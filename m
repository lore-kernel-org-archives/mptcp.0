Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2076.outbound.protection.outlook.com [40.107.247.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41721FBA
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 08:59:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNBnH6lMoitmqDuw3awDkjnOYNCcI9GuFL5LkqihOTPfAruFDxvOkSscPxsU9nTg4TDKVwJdFauRJuyM5GjaXdYfFbqkumULwcuHFZ1JUeXK/FF0L5ie7b3OX0MBigG3WaE6JZlGjHwIIOx1WwW/XvlrgFCuWAsLBQMx1Xcm9KGy1cJIQ2uvfBEJDuXYsSqXY+xsp6knTM3mzx7Cv+qulLJ3MmRDNvOCUMSzDvFxlnoNxdkDeuBj7RAJJdtHVhFRGeufeRdUa+BMb1q8HqdR/7TAYCKfjoT5yGNjyQAdF2XJcZXIh5QQKDxT20VIk6oSvWtCLd7A/1dLpzjnt97cXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1k7+1DUoz+ObFyp6Y8sVXFvhhgqnMjvT57sJoqgIW0=;
 b=oSB06F5+CxmFHmZs2LI/WviuIpqlhK21Dfu1FLJx+ChV+AsMvx18qJQ7YHKUdAB+acV+SHqe2KIReJ53VcCvuEDtI2HtzSN59VJy2WluUnWy94eyqWy91ntP3x7ahFaaACgvYdxSBJYr36RmxEjE3BlJ6gQfX616uc0DO56Iy2jjA3cae/mlEwsejLEg76BMRr4U5tRLy9NpTRpiqx+afgQGIQOd+cgq6p7mreaabc22disKxVn/6gJ5DxLwkJPtSuZxHau8UKS2AEaIXSZgzxdPAdaNmTOejSs2mTxjkjsUig4BlmIBbWhwfABg/YPgIh0tj8eUbuAPnyVOPEcepQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1k7+1DUoz+ObFyp6Y8sVXFvhhgqnMjvT57sJoqgIW0=;
 b=nTOnjb5aRTzu58CDGwDYAqQZjXnQcZ/7QsJG40Eo+0VU5xTYtMhOVHx562myYOLZr3a9uOZP53dg1jwQmHORiUnIksjfW5f/H4AovnehNP210SSE/SReLEsIce805QU7hma6bODBuU7DS5kuC9xMYfiymBx0VgLruNGgLX7GVgXLtPWwxv9Sv3ojcM/V31QpY5rpKITKlWFqSrYpAYFcvZoJtqwVUMqjuxm9NAEqCGpWLkQ6WI8tooUnaemrpYSbpKvL2d72M+3Saw4GDVVzfZt8rffmYGHBnPfcY9g6Oc8nbNbq/g+vek73Oi1/SBCCcyaVy+NI/n03Mqwu2t6VJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7902.eurprd04.prod.outlook.com (2603:10a6:102:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 08:59:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 08:59:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 3/7] selftests: mptcp: test userspace pm out of transfer
Date: Wed, 31 May 2023 16:58:52 +0800
Message-Id: <afd8f08766de7ccde5f6088f23c09e174d288c34.1685523463.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685523463.git.geliang.tang@suse.com>
References: <cover.1685523463.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f079e0-c5e1-46a2-7631-08db61b55636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7Mw8wkP3O4rOokQgjCA45oSJIHtPkrPINJBb8vKNSgnePhzsvLnDtPfpTHruYIGpKeCKqBtYU4jodTB7eNp45TmzxQIBJi+n3pXNz2lXrpKsiYa7kMGiT0Hyn6iV1I0UaL5TEgMW7ciYCEvsVRiRJnC0w29u9SyuXD/MT4OoeaEeX+XDmMHpDs9khxdPm9VhldkM+TZCnAdZT66LcP/aoZPw4h2OnalZ6Lghv/xkjcheWwlJ+xl6L09yVYY7Ds9cOY528nLfAWs0edx1XSSB7cmk93PMVU91fPWL0DSscHhof+EwEnHjhj9TihTjnh3pEI7Nv7CpR9gBDH+St58cwg5S9icl+HYDqIfQLHV0b2YV4TQOhCL8/XaMr7l+0n7UsJ/w4RSisM6ZNVob1GPpCfmGsgLNHxA7JbW1C541wPGO6jIhUKzmt/ktynGQacq7QNsXx5ne10J7ci0BI0sQni8l+iqDxU4B2eS5E+TOaESr5MSwlbvBc0iLjzagDqo29hctfuslso+uJRodd0sbKfzDj6iUYbHS+aXbUZxc4tWfxicgA+bZzAl/uUwisCB9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(107886003)(2616005)(38100700002)(186003)(41300700001)(83380400001)(26005)(6506007)(6486002)(6512007)(6666004)(478600001)(4326008)(6916009)(66476007)(66946007)(316002)(5660300002)(66556008)(8676002)(8936002)(44832011)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GJ/ujyBTUGEtNRG+Y388a2KUyCs5so/9aLAJiT1Qwwb+ZraqyixwDHAH6ZCF?=
 =?us-ascii?Q?o6ZoyUN+8kkgeQAD1TgwiN//AdakIkDMQC/JCfl7FzMIYtHd040mt2Z0uBsr?=
 =?us-ascii?Q?c4C0jQkwGRsy2D7ViThB3vui4HL7k7NsbHreacgSlDVbaiFSwfOaHtSYIwpL?=
 =?us-ascii?Q?QsAJ8iml/vvV1R9MaWhh4i8zv0uITNMkiC45mRRBoJRst6ruyGvQFC24RAAj?=
 =?us-ascii?Q?iMaL5lITQv23JZRonT79AD7CNve2m/WQQs81+G8xrI/fKfdIa/wnw/NE1ii1?=
 =?us-ascii?Q?CfAup2PTczRZdIq5jX3K1Ak6KGGpNTVPlFMdug0Gh/H1wfk8I3LxHggFtAX6?=
 =?us-ascii?Q?+yoeYn6iG+b2TnsfY8VkyCHbX9YAmJ2+geWAAy+J3Wounf6FNe3THcK4QY8d?=
 =?us-ascii?Q?7+JbDhnArmtdiiiDoF1c/Yf9OntBqgacPsL1ORiTwo7jzQy+/7zfiJjtr9ac?=
 =?us-ascii?Q?loEou0HRew+3j0ftg2bnK8d2p/Hx6xqME9fvnGlpqAivbLEWaqgWG+84SPlW?=
 =?us-ascii?Q?ayI94D1GJToObkV0xFSMMasRjFCPAOF0apcHkiNAnTsG91COEdHXlmREm2jF?=
 =?us-ascii?Q?jbSzH9Ur+/QO51LbhwYYOn2IitLdb9Wpyq699lVp+Yd5zY8F/AWHZa5BSP4P?=
 =?us-ascii?Q?Gxfnc3axJMBcQjvrsHr3udQJUuPlGUM4WjPL7JmblDi7aYuX3EuXTBbqhx5l?=
 =?us-ascii?Q?ZoqT6fFaAsmv5vuz5ICPO3kGfZSs5qg/jmbrw/PXkhu7KdaBpcRxSNxrQjjK?=
 =?us-ascii?Q?ffbus28KFOO3J0prP+yYZ4fG3b6CP+mGkSTKeBIg5Nnexl1cvbMqcGBhYAp1?=
 =?us-ascii?Q?ltMXsiOsEEKC/uPtmBGpJxKdRUyQf3y0tyH164vJujqHS/KVThxjmuAyPMvc?=
 =?us-ascii?Q?oE3r9K11nJ8xpkPA+VoP6tDpBP1tywDYDCd1P+K5rzPmI7r4t9KDPcZMPGmm?=
 =?us-ascii?Q?sJsuOygka1hdQma1RD70/ktKWxtYllM3LYUrWbgam1vQldRibj228pHu7QfX?=
 =?us-ascii?Q?0lrJsa1DUyWT+vKUeNAif5FzZxd7cFlW5rh/+KWMKrnNtNfnk094KHdI2Hc1?=
 =?us-ascii?Q?MKGKOkpcaSS6R5e6LT7bePaHKOFTW3RQFlUVe5NOn+T4e43NWKSq+QfXMEIU?=
 =?us-ascii?Q?TizpR3+L2NsFEhWxjlNBdS6qmaaPODBm6JFlGI0yByj2CBbeEBiPP1Za3Kix?=
 =?us-ascii?Q?3C0PMQLrnnXm3b0dyblHvdLL1Kp/SLGio15DM1k6fFBKcUCpwaKCSIt3ApMi?=
 =?us-ascii?Q?9GaWf03l6Vz0H1vbLn0cI28ZUBvvq8vdh+2A6fzs/L9Qyy5OezUAsXO0Yodz?=
 =?us-ascii?Q?U+8OLDWqdTcMgFZD1ssVkBzuyn1nt1WEBug+0i7vZE/ZUvBvEkiXBc0GY/on?=
 =?us-ascii?Q?4+QRBQYaYaSpdA42XXrDCYfKK84hDBnPVEHWLxxSornPjty2HywybCw0ipoA?=
 =?us-ascii?Q?S6ZW6d2OyNj/WDAV7AsmI8sXoOIywnFoPyIDgFF2jxAs2ttvsgD7V+LpBMo/?=
 =?us-ascii?Q?QMiSNWCBy2DnvAZTcNbOgq8rtM2+szpLVy5+XNxe+YdFUHTpK/Aw0es11ezM?=
 =?us-ascii?Q?gXYyLfdGl/7skkPC68RDSt6J36myEBEfZpzggBgj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f079e0-c5e1-46a2-7631-08db61b55636
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 08:59:26.8288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCv5xIkZx6smaKXNYvsky4qaDBbJH1iaTyT4FB7CW1QErtm1jp725GOe3g+ZojpmQO8j2Ydl4qhziDcSpXRR8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7902

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

