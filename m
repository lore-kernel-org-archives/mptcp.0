Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E195B7A
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 08:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652948729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EicMjzMKXLKeLr1ZK/Z417d48fEFP45eGOnRQNY3JLE=;
	b=WQ6EUqViI8CwMfB9TUQxQBWnguvV+lx/cB2oY36r4ERln3JBbl95fZVvgdDsD9ZdhmZhWU
	uVLid4lhnFp1ov6168guH/tG+sR2Rntsg2OZyXy7uG7bxh/qp8h2AZTsT6wgpCB+TFZKe0
	81VJ79Dh6Qgwv6wh3l2QMXP5+YwvPmU=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-jTuayB5bMsa3RzXQGM6SBA-1; Thu, 19 May 2022 10:25:26 +0200
X-MC-Unique: jTuayB5bMsa3RzXQGM6SBA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcpSnPw6rCflU8EFudhH158jPfdyNn3yvAPg4o1DHVkLFn1Ge4YPLkY0N1RsLfGYQ5qIXvx/6lAjq1TF1Le0Y8i82kZS4Pk3og5UKzsHvq9EWYLpBT1/+IWxYBiR+B2H0XD/ahlu6km1g+ZgWcLMA6PJXcCZ5+TWpD3oIWwVTm6I+J/nI0IwQu7aKHOhZwzpPjXt4rMp47swm0qqoTlYHqaRwfkbclAeev+co+XL58MA8NDjF2eRENKuHhIs6dJMVWjQqS3093s4rQBxxPKIEB/piW8bENqpyfcgL8FmXuFSl/YT4frMbPl1t3wp4NICcjo3i9g0O/hu6YgNOzI5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msA2bjzTNSqodiZppHXl3qmzTBuJMov3KAfIA+L3yCs=;
 b=QFDfgSpPtopSn6WHEsljWuIfHZAD+GZPAJcm8JylTPsXwmOvr1ochLKCc9Fl5f41SM6kf773wBsGXFIPrHcQKnICShp7Q99gRQJ86mXtRSS2LO8Hl39+jvXvcmrfjwqqxRe194sF6Wxk/jeULX6rHaE5L7fnYc1Cbw53xjOOvRTZzGsyoaLSYlV8tQwjXMfxSSYYR+25Jdos2kLU4TD/n+A0fo8nNSWNW8qHuZ8gDgBZRbDWlgoBrLhXGZDnJ6h8orEzzL5Zv0sphVMnn2oWdGcq9XF8KMoywkB+YHlTrKiqXSHxBCPN9lKFkd9Y+x/wd1Hlj7cKyXG+dHgDTs/1+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8752.eurprd04.prod.outlook.com (2603:10a6:102:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Thu, 19 May
 2022 08:25:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Thu, 19 May 2022
 08:25:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v2 1/7] bpf: add bpf_skc_to_mptcp_sock_proto
Date: Thu, 19 May 2022 16:25:12 +0800
Message-ID: <6fb80cd069c660b3f86b8d283f58fb12a7af0bf1.1652948238.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652948238.git.geliang.tang@suse.com>
References: <cover.1652948238.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f93bf63-a7a0-4f3f-f8ac-08da39711fc1
X-MS-TrafficTypeDiagnostic: PAXPR04MB8752:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB8752B0AA0B38F4F34EDB2539F8D09@PAXPR04MB8752.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TfXq5UWhFHSjhbr9RtBYIQIzyn9uIoGCvBjNcbbL2hf/BMqSHQSCf3DjmLfsqLkzmtYVFC/fvfOh3Zz2xF6uK50NHs489TLCzA0t5xDzmUYexeYCm1/9oSv2uspvJhJXpb/qBtcozPxeSBhtMqN15UpbmNwjw7a1TR831019QsiPs07THfaOx6Pq+oUuDJ+EURKEv6U2D5kp4rScxK3a+ePmTh4bz+sOvxbILpMXTjhusipbBhVL+QFWEDh7uGMwMAVjYvDzegiTt3b7BuTgnIqb3TMh4vlxhZwnXLRZAYaByPTeuzRKetd8ASAIKll6Ay6S/SlyfUKfTMp6sJSLzmjPrSwYSZiNZoMFyZeKNodUneBscQEw4exdN8Z7kp35jchEVAdPsHPywlPwHPPBC/yPsfxTwMgjn2BisUlysVX3opix8kpBDYKmlMy3Mi3qAhgu2kg6zw0uJre8MauLb7755Q9uCwlrW7bc91LJBm5nk5ej4/jLWa7Gkl/hSbdRGhON+uK4c10U/IRP45KYgS5jX8CaXaq4kp7pai9UKl9YPZEKe8HKmQq0yInpONYE92OB8va0aqY4GozfnqV1+DCcifJhgHzEjfHNJJGaNRcUH59UrbuBF1zjVgNvLP1rf1F3i1XXo5fsHwdXgN146Gp+B8vtdEP+HYTBeBwBBzhoydUaaJfRJJq4RWub1FTQuO+C7hCUM7Vh/V+bXKeKhQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(36756003)(54906003)(186003)(38100700002)(2616005)(8676002)(66476007)(6916009)(4326008)(66946007)(66556008)(8936002)(44832011)(5660300002)(86362001)(26005)(6506007)(83380400001)(2906002)(508600001)(6486002)(6512007)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2AHHDL1VDp+P1tmhuc6PLhuTyIgM16t4j9frwDm0HIocziLpBtUaTD4yn5FY?=
 =?us-ascii?Q?MX4F2HQCS7QkzFfG+ADg5pjQvonqqqoI7zwJ7VA1oK9GwcM7kjDy25kp2B2h?=
 =?us-ascii?Q?sFYkSgDIBgsr0QiCc3cbmxT/dvO9794y8oQDHHZo6vUa6gBDa4ASRTCJoAAz?=
 =?us-ascii?Q?MS1ZdsMOHrvvCljE/hTWLjsI0eYWVbr+O5EgFrpYXfrM7z8lpdiG91W2VUCe?=
 =?us-ascii?Q?dAnHZfIcZpbkmYmcHd7CwX7A4Pl5W6sgPuR0eD/ZwP0fgQ5m5gJ69iDDFQZp?=
 =?us-ascii?Q?JxPm8DvSoc9a7/leUmh86R/4+Ej7PfFTPOI17jk3WSwaw+YbI76AiKuDB0jP?=
 =?us-ascii?Q?BrVM/RmTLtJ5fmWXFdUqySN19ItUnpgNXlbpRcB3/R/emzd39eJ3SdAMJ3Np?=
 =?us-ascii?Q?pXGIIrcoEXm3rtoFG/+3dLBADb9I0VcKDsmE3uccPjAEAfpK6QqVKynupAZA?=
 =?us-ascii?Q?C9iXZ0uUMFT2VZ5RbkP/+kmmHt6IXK+qi3GoTiYaxu+iaNuW3XoxX6H6+Zv5?=
 =?us-ascii?Q?kV8ou+qazndPyvwb8hJyCn85n0vhA5HkqIXugmUUz4OJ1B1I4jphvIOc2IIc?=
 =?us-ascii?Q?l1joz6CQwXLqCyD2h9FbWVwgWD6K2SGwp3GrZFh57HCJfoBeyxwl0P1Qmjvn?=
 =?us-ascii?Q?BqFB6OtdnYbgfPsjMv9rj85kAb1cIcL6lfyOeSbdsCPi3gOysGNRfI4nIfQv?=
 =?us-ascii?Q?PmNoZjTh9Ua+WywPAbqjcuvzSls+pZ/0Uy1NwJmgCNGliKok8jtHZh9fCZ2p?=
 =?us-ascii?Q?i0Vbkjb+Df22hHueh3McTrmRYYbP89C+KbpdzELyU11uB1DFf58QfPiCXRq3?=
 =?us-ascii?Q?UDDsuYsZqk/jp+gvU7UUI9A31yI37MyJDz3A1wzHlPIikI9k8dUhfatEHKeJ?=
 =?us-ascii?Q?DgFft+KpvMIgRxQ0seo4WGvNaTAYmKjMVrtKYisrvz0S5R/MQHt1UfJVXUnw?=
 =?us-ascii?Q?cXTg0m3ChGa2BTJ7mVWlw3uoV0P61+R1zlPGDSRHmBCpirnoc9/mWnAC67aa?=
 =?us-ascii?Q?DHrJmgd5aWVGDQ/Py8sETrqS+fq7wC0MW02/953uAc+7/nGFVC2W0XmhRPhM?=
 =?us-ascii?Q?5hxrjU+NfS8it4GcLgSTnlcB4qLUN3TwaXNZJ/iuRbGjVelCluu0B+4J5mBj?=
 =?us-ascii?Q?01w22eLSX/v7CmrjGKRuZPZUKP1DWoGy0cNTX9SVlhYe5EjKRgvFkuPI6kM6?=
 =?us-ascii?Q?DPy1Pq8S5GbzVbYmLot159ddPEn3l3zn0R/uq/dga4sPzidqZjS14ydFHh4b?=
 =?us-ascii?Q?UGptj7eJI7qfcLSma67bE1vYmYZXvZ5xSSKLj0oDWvTPsZDpa9Wd/pt5lvaQ?=
 =?us-ascii?Q?ksq4CgWgFTqRVjm+VveRXr5QaV8HjhIHaQxbbv9mlvSBEfHZR7B7ZAgFf8I4?=
 =?us-ascii?Q?GvUXBMLEZiWz0Rf+ARo7NsfO1uhBBe4fxtEgzTa2F6JZL919UkIfLdEwFTzQ?=
 =?us-ascii?Q?YukIHOQDl4G/VC5vABhsGtnEnwNVtlbrYAPzF+uQYXAteMAPlfhPmEjHemC+?=
 =?us-ascii?Q?6or95EVZAUkUn0EVoQp1Hl1oTPwy9uBUWi8FIXKlFFt/EqvPhElM0Mth7Cww?=
 =?us-ascii?Q?hVXc/ql9hNKAS7NjpBzamjvrkuNtAEHXfPdqRJKm5mFtqp11QVkaOdJDAqBs?=
 =?us-ascii?Q?yHOuF0ig4CFkJ7tr0zBRRtnmKKimc2OOdU0cEciHsyFOvUd1DmUmRJuDS9EM?=
 =?us-ascii?Q?aFN5pMm0hq1XZrbtFRNNDp4aEWIgAsV+dpUwRwbnPZVxYS+/gnL/MRGvp6VZ?=
 =?us-ascii?Q?pPUHKQfTFYR087ySTUSkjA1ndxmX+fg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f93bf63-a7a0-4f3f-f8ac-08da39711fc1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 08:25:25.5896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JC6PnKA9uPlEUVUdApt1eFu86WEeyJ8vKt6f9jALwnIylUJYBa12NagZT5ZyOwVm68WraNX3nj5UduN1BzTaVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8752

This patch implements a new struct bpf_func_proto, named
bpf_skc_to_mptcp_sock_proto. Define a new bpf_id BTF_SOCK_TYPE_MPTCP,
and a new helper bpf_skc_to_mptcp_sock(), which invokes another new
helper bpf_mptcp_sock_from_subflow() in net/mptcp/bpf.c to get struct
mptcp_sock from a given subflow socket.

v2: Emit BTF type, add func_id checks in verifier.c and bpf_trace.c,
remove build check for CONFIG_BPF_JIT
v3: Drop EXPORT_SYMBOL (Martin)

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
 net/mptcp/bpf.c                | 21 +++++++++++++++++++++
 scripts/bpf_doc.py             |  2 ++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 11 files changed, 69 insertions(+), 1 deletion(-)
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
index 000000000000..5a0a84ad94af
--- /dev/null
+++ b/net/mptcp/bpf.c
@@ -0,0 +1,21 @@
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

