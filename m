Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2066.outbound.protection.outlook.com [40.107.241.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5F22AB4A
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 10:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oW63GMGuLMVCmi0QVyUK9twD0zYgc9s+RGdc1b27aOJn2tp322vd42hRB9PrnAbWCF5H1pWEvsVZOQbz2tANTuzX0wdVJM1xODsSm6o0+FTLxThmsyf4Cb0pYFBumcYWfqt2yWpLbKFpXpwQ80v9a8p6UfCM4XGBDFzfIcpdfIgy1uZdcCx9LKeMc+cDlDlOnxNktqtMRnWwgdjP0ARZOPREObVTD8k931cB0xgcml/3LgX1JXF5AH3vI6G7bUk97+eQYN4718SYwa1qxaJQsd7ArqnDljtE4AfNIeFELTNjD3fQ0Cht6Sc/+wiWgeiOliNdeKwQuPM5y9PeeeF9nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GE78aZJ3v6xlnhLBrQKgprjSocMooXv8XYlKh+VFWac=;
 b=EeLeFHPQZFQjldcTiDIwkUcy5+opXfUd3A2sl9oQa1//dt3U6jOmHT+z3GbhnlmspAQzAsRErKmoRUWp6r3aae9h++tjojzY2ZMof6H2vcrdnwO31yDsW2GXlqFXCqEI/7SU/xc6M4IWsrOOnJv/RzlHWrQdsRCoeIH6vktsdyiGOd2mw+mHL/Tp9JmsN4YzlORo8ZXrYAtTtOr1RYcpi+vgHX+OMAMexl2qCkiQZlQB49UNqkr80XbPPvTOJugKgX2/iZevsm58Jg17s6at9vfANbURXiL71lqupPuWIjeAp6f6X//FueCY2VGq1RjE7z+LVqacGYSTOqsrVJFRdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GE78aZJ3v6xlnhLBrQKgprjSocMooXv8XYlKh+VFWac=;
 b=xax2CDkvjDyjpurgtw8rQNHtyIlrFY6Zh2+M3I/GOK4O90jq37efxSiESxjJGOW3PFWQ6Jfl/9DhPofAZkINKYt2hVGfIlTVy10chv/Zpnp7Et0J6krD5jlF+1RBxEVLy7aA54QXykodHzH2+Tipi0mESQLWJfRzrO33C5GJHgg+TV14ZIPH6Eo0NorsrJ6Kh/EbfTCTCp705vA2vPznfxROZ+/zYWnuZdVJz4RwchtRP+g79lfD+xcGbrfYYaW7O1JNamUPouYB/k1ToZyg7o+Pla3xn0yVN0t5GIOdto6Gr95AZBB28cTgkrOEkd8FKLQCqyLDTGAOYpn3Tep4Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8992.eurprd04.prod.outlook.com (2603:10a6:102:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 10:03:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 10:03:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 3/8] selftests: mptcp: update userspace pm test helpers
Date: Thu, 14 Sep 2023 18:03:20 +0800
Message-Id: <ce682f1d13bd68de90e30d3138e8a4280fba4230.1694685050.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694685050.git.geliang.tang@suse.com>
References: <cover.1694685050.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da64163-ae7e-4b54-2e3f-08dbb509d395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T5ZlgE+rHby9O5Mse2SWURg5ZaJzinwyV/oDIQwnTUI92Cz22WiA5oyV2rHhIXnNPv+ukBVpVckxiDX6oTryMAm20Qg+mQuEQgmcfrWJYRQ2rzhcHnRJYKlKqq12XVIzP4lX+M6EPj0fPAbMpLMhAHtVyMDg0vAa0/8+nTxSM0ZmuHSGS61Io8P+8eTX6wuhop3hYj/Pi+3iC9cqu7dw7LOcDhmN8YVeMCmgEyGAi2AeMk2vWWJBebKZgxmyk3MsGSpndXSBFE0tL672gLKk9R+TGmmHnC8Zf2vr49UQKg6LvBIBQpsUBxUzlXuth08OkTfehrIAYSjeYgieKBU7ASqh3sHM2m3rFPuVKYTTYOUVtPzuJXuGFzudSj3hhtswRnzxGjLCtQd4B3zzegec0VUCReB4S4fqWTS6AtMpn2Q2+x4aZwfbnDnMq83jRed//TknV3L2RLJALWQaNAt1Ld2ZACaurjTU9qKSbAlwbDvV5p+RzpsiKKxdDW8n3T2eOIivKduRATu+kj+1DuHeOG5nEr41ErQPmCG0NtOQbR+Q/Pr1OXP5YCMIuo/QscpU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(376002)(346002)(186009)(1800799009)(451199024)(2906002)(86362001)(6512007)(26005)(36756003)(2616005)(107886003)(478600001)(6486002)(6506007)(83380400001)(38100700002)(41300700001)(8676002)(4326008)(8936002)(5660300002)(6916009)(316002)(66946007)(66556008)(66476007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nDrTXs/jRW2xFIx8Ul1+XyvV3JfUWJHLf4Ka/7B8MypGv9pDnEjFxIz8kgfj?=
 =?us-ascii?Q?KZ6nYluUR2xsMoN/nywT2CMG1a7hNUqQG0Dmomks7VvG/fTAnEs8KHdXmkKg?=
 =?us-ascii?Q?wQ8V/S71kNUZdEoLxyxYy58mOh3qYu4+wWHeO8FoJcEZfD7BwFUU/hDHARpZ?=
 =?us-ascii?Q?95FsFy2s04/m1x20RKADW+ZR1M0A/JVWgUFtc2oBX2xqN652L2OQDHvbggIt?=
 =?us-ascii?Q?Q8hLpqV3cGSB2RYhpjwdKvEMNmicRYvGgxQI1/IuZwDtXkrc3ReQcCr/fNcG?=
 =?us-ascii?Q?RRiNLB4jxlXWByIBRrh65EDQv0Dl1aOYj85MMdN8l/0vrGin6RwS5p3zak3C?=
 =?us-ascii?Q?ZDEWk1z5LKzJjGqUfrJMew/+vjnqRoHKFaDJ04jKxwtSV1gNMeevkeGCQpRv?=
 =?us-ascii?Q?fjgPvBo7pVAiT+VvZY0b789DVpj0SkRA9qkDVzrp+G2WnQ9W3zEkLVAz15Mh?=
 =?us-ascii?Q?MfnkQMUfmg3yBX6wt5poPxFIp02pX/yjA9jZ9Sy07YHkVZ0Jws0d+jqNl+CS?=
 =?us-ascii?Q?Nw1GZhzAduKL3QrChYaDOWW0IACfRq19+B//SUaBPsN+QHQmfTclGv2urg6p?=
 =?us-ascii?Q?HpHgy7HR7YyqnqhqHCJ0P0O2szFlLlsz8q/Bo++b9kMet0ENBXCV9hxaqOg8?=
 =?us-ascii?Q?BZ8KLQpl/kEl7r/wpbyz8J1RIwww5Miy7wEOYvW8WQkAfgP4gD7zzLVHkDWN?=
 =?us-ascii?Q?3A7lAkdLXCWF34ZBlvHgmFPFBxLm+7V2LBuYaBTZvKvI+e1neldMqdb82wFH?=
 =?us-ascii?Q?XtQsKdpgEVeroNYIDZJesm7kOIjk7yxcPcaYqxHHs2cVYbRdg3O3/Nqwdp6x?=
 =?us-ascii?Q?m3lZpDKyz/ojCnJ4l3f5at5nwNft15HrQbpiy4DYtlAtwqhyN505GFrJfCGA?=
 =?us-ascii?Q?RxUpZqqWYlCXKfRqAcQT5IOdYl/ttQOlcIp5RXpsv1FnOJmoaqRSE3bJuXjf?=
 =?us-ascii?Q?DeicLRfANyniBuEJmV5XF0mDUX0vT/Ev4SItTUAtDNSyxix/iiV0FHgmTL6n?=
 =?us-ascii?Q?aEg5GweHzn3SuODYo8L9wu+boWmiFhmb5bfxfAkbh31OqDZAeufZu7NZMWio?=
 =?us-ascii?Q?ZEx/5Sw7VaYWyqfOxeXxjNCBGKssWP0rMbQXJl98PavNNF/kOQGs17/K54hR?=
 =?us-ascii?Q?7OCe4p/Tj5Ptg1AS/0ja4Q1J1OeDoEMrtEHIRXwiS65Efp/ESWv1OVPAJjnr?=
 =?us-ascii?Q?94Kg+h03IhI8JLHgq5XEjBMtPemtw4rpndJ0oA+v2NwaF0JZSW6mnYhwES8v?=
 =?us-ascii?Q?S6MKhRGfnqdag3sby54fD8yLVxXk2q6VbRHAumNvl86nnXNZ6UpoNc3K2c/T?=
 =?us-ascii?Q?MayyeG/v0uQwOKq+nEB+9mFLPqkXyW8ub94IeT81CCYsUUtjytu++BS10fXi?=
 =?us-ascii?Q?vNwKPyBkfhOs9vZ416WUUL5TamAvh1dlsItMRzGiv+tCPoi4/aoDWxaHhI6U?=
 =?us-ascii?Q?ieYF8jV1wRooLVzQ1tLZi1GMIkqp1oHBP+JnIK55da+He3K5d7Pyer9NwDzH?=
 =?us-ascii?Q?ayvac7zbW/vzegdfe1d/HJU98sSIfk4WLLmmNcFqXXMsk9pKoPJqXzZyCHK8?=
 =?us-ascii?Q?5Ny/CzTyjZoVsC6qbxMB9BGw0N7/orfvekH4fba9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da64163-ae7e-4b54-2e3f-08dbb509d395
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:03:21.5803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xx3P5IPHLPTFH725PRcGuHAX+apFAr3ZHAE5AmLOx4QfMa08tW9nGSxqa9NqimMdohCByEGaeproCFdFPtLrvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8992

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
index 27517ba770bc..2ebe1692edeb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3252,69 +3252,66 @@ fail_tests()
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
@@ -3401,12 +3398,13 @@ userspace_tests()
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns1
-		userspace_pm_add_addr 10.0.2.1 10
+		userspace_pm_add_addr $ns1 10.0.2.1 10
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
+		userspace_pm_rm_addr $ns1 10
+		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
@@ -3422,10 +3420,11 @@ userspace_tests()
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns2
-		userspace_pm_add_sf 10.0.3.2 20
+		userspace_pm_add_sf $ns2 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
-		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
+		userspace_pm_rm_addr $ns2 20
+		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
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

