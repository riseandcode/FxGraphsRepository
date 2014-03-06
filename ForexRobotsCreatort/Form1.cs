using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading;
using System.Windows.Forms;

namespace ForexRobotsCreatort
{
    public partial class Form1 : Form
    {
        private const string _moonBeamBoxFileName = "MoonBeamBox.mq4";
        private const string _priceAutoBoxFileName = "Price AutoBox.mq4";
        private const string _scalperBoxFileName = "ScalperBox.mq4";
        private const string _accountNumber = "thisShouldBeAccountNumber";

        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string accountNumber = txtAccountNumber.Text;
            CompileRobot(_moonBeamBoxFileName, accountNumber);
            CompileRobot( _priceAutoBoxFileName, accountNumber);
            CompileRobot(_scalperBoxFileName, accountNumber);
        }

        private void CompileRobot(string fileRobotName, string accountNumber)
        {
            var loc = Path.GetDirectoryName(Assembly.GetEntryAssembly().Location) + "\\";
            fileRobotName = loc + fileRobotName;
            var text = File.ReadAllText(fileRobotName);
            text = text.Replace(_accountNumber, accountNumber);
            File.Delete(fileRobotName);
            File.WriteAllText(fileRobotName, text); 
            const string command = "metalang";
            var arguments = string.Format(" -q \"{0}\"", fileRobotName);
            ExecuteCommand(command, arguments);
            var newFileName = loc +  "experts\\" + Path.GetFileName(fileRobotName.Replace(".mq4", ".ex4"));
            File.Delete(newFileName);
            File.Move(fileRobotName.Replace(".mq4", ".ex4"), newFileName);

            text =  text.Replace(accountNumber, _accountNumber);
            File.Delete(fileRobotName);
            File.WriteAllText(fileRobotName, text, Encoding.ASCII);
        }

        private void ExecuteCommand(string command, string arguments )
        {
            var procStartInfo = new ProcessStartInfo(command);
            procStartInfo.Arguments = arguments;
            procStartInfo.UseShellExecute = false;

            Process proc = new System.Diagnostics.Process();
            proc.StartInfo = procStartInfo;
            proc.Start();
            proc.WaitForExit();

        }
    }
}
