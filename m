Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4723CA31
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 09:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647942797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUfMKSLA5Bp0kliy1ANdGDuSrdGkb2DjLPMLmhk4Z0g=;
	b=VdNLjzAGinfpPOFFhmh2M2uDOLmGYDowCKbAFk8WR134zA44Avtcc2Ypl7RuwjZW2wUPJN
	1KzGyut7pVZYFvS0VQ2iCxwm8DYUmxLVDhGyNJuTylQHq3zQR2urWPdGCwqe5w9B7/7amz
	Wi/Y3vZNUhCBbczfdzZSq+ualYbLblk=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2050.outbound.protection.outlook.com [104.47.9.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-kVVxcKCXPRqSQr8CxtIARg-1; Tue, 22 Mar 2022 10:53:16 +0100
X-MC-Unique: kVVxcKCXPRqSQr8CxtIARg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTBDBF/A0JB9Q6e3hu0OUWJp2OC8AU8gAGdObFDjwBBTQef9BSwYST2b7I0pHRCN+/G4bi3YLZrCo5jghnp4cuxE2INMje6kMEVyMbmNfdy/M1mAVL7wdblCmz8JpoUcD6379zVzqt/FPyK4KD3Vcp7mQVdgV9SzYIoSR9+nrwLH3NKzDdFcz5Jdx4fhR52rSYeeVAWKQ9OLi6FqWHYva3YSueMEScpWQUj7WqOzyPTAXKn5geOTz4z+3D2MBMgmQIxxltCUSJupj36IsTnvmj701zlRg6qv2RH0pDD7WWigpDRkXJYTSCV1TRAc1pJvKRwKjOBQ9JTaewUpB/Yv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+LeuUiTsVgMDiquyysnuN32qrFMkLGwGx+kyi1viLY=;
 b=NkA4FWzzVdkoQntdYZbnVaak3i+2bvZdSEQchZROznUOE40iuAw51EUKOpCLqiyPl3h8PeT4v6Jgd8yG4dDtNKhoF1yZlqTYSjaTWh6Wyj1eBYdKLpIXhPn1RIlMWOxSmVH4yABgBKHV6M6pMYTLseW+bOqmIIqAb1qp1xwpFWciraLKAxB053TtB0NwvW+1047JAfDG4L/wkswfDPMllQ2nIrFLq8zHgTgcMqquGVReMnR2EHh53IsguQq3ZPPh9qzyfgCmd4wLJWrYxANntYVb19Qj9kDN0r1SdSztkHGgVfaryfcthRHLzOaCdWoCYsZ4mUl2HKHGOVJ2xmS/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2282.eurprd04.prod.outlook.com (2603:10a6:3:24::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 09:53:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 09:53:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 3/8] mptcp: add a new sysctl scheduler
Date: Tue, 22 Mar 2022 17:52:38 +0800
Message-ID: <0e1e6ebf2c8098e9bd1a86d4390eef5265bd55ca.1647942374.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647942374.git.geliang.tang@suse.com>
References: <cover.1647942374.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0213.apcprd06.prod.outlook.com
 (2603:1096:4:68::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29384d96-3ca4-4994-05d6-08da0be9c8da
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2282:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2282A03F5887EF2A874FFA8DF8179@HE1PR0401MB2282.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PywnklGvd0YZqTqmXJSOZyroIquPKqvTU7rgfE1WwXLZjFjeDVjmmD+zQPebHbklS5oRz9rzUQfu0CZgM8a6ufeW7JsgCyTVG15syIgmV4UHm3xPZZ9dJg6OmATo/OoYWH8A8ycdDJJxE0zQUKjxPTl6ShMPY3ojzt5akoh1q7nFpy6yoVpZUlncOxwQDJ6h+j9b4HBWfwIpcnR8QHQZ1h4wp+KfdTZKN/Dzc9/42xXtiL1aSDJRUlfEFqMbD1zx+2DGYxTiIlHDxmcbyqJ8uBYLuCNQCrAZwxTvinVwz6Is6itxZjlbgh0sbWW3EYa7V07S4qGtttK2Lt0OSWwPv6zMcvNXaRME+GS1DenKHZxeuH+LCx3b/t+lO4shj4UhmRk1Rc3okpgb+tJhFKN5n07iWsohwYyK7KcB08FORg3p3eScAphzJXcE8D2lNbQApmC2VtGQLwTrIcretP7IFW4cb/Dk3tLXUTwpg5fcwsdhQ4+NYbHbXwBegIw5Z9k56QuEqcGovhqjx+zNsF1bW0K9sMsWr/ZVBVWDcxki8RS4tVvoFQWpmV/YYZfxZflRh+PTFa4l1N+CKBXpQ8h1DuRP+hV5UnxoVyUW3RMpzhUMd0dHSzZFQUPDjZ2+AWP7JaoMNDcwjQ3Bg0BvosbM23InoriFJtPoNu9PC4+WJgqQSvyuFOUpVHLS0p33NpyeaE6dqMeCT1c9jathU0J9Wg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(316002)(6916009)(4326008)(8676002)(66946007)(66476007)(66556008)(2616005)(38100700002)(86362001)(6506007)(5660300002)(6512007)(186003)(26005)(107886003)(2906002)(36756003)(44832011)(6486002)(508600001)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ldipcgvE+DR2yZBGRs6Yv6Fe6lU1+YMDtg1LPY44tzDDSjkR2HvQltWWI5zn?=
 =?us-ascii?Q?M+cgdshtzxLl1X89ekDQAbSLhAhOMvOYGzYfDA2lOYkIjo6DIXeH7HnnGh0I?=
 =?us-ascii?Q?e06va2TRzxh5zekq492evxb4PPWJ3lnuD6I/3uAZ6Kj7ADFlyDyooiZKWRkP?=
 =?us-ascii?Q?Y9N+7g5lLCQN1wBRfAxFkLxR3xRr97+TH2cr9zonHM4TF6a3DFLI9mAa6dyq?=
 =?us-ascii?Q?nLdoGvQvd6FoutabQx+rK+ggKr4WtJN3MD69CIptstgbMmuQSce/FVb++pES?=
 =?us-ascii?Q?xujzs7Tw5gTzovUoLsnZc6eKzrNy6ND6dP2oumF9VqR8lc7twfMykiHLM9sb?=
 =?us-ascii?Q?RGD8xlu0moabowKCyfmJR3MxbK4OLPaQy/rqweCk0SKwC8mzv1sTzepJMr6s?=
 =?us-ascii?Q?8MihRzs2GrHha9CaNiP42Cadi/HPde4442yFPas8BJSlV7cvDjBMFdwr6yHC?=
 =?us-ascii?Q?YTFfZPPQ66A8QMd1HTXwaxveKcsBFRZeouEwz4uGeNsPYrFEZaussAy5iLyn?=
 =?us-ascii?Q?j/cZSe0WXpSuetdaImklwQn5xkzF8GzuBiqFgkxx0zD6ADaTE7HsTML5umR4?=
 =?us-ascii?Q?TXEqh8CRHjp6YjTTIhjm+84ef7XupuWn5GUTLxqj2rTEn116QosOabPvu6cJ?=
 =?us-ascii?Q?dshpI58sBzpooI+SLULrCB602Wfo6gvb09U5gh+AtopB/q3cjVxCDvlFX6tM?=
 =?us-ascii?Q?KyGWMX5/tSME4vYP3lji9hI//6gWg4UG/CcO26qbZdicbaOceCbQRpvD7zf+?=
 =?us-ascii?Q?RuO0oH7gQPjKsepBo89bEL/uC3xNR2j5JinuGg46CIFOtfAdGElfs7ACDvxK?=
 =?us-ascii?Q?nDif0WPMwvvxLI4F2XeDaMxKoC70Ao0ppz059EO+y4bF0aBhmlwkA1o8ke0u?=
 =?us-ascii?Q?hH/642OtHZktcA04qMvFyFuBQ04WFfLFjid3zO6wIS3u69CaHVxadA7CCMk6?=
 =?us-ascii?Q?Us7JnX/Gcls/QvvyIg89M3rOrh+FlOd9JNkQVK7jqqzujZnJltbvMGpqynPH?=
 =?us-ascii?Q?PIPYUhrXI84aNG2dNhfUSltH5i3sbF0SFEpVfaRUVutQw1XsnZMSVUV+eUA0?=
 =?us-ascii?Q?oL5mgEpzirB/uk8gkiN42Jx1A+emq3i3MWChLV9Gsf5scpLaSAPf/QBy8yoG?=
 =?us-ascii?Q?HPy8j/FgJXoKJPlSLCvQbISb3LPPtM5RpfreSzBGl9gfY9J+MnU2W/WWv8s/?=
 =?us-ascii?Q?D2FXKueM1mI0xPqEK8gz1MIH7Nfx+IiUGF88h/WNGu0/k8QYBIQsT1+1APfB?=
 =?us-ascii?Q?Gz3P8SW093QLWyhMLRzunvdiA5SC4F71E+4V6FXFppu16E9XM8yXa9F486/h?=
 =?us-ascii?Q?Dm1vVCd0PjlQFtLUCq9DdtBC+TBi9FaZWtwq30Ant3hWb/xLuXf+eJTRUAVP?=
 =?us-ascii?Q?G5gfp6C9JJtGyHpQm7cqIi4Q6rztiRK+1Kd8AqM2/+wbeEN6AVSTs9T8M802?=
 =?us-ascii?Q?S3ZFK1I4X76+xSljwq6B4no1Czcw8W2Jz9nuN7vNwfROG3wcXJbPRQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29384d96-3ca4-4994-05d6-08da0be9c8da
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 09:53:15.4019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ppaWe9/wonNu4Pnpkz3ko+xf0v/Iqzzk+NB4FwARwHyfwWG0VQlLPyeG0lA1dqzRvRnrNopzmKmR2QBtJ7BQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2282

This patch added a new sysctl, named scheduler, to support for selection
of different schedulers.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 Documentation/networking/mptcp-sysctl.rst |  8 ++++++++
 net/mptcp/ctrl.c                          | 14 ++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 3 files changed, 23 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/netw=
orking/mptcp-sysctl.rst
index e263dfcc4b40..d9e69fdc7ea3 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -75,3 +75,11 @@ stale_loss_cnt - INTEGER
 	This is a per-namespace sysctl.
=20
 	Default: 4
+
+scheduler - STRING
+	Select the scheduler of your choice.
+
+	Support for selection of different schedulers. This is a per-namespace
+	sysctl.
+
+	Default: "default"
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index ae20b7d92e28..c46c22a84d23 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -32,6 +32,7 @@ struct mptcp_pernet {
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
 	u8 pm_type;
+	char scheduler[MPTCP_SCHED_NAME_MAX];
 };
=20
 static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
@@ -69,6 +70,11 @@ int mptcp_get_pm_type(const struct net *net)
 	return mptcp_get_pernet(net)->pm_type;
 }
=20
+const char *mptcp_get_scheduler(const struct net *net)
+{
+	return mptcp_get_pernet(net)->scheduler;
+}
+
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled =3D 1;
@@ -77,6 +83,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet=
 *pernet)
 	pernet->allow_join_initial_addr_port =3D 1;
 	pernet->stale_loss_cnt =3D 4;
 	pernet->pm_type =3D MPTCP_PM_TYPE_KERNEL;
+	strcpy(pernet->scheduler, "default");
 }
=20
 #ifdef CONFIG_SYSCTL
@@ -128,6 +135,12 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
 		.extra1       =3D SYSCTL_ZERO,
 		.extra2       =3D &mptcp_pm_type_max
 	},
+	{
+		.procname =3D "scheduler",
+		.maxlen	=3D MPTCP_SCHED_NAME_MAX,
+		.mode =3D 0644,
+		.proc_handler =3D proc_dostring,
+	},
 	{}
 };
=20
@@ -149,6 +162,7 @@ static int mptcp_pernet_new_table(struct net *net, stru=
ct mptcp_pernet *pernet)
 	table[3].data =3D &pernet->allow_join_initial_addr_port;
 	table[4].data =3D &pernet->stale_loss_cnt;
 	table[5].data =3D &pernet->pm_type;
+	table[6].data =3D &pernet->scheduler;
=20
 	hdr =3D register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c186d199cf5b..f0bd2e17f2d6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -583,6 +583,7 @@ int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 int mptcp_get_pm_type(const struct net *net);
+const char *mptcp_get_scheduler(const struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow=
,
 				     struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
--=20
2.34.1

