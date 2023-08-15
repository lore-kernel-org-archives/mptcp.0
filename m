Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC2C525A
	for <mptcp@lists.linux.dev>; Tue, 15 Aug 2023 06:29:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyvL3aO4f2h/p0GAq348MgXvoRsIldZ/G64BMjFS4DaspZ8YWpPE4jjTjiyRKw5oPuYpusRSvTGEAAp+qNzrn+ZCf91xw3jfHJ7DdyBacYQfFAt473+SdImTLqf1DpZK8vR8/JglApcf72ac8e9Y5Ql4VVg6APtyH86whVBKx+gWojIJkfSeFIBUW/XYRvfUML2f7vmPUdr7tmottJ/u4oTI7aexzA5ghISQ8pVS8wVq2y1wm7N+mKIikhebs534sAHa3Bs9ErGAlLlAqcS6lKwxvNJ+WkpiRUqf8BwemBgGAARIUd0UMc14n9toE/hMSRxh4SqLKSSNQovhXMkaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU/m3HCap44CvDzKFr9OZIWSUp/EuPz2jdGoZfYq97U=;
 b=bXi7qh8KPwY5Pttenuw9eunOFlNOSvfmQKriBeRzsG+y74VQBsWAQps90RRWXJBxY0bgwM/2REjodO+aIV0qDl51KZoWa2L6vP9OkZoZp4iQ2Y+fgIKyAV1S9oH5gQ/ZmVcSWMiOoL03JQTNsqe7RuDa9vH1DSVqFBjXpqLGtXhgx9Et20gJXRe68NJ064M9pBCE2WOQRKWNkzW/i5ueaI1dRpp338GqcpbWHXIzB9YLOF0viPcZ9sH0e+p2z6yBoF637QWnf2tC8JkGUn6Jb/h+u6bbW4V0R6u/aixW9dJ1PqLgz+HNPNF9JpVXON210zwGYRHYWv09CZkUOPG4sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU/m3HCap44CvDzKFr9OZIWSUp/EuPz2jdGoZfYq97U=;
 b=OiSBz2VbjniSHdl6iiTuufp353IA/u37tJ9pCk1wonLA78+TfYw+jPSuyeNZhdr3KUQPjfQAYJzMUklDT+aXL4s3LaUzD9TADGs2ZCIydi3iOLDWCEBF2+obH2Se9YzDPR7GFTMY1B9gz+IRkBcdcCV/jHEZ2md7TIHkrhiztjndxnJXCdeOmOlB3n2gAxx+a7NWe/ERZQrTf5lpzPXdyNQe3C7uSMi6tuLR4hv8Y15Uq/ACaG/o0YnB/fo+2dn+MzH+7g8diCnhxsKZBy+lH6eI47TEq0xwR/gI+pneR5eZNU/8WN0Sb/m4QZbydLhWBxncwVF/C14P3z4lfKfaEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8686.eurprd04.prod.outlook.com (2603:10a6:102:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 06:29:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 06:29:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/9] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Tue, 15 Aug 2023 14:29:21 +0800
Message-Id: <33e1e499fe4ac2f7a1b34dcc366819ae1830fcfa.1692080803.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692080803.git.geliang.tang@suse.com>
References: <cover.1692080803.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0277.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8686:EE_
X-MS-Office365-Filtering-Correlation-Id: 533ffbab-c682-48e0-9fe4-08db9d58fb29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fy+nOoMNypDqfe66VGMSg8wVqpJdKDmMV97knfu0PrpxWmH3APwVg7WA+6ytwnSJF2zE77ho1pHGLJTkUJc1XIgWU1XJdNWAV6tKYqc3mgDgPt91A+ywRP6dRxj8rXhKnEfYY0373RT6Skonc62gYEd3tIo8Askjihve0o5+mSvI5Fi9VvR2FvSqFXH3ZZ4ZT0o4YPojlHMp8whve7wOWP0cxIjnwy64MhkNCVJ5XitRUqfGt45enXIWrpOcCD2OEAOntNfEgQ52vanOlhNuyB3LfiKfnfSzlLGSqCoq77G4fnjiqYoD92NrjcjGimbgMXplz2Vt7z81GcXkV2ysiDHOVPqLG4ltMR+IySeryfxwBw+htnINp9azCqnW2EtvoLku7mwmed+UK/OhTTUefta/DjYdUzM6Gwir/kioxCqBJQCcdGCGTgMpNNcYTtnRt/Z2P0cVChpZt47Krxy/KXG/j4BOcDUKLubANCItYWyLZQ1CH0B9YO2LMO8xkKWm8t7OfxQFgU5GGHRv/6lIguSaDZ3GDx/b2lbU2/GyqwB6QuTmz3zdRlZJhQcmRbDDFwM11Mf4JMoXCvZbxFpV4PLE/BgmSTiCyHmgGfejWdU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199021)(186006)(1800799006)(26005)(107886003)(6512007)(2616005)(83380400001)(6506007)(41300700001)(66476007)(66556008)(66946007)(6916009)(2906002)(316002)(5660300002)(44832011)(8936002)(8676002)(4326008)(478600001)(6666004)(6486002)(86362001)(36756003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?771Vc+e2heKzncloeQ99rrzr9XOzx3sgAoRm9razpjOzoIl+tZnsT0lU/yiV?=
 =?us-ascii?Q?99bZPvn3exjG05Tm1quwrLuxLAnAsw+7NGkPQTjzJeqGZOpbMyFzirewPzjf?=
 =?us-ascii?Q?eS0JoDgIS90J2xFtoIhBdjJb2TtUsFmcUyOBl3lJ+F8AqHRChxa6EhtB9Kvz?=
 =?us-ascii?Q?+Iwg1zDOyzjBXdjLZ8CKGxWavvsKvZ2lN2qiGxSheHz6NaYyx13yNPO5tKjx?=
 =?us-ascii?Q?OdNb1ax84yQq9UxkPWT047pGGYthEUM0nwPMpc5N6RtJXiKL4PuHqK6CuqFY?=
 =?us-ascii?Q?lZVatDhGwaUPuAZUfZQj0uP+U5s6fISmW9d+RZGVB1RIauiPL5hm/DpF3H8U?=
 =?us-ascii?Q?YVzwnGp7wT3GwbIU/EzwhEMoXIQReT68MzW86gPyL6/oehHTe3mDI3k8lu03?=
 =?us-ascii?Q?zlq5BXQCPg/0EwduIl3n3tzyRKo8WsO6aIjYO42tC0UYcmu7C0hmg/KEXU/2?=
 =?us-ascii?Q?GlvKfvf32TaC+1eye1geHdrKvfo52p8Sr9PYwh8e2V6J4WwAuqjXC/IRrPYO?=
 =?us-ascii?Q?AyOt8tlXgGtjrT4XYJs9NRnCjxX66oLBZzw2bBiT17oLlKAqqzoRddVw9C7j?=
 =?us-ascii?Q?htD48uKKjefFs/787sjNAhnDIqwhU6MMKG6nPfTBosnVRv+bn+5glCLYL7ek?=
 =?us-ascii?Q?5hVjhDEdY3XRDjw0Rzn5Xb9ntIQyOBZfR0+pRPkBicYVix2CIo7dpzuZ9ms8?=
 =?us-ascii?Q?BQdHWFYp2qIdM17gNl3jp/iNGK8yOsdLsOkcJo4DGIeeGMX7HUHNsrlJcAm9?=
 =?us-ascii?Q?H/0a5uF9wJxzfaKUAI4q0ZUQb8/XsvpE7wdj5M0Yk1x1e85q2u8n55dkE2Is?=
 =?us-ascii?Q?K/fTKbs4m1ieeDVH7PV/Hx5tcytOryht3uU4r3oGmR8/5B4vRBQDbv/QrM1W?=
 =?us-ascii?Q?cRzUGUBvZwXH50d87mQI8AdfnxfeY4bA4Yf/T5nJkotc/vIBQIJN+WPm5p7w?=
 =?us-ascii?Q?9TuZjWsfeCP1d79cFMDMcO46PWw1h/DD/jzDZSHOl7B+itWTFDHe97ACmBm/?=
 =?us-ascii?Q?YDHIDzVw9UtcHRvd6Hufx344m1ONELgYw/U8meUpjmO0pnVbap1Y4q4AlW1T?=
 =?us-ascii?Q?ZzFo5w/UHbzQr6r4viNcxDfA1KjKNghrJ3/mF17guzJEKYoRqstIrsCUKODl?=
 =?us-ascii?Q?qJgQAqtd2dxzmxyjatyxokxhYHJj5jEin5ETkWU0fGATx0ZXdIntKSa2iV0a?=
 =?us-ascii?Q?HHsaOTK7tL94F2CzyfBJAoU+6BdgWttMWFwUYTQLS1mg0ORGLFA2yJqtMmsh?=
 =?us-ascii?Q?FYAkjhzDkWFVJStGY/wH5rVa+Zhz8KFemEkdMSxIl5T9YmjgoHG03R9O5s53?=
 =?us-ascii?Q?1ho2QLaUcQxzvXu4C+1Aam01JFhB8fZocS1oqniehRz0QqWhv0Ji/r3FpU7v?=
 =?us-ascii?Q?9JkaZBCC6yswpbXV8EG/CsV3dlFgU6UfpG/DUIyAi3q2Yfjy1eCfjUHFfs4D?=
 =?us-ascii?Q?3NHvy2AGmL8U8w3sRKIS42BPYc5aKaaov2AlJi6kLZdjCFaFJM6s5zAxQvsz?=
 =?us-ascii?Q?dbkvDmQAcP1eamTfqHx9ZWVpCIaBgsnAMwqzHVy6cGANMTDWP5eRVym9fyzK?=
 =?us-ascii?Q?2ZqGhxT/ORUbo30BQmGTwX0W0TMgEHuvn5bHqQyp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533ffbab-c682-48e0-9fe4-08db9d58fb29
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:29:30.0737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nexgzriZW4Y43wBNIpqUW0rH+588Xx1E7S0Qpb7MUyOocpnWyFmTXuZCDynle114gB2bLrDRvhTEMvg8g1hzJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8686

Please update the commit log:

'''
This patch defines struct mptcp_sched_ops, which has three struct members,
name, owner and list, and four function pointers: init(), release() and
get_subflow().

The scheduler function get_subflow() have a struct mptcp_sched_data
parameter, which contains a reinject flag for retrans or not, a subflows
number and a mptcp_subflow_context array.

Add the scheduler registering, unregistering and finding functions to add,
delete and find a packet scheduler on the global list mptcp_sched_list.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h | 4 +---
 net/mptcp/sched.c   | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index ba0e1ee68a05..fb996124b3d5 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -106,10 +106,8 @@ struct mptcp_sched_data {
 };
 
 struct mptcp_sched_ops {
-	void (*data_init)(struct mptcp_sock *msk,
-			  struct mptcp_sched_data *data);
 	int (*get_subflow)(struct mptcp_sock *msk,
-			   const struct mptcp_sched_data *data);
+			   struct mptcp_sched_data *data);
 
 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 4d81d0c1c096..049c94678d9b 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -59,7 +59,7 @@ struct mptcp_sched_ops *mptcp_sched_find(const char *name)
 
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 {
-	if (!sched->data_init || !sched->get_subflow)
+	if (!sched->get_subflow)
 		return -EINVAL;
 
 	spin_lock(&mptcp_sched_list_lock);
-- 
2.35.3

