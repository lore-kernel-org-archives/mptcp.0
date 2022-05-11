Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8178E15B4
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 03:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652240446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dNw6Z2XuNa3NUByUXk4xw3jn5EgSKzAkowrNy+Viams=;
	b=Kw0q+6T6+fw6Y1VLpILm6XL4FIf6bcmMBIyHH5oP1QO3f9mlbeS4tnZHXD0KGCGptD6bpk
	61874iyqRSHMA56cuLMgOmyHWhO71vJ3uXakG8j6I1uLxGDodvmH1mdydgTqqdF3WuJIS9
	u11VDakhBC5GjJmvmkbHI8/hKZrcwP8=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-PowLNyJQMw-3wRr421Prdg-1; Wed, 11 May 2022 05:40:45 +0200
X-MC-Unique: PowLNyJQMw-3wRr421Prdg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgb4LMtYvMZrg9E/GBY7FPDaMhItfjoc6Gwz7VS8jUls2/4g5JJMhXw5TA8SUS8sSn7lR6DCpusiiYlimaMlZYrjUygmvPjWWvkTAkBjOqedOfcYdDqpW1yovcu+iC4nJYx+WdO9y+eGkg9UJ1F7dhFG+AM2DrCrHzYzDKSMskn6LLtd7Czq8Lg5Cub9AEn4ZufOoF7WOGoSXbMr2azpyzsm+aa691ZxSnPdfCT1VywJawvknMBju2KLOkhWq7eKpw3PFdJlG9Tu/gBbIHoKEN/d30QrgjvB6RGnV9RjIwWE9ZL8Dk6RbHclUmksjt7B3pGa6jf1hBCZmxydv+IMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgVHXz8c0FkJs+CAoq6vFRlqNbJHmy3lfrT7rz2d/ZQ=;
 b=a0xAeP+fteP5aB2Jjn/IUMrw9Tdh8WJSV8MKDElZSEYpATDYYrc0GvYpVij22hPiScS/lxbYlnS1SkgchpFT8V9loR1r0GJV6Nswg6jNurwklHXmSGDAIx6skJF35P1qBF2IzhmEJKHVwpQUkDYm/Lza1hOmCsxz5qE0qubz6VqOADc4+MYV1uryNJh8VGrQumFXexPJAG6uXucC70OgGMBJj5yR9fNMFQIrARzsWt/pwS+glCEGQPPEm5bM6Ql7rWFgRhhG0H6a/J3iZ9O4e+arZ7SXk/Ecg6KYZ4F/on4SkwRLSBvNIl3gMWpQEfs8Bo2xhmedw9VHtaDK4qsgaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Wed, 11 May
 2022 03:40:45 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 03:40:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 10/15] mptcp: add a new sysctl scheduler
Date: Wed, 11 May 2022 11:39:11 +0800
Message-ID: <67bab16d588d0a15a114a8a19ac6c6e8819cc6dc.1652239604.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652239604.git.geliang.tang@suse.com>
References: <cover.1652239604.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0058.apcprd04.prod.outlook.com
 (2603:1096:202:14::26) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7beeff4d-4e66-4bb9-7a0e-08da3300079d
X-MS-TrafficTypeDiagnostic: AM0PR04MB7156:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB71568230040EFE0227DBD281F8C89@AM0PR04MB7156.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OoprgtmNQSWCp4uTPW49b5ZWUf9CrK7+lxANWHCgfFRAGL87jyuIvSbpL8xrPiJYwU1eVCXLzw5yvQnocIBc82ZyhaKJQG82HrO6ZhZ36HF4oen9Ng6OgydXRhzwgYNQPwCh4qakP9SeQms2YkLDLyogSh0DrRTG6Fgkeo1oBTZ/Mzo0d3zhmocwLEtzTX+KJ99zi84Q6xShI0wmhybD+GtFPSPcd1Zcd5YzSpZjEdQPATnej8mMZitWdz4ukLSj3VVjiYoCrnQkCtv/w3YeoeXq9DtE11Kh57iZ+gEZxJuAbF3cdFxnlRybc3LQ5r7RLsAASP1tCJU4Hbkr2YRi888H56rGiT8BBhhF3cTkwiV5wJsMrAM3Et8djid86NR3n1OtVfDg7gEDw5HTk+ec0LtgMJqpVAMBDCTF3xRDV3NAoJLaSOXgdovs4Rbl8Ze4gXhU2FYx42cYthZ2P2efX32O2T0azcsZa7fFFxQbAthlZr+DppQkgQmKMayO88OzVxRltmtBQUoPZduSMBEaPfEMqEW8oHVGB276gtVEgFavseiQXB8226/219kYjkZibDQ44hePEWe+nwoJwS6YoQeO8hpYqVN9NZ9lucUJmVciFQdcmQTlpTcBEIHmLiCEQ4vizNix8WPNBhVeEU4oi9CfXa3rPRTKEFA/6MU6UyqVHFEnXHt7JhNxNEjvTI+cChV7VElO/uxGUJ3ha1qhNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(86362001)(5660300002)(4326008)(2616005)(6486002)(66476007)(8676002)(8936002)(6506007)(66556008)(38100700002)(6916009)(6666004)(66946007)(54906003)(316002)(508600001)(36756003)(2906002)(44832011)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GAI+DqQZguvmez46CCYeoKtsm6ZEEl+yGMKbekdZf51kYxg5rOxZWzi7E/Q2?=
 =?us-ascii?Q?6degOmxChtWP8Nt/n192O7B6pqmpasrZl5DeIqQNsUFfCTA1JiIxzQlzq9Fl?=
 =?us-ascii?Q?Otrnj/q6gfL6nj19z8D4Qk+6M9ycQktgfhatYtgnLsiYqQWe6JXaBl7y3Q0d?=
 =?us-ascii?Q?V1lMGVW9+mq21NuHgOj8wWgULCDr5lgK3tM1awJYtGeKnc4hQ7mgOHVMbvRQ?=
 =?us-ascii?Q?QVUwDmllcAmp5vcLRsqzuCY+JpqUMTpMlWPznNNIDrJcOCq3lxbMO8cp3k9c?=
 =?us-ascii?Q?eQpo/rUTU51Q5WqYWfIAo3BpfWFBsjQ/fNLrAzdc1TIsjBVz7UvW2xhrdXTi?=
 =?us-ascii?Q?9mLPRhHKHZflH0vYuu7DHfFfzzUVcdXUrQqpOrBGD2QYvbWuUvvI3RZCQHov?=
 =?us-ascii?Q?pPqrmdZ272pxS7+YGZP0duStvU43b7FtspK+7AXz0x6mN4iWv8Qemfr30MCd?=
 =?us-ascii?Q?W5RmoHGJq+dS8QMkS0jCqrPFZ1fDLWl4ZRPTCSwLK8yi20xzZSyEWsWq7WrH?=
 =?us-ascii?Q?k3H6HCGjO52RL/E6j33nNWnA4zhh3b+G6Ag/Xmx2/CJIf8lJs7/ysKBarX5B?=
 =?us-ascii?Q?nQO0WzmV7P1f2gfg68XtRZh9wGnYKWeM7QyhhSjVd6vzPhd0fxx0gJpsRJvg?=
 =?us-ascii?Q?7P6xNaJmHdvon8SdSRcaMjo6phMWbeRiuSh5G60tSuUXAfCUBRe+Nry9e3No?=
 =?us-ascii?Q?6gG+kuanhQA84hBNYSeYRQIOEKgOSuJLi4lTSI4hZjpi1ZQdg8M9i5o+O6HD?=
 =?us-ascii?Q?NmnuBRgizikZ9CYQq6C26RiEB4hbe94fzOtSVYiKATrVDc4thoRRDUkRlCGR?=
 =?us-ascii?Q?WtwNZLgwaZCtWgCkOFg0qr5plySVEf3i2KjEYk8MFBj2t0SnRMJcS/eVCLC1?=
 =?us-ascii?Q?ADPzCbHXHQi42MRhiGZZvw+wDo+1e5SPn8KTmW7DjxyOooTARz/wHGth37cq?=
 =?us-ascii?Q?AdIsF4hYy4CcUvTHjVrpko3TuRPzvTF3+2cNZXslMdthiF7lPE6Ct05k5BMh?=
 =?us-ascii?Q?OBZBt6VYy/b/7Pz96IxmlnptNxGCJdCGJ8FZzX9JFyMMFr8cEyaKrY/elcQM?=
 =?us-ascii?Q?Dr+2wHkMzKF+8Ga17wLOfw7EdDwsbAIZ6Yq0bwR6bBOdo2FCm4GL8bpbeL8r?=
 =?us-ascii?Q?+wwmBZgc93ZHKlEbKxHX4pth4rd74t85So3MgCO630XeVxmbND84Gi6c+j3X?=
 =?us-ascii?Q?Wx4UgHuE3UeyEekyLN8cCE1W+Z6bv/8pz1lYfEvnwao0CZQlZlknydl74USv?=
 =?us-ascii?Q?xrP37EDlU5T2GAvmaQv0GGk/cZIC004+OovLkuc4u0kVCJkpd0pWhpo/M+y1?=
 =?us-ascii?Q?R5OqCf9x7TCdd8uwmbNAdHXSGtpPqOd6d7+2LPhjTmaWVcQb9uwAfZbrOJF6?=
 =?us-ascii?Q?Z2soCjMlFHI6tMuORChWMkQcYMGL7xG6oh8IvEjn+9QwsmUEq3QmgqdxzqM7?=
 =?us-ascii?Q?49n6vrwn4QzMcCwEaDh920c+dTHhc2nx4CsTLoGF14jS8FTwJ1iTxTJi57En?=
 =?us-ascii?Q?TZBpNCnSfVfJaolYdZQMVdi+HFi81TVXT266mR4Aglpse1KdlmzlhcjU3OYC?=
 =?us-ascii?Q?ZQ9Iz1xXijmbYUAOEmi8q7c4ZC0bghG/BMNHMbN27dSvJXG+gkl+FRSOUOLT?=
 =?us-ascii?Q?cd+anvMKtV6KYYsE7C7arFgvC/4bn5mKAN9kNK0yYpP6og9kJkkK4Qct7GPn?=
 =?us-ascii?Q?t2Z1Ga2wX7rBZp6YNthpVeHUzjyOvRxSjWz/+ie2IwmKZgOXZ/DUiRzR+nlM?=
 =?us-ascii?Q?gziUdR8znAT9vl7to/wujvx4gfv9CeA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7beeff4d-4e66-4bb9-7a0e-08da3300079d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 03:40:44.9780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3BAKFqXD5yPF8ZoKQmFzIFzRYt0WdEMpdr2ySb/8E/QxBYdD6Dd5Tes9idmEa19z5N/ufKFrXusK0eX7j5bKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

This patch adds a new sysctl, named scheduler, to support for selection
of different schedulers. Export mptcp_get_scheduler helper to get this
sysctl.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
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
index 2f6c4486a009..b52cef5fdd9c 100644
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

