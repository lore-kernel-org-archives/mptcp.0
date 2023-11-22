Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A324C51035
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="vbrQremn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvt+lrwYloKhBSqj60gDAwDxFoyBqjBwjzAkZjMpT8zU77Ozx2/6cnuWM1chMTYpx4qho6AboNd68qB2NwVV4tFkAcuMuQ1ximJYB0WGnsMHihCUVjunguqZ9KtNBYSOkhEQEUa3hix7lq+Iy+TC6BTWhPsp+of+TmIuV0vLGgPgXSe9PHTmymlHrJBe3RYB1Mp35gIEX1yax0BAIZmAoQJhWG3ip0+6KzHOk6UDZgESa0hLhjcRnkiNw8wxgKzi2pGXS8BJ70uvDW8BQbXUuMnbWaxPkZ8ZjYmxBeaTKeJhaM/hC7BUOp11MFSVeUMATVm/nqW/L0c9KP2kW2Im9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/gQyUaHUhRxW9N3xngLMLuBruOs0x9K+AgcCwzAmQk=;
 b=VvmYVr2GqjB1JxnPOa9MSvTSCJUBJdfj2c6qM46YY+J0fbgpeHckhiHUc0jhV4CfBTop4SoZuyTgs8VI45DYSTgD8BmUnmWAAhgcOd0nLiQK68guG88saPxrA0WJXo2Evvya3nOZZkqDSrZebAPAExin4Z0s2fpHSS07fZuUvpWh2Mf4klJADcRsYzRT/TNvHrTI9VkxkwlETpRdSDBmOyL7xtKmFL6srm7M1cF6/V5GhIQxX0y/SWKjSet0uJ8KThUW/p3m7QQvAEmthVs/ONqUidPtFsQN6ryN7T3/rEGux680rlFWsW839wN2jtqFWyhlSf/nrnQg1WEXjP6DYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/gQyUaHUhRxW9N3xngLMLuBruOs0x9K+AgcCwzAmQk=;
 b=vbrQremny0zfNY1lNQfljCSwwbdyMjiJLRW4p/4l9N/aI9WZwcZixQP22gOKIGEKRPuXuEBRJUEHNboDbYIxxAL9JYFbR3NX0DLtfkHKc3bs9w5HitP6QE8D+XcjF6gZ8feqWu1Kc12iPGYgc3BiTkons0/jH9kIQq2aIrzWtyHKwiOgMvuPVO2rYECCeH755jIqS6RgKeGzhOmamdRtZbcy+4/awtPuGSSSnjNE52bBNswKZfh3++mejkfqNy5rpbIAfNSLxPnPXrK4RFT9tb15eZWuamr4Ghglg4IACqa60i6AhntBnF10eCmgr8u2Mv/YOtmd9l4yBJ7+0/7QMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:33:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:33:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 21/33] selftests: mptcp: simult flows: print out test counter
Date: Wed, 22 Nov 2023 19:31:09 +0800
Message-Id: <3953c26697d21e46df34c8fd1812378b425c0f7e.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd69b91-35d3-405c-dd60-08dbeb4ee145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VQbqCvf/EWcCOPyzfVlh2G2r+8qGEZgcITJhn0V4wnrdcFfGuHdR6flaHelOQHpOcXq7nLapjmoc4EiJ+r0iwsKzDIj5jGJEuN/cdPk144As6t3GtQ/IcggvwK2KaU5SzmcrBKnLXhCTsb/l+Ljc19qzHhc3m8f7prCv6vseK3ffawukKDFgBQpl9hiYIiQ8JZ1tb1BMU/p3pth66lNfWxVts9qms1QlCJ7AonmL3gVgaVogv6g3AzJmXjh2NHgrHtAjGZ3PuSYMHC1sCS+1QcF57ru2Du1Rg2zX1UU6B0SB/v5W09D25lGBKw96I5LY255GReTL7mtEEVBbycWYK2KxPxTLJ1Fxl1KzlP86LCPNmzTshlfgIPg8clz7yZEkaiCuL/UliMrjNl6TFVG2jDK3Q2lDwnkT+C7hze+Q+g7WRYG4h9u03Yht4TPWz/NQFBcPKT5IisAuukcq0dpQkG/piUqJYA4TP86brWmWmRCxS6aYf8eKkvRpSU3URwUVx/qasDl/V+1yqLI8oCjPmB3G2I75O0lVarxZ+d8MTwO5TpqM+xGX9DXg/6ArHWl/08tLN6BgkKd6HtZivS4cUtXxK4e/CwG2I1d4kqmqy4A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(44832011)(2906002)(4326008)(8936002)(41300700001)(8676002)(66946007)(66476007)(316002)(6916009)(66556008)(86362001)(6486002)(107886003)(478600001)(26005)(6512007)(6666004)(36756003)(6506007)(2616005)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zPw+/nOLq21Sb7WmUVYDEcbnq91DCRllZ56sZt1JuDik6EvGjuWbyymT1/pV?=
 =?us-ascii?Q?4BqXo2MbQE23kM/ewtFEcjtuAobuueHHdR3Qz8/KC4YJbWgoX5aNhyXhV3hj?=
 =?us-ascii?Q?KU3KQu8/2/pRG41DYllgo+U6/1+Fy3QYl0J2NtUQOX2kmzvRLuR/Ks8khY+f?=
 =?us-ascii?Q?TvzEMVrIoCTtLh6TUgOoLYRa+qXROo9uStA9Cca/pAn44CQQaXbXI3IDttj1?=
 =?us-ascii?Q?KcfEyz9TBaLKmTYFCIoXRKNUmw93kkqs1zEC4H7oixm85K8UFNPCghIXmust?=
 =?us-ascii?Q?sWdWKtnaQSXMFgFYEQLOO5DBUdMtsU9V10EMFHIRc5uErXGlMJMEkYd86rv5?=
 =?us-ascii?Q?Flm4tl+uXWmeq2hyPNQAivi5Q9OT5VQdQKd6EckpvaJ1+vdXsUbk8847wb5f?=
 =?us-ascii?Q?y2jlvx4IsUnp2yajpGZvCWLmflw3CvGzDtUjoUoNyOwmrSAH7RCl1gUS4+cc?=
 =?us-ascii?Q?yGZJJl73HcZ0mhmTP671fSYhZiJ8HWnx1C+jGNJleVMpBfzGdmtaLWnBEW0B?=
 =?us-ascii?Q?Zy18+yv1BiAYsnGMY9KbhOxx0iZ4XpmVQnmRIL4dqPeqSwWUV2W7xyjYRG/X?=
 =?us-ascii?Q?Ot2OP7SJcS5wcF3m0Ss72swawJB529Vf57EyjoHTidQC6dPmpOgfTChheMlu?=
 =?us-ascii?Q?3h+cahsRBh/FkcE+mx6LMYHovZZgyhMFaTZdLJZiivMqAFlwoMpx5kxiy/h9?=
 =?us-ascii?Q?RR9uzMGtla68EezDBor4xszVKNhlir/IcV9bKZ2GbsD9S6JLbFZcKPL6Y/JJ?=
 =?us-ascii?Q?lufdBWBJ6LGn4oGmprcSM0yND5AU8vlzVO9XgW67NJJIEHpeYdOyYmaVLqtg?=
 =?us-ascii?Q?QE7/K6ccjY0hGiADuOXJUMG0mgBgT035qjlWEzebQ6kqIMRCOv1zU1JaZwYd?=
 =?us-ascii?Q?LKIX5EJtjqKx0xPZnyMsAzLJIzz5HoJdP6n9kWxpmuem44AyFjz7tGgeo7eN?=
 =?us-ascii?Q?6N4Qcv3gLg3sP7bWwCf5UkiUjZlTQmqwYARxrcI8xl2c610A4dyaSEsBexXg?=
 =?us-ascii?Q?wTJcAsAymHCobWUumTBj0DjFuPg8zCytJQ36+Gpu3zTVq9u0yky4Lr8jEwWf?=
 =?us-ascii?Q?7vpDY6w4ww4QHeAQWZGuxgV7dQCa4MPEI0sULLQS/5xhKUtEusU272qjHevy?=
 =?us-ascii?Q?G3AoFbgJHxOR2O+pf0LPXUZit+UNf4XT+tv7lsckr+Xo1dOjtAulfpYkdST3?=
 =?us-ascii?Q?1Qj6WpPPbec5YqB50romVRg4X4xt9XijiKfcWvfVMRMy+KElpcBN7tMCU1dO?=
 =?us-ascii?Q?tTYQnnUWsOZ2F+htXbrA//YdnpLcyc+9qWzpnKHQ9/FmTDb1Ba32MK7P38il?=
 =?us-ascii?Q?QgHLi+7ziSwvrD8YxBiExBAYArpHoX7ZMHKMocPaO93H769X8epXuhik5+xS?=
 =?us-ascii?Q?elnY30/Cl/ZtT2knCXl0HVBJnXzLRdyPIqgioot4jdXMxbOWndJRWdnbDkF7?=
 =?us-ascii?Q?SxksrQB/m+bplwQfs/GhvPK1BS/71VXssxrHBm2wVkh5Gg26kkeLGkBDG21C?=
 =?us-ascii?Q?YiQ94Ip8CfClRm565KTbsSaFnkcmVJuBpwUMypQk1KHSYPk5+LbNcbquxEhS?=
 =?us-ascii?Q?en/LVVS1iz8tos6WICemCrwcHbSmksYbeVmjuvBmQnmvv7fsjgcj3Ku3yDfL?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd69b91-35d3-405c-dd60-08dbeb4ee145
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:33:44.1786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/b3VEzzDelumiG1PQOxH0bB2XFOdZ/TCg0Xxwe84DA0dSf1PIg/MyUSo8Bh4tiJNPZS+RhJp48XcLlNm3Z2ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

This patch prints out TEST_COUNT for every tests in script simult_flows.sh.

The output looks like:

 01 balanced bwidth                          7411 max 8456       [ OK ]
 02 balanced bwidth - reverse direction      7380 max 8456       [ OK ]
 03 balanced bwidth with unbalanced delay    7434 max 8456       [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 6a4568d8f596..a9e14698c179 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -8,7 +8,7 @@ capture=false
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-TEST_COUNT=1
+TEST_COUNT=0
 bail=0
 slack=50
 
@@ -227,7 +227,7 @@ run_test()
 	# completion (see mptcp_connect): 200ms on each side, add some slack
 	time=$((time + 400 + slack))
 
-	printf "%-60s" "$msg"
+	printf "%02u %-60s" "$((TEST_COUNT+1))" "$msg"
 	do_transfer $small $large $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
@@ -236,7 +236,7 @@ run_test()
 		[ $bail -eq 0 ] || exit $ret
 	fi
 
-	printf "%-60s" "$msg - reverse direction"
+	printf "%02u %-60s" "$((TEST_COUNT+1))" "$msg - reverse direction"
 	do_transfer $large $small $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
-- 
2.35.3

