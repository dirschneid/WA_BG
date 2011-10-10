using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Drawing;

namespace WAutomator
{
    public struct ColorAndKeyPair
    {
        public Color color;
        public KeyEventArgs key;

        public override string ToString()
        {
            return FormatColor(color) + " - " + FormatKey(key);
        }

        // Возвращает строку с упрощенным описанием цвета
        public static string FormatColor(Color color)
        {
            if (null == color)
                return string.Empty;

            return string.Format("R:{0}, G:{1}, B:{2}", Math.Round(color.R / 255.0, 3), Math.Round(color.G / 255.0, 3), Math.Round(color.B / 255.0, 3));
        }

        // Возвращает строку с описанием комбинации клавиш
        public static string FormatKey(KeyEventArgs key)
        {
            if (null == key)
                return string.Empty;

            StringBuilder sb = new StringBuilder();

            if (key.Shift)
                sb.Append("Shift+");
            if (key.Control)
                sb.Append("Control+");
            if (key.Alt)
                sb.Append("Alt+");

            sb.Append(key.KeyCode);

            return sb.ToString();
        }
    }

}
