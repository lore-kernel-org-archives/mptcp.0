Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2077.outbound.protection.outlook.com [40.107.15.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D77566C
	for <mptcp@lists.linux.dev>; Sun, 20 Aug 2023 12:07:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhN1Nk2W52rHatZDVr3X6EDKscN+i/whrMktaS7aduWnjw6L0FgIw+7cKDvVo2GcaCJ3FD0tiNdR2Jt6PoHWDAVm63ks5gz6410xkLyaYUi5pcFEgpDig7oAH6YVhO0EMVnqhCmoxyN3h0gzUkvne4GPbMJThPTM7fIhSsAplpNrjTbMjzWxlKVHHn1SKWJDlrujYMta5eC+oI3O8o4imLJlBf3vpAHqurZvfiQtLc6VL35q/KQghZVnv9Nrqp/eKqpmKGE55e7pkLFVztimvz3EfqxhKPflY9aRzv2cHLlPkoZzY17tQp3w8F6n4JY1U+yhtvgISP++PyWkcP6EyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ve8kOnKk8JaSkqJykI832AF5++gQpH8SpG3UW6zE2Aw=;
 b=C5e0LUccwbpbaKfDxLnMC4RQ8QpPlCdy1Eu5YUvGCSki6/zOKxFF17doWp26gZb6QlrMKoAget8d30tlRs5k8XjSDytUFV+qIAhO2il6Zsrh5GPXBW0et4SmEr0a87PsElJ1WISjgt9/YL25fZkMG/JlvOoAkOWefbOn89I+EYA2BHtRXz5+R9Fhxp2EVAn6lmpcCKXJRRjmz4vEuCV3NnfsZDNOcipNa4mHKCg1D2Dt2W4u5W0EYOvhvImFCVmjOqiPo4EczN/TPqIDsMvduIw8Mro+jdAFjSeHg8qTmX0nRQP6f8cEaNE4JKVzIcxbX5FfYuOB5ZlJEwyDW9uTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve8kOnKk8JaSkqJykI832AF5++gQpH8SpG3UW6zE2Aw=;
 b=CRDFOQbxpVcWaT7O2yoC26rXJMLlqt8ov3mgJ3xPD0coc5GViUV3SZhpiDPe+ck0BkZiORb9sz9xkMLGG9Z41F6tKBSvDtia+a4riV/Q+Rb6MgkTs6XN8LNy93nL8D/riW+vRz5/qXdYrUMvNwdMPB5cP4GxQyYkbIm7KDr7YyTHh8UpGsQUawE+Pkji3VSX3TQjEh1Er0IdFLhIw/9wuuEvRxYWZgAsH0MnftiLDZ1X3Ioq8scVcdCLWC7OCiS22o/0NyhEVduV2Fhf5o9k9eB05t7ipPuVCvTlGKcoeF6O8KeVmpbVoAYvt+paZmHG7LFrpsxoevKUQHXQ/ITIMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9523.eurprd04.prod.outlook.com (2603:10a6:10:2f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sun, 20 Aug
 2023 12:07:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Sun, 20 Aug 2023
 12:07:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 7/9] selftests: mptcp: userspace pm remove id 0 address
Date: Sun, 20 Aug 2023 20:06:38 +0800
Message-Id: <6417c2f6e2c5fbab2308689f52f14934d0b60704.1692532859.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692532859.git.geliang.tang@suse.com>
References: <cover.1692532859.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0249.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: 04885929-9957-41c1-2089-08dba17604d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mrjbxqGKvkf3TmIzYlKWkRdGiLCVufCXyKko6K7awgVKOhFF+AY1mfKnjAKDrb11QR6bvQjUKgGid/L6LssU+dAV4OemwgGYnGOjPtyD2/do6DClDoSSQXHFGTGEa4U9T13Up5Bx4Nt7ts9XjEpA3Vp8MS4NILL+KIAUkZ14Hm5FzyGDqjm8mQi9RYKnLWJ1604ThCodFsceJSjdqcIGuFErpX5rCcwocFkuMXlKSXuWRXJZWds//qGsF9d/5dhrB3FvfqkMqUFme8ZW7DebH7Rm6ApIvum4icGLXinx1RmcPQ1PvJzdpI51IGmhhQrhM/xAcGbTS+HiSZYcTCxgixCgqrGqvYt1nmDUwKOAJrZu2ZvGJnCW7qgkBuJxIBnUWwzD1N94IaGsY3MHcveFB/+nw0ogEu4Ty7NBoGHTjQMaaQRLlwCgdcYMUR6QLj69ac1D2hWnQX/Df4do65vHFp34Ktlzvn+ROo6+9ruL9WBuUiVAZHlu3oMiEhdo+qgPnaT2wVoyMQ16ptZEEwP8CuwQpEiRbnKx+fo7mZNtnL3dE8oTiySTH69Ns0p5Xz65gGtm4Rn4EHnMO8oPipAYw5qGk7dO/7DGg8arjOY1ulE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(376002)(396003)(346002)(366004)(186009)(1800799009)(451199024)(86362001)(36756003)(478600001)(66476007)(66556008)(66946007)(6916009)(316002)(41300700001)(38100700002)(6486002)(6506007)(26005)(6666004)(6512007)(107886003)(2616005)(8676002)(5660300002)(2906002)(4326008)(44832011)(8936002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?to2rYly6kDRwk9QZnLjcuP8srGjS57sDJDrOC16KqMas4CsMqGyd5ueyh0kh?=
 =?us-ascii?Q?QhltS2zFP20PTkGaAGMexmeXPOEva4DKJnvTf+ubZS/T8GevwQrtZtmTWgCE?=
 =?us-ascii?Q?GhuJVmBGRgXXQFPXat32T+ncZjQHE94rknsXWrDgq1kb13ZA5G69DoW4ngep?=
 =?us-ascii?Q?O8UdssD628OCl+ZkzFBLV60Syjh13kQVIVWi6XdNh4cUTmq9Ma64zWOXbEsk?=
 =?us-ascii?Q?kQYSUxu/zJHyA9VZjisCa3vEEWde9rVOkK3LdScA9UM1x7X7cGlXK8Ncrwoo?=
 =?us-ascii?Q?IUOsuePZ1Sf0tryz4Ys/5kyOIIC/sFfAa1wWvxX23LtR+6KbOxp3FybkzHAR?=
 =?us-ascii?Q?7+URsLntfrjhclzx/1UTTubEtceHucQTCedWfBmEgnSs2HOQtuuZbjw3ZmsH?=
 =?us-ascii?Q?5zYZ6XXOiPW8tum9zyUfOmpDPeObJg7SFdlEgSn3lQIb9XkjXrXL0Uzrr1Wl?=
 =?us-ascii?Q?qn9AMWRe5xqpjE0/0R3/D8+1VC4pRYD5wVvt0N9SRJ993kk0zCog0+Xqwx+C?=
 =?us-ascii?Q?+zLW03JUUPjx1OuxpLoeXXT5BiADTv86aVkLs/X0vMh8NZquRJ4wN96TfHaG?=
 =?us-ascii?Q?xfNH6IG4liGCZjJqtMxAf2fMt4GULUU4z/gG2q7oAkTCXDbQontcqoH8BFHJ?=
 =?us-ascii?Q?t6SCSw23mOvLcq1qcE/C+dPnsHi8a4cXig8bISCUqDLNYIKos1dWQHarbZXv?=
 =?us-ascii?Q?AXGJVdtxeF9pztKhL43JG88TCn4Mu0LNzFGaeZ29zX80HdrKC6aJX6RkVNui?=
 =?us-ascii?Q?x7/Mi5uC1PS3CtJRhSeJfvR9+Z3B1cXRLm9rk+/h46oCG1l2zQmB4nQmatj0?=
 =?us-ascii?Q?Nw999P2pBNuA3/E4Dcyr5uzamzbxoaQv59q+AK6Jy0f4LgLFr0SSQLiS8flc?=
 =?us-ascii?Q?kvauGnM5Zvc+pCTq1z0B81ZcNEzRd9JrfV5FWiDAaux32hhX8raL0S6Gy4ON?=
 =?us-ascii?Q?a6iAmcV5QM1MWU2QAek/f32x9QTeb3HY+DqEprxYQnZAXVMz37FtYzYVoML3?=
 =?us-ascii?Q?CJxFsJjlj7l/VSNUjMv3oEVjdDn5a2s3tWN2nprs+dDz1xBVJN+Xjeo4tp3A?=
 =?us-ascii?Q?+MB3MBhQuksWOxaC0DG0/+Y0iOhmdn4XQpzD3BSmNGU8ipeAbQZvu8Y16yPb?=
 =?us-ascii?Q?c3oiLvJRJQZmvUCqYs3yBNL9ADwNwXGXG1AtQd/6QgD+M2JPtOuShu30ZBnY?=
 =?us-ascii?Q?isL8wva0r5lWZUxUri5Wmuqo4yK8vx81RIKPrk3nEMepiJGvYpSeBLZQbAce?=
 =?us-ascii?Q?EPynBpoz+jqqrmSOediVHJddfmFSwazeArACX5ZB6m7myM0kwc5di9iMsRcs?=
 =?us-ascii?Q?ouL4nWgsS/BpwL+Ht9BLwwoJKAasX2YvrCrf6kXzRkjs2tm2JIeo6R/Hhnut?=
 =?us-ascii?Q?DksdAWyi37uiBg90kWp8bXzhngrWTQyhwM8aYRQdO1OvzjfeFNHkDiYIxk+j?=
 =?us-ascii?Q?IATBK16BH+ucLcVGDQuQynKIkV4JfPVs2EF1d4HRyeFzucbHjeLBavNhSvnK?=
 =?us-ascii?Q?CV7zrn6JWIBryOqBgPOBkj+lUGfSdykBzWG2Z/RNBEpO3lbpWVKOnQBhJ4Yf?=
 =?us-ascii?Q?gLWg8rZ3RlCOZWl4om302bc+QhHR4qydZbdaOfry?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04885929-9957-41c1-2089-08dba17604d6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 12:07:26.3372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VanVUqf4u7fvTH+eFuZrVhALjlGMn1ZsHm0qfXBKMwsnFCgfGatckO7MmbVd72EvOITdT4BPoALw9NXC+tnjDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9523

This patch adds a selftest for userpsace PM to remove id 0 address.
Use userspace_pm_add_addr() helper to add a id 10 address, then use
userspace_pm_rm_addr() helper to remove id 0 address.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 22d0c861e974..a4012e09728d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3505,6 +3505,30 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove id 0 address
+	if reset_with_events "userspace pm remove id 0 address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 1 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 2 2
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		userspace_pm_rm_addr $ns1 0
+		chk_rm_nr 1 0 invert
+		chk_rst_nr 1 1 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

