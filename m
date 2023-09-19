Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307ACEBE
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:02:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dgl/7jaIEY1Rbrqm9a++6PkH4t6sSthskYxIVbgI3AeiQ//Juzrmzlm2rN26FueUzXARnaB6Ttq6YLJrmb/7abIQ2bJhIbyU01ccZfwCALB0stSy0Ccvgsq2yEZYo4AbH9DTiDFjYR4yHHuKHSzYHxGaiFW22DBcI64Zo8qB7g+ah5pa3TB3oqob2iOJw8sxzu9+/zBnst+az0xrWC87g5THqCgWh0Rw8Kaus7C1fAp8t3Af+rK6Bk+xDnoNfWIT9z10HKgTIjIxtFDLtJtHGazxwUVGw6gX1+Q5MvxfHAt7si4zvSO2fivSdsyAZWhpmT138xyjrHb4vzqsUAT26g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+Y33su+C9J6Koo9Ht4ThakHCQPCRdOnwLNMviqBHVs=;
 b=UMhVMrsi9kO0WGoU3q5yp/7kYyMC33n8zwNConiHm9hvZUR1mOj/fy/kE2Q7a6Zjd/zUaCS2zcX0TH6odZ45ir7VjDnmyPCpOGXagrviKyTqnibqt4BqHxaw2u1B3mWc1i4I8auX1tXrZs3vRQ7Dm2WsN0Bbc9hb+3XptxOTKq6I6OzWGmmUA2TKxXwaIvmjSuu52D4TUQy76jUWbsCj2p1RRGyy2zjhht2vhieP/ucxgjluieOMyMze7atZuq/j3pkaoOn1G0XG8kcS3QBrDVrSOSgDZyDlyPhsRV98P28IJXJTbwJsbPTmsSjk3CM0al/76Xw8f8frYgSZ9mmqEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+Y33su+C9J6Koo9Ht4ThakHCQPCRdOnwLNMviqBHVs=;
 b=RHAG84RfuSgMEEi0Ozu53sM+DIyUhaN4cEeJYqm81KUHDRTnWFYhUBsxdNmYNsvCWethVCZCzCiVQ4wR8OJti/eFeq4M2Wi4JcCXme8HoEk6eMdveKG3gQeOwLVkvN7+9SbbnHX5G3cdoOb/TYZbm2iBROlQHYRhs3jlsEkelBTfKf5n3Up8jXtgnsfnDU9vZhrq/AMvC4TprIHFoXDWkauDkCxlSkFzk2JUey4/YFDr1Ve+80OF7pstOPLjmxTaYxN2oWPgmzH3Cq+wD2oOYkQJCGDg/gYvZsGzdiDNnVkX3vA30DAUQ8Njxc2Jx9E5xEMQtsBj/4znsEKDwzcD2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:02:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:02:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 03/30] mptcp: use mptcp_get_ext helper
Date: Tue, 19 Sep 2023 12:02:04 +0800
Message-Id: <eab3413aa2ce1a12430af650e9452e887e14c1a3.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0181.apcprd04.prod.outlook.com
 (2603:1096:4:14::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: cf999998-51ed-40bb-d069-08dbb8c53734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Apgpi2vMkLYElllJvHo2rwYCZ6fjk+G1pUL17TVKypk+Z5IqDxztS0gzX/oS2oX3/qIx/42FMJkWQG63yQz++NbVeDLUWo6rj7tH6L/B7N6UmbVHl7Op7sAafxB6wkBAxfx7usEHXo+DLHpw9+pOyrthu5cOtkytXmNcCbyo+9vyMzIdAasYyKY34yu+QUSjTErjguqHdvsSWdEbYOEMIq8eCTH/dFlIUj9uvgedbGuIqK/xz1jX3hZxKi2S1yjhovLMqD6XJuipBXOKG7jBTcvJE4k9fny0eIf0moH1L3AtXrBL5Uv1GfiFPNHLtnXzrBGC2J/zThLJSmf8kz46FF3BMQpP3iQxjDLuBoGGIzlHi5RlfenS/YNVEspTsFf24E9By7TgHOjjPIH5S3wjW3AyE3ZQP3aCs4HiNR8tA83+ge7mdFLhBnvtp/7M/UaWOmM+MCFplhn9LIGinxTov9ZHKMV9zbsPKJRCWtgDssa7AvD9gbje5Ef8ty6E7u41qPv9agX2hullo9cr/dxNVe3AOnCkeKC0OKO7M/1tuS85ZAkaeZ7WYoG06pU+kk9zLEU71RIQm+V7Aezc22lFP3+hZ+qNC7RfI+oI84mz/Mg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(36756003)(2906002)(4744005)(38100700002)(6506007)(41300700001)(6486002)(2616005)(66476007)(66556008)(6916009)(316002)(66946007)(6512007)(86362001)(26005)(478600001)(44832011)(6666004)(5660300002)(107886003)(8676002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Se1r8XSe9NDVU4nu+vr5eI36nyRcE6LJgp7A5yGZT9BzjyXVte4WaOCHBuZP?=
 =?us-ascii?Q?Ee+HxwmJ+iA1Lw34EZS0zlF2Vhj2C12z5C1C3/SNuqz2McRAvSIkd0lHo41/?=
 =?us-ascii?Q?I/OhtNRqzv4cF/irDT1UvJNT9dVK4jL2qkHyZoiyqWCOJ9zJveZkpbLLM4Cn?=
 =?us-ascii?Q?WvvJGn2q0qf4qtWXtPUIURIvIoFl58PNT08zpVxuaxfmfF/kD1OXtJccmhvn?=
 =?us-ascii?Q?MBllHAaEPcZM1Hi91PtBQ+1Q6k4EmGV/aJ3dlocGnBvDc3HE5PzPjbixq9UU?=
 =?us-ascii?Q?iOVc5Nue9ocyP344vc+CWb9KQeg8BI3it2PG0kiOKoEctqMQ7CJ+078nRuso?=
 =?us-ascii?Q?mt7M4IWUk6AnRQjtkjrnZuPOFu0tWwGXmpRcVdfCNOJFQlFC0sSsYTlIurGo?=
 =?us-ascii?Q?Se/Sq7uox7X9/0nL3C5AZnQydtJtm9D0jbdImDCuNJVLdO6n9AtZkkd+ZjBX?=
 =?us-ascii?Q?yCrymEqEW3/vVcn9RA3NG3vuFdJMrSGJjJoWUdqK3TQevBOUDQSUhEplTbM5?=
 =?us-ascii?Q?R0X4OlJIfgHTzczVZGHggS0lzRPdYcOUD4NNr8tuu3np1ZCr8TIrXghAdTJu?=
 =?us-ascii?Q?jTXV9EZvTbWMzLHiNDHDgQjLttbrngX8ZW4DauyZSVSL7fBQ2jv9IYBQTweA?=
 =?us-ascii?Q?+g8LzAXSlW0DxQEfqjvYUE1++QriYl8Vd8gbk1FKEF6GpVRZjFvAg02s6Vz/?=
 =?us-ascii?Q?FzTcb4RQV7eSEtOZJLpIBazf04RQev1HDLUBpXssFqZQYSHhctWNjTYVUmuz?=
 =?us-ascii?Q?3Umve8dw1nceCKXNrX0kcVCvVetcoZIBtQYo4l7GWFfMu7gVZbRZCmkTSBFX?=
 =?us-ascii?Q?zfHemDtogJIoMvSqKCNTXUuQbT1rcQGFJYzjBuZIbAePZcJnTro+X3czW4Ny?=
 =?us-ascii?Q?ZKVqDkriLcfZ8569v4sB1aYDaj7UlMHgXSVAU4A4D0/uLVaBj7ka+N3G19BF?=
 =?us-ascii?Q?48pvthMoHinGxZoDbLflgSW6brwmVHIeWoU0m+DzRMmYn6Th6mqtC+HAqaB1?=
 =?us-ascii?Q?Ryyzq4FEuMKIiI0dRZb0NGIVoIxrvQ3N8M16lNvsqwEPhEO4tu98pYYQudv9?=
 =?us-ascii?Q?yz/sRe2FNhY4fgu60zlLSVJv8HILtK5SGQ+1TgdegI9MDjYOl9rgTGN4+DQC?=
 =?us-ascii?Q?Si+ykX5ppXXNkG90dVTPfHjQk1GCSkzpr8DBotFoX9wJOGJl540RTsElD/Wo?=
 =?us-ascii?Q?3KBvCB2+QMyECxeqSmmsJUT1yCxjkpEAkS7hN2eE2uH7piMh5sXJUWUqvowX?=
 =?us-ascii?Q?Td2qkgFoEbdUVj/AYFX6lmRVmpugdliZuBg8RT/AocWnWLvgM4OrvFH2DTC0?=
 =?us-ascii?Q?t3NXM45bS573U/3UGYRL+WQqo6Rt+KcZ9/pkKJedYgmlVoOJ3kzbIi8VIDvH?=
 =?us-ascii?Q?C9r+uYQf3k/YhDNrIjgmm+wVPvm50/4SroJkIwJiWlFeqK5IHoPlL6RZSUcu?=
 =?us-ascii?Q?2L6amXLyo1ttI+5q90kTuJdYgQETkAQ3dTefv4UNFQzZTYM7v7jqW72+BZt9?=
 =?us-ascii?Q?6BPhvJ93PEUmabEww5d6EFR6jmWfI45Yx0SMGRKuZp3d9E/co3oZ4LsDKaP3?=
 =?us-ascii?Q?ImIbwqwzFTMDJXh+2QhgN7YQ1c4a/UXczD3mdfNn?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf999998-51ed-40bb-d069-08dbb8c53734
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:02:17.8452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njXXIsVWJpdGI6SXiR8/7SCm9bWNyE4Gk8rUKIL+ScvBBeOpto01EXAvutGY5v2qY7jrbSYJvE5aRQkN3Es9qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

Use mptcp_get_ext() helper defined in protocol.h instead of open-coding
it in mptcp_sendmsg_frag().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 15cdcc0f03bd..2c2b1ab7d1ae 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1268,7 +1268,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		 * queue management operation, to avoid breaking the ext <->
 		 * SSN association set here
 		 */
-		mpext = skb_ext_find(skb, SKB_EXT_MPTCP);
+		mpext = mptcp_get_ext(skb);
 		if (!mptcp_skb_can_collapse_to(data_seq, skb, mpext)) {
 			TCP_SKB_CB(skb)->eor = 1;
 			goto alloc_skb;
@@ -1290,7 +1290,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 
 		i = skb_shinfo(skb)->nr_frags;
 		reuse_skb = false;
-		mpext = skb_ext_find(skb, SKB_EXT_MPTCP);
+		mpext = mptcp_get_ext(skb);
 	}
 
 	/* Zero window and all data acked? Probe. */
-- 
2.35.3

