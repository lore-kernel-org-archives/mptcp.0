Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2086.outbound.protection.outlook.com [40.107.249.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB545684
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 10:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODO5XRn6ujXbc3ilgz01/VP95Z/4RFeYsIppgxyAqWbd0xLLH7cYQ5aNlU+B8gdL3Gqwku/2NxZ0py7U5yA0mXp1MKGIMBTtHJ8jEpUIUljsLkl08c0teHi/P1xaREhAsT1dtbaXaklXr2H6Lfy2Bvduh+DYM7kEw7tHcairb/yNmGKWaMbgk2OR153Roh2o6sv0dvnNR/QvhZP1FbYkz8d67SB6tl9VGy0mdlYvuAnyZmqtfpdeyYtYeMk2kpeJ365jZm/zb5gwpp35OKL1lwjoqWCNphUbutLHuN1kdkRWMLzDS3kOsXoKYvQR5RdKlpSN5IiLqz/rE7HTKhSRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0gv1mvFKUIMpPvc9tNX5nkk28CQRKTkvJcnOwL4VHc=;
 b=nh7q0vZgxPQI2xtfILo7EL138gMqL79te/4sw1XD0hPAgqyeMZGt1uBCYo3NNIweCpZ8RH1Bccs6fSvd82DvWIcYI48JcAPMu7opZC7dl9pIec1ys+YU84wCwR2OzeemA25HVc56ykXwUI9UfSXe5XdlQ/znorsHiP0WVosNAeemXuDD5oBMUOu5uJgPNm/FEaUykBUDSI7rZcf5y0xJeLNbzqnOG85fVMmL6sPGLcZPeSGgNJbeEG3LEUHQYT55q9DCmXwQY58NrAjJ/GghVr26LGj/ZwwJSx9C6IcMr3VQAZolHh3jASA1GJSLmLDmdlOcvnKRABf723NzWU77pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0gv1mvFKUIMpPvc9tNX5nkk28CQRKTkvJcnOwL4VHc=;
 b=biwcjQgq8+HIQzrL0D0rCv+Kmtx57r2VmJOoaRp7Lx9EzDQJhwsDySTHCDzZKBxKvUqZDlS1A4kmXbSMCPrLQq4h8tBw9VVdHyBvm2lYUsv7gR6/9f+eup0dV2PrGIzg1rGHoJI+HUXwlMEbkx+tJwO/6Ld4uZ8eJsh6sEhMVtPMwm4BWU4YqTVLo4T81DQTbbOYGBQDyDS5RL6Fxc4t51ysMSKJhVA4RQifoq9fug3B7e1VfbWyVeCpgrrd5AgDAgrCdw/8BJGB2DqztVJtho1hfeHM60+YAOFAZBroQ/5NAFft6bFtuPaL2mL+gxwuidrgJ9b7L4a2HGlhnRYDMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8596.eurprd04.prod.outlook.com (2603:10a6:20b:427::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 10:04:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:04:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 05/14] mptcp: add snd_burst in sched_data
Date: Mon,  5 Jun 2023 18:04:00 +0800
Message-Id: <3b72e88150e9189231ebdbd81b09fe4c65a1c5c9.1685959315.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685959315.git.geliang.tang@suse.com>
References: <cover.1685959315.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 573d5734-6c69-4aa9-f616-08db65ac510b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+3I3HNsRA3ypzzrMlWeTg/6adug5FSiYjCHAyLP2DQDCFa7/DG0pRgqSR/fzIhlkl7h2wLVH1uPzERIX4p9Q/gAHqZlz4V5XAYlCcHaBjDqXS1e87sAkzrukvDPaZLSqfXsg+ZP17Gt4JHRnTEI6Rru2ty5JyEL6XDOWFpSWQjNLus0FAjLfcshHZYikOF47il8q3xZc6P1qmsr/XsmBlc4a2k0oBr27SkqH1JJL/jbKwBysUBG+NgM34zAjew+7wJZzbZ/lOw17xjE4XB8Hl4byc+qfGsX33F6xo6Lt8MbNf4XZOQ9mmm0zlEKeK9PwkAIya273KtV2C2f4H1COesROQ7H5igEEtI2UZWzuFhfwJLT+uJlS/NI0xzr1cl6YWN1d0dMJNkJ1jJw97egV8Quf0qXB4C7tG8t90cKzqP0U2PQh/6ua+GOJ7fC21r0yRYTQy+rmuTL0QSj1VZkxXj5nL3hMBvBEZxenyj8ZEjQwA8XwOlK4+Cqf+fcLOSA/yEex0zWWRseiXQD8uSaFahrGvdOlHvGNq/7d2ODUqXLUrF59XmP2/ab6bRiImy6s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199021)(107886003)(6506007)(186003)(26005)(6512007)(2616005)(83380400001)(6486002)(36756003)(6666004)(2906002)(8676002)(8936002)(44832011)(478600001)(5660300002)(38100700002)(6916009)(86362001)(4326008)(316002)(41300700001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HmlTGY8Gh6YiIMVvoxGMGNrC76k7wLNbnOZnNxM5rJ1GalD7RO56XoXoevEn?=
 =?us-ascii?Q?szDDRj+WMnrC3EO1qSSvz5DE9QsGHaaIZR6NjqOQqfr+r28WdcIglpz6wHpG?=
 =?us-ascii?Q?vYYhdpT14HJ9b9veiqqb/+RGmTZiXnRJ0tdAO2z/Nxto2W2kyqad3+sBuO9T?=
 =?us-ascii?Q?R3R+u6/kENiCQeyk09/JE9J6rtU7AZvVXLTBtG3FgLjss88Ef36PU2aAhYQ/?=
 =?us-ascii?Q?vNs+qCxkDoLkzDRw+DN1kjC29hRtMfWUvT12RKn+HqMyC/dr04R4IxSvxM62?=
 =?us-ascii?Q?WoHcx6bEtCK37U5jeUd2wgBWL+qoK1qmjpQpOxrIPa4VLhdwC/YM6FAWDo2q?=
 =?us-ascii?Q?xOETflUzwd6vYWpIZkjqoKzVOyrVyZBiumMqbcGW3aKcfX4zIQMwDZvK1uR3?=
 =?us-ascii?Q?E+OT3Lh5Yj05fR3ybnoBCELOArwWuBRYze0NEli8A1/zxs9cgL1N4Ug5/euh?=
 =?us-ascii?Q?2ZLLaGp4cW8saV/0MX+c2MjwybDdky3hnJ+qErnjN3/e/GBNotkt2PEOIkkE?=
 =?us-ascii?Q?zFpVslVXXeW+fPe1hQ/2LNTP8Lj6jWit18diKVYbUjyW5tiHYteAvd5urzW1?=
 =?us-ascii?Q?NR/YGSbRP9mE0G1+GO2llx0nnrleKMnPdJY4Gkzu9VWkJxXt3fKcSOpV2gn0?=
 =?us-ascii?Q?Qv7oGVpzDBr/C1c5Rhcb6VNjf3FVMD1fEsAyLToE0nvn9Tg7RZdE6Rt8mFtz?=
 =?us-ascii?Q?ZaStONfR7RPthqP4qkO8+gHdqPplkNLIao1sfH2cqwyQsgNUL0fDYpn9ZJC/?=
 =?us-ascii?Q?9r/WaG1c5BNHXN0GAaxgV2craGIf9UONdn2+9f7CQJpJLu6g8aUuF0NDeDdi?=
 =?us-ascii?Q?OEW52Bm5dSPWmkcpFb/0ULb/WPLaYRXQ77bipJ126sFXjtpLAxz9OcxBlvFp?=
 =?us-ascii?Q?WwqvEiACstQStMMydsfV4sD4StiEY9AE0+uXblfztmaPCJTRFh0tZ5rTkl9A?=
 =?us-ascii?Q?JA9pGgkpor7toatJumYxKiNKsphSGmTJQbXxNKGir+7lY0Pc+JoiyUVnC+6H?=
 =?us-ascii?Q?6FvFmJLlN77gs+18T7TRWAfzVy3Zaf+cyuen1Xfoon75g9R5ioRt83fPAmCf?=
 =?us-ascii?Q?jcNA7YJ8GyLfdDkEyd/GZZh86new69DraTobTAEVtESDCbVIzgcLplfNgYy+?=
 =?us-ascii?Q?243H1BBQ+OzuxE+8MK0NFYBKCoxmdl4z2E8hajF/D7HXR4iIrwWWwt/DU+P0?=
 =?us-ascii?Q?CR9+TL5lAi1uzHFHGXVZ5YM+nftdnz77Bu3OIo+Y+miE2HnOSrY52LOuhg5b?=
 =?us-ascii?Q?LIKnurRN02zoNbSJh4aUHltcdsPQwxWqu6QhYtMThP7LO//xmEbVa/TRYyBt?=
 =?us-ascii?Q?gOYdCjwu85r2c46jiU2X0b/negJ+Z7iv1yamOba89uyH3DPxrrDo4mWAqccD?=
 =?us-ascii?Q?LYbH/WqKg67p05mVx5+3NgvOIwvVqHtfvnWMUfV/Hfg2lWm5aX1tkLw1kDSe?=
 =?us-ascii?Q?1XzZNmpB49IxpMHv5G/d3mC3WUe11pcveqi7y8bWmVp8tsIcR+tDxOCfJgWR?=
 =?us-ascii?Q?+2cTXgqIkijFdHaWHcxBqu6rx4Hj0wCYqqBaph4EYgn7fMfGtxCU3Vt+bm0w?=
 =?us-ascii?Q?laVtwmFTYHv8rG7prwXqQZqxDvQ+ngEYeCB1WKbC?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573d5734-6c69-4aa9-f616-08db65ac510b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 10:04:57.5284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZYgQeZRmTW1qk+YIb9Z5OY+hI3rl3gxNq9/RfhKmA8Lv2Lt25LRw683jyKeEQMEKMRpJkcdrrFEDnBWusCvKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8596

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
index 42adc14a073e..27feabd92b3e 100644
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
@@ -2355,7 +2356,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	mptcp_data_unlock(sk);
 
 	msk->first_pending = rtx_head;
-	msk->snd_burst = 0;
+	msk->sched_data->snd_burst = 0;
 
 	/* be sure to clear the "sent status" on all re-injected fragments */
 	list_for_each_entry(cur, &msk->rtx_queue, list) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 949f46d4c710..a4db0f8f00f4 100644
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
@@ -668,7 +667,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
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

