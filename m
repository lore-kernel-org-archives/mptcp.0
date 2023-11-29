Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2082.outbound.protection.outlook.com [40.107.13.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130563B1
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 04:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AZ82rZ+x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHSByWVEBrR5pj3MiqGD0yY2BXJqsj2SzbjwQ9cwnFEuIoe+jLbsszt/vhAhZsc8pCQj5cfBAnk2QfGDd16ZJkIyZ31LI/kT8TUTZ+ObCmAnQZCspvFy5X3KRatuykFweC8u/KxCRfIs6fM69uEVCXxsrOP5sB9YEwMXhRp7BoH3gIWTfRnmwI8OC8eY0bnV40ADd9GojRVeqEuPJwMmnyRL6ZXVnXUTcI0iQSReiCPZsksE3cKSiR1HFwcFC5zeO3tA7MttFwUhqTEjr9HkN2AHigcFAurOBa+BPtLqSSLqOY6t+0bWy6XC2QE6HLAexiLCgafFYxaD4wAMccL7Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnQTYz0XFDj+U/VmzjWysB9o+mCrYBT8oV31tR0XNkA=;
 b=CTUEvcwV0LtihD/3ggkVebZu/02rOA8+AgLmHUzDXYz0luLQ1ldo9DkPNdWsEmcOuX/emqd/dokGb3q3h72fs0982ROWYSVjjTNmBXL9+PzFgL/Fyt+c53As9htcx3pjVjgoKt+V6W9JzN/EQDl8Uq4Fm2WWQbWGBvbyaWr49neIgeupu5Ir+n10YjHfICNUWYG5SKWfeUD5GsAGFrEd49293JEQ5rU48ixMEyqDmCu4kAOYk3dgcmGk1LeQ4B6tQqGpYdx/4GXqz4TUub8DSkcl909uD+vCmDOhBMWXMD79UB4wiAgzmWuhOMV2ARKr5ZiwcU2/9+26I7He/7gcmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnQTYz0XFDj+U/VmzjWysB9o+mCrYBT8oV31tR0XNkA=;
 b=AZ82rZ+xe2trFDfK4ldIHoNNIgqIBjpSAvRU0wyrKwQ+QGk902an/KOfXRlfCOvaO+0QfLEG7jHR+yir0i21QLltqUvsHvXWHB/xAnvbKypTTlFTWf53SWXyOmtotdui0KOFH2NsxGKWKVWlOhBZTtjvsu6n5huqF4xKswhuoEapAW92EGilc5uUtNZnqEXlcLDZSuU1YW3AoqZAd5E4c8V2xrNgHjcaaZRMdbq8X7dhwCXDvvWvLBdkyxgdBL7oaACEZiQidu00UTitZOLWv6thZXUkN0+AgaKlezrox0s/GsJlMNXxtFxhOx9nPCeJiP+IcGuqLpEyReZ16wBb0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9118.eurprd04.prod.outlook.com (2603:10a6:150:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 04:08:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 04:08:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 4/4] selftests: mptcp: join: check CURRESTAB counters
Date: Wed, 29 Nov 2023 12:08:54 +0800
Message-Id: <bfe28bf33329bf157f8b8f9ff49b398003c487cb.1701230012.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701230012.git.geliang.tang@suse.com>
References: <cover.1701230012.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb8d286-91d5-4fec-8b21-08dbf090e716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DTgeGz5xpXf0tWyiUIBXZRJ6EHuLIk3hjqKW3Plpc08qjKsu7uxncwsawuCL1JV+7gBTIl1TolbbGlaw5nHPN2Kbk4EFUlndEglLj25wjQMY53eJI6B95J26BgxO7QiLzGh9EOP+jnPvYoFughgTc2zjvEm9AI4Clv/XMD/vbXgIPMzmQLuItP2Xdsb3m6cr6ueqln2zV+cgt/4XZ1ymuAM+gI441IKoz5A8mpX6Lv8bNZrFNij9YEcARw0Kivkz9Rw3HhnjzoPXx5G2ZhJPgxbJe/KmVy6JaPhIA3frKCFsVKtVu2KKl3/WTVm6Y3LrYv/DGyhL+JDJa9kyGs3mcgoiL+LPqclX39Ngc8f/2rzk9dNs6truXx11ZhZdKmBmAVNjvrCDjLCff1xSgbQkKJU0avti0v7X6Mccjv4F0bBIgfdw0SHsM2sAWNEK0bGgjiwkhocILHWiyHIcAFiGLnhTCN6HGK+xer6QaxDa8oV+GnqCDGd7ifH2TdYd6Ax/9sLtVDw2hcHh1+YiOV9bvTmJO6vr97NFFqUtzD7z1h2qFKdJmM4pFrYHg48Rc0rAH1txqYqNfNrijZ3RWNA8xVzr006pk8x/WDERkkcRqJ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(107886003)(26005)(6512007)(41300700001)(83380400001)(44832011)(36756003)(6916009)(316002)(66946007)(66556008)(66476007)(6486002)(5660300002)(4326008)(8676002)(8936002)(86362001)(38100700002)(6506007)(2906002)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rX2hiz/gh7EB/8DuFGu1VTR7nHvqVDoo7wS+qPrHrVg/wQJLYTQE0beN/e+A?=
 =?us-ascii?Q?akiNTuABR8DkoS+DgGTaq/9swZgNIBsSmzlF+MlCJFNHiMl48lBP9KK3q/Ls?=
 =?us-ascii?Q?KZZSUJ5MfHV5gc96YmRrTVdmAvW/9FE7hlg/ZRudOGKRTbNxNtQ7goP5nR+w?=
 =?us-ascii?Q?n+9n1zxqzvmtuiW71wlSkmk2akg/u0WbaIUFccPirZfD95Ys54kSeaLEZZ6Y?=
 =?us-ascii?Q?ReyvoNhSpNFVTmE1xVqe1aFX77HMFmJscaOSAYYZL/aOLPYEM/qhQ1A7pRug?=
 =?us-ascii?Q?0BLur3Z8dV6YX51QY3OIbZldSC4d+MCaPwqsDyHuJHCo1Vbhx2oxPFH5JuQ5?=
 =?us-ascii?Q?WLO94vfyOoj4NKE5c9fP0Y7S1YByBE5GznXxNC4K4x75CJyRESES4Tbbt0Ua?=
 =?us-ascii?Q?VY1/gK6aJAb3/1D1x0FbL7Bi+0bSO4AkcJMUZuEL4bnFzYK30hKJj6aB8CrF?=
 =?us-ascii?Q?Y0TeTvCWmJF6M6XxuZoQb6uvsxVRUI6dFwkP0RSSeMerxME/67UWFIyp5U0F?=
 =?us-ascii?Q?MBdf17oY++buvjmBT3o0cxqKc+OR1p3PWelI5d5gO8y7hNgY097keFhLOnxW?=
 =?us-ascii?Q?WJWb6FsOjp2SO1OebJHof2Z6cVibb8IZwNVcSQMxO6/BHqNY428ODnkMYw70?=
 =?us-ascii?Q?HBlImrWawbAfYXuhEjP2pw0XNlKXm4S7VjKHWTffb9FgIT5MHi0gzaEdwQtj?=
 =?us-ascii?Q?QdOyrKE08gJW8bWMH0Dewt8Fg0WLdfrHVy7Oo3Zq8nTwpIILt0vKZ/Bolawt?=
 =?us-ascii?Q?8gZAIhKS1dFjm5G1hKlDceqK408H5wzH91FVTiezYt2Mh0q623+NZWw1Ni61?=
 =?us-ascii?Q?58gWyROsxV0FnJ6wfjjTjRJ++o/bnZ7DRlJroTEittqhu+uXy2TNJNjETot3?=
 =?us-ascii?Q?t2QuhAsPhyZrDAK6rN88yF+nzCybsxJk6DtNr94brU2wgGUqj9bDauKCXwhw?=
 =?us-ascii?Q?gXdUH6qU0gYmsiG2WQtqYDWgqvQ3N9O55r2ZX//t0pREOty9tY1Kc/ta39zp?=
 =?us-ascii?Q?JGm+NJHZR03qSDHz1Egk/rS8o90HXy/xmvxUyx2Ip1ujuOpKe0MHA2WF0NII?=
 =?us-ascii?Q?OYVcWpeRToyGxxCQimO7F/GZJeZGqQJkC1ILqVslJK9P0JOZlUg0jaiwNMzA?=
 =?us-ascii?Q?R9GpD0qYXOxdczG5GojRqWcr85d9tZsDmuV3j39JDu/XloVMlVvHSf3pkxzT?=
 =?us-ascii?Q?rUtsfy8tTr1txnqyDPRdWqGB3EANgihpiBCuHQBcCoSFzbnzOhP+9aTCqq4R?=
 =?us-ascii?Q?7bB1sqgcXr8XnW8uEWNRlayvVJPFvHob8TVIx7N5P69JOwEAueT/ljjejdEZ?=
 =?us-ascii?Q?XxaHcJPfaz0oimBic8KuxA4xkkwWJCEwNK/3Y3dta9Pk+WsoxxK9Oa7o8wFo?=
 =?us-ascii?Q?ScO+xWD7hYpJbv99sOs5nzen9H8z2tfjfUpg5A3u7mXhvZieD1FzOIuK7Byu?=
 =?us-ascii?Q?iGzmpZ3clqXw334hwMju95nmNwlYgZvQeXms2litwbdrlOce0MK5+/qDV5uX?=
 =?us-ascii?Q?HYgXPW//0MbYhqKSq2wZPjq6u/awYz1T5VabpwkumMpie2CgI8fk4X8fpJ3r?=
 =?us-ascii?Q?qZ4cZozlXE9EHsd0ZVKJqnOTz2WG5VJyL4GqEnarpy3A7X1TUHlUP5/kmYQu?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb8d286-91d5-4fec-8b21-08dbf090e716
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 04:08:54.9805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkVz0wiOD8an2pZviUeWgXy+cUwVKxY/7MECPG2ZNF8Jibb+ziJJICZFIsnpWqQtWtDExaNWE93cr8fEhjWgXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9118

This patch adds a new helper chk_cestab_nr() to check the current
established connections counter MIB_CURRESTAB. Set the newly added
variables cestab_ns1 and cestab_ns2 to indicate how many connections
are expected in ns1 or ns2. These checks are embedded in add_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 58 +++++++++++++++++--
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 87590a43b50d..826c2af6ab27 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -56,6 +56,8 @@ unset FAILING_LINKS
 unset test_linkfail
 unset addr_nr_ns1
 unset addr_nr_ns2
+unset cestab_ns1
+unset cestab_ns2
 unset sflags
 unset fastclose
 unset fullmesh
@@ -976,6 +978,46 @@ pm_nl_set_endpoint()
 	fi
 }
 
+chk_cestab_nr()
+{
+	local ns=$1
+	local cestab=$2
+	local count
+
+	print_check "current establish"
+	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPCurrEstab")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$cestab" ]; then
+		fail_test "got $count current establish[s] expected $cestab"
+	else
+		print_ok
+	fi
+}
+
+check_cestab()
+{
+	local cestab_ns1=${cestab_ns1:-0}
+	local cestab_ns2=${cestab_ns2:-0}
+
+	if ! mptcp_lib_kallsyms_has "register_ftrace_function"; then
+		return
+	fi
+
+	if [ $cestab_ns1 -gt 0 ]; then
+		if mptcp_lib_is_v6 $3; then
+			sleep 2
+		fi
+		chk_cestab_nr $1 $cestab_ns1
+	fi
+	if [ $cestab_ns2 -gt 0 ]; then
+		if mptcp_lib_is_v6 $3; then
+			sleep 2
+		fi
+		chk_cestab_nr $2 $cestab_ns2
+	fi
+}
+
 do_transfer()
 {
 	local listener_ns="$1"
@@ -1089,6 +1131,7 @@ do_transfer()
 	local cpid=$!
 
 	pm_nl_set_endpoint $listener_ns $connector_ns $connect_addr
+	check_cestab $listener_ns $connector_ns $connect_addr
 
 	wait $cpid
 	local retc=$?
@@ -2477,47 +2520,52 @@ add_tests()
 	if reset "add single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		addr_nr_ns2=1 speed=slow \
+		addr_nr_ns2=1 speed=slow cestab_ns2=2 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
+		chk_cestab_nr $ns2 0
 	fi
 
 	# add signal address
 	if reset "add signal address"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
-		addr_nr_ns1=1 speed=slow \
+		addr_nr_ns1=1 speed=slow cestab_ns1=2 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		chk_cestab_nr $ns1 0
 	fi
 
 	# add multiple subflows
 	if reset "add multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		addr_nr_ns2=2 speed=slow \
+		addr_nr_ns2=2 speed=slow cestab_ns2=3 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
+		chk_cestab_nr $ns2 0
 	fi
 
 	# add multiple subflows IPv6
 	if reset "add multiple subflows IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		addr_nr_ns2=2 speed=slow \
+		addr_nr_ns2=2 speed=slow cestab_ns2=3 \
 			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 2 2 2
+		chk_cestab_nr $ns2 0
 	fi
 
 	# add multiple addresses IPv6
 	if reset "add multiple addresses IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
-		addr_nr_ns1=2 speed=slow \
+		addr_nr_ns1=2 speed=slow cestab_ns1=3 \
 			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
+		chk_cestab_nr $ns1 0
 	fi
 }
 
-- 
2.35.3

