using System;
using System.Diagnostics;
using System.Windows.Forms;
using WAutomator;
using System.Xml.Serialization;
using System.IO;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;

namespace WA_BG
{
    public partial class MainForm : Form
    {
        private const string ProcessName = "WoW";

        private Process m_WoW;

        private SimpleAutomator m_automator;

        // -----------------------------------

        public MainForm()
        {
            InitializeComponent();

            Process[] processes = Process.GetProcessesByName(ProcessName);
            if (processes.Length == 0)
            {
                MessageBox.Show("Загрузите WoW");
                return;
            }

            m_WoW = processes[0];

            m_automator = new SimpleAutomator(
                m_WoW,
                delegate(string msg)
                {
                    listBox1.Items.Insert(0, msg);
                    if (listBox1.Items.Count > 5000)
                    {
                        listBox1.Items.Clear();
                    }
                });

            LoadShortcuts();
        }

        private void btnRun_Click(object sender, EventArgs e)
        {
            //textMousePos.Text = string.Format("X: {0}, Y: {1}", Cursor.Position.X, Cursor.Position.Y);

            //Color color = Automator.GetPixeColor(Cursor.Position.X, Cursor.Position.Y, m_WoW.MainWindowHandle);
            //textColorUnderMouse.Text = string.Format("R: {0}, G: {1}, B: {2}", color.R, color.B, color.G);

            //Automator.SendMouseLButtonClick(Cursor.Position.X, Cursor.Position.Y, m_WoW.MainWindowHandle);

            ShortcutItem[] shortcuts = GetShortcuts();

            m_automator.UseAlternateKeys = uiAlternativeKeys.Checked;
            m_automator.Shortcuts = shortcuts;
            m_automator.Start();

            uiRunButton.Enabled = uiAlternativeKeys.Enabled = uiAddShortcutButton.Enabled = uiRemoveShortcutButton.Enabled = uiShortcuts.Enabled = false;
            uiStopButton.Enabled = true;
        }

        private void btnStop_Click(object sender, EventArgs e)
        {
            m_automator.Stop();

            uiRunButton.Enabled = uiAlternativeKeys.Enabled = uiAddShortcutButton.Enabled = uiRemoveShortcutButton.Enabled = uiShortcuts.Enabled = true;
            uiStopButton.Enabled = false;
        }

        private void uiAddShortcutButton_Click(object sender, EventArgs e)
        {
            ShortcutForm shortcutForm = new ShortcutForm();
            if (shortcutForm.ShowDialog() == DialogResult.OK)
            {
                AddShortcut(new ShortcutItem()
                {
                    Shortcut = shortcutForm.Shortcut,
                    Timeout = shortcutForm.Timeout,
                    TimeLeft = 0
                });
            }
        }

        private void uiRemoveShortcutButton_Click(object sender, EventArgs e)
        {
            foreach (ListViewItem item in uiShortcuts.SelectedItems)
            {
                uiShortcuts.Items.Remove(item);
            }
        }

        private void uiLoadButton_Click(object sender, EventArgs e)
        {
            LoadShortcuts();
        }

        private void uiSaveButton_Click(object sender, EventArgs e)
        {
            SaveShortcuts();
        }

        private void uiEditButton_Click(object sender, EventArgs e)
        {
            ShortcutForm shortcutForm = new ShortcutForm();

            ShortcutItem si = (ShortcutItem)uiShortcuts.SelectedItems[0].Tag;
            shortcutForm.Shortcut = si.Shortcut;
            shortcutForm.Timeout = si.Timeout;

            if (shortcutForm.ShowDialog() == DialogResult.OK)
            {
                si.Shortcut = shortcutForm.Shortcut;
                si.Timeout = shortcutForm.Timeout;
                si.TimeLeft = 0;

                uiShortcuts.SelectedItems[0].Tag = si;
                uiShortcuts.SelectedItems[0].SubItems[0].Text = si.ShortcutText;
                uiShortcuts.SelectedItems[0].SubItems[1].Text = si.Timeout.ToString();
            }

            uiShortcuts.SelectedItems.Clear();
        }

        private void LoadShortcuts()
        {
            try
            {
                using (Stream profile = File.Open(@"default.profile", FileMode.Open))
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
            }
            catch
            {
            }
        }

        private void SaveShortcuts()
        {
            try
            {
                using (Stream profile = File.Open(@"default.profile", FileMode.Create))
                {
                    //XmlSerializer xs = new XmlSerializer(typeof(ShortcutItem[]));
                    //xs.Serialize(profile, GetShortcuts());
                    IFormatter formatter = new BinaryFormatter();
                    formatter.Serialize(profile, GetShortcuts());
                }
            }
            catch
            {
            }
        }

        private void AddShortcut(ShortcutItem si)
        {
            uiShortcuts.Items.Add(new ListViewItem(new string[] { si.ShortcutText, si.Timeout.ToString() })
            {
                Tag = si
            });
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
            uiEditShortcutButton.Enabled = (uiShortcuts.SelectedItems.Count == 1);
            uiRemoveShortcutButton.Enabled = (uiShortcuts.SelectedItems.Count > 0);
        }
    }
}
