Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2041.outbound.protection.outlook.com [40.107.7.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92570110C
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 05:10:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BapIQL0apgta5r6uubg+aayfDJ9DJQPi/Esne22qFPbF6/Lb/n/pa5t6BOmi+YI1qzj16b63bCfvO1jmR/20hidKHRC8hnRbnoyyZHx5n/VsteyTC7lxnEI16Q2ENohflpfi/+C9Z7uJnKHz7eqVLVmeq6zzMLRy0fVh1HK3zWILLA0A8d1lKEUGrYGY9nQ0+wcz/0pD2J91ZT7ILo+iw4J1m8twpEikPKfc5j5zVsW4UqOCH09xr9H1byBy2oHx6qNZREkSvK/Te9oRjf6++zroDrpJQH8b/sjWYFg4X63LGmX5CVrS+EDqeb5LRMfLLEXO0lfim/Um/R0/AP0Yqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4k7UonGagjOgzKMM9Mz2AG6Ovhswbxa4bxtDUFAO2Q8=;
 b=dFldS1G8c9C0FxSSSN+75Q9YJpJPqh5lKMi8allJnb8N6peDF3efkGpOxv+gQciTx42yWBf4g2mRleMIgWwggRGGOTKseTvBhA7KaroMfCUtdpMh2MDWLJc3Ga3xFEyy8PMhsxW/aw1I7Gd3ZUlLzu+M62hFuxaphYXd91XKE2+Muyio8qP3nevYG1HnUGdfikbHW99KH4YthNZ3HNbl+udvRNY7zTsuRSe8KybiGyyTL3svfzUzmcOkJPxDQwMu1qdD0sUA63wa3RjeKoJDA+GGlz2Z8TawpjVctVYySy5/6Wo4+uf6DUyLLMgolM/zo+ZvlnrJC2Q09NvI+Hs6ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4k7UonGagjOgzKMM9Mz2AG6Ovhswbxa4bxtDUFAO2Q8=;
 b=jFIe/XWU9frChHG4/TyPIXX3xLi82QbrVj6GNQt0B1299guzl7hep7Pbr1dNmwZ0TgKsZnlmQ8kTTGp1PyTMkTijj9bb7WZOBehISwF7t3aLbXHrs5SPZI3Sc318fZndR63FoqX6PmgWJ0piIv/oeGIq91rgyNKjEH1TgrcC6Yj26MfMH9S22dh+NpV3/TLIz2QgRFsnnpHfA2Dcx9fYBRbyrkWwpQVHMBhmcUGQWCYvrRuWSeK27fQUE86ueExFiSDR6j4F0M/LpHNygPDd1YSLgxlrJHoT5WzWiOTIVwGXvXQ+euwZSn3kqvnDBtbpDd9dgpOBMy24MgTtoEbxvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AS5PR04MB9826.eurprd04.prod.outlook.com (2603:10a6:20b:673::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 05:10:16 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797%5]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 05:10:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/3] add bpf_stale scheduler
Date: Wed,  2 Aug 2023 13:10:17 +0800
Message-Id: <cover.1690952908.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0238.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::11) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AS5PR04MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: 866e57b3-1498-4440-1db8-08db9316c14b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OHapH3b4IEWG1KUjPzk8k4tIGs/d65OzIgi7Oe4b93YifwJe+aCt9lbvVzvouZ4refeXwvGDP5bFwbp0hC6arP/id8jTSngfIAnZ7iAoh9nJWaNS2i12hNDIVmbiTI+cq71k7zN7i6XC5dxDgTl0vTAJij2hUNKjQ3PhWyrLpi1UhGx0Zsc5YYE80YcL67DTOC5WIoYGMbi8oXv2QsxqvcplU5WWxcH7WOrj+/OIepU8oeIQViPBlIcKu95NGC4ycCCHRNsDgvSN3TuTwMTJP3FFIFD3qlehhM+3EOlP4SeIlPTdlMaRTA/PzfyHbL4axpJm/oFOQdeQAM+w0rBT+0tX948gkcgJTnPtjxdFRCYoF3C4qIagSza5AyGdTUyRd8VdRygQELXFURfrqDwaHROJ+LPfFjHO97QGQHrGH2vwTnSn1GGjwPvd4SnXU8WYz+1Yd2juoE+nX0E2Le4mBi88W6S71epUhbDpUNpR8CsczBUCQsGy2aQh03V4qOtY9aGSJW6dMoJxnLbamXhEDweLyL2wRa+X4CfqxQJt9oC+NZdNB/lxEIZjG7HXyKo1eFNgCW8agpQ2l49QE242qwFRDZrCwflLRqIJJVvk4T8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(44832011)(66556008)(66476007)(6916009)(4326008)(66946007)(2906002)(38100700002)(2616005)(186003)(6506007)(26005)(83380400001)(86362001)(107886003)(36756003)(478600001)(6512007)(6486002)(4744005)(41300700001)(8936002)(8676002)(5660300002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SAhwYcDW7Eo9OYvBvQf/mOahru4Gf9SiwLaCrkNy++g5xTy9z82SXU0V5oxY?=
 =?us-ascii?Q?U9nJbE943YLR6vJOMl+riJLlzXoZiGcTOqvpAMoRTwrF0XMQPCOXbXC8QUKT?=
 =?us-ascii?Q?qgumrJQF0HQEfoOMiaZbqbjnzPSWMsnyLfjq0P7XUZPXUdzcP8fpOJGDiMsO?=
 =?us-ascii?Q?ylSB2mYm9wAUbt5rTFOb0fK23rCAvObzIsoJQGW/Xi4s0Ifmgg25mdFUzO2R?=
 =?us-ascii?Q?dgKybmxWZRMBmrphn23+bSGhnJlzXV6WRjweVuBg+dpKWwV0sGSfgZGyhfmF?=
 =?us-ascii?Q?Gjacg8kaZ5lx2XYbiA9jfIUVTz12gEw6iKkSlCQA8wXTdrBXyUYPt1meAmtV?=
 =?us-ascii?Q?1okSwD80NZ/4++C9UiWIc8EJdMudHm9gxdo6AipE1+7aZIdQ5OASgq689uHw?=
 =?us-ascii?Q?5C+ji9dPtR9tMCbFB27FmfdbiVfHRKGEtFn8NlGYAKgyGZEiND66ql5q2y09?=
 =?us-ascii?Q?u1NeoKO/89XdXUZ7lxZpIkoUNcISlWNws0CZKEfMk91drxfBKPpUEh/pnZFx?=
 =?us-ascii?Q?g3/5k8DbN0cbZdm3yT0BnEwkmevAB7+vvN4TAPK3ykdCzf+Bq2H5xu2q8srt?=
 =?us-ascii?Q?HqiWJIqZgI8B5pRBNFX/q4i8sdrsNrqqh+WF0cfu2SnnMNuaEw+m4yKc9glK?=
 =?us-ascii?Q?+x4buwuM20cPcsYoLEjPPCQB30Db9e2wL41plTWqAVVLSR3CsLew4MIH/8C6?=
 =?us-ascii?Q?ttE/X/fvI6TGy09neY92fEfGMyqCLu/idyHFNWroTIW9kuIhvc0l79dO3hC+?=
 =?us-ascii?Q?NEDlPvVRip67H6PaJy49DrhPLEtHktAwd/stBq5N6NV6Mb1NMEJou3pA5n1k?=
 =?us-ascii?Q?mSWhgTHnaOaPrwNvL1Kp6jyD4dxbPobgCmEN2IYvFAvhmptWdLp6vpzzPFJ9?=
 =?us-ascii?Q?Er4BSYgHl+ok91Z71MsSVfqNZzPn7ZaT8/A0wqE+EOT6H7Ztnhu1QXsGU9uE?=
 =?us-ascii?Q?4n0i8BphbxK3h08Uphpiu1Q9v//R6+cpKrVbKVQMutq3C4Dy+bnmu6PHFp5b?=
 =?us-ascii?Q?40McwsX1xYfGsOEiGbZSVdA05f0Pm1gCxmcHZ0YYqhpHUUsINxe8sYONI2Km?=
 =?us-ascii?Q?PuZO44Vppv8+OvAuTs+jsFMy1OnYPAmh1Fprs1qRg4FYCXXilR6rmTa7S4wj?=
 =?us-ascii?Q?3PKRoIUS3k/tEKxfK4OBLhNuVqlwt3yJAJj1klgd3qBDSNBBnrj71cgJpzEy?=
 =?us-ascii?Q?Tx/D/gmRWafpjQdIZXPDzalC7b3iC7xlxc3AEKvQbta3SStt0wz3aOG5quia?=
 =?us-ascii?Q?7NX/J0Gf5ozkojI48iPO9XZCfHh/Mv5B+QHqwY+MT/56X4i8ujBkWsfiT9jT?=
 =?us-ascii?Q?zS+5OLravZsFKb7zBEUm8bfk2ZZJtY9PUMH/phUKHhuUeQOvMoc9hukDNTEx?=
 =?us-ascii?Q?6h8wJekCiWgVsH3VQsTKy/Os54D+H1itFLeWhu/EVAkcQiipp7A8nc8VTuh0?=
 =?us-ascii?Q?QA4QkKRZ+vdwr9wfGC3/2KFTPLxIX+eX5f4O01mc0oqDXmbCGFWBRZf2NUWg?=
 =?us-ascii?Q?yT1htQrIXtUag+zeCHavk9YGBy/WlnTTHyoabceLi6jlBkG89KV+qjsmDm3f?=
 =?us-ascii?Q?bVytHhi8Ad0+nr0dA89dooZi827I0v4STd1DWtVc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866e57b3-1498-4440-1db8-08db9316c14b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 05:10:15.5009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3nf9sQi+rlHgq1k/cHy01n5qtYnciNCW3zhdSFrHuC5WGIEdkD6DmJhI0FfCukOh7PpHdISbVWcZlVnhaAGDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9826

This patchset adds the new bpf_stale scheduler. Use sk_storage to save
the stale map instead of using subflow->stale flag to manage it.

Geliang Tang (3):
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  selftests/bpf: Add bpf_stale scheduler
  selftests/bpf: Add bpf_stale test

 net/mptcp/bpf.c                               |   3 -
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  38 +++++
 .../selftests/bpf/progs/mptcp_bpf_stale.c     | 155 ++++++++++++++++++
 3 files changed, 193 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

-- 
2.35.3

