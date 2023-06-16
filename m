Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2059.outbound.protection.outlook.com [40.107.14.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093E323C2
	for <mptcp@lists.linux.dev>; Fri, 16 Jun 2023 07:32:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeMHxGJL/JLnK+W9EmbXqo2JsKaer/XztZrFAeMje6im3OoyY+asnWthJtVbUWybp/wwTcC0BDnEeQVdATisVf8SP3IYk+j3UqUTLqeTJ7bImzS5qLF3G94H+UQSU/msu5EGBbtO0R7YAmHkduwoDeO5Pzl+d9ODsGp1+3x/RlmWrc1S++eZ1Q2oJhoDSqF1MDo/SscjXBvhISWiZ9q3xIEWq8MaWuSAr0unC6stVjmx4C8uKY/uO9eB/N8LRseZhdvs0Kzzv7w4mfEqTE8Ai99J1j4Z9ytB/vig2T514i6lZoJopru/o9cAMxLIu14uKjRFhuwL36Zd3fgpXPbdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0MsODbHF4hJccdLIrllByj0rSIagnxB5b8D70tzx40=;
 b=k64g61iwICBWVmw6E05FiP+vbqE5Dom3/O/lM7BqHCSfzP+cp0Bk7byM8R+7Apr5817pMnWrRjZBpoGcIjIseSkCWW7IAy3gRvMaQxGsk6YxP9e0DWUAXnSonB81ield6jFDfR4mw7CuNmqQoiM4V6g0B6ox4zarTfvhSJDG2cpI1cIpsLv/3U4iDvtUnIHh1FZ0P/r7OeaLoBFrne3G2l4BlFsO9HTghY0f7z0K1HqaFQoZqmEWPrA1cHxVKpbBEZOfmXhYx4SS/6Zr3Jbt35NbXvxj4VM+BxRy+Z11IJS/DvplTXZulgxH9rgEjUDzajVa5YZBSTRj0niF6BK2ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0MsODbHF4hJccdLIrllByj0rSIagnxB5b8D70tzx40=;
 b=25x75q3a/ifsaAiGseSCTZ1XUxTZvBFYkLFHmujedVsT+1AL5uIr9lCiEmM5xIqYueImejjIBH7hTTm6l/uKKpFsh4tO4/n1lLVibOJvmudVSHAaqu/hzq8IKgcr4Fdks8cHPoM/mA0GOXdBHzg4Cff016lLEHm8gT5tRHszHZa/+SVsvgr6uJS045zNFAXhASMYQAHOQnNt/JGbW2K+reGpn/CtIWoDlqWzGTtTphq/wxQfgSHP6iTc1sNLtsBsYuPzyKgplNyv4Vgg/0R99/FvJHf4eSlGpPqo3CCQCOHPIcE+4j5jp/52ci0+4nQ/hmIVrwlgFCQDqZIfEi2p2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 07:32:09 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59%4]) with mapi id 15.20.6455.039; Fri, 16 Jun 2023
 07:32:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v20 08/10] selftests: mptcp: add pm_nl_set_endpoint helper
Date: Fri, 16 Jun 2023 15:31:00 +0800
Message-Id: <2efa6bc9b4f8b3817a64445f92f50bace87aeb20.1686900596.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686900596.git.geliang.tang@suse.com>
References: <cover.1686900596.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM7PR04MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a21fdec-4bf6-4d45-23a6-08db6e3bca7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iWtTSeT3BmpviI1FyKctC3XSjBSM9WF+Y5eMG1bL/5spRVMD0ScoBsnDWq4yNwzwYGi7yunIdE3myEvvO1gFktN17ljmWU6ZYKmUQ6n/i7GT+x8pTw8/DOZZkJT61Hey0ZZbFrOKA0xS/fmHfGC174QnGsBNH6mRZIASXi87szNIi9+H5EEtoOsgU52mN3ffbBAEPA2KzwveooJLLpKeE6QhIGrUjfrZZ4lp8cvDYagw32CJ2KLjzG/dAme/qI8V0e39zPlfKHKSK+deqI5z9EpjB28icc09UBybQlCGF7Jy5biodbmJaJ/e+ub+uVNCwJNFjOcIad3FK5NLgvjqAQqaE9aZfTH3DxfzjptuXCSrS3Jsj4GqxEEkk0j/03MjfYap9pWFje73UVUsJxsH4BzjLi3cwnRib1LbbT5wIFJxzy08pRxEbgf5KymanOtDQ0DdleWcWHLVdy8NTOk/sjmYQbq4ycTNMmg4/7RinXFtyd8mmudZobIwKjWVXnHO8bXAqZEfc7pSnwezUMsV/tE4Ih771T9wRiA7QyCzy9e08clL+d6cpyFBmDKINsBj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(6512007)(6506007)(107886003)(26005)(6916009)(4326008)(66946007)(316002)(66476007)(66556008)(2616005)(186003)(83380400001)(6666004)(6486002)(478600001)(38100700002)(8676002)(44832011)(8936002)(5660300002)(86362001)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ASytsSEKHb1MXWbl6XT7EVH4nXLSsVzL48C4erOc11FUdGm1AwInpSKOlB++?=
 =?us-ascii?Q?bh3AAhIV2kP+xFYnRVtPuyYLMeboULdRDA+RUGjQi9vbsibUB5IXBsqEJ2sF?=
 =?us-ascii?Q?6x1xQ98T1i6rqgL9UMfCWBXStA7EqBdltDN+9fS0WUHkuBkMgF9fKia9AnU+?=
 =?us-ascii?Q?uwk2Xte5rwKZhHkw3WZUjasO5HUvzjScnin8vwO7foiaLghsBiseV7hTuO19?=
 =?us-ascii?Q?glQjGSV8wGaZktxuEjzQJPekXYW87CcyXjqUFqZdye5Kg9fnLjRFRRTcfdqz?=
 =?us-ascii?Q?jdj29JDP2oOP0Z1//8hYZLvFS5ZcMLWP/h4WBCK7DsXlGEH3s4aKFI55XFyL?=
 =?us-ascii?Q?XtpDmr06pmwiPvZDLb4rCZyqMiuGsWA0js3qwg9sFPRFnFOOPT35F8LhBE9t?=
 =?us-ascii?Q?LTgwJuABB3YOobF4zfWMQOxD3oEWqGvdPgHcJuOWttiIbBMTSy3YXvbpfc54?=
 =?us-ascii?Q?ZfHL8w/VxhCyr6nyLB4+Lh7eNQ9TuWSMg1eugD4hhjJ9xuqWeADrbHi7jjoQ?=
 =?us-ascii?Q?x3zxz5S5O0Dt6LDopZAeHn05JLzJK5obxrtmsuEZRZRI9NsKW3BuyXlv76t1?=
 =?us-ascii?Q?6yFqil5eCFRQlS70yZYZFZ/lzA+PO8X6UbRDxyfiU3zdnc7QaHkuD7a73kWA?=
 =?us-ascii?Q?hzm/BYOjlQ3MpmNnV9USLHy+VJXTEgJ5jpjYSdoMPBdvx6sG+spfJM0DyJCb?=
 =?us-ascii?Q?71lagIwneJU4zGUkaXcjbAfwe1k1PKqFrDR8m5M9wybLzQh6Ge+7L4JZ9Lfu?=
 =?us-ascii?Q?vehWdSeo13tgAuCJ88L6QrnV1eRqluRTarHuXL9CUx2LkN10fwJdEwDMIIsi?=
 =?us-ascii?Q?sPArFUbLlBeUS9l3P4xmw+RrYsG2KbADI6mJBpzqmlXQ91gzi0Z8mOeRoo1b?=
 =?us-ascii?Q?tp3fFvrpCA/odv+NFzdCJzMLtELZszpJIC8BCsjFyDIP88uXIanh70dglHxC?=
 =?us-ascii?Q?jH8y+9urTCO7UC5puGPULpazqIOjB9eDTj1hJrxXEe6AcjBcio9m/tcKusk6?=
 =?us-ascii?Q?JnfMc84J66lzBGqYlHvuoMvrZlrSniD86yxP6az2awbt+CP4EXMjkQllbDII?=
 =?us-ascii?Q?k30f8u8XW+aFFom29Z73XENB9VHSDVP1YrKKznf6y3Ga52mRJdiZVYl5g8se?=
 =?us-ascii?Q?UXtDUxWWs8l3l8BsOi8UYykaGu6iL+2vjP5mYLfTP9QAorC8JGZTg69XgAfe?=
 =?us-ascii?Q?oaX5xY2K8bjBpRSzIYxSuFmKMWjuZF0neVAQwQAR0OW+6V+GDWgKMf+aZR5F?=
 =?us-ascii?Q?EgM3mxj6e3LGNGg+WyxnGe8i9y2GlH6JoIul+h0hRqVn+nzJinZS31i9vmsv?=
 =?us-ascii?Q?kqsphJtXbqWy8F29cySBGhEG3H6vI9n+JRhTUfZWMVsmBcyvVUr2XnDGbCXt?=
 =?us-ascii?Q?RrD5fYbOLAf+SDlLmWc5Tw0Tw+P/7+a9814V+Lo6U5/LLJ/ot/rFGkNQBE7r?=
 =?us-ascii?Q?EYoiDl5+X7MNRXFOUvLxRoTISTFBrAC1sMQSch/qf/TyGKQCS4ThEAOkh14B?=
 =?us-ascii?Q?5G3cRykGDjtgD1ez0/nNIoUxGBMS+GJPFb9iGiZ7TJL+tX2OQPCS4M8qFCvj?=
 =?us-ascii?Q?AECDMPEqhWfsOymbHnC1WEyLrSQlRgg/yLuK7hIQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a21fdec-4bf6-4d45-23a6-08db6e3bca7e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:32:08.8556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrXgbXynuA8gmENeVK5Dl3lxpXyCXf3d4D1InGf5uckPQUvzq7HUiPwlCnrB5vr3ih7jEQQ0J837Q5ozpEV9LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7157

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

