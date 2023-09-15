Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2070.outbound.protection.outlook.com [40.107.105.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA463FEF
	for <mptcp@lists.linux.dev>; Fri, 15 Sep 2023 07:45:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaQUenciJFBwMPfWm1qpj3PR2WLH4U0idJXENOa/mRj91FlHJANP5fFxEP6YrrqSycW2uPV5exF4bxEW0pYS9uJ6H8xhbDJnw1qlU5Ef3RpI4V54EUEFqROvHxrOqHvIjkMRCN5CawJb2nsOTv4uKR0hVEkI1kT1CnC7R9xHs+X4Hwn+ntUUA2ytPXU+PkMWecc09wNpFOOt2CAVwo4qbExWt7ok3p9t65GECGOevKVL2w9dupbfEyPI6SHDQO5ai6e4acNzbUTM86o6+AlvRyjmimVFKS++ILZ945xZJjKziE2i/7ChQxRRtIyG1XRv38aByOrmPc72kuoFl44tNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GE78aZJ3v6xlnhLBrQKgprjSocMooXv8XYlKh+VFWac=;
 b=OQWYU/kJ1cqSg/qv9OWct0evoCuS7/sBNXqWlsva6YQ9p/ndhCsADrrF4+3GskXRUck+GKola7M5adjEyHDtKBrDeDzpG2eUq2+ZM9kjlQuEmG1DtYkNQwCcvFlyClsCBQmoFm/dqUTucpjsLz1OjYNu17l5a0gpAUBZ9YPqOqYbTx0vAQLVWGnTuM5INRxJlzRaMsYW90QVhHzGJ1bIzmVDTX/ADhKlDLFNxpTsTw9ToblaWvIvl+C9+mqwURogiO+dhKTSqmFLHoS0Q8v/B+f2bnkOdboGdNKN5I+9ZWrQOyyqemSTlQI/XxreSzZRgk8zjjwNlnpO3gEHTkmUeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GE78aZJ3v6xlnhLBrQKgprjSocMooXv8XYlKh+VFWac=;
 b=0UlDcTEFnNzN6sqUweSvisAz4XyurZ9sB3xox6TIXiRu4/fnpOJP44A4uxTba/2zE+KmgYtFPcp1zVn405+2OV3OX+FvLfaTHZjMTUS0PbdMKbERzuk1s1leJGFn4Qafo60hElKSlQQX9QMYpcyhSnAYWRSxYsSB6AhAIgJgeeWKsVDkLrA+2RiuNySywmN3++xfYQvcOlZTxMzNCblu+hcJh9Vkk1/SszCmcJ8HLLkSpGfELtfXMcXf5zvRVGhTpTf8eclrMLSRwUKGXvXvbbb3JpOnu0i0LEDd/V964sZVrwVl2iI00LVfU0JPNfl7VjxZSzgnPe+xhcnrd/HkxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7524.eurprd04.prod.outlook.com (2603:10a6:20b:286::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 07:45:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 07:45:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 3/8] selftests: mptcp: update userspace pm test helpers
Date: Fri, 15 Sep 2023 15:45:13 +0800
Message-Id: <43e619056ff815355d8fc67338d7578741918572.1694763508.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694763508.git.geliang.tang@suse.com>
References: <cover.1694763508.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: c01dbc12-2d21-48ce-1f1c-08dbb5bfaa0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u6F473TUvDU16peoLzS2df0iAy9QcNmFgFJ6xYhCUcypnl9YNwaNgmNt/SiXiGdDDpJO9RMSas2fxEGLud+Vp8c7z1UruHlrPUEws5J8vV1XyyqYRHWaJoKHjAeibYfuFU/JqD+yaSSSwee0kT8kccqXpKDqR0SIBqCnu5cbLNxYxA2euaJtaGHf7RvHmzpTAw8EROc/4Ax1LKdJEbpqkJzXYAgy0z1B5ZktOOIgo44uhtCqCQoSDvpjIAIZNlQC0jb271Nsvou2A0XQK5NsAKY8EwLi0+umKIsz+ji0Zo5cSj0SP6jgMNmpnQfSxAz9/m7PAOvhnarao20hGQimQyJx/38uQNLxiVLA+tl86lzz8WlY9jq4w71sP+MUzyRpniUrLqbjf3b7Qi3mAI6VwcbSlQFpkCvOH2yzauZaou5FWcqlLhRcDfwULkY5YzUmQqdJV/ff9hwb4nFNmQnXWblSgNjgIeDwFQMrGcE+tXuWxRtVmMPLe3sOJI5PH92tBY9VAaInH3nw60eYgoDA5KiaF6C/K8YgJ4PCuVT4MPGLKZsVpaA3Mnv1VUkxoHCGcfpaIzpbvAyGRLcVG96zP9ZkK3Svqxpaqe2YiluOglU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199024)(1800799009)(186009)(6512007)(6486002)(6666004)(2616005)(26005)(6506007)(38100700002)(86362001)(478600001)(107886003)(8676002)(66946007)(5660300002)(8936002)(66476007)(44832011)(4326008)(316002)(66556008)(2906002)(6916009)(36756003)(41300700001)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BxeIk6akcN+dmxY5Jqf0cW0PXIMGEP6jXFoqTcxxD3v1zNxO7449XsZyb8VN?=
 =?us-ascii?Q?fCAHJlSZcP3qp8b5zUhoPZwz1/b/ePIpnHmrHQwJwR08m4wcEuyqH9Lko1sI?=
 =?us-ascii?Q?aJHATHBO41k7n+GAMNSry2crznGwkyFjzFbpdr9JMeKR8eZRmC/MM7zNv9gA?=
 =?us-ascii?Q?r6nWa3Yjd7Bbt2evsvmgYXWJPn5EgqNwatwSTHWMnrcmtR84bpBv47/+c19b?=
 =?us-ascii?Q?YlK90+P3ZTJ5YdziWcjAkzfrEjzR/2T74Uxbi5zB6IdY0aCYDULlNp+bof5j?=
 =?us-ascii?Q?Uuce+vxjmcjYAR2RqNR/IeA1G/28T9QTow0ZyWdjIkLkCY8/FYbtfw9HIcLA?=
 =?us-ascii?Q?nOqjdcpdsBWtPXtNSKcwdFNEX9qLibWivPV/z+yfi1m90JQnsKUOABegmzQT?=
 =?us-ascii?Q?R1pWumRLVkrSaFaZ0gpkRntlt6vIYfj+vRw1Xd1uv+16nUvy8X8O09PPkrNb?=
 =?us-ascii?Q?JIv40CW0qlbU7mQi5wFlrdOBCyDmH8AhC9Fyjrge4Pp+V3MRPQ9W8aao6DU8?=
 =?us-ascii?Q?4i7gZOEJWH0RoseKqNmpTL32RqdDwe/x3UB6Xd5AFBCw7gEK8REaTJPBoCHJ?=
 =?us-ascii?Q?L42eYLWkso1ffUNRtgGxb0rgNyXrgIrg6wJbeHkxzRur8o3juhNFI0y+9EMD?=
 =?us-ascii?Q?5wwi05WgdC0SflpSbqdBWUrD0j/8+7g7D9L4DL3ZaDjiGO2kVNMwRU6ljP1Y?=
 =?us-ascii?Q?SlODofjNnX9MxwEMITuXk4GUrgt2IlHJSk6+dY7gW1b94L9uB1moLQcLnz+Q?=
 =?us-ascii?Q?GtWlhS7+SMZV4xXNYzA4X1vUlReUIY3aKHUkSbkn/Ue+a59+7LkjMfkLExm3?=
 =?us-ascii?Q?jdPhgVzQGW++yGdLDo5HPMD/opzUPjGXg7vUUMvdd5GY+5RK03mTNpNpSPLt?=
 =?us-ascii?Q?uZxgdNCl98/Jdr/agrZvOFZVjKSE7xTehxQ/Bt37ne/uwvwo4c4iusQ92Lqx?=
 =?us-ascii?Q?vIyMzAi1bgIYipO3c9yguz+7JvQS84K2HFEBwMT26bABUAI1MS/bsSFXr9mA?=
 =?us-ascii?Q?z885LfRiqInE7vJ3wsZKi6ptFLPgnyLXNgV/88IOieqU12ttl8GqlgEZ/p+t?=
 =?us-ascii?Q?OlSsTzsoksplIohdFpjTFKq/jbuDdt7gDfEQCbjJ2tUtp6AwTgsYbNOx5Q5t?=
 =?us-ascii?Q?btxkzve+/mi3fRoLan5OaBKDiRH7tyRW+Admiw5/A9fUHZhKZlg48oulOK6O?=
 =?us-ascii?Q?6w63GADau2N0ivOI7SUfht0AWEs5Fka+HUPWnY/twx+FncjgksYIICKXvvJQ?=
 =?us-ascii?Q?aG9xB4UVOicyoKCkXC0b9z7ynLgCasdCmTTHtKRQyuH6sf6UxbXfVLah02JQ?=
 =?us-ascii?Q?enRwsAb043NSL4kziAvss4EWyhAoTUmE27zd5QXNcgtMvJnozDfjsTo7PKxI?=
 =?us-ascii?Q?MWn+BO482HagRZrVcBOV6OiFEdr1jf5N1Y/BYV3fzJ2EQC873Z8H0+ddVHlj?=
 =?us-ascii?Q?Y/BMkxJqLzrJRMeAQ2lwHcZeOAidugLp3jzIuNPUacxYFsy3qPgGs9yeFLVN?=
 =?us-ascii?Q?yXhpAF0/VFjsNxUvbfXCBbHldGYi8p7QmyrupumxeqArIdQpm5+7SNa2FPGR?=
 =?us-ascii?Q?4mg3yIbK8gSbCnxFqRlh0IwciBEq8stpMsE6NzNKrV/jgo4720PLGal2S3QW?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01dbc12-2d21-48ce-1f1c-08dbb5bfaa0c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 07:45:00.2665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+7vtmeRXBZAEwvsf4Wcp4OzSggXT734hZJTLU8Ns91RgMgSIXL/EI92/8PrraPRTffuw9ojYIrVoXuzqOMs7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7524

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

