Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704DA46B6
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 05:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naeu1fvMDvhMUJS3/srajZBKFHdw4U4DmqCQiDZeYa/Wy2GohBg2arTnPpkrA0vxUUCz/pZWEZzibMZF19qdVjyg4QKh+fEfPKwvCd6SK8BiAN3iNRjpnijJND8R2Q/0n2+O+0AnhZ0jueMuYJ6oPiZC4KGJoW+qmIv23ZWWx3LKxOogfrGCb+OqZxej9XzA4npOvfWk3AB4+jrbAHQd4+D6xewyPJwlugO4A2ahdWN4vTbrY5+Dtxj25oLM8XfJjUrYx1YjHqFV/6JK/6ubKPlg9PayqAgI/YF3GV6Zq2iBly+Fs1ZkUhkwF49K0O7h/h38r9pcEtcxKPocjHKbug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDqKqJclSMOtIZ+UWw+IZRlVKeUIT5cJ6f79gHkjK0I=;
 b=TnqyrXcFKf+pqeC+KueQ0zaZzkyBZ8P1rppKu+7cXl/7S9Q7j0SIJllLfXAe/SWIDeohnJADyHhcosDJX/vN3brO5cB/OfZcAjnIq9UVzt5bT6p3mAnQ0w0KqgaHJBbSrEReaXvfCHON4PMqzLRIq0ALg33Qm+Z6yF/R9KQgSCcevtJzzuTcKocITFyxyj6nECreD5ogiVa5bQF5sAwF1r6QXiCxk4j4hZPbs5ul/2WTMNc0REdQu94bKAGH/loy1+V1EKsZywC2hQ3uxRRClHRf/cryGPJJKUkoTUIPETJFZugECred72O7+ZEqS4BPaJjVodvUp3U4sQyDzV4lew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDqKqJclSMOtIZ+UWw+IZRlVKeUIT5cJ6f79gHkjK0I=;
 b=gWY6dBDdpus23HMR5OUMR6Sb5F1MIvdXkuLCNc1aB0n+uuwtzLDOKlTeNSnKK0OQqKQi6OBqWeXz5ZRNoIK0zfOizuA8dN3SHgODrRH1ubYah4gqP5yD5SkL4EbvFtZEewbdA1T66RMt7UcEjnSyPZ6uaXdJ+gUSYStRX7f3DmUPT8ySIb/f6josOKP7ZX52kc0PRN5cKkW5C7Rierzr3zaRrg2TKPhFFY/i8x9PSYpVOKaNsHZDmMRtP4DELnwqkWjUWbrSNbprvMoTfSmeNtZZyFSNJWSO4/Nto7WbjE5CMi/V5Nb928L5t7cEFRruKuWN4fHmb4/Z5bQczWx59g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8609.eurprd04.prod.outlook.com (2603:10a6:20b:424::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 05:48:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 05:48:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 05/17] mptcp: add snd_burst in sched_data
Date: Thu,  8 Jun 2023 13:46:43 +0800
Message-Id: <3305962d70df98ed07aaf95e60c1b086eb7d1bc5.1686202841.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686202841.git.geliang.tang@suse.com>
References: <cover.1686202841.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 53182761-f32d-44c7-9ef5-08db67e3f600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	92IcvXYVYLpjkkTW3MEyJzWXZpfzY0kky5nLE+7UrQrT+JEdVySuc6RSQ9Iit4msjolLRW0RIFKsVnLWyu5E+kM6DcT2t2dEWMVCPJn6kV5xqRV1Dj94pmn92dYWjrRqA5htYGaQg6ImWnSh5sMMysRG8CQCcJxoxrcpmfxJA+KMZVTpoFd+JTLSeobZk3BN3A9ZPz0NsLFNzS04keQ0jyrmggoDgtZsAnx3QGnpLjj/VcqJ53WLzwWkaKG8/LrQZ9A8vnzn7kqmHAhNuuHOZBfsuwbPK7NdB9SbuFNeSmmoRCPlbKj2fLrwoOLSRCvMzP6YVgYPjsUPLw01i5Qt2jkbtenfDffWJXuJqcCfRS9ivA+w+ZuWhSP3LCyIrnKW738duTctE3/pd698+lE3eA4P+VUSq3PB1T4md3XdZouXNAqd1txYxUykhhFDlycjrD1bI5oH1HDf1B3ajpUKDzKjI9hrfG6goXDdNjRH752Lr6gMoNBohNcyL55saqi1POPr0hZyXDnxeL3qb7YLtQjAFC6ze45vwy+0q33L7JE5GYxI4W02srYMn+YzK4VM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(66476007)(66946007)(66556008)(8676002)(8936002)(36756003)(5660300002)(6666004)(4326008)(6916009)(478600001)(41300700001)(316002)(6486002)(38100700002)(186003)(26005)(44832011)(107886003)(6512007)(6506007)(83380400001)(2616005)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GBu9ou64Yylch4s3SPWiEp9mKX59akc3LKhBHDaRLL93LimF2ybr2wd0Q7aO?=
 =?us-ascii?Q?9PGFdfIf64Ayk7ZZM+82YroPRZ6dD9MnEMkL09cRdtwOnTKoeIKJLzuHki2y?=
 =?us-ascii?Q?CqGtaPlKOrIF+C0WQ7A8flh+uH8YDXnxfWc/baX2miJ9Q9mIW1HWUniKTd6n?=
 =?us-ascii?Q?ryb9cbGkAZrFaFUsiKe72sQeuPZ8V1xB8kO74f8CBX1Eh1EEEG4rBpsL1kwu?=
 =?us-ascii?Q?8/6KCmSAWHAqGBz8kRPQ4WWvmK6AOQ324jFzFKzvRYYKGYvxc2fJfLAgoKyX?=
 =?us-ascii?Q?T2fFFK7/pl61OPPZ7z2y5DwUfVWbYEnAHCaS4iqSBjpxdGvjRWcHM+rycm0l?=
 =?us-ascii?Q?1Y49MGnA2qunt67cZcRldHISGIEWWtQJFvTUimmYf2CeBpkfm0CYHfxwAGY+?=
 =?us-ascii?Q?KEuCGAPel8J1HghfIw2DvNNM12si3TaLiIKA6WuKlJyiRacv50Y99/Pp+tGT?=
 =?us-ascii?Q?+j5SueD68kfW8+mhnsf776nZjKOAqG9Us5iYO0p7qUij4H1EydUYxWeLYeLj?=
 =?us-ascii?Q?GVGWp18Bo+QF/CbaXrOP5SOeKB4hn+IvjA6tn/coFIDOK3SdBbvDdrEFFoGk?=
 =?us-ascii?Q?KSTViCHdqbc02mgf/nklcF464UctOfYsbeCaQHqUSD0gw3C/Wv2sveuPMRjq?=
 =?us-ascii?Q?SYHapvWJnNACjTvD7qViQcSaYq/aP1zengmgFA85FLeTxu6yI7vj3B/zXmhJ?=
 =?us-ascii?Q?SRmYoG8q9On6XmJN/K83pXle5QaaDuN8cf7MHMg9dee9uMX92arQolF0B4Ki?=
 =?us-ascii?Q?wfzy0tMmg4r6/m6Mjya+XFwjfbfFKPk2Panyh8STQSqDO69DfXbu+OiBdDxq?=
 =?us-ascii?Q?GNOCYjJzgKlb7hVsOjvdKzy2rzxLZYuYlL9SvA299wjfdAGxbq+UyUH8+S28?=
 =?us-ascii?Q?u29h7V9vEOTkzZfw3IV/Q37JcymfdK/MubUIkKIIblCvcrHZ2V5kqsPeic16?=
 =?us-ascii?Q?N/bqRz4AGdhj/hseIHikBUKfPb+KmWVEY/qbtk6y6sH0lYC6frwe1iNVQuVx?=
 =?us-ascii?Q?DuCfZBP5ObEYgsiUiJGlUQDZ0WM0Js5Bf2wUtbQv69agkzCjLgNFnzp0obgH?=
 =?us-ascii?Q?LYaciV4Ap3wOxcZGHgs74vVvB8+pTCumJL511YTSxRrj+FCVoeeK4I6SPjUv?=
 =?us-ascii?Q?1UBaRcoxygHZG5AN5Zjj8Dqm2WvRO5Mw2N4HFEMj6jTsg/6wOTzGG5oBdvuG?=
 =?us-ascii?Q?fw3jyU4Pu4bMOyo1QKcLma/ztgkrV7iW09DZgFojCGFTTI3rSysxIRDtruPA?=
 =?us-ascii?Q?dSJydkLnnlHV/OMMyR9M3/M0iPZuUHb1hQauDv/BwErxph/mp1ffEPij5AvR?=
 =?us-ascii?Q?HDU4lPnGlaHr6v2Z+s9aPmxrxnGbVug1/wVBXTdcNRh5PoIVgUGDcN/Ibj72?=
 =?us-ascii?Q?e+cl/cGoJLz4A/moWWm4N/qFZJReixMoSpf/psQI5lePppolWonecHxWguKE?=
 =?us-ascii?Q?6gclIHPrQtbtnfzQiIow564XJ4ac7MBaclFW0ibyJJf22D/McAlIRecX1bzr?=
 =?us-ascii?Q?sHFs9suyz9OI8wq15kxHZPfk1MnWC+54jLGB+bn9Dm54HDtyV6liJSPwRVSj?=
 =?us-ascii?Q?8zzekcX6HiSL+H+tPv/KlpRtzCTSTF3APZmDrNTX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53182761-f32d-44c7-9ef5-08db67e3f600
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 05:48:18.8744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GevkbV457d2DYJwofWid+HIQ0zzmzN9M+EfivwQ8d8U0c7fHju/rD8NGAsgeED7lLIr32edHKPdYCuJ+KfyWiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8609

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
index c52f0eb8c261..81171d9f4aa3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1414,7 +1414,8 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
+				    struct mptcp_sched_data *data)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1484,7 +1485,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->snd_burst = burst;
+	data->snd_burst = burst;
 	return ssk;
 }
 
@@ -1502,7 +1503,7 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 
 	dfrag->already_sent += sent;
 
-	msk->snd_burst -= sent;
+	msk->sched_data.snd_burst -= sent;
 
 	snd_nxt_new += dfrag->already_sent;
 
@@ -1555,7 +1556,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-		if (msk->snd_burst <= 0 ||
+		if (msk->sched_data.snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
 		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
 			err = copied;
@@ -2352,7 +2353,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	mptcp_data_unlock(sk);
 
 	msk->first_pending = rtx_head;
-	msk->snd_burst = 0;
+	msk->sched_data.snd_burst = 0;
 
 	/* be sure to clear the "sent status" on all re-injected fragments */
 	list_for_each_entry(cur, &msk->rtx_queue, list) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 65a22959d645..7d22f35a0ae4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -269,7 +269,6 @@ struct mptcp_sock {
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
 	int		rmem_fwd_alloc;
-	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
 						 * recovery related fields are under data_lock
@@ -667,7 +666,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
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
index dd182078f035..6ff4666a59c8 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -140,7 +140,7 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	if (!msk->sched) {
 		struct sock *ssk;
 
-		ssk = mptcp_subflow_get_send(msk);
+		ssk = mptcp_subflow_get_send(msk, &msk->sched_data);
 		if (!ssk)
 			return -EINVAL;
 		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-- 
2.35.3

