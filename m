Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38D84A24
	for <mptcp@lists.linux.dev>; Tue, 18 Oct 2022 11:03:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/2QuFYpARfe2yQnihe6ewUYWvTO0d9i5wUh4OWWm8jRjBRPVsFa2bdTkP4cep1nw+ZrLpyvR+bdWyiODXtq/t3VC25zdyghCdso1+VxxENary+gdzcXY8Lc4zPdq+6ZecSE2OK9e0ObSywrRRfT4c02hBIxwQO0D14SMAJ58PR0DQqDnWBLJFsev1ZOiJCxT42rZ71qSxSBJeiiOyyjT/aLGelTVDDyofuSApy+dAPicPPrdBV6uTRbrlp18eIZBIK4lZkfoBoHOQT5o/WYGSsGq9wGV6DfZ7oUgc6CUR9WS25JWza+B0FIQFD5iuubulawEgZkVeOgBreUBgBQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uhp0dWSuwG2t7V/JR43npOnCo1OAysYQyY0K/tlurac=;
 b=mNlMT/KXQHs1nmagNCmVASWyVdRDgA5Tm+KwByNBeLJBxjCi8GWtwxh93xJFyLp79S1/5I277wMHNEym0kr9IoAO0/xwKmYbPZr6Hqigcv/sVN5bWv63uVEZkyt7Fwd7TQaOxyZirFIiewqOuL9JErZHF2tXU1XwhTo/AujO5BJsx2sQT6THBD+mPDfp6x6qSdA2uFzkt6ikxt3ljGAXIKBTUsm8Desbvc6Fj0Wdyir3brVLJq4u0A9wvi43RjrK1tGRbCFdSEQBQZD+GbbZ9Y1DImswi/2k2SZybtR5qjFFoExuGZpkFLP8OIkyYyq+4KmnFYu94oe9qdF4uGVgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uhp0dWSuwG2t7V/JR43npOnCo1OAysYQyY0K/tlurac=;
 b=i1Zcb0AliN3r6L7belQM63VX3LP9mHN5qbTnS4EZL+E5dcavyHOU2TY+KFiDT90k0N8wQfnGRs2emwJag7AD3f5yRFDVSEZAXfxeNKw5/hIHMCNsy7iiEy8p5jd0qzb3BEtWjcpmEAzSfj6JObd4fxm7AhYG9bo8aNBbmY+1R/jPQLf2hj+V/xQNmerAbKl7pboI6LlbUK102eTkDqWP4urPiW7r5JJmRDnnphkEx67F8X6YEQCWTUzCH4+DqPqcxqHGOu5qiTw9KmNb+Sx5HeLL8EWiVzIFW7YzZ/i4WN8HuviaxLnMLa6caHxa7eCpI2rWCG6dCB08hpHxiFU8TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7369.eurprd04.prod.outlook.com (2603:10a6:102:89::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 11:03:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.032; Tue, 18 Oct 2022
 11:03:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 2/4] mptcp: use msk instead of mptcp_sk
Date: Tue, 18 Oct 2022 19:03:10 +0800
Message-Id: <20221018110312.22510-3-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221018110312.22510-1-geliang.tang@suse.com>
References: <20221018110312.22510-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e71bf5b-104b-4309-d334-08dab0f86b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nGla4b1/Vf0m62WxZlMX1J7N55nxY2G9EPrzNTikMm8QRPyJS8/EwoS0XZR2NZVM6VN0HrErFzabzw5MmYEVbPIwUnMJ5ZqhtnK31rnFAfYXmD9qPBj4bEefytGfWhlriLQOem+K5eyvN30fhMt0po7ejDwELj/N8Zr0LtwBSjA9J6ZVNGheHYz0tEe/oFoIRvtAnEuTufGdUHefosz2Pr+Sr//qwgCI/lMON7L7WBTZ2a/LY7Ngy8idYu5D8eMrA/4jR29PsqwuEYYIbq4JO2cobQKzlGC39sNLV0bRKQDyP9alQm4abL5EI3NSXAo9aURqIzMW0ufPvggDeJfwkDUowCkuoOCmAFXilRmNcFRCpTDxx35y9z1wIcQTsxUt8jfGMExQ1zWJ/Gs6QNFWKsJGo7TEajbs1mPob5GTQnD1I+AmbUZGjRfWPZpWufxihXR1F4ihAgE0bBbbp3C3Q/ag4Nkwxe9SU16iTNrUB77ii4+Jh8u7wc7hziJcthfdbwb3DRGpKz4plH4qxP5NBSCnTiJ9naVcoJq8p45nfQxu7TepWMefXsCNqwkN0woltUirELiCHP35HXwNDyo00/i+46RNdxT3E98TVlxXI5V3yZz3X2c1Dk4uxfX5BgI2PLhOl6zxCu8FGzZlZ9WY5AB2gcNpqhqNNhWRQwYJ+PAxaYvaz+x/oA46Sw/aFnW2673UStcgt3lx25lP0ErqHNiVntnL3HQj04Zs0gYfon+cB3JHFIfKdM9VbSbIMBeg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199015)(36756003)(86362001)(107886003)(6666004)(83380400001)(38100700002)(66946007)(66556008)(8676002)(5660300002)(316002)(8936002)(6916009)(44832011)(4326008)(6486002)(2906002)(186003)(1076003)(66476007)(2616005)(6506007)(478600001)(26005)(6512007)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LcF0CFy7LPbLWeqybyEGL4DCN802MDWAA5NMDE5GK7wwcku4wG3mDC9UQ+s+?=
 =?us-ascii?Q?kHNc901vs+rezujr4bLE2uP6y+nWQBhq55CN0UmwG90XwNf9vbHMywrOUX+U?=
 =?us-ascii?Q?vMo0CuzxHBJBgDtZM5kZtsj5Bfdgi9Edqy6l8OnfNKrOxJHGjjF0AkBbZjey?=
 =?us-ascii?Q?p60H8XRkD7ia65Ub11sZaR7iXjh6OyypAc8dQ1xI0D5liGH3Q4McQjhlxgOX?=
 =?us-ascii?Q?fEhrLimmczrovU2oksJfKA/U1YCpI73D9LEwr36Bkz5Xe3xIic+q0W+JWd9P?=
 =?us-ascii?Q?n46OARfcXXVbCbdjWd6qQYrHTm/EqiU+fU1Eh7z8o5iB1c5+vv7bWFgI02MR?=
 =?us-ascii?Q?nawfOPQo4dXokiM/shuOs8tTBpDmZmPqLM80WlI54YT5ILWBq86F70sddph8?=
 =?us-ascii?Q?m3WBeRiaQ1ISofIofGA9tdFQt8rDoo2BoVcL/I7M+SnKdNPPBjLScgABBUYv?=
 =?us-ascii?Q?VfrryKdvwmKRHpgnxnoWlCn6Ls2KNF6N+XAr59gaFa1Js0r01P3LlxCEzbbr?=
 =?us-ascii?Q?9AOSZvwpH9N0d/FchxhaaMXp34DcxFmIrSezlha8TcXnLQbK8UmQgSzhUTIv?=
 =?us-ascii?Q?0T0jZDf3KhsgOxbDK1jMWl5WS0vsZ8sKpTYr+WgUnJ6Df3cuNpB5w6RsVL4p?=
 =?us-ascii?Q?epESl7JFJgErHb1X5BwaM4nQSrIkAaGkMY5f22ofL3btbLfr06TS292GpCbK?=
 =?us-ascii?Q?dA8qqKnRUI6aVuziHeNG4RfhWRB0sdP3Anpuwq6YFkahFVXONXQPr14pmlbf?=
 =?us-ascii?Q?/F97bgsspu24lU58X+pn7k8aEJQGoMVZIWX7NxX77BPyPnX1enZ6YUb2EO41?=
 =?us-ascii?Q?ttj7SEg0e08dc6SmpJqU0YC8A3sJCV3gyHdjvKSceYjkCFxT8kfTKoOTawRZ?=
 =?us-ascii?Q?tvZL5kmGqUN3wWo04u1cc9+gk0vtAWfhgymnrudivwdaS9wR9Pi1LrECQkyX?=
 =?us-ascii?Q?NeROHD+tLmO1w/79fqr4uF9DB2uyW9IFw9Vsv/74yhwyiI1zZSBqzghbs51Z?=
 =?us-ascii?Q?gXhveFX1Me+PcwEDQ9AFJJYGmp/HdO5s160oQinVLsk6w5OlsKtBZr0LpqAk?=
 =?us-ascii?Q?RoOwq25ZItuBdmaq/mCCynzzYcTSEWnu0APngVWuwIg3QCal+KbHpu4TfYQf?=
 =?us-ascii?Q?AVxN0Tpoc2s+ENtoyCcUDtFjbWl5L/o7hcs6VuEl7kZho+rCeQ6FjEhK5j7+?=
 =?us-ascii?Q?bOToYMiZiy1JSS2c0n6mD3FvnjvhXsz9PWVDQEdqfxTFdEoGnRIRxXsQ0HOT?=
 =?us-ascii?Q?cOpO4Fzc8HidcCEypUTzbATsuz2vU4RYBJY3pxI5Z8hO58mVLg5BR2fu/4A9?=
 =?us-ascii?Q?9e9qin5xTF3KIU2L9UA+8jjfwIYoyXNGKnWrIGPbc72O1snuvx30AVeNgiUK?=
 =?us-ascii?Q?N1SX8Kc42wDDtwz9AG3qayTdi9WjITSTWBIhA9i/TB6w2EzfcckhADQ7e3Jk?=
 =?us-ascii?Q?FWXkZTvvVht5sMTYKpUqCduKHvTLIS1bdr+JAiu3fvDYOFxTiHvHVWtnIgtB?=
 =?us-ascii?Q?8AbjxrU41TBsKucEis3VJDX8enQGdG3CXh/PPsd1zT+HyEGqbCmTGscbuJ+9?=
 =?us-ascii?Q?DIgOdZYypTHka03ehnhQ2M7FxQ5m6xfMgJI6uLGmMGHjzfXv63WRPI+0cVRl?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e71bf5b-104b-4309-d334-08dab0f86b10
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 11:03:42.1926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUax8uQtTZTJbIvOKoLIwEHHLSoJIhnlZxBoSe93lNoOuQarbW1QW4OSB8JwERgyrcSCshMnEYJOvy2SFofenQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7369

Use msk instead of mptcp_sk(sk) in the functions where the variable
"msk = mptcp_sk(sk)" has been defined.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1cf8b1c68e09..11be5b9c379d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1616,7 +1616,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk != ssk) {
@@ -2261,7 +2261,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	struct mptcp_data_frag *cur, *rtx_head;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	if (__mptcp_check_fallback(mptcp_sk(sk)))
+	if (__mptcp_check_fallback(msk))
 		return false;
 
 	if (tcp_rtx_and_write_queues_empty(sk))
@@ -2943,7 +2943,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 
 	sock_hold(sk);
 	pr_debug("msk=%p state=%d", sk, sk->sk_state);
-	if (mptcp_sk(sk)->token)
+	if (msk->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
 
 	if (sk->sk_state == TCP_CLOSE) {
@@ -3002,8 +3002,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_stop_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 
-	if (mptcp_sk(sk)->token)
-		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
+	if (msk->token)
+		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
 
 	/* msk->subflow is still intact, the following will not free the first
 	 * subflow
-- 
2.35.3

