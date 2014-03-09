using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Xml;

namespace DL
{
    /// <summary>
    /// Repository that manages User settings for stattistic displaying
    /// </summary>
    public class StatisticConfigurationRepository
    {
        public UserStatisticSettings GetUserStatisticSettingsByUserId(Guid id)
        {
            UserStatisticSettings settings = null;

            using (var ctx = new forexBox2Entities())
            {
                var dbEntity = ctx.StatisticConfigurations.FirstOrDefault(x => x.UserId == id);
                if (dbEntity != null)
                {
                    settings = DeserializeObject(dbEntity.Data);
                    settings.UserId = id;
                }
            }

            return settings;
        }

        public bool AddUserStatisticSettings(UserStatisticSettings settings)
        {
            using (var ctx = new forexBox2Entities())
            {
                var data = SerializeObject(settings);
                ctx.StatisticConfigurations.AddObject(new StatisticConfiguration
                {
                    Data = data,
                    UserId = settings.UserId,
                });

                try
                {
                    ctx.SaveChanges();
                }
                catch { return false; }                                
            }

            return true;
        }

        public void UpdateUserStatisticSettings(UserStatisticSettings settings)
        {
            using (var ctx = new forexBox2Entities())
            {                
                var entity = ctx.StatisticConfigurations.FirstOrDefault(x => x.UserId == settings.UserId);
                if (entity != null)
                {
                    var data = SerializeObject(settings);
                    entity.Data = data;
                    ctx.SaveChanges();
                }
            }
        }

        private byte[] SerializeObject(UserStatisticSettings setting)
        {
            var serializer = new DataContractSerializer(typeof(UserStatisticSettings));
            using (var stream = new MemoryStream())
            {
                using (var writer = XmlDictionaryWriter.CreateBinaryWriter(stream))
                {
                    serializer.WriteObject(writer, setting);
                }
                return stream.ToArray();
            }            
        }

        private UserStatisticSettings DeserializeObject(byte[] data)
        {
            var serializer = new DataContractSerializer(typeof(UserStatisticSettings));

            using (var stream = new MemoryStream(data))
            {
                using (var reader = XmlDictionaryReader.CreateBinaryReader(stream, XmlDictionaryReaderQuotas.Max))
                {
                    return (UserStatisticSettings)serializer.ReadObject(reader);
                }
            }            
        }
    }
    
}
