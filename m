Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2051.outbound.protection.outlook.com [40.107.247.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7741FBA
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 09:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ID8caxhDBMvQqnpyPJZycf5NDW5dkMd/6wYwpiP2JlWZ4e1FENncEPibanyj9IC0j/HCJRZiHsS1CnLAEN046z9C196Mw1QxKyJj3kzayMKLwIrZMY8z51Ejp2zdJ+r6pqn0mWkdV1jZDGkLUm2E20MMQ64JqT9sBKG8hAUOPgMZ4RhB8TyqDP/26SdTbs1jegEskuGIJ8EPGNfV7xF7qVZZGkVGG+swT/YWXjIymjL0gYOdeCHn0GDsxFw2ITIBfxpgDafnNwKp5+Pqey1AfGkdBrV2S4J57sKzk3CKtqLCLduOhMbzTGIxvK+wTRhydYu4otPAfRgP377G2xOZ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApJUx88M541wSffoRbRoFycGTs+RLwnVofZvQMIx96g=;
 b=oS9nlmkJcx3uaFd1xi0jl3ERPxFbOZLKWNSw84IRgSptk/EoMLn8W5B6ognnCFWoiymmRPEB3o/omQSwRzgnPA/qjBTHCbWrETzp2uZRgD0Wc3iluCqlNqN06oAmMBcxEYe3uoRdmfTd/BiDEki2mHuBE9J6EXJpIiZ8ZDdIoB0OXQJ6YAcTRR2CHttuGdFje2motQkEIWsQRoOzfHLxBcitVPVNk7SHQB7N11ICxKBKZnYT6KCJsw33IhiYN9SFIyO9N5vbGqL4y7lqp+SW/1OzrfEaK8iuU+8lo6tBnQtpggGAN/EjacvHGJD3eVXprcslRbuFHI1SpNRuSM8BNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApJUx88M541wSffoRbRoFycGTs+RLwnVofZvQMIx96g=;
 b=yZJpirqnEqMbSuhaFCpbN+Lu4U3CRUdM+DkaTGRNtV2gsuxQ/n6qMb3GzRhvYzcm9kkaIRiEYVWb+GorwM3b9QVk8we09zr6IRZjYS8BhfcB7gov0Cc5m6ewPindX3KNJE+sB6YI0d26UJGQ33xjZ1ScEg2xTq0QL+aK2lYPbPt6RZ/sJR3U6XW51ErJz9OlrWGR9XD/WCxJWf8FoI7vD9jycZdOSt1Nkzt+/Zx/DL9Hh941mqtDyr2j17rQvN8anKZhyvYdl59sG0Zny1g+Brlmuk4ugTOZ4+iVcMKphLNWL71pc+QZR++zV8+P4HfR63JDcjvrjwl7AT8RYXmuJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7902.eurprd04.prod.outlook.com (2603:10a6:102:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 08:59:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 08:59:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 7/7] selftests: mptcp: set endpoint out of transfer
Date: Wed, 31 May 2023 16:58:56 +0800
Message-Id: <46e0ef22b358efde64e3783c4cce79dbcc45f417.1685523463.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685523463.git.geliang.tang@suse.com>
References: <cover.1685523463.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 4073bda4-c9be-4cf8-8c41-08db61b568ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	42C212FLL0FhpeXX6cFYVucO/KNcyWBLeYT8wIaCBKNVem59BpWvDPqe9VsmQEigGtiU+pN+GuvyPFIWxQ45feQWFqz9YCGqlo8kyfp/tp4qjdCVuMXXtqJdkXbzjfaz0ijhOkqeP7QOYB1SDJ8OrQe11vkE3axVV8xBkf/VmeUFZP5rWLZajssL3GmlsHuz0pUOF1ILzlhc8MMFeSvOhLPBdb0s7s0rbyVAQGd7X+o9EG6+ZdBqbnGh3ffU0frJF3+KfXnWLY12dMw6AdlvhJnryT1gUtYHidTDqqAtum3H3GVpGYrvo/yqY/+z9r6ga4WqzW8SdzX3+qZyWkXBv9uWB2laSG/ZvPpFu29VvJUcWk4kK8ivqX6Ht1cn5LQZ7pg7Ld5mCjHVwjZzpbV6qgOtbjlQ9qbkLlfuUEInXLOgQL4ptCxRGGym6r6/FSyuoG4XYuSBvZwbTKErxuxU12/nnSf6Zspi/A5L7+W/oOrJpOFtgdb8sxi4eq0kZI20U35tk+lcuRnOpPsBpJ36FZg8L7y0eXQ69quvyEFqTj4+2/U7vwXYrJWrvUPFWPf/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(107886003)(2616005)(38100700002)(186003)(41300700001)(83380400001)(26005)(6506007)(6486002)(6512007)(478600001)(4326008)(6916009)(66476007)(66946007)(316002)(5660300002)(66556008)(8676002)(8936002)(44832011)(30864003)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AfXfOalF1wj7g3N1BGgO1QfeHYZ1vPUFMHLn62W23iAhlSXMWWYJESaJw6DQ?=
 =?us-ascii?Q?IBcxfelF3ooiW/gPvCRBkoF8U5DrS4++ocj++ouUBrPiTQMb1JydQOS0qcbq?=
 =?us-ascii?Q?GxYyIGENKKYbGR0oA5d3HLO6x6mN1oM9mrWUnfOh2wnHIzK86hVaKpc2URyD?=
 =?us-ascii?Q?+RClQzPfdw6qFdnPGOoN11X/L3ZLiShRuRMuGaE1kvDiTEO171KU/WNW4t4k?=
 =?us-ascii?Q?o7pGm5ltLue307z+Ar28XjwOIDWb+xcMwoKjn2Wy/64A+EiwoAQkw8qaUlfV?=
 =?us-ascii?Q?pur4Fh7vPWKHp245+VmSb7vcCbvXc7M/ye9PMsFFb3iZlalxEcHe81PYxqJM?=
 =?us-ascii?Q?fYE6P8iLOHDjdox4aGl4ZbRW/8pCvQz0hMA0JNd+MbgyjtgNG6BEKQACT1/I?=
 =?us-ascii?Q?5LqLFSBV7Sf910j1ui59Um0baJhLytXXAyUPql8nznNXb0w4dMad8Z1B5h8O?=
 =?us-ascii?Q?BgqQEgw29OyQTDFq4SNdJDg8jF6bDWbEwGaK7Tmotw7IqUJlfyOV3os+EjxH?=
 =?us-ascii?Q?AG1NdC8NGYuptWlcTlNQaMO1rGTsmppgDqdabZCdib+K+drb0C+96PiWItz1?=
 =?us-ascii?Q?7U0teJ/biiXbzmF/YBixqDJnDg22YLCNo9RsjzjHuQnn+G0/PHE5hHYJluas?=
 =?us-ascii?Q?LSKNjmtnQnXpRpYeBtZZcfqkd0rnsWhNoBEPLXNZP2lr4BLjO9r2A2kEaFNZ?=
 =?us-ascii?Q?wNtvXsez0btHtY3S2OW4BoggPT9RH/kyNbzUDq/BgxridYMQHkBBPkj9/bTI?=
 =?us-ascii?Q?l9E6HJOHnW42887c0hmUmxVwtzTMvAz0a53Q4BKASZFpbtqdT0pCe6X/OmR4?=
 =?us-ascii?Q?xlfKhcCu5XhzJ9lSQhbgi5a0DEaRo/K2lUA88Gl9HgT9vxmLUlQoVKjn3bUh?=
 =?us-ascii?Q?/9CX0OV2zwtUYC5dmPjfjaM8ik1ed8BHkT/QbnSJ9+R3EiU8WXwYvs7oR3Fd?=
 =?us-ascii?Q?kysG9ZP+NNDIa+wgjGIw9AHF5Cqh5Sb8hGt0khMAl731Nf+HW+9Sigt0kXyW?=
 =?us-ascii?Q?a7Nk7mW0z5FSFIF6SzCqv9aUHRBSNmtb0KxMcGO/c2OxosPPEjE8cjVjoQ3K?=
 =?us-ascii?Q?apRiDd8UeF0S7+U8bZndVqgZjzzYdGfa/QM1WFo5E7x8Ml32Eg7DQzMiHfP6?=
 =?us-ascii?Q?Auya0DJ0IuibU1TK+xPfRWqfdEZ8ZS9rgyQMSZFSQfLktqcq5tKASH1D+5xa?=
 =?us-ascii?Q?a28Uhm5M5VnMoLNA2wN0IA0tjNNFC0vxLmgBQka8gTYq0jOE0Y7ddTdvNtMa?=
 =?us-ascii?Q?VBSfvcPjCKgnlO/iQ9YDxkWf/BxCQGP/IgYYNxdLDkX39zijE0k6D/EAFZox?=
 =?us-ascii?Q?jFEQx/gCNWMipokaiQVgn2Ox2bYPVCEfJSMshlV6FUkw5sC3O3Mp2Sfs9EG1?=
 =?us-ascii?Q?ZIFl7r9VPRS+MallAOPc1oufe0vmLgZAlWxelWLvfgDtyvVBScLR+kAIDl2c?=
 =?us-ascii?Q?oQEld1VJLLafHwhb7unyte5efoteNGIs+pQtD1dr0gF5EmDg9aarUh2Uigz7?=
 =?us-ascii?Q?HM/i+4DtoijYNJ0pW3Sz3SxHOt6sw4ipcASaweOvz7shnW05twBJKH4wn+gw?=
 =?us-ascii?Q?+R07umJFWSOOXvM85PdYHhAcVlZE2QUEpe1gjUi1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4073bda4-c9be-4cf8-8c41-08db61b568ab
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 08:59:57.7465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSjlMybRqoOOtaQ3uNNbd9x0G9QLbJ7XwtSEp91ZQtYo1FgGcn6aRYJhb902u4DgZANv/afXTpeTkxtc3Ju8dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7902

This patch moves endpoint settings out of do_transfer() into a new
function pm_nl_set_endpoint(), then addr_nr_ns1 and addr_nr_ns2
arguments can be removed for do_transfer() and run_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 384 ++++++++++--------
 1 file changed, 205 insertions(+), 179 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e91ce69e983b..7a14d9e18428 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -798,128 +798,21 @@ pm_nl_check_endpoint()
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
+	local connect_addr="$3"
+	local addr_nr_ns1="$4"
+	local addr_nr_ns2="${5:-0}"
+	local sflags="${6:-""}"
 
 	local flags="subflow"
-	local extra_cl_args=""
-	local extra_srv_args=""
-	local trunc_size=""
-	if [[ "${sflags}" = "fastclose_"* ]]; then
-		if [ ${test_link_fail} -le 1 ]; then
-			echo "fastclose tests need test_link_fail argument"
-			fail_test
-			return 1
-		fi
-
-		# disconnect
-		trunc_size=${test_link_fail}
-		local side=${sflags:10}
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
-		sflags=0
-	fi
 	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
 		flags="${flags},fullmesh"
 		addr_nr_ns2=${addr_nr_ns2:9}
 	fi
 
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
-
 	# let the mptcp subflow be established in background before
 	# do endpoint manipulation
 	if [ $addr_nr_ns1 != "0" ] || [ $addr_nr_ns2 != "0" ]; then
@@ -1058,6 +951,121 @@ do_transfer()
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
+	local speed="$7"
+	local sflags="${8}"
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
+	local extra_cl_args=""
+	local extra_srv_args=""
+	local trunc_size=""
+	if [[ "${sflags}" = "fastclose_"* ]]; then
+		if [ ${test_link_fail} -le 1 ]; then
+			echo "fastclose tests need test_link_fail argument"
+			fail_test
+			return 1
+		fi
+
+		# disconnect
+		trunc_size=${test_link_fail}
+		local side=${sflags:10}
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
 
 	wait $cpid
 	local retc=$?
@@ -1128,10 +1136,8 @@ run_tests()
 	local connector_ns="$2"
 	local connect_addr="$3"
 	local test_linkfail="${4:-0}"
-	local addr_nr_ns1="${5:-0}"
-	local addr_nr_ns2="${6:-0}"
-	local speed="${7:-fast}"
-	local sflags="${8:-""}"
+	local speed="${5:-fast}"
+	local sflags="${6:-""}"
 
 	local size
 
@@ -1176,7 +1182,27 @@ run_tests()
 	fi
 
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
+		${test_linkfail} ${speed} ${sflags}
+}
+
+run_tests_bg()
+{
+	local listener_ns="$1"
+	local connector_ns="$2"
+	local connect_addr="$3"
+	local test_linkfail="${4:-0}"
+	local addr_nr_ns1="${5:-0}"
+	local addr_nr_ns2="${6:-0}"
+	local speed="${7:-fast}"
+	local sflags="${8:-""}"
+	local wait_join="${9:-0}"
+
+	run_tests $listener_ns $connector_ns $connect_addr $test_linkfail $speed &
+	local tests_pid=$!
+	[ $wait_join -eq 1 ] && wait_mpj $connector_ns
+	pm_nl_set_endpoint $listener_ns $connector_ns $connect_addr $addr_nr_ns1 \
+		$addr_nr_ns2 $sflags
+	wait $tests_pid
 }
 
 dump_stats()
@@ -1977,7 +2003,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 0 0 0
 	fi
 
@@ -1988,7 +2014,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -1999,7 +2025,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2011,7 +2037,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
+		run_tests $ns1 $ns2 10.0.1.1 0 slow &
 
 		# mpj subflow will be in TW after the reset
 		wait_attempt_fail $ns2
@@ -2110,7 +2136,7 @@ signal_address_tests()
 
 		# the peer could possibly miss some addr notification, allow retransmission
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 
 		# It is not directly linked to the commit introducing this
 		# symbol but for the parent one which is linked anyway.
@@ -2218,7 +2244,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_tx_nr 4 4
 		chk_add_nr 4 0
@@ -2229,7 +2255,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 4 0
 	fi
@@ -2240,7 +2266,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10
 		chk_join_nr 2 2 2
 		chk_add_nr 8 0
 	fi
@@ -2251,7 +2277,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10
 		chk_join_nr 1 1 1
 		chk_add_nr 8 0
 	fi
@@ -2264,7 +2290,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 -1 slow
 		chk_join_nr 1 1 1
 		chk_rm_tx_nr 1
 		chk_rm_nr 1 1
@@ -2276,7 +2302,7 @@ remove_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 -2 speed_10 "" 1
 		chk_join_nr 2 2 2
 		chk_rm_nr 2 2
 	fi
@@ -2286,7 +2312,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2298,7 +2324,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -1 -1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2311,7 +2337,7 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 speed_10
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -1 -2 speed_10 "" 1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
@@ -2324,7 +2350,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -3 0 speed_10 "" 1
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
@@ -2337,7 +2363,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -3 0 speed_10 "" 1
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2350,7 +2376,7 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -8 -8 speed_10 "" 1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
@@ -2363,7 +2389,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -8 -8 speed_10 "" 1
 		chk_join_nr 3 3 3
 
 		if mptcp_lib_kversion_ge 5.18; then
@@ -2381,7 +2407,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -8 -8 speed_10 "" 1
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert simult
@@ -2394,7 +2420,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -8 0 speed_10 "" 1
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2405,7 +2431,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 -9 speed_10 "" 1
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
 	fi
@@ -2415,7 +2441,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -9 0 speed_10 "" 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2428,7 +2454,7 @@ add_tests()
 	if reset "add single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 1 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2436,7 +2462,7 @@ add_tests()
 	if reset "add signal address"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2445,7 +2471,7 @@ add_tests()
 	if reset "add multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 2 slow
 		chk_join_nr 2 2 2
 	fi
 
@@ -2453,7 +2479,7 @@ add_tests()
 	if reset "add multiple subflows IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 2 slow
+		run_tests_bg $ns1 $ns2 dead:beef:1::1 0 0 2 slow
 		chk_join_nr 2 2 2
 	fi
 
@@ -2461,7 +2487,7 @@ add_tests()
 	if reset "add multiple addresses IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
+		run_tests_bg $ns1 $ns2 dead:beef:1::1 0 2 0 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
 	fi
@@ -2474,14 +2500,14 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
 	# add_address, unused IPv6
 	if reset "unused signal address IPv6"; then
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow
 		chk_join_nr 0 0 0
 		chk_add_nr 1 1
 	fi
@@ -2491,7 +2517,7 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2501,7 +2527,7 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
+		run_tests_bg $ns1 $ns2 dead:beef:1::1 0 -1 0 speed_10 "" 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2513,7 +2539,7 @@ ipv6_tests()
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
+		run_tests_bg $ns1 $ns2 dead:beef:1::1 0 -1 -1 speed_10 "" 1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2614,7 +2640,7 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 0 0 0
 	fi
 
@@ -2624,7 +2650,7 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:2::1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2635,7 +2661,7 @@ mixed_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:2::1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2647,7 +2673,7 @@ mixed_tests()
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 fullmesh_1 slow
+		run_tests_bg $ns1 $ns2 dead:beef:1::1 0 0 fullmesh_1 speed_10 "" 1
 		chk_join_nr 4 4 4
 	fi
 }
@@ -2660,7 +2686,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 0 speed_10 nobackup 1
 		chk_join_nr 1 1 1
 		chk_prio_nr 0 1
 	fi
@@ -2671,7 +2697,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 0 speed_10 backup 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2683,7 +2709,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 0 speed_10 backup 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2692,7 +2718,7 @@ backup_tests()
 	if reset "mpc backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2701,7 +2727,7 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2709,7 +2735,7 @@ backup_tests()
 	if reset "mpc switch to backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2718,7 +2744,7 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2809,7 +2835,7 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
@@ -2825,7 +2851,7 @@ add_addr_ports_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -1 -1 speed_10
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1
@@ -2838,7 +2864,7 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -8 -2 speed_10 "" 1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
@@ -3040,7 +3066,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 1 0 slow
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -3052,7 +3078,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 	fi
@@ -3064,7 +3090,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 5
 		pm_nl_set_limits $ns2 1 5
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 		chk_join_nr 5 5 5
 		chk_add_nr 1 1
 	fi
@@ -3077,7 +3103,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -3088,7 +3114,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow fullmesh
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 1 slow fullmesh
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3099,7 +3125,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nofullmesh
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nofullmesh
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3110,7 +3136,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow backup,fullmesh
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 1 slow backup,fullmesh
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3122,7 +3148,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup,nofullmesh
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 0 speed_10 nobackup,nofullmesh 1
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3132,14 +3158,14 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 0 fast fastclose_client
+		run_tests $ns1 $ns2 10.0.1.1 1024 fast fastclose_client
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 0 fast fastclose_server
+		run_tests $ns1 $ns2 10.0.1.1 1024 fast fastclose_server
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
 		chk_rst_nr 1 1
@@ -3287,7 +3313,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 slow backup
 		chk_join_nr 1 1 0
 		chk_prio_nr 0 0
 	fi
@@ -3300,7 +3326,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 -1 slow
 		chk_join_nr 0 0 0
 		chk_rm_nr 0 0
 	fi
@@ -3310,7 +3336,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10 &
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr 10.0.2.1 10
@@ -3332,7 +3358,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10 &
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf 10.0.3.2 20
@@ -3356,7 +3382,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
@@ -3379,7 +3405,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 4 speed_20 2>/dev/null &
 
 		wait_mpj $ns2
 		chk_subflow_nr needtitle "before delete" 2
-- 
2.35.3

