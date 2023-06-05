Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2075.outbound.protection.outlook.com [40.107.15.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A933611C97
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 08:18:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mg8ou2Lc2zYTqY1krrF7s27DI6Wo7HjwepaB7+lCIAr9C5P4r2DQd6JMTxrd5aGvkKdco1U2YkZ19a1tAnQavKkHGmlCWDNCha2E0maaONkIQI5L/X3/hmUzBagwtSAyLDPdY1diSFY9/0QiOdb7wW8CqoGhzpGOQqNGlpbuzQRlxjyqvlHREDKCYmC6zlMnnEIPZ2YMyYk+hyWze4l5k92MNacyQ/SqOAUulJt7XvAk5sL8RcRfc4eI1kNHr9tB2g3w12cCyZQ5IyJb/PHB6srEl7rZslTez1ESa63+XWvlfDuOZ3xKJJeIxfK7nkSNGPURI1sgvzOdiEpACzCC+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xzMH36KZku9gdo444aNWwsXDsrUEf4tqmh6TKrX8WM=;
 b=TgDfruAZzeZsYm35RAVOx5leMv0D/qKrsJm5q6j5JXeXxXKSyv0a3BrImYR+kwFawuqbrKbTn9Jg+45wKXDJN9J9JhoPxXOlS3PHNog9XQQ+VTubvloBQK8DGDE3x5vVqsgsg35Gumg3hR5hOePLeckfQGunN30TMCFYc+7L24Te9iqyi665O7s++d2XjA7uuq9YZj4eYMgfH+upRvjt62A/fRVVMI3jWjnSKkpLzcscsaUnmrduZKU1ktR8tt4f1E+i2t9hd4j1g+6DbK8jSwi2wVD/D9zDiu2uHLDpVl4IQ+fhxB87GBNfOASwGOy69I+kCDlgOfjk7ilynHKycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xzMH36KZku9gdo444aNWwsXDsrUEf4tqmh6TKrX8WM=;
 b=gSTbF6SHQR9cGPuKxYSShoQmKpe1zZ9Xb5T3VE5VDgYUqEFB90DJms2C/46QrpC+k0h7Z7ZreG4Asw6QBVtu/FZSWambBF40KxJaGphoOVMJjQfhhC4qgFrm99cQUtQN5PF6kSw6WQEmQsVXRVknh6G9qG6/8fzjxz4WrQOj/oCOwDGQk9O36WlUImlAN5yU0mzMAvxFqkslvDZQV00qvCrXHvklSkddz5KpUNaI6+YoHL5AgrLiqIqOtLBoUcJseHHPqUX8hhdOogjA6qsjGvUOIffsFnTEfIG0YSE85fOLzyoupTmB+OM01eRx6L70L8MUf+HB/pzCn4Pldlvomw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8799.eurprd04.prod.outlook.com (2603:10a6:102:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 08:18:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 08:18:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 2/5] selftests: mptcp: test userspace pm out of transfer
Date: Mon,  5 Jun 2023 16:18:05 +0800
Message-Id: <d10bdb42a1673d15cfb45c23ede2a72a32a460ec.1685952776.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685952776.git.geliang.tang@suse.com>
References: <cover.1685952776.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd0f521-4858-412e-37d3-08db659d6c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gm+CNHdPu/2dcBzV2sa5OFKIA/YQuSYayMAWHlXa89I/oDnVJjVHPUhCmOUUi43vAmYlHWQXaZYwcKHc2taIC6U1vYG0A8sG55DiGIFNbBac2vTCXXAlcOMvhRDQoxNy7ICI+k6aK0nZJA6//ZJtWgeR+ABhrovImuOYs3mb8tT+ZGhZsQdtt4Iq2VUUsCWr+yYsVZ5b4TIMUQGE3BXmQMkQjKihFCKZ/+SorcaK569ghIpuYXtPRwrZREqxr5j9ot3r0/bRrfCG20A5O4YM+NlNxh4JZNEKhdW1Vzg2CO2Yw/ixwYmSy0kXWHOVaYc8DiHpDnri/S3HKLuGiiYlh3Lbdr7cXAJsn5RTH1IPSqQ25wKcaV3Tg7pv2gvAyu61kQPIrarDxpCSGJabsn1qhKDZORKPWtkTJF5Ss82WTCJYceQqLRRaHydL/IR8dkkZxOzuxMJlpiv0mWQjs4y/gnGNK3qlWVYgNrg76eatgV6Hm/tiN1PyYgZYOpzvlBf7OeWpnjgLd8BfvTTvshnMaYQHB+WUfwSAttwDNqfW8Ll9bilRBNBhq7Cu6hFWSsbP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(478600001)(6916009)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(38100700002)(41300700001)(2616005)(186003)(83380400001)(6666004)(6486002)(107886003)(6512007)(26005)(6506007)(86362001)(44832011)(5660300002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IR1v43H5fzmyJsXcMTTPSDmuryI+BVspvtdWEtCQpPT0W3ytn1o5YiyG/kCi?=
 =?us-ascii?Q?jB4rwqnZBpJX4saEKAtzCEtqlZl2ZiHDGS1H9AdvWhECGyqVQZZ26XB8XW2R?=
 =?us-ascii?Q?bo98SZ9cHz1ElNS0glIsanuLuJ7cfsw0dxPg80gFpTr6cpK6wW/Xbc/1EnM5?=
 =?us-ascii?Q?IHRTuPc83flZTrbB31SMEP+Q7bjfw0BhTTSQH8wSn1I4WrlfmYz7cuZwOYZQ?=
 =?us-ascii?Q?nt9Kk48REalRXl4inCJGMi69dkQMwNUbu4UMouMuQ//+w5Xxs0W4/9newOz+?=
 =?us-ascii?Q?g8Bkvcg82eH1KtdJ97m2IoPFFklkBnRmQbeFvGQGjwO3lMzF/MxLiCruG1ZY?=
 =?us-ascii?Q?wsorQ/MSqRYjs4qmQdxMotFzNFLLaTdjI8NQyBkAyDr+hZKpWEBWqBB1g2+k?=
 =?us-ascii?Q?SoJ2I5+7MhtBfVFgyAYPH93Opx7nqMnar2FdcSkq5rLCtEb4zlKdxKOkWLu0?=
 =?us-ascii?Q?CKCgBiZKjPFdJ9hMlNp1PL7hSdaIdkKBeSmnw7XR94tkVJgpIBDk1tCxhLG6?=
 =?us-ascii?Q?JyfvkNY4O72f5gR82idGecUKSkI1SRlcSraStR78tu6K6knydK3NR04oi1zB?=
 =?us-ascii?Q?BBFA2fewPw8DJ7B/rR/28lV1vdukLlPM/5ZtR7/WpxX19bquUkcSqC36BDc5?=
 =?us-ascii?Q?oGxu1qxZDr5wEKku1YZTQFDQQn24VwDrOauj1onAre7RdPd9GcmZ9TkItDKe?=
 =?us-ascii?Q?Kk1HiSl3VecrcfdoOssiMO4BqfAqbLgSfEfuRpOIiPgksYtc7DyDuIASF1cC?=
 =?us-ascii?Q?BuHDqujr9pbS2lw8h3TIHPpt8GwxISE6YOsjSCqv6HF+93GsjPY1nTY7LdIe?=
 =?us-ascii?Q?f4EaN0Iz3XCAPDBMBVmS/R30WwvI2+K93i4gVS6O49t/iWb9YPpspuEOzAJv?=
 =?us-ascii?Q?iRNoJ4MISpE04L4qiVSBWzGPcy6JGuLLNv4pVAqnyODQ3Qg3VpiwvSudbg8D?=
 =?us-ascii?Q?LSsqWBV60iR4Btthk0GTeXswRi5Cy9rCxLhYiOIYmpuFU2PNHXfPOGi8YwI3?=
 =?us-ascii?Q?eng3c/2lYqcrEeju9jCsBWVVCfnrxwLWTUMowficZYUQXy2yOmQdDziLOFaP?=
 =?us-ascii?Q?boQ4hp07v+ruSpNORexWZa1T+99pIeKVJQ5RjYUE/KIZtKocEhJzsbChe8M+?=
 =?us-ascii?Q?tPqDl6uxa9+SfQbzMPn0zrd7I1L2sDu9snmSizmrGu+vLWXtJbY+/TYEv211?=
 =?us-ascii?Q?wgKUnvdVZu4eoTsGTAurlLA6nvPLsYXuRNIX66cR7B7GHtEim1ipXjRJi3wc?=
 =?us-ascii?Q?CKzsMK3oH9uqf31YLNcw2ZxWj57A1DkTsdljJasvrMkVf52Ts14zNGNqdvPG?=
 =?us-ascii?Q?DKdoAx/H9N+9df8uRURtMENOxG7y0Cbe24vEszCLxejeIVP9+ZPzM1V/0gfk?=
 =?us-ascii?Q?gU8nJMGnXNzRrEHPapyY1PNONO0uiLPU+V/Kpk8MlGMDSr94jBgI6hspHald?=
 =?us-ascii?Q?I+XGc1IQvaKfjKhudhRVqbtl48hsONZI87zG61SM60O8CdeLLdI3I2CZUB94?=
 =?us-ascii?Q?/q/YqzfHGXtMBQdmVIFajL/P1Dl5/Ltmj2ZhLzoN72NzqLxC3enpj/l8hGaV?=
 =?us-ascii?Q?STtuUtiHYGo9PKTL54hoX/i9MstP4PZoRsqOrfBx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd0f521-4858-412e-37d3-08db659d6c56
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 08:18:20.8363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymmdH30JyzZzK8jaOXSNe6+++lY3aVEUAznO/kRw87H2WOy1jNBB4mF7GsLfR9ngNesMRzalt+mNtzP9nBKMzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8799

This patch moves userspace pm tests out of do_transfer(). Move add
addrese test into a new function userspace_pm_add_addr(), and remove
address test into userspace_pm_rm_addr(). Move add subflow test into
userspace_pm_add_sf() and remove subflow into userspace_pm_rm_sf().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 123 +++++++++++-------
 1 file changed, 77 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 85474e029784..5fb67399c00d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -727,7 +727,6 @@ do_transfer()
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
-	local userspace_pm=0
 
 	:> "$cout"
 	:> "$sout"
@@ -764,11 +763,6 @@ do_transfer()
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
@@ -796,9 +790,6 @@ do_transfer()
 			return 1
 		fi
 		addr_nr_ns2=0
-	elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
-		userspace_pm=1
-		addr_nr_ns2=${addr_nr_ns2:10}
 	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
 		flags="${flags},fullmesh"
 		addr_nr_ns2=${addr_nr_ns2:9}
@@ -852,7 +843,6 @@ do_transfer()
 		local counter=2
 		local add_nr_ns1=${addr_nr_ns1}
 		local id=10
-		local tk
 		while [ $add_nr_ns1 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -860,24 +850,7 @@ do_transfer()
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
@@ -922,7 +895,6 @@ do_transfer()
 		local add_nr_ns2=${addr_nr_ns2}
 		local counter=3
 		local id=20
-		local tk da dp sp
 		while [ $add_nr_ns2 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -930,21 +902,7 @@ do_transfer()
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
@@ -3073,6 +3031,65 @@ fail_tests()
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
@@ -3144,21 +3161,35 @@ userspace_tests()
 	if reset_with_events "userspace pm add & remove address"; then
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
 	if reset_with_events "userspace pm create destroy subflow"; then
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

