Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2072.outbound.protection.outlook.com [40.107.249.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB1520F9
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 07:21:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lide5PmcYNVttjryQTFMeiPuP2nvKnt7DFXCm0oIXJ9IPjE6o42nSMGi/CEkGi6wXABABOuC3M58NgjxZkfN8I1mXZenKhruDAuyLjUVDLWD/wzKL92SsQfxzAEnerK/Sgqplh0E1i5ssvDtNT0P3b8N3ldFXuuXocYBVBaNQzcLSiPTO0feMTHldTopEaLeNy/t5saXS/nOy/BNbZuDQlLU94oc4jAvBdcUZv+TfKemJUqIVJkoz1tXEy7ESXUo1Z12PA3ZG5OZEdfaAvBIzgf11RTYTSZMvDJEKayz3hz5/A1UdeTd45C9L6phNHaX3F9ISx0o0D52KQQrw1/prg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCTAP7vHZg5YnMrge8R9OegDnudXtsx03MzFEZZjOGo=;
 b=ll63gISWbigcnJa9L9SSSV8h0F9hIdSHks8HZFwejgzSCh1FEfZ5kkpR8O0mGsAlDPWRU934K5hmax4nBC6c8tdtJsg0ZBuvD2iBQi8+Xnp+5KoEQReo09aq9KqTI17JTK/geRhQZIh9IhOABc+9jZJ4yw8xIDjnffHhhvQWiGIjRXvCofbz9UD7yi+WQrFmsgQbiMYIINJ5DJNGK9ppP+7uAq0qEq2WKBXt2Ux7P9mWYj7IO1EfUo+759nWSrmFSK7eBZD761CguFjxKbFA3w5hry2wHqdIB427ZLvIoISNRxj0Oc82QgWb6gzQRIFthZWwRwYmzqvNB+tPTPkp5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCTAP7vHZg5YnMrge8R9OegDnudXtsx03MzFEZZjOGo=;
 b=4ws7VIESXW9MAxMxa/mFRiE3Hd0StT030LGl5VHmgz0mq2+CkRv5zbcoUqY9dEgthtdYLdTaWnLLr+A+APODpCKSAk3WsCBrKZCiZxwSRRh9KuWrJoximEmagAGJYQacIz5YexCouru/fY4ciSZP8EsQuR0LPP5UC5I1NSXfSnEaxtk9g7nbIHnoIH8VGsL2NBxkhvUhZYlDEq+Gs/96Y3dfQKyRD5I44ECsF9gYFne36xI0M1pv9JfaktborHukLdkYnxMM9rwDGUML3+LYCMk7tixyruywAy50j+6thRIwP5C0/Fl2SOuhixGR8Ym/uzvZGnIU2NrNltwblxzyhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9149.eurprd04.prod.outlook.com (2603:10a6:150:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 07:21:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 07:21:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 7/7] selftests: mptcp: add pm_nl_set_endpoint helper
Date: Mon, 12 Jun 2023 15:19:46 +0800
Message-Id: <54a3b69d83dc1e965202eca7ccfdd4927b68de2d.1686554287.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686554287.git.geliang.tang@suse.com>
References: <cover.1686554287.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9149:EE_
X-MS-Office365-Filtering-Correlation-Id: 8690bfa6-771c-4582-f4f5-08db6b159b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HZDkqrUdimulokSbZu9XY59VSGekjjwyWZt6kwLLc0zY5Sj005fnbsBHKuVH+MZ6FyGazHusHgsWVZLHr1BlAzBslS2+pErzo/zsIWOut2YF81K0bIs1gG5/uO5R3TorTd6sYdiC10a01KJCx69nRWgzizveO68+QbqVLkof5bc0r87YCmzEfv9XX7i595HhiNqN/tW0apb1+jVs6X5agqbLLsXJT+hN1Aavw0KUe3svyaHuewmgfrimUOj3s1EMTDm3gCYFjSE1waB69+MVPHzeVj1E4XUe5MgUG5E9L+V9/3PmqEAA5zOdbaawGuwrKj7+p71JONA0c9bdbPmmBLpmz9CMwlTGEI0Mxu4NxHvLmQA99JddmSC29piIK9NkaWVMqgLHsFtJp2o2cfrwaUOI2XtEPWO9DL47c70BBW9mlGK9wwy4UvI6hgLoVl7hkLXE2NhIVGWdw28vIYlRlKlfJ7vv7oZdL+ho5P36OQlx5j+49DIlCuBfNhHFCKX1nDLLbU+uCcT+FY7p9xpoVYS+LLSVv9KSzyomBdNAXXAPpDmZ9MleWzj7v8dKQP3C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(107886003)(6506007)(26005)(186003)(6512007)(2616005)(83380400001)(6666004)(36756003)(44832011)(2906002)(8676002)(8936002)(6486002)(478600001)(6916009)(5660300002)(41300700001)(316002)(38100700002)(66476007)(4326008)(86362001)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yo1xSXz9F43RtZS1t0XQURzjybOK9GkpGDS5ERS635Olf3D0R4cHkU8XGlg2?=
 =?us-ascii?Q?3LA4Et8pXDTDcz/pgenqIcA7kc1UQFkIMerWuWuuHrHjQkRqTKokZwlXL7xf?=
 =?us-ascii?Q?KVZ+gOW3WI1FbBR/34u7qtwnjl/Oab0W74ZCSjZ2/7egyeMvjmBO8ADAXl8q?=
 =?us-ascii?Q?xZQPu4fAPJdhIysQ3tKjiR1C7MwxtRvCh/xUzsecBQpTNMh/VAytL9S6bk1C?=
 =?us-ascii?Q?qJdV53BCBaNHaEQ/oL6bMGT0rQR3Sd9+3RV77gtC8Z5aJC9IBvnrzfb3bF3M?=
 =?us-ascii?Q?9Yy8fWSlB4CgoIbni5jhQ6qAopdx3z2e1TfcAhD2/0ZxNYKUD4C2lKlplEiL?=
 =?us-ascii?Q?XXR0DKjv9EwjSrlAzu4Iki2et0oxTGu3ip/EP6vbzgvLkz7eoqYFBiQVUCxl?=
 =?us-ascii?Q?bs9GJc84bVXpAfZrz2hqAWRrBd3VtArndczQMQ8UxDPMfGpPIYWhC3IWgWIZ?=
 =?us-ascii?Q?2r19gIq3SFzwadU+oJOLMmNia0CuNqbtakTlXDhyh5ur3V01wHf/if6ff0a8?=
 =?us-ascii?Q?AeoqmH3RuO9mfQenYe75i0l0KAfZOMaUxJPBXjy3UDcfNoKGUJHFuek6q5EW?=
 =?us-ascii?Q?gkMvxcPP5Y/Jyc43pYfPtLVK7IkbPxqe6y2Kn0KmZV+kMqQakB5qW2k30TM/?=
 =?us-ascii?Q?4LQWlHeQm0Z8j8BZPrVDUKB+anviFFPQ3b/AignPr6HXSkjKLh9sEiYZ0Sug?=
 =?us-ascii?Q?eMZbwPsEuDhNgTeoZTBzfYFYGjl08SZBQq+5+Ewn8sxOQFyIZ0le/YvD0B/y?=
 =?us-ascii?Q?xEt0V5LZOIiobMRqTutSVIP4AjELutgxs9V4Zi1a1Hbo+80/lS3PjpLtzyNJ?=
 =?us-ascii?Q?Nanb6wdiQ3zQk5D3kxuePMt+iFb7XoHim0Z5VvD5IVL8AuydeblRgTFeNHcj?=
 =?us-ascii?Q?+O+uGVyk1KGC4s4kuI9uJrSPy3Axt/i3luUyTmA4UIDZzhQ2ZaqEBqz4Gp50?=
 =?us-ascii?Q?zQjylSvcuGk8UYwDt5ubLc2bk3b62cDf1cNYOJmQXJi+m7MDIL95EkC8mNGz?=
 =?us-ascii?Q?wwyjbXD3H75jJtxHNco0PNO2XjOSJ7VsbypP0ki4f3w29X4yT4UDdHA7jtlw?=
 =?us-ascii?Q?0O2+4WGv6AsGB+Oyh051JmC/EALCxyJpDn6SYK2ubNLbQFO7cJuhzOXjFGZj?=
 =?us-ascii?Q?PwrLlbtnxabge9zouPUwPkUjE3f0Vm/wcRcwGh5uBYY+mC/2Jax529y28Zpz?=
 =?us-ascii?Q?jCuScQk4pMrH7NudgDtARxUAkmWfRcRokIijUfdellgTAUmQVzxLQU5vVmA/?=
 =?us-ascii?Q?yrSAvKYBuPEMxB2QaIxSIi4Jlv76NLT5cJGdSF+av3zimQyB0F0ie583O0pu?=
 =?us-ascii?Q?KZJAFugtZ9Yd/iqjPZx+FJY7hXdLUWYyoP21UhrKNvEKKmIkmCIpjvurkeb3?=
 =?us-ascii?Q?fVQWnzGd8H4IEbN1R7lwcT7teDlwNCkykyeEG1hnILJthDJUXk7uF8d1jX1Y?=
 =?us-ascii?Q?7qtJv0K0CdSC9b04GmolqtbWnlmMP27EOzeP2Eaiw+AYPas0WkJhsFZC7bgG?=
 =?us-ascii?Q?l3DXmcjs38KT7hGol21aIocY3EQF4ELL+83nBp5FTavIq2b6R8o4WZkB0jNJ?=
 =?us-ascii?Q?Y4Qpc7/TqmR2QNmGfPVaWP4UJANkNvJdBmXNhUje?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8690bfa6-771c-4582-f4f5-08db6b159b39
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 07:21:14.7980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIcDyESjoUidbLmdW2EB9diR5AeEwpSGelsD1WohRQeH2S6arCwb/B0SqtnvrBwILn4n90zeYtmhT/LUDZBnMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9149

This patch moves endpoint settings out of do_transfer() into a new
helper pm_nl_set_endpoint(). And invoke this helper in do_transfer().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 235 +++++++++---------
 1 file changed, 122 insertions(+), 113 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 68025ef698b8..e25e3ffd701b 100755
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

