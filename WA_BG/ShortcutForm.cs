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

        public ShortcutItem Shortcut
        {
            get
            {
                return new ShortcutItem()
                {
                    Shortcut = m_shortcut,
                    Timeout = uiTimeout.Value,
                    Comment = uiComment.Text,
                    CheckColor = uiCheckColor.Checked,
                    CoordX = Convert.ToInt32(uiCoordX.Value),
                    CoordY = Convert.ToInt32(uiCoordY.Value),
                    ColorR = uiColorR.Value,
                    ColorG = uiColorG.Value,
                    ColorB = uiColorB.Value,
                };
            }
            set
            {
                textKey_KeyDown(this, value.Shortcut);

                uiTimeout.Value = value.Timeout;
                uiComment.Text = value.Comment;
                uiCheckColor.Checked = value.CheckColor;
                uiCoordX.Value = value.CoordX;
                uiCoordY.Value = value.CoordY;
                uiColorR.Value = value.ColorR;
                uiColorG.Value = value.ColorG;
                uiColorB.Value = value.ColorB;
            }
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

        private void PickColor()
        {
            //textMousePos.Text = string.Format("X: {0}, Y: {1}", Cursor.Position.X, Cursor.Position.Y);

            //Color color = Automator.GetPixeColor(Cursor.Position.X, Cursor.Position.Y, m_WoW.MainWindowHandle);
            //textColorUnderMouse.Text = string.Format("R: {0}, G: {1}, B: {2}", color.R, color.B, color.G);

            //Automator.SendMouseLButtonClick(Cursor.Position.X, Cursor.Position.Y, m_WoW.MainWindowHandle);
        }
    }
}
