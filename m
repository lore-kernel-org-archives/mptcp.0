Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196497FA
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 02:23:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aarn3j5CWWEbLGulCjx2ylas6dj6J1cSNM4aJRTC6JaUKBggJW4DrGCbCi5T17mgFpnTfyBihoMBvYyfm2GHtP+HSWqbmHs3xJvVlRXBnSyIhu35JPyppXxQ/tEWjGQft72U/u1SFxdkfjWVZUMa2UJN0bRFv+gxLjVEshA/U6ptFQ911jHOMzGN0PT63Tb4cXt/i0Ie8Q3iFkxVnBJOvB+kJDZL0Wj5KhJwF7ib7+4JYYx+GCnhbqbj05kXkTZO6jAiRM6abr0KPuW5Ifju5Bc5HxneSTHK//GqPyshJkh6WABYOuqBENMqc6LuZ2WwAjuNPsNlLSz8BmWWKmo97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMuiez9ufG/+XvLADX8WSR/KEeQqiLIA21v17pE6eyQ=;
 b=B80pS/wCjIMkGS+GNh0ftdCV0e0CImj5zaXgxomisAWOiU91cv99QPxbu1GdJBjqcd0oL3VloTj+msdJPeRKk+iyynMBhhiRR3OwBrr+kq1g0VN73LlbnMfnXJipiLAjWzYKAGA1P7V8V8tYjHZaHwfilxoaZnqFjyrz7z0e6v3FdBQcATOJkCE2eYTg12YK+pUOGHwqGwBjvaxLfCikBeNplln3LOVzTppjD4sWPqzmMCWmJOAwm1HQE6DECLWniSRgSEmyvQVr1jJiFQysRwYSO/qctrakz10NivjX0iQTwSboK4XSCyB1e5Zed434wRY4aiopPx6VPvsDEtTIHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMuiez9ufG/+XvLADX8WSR/KEeQqiLIA21v17pE6eyQ=;
 b=EmlOEqQFhjNCX+aGx8kiBt/B+fAW0GdZ3lXTABYQ2ud/OOaen0mHR5ISQdrfx1MUEOnVkkkEB691wz8Etzqf2wUsNLOUyy4Em9q+dLjv+9tNdOtfDGYDTh2955+ollOQ+p6HEP5U0ZgNOOmMudyVSRiGKGfHNpOJSZwvOndVKtOrUmx1Y0DU4syZhyYztyUmbUqRG0rYsQMF4SyJqgf5UngabIbHSBmBDRE/SAciYDXKSmpfW7xDpwYnQ8ZMpRJ1itOp5fB467FDeBntv+mfu9pdZi2aaT/RxkmZJ4sJjI7hhrVM6bZEXtCkWUXxOegax3HXBXkJ7kBWLgu6Opzpcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7088.eurprd04.prod.outlook.com (2603:10a6:800:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 02:23:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 02:23:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 03/13] Squash to "mptcp: add sched_data_set_contexts helper"
Date: Mon, 26 Jun 2023 10:23:04 +0800
Message-Id: <0f2269a4f66fb09978d8bd190c163cabbf7e05c8.1687746021.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687746021.git.geliang.tang@suse.com>
References: <cover.1687746021.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d9c355-af46-4323-2d1e-08db75ec5801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ptG3LhjKP2B1laUldSgA1UoEOHzXGnhgJ/PWm9+lgkOA28y5iqtQnUgKTrU7XT3PV66955Bwn6bnbcheQ+9XpRujYgwbdIbUhQATmVwRWf1IN/0mW6KeMfKhRHQ6zUsSL8CgTOQJI4Z+IsF/MedYv4XcX63SwGTtwdF5F3lOSHJwHsb1Yn2wXo6mwgaGiGb1jv5+OzB92elqbwghUnkbpv6/6yyTQc4dv//uOlxuDwAfEiQvUWrFOGxBu+PrMjGk71bw/LAWXYsJVcw+pPzLV5VKqcGoz0jhc78w2gXExHxsHJLpfVLqBAPfNG1/3HYN0CTFNc5AsZjYbAZ+OsjsmTZFDSa+pKNZGuXd4uGeDZX4GcxyU2EtBvuXZfiVBj6lUjwwpTLmIn64GF9+saiv0Lv5PEx+GoHSTVY3pYUmh6GFmnz8mPHTqgAK1dXeFBpSCIUllkOeJtoyYOSaMqVWkUykQWizLxPSqPHPXliDXOuHTNN8O0/6DRCM9fP9eet5DH65pAZJNAknIOX6tXiIImJECBPfWy24228hHWQpXJunhrXINADgYll3Aw3OJuSR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(6666004)(6486002)(478600001)(2616005)(86362001)(66476007)(107886003)(186003)(26005)(6506007)(2906002)(6512007)(6916009)(36756003)(4326008)(316002)(66556008)(66946007)(5660300002)(38100700002)(8936002)(44832011)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AANV/Z+8P50D8qF3UvDlK5bGxmEl6WSucqGm2aL9lu38ZhVRH9QpfBdMiFP4?=
 =?us-ascii?Q?+AHNlRjt94VGCkLzHCyuRxc6fALNMBY/tll4/amt52+CwtIIskXecKtqz4Z/?=
 =?us-ascii?Q?BK3KF9WIcdYn1L3MksYftHFQ0uBPDLYwNRHPCRasrGebW6F0F3a8w0RiU6Vd?=
 =?us-ascii?Q?+zY0G/9jZvB9gLEMoFxzcslMtMLVALiILHmZK/hRMobeKrFgwJC4WQACabNl?=
 =?us-ascii?Q?5kOlYHM34t6lzFJNxmkhr4cl7uKseQsa3im2GiZb2A4zqUMGVw7DCuJ71aO3?=
 =?us-ascii?Q?37ffwyj58qgcbTHTq5YLnnIkISR0sMNJkc98lXlB3rjACI8xOsZuochglxdI?=
 =?us-ascii?Q?WkKaTx1QAlR+fGDKvdGEn/84gUYJ/Tit4MeoSxXao1SZFvSJ27XUdxdFkeln?=
 =?us-ascii?Q?CJeBJ8g7tqmiIXH4wPcZFGOt2bi91t5vg1B3k9PAyCV7+DA1Vn5GKzWbYpR2?=
 =?us-ascii?Q?RMUPYpeCUymX3lXD+A8Hs1Q7OpD/ONVx08qcpdblXmPgLIeCK/uuuCLkEi3e?=
 =?us-ascii?Q?OBOE5La4w42jA31zh9/4FcUpy07E+hQGtZDGwymN+JW1xwtEUIqoE4taTPmV?=
 =?us-ascii?Q?51W+SnMKvcr6xtYrzlG3j+2kWTn7z9lxI5iIIMMByBcP7NwRvbRfWoNfcsKd?=
 =?us-ascii?Q?TXoX24b1xv4zY7txd12XKfvrMOz+N9G6WT1o4VR86w8xJ63Or7/rtOi9px6I?=
 =?us-ascii?Q?4pZACavka6q7ZNs9HSQ596B7LfWMQ8EAPXP6OrCD2rvO34xWSo99fM/6pT17?=
 =?us-ascii?Q?jS00K4YHjL9KAcwkqpvPQspJT9OC/L1CjeBeD1hfcA1eyymh8uzHFTqH2xti?=
 =?us-ascii?Q?gXkq308Cg64OWJ4c9CTYAPjIdiGwOchn75ep1j3xh5ilXqDj5xFrDrOOb5CS?=
 =?us-ascii?Q?SMbGBVgKtlrauaDsETOUTfnsBs3JNN3ax7/vv96uWwt1q3bNrbFBucDeBMo3?=
 =?us-ascii?Q?g1Z6R+v/usDVSPLHC/iQxLPQdQXBgdgBgLZ5gScPhlziQVLt084bm+JqCci+?=
 =?us-ascii?Q?7ShklHRq1MS8cv/4YqQDWMSZt+E3iinGJ2NWvzNsHazB/CYNHb4enk4j0nbt?=
 =?us-ascii?Q?rO7iCQHiTAZMd4LYUzRftLtxlUomK2p5Xct55UKL1wwesxmF+DqPxbw6+kl4?=
 =?us-ascii?Q?etLIoHn65sHlBE+eFTswfmAoq+qhmv/Z6T0F66VQGDpLSYNM3GuDQa+xiOm9?=
 =?us-ascii?Q?3vmknSeN80cvz7yY1vniidU4ueEAEimXj+XDVvp4s0Ee0VKsOB0IbPR95r0x?=
 =?us-ascii?Q?LfBIvbOpOVn9UjQpwqaPYGBywQPkOqGKUsk7DkbqZDK0mXH5rgUPZwIzv5vl?=
 =?us-ascii?Q?RXBdEkyfpWAol0gSDDddXO8Hu1YhEclAwn7NzQT0w38jCNlTE+iGDzgzSJeZ?=
 =?us-ascii?Q?0HFG+XP+vAGjKlOJsWCgxKgDSTHVVvaQSLFULjwekgZZ9gYtm9LXWLfpIBQ6?=
 =?us-ascii?Q?KlEphBSxtDUC4st2LgBhaSsAk8jeoeFsFSzyNxjBSMYa41UzvWD+LKc4Z23g?=
 =?us-ascii?Q?okAn90ntmF0sds1Zrla+uE48aS9OFHdVJR9BwR2FnVr1n44lFlUlBoI7Jzra?=
 =?us-ascii?Q?//qYGnunB6wZAtLoG4bcVh607LWrQE5z/jwCwvA2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d9c355-af46-4323-2d1e-08db75ec5801
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 02:23:35.3325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIsCk8VpCutO6z/D3wBgEuuWFyxV6eWo6GsC1oGeKnu7M0+A5X8ZGTzPo4mCV2IuxpTb/QSrt+kRjOTcbJMyiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7088

mptcp: add sched_data helpers

Add a new helper mptcp_sched_data_set_contexts() to set the subflow
pointers array in struct mptcp_sched_data. Add a new helper
mptcp_subflow_ctx_by_pos() to get the given pos subflow from the
contexts array in struct mptcp_sched_data. They will be invoked by
the BPF schedulers to export the subflow pointers to the BPF contexts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h | 2 ++
 net/mptcp/sched.c    | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8c9b2a03dc94..cb2f34c8ed09 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -664,6 +664,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
+struct mptcp_subflow_context *
+mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c7c167e48d72..82665263bb94 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -108,11 +108,20 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 		mptcp_subflow_set_scheduled(subflow, false);
 		data->contexts[i++] = subflow;
 	}
+	data->subflows = i;
 
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 }
 
+struct mptcp_subflow_context *
+mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
+{
+	if (pos >= MPTCP_SUBFLOWS_MAX)
+		return NULL;
+	return data->contexts[pos];
+}
+
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-- 
2.35.3

