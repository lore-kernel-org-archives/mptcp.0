Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF1634
	for <mptcp@lists.linux.dev>; Mon, 28 Aug 2023 04:35:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTJg8He3Dt43H5Qdg+BO0uPQJaTfaNY/H7SUNWRxDTOz3ldj0o+h/udQDhD8rvO64m2m21w0pzIi042lTMlE2FH8pWk62uJvHHkDTf54e4O5jxG8bG1UWOfVuKc0AYuDSWHPkuw2KJfVnnXjE4yizkjJ8CaI/VoVAnAwG+dTJk3nrM7g5Relb7HXhfg4A+HU4WV8+/QifeyKGXZ1sLWRJmnw/PAo7BwAetdkkZTQ3i4m1HYQmr9181EWAZyGhMcFM/mvNFMTU/I7C67N6sRvsBVC01Pvwoxrg3reMk0jY5EgtCnwmv9cEFfQjoR5QnWVrTwVVviL6YyiWbsW3lwe5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30jQk7COxHDLboAs8epQWAdHgNzUOIQtcJ5xZ11VfOw=;
 b=FWyehNoHE74qkuGUGmOsg/zBSVx6crcTjGMB1drjFtQXkKh95ENaydlO5Nclfh4uQher69DPLBlpxJdcKs5mh1vfdTYBlbZIEt4KIBLoGZpg6TclD/QYKm83Y9eruGl+7CvWjMdLn7ePAkCmqwpGfH/pYCwPTg0X2GT0MNmhRFf4ZJP2ZyGLVaErm1AfmUSVbcvYU+YxZCOewWq9If/N737nJgjGzgMM6nGNsPOYXgUE4RCnqzOp9uB4+5NX2teMYQF56VkWE7R3AItSEvjdsrrWa8bzFzOMzrD4h4scaU9u+DEm7uEcKmgwltpuAEoy2wC3YO0MuQXr3ktrYJwJxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30jQk7COxHDLboAs8epQWAdHgNzUOIQtcJ5xZ11VfOw=;
 b=jm9AXNUEDq4zXwWOBr85z8lPnaO1vesaV+lyReGUgNEmSVtwm/xqZ36JX3lNDEADz/1qDD/eNx3xTg+TRYDGrYFTyZpCQ3vWGuGQFfffjlSMQQiXzICmcXvW5iuGYMR680QoSQMjSUn5JtGF4UXUAoilAKa45mR/Lc1fuMJY9jFxoKZtU4pey+kWGvrtasmY1wc55ZhpKp93YpRv+MqHNnymToy/4sQllLcQi/HjBFHrP8Vx3BOClREAvKnl5R6yHomzgGAohJNHWCvQj8h3El/H/HtzR511v46KoJs/We5DG0OB38jE7oMjH7i58lHWDb/toAZnKVOspPyh3woW1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 04:35:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 04:35:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 2/7] selftests: mptcp: update userspace pm test helpers
Date: Mon, 28 Aug 2023 12:35:24 +0800
Message-Id: <dda6ac47bfd38d8d1f453d0f8c749c7bcdd85e51.1693197152.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1693197152.git.geliang.tang@suse.com>
References: <cover.1693197152.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0022.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 24546771-1cf9-4be5-df3f-08dba78036ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e3XhmGut68cSJ3XYVgZ2CdR7NR1lF6UTMoUALHCiLOIaRUTpZarQjld2+jBHRFbYEYBzAhA+vxvnt1SvUD7PZcOf35u6JiDWcMI873Sla1pbezFrbGFq6nhVOd/UF31nclkfm4ja40gVGItL1xGT8Ko/1BWFsvvERb2FuBBfDOpcPq0VQoYqaHrKok706Z88ZZOoAfXEJsM3U0dtUAzYKBnxjV2aJpAEmFMML6CNBkVatbyak06utEuAoTQ5DEfQfr9zEtnpBnnLH6k2JwMQ3XoTgP2LV/7Erhv3pGmjKH0yPOGOAqKisUNi4EK3Lw1WTw8IzDhJS3xo8DnRD8lG6R5uEXSfP3FAOPbZPJeCG+qFvjE9TEQt2QniKZc+kr14+tqujXK6hQy6A6WvAjBg2cTP5DnGcegGX9P6MqKl6b8qgjStojJ5HZczpqakDcZKMcM+WTKq8O86pt4xDbCC8oXxj3hAygYwH7bCM95sffdHoeyTkKzm3NycjCi9lz9B8PGkYnYpdJl92PBK9GmX7sIFnkfKpre2PPlUhIzeGKlZ7c4rreoD/1iH3ft/6lUv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39850400004)(346002)(186009)(1800799009)(451199024)(41300700001)(15650500001)(38100700002)(6666004)(86362001)(83380400001)(478600001)(2616005)(26005)(107886003)(6512007)(6506007)(6486002)(36756003)(2906002)(6916009)(316002)(66476007)(66556008)(66946007)(5660300002)(8676002)(8936002)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d80PxZM9aytVnBaSbq/iFQESwODT989Uv+FcwVsw2fm8iBXnc99MXcYbQ5j5?=
 =?us-ascii?Q?MqSGCSOfsLRQzVY0rB/iLeyJleFWoUHXUi4GBPEF8nPX/gVyQSFVt+1YlD/F?=
 =?us-ascii?Q?A0NpdL+M2ICNQUzYHhidglM1PNBdCBaStz35Sh9IUjm1ddX9yX9vH0xOrG7r?=
 =?us-ascii?Q?qw+hq4bCBQMhqOtbskhk/VYekXS+cBi9klldz8fiMivbWqvK76BfylNCp0kZ?=
 =?us-ascii?Q?ZE3jRarP0UifZwB3naAl0y5x81vn9V28IoghjOPXjbAzD5TsSF+BfXqoOdKw?=
 =?us-ascii?Q?TBeh0PjFnxomvbl5um3g5YXbFlX0KPpuyPj/Dt3djtiKtZrbnFKAp8dICZGk?=
 =?us-ascii?Q?OikfUgY8qq4mYorUpLNIK/LAeKid8gbzEUursj+2+3TLN0kvyrzLJ5ZGFvxL?=
 =?us-ascii?Q?gMi2TPyVRYH7RhdxgTGGI4qmdzroj7qoz9Bk/t8OlEbDAUvFbIOspd/CFlFb?=
 =?us-ascii?Q?7W1Qpd83RvR/9louFdXv32NXxOcOW0a9gBewE+aTYcuuU8xZfgWU9Kkgmsrg?=
 =?us-ascii?Q?e+pkKY4ZXUp9k1lDCM8/G7xbBw8Mu8nqUCyZwfN0MhSa0aEC4nTLonBs7ROU?=
 =?us-ascii?Q?7JkjP4RosyINQ3Ne8XJSNKiIPE14CBzIY01HN5jlXLo69hzbeEQBRh5w9Ew0?=
 =?us-ascii?Q?CDsYhWaD2HR+qpyG4MZLgm/LrwMSLYupS/jPPt6kjkYFj81Qz+H/fYKxLX7H?=
 =?us-ascii?Q?WCAzG+7i/j9tnIV1NQ9nAxLbszlcZmxxnCroyXIvw/c3pIX1G7k2MboJlA+6?=
 =?us-ascii?Q?4xgQXDMBWDZtcVwvDY8XveBbbQU5+G9GzDL1I+aBtCCZFPKQ6w3zignQmF6d?=
 =?us-ascii?Q?TI4QS3wxemcYg92Kb66TuYRQFWN+nf2ZLLJL8IdFWV9KWOYDVXF7uF7EiIWm?=
 =?us-ascii?Q?H8ugIEZCHZuhrUsxMPP//9ZkE6lhO1+2f/qJ4/Qh18p28PKaFZ1TGYgAwhQ8?=
 =?us-ascii?Q?sV/SSFMUE9IBRvoFP3zwdj3/DjdjTkjnIAGEih26Wd5K5pmHH+PRT2XHE8R8?=
 =?us-ascii?Q?f2FXsc7toeYQ3htLZ7YhXqtn9uHhuUzoB4Hfts4HNy1VNMeUNoyWuz7RZ9Cv?=
 =?us-ascii?Q?o9VYcixPh0GBN80A7/51C4v5Fq7keLTemqWfiGwlgSpM98UqumZOahFg7Gbs?=
 =?us-ascii?Q?X1OJx6yFl6GUjRDDCK+x4JFR+0dM91mW+0pZBzTNpKC2/IQMeqtr3pJrRExs?=
 =?us-ascii?Q?lp9Cx2+FvUk5FV2jyk7CWXghmMGvSnR5f2kpx1vMAN2bAvBMzhwHtXneXd7e?=
 =?us-ascii?Q?Xx+MlrNoRyS2mXf1mgmXqepWvVon0L9lkSSu1TgdMhxrmU/tRCXsjBcfz/aC?=
 =?us-ascii?Q?iqdMCR4jVhQ43Dgs63+/BV/D5ojy6Hi3OhklNDx0UttefVYKt3flbMPZpP+C?=
 =?us-ascii?Q?0Xfl7oYyuUy7x3RXttS049JSnDrN8t6p0i66W5LQr1bVLqdwb40g4Cl2lNZt?=
 =?us-ascii?Q?wZeanOYjeDCB9q4WNzhJ+wreyDe2mWWZ7ScdaSRouqF9kX0LIMig7QvYHSBO?=
 =?us-ascii?Q?pMoCiQ0tPoS1cCTo++eNDD79mB+X1tEOBI9RySp4tpbdbYO0ERV0t/v2FbFI?=
 =?us-ascii?Q?8MpscvPNZe9uALR3VLp+WdijjEsceEPclyvIVQXW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24546771-1cf9-4be5-df3f-08dba78036ba
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 04:35:32.0825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VeeP3l1kXqU5by0r7BSuOiixqEEhF3frLhIebk6XcLAI2qwo2AmEh/mGuk2XDyOV5eUDWxdXjNMVWbjWwmOkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

This patch adds a new argument namespace to userspace_pm_add_addr() and
userspace_pm_add_sf() to make these two helper more versatile.

Add two more versatile helpers for userspace pm remove subflow or address:
userspace_pm_rm_addr() and userspace_pm_rm_sf(). The original test helpers
userspace_pm_rm_sf_addr_ns1() and userspace_pm_rm_sf_addr_ns2() can be
replaced by these new helpers.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 95 +++++++++----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 10 ++
 .../selftests/net/mptcp/userspace_pm.sh       | 10 --
 3 files changed, 54 insertions(+), 61 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 27517ba770bc..983fe4446523 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2792,12 +2792,6 @@ backup_tests()
 	fi
 }
 
-LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
-LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
-
-AF_INET=2
-AF_INET6=10
-
 verify_listener_events()
 {
 	local evt=$1
@@ -3252,69 +3246,66 @@ fail_tests()
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
@@ -3401,12 +3392,13 @@ userspace_tests()
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
@@ -3422,10 +3414,11 @@ userspace_tests()
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
index def35395a254..644d732c64a6 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -8,6 +8,16 @@ readonly KSFT_SKIP=4
 # shellcheck disable=SC2155 # declare and assign separately
 readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
 
+ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
+REMOVED=7          # MPTCP_EVENT_REMOVED
+SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
+SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
+LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
+LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
+
+AF_INET=2
+AF_INET6=10
+
 MPTCP_LIB_SUBTESTS=()
 
 # only if supported (or forced) and not disabled, see no-color.org
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 2413059a42e5..91a5a55b2e5d 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -23,16 +23,6 @@ if ! ip -Version &> /dev/null; then
 	exit ${KSFT_SKIP}
 fi
 
-ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
-REMOVED=7          # MPTCP_EVENT_REMOVED
-SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
-SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
-LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
-LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
-
-AF_INET=2
-AF_INET6=10
-
 file=""
 server_evts=""
 client_evts=""
-- 
2.35.3

