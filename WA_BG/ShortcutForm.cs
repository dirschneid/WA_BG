using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WA_BG
{
    public partial class ShortcutForm : Form
    {
        private KeyEventArgs m_shortcut;

        public KeyEventArgs Shortcut
        {
            get { return m_shortcut; }
            set
            {
                if (null != value)
                    textKey_KeyDown(this, value);
            }
        }

        public int Timeout
        {
            get { return Convert.ToInt32(uiTimeout.Value); }
            set { uiTimeout.Value = value; }
        }

        public ShortcutForm()
        {
            InitializeComponent();

            uiKey.Select();
        }

        private void textKey_KeyDown(object sender, KeyEventArgs e)
        {
            uiModifierShift.Checked = e.Shift;
            uiModifierCtrl.Checked = e.Control;
            uiModifierAlt.Checked = e.Alt;

            if (e.KeyCode != Keys.ShiftKey && e.KeyCode != Keys.ControlKey && e.KeyCode != Keys.Menu)
                uiKey.Text = e.KeyCode.ToString();

            // Запомним кнопку
            m_shortcut = e;

            e.SuppressKeyPress = true;
        }
    }
}
