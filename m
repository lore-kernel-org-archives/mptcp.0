Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711B27C
	for <mptcp@lists.linux.dev>; Mon, 28 Mar 2022 09:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648460297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07Mi45gdW29fyVfCL+cyHQvOF5SHeGenyDmapEHikUo=;
	b=KJqhl8tvymEBUm5Tj9EXEAEg9PD7Q2fTUczP8TxfnEmUmOBMP3t5tcbJd8nGQpmdyOD5Y6
	JHNdsz7VKsY3+vNHerLF6asc2/ataj2lZMQJoz+xIIx2MIHktHJUAqVKfMAmX8hhesxvwt
	kHoK8XvV0TVLx+kRwsjPJfD6GYsI7zw=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2055.outbound.protection.outlook.com [104.47.9.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-Huh1p26XMyS8frfSQKkzqA-1; Mon, 28 Mar 2022 11:38:16 +0200
X-MC-Unique: Huh1p26XMyS8frfSQKkzqA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn2GqOiyWqfMUgYeOdGA9IGgASQ9/Jy9cYTvokKmzM2XGNP3DYCaRrMd99uSG7OCqD83uovJ0Vy0a+uNaSxFjFnWt84bCtGscR1/cx+l1NtRluvP8mxjqqyEYNKivnRBfROMnQBrJNMNhqJFREIPYNu4Ew+/ujwBLst88N9p+ScnERh6mUymje5iFbf5FpOZkHXeJ0B/5L6ly/06G7IFkaHRtlsZEhH8VzZkZUPduFFdbxdZn6qS6CaKq/GNjC6L3+b6gQwXsciaFBXKuvnjtOS/VaLk6sETGywSMkL/pytcy3WKzmfy2/Ai6Gkuyo+I9xjURD6Zq1d7qH25rbxYeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lN7S5TalWS4+INezh4rB/xrUvt7NA9yhW6E7t2b5ng=;
 b=J8E5LhMgrWskSi3D7Jm1g4rNnDp3fEVhTIOkS7lh3dogC+WyGZAVTs5dSBtsf5KckZWZlHrCOxYvpbgId6NVWvJ+yByMvmIz2g7O6szFxNDzbxYvGo5TEmLjsgve2fPeEuPB3WFEaycLLbVl2N6QoUaE2IBTYlTUUE6IYxfpZ3/5GFRVnH++pL2ueSq4ILWFK0CP1C5lR427y3lc18cBc9kLLkxlCLroRfzZgCTPFD9WFicYCfIbAPHuFmNIuSLNKFQVkaAcqAPw1WwgEu2K3+XtIx7wzzkaKqxkDBdb0n5z5i53oTdd6XfarlLZNcpqUTWFFyY1mw6x57/tcWjhGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB5067.eurprd04.prod.outlook.com (2603:10a6:10:1a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 09:38:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 09:38:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 2/8] mptcp: register default scheduler
Date: Mon, 28 Mar 2022 17:37:56 +0800
Message-ID: <729cf003fe9aaadc03b2a9a4cc7328425804031e.1648459865.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648459865.git.geliang.tang@suse.com>
References: <cover.1648459865.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a293fa06-d756-42ef-76df-08da109eaefb
X-MS-TrafficTypeDiagnostic: DB7PR04MB5067:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB506773EC4CBE17FC0A82DF44F81D9@DB7PR04MB5067.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UiTRHLcsOwhyhduF0+yRPQhMRGb4zfBsZ44XD2iIwGFh2l5+SRYfwzUBGqUEXW/ODpw6qebfgBMjm/ErjA4QsKMvm28vBC017bPRE75/xUVBWk6f1d6gNvBSedY1jgAoxuOG/T92WsD//wDh9KDBnPJid/uaL9VxA3E3geguCfG2cxXMf3XT5SXijyNsph2++Ek/4U/T9/6JO8XbU1QNE3DiYhW3UqrAr+vIxiljNi/NYccH1mXUT6+56ttLyMl+AC4hCOCOUPRv4TJe2BJ26E/eTZeKzRJdp0x9MBoJiZIKVLuSUBBR63NKsZFU5JNSj9hbAV8R18zvsAMbEkwoylcMfoP4uJUaTpkzeHJDD8gWq+14Uf6PhM0fU+iUiTPhfsUIPhxpnegDYT7JzYUKL0/+UCO7W6FQ1UoXjrMs0SZIFrx6KA2owGqQcQ8Gd5OwapUClrEZvfRDKmt91nX1x6Iv+pVATaq9/wMcQEoBbnnt0RyQ9Wx9NTFD1wkgZZknEg1skYeb60hAg2YHCwOtRjDrhIiOogZtu5PTTiJ0PHsfrbjj6o8OTMBxeYrESYijsn0ThTddsT5dBQTL6tR918BiIpjLcGdsxRJCSkaE9h4OElVljrpCP6j4kiJED46auRgyg2tks9fpFWNIAx6wvmynfEi0s+XagUzUo9eHc6Luo7ZTtFlKfu85ko5VXuIFZTK3FumQgEBdub5maZCcPA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(66476007)(66556008)(38100700002)(66946007)(2906002)(8936002)(86362001)(316002)(44832011)(5660300002)(6486002)(83380400001)(8676002)(4326008)(6506007)(6512007)(508600001)(107886003)(2616005)(186003)(26005)(6666004)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EFypAgmk0VNvG3mWL/w4+8BTY41FRwop/9Asino7SR/TROg2nB8zk5yrg0cb?=
 =?us-ascii?Q?0MXkBOjWEMSYbi8S7QddV9gA25eQyKC93u2jjnLkBhqpT9rJhJS5CCzNtyep?=
 =?us-ascii?Q?Em/p9CJNA0EslQRTA+8GNckFlmTc/G1wBOigDzBNsnNmnBxAxHwB6eafhzgz?=
 =?us-ascii?Q?4Nzt+sOxmtiDuN7WmmPMS7tvkWe7Q7OVYrSGtGu+mwtEial/S834F+iIleYN?=
 =?us-ascii?Q?M1zSE4EIAF2B8cMIklnHb64U5pXCOAKiQuOtEmCakQiJFKfGUGWmO15w+qxR?=
 =?us-ascii?Q?T71EaTPE3OqtjkrAlOzmNvAJxvh94/T+I1r+hyG6IkmJHMR+69asoYJQiswo?=
 =?us-ascii?Q?+dC0EsDhDPoRwMjzJrPc4Bi3i7671/fx3rbvPcP4B2bnZLaOTw/Q6A3w8J+R?=
 =?us-ascii?Q?hitki3rW/xpf2EP9Q3oXy0engtztsurlT45/jeQbtvL6LaXkWvOLv7UW5G3K?=
 =?us-ascii?Q?xjFIpuIV6Vuq+91nBdedwyrmMwDFK3+kDQ7mRsxJnsOlFH7bxyfeGdgeeAF3?=
 =?us-ascii?Q?L/nHB9ZFXp7yG8AirsLgUFlhT3CyF9XUILdwyTDkv0FYqXkdVxhXlXobEQxe?=
 =?us-ascii?Q?HhDEAZBuzNCdxsIqpfyvGq3Ds9lNlon3fpLznkmBpQnnI4AN5ZLaSCcimJpe?=
 =?us-ascii?Q?rw/ODaykS9A8wJa9XzRjkuCCej7DJ6Kc9ldRdveFYc0WlT8rURaV2QuDklI6?=
 =?us-ascii?Q?newsQ91Rc9ONozP4cq1rPQSjynEt1/opZSFdKiFsFqsxTwZtExirxC1wXBag?=
 =?us-ascii?Q?dZsWRnMm8W9bzOUEQjw9BkCqnj1iyF3DhAMog0MA8ZpUOkbVV4gvJVvZgZNY?=
 =?us-ascii?Q?O/LzsNU48pb/xkscOX/rjtrdvVKJJSMwuGUUO2rrXnexQRjiYUQFaMJd7h0V?=
 =?us-ascii?Q?4W0wHi9GqsrhIaiU5K6DK3CAFhUrOqJJ41gP/EhnKcbdXOjxk6FThcr6JxOj?=
 =?us-ascii?Q?RbPzkC9FRxfDXaHjC5LtFmkXEuHWmybM+FHsjUzWD4nCUEujOebU7n70/36d?=
 =?us-ascii?Q?yCyxRseuQ5jS/EAJc0nLO7MNajs6MAnMFuV6giLb1Pyr1mNMQP5zACgFksWg?=
 =?us-ascii?Q?CuiSTfcSvi/wRTueZBCWMFCN+ZGvmPvvVrVNx77tcz3ozcgVG52Tgh8C14GX?=
 =?us-ascii?Q?jmhVcgcuHeq7Pxspumqa7aiuYefxifu3V+glJtSmJ8MlqITK7IqpLWFTZLk9?=
 =?us-ascii?Q?cBjdplmggI0rKSXMbDhN8lPksCnUNgAk3V46BgioLN/PkuYzoKe110ujgOZE?=
 =?us-ascii?Q?z5wAbok67ROUrujNcCygfVfPkWQ/Lb9BXSxq60yDldPX0v3FOZOLJVXWZj4J?=
 =?us-ascii?Q?pcgLV3sntvr+t2T91bi8+YenWpkC3VW1WGS7W1SPzCBor71Ju/1fiMappSbh?=
 =?us-ascii?Q?O/S5kzu79L6+NqGahAI7/4reOIurRvzXYQ5dvqsPSCA8lByLUb2Pua0f5xEA?=
 =?us-ascii?Q?uRyST42V7DXD4ySu9a3iKI4H09PL32i84/oZ0EYVZ19bKQxZSmP2P1chF/2a?=
 =?us-ascii?Q?Nc53Qe1xx6JRCWSxlFf4NJmyU1WppPM/IhxzOAD590cDwoO5aUh15b3q3hnX?=
 =?us-ascii?Q?VnkF7yhOc1u3MecmDRAgdvIrt2ik3bOarnfJ3sIV0Hntjo+RuNmoZ9nSXQag?=
 =?us-ascii?Q?5y9USkxSrJ9JKAbyKBU8itlaxZmvKA6vNPwsNhOu2V6f8Pn8APQhMqyihqv1?=
 =?us-ascii?Q?AkZ4IESsKXnooURVDEkEirW5MFhnr/SKjzjivjzxWCn5V+oRyRtbOvcc8vpF?=
 =?us-ascii?Q?+tzyK0sNJamEbrUD1fhiVXLjfb5iY0k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a293fa06-d756-42ef-76df-08da109eaefb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 09:38:15.3876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWc10jwqyHjrBXMl24YL5g1Z+XpIiEq+Cy23Tfrfh4y8xc4jdcwW2ddWjt58a1rFZS+sSAzB8iTZqu+DWIu9RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5067

This patch defines the default packet scheduler mptcp_sched_default,
registers it in mptcp_sched_data_init(). Skip deleting this default
scheduler in mptcp_unregister_scheduler.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  3 ++-
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 14 ++++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b1d7c8b0c112..2c684034fe7a 100644
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
@@ -2614,6 +2614,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->recovery =3D false;
=20
 	mptcp_pm_data_init(msk);
+	mptcp_sched_data_init(sk);
=20
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3258b740c8ee..4c0a3c39e897 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -615,6 +615,8 @@ int mptcp_register_scheduler(const struct net *net,
 void mptcp_unregister_scheduler(const struct net *net,
 				struct mptcp_sched_ops *sched);
 void mptcp_sched_init(void);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+void mptcp_sched_data_init(struct sock *sk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index ae1956b6de92..1fb3dd24d6ff 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -23,6 +23,12 @@ struct sched_pernet {
 	struct list_head	sched_list;
 };
=20
+static struct mptcp_sched_ops mptcp_sched_default =3D {
+	.get_subflow    =3D mptcp_subflow_get_send,
+	.name           =3D "default",
+	.owner          =3D THIS_MODULE,
+};
+
 static struct sched_pernet *sched_get_pernet(const struct net *net)
 {
 	return net_generic(net, sched_pernet_id);
@@ -70,6 +76,9 @@ void mptcp_unregister_scheduler(const struct net *net,
 {
 	struct sched_pernet *pernet =3D sched_get_pernet(net);
=20
+	if (sched =3D=3D &mptcp_sched_default)
+		return;
+
 	spin_lock(&pernet->lock);
 	list_del_rcu(&sched->list);
 	spin_unlock(&pernet->lock);
@@ -111,3 +120,8 @@ void mptcp_sched_init(void)
 	if (register_pernet_subsys(&mptcp_sched_pernet_ops) < 0)
 		panic("Failed to register MPTCP sched pernet subsystem.\n");
 }
+
+void mptcp_sched_data_init(struct sock *sk)
+{
+	mptcp_register_scheduler(sock_net(sk), &mptcp_sched_default);
+}
--=20
2.34.1

