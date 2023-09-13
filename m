Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B723BA45
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 06:04:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqbnLswltykjsFEKI9f7hMobXd30e2VBQr8Yn38R9iZSwFco4oGxY+jXw3iu9st5bWwL+nUtlOxMS2N/W7lq4XjoBNUkjno2ebFRrUQhZ50UNZVUlC2cbLpfMbyZSCOtVwLk6qn60RzWJam+quU0YyDdvmu43714m9k3l7v0zBJac35YTW5VxLOZE6mOs5INJ33qXwUCTzjZTmOxXubGHn1itSVGQ3Cd1GI6FuVW05wchLyDcFoq3RzoVtFHx3yZv+5bWvoHOUqDKhEShNmkRFuDlLdvnJ6Lt4+NI3Jvm1NIFg+EGNOfi2Qn3J6BjOWnP/QW849/jGn9Pi95B4FwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkZcNVm8vYhcEVIJVfBiWy3Nu53VBJd0ERRIAhCIIPE=;
 b=J8pJ17/30dO4bEWHcIUk48HhcWjTihm3DKQ4V78sA2NfEbhCtHK5pscJCy18j/1bbdK/1srrfN+T1m3yLF+ekEIKmYsxGQ8V8VJBZCEVOYolpcwrAW/LbYPi3IktqbQJIaBbdLQK1gEsgvsWgXuj+QvV/d825yFPwsy6Bo9fLelvEGZY052pkz3I5b5fX7lJdH2w4e1+jXHCfZfxSEjM874mHQ4XhHJ5w59a3wdQq9Zdzrn0ErbcTZU0E5MbjHN6KVRaE/vnDJpoZLktTA498Vsm+iVdvW+EcAeTXFhH3hart6XUpSaJ0oN8Qo20X2PIFMQyTf11sx5YBoUNARu0eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkZcNVm8vYhcEVIJVfBiWy3Nu53VBJd0ERRIAhCIIPE=;
 b=SmuACXR5kdzHCrWHUy+7fuLOhJOi033d3HGDLwXEsMXHQ7jx6tA7oZ2B5gNR7qZDyRC3jqW+WBBdI192Rbjl2FKcQhVpWXJp1C40Grio41761qrav1lpjWf7uW4H8iTeXR//ik9sn6HRVkGEtRElVYZJYjX7Iac6smP7+6bKa4E1tOTLw3c4kDZKOcaDismgOHh5tNm9Ubp2pyR94o5VnKmQgcn65nuKk4yFOVYElN1pTevsGZgW+AfxoXek0nlkqM9oCJbXhNHzBlajDp4OiM/qnVGd5aQ/0h0o8a+iFzRqQgFfNKPUB2quZ/YQFA7vHHVEySnGGjl41EMKjO4DkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8063.eurprd04.prod.outlook.com (2603:10a6:102:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Wed, 13 Sep
 2023 06:04:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 06:04:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 04/13] selftests: mptcp: add userspace pm fullmesh tests
Date: Wed, 13 Sep 2023 14:04:52 +0800
Message-Id: <05750ff864d51c845f16d1959057679269f95686.1694584681.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694584681.git.geliang.tang@suse.com>
References: <cover.1694584681.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 72619e52-9641-428a-e5a9-08dbb41f55d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hLvsjGaGddiVUkXS2UdC7KB2cFaj8er421Smy1I3cgP7i6tyel4ZcyVRnG4FEdZeNOtfiI3oXq9IujcHFOHSWmSBZ8VKt0Mkmp/EJOynMnYygzR3FjTS3oaQbN41htaLAQFYF/eOFmKVzfernP7oNIANmvKwvCHzFIffnXVJ3mr+PbWRwjVnD1OHkOQ+KAsXc/iYNbDUhsjf+Hzr5DNtX8/awNK2S5ndCE4i1c1fg3wZTGX6UBMBaUslPoYWAGd6BzsgsDRD8iNQqG8bsNlIyxlpOdOfQUlTXD8r5v/jFyOjbNwSTD+Qn1hovTZKNclsXci5bHJeHk/s/p/BKzua7IfEGIwDkSR95GjegwZP0sL1Ry/mn70vADP/SgtyAvpU0TvTd+mnzwPEkuANPFzudZrfJa7X8rm+i6vCovlEfjm7YfDKM75enSzEw5iLhSkurRkAu4LvtfMakWHJCSSMgE4XHFBa8ylyGgjoVSnJftmlxl9EzAdrwrTX1TrraWi1c5SVStyfxQkJBU1rY3w9k6NYLd08ViOV2FvzjdTEz5HM9e3vFTjc8LzZIzmCmF/vMDLEicxZtcHW/LL4gbfQsWccWZ7cr9QFIl9qyV++xds=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(1800799009)(186009)(451199024)(316002)(6486002)(6506007)(6666004)(38100700002)(86362001)(36756003)(2906002)(26005)(6512007)(107886003)(478600001)(2616005)(41300700001)(5660300002)(83380400001)(4326008)(8936002)(8676002)(6916009)(66946007)(44832011)(66476007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S/ATGdATj5G58u5m3vUhaqGBcdnNdQXZIUrkZ2JfHS3cfCbqKBcvec9H/M24?=
 =?us-ascii?Q?u2pw3n0IOFGeOaGDMEPi/xTS5eveHaGIKQ/BjoN0ZyNz8CE8Jo95AE0DT0lr?=
 =?us-ascii?Q?jUJ7+uQq+A3Dkoemd8mJRAg5MFTWi/5KgMRP3k/faCONyU+MewatQz0NVS1g?=
 =?us-ascii?Q?knbqjPXniUH0V9v4r0wZfv/gKblqo76fNRX1W7CSMhw9X7NxHP/EYc+Z5zWB?=
 =?us-ascii?Q?BrJz7X3OU9FkejxgPW7WxHoa3b3DAhjbVZ7nrYdjlR31haoVYUCesUeH0LRJ?=
 =?us-ascii?Q?XDF7XnPenAaeupZFoiwewU8mhVkNC9t0Rgt1d2c0DJbmEWvGP3ckTnBjDp16?=
 =?us-ascii?Q?CXW798WleoZCPI1KO3DcF7m9+pikOJGNwFI2oPorD7h1/EVAs1yKftVlu+EZ?=
 =?us-ascii?Q?hDWRoefjaaMQvhPkNfVkrCnDRUzgln+hKo26RPWom6VSiDf7zZoKxJLg5Mp1?=
 =?us-ascii?Q?ykOTKSr4u79IlPzpB/3lMPcj5ztN6Qssf0138g8apstLjlbfMzSap95sZ4cu?=
 =?us-ascii?Q?b77WiLaoklIWvjrW374sj+zIisXm+YZfK4VKgL33ZaBncKfjhl80EOd7J8t8?=
 =?us-ascii?Q?YBrTNtvRIJOOWc390+WvqbjZGdB8YI3h+9lu/UQByX3W9hnVpwToNmykaEhY?=
 =?us-ascii?Q?KpugIKh15V7DABre4gmTA8AMHTVEvuHFI+Uumzm62ld5Mo3Z7lej8hY67Rdw?=
 =?us-ascii?Q?FyJfmTv8fjd7qIpAmMFN5m4hIEBAmcfa7srCZZ7hDR1eDgjQUiYgL9kuv4KU?=
 =?us-ascii?Q?43GT0YvUamJdtwZsFyWhN8/M7FDTz3roxAcRM1CkB1xo2kD9WZJ0u0ycTW2z?=
 =?us-ascii?Q?hc6hn1TxcVmiQbVkB0nnJKeasGiNuI2oIk4L6FM46Rb/yfXZ7Zkm0QftQkJe?=
 =?us-ascii?Q?bI27B8N5+YsSioMoUFMj42u8Ej9775tXGUb4TqLKHMetbYX6nIb0RZ3eYedf?=
 =?us-ascii?Q?kbej7PN62yhtXPCTh7xj/ey+Wu0NTL2e7fFCg1p0xJ+pHUyKQJ7scg+Eo9IO?=
 =?us-ascii?Q?NHr0H4iZhBD6IjWD3RuU+4+PFG0hHL+13J/Ci2P5G/7p9knFcTDNbl1fRCNo?=
 =?us-ascii?Q?OoIFgDrnbVTLMvjOshJWTyxgkPGoC54oQ9FtmUfQQnmJu27uJXFKPIQLR/yM?=
 =?us-ascii?Q?qGpRCq4MPJij44C+PXcprweSOn1wrH03Ok3geLUG1+4qWTr2x4aTazQ+nGCF?=
 =?us-ascii?Q?uxlzI1Fpe2aNwh4k8WgdW0jpVwrqqLTYi7HDKcRcPEWcKWP4Cp2YJGMab2IF?=
 =?us-ascii?Q?L+6p8JIoJcQ0hdNb5hFsJvdZhCU5Pk4BV1aqQJJ94XSe+hVkr6K85XeBJOks?=
 =?us-ascii?Q?UFH1MD2t+zb5kIyFKRM8n976qcXOm0y1VkF2yCVM6gynVXfJUO/cWSXfU2Zj?=
 =?us-ascii?Q?lZ+d8bBvOPx5WoKhfkvVnyWZwBkwsBi+a5Uk22Z0t2ezEHL/JMQarVKUsMIj?=
 =?us-ascii?Q?l7k7kb4WvfDYyvWX03/HRKZqggt3rRBoDdb0XX1hbE6QNmh3IvI7sLJitSDu?=
 =?us-ascii?Q?qPrwP7TGklgvv1ytAtryQSbeEkB73LgmQl1CF5UnXKyVo+oR6osjl+xKz22a?=
 =?us-ascii?Q?G/oJbvChLf1TaDCWNiX7OYa1kp3s2g6gsb0SuUE2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72619e52-9641-428a-e5a9-08dbb41f55d9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 06:04:48.2175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdTa+KvUWv22Ys8/twWXaNpmRbrK9oOFMaSkLpO6Dl6E630Pb+BjHWaB/0x2QdzkUC7LsqNjDyp/ifW8JuoKJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8063

This patch adds fullmesh selftests for userspace pm both on server side
and on client side. For the server side test, add two endpoints with
fullmesh flag on ns2, then signal an address on ns1 by userspace PM to
trigger the fullmesh connections. For the client side test, just use
userspace PM to create multiple subflows to do the fullmesh connections.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index caafb3b1a465..2fb07f87e6bb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3520,6 +3520,46 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm server fullmesh
+	if reset_with_events "userspace pm server fullmesh" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 5 5
+		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		chk_join_nr 4 4 4
+		chk_add_nr 1 1
+		chk_mptcp_info subflows 4 subflows 4
+		chk_all_subflows 5 5
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		mptcp_lib_evts_kill
+		wait $tests_pid
+	fi
+
+	# userspace pm client fullmesh
+	if reset_with_events "userspace pm client fullmesh" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		pm_nl_set_limits $ns1 5 5
+		set_userspace_pm $ns2
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_sf $ns2 10.0.2.2 20
+		userspace_pm_add_sf $ns2 10.0.3.2 30
+		userspace_pm_add_sf $ns2 10.0.4.2 40
+		chk_join_nr 3 3 3
+		chk_mptcp_info subflows 3 subflows 3
+		chk_all_subflows 4 4
+		mptcp_lib_evts_kill
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

