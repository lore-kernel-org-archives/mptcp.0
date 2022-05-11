Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266D215B4
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 03:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652240380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuHI0gGsVN/rSgifaw34VkEaTkPb7irTtsRNAZyp+RI=;
	b=MjVRaT4tjbh8YkP4Z9WKLKMXDvVTK4w4DrjPFw0e4JLGvUIi6ld2NmgwFCXGvaHPePe0fG
	TOrXLRurBoVuZO1cbOxoFkAcN0iM/Yc5h3fMTdxt27VQ7CDMZn1YvNKrtzwpLuzX2zimMt
	AaNWqaSz/gHLRndrWPiTrmMWw2G2If4=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-1uczR1xkPiKu7vvifIDHZA-2; Wed, 11 May 2022 05:39:39 +0200
X-MC-Unique: 1uczR1xkPiKu7vvifIDHZA-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mI0HT7EMX81M6i+QKkHipPH9O8eTLCjL0vzpJIJx8j/ZbIs7zASIdpQlos1jhuVDxJal8lBzh67AJUHXzxJXrN54aIiBlUUU4nhj1mTyktjfhQgMlOvNKkWrrZUOLpBhCGlBRVtErtmwidH+eLdy6RvXUUrUTvZA9S7QPw0sWdRTORHUUMXZiRnsmEliJ+fxlZVXp2w1xLdONIUYhQ/gn3BhQ+slmwlfjv16/rFkGMGf1Yai3or6h/1xVIZBxAn8RLYwk2aa9lUnkC7FT4fi9Ua5AU6Kw2+Gnl+eB0Xzlu3+H445SxNXd01EdgWmQ2FKxFwatGHyGAE4jkSc/CeAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAaaqp5lXAu/Qsd4rXbGY6UownS71onl3rE6p0mTtnA=;
 b=j7c33gcrQawSpWkMBy0ucDoztF4u+2rOp4XxbJeK3VXdFmIX0q2PVmMJnNpOOz59SN1xwQUdauaiLHK/trRU5ntICdU2nfT7oCzjZ1ikI4XHc9aLeVq2X7w8de0gymR6PEuPBkUC4TJ85QZgGV00wQyc/+copjny+Ea8ObLPXRtT4qgF72dAUvXJuj1xNhHSz5CmvKXXeo7cx1snHnx2aeLk23LEgTy5aoy6ZXbSwK1BML/uZLZJMVibajyZykUnwzNUney7cSzGHfMYC9G3p9KeCMYhNuVBvTHwpOfx1wsFQjXgKjFVkcg3hKStfpbP1MmOJlnIS88kZ6wKCaAhhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Wed, 11 May
 2022 03:39:38 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 03:39:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 02/15] bpf: add bpf_skc_to_mptcp_sock_proto
Date: Wed, 11 May 2022 11:39:03 +0800
Message-ID: <014d32e98bbf9c7fe27e070e9897d82eecf98df0.1652239604.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652239604.git.geliang.tang@suse.com>
References: <cover.1652239604.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:203:b0::24) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a0e4fcf-5376-4fcd-1e56-08da32ffe00e
X-MS-TrafficTypeDiagnostic: AM0PR04MB7156:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB7156E883ADDAC1B67B32B24DF8C89@AM0PR04MB7156.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LN8rcxM1cHJL5kX7vSA9VnRVZSKxE3IJ/g8ERLTd2FVCicecYWAyoxQm6KdcxIdav1f68sZvcau8cc/AG4usH9LHsui622oCEy06Uuk8RE1+3AiUsxCDY5DLOqgzYOWxcPSJsEnjCXGKfHFWA7JHTmm30ysyK7xLoAJ3bo6H2wKdld6E4aeb9BaDEfp1lBWtzSIGbBezV62UonnMBNaBJ1vfgVrhR89VeR2okl3AHQWrzn7RmWLMSO0o7EhrFLKXFoHw+k5odc67eOOSqml52ezcwGhOA24puNd0K5yw/v2zFXXtJz2XcLmgcr85AfjUuY8ZVSO1DPapKwscv1q9W2n8KlDV/mAe/9vSOBoKIxuK4wZ+0c60Wyk5rQyzjZL2Hb6BpdkFpyhneP/fPDcLFg3ByIUWpxRFu8W6OrMYgPqYf9i8rJ1P1oh0+Q5eCu7mQvg2kWnT4NbFGo6f0pM8n7cZKHbV2STPrHgQ/RP7teyT1cC1ZBfnJ998xsBhfiUzU/b1P+XcdE2Ua6qDI1j++EDgDXsa3Snz/ckbH44TO6WZd3CwGysUmoUH1cjH0oNiHgguJhRFGlOoecFOyH3Gu7oJKKAM/LglkS2TZtfiYdem3eI6dRlNAoBwVWxW5wMRoQYlL5th4Y/g+wL3RmTZ9iVCpUsqvBgI7y18qcIFm78p6czcXUD3Jr5sInb8acPy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(86362001)(5660300002)(4326008)(2616005)(6486002)(66476007)(8676002)(8936002)(6506007)(66556008)(38100700002)(6916009)(6666004)(66946007)(54906003)(316002)(508600001)(36756003)(2906002)(44832011)(83380400001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?axuSCqWcokAurjmzw6ebbejkuoTuaqJ6qWJu8OY+0wlq/UKzIfGu/d7a6gMY?=
 =?us-ascii?Q?WrIJiZWzxGFMJ/JM/TwgiUU8N9fjhn6vTjWEzPhRSAw7OOzOzouiz6i6et/F?=
 =?us-ascii?Q?o2rxbK9a+D4+poXoFfvhPHKGx8tHY3d3J81WHajYW7wHOy35dbqsLHDbYrtF?=
 =?us-ascii?Q?hkfM4wpMIofzgryuegY+rmOxt53/Se1cqI8e+z8eamA/0+HxDOvIWwQyqjh3?=
 =?us-ascii?Q?ogU9sqgwt6xo4cOXswiFs5LxF34ZnPZyNOsraMDt8EhzH45N0X4AFzMFojUu?=
 =?us-ascii?Q?Hny4Fp2n+LRmpRpn8OijapPI+7E3BGg159c/XLiULtA02rtDR9MpbX1iapSU?=
 =?us-ascii?Q?Opa8/gOw5TIYL2+EBWhvgnIPjBCCpeIRudNs0cbsF0Cv+p/N8gR7HRZo4kPr?=
 =?us-ascii?Q?SOImQ9MIVYdmsKBjE3GEQ0VFfzhGR7kVpnQ9c+P1EpA5T2uiuo6IFxIgzn8H?=
 =?us-ascii?Q?BATc3y3wVcoirgwrzHZtw4tJ4UzAVaswK7RCVYwq64pgQLNkE3L58/5P5nfz?=
 =?us-ascii?Q?MMRp5cL8q2ELp5pEfaCx8D4BkeLIVXhXfTRwRJXLNqgIsAgeQK+JBZCJnP1u?=
 =?us-ascii?Q?InGsEvkzK4YsAffiLZseILtCA7GdKMMQ8pHsysUFJa6VkkcuWttGmELUvzEX?=
 =?us-ascii?Q?kGLpKBnFI6L78k4hMS5baJN9OLnHUP1xi0bmmnlMwj5XKYjQ/m0uiBDx3u68?=
 =?us-ascii?Q?5isIwv5OU1jtU+pwPjfl9DF4Qt2wit6xxRCD0ptoYDDx8SzKyLCYorYh0pij?=
 =?us-ascii?Q?CO+faZmSjMcSe4MegeXDcOgnOsQeI5D1PuYyjIKkwJTDpatWx/1Qsh9eZogK?=
 =?us-ascii?Q?1o5ukZFDLvoCxfsYXQ9haVQ+T2gIwQ7nImQVr2fU3ITHXrDoCeHyo2qUrApP?=
 =?us-ascii?Q?HSQTyZwBg/gaLDmbBd8K7UHjR3ZpM4IugDKfDxgD95oK9cS0HOMSxLgHC5NZ?=
 =?us-ascii?Q?uJ5F5b0PMiZNPYoN8QvYe65mVJ56Rppcjv3oqttjcoANZBb5Rt9fleiOY086?=
 =?us-ascii?Q?ioRzlngimY92ncwQkwe/RiKq19ct1MdZMtX3vcGo5QwjhJNRZTy7ohU4ch1r?=
 =?us-ascii?Q?xK8zTLZ1fMgUGseDeahpgBJ/IcI8KmzscydfPZVD0PE8lBW++xeWHWEwREm3?=
 =?us-ascii?Q?LSC9gpVSO9ZDr69L0CTwL06u22AS8N7kI/nuQ1n2HLmNHoYZBPcQlfJU3g8l?=
 =?us-ascii?Q?Q24WtTLJU6xcgeg28wzmRUxjeS30DnREbrAgJSz8ir/Sot7+d9pmXejK870A?=
 =?us-ascii?Q?Plvg3ElMobshozy55Gfv+5ZqmweknTwxuqXpdzHI0Nrg82b5pH9GyN2Eo7hi?=
 =?us-ascii?Q?iSoP+FS1473NLA0AoIkMe6wE4rx0UtX0dMr5coYnvTSk8cxQTy9gUUFFldUd?=
 =?us-ascii?Q?hmHAYChy0m0uuuE99ppqf/aljwHAGypYJsuY6EJ5ZjkwXC81qMLWUdnu3Ybz?=
 =?us-ascii?Q?JqePKNdL8cz097gs7TnZnxCpOTxPgehmG0KZ6p+4rwWMUYlPENvqdwk/jSCC?=
 =?us-ascii?Q?wlavyXnvUoW+Af1d3QozYXiH/w6KNmYBNU6Wgl+o350A+KYXwPRLT2ga8KjO?=
 =?us-ascii?Q?Sk4f29aDvkWiA9eEg57Ac7eHChr5mQdhK0zwVIAMTjkfK11N1yAmkE0KG1CH?=
 =?us-ascii?Q?nQwtHGMh9rQ09kMrGlbf6DwRCu1RTU5hxoqE2szGV/RDsSf53DwmbX+q5wmi?=
 =?us-ascii?Q?FosdnsczFJx9yid8/jXDfR1+zGmi7V/I1BWvgxgIMnSR9b/s6au1U877z0YY?=
 =?us-ascii?Q?TIhAHz4MK4MA2zH35GmoHwS04v4lFCY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0e4fcf-5376-4fcd-1e56-08da32ffe00e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 03:39:38.5604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IH7CKTmQxh3uPVdLnW593dT5AQjBjGpCBg90UjjaX1JvZ7toh/QLZxb4flertueRfr0KjLIG9sMNi1RIFTRytg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

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
index 7043f3641534..56a66778dc28 100644
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
index b474e5bd1458..b39e4af9a0ec 100644
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
@@ -11279,6 +11280,20 @@ const struct bpf_func_proto bpf_skc_to_unix_sock_p=
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
@@ -11321,6 +11336,9 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
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
index 7043f3641534..56a66778dc28 100644
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

