Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2086.outbound.protection.outlook.com [40.107.105.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9219C16412
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="1K87Mn6H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDWtMW15Dyts75H8wS9EZtJWcv6PcZwM8bAe5sYQZbXzkFGydWiNimqCJundmUMdTgwgfSSllB0oL5GVHmI8TRZpm4CWSulT/HtngFBpz/Z6UPjO/Q4uzN2sMWEGiGWYR/WR72vNmX3Op9C7hOL3394ISiK5fnFCm0dGx3NLaNfqA4GDl7v+cP8kF8nGpFuPeY3KvNIDm3mRwlRmgPs88Ygk9vzOogZsHtSu/WihooFcZ2StxqL6/M1vDHya6Sj5GF6To8SkruP/UM7qrh7UVXhdcBZfeRiXFrDod+wnVdlIidJWScbzjvplq2ufm02OhWB0vjePU65FRONN/mVBgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsRv6aGr6mmmOPvTXHhXyzuRdf8FIBdg1IzuxNO8OK0=;
 b=KhbtGRIzWsal/TCgqdtg7mgj2KDMqt2sLEH7bcggpJD1AspHacQxOXgBu7bXhwfSxtzYudoki0FUv6J50TljBvL2btqyewUAKIClTEiNHA3OiyyFdarCB8Vi40IhNnU/eLTillmb57mc0IOAPSkeNxNQkV6c8OXGu94cACecWggLbYj+nVQFbuzAjlcny1ibzJq4uka82GZ7zik/Ze3E4EqeZNOz2Zo+PimGDrM7v0Hsp+2Q5Zkj3DzVdUJRyJrQUSpyrPqAV3vUUPF0km/O6VNylqL91QsyGwTstduqnK4KP420Wb6Y8aozcyjM/Yxg2D2Pu0+89sQnlYoNkW0XvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsRv6aGr6mmmOPvTXHhXyzuRdf8FIBdg1IzuxNO8OK0=;
 b=1K87Mn6H3tidkV98GYrS1MGoKusHCHOCdAN+rmkJGP1zqWXNg7rtV2wv3kIhzpjr2wAmJfdjxQ/eolGRbd5ddYCLUgeUco8b5pGDPs6Go3PRnY5yiLtWnGdvMV2myyUYF/AR+irWw6eDSZZW20v1aGbSNnBckYYIOar7flgfFQtJGOvmDXyWqzR1ExmVLjnnpUokBTXHQ7T3UJ3pvEcDXVO+nUn5NiCwUraJV3yQ8jVLq4eG0d4HWgFREuwKIFSDmeKP/r0Q+tseM11AS9HlKQESOof624z7HFEdqC2GztDbU3i2gmyS9J6cbP9VrrPUvWvJVSmUrV5h2L3w3m3Cxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:22:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:22:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 05/33] selftests: mptcp: netlink: drop duplicate var ret
Date: Tue, 14 Nov 2023 18:21:35 +0800
Message-Id: <25c1cc424dd4101365bb8cc666b8c6962c819be9.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0190.apcprd06.prod.outlook.com (2603:1096:4:1::22)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3a0351-b141-46a7-c9d1-08dbe4fb97cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0iG8mgkKGDcaASsMCUaAda8fzXsrXrxYeCcKtqVcQunk8SZSCFO1+XaIX0ktnMm0r6wbAo+PJHncI4NjS8bCdIwhBiUyEq6OWS8U9Xarv4f2/OHMbJDGQa2k7pmJL2/YJdBPlHmcdiiypZNS4bqrolz+2vp/0G8SR2SIVkW4N5ISe+dUGRUKtaZpmuDX+VVLYZcraekE71HOveYM9fimRYive1PwG4v4hgsU7MIVGRRlc2iLWdEQAtkHucqrCz9Lo4lZNbOVRvH7SlOGSlwzFIw9eW+ycCuGgbASB6uOzuhVxrHUCOOTC3KF5YuNKFZBtzLYZye3twG+szI10XVigdraeOCSpqn7DpS1ivmCedt5EyC3x0Vdbwo5f1C9WhEpexSkOCWTsO0CAYg/xbYNkPsQMItdohs+fOr3abzRZrR7iSM2ndxKhdJV0q/aIZ6NuwTKRQeiZhRz7GbV0w5H1U+ou2C3DXLCEXdPMQj52bLV6i9uFo9NKcIgTtSVz50fCHYq51Si4p65mnKsXL3Ix0YCcfSCud5mAVNoyBxhcGfV4OmuGlsJG+rdhNjGWg2K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(4744005)(2906002)(44832011)(5660300002)(38100700002)(86362001)(41300700001)(2616005)(107886003)(6506007)(6666004)(6512007)(6486002)(478600001)(26005)(8676002)(8936002)(4326008)(83380400001)(66556008)(66476007)(6916009)(316002)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IYKGkiX+4JnQjiDotVONklSImJvIUCfWkjTfsiCf/k2ii+tZ+mpLmL+Pyyvc?=
 =?us-ascii?Q?YjKFbm3JFTH9lsKFbo9er673uEFWDpDZZOBNc4trDcL2q4HcMGI1K5r7vkQC?=
 =?us-ascii?Q?JkQmYlgXBaot6v0rx1DWMQl9ZEN6xpNldBSoL2ro649dg9xhZeK4nqdVVJ+H?=
 =?us-ascii?Q?mq6CMRCiuF4gcBUa+eCs//RNO7I1k+K+8U3lBB4ggyJZqrT4Nd1by96xSM5f?=
 =?us-ascii?Q?yYl4lPEGAvZIUXUwJz6IsibOGCECfmNJY1MwHuepp9EIjzSYYPThxeQUXITk?=
 =?us-ascii?Q?9O3UPnyfvxgIPxRQe2bm+bWwbBMtZkgjBfwDCoSneZsG/YOq+hyC4wnk6M8G?=
 =?us-ascii?Q?+Og49dbYoAWs9eaCYc79WTxhZlG5mKxhQDFKA/tMuO7pcMmSNcs3RYVhCpf+?=
 =?us-ascii?Q?YBE8bqLz8GZUiyx8DfI5UTwAcCr1CiIzToKbxJU3LRCToHsVbAQFxWOUBN2K?=
 =?us-ascii?Q?rKko2yYwCQ1Sv1APIe4wFVWMVHqX9HcQ+96DXAleIe9KCiB5tALc9EsyVceE?=
 =?us-ascii?Q?HY6ebvB1r2MRMx9J/ZVl38P24lvtZ+6HGiK9UB3Sds8Y71aADem0q1JdUCFe?=
 =?us-ascii?Q?xHje8UuWzkJaATl8ZwxA4zpYEh0vB/2WruZH5TLLcRMC9PN8v9W0X2p7tOCB?=
 =?us-ascii?Q?1+bBPfcPs6BZPUZwo4lH77vV3oJhVPAskNXJ9amUi4+WEwPAqmBqDn+MEUcy?=
 =?us-ascii?Q?bjdrUwYCgVtS03a66HDF2FuM/0WX9YLqau/m8OE8kMzuS2Gcp7kfsv0cxi81?=
 =?us-ascii?Q?YEHDiUSdTLjV4OAas3jDhl+tQ1WeBBXKosJp/ZkI447Ig50qsb/T7Btpmtb1?=
 =?us-ascii?Q?vgdTGVpHyqP0jQjT3MSUNespplrST1RkI9oQRJmmP1MDktP3tskBpmfInyTc?=
 =?us-ascii?Q?VR/w1Df6LJwF38wRiDUWl7Lvjh6DblsHDIr/qZELF/dVuWczaXMLRDx8rEav?=
 =?us-ascii?Q?ixchROn1kUansY4lXgokN0vQQAL51pYvGorTMGnWXu1EFfvuQjpd+zSLfWiM?=
 =?us-ascii?Q?CDP3hEWg3c/c40jK1/HjeD+2GNB1qjeZWnMI28JCpbvLIlkOq1cH04/djiru?=
 =?us-ascii?Q?MAv1o+eqHxvXxfiNltvM0/QKuGpWPkvIy6iM2kGLtv1sQuyqyYK4xW4geO77?=
 =?us-ascii?Q?M9mzdjEOEZuCI25EdPZ6I8lVyl6a8On8eOKJ0202CNKwpqIF/+E3T6odFGDr?=
 =?us-ascii?Q?fhtp15bsa8nnJ3+4Y7xavv+kl5sy+AABCY6gfXWBRRJI4nSG9aj+oWD2biuy?=
 =?us-ascii?Q?EF7THRW7dYptPk08L9NZjsVxXAs5nWv1s7RnMRfTLSUfTLcprQEaup32Birp?=
 =?us-ascii?Q?kt2WFoXRFMke9HElca4C8evp7H3MxV4nsGMXWhayI9O9SLxZSPE7HPjSh14u?=
 =?us-ascii?Q?Vd6hGA760gf6hBcyBShAq55n+8hvwjcRhMVI+nav8Dka2SYeq55JVX4BViAY?=
 =?us-ascii?Q?veL2aYGGvhicnS7SGikJkuy+WJ6ID8/ULCTUzxva5VAzEEzqsWtcfC0KuP/f?=
 =?us-ascii?Q?jC6QlqxnK+wwvnT6+LwruvdQ8QmQ81fsoUXiY0eUNbmeUnlDUeTt6H33KQCp?=
 =?us-ascii?Q?/vSI2DROwIoE9pyhj2qeWNeJj3AojvxCXos+ZC/0?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3a0351-b141-46a7-c9d1-08dbe4fb97cc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:22:23.9290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: il9ic64Ku0RWiep2hDLC9Fap8w8CS5MNqPHWUz5mHxjU9AR1Ynxx2gh80ui4r5keZkXL/ymlSxPMtqsS73dVkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

The variable 'ret' are defined twice in pm_netlink.sh. This patch drops
this duplicate one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 8d30d4a1db57..e995dfca52cc 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -27,7 +27,6 @@ done
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
-ret=0
 
 cleanup()
 {
-- 
2.35.3

