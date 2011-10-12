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

        public double Timeout
        {
            get { return Convert.ToDouble(uiTimeout.Value); }
            set { uiTimeout.Value = Convert.ToDecimal(value); }
        }

        public string Comment
        {
            get { return uiComment.Text; }
            set { uiComment.Text = value; }
        }

        public bool CheckColor
        {
            get { return uiCheckColor.Checked; }
            set { uiCheckColor.Checked = value; }
        }

        public decimal CoordX
        {
            get { return uiCoordX.Value; }
            set { uiCoordX.Value = value; }
        }

        public decimal CoordY
        {
            get { return uiCoordY.Value; }
            set { uiCoordY.Value = value; }
        }

        public decimal ColorR
        {
            get { return uiColorR.Value; }
            set { uiColorR.Value = value; }
        }

        public decimal ColorG
        {
            get { return uiColorG.Value; }
            set { uiColorG.Value = value; }
        }

        public decimal ColorB
        {
            get { return uiColorB.Value; }
            set { uiColorB.Value = value; }
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

        private void uiCheckColor_CheckedChanged(object sender, EventArgs e)
        {
            uiCoordX.Enabled = uiCoordY.Enabled =
                uiColorR.Enabled = uiColorG.Enabled = uiColorB.Enabled = uiCheckColor.Checked;
        }
    }
}
