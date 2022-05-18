Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C05B1852
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 06:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652854289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t52O9fH1kPKxXbF79YHidiaRra2Mm/xvTLNfOoSYyLM=;
	b=WMjrfYprkmfmCPVzvXii50Ei5WE2+I0Pgj1F/BvDE8HxV2TTHkRanhlE0Qil2A7XZylxQO
	owtRgn7EQ5JLLT3D8Tosc3D9xlGdewvFoajbG+zkge0Pyx/YRp3Bck/ob64NNpaHvh6Af6
	Ga/iml135rZ1Zeb8jDJD1C0JRunNCjM=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2056.outbound.protection.outlook.com [104.47.12.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-9Y21-GfuOV-XppkPJl27ig-1; Wed, 18 May 2022 08:11:28 +0200
X-MC-Unique: 9Y21-GfuOV-XppkPJl27ig-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bex2xbVKhHRdlaphEdZIYxIIuDKeBjQsC32bpvNkbisxRSlGVqCnmoiwWsGUDlvoafuSmXIAOmJW6YDkfwDg9xovsTlPeDDTDjYry0zTUyHn2Gk5Bzp8RJ63wmrl2rza7YwX5donvxG253KxPmlgzY1DCrtfKeoI1hKxXkaQWG6LTnuNZwFdCeWAfWKbhCUpKBo1RXwyHNWZ/3PIdQ9OJVX5LQhh32sCvhlRHKFDJuZSaz82rIURjwgfTV4LIgaUG6S0nqBC1gP87m//j2hAVi2pHAArdA28Px6CCP7AXudWDw2BrvKLqTjskPOWkHFc8jhwC1Uhcf0y22n3iMOGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UG5docKwYtHN13X5ollLBfj9pCQmIHlstq8pe38WZE=;
 b=KDTcqJVSRyTwcy80eWwhho7jIYxLbGOSjdhqlB9pq/yVJK/vCOF6f1cMAU7fHcsX+VM1W4C+prwt2cUtV9h5hIzY41AFX6bmOO87AnNsmVgIPHyNQ95UZBdgUQNNqKY1o9AuWW+U69GYDZ63wwUIjtphhYQZsrHffHFnME8rwNaGm66N9rsVQtsK7yh+FCNKiMtOl8u5AfMP1IpWrfNIquwbzw1mSGOsI98csQItHBVkXLTsmPeKo0yteMHQ98yqWMnfcEOtaTqKjhiKLiwPoWXYiLmxWDtTdCd5hziEjqF7v+/0AG8eExQ7IsiE4bMAEWzfgLKk5+yts9BRZ0KyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 06:11:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:11:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 04/17] bpf: add bpf_skc_to_mptcp_sock_proto
Date: Wed, 18 May 2022 14:10:42 +0800
Message-ID: <37a37833b37af5f05a261ed4e609b061eee4d2b5.1652853898.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652853898.git.geliang.tang@suse.com>
References: <cover.1652853898.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:202:2::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 571cad4b-8ede-48d4-7ab2-08da38953e16
X-MS-TrafficTypeDiagnostic: PAXPR04MB8256:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB8256DCEB91987169CB73F114F8D19@PAXPR04MB8256.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FONx35m/3wopMKXA9qaVpc1+N2GFrd0Ltln9i/JCnesj/E3F7i1GuAh0u3VOOBB98lQ4Osxesk39yI+RWGCb2itqkuxmirrrCyOcyc1JBcwHcRhRmsADTur/uFyZvE5Sxk5YafPiGP5kgDQ4S/zC28w4s16z2ng7eX7VnAS2AwOInVnXpFQRfXgYox+EfAwwRZGJii+5U+YBF5jJkYDsc3w4Y6DXWEISNtldHfzAHWBvMSyXPLohLAspuBEcU7CJyWHjZ1WfO3vJRKoLUgz+L7s+yDtIcNGWPfR4pymiXqfKgF+owdGa8y2+ceo2iJbXXegwel6zUpjRYTsaa+eglWRm7EwGFwrT4Y5YH66SaiPV3xDnDM1Iw3LhWgPVf4i0TFESFWV0IHjhEs7tOSafBeErBB+A6jLDywPWlQs7RnlqPLDDpcMzIL/WSZNJ2vQkbT6rD6/dW9emM+H8yoqe4T8uR3GHCYzlO0F9gNQrjPG24cJDaMn+74lA9nlE4gvfw2jJanRm/v8BXWGloXMQugezwqp7PHoHUfvpTc3H7TkEgHne/AYIjcUgOz5YnLPbkNLhP1erNLt5ZlgmLBLxjiyvqQcRnK0IvyUqxt6iAOPq+lfbrFDRrd+FXSYGz+511iNTd19r3fUOIeWYK3FwTlqCqvynq+1OLzee69LxLZuXxc9Um4zNhIZZ2mT3FBKc+aBlhw40DhulrhBeYcrTLg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(66556008)(6666004)(2906002)(66476007)(8676002)(4326008)(36756003)(66946007)(316002)(6916009)(54906003)(508600001)(8936002)(38100700002)(5660300002)(44832011)(86362001)(2616005)(83380400001)(26005)(6486002)(6512007)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZWejwpIW5ViH4j+oSpM9ZgYoLikBhLHMUs44o3nvvdcKJQ5+lkpZZd/a1GFG?=
 =?us-ascii?Q?w46A91JRPyvTtRXvYgxnquj/9P3U/0XhI/GXknJ9UMi8+XzrYl6aifke85up?=
 =?us-ascii?Q?kWvoaN1qHdQHM6IObCkG/oq/wyCEeFznNDJpbF60ynkf6ppb2FLKuM10D+Kv?=
 =?us-ascii?Q?ygbQryvTRwmnz5VkprL9g7FapUsqzXlZKiiCahyFSIC4Irof/lAFLruT2E9d?=
 =?us-ascii?Q?WVT4Fs9t4PrjnLr+8cwJ+MLiRRhU4pT/nvddclrlMFfFzWp00eNAWVoJnkkb?=
 =?us-ascii?Q?Ublkjjyb7I5smwtnI/qogCI7rzjpifidelUAwJgdq0at4ZViCCYOFRyATfhs?=
 =?us-ascii?Q?b5/AE7nyFJqXT13CJoXXHmLkKVvQ8ruL5S+ZCotC6VNs7gJiTsek383M3nkj?=
 =?us-ascii?Q?2HX137PlxaXuLKMV2N95loa6TDNCaDof9Lc2205RJR0oRuGAxFxL2T3RcMSO?=
 =?us-ascii?Q?7vdj4Rx065b3b7/5Qoo4YVSUcpo4sz/H/E/OLOoAwY3071wilWeO1e2xDxed?=
 =?us-ascii?Q?t0nkxyL9JcZ3BKQqfjk/Z9Q9jEqnzlbWI7Mf7+F6zzb2f53qdhOz8Qtq88WE?=
 =?us-ascii?Q?UDE07mtjcMHgO0s9Y8gFPUFqbeftwVjOoFhxd+NEJDzbZQG41nRQxRi2t2pz?=
 =?us-ascii?Q?GnHTc9FO6hTZOT2tPvzp68IiDDlYHUNc+JUFtMYogVUtvv0bTJhdfZDvil06?=
 =?us-ascii?Q?lVsnYSuMg58oFGbQBp6mT+v3hv+ESlj1B7pmmsjwtBpBbSUHd2pT4MlHf333?=
 =?us-ascii?Q?27vTfh/HGc1E+RT52RAiAA1zHo49HsDgDm2eWTyM3eMONiS4pfImu6Nld1wZ?=
 =?us-ascii?Q?dxfdSo9mLQp/2NhAd7J1gygjNkY4YJ7xVttWeLE1G1Td38kL3qLLc417TG7y?=
 =?us-ascii?Q?mU/C4+3KjLb5VRrxEbk7wzysUBRiB21Xp9NXKn2o3ye0bSPNpP2i8bS68pgq?=
 =?us-ascii?Q?eeHPnyp4LMdJvVmfr8EsOo7IuQw78mk8MrYdJwlmZsNNjT24rBqIUCk+al6M?=
 =?us-ascii?Q?TsPy/dzOKb5tGZYOpuxC2sTCbKb8ySGUCX5H5uA7PJ8zGyCxYKYjVhLpp1sF?=
 =?us-ascii?Q?V/3VdHn9XQOvNMpvFJca/uYlXEK66sowM09QxKpr85LIPtGd3VE6D0ksxIHo?=
 =?us-ascii?Q?A3pfPbBFnyZsYKlJgkDEbdEO0nroBkMXyEqksym3kjwm4pFuk0zAeby3aPwK?=
 =?us-ascii?Q?d/m9ewAdvaVPTXHuKPik0rt1mUJF4ZCjfRuKx4EXz2nQ6WbGZWhk7lGeWVjz?=
 =?us-ascii?Q?szxnppf436PD6Zh0jDRipm5cb+OrR5hS1QbQIK16jp/BR6jorglhkOqHr50X?=
 =?us-ascii?Q?M9KyhtD7LEVnc9tBOQBXcMcEZVPC5EFacLGazvMdYb4k3MTbNfR1hhTJRzsR?=
 =?us-ascii?Q?s1ASZcAvaIKqVeENGjQLxSGVjfrk3zdoZfPLL4o4m/N/5K/rwtxw9sgyhBiC?=
 =?us-ascii?Q?+GF7FKTddBdQY/+SI4AIcO5eecVU1ccm1rkUeIhdgo0VfEhRz7D4pF5LO/X9?=
 =?us-ascii?Q?LuFAKJcddJtikiM+M/G4myjec9K1086PlVZp1Tp5TDNfQHzZMlGvAeY5XiEL?=
 =?us-ascii?Q?Wdcu3lJf0jdIsk5UHu1MxMWvCwtMV8bjFtRL4+JkcT8jUIDADd4VUynR5F1s?=
 =?us-ascii?Q?tOmCOZmC0njr6/+Im9K5a3woIFYh0Ied0pKoCQv2PRDuZE8s4ohErow76gjQ?=
 =?us-ascii?Q?yykH2ykqN9flt2pVUmrtoEDoFfmwb4clmJQbllefnh94fPdE47iyjmHOhAhH?=
 =?us-ascii?Q?Kvfahsxxk2N7w0OQJ9duvl62Lao2sbI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571cad4b-8ede-48d4-7ab2-08da38953e16
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:11:27.1476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PDryCaEdUTMKOeDqYHy/FnhL2u1rnM1HcxAl016S6y6J67XWJH1ATCr49/vzbu7jRJSJwqac/SibHaO4OaTng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

This patch implements a new struct bpf_func_proto, named
bpf_skc_to_mptcp_sock_proto. Define a new bpf_id BTF_SOCK_TYPE_MPTCP,
and a new helper bpf_skc_to_mptcp_sock(), which invokes another new
helper bpf_mptcp_sock_from_subflow() in net/mptcp/bpf.c to get struct
mptcp_sock from a given subflow socket.

v2: Emit BTF type, add func_id checks in verifier.c and bpf_trace.c,
remove build check for CONFIG_BPF_JIT
v3: Drop bpf.c, define bpf_mptcp_sock_from_subflow() in mptcp.h (Martin)

Co-developed-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf.h            |  1 +
 include/linux/btf_ids.h        |  3 ++-
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/bpf/verifier.c          |  1 +
 kernel/trace/bpf_trace.c       |  2 ++
 net/core/filter.c              | 18 ++++++++++++++++++
 scripts/bpf_doc.py             |  2 ++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 8 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index be94833d390a..f53e39065a6e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2204,6 +2204,7 @@ extern const struct bpf_func_proto bpf_skc_to_tcp_tim=
ewait_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_udp6_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_unix_sock_proto;
+extern const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto;
 extern const struct bpf_func_proto bpf_copy_from_user_proto;
 extern const struct bpf_func_proto bpf_snprintf_btf_proto;
 extern const struct bpf_func_proto bpf_snprintf_proto;
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index bc5d9cc34e4c..335a19092368 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -178,7 +178,8 @@ extern struct btf_id_set name;
 	BTF_SOCK_TYPE(BTF_SOCK_TYPE_TCP6, tcp6_sock)			\
 	BTF_SOCK_TYPE(BTF_SOCK_TYPE_UDP, udp_sock)			\
 	BTF_SOCK_TYPE(BTF_SOCK_TYPE_UDP6, udp6_sock)			\
-	BTF_SOCK_TYPE(BTF_SOCK_TYPE_UNIX, unix_sock)
+	BTF_SOCK_TYPE(BTF_SOCK_TYPE_UNIX, unix_sock)			\
+	BTF_SOCK_TYPE(BTF_SOCK_TYPE_MPTCP, mptcp_sock)
=20
 enum {
 #define BTF_SOCK_TYPE(name, str) name,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 444fe6f1cf35..3e996e097084 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5154,6 +5154,12 @@ union bpf_attr {
  *		if not NULL, is a reference which must be released using its
  *		corresponding release function, or moved into a BPF map before
  *		program exit.
+ *
+ * struct mptcp_sock *bpf_skc_to_mptcp_sock(void *sk)
+ *	Description
+ *		Dynamically cast a *sk* pointer to a *mptcp_sock* pointer.
+ *	Return
+ *		*sk* if casting is valid, or **NULL** otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5351,6 +5357,7 @@ union bpf_attr {
 	FN(skb_set_tstamp),		\
 	FN(ima_file_hash),		\
 	FN(kptr_xchg),			\
+	FN(skc_to_mptcp_sock),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 813f6ee80419..3d8790e81c48 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -509,6 +509,7 @@ static bool is_ptr_cast_function(enum bpf_func_id func_=
id)
 		func_id =3D=3D BPF_FUNC_skc_to_tcp_sock ||
 		func_id =3D=3D BPF_FUNC_skc_to_tcp6_sock ||
 		func_id =3D=3D BPF_FUNC_skc_to_udp6_sock ||
+		func_id =3D=3D BPF_FUNC_skc_to_mptcp_sock ||
 		func_id =3D=3D BPF_FUNC_skc_to_tcp_timewait_sock ||
 		func_id =3D=3D BPF_FUNC_skc_to_tcp_request_sock;
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f15b826f9899..8451fc83d031 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1688,6 +1688,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, con=
st struct bpf_prog *prog)
 		return &bpf_skc_to_udp6_sock_proto;
 	case BPF_FUNC_skc_to_unix_sock:
 		return &bpf_skc_to_unix_sock_proto;
+	case BPF_FUNC_skc_to_mptcp_sock:
+		return &bpf_skc_to_mptcp_sock_proto;
 	case BPF_FUNC_sk_storage_get:
 		return &bpf_sk_storage_get_tracing_proto;
 	case BPF_FUNC_sk_storage_delete:
diff --git a/net/core/filter.c b/net/core/filter.c
index b741b9f7e6a9..ef84a9087651 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -78,6 +78,7 @@
 #include <linux/btf_ids.h>
 #include <net/tls.h>
 #include <net/xdp.h>
+#include <net/mptcp.h>
=20
 static const struct bpf_func_proto *
 bpf_sk_base_func_proto(enum bpf_func_id func_id);
@@ -11272,6 +11273,20 @@ const struct bpf_func_proto bpf_skc_to_unix_sock_p=
roto =3D {
 	.ret_btf_id		=3D &btf_sock_ids[BTF_SOCK_TYPE_UNIX],
 };
=20
+BPF_CALL_1(bpf_skc_to_mptcp_sock, struct sock *, sk)
+{
+	BTF_TYPE_EMIT(struct mptcp_sock);
+	return (unsigned long)bpf_mptcp_sock_from_subflow(sk);
+}
+
+const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto =3D {
+	.func		=3D bpf_skc_to_mptcp_sock,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_PTR_TO_BTF_ID_OR_NULL,
+	.arg1_type	=3D ARG_PTR_TO_SOCK_COMMON,
+	.ret_btf_id	=3D &btf_sock_ids[BTF_SOCK_TYPE_MPTCP],
+};
+
 BPF_CALL_1(bpf_sock_from_file, struct file *, file)
 {
 	return (unsigned long)sock_from_file(file);
@@ -11314,6 +11329,9 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
 	case BPF_FUNC_skc_to_unix_sock:
 		func =3D &bpf_skc_to_unix_sock_proto;
 		break;
+	case BPF_FUNC_skc_to_mptcp_sock:
+		func =3D &bpf_skc_to_mptcp_sock_proto;
+		break;
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
 	default:
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 096625242475..d5452f7eb996 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -633,6 +633,7 @@ class PrinterHelpers(Printer):
             'struct socket',
             'struct file',
             'struct bpf_timer',
+            'struct mptcp_sock',
     ]
     known_types =3D {
             '...',
@@ -682,6 +683,7 @@ class PrinterHelpers(Printer):
             'struct socket',
             'struct file',
             'struct bpf_timer',
+            'struct mptcp_sock',
     }
     mapped_types =3D {
             'u8': '__u8',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.=
h
index 444fe6f1cf35..3e996e097084 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5154,6 +5154,12 @@ union bpf_attr {
  *		if not NULL, is a reference which must be released using its
  *		corresponding release function, or moved into a BPF map before
  *		program exit.
+ *
+ * struct mptcp_sock *bpf_skc_to_mptcp_sock(void *sk)
+ *	Description
+ *		Dynamically cast a *sk* pointer to a *mptcp_sock* pointer.
+ *	Return
+ *		*sk* if casting is valid, or **NULL** otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5351,6 +5357,7 @@ union bpf_attr {
 	FN(skb_set_tstamp),		\
 	FN(ima_file_hash),		\
 	FN(kptr_xchg),			\
+	FN(skc_to_mptcp_sock),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
--=20
2.34.1

