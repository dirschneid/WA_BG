using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;

namespace WAutomator
{
    public class ByColorAutomator : Automator
    {
        private Dictionary<Color, KeyEventArgs> m_colormap;

        // -----------------------------------

        public ByColorAutomator(Process controlledProcess, Dictionary<Color, KeyEventArgs> colormap, Action<string> logAction = null, Action tickAction = null)
            : base(controlledProcess, logAction, tickAction)
        {
            m_colormap = colormap;
        }

        // -----------------------------------

        protected override void TickHandler(object source, EventArgs args)
        {
            //// Задержка до следующего вызова
            //m_timer.Interval = TimeSpan.FromMilliseconds(MasterTickOffset);

            //// Проинформируем основное окно о том, что процесс идет
            //if (null != m_tickAction)
            //    m_tickAction();

            ////Color pixel = GetPixeColor(NOTIFICATION_POINT_X, NOTIFICATION_POINT_Y);

            ////foreach (var item in m_keymap)
            ////{
            ////    // TODO: Разобраться, что зачем и как тут с цветами
            ////    if (((Math.Abs(pixel.R - item.Key.R) < 2) &&
            ////        (Math.Abs(pixel.G - item.Key.G) < 2)) &&
            ////        (Math.Abs(pixel.B - item.Key.B) < 2))
            ////    {
            ////        // Нашли соответствующую цвету кнопку, зашлём в оркестр.
            ////        SendKey(item.Value);

            ////        // После нажатия подожем подольше
            ////        m_timer.Interval = TimeSpan.FromMilliseconds(AfterCastTickOffset);

            ////        if (null != m_logAction)
            ////            m_logAction(string.Format("{0} - {1}", DateTime.Now.ToString("hh:mm:ss"), ColorAndKeyPair.FormatKey(item.Value)));

            ////        return;
            ////    }
            ////}

            ////// Проверяем события для мыши

            //////if ()
        }
    }
}
