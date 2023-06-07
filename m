Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2040.outbound.protection.outlook.com [40.107.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBE87488
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 11:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3owsvKU9OGzHtPdDKZMlquFQCRQzQ1c/yUNBGAy+9mopq8D/EEnbESFSEbxJO1HUFaMsSxctoDzRBfqRxEW88eULi2wVPQLkMipvE4VaXVtR/CZ+lG2gM0JrGmJ8iBUl0S+SH2RnDVE8CwaZYMOKlgAx2sLZJ7zckCSyQnf3SQwDqkPOF5gjj/ZCrE6bdfLpF/vuqdrV1tW6F2EWOb733Mdj3UHuVzyGBbWVyKsQfq/ILIR4feH20bCWsm6kKxnLqRv7h7bAykIPZ4H6yjKmEoD44RC2LPRiqnwAVyQP2wJP0pc7ZrZMhcBhRXaKwpyTK+q4NRUbo8qw9iiML9dnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmPUcaSkQVSyXEZXDYocwN6iyLapH4O0310Ce4CfRfg=;
 b=B3qADvpq6FFHumEMlmHUzJOkAEJs/3eRUb3IiNnkB5jvfFl2k/MqZIMBK1IIXf7Ffecf4Jw8GY51W+PAfvoAo3a0/WPxEXriYbDttjYDlG4mArDS0RsvbnO7o+7731wTBaF74r3jzdpXzJJm/avfcXZVc7WNLhCVgXvLwiOU2Wc/MKuf7Td+SVNcNbTT71MKks0Ho9BBZigJvK87ywj4plP6JLCLEb09G6Kw1WolgbKjnvUZhADLcZPFtNUtDpR7Fh5vTFMVofQIPHoNlmca1eUoQNaCxTCSLeEz9T2iLsHwZ/e6y3+WoElabssuB5PgNJDXFhRwGwGdxBdDzUPOzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmPUcaSkQVSyXEZXDYocwN6iyLapH4O0310Ce4CfRfg=;
 b=F4Sy4mEQ/s1oZnqO1WXdToMvVUEQ0Jkhdi5IExdoHTqJE4U1SvOgIXm8mAMbJIkyoIlGaPdbVbFxwv/4Z+mruN83LBmHa9ENqP7MrloSq4mtzFQGqZezdTAvwwPVKWGzgtPWWLTA9fQelt75+1/otEL0Rr9iylCiswvo7JQmbyDKFApATmpnnjL25CUOYxbgMJqIFlPJq3e6xEYDCFDu08tTuYxs0DeqrKbvGFfV74Q6GDIGkGxyiQnFww3ggCY/+DWiGmG+H91u2bGZ9QUsBb94p8h47BWNpZ9eB6KwJFtqUh8YcYPEDCG1RR35bPyk0zkgsUD79Fp3NcVsG8ypSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8281.eurprd04.prod.outlook.com (2603:10a6:10:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 11:45:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 11:45:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 5/7] selftests: mptcp: add pm_nl_set_endpoint helper
Date: Wed,  7 Jun 2023 19:44:24 +0800
Message-Id: <1ff39615db5be22e2a6ad043d8799dced8d9d7c6.1686138130.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686138130.git.geliang.tang@suse.com>
References: <cover.1686138130.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 586d9d0d-ac99-4e01-484a-08db674cbf04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fuoHfeyahrmJahjvfF0toVsV9CwwL9BBY1m2ktrpxD+R3akmMCPSh/Nc/WgpqfHakYBu2GSkRuPcYmDjf4EsFAc8y+OdiaTRsZT72iSSNHEjq2XHCNsqMYd6eM6V8jkUzf3cbV++SKjkYsHhE5dnK8Vmp3/WiBIUq0/ywfbFAwVNzM2QMWyoc3/OE8LFVdM6td4Hzq7gT+qFtLTdoSv7fS5swvw6oO+hqLZJk2HEZxPkD6YKDT9AVsN7d5nSZoKwiV0JmqNlBbQ5njRSPj2NsgoLEze5yDzQGKJWw252VmojJ7EXDgBzGssQ25l11/34PypzwwyjxQxHtX3AWp0unE+9axr+BBB/EecL5KIJ8ecl96yPZUgl/Rt1klYL9WTS3+cqWlpYHQ3dubl0Vff2nQg2YuTqwPXjNTCrcyZ4MIr2jIlGMI9Bw+9lGq8YQqmsFCT4xirNIAhc7TSjNmv1VvnadaVbeNSemVGmGxu9GeFNBDRKBR/5iL/sMuEG0Kpsd8mZfQph/tMEMQ8Moo7unY7mt4sXLN3erYgiBOzlgLanJY2JF1frR7seVvUeqWQn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(107886003)(6512007)(6506007)(38100700002)(2616005)(41300700001)(6486002)(6666004)(186003)(26005)(83380400001)(478600001)(66556008)(6916009)(66476007)(66946007)(316002)(2906002)(8676002)(8936002)(5660300002)(4326008)(44832011)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jPFEiquymD0UtPgIrSbD3G3H+rgQIjmvJPMsIDwbA1g9Zqb2QfsFAl4IqRTK?=
 =?us-ascii?Q?ac3+ZE/ozKRY1ovo1Rn/PX/1+PMgGfcqDA7db2IytYXAjv/fJNAP8u9o32mN?=
 =?us-ascii?Q?EKOOa7eIkz9GD57sLT59HjYd1JmY0VrxVUrlfL595VHHdolqTsYv1cgc8KI8?=
 =?us-ascii?Q?M89KvjD4TJLi3U+fhEyIB/oUSRWvbmJub0z1wwnoK7CCt3B5vgW0dDyXZrTW?=
 =?us-ascii?Q?xivtqlVZ0oqRxpB8XVibTY/VSQDVodWqEbQzedhubTftFezR5bZV9D+8UoaS?=
 =?us-ascii?Q?9LiS31LHF+cFdi5NPwZd0XWHiwDMnqzBh7Umi/Ht9jiSN4dikx5+2zHCX43F?=
 =?us-ascii?Q?70bFjKg+4rADf7yplAvFOmXmkKucmakXQxJorhMJGefRRFqcJ9I/DrjBFs4n?=
 =?us-ascii?Q?L6ZtuJ9CV3dJ6lvYfUswX3E2J2Y5j60LzkAI2cTXlpXq+24PZluIbbrh7O5x?=
 =?us-ascii?Q?n2hD3/ec68eveMoQLIcMmEjVx1qYAtFTTkSUWME/cFUg2jL22DdKKXDosms/?=
 =?us-ascii?Q?df/Zuu1+aRUFQbv0ukD2AGLaBeqHXX/7ecyMNv+Q+UYrAvYF9a8oCs2JD/gu?=
 =?us-ascii?Q?j4t//u8wy+OW+hBGJggOcfKfV/dm7HB3Zds460FbzXlIOYk07AXiiTVgQd9p?=
 =?us-ascii?Q?wJm7i8KlI0pIV9SUMLxTkWDRHS6d5cZ9TGY3BIIGPivgivSV/uUZ2RtwA8Hy?=
 =?us-ascii?Q?6k6qx6XCsrEo/h3EHoZNcWoHRyqy7jPkY1Fvz3pVVvlpRJNu2V/oQ+xjtFGQ?=
 =?us-ascii?Q?dR35JvZ6Vfhs0E+eTj+5ZOmOmOWBHRkBakXPwKjfImN+5SN3n4Fdfc2kckvD?=
 =?us-ascii?Q?K9q8FRdV0gKqdw5UX82VqqmD0DbR9uNjKcLfDYn5NKAdi0qF6LvZNX3ycWVm?=
 =?us-ascii?Q?Ec7j3PFadcjk/GQ3z8/sgM7M+NnTmNTSw6txKHLbybftEnd2ixERXTNlfa67?=
 =?us-ascii?Q?XUBRkaI2qjMd1Xto2tKqbAC7VyK0qQd+89OgALiQMlVXHsR7LADdjC/JSpSq?=
 =?us-ascii?Q?1YApWa0ttjtBwsx0yU6739sS/5YXNbT2luIAqH/90WJuu8GDDJ56erzHqwXZ?=
 =?us-ascii?Q?Gy3gi8RI9um6JHK32l3DtofNp95h0Vw0JCX78SiCej5VlwyYncz63JbhUMed?=
 =?us-ascii?Q?T8EA5UqL2kNCFJyU5kawB82VXcYJYJGopz5Xhy4Kc0W6xROhqPZ6lEt7tmjE?=
 =?us-ascii?Q?lJEmr7Y82tBouyqGmV7X8iGgubbegtcjJ/WKyoHc7X/VwSYodws3y93hcUmi?=
 =?us-ascii?Q?JEBuELp1k3qyhikOhEuH0kBAlm/WWamcZmLKRoXC91rDA1lDyygu1tkcHuQe?=
 =?us-ascii?Q?fLU59iIw8cc/f4fkICtJqcF2pl70gMt441oXS/iVoLGWXrDwJMnK/SFNxjTc?=
 =?us-ascii?Q?fnhVRdARaNOEj7MIvX48jscfJMPkLoTZ2Hb6m9VbYF7vhxNc0U7hg6pAg9yx?=
 =?us-ascii?Q?meFes0NVo2JyHnwSv3DbQQHLjlmSXM8nET0/T9f9viNIzs1bb6/sxwq6xk61?=
 =?us-ascii?Q?7xGJwhytv/0bQAFPAUJG5E8CLcqrSYcE0bhtwi6YXB5mHYB1R72xynocRutH?=
 =?us-ascii?Q?HNQIqz+loEq1szb4vhbD+qENfgQBYS3YN6dUndRm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 586d9d0d-ac99-4e01-484a-08db674cbf04
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 11:45:52.5019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTztySVvg7t6Hv3W/poZaOc96F1AJvCKtrIS6M/YChH48ND/hmBXu6FdkRPYUYMSkVAqbKdcq+J9ELWiBThsTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8281

This patch moves endpoint settings out of do_transfer() into a new
helper pm_nl_set_endpoint(). And invoke this helper in do_transfer().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 246 +++++++++---------
 1 file changed, 129 insertions(+), 117 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 530b88990b76..d594df3e7897 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -798,126 +798,14 @@ pm_nl_check_endpoint()
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
-	local test_link_fail="$6"
-	local addr_nr_ns1="$7"
-	local addr_nr_ns2="$8"
-	local speed="$9"
-	local sflags="${10}"
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
-		if [ ${test_link_fail} -le 1 ]; then
-			echo "fastclose tests need test_link_fail argument"
-			fail_test
-			return 1
-		fi
-
-		# disconnect
-		trunc_size=${test_link_fail}
-		local side=${addr_nr_ns2:10}
-
-		if [ ${side} = "client" ]; then
-			extra_cl_args="-f ${test_link_fail}"
-			extra_srv_args="-f -1"
-		elif [ ${side} = "server" ]; then
-			extra_srv_args="-f ${test_link_fail}"
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
-	if [ "$test_link_fail" -gt 1 ];then
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
-	if [ "$test_link_fail" -eq 0 ];then
-		timeout ${timeout_test} \
-			ip netns exec ${connector_ns} \
-				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-					$extra_cl_args $connect_addr < "$cin" > "$cout" &
-	elif [ "$test_link_fail" -eq 1 ] || [ "$test_link_fail" -eq 2 ];then
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
+	local addr_nr_ns1="$4"
+	local addr_nr_ns2="$5"
+	local sflags="${6}"
 
 	# let the mptcp subflow be established in background before
 	# do endpoint manipulation
@@ -1057,6 +945,130 @@ do_transfer()
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
+	local test_link_fail="$6"
+	local addr_nr_ns1="$7"
+	local addr_nr_ns2="$8"
+	local speed="$9"
+	local sflags="${10}"
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
+		if [ ${test_link_fail} -le 1 ]; then
+			echo "fastclose tests need test_link_fail argument"
+			fail_test
+			return 1
+		fi
+
+		# disconnect
+		trunc_size=${test_link_fail}
+		local side=${addr_nr_ns2:10}
+
+		if [ ${side} = "client" ]; then
+			extra_cl_args="-f ${test_link_fail}"
+			extra_srv_args="-f -1"
+		elif [ ${side} = "server" ]; then
+			extra_srv_args="-f ${test_link_fail}"
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
+	if [ "$test_link_fail" -gt 1 ];then
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
+	if [ "$test_link_fail" -eq 0 ];then
+		timeout ${timeout_test} \
+			ip netns exec ${connector_ns} \
+				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+					$extra_cl_args $connect_addr < "$cin" > "$cout" &
+	elif [ "$test_link_fail" -eq 1 ] || [ "$test_link_fail" -eq 2 ];then
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
+	pm_nl_set_endpoint $listener_ns $connector_ns $connect_addr $addr_nr_ns1 $addr_nr_ns2 $sflags
 
 	wait $cpid
 	local retc=$?
-- 
2.35.3

