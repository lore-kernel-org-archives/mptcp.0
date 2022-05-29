Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E065015A8
	for <mptcp@lists.linux.dev>; Sun, 29 May 2022 02:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653790883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vkp64iDl04EUvJGGcy8lzxgXgvuE81NGBiEmCFykT8M=;
	b=hrk6LWurgz+Hf9cFnZ9fzgO+wUWl2PHR1QE7wFX6iKWqScK5fO3hUI77iCIP8y32+QCFq+
	I6ED1Ptsd7ngNDktbrvrJoWne0vp9n3qasXAD4R+gfJwhB2Hd1YAsSgztDgzcLvW3IzWnk
	+YPhGvCrC2sOvI4kTgQPaJM5tLtIB/8=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2051.outbound.protection.outlook.com [104.47.1.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-OmKDAaJPPdOjyjWudtAfkw-1; Sun, 29 May 2022 04:21:20 +0200
X-MC-Unique: OmKDAaJPPdOjyjWudtAfkw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3Xc6u49Qdo6GTVkeNneAm7jrRcwpRGNRdwEQNP1TxdbPtthnpMB0h89LV1bkZLgICbvQQ+xR6tUYUe9ei0iBTZlu0m7gKqDCneAcWkvCfD0BWQszruuUNbkI97R4tkDQ0ly9ezutmWRt2fCo9X6avkIMvQeCtd7hDEcLcfOev/6qLeB34dThBNItySvourpoEXKlxARIGc0ljg03VXBmgwikJpADR3/RnVqSq0+zf9P7ZkblDZYOzJ+Uz9uwiTC6YDe3ASRMSR26IQfjMW6zBqfD4weTSg5XEQwgtkS9WEvjCzzWodLtn3GmPyFBOcpkaJ0p1mFQwoT7svI/RcjWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmDLsv8XH1HRAEJTp4GHpoc89EshST+EfJTEU07piPQ=;
 b=gNmcm4hH8MpTi3RJX9hm5OXtsP0Mlc8o5+TQbgTXxnFaKhW6+ahB1rmcikYrWsmycDbB+FUs1QUF/J3ELDU0e5P/rBttR+GhCcN0I/dJ3X9NLIe8zYarrs/0LGIXSHcD+3NjhhAButRjVtkGseVbFbeFV4Dh8CvRjLoC0QcFdUelAzgilz9ihP3Htrw8j994UjOAB7DOV8GZyZ4RS808iwixAbhF0kA8xGoQHKOv+nrFIyKTNNQXlF322XBkk3pwnqbYpms1SBPlfRq4V66+zyTPHjjfcGuhzSNHYD723W4FFmOrh2R1T8pMolErzeXHwoZhUnCwDC8VbTD13WPBdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR04MB3239.eurprd04.prod.outlook.com (2603:10a6:6:f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.18; Sun, 29 May 2022 02:21:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.017; Sun, 29 May 2022
 02:21:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] mptcp: move is_scheduled into mptcp_subflow_context
Date: Sun, 29 May 2022 10:21:24 +0800
Message-ID: <d0566f954ee527d31c37f118602e0c4b7d9f1654.1653790818.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0081.apcprd04.prod.outlook.com
 (2603:1096:202:15::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20194aeb-7cb1-4f10-23d9-08da4119e958
X-MS-TrafficTypeDiagnostic: DB6PR04MB3239:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR04MB323915AB029C96A65EFFB5D2F8DA9@DB6PR04MB3239.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o6YvRLe8DES12fZ7+x+kzSmpcPcUkqJalGVZMR3lyhFC/ksr1mM7IfizMa2yN2nGPMSQYj/ND+avuog4H15Xmd8FRnB9sn6N7K6MYk7KoCMPa/Jy2/W1/CpsYSAb0mCGAHr3XMlW+g5l2Lc/u5mth0RnRos8Jd3q0q5Wk0eTmObMHbAqEPvn9u/uERRdE3/UIcd0qw9LslZQClJVYdaSeeC7m2LZc/cG2FgIx5ySl0g/0pU+w4MX+m+w3Nr+QzAqJ3C0bI7iG7hP5HVmb5zdWGtRG/K/Vjj93QsNDzN+TDJmGmLn7om8y9sP4OPJpiU8dhJ+gd6RtCviPR6/39e+ucYtupKOT4W/0RoIFOBBOQiYmcyfXDlzzka9Cop6+SCvatlOuPWSUEJLzEulQfKpbTFDbmUUsdI9yEB45NPBUf2BPvdnlqH2b849K50T/7M3vvr16kco3wnv/bS4cuUsJr213m4bT9VoJpymxRqYJhaqu4LcnDv3IPY4/tCMPapGbwHbW8uS8jFG/eQTD+w0p+kagvX70hr3KpLE/s2HEd29QUfdF9TxbN1UG5cWdzFAgpFOfw3cMKp/Vxq8ztkPXOv6tLWMK1VwNG212ailihl9mDb9zYmTmuyv0JMttoV0TjByMn8tqpct92s8epS9JdWaSx8QKatD+Ks/0f0G/4qgdFY48/H+eSucPvKf70fa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(316002)(44832011)(6512007)(26005)(6506007)(38100700002)(2616005)(83380400001)(8676002)(508600001)(5660300002)(36756003)(8936002)(6486002)(6916009)(2906002)(186003)(6666004)(86362001)(66476007)(66556008)(66946007)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F6zrtvLe+qZTlBSrrLVlagcTwPJp0Zfurg03WKjK6mEzHpZgaPX01IudUaK8?=
 =?us-ascii?Q?LSoAK8qblUROT/548meBFe4k7MXt6K+eIQgewR38q90GaXneSSMPslcHLZMx?=
 =?us-ascii?Q?Sr8mjqVTCSv47WCYj7wj6O+XQs4Z7RkLfJTVnVfdXHiu1CJsLKyD0CfoHh9v?=
 =?us-ascii?Q?MSwcRdE0rCq9tw9XW/uHvcrV/wFxHil76vKCi6w3GG6J9aElDRnfOg1pzfL0?=
 =?us-ascii?Q?sIwvqPOnbtLrP9BdzzAOCoiyMe9EH1UBGWWVHxvE9tRaUdvnTfqL5Fs/wDLo?=
 =?us-ascii?Q?9J99i0gwlRDXd8NNdB5z1GLlhETXNLM4oKO6lMRIEeNcIm8piP+qSFbZ3yz+?=
 =?us-ascii?Q?dBtLzLPJb7Xh4IGMR4iGeW8r6F77jDqJbh/71lmUtRsbaDS6ibiF9YKc8OMy?=
 =?us-ascii?Q?AFcCERFCV7MxqDPrxFbb/ojFF9y00bN40Pu0vofPY4cEp4v68ivD5rr6rBvM?=
 =?us-ascii?Q?RgBTFS+xmS8TFPeK90xLTSAY8bOdEALJ6dgJaUf7JWKj8AAtlkm03oLsak6b?=
 =?us-ascii?Q?P52Dftw5hmu0o/QBBj/CkEwVTVY+QXasf+MhhnGq077irvSMJYqE7bBbk4F1?=
 =?us-ascii?Q?CDgmvHg2amWXqil1VprL8CNIGrB08o2RJ1bZPCIIFR5qHwVoOFIE0ftUKU/5?=
 =?us-ascii?Q?AHooeychyelevXHeR7wBP1GCXKt/Uh7xS+Kk1qtuhEZ5uk95rnU3eRzPCKTV?=
 =?us-ascii?Q?OgB0lfJzl1DaaxMglnJNzDSQEyE8/UzahsStcuel9qTtZWV8jqzm/I7fzp8u?=
 =?us-ascii?Q?ohDa389q/A9Li3dkh5Tps0J9gdyva/zpc7rj0Va318TGHKY4yhQ1bMCKTxcp?=
 =?us-ascii?Q?U6u9IL0qyJKmY4IDVC13JCD8z+mharh2NFTJHF1Gsc8VeVcgxNQIn4zgodHA?=
 =?us-ascii?Q?5+wvpbEjFAIgN3AFGzilKu4lIn081a2K/Mq6j26g2mgLGZc/FoLcP4YLsyxr?=
 =?us-ascii?Q?/98DkYAmJQ7mKxyFxl0bF7mF9vX5/upTe0BKyIuhu7N14yNKXWQKtLRQwaD3?=
 =?us-ascii?Q?fdqxu3BFr4vH9/+29xSm37uNCx9QflZ6rj4BUePsKeDz+IyRzuXBCOmV6iBH?=
 =?us-ascii?Q?n71CmeCh427lWxqhj4TcNUwg5NqvuyyyDx+5ynNJ318LUROuIPh0EYXMwdHa?=
 =?us-ascii?Q?69ELISc9d2bZoarMGO08gW8LRHoiDVhiLHdDOogtm6k021T9frW4Z8A07UaO?=
 =?us-ascii?Q?u7lzb/bk6ZNvkDr8ByLno8x+vpHU2jdeATd6n5uxR+wtrA7Yjw0odkWOyVdX?=
 =?us-ascii?Q?zqMA7JUFpfYW/aS7cekXm+SBDK2HixAQmSysH2AVw5aZ9JBo97BdU3NvIF7A?=
 =?us-ascii?Q?cIVdRu8N1yXs4a20JmbcExcknwd637X/HObBVoSXI48cNx49DSYDdMpC01RR?=
 =?us-ascii?Q?sobHUxqinXgeOQV+polAEq/AbTaJOA8k/8q2MLRfGuTqqNeUrTmfDA78be54?=
 =?us-ascii?Q?/fHm5iO3flO792VHZipaL1q5pWNXDNWmYENR2GDK9mYEtRMIipafV9yl0SZ3?=
 =?us-ascii?Q?3aJhj7/TLqIE6xbDsJqAiY/CTUdP+dZtxUEzemFrKzPxs76CaRQUUb1G46we?=
 =?us-ascii?Q?HVQ+tAeUzx/vVTnaCADrmxzv0/M7dR1/IOkVfMV1qxXCB3zdTJ4xU9F/mIUv?=
 =?us-ascii?Q?6mZlNUAIZ7yhpsghyZMKg+PNO9sZ4EjHsQXjk0iguBR0+MxrnKi1NzDPAq29?=
 =?us-ascii?Q?vmyV39EdV4Y7PEY58GE2KPMOW76VvLR36dEf0REXtCYN2wYsMvU1pQ1L0KO0?=
 =?us-ascii?Q?OiLCJf97tXP08ErTpJpl38U5mXm9KFM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20194aeb-7cb1-4f10-23d9-08da4119e958
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2022 02:21:17.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4YWCMn8kyEOF/TZNEK7SJJRuOAHF9sWfG6Jswhm7K+vmiiJE8mip08xPIA+86pGWm9ipXWXXT/2MEk9XdooWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3239

This patch should be squashed into "BPF packet scheduler" v3.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                           |  7 +---
 net/mptcp/bpf.c                               | 34 +++++++++----------
 net/mptcp/protocol.h                          |  1 +
 net/mptcp/sched.c                             | 21 +++++-------
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  8 ++---
 .../selftests/bpf/progs/mptcp_bpf_backup.c    |  6 ++--
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  2 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |  8 ++---
 8 files changed, 36 insertions(+), 51 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 8a53583a9745..7af7fd48acc7 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -99,14 +99,9 @@ struct mptcp_out_options {
 #define MPTCP_SCHED_NAME_MAX	16
 #define MPTCP_SUBFLOWS_MAX	8
=20
-struct mptcp_sched_subflow {
-	struct mptcp_subflow_context *context;
-	bool	is_scheduled;
-};
-
 struct mptcp_sched_data {
 	bool	reinject;
-	struct mptcp_sched_subflow subflows[MPTCP_SUBFLOWS_MAX];
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 4f4559d37f9e..0529e70d53b1 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -33,12 +33,6 @@ bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
 	return bpf_base_func_proto(func_id);
 }
=20
-static size_t subflow_offset(int i)
-{
-	return offsetof(struct mptcp_sched_data, subflows) +
-	       i * sizeof(struct mptcp_sched_subflow);
-}
-
 static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 					     const struct btf *btf,
 					     const struct btf_type *t, int off,
@@ -46,8 +40,7 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_v=
erifier_log *log,
 					     u32 *next_btf_id,
 					     enum bpf_type_flag *flag)
 {
-	size_t start, end, soff;
-	int i;
+	size_t end;
=20
 	if (atype =3D=3D BPF_READ) {
 		return btf_struct_access(log, btf, t, off, size, atype,
@@ -55,21 +48,26 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf=
_verifier_log *log,
 	}
=20
 	if (t !=3D mptcp_sched_type) {
-		bpf_log(log, "only access to mptcp_sched_data is supported\n");
+		bpf_log(log, "only access to mptcp_subflow_context is supported\n");
 		return -EACCES;
 	}
=20
-	start =3D offsetof(struct mptcp_sched_subflow, is_scheduled);
-	end =3D offsetofend(struct mptcp_sched_subflow, is_scheduled);
+	switch (off) {
+	case offsetof(struct mptcp_subflow_context, scheduled):
+		end =3D offsetofend(struct mptcp_subflow_context, scheduled);
+		break;
+	default:
+		bpf_log(log, "no write support to mptcp_subflow_context at off %d\n", of=
f);
+		return -EACCES;
+	}
=20
-	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		soff =3D subflow_offset(i);
-		if (off =3D=3D soff + start && off + size <=3D soff + end)
-			return NOT_INIT; /* offsets match up with is_scheduled */
+	if (off + size > end) {
+		bpf_log(log, "access beyond mptcp_subflow_context at off %u size %u ende=
d at %zu",
+			off, size, end);
+		return -EACCES;
 	}
=20
-	bpf_log(log, "no write support to mptcp_sched_data at off %d\n", off);
-	return -EACCES;
+	return NOT_INIT;
 }
=20
 static const struct bpf_verifier_ops bpf_mptcp_sched_verifier_ops =3D {
@@ -144,7 +142,7 @@ static int bpf_mptcp_sched_init(struct btf *btf)
 {
 	s32 type_id;
=20
-	type_id =3D btf_find_by_name_kind(btf, "mptcp_sched_data",
+	type_id =3D btf_find_by_name_kind(btf, "mptcp_subflow_context",
 					BTF_KIND_STRUCT);
 	if (type_id < 0)
 		return -EINVAL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8739794166d8..48c5261b7b15 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -469,6 +469,7 @@ struct mptcp_subflow_context {
 		valid_csum_seen : 1;        /* at least one csum validated */
 	enum mptcp_data_avail data_avail;
 	bool	mp_fail_response_expect;
+	bool	scheduled;
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 46396eed62d0..613b7005938c 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -101,15 +101,12 @@ static int mptcp_sched_data_init(struct mptcp_sock *m=
sk, bool reinject,
 			pr_warn_once("too many subflows");
 			break;
 		}
-		data->subflows[i].context =3D subflow;
-		data->subflows[i].is_scheduled =3D 0;
-		i++;
+		WRITE_ONCE(subflow->scheduled, false);
+		data->contexts[i++] =3D subflow;
 	}
=20
-	for (; i < MPTCP_SUBFLOWS_MAX; i++) {
-		data->subflows[i].context =3D NULL;
-		data->subflows[i].is_scheduled =3D 0;
-	}
+	for (; i < MPTCP_SUBFLOWS_MAX; i++)
+		data->contexts[i] =3D NULL;
=20
 	return 0;
 }
@@ -136,9 +133,8 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *ms=
k)
 	msk->sched->get_subflow(msk, &data);
=20
 	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.subflows[i].is_scheduled &&
-		    data.subflows[i].context) {
-			ssk =3D data.subflows[i].context->tcp_sock;
+		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
+			ssk =3D data.contexts[i]->tcp_sock;
 			msk->last_snd =3D ssk;
 			break;
 		}
@@ -166,9 +162,8 @@ struct sock *mptcp_sched_get_retrans(struct mptcp_sock =
*msk)
 	msk->sched->get_subflow(msk, &data);
=20
 	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.subflows[i].is_scheduled &&
-		    data.subflows[i].context) {
-			ssk =3D data.subflows[i].context->tcp_sock;
+		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
+			ssk =3D data.contexts[i]->tcp_sock;
 			msk->last_snd =3D ssk;
 			break;
 		}
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 480be2ea7d59..915f5735ebbd 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -237,17 +237,13 @@ struct mptcp_subflow_context {
 	__u32	token;
 	__u32	padding : 12,
 		backup : 1;
+	bool	scheduled;
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 } __attribute__((preserve_access_index));
=20
-struct mptcp_sched_subflow {
-	struct mptcp_subflow_context *context;
-	bool	is_scheduled;
-};
-
 struct mptcp_sched_data {
 	bool	reinject;
-	struct mptcp_sched_subflow subflows[MPTCP_SUBFLOWS_MAX];
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_backup.c b/tools/t=
esting/selftests/bpf/progs/mptcp_bpf_backup.c
index 4f394e971c03..088dbc4be99a 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_backup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_backup.c
@@ -22,16 +22,16 @@ void BPF_STRUCT_OPS(bpf_backup_get_subflow, const struc=
t mptcp_sock *msk,
 	int nr =3D 0;
=20
 	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!data->subflows[i].context)
+		if (!data->contexts[i])
 			break;
=20
-		if (!data->subflows[i].context->backup) {
+		if (!data->contexts[i]->backup) {
 			nr =3D i;
 			break;
 		}
 	}
=20
-	data->subflows[nr].is_scheduled =3D 1;
+	data->contexts[nr]->scheduled =3D 1;
 }
=20
 SEC(".struct_ops")
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
index 0baacd8b6426..5f866f51ac70 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -19,7 +19,7 @@ void BPF_PROG(mptcp_sched_first_release, const struct mpt=
cp_sock *msk)
 void BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
 {
-	data->subflows[0].is_scheduled =3D 1;
+	data->contexts[0]->scheduled =3D 1;
 }
=20
 SEC(".struct_ops")
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testi=
ng/selftests/bpf/progs/mptcp_bpf_rr.c
index de0d893e08b4..03c1032bc31a 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -22,11 +22,11 @@ void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mp=
tcp_sock *msk,
 	int nr =3D 0;
=20
 	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!msk->last_snd || !data->subflows[i].context)
+		if (!msk->last_snd || !data->contexts[i])
 			break;
=20
-		if (data->subflows[i].context->tcp_sock =3D=3D msk->last_snd) {
-			if (i + 1 =3D=3D MPTCP_SUBFLOWS_MAX || !data->subflows[i + 1].context)
+		if (data->contexts[i]->tcp_sock =3D=3D msk->last_snd) {
+			if (i + 1 =3D=3D MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
 				break;
=20
 			nr =3D i + 1;
@@ -34,7 +34,7 @@ void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptc=
p_sock *msk,
 		}
 	}
=20
-	data->subflows[nr].is_scheduled =3D 1;
+	data->contexts[nr]->scheduled =3D 1;
 }
=20
 SEC(".struct_ops")
--=20
2.34.1

