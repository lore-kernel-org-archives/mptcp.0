Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2071.outbound.protection.outlook.com [40.107.6.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBD97488
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 11:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+CkHn50PcV9wG/H/lSlwwNNfMIPZPBy7yh9mDkPWLRVk2TmKsObYHXBVP0gZf8rklw1zRz8Pa/CZd9JdPAnLEnlORTt304gtstYkGsSNJpkt4PVMY+YjZ0AxVvRqenbXLuuh+SXA7m5tyMLoSWqXSaMshZpDui8Uak4nIiTGwhbn0sM+ZkvhrFEENbqBPcCmy/DMUOWLjVBNh12K2UXsWpv1tmtw2ZBayYNxjddyrNg6InsMmOi2dpNQmCzk27oJJ+LgfZ3pAaEDX3yV4W1mfLKwiD2FMgs/CzYDmt3YH4nW7TwEfHYhTYKptPgzYr23XqigTI44D01ooe+iiAZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDlzvK2Km7uJkL8+hWnpmZ4RNEmkYMjIlonW7jad778=;
 b=YNuogMBbSZOj+CdCFbPwvfN680LkN1J6RMVl25B1bpvK8/p4pF4MNrEoNfRJu85N/Ib7qZPYapC29Jx9jshtdiNF9wQ2UkS/DR5UHu9wLfBsbu9NN5S9lP56oDDfzc8n+10JN9wPYMgGGfMwdKq6937xFWnYDm8dxM3KUFb5bmeG/hegQwQWA7fMmpqnGvvlRkm8HFvWaR0rDOb8ULrGmPJzYc4KIpWX+oLo+aJK9pwAObWYFS6Fm13KXI3fSU2pC+Rr999zchjzYOkeuJoze1W4BOiRqNjxm+AsWjZ7B6KI3CdjbHLojEIK8RpRh7j1+TIoUa4VTs3aRpcLFK2ObA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDlzvK2Km7uJkL8+hWnpmZ4RNEmkYMjIlonW7jad778=;
 b=vjluEpSoqJvHwCvt5EilwkT0VSCiYGzpuJDG6yuDpY58zhQrb2q7j4jwZSXBMIglxEmEA4GUrKFA1azrB6aAHCCusm4aVQ1BPC32t7/mmeNtIkmjZLlrMsIQt1o0NPgK6jCKoNUdxlSrVy9VoJjeepTb8BXQrvhWGSZ+lnUTeIvjQ4ZqbZPuZsGP6dfdtEqleAug7PvEqTtltM5q6cWhZ+pWXk3iONKIvvMi8RTXtTH9N+1c9u7Qer+Sgvp4jwXN9A4uAEuse0gaj7wNYa28rn2gB+Kim5Wh0MZdaeiRbfQGLQCoa9XIVH9Mj8QpgL2hTxPBTsGLVoUJIE52u+vOhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8281.eurprd04.prod.outlook.com (2603:10a6:10:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 11:45:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 11:45:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 2/7] selftests: mptcp: test userspace pm out of transfer
Date: Wed,  7 Jun 2023 19:44:21 +0800
Message-Id: <262e128b23aa36756b7c1957daf6316c64ac014c.1686138130.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686138130.git.geliang.tang@suse.com>
References: <cover.1686138130.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 561ef5ce-70f9-48a7-6897-08db674cb18f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bgOWxxbZ0cyXw0CHaaot8UtnqfSqn5esuky9Ip+p7Q7x4LtkKkMPNeIUvasDpeldDK4E6ujgWoNYjngksVsmtdgDqU2VFVR82uGsGIt1l277rHILOp1BfomVSrcZzESAnBXvs9OtmQgDWGDLWk2lJbrzUTFq86ZVJPM5j/Ds3sZgYGI640EJcSJxR9UqmnbDIGazo2lknkiyC0xoWbFEr8LGY7jcvcFKmAdB6txdArPzLA4xwrY5Ese812jyfGXOFIcC7MpN0l803qH3uHK4WNmc9m5JLJD1Haoo/RjJ4KTqh3cemA1RV44DeDmO9sgoQROLUND05nzbq+NHtjrM9iximgnKzLC78IPCjSIlybfXj9QY/w+saEYhk7BboyrVe2ntzzW5AsXqYhst4SRXztN8LUAU0bY0eDCFkVEaqjNHyGMWVrw5xYy3Y9G4qjmwbYdztH4BPFondWCd5plKymLLUWPcypcAAKSzH7aReMIct11Qq7/O+RV10+b7zevLkJroudcJqiZ977xFtiVsYvKypbyav7MO85pL9564y16HwYhbaDD5//rsO95OfywY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(107886003)(6512007)(6506007)(38100700002)(2616005)(41300700001)(6486002)(6666004)(186003)(26005)(83380400001)(478600001)(66556008)(6916009)(66476007)(66946007)(316002)(2906002)(8676002)(8936002)(5660300002)(4326008)(44832011)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pQ++1B7ftDUgrhP1jwXc7rHSrVvBpDSJ3FDWnmh57goa+/69TIrQ0wKyddJE?=
 =?us-ascii?Q?WiRsP45sIffHdJhZC2HqzGIvMUG30ZiLZEYV1RFzqcqzD7Gp2GmGPq6xbo1Y?=
 =?us-ascii?Q?aw7bZdFw8d3iwTn5L+GL43Be5O9c+a2eC5UkkDTmJ4n16ykB7Kvto57XFSrH?=
 =?us-ascii?Q?UrANKTLgmxOdcrR2GJt+ActJxHBPnRjEMpMCbr63Ki8Z4PS+T+6WZ4w4ZpV6?=
 =?us-ascii?Q?8YMBNnHA3e30yYEKpOFumGBQXb1F+/P++scgZ2lHr7xYtdCPkCX7aJaCxriq?=
 =?us-ascii?Q?jEceq4IlEMTpVDCpa9UeFyS20sUHmlex6UrxZHfVfNvmlBl4d1aCOI1NB9YF?=
 =?us-ascii?Q?2H36eP1+sJOqqKl6bW/7D0nTyvkOk7mMdH7Bh7nfo8M+uJioGaiLG/d3K1z6?=
 =?us-ascii?Q?2LwFaqoYxzVjp9zLSNhNb1D1cHbBtpYZBT80bASZ4DlfWhr3JNkGE1cZNT4/?=
 =?us-ascii?Q?q8JqeEmhL1o/9O5ujV5/Pp6dP4pR5WyIuSyfo2UB4XFf6TjczTDo8Eo6LpSk?=
 =?us-ascii?Q?UVuySjCluE9vlLCvmhJDee2qSHbNFamiKVsjh7Mm3qfatKYSvDmxmC7w2lYg?=
 =?us-ascii?Q?81MpNQm+izCBrxlIOXWExzKwka0mpMSgkRDaYg3wvt3ybqn2YF10TMzgKy5k?=
 =?us-ascii?Q?LWBxfi+XjeyNiLMz9VOZA9ivjtqLcd4UN5+XN35USpyeVlXXALdCogTi+PCH?=
 =?us-ascii?Q?q1kqzj3NITBrJjSHgEaVp/CdAnbRp/lhGTlHw2CdbQRuBhqN//0CyDPJslWR?=
 =?us-ascii?Q?lRDcUg0kMkxdIrda8gq2ESolntru7Z/BXRHJ9liTqUJApX2TDCz0XtK8/VNv?=
 =?us-ascii?Q?U7MpmxZ32iJc9XLeWlCnOcfF3qhn/1FHKKl0gj/WiNJBJi3cVMSqENiwVAYd?=
 =?us-ascii?Q?mv/NEedDPgTVRdPRclcipHsmKNmkkewScTCpJzXHGVQTgNjk3HY732zw7DDA?=
 =?us-ascii?Q?Ly3eiFeU7CIn/P292SEJEk22qveBCYIRQLE+cy85XmevCvHJHKAlv+S8B073?=
 =?us-ascii?Q?1CzcidO5fM3IzHUFyqB5WT/l8F0dM1vy4MKK7w0K7GaRI9FyrdB3TNcdwbAg?=
 =?us-ascii?Q?jmmy2GKwtKyceIbJHuDAh3k+r45UupGebfpzBH7c9KucYQj3rt3nbEVZp9JK?=
 =?us-ascii?Q?qtPmVHDLR8C1aMbBYbko4vcfLl0ZYK+4s2e/ZL81K5dcX7f3j0vzSLF0Ual5?=
 =?us-ascii?Q?yjzKBAGOXwxEF3OHJgmlRZ6YP96gLADmYD4BYfRH14IPIL2iOMZ6roTRuHVA?=
 =?us-ascii?Q?QiwAGZAp37CsxW4LT+eDcvOpyajo70pUWJg6Jqsh/J7Yo7PqRqU2M9Yx9maW?=
 =?us-ascii?Q?F05wdgUHj1qNCP8lv87lsiSdAjNeKWLiLmFA+yJD6hBdxHEKaS/hq845Gogi?=
 =?us-ascii?Q?bdeQilVPNQN6ZRG9IpuuEhiAtEFTi7FnzXGVS5zwVNLGdYsK/R6WPaPwioBt?=
 =?us-ascii?Q?w+js7Jv00OyAuJCXTsNYVB1vfEt7mItcn3FVmqa08n5EK2jijt564iqU715D?=
 =?us-ascii?Q?OXts77/YJ1vbQJioTdSiprzcBhtx9PhrnphNUeWxlgPOtKbLTAB9jLl4U5Xj?=
 =?us-ascii?Q?o91rPMBylLnfT+1KjW09rjbYl+4yW31xU0MdkT5+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561ef5ce-70f9-48a7-6897-08db674cb18f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 11:45:30.0204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5RS2WEjzya1JR7eC/F5tSw9RqW2g1fdqpUvmc30Gmq1rcvWL4JHO5dutUhPiLsYubn2yZjVOZ8GIoDVKjpEyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8281

This patch moves userspace pm tests out of do_transfer(). Move add
addrese test into a new function userspace_pm_add_addr(), and remove
address test into userspace_pm_rm_addr(). Move add subflow test into
userspace_pm_add_sf() and remove subflow into userspace_pm_rm_sf().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 123 +++++++++++-------
 1 file changed, 77 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a7973d6a40a0..6684a60dad50 100755
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
@@ -3205,6 +3163,65 @@ fail_tests()
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
@@ -3283,11 +3300,18 @@ userspace_tests()
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
@@ -3295,10 +3319,17 @@ userspace_tests()
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
+		wait_rm_addr $ns2 1
 		chk_rm_nr 1 1
 		kill_events_pids
+		wait $tests_pid
 	fi
 }
 
-- 
2.35.3

