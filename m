Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DF915B9
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 07:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652255794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+bLnnx2h1bEln3SAlCc0ZXPYN0SwxRpN9FGjuaOyf8=;
	b=TBLyYGEcRSM9RN/oW0m9Cb4VVGinWFjpmqHwvbyLmSNHSNwk/SUL/bOT9m+hmvwCTwvYct
	JQmOcDFob/NZdCCOjb4ARO0JG5aTLE1FOyr5lL4rsVdIFOZL6PcGYsBtoJuNAJojgIIMZR
	yigft8lI3/irmxgnb455QCG/FuLLdaI=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2054.outbound.protection.outlook.com [104.47.9.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-gEU30gr2PrKI8v7JxpJJ1A-1; Wed, 11 May 2022 09:56:32 +0200
X-MC-Unique: gEU30gr2PrKI8v7JxpJJ1A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6A+3yyVp8m0qOr96ETB1c9+WezP/BMBr8AeBuzUIbtDCTWDBkJKvUy9ygxjryBfs4QWNX8Lwfsxur3Qsh4Yx547c5m8S2EwxbzosENpov2LgZqPKELjkFHKP2mxyAPxoOEIC6Z2U42j2NL+UqAH3VnLCB4NdBfkAV6DJX53FgPBQ8xnBHzOhBIEggMuhg2FpPpfzDQCS98Hm3xNf/NvGjNtciMls1gQGK+9Sx6zsee2EUcBon1FHSEGzohmg9jXXNVzyWPoD1r23h77m9xhkYE1nkDXxXBoQe7AtZ66VdFSRHznrRwI46lgsQMyo/H/hemQ3ZyonF/xLuGYZYxERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNMUb3QdBPpsBnW5y5B3qCVSB3VxGyGixxiriiYkJjQ=;
 b=oROXclsBdFY1ihh6nXhgHKAOq8e53fsdy0lGgA5z9OoHaRyifW7jSW7bkYeGAShQSyG4sSMjT7Dz8iKvPDgD6Z1GLOsyhR+FBxd99Lo7vi4so6/80kcgEadin6csFJWtBqo2n4DFzQ/FJiicBQLns1dV1JUvKyy7H3pvGEeTU5JtXeIOeuuFcA1J73+5afxPmMonwk5nd/lYBTGauWNi8/mtT67u5tdV/y4KkB7hUZXa+d+KKMxIRGiZHy/RTQEVzzKkna9rEKpg3w5478TkrZY1/Nnd+I04nlOkKXaJjmzYzQoFq/yRjKgPbqmkQ9GkZxJXZ5YiOwW+iSOFg67Otw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB4461.eurprd04.prod.outlook.com (2603:10a6:803:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 07:56:30 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:56:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v2 01/14] bpf: add bpf_skc_to_mptcp_sock_proto
Date: Wed, 11 May 2022 15:56:07 +0800
Message-ID: <f57fe3e85dc92263b9320a37d2c80b370659b991.1652255615.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652255615.git.geliang.tang@suse.com>
References: <cover.1652255615.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dd3a061-8f2f-4b02-8a32-08da3323c263
X-MS-TrafficTypeDiagnostic: VI1PR04MB4461:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB44617CD301C5F8F727FB6E24F8C89@VI1PR04MB4461.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BhzFmw9EfzU9WbETO4XMxIdUSwLf8Wc90li7Pc8zPWmSim7I8wCZe0Roa7/P38qmk9PmwwB91Z944ODxoCgVUJxUXYYGSrDpQWK+TP4kGeHwz/Jn6nrK9FoMmrJJBemTVWjEk34lb9bPuQajMbH9GODdI5CZbkGZ4xXlnx1oeFlNjxpXiSxNT59yfFR89K2DuNhpZMIWiiWN44G53i2acgQTckhkYTcAA8g0jiBc1Icw2OthHODPPH6Tex5FpezN1rqgVdjriYred9sHmU8sKrzPFg58NXoUg0EWU5CjHmNa+0qh7cmLX5x765fPrqTTm40pE0oQAG1jZRolfjQQGBbWgNXLnypKF7gGIj/AIc9f2rq6VnNyxdGB5jK03/G5s9Sigf+kywYNuKgUlpZCz1ZWy/Z6INTlOQI5oO8e1quAmmN7Cl8maCL2o8SNYp5hhpjLKR84YHRWPqdMR6UqIOomI7UQvv0+beqYGxcIN4LODsZ7IVuVP5rDJ3QOwZvKg+16U6YC/LbWHcs0iGQH4pQ5ULrOa+RCI0NAHN5GmOSBi9R9s0w6B8GCl8pBKZW5Xvtmtcpw3BWZ3tPFbFQBYUo9fciuYBc5z43kX1BTjQzJKZR3E6M5LZpjjPXKuNax841mh/uOwS3O1NvDJb7aZNT1LqZ/Hhg/Iw4iLVMS4mDz4WY9evHCLEhI7QcZZlvI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(508600001)(5660300002)(8936002)(316002)(66476007)(54906003)(66556008)(36756003)(186003)(66946007)(6916009)(6512007)(86362001)(2616005)(4326008)(8676002)(26005)(6666004)(83380400001)(6486002)(6506007)(44832011)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mKuVqERTfwgailDb4lwF8Zir9yYfCnvmsZG2+d3R1zXcl9/8RCB3e1IyKFaW?=
 =?us-ascii?Q?UyYl+9JBxLyUPejroNmv291VwlevZiIAoT8qZcTR6YlGeOu1p09X2yOl4Jcy?=
 =?us-ascii?Q?dbPS3sPfTcXtjslyewWctcXe+DkazS+g5HYd7ktBVpymu86md6Eybs8j5omv?=
 =?us-ascii?Q?sjJQh3SlTrpBWuvqpFE5cFx5mIPs2XDm3e9Wp6eTqjvvd7uKC4F7Ds+NNZlG?=
 =?us-ascii?Q?6MRbqDi4uIiXvoQlkYNkWzySqPZuYQp3TCTTo/IKcmR7jO6NYmfQKXKxrrz+?=
 =?us-ascii?Q?lxT6qc0tIYTyvfwg5FOnFKgQfaMZZSZEoiXENh1jtmX5P2ksUREC5EIdIsvY?=
 =?us-ascii?Q?iP3ylNENahgHr4L+LCW3NzN+vyz/nXIV8VQLrW/ce5exGCd8Zt5mUjiJxZ5d?=
 =?us-ascii?Q?Rh2wYyAvlvx4S6UkymgSxUhTV6LJ/haSdVW2IWAykihv5vFRUTlbW7jDja2d?=
 =?us-ascii?Q?O59076e1/W47wPkxyMObV31T8F03d9r2G2QbvwQf8z4KHvxMCNTWBszB5eHh?=
 =?us-ascii?Q?aIsA0+0yZKknrF1bxWzMSrBuNLYHu1FcWrfUOPM92mphd5H+fcmeEo02Qquv?=
 =?us-ascii?Q?IJHzN4y3cT/dqZTtR3Y0DIp4BnQ7/aHoMD2LNsHXUB1M4Xseqrk+KhppwjDV?=
 =?us-ascii?Q?CA+ncwr2z4h0D0SpXaCdNwezRrFiGy65LS4lMgFPP1RktWSlb1CSPhtqtIii?=
 =?us-ascii?Q?oElGEutv+SRcpoIt8CMx3DTsbAoQYISLseXxPYzc61Ri88YTs7Q2R94mO8/K?=
 =?us-ascii?Q?TGm4PuV+xtt3h0P81MnoYfkK6fqRaJYX4zwJjlJSCXnWDhebJFuvvU5nvaHO?=
 =?us-ascii?Q?ryvzIjDD3xVzPaP7Tu9Fgux5+WOsyxXmvP3sUfaItJFrEkJc2u/QjES31mkZ?=
 =?us-ascii?Q?PJ3jHo3tdeb6xrqzAJxS9QT4CI1Yb3anWQ2azbiQ+VR40cTAL5iVXECvpAmN?=
 =?us-ascii?Q?DOHIZ+TyvItfonqIKQKTlOWtSaN/hB61aR5iFy/sSJQhROA8U0x5MGE3JTFC?=
 =?us-ascii?Q?EkBvC+AspNe3bYXyporafDI0zXbBLcFJTj+G2HwDBfGc4+GZYMJuoLLAMT1D?=
 =?us-ascii?Q?BGLXBtr70PvUbnusqdAUuk6FOJXySDiuPzn5aCg3e8lv4cjMU7WnTzJbEPoG?=
 =?us-ascii?Q?w283uDfOgBVo6Z1891/FRQCdD5XZpYLvV1t9Z7SzkLpVXIx75BaWqbPZ6xnN?=
 =?us-ascii?Q?PllC4XeYZYzJGXSu+W9oxWGzSgoFi3g9edA/vuv02PoeF6CtdssyIIiMc6DL?=
 =?us-ascii?Q?j4khNO1P6XLCDGq0Np75ZPQ6yJeXO13zf29ytMGM7pFaug5/17vSgA5KltfN?=
 =?us-ascii?Q?Ruy76lqInDu9GooFAQWKuKZDjYWqHlZBTro+c1s5uif/W/p32yIIu7KfKgCU?=
 =?us-ascii?Q?dxCBCw1OhdiGZ9XAZO1nnLkiNHvQ0itB/AFwl6zZFA11tt/Lj9AxWko6b9xv?=
 =?us-ascii?Q?pby6Dqtdioh/g7tweSgrVdKmcrTxoaSFpRHAvFYPkLZrjZpI8H8zPWArdzwR?=
 =?us-ascii?Q?PM7OGptczfhZZUtIj7uDasgVp+AAlwHc9miBwZXOKH4TkDNoue/zDzDnN2Im?=
 =?us-ascii?Q?TiyAnNpc9GRN6nGNLQyFymZevzM4/254Lb8i4e70HKV1XAQu6kjgi0w6zXGp?=
 =?us-ascii?Q?kwX3d7Piy5wHfzoZAontjFMx3KFkY9+bDdUdNmkh8NrHXmtTBZNv3IiTT4ws?=
 =?us-ascii?Q?dOGqsltAJMXbR5MSGEVutKXseRCOGGc7aQYWXccg50zeqfIXa/mEAW0nrPaI?=
 =?us-ascii?Q?hHvhHU6mn2FXaIpHv8UUzabgFY3QvBM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd3a061-8f2f-4b02-8a32-08da3323c263
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:56:30.7021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuX7Z5bpPBlZ4UWfmugLoECAlAVLeWV4TYW4xbEL/FA34kTaXmwUnLGBFsFpqqWXRPXq4y9zhruZqOvRqTWP0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4461

This patch implements a new struct bpf_func_proto, named
bpf_skc_to_mptcp_sock_proto. Define a new bpf_id BTF_SOCK_TYPE_MPTCP,
and a new helper bpf_skc_to_mptcp_sock(), which invokes another new
helper bpf_mptcp_sock_from_subflow() in net/mptcp/bpf.c to get struct
mptcp_sock from a given subflow socket.

v2: Emit BTF type, add func_id checks in verifier.c and bpf_trace.c,
remove build check for CONFIG_BPF_JIT

Co-developed-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf.h            |  1 +
 include/linux/btf_ids.h        |  3 ++-
 include/net/mptcp.h            |  6 ++++++
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/bpf/verifier.c          |  1 +
 kernel/trace/bpf_trace.c       |  2 ++
 net/core/filter.c              | 18 ++++++++++++++++++
 net/mptcp/Makefile             |  2 ++
 net/mptcp/bpf.c                | 22 ++++++++++++++++++++++
 scripts/bpf_doc.py             |  2 ++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 11 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 net/mptcp/bpf.c

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
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d4ec894ce67b..4d761ad530c9 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -284,4 +284,10 @@ static inline int mptcpv6_init(void) { return 0; }
 static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
 #endif
=20
+#if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_SYSCALL)
+struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk);
+#else
+static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *=
sk) { return NULL; }
+#endif
+
 #endif /* __NET_MPTCP_H */
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
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index cb7f53f6ab22..6e7df47c9584 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -10,3 +10,5 @@ obj-$(CONFIG_INET_MPTCP_DIAG) +=3D mptcp_diag.o
 mptcp_crypto_test-objs :=3D crypto_test.o
 mptcp_token_test-objs :=3D token_test.o
 obj-$(CONFIG_MPTCP_KUNIT_TEST) +=3D mptcp_crypto_test.o mptcp_token_test.o
+
+obj-$(CONFIG_BPF_SYSCALL) +=3D bpf.o
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
new file mode 100644
index 000000000000..535602ba2582
--- /dev/null
+++ b/net/mptcp/bpf.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Multipath TCP
+ *
+ * Copyright (c) 2020, Tessares SA.
+ * Copyright (c) 2022, SUSE.
+ *
+ * Author: Nicolas Rybowski <nicolas.rybowski@tessares.net>
+ */
+
+#define pr_fmt(fmt) "MPTCP: " fmt
+
+#include <linux/bpf.h>
+#include "protocol.h"
+
+struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
+{
+	if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_=
mptcp(sk))
+		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
+
+	return NULL;
+}
+EXPORT_SYMBOL(bpf_mptcp_sock_from_subflow);
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

