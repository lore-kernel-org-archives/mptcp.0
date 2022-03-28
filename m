Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA787C
	for <mptcp@lists.linux.dev>; Mon, 28 Mar 2022 09:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648460304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fPrB6yogrCyWuPsHL1J1F7VvcBWI0liLJZj/j0V5SMI=;
	b=EaT+0HB0CEquhZ5Tk50AX/xx7lzWTEAsfosfObIJkLgXWuEspU7MbCTRTz7Qn3b5I/2xMA
	6R7zWa6n9YYuv5wMGVXUEMZ3KF/30pRkiz57jd9hiu/USArdM9PQHJCd/pFCLzlagoGTKx
	YXtCU+UmRCZSq9sOahBmvK4V3RSXScg=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2052.outbound.protection.outlook.com [104.47.9.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-vLStwb5qN_WpQgkX-cPKAg-1; Mon, 28 Mar 2022 11:38:23 +0200
X-MC-Unique: vLStwb5qN_WpQgkX-cPKAg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJ00QR7waCwBhRjhMsNJBRBRJoNLNh1M2gMxq/v5UReeM1xVOqtHM75pbBfW4CrhmMa4KYa+ueF9biq1ocT2Vhcncf2RsHlzvraZ70uJCZl14Wy4yileqPk7AqFO6goMwnmKUFQNhCbDr2dt1zCNZtbbTyfKksHgXddXkDRvPPWiSsB5US/7lvVGd2/f94uGtFHQv8rpHvpRvGhnRPRwtS4HYQf9qyWrYcjyJ+gHlNsFTfBiDIfZQgz1hUXX95HRljkbAU7/I782garsWtTG8raxpjpXrTW2iNymclhYmz3ZdkI64cGSVtXkEAID9/MPE1mjNYKtqo9OiZJ5U3i6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3batoZYvviKMA8nJY0rJvoR016zww+Mj2NP1dhJd8I=;
 b=mwP7kthQBfr/fsApWEcubByaVQFDoijF6gYDewrUze7rq3SVrLHUd5qjDXHgVgQrogFiVxFb7PcDNLKP5dzAakQnXmYpQ9r5IRnl/IFmxZ5O2nvTuEK33YhhAuLhPgU0rBVg63CRpw/7vFFBMWT/p9Q/SR8fAzwpjlzZp+qoFj6LKiWc0dH/lQwXW6ejF89W2JNInF/KIjH3ztbGqSlvubWKLhr3Wmh9vRWsza4kJq5AK4cwt9mVZG+C61FGhq1nvoSbtILz6XvFYTUud3TViYI8YgjomFY2B/QZ9+u7AGVWCA8rV27gGYb44Zi0OYrDjm9ZqPYeVXWmD2PKmxTZVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB5067.eurprd04.prod.outlook.com (2603:10a6:10:1a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 09:38:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 09:38:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 3/8] mptcp: add a new sysctl scheduler
Date: Mon, 28 Mar 2022 17:37:57 +0800
Message-ID: <1672f52dfd1ca08871554f6e934569e7d4fa9dcb.1648459865.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648459865.git.geliang.tang@suse.com>
References: <cover.1648459865.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14f369fa-825d-4cd5-47c0-08da109eb2ee
X-MS-TrafficTypeDiagnostic: DB7PR04MB5067:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB5067110E49DAD7AF5202FBE3F81D9@DB7PR04MB5067.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yq+jUzTNNmynlGPQLUzJPhho6EDYmaGAXj8Td64uZnGfi9v29jyE2ymwG48yTGeRyLHYhZ/l92C2vPspaM8ATX8Tfrr4epFqGYhe9no4nJ8YB93T544jFa1JZ9pxQvi7odC2+eFUGozlQbRlbSjZ/6AiBho7jZ+67BDyLNYfXXNkP1n4R+ZL6k1CW2I2o8/ve2etgPRS8dghCqQrnGUorUi8VvTShTD+Rb19CWRR8qKck4EqLxT489AwYFHJhkO0fXD3ggd4DddVWHqum8T6MHy4YNicYLHxcoGgV5qgfYUX7BfKyYNy1sj3o3ttfG6iJSWE5tXdXVb58ou9YQtFvzU6qIpVuW9WShUSbHPnqNtzAxvnR7qpqn+9dAFfmpumRYdx7baI8V9ug86PwVPjbK3s9OBbs8pjdsszFTQE8mN0fG8zAHxZS0y1xOoCGNoPfvyFf6Hoxr3iQPI6pxq+yDPM5KQsL7k7PPOWbpefPIZNVvpFRo65VRA0u45QiYWFgjhZ5FCfDUyWUlGVAgk3tG0/cZShIO5bnksCQ6fBWTiRfDMZ4bQJAZnKPWpV5QCP9SviUtuOdk3hWqKi5D6J8B/uLhwVUIbd0D79l1H5sl5/El8EYFKnXN78j1eXanPk6AtpuhITkw2dcJLY5RyBWlJ/Y0KOdWZBNtgbJCmxQJOq8QX7IFBbjbESN3oA9z2UISRWZvxPmKnteHR2uOx6qw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(66476007)(66556008)(38100700002)(66946007)(2906002)(8936002)(86362001)(316002)(44832011)(5660300002)(6486002)(8676002)(4326008)(6506007)(6512007)(508600001)(107886003)(2616005)(186003)(26005)(6666004)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vMWfIR0QgFKpSI5E4fJB0RtlE39OThEo93+6jMuSngxETpNxI6xV2HPwxrV3?=
 =?us-ascii?Q?fqjVmxemXCE+alXgKWHAQVElrrYFasQHwYLdPK9URZ/Rtu8+aWwiL4oupIOr?=
 =?us-ascii?Q?ZF4j/HDOw5EMIzQcEJugyiCGQlyaq15oaHrzLW/8Pg4h+iHzV4huWCGGIPSZ?=
 =?us-ascii?Q?oG6yuN7eReF8b31oO6wxLpWaKOJmVgPG+EtYAw6c4EYfipHRXNLuT/uGmyuX?=
 =?us-ascii?Q?4R0r/0f4Ms4NO7FbZdLAb+E3u0HLLbaKkwqJloxSPseucBCAZQJmorRHqyos?=
 =?us-ascii?Q?c/p6IqoQ2EvVfKm9+/CQmdjik4s3ZNEoA0BDGpXyLnJNLdJPScKm33eOJho7?=
 =?us-ascii?Q?S8+OOw+elO8uxISGNUPG2s3/bnVkrNNzuJBr61nLZJma9Jh/a+aa7IFHUE2a?=
 =?us-ascii?Q?Li4gq8GgZ+SQGJjDW6/Yv2Q2OiIr7wUchG25/7XbyOGQAliM/W2/onUiu1l5?=
 =?us-ascii?Q?NEwzea9U4NdRx+NjrgweIfFoqLtCuxU5/ehW7oshc6WVESRU/QN76vAaQIk8?=
 =?us-ascii?Q?SnLyRI/gc4zwWwqdjQo4ZzHomyveZiHddKiI5nS2xnKDBGvVUcit9HFPbXiq?=
 =?us-ascii?Q?wXLRcKmowz3fNKdRa/3ix+foCuoMlK6pImDLaM9cNwuKSiU1nXCwqViL76la?=
 =?us-ascii?Q?U++ILqeRyOkaQWqBvUhpwfqBLNiIQiCVeOwdewUkBa89QKh0cX0hBID3S8IC?=
 =?us-ascii?Q?HOsiqoIyyMaz8ndFXSOBnnEDEjKGjmJ/M4ib5N/K8WYeJGH9OHx4odDsZSGl?=
 =?us-ascii?Q?AB4TX9XOi7t4V6EsOPYB8BSxTnyXRzMLLhm+oXrCMpvH86EleSAIvV3SW5XR?=
 =?us-ascii?Q?smecSMGz1ko2D7v+zipnSF3fZ9KTA90Xtma8iTr/XRzJN/zZnKk0gb8GupXH?=
 =?us-ascii?Q?YNAbs4Zsufsw4f7I+f6SeKUtjvxUwtrRR/SJ+/qpDt8gV4yZ1SqGye3lO33f?=
 =?us-ascii?Q?wI/Kd2nwa0/23bIk64mgGaV1fVs578MyFTALYoZhK6WyB8aB8rM26Q48tuw2?=
 =?us-ascii?Q?S7gZSM6hpaDBReplE+mYyRaPvOAJtWMZ4NzTQmWNTz/hw03GFSs4FWEyKE3V?=
 =?us-ascii?Q?AV/1rxsm7ukVwscA9zd0K85F0T0Gap6zvkBiB8e5mQT9MOns95uqm2YU0hbn?=
 =?us-ascii?Q?XkpOnVE6XF3Zw7U/wCC/4r2egds2OJjXWTeV4Y8kY4PzYH/riNNLqIW0mKxp?=
 =?us-ascii?Q?Bb6dlryVI054xT/zSYk9pYbu0ik1SJwMB/ZYOe6UeZ4j3DIyjO6w1MbAeglY?=
 =?us-ascii?Q?FYPKzYhlqzy00t8UIzbFNODv38CD2ybsnYk0bLXvIAeijeVSJC475gYdIZTN?=
 =?us-ascii?Q?4CS72wC9dCGIkUNsjHIqrCxnzPmwdaAWLirkD4rRZDL/wUPoRbhgDOZfyD7q?=
 =?us-ascii?Q?I1lOp14/thIdpz6kjbVf3EwbSq1Ccy2Qhh46X3x7POBaVMuYuT/t3ddYluBI?=
 =?us-ascii?Q?h89QPSdkZ45Rwhcl3DceAZAYbhaecDCV/QdpBllpnqKinyM+A+JIeDOcI/bm?=
 =?us-ascii?Q?CJeDRvVzGL0TIlPD8ezJz4+tDmOnf6liSdhjXqmrchZqh3Zs7nneet0Y3Stn?=
 =?us-ascii?Q?YZY74pHtPXHquJGkTB6i0r7W4+sVw7GfdiR9v6uYNpz6OD0maWE6tSbx8qAH?=
 =?us-ascii?Q?PFAJeBbw8isrTzgoYhTEc6ch1bxmfp3am0PL0nr8UJP7D80xui3+hD3JpgrC?=
 =?us-ascii?Q?eZD+UjmXiNe6tERZDOe14jAtrihkM4SuZTkdVQWse878pn0R7CW6HEmca1fW?=
 =?us-ascii?Q?drZytq5guK5eI0wOqT64qi7eBQQhEYg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f369fa-825d-4cd5-47c0-08da109eb2ee
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 09:38:22.2308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSh6TdBrMzrJNXcY+oD4367Zm6FSsFPNrwOym4NgP0h6YIRWS47p9P/ko3M/4u1S+nZ81ei5d3s8tgK3JC8c4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5067

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
index 4c0a3c39e897..dd4a2afdb38b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -586,6 +586,7 @@ int mptcp_is_checksum_enabled(const struct net *net);
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

