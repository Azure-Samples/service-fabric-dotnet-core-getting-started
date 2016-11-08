// ------------------------------------------------------------
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//  Licensed under the MIT License (MIT). See License.txt in the repo root for license information.
// ------------------------------------------------------------

namespace VisualObjects.WebService
{
    using System;
    using System.Collections.Concurrent;
    using Microsoft.ServiceFabric.Actors;

    /// <summary>
    /// This class encapsulates the logic for getting all of the visual object actors and joining their values into a JSON string.
    /// </summary>
    public class VisualObjectsBox : IVisualObjectsBox
    {
        private static readonly object LockObject = new object();

        private static VisualObjectsBox instance = null;

        public static IVisualObjectsBox Current
        {
            get
            {
                if (VisualObjectsBox.instance == null)
                {
                    lock (VisualObjectsBox.LockObject)
                    {
                        if (VisualObjectsBox.instance == null)
                        {
                            VisualObjectsBox.instance = new VisualObjectsBox();
                        }
                    }
                }

                return VisualObjectsBox.instance;
            }
        }

        private readonly ConcurrentDictionary<ActorId, string> objectData = new ConcurrentDictionary<ActorId, string>();
        private string json = "[]";

        string IVisualObjectsBox.GetJson()
        {
            return this.json;
        }

        void IVisualObjectsBox.SetObjectString(ActorId actorId, string objectJson)
        {
            this.objectData[actorId] = objectJson;
        }

        void IVisualObjectsBox.computeJson()
        {
            if (this.objectData.Keys.Count > 0)
            {
                this.json = "[" + string.Join(",", this.objectData.Values) + "]";
            }
        }
    }
}