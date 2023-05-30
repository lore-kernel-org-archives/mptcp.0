Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54D2134C8
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:18:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7k07QBdtA+QvlcIwWHpkDX+RnPL/QxTTnUc6zXtIQHrBUmxnLiv/bzs3MOmAI5oN274+zPPcSW7vLAcU4monSb95D1vGF3TEaTQXxUuspb7seMTimir0n5nox948jbj3MYqt3aCtJ32KZbnNUs9HTEn5dl/HIot+INEfrnx+5GPbJQATiO4ome6LYTmanKqSpDj35t81lIxZJALmlO+YkxwYFVJMWhUfw/5Ij8N0BrEMdDMQDuXvX39PvlxYyW7GQ/s2Ku+8uFM/2h+4M8NLaSW+/5NmIa6YB6JQBlw5MDeupYnnYU+YLB5uj63DZL0jjmpHl4y0zw1HLd1uyNziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMPieQ2xwnkDCJSVmp0b8yrHG6xmnzhzmM/vOjw5gYo=;
 b=LI/nKkmubFVQiMcJc9dV3fLqhtLbL6SO1nt+tKeZIAvHZdiFXG0DMoLbO4ePZCWlhVkRGZuPcTd3P1vyS7jzTp97oNJe22HX8wGHkJshDnoboG85TdxJ/d/5mYJ3gMIESLitQA1k0mxwWhZ9+vSkvuB83EBe9gi3gItAeLA/qLrRkg707f6hQa7UJXvQl/jNStOHNZWyhuoTQxNrBLa5SdoUfBueLlDoo2FEChAzxOtrkb6OfB9FAVhIzsEc6R5osnagTvt74bPgi+14/U8vGB+IhqhMue5buYkw252XqZeI603LlTZHGJdsG6DpRkJB3EWBn21ksuIOOFnXcABk5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMPieQ2xwnkDCJSVmp0b8yrHG6xmnzhzmM/vOjw5gYo=;
 b=dO1guUILp3egxi/bTnnwXSio6g0cgGJGCfCKSj5tFnrXCNx4Xnbs8n5eONxMnL6VaU6Hr+wL9LI3waAS1MyVBTewHmdYaB1TGOrOLPAQXIb0EIUXLwRf3KMrQwIX5btfnk8fI6Cbn0LmJVYzLL4etqs3NQXbrbeAI26/u9ZRWiqS0cMIx20qorT2clDxTMrjccjF+iRgmnsTJmSt3awSz/fvNJdsDmDtqwY3sr7FDeqs9akrDfC5cI93kyqln9VYSNCLJuDCzUNSYxO/5pVqkJ7zjoSorRmDXJRjSIxiMcwiZRDXCMTWU0XqFdeO7VPPThjgdd5mvk4JbNav9YyP9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8622.eurprd04.prod.outlook.com (2603:10a6:102:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:18:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:18:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 05/15] mptcp: add snd_burst in sched_data
Date: Tue, 30 May 2023 21:17:25 +0800
Message-Id: <47615dee16ea4e7a8671259ead0047db962b861b.1685452619.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685452619.git.geliang.tang@suse.com>
References: <cover.1685452619.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0009.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8622:EE_
X-MS-Office365-Filtering-Correlation-Id: cf01c0eb-b902-46c4-8ac7-08db61105b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8HUmRUEfu0O30ZfbyjQC5/Hacm8NmW5Br8+H7W5mlf1NwvAn+giFE7lW+AFsq2ebszFWAnYzjn3/PuY4W/7tgCg1jsE/poHR1LfWYXSwNzlFJvJAh46F4ZHcjjdln8ih/JUAjBzO6PgPljmsH4svI1BUJmA1CwwL1O2RIAf4nuDPGLWfUrtoqmedVA91I2XRb/FJYSMPrCBCDEewj2Wa2fhm5KCEujcOmTIIlP1HmBqhd/FkQ0jc8N+ccAZ9YfzcRQ7kl8v6/+UQuX16HCYb9fqhlIGrVtB1AvdEenN80IoSyl7mTp2SW6crPWMY/ndDiHLmIuQOUA8KARANOL1ZTQ2unKSWEobLWVO3QaHEtdwz7qOCUajotDRPscHhByA78vhFyWYVSQiEPjhfEd1EoQyegZVajbwk3O37wfq8rCtLQ260qlVsNat9cUF5JmYffO92fm8L4dz+NBlx072kzMHubkTcbOj4RjEiDfikQraC2yKGYgD8Tji5w7nPs+AMYBaBIOqKgcJsz0LQJ1ZGV131pb/wQJxCsCmpV8h4q3MEvVhM2KT0TJAZXrjuZkG3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(396003)(39850400004)(376002)(451199021)(186003)(107886003)(2616005)(38100700002)(41300700001)(83380400001)(6506007)(6512007)(26005)(6486002)(6666004)(478600001)(4326008)(66556008)(66476007)(66946007)(6916009)(316002)(8936002)(8676002)(5660300002)(44832011)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HVO7ceuJFBaE2bOK9Ig+xnw8RTkCPRI1dVw0jb6PtELhScM/ClCLWqye6Mmz?=
 =?us-ascii?Q?Bw0e8jTyAk3LjddFlRyhRCIrm4Irw4Jl8nzO3+0ZR5+4DwmYmQX+At+JQFcX?=
 =?us-ascii?Q?PKOop6lmailjuPQhfxAC0XyInfJFfkkxvlSGMM07i0wOAzWNAPqdZNveXauZ?=
 =?us-ascii?Q?/N3ockv4/tzKBc/glGJUDePIePSdpedzbax0HDI+GTD6TbKZKn4RRNAjt5lO?=
 =?us-ascii?Q?KlJNcN+gGd2dR7IYl6sEYUVJXjc1o3p9fvpARV1TI39cu7TAfaU9o7V1zThs?=
 =?us-ascii?Q?BpkzCtSB9fkoHaFF58Hv5/tP/jQSnupwOJlL6g5vNTVmzM0Fp3gRszvzChDr?=
 =?us-ascii?Q?qYBGcxyls8YkKkCdjB90HfezqEAsxgQ/GnJSuiHejO3LDnX7TWR+5+zxFP+k?=
 =?us-ascii?Q?BUE3yhdXYtm280CYDfiXGD5wDaPDyQ2NEnuEqAuh1fcJhvEH2XwnDf8PXTU3?=
 =?us-ascii?Q?6LuGBErEM8G9g4fRb/z0km6wdyKkg71evzRcFBpRL2QwoFvvf0Q9SVXzBaBv?=
 =?us-ascii?Q?N6BdyPbmE3n1lCqI1i+/AXLtJ2IovAsdvJM8fY+7Ueb7rCgp8dcZCkQd9xAk?=
 =?us-ascii?Q?bk9lk8ita617Dhr9oJqvpiITf14lJDVfQ/ZV3pOBWj035kUa4tf/KBRdn3gY?=
 =?us-ascii?Q?O9/V8Ao3KbHfWZvSfzQfKRVP1XpIjSrKA8+TOBbU6cWtJhrPgQPV61MdxRZS?=
 =?us-ascii?Q?2pVDpdv65qrmMYDYZ/+z6BSEx4Rhpyjg2Ai3cRJ0x1AcOb8JMMHbO3WQ1VXP?=
 =?us-ascii?Q?6Hczeg6PqybYWpMqQRQVyz8xF4s6+NNN6yy8x7f5o23lbH9H0sjNNphoQChm?=
 =?us-ascii?Q?prDMPcaECBLygfT9KaLwIClOAID0OKUasGdBggmWEsKklYyfgylazlTTBo+K?=
 =?us-ascii?Q?GlZfcl7ykg7aPGBvaRbJAbOOHrozAWwirmWZOe+5M26Aj1fe0B0wJOuLWkbX?=
 =?us-ascii?Q?CAR2mUKRNWsp9GVyFxd8eFeBKlShXFwvADqF0RCFIMT0RDsSmQvzNDykGgWU?=
 =?us-ascii?Q?xrBh+LZ69+3qx2mB2+6zeXWFLtJnVKLMqlpI9QuIXhyZMmCApsEgPvjKBuPf?=
 =?us-ascii?Q?EjzKRm+YaHsSKU4nx3SmXpcjGlm+y0PKRc/YtqyMlruZwpnpPK4dCrGyY3JF?=
 =?us-ascii?Q?pMpTrDx0BmxRLSvdA5zemQlEZ9ecs7wARpZHgBE7JysdRLS4m6pKQsev3nhb?=
 =?us-ascii?Q?fUi48FJ86WavRhyApx/m+h4yOJf/TezTEsfPmV1GnY/Mn9p1zG46UiXkKqkD?=
 =?us-ascii?Q?4gWb7N3OPqpQ5qxN4kuWrJYipkOhkDkXFRZDaOo6gitEkrNri6kFFgzF/fAA?=
 =?us-ascii?Q?JN7ex0464caUiGhKuo5pve9IHNQElfv1oMcbTeXiNT/lnZs9itu4+6Ft1AiH?=
 =?us-ascii?Q?sdcvKslPnwW2HfsODOZGy61SSl6/PRsoPnRRr69VFg0nfWB9WBflLXoHzHRh?=
 =?us-ascii?Q?Qw3LeGJG0f6zzGTe62bBJ/PNUQxAOGATqJfpJbVj0XGEbyOTkuP8EBs8Wq+n?=
 =?us-ascii?Q?Bf3kYAKcDkKa5884vLYl/G9uMYMQZwn2i/mxAYalKqjHBypuv2uRRz2cxgMx?=
 =?us-ascii?Q?ZPlJAqirFLZDGwubud3uU9fNAwdtFIGpQ8x/Y+kD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf01c0eb-b902-46c4-8ac7-08db61105b89
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:18:28.9958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gv82dQD3aDeBIa7iV4YryYjn1Hg8/ZxhnQSV7xdmk2sF1gNdjmRgRMnjqRtcdd9xxMnWSbqDbtoxV9Q+94AiSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8622

This patch moves the member snd_burst from struct mptcp_sock to struct
mptcp_sched_data to make it accessible to bpf schedulers.

To make mptcp_subflow_get_send() adapt with MPTCP scheduler API, it's
necessary to make the msk parameter of it const. Also an new parameter
sched_data is needed.

With this change, msk->snd_burst should be replaced by
msk->sched_data->snd_burst.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/protocol.c | 11 ++++++-----
 net/mptcp/protocol.h |  4 ++--
 net/mptcp/sched.c    |  2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d52aeb8b4485..fb4e6a59afc8 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -101,6 +101,7 @@ struct mptcp_out_options {
 
 struct mptcp_sched_data {
 	struct sock	*last_snd;
+	int		snd_burst;
 	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 05a98ae09226..a178cd841d82 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1416,7 +1416,8 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
+				    struct mptcp_sched_data *data)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1486,7 +1487,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->snd_burst = burst;
+	data->snd_burst = burst;
 	return ssk;
 }
 
@@ -1504,7 +1505,7 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 
 	dfrag->already_sent += sent;
 
-	msk->snd_burst -= sent;
+	msk->sched_data->snd_burst -= sent;
 
 	snd_nxt_new += dfrag->already_sent;
 
@@ -1555,7 +1556,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-		if (msk->snd_burst <= 0 ||
+		if (msk->sched_data->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
 		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
 			err = copied;
@@ -2349,7 +2350,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	mptcp_data_unlock(sk);
 
 	msk->first_pending = rtx_head;
-	msk->snd_burst = 0;
+	msk->sched_data->snd_burst = 0;
 
 	/* be sure to clear the "sent status" on all re-injected fragments */
 	list_for_each_entry(cur, &msk->rtx_queue, list) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ce3be8eb68d6..37f5cb898b45 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -266,7 +266,6 @@ struct mptcp_sock {
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	int		rmem_fwd_alloc;
-	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
 						 * recovery related fields are under data_lock
@@ -660,7 +659,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
+				    struct mptcp_sched_data *data);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 5438a86e897a..a6210ec4ba5f 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -149,7 +149,7 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	if (!msk->sched) {
 		struct sock *ssk;
 
-		ssk = mptcp_subflow_get_send(msk);
+		ssk = mptcp_subflow_get_send(msk, msk->sched_data);
 		if (!ssk)
 			return -EINVAL;
 		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-- 
2.35.3

