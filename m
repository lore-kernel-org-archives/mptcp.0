Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B01D68
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 03:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1638763196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMYkImK8F9RAYbnsslJREBWgmyJSXTsIqbVq81jdn/c=;
	b=L4MFEF6uLnWZd4nu9ZY15A+3EAJZl7DIREVNUTYwqNI82G9FLhoqmFdE4eDVXDVFLiP12r
	pkCbAo0oj5HKLNjv3j2XXcia/5Hqo58ypM1yiwtySHed7/LpGIfkPQGbyBixKcWtTuzf25
	Wz2JYg/nakmT1tzZAERQL737ki61Dds=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2052.outbound.protection.outlook.com [104.47.1.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-VcM4y2H0Me24AWema84iWw-1; Mon, 06 Dec 2021 04:59:55 +0100
X-MC-Unique: VcM4y2H0Me24AWema84iWw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxyua+lCbW/LPaRvWmtDp7TetfhTVjg2KNqK4vncO8NzRp3EW4fthyf97zcq+TrU/8zGxHKh2MG0PhDCoklyv3EjHploEV4AI0X9+BZSLDkcmtsY5Nn+UykLtBBW1GWjDFI2ntRPLprowls9DT36enF+u2mwm8vtIfD59x1oNU8s8jZakME9O/N/n3EJWt8RhfbJ+Yw8sy1GLOwNtRQ5UOudx4RouBsKHgNYn1+8VcUpr6LGuyEkLAVa5UcsN66v0KKL/Mwi/gAR+LZHjkek3vnOJ+Y6nvd3Inee1GuLPS+JcjsIdMwFed94ssZELGNevjocRXwTIXqwGvqW7qSH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhN8DGMig2/3iAt/YGe7jK7yfo6Vh2PFRU3mMf1aHBc=;
 b=mN6hOoLbdYRzd2ouPkwtkOdb2PTVXqb+4hd14WtvhmRu9wZ902Qzn7mBpOArSD3c8fFVB614sXZBdg6JBUr8ZncPylVoJYh1pcHdao8w1aEJD0uTvJ+rDNHkp81xrmNU57XsoYdlhRXGn/44lP/GfH+ZeI4MFi0vIp+qOH1dJywwcIo4kiZ9hJxX4g/CqTXIf+uukm8sNCB3pyFNuki/pOpELYWuIn78dVdVthqX/d526eLkerTk8L2KpsRcIR2xXs83Oa/IKKqPwoMOM0cPI96HTaQH6iS12WdPFhQujm1n5Xtoe1Bo3V14d+ZK62N5jBRlk8GujLq/KDeUSKyQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3065.eurprd04.prod.outlook.com (2603:10a6:7:1d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 03:59:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%7]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 03:59:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v6 1/2] Squash to "mptcp: implement fastclose xmit path"
Date: Mon,  6 Dec 2021 11:59:34 +0800
Message-ID: <9b7f1f42a7f25006e09e2484bee5643bbb13568b.1638762825.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1638762825.git.geliang.tang@suse.com>
References: <cover.1638762825.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK0PR01CA0066.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Mon, 6 Dec 2021 03:59:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fe51b98-a9d6-4821-1182-08d9b86cdc57
X-MS-TrafficTypeDiagnostic: HE1PR04MB3065:
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB3065AAA82100FC6B69D73539F86D9@HE1PR04MB3065.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VM29mEKEd/yv9Kxs/U7LHKYbJZlqtXMBaReUTYOBQN8jXueZV4/GC3HcFMnEZ+O9NRMMmOcdwPb1TQGsXVgszHlsdnE0wGWD5JdM+OFC5qGY+RCciqS9DvzxQd+jw41VAq3+4ST4v0feritz4JCjBcb4j5CiJdl7sGHFYr9+v8sN0bxTW4XpbHpyoQKnfQfOn8/TNi7DUy6XMHLm/JFWAe3V7HW4k159QtGi/E9nPi41TAvQiBa7tMiBZLygVfwQahYMkPtCRfH53xTwMoEr1+Da7ev9CmwruRF6kktlPtTzxX+Kbo72qwzbmQuvsB/2cKp6ljwNKTEDI82pPiKcYbcXChNeXzWnslhmsdxl/IZkdFJCjtnpIg62Vs+EozN8Umnof2BZISVLHHZZYUfpyJwaDzbIyAnLNpD4e0xkt+0KXWyTPl/fV+sMpKAO3aNE/0nnPcranntXpaqTdhSFHkgO3Mneiugw8Eg0MSOrjdS/Lu6NJeHMlrPmlmFJBIl00WSS4pi2DW/DFYhazQwVZsPhqzgs4YNIMCIq9R0aYkQRzX7UlJn0BBQ+944urdeC0ZM66INDly9F3lwREoXR4/f7dEuVomoQs+Fcj5vSGKV0AKCIDMJffq5JKYiXwoXCsPJeRR/l9Omi/URK8XvP1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(4326008)(2906002)(83380400001)(6486002)(6496006)(8936002)(54906003)(38100700002)(86362001)(36756003)(956004)(2616005)(6666004)(508600001)(5660300002)(66556008)(26005)(6916009)(55236004)(8676002)(66946007)(66476007)(44832011)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hYasuG61sfMGc5RFbL5TsD+jft7+tB7aI2yeKyJTtIKeS68czXsZxpHBUtCm?=
 =?us-ascii?Q?9EozquwiJWYhrcGV7J3VCELiF7dyrGfZhHKZt6IDEBrv9pR2roaqKgBiXAce?=
 =?us-ascii?Q?PAsyUdpzmmgW6hqZ2rGhIhrMzEwoA+yNDkVXNjd0bO1eLRLYHEZ+u4ab3DT2?=
 =?us-ascii?Q?Fz5gobdHu//5igvkJZ3RxDo5LfpFYN1Ulx0DdAtMEdHSGkjWsRbuiZwDZTh1?=
 =?us-ascii?Q?L+xXEcAuJlERPIQfWW+04OvJM9j554M0h/kVnrjAwRCHnSUM2YFrbv1nhfcy?=
 =?us-ascii?Q?tplbOqkoV8pgUXLl4heixqz7SZblkSmDUQz/Z94Rwz+l27tWa/jhU488IgoP?=
 =?us-ascii?Q?8uMXF0SzYer+AAXC7Teh1K6lzlrGqpMuF6iL6B2R1sc7IBh8uzz2aNYBzNFg?=
 =?us-ascii?Q?9lS2u9HPBDjzgNNyAT1oU3vyYMjVKVkPGtHDnhDTx/tg+E6jcb+V4xw6+UQ6?=
 =?us-ascii?Q?HW43FLPEFKyrfdem1ebqRFvgvebTo3wgwMzjoSScOFZ0g4dcvWzpvlRfAvUv?=
 =?us-ascii?Q?pyf4PFmas2WPSV/mJFV/WTVIEQYk05Ycb6ulrREXDQ5m0+8VtOCGFC9pXZK7?=
 =?us-ascii?Q?iQEKDljkW8bPV3MEL2k4OfwcrIEUHfKkgKDfCyfB/1/vE9Jc9K9ny0Axvhht?=
 =?us-ascii?Q?gs42X87H11WlB8ecDwD5IPHsngAGVQCuAKtnUt4HSRggWgMpgO16SxmqGPNj?=
 =?us-ascii?Q?aN69j3rhsgfA6fqufz2ZkTKaBgsl7qYioNRfzkJvEpjwgl1ovDzupZ+MSdXT?=
 =?us-ascii?Q?fG2iDBn1kCYrLrtmOw9wemAKxnCclwyWrq65JfOfTdN9hQZzC/GZ4Ei6gsRH?=
 =?us-ascii?Q?a2pp035Y1wbjL4AacCV9PoK+O12NWLt2N5chUUM0Qx3b7G9ezmdeIurdDzKF?=
 =?us-ascii?Q?vRpyRKHxP8ifmG+Ik+1AhTJmb7RtFSN3D3yZzJJ9efAA6ZKxOt9J1ysXiYcG?=
 =?us-ascii?Q?g+og9xjp533ONF1KuUM9Y3P2yhImh6oeM1gCZajbc1wfcEA/iwAIJ4/Nen1E?=
 =?us-ascii?Q?tl+cJEalSFVRBwDet8NcfvhW/VRpqQpw01HmY7e5yOizcDDjqXXXVqom1aLk?=
 =?us-ascii?Q?pDy6CXoE3OYJI0eLz+9N/Nt5ZbByYXizUwPqLhKYG8uUe2LCDS2MWfNjeXbg?=
 =?us-ascii?Q?rlaaa2CbmJYN5P3JXeMKoSZ69YrBokR46Rhjk9QbaBoLKxoC/sikZIU4un3W?=
 =?us-ascii?Q?D9EifLpfaTPJ5M02lXiBXBBG+R3sczquY1/djfFfcV2pUNh5V7fDqvqvAE+q?=
 =?us-ascii?Q?R+APSbIgl1t1Ae+muihpSHXprMFdfzqErRd08osFLylQiQQGJX8pdmOXgFdq?=
 =?us-ascii?Q?I6BskAlXBPPHDmvsWMA7/l/ZmGm4WLZ7phWTbcBN/61Jl5ZAds5LlLiKvrEB?=
 =?us-ascii?Q?RDv217FKlh+3pOSRVXFIz747ORUfQvzQypLfPkMKTr/G9Tmomi69K91lDsJO?=
 =?us-ascii?Q?s2SAaaC/oimtEZTEQaf0JrR+MDeYP5EK8DV3Bdhyb2dyGlBEEs2/IlH5RR+i?=
 =?us-ascii?Q?beBLY797BE+a2QuIpYMzrb194E4lCqasKuz6aJkyTLez/DYlYMbWowhEQnH7?=
 =?us-ascii?Q?Vm+Oux5CdHioydz0SrwpcHJGL3L1+zWvp0sWruChVJtkUDowners8R95WzoD?=
 =?us-ascii?Q?NJNlJgub2S0vgQBGGWJEhdM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe51b98-a9d6-4821-1182-08d9b86cdc57
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 03:59:54.2937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1t875D9Li2ZBBKR72NOX1ylklWco833MbCAN+3kGjrV8gS6dvfi/rtk6icli2XORCBVhJC23uLcLzi/bOnQGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3065

MP_FAIL could be sent with RST or DSS, and FASTCLOSE could be sent with
RST or DSS too. So we should use the same xmit logic for FASTCLOSE as
MP_FAIL.

Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1020e4285c..c5c0dd983ad6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -828,9 +828,12 @@ bool mptcp_established_options(struct sock *sk, struct=
 sk_buff *skb,
 		return false;
=20
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
-		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) =
||
-		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
-		    mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) =
{
+		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
+		    mptcp_established_options_fastclose(sk, &opt_size, remaining, opts))=
 {
+			*size +=3D opt_size;
+			remaining -=3D opt_size;
+		}
+		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) =
{
 			*size +=3D opt_size;
 			remaining -=3D opt_size;
 		}
@@ -842,7 +845,8 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 		ret =3D true;
 	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, =
remaining, opts)) {
 		ret =3D true;
-		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
+		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
+		    mptcp_established_options_fastclose(sk, &opt_size, remaining, opts))=
 {
 			*size +=3D opt_size;
 			remaining -=3D opt_size;
 			return true;
@@ -1269,9 +1273,16 @@ void mptcp_write_options(__be32 *ptr, const struct t=
cp_sock *tp,
 				      0, 0);
 		put_unaligned_be64(opts->fail_seq, ptr);
 		ptr +=3D 2;
+	} else if (unlikely(OPTION_MPTCP_FASTCLOSE & opts->suboptions)) {
+		/* FASTCLOSE is mutually exclusive with others except DSS and RST */
+		*ptr++ =3D mptcp_option(MPTCPOPT_MP_FASTCLOSE,
+				      TCPOLEN_MPTCP_FASTCLOSE,
+				      0, 0);
+		put_unaligned_be64(opts->rcvr_key, ptr);
+		ptr +=3D 2;
 	}
=20
-	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
+	/* DSS, MPC, MPJ, ADD_ADDR and RST are mutually exclusive,
 	 * see mptcp_established_options*()
 	 */
 	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
@@ -1465,13 +1476,6 @@ void mptcp_write_options(__be32 *ptr, const struct t=
cp_sock *tp,
 				      opts->reset_transient,
 				      opts->reset_reason);
 		return;
-	} else if (unlikely(OPTION_MPTCP_FASTCLOSE & opts->suboptions)) {
-		/* FASTCLOSE is mutually exclusive with everything else */
-		*ptr++ =3D mptcp_option(MPTCPOPT_MP_FASTCLOSE,
-				      TCPOLEN_MPTCP_FASTCLOSE,
-				      0, 0);
-		put_unaligned_be64(opts->rcvr_key, ptr);
-		return;
 	}
=20
 	if (OPTION_MPTCP_PRIO & opts->suboptions) {
--=20
2.31.1

