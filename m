Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0F87E
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 14:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646318906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idkAu/GV1XBEd0USUsg0S8la7TmFGY5C2bHtnQ+kaPE=;
	b=lcjK2+9pq9eqqufIpHK/XOjEOtqNIKO2nFbDh9m0zB0V7BGFISgrgRFB6VjPdZXFAIJCSm
	N42R2CwNDI8jDW1FoB+616Ke+bUNJbzsvKkLHhvvImgXdpTMixWcQ3Qo/AcKdgWhx9nVOd
	TfONSi65vteUwT+qqYZxeWk7QRqm1eo=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2059.outbound.protection.outlook.com [104.47.8.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-G67zoQJ9NUK8m0wUR1i9Tg-1; Thu, 03 Mar 2022 15:48:25 +0100
X-MC-Unique: G67zoQJ9NUK8m0wUR1i9Tg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjXQsDZUW4AFlzzhLdQLnbEa3cXVF1pkX80zuTnD2RUZsrjssZea56bhJgasTNGMRCnin49i/E/mpir2gogncnCmalN+qzRGifZdoDAvJcSbh3I0M/wAQeL7F1jxt/ZaFnpC1RXxmFVM712EA97f4hmNLINCM7APEGjSQnbh62XfS+kqsEThdGV3Orym5nykw6cyU5YzcRjTQFIrYLev36xh1arlj+G9Ennr1ikR4tBk+b3Oygm2lZxFzuiSt1WVqARaYD/1YNoRjnV8T0+8HEctsoZmDyf8IeJELkEfxYUiApbe+IlxsguLlUls1Stft7yBfbkX86jIt0FbJVDO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4EgAF6UvYKVHxMZRziV2k6hq2UZZeO8tPU0AxcFniQ=;
 b=D/GG4euoh4IMR5mmS5ez+6w4PeJBXu1m2XhE42xJk5yQL3mmWCA978qt3lc00Tt0u6VagCa0w3JB3NyEDA5wsljdhqX0sSlssGbH9l+NTmFG7kFdHjbJBgKxSNKIx9f695wrcEEZN58g/Z40ir5CvV6q5M5feiOJjg8/7AW9ifV2IqBQCyU0VFci5wvAH6VqV94R7gKo9mL5fdnxHrprSxs2RjO9MkLaar6B0s4vM1uOHFWk6QIy3iBUyds6dycpNFPWniHsQ6L6FjYZ4MS+pMnbHxoftCLM4J3Y1STFwpSdV5PhJPuamFeQRLGjJKn1N7+pY9l7HFej5xVWq9MJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB6218.eurprd04.prod.outlook.com (2603:10a6:10:d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 14:48:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 14:48:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 2/3] bpf: implement bpf_mptcp_sock()
Date: Thu,  3 Mar 2022 22:47:59 +0800
Message-ID: <35863a093e11972db811c4839dd04c97f463c802.1646318613.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646318613.git.geliang.tang@suse.com>
References: <cover.1646318613.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0014.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f84498cd-d28b-43ab-154c-08d9fd24de47
X-MS-TrafficTypeDiagnostic: DBBPR04MB6218:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB6218AD792D156EBD89FDC004F8049@DBBPR04MB6218.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vEWAY3WXrIUChm9twV7IpxJwekR28xXqedKwCUdJbs8kz/myaCR53E4k7mxFzaK7rcOKY+detj6Xchcor+bK70LRtm94E1Cm7N1jHq5NzUPWYhHyXK3WK16tH6IsDbA1I3pOGI/njR3992HWjkh8waQexQJiWJGL5//BiC5NaW0oGcvbwWABsa51IKmHM/pRfgGMI2HKRFGDU1FPnHxf7uoSRfbmydXQpdRehj9jt697x44BpZSn+7yuxOsyxne265CplcZl7GNIRGN0vL1dr8a5TEGfO/yIkgc2nor+xE1AViACTpAMQzTBkh3pY4Om6iO0+SB5kaUFpJVoCoccpISyZei98oWvqmOEkYHOmUvaW9KLi7gBVbpB64LtPpqZThZgLq7twoyYNkOCz7e3no1kbijwxn4J9v5gWODUHbexh1+c6o3hwQ6kFgTZNK1wQwWmqJOYx7dw+HXyxnRluz8ifzLdw+a85D+vbWG7lFLx7n/f1d0jr8KS5HVHpoFhuAJVgephFEf2UB/R0kkekLONBqQowftz6DS8Zcf3+dF7o8g+GKdwdZt03OyLh7y0xXaMt4uasZ3WVeCo/Y/IZP1vG0+CQ2fC0Fek5liOIDfcKcxAV2A0zLoWyQdGH65rxoicFX7YhjQ80OZtu7Coi3cU4xslPuiySW2rWGSOTshNLmod0AWYYuW8bpzNdC2KDrTMq8rWjjuXDVmx8R41IA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(86362001)(8936002)(5660300002)(38100700002)(26005)(44832011)(186003)(2616005)(107886003)(6916009)(6506007)(6512007)(6666004)(508600001)(6486002)(36756003)(66476007)(66556008)(66946007)(4326008)(8676002)(83380400001)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cInr6xupbqid8/j52EeWNo3wUgLBKjZReEOxZVVaEResBxIKxwZUwp4PjiEw?=
 =?us-ascii?Q?pEFQG/AU8+0ix5DEBv1R/b6Q7GOz3x94c7J07OeoQJfHiLDPRheoD3H0UaHY?=
 =?us-ascii?Q?VvJAspzwXYp3H/VTf9gzx+OrOWLHrBpqGP5oRn5tbeuoYg5qxjGoIzTNNlC5?=
 =?us-ascii?Q?0GN83kLwhGSq6BFyz3SpB1TIrbbY5AdwD9AALsSZx/DSjYjSlpE0fqNPsT+V?=
 =?us-ascii?Q?Uhcaka1OSuVfDLI0QW+4RXmXGM8+XeatGRV72E9XYnmu67lkQmzjJCsKPynF?=
 =?us-ascii?Q?olYiwj9/knacfN74pvduLaUOI44NGECcjt5ku6/vfPcfsGyCBJFzbJE1YIr+?=
 =?us-ascii?Q?yQ5nMnIMxFQAktFov6OKgZkdPvmB7yI92RDy2nO7jLo6+aWWQPovP1cc0RPe?=
 =?us-ascii?Q?d+OM1Y4U9WtFlzmtwluj6RNy52hnGU61gamTUdQT2MNUa/TL/rIMK/UKuV2C?=
 =?us-ascii?Q?UN5vw+KrcQG4b3/ZTDokNYtwsCp57hVQ+zJATIDdFqbz2g1uwzkGdP0fI3qH?=
 =?us-ascii?Q?62LdqBNAIsqk1sR3f6QNRZ7A/8DG8G3ZLEpa1LNHuDQH4sPMejljyaqRNx6N?=
 =?us-ascii?Q?UIymIw47aaMn5LpTxE8MDKvQeTXRwZKVBYa8cOafsefiZDE1ecfIn5H9NT+k?=
 =?us-ascii?Q?GrLa5yxJ3FI2L2n71Um4CKGP0ca9rR8ubSNY1AZF1SnjarPOQBg0S3dhVi1m?=
 =?us-ascii?Q?O2b+y9hjmAWQ7nq2f4GqC7qE964BCi0D2SeCJuZOKYW8QZZF2WHJew56scZc?=
 =?us-ascii?Q?odhQvrP5j14Xs2SaIkgWB3O6jU7AdRc7mmHJa7CVYUGQ7/dj/qU/gSCw/lcM?=
 =?us-ascii?Q?TLX2cphjjfCn7Qy9iV1DVNMUOF2gJKpeoFexg5vlzqlXEN2wcZEJsQtuEols?=
 =?us-ascii?Q?ldmtBe2nPYnvmUaGbqwigvw2ibNY99F4EacWBPCWC4v38iQHndIeWONdXTrH?=
 =?us-ascii?Q?N6Bavp7BtAxVhMZgIN7kVLg/LsNUK+SzwKFV3WbvL86OWWyANREpber8RSQJ?=
 =?us-ascii?Q?nfbDeA6FUgj6h2MpRlvvXZgC8suCyNGJR5+PLMBo9kzdqDjNSBn3n2cs7Jpe?=
 =?us-ascii?Q?y0ui2qAPBPuWITFVPqzBn+uIZamoulQoealYKt8mDsoTxwuNL2NwC7dq2d8L?=
 =?us-ascii?Q?5O8Q8Z6NY9Z62x4V4nNuIgu0bS3/vfNKq1k/46WJHNRWiw6GcK2MGI8Ahal8?=
 =?us-ascii?Q?9COhLKuEqHDqx1DPWAS4a7M9Rquo1X0iPmKM9gwvzwa8JTNJvKAJ//uWTYnc?=
 =?us-ascii?Q?DoOYE8HR4yo91Ys8tXPkEIKWWL4iP5GJLzUXu7QsGBc9OI68AnTLOMZcbL9O?=
 =?us-ascii?Q?sYRtRyGjNnkdO0PE+GR0efTB9fvZ20FMRyM9Si+3gUd+Y70emPIP5MqLWbDh?=
 =?us-ascii?Q?4X25zZ2qwIy4MkUb0BQhLYt6kOYG18KKlzKkHB7wnxIEbNMj9lQTD7wNbd4s?=
 =?us-ascii?Q?6uLoK6D242x6opyO1VbAoAmBeUegnwa0ykBdzGda3SND/weQcrzh0f7okWmw?=
 =?us-ascii?Q?NP0TyZmC3HNmV6MGjn9I0O5gLPtePgBA5Jus/CW/NLejp+SmE366cu5pMxNv?=
 =?us-ascii?Q?aLnH+0eoNgZiJN+LdT8iYfv5eXtGpoaBcU6hsZNlL+Px/Het18cIdSMorcAV?=
 =?us-ascii?Q?E6uUWF/4PUC8CCZ9Wfx2yv0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84498cd-d28b-43ab-154c-08d9fd24de47
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 14:48:24.1204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2ouYJoHFzrF4HniYc0KyVIibyMwyql2g+GvOjcDBVdkov4dFtDpw0LyGMOeHttL4pmsvyZzX3l1EooZUH8z5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6218

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
index 0ae57df2f226..08616218e305 100644
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
+static struct bpf_mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
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

