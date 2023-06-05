Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7669611C97
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 08:18:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCHO9xgbMeMHQ38eiHQhB95t8Slj8BZ/kXJdwunZu0mmPAiFl69mzi4xeigMif34VKVb7HAyHuauRQQ/GLIpCifafowIGiKshTE/AiDDLJbB9EyiU/FBQsifF5ws1cBDtLUcqvePyzLKWDdgKap/77qkg+xjchEt6X4f9mBpLTreFRRWSTtR66k0xPOdXp7XVp8Z0I2QZuzGStrEB6dT5IH1B5nW4E2tJGbMQssDsj4sDEcG83c1zJ9eMivkGhrSBANrcg051Nsw/Ve5hRCl7/lAOmgtPWHrn1QNaopNXirmribI5e1LOiMau0DcmyCKNIpAyk6srWi1vwLLFqJt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVGVBWrmmmHaYezaDo0gTkf6ky2L/71v0p52m/znz5o=;
 b=Hf6vmjB8CA3CyyGHI6qhYXDTlxAdPqGmsdbz4ZCQyqC7+7nhGWoPUtXIC8G1j6+Zav7ca5RY5dqqoclqWiqBc1ytMWjrwi58FfjLEfyeZLAAJnt5AZTIou098I9IfYxIM5yTnxthmsWFxscCvvP7r0KF3ZQYP1bZCUEj7EFmu33kHKZbK0jRhu1WPA8rST1tL9zIWgW/+qwc0dlrHP1eMCgzSP7AGF/6/qCYGwN8jlscoJbYJmUuBGmgJ5T4Y6HzJ7fgxXksjZYVuV9k+d+s5GnUzz19lu+8jEVvQm3bDNrFHLK3FvtjpJgqGl9dvyaF3m8QsqS69N4AmcXQpzL72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVGVBWrmmmHaYezaDo0gTkf6ky2L/71v0p52m/znz5o=;
 b=geOUJMmdfFh3hxdvqoOxcixoj9vcNbAPrncKyhB49V0Ds94bBVz7Gli7rDzwPkBebmW2LEUSxIkqUyrN/sdyrwmo7dvu8hBlyrtmaKIbwSdB1MNiCIrI4vfTRMiggta4IBbPAWWDNIvLfJovdLIhDBIiY6jt96MktEC/a+fda7XolZK+ihGQPfMe9k6D2bo/A6YYiVbNF+53WUBcx24uS7D86x8pshLeQx1ejqG1cnnoyTc8I9mwoCawQ4UtXBgLPSLdfEKiqU71qPQaUWr6udpcUu7Lx1qNEwnyEyitbCHmxjYIbl0BNuIJP9rERSG4GSE+BMlbaL0I9E4A+mZ9OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8799.eurprd04.prod.outlook.com (2603:10a6:102:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 08:18:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 08:18:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 5/5] selftests: mptcp: add pm_nl_set_endpoint helper
Date: Mon,  5 Jun 2023 16:18:08 +0800
Message-Id: <99a7be9d54bccc4e35f0fa892d7caa5b4da5b3c4.1685952776.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685952776.git.geliang.tang@suse.com>
References: <cover.1685952776.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f52ba0-e4a3-4237-9861-08db659d7ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eAf9bbsGHoPvJNWGwyh7QNChVzyH/rku0DdEoAiHj46FsyZ3cdmbTei8Ryh1JaTf8YjqC65hB0nd6jyj5xNQ4Swfwx0FF7gY2TcxRp8DnibMq+aEqTCPRl9O1R3ys2kHy3nJ8yucVGOhZ5JiaJpOtk0IpwI9TYZd4wYqdd0yVor817bDn3pRhopuar6xkcuZ7J/gakuVQeQ7jPjLW0pmbf1Dr8vdDmY98TpUMPYhKm7VE0VFGsOhD51Ck/vCkE+hHOmAxDQE8Alx9/+DVycd4LTX2Z2lbBlCtjKREv/k5UEAqFpetnyUiGjidYOZ+eFJEkFiQEGAlWzXN/VjwpTlrYj4voXI08Z18QVUzc7liURbAZAwku6CoDyVssDFT8ETSeisT+4VZPN4d+TzDTb4XfB2bWXVn4sga3Gpf7dE84X8sOucxUtmUxDFUb846TWd7omBspB1qZZonkxOdaO0WOqX1TLwOmizIf8mFTp7y88QZhtyKH691MRdDxO8Pzz0GlqawyV4C1Ds84x/EZ71rBRf8t5Egru2F5YmGXBPp8J/oIMDxoWUZ0HQsE1wULL4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(478600001)(6916009)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(38100700002)(41300700001)(2616005)(186003)(83380400001)(6666004)(6486002)(107886003)(6512007)(26005)(6506007)(86362001)(44832011)(5660300002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gqVAoWQGhfz/WjeuHTD3GEK7Q7ITpl3aaY4Ji59+bC2rs7MqoFllajC+YMMo?=
 =?us-ascii?Q?f1AbKVdMpD9xayQ8VY9lttEjY0MtrnGDQMgjDDOHql3XCzL3zcmwpCTRvdSW?=
 =?us-ascii?Q?0C6Af5vXvptKxxSNo0zeZeAisMA8gWpQe5c+veZmjKFSMYpWY5ku6VBvC3lF?=
 =?us-ascii?Q?4cHDvq4Qn16tpeiWRDsVV32gjtoCFC9ly1WClX51NVLBnp2t0K2xi3Jaw/sN?=
 =?us-ascii?Q?fklXz99jCQ1N5m4oSnGCAEQSW79ot686ZbprFe70Hju/zpUty5y9dykD+4Am?=
 =?us-ascii?Q?p9DJ2CPZLe0WT+PnSQco3JJt8lA4vSccZWEoIdQRj6i4POryNkTfPA6xMcYw?=
 =?us-ascii?Q?aoWhbxDtcSlTtidLkITFZGgXnD4xKLGMQxkT4tfEGGdBRQx3brvdH1dz3kdM?=
 =?us-ascii?Q?G8ngAnKpzlzVNx8Q+xit4GbJaL5ZlM66pm2CKRvQpCYgYRlTtEYM5YfnSeon?=
 =?us-ascii?Q?7YkdNTQqGjpOg4Dh8Dzy78Y0iXQA2XqzMs45IPXaxWF4AHK+sZjjUw08EjPo?=
 =?us-ascii?Q?B3E78F9ykMxKDX6bKYWYVae3hnuCkpv/xEKt1Blzwi4ACTpicuJduE5ttX+o?=
 =?us-ascii?Q?AoxdkbY+o7SQ+fGKh8C8AP/fWteTWJvCIphrTsIZZuaVNvrpJ81mQVEeTtg6?=
 =?us-ascii?Q?e+XyNSCVm8sYTGJW7qmwIGmq1jCC0s0zlUtICatFgPftg8EdRksmP7/yoLr3?=
 =?us-ascii?Q?yZ7aXTUUaMk/FDWd9XlezaT7hRTFw38xgLbKUHhdd5hq9M95nESgf9HpKr8C?=
 =?us-ascii?Q?jg3lUZnaGr/XDrWr3AG558CdFvkzKWSDD3lG6aotpR8lzxq6kX2Z9QvKv2NI?=
 =?us-ascii?Q?Xv9rpBmehRAIKHAtFolCsz7oYgNN8pUP72oX2u1XS+TDhk6u7DHNPgC0WwDE?=
 =?us-ascii?Q?qqfixr8Lxvs+7q9Q08nMuv1omQgb9LqKRx6wsu0bY3cpVoAuTKVks1pOoWKV?=
 =?us-ascii?Q?i3lj+zUZ/u7AxKcUuKlfzOMatntXqRkkCJYPdr3ItFHBUSAMRPcjXKZmYI1I?=
 =?us-ascii?Q?CewTcbvKr7aTen7D4eHCfaVCgghk7IfssDSTFAuK/SS0XONg7Hk69dZC3vbH?=
 =?us-ascii?Q?QLcvgMZmHJ+QpasQtY5qyJGIvdTeXZbFPhPY3nxxhLLYVpL4tIjvquFJOaD9?=
 =?us-ascii?Q?UpJ9865U5w8wdHvB8lI4v1SrRuA+c4zfTj8ISxzHlfcXoz7/BNLK4Cgvpawu?=
 =?us-ascii?Q?/5v6uBk1rEQJ7DcFmcDTNb0BqWOWoU0E3uKzkUYillMKVkZDAz1j73z+nHCN?=
 =?us-ascii?Q?hXP6+Wj/Z1z/ixo36jMm+8wClvmW08GMyLAWVbkNUEttSh7MJcZlQWIy6IfI?=
 =?us-ascii?Q?URZwkOLxsYvdbulz5zvtrxIuR5+rJIMbDZr5qGKPsk+r5Y0JnK16GcVlYe63?=
 =?us-ascii?Q?TENKMWsYYpdT622fhk1z/WIo/gmcVMjLvhYO4cM5g5ziYJhRQk1JhCQub9dP?=
 =?us-ascii?Q?m+zS8gndr/+bwp+VZKoI0BlO3moxQgKQYAVlOrJLCfxW9R2gYK1ev8NK17Bc?=
 =?us-ascii?Q?7LMAsCb5S1cAARt4BEYXT6MAPlCcYoMmzw/ia5NmQdUbq2H0zzns3ZDZ8nwa?=
 =?us-ascii?Q?IRLoIujuwg6A3DD0v4hVO2dRLBFlGjxhEwfrG1NH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f52ba0-e4a3-4237-9861-08db659d7ca4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 08:18:48.2459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1vxGBTX56bIyBUjWTvBOKdKSl55szB9ILQ5iN9n/D+8UNWfw2TiRVdFFhDNxz6PV9Wrj00ahUOOakiQ6cB0iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8799

This patch moves endpoint settings out of do_transfer() into a new
helper pm_nl_set_endpoint(). And invoke this helper in do_transfer().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 246 +++++++++---------
 1 file changed, 129 insertions(+), 117 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5c2367c84cea..bb073baa7d0a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -712,126 +712,14 @@ filter_tcp_from()
 	ip netns exec "${ns}" iptables -A INPUT -s "${src}" -p tcp -j "${target}"
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
@@ -971,6 +859,130 @@ do_transfer()
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

