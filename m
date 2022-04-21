Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A427A
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 06:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650522161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MC8H7yQYaz5Ea+Nga7xr6KOxz1gRnFZDkrRbxcZNehA=;
	b=AedKFIjE8VSMgsawMoSj39C3H09GRqRfjrigzCwXvC1rxJnBJ+F9WIzOXKqdaiMkJljqau
	/uex2kr4bfE5x+fS6oGgxdpaN10nI0v3j4sesHar3Zos5xuiPn0x6PsNYEUOvFjLXV4bGO
	YBCTrxxXB812+neWxIieFOEEImpS6YE=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-8Q01BdqHN3KTofibDcKDBw-1; Thu, 21 Apr 2022 08:22:40 +0200
X-MC-Unique: 8Q01BdqHN3KTofibDcKDBw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxsqjk3HAygX/pzutvcPk6u+lIrr4iCxyaKgn6mCE0henGnycDRAsaCHQmGuZ/jvLj2rP7ky3yRuuQy8arhTb549FtsUuLaQhtctyg+T/82SR9PYaNjs0+I6FVZXvBKJHLqe+Vnj6oBlf3OI6iYth3J7wTeZB25TVHXHYOlL3H+CiTdEv/F0pcIFHLSeUKFk+wB/xoI9nbudPe/WfEvgzxPpWhYE5OG64QA466stTJymPevm0t8amI3zmGhCp9G1yIKHWbPmtpvCyfvLxRX+Yif00PUeqkzIZQ1x+XecLNgt5+7eyCG0HhpcMYUyDN9R6UwQLd3N9epLafNcEoX4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyP8xbjUCFI8EMHHeXrFei/OP8x7Ipvdrh/xZJyD234=;
 b=j1AE/YgCDPlBy+9H1ryNRY+mT8qjAlWXOxbGyM+AaXfAFtRLf574jNucwv5GnBoZQL8TN0QSsff61+/nk4e2cYadA0pnw4f59JPdJ3vKNMNrVXjMhcmYq6CBy9hqh8lppgB/cmnc/9JdCYsm40I3F/UMi79uDvZ+avKnboKJrJtu/R+nYNb0cpuo5nKFU+NaVn7HLRR26xXFvjIvYt1BqD/ElCtuS41BV6EG5/eaWpfeECCJNnnaim1xiYyiC6OcfTySKhoKfUaHJrO4+dxpQFnFsLXUK/gCYJkf/rOuovwv0mKUlWzPxdcBhpe/146tpX3tWuMD7Kj0ly3LNOQPjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 06:22:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 06:22:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 3/9] mptcp: add a new sysctl scheduler
Date: Thu, 21 Apr 2022 14:22:21 +0800
Message-ID: <655bfb05675291f94efbc587432d94d18a56bc3a.1650521788.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650521788.git.geliang.tang@suse.com>
References: <cover.1650521788.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:202:2e::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f689798e-5f0b-4619-0025-08da235f5550
X-MS-TrafficTypeDiagnostic: AM9PR04MB8100:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB810011705F430C7D4D7409FAF8F49@AM9PR04MB8100.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jxWXp5g+AYL8RxvB5N002rcASe4KBSLVFpbk2JBY0mdMBXFU8zy6BGGq0QEgOLwC/STe++5tVOGy/kGBYqDsXMi3RMw5IdMz992VrB7r1pnkO69BJlzFRpK0eIRtRgySc+xVWzg3to43bZuFJEmpn/1j0DJFMIX35OVLn/zDTu0RK/w28teeRnxeTcZh0hyOe2+6n7lBCF51TyJcYNZQXFUx8wfD7+CaXHUwdrKjCTLrW8hKcSm4xLVUf99X2xjoPSGS3pG+Zh1ViDyqxgxEL/e/is6JZ3Clt6lypKu9oTaSgmT9vZs9hLskjARu3A/vi1YFeZskaPloxQp7HU6xUULxPSpqFEpaIoa2mJgH0Y/Q4RQls4+pyVhEmarHDYEkO5y4OcL4N80Smhq3nDsJiPG09gGpNoi4KyzMW8RpwESrcNLlz5ixjc78DrVWE+VEvCLFkupgzV+6ZP1o4gJL3RVQ4HZ7Pw6V8l4EfW4QcZwSSNXkJOjsLfydZUVdpoidDj5cs4qgEcAtU0P6V9WkllL7ktbSgrN6AJ9c5VLRRD8cLSHOYYr/7GEYT1l5dFNLFHrYcWA1q4wb+OLy7U1zyQByURGVn5A4DNUbuCbgE0UYZmOycKHeJhitu+yWLCj/JrHukaRuasd2pmyrfOHgsfQQYL4OOXw1Jj/NJ9mV0SBFgPzzWzI/DQDUKhHcmJjjnPHP6XPYWc7TpIontquf5w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(2616005)(86362001)(6512007)(26005)(316002)(6916009)(508600001)(6506007)(6486002)(38100700002)(66946007)(66556008)(107886003)(186003)(66476007)(36756003)(2906002)(4326008)(5660300002)(8936002)(44832011)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GpATwmyefsj7WzV+YuT3ylp0T9l+K1Ep6Nzm5RNWS+BX5rViSwsvU8nxE1AR?=
 =?us-ascii?Q?nRj0xH5zgPR9huXAomccqsPa+INY+l/cR9kKSWtw8TsXuLoryGdQOQCpOFqL?=
 =?us-ascii?Q?MWCMahwVb+M4AyFnUfNZfDdp5MPouzvUQqo9AS+NqJlPkJnIKn9iOq+r8VXT?=
 =?us-ascii?Q?YBTw7bdRM//OcFTwqrvRmKlxi22DlEUE0Tg2a1prPwlMg9uXuBMCeYIkhpfk?=
 =?us-ascii?Q?l9Q3QmHUJlnyG6lK0uiHx7Dic5Kr4vHOIm0m5AcI6KxXcCU+Et/uxvStS0JH?=
 =?us-ascii?Q?3V6XU3zjj1eQpnOTobuB8SfnyTkFU0IHzACmuc+2nZzdUFI4RIaAxCwkN6d1?=
 =?us-ascii?Q?IPtEUXS3HD9PM2a6RfvQaenG1NpVie65fJFo868ZfJEUqmRJf4Od1ArZm/MV?=
 =?us-ascii?Q?G0qvBTVmEZD8q7aHDwSgqcdpgk2cglwntmDGBNEOyrFh/EGY1UD0x0/CjVQm?=
 =?us-ascii?Q?WsVk2v72GET8K+0iawbvIyLSzNT4/V65E6ier+/lOPjopjG5X6gfxOpOy/wc?=
 =?us-ascii?Q?bJd/ZZ9PCbGdyEkx3dboq1OEfkIEh+2mTYs/l22nCXBRGrKOtYVQpgNPexJ4?=
 =?us-ascii?Q?KyYk019H2vNr46KErK7jLQEdi9X2OMHbujONkPwYEFxxqUtvlvMy5EijDnmU?=
 =?us-ascii?Q?ftFUf3G4HHXUIx5VLYOXPeRevlWQyHSyzeEzNR0Cupy5Q54vrMBo0dUgDFwQ?=
 =?us-ascii?Q?MGOfDHSWKDbou8wPVD/+oPMURfKV7nrleVew88kphkBkK/sbt9zt3r0Iv7FA?=
 =?us-ascii?Q?4CX6LePApIhGc2IbL2xGWL3JnblRDAFiP0X5UcbtRa6+lO2SDu3pA7OdTnc8?=
 =?us-ascii?Q?+VaJ1BNPxEtrri9d6bXEYAliygURV1d9FlTl6u7JagFus0RykIbd4CU4LMz9?=
 =?us-ascii?Q?OL6bnssreglkRls28oIx/WuLyQrZM3VhZ7qby/KtI2s382yzsfDGKWGqKNT6?=
 =?us-ascii?Q?ZsSQSy9TniATlpcOFxn0E2x2KUMftUaUHhBjV2PnoWHAffZpzoVZMQKTrJr7?=
 =?us-ascii?Q?wbfVowFJOzm2rnBIUT845300HW1byZ2XBqI40GTbDoxrGHQKd14IQGeGwdoo?=
 =?us-ascii?Q?ntKADe+rBVUnYk2G4vd28vt4ngq8Pnahf1/STiONN3HgdLOxMRquwtEmsfZf?=
 =?us-ascii?Q?YhGA7yE8PSfr4UljkpKZ9aKfvlNiCVkIhhhd1auQ+sbW9LlFBUlUmGheYDtt?=
 =?us-ascii?Q?XVTuCt5TREky0Qo06g1Kh1jcYrXLRMZQtzFmlWKNVtaDuf4ulj6jMsMdP7Rv?=
 =?us-ascii?Q?gnnkhwl3A0lDKUwcRUFJ2Do3VqEvHshQJ/g7VBP+lh7pTUngiZga+WGVeWL/?=
 =?us-ascii?Q?AFil/1LazdIE1wLSxWOTMhQrD7ZwVH9QcePEUPoLyMLaxMbB5KyMIxwWkZ7w?=
 =?us-ascii?Q?xfjF0U8PrfuucmbNuEchg7Y4Ht7gEQ+YWHK8O7vsziQTOwC7M51/l+cIHvvt?=
 =?us-ascii?Q?pic/XlnN+GD8PkF1lj0FvhPhdNsl62TlDN1rsha0v6kfUJzRxyYPzPKHNzOS?=
 =?us-ascii?Q?Z+DqJio1mwY+qL+NYtowo/wBZUBArnuBIaNXSlCWn/uD11//2XXbKfZvBWd5?=
 =?us-ascii?Q?VbxDR2IrZXUnMi2l5kTjmLPZrD06RCxEgbrW8+k2aUWwOF1WqTlam3q/R2t0?=
 =?us-ascii?Q?WManMn9jMTLB+XkuSEGR+HUnQYdFK2hrKrrk2NZZw2PsA7Lx+WhW9bQvXUL/?=
 =?us-ascii?Q?IA4o9acs7dx3a0lF422sBUNA0EXc0K7qpd9u4Dy2wDolUnvdzOzdUmfNjtlR?=
 =?us-ascii?Q?iJWqzsfJsze4REtqKjcecXa8N+7x1XI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f689798e-5f0b-4619-0025-08da235f5550
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 06:22:38.9799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qs/HYYUYFEh2yit+fnTK1ySp9Bmzt0UOv3f28Dj2hdesefpvCQMpJPmGUqTp3c8J3t/YG1N4ziVXg9jJH2epOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8100

This patch adds a new sysctl, named scheduler, to support for selection
of different schedulers. Export mptcp_get_scheduler helper to get this
sysctl.

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
index b71d430ec868..bfa37f6b9063 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -596,6 +596,7 @@ int mptcp_is_checksum_enabled(const struct net *net);
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

