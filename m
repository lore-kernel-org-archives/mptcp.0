Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2045.outbound.protection.outlook.com [40.107.6.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991161FD6
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 05:32:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ht413v3/rDgDrlqYoC4puNzkTghHca6VIyKEPPbsbX0nbAhkr1CugIqyKdsPsIH6oWFM9mU2c2DiKMi1t6RqY9R3EHT5FTKGCLDUKjrdriKVfP0Wrv27I+aqNQE+lpiDy5S90xippq5xAxkiIrrF/Zb4YrjZjnRvrxKy+SCVd6+52oCRPIfseKlxmhgM830+MjArDVBuNPs1/ZnRMYrfRFlTVihspMaKwjeL3UyJzQ8clsp99vtG8kpAHkbGeI/qjUl4IGpwcrRC1R4PPvx8FRvAVSmjRMCLdSHK/vLHfG+pd646BEtRnHNpd0ovo80z2jNnlVPwVm/SsmFoK92qVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0MsODbHF4hJccdLIrllByj0rSIagnxB5b8D70tzx40=;
 b=N5A4/D3NHff1n8MSntxYvCs7oEMzZUx9CYApb3oJIYQjjXna2TjR5PYImP7AWK6DHapRJnmKaTCLSbpMx9gCMvZAt6bukZtUEfI2S/CTNCLULiy06EveNJstyBkFnD0eCEj5rscvzl6Zm2GlGHouXnCKNbxh5b+NTY1kaNYLcjUhVUelCBCx7rG0hA9HNnNi2dzhQWaXuTCUzBVjn4l5YeBQA4wxLq+Yfsc6yfT/Q1XquDuG4NqtJf4dVlg3SalnTQgYz8gYzAuFBukdx6V4RudzadHPQvFc0ZwmOFUc/3yjZhiO1xTJJKeE2LTp0itiV9IZ9HebML3d42Zxtw+i6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0MsODbHF4hJccdLIrllByj0rSIagnxB5b8D70tzx40=;
 b=L340Zaz6vRlyfMng63rABSyfmyJqM67qJXSPke0GX5D1mbW9GnpFdxus147VZhHEthdhFO7ONTut9d+6DVxveKDYUPpMo5GliBPg1+4ACws8TsW5ZR6ORZgjIyY/K9xGuqI8wzkt/2DOR5yqZ2k0qef7e+Tu7nxScOQcOu3++bCVCgnsE2KH3aSJx6wvQgj4z2tsronhm3VyxXZgmPRar/wXlObZnjfM4szdjZVb3lR70X6UuYURLEYZwUMXJQwo04S3wHUaAIk4KYvuUCjdXwlsK+8lMtY1xIOQez3SfbyNYnamzys+axdOwjlUxw19SQTlKYJnod5WDd0a98oyJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7642.eurprd04.prod.outlook.com (2603:10a6:10:207::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 05:32:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 05:32:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 8/8] selftests: mptcp: add pm_nl_set_endpoint helper
Date: Tue, 13 Jun 2023 13:31:15 +0800
Message-Id: <3787039ef2a3501d890221740d2118d585eda436.1686634037.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686634037.git.geliang.tang@suse.com>
References: <cover.1686634037.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c691803-827d-4631-ac6a-08db6bcfa2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	neWJ/y9HtywmyGq7NG1DffPyatSY1N52r/jYymvrMoQL5sszhdE3Qa5YPCKzeCBh8fQgZitp06HVL4s8YDTB3kk4lnGvM0RTaUoE1Kqy+TQ5Ud8Idkxkh9Xk/mhqDcrrjTnDcCkSOY5xl0oD2NJOgT1RZXzeEx3S7lBDzDEijhOB1zAzB6vnEFsGKKo9nqNP8ZoZg/DfZCPJBGv0ecyL3caY11lymkSsbpyKAOfYfcIgsyaPaKSmlPePwxQyuNTawDaNaORBYFL2ilezGVraZ00s8r9XJKFYn6BL0IeTIvDgiHSYnMO7HHJ/byWRYiaVitnx+oHMKPl2ectyydIN+cBJw/Q26NkoXXquPioIOoOYbxdAYEUsYdNlnKN6qAPmYsD7AYymo+WR7rZDeq0kIVYZGiwuDk144E3FKp9p2meVzYAYGq2T3H6OTlGX7uH6xflTeqsgTzPk3jgfhN8i5V75b3rmfuxJT8D7cFRrnTWt+hu7kpO846XHySk9CrIEYSWGx9xqWK+u/Jt/2dYSIeH/BMAH9VFx6QtOiV3t2gK6IskUi0ZIn7b0pLQMUfA9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199021)(8936002)(44832011)(8676002)(5660300002)(4326008)(66946007)(6916009)(66476007)(66556008)(316002)(2906002)(41300700001)(6666004)(478600001)(6486002)(107886003)(6506007)(6512007)(36756003)(83380400001)(186003)(2616005)(26005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tvMbBV0dHyURSf1wTKPRO81vdv6szpzTB8qOCKWboDoT8aSGH22W+cMUv5gL?=
 =?us-ascii?Q?tFUYBSDb2sN4rYQCRQPvDfsBvAQbskeWUlVQ4l/n0wNpMo+37eO18qg997zq?=
 =?us-ascii?Q?nASuCgdNVf+7OQArIO8ElyHweTaXyL33ntwyrQ9G773OjhZWZB5AbgPYaPp4?=
 =?us-ascii?Q?Ta0XsXYiQ+/9v/GU72LGZVwXIv2uhxuUnB4MWZ0MCdUWSfjxtodDvzfSFNRX?=
 =?us-ascii?Q?QNRBkwrnG7NpZb7m4VKpQCvz4aQEPHWdhKK+JFZStjNpk3u2DicejOYoqWZr?=
 =?us-ascii?Q?cfGRUWdGKinMoO8ruh4kaud0u3hTmR3TF79gytVl20Xp++jTXAvuuFHU330W?=
 =?us-ascii?Q?P2EhuhJ81tyyxo5H3sECvUdeo4rYC84HMTjHuly5bk6st9lJPO+FzuCsOI4r?=
 =?us-ascii?Q?Ut+Eos/BzMkYRSm8r99cDm6wscsWBuNnHWqdfQ6TlUol2OVab7ob6mjCeiEi?=
 =?us-ascii?Q?htaZBFHV9GJMWGyJ4HtTnWQBfQbw+AfyiiMG+Eghs9NMjD9lQFkF7jCvbIpb?=
 =?us-ascii?Q?44InoZZl4tOzIevtXJi1mqWhkJ5vDLFOwrWE/i0DlqmuU5Kq7ppdqXV1gV3w?=
 =?us-ascii?Q?9YDu9Pzy6s57ASHFb7Q395jrh7BpSrheBUEO8OKOH60uEnVTMjUJNidYd5xd?=
 =?us-ascii?Q?MG+ym6mQJhxsFAs9ya9FGl99bmXWXo+5kpQn91gFvWdf/ZqUsqsK+JS9qiu+?=
 =?us-ascii?Q?4UPGWF/xPURJ2zuBQpgQ5m5M56jbeu/scL5C8CnoIla4O02pNx2ZsBJYxJAa?=
 =?us-ascii?Q?E06Yaxk27z4uuzbgvZvqHqz8vHNoEpEbitecE4jEH1u+GC4GigH6w/qwztnB?=
 =?us-ascii?Q?YigK7w3S3uvPbBFGeYGhZDbsSFKr8B7AQEjjDKvahNV9+bkayqu9zuCK9LrM?=
 =?us-ascii?Q?oYtJSPhV1G9+Gt0FnzFkOpO23dJZ/ATDtN5IOPGsrjAewaExsAmacyOFKB0E?=
 =?us-ascii?Q?a0enQaVPGQG6si5/A4qvHpChx/272Cdb2X4CU+C6W0skrKqnTDN+g1U7tZeX?=
 =?us-ascii?Q?zuApY5ZoTrwkv0CJsUjOWouad3PwQyWrF7IMG7DoZLqxt2AKJgZhrQ52CClJ?=
 =?us-ascii?Q?9kigLC3Azx1GfETQgjpmvI2mAan586u2XHHyiN3FmfpqlVAwGKLBQIre8Q25?=
 =?us-ascii?Q?cvq49YAcRgvy9VX5qhb/PISNVp+wrR5LJGFrdK3Ms0b0bEKJhJXfytbwoDSz?=
 =?us-ascii?Q?hkTa2dMoCpcI0KxRNr5PXI70Sqil4qziSjn4G4qk3sE6s/V6zdF6RFd5iOXk?=
 =?us-ascii?Q?7XkQS25kk5k8XrfND2AVCmM3mhHOrvwkS+01W5J/EwK8W7eHEI7/KhJ3+nCF?=
 =?us-ascii?Q?v+1+gKHxglKI0kQSU0fZjeX7RGmo8jPu0sWkG/jCowbhA4u/bbvkVlsGXwql?=
 =?us-ascii?Q?0o/0dyXLxdAVu507zeBDdOhtrIi6rdGEzkqGY1qCo8giWaHBLldjtr0LUk1K?=
 =?us-ascii?Q?QPeTVXQOLUfbSqri2gchwcwRcfOjmzvq+E4VbYy5IhANhuOXRvs81QEmO7R7?=
 =?us-ascii?Q?bA5c9BLslSaMcVDrr4EdCL6WEci/Om6qnCfrYyEGyKMIAiVACEqbrovsqxpH?=
 =?us-ascii?Q?3xq2Otls369FHSnoqRHtmbZrWLCpGRK1lCb3yXWj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c691803-827d-4631-ac6a-08db6bcfa2b4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 05:32:53.8252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CK9GJAwdIb1gY3i5ublOurF3t5YS5RlcsezsD8COPAyqkXYtogfi5RkT8y3a7nI5KKWzYRYa2of1UJvKo5APA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7642

This patch moves endpoint settings out of do_transfer() into a new
helper pm_nl_set_endpoint(). And invoke this helper in do_transfer().
This makes the code much more clearer.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 235 +++++++++---------
 1 file changed, 122 insertions(+), 113 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 49d0fa5496a2..c3c8471f9ad1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -822,122 +822,11 @@ pm_nl_check_endpoint()
 	fi
 }
 
-do_transfer()
+pm_nl_set_endpoint()
 {
 	local listener_ns="$1"
 	local connector_ns="$2"
-	local cl_proto="$3"
-	local srv_proto="$4"
-	local connect_addr="$5"
-	local speed="$6"
-
-	local port=$((10000 + TEST_COUNT - 1))
-	local cappid
-
-	:> "$cout"
-	:> "$sout"
-	:> "$capout"
-
-	if [ $capture -eq 1 ]; then
-		local capuser
-		if [ -z $SUDO_USER ] ; then
-			capuser=""
-		else
-			capuser="-Z $SUDO_USER"
-		fi
-
-		capfile=$(printf "mp_join-%02u-%s.pcap" "$TEST_COUNT" "${listener_ns}")
-
-		echo "Capturing traffic for test $TEST_COUNT into $capfile"
-		ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuser -w $capfile > "$capout" 2>&1 &
-		cappid=$!
-
-		sleep 1
-	fi
-
-	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
-		nstat -n
-	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
-		nstat -n
-
-	local extra_args
-	if [ $speed = "fast" ]; then
-		extra_args="-j"
-	elif [ $speed = "slow" ]; then
-		extra_args="-r 50"
-	elif [[ $speed = "speed_"* ]]; then
-		extra_args="-r ${speed:6}"
-	fi
-
-	local flags="subflow"
-	local extra_cl_args=""
-	local extra_srv_args=""
-	local trunc_size=""
-	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
-		if [ ${test_linkfail} -le 1 ]; then
-			echo "fastclose tests need test_linkfail argument"
-			fail_test
-			return 1
-		fi
-
-		# disconnect
-		trunc_size=${test_linkfail}
-		local side=${addr_nr_ns2:10}
-
-		if [ ${side} = "client" ]; then
-			extra_cl_args="-f ${test_linkfail}"
-			extra_srv_args="-f -1"
-		elif [ ${side} = "server" ]; then
-			extra_srv_args="-f ${test_linkfail}"
-			extra_cl_args="-f -1"
-		else
-			echo "wrong/unknown fastclose spec ${side}"
-			fail_test
-			return 1
-		fi
-		addr_nr_ns2=0
-	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
-		flags="${flags},fullmesh"
-		addr_nr_ns2=${addr_nr_ns2:9}
-	fi
-
-	extra_srv_args="$extra_args $extra_srv_args"
-	if [ "$test_linkfail" -gt 1 ];then
-		timeout ${timeout_test} \
-			ip netns exec ${listener_ns} \
-				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					$extra_srv_args "::" < "$sinfail" > "$sout" &
-	else
-		timeout ${timeout_test} \
-			ip netns exec ${listener_ns} \
-				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					$extra_srv_args "::" < "$sin" > "$sout" &
-	fi
-	local spid=$!
-
-	wait_local_port_listen "${listener_ns}" "${port}"
-
-	extra_cl_args="$extra_args $extra_cl_args"
-	if [ "$test_linkfail" -eq 0 ];then
-		timeout ${timeout_test} \
-			ip netns exec ${connector_ns} \
-				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-					$extra_cl_args $connect_addr < "$cin" > "$cout" &
-	elif [ "$test_linkfail" -eq 1 ] || [ "$test_linkfail" -eq 2 ];then
-		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" ) | \
-			tee "$cinsent" | \
-			timeout ${timeout_test} \
-				ip netns exec ${connector_ns} \
-					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-						$extra_cl_args $connect_addr > "$cout" &
-	else
-		tee "$cinsent" < "$cinfail" | \
-			timeout ${timeout_test} \
-				ip netns exec ${connector_ns} \
-					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-						$extra_cl_args $connect_addr > "$cout" &
-	fi
-	local cpid=$!
+	local connect_addr="$3"
 
 	# let the mptcp subflow be established in background before
 	# do endpoint manipulation
@@ -1077,6 +966,126 @@ do_transfer()
 			done
 		done
 	fi
+}
+
+do_transfer()
+{
+	local listener_ns="$1"
+	local connector_ns="$2"
+	local cl_proto="$3"
+	local srv_proto="$4"
+	local connect_addr="$5"
+	local speed="$6"
+
+	local port=$((10000 + TEST_COUNT - 1))
+	local cappid
+
+	:> "$cout"
+	:> "$sout"
+	:> "$capout"
+
+	if [ $capture -eq 1 ]; then
+		local capuser
+		if [ -z $SUDO_USER ] ; then
+			capuser=""
+		else
+			capuser="-Z $SUDO_USER"
+		fi
+
+		capfile=$(printf "mp_join-%02u-%s.pcap" "$TEST_COUNT" "${listener_ns}")
+
+		echo "Capturing traffic for test $TEST_COUNT into $capfile"
+		ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuser -w $capfile > "$capout" 2>&1 &
+		cappid=$!
+
+		sleep 1
+	fi
+
+	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
+		nstat -n
+	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
+		nstat -n
+
+	local extra_args
+	if [ $speed = "fast" ]; then
+		extra_args="-j"
+	elif [ $speed = "slow" ]; then
+		extra_args="-r 50"
+	elif [[ $speed = "speed_"* ]]; then
+		extra_args="-r ${speed:6}"
+	fi
+
+	local flags="subflow"
+	local extra_cl_args=""
+	local extra_srv_args=""
+	local trunc_size=""
+	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
+		if [ ${test_linkfail} -le 1 ]; then
+			echo "fastclose tests need test_linkfail argument"
+			fail_test
+			return 1
+		fi
+
+		# disconnect
+		trunc_size=${test_linkfail}
+		local side=${addr_nr_ns2:10}
+
+		if [ ${side} = "client" ]; then
+			extra_cl_args="-f ${test_linkfail}"
+			extra_srv_args="-f -1"
+		elif [ ${side} = "server" ]; then
+			extra_srv_args="-f ${test_linkfail}"
+			extra_cl_args="-f -1"
+		else
+			echo "wrong/unknown fastclose spec ${side}"
+			fail_test
+			return 1
+		fi
+		addr_nr_ns2=0
+	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
+		flags="${flags},fullmesh"
+		addr_nr_ns2=${addr_nr_ns2:9}
+	fi
+
+	extra_srv_args="$extra_args $extra_srv_args"
+	if [ "$test_linkfail" -gt 1 ];then
+		timeout ${timeout_test} \
+			ip netns exec ${listener_ns} \
+				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
+					$extra_srv_args "::" < "$sinfail" > "$sout" &
+	else
+		timeout ${timeout_test} \
+			ip netns exec ${listener_ns} \
+				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
+					$extra_srv_args "::" < "$sin" > "$sout" &
+	fi
+	local spid=$!
+
+	wait_local_port_listen "${listener_ns}" "${port}"
+
+	extra_cl_args="$extra_args $extra_cl_args"
+	if [ "$test_linkfail" -eq 0 ];then
+		timeout ${timeout_test} \
+			ip netns exec ${connector_ns} \
+				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+					$extra_cl_args $connect_addr < "$cin" > "$cout" &
+	elif [ "$test_linkfail" -eq 1 ] || [ "$test_linkfail" -eq 2 ];then
+		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" ) | \
+			tee "$cinsent" | \
+			timeout ${timeout_test} \
+				ip netns exec ${connector_ns} \
+					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+						$extra_cl_args $connect_addr > "$cout" &
+	else
+		tee "$cinsent" < "$cinfail" | \
+			timeout ${timeout_test} \
+				ip netns exec ${connector_ns} \
+					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+						$extra_cl_args $connect_addr > "$cout" &
+	fi
+	local cpid=$!
+
+	pm_nl_set_endpoint $listener_ns $connector_ns $connect_addr
 
 	wait $cpid
 	local retc=$?
-- 
2.35.3

