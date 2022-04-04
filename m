Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF723C8
	for <mptcp@lists.linux.dev>; Mon,  4 Apr 2022 02:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649038223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z9bKNns0WKPtoPGR1Yav8hetGtaj7+evRF/dqMYzWuA=;
	b=eyRKi6sIhKQ/Zc9Pg/SER7mqSEn3YssjftM17AZW2kHfYfUfKYqt9ehnL2o26VAP3Tgmp9
	F/ZgxzkCX2RGgo4InqCRd+qhBtBfrm7IEwGZDKgRjhB5fiesUkC0y+XZ5C97F/gXiEOls2
	Vq2/4eCugmTOdVch3AC/jpm1HF4eEhY=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2057.outbound.protection.outlook.com [104.47.8.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-ZYAkZPotOw6vfIfb0W42wQ-1; Mon, 04 Apr 2022 04:10:22 +0200
X-MC-Unique: ZYAkZPotOw6vfIfb0W42wQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYnY0psqsJ/JXGo2e852kaIWpbLdZEDp+dz3s/ra9hyYwglWGUSWG+o2eSPW0i26tqXcp+l5CEUU/wtkCYb7aXOHlEUME1WmCtx2WTFiIF6p7skbYBFf5evbXeJweXzs3Wm5Q52MclDHBMz5LXErYPmS598IJWNdwduhaqKrNDZXKmROzRphCDhNvVFW6/bhg+OJMs+bTpFX+IYXd/tNAaFYw6P57rizyLztSYFQshZMeBtV0AsQenJmwoQjclPYmKyIF8LEfxnqzHA221pAgEPxes97yoQ/mg7lFQuWprbbpBCK4voZvGT/gwIaJM5gkdowP7F+RPALVZTpht1p7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDimTEZvw0pFT5GFgXHly73uwPmnpfTzyITsok+hkpM=;
 b=JmXWdDCAznwQpxGrW+euF/0Qywyxt7PRvNiSTjclcO8bTMfGOUOnimRIBDVydDxfldykyVELyDdw+7rhuVMPKZkJdAp2NpOKp7EhuiXlDWWbNFNTutD853we+jc5W83zIHX0FSqa+JjPS3cEfka/hiNp92FU0JTRSa298YHjfv2wZ2Gy4i505NhVopDr0Mx9qkBDGYXlGXO+V2ZfzelZQYRjEv6+I8tYArskdrGkAxZ81rx2wXLB1tNpNi7yBMY0ocmdCAoL9o223f+tsyE/+hvVHb2xyCoRm6Jz3hNKrMRWofMvAI8U6w9z36f3BgSQ9fkAday9ldLcXC9hk8dHYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7189.eurprd04.prod.outlook.com (2603:10a6:20b:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 02:10:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 02:10:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 2/8] mptcp: register default scheduler
Date: Mon,  4 Apr 2022 10:09:54 +0800
Message-ID: <b0bf754af3bd3215440fa60dfb816bb6b62c45f7.1649037838.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649037838.git.geliang.tang@suse.com>
References: <cover.1649037838.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b7ee162-b370-402b-cb1f-08da15e045d6
X-MS-TrafficTypeDiagnostic: AM7PR04MB7189:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB718916D495071F62345AD2CFF8E59@AM7PR04MB7189.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cAqq0Mz70KT27wgqoHEZuV+ujIaT4vqJBI5WDy16qLeCfvYTcV52NgUWRZM7etaGMLYzvhwWermB0yFRgfM0nmp3fSmSxqKNoz6nwRWpDibwo5ymCAs11SsXO35LLqqVsBpIxNGhdO2+JOJBGjfVINZhjsLNQsHJQPXw5mIJQ+CID6gOKT3LH/EMmYAwW/6qGZlwgEWM19Ajn3ELYNgH3Uf7XcQOQ8k9xNQd8lAuwZGg4tc23qV482/xAg2I6NXGjNc34bUguezhMozT5SdyUCom/FHwr50DUMCfhHw16PoI+QPlgNYoEUiMprzIrVIoFtPERVZ7CmzNeyMFlRpw7GU8Zos/q/xYFtuQIB06bZNJQ07xzFMZPj05/hyuyUthXWiLSzrE1Mdn1/wSfF7Lwrfr1Hw+HX4pGVOvolSfuoXpH4/6ukLVINwtU+Xb3J33xAuxfy+0IvX+uTKOql1q2gA/mN7GBN99k62G9WwVpH8QoOS7suVV8hTZshuMobAOsbGL2Y2YiZv1KEbUVkM7fC9bmieoUdz/k332w5vg/71ixV5GI1B8NpRD4XGW5WDVGeKNGcN23aLHFuRNBbiOqzj9Gc1Sc0l+H0LBPO9qoCSmQ3Kzsu9MDSwzhYhyYrc+JcCLbTi6aIlYm4Ra3He35CmUJQfh51MO4bBH3MIuzbexFjtCgZDnX5/+NMJXO6cw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(107886003)(6486002)(5660300002)(83380400001)(8936002)(36756003)(26005)(2616005)(6666004)(2906002)(508600001)(38100700002)(66476007)(316002)(86362001)(6916009)(66556008)(8676002)(4326008)(6512007)(6506007)(66946007)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1pJHfoNF5FNO7c9/94axQYGpNP/6uba77zH8WES+7jE2w52IgzDvrY+9yMUi?=
 =?us-ascii?Q?As+gEquKykPSoP7GHNV6+RfRtpe37CUODU7m+Q3VjrWragXSINbsSG4HajeG?=
 =?us-ascii?Q?2XbXQbp1RMgLI2z9G+bkRf4ulXKCApFuEXPPOYiKQwcn1Vy1Q7BUP70gKX05?=
 =?us-ascii?Q?KeYkgZBEClAU3GNOQv9MxWqhwTC9j7qFcTuEjpzl06vAZOa6rSv0jaVG8nHp?=
 =?us-ascii?Q?u3p5PfdNLjL344wN0gnTXwyfq1Pfwck9/7fAUqnwDzbrT3IU0OPB9k2jeoFg?=
 =?us-ascii?Q?SKagBpC2gAgub2I3KtTbseqxVVtNRic+DfJpRV8ysW1gUhjNCBqaaw1dd6J7?=
 =?us-ascii?Q?9B936UAZdP10XZct2BmFOao92srPIozT/06S32ZqpKGmotUzsUWsl+TJ8cdH?=
 =?us-ascii?Q?F6/3pCCcJHTEaaLrcv43YQqmm1yE36CJPJ39vJCt5CKTLUPeeEQ/Nrg0xKv5?=
 =?us-ascii?Q?mj8TCKi8CEFZJuD+Gg68pkau7F74Mo16qGkCA7Z0SPnJtUpFcFCggeGwCvxo?=
 =?us-ascii?Q?IbA6ulQq6p/DMnMEBVB2/iB5DoJu1FxYLm0HxQhqla+IEi4TqzGNc/k/HqBn?=
 =?us-ascii?Q?lZIUN9W29JDBjbKYHfPClALqoJRZU5e/0eX91y8sH1+BtOxvz+KaDf359Czb?=
 =?us-ascii?Q?OugUAn6s9f9cm8DZzllFyIUFFOBFS02oYcwyF2fg97quii2GfUeTEpQB7Nvs?=
 =?us-ascii?Q?E/LEYdo6SstDb8q0GXtFLHpBxg6+d6q48CC1q6Hrl41k8M3uMu5NE5us6tZv?=
 =?us-ascii?Q?oBnWh3Jg6giw1B/lmVlTVSqTNCe4fp1pf9ipgI9Ac0oxerGC1yNVySaEIB26?=
 =?us-ascii?Q?abU0qesI9aUvn2GijEYHK5pqK5MytuJTTFKZRg6EEb+romAts7C3PNqVjXBV?=
 =?us-ascii?Q?oi6hkNwNO+h+eIXnGv/LA4MBcStirSlEv/X6dSJvj7HMKul1gDQ6pRSWTmDD?=
 =?us-ascii?Q?20jPJ/82gybUw2MCf/uQiCaQbJkEKAvdkjR+E8/TodK0mwYPVmLBZiVXP6l+?=
 =?us-ascii?Q?I4a4VP9RL/OZNxvq1dBd3Rx2e7V5F7nYHA5XJiVC0xxaBTorrJetkZM7Nso/?=
 =?us-ascii?Q?gCFxAFcF/Z5vZ0mG+2p+jUaA9fercQjXBr8EkfJ26pGAvPNNd+TdDVKlgwSJ?=
 =?us-ascii?Q?i73fCmTziXU/dneUwrw26YFOKvk27CFyPqeDF40eGEgoQlHaQ9zvPHvQkw1P?=
 =?us-ascii?Q?a+XsdVfILp9Ee8TrK6Wr3vsWCn/rLMS2YgnUhTtYm8++iSkqnF2FJFWjDWky?=
 =?us-ascii?Q?t+G9tGVWiuNHAaakBcgHnoblXbmgy2ROuEqkOH7EotZJLox6H7Ou/h+yGdNE?=
 =?us-ascii?Q?DoUvxkyk1IVRrfNgzxhx1rzrE7hm3Ntfi7GMGiMFB4rtDnd488NFQXI4aE8i?=
 =?us-ascii?Q?qCeNNJ/A+ZANhmZ10kZ/9wu+AorOPuJ0X0gZTKT7m1OxGH09Z6vHwHH0pWc+?=
 =?us-ascii?Q?m+KnBwlnVPFPlnQbOHxtmc4rj9v4+UGdkPIHxcUpiqYcPFlzieKQkvV5KGFK?=
 =?us-ascii?Q?Qnh6H8zFH7jmX9ev1k9ThTmWo6noFeorOWT5d1ukYI9cbEpgM2BuqfhmosEP?=
 =?us-ascii?Q?RSjDO8xCv+GbSASRLmoYomU8uHRtou74xS93jYXUk3XY+S9iLq7EQtBd0ZRP?=
 =?us-ascii?Q?3vzGPVQkWXLsKQ8xYSqybpBGPTMd8Kidzzb/MHZ7veATAyVBBZiewzerGT6k?=
 =?us-ascii?Q?DewnGUuvLuFwx6U2NVS9YnYb7UpXrwQ6s85LcaeNcksdCfAfmnXiw2b5XgGw?=
 =?us-ascii?Q?SinkvVXXNCgYq0sfEDDqT9x4VMKqWVk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7ee162-b370-402b-cb1f-08da15e045d6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 02:10:21.8189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5HXPiTDg+qOTd+/SZs1oyk5Cnuzw0tsHdXGWvil/RxrtD2HnKaLAIylMcaUUzibOt8DW2xfAtoDTQpU1QEujg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7189

This patch defines the default packet scheduler mptcp_sched_default,
register it in mptcp_sched_init(), which is invoked in mptcp_proto_init().
Skip deleting this default scheduler in mptcp_unregister_scheduler().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  3 ++-
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 14 ++++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b2c654992de0..8f0e71c38336 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1424,7 +1424,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_contex=
t *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -3804,6 +3804,7 @@ void __init mptcp_proto_init(void)
=20
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
=20
 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) !=3D 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7cd2c1c3d25c..a264964f8d95 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -611,6 +611,8 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *=
info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+void mptcp_sched_init(void);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c5d3bbafba71..52828eb741c0 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -13,6 +13,12 @@
 #include <linux/spinlock.h>
 #include "protocol.h"
=20
+static struct mptcp_sched_ops mptcp_sched_default =3D {
+	.get_subflow    =3D mptcp_subflow_get_send,
+	.name           =3D "default",
+	.owner          =3D THIS_MODULE,
+};
+
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
=20
@@ -50,7 +56,15 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sch=
ed)
=20
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
 {
+	if (sched =3D=3D &mptcp_sched_default)
+		return;
+
 	spin_lock(&mptcp_sched_list_lock);
 	list_del_rcu(&sched->list);
 	spin_unlock(&mptcp_sched_list_lock);
 }
+
+void mptcp_sched_init(void)
+{
+	mptcp_register_scheduler(&mptcp_sched_default);
+}
--=20
2.34.1

