Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2071.outbound.protection.outlook.com [40.107.8.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A961E1C4
	for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 14:10:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3oMiQPZMfSOmZeUZ6W4jOjfs501WnlLUDOxqRAs+C514TFK5zHwYtGScYufi8oDw6uCCmdako5FA3SrSS4zvyxHFowFCmH/B+j5MzxcyUFOZX6rqn9MWUa2J0WQu1ktG79sUBHHgpJZXODe+uCSn/pm7RW4m+VwvzwcXlLxeeVDTvHnLzSKYhj6vPeZuij3pPWk7e2gwo7SxVVm4XUEiYe27ZnOFIOeQuSGm5/NctKB9Yns8GuNKZvHtyWbtiS53MQXBCgQ1qDaCs90pAJEK34pgVe3lKTsWrCPHPSJp1YwGEnJw8S+BeX0yLkTAgsReLD3wyNaJgWsVjZ7bQhiLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdqKRo2IeuFouYTAT5ncNnA3b+h0GoBTH4ZGs0jjxb0=;
 b=nNzXOrzjk4iSvnou8zg9QoIQyK6F74G9atI1Zag+sFFZp7E84lgni4oQONnM0ED+4GKiRf//HiOqAccLt9ouf7qXCATruZ0HUSnH/MCg/Zg2JwkYG2gA9A0eoxi6R815nWMNE51torby0r+ZlpyWu1cBs3v4kTPV3ieLWYDEVpnI5A77dwVFTng8xAhlVpq5u3MUrpnm1OGD7kKel6LGoujmJnEy/pn4tqPZpttMgKO6yztFOX7vIZthUsEGKWcNs7kw1y19Y3HeyVbOsrBIieM/KaJJCwUmvOcJJ81jSuN7+LoYql4RfFFvWZVAGwZrHdBg3D2gQ7h0YkTKZsf98A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdqKRo2IeuFouYTAT5ncNnA3b+h0GoBTH4ZGs0jjxb0=;
 b=3HnkLUHEQxCPlIpjSC4BUEMwlnF5iy8SbbpHtZLw6/VTk2sdtoJS1Ti/9O3hXqpsmnAK4a50bfsP2Rs4J8sjZlPFHtG3O6uqorRJjNziQ8EUzv4MxP1qHtgdchwru4VFK74Xq1C5tgVyB/O6HcgSZIAY9SGggwNdQ8acdy5zmB32Le5Na0Jv6Al0ej0OyJ9EydQPkY+AbCVUTfwgBUdHNBlvTc3JetgaU51h4zwx+AtS6nijycJEYCt/O+NMJVxeFDv1pUqhusspblSrQBLbIiyysoAjXrT/7m1dJVy03esTy0pWTtQ+qr2uS7ydNtyps4Xbk65Z9UNqTm00sLhohw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8993.eurprd04.prod.outlook.com (2603:10a6:20b:42c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Thu, 10 Aug
 2023 14:10:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:10:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next 03/11] mptcp: use snd_burst wrappers
Date: Thu, 10 Aug 2023 22:09:55 +0800
Message-Id: <4e8662cef4da1cbab18b467b922284e23c9b97f0.1691676509.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691676509.git.geliang.tang@suse.com>
References: <cover.1691676509.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:3:17::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: 7738078d-3604-4c55-df4a-08db99ab8563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	879yIoFU2sOIER3oMI0U7Nr/x2FrPN6WiSna5qqR66q4Uqi53LsV1xf4r+50B448CbY3BCPRwtVCvUEaEUMWS2Qy1g5IP4KaTGMd3O0hVgZGmdc9CadIheRiuz2PZpV1mHo4ZDRAJGEgTP+Y8oRrH8dXT7iX5YY7hz1Ntor68ufKZXiqKI42xxOBlWM+P9dS/3K3pgyWiFcpR0wzF+Y2y4YhJM3xgNSD2qiCoNwilFKS1ELzbYsNmIIFUc+i/jD2R6WAC/1zqa/w2o1LmFuMYKH5Fq4wcyQM4X7CnNN8vgKjF03I3ehPplODYpU7Gyl8ajlF02f8mLPy3LlZQLCiX8U4C+HeWHXg/ikj6MMNpD2h7++SWxUUIbtLgNBDNuzXhSNBOvROtoP1dSXk86w3HNmB7ORkYLV7f+L5uRdyOrsP1FERjXhFHDrAkbcXh4KxrfWWdjF1+/kT8KuZ7yLB4hn6aPDG3/AvGTPC6A066qzErCZpIhofb9jerlNUQP8eFgZ7OkMBsKo4s1ZL7MSI41vXpLR4T1uZOGrDT80ViLXvUqYOwXLpE/UXvKQwcFCSg6cs2fxUTCZcwVqkYIrgMbAKzlhyd9rbA1Tdlj7fNQ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199021)(186006)(1800799006)(2616005)(6506007)(6916009)(36756003)(4326008)(6512007)(316002)(86362001)(38100700002)(478600001)(66946007)(6666004)(66476007)(6486002)(66556008)(26005)(107886003)(8936002)(41300700001)(8676002)(2906002)(83380400001)(44832011)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z74rJl5xPKqcLZ9qrEyuZ9yso2GAkIrnBks0nHiwBTdAxhN/4/MRtVsqQ8ME?=
 =?us-ascii?Q?CJR3J11z3clEMJ/DVcSF5J4KMF6xpbMpfmpmKS+0iMEC5r2iH8+bjfwEKyRD?=
 =?us-ascii?Q?rJDmosDABg70b734MfNsZczERDMPR87tb2Q3vItjuC+y/4WJpDoLFsx6pOdh?=
 =?us-ascii?Q?OamyZESwprgdisxAdxo1+AaS+Qc0R9iJkOnTNnprWkAMCA7e4L/e2V3bwZJx?=
 =?us-ascii?Q?J5Q+c/ynvXhz0mFfemEzc91/b2TbzZ8Mx0r39xBWid9PT/1VBe/TM/ncCsyU?=
 =?us-ascii?Q?mU9P3ZHVwuAoTTe3MFBi4C4Oo5bj/LrAQEVftIOGpFlA0RQn9yroqD/GOlwW?=
 =?us-ascii?Q?sVPyfhVgJ3M9JA5eGxG7wo2h65qyVgLlbFwGCJYKKseLZLIVjiKmJMkLdC4d?=
 =?us-ascii?Q?Y0nfcll6orSYTt8h91nWT1IM3AdIgtVtii0zro8xFP3wggA3Lxcr5Z36ygpg?=
 =?us-ascii?Q?Kkg+jWQwQQtfwMDOFABJKJWi7YILQ8aJM9h1fjCnHHrf1wXRbfuDne80MNAb?=
 =?us-ascii?Q?woO2UzDuTbE9jwVRR781uwTsh0/FdLyWB6KJPhhDTUeO3rzA/5Rqc3l5bLyq?=
 =?us-ascii?Q?oVobw381zdG7RnaKEciBkYJuzO63hkXkoBeL0aaL3Rhty3VUaOknM+Utu2CH?=
 =?us-ascii?Q?aoyGayozxbzWj5COfivaZanlKqq5+Za/C8MwOhDDPggiOlZwnJjZEEoVMg3l?=
 =?us-ascii?Q?F+MYDCd1uYGpm0Ju5r0cpS8qbvFoP5kNS4OfqFj1PaEyNVGthB4j2kPkkMGX?=
 =?us-ascii?Q?h/XB3CFk0Th6wh+pLGyZHm2URF99qHEIR6WoORZ4BN1YM24nQlQ7IadTTmxE?=
 =?us-ascii?Q?oXQc7hNKRo1g92qkTuC+rkMXJB+dndK/kRtT7jSuAll62NKn9buepBtVSeFV?=
 =?us-ascii?Q?nG1f4HOHjNqM/0mNHFp2X7N9b+5r9nJj98pWMh6Vz7czLIrHAkG7mgtfA2vC?=
 =?us-ascii?Q?XKMubbmo+rRtzb9qRAF/kG3q3JcVNUnU8PkeD8jMIcnTJVlPc/K9H6LOpfM2?=
 =?us-ascii?Q?yYnLDv+JTLnCcoH42REKTGQgaKOmWxzEqWPfA9h+4Wb6JuTh8E5Us9TN58gG?=
 =?us-ascii?Q?OBV44dwu+B1JtPn3IzYVwfqAGbScJM6ISz3IwPt2pWArkziGyOL0WA57AuHG?=
 =?us-ascii?Q?umSk4id1hvc8TaEC6hy65/nnVHhwFnxcEPnu0FSjhShY2Dg0dkIvxnWFogXt?=
 =?us-ascii?Q?xtZg/a9TuqJXnpjuId8S9aSEK3ilygBPeM47Tcv93qGaUaq2q9g4bZNdRoGT?=
 =?us-ascii?Q?pUCnSvx+AiEKSk2I4pdFcgw0wYeZdI1vgmeAPzasSpU8/917n7kTkrNNcA53?=
 =?us-ascii?Q?cOVSd4JoRTU+zjjmm3MR4QObigIUOaO65wbruJNtawX3sKAX50+DrVsVn3MW?=
 =?us-ascii?Q?fA6rOdf6sG6QvEBmjY9As0L20HCiR2M2SiL37l/2CwkUPZv9LZBRvGDjUMAb?=
 =?us-ascii?Q?pQZ0ze4/GiONmlE0r1sGJ4t81/lbUukKButCBUTwsvGfFU5TAbqlZS9IHi/m?=
 =?us-ascii?Q?8G03tNFV0KH0o6/aukmdfdyYU5p5u+SCdZ9e451I6o2DkcxUZLXRRQn5Ck0v?=
 =?us-ascii?Q?UzhV+cmkI+pYZDMhZdXIGZQK/j79yjpCRDgR5jxB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7738078d-3604-4c55-df4a-08db99ab8563
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:10:16.1565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QA8go446+vYodq+pGtx8fGBGufqqkMyqDqBtpTFU4s340LZlWGfijLRHa0E76fAV5fFTw9BHcFeZ+ah6TL6qzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8993

Use mptcp_get_snd_burst() and mptcp_set_snd_burst() wrappers, instead of
read and set msk->snd_burst directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 40ca9f5d1360..77aa05631add 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1436,7 +1436,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->snd_burst = burst;
+	mptcp_set_snd_burst(msk, burst);
 	return ssk;
 }
 
@@ -1454,7 +1454,7 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 
 	dfrag->already_sent += sent;
 
-	msk->snd_burst -= sent;
+	mptcp_set_snd_burst(msk, mptcp_get_snd_burst(msk) - sent);
 
 	snd_nxt_new += dfrag->already_sent;
 
@@ -1507,7 +1507,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-		if (msk->snd_burst <= 0 ||
+		if (mptcp_get_snd_burst(msk) <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
 		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
 			err = copied;
@@ -2290,7 +2290,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	mptcp_data_unlock(sk);
 
 	msk->first_pending = rtx_head;
-	msk->snd_burst = 0;
+	mptcp_set_snd_burst(msk, 0);
 
 	/* be sure to clear the "sent status" on all re-injected fragments */
 	list_for_each_entry(cur, &msk->rtx_queue, list) {
-- 
2.35.3

