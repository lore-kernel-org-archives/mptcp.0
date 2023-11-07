Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2067.outbound.protection.outlook.com [40.107.241.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A642C872
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gtosPJm7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Owa+cU/NQAL5zQEJTE9ZigLdZL90NRwNNc94avPgr2ALnLLG5ZR70SNaQUpIg8mVZiLIgsaxpBYCC/EasplubsdzXr31T+LqVa/KiIXq0aGW6thTEHfbhR139orIxTgRlaqJoCcaMl54GJwnrXWRXGBocZATTBW0SNnM94r4M/5gP9ZnTtbMWZzTTd19lqoIpY55LU1Hj1gsFY4Qq/DgB+0CXMsffmRsCqR06OnoU/MvAVK6BeC0RXlH6j6kYmHzuV83tfALiZfRdh153futNGqg1TZfzKTrlhliL5rhnUYQJqU69dIZT6DghmPrmEyRLyAmLf6BPIE9yWiQBojntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZz95VFXTVhMoPeoTa3zCbK+HVPFALauThw0m6IGc5c=;
 b=k6OfREMSALnG8boFnxFGWz+bo6mSYip/97HAVvKDnpswO0TP5ecRU4ASvdB/+7LrsdPnN9JofYS+iDssgLCXTo7Dm7QOB1djxJ+aIGyyth9NLMRjpTYkO6mg5qIP/HhWkcLNLMz6JAWaRz+Axvo4GiYuzUphl/GZ1M/kPSAiMuqbuqi4G6G0h61VO+QM1410cwYBlgWC398rqLsNq/hW+2xxkPSBF8tFgHETI7KpGQxVbBGcBgTt2eKcQJkSQDOWu5NBB5F9DBleymFTRuN/vCC+dQan1LsFi9nUDq4jW1tWdHvqlB7xEa0xtlw6hz9p+LanYlaR445wDmFVTw+m2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZz95VFXTVhMoPeoTa3zCbK+HVPFALauThw0m6IGc5c=;
 b=gtosPJm7as8Lzo5HI0MCDQTWN7mam7RlZiqLNaF/MBw3L97hLtO6GxKtdaBtcx3+ldG79K9Cu3MRXz68RAdlDzjXBod3jOYT/81dxkODK+NyEu+aFQWZnw2htlI5eZwwGRpP9pjYd/1CXZxLDs5Dai/BsAWY5qoYU90Zd9VPrNy1KvQlYddnMx0Br+mu0jopeebpUdQgyXFPdbIogpRvQxtFFfHmBpfVr4vgoSYfZZR0m6CAGGVO9e+tOq0KtrveqWubJ4qiMvXk3KXFJt+A+Pfx62hMImCYoh1J8LQC6A4eVA6smGCe8Z7L4AAoDZHQZCjYU0ifFT6xqTXm1JFDCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8467.eurprd04.prod.outlook.com (2603:10a6:20b:34a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 15:38:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 15:38:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: add use_id parameter for addresses_equal v6"
Date: Tue,  7 Nov 2023 23:38:18 +0800
Message-Id: <20231107153818.5498-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 238949f4-25da-4d6a-4ec6-08dbdfa78b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ADZLFMpKuy66EH6Egusuj5e1uRqy8NN2DfEnGsZq6B2Zk42OvnFIo9kWdVR5/R1EZvuah8+qNSWvY3/yHl7Uml/VMAoFCltB3emdNBa7kFN65ZWqK6vs09cAc4qdlIlQJ3ocGYjRKFZ2JlGUsv9sMDuKD2n/zsxUl9fyZ/SSJU4X+r8+ZJGuAYIkH1kAfsW2Dm5seuCoPb57FoU3bMwlLUFUDheF9xtCf2dJMtw2KRilrNxTpOpUXrLY4NAhjc1XeMozGv1vSCnKCKNBZzqE2phQ0lPldlqFcygx4yAIekyCXLrRh6Tf+5Rjtu88lmeOGPfmTCP8KeHoKzJlDQo9hki27cpYnhSE336XFFL5Cg2/E/2HCahDzDE+sOtOrLmoZG42skryMVPg4eQCKMHD5yi5aSatVq9XSO7fOG3kpCurYdpaRIKY+vB0hqGhvFhPgoG/8Ma8JlCLVKhmH3VhvaEBQlan2t8o6TM9KFs8dbZo6Mn2TskhRrKtfnp0U58Alf3WZPy+c26oZRcE7Y8qOfkaaolGT4B0+5sM03DU9bCR8/E5kFETAkjkHPy8h8HHujgaJmGMunuw1dFEUy7/wGZ9PbBYCGOrJeOBK1z/X1Gd3CZYczJVLZbTiQvGElUS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(230273577357003)(230173577357003)(1800799009)(186009)(64100799003)(451199024)(478600001)(6486002)(6666004)(6506007)(66476007)(6512007)(66946007)(26005)(41300700001)(2616005)(1076003)(107886003)(4326008)(2906002)(4744005)(8936002)(8676002)(316002)(6916009)(5660300002)(44832011)(36756003)(86362001)(83380400001)(38100700002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bf9+fhTiCPQsWxk3K05GjT8evks/zaT1oS2JeTywVCKiVJGJFZbn+qCQV5WS?=
 =?us-ascii?Q?DWnAAx0TT5qWbYZAeP3ea3ShATw28qlfH6cijnP07jtbs/R2kzC95tmRVdc2?=
 =?us-ascii?Q?Y8mbUaB6PBP7z8nOOqtJTjhouivrxFBF9jevbMLPuj0yF+IhM4TSBTNeZ3rA?=
 =?us-ascii?Q?V3ZVUFZkrddB4COcCceJqEhyMjKwOItlzLUSiiXn94TdbUh5sWmAsPOHkAgu?=
 =?us-ascii?Q?eKHdwOk8Zke/oHrqtXflYdYkcj6g8g4WbowAE+xkXZsH8DNtBgsXRFwQ1OFz?=
 =?us-ascii?Q?QTfBng3qwr+ZQ3MjWrb2vhlEZSa5vVzkfwy+5A8OpdbBQajao7a5Y1iWUkZF?=
 =?us-ascii?Q?0aBjIebaiiHJji81AFdx4DTrkfhLb4SRIPrpf8VB/lvVWRHbl9pxtpvfL+26?=
 =?us-ascii?Q?ZRsS1oyjAR8FsYPfRnZFDXJqCsMnG/X9f2weEUJGLKJNVmoALvKgJrN4gGIH?=
 =?us-ascii?Q?GNrda/a8LUskT0pc817vQpCuniMCULAOZe03V1rcc6btaDhKEVZr+Jxijdru?=
 =?us-ascii?Q?yB/MSvrcRf3zmzIc2p5j+vBxJGtaQtoysXl/cIqDtCjJeIWMQpTGlEOypVKz?=
 =?us-ascii?Q?Teaodsv/2LALQyMvsXGBrpGg3XI+BT92Mg6PKpHI8Dxj0FYrLAp/72pp38y8?=
 =?us-ascii?Q?krrDqzelT0u2xuFfvdsJct7cuGxm3VrWvwok7XzscSmRCOw/lXRD4JGMjyLc?=
 =?us-ascii?Q?ha8c4yhQy3+A189JJP/xKJGpDZK1DfmY8T7if0M9YX4ReNRE1udFtol4+1h8?=
 =?us-ascii?Q?7cXzPWOfhnxDV/uo2aPmG3MBHCIwfF2boIdsSXQ7pFNgkk4rQiOqqM8RqzV6?=
 =?us-ascii?Q?fJ/vIKvNBq/YgFI/iruyM6/TI8EsFtZyZI7xFi5oj+niHW7zR91tjWVT+Klf?=
 =?us-ascii?Q?T70gE2A04pCE/vyJGXY15x7VJNYLDVNwXDONJ6i4x4LRM9zC8SRnQ5XJpZaC?=
 =?us-ascii?Q?TFAlBBvhkXrjb/3Ysj0xXv/Ik8wc2/rOR7xIpYu1memm//kdMbPAb4+8GRKI?=
 =?us-ascii?Q?yQWdOwgfQmxVf9Q8iF76F+ez6ZKYHVj4JZsKctpPeokotZ5JSb5zOYDtdadk?=
 =?us-ascii?Q?HYBtfJCKor3zhyeIwAcOVTw7B0drHsAOd33DlV6frjpbJ902ZhCb1G7Qn/41?=
 =?us-ascii?Q?BH90GUm721Lz7/De/hewSyy2yflxIOr08oZ4DCivyos8WIA0eI4X7XvR2DX1?=
 =?us-ascii?Q?qXLTqPzl5YgVDowQ++/OMmpljpqHnmGlgdaQM+M9sNz+lSw82dguzVMV5yNS?=
 =?us-ascii?Q?Mlwsw3Ye2JdqPPKx3a24Zw7i2/0KOAezXQWaikALax8HoZ1MRZmmZc23yGbv?=
 =?us-ascii?Q?lCZZrHpaMcYq3xBt23eN/8wk0fldXfWcqSF3frkkWSMpNa5kSY2tDVc3WEEP?=
 =?us-ascii?Q?Bj5/ksPahIYzV7po74kuWXSa0ZZYfRq/Xv9yIamKTJQevTCHrr1/HDHTpc6X?=
 =?us-ascii?Q?1iLbzF6e9XWang4qZEDs1saYfdePpi4KT2l0ocnReC9A1wqir97uL83C5uG6?=
 =?us-ascii?Q?+dQWifZxcLLn1F9lpvN/YZ6Fw5gWGsowBHlJModFNuy8dEp9yqpbmRVTQvio?=
 =?us-ascii?Q?MDVN0YEiK/2tI+CNp7VnOjv7eyAB4BmFNz/R/whe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238949f4-25da-4d6a-4ec6-08dbdfa78b15
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 15:38:09.0800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97EagpNuJuWOrSjKPARQWMp8Wj1K7IXjTrsEk7F/2Q7rZhlBnaDNuvnyWkFH9iCz6z7mu+XT25Ttsdt6xhutkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8467

Squash to:
[mptcp-next,v6,07/20] mptcp: drop lookup_by_id parameter in lookup_addr

Fix mptcp/add_addr packetdrill warnings in v6 reported by CI:

KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed test(s): packetdrill_add_addr

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 95d99927b144..d2e53836f45e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -72,6 +72,8 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 	if (!use_port && !use_id)
 		return true;
 
+	if (use_port && use_id)
+		return (a->port == b->port) && (a->id == b->id);
 	if (use_port)
 		return a->port == b->port;
 	return a->id == b->id;
-- 
2.35.3

