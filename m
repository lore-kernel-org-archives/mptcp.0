Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C8234CCA
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:03:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuOf957bipNGOmbcH6R7E62D1OfhxPo+qYcMln6vfqPz7GN3rLZKj2gh3Zwc8ZqDa9YqK1N7534dStd7nYDrTjkfZPj+ermpZyCWyj7367+HtkWX8JrlVG/eWaIkKLZCLCOfM20hcI1mtGg5K0lK6MWMQ5y5kwsnGHuO0+abcvhWpdiUbbf/X1YBK4CkQ8aWcsHkynrBrEvwBa1Q7/Avhdj/pEAHWJ3q/CKxQ+52DBT87jFqBxfEpLtiVQvmg1xYtd6BNidGIRjNpJoZ9JQrUILBA4rCA7uaf+KNltCfvJKSJ/GfH7+rsjSn7OM0ZEo74wBnk8RMXdIhbhPB8ZtZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dldh0QL60dVm0Zv3FutnsN/7YDz8pwJ6WGJ4JYinY0=;
 b=jlTcyXMtPgpzkfeLPdpORfHY6IdkWgmfDclH9djFEu97OgqcQp6kL2neaLYSN19+Mx/OQ5YOpDVXvZcRghiq3oKlhGSLSgx0CaIgi0L4UuCfflUY4YxXMlUMxe0V5yNNZljp2dJXaKIaN1r6x6eqkeN9cQHXNyFeqCGSJXheXZBOzbU54UTzbMB9K8PXbXw1GBasqpTVNd0eVBa5Few97NnH8h+SshlrrfGJIVX4Y5MgMAiKHBKhG5QGpHfxKg/JEaZOELBWixkbt3uOxkaYTApKstWoHT+rHZL0abXfmii0f/ZzajhUIZKpKAHpbcR94xzPrFhmz9ZU0IFRFTNoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dldh0QL60dVm0Zv3FutnsN/7YDz8pwJ6WGJ4JYinY0=;
 b=1TQ9bIIKb5WbxQeQDxfM63zEYZWCf36Wz9u0TbeuHz/hBaI+cCHl9FDkV41lA7a2y1mTbg+U+dymjWLAToFmPRoxbaBOLfOET0rvyFFJthFeFv+/jFqcvxTpwKJxC74T1q7DC/aKQubB5x+trfW034yWsZyQ6XLHqfZwgSvkD3e7tH968Qp5ryn2QbN+bL3ioFXOsAqiII//9LSknkobATJjt52dPTE/AwLtiqDlgmS4bb/flkH7RWSUYx+sc474W16xu0I0I16f2gNEbdIWhsYm/d0UpuM36dNtpZCGBsMh4mW5T6F62KIhXk7yajBSMRhhODHRcQRMtkyU5O/Xuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:03:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:03:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 12/30] selftests: mptcp: update userspace pm test helpers
Date: Tue, 19 Sep 2023 12:02:13 +0800
Message-Id: <d2ec4d183a01d4e696d7eeb09b26a7dd83511eb8.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: c566adaf-0217-44b7-bee5-08dbb8c560ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E55ddeWjsNgho2qgDtHwtXp4lCZDQ9ZX0W4DqhnyHdmHhlBuJ5oUSStmFE7K3QsR+KrV5BpQsJ5CeE3N130D+VxFfJ/GvXzIcl88qoyV/weGVnS/QPiw4AD7LNmPSuPX0TY1jTx3/qTgZYF2y2X04Tp4839j8adCe2lNj3rgtcOnxXfGr7ZvwzY80sbyRYnLs+i+QzGiCAnMH0GCAosIYpc6Mjluq3hUA9h2Zdh/x1k3OYaj5RYjQj5QYg345uLP2RC78+Ky9PR9OcFZvDGsJ6hyIHQ9sddUWCD+jCjTY6/tVKMWJrF6VZB6dPUKAB0/t8S0N8dNkf9Dwzjza2Jk8LWcGW7t1QNjpFnEPbcG2Ii0cqz7kwyhH94Uwk8FG0IBFWfM2SJ2tvEqn38IAbL2jcdyT5waAZItNXozkm03GIwiTZ05qNt4oX72QWH/wxUwc5wp73LM7rxvbXanOjxQNuzi3+U/QrVqCo0TJx/i3TGEND/vEXSYcmA2ey5xEKYDSbnUYjwCQhsTlEICh9R0Mt5LNDyGDNm5lhuoXhu99B8Va+uIyd95+xWmnAeL/pK2sMX0zvnVRE0864jl2mx+rsndQPy6Os1yxEdVWbiALFE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(36756003)(2906002)(38100700002)(6506007)(41300700001)(6486002)(2616005)(66476007)(66556008)(6916009)(316002)(66946007)(6512007)(86362001)(26005)(478600001)(44832011)(6666004)(5660300002)(107886003)(8676002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4lJKvSIx7fwNORKLeb70A1p5deTX9kiH3/7OY9QqoSa26xS66SKIk5dmOqXM?=
 =?us-ascii?Q?jCUvXxZWsEcg7cY6RhiD8NW7C3eXuJl4V50g+ol8yp9MoX372fM8NUI7s6s1?=
 =?us-ascii?Q?IWRc/F9muCW9GqLQDpUndpbeHidD6o9dJ3dTHXAbxEMCdqZ6Vva9QaP8Poug?=
 =?us-ascii?Q?q/LYvuAq53ls2Pp4wNCLpq5ptAdWSd1nIAk2zX6m6fRwPbpuilvsA8x5vkfC?=
 =?us-ascii?Q?S96x3h3Sk0nj041NEJSLV5H5YiF8pPhQ4l1jpKHV6UVu+yvbNJU5Y5W40jVE?=
 =?us-ascii?Q?UNaPpJsPeNhaxyVpUy1ZOCCkCX6aF8QByYKfzeRlXbS36QJH0ATHGZjr26C6?=
 =?us-ascii?Q?r/nP3C09Ar+XlOblj+MnbEuDGxne9jJBtQQGeTw4j5wqfjmVJ4fneS7l11GK?=
 =?us-ascii?Q?bmHG85NyYwFKGPbAoCebDPkXFcTzt97QIe4fdT7R3RncR1ywDy4+9Oxi1K9h?=
 =?us-ascii?Q?cQ8VPibUw3Ic7QYtH+1tGpDIl0wOyWAsCy+G0Vbyp9gJ8aC0kTkY3fpfCzwd?=
 =?us-ascii?Q?EBpa4gWa8qWN6yZwpfYjY+yLElEjpVOvmSLEAKhhluP3+iRafJX/KD6LwNlc?=
 =?us-ascii?Q?3CJHyB8Flz0boCg5drmvqt24tKWrfeCpEEHn1kOo0bE9aexq6wiZYsUQVlyZ?=
 =?us-ascii?Q?oAb1iwIWbHaaDZcO3f2IaNOjk5ItF7wM5pbr8f5MgrKt7bxB9NMpMO7zzwmi?=
 =?us-ascii?Q?T2QyC2UVTJa7KTEk9Mc47POSQkjOI/2cyYbhrBnO/90ni7Gb2LzLlBDsgxI6?=
 =?us-ascii?Q?zsccSX2fMacyiK+p1IvqWgvMTBZ+kbSugB0h+wvKPNIKEN4DdKIrYGKdzsYq?=
 =?us-ascii?Q?lMK2IPJwMxr9b5VKNYfUIOVQ+8oH8Hwt46t0YMWU+I36/WPqWAkyzKVugPIY?=
 =?us-ascii?Q?41hjvct/kdHE0A5J2CFbSOxzRgN8HCz7MbdSc3XyM96n5y4/o2ojEvYygPj7?=
 =?us-ascii?Q?w8o1R0Xy8rFLl+VebY/akyZmLA9hxK5YjoT6UvJGeu3hYjDiOdJq90+E3Tsf?=
 =?us-ascii?Q?OeXgLjhBkDRHP+T1SOwFsyF2JHE/HXSjPjHQds82LNUm53Vdv8fL1/Nfkoo4?=
 =?us-ascii?Q?dJsgcpbn8zeakuXNi8WlBEh9oLmV5XBb9zhYKoS+yl5cfULHlP/8mfZNiayI?=
 =?us-ascii?Q?EW1nPB/6leWy2GDdedpQjjmlbdVNeeD1cuH0bXD2ONSSWAS1UD9cktYBLAeG?=
 =?us-ascii?Q?GyDX3aIV5v+kmXBiWZbFcrl/ZUjETFBeSrr0AwKcJ/mJwAt5QPoNRQ39Be77?=
 =?us-ascii?Q?uc865Pvkbl/YL3BkkDVMB6X1RSjVIN0jUvkqa+k+YpRv4afTMApHKyDREfUd?=
 =?us-ascii?Q?yf1+cc2HYr/rsZK/2+9765nAz7aGcCeskBGnpyesVLHb7FM4ETGvpRgYBNBd?=
 =?us-ascii?Q?Jy05sfNWqvuh+ANK3yJjLqsvog3KbXyk/OLFTFOWMC9u+hhRD9LAyGHthgzx?=
 =?us-ascii?Q?Y7bfvjftJ4mVaC/WFeGUNUcPL9n1kjbgGLLdrs1BOOPW/s8mqCA6TduvqUm9?=
 =?us-ascii?Q?PaoBFCw+1EAIAZZbI5zEGOOl5STkFadGw679XJc7hRs3SCVDuzNNSew25kO/?=
 =?us-ascii?Q?A/CTH74ycO1exBndcGMxdQ1A1yUqdx1uItLBdReA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c566adaf-0217-44b7-bee5-08dbb8c560ea
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:03:27.9817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLKmqm+Lh1oUZwR/KIa8Zw22pDaGBDV3M8NxLMtTlSK5kSGa6UTvJh/1wu25Kir1kpzHY7Q8sg+ZmZJL+723Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

This patch adds a new argument namespace to userspace_pm_add_addr() and
userspace_pm_add_sf() to make these two helper more versatile.

Add two more versatile helpers for userspace pm remove subflow or address:
userspace_pm_rm_addr() and userspace_pm_rm_sf(). The original test helpers
userspace_pm_rm_sf_addr_ns1() and userspace_pm_rm_sf_addr_ns2() can be
replaced by these new helpers.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 89 +++++++++----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  2 +
 .../selftests/net/mptcp/userspace_pm.sh       |  1 -
 3 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3e24ab7bc221..25c2948391f5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3285,69 +3285,66 @@ fail_tests()
 	fi
 }
 
+# $1: ns ; $2: addr ; $3: id
 userspace_pm_add_addr()
 {
-	local addr=$1
-	local id=$2
+	local evts=$evts_ns1
 	local tk
 
-	tk=$(grep "type:1," "$evts_ns1" |
-	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-	ip netns exec $ns1 ./pm_nl_ctl ann $addr token $tk id $id
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl ann $2 token $tk id $3
 	sleep 1
 }
 
-userspace_pm_rm_sf_addr_ns1()
+# $1: ns ; $2: id
+userspace_pm_rm_addr()
 {
-	local addr=$1
-	local id=$2
-	local tk sp da dp
-
-	tk=$(grep "type:1," "$evts_ns1" |
-	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-	sp=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	da=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
-	dp=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
-	ip netns exec $ns1 ./pm_nl_ctl rem token $tk id $id
-	ip netns exec $ns1 ./pm_nl_ctl dsf lip "::ffff:$addr" \
-				lport $sp rip $da rport $dp token $tk
-	wait_rm_addr $ns1 1
-	wait_rm_sf $ns1 1
+	local evts=$evts_ns1
+	local tk
+
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl rem token $tk id $2
+	wait_rm_addr $1 1
 }
 
+# $1: ns ; $2: addr ; $3: id
 userspace_pm_add_sf()
 {
-	local addr=$1
-	local id=$2
+	local evts=$evts_ns1
 	local tk da dp
 
-	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
-	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	ip netns exec $ns2 ./pm_nl_ctl csf lip $addr lid $id \
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+	da=$(mptcp_lib_evts_get_info daddr4 "$evts")
+	dp=$(mptcp_lib_evts_get_info dport "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl csf lip $2 lid $3 \
 				rip $da rport $dp token $tk
 	sleep 1
 }
 
-userspace_pm_rm_sf_addr_ns2()
+# $1: ns ; $2: addr $3: event type
+userspace_pm_rm_sf()
 {
-	local addr=$1
-	local id=$2
+	local evts=$evts_ns1
+	local t=${3:-1}
+	local ip=4
 	local tk da dp sp
 
-	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
-	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	sp=$(grep "type:10" "$evts_ns2" |
-	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	ip netns exec $ns2 ./pm_nl_ctl rem token $tk id $id
-	ip netns exec $ns2 ./pm_nl_ctl dsf lip $addr lport $sp \
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	if is_v6 $2; then ip=6; fi
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
+	dp=$(mptcp_lib_evts_get_info dport "$evts" $t)
+	sp=$(mptcp_lib_evts_get_info sport "$evts" $t)
+
+	ip netns exec $1 ./pm_nl_ctl dsf lip $2 lport $sp \
 				rip $da rport $dp token $tk
-	wait_rm_addr $ns2 1
-	wait_rm_sf $ns2 1
+	wait_rm_sf $1 1
 }
 
 userspace_tests()
@@ -3434,13 +3431,14 @@ userspace_tests()
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns1
-		userspace_pm_add_addr 10.0.2.1 10
+		userspace_pm_add_addr $ns1 10.0.2.1 10
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
+		userspace_pm_rm_addr $ns1 10
+		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
@@ -3457,11 +3455,12 @@ userspace_tests()
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns2
-		userspace_pm_add_sf 10.0.3.2 20
+		userspace_pm_add_sf $ns2 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
+		userspace_pm_rm_addr $ns2 20
+		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index def35395a254..bb95dd967eb3 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -8,6 +8,8 @@ readonly KSFT_SKIP=4
 # shellcheck disable=SC2155 # declare and assign separately
 readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
 
+SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
+
 MPTCP_LIB_SUBTESTS=()
 
 # only if supported (or forced) and not disabled, see no-color.org
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 2413059a42e5..283c62deb628 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -25,7 +25,6 @@ fi
 
 ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
 REMOVED=7          # MPTCP_EVENT_REMOVED
-SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
 SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
 LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
 LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
-- 
2.35.3

