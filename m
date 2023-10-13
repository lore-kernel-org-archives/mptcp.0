Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27E55693
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 05:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RyPYX1ae"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoRDb+l0b91isBo6oCfIurgSRURoA7mGQP3F/ngpT0vWcqhphzs7cmOCtPjZa/UYtenLsvKN1wwzbTbAyS6okwbcoXYo6aTYEWS9sw9lAJq2SucvKgPKXsQRcXOOcBIbXQvzI27o5PKGohfQyuJfuWp7lpEytqGfqOW3/GBB9PUFs6FgDqQkfBrvZs21PBTpEiRlKsMTuJm/Ji9hP8B2Lw3ERTQzbFuk3GG5oWbAXK2N0kugF7h/nHiJig+PhQqt9ZU4US6XwYmS+L1z6FHD4RKPHOP5KebOA+seMgzLAj5NdnsBLXeqgssqnIe2Pop67q9fwfBf6LrJ3dl9Gvu/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=my2GyeZHLrGsDt3kYU/DWY09ZQGDGYyPOTO1PPrqtEo=;
 b=m92DBsHdw0/gZ6BLkGu2Wa6JZrnH8h5NJtG1msJKHpAg8vXijoVmCv1cN64yBMB7nKpndDPsupUkRS5XraSJhUJTXJ0R1PS+pN6fCEg7Rzx66SrtJtQMavxapCO85BqUHzhYwhSCvX6ySxOpMaPzhugcYwh/5ryjhNGep16YfaTdYTwGdhwrPQDMoP4WrUG+fUXs3fErVfsAVC6z/X5FHzTOzqpIJvsGokjXylTzVd+/c+12aIRzR2ldbWlgRBliBkeEtxJdkjNrN9dQVkHOYvGdjRbHo5XA/EkX/Fn4yKUYy2Leeg+Oizd6pGoKInAnuhRA9hpZCdujsnEEQsNu+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=my2GyeZHLrGsDt3kYU/DWY09ZQGDGYyPOTO1PPrqtEo=;
 b=RyPYX1aewMHUQ5woPVk4dhkU2U9ydu7h9eswHO8x1qWGj2znTj/5f/wsqlblN/aVJ8sppDu4ru1JTBWs1dBdz3/8Q65HsfsYrCwuHeQMGT7uxHEVjR05BYSRK4hQwQndYdSnljY4UNAYVJ+Ruc3iSHoqvIPM05barXS9Hu1BUAZkd6Eq84n+bGXeTEo7A/sArnLFo8eDyNwQQ8BVnM890viKoBf0IbfpR07cdPZZA54fJazHJFezuuq4lCQxznbtQmG8olc1gkrFSDOLDbFagNhaj4CXb1XH412aVEyNLmCiM+aYAhOiNJxkVBfSsJM6Kl+wAFQpdmFK/qJPGz++Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7288.eurprd04.prod.outlook.com (2603:10a6:10:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 05:46:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 05:46:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 4/8] Squash to "selftests: mptcp: add chk_subflows_total helper"
Date: Fri, 13 Oct 2023 13:46:39 +0800
Message-Id: <91a45ec5f8ad170550ed79fd26295a21d0306033.1697175899.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697175899.git.geliang.tang@suse.com>
References: <cover.1697175899.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: ed17fbc5-e230-42c5-b77d-08dbcbafb17e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pAltEbhL9uDt9Niv6cysvwUV52ZR3qrkrsnFlcldX1L8AiTMx2odoFhlUPvKRdN2Kfz1rf4EJ6hF77431GvxUlL1GkYBGwvFLzGPBPxfGclG/HP/Og5i3tz1c2FcvBuWjCHBQ5/lwHhe1O12kKfdpoPYSWVcE/1gVkp1j9w5/bi332SRTvaugpU2NbvMpuv+t/iVwFJt7Kq6TSoiGxLPsCAxm1FlunCtd8HvmbOQRtfAZGp1+k7WT318PJ1vPezvAdN+3t2mGKwH1cF2QGcuv9jnlk0WmF6yYSKgQaN9QSBYHzDdrXJplJ3j2xoDrOft6TbRKaCya/4cBkYhHZ00Z+2BRGKkOZJhcgqbNOn8bvL22CPw3G0aGHojvjb/xE54mlKnszdSfYocIogBceLEmWQnuqrFwAMb8PBnOM1cNuAokz9WR59S9x9aNUbPGtPJ4zAJnv2PmDX26Km63b1EMb8Ocy4kOO7FBn6rs1/VwPtGR+Px9tdFwt9Qgsnd0vLAJ1I+gMUtPPfirSdY4KeXY1G8mPJnd1Vwc8TQJAVrkIYsscEqcj0VTjzz/lAUnCPn/c39KoTu0P1hA8I8ipQC6RDXDpclaurJJLTiLbni8gE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6666004)(2906002)(6486002)(478600001)(41300700001)(4326008)(8936002)(8676002)(5660300002)(44832011)(66476007)(66946007)(6916009)(316002)(36756003)(66556008)(83380400001)(26005)(6506007)(2616005)(6512007)(38100700002)(107886003)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tVWxTEoH9cCgA0ZYxnfw68S5eVLTgfi2ImLxlWAo3YA4q7CLXTjPsaV9xXh9?=
 =?us-ascii?Q?EsIOvz+h5zcgpVP92YYCIo2Cr/ozqNIpoJtx70TnTxQHUD9SDHxlRFUnWj7m?=
 =?us-ascii?Q?dVWj5JPxVUC7xkzw54N0H6FKJSf2kQhb0U58jfBUJWbbL/+NdcRWotCwkJwG?=
 =?us-ascii?Q?enBBzlYusgTHw1qrm9u/txLDlsrir6ceTiYjBTh35YdzCYCPeb0T4qy7XhAK?=
 =?us-ascii?Q?zerpvQTmaJA5ECYRjEG7ya9LmUI7HYVo9jErWGKVZMnenRMBYdv0+yYL/K7W?=
 =?us-ascii?Q?3F4ex8ISXyOq7jPnkT0tIJ2zgqMyHwozF9kdbdqPhadRnJcaHVqgR8HBXxNZ?=
 =?us-ascii?Q?omFzL15vVFmNwAL5jkYA8Nt6ccZeWEx6h6ttCx12GdM3DVej6S0A8y9zrjt5?=
 =?us-ascii?Q?lI7OFdSTHTn5CZGfPKhAjaOpim6OY0L/2nzyomiRBc/eZ+rwFNAVt1Y/KUND?=
 =?us-ascii?Q?QRINc/yLt9KBVdjDEYLfeBxS/8V26uaYiov8g89JsXH6F835fIoTzZokW25o?=
 =?us-ascii?Q?3CcMUIc401rh3tyvYSOVEestuOguEsfGXOxFWj0FrDoDjk/c8laIWnbXOHOe?=
 =?us-ascii?Q?IL4ptEBPK76YczCeebbpUSdfnkeP7/kdXVtaQjrJdNX7NJQiUqdNmdVdLPwG?=
 =?us-ascii?Q?wevgxSttrwiQOE5MoEIsjII1gWeJ7eZpk8Aa+VFCWT5/UsNhCTbRwrJHVIyH?=
 =?us-ascii?Q?Ogb4PKTn4V5QD6XXfmMtn21+HB2JRXobnROt2kDRSHAvNtm8V9TaGNs+YgrV?=
 =?us-ascii?Q?/SrRsslO/oEg6N7P9oX6tVjxeoWhTCW5EPyRvHSBMYVynpVoo2mKl6kor0qM?=
 =?us-ascii?Q?J2kLFtzdGHQAU8/CAaT6qJU+BUYMEuD7OQEp53SYQluzv4UZgbuAChT5eKZX?=
 =?us-ascii?Q?fly6wA/faSeZA2h3gq0/vmKL/L0yVxBpnWiCqOSq2gyB46NqMAw4GqZ9g8Gf?=
 =?us-ascii?Q?SES3lInwamGx3YWBH4pz5UG/w9rwQK1kWqyLmixriBp9jLwUiFvgMVn3vYah?=
 =?us-ascii?Q?QeEWHpCjZ6UIgC6uR7/IThERjpe9Fzw0viZzkypQsYj8uMBYnHM1MnNYCluC?=
 =?us-ascii?Q?7AQG2fqvJZP/Lz8H+P4jsm1w1Yw9rs+DBJydKEJAt3P5E/Hxfq5ITEGJ0MBE?=
 =?us-ascii?Q?OmDLUEcqkXcsCyY/FQF1wvqBrdNz23MARCCr3WeDK5Iz46S8QGFHNTn3muAh?=
 =?us-ascii?Q?/lgXNxNpOVP6YbKCryNFHKcqg/upLIXSCKvzfCQec/95JwMn2ayZhb1a7U6E?=
 =?us-ascii?Q?YIX2dPpKVHJR1t3bi1/YWFwldQlKQex0NPx0qN4B0B0xIf/mV+B8e/jZj1OB?=
 =?us-ascii?Q?NGViVcUyi1fao+wkVhSkt2TG5MJRmteW76WWzztGDTtq9g2vXQtXGoSgK9Nf?=
 =?us-ascii?Q?3L3Ki3OLEwUX1eZsCea23HWBQkC/aJQovvSc5xCL5xNjU/A1Ryw7TSMfSOqW?=
 =?us-ascii?Q?Wnu3axdKO8JWmUZ4snicmlTF+x+jECako0/MlcOK06UXli7uZuBLwBPu5d5R?=
 =?us-ascii?Q?Pehs4TC3pvVrCLIE2AwW6Tn+XRx7EOLkYpbRJheG0HiAWoDHlRkmkE7awkbS?=
 =?us-ascii?Q?07WUU0ijjxHU7vZ8ECIh+7Yp6+x104zby55SyvN0BDHz0emtAhLfK3Iw4RcG?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed17fbc5-e230-42c5-b77d-08dbcbafb17e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 05:46:06.1775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pL2NyDuWC3m+1WDA6FdQ9SVc8oC04TrMwFhWRXGuC/T8/GAIHTKpuYUN9tV60X/Y9726JcTKLyTcYyiJ0Uc/gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7288

Please update the commit log too:

'''
            ss -ti | grep -c tcp-ulp-mptcp.
'''

->

'''
            ss -ti state established | grep -c tcp-ulp-mptcp.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 07b2c4bfa183..74f40cdf97c3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1905,8 +1905,8 @@ chk_subflows_total()
 	print_check "$info $1:$2"
 
 	# if not, count the TCP connections that are in fact MPTCP subflows
-	cnt1=$(ss -N $ns1 -ti | grep -c tcp-ulp-mptcp)
-	cnt2=$(ss -N $ns2 -ti | grep -c tcp-ulp-mptcp)
+	cnt1=$(ss -N $ns1 -ti state established | grep -c tcp-ulp-mptcp)
+	cnt2=$(ss -N $ns2 -ti state established | grep -c tcp-ulp-mptcp)
 
 	if [ "$1" != "$cnt1" ] || [ "$2" != "$cnt2" ]; then
 		fail_test "got subflows $cnt1:$cnt2 expected $1:$2"
-- 
2.35.3

