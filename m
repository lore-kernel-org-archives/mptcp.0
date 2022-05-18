Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5814F1852
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 06:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652854280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ObPwR5jbkeTgzrj66kEsF+6m7SwV4LhCvqir9MbnACc=;
	b=f+4b6vSkL+8sBa9Bsloc2XBRIU9txVAUxcmTqE54gzcT4b0rMLE7KaXw1adOuAQZTPhW3d
	JvqWuUQyKMS47f+LRbaVjhkF2Wn10/3YrqurI+bzSw+RXAAcEJm9BFt71kn17B6Ubxesbe
	AOOBmLatNi+8+pRPtIpXMYMMbsBaWug=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-hIPToKJhPweMvQ8WKbOWCQ-1; Wed, 18 May 2022 08:11:19 +0200
X-MC-Unique: hIPToKJhPweMvQ8WKbOWCQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyvajc230ZDK8KJ6KcWtmzPLq7Hfw2HjkvyMuhka0vGJnq4FiamJ9Lh+xL8HKxOjXX96s1KUPaPhqwxCgd9FRpmW0DHRI2sqU0RCR8cWmJBnrDN/HYqXZ6xTVxHEHKURvaYcAHMnfqxkBSEdi1E3aEUi+kWtTMfq3gk9+CMfVknOq3TZCUfGpFLj3OxxIO0WJfo7Zf2iw1HJmEIxeaYtELKkRGVOA/CiSbhSi7pdASQelHoaNezkaf1FWrchUzPQwArv8/2/M9kE4rPcvXei+PVlxwomXSAVxdYOnfKI0ki4f1zoex0pTEhNDK5ZA9wUohpYwS+BxtUVc82wjDN1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6R2G49GGmKhcHfbNIWk9QH/pxnptfN3X2CQbusP4GDE=;
 b=jsYPxAC8Xp3Y+9jSMdcgj8z55GTQTRfN2bUOayrBE/kdnwXH7wfhB3S1XKA7hO8FQ3p7otkaapeGQpgeK8ZJ89ur6LuvJAsSgOMa/69bHetzzpS3xTEZrdja6nPCFv050MRxh3jYfwHpMQznYpDtiH5OyOrHtQBYE+4aKiU2GfhtxfnEon7dMN+48IY59Ug5+lvJZtlxkoqeA0BKG2boGJhEL2GhgICrQR7zTF4yRYMsg8bIj1EdG0BHf8d1mbOhSIj6UNdteiyUUbwzNltn2WKigMUAOTeuT9KEte9DMFFUuaPEi+QSSLhRybSqTxWRLoKealZigKf/FKVrqvhNrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 06:11:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:11:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 03/17] bpf: add bpf_mptcp_sock_from_subflow helper
Date: Wed, 18 May 2022 14:10:41 +0800
Message-ID: <3b4bb11cd5d2a3a3d017823eda1e7a079043f71a.1652853898.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652853898.git.geliang.tang@suse.com>
References: <cover.1652853898.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0020.apcprd04.prod.outlook.com
 (2603:1096:202:2::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fca32ec8-a27e-4410-97cf-08da389538e6
X-MS-TrafficTypeDiagnostic: PAXPR04MB8256:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB8256D59AAAA7D511C679F56AF8D19@PAXPR04MB8256.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DpE52jgNXXQ2oT55soxUw8L1oQlpNKRNQVXvAoPTiv6zlJCqinQS0A9I/NqY1gScEiBpQCd+JTKVJClRfQlnpgUApEBo/reA4asHQjUvcUsE9wZh/RNHRhjRpDZthJbOTSHePc+Nj5TqoMQul8j5iV87ujdq8IHQnB5utdNhpOBfhfuym5tyvVCJcZCslz9TOYHbQ6Q9+i//usSBGKsbOIllcmk2E/gXgEd6Z2xSoKvnuecRX5GbTc/VZ7FB6iroxG2ZvnqdbUCaw2ZjfByGt76P/jReezT+JbAiEvIPnsb82hcoCpdk0lSQOCQpQmzp4r4/TyNYe2MRMB/I2tKA7rYvNRPvl9GW9cIrkFXq9IsGL1mlITrDvfHK+4d/+G2QbbK81tVrtu4rmD9SI5wCfpxDgoXeUSk7tsShhtlyGmqhHFnV3y9/PjdVGim29m5wH5uZtFHEr1uytLfWV3Br6wZ44ctd0lOFOMq8y50FRZO/O9pcKNXSdjOEIGnyJlIGC4J86TP0EvvQzJ6txJ9R6MPDDKI2Sj16mBQApBziTJ+o4TiBFun9xE4GunouWAYsPmp30T+SFMMGyRHSfjORN+C1IPGkYOXck3WeSIuejSer+fi7FBIlo6x2x9QAWXhZy+9BiW+aEA0oijsDzUwVw53GDgOCeCr5dwUVoLvK79AqOzedSzv3BrylYpvbw3tvIakiYQ2HOsQqOtF8TGBeXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(66556008)(6666004)(2906002)(66476007)(107886003)(8676002)(4326008)(36756003)(66946007)(316002)(6916009)(508600001)(8936002)(38100700002)(5660300002)(44832011)(86362001)(2616005)(83380400001)(26005)(6486002)(6512007)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AY7/u9VkkAg/nJGI48RFKL+mJu1Yxt6/MEWuTu9jdBSVbaXv632vibK/w4Z5?=
 =?us-ascii?Q?gIYEJF7rwWikffvZ5qi0yjxTQx9rC7gFIuWa9cCi4qK3EMjL1KBDMhzWhfGx?=
 =?us-ascii?Q?zBOb/6TqCo4R1jImR2PzFNRDHaAGiOEqbQxPImB6uLxmcFqdauFWiByiWAFX?=
 =?us-ascii?Q?uR8aTmIzBA85VZ1AfYzEjCh3DZOwkgSO/8mrJB2FQvqVX4QuW8cibLYkBP40?=
 =?us-ascii?Q?5X17menoTQGJhywfnnqDO2Fcc0TCq1M2Rf77DJB5oUhcgxAu/cewAhriTe0N?=
 =?us-ascii?Q?x8iFDworMEZ1QLAlolZtcnCCvvTYPC+odD0LB9XdrpvdnmduEKVuwwFIHh9O?=
 =?us-ascii?Q?dragPcGgFKrqLdr/QkELGvTxNEIF7izSz60MmPobM601kaaAn9oeVWKoxv01?=
 =?us-ascii?Q?M1zHQrSz4joaNgv8t1jRKdDf2KSU8mo+2XviOaRhiVK4EHKXRowagd7aa4Rf?=
 =?us-ascii?Q?2MQnS4S7Wz2TeDaSNsXhjJtDbaWAdivwpMpdQ+elp3Fd57r8b3UgmlbdqhKh?=
 =?us-ascii?Q?tMFfmbdwz05iVyQFQlGoNG3xDb79gNUM/wOVQ/n9GVKsQT+QWTZxlp/DaL4d?=
 =?us-ascii?Q?LlJRtEoaZKuy7acKZP0FRCp7jZBknBgHgiTPL1iLu7eRl5+jG7zBqxRir2Rx?=
 =?us-ascii?Q?vzepQlHeuNgglF7WcCShWhFe/hXvroHyg9gwYxSNL2iTbzo0ZxcHFd5+bKMe?=
 =?us-ascii?Q?Xn6j1jDc5p/11MhMLOOnjTITy3S240hjAd2ElOtmX/T0iuZctsPa9GaAnNbB?=
 =?us-ascii?Q?n3C4wX1/pqAeiVDVdQfHys/yvFlxTuse5Apm/hYPqpii/VeHACXTO9Rjr6SZ?=
 =?us-ascii?Q?jziB6+xhbxeF2YFxKCCmK1KvMC9kz3W8/iQYPNdES+TtBz8W3ppHFt21s+uO?=
 =?us-ascii?Q?GAafrNItcfbwC9whMA0NBVMYVQnHJAbO7erOj6V2vqs+JfNsbCkKP3e/ddms?=
 =?us-ascii?Q?UQjB4/HGc2SgFfXgIRTVrpOotwVOh6pHtDwIzzmdObtpS+9M+JLaH0/fs/5W?=
 =?us-ascii?Q?SXOHbZjY8WPYVj5Fs+F1uOA1tMrKvmRkrKggS+2MXC/T926ZZKZX6R1uNr5F?=
 =?us-ascii?Q?S07K7OaigAlnhLhKw8Cohu/h0owC6/4/fos1U82n+aYa9f4TmuTCA4AsvAJC?=
 =?us-ascii?Q?l+75FILddbI9vzkO6t468GPEiXA/yV2bw+ruBeT3j7gSKtb4OWR6wnPJSlIL?=
 =?us-ascii?Q?h82d0ZW2og7Zm7xN+/pDm8gPeW+XkzLdDnbYd/p/4hOFSDxtTBy7IWRIyye6?=
 =?us-ascii?Q?GUMbfQ2POhP7dpu2GCQNNtd0MlBqE3bqEUOQjJ/VPGhiwye/i4cfkL6TW/i6?=
 =?us-ascii?Q?CRG29rRckrVQoCPWGWOgzu50ApMxmKJijLrzUv2lnwK2bB8NuH5d4C0s3ErL?=
 =?us-ascii?Q?JS1DZZxRxyblQ10R4paVl8sqP8ILDCA4Z5UUh96ml09QEbxVOa1qKc0LfCED?=
 =?us-ascii?Q?jJrcxdOdc8Lesn10ZxizMYzv9EMbChwh7eDwx7vfofCC6x2JnsFksSccqWf5?=
 =?us-ascii?Q?BKfchvdIjK05puvUlH+Wh4Wn456BlQNlK6N+dwwsIx40uKJ/4qR7opGuUDwM?=
 =?us-ascii?Q?0oeSZ/7b2L6p51a/lEV/msnzJ0KQOz5QULEURE/oVKiGk/ap5XrvxYFv6164?=
 =?us-ascii?Q?f7BM0TlWr4/VPA70KytykW7vQLmk4EJ2FYwaGGcn58TCyQnLvVLJCfIAIkJs?=
 =?us-ascii?Q?1U6BxmbyW4LrGqB7Cf5PP827iM7oUH41+YQjnYvXzqn2JGx5xG1u3u0mY99C?=
 =?us-ascii?Q?TlBOy1o46o0IWbgPyD1Sv8eBbXi+ZFM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca32ec8-a27e-4410-97cf-08da389538e6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:11:18.5390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8X8tolmaT0SHMjtVB8sXXLABVNBXmtaNjrZwMRYjgtPEqXJO0ov1ACWPCs1dLU5n8QRepJ0eZsWZ+s6eZnec1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

This patch implements the helper bpf_mptcp_sock_from_subflow(), to get
the MPTCP socket from a given TCP subflow socket.

Move the inline function mptcp_sk() from net/mptcp/protocol.h to
include/net/mptcp.h.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  | 18 ++++++++++++++++++
 net/mptcp/protocol.h |  5 -----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 9422b6d2a268..a267cff36197 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -287,6 +287,11 @@ mptcp_subflow_ctx(const struct sock *sk)
 	/* Use RCU on icsk_ulp_data only for sock diag code */
 	return (__force struct mptcp_subflow_context *)icsk->icsk_ulp_data;
 }
+
+static inline struct mptcp_sock *mptcp_sk(const struct sock *sk)
+{
+	return (struct mptcp_sock *)sk;
+}
 #else
=20
 static inline void mptcp_init(void)
@@ -366,6 +371,7 @@ static inline int mptcp_subflow_init_cookie_req(struct =
request_sock *req,
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { retu=
rn htonl(0u); }
 static inline struct mptcp_subflow_context *
 mptcp_subflow_ctx(const struct sock *sk) { return NULL; }
+static inline struct mptcp_sock *mptcp_sk(const struct sock *sk) { return =
NULL; }
 #endif /* CONFIG_MPTCP */
=20
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -376,4 +382,16 @@ static inline int mptcpv6_init(void) { return 0; }
 static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
 #endif
=20
+#if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_SYSCALL)
+static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *=
sk)
+{
+	if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_=
mptcp(sk))
+		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
+
+	return NULL;
+}
+#else
+static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *=
sk) { return NULL; }
+#endif
+
 #endif /* __NET_MPTCP_H */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cc24756cedfe..2fc8aaf5cb05 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -318,11 +318,6 @@ static inline void msk_owned_by_me(const struct mptcp_=
sock *msk)
 	sock_owned_by_me((const struct sock *)msk);
 }
=20
-static inline struct mptcp_sock *mptcp_sk(const struct sock *sk)
-{
-	return (struct mptcp_sock *)sk;
-}
-
 /* the msk socket don't use the backlog, also account for the bulk
  * free memory
  */
--=20
2.34.1

