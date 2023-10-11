Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90B91A711
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="oFAa6c61"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2xWk/RktGbE3P0pIQm0YWNrEca2Pkf0CybM7dtFEXL0zwTV4ZpYpBOiPz8iuO8MgF1i6nkH4Rj1eZjviXAMnP8UMeWbq+v6vWNw5N8l7jkvQOSKX8axOFPrb8TfITYYmeU8DTM7tGDYUtFb/BjRR42HMAkgcC0U6akwndvpflOsizXFINKEHsNhlkUO6D9bcHmDL5ZbSKnYhMfs9+IkQofchP5G9nOg4Aa183u/hNhk8jXNinQXbTeKC4M/m2beblJo5vjeiorfhYiOfXBA1BnNEJ5MdJMv+g8J9og54KGzgQyRGfZengC6/4NMGLpRCAquFPrm8YY2Hz6bHVwESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceX2PLTbPrCQTTfEW+3tgDaXzPkKfL/aXmCq/5Yr/SE=;
 b=LEkFoclBwj0e7ij9F26oIn30EYmHpHKWQQ946xMPIXVafEbr2IRp7y0AZ2CMnA20CNDQtgiDpaRAXHbp+PSrULcrIyT3+0buY1jnFKgXU7I2r3FDVyyd2crl3tMYdkuBoefO2A+43PqXuvV4X7XFPJ2pKTnN1LshRbdgkXNvmzF5jxb57jVh3eBzbGKD+/JwoPKNlwvRcTGk5VmsDEu5PmmGM2lUfXTE0XszAKmGlo54wbjshkqfcPAb1hCERKxBrGX2XaWyZSOlggCsJEPlOitTt8KPVM/Pnnq/SdR3WsYi9ZcoVRs7oVBgkwMt+QYtQLhIZrBYIlHb7H3cRiytKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceX2PLTbPrCQTTfEW+3tgDaXzPkKfL/aXmCq/5Yr/SE=;
 b=oFAa6c618MO3niEO0k9XunSna4/1WhLZqCg7vP6osqSkIFEjezc0YHMC+F+RyhTLS/flRe0VSA1sH6mXqU9IAa1WOsr4OjeaR7+Swj0n1VXsp07Np9yNYOegfjjM7t3v/VO2Qc0LXDiuyQk9Zh0ANWrRwc2A0/v2CKpyYSHtOq21g6iEEyZFLqS1SSF1EtpJ4H7x8hBhfHwoP3v5hbWemGWQ4DkqLeywazCJn4KD8BRFEFdSGSdr5jp6uHl4oM6gYXOnTWXXVjXHYDJTYfdPK9sMtyYC0/vXoQU5Sd8M7Z4g8P6Ao0cqYshdyMrAgnFToSX8rdeYKvnM+wex2VPCAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6960.eurprd04.prod.outlook.com (2603:10a6:803:12d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 09:49:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 09:49:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 2/5] selftests: mptcp: userspace pm remove initial subflow
Date: Wed, 11 Oct 2023 17:50:26 +0800
Message-Id: <e3ea1688e3ea581bcb435c678c692c29760b1d83.1697017655.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697017655.git.geliang.tang@suse.com>
References: <cover.1697017655.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0245.apcprd06.prod.outlook.com
 (2603:1096:4:ac::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf0be64-9a14-4aac-f72c-08dbca3f60f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CdozFz3dTnmqVCxnYvhyNcwmsLSxscZbU81Xzyr5/tyeK/8m7C3BB4owzId04ecs3F18vyqhsvl3hMDO2PAIWgkNHEwypwbYz5rD8Nyz5y26Ei/94sNPEWeskpy8TkQhZME+ZJx9YTrIimidOU6oFJJ3Fvn/7EVWg/rLcdZv0AqHYiNAHGsyBzux0ZZiJD50IsraIDO4gaAqkekXDu/rHC8Cb2tZd5tBQRg38s4Mxpq6jN0PrZ4NPgkwesvaPeqUi5+Fl6eXdO9Iti297f/0O6VE4738yUTnM133b0vWjePFaYs+8ABE6JloCa18k6ps+2DT5/OA+3MiD7+aibROszSwc/lQRE0Evy3UOfQgs/XjuyAAO//s+yC3cYA1Dmzm9o0AxMfFQgfPvCJ1FzLnIY/wGyaL/YxDsnjAgkwFOstP1S8g8vErR3MZXPOcIn+0aRA2lnpqbJX97/LuIiee6B6IgGp6fIvpnDDLvDNWZpH7mLf5xNyIMV2s92aEbaGUUYrT5Hrpdkdc02RD8u0FDjUDqH3DuIzXu9xtFOrwZc3CvqyintEZF80tKtM2BWkno07yHzEkRcJSDfuiBFB0KQjp0glb99o0WWB0VolUR4M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2616005)(107886003)(478600001)(26005)(6486002)(38100700002)(6512007)(66476007)(316002)(66556008)(6916009)(66946007)(6506007)(5660300002)(44832011)(83380400001)(4326008)(8936002)(41300700001)(8676002)(36756003)(6666004)(86362001)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lMOSvP/q7CExmpb2Z/g1Qm6+B6PGSKM9Xth90lj+qP376ZhQoJFuAeZqueav?=
 =?us-ascii?Q?sZF8Yxno2QRTi3ww5s/uAeMc9HqgRyL41T+IzxZX/DvF8jRdT0MtUL7sD4fF?=
 =?us-ascii?Q?qNPa1pj7axyHwtUt1IhqEhjT/rkImGZQc38/RxuBFunatg8kfoBS+JlzjbjN?=
 =?us-ascii?Q?YyyWR+PgIw9Eq7j6zAYdh+j73e1Q8dHQ+YDA3cwGMq/Cg0EJ0zQWBSWGee04?=
 =?us-ascii?Q?qPhvWwjDM1xcaJn2V+0++LbvPeyS3qjA/DAbdIZdZtgtyz25djrwMbKykoMs?=
 =?us-ascii?Q?/cNrWBIqfIbI1OfQGrKeB5QNc1HIQb/HR8gylIJNRGRtBXcJfuzG1MLlDCxJ?=
 =?us-ascii?Q?EqhxthzDhqlDH5GwPnBtOGfCxB80CGFOMFTqG7PXZ+a2RP4EuIHbmdcTVzTE?=
 =?us-ascii?Q?4G1oJOB1n0c/DwQKLb7aZmO5jVZrZZFDZ22r/+TB2tiCgbPw+XvL8oBMkd5P?=
 =?us-ascii?Q?CXSEE/rCaAS2TsUTwXF/J99ExHAB4EHILLXOF4ruvER3uRSomoMLJXmVC6SE?=
 =?us-ascii?Q?R/S/Tart1RaquM5TpZzx3z0vVtuZI+3iwv/eeZW+PYQwAaP487FSGMqg3AOR?=
 =?us-ascii?Q?JkaE0E1h7hJVFquRcYGctDskCQRZFoQoEK+4n2q46E6Gn9GuHLRB83DaJHHk?=
 =?us-ascii?Q?SsCXWWrlmLwFKIY+e6otqCGJ8l2ivLtMD5V5zZYNWPDE+vMxisMXoqyYNGPh?=
 =?us-ascii?Q?XcMvMZk21SOt45GB0cBSs91RPtjAEwh18eBJF4LdsskRhcHMC6D+wBt9VyCx?=
 =?us-ascii?Q?m7qspuhxj5wN0wJ/4lb6z2LwhOjWy3OBLd7GGfw1qkmCYn4KAxQ4ytvu19QT?=
 =?us-ascii?Q?n+BDKqjXBuK6RnqFcFB14pPDUteVMgso0rfUZc0OhSKV//g2Tca3iGWvL+wF?=
 =?us-ascii?Q?CisITjf25WL1/IqOhdS77ucQe8fQprj/cHwgq2ogGw3c7eoOjDaFWEUfHr86?=
 =?us-ascii?Q?qPwfghPQRS2xwb7vugNWzIk6yr4qRJCMTq9APRqSGjMc+kEP/oZLZjC88la2?=
 =?us-ascii?Q?+auMG4gp0WyQBNk/aGITyKrwEhdFafG6fbSKAQxxXLU+DCBPWDdC05peWjKW?=
 =?us-ascii?Q?dMi0JKbjz7tRk+CwwtRmMo/ACCh8CLa4IPmPfGmKe3iwcVABy2ZFEZ/shEHv?=
 =?us-ascii?Q?QJ2dpiCpyNORI+gBT+D4ruGGr0pTv2h3AycgZ6+DXpDQRhby5AnpdL/XjwvB?=
 =?us-ascii?Q?zDlrZdaIoQzldFfHrUm6dM6YyjNPV/18u58KK5hPaqq6ZOZbbozDRheBEGFt?=
 =?us-ascii?Q?tXhqdWDXWaxXwgT/yP3b1tTOBcNJY7nrwpK7fbWZl7EApEz/t4T3u/rAHjOK?=
 =?us-ascii?Q?stYffx27N9bcJIEHBQE66pSkmwVe+FqfICVkttQpQ91CZw2WGb20G+bFTfI6?=
 =?us-ascii?Q?9WDRVJJv5dk2zhsNUwI2zX9TPHahCqIVcAkJLZdC8btJmjI8vtHYNm70E7iJ?=
 =?us-ascii?Q?2XXqv5dxaTea6aE4YdfiHtzw0sz+gAZsADCmRsm75PL8rsLRsi3/LbYALngJ?=
 =?us-ascii?Q?tNVwzBnOhEWkFS8BJHcmvvT84y3SXj28/L37LUrN45Wl4EqO6+E1QM/9iK/7?=
 =?us-ascii?Q?Gp0DF+tlPsPgGVxel+NL8xFn8SpGBImW2o9qY2xm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf0be64-9a14-4aac-f72c-08dbca3f60f9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 09:49:36.2852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIGDXIDNwI6gMJzC/31wfJg/58EW6dBx+MWQKFAfQYPQ90jfLb8ESWmchFJnfJgLvLSPFjaw0su2zYtg2GjK2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6960

This patch adds a selftest for userpsace PM to remove the initial
subflow. Use userspace_pm_add_sf() to add a subflow, and pass initial
ip address to userspace_pm_rm_sf() to remove the initial subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ae38b428e42e..199ebd0d3463 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3490,6 +3490,28 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove initial subflow
+	if reset_with_events "userspace pm remove initial subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		userspace_pm_rm_sf $ns2 10.0.1.2
+		chk_rm_nr 0 1
+		chk_rst_nr 0 0 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

