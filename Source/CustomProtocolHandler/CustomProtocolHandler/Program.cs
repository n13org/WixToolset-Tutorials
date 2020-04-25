using System;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;

namespace CustomProtocolHandler
{
    public class Program
    {
        public static void Main(string[] args)
        {
            // No args, nothing to do
            if (args == null) return;

            // Parse the args
            foreach (string arg in args)
            {
                // Check if protocoll is at the beginning of the arg
                if (arg.ToLower().StartsWith(KargWareDemoProtocol.ProtocolPrefix, true, CultureInfo.InvariantCulture))
                {
                    // Escape the argument as it is passed as a url
                    string escapedArgument = Uri.UnescapeDataString(arg);
                    string[] arguments = escapedArgument.Replace(KargWareDemoProtocol.ProtocolPrefix, string.Empty).Split('&');

                    // 1. Argument is the format
                    string format = arguments.FirstOrDefault();
                    if (!string.IsNullOrEmpty(format))
                    {
                        switch (format.ToLower())
                        {
                            case "plaintext":
                                break;
                            case "json":
                                break;
                            case "xml":
                                break;
                            default:
                                throw new ArgumentException($"The format '{format}' is not allowed!");
                        }
                    } else
                    {
                        throw new ArgumentNullException($"The 1. argument 'format' is empty!");
                    }

                    // 2. Argument is the content
                    string content = arguments.Skip(1).FirstOrDefault();
                    if (!string.IsNullOrEmpty(content))
                    {
                        var fullfilename = Path.Join(Path.GetTempPath(), "KargWare-ProtocolHandler.log");
                        using var file = new StreamWriter(fullfilename, true, Encoding.UTF8);
                        file.WriteLine($"{DateTime.Now:yyyy-MM-dd HH:mm:ss} {format} {content}");
                        file.Flush();
                        file.Close();
                    }
                    else
                    {
                        throw new ArgumentNullException($"The 2. argument 'content' is empty!");
                    }
                }
            }
        }
    }
}
