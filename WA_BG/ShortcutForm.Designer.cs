namespace WA_BG
{
    partial class ShortcutForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.uiKey = new System.Windows.Forms.TextBox();
            this.uiModifierCtrl = new System.Windows.Forms.CheckBox();
            this.uiModifierShift = new System.Windows.Forms.CheckBox();
            this.uiModifierAlt = new System.Windows.Forms.CheckBox();
            this.buttonOk = new System.Windows.Forms.Button();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.uiTimeout = new System.Windows.Forms.NumericUpDown();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.uiComment = new System.Windows.Forms.TextBox();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.uiCheckColor = new System.Windows.Forms.CheckBox();
            this.uiCoordX = new System.Windows.Forms.NumericUpDown();
            this.label1 = new System.Windows.Forms.Label();
            this.uiCoordY = new System.Windows.Forms.NumericUpDown();
            this.label2 = new System.Windows.Forms.Label();
            this.uiColorR = new System.Windows.Forms.NumericUpDown();
            this.label3 = new System.Windows.Forms.Label();
            this.uiColorG = new System.Windows.Forms.NumericUpDown();
            this.label4 = new System.Windows.Forms.Label();
            this.uiColorB = new System.Windows.Forms.NumericUpDown();
            this.label5 = new System.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.uiTimeout)).BeginInit();
            this.groupBox3.SuspendLayout();
            this.groupBox4.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.uiCoordX)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.uiCoordY)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.uiColorR)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.uiColorG)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.uiColorB)).BeginInit();
            this.SuspendLayout();
            // 
            // uiKey
            // 
            this.uiKey.Location = new System.Drawing.Point(154, 21);
            this.uiKey.Name = "uiKey";
            this.uiKey.Size = new System.Drawing.Size(139, 20);
            this.uiKey.TabIndex = 0;
            this.uiKey.KeyDown += new System.Windows.Forms.KeyEventHandler(this.textKey_KeyDown);
            // 
            // uiModifierCtrl
            // 
            this.uiModifierCtrl.AutoSize = true;
            this.uiModifierCtrl.Location = new System.Drawing.Point(63, 23);
            this.uiModifierCtrl.Name = "uiModifierCtrl";
            this.uiModifierCtrl.Size = new System.Drawing.Size(41, 17);
            this.uiModifierCtrl.TabIndex = 6;
            this.uiModifierCtrl.Text = "Ctrl";
            this.uiModifierCtrl.UseVisualStyleBackColor = true;
            // 
            // uiModifierShift
            // 
            this.uiModifierShift.AutoSize = true;
            this.uiModifierShift.Location = new System.Drawing.Point(10, 23);
            this.uiModifierShift.Name = "uiModifierShift";
            this.uiModifierShift.Size = new System.Drawing.Size(47, 17);
            this.uiModifierShift.TabIndex = 8;
            this.uiModifierShift.Text = "Shift";
            this.uiModifierShift.UseVisualStyleBackColor = true;
            // 
            // uiModifierAlt
            // 
            this.uiModifierAlt.AutoSize = true;
            this.uiModifierAlt.Location = new System.Drawing.Point(110, 23);
            this.uiModifierAlt.Name = "uiModifierAlt";
            this.uiModifierAlt.Size = new System.Drawing.Size(38, 17);
            this.uiModifierAlt.TabIndex = 9;
            this.uiModifierAlt.Text = "Alt";
            this.uiModifierAlt.UseVisualStyleBackColor = true;
            // 
            // buttonOk
            // 
            this.buttonOk.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonOk.DialogResult = System.Windows.Forms.DialogResult.OK;
            this.buttonOk.Location = new System.Drawing.Point(242, 288);
            this.buttonOk.Name = "buttonOk";
            this.buttonOk.Size = new System.Drawing.Size(75, 23);
            this.buttonOk.TabIndex = 10;
            this.buttonOk.Text = "Select";
            this.buttonOk.UseVisualStyleBackColor = true;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.uiKey);
            this.groupBox1.Controls.Add(this.uiModifierAlt);
            this.groupBox1.Controls.Add(this.uiModifierShift);
            this.groupBox1.Controls.Add(this.uiModifierCtrl);
            this.groupBox1.Location = new System.Drawing.Point(12, 70);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(303, 55);
            this.groupBox1.TabIndex = 11;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Shortcut";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.uiTimeout);
            this.groupBox2.Location = new System.Drawing.Point(12, 131);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(303, 53);
            this.groupBox2.TabIndex = 12;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Timeout (sec), up to 20 min";
            // 
            // uiTimeout
            // 
            this.uiTimeout.DecimalPlaces = 1;
            this.uiTimeout.Location = new System.Drawing.Point(10, 19);
            this.uiTimeout.Maximum = new decimal(new int[] {
            1200,
            0,
            0,
            0});
            this.uiTimeout.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            65536});
            this.uiTimeout.Name = "uiTimeout";
            this.uiTimeout.Size = new System.Drawing.Size(283, 20);
            this.uiTimeout.TabIndex = 0;
            this.uiTimeout.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.uiComment);
            this.groupBox3.Location = new System.Drawing.Point(12, 12);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(303, 52);
            this.groupBox3.TabIndex = 13;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Comment";
            // 
            // uiComment
            // 
            this.uiComment.Location = new System.Drawing.Point(10, 19);
            this.uiComment.Name = "uiComment";
            this.uiComment.Size = new System.Drawing.Size(283, 20);
            this.uiComment.TabIndex = 0;
            // 
            // groupBox4
            // 
            this.groupBox4.Controls.Add(this.label2);
            this.groupBox4.Controls.Add(this.label5);
            this.groupBox4.Controls.Add(this.label4);
            this.groupBox4.Controls.Add(this.label3);
            this.groupBox4.Controls.Add(this.label1);
            this.groupBox4.Controls.Add(this.uiCoordY);
            this.groupBox4.Controls.Add(this.uiColorB);
            this.groupBox4.Controls.Add(this.uiColorG);
            this.groupBox4.Controls.Add(this.uiColorR);
            this.groupBox4.Controls.Add(this.uiCoordX);
            this.groupBox4.Controls.Add(this.uiCheckColor);
            this.groupBox4.Location = new System.Drawing.Point(12, 190);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(303, 90);
            this.groupBox4.TabIndex = 14;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "Color";
            // 
            // uiCheckColor
            // 
            this.uiCheckColor.AutoSize = true;
            this.uiCheckColor.Location = new System.Drawing.Point(10, 19);
            this.uiCheckColor.Name = "uiCheckColor";
            this.uiCheckColor.Size = new System.Drawing.Size(83, 17);
            this.uiCheckColor.TabIndex = 0;
            this.uiCheckColor.Text = "Check color";
            this.uiCheckColor.UseVisualStyleBackColor = true;
            this.uiCheckColor.CheckedChanged += new System.EventHandler(this.uiCheckColor_CheckedChanged);
            // 
            // uiCoordX
            // 
            this.uiCoordX.Enabled = false;
            this.uiCoordX.Location = new System.Drawing.Point(134, 16);
            this.uiCoordX.Name = "uiCoordX";
            this.uiCoordX.Size = new System.Drawing.Size(65, 20);
            this.uiCoordX.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(111, 20);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(17, 13);
            this.label1.TabIndex = 2;
            this.label1.Text = "X:";
            // 
            // uiCoordY
            // 
            this.uiCoordY.Enabled = false;
            this.uiCoordY.Location = new System.Drawing.Point(228, 16);
            this.uiCoordY.Name = "uiCoordY";
            this.uiCoordY.Size = new System.Drawing.Size(65, 20);
            this.uiCoordY.TabIndex = 1;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(205, 20);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(17, 13);
            this.label2.TabIndex = 2;
            this.label2.Text = "Y:";
            // 
            // uiColorR
            // 
            this.uiColorR.DecimalPlaces = 3;
            this.uiColorR.Enabled = false;
            this.uiColorR.Increment = new decimal(new int[] {
            1,
            0,
            0,
            131072});
            this.uiColorR.Location = new System.Drawing.Point(39, 58);
            this.uiColorR.Maximum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.uiColorR.Name = "uiColorR";
            this.uiColorR.Size = new System.Drawing.Size(65, 20);
            this.uiColorR.TabIndex = 1;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(15, 62);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(18, 13);
            this.label3.TabIndex = 2;
            this.label3.Text = "R:";
            // 
            // uiColorG
            // 
            this.uiColorG.DecimalPlaces = 3;
            this.uiColorG.Enabled = false;
            this.uiColorG.Increment = new decimal(new int[] {
            1,
            0,
            0,
            131072});
            this.uiColorG.Location = new System.Drawing.Point(134, 58);
            this.uiColorG.Maximum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.uiColorG.Name = "uiColorG";
            this.uiColorG.Size = new System.Drawing.Size(65, 20);
            this.uiColorG.TabIndex = 1;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(111, 62);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(18, 13);
            this.label4.TabIndex = 2;
            this.label4.Text = "G:";
            // 
            // uiColorB
            // 
            this.uiColorB.DecimalPlaces = 3;
            this.uiColorB.Enabled = false;
            this.uiColorB.Increment = new decimal(new int[] {
            1,
            0,
            0,
            131072});
            this.uiColorB.Location = new System.Drawing.Point(228, 58);
            this.uiColorB.Maximum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.uiColorB.Name = "uiColorB";
            this.uiColorB.Size = new System.Drawing.Size(65, 20);
            this.uiColorB.TabIndex = 1;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(205, 60);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(17, 13);
            this.label5.TabIndex = 2;
            this.label5.Text = "B:";
            // 
            // ShortcutForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(329, 323);
            this.Controls.Add(this.groupBox4);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.buttonOk);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.MaximizeBox = false;
            this.Name = "ShortcutForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Select shortcut";
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.uiTimeout)).EndInit();
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.groupBox4.ResumeLayout(false);
            this.groupBox4.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.uiCoordX)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.uiCoordY)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.uiColorR)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.uiColorG)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.uiColorB)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TextBox uiKey;
        private System.Windows.Forms.CheckBox uiModifierCtrl;
        private System.Windows.Forms.CheckBox uiModifierShift;
        private System.Windows.Forms.CheckBox uiModifierAlt;
        private System.Windows.Forms.Button buttonOk;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.NumericUpDown uiTimeout;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.TextBox uiComment;
        private System.Windows.Forms.GroupBox groupBox4;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.NumericUpDown uiCoordY;
        private System.Windows.Forms.NumericUpDown uiColorB;
        private System.Windows.Forms.NumericUpDown uiColorG;
        private System.Windows.Forms.NumericUpDown uiColorR;
        private System.Windows.Forms.NumericUpDown uiCoordX;
        private System.Windows.Forms.CheckBox uiCheckColor;
    }
}