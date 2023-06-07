Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2046.outbound.protection.outlook.com [40.107.6.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9707488
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 11:46:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFJ+VnU0oVcBLQQfx13gLY4xo2m9Dwh4ABqstPlzUiS0jCJzeroUisxbM713MWEwzNS0qlZNhPDJIopoD7672aGc4a7C7dx08SKbh2fdXK7pSawIS/gycXMFBv9i4dGcyXokYjaAhxOWCPhiwwlwXsyVxkiqN2aoksOSRiR8qw5U8DY3wRVJhcHm2H3S2jBSJw/tl2XUCp7xHjMrc/CglQ4sChOHRUBqTIZPFUOUxPsqFI+igqKrnh8iRNHft0+2B5/x6MV2C9J5pmq1Ap5Vxv9FAIG+47kIh8b1F1SC1XIlpa4CkqdSDQtYPscrsQaUXsecvc3nYTbyn7ueQjoiVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhhOAcoRWlOofnr627Z9WiHABgSCt/EoCPweAn/MeO0=;
 b=Wz/Mq4kasBfIGmKcr8iuJGvygxEFT7IYNnsT005Ts5aP10K6BbncT0Q8xPtWV+Lq9SjzvKeCwF/N4+wRX+33kC0I8N7/CFYEy0WhuAAk+sWd0hxsj2BQkqOrBNuour2ICbUlTlELZtSqFrB8CcqJReByRvnZv4r0L/jNXEWYv5soctPa/f0Xgl0RWFfaJ17tzlTUja/MIXLQl1GUuoGoUqIZpQc3QHVZ+ikFJNTXq7NCjIVhe/uu6NiOc3ZKeSB+xFSYzodSVxCEllyItO2LhkXT3itIRgyend6p3QGhmJ3a+D/WcU3vWj1+99SNp1jsZ76LpbKsKtlcJY12KQz5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhhOAcoRWlOofnr627Z9WiHABgSCt/EoCPweAn/MeO0=;
 b=Us4jRr/KV4c+GCW0zYwKXrRkYRNiMgqEdHUZHg0W33+EkYTg5+KIZjlnnx3NxGVOmvL4qkbMdXYMKsIqdk3Z11/S2DacL20iO08ahqrDJbfNkcFzP301Is7ilbvacBKKFMMOA5/oVYV4nagK5mnC6OAXszkeQ9IAOIKa4Zge1//fD7I8oebYps3H5xcNuT3uwrxLJ6gIeJkchuct/KkjfqIrVy1/wfL4YHdalUMB2LGLrln2/Ma7dmjVVVD16mvR4C3TRbyXqdX2xwzn0qLoYC7Y07OHc23kTJHj9U1i3zzJSEnINBfsL8z5pjgYqZ3evgIlkAUMsWoC28ekM+bAFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8281.eurprd04.prod.outlook.com (2603:10a6:10:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 11:46:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 11:46:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 6/7] selftests: mptcp: pass fastclose to sflags
Date: Wed,  7 Jun 2023 19:44:25 +0800
Message-Id: <00b3279d1d0389d0cb35405eae07e0da4f0ccd3c.1686138130.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686138130.git.geliang.tang@suse.com>
References: <cover.1686138130.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0272.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f67c20-e5e2-481a-03b9-08db674cc7ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+JVWKXbVfkNvlbYeKw5BDBX85cTmcczzwQ+MBE+kt2yDirzOSiIsjbKqRhEyFwoU98qThfj8AMiyNyyREm26M5h8r3uraYrNRrLyQ5ePNci6rX/zUJRu+bwnvI0TM/2YJUbnUvVAqErQZvzfEZqEDjchmgsUtk08vu7YTUpvilcI26eyZnha71DHY6tRI7LjreRi0Gh9h1blEYr7teMQa3r5Pip8Up4WbB1CHG7B+4fMs0EXCNjQsjda7wHZ0y6yjHOAP9SHNE/LW2r+6fhht8mlTviW9ZgPIsLwN2/NzckGUHWaGy9UbHdd+7DRN54suwn13whBaAvoQqqpGOIz8bjkyZFVHuvrUPaXPScmi39pu+BaXWnaFo2a4oJe/Bi/jB0cmnwtHGBwVi+EFNd3tPuQ2GF69jeiamVQmAK8uSrO6NydKAfaZK2HHoc7QBeYs8UuSsuYrLkBU1vaTKU7Yi3pFNsvTVgN8pkjlt5VfLx385TX2D32WQIH8K1ihaXHVongFX6VnLrVSCm6yqZFQzI2FlglJLyxUz8QYRQytLb6beIGpkvrk9+VHwnkXz7H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(107886003)(6512007)(6506007)(38100700002)(2616005)(41300700001)(6486002)(6666004)(186003)(26005)(83380400001)(478600001)(66556008)(6916009)(66476007)(66946007)(316002)(2906002)(8676002)(8936002)(5660300002)(4326008)(44832011)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vzNr/SR9Fe+rRe7Jzr9ARzdzK+qPBwDRB7nh6MLl/yIGnVi9ll2WdHG+0iMe?=
 =?us-ascii?Q?JvD7O4z+AVFEYdgaxQoBH20d70v4wWLAuRcPy8H1PSI1dXUBUoIYY6QiRZKM?=
 =?us-ascii?Q?IBACaAxh+sQ1OiBfVCCG+90wfpMLcpZOQspEWFT9ICkNpr73+ZBZGYtt3QQP?=
 =?us-ascii?Q?a0WY0kI3fyMURCZHw80TVFZ7+izaisEgI0XEbRCgI5Z4RXmZeWtOyA+lsQGg?=
 =?us-ascii?Q?jATDiUkVzewG2ZeJOPvCWZsepPawDd/+F/7H9sUe4+l4ueh59gQL+83c33of?=
 =?us-ascii?Q?sBVmQf/hQqI4LamhlReNpN+TE01uu8RDRyA7c2mTWB1cKIDGDKL/6mmDcfMP?=
 =?us-ascii?Q?4UQqA945l5mSrFM6YX2akHid+luOOxyHRKfrUpoJkTPIOWybwcShbr0Wt7mU?=
 =?us-ascii?Q?ywXngfQ5VhgWkvggz9+xLPiJGtOUVhxSaW40Lo4j288zE9EmeC0DFi2mCw5w?=
 =?us-ascii?Q?+uFTnlPfph4VgIBCBw5xHhxLGnTi3hFPwemD0wlXpjmiCaoz9FE6k5CTGzAO?=
 =?us-ascii?Q?8gu/oxJBpcvicvE6h1tr2BiFEULjKpZBudh+MEknGloZk9JNHwYlVN9+KDjN?=
 =?us-ascii?Q?kKogFiHC5IGvPfLemCpYnCPmaqlssHxuJApn/1QleW9QT3lza1eMLxjebhJR?=
 =?us-ascii?Q?KSmWpfL2dPGNy+rG4V/jxNLOL4lZ4P+x6MKpbo05wFePfGLoAaD3+XVVddI+?=
 =?us-ascii?Q?jdmpNBAQ2VbONWH9yQKTbfD/K3I2yaBOsTHJgiphF0XZMqXERPgjM+g8/kr9?=
 =?us-ascii?Q?n2v9hv1Ap0sTfrRp6IyshINm9FZB/4XZ5TZoUueGQdiWD7+8uW+pwFkST7Lr?=
 =?us-ascii?Q?vFEsxcrqj9m2uXgrkF812tvkCrENaFygfwURfjgnyhhhYhS6TxYHdL1wRuvm?=
 =?us-ascii?Q?+gE9w+HZ0rKBNAeHyV0LsZ3OaFGfDKN40ig8xSscNlQ2zWLcmNpHUhMPmMav?=
 =?us-ascii?Q?GR3a44PrOp7S25kUwGUuKtf+HkmLWOxW2tmRBeLBlUDlfXlvPMFcF7ABGPMN?=
 =?us-ascii?Q?N7vQNDB7miikGDI005vA7WvDts0WC2LjmDj9zU0oRe+Lfy4oe779wBHPsDSJ?=
 =?us-ascii?Q?Pae8CN1gL9MKycYd3OBloyWwcq8hZrZLvOpc+fxczjwYnOZI8MCQhBT529ZN?=
 =?us-ascii?Q?8c9T7TktctHllg5FBSe3wIobfUZLolG/3x24or0Hgzbuh6mRWzCJLzZwgDvk?=
 =?us-ascii?Q?EPRre+AXrRuI0D+ZCstl3/IXThRslxZo9B48fbzxEJZWSqpUCFECS+JaQv7I?=
 =?us-ascii?Q?L8Y+Aq6YZ+BWzv0HtiysCzRnNfN8VQnBV0L+3utGdmwG9qiQNRmJoWxOt1HD?=
 =?us-ascii?Q?ZjY1FwDulZO92CkwOaLqRJMeOo3OqmCK9rltyDpJ669ghthtorJrkA3eYlpn?=
 =?us-ascii?Q?6WT+rYngmIXvDTyTTVxJHHt5+WBLDrEa29vbZvijyphffnLvTgMYGYAHsarK?=
 =?us-ascii?Q?v1ANsIKX9g7otaq4UlrkzVLne4wzGTp1semt4Lzo6/C2jbdJJgt1+nCptxGF?=
 =?us-ascii?Q?KBlfjw+mVXaixKNZIqKemlvfu+jR6zVT6Q8CM+A0A1J4+r233sU49k6cI6+1?=
 =?us-ascii?Q?+dNW+d0RSP396gJvKYHSC0NB6FnuEPXTtcbX2OrN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f67c20-e5e2-481a-03b9-08db674cc7ab
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 11:46:06.9351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+Wx3H0vxzdvkJR5RzU5Zb/rETqj14vaUdlu7+HMDCJZib2602CVz/KEEvkBw/Rd9RuUTQ3BxJKiCaNAlWaNxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8281

Pass fastclose flag to the sflags argument instead of addr_nr_ns2.
Then the fullmesh flag setting can be moved into pm_nl_set_endpoint()
from do_transfer().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d594df3e7897..cd6869a3783d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -807,6 +807,12 @@ pm_nl_set_endpoint()
 	local addr_nr_ns2="$5"
 	local sflags="${6}"
 
+	local flags="subflow"
+	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
+		flags="${flags},fullmesh"
+		addr_nr_ns2=${addr_nr_ns2:9}
+	fi
+
 	# let the mptcp subflow be established in background before
 	# do endpoint manipulation
 	if [ $addr_nr_ns1 != "0" ] || [ $addr_nr_ns2 != "0" ]; then
@@ -998,11 +1004,10 @@ do_transfer()
 		extra_args="-r ${speed:6}"
 	fi
 
-	local flags="subflow"
 	local extra_cl_args=""
 	local extra_srv_args=""
 	local trunc_size=""
-	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
+	if [[ "${sflags}" = "fastclose_"* ]]; then
 		if [ ${test_link_fail} -le 1 ]; then
 			echo "fastclose tests need test_link_fail argument"
 			fail_test
@@ -1011,7 +1016,7 @@ do_transfer()
 
 		# disconnect
 		trunc_size=${test_link_fail}
-		local side=${addr_nr_ns2:10}
+		local side=${sflags:10}
 
 		if [ ${side} = "client" ]; then
 			extra_cl_args="-f ${test_link_fail}"
@@ -1024,10 +1029,6 @@ do_transfer()
 			fail_test
 			return 1
 		fi
-		addr_nr_ns2=0
-	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
-		flags="${flags},fullmesh"
-		addr_nr_ns2=${addr_nr_ns2:9}
 	fi
 
 	extra_srv_args="$extra_args $extra_srv_args"
@@ -3134,14 +3135,14 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_client
+		run_tests $ns1 $ns2 10.0.1.1 1024 0 0 fast fastclose_client
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_server
+		run_tests $ns1 $ns2 10.0.1.1 1024 0 0 fast fastclose_server
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
 		chk_rst_nr 1 1
-- 
2.35.3

