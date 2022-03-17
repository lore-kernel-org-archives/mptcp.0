Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168292F38
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 11:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647515097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8mCTpTt5GMaNI4IT5rhV/RB8K3kk2qV1QJaBS4N1spE=;
	b=GDlqoAC5XFwC5cJEx+Ofpb2FRM1DvMK5cYbBDTz4nUIcBoheSBGBAbXvLgADfhhun5Ok0e
	EmdWWa1udd449WBor6WvS+NnYlVV2l4L0poDY9VPO9NCO3hDkT4fP80GiwFKKRLStXo8BF
	m87+5matgbysqaTS5AJRhNllndSEfk0=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-7p2pUvYWMMiBGyM_FIqQfg-2; Thu, 17 Mar 2022 12:04:55 +0100
X-MC-Unique: 7p2pUvYWMMiBGyM_FIqQfg-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5MdqInI1ANxSN8vul8Tga9nprB3lKgWCwTqJTLs4M9k6AMN1fVsuTedYVTkbjmewjUJIZSKwFW+KgcgQaTgaU+w4Zj7zdq1Wi797NO4CH8KjwloqPY352XUsvoiOzwgBTbvDaR4iTF6W9X6dOu7KqGUMFvajetZjTTb6Qj771mO27aJ7ak+HphZFKIXN6hGoYFC5pnmxVS4HwQOhOKFku/h0i2Z1Gq8YKigZ6TgQi0AV8LhaxNAJ+l7YxoqJrftd44Qd5lj0cr7qpNmBUydzliOKCnxEbB24hv84XgUShr/TnwjihmHN9nA86n3yDp3B9vP2li4oQJXR+gwJmsfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOaGNkiDFkW2us/y4FUYH259Tr4/9+TJSJvlDtxae/A=;
 b=dNMvykV2cO7i9r2zjIGeSyz8SnFAgCSdIViaRuMPqYA9LujVY/lPgU2PyIXbNIyWPr+dO8EV6lg3BmNjCYp9Oa+KK24wY/CzsQXC5EMIW5PFcqZRImunrb7H+4tTFeGUoonQRxQqz8mPEkDkNnEo8PcDEIXryMMx9g/J7QqBn8ISaEfrGLFkKwzVHNMCqA8nVRkZGmPjAmeOgJgN/vDFoL70RxVV1urDa59r2vGQS0OY8KSfsYoU19k3GEpK6/j+w5bzpi+g1kMqst+cFJNWX3dH8s5Fj8hlZ3iTKBSQ4TFCqrnfhX6sr4MFgSoQxzHpGST3kLB0dugrLZ8zrqtVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4462.eurprd04.prod.outlook.com (2603:10a6:803:65::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 11:04:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 11:04:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/5] mptcp: add a new sysctl scheduler
Date: Thu, 17 Mar 2022 19:04:42 +0800
Message-ID: <23bdbd0af9f498a2d6fd3964acd694ab5f7edb60.1647514852.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647514852.git.geliang.tang@suse.com>
References: <cover.1647514852.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0164.apcprd02.prod.outlook.com
 (2603:1096:201:1f::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d06e93dd-e65c-4ad9-3ed1-08da0805f764
X-MS-TrafficTypeDiagnostic: VI1PR04MB4462:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4462DC57C759E840FEB51AE2F8129@VI1PR04MB4462.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x+/vazowaE1vawpmq6v9uGx/rHKsgC0z6v0Ns89fSADm+rh5zTsBBSB9iCO5YUi6ONUG17hJCrfkezt8jDSoaXT7kDahbEkG11+W/GV/SYW+t5dV4cX2pseXPWDF5C3jhdyB7R8sS8MjhVEm+yUiSzvcMDNeVTgVO2/GBMcJeByX5uBlMysHeAhP9uFCm3pQIEAnCdNlINJD8CTKdKQ+t427AebZU6kpycosSg2dkIxSm0zy5TYHx5GC1UMEWQM2WcEWlsuVyUbl7bHv6MHg9VhNL97DcFFuC9VqMYpL85QhLgQrKLQMEvTLaShrAR9rZlkdR24DApq3BvDi2rIJdGxs84oVz3O2EN7oO54wv5FnHAJtldCSkBx/XtaxJRYuNulMNHd0+p1e7GjYGfJQ3sEHv1yrTKVwjr+emF1tzQtTETfIbtdriJGR3Au0WZ0liksnNt7L5HO+7JG14VkNCpB6Y9d+klqAogzspCBa4VRIyGfZJnyy6OPuQm7h81kaK9aQFjM8Ql34O9jJDR5vlBVtdg9q9X1puWuqY4dGSnyhGBxkXPEZ9xfK6Gn/fSC7xpRq9DwhoyYEVo98WNr6ouY8wShyNjpSf/4oNNwLG9brSqn2bOty8KoOfV1z0LEx2zpSsTdvDti4MuQopARmgk7pKkxWjU+J+ZE68qJrpEYwH+qbcUOaps/1t2auAxsw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(6666004)(4326008)(36756003)(2906002)(5660300002)(107886003)(508600001)(8936002)(66946007)(66556008)(66476007)(6506007)(44832011)(38100700002)(86362001)(26005)(186003)(316002)(6512007)(6916009)(2616005)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H7Heez3frd/QKRaow4GvJwVcb+rjI1zZU4Rh45F+8ixBQB9NRd39VeZSMNsL?=
 =?us-ascii?Q?pjTBJuhA4KeiBj2Bz5VKfr6LAGEwuZYdawpIT+0T+A6r0V85tu91xBuAKC3A?=
 =?us-ascii?Q?NdKqD63ejM9prgWCPNTfDJYXxRnW5TvlTqqWtb/Qs//rhHh0ahuDwl5hH4qL?=
 =?us-ascii?Q?ZVs6CNfencEG2tBCUAJgsTsyPa5mUzCTBiVLoUef35sjtJqxHd5xsrD955y4?=
 =?us-ascii?Q?Ku2PbsCeL1uA3hHreaP4xvTPWflz/I6WuUuIKYH7pcFp8YInh4wQBR1OkDYU?=
 =?us-ascii?Q?7TucNk8EErKdDejM2N/q3mvVJ6uXEhsErETK4FdEf1MBt8JNkkQqhLVuTsEL?=
 =?us-ascii?Q?X/Cvo3OZ25OWzcUzUmXyeARpx62nRFtyB1C0bzgZn7PrPlCRfdmapfI8y/hs?=
 =?us-ascii?Q?Yiay5msVrdtA81qESkbOCa5a3fhUqPeHfpdn1/FIfBy6R9UUNw5llOo3sjn/?=
 =?us-ascii?Q?+EeekLU6V8aT+pqE/IvIN2pm7wDg/CvNtksKJUoDYDSMbont58x1uXBWJAd6?=
 =?us-ascii?Q?Xy9lmn9ONfMyXNm06WZmEJYhgBl4+IEPs2XXj5+yPP3XAhPJCg0bV6dtFR2E?=
 =?us-ascii?Q?VYtXBAHizy8v9RashwujsBT9+QgGfSdrF7DttcGBSSavFJ7XFyOkI6KtQt2I?=
 =?us-ascii?Q?hq62vcGyiEEUHFqxr0cGHi1OuZq4qp6OqppKI2Kijby8TwYCW1mAugLrGgi3?=
 =?us-ascii?Q?Vmz5veQkXtPl5ZAXBebb7X4bqOcdk/p1N/UwFRRpAh+JWXWhhAqNSpt2/nUN?=
 =?us-ascii?Q?uZORY1eFHMBZ0Gp/CFv99nlsGmBLaeqDoyOB0YF2avxid+ujqXijtvJYp4g2?=
 =?us-ascii?Q?AmevHrPecBntY2LEkYk/WPY4RkOveibb9XcQ9zR4xeU67ukEvqlQ7BsAEKxD?=
 =?us-ascii?Q?Xq4VivfWNocWXtZCqDvDTy4w0X01HsXZZbWcbeApTr3ZPjaPHf6qdXkf6iQd?=
 =?us-ascii?Q?6JP6bzcRRo8xtGmehb+a3FjA3NTsCOjwD3dE6hO2BG91AS0FBDb+XBXHopna?=
 =?us-ascii?Q?aAc+tH6m5EEwLitOVAny6JnlaaPgnh/0bWRJ71uE0AJ+uvpHbnonzKadmHp3?=
 =?us-ascii?Q?TIipM35eWtYSbci1qecDWk9gQrajHs1smqxFTAFldSHW5VugSRpjLjT7SUZ4?=
 =?us-ascii?Q?7u8xTIl9P9uLcsJ3+yoO7DvO0ueb1fjPzYylj2G5tYat/zSYQhl5swTbjEvl?=
 =?us-ascii?Q?d1eNXixytlryEP2ilsWGZSVZZrStblSbF6mj/MQ2e7CUmxAQtWHcOj1OmN+G?=
 =?us-ascii?Q?QoctmU2Cg0Kx/7M/292dsrYyGScpWKxd9/eNMh0OcutuxVF3LpG6kVqxdmFO?=
 =?us-ascii?Q?p9ZMJhAICyZvUj2WlKthTxibh0S+wG7LZcsosbYVBTbKOhKR13wsE0XFogkK?=
 =?us-ascii?Q?xWpUNN1ILGPAvWxbqpA9Xh9lJ8G4IKse6Y73zU1bvZL7CM7HwFXOpjkVK6Oy?=
 =?us-ascii?Q?AYNoQ4QjzG9WJZeruETBWN4iq9UOmJUycJUdZKFwSib4c3csOGxRPA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06e93dd-e65c-4ad9-3ed1-08da0805f764
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 11:04:54.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sag9F9cm3IsYd7xRgjqvyYvOeWYV68yj3QfWEod/zDZhtceStQ6e1+bORZfEeJBTKc6C2HFcirlQfaEMi7gj3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4462

This patch added a new sysctl, named scheduler, to support for selection
of different schedulers.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 Documentation/networking/mptcp-sysctl.rst |  8 ++++++++
 include/net/mptcp.h                       |  2 ++
 net/mptcp/ctrl.c                          | 14 ++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 4 files changed, 25 insertions(+)

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
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 8b1afd6f5cc4..2dde95412fc3 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -284,4 +284,6 @@ static inline int mptcpv6_init(void) { return 0; }
 static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
 #endif
=20
+#define MPTCP_SCHED_NAME_MAX 16
+
 #endif /* __NET_MPTCP_H */
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index ae20b7d92e28..4e0811969d8c 100644
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
+char *mptcp_get_scheduler(struct net *net)
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
index c8bada4537e2..c36b9c40c314 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -583,6 +583,7 @@ int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 int mptcp_get_pm_type(const struct net *net);
+char *mptcp_get_scheduler(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow=
,
 				     struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
--=20
2.34.1

