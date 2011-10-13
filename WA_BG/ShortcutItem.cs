using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WAutomator;
using System.Drawing;

namespace WA_BG
{
    [Serializable]
    public class ShortcutItem
    {
        public Keys Key;
        /// <summary>
        /// Интервал между нажатиями (в секундах).
        /// </summary>
        public decimal Timeout;
        /// <summary>
        /// Время, оставшееся до нажатия (в миллисекундах).
        /// </summary>
        public decimal TimeLeft;
        public string Comment;

        public bool CheckColor;
        public int CoordX;
        public int CoordY;
        public decimal ColorR;
        public decimal ColorG;
        public decimal ColorB;

        public KeyEventArgs Shortcut { get { return new KeyEventArgs(Key); } set { Key = (null == value) ? Keys.None : value.KeyData; } }
        public string ShortcutText { get { return ColorAndKeyPair.FormatKey(Shortcut); } }
        public string ColorText { get {
            return CheckColor
                ? string.Format("R:{0}, G:{1}, B:{2} @ X:{3} Y:{4}", ColorR, ColorG, ColorB, CoordX, CoordY)
                : "Not cheked";
        } }

        public ShortcutItem()
        { 
        }

        public void ResetTimeout()
        {
            TimeLeft = Timeout;
        }

        public bool IsColorEqualTo(Color color)
        {
            bool matchR = Math.Abs(Convert.ToDouble(ColorR) - Math.Round(color.R / 255.0, 3)) < 0.01;
            bool matchG = Math.Abs(Convert.ToDouble(ColorG) - Math.Round(color.G / 255.0, 3)) < 0.01;
            bool matchB = Math.Abs(Convert.ToDouble(ColorB) - Math.Round(color.B / 255.0, 3)) < 0.01;

            return matchR && matchG && matchB;
        }
    }
}
