Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CAF2CA0
	for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 06:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1639723112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HTmgBidNdf3LpudED5bkIFBGvYVg4d8dO7jKvMJwBH8=;
	b=luiQfO/dr0J2KtMlFVCHo9vSm1TLqHoXByJV5wG2HP45xPoAIhfHxkSrKSFdiv67vdtKd6
	Yg2ggf6IeFaZA/qyAiS9hi7CZqBXUk4+fWtFIWvsx5cR1vBdzAnCc2r1Cf0lQlDVv+s30j
	d0NNDtkyvR4p2Uufz7vu09FbK1UAiRs=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-PARowl7GN5mmXqe8RnL0VA-1; Fri, 17 Dec 2021 07:38:30 +0100
X-MC-Unique: PARowl7GN5mmXqe8RnL0VA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPdWM3ne9l/bv/AnYDB5pgyLY6FKOH+bRI9HyNCfyEPerw4Vlh1ACcJYqmmo4P9RmExAM+3E2QyRH39E2NPBr6zgI+2tn2fbhoPGcep41tMfEk972Y7VJ7CKZkd3ZXHCMJYaJ5SharIjp+C47E6VZyzR/ykxBQPXc9a9riq6W0Uz/3q+zFViRNo5lCs6H/BdI6CKszD4S50xQBV3/xznLvhLbyzIZQ3Z0SYSrA0Si7ffesjN1GusvKDfAfFwDfS/7Bm45QtlzNbNrQfJWCY+2mYyKXmXF0jKPgdAtEZWmSdN8E2y9ey4QCXRD4AbED3WT+UpXv7OIOid8n9jiTBcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHnsAKkxKT9gabdbvixFkbSOk5VHDIZ9bjqI/4yksxE=;
 b=Sr+x7FJBsVwKpfnIDkCDDFoLz4Z27JGyvL9XJBcIQJ1VtLWGWk8kcA3yRUzR2w39Uw1oYCrqsiDxmYEZD54m2ZYqMPtswpSv6IPRX8OIe+7i9UdZNZw5IfQKwz0FE11nlGZPb/MdBSryLx9drfs7DDLJlAQ0xtAknAgHScY5ogrE9AdMFQcyCLWu4e+xT87IXdObq7NNa0J/vwTpJDpoxI9wF92mnguv1cT3QrDltnZ5PFAzltEm4ANqa0CPeAhyAYKtodeOwebVBjoS6eLQh6GHDODy9OI2yhOBVgq0Op3NY8bP+tQZ8gj6AgfP28yTlylguZRc9Ww/0xwRcvN0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2444.eurprd04.prod.outlook.com (2603:10a6:3:83::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Fri, 17 Dec
 2021 06:38:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%7]) with mapi id 15.20.4778.019; Fri, 17 Dec 2021
 06:38:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/2] mptcp: change the parameter of __mptcp_make_csum
Date: Fri, 17 Dec 2021 14:38:19 +0800
Message-ID: <050e6de9fa6dfdd330c365cacd03012e383285c5.1639722883.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1639722883.git.geliang.tang@suse.com>
References: <cover.1639722883.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0065.apcprd03.prod.outlook.com
 (2603:1096:202:17::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ece28ec-b552-4230-eb37-08d9c127d69f
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2444:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB244439D44A8ABF22BCD62B9AF8789@HE1PR0401MB2444.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BBPk+/s+gk5VEvF3XZsVuLOW3JLWMx+RwoSwIw/P3DY36Hxl7jyK4i3VUe7dLGab9BWuUej/OBUdmTBRrWZEnCXo/Bpol6IxPEs60poQYmx34sbIAZvEomFdJzbakP6zL+8oSdiLz0zpTlMqsOAPhF7ho9kdd3OL+ctV2H+72QgYpRLF4R6ujGwDH3qx7WjDwSzKqLmsTqUaAGaVPe1hJh+ARs3RQOLwhtb5YdXa5bqoOSEWvq0vx4HyR4r6gLDzQ5YlFiuGIpg5OpUL5rLG+Jc3wOVb532anq3Au5sdIRwHeUyBjNz5w54vX/KEOOacEjdbGLZyCitvChvoih5Wb5D1/FFytZ5JJAYz1a7zmmvg2tM3WU15hq9/gPj/k2LD6C4/5DqbtLqLBf3wNYAygKrgu2kKqPUzIV9ySi/3TAkjV92igL3HIlds6rA6rI0FDxISbr48rANjY5fNNL7ycu9MbdwQiafLQq0eIyPPd1p6f3WiF/Kx6Ymm6EOyNs9Mrr478Kzjj+uMW/p3pOiCadbYF1/DFTefadVwzXqH5ROmwKd1uTrs85QgpkDUGqv0N1ctFxGl3QOxiU3xpdLshu1C3VkysmOp7rphJOkKVba7jvrHA9yVDlruq2kH92i8OYnN5L6TJ/ETsOp7DzQddg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(316002)(5660300002)(2616005)(55236004)(8936002)(44832011)(6486002)(26005)(6506007)(186003)(86362001)(38100700002)(36756003)(6666004)(6512007)(6916009)(107886003)(66946007)(8676002)(83380400001)(66556008)(66476007)(2906002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EiaVmGJ5/Me+Ep9BDqM0A7bmHZjXsRPuTeDI21RlOc/xGQsozswg0yNpKCXX?=
 =?us-ascii?Q?5s7LRAAOhbbFoZpqr+mWjg5rDjYFBWm6XB/+vfkJJRDUN7209DKEDOVODace?=
 =?us-ascii?Q?xv5rSyoUvz/JyGsOk7yTtzfRC+qFsFaWuYIiMR+GSVTTvnPUHsJTxLbTVRAK?=
 =?us-ascii?Q?bJi5mcRyX6lqpEJdg1P4o3yZ3CIcumLRF9JDrjG2d7YS9N3HGTQVRaSLFrqV?=
 =?us-ascii?Q?bX27UVocHGVXjxP3MRLGxvVFYngtyVf7JIvowBcu61C+iRXpiyty4lwmhVHx?=
 =?us-ascii?Q?jZVTBsqE1e8BEr6Sn5nqjI+M2IwUjD2oFt4u+7aD5SLSxuqj1nbvNkgg5/zY?=
 =?us-ascii?Q?yvtWQ0KcTm6neySPqESsl5zPymMfPYptpkpi5OuZc8C9EBJ0Cze/o5hnSrpw?=
 =?us-ascii?Q?671GgfWuEBFkkSTlWM4yMTcarp+X+W7QHZybCaAMWDkZt7tReDMuzN38nbRq?=
 =?us-ascii?Q?SSPkRZEwfFBpCcP6qghM5Is3sXf/wt9d+QIP0+Z6mro3Rf++luBNjwODm7h9?=
 =?us-ascii?Q?/MOGtQ2XxzRSZq5FjL9T+QaSGWiDGnJkfA8nhWYvCNT+9pcVFQDbffuz+z4j?=
 =?us-ascii?Q?y82Y9y5Xm8AUQp7Xm+2ra9dF4B+O1PDtxm+A3KlRobEstDY+sfyAPNB0rKQI?=
 =?us-ascii?Q?/tasHtkNpKnkMFNB38dxTbPIN19fFWlYKukHzKQU9zr9ANpWHmkpesVLcIr0?=
 =?us-ascii?Q?r2F2doaaD3V0Qs/BtXsDku4H7QzhlNKtTooXAjuncANgul1eLRqrEncOr/xt?=
 =?us-ascii?Q?poMoT8TFsDAF9D/Bl2DEqbngLo0js3AgIxIimd31Vi0pRGK/RYtc3EE04yPi?=
 =?us-ascii?Q?oe7iXJo+JWukigXwojt44eXOOTe4Bi6Kk7iSWiwNeUg5qiKvToVL9YfYH0XW?=
 =?us-ascii?Q?4I2iwiqBwKmVkmyCfAtuZ/QhwUZQizmWHVGNaop/RcfXLf+bPO28stFEMq5/?=
 =?us-ascii?Q?xpc/OvpepyITO25blW2yDRBDL4+ut4hoO92mj1Lu0GxdQXigeQd8TbPEJoCj?=
 =?us-ascii?Q?3V7FGrSRFPAiRX4jNimJyXIzpKHnMRntLB9kdEjV+vUz7E1dJcyVbqbGWNg2?=
 =?us-ascii?Q?6s8J6uIPMyng2F8wj3pSaBe25tg2fnH31rXar9cEpT43ZI+O1wnDpIXZ+8ud?=
 =?us-ascii?Q?9pZFqU8aOltmkhLbS7tknW1gsDEF3AV0M+W6pTUY9XDCeiaCJigUOSIRa2WF?=
 =?us-ascii?Q?Eg6WC+cHWI65BIoyQfSx7uQX4ocIa7YF0z2cVJ0tOjvfDk5nzqpeA4ROOBb8?=
 =?us-ascii?Q?SlZsNBzbqr2m6dWkjxdGMFrXfbzQegMMdTVkQDvWzG91/QsMLDJxPWjx6Y5r?=
 =?us-ascii?Q?hScYyRSlYE5cH3ov2e++PdoKbpC7jlvtXcuzLdet+Dgk9jPVkTZ8vu4Onbp/?=
 =?us-ascii?Q?cwoCxjTpX0sp3yXx1mwYDDUECQhANlTXIxwI2u6dhdLud1erw50IT/OcciHy?=
 =?us-ascii?Q?AJZozxTCh3utw7Zi9h8a2LN++lrSZReLuwnFvDfAQwyzINQgG49633u4/qEV?=
 =?us-ascii?Q?PKFE266viDtgvOfHAf2rIDwJwI9N1NuSFXV6OhQo77n8Ygq6DvVTCEfQ98oV?=
 =?us-ascii?Q?RNqyRAMepTZnt7r/HzHWYhWplzI5pf3KpVtihRkz7QVy2Xc1/ngPS52nfRJO?=
 =?us-ascii?Q?FxUtBSVpFfRZ0hMy9ju1gZ4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ece28ec-b552-4230-eb37-08d9c127d69f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 06:38:29.9275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLn6yzx70gdaYFLnZ0G9pVIvqQN2/tQ2KnPfW5/uMf726oqZQkevtT/qsFIaveQ3nv1GLP58g04KEU8DEdZv1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2444

This patch changed the type of the last parameter of __mptcp_make_csum()
from __sum16 to __wsum. And export this function in protocol.h.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c  | 8 ++++----
 net/mptcp/protocol.h | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 7a6a39b71633..c6726e8389ec 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1229,7 +1229,7 @@ static void mptcp_set_rwin(const struct tcp_sock *tp)
 		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
 }
=20
-static u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, =
__sum16 sum)
+u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum =
sum)
 {
 	struct csum_pseudo_header header;
 	__wsum csum;
@@ -1244,14 +1244,14 @@ static u16 __mptcp_make_csum(u64 data_seq, u32 subf=
low_seq, u16 data_len, __sum1
 	header.data_len =3D htons(data_len);
 	header.csum =3D 0;
=20
-	csum =3D csum_partial(&header, sizeof(header), ~csum_unfold(sum));
+	csum =3D csum_partial(&header, sizeof(header), sum);
 	return (__force u16)csum_fold(csum);
 }
=20
 static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
 {
 	return __mptcp_make_csum(mpext->data_seq, mpext->subflow_seq, mpext->data=
_len,
-				 mpext->csum);
+				 ~csum_unfold(mpext->csum));
 }
=20
 void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
@@ -1372,7 +1372,7 @@ void mptcp_write_options(__be32 *ptr, const struct tc=
p_sock *tp,
 					   __mptcp_make_csum(opts->data_seq,
 							     opts->subflow_seq,
 							     opts->data_len,
-							     opts->csum), ptr);
+							     ~csum_unfold(opts->csum)), ptr);
 		} else {
 			put_unaligned_be32(opts->data_len << 16 |
 					   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d1b46c0d8c40..ec077e52c475 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -737,6 +737,7 @@ void mptcp_token_destroy(struct mptcp_sock *msk);
 void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn);
=20
 void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hma=
c);
+u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum =
sum);
=20
 void __init mptcp_pm_init(void);
 void mptcp_pm_data_init(struct mptcp_sock *msk);
--=20
2.31.1

