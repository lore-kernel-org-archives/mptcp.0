Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6540EA4
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 00:53:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhpBxwve3X3P+K+YDyFOlHywYvXlp0vo3nf7o9ZaV4evIaoKT6lgzPnN2vYH9iPn54zSRJK7CXfeWbp0Ze4iiu88OcKn8zbmwQEbkVgZ8gjJkrhUgeI756rOwy1sdYLrkXcDGDMVIEuX6LQt97oo6LvJEmHOXgf7K4T3EfhGl7XVTb3YGTgvfz9e2bdhNTCIvp44sHOe0c/83c4xiU0f46abM/VewEp/SrimAcwh/cT8Dyy3oXrS63DwqnX5mKqxzedg71YGLOXWxNsf3DKiUYfo/udDGvMFsOLvhAphbcLnAys1J5a/bDZx4K6SNZgSwzJiLGJO7kHlmnyy2TX2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1k7+1DUoz+ObFyp6Y8sVXFvhhgqnMjvT57sJoqgIW0=;
 b=C3yoOMiaaggPaAoyeDtsYbvppwAqGL48yYoQPjbi7/kw7kgfDv060sBlGMwXpT35+CjWucejmRHx6uYZuHrE5XsnjtXwESUjnUJAYKxmFbElILAMOVFMizZjhLXA9wCrkuXYxX/WP6W+n/ETnePfINoqvFhvsT/H1oHHglZkx/NvijHJC3AATjJVQFi+aZQtcbKmvQVhzrZ50kkTuhqSyVrdow6idxCmW2yer1IkVSKsjIXGDybLkruGsUmNCoqeHxlvmKezwIgALnkvZ1Js3TYOnn8J9EC3Nm2wkwK5x9uXVXa1tc7PSvX4FkV2gHNh7HHGR3vDdjxghlqqEsK45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1k7+1DUoz+ObFyp6Y8sVXFvhhgqnMjvT57sJoqgIW0=;
 b=5u1Hu9L/xH9EGM4q3Wr1CRf16bSPCIuV2uqgwnWD932RcK/H4STnIlZUlnm7aGQ1yRQX7f+FTSVo5RsjdiJwW5VyVh5NcQ0XZZrfHwTcv36mqH2TnUpJvZ/QS1nuWxzlhm1wUD2CpmWR49U63M5P4uwDFUkiCdy3rAhjolgGml8V1+ftTqOoLn9evyUlbxiLUFNxHYyRI/gFl7DFBuoEDCyiEYM1hOpRaA4UfAdLHaIApBkfowG8eNYVAxplK7Qt8KlkBJyOsIM4gTXZVX7o1Q5IKt1P6NKx5GLEJJIsrLxYx7hztZEWAI6DixI8kF5N4hdO3c1cwxz/i5yZxk+cRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7163.eurprd04.prod.outlook.com (2603:10a6:10:fe::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 00:53:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 00:53:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 3/7] selftests: mptcp: test userspace pm out of transfer
Date: Wed, 31 May 2023 08:53:00 +0800
Message-Id: <afd8f08766de7ccde5f6088f23c09e174d288c34.1685494054.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685494054.git.geliang.tang@suse.com>
References: <cover.1685494054.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0138.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd760d2-08b5-4a64-fea1-08db617178cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	riv5wUetGf2dDvYW7CHdbg+d+E265fgMsFrfIm25sTRKDWr+8xjLtc5JFDcTp5pXUSCcN9JjQKcbhFFZVvrF3nrP2sOHpCcprffH6NNFo/bsve4H7WaoHjV0w7mUGmO+h84+Cov2+T01wR+Nf3rD6mr2iOHPUWkeYzQf3vQDyAGLzP3dQObxFBOzP2xU9zzeR1hBkBq5bda3XRiaohKoVsRDSuCHJ8VeP/J24eijofB7XeJ8X/T+DKxnJqKHKgZOp7zw7X1NJApHosOe9Dt6VtWBESF8wKAj16E61w6pqi7TcHWWbQ8QezNdbj3yyLxcsuwfLxACU5NU+qqzyqhD15VyEVfVOvkPjl7Rp2gr3jvve8wSz7jb9wOjkzfi/BnrOoPnr141MGPfOIYFwvsQzDsDYZ9ohQnmXQ2oAVlBrxhAf11ry+/Oj3K6aMtBQxHzE/lWTf036euIfMAPPBNuvMVZLC2IhWJjn0IzCZx0O/YDjUldpnFDlKn4w9MYiLlZ0H4GDcJB8SesBGZ2Q12tRVUR4FV/CbVdvSh5CRfntVeTcJvf2dS7DyO30IngjEki
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(478600001)(8676002)(44832011)(8936002)(5660300002)(86362001)(36756003)(2906002)(66476007)(4326008)(6916009)(66556008)(66946007)(316002)(38100700002)(41300700001)(2616005)(107886003)(186003)(6506007)(26005)(6486002)(6666004)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ype0GJHl6DgSXZI2XKkRvCEqlIoajoc400Ne4dfNg9Vi4Qn8XziqXVY+uPu+?=
 =?us-ascii?Q?RFdKtJolHXlK0+H0IsIXtlHJIXKSvXWttTD2+W25l7oYKD6SVHhV/nECxc0H?=
 =?us-ascii?Q?Ys8vIE05LPGzwK5X4z17lStTS0AoebJfODRtHa1OXzO3CY/AQLS+6lzNoLFy?=
 =?us-ascii?Q?uBtP0surTaumI8JTCDj/MFuqV6d9UD6OagksbJevmh7qXvBZiZBxW1dnTd6I?=
 =?us-ascii?Q?0EGMgrbOuiqmAl7a3rV+X+oNbRNoyT+ZTH5rqBcKKIJi0b/31rgp7VGJPXWe?=
 =?us-ascii?Q?H23ZJhG0NTbsGBmCfVAWUT5dlzX+JpRpAuZN31MhNNU6xPWLDY7lgRtDnJ+f?=
 =?us-ascii?Q?Pc1LrleHWU0yA5t9TJ/azd1F0fV7aMTgV3D4CGNv4+PE4Ej8FU2G4/sIzb6g?=
 =?us-ascii?Q?miwKJN4FEqviZ7MjurxHVs7fyYzjVAJfnVB15CRP66wl4xtTEnayA9UNYBCX?=
 =?us-ascii?Q?sqbvNImmjdd4+crurmE0Yk9sseH03Ajui3n0cOwVWpev54MLj9CLJErij2kJ?=
 =?us-ascii?Q?uL2vgn2lOA67envgaxkKhGfld9l78TGfvqdWNTJC+bm9DACA6drFcz+A4Z3h?=
 =?us-ascii?Q?MvmVHoFViUJa8tlBbm2UoZ8IEfegEKB4JcbtVwnuq0ir4kz5+Dm8PCPIVKmR?=
 =?us-ascii?Q?qaZgoT4d+AQBNIMrzR3J4tvM3QHLdjoCWM2KnH092q2C1kpaGQcKQYKBh+tp?=
 =?us-ascii?Q?okyPywWX/iLRDIZaEmIPa+1oddwvD6vfGj9hdzwUhl9n7cS+3tg9twUP6m4F?=
 =?us-ascii?Q?UTZbWK7GgZw3MvU+Hh+sUjGDwII7unbl7qoHMclY8pV+31fTZ/LjWZyN5+2v?=
 =?us-ascii?Q?A9izA1vMHpFDdz4GrK28bFTucoTG2BXjRBZK/A9JP2jleo+xxfCw1xv77uQu?=
 =?us-ascii?Q?k3a6gTKANsHP2YcL/mVS/CGrMeQC/r+OcTYcMIFe7DWaNTHfSTLwB15lhl12?=
 =?us-ascii?Q?Ze/92hQutSGogbpiMqQR+XRJMYbBdbz0C5jed0ici4uQkxqzkHVAM522tFi+?=
 =?us-ascii?Q?z4XhNPnZu1lPSxUSrGqwBJs96XfEq9GAjnJ75YBgCwi1qDUKSmUAPbzNb+L0?=
 =?us-ascii?Q?SFNr6Tmf3UL2dDOyNRyK8JZLZANLooFyEKbfO7VPFkZ0cxxeUwNA1Boqm5Zm?=
 =?us-ascii?Q?JtPnkgHcdlkxm8sEPmaiQ8Ss+JNAyUgh3/XMzRVEdf/Bx4SYvzNoPYfI9h6N?=
 =?us-ascii?Q?9hJR0gazNLq8OH/ckywteggkSoNGzIDoqDgVt4FC1U7IMhInrQ0FzRxa0c2G?=
 =?us-ascii?Q?gYV8HZqLA4djoGU7H5mGBqkitPPnYlOpE6Qvky33YZ0hwSjcUKTdSZqBp9w9?=
 =?us-ascii?Q?unwQzJN7PPochdK5ApoaarcPrdkeW1rDX5Td7U++PbjcCapp9z8tinJsMsDH?=
 =?us-ascii?Q?h4ioWumE+0Xco1UQeDtn7wku3pwvoOoyJwo/qjizIGlm0S5G94ZWnzG0MCNv?=
 =?us-ascii?Q?gIdRGJwNZwrBb1226zm7PTR+Ao7TurG1sTBnb4Xy6dkMqaTXrhMft0kQy7QU?=
 =?us-ascii?Q?ENDroOPrbmV4HobosMRCMG5dWbTfKOIwCyfhNsd44OXTDuEujvhYZkrR6cX8?=
 =?us-ascii?Q?Eapaqe5vo01Tsf7N8kIKK1CgxSR2MDpRRfUDlw/I?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd760d2-08b5-4a64-fea1-08db617178cf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 00:53:39.1686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SwOUBol4seOT96sAugKZtuQ/cAEcE5UcdxuT4koIr9kARm8KDCv1E3giqO+rFgsLiL9o8aPaGimwSXYs1Qyng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7163

This patch moves userspace pm tests out of do_transfer(). Move add
addrese test into a new function userspace_pm_add_addr(), and remove
address test into userspace_pm_rm_addr(). Move add subflow test into
userspace_pm_add_sf() and remove subflow into userspace_pm_rm_sf().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 122 +++++++++++-------
 1 file changed, 76 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b4a2c2388d2f..04c15fa6f4a1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -813,7 +813,6 @@ do_transfer()
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
-	local userspace_pm=0
 
 	:> "$cout"
 	:> "$sout"
@@ -850,11 +849,6 @@ do_transfer()
 		extra_args="-r ${speed:6}"
 	fi
 
-	if [[ "${addr_nr_ns1}" = "userspace_"* ]]; then
-		userspace_pm=1
-		addr_nr_ns1=${addr_nr_ns1:10}
-	fi
-
 	local flags="subflow"
 	local extra_cl_args=""
 	local extra_srv_args=""
@@ -882,9 +876,6 @@ do_transfer()
 			return 1
 		fi
 		addr_nr_ns2=0
-	elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
-		userspace_pm=1
-		addr_nr_ns2=${addr_nr_ns2:10}
 	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
 		flags="${flags},fullmesh"
 		addr_nr_ns2=${addr_nr_ns2:9}
@@ -938,7 +929,6 @@ do_transfer()
 		local counter=2
 		local add_nr_ns1=${addr_nr_ns1}
 		local id=10
-		local tk
 		while [ $add_nr_ns1 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -946,24 +936,7 @@ do_transfer()
 			else
 				addr="10.0.$counter.1"
 			fi
-			if [ $userspace_pm -eq 0 ]; then
-				pm_nl_add_endpoint $ns1 $addr flags signal
-			else
-				tk=$(grep "type:1," "$evts_ns1" |
-				     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
-				sleep 1
-				sp=$(grep "type:10" "$evts_ns1" |
-				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-				da=$(grep "type:10" "$evts_ns1" |
-				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
-				dp=$(grep "type:10" "$evts_ns1" |
-				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
-				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
-				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "::ffff:$addr" \
-							lport $sp rip $da rport $dp token $tk
-			fi
-
+			pm_nl_add_endpoint $ns1 $addr flags signal
 			counter=$((counter + 1))
 			add_nr_ns1=$((add_nr_ns1 - 1))
 			id=$((id + 1))
@@ -1008,7 +981,6 @@ do_transfer()
 		local add_nr_ns2=${addr_nr_ns2}
 		local counter=3
 		local id=20
-		local tk da dp sp
 		while [ $add_nr_ns2 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -1016,21 +988,7 @@ do_transfer()
 			else
 				addr="10.0.$counter.2"
 			fi
-			if [ $userspace_pm -eq 0 ]; then
-				pm_nl_add_endpoint $ns2 $addr flags $flags
-			else
-				tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-				da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
-				dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-				ip netns exec ${connector_ns} ./pm_nl_ctl csf lip $addr lid $id \
-									rip $da rport $dp token $tk
-				sleep 1
-				sp=$(grep "type:10" "$evts_ns2" |
-				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id
-				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
-									rip $da rport $dp token $tk
-			fi
+			pm_nl_add_endpoint $ns2 $addr flags $flags
 			counter=$((counter + 1))
 			add_nr_ns2=$((add_nr_ns2 - 1))
 			id=$((id + 1))
@@ -3210,6 +3168,65 @@ fail_tests()
 	fi
 }
 
+userspace_pm_add_addr()
+{
+	local addr=$1
+	local id=$2
+	local tk
+
+	tk=$(grep "type:1," "$evts_ns1" |
+	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
+	ip netns exec $ns1 ./pm_nl_ctl ann $addr token $tk id $id
+}
+
+userspace_pm_rm_addr()
+{
+	local addr=$1
+	local id=$2
+	local tk sp da dp
+
+	tk=$(grep "type:1," "$evts_ns1" |
+	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
+	sp=$(grep "type:10" "$evts_ns1" |
+	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	da=$(grep "type:10" "$evts_ns1" |
+	     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+	dp=$(grep "type:10" "$evts_ns1" |
+	     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
+	ip netns exec $ns1 ./pm_nl_ctl rem token $tk id $id
+	ip netns exec $ns1 ./pm_nl_ctl dsf lip "::ffff:$addr" \
+				lport $sp rip $da rport $dp token $tk
+}
+
+userspace_pm_add_sf()
+{
+	local addr=$1
+	local id=$2
+	local tk da dp
+
+	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
+	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+	ip netns exec $ns2 ./pm_nl_ctl csf lip $addr lid $id \
+				rip $da rport $dp token $tk
+}
+
+userspace_pm_rm_sf()
+{
+	local addr=$1
+	local id=$2
+	local tk da dp sp
+
+	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
+	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+	sp=$(grep "type:10" "$evts_ns2" |
+	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	ip netns exec $ns2 ./pm_nl_ctl rem token $tk id $id
+	ip netns exec $ns2 ./pm_nl_ctl dsf lip $addr lport $sp \
+				rip $da rport $dp token $tk
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -3288,11 +3305,18 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr 10.0.2.1 10
+		sleep 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		userspace_pm_rm_addr 10.0.2.1 10
+		wait_rm_addr $ns1 1
 		chk_rm_nr 1 1 invert
 		kill_events_pids
+		wait $tests_pid
 	fi
 
 	# userspace pm create destroy subflow
@@ -3300,10 +3324,16 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		userspace_pm_add_sf 10.0.3.2 20
+		sleep 1
 		chk_join_nr 1 1 1
+		userspace_pm_rm_sf 10.0.3.2 20
 		chk_rm_nr 1 1
 		kill_events_pids
+		wait $tests_pid
 	fi
 }
 
-- 
2.35.3

