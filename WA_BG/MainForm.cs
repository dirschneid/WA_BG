using System;
using System.Diagnostics;
using System.Windows.Forms;
using WAutomator;
using System.Xml.Serialization;
using System.IO;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;
using WA_BG.Properties;

namespace WA_BG
{
    public partial class MainForm : Form
    {
        private string m_profileFileName = @"default.profile";

        private KeypressAutomator m_automator;

        private string FormTitle { get { return "World of Warcraft Automator - BG (Profile: " + m_profileFileName + ")"; } }


        // -----------------------------------

        public MainForm()
        {
            InitializeComponent();

            m_automator = new KeypressAutomator(
                delegate(string msg)
                {
                    uiKeypressLog.Items.Add(msg);
                    if (uiKeypressLog.Items.Count > 1000)
                    {
                        uiKeypressLog.Items.RemoveAt(0);
                    }

                    uiKeypressLog.SelectedIndex = uiKeypressLog.Items.Count - 1;
                    uiKeypressLog.SelectedIndex = -1;
                });

            LoadProfile();
        }

        private void uiRunButton_Click(object sender, EventArgs e)
        {
            const string ProcessName = "WoW";

            Process[] processes = Process.GetProcessesByName(ProcessName);
            if (processes.Length == 0)
            {
                MessageBox.Show("Start process '" + ProcessName + "' please");
                return;
            }

			m_automator.Interval = Settings.Default.CheckInterval;
            m_automator.Shortcuts = GetShortcuts();
            m_automator.Start(processes[0]);

            uiShortcuts.SelectedItems.Clear();

            optionsToolStripMenuItem.Enabled =
            uiShortcuts.Enabled =
            uiAddTSButton.Enabled = addShortcutToolStripMenuItem.Enabled =
            uiOpenTSButton.Enabled = openToolStripMenuItem.Enabled =
            uiSaveTSButton.Enabled = saveToolStripMenuItem.Enabled =
            uiSaveAsTSButton.Enabled = saveAsToolStripMenuItem.Enabled =
            uiRunTSButton.Enabled = runToolStripMenuItem.Enabled = false;

            uiStopTSButton.Enabled = stopToolStripMenuItem.Enabled = true;
        }

        private void uiStopButton_Click(object sender, EventArgs e)
        {
            m_automator.Stop();

			optionsToolStripMenuItem.Enabled =
			uiShortcuts.Enabled =
			uiAddTSButton.Enabled = addShortcutToolStripMenuItem.Enabled =
			uiOpenTSButton.Enabled = openToolStripMenuItem.Enabled =
			uiSaveTSButton.Enabled = saveToolStripMenuItem.Enabled =
			uiSaveAsTSButton.Enabled = saveAsToolStripMenuItem.Enabled =
			uiRunTSButton.Enabled = runToolStripMenuItem.Enabled = true;

			uiStopTSButton.Enabled = stopToolStripMenuItem.Enabled = false;
        }

        private void uiAddShortcutButton_Click(object sender, EventArgs e)
        {
            ShortcutForm shortcutForm = new ShortcutForm();
            if (shortcutForm.ShowDialog() == DialogResult.OK)
            {
                AddShortcut(shortcutForm.Shortcut);
            }
        }

        private void uiRemoveShortcutButton_Click(object sender, EventArgs e)
        {
            foreach (ListViewItem item in uiShortcuts.SelectedItems)
            {
                uiShortcuts.Items.Remove(item);
            }

            uiShortcuts.SelectedItems.Clear();
        }

        private void uiEditShortcutButton_Click(object sender, EventArgs e)
        {
            ShortcutForm shortcutForm = new ShortcutForm();

            shortcutForm.Shortcut = (ShortcutItem)uiShortcuts.SelectedItems[0].Tag;

            if (shortcutForm.ShowDialog() == DialogResult.OK)
            {
                var si = shortcutForm.Shortcut;
                si.ResetTimeout();

                SetListVievItemValue(uiShortcuts.SelectedItems[0], si);
            }

            uiShortcuts.SelectedItems.Clear();
        }

        private void uiDuplicateButton_Click(object sender, EventArgs e)
        {
            foreach (ListViewItem item in uiShortcuts.SelectedItems)
            {
                AddShortcut((ShortcutItem)item.Tag);
            }

            uiShortcuts.SelectedItems.Clear();
        }

        private void uiLoadButton_Click(object sender, EventArgs e)
        {
            if (uiOpenProfileDialog.ShowDialog() == DialogResult.OK)
            {
                m_profileFileName = uiOpenProfileDialog.FileName;
                LoadProfile();
            }
        }

        private void uiSaveButton_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(m_profileFileName))
                uiSaveAsButton_Click(sender, e);

            SaveProfile();
        }

        private void uiSaveAsButton_Click(object sender, EventArgs e)
        {
            if (uiSaveProfileDialog.ShowDialog() == DialogResult.OK)
            {
                m_profileFileName = uiSaveProfileDialog.FileName;
                SaveProfile();
            }
        }

        private void LoadProfile()
        {
            try
            {
                using (Stream profile = File.Open(m_profileFileName, FileMode.Open))
                {
                    //XmlSerializer xs = new XmlSerializer(typeof(ShortcutItem[]));
                    //ShortcutItem[] items = (ShortcutItem[])xs.Deserialize(profile);
                    IFormatter formatter = new BinaryFormatter();
                    ShortcutItem[] items = (ShortcutItem[])formatter.Deserialize(profile);

                    uiShortcuts.Items.Clear();

                    for (int i = 0; i < items.Length; ++i)
                    {
                        AddShortcut(items[i]);
                    }
                }

                base.Text = FormTitle;
            }
            catch
            {
            }
        }

        private void SaveProfile()
        {
            try
            {
                using (Stream profile = File.Open(m_profileFileName, FileMode.Create))
                {
                    //XmlSerializer xs = new XmlSerializer(typeof(ShortcutItem[]));
                    //xs.Serialize(profile, GetShortcuts());
                    IFormatter formatter = new BinaryFormatter();
                    formatter.Serialize(profile, GetShortcuts());
                }

                base.Text = FormTitle;
            }
            catch
            {
            }
        }

        private void AddShortcut(ShortcutItem si)
        {
            string[] rowItems = new string[uiShortcuts.Columns.Count];

            ListViewItem lvItem = new ListViewItem(rowItems);
            SetListVievItemValue(lvItem, si);

            uiShortcuts.Items.Add(lvItem);
        }

        private void SetListVievItemValue(ListViewItem lvItem, ShortcutItem si)
        {
            lvItem.Tag = si;
            lvItem.SubItems[0].Text = si.ShortcutText;
            lvItem.SubItems[1].Text = si.Timeout.ToString();
            lvItem.SubItems[2].Text = si.TextX;
            lvItem.SubItems[3].Text = si.TextY;
            lvItem.SubItems[4].Text = si.TextR;
            lvItem.SubItems[5].Text = si.TextG;
            lvItem.SubItems[6].Text = si.TextB;
            lvItem.SubItems[7].Text = si.Comment;
        }

        private ShortcutItem[] GetShortcuts()
        {
            ShortcutItem[] shortcuts = new ShortcutItem[uiShortcuts.Items.Count];

            for (int i = 0; i < uiShortcuts.Items.Count; ++i)
            {
                shortcuts[i] = (ShortcutItem)uiShortcuts.Items[i].Tag;
            }

            return shortcuts;
        }

        private void uiShortcuts_ItemSelectionChanged(object sender, ListViewItemSelectionChangedEventArgs e)
        {
            uiEditTSButton.Enabled = (uiShortcuts.SelectedItems.Count == 1);
            uiRemoveTSButton.Enabled =
            uiDuplicateTSButton.Enabled = (uiShortcuts.SelectedItems.Count > 0);
        }

        private void MainForm_FormClosing(object sender, FormClosingEventArgs e)
        {
			Settings.Default.Save();
            SaveProfile();
        }

        private void selectAllToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (uiShortcuts.MultiSelect)
            {
                foreach (ListViewItem item in uiShortcuts.Items)
                    item.Selected = true;
            }
        }

		private void optionsToolStripMenuItem_Click(object sender, EventArgs e)
		{
			new OptionsForm().ShowDialog();
		}

		private void aboutToolStripMenuItem_Click(object sender, EventArgs e)
		{
			MessageBox.Show("А вот хрен вам, а не About!", "About", MessageBoxButtons.OK, MessageBoxIcon.Hand);
		}
    }
}
