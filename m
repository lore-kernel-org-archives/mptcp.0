Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6647E
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 15:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646320985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WM7I/W20rlZ/WmEIHVCw3hBkcnYpvZfBnaQYYVMe6jA=;
	b=avZvGZ7QWKdh0tkNYASVAQG+Py2lMihQPEteoaMnZ4iZHvMwrZHVxwJxuta6dNayfCbqkF
	W3jiWbGFClV+TloBrmJYOELNoccQbjcTOs7R7O/SBYABsVJkdoRZylXC4flmkkmUVe/+aX
	PqCgxZVEwnjHfAJxDMiEJ02stmgDySk=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2050.outbound.protection.outlook.com [104.47.14.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-xb4Hfr91Nzy-oLhchGmMGw-1; Thu, 03 Mar 2022 16:23:04 +0100
X-MC-Unique: xb4Hfr91Nzy-oLhchGmMGw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drk0uXR93qYIfffm4pgbXkB++7PlNDzINX6I68+rWQSU3jhlrF9Ed6+Y64KqKYprHQdzdSSxhov5JfBsGJ8EqEXKIqzFAJtVbU+drdwj0ZRp8LJ9O8psD3Vi5QMb9wU7GR+sNo7C5obDkoX32yTHO7PmCr11u14pZoTbfEbGyTzqRONvQcodNAa870UwS7xBJnyteeQJrDvYiiJPTbqGzRj6AdfiFeW/ezcoLE3coWcFN7EVDqZ+BiBUhF/gHYBkwDU19du/2az8hGYL1iJsS8knycQ24gMWdFrELmr6qit2HoLwtVejztdjTfMUvDKm4Hv/quvRDNbM3lUEFjFMzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xvHKsOxzZ9F+E+cR0eK1TFp4Hl0Uj/N1LTO8cu6RZE=;
 b=Ap8Ex2rjoWJ3yKrGqTBxpvPIJQMXA0VbTsNB1PYPyIGlLDWXZKLFaNpLrnT0qYVN+UzNaGjPnYjFYEbc9veT+ODyzJvFMtcyqeSdVk6LoXxVB9jgID5WD+/2C97UI/IR4eyzsPQmKju1MHQDinKkzSLT0J69uym6+BOp9YT/TOZpd9bK1W42frDNtBzZf8rUrAmj26y4yeeFMPt+xS2kJrAXCiNOnLSyNbNTnJpDQIiHU911KRh5pKF/Z5mD7h2rd+eBJwP+BKt5fGTKt3iqBdwPR4shEcnrUm1j4w2GhLg0M86o1kdLDBOpPV9XT7ksPSXZBsDxfG6chlZc4tU76g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB3213.eurprd04.prod.outlook.com (2603:10a6:802:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Thu, 3 Mar
 2022 15:23:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 15:23:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v5 2/3] bpf: implement bpf_mptcp_sock()
Date: Thu,  3 Mar 2022 23:22:37 +0800
Message-ID: <cb3f55a9c5ef9b89ed5da8949192077fb72f275b.1646320786.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646320786.git.geliang.tang@suse.com>
References: <cover.1646320786.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0056.apcprd04.prod.outlook.com
 (2603:1096:202:14::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70bc0a8f-c270-4377-d3eb-08d9fd29b548
X-MS-TrafficTypeDiagnostic: VI1PR04MB3213:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB3213BE8C293D70330FEBE89DF8049@VI1PR04MB3213.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a+6CTMpaIp7ko5O47eDalzKJ+cxYAgQNGwupJhnnAIleajcKFXKK6JC2G3lfZ/Os4HiVuZ9qshmRKYrFRKP/ArbaA83AcfJ1gdRRYk1SKZL9jG1nWyYXHylBcecc5h9ZNi9xU93VrP8a5f3x7NHfAWzHzFTJIkgcFySWK/cPzbzNnP0mCgC+oA67LQ1OmhAvkjCQH+A0GNBYSquowjkwJWyzxvrBztBasbGzb9oK1c1thhE0VNcWrk1bEYMZsE8WBELEiCszrt6RkMZJMrKlODx+Q/PceYqTDmebp8RPnpkFbH93qv8vIuESwge50nfVk6f5wyU5BN80j4Nn5QJmANs8eeP73ajaXxyUdrjcQCnXMTFsQBnmW2m6h2TWgPE7rOL8PEdN7my/6/3TuvlXeVPVcQ+PT+fakSEAOohzTjAHdG531U97itnHx+XJqRFDjPtZyCuX6ENGDdZehZ4x77Qm50amBWgolFZi4U6P2T2g/hIoT80hlZtDc2bOP3BNuwwyvaYSrPFk6Wg92VzY3vAWJNqg5XHkxK7KnQduYAL9w+D027dKie38Ni+hfGMwfHrWSlRKex9bx7XSm7AcEZoauNXRQW7cCPHKD8Y9CK46vp2NznVRYe24UnnFqMe6r3o0yF59V2v/0icALShfoqD9uiGOADGBkB9pgyD5NgkhbDXE2Pfoxc22bGZS2flLmQLdL6ttFuEr2vjZMLsClA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(4326008)(66946007)(2906002)(66476007)(2616005)(107886003)(6666004)(5660300002)(6506007)(8936002)(8676002)(6512007)(44832011)(316002)(86362001)(26005)(186003)(6486002)(6916009)(508600001)(83380400001)(36756003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4SPO7htfMC+fdnTVY1TBQsxQ0bUg/yfoEckiLeL/O4rEutLZlDsIK/+kfQBN?=
 =?us-ascii?Q?8PWxE7nhRLoNpdFTz4+M+HJQEtqnoZ4x1rFncWPIh1N7HI0NWDNyqhFA4h0O?=
 =?us-ascii?Q?CfT+yhgNMzvgokUUFf4TLJGPAVjeNXMMMkWKMLKivtG89Z3p3nDW+UOy4Oaq?=
 =?us-ascii?Q?ecY8TBZ0NLJTOsobCIynhhRfWZoA1kIUWrVxw5gqn5WRWEMKJPcvX8qewyDZ?=
 =?us-ascii?Q?cX6G5Iuit6kTNNohe3xACQ1dXC8tm2pXj1/B7wd8AZUETbmsNqrAunDUpsYJ?=
 =?us-ascii?Q?WGAgcPZfeJV51uFagsffGXESez0wApqXvStOWZrhipwfaDg5ix8Nj+Q55kLZ?=
 =?us-ascii?Q?1GL+OFKcYWsRh6KGNEME88hUCnm3UJrnDYNif5Eg+JE4+XrKs4dV26zFtHBt?=
 =?us-ascii?Q?4I8wn6IzHLqKcftJaH1L2JWXq0W6Pn5clTSwGaQaPlpjDabHHj87HzIA5JNg?=
 =?us-ascii?Q?U8RmkadJZEY2iCg0LZ8MfoHrRSFskNp4jNiwhmTaKabYtGacmrrBu93gFiJs?=
 =?us-ascii?Q?XrsthbWvZ/t4TxD2b9/c39gqJJZGxjDYo+Fjzcpf6wCNX1RlTv3pO7Y7APZf?=
 =?us-ascii?Q?TBRsL1C2dkRFm+BmEP5pLq/5CxiYS6aH4hugIObbTeZbILN7QtEluOyRWpgm?=
 =?us-ascii?Q?V6uXXq3Gf48Pz/0STmZQbF6amsl/9qr0xcJh8aNwbi93DfQeFOKy+dyXnGCP?=
 =?us-ascii?Q?FFvRczD/mAGcSWW5K98LAsQiuSDjeU08qm9k4+SM9w+Dub+kdLxl6L8pAzqq?=
 =?us-ascii?Q?AMPar7SKxHZ60d85nk40ngKDqcz5Ur+nz4iRDnt1FfuPQZc9n8k4qm6BgLpo?=
 =?us-ascii?Q?YulovMyKm2gzMusHnjVpGHxOAfbaFfV2eANniWqsWykIjx6iYuAturI/sWCn?=
 =?us-ascii?Q?9Vt4N5y1beukMSdpBC1t0O8+D0FKAYBQyJulPxN3XSViwOFAjCvvoLBTz5EK?=
 =?us-ascii?Q?5SRcC401/sQSDGlFb8XpWvKF3x1TX1lR/KCxTdvzoXGBSr73EbWgHO43NeJ8?=
 =?us-ascii?Q?brxl0Twf44k3hrkdbeeUuhgG2E3mKVSCdZN1a3F9L9a2PXK9nQd3Y8LK2eMK?=
 =?us-ascii?Q?oPKI72DMFH51a3i9VPuHVJiW5DQ6ezQ7fiTEvkH0FBsXCRc/sd2od14z/jFL?=
 =?us-ascii?Q?dMebrS05B1hBtu2kEvvxcY5LMV36xGjtS46VcZ0HYcO5eBrXcWxrIjYFKphV?=
 =?us-ascii?Q?tZfGAG5stfmVmzLckmO1Qb8CuV9u9Rx1UEgwQoldS8b68UHsP6FRZDmeW7zR?=
 =?us-ascii?Q?HwK2Zjx/rsMWPF73r1ZF9XkQoTey7QtXz2OK4XRYpktZUfDp4b+3uufaR6Jy?=
 =?us-ascii?Q?GkibZ/DinSqe+MsCNG05py2oTTbfcnTJSo+AavELPckeU1Wjfd5KQOQIXK3T?=
 =?us-ascii?Q?UlhXWsoFHifAqcJmeXWWz803YgAxsxb8AMdmxgUQ+5USEteGl6MLEEl+1dt2?=
 =?us-ascii?Q?SJmlFR/Dtv1L+Ys7+fTYeZrlyuJzz4Ol38Ej1fWMDnFeYj4H420Ov9M1Kb5o?=
 =?us-ascii?Q?Ri3wEysdhznZ/onKTrqgVOPcWg166BjqjT+lPGisdWItkJWXgAziHChaOcHW?=
 =?us-ascii?Q?9JLNuravDQaxNlglAJEmdTIpiB+S3Ypge5MfO7epRE//0vmXFt+CDFwdjYBl?=
 =?us-ascii?Q?0v5cMngLK6zvJcoEM5DUKlo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bc0a8f-c270-4377-d3eb-08d9fd29b548
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 15:23:02.9852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/o7vCKJ+7wk3BXS8K80Gs2/IDnMaxjsZySubDsOh4CBH8eu96USJoYmOFkBD/Cv64IX2hFTu6G7gByYY3CQmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3213

This patch implemented the function bpf_mptcp_sock(). Defined a new bpf_id
BTF_SOCK_TYPE_MPTCP, and added a new helper bpf_mptcp_sock_from_subflow()
to get struct bpf_mptcp_sock from a given subflow socket.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf.h     |  6 ++++++
 include/linux/btf_ids.h |  3 ++-
 net/core/filter.c       | 17 +++++++++++++++++
 net/mptcp/bpf.c         | 15 +++++++++++++++
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0ae57df2f226..38290b249d5f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2359,6 +2359,7 @@ bool bpf_mptcp_sock_is_valid_access(int off, int size=
,
 				    enum bpf_access_type type,
 				    struct bpf_insn_access_aux *info);
=20
+struct bpf_mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk);
 #else /* CONFIG_MPTCP */
 static inline bool bpf_mptcp_sock_is_valid_access(int off, int size,
 						  enum bpf_access_type type,
@@ -2366,6 +2367,11 @@ static inline bool bpf_mptcp_sock_is_valid_access(in=
t off, int size,
 {
 	return false;
 }
+
+static inline struct bpf_mptcp_sock *bpf_mptcp_sock_from_subflow(struct so=
ck *sk)
+{
+	return NULL;
+}
 #endif /* CONFIG_MPTCP */
=20
 enum bpf_text_poke_type {
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
diff --git a/net/core/filter.c b/net/core/filter.c
index f64454722a7e..83ed8db32c79 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7395,6 +7395,19 @@ static const struct bpf_func_proto bpf_sock_ops_rese=
rve_hdr_opt_proto =3D {
 	.arg3_type	=3D ARG_ANYTHING,
 };
=20
+BPF_CALL_1(bpf_mptcp_sock, struct sock *, sk)
+{
+	return (unsigned long)bpf_mptcp_sock_from_subflow(sk);
+}
+
+static const struct bpf_func_proto bpf_mptcp_sock_proto =3D {
+	.func		=3D bpf_mptcp_sock,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_PTR_TO_BTF_ID_OR_NULL,
+	.arg1_type	=3D ARG_PTR_TO_SOCK_COMMON,
+	.ret_btf_id	=3D &btf_sock_ids[BTF_SOCK_TYPE_MPTCP],
+};
+
 #endif /* CONFIG_INET */
=20
 bool bpf_helper_changes_pkt_data(void *func)
@@ -7850,6 +7863,10 @@ sock_ops_func_proto(enum bpf_func_id func_id, const =
struct bpf_prog *prog)
 	case BPF_FUNC_tcp_sock:
 		return &bpf_tcp_sock_proto;
 #endif /* CONFIG_INET */
+#ifdef CONFIG_MPTCP
+	case BPF_FUNC_mptcp_sock:
+		return &bpf_mptcp_sock_proto;
+#endif /* CONFIG_MPTCP */
 	default:
 		return bpf_sk_base_func_proto(func_id);
 	}
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 2e42a95d1206..e3213818c45b 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -25,3 +25,18 @@ bool bpf_mptcp_sock_is_valid_access(int off, int size, e=
num bpf_access_type type
 		return size =3D=3D sizeof(__u32);
 	}
 }
+
+struct bpf_mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
+{
+	if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_=
mptcp(sk)) {
+		struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+		struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
+		struct bpf_mptcp_sock *bpf_msk;
+
+		bpf_msk =3D (struct bpf_mptcp_sock *)subflow->conn;
+		bpf_msk->token =3D msk->token;
+		return bpf_msk;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(bpf_mptcp_sock_from_subflow);
--=20
2.34.1

