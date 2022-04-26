Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A2363
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 04:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650947160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K90DjONJrp/hCchpKRGK9dPB2Sd6RtZb9bYPlQ3alTI=;
	b=UH/SNkmPFyG0X7jsy99tgY7tX07fDm+gl7FaEAQmTcJIiJPrgZBCWCHK3t/cYR89prppMB
	nGdOPgw0wJoGIqJ3mb/0ZVABVM2nMBz8Wwf8nW7cYTdGFHP7OuI98Uoqx4nw1RaTTfmKGg
	wVW84j3nGSgqerKVuU91JU+EFvLUd7U=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-haqg4gIIMYyTKAcjHDKqVg-1; Tue, 26 Apr 2022 06:25:59 +0200
X-MC-Unique: haqg4gIIMYyTKAcjHDKqVg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNEPUZYhWbBrwa8hen+EfA28uBn2Mn5LXuybxIoh3L7musP1Ehmp3U66pbLWgc4IR0voerdorw0k+mpTShJamwLFPaYd43N5ikQAXjKS3psoSAqZjxc1Xe4Ce4/a1ioWYHKYEqjNwUnEANahEZvbKAtCQrwMC0p07nEpimDchlol3/z8U9XkV/S2+47jPbWadKfLbKPVUAHOwqP4YlebhPa+0ZJ9CYmrqqhv3SXyGvzikfbC5P3Juc6txrHFYQqK0KSmRsNlsPvC1o5SMk8GIHuRo/QygHEpTSt82XmDWDiT8h3MTi/RTGvW8QiHZGqLIGQe/b5GRllea1lQY4N4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OC0Wi8sSAbO3bhUmIfBT3k8Ibwj2rgOW0AIYmXvQ8aU=;
 b=Q2E5scSMrTERNilLsECRxQsLT1Ni/w0IbqCQuW5Irj9y3JPPsP1+x2VJlZDNsWn6F/7CQLkwlyiMm2QqeIwrIMANxfzLcKYo+o+sdaraNcDwNIrAwhkA1xDZRNOJN2mIwXMk/TnP9+NMTHV3UAE+CrsBb6rBrJnrmFC69gk0Xi9viLPp4QIFalq7R6KL8K0ZwKSiHlByVdCc7BLeBTTtaopq8Xbx8vQFircuVgCWJobZKZi/w8n8pDufGlSm/0AZlH2j3adnIcIEj73E0InMQMyN5OWSCBD5rhXgfSCUqBOz4Nzv8iusx+2DGiCdyQscBoIj3PdTMOUxupaBqrKKHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB2962.eurprd04.prod.outlook.com (2603:10a6:206:6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 04:25:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 04:25:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "bpf: add bpf_skc_to_mptcp_sock_proto"
Date: Tue, 26 Apr 2022 12:26:10 +0800
Message-ID: <a412b57378176f189e112a36443ac133fa90566c.1650947043.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0164.apcprd02.prod.outlook.com
 (2603:1096:201:1f::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0d26886-953d-4500-af1d-08da273cdc2f
X-MS-TrafficTypeDiagnostic: AM5PR04MB2962:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB2962BFB68D17706ACB15AA9BF8FB9@AM5PR04MB2962.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yh7YRGRegI37k9cj0VPlcduLTii6i0te/KTShY3Qmm7czx0ZMJbuhRAgPTZmruUKLBU6aV1XWFiqQv8VTExi/5a0F8fPX9Y5HiFHxW/ym06igh+1Q95/UofM3yYXCX3AZEf6bNu9YDAGgR5KBTU1RD8eGZFS2nD6/W1URZpzYpq6Nb6Lkw3AbXX3rnmk1EHpzzxxx0FbMW62C5kS94MAmm3KwejKijx1XBKwbCFEfNWWHDjStTWiVa+PzbmAAkDKVhvfREBTxJaZKTtX2bowXBS5X7PV0myrDcOtF/2z53niBABzB57D7+f3Am1rwyoEjbstJxAJRR7nYqjTohiX8cyKQ+9LH+ab+ywPWJ3IxTX4EhwcPYkXOQodHN3lXgK54xJbK7byRr2Pk1QhayZyouyHHGIEl9qgPelN6euwjfqncyQlVXjcHCvL8d7OvSu7gbwPaeOTLmON4fXPoPCCbvrsw+Em3xmQqt6I70pYqTxI6nP6jIa0b4uEQ8IOHE7e9TjlqhaYGsLWpGIyTDVqqD/rKx7gVsVoU4GtrzAGTKyDVq9FvbspFDxsEUGPOT1NUyElenIPCeC0y2vzdkMfkMb/V8F6x717HUp38hiZFzBYTm3sdOK7BINgMh7wglrWF/IRaPfqq6moSAdpNWD8UfeVcpmwpKX6BtYs7ChdVWGD2fEGjVHfBMqJUIFlHIB3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(5660300002)(66946007)(6512007)(38100700002)(2906002)(316002)(86362001)(6666004)(107886003)(83380400001)(2616005)(4326008)(186003)(66556008)(6486002)(66476007)(8676002)(44832011)(26005)(8936002)(6916009)(36756003)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yZ/3ek/tVXFu+p8H4Gbm6WFSflczNBzcMPFO6tWVgaI+hij7Nm+Fwp58oH5l?=
 =?us-ascii?Q?SozHuVxN6GTSeNP75zdS4WVIPBkFl84cewZ0kHLviSi6LJIDKpCt8Z38GhEQ?=
 =?us-ascii?Q?dGPyNOmT6fZizPhmgHEBAAD78dI/GADm/dMtxOaks0VR3tvHqLW4zI4lKne0?=
 =?us-ascii?Q?YptpeUKO0Krllzcq+wBCspkRpH43rxdyC4DmRGoRGQPLJGGQ0Dae8uxPOfQe?=
 =?us-ascii?Q?GEZY4F1vUBQS+UY6/6EmGpqcrGqzV1qmejz5vRQZxNFMJ6P3HvS94rJEPRrd?=
 =?us-ascii?Q?ZBwuI6nZDzRLbEhDVOFny3p8AUcyxE/vELlGei6dmrzm+wX2H9IdH9KSu9c+?=
 =?us-ascii?Q?KkQJRY44fskDT2nEVu43wIB/hkzWyDaDvcAKBO+IFmykDW5PfS3MnfHA3eGr?=
 =?us-ascii?Q?HnAw/S/C6YrG8tGKekZaK7+2MdJR5u8Rxyeqf5m1q/YHIHTsQW7eRf6dCKEg?=
 =?us-ascii?Q?yyViyTCE0OM8QrSQYHFi0AJAsPTi1zZP7zZAQUKNHwWDvOtG/Zw5BVOMo5qv?=
 =?us-ascii?Q?Gz0urYSse1dVEg9WMW/rDohhxJkHGUTiKRGqjWR59A86t2e+m+B2jhWyjGkJ?=
 =?us-ascii?Q?jBJkWBmpQjJz9ffyiCauCxUCyLUVeLmvSscD4Muzj67JJlJvqP9JIvtx6gW/?=
 =?us-ascii?Q?NCNvwJkAStwwYxHSfy/0mR6FaeHm7e2srY+R0qOs0o+o/rSFLE8LhjzxuQcs?=
 =?us-ascii?Q?rg6loRAdcIF4cJKjhKFfg5MHGwg6gDO529IfpXMNY6hwlWUEzqE7IWWiPcci?=
 =?us-ascii?Q?6qji47At9AbY1oW9/+a/IztxDC2NaBLjSAKX7yYTlPklmE+zjiounJJHOt2g?=
 =?us-ascii?Q?qskl6815zBK7zwm9IcfjjiLyv8CgBVaEAyUMqsnIur+TR4Tm//kc5AXMnCcq?=
 =?us-ascii?Q?sWQyVndLvpQgbL7JN3l4Poz4lUg5V1gfTFjMWEdd9L8abLeXURa90sCyiVtF?=
 =?us-ascii?Q?3AIv4NRQRe7nE7izJYOt8p/iUvV3l2sjMYu+JNdaV9KJM52i9uC9kOt42IcX?=
 =?us-ascii?Q?lHj6XppAL/CiswLsPLGZcEF1Zz3olNSik+3p7liTTKLYsD+yOq5y701MBWXB?=
 =?us-ascii?Q?MjAS0IGo30GmuZGEDjIKh0loO+l6zZaOl0gZbhOBD5OVB7XMgAXDVfq89Akx?=
 =?us-ascii?Q?1/50/anmAGk6d3I+A35v1dJ/LKen7fgVC+uoxUUTTFpYCDmeTcnA+wQhg5wd?=
 =?us-ascii?Q?dqEYfzEcrGS4rndVQ5BC+DsVE66Kf3I8+PzTxcIx9W1rYHBn5pbPZxEYHG+D?=
 =?us-ascii?Q?iQ+Y/W2xnrRkvtJ7d5OE1wKmLl/V6qGw+Q8GVv3y/rxBqRaPmAnAPZ99R43l?=
 =?us-ascii?Q?ZS8hmvvUC6tfH/iT/zFnc0ZQqCsspXTR+3m0r6uAxwyPsH/VBfqG0vRKxSr5?=
 =?us-ascii?Q?d2apaM4X80ykeMsZ31RZIvp6okGiwDx7STexvyWWXeFIfrM4SGdPJfdZ5jkw?=
 =?us-ascii?Q?OOts01tLZGhcGIouurg+d/llq2JUUk9q3P2RNoi5N43CBuFvGNMezHEwVl71?=
 =?us-ascii?Q?s1/LCFpUjQtFflZCzDBzrpmkqNwYWTOuYYk1vv+Z08UDe7aXe4FYK9OH3/o5?=
 =?us-ascii?Q?kSezost7Iuc9A8DIrbWYYO+MEoe+v0FtA7gLvmazUXIlF3iaoNZpjK1ZFV0y?=
 =?us-ascii?Q?s3YDl+qpkxqd4TMlOsledrmNVxwgdfufOm/FYN9qSWNrL/cIow2mVOjNEtTS?=
 =?us-ascii?Q?i9wjTZDQWY/XMcB1m5mXz+Xl6bggpbstNA4ClDTLFGr9saGL1r08HZ/14ggo?=
 =?us-ascii?Q?ZyIhBstruKaZXmfJBMQzfncMAb8Y4vU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d26886-953d-4500-af1d-08da273cdc2f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 04:25:57.5886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ej1FWMqkhLmId26LW/85TkBRx0v+tzqBD/2mfcQOVA8AVFB68K/Yrpkul//Run+/UlyANM1zxo+dRLKJA5Oqaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2962

Update as Daniel suggested.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf.h      | 1 +
 include/net/mptcp.h      | 2 +-
 kernel/bpf/verifier.c    | 1 +
 kernel/trace/bpf_trace.c | 2 ++
 net/core/filter.c        | 3 ++-
 net/mptcp/Makefile       | 2 --
 6 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bdb5298735ce..2493f9601842 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2249,6 +2249,7 @@ extern const struct bpf_func_proto bpf_skc_to_tcp_tim=
ewait_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_udp6_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_unix_sock_proto;
+extern const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto;
 extern const struct bpf_func_proto bpf_copy_from_user_proto;
 extern const struct bpf_func_proto bpf_snprintf_btf_proto;
 extern const struct bpf_func_proto bpf_snprintf_proto;
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6b07011c060d..4d761ad530c9 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -284,7 +284,7 @@ static inline int mptcpv6_init(void) { return 0; }
 static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
 #endif
=20
-#if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF=
_SYSCALL)
+#if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_SYSCALL)
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk);
 #else
 static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *=
sk) { return NULL; }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9c1a02b82ecd..40602ec20c6a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -517,6 +517,7 @@ static bool is_ptr_cast_function(enum bpf_func_id func_=
id)
 		func_id =3D=3D BPF_FUNC_skc_to_tcp_sock ||
 		func_id =3D=3D BPF_FUNC_skc_to_tcp6_sock ||
 		func_id =3D=3D BPF_FUNC_skc_to_udp6_sock ||
+		func_id =3D=3D BPF_FUNC_skc_to_mptcp_sock ||
 		func_id =3D=3D BPF_FUNC_skc_to_tcp_timewait_sock ||
 		func_id =3D=3D BPF_FUNC_skc_to_tcp_request_sock;
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b26f3da943de..c7bf10cf2fa5 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1685,6 +1685,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, con=
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
index 4bcf13b1d0e2..a0dd6f6b17f8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11282,10 +11282,11 @@ const struct bpf_func_proto bpf_skc_to_unix_sock_=
proto =3D {
=20
 BPF_CALL_1(bpf_skc_to_mptcp_sock, struct sock *, sk)
 {
+	BTF_TYPE_EMIT(struct mptcp_sock);
 	return (unsigned long)bpf_mptcp_sock_from_subflow(sk);
 }
=20
-static const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto =3D {
+const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto =3D {
 	.func		=3D bpf_skc_to_mptcp_sock,
 	.gpl_only	=3D false,
 	.ret_type	=3D RET_PTR_TO_BTF_ID_OR_NULL,
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 4004347db47e..6e7df47c9584 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -11,6 +11,4 @@ mptcp_crypto_test-objs :=3D crypto_test.o
 mptcp_token_test-objs :=3D token_test.o
 obj-$(CONFIG_MPTCP_KUNIT_TEST) +=3D mptcp_crypto_test.o mptcp_token_test.o
=20
-ifeq ($(CONFIG_BPF_JIT),y)
 obj-$(CONFIG_BPF_SYSCALL) +=3D bpf.o
-endif
--=20
2.34.1

