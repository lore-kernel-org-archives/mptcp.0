Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4EC1381
	for <mptcp@lists.linux.dev>; Mon, 15 May 2023 02:12:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amAfF4ykXFMn3eErrIcXg4jWy+iggtYNo7v7Hx8B/5Y1QUfY7Uk1m/MD4cZr5vqvEPZjrwO1bd0rzpI8gCGfJfrDlW0FCf95ycpnWlFAVcBxO8BFFKSAr9XSs+MT7svaJ59VAP00Z1GKoykgN+q4aiTAH9HiZAXlRjnGaGBjRwtBIh0E6n0egVz9gVV1xY7KA0Qu91qqY1rLPIK+AZb6DjGul8PPgKIKPPK9NYe9UAXwh0zinbsp3KGrWGEBGmpX0R9miiHuKPhYUBkGOA3eVJltz7uaWVoHxril7mlBi8Lfhu4SDo4ZICC75m5va7D1hFTnrPUsXRUj3YrJ+qdxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sF9hPodpYBzqQOIFNUGISJo6c0LmLUv6QS2uPG50Mwk=;
 b=muhYnrVbKHPpAsPO02E1nDlBvKKrzZ8y3ka4P5U296gbKP3VDy87o9+/loNUn/XlpGp7WAPNlT+ZH3Z14hQcxs4y2t2o2q7sjZkAkMsWr4LXSZXcEx1Voikr4nftKeHd2DunIt1EyrMTLDIbsWap4ZMcOkZZxIUSzzLqIxxksWbw9p7gKRhewKqMQRVBHw1kT8FV2pSnOC/oFjAPGd0CvPzD5U+OhbrSj1Jc1DDbGgZWFm4837NsRGfvQQGs6nICg/IFNijaSQooihnt/2zZZJh/RxlKnmnLnNiK0yAXupNHgEn4pS5EViKPYqKhAcef74n2p51vfEOdAG1CVx2ALw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sF9hPodpYBzqQOIFNUGISJo6c0LmLUv6QS2uPG50Mwk=;
 b=ihATB4zuXfZXDkibjpZ6ltw2sLsaZBmhBqAmDYz7u497/5zVGwa/uKZHBdDMbs/R9hIErDryqW0Y6RtVyQfCXjpJwCKbqccKn1dfN0j8fmQm7le85YfhN3MsI2lue3x/wfybNY7M7jmomUF7lNwcvFlQZ14qwTDWx8fUkK61SdzHpxsvvhf6MUGBqsaOFwlWMJkfChMq/UQJED5irk9WnvfZk7O8Hn7GfMXAfE9Ww/fnsPuG2/2MFEJyPtVvbw1usbHCIhy4xK7ZTPlCYCGctYfwWLaLzDhJTydxHSBDVucBgoblNFL1fwClS1sodsSpObAG4d15IAEn5svw/gZLgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9361.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 02:12:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Mon, 15 May 2023
 02:12:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 7/7] selftests: mptcp: set endpoint out of transfer
Date: Mon, 15 May 2023 10:10:58 +0800
Message-Id: <bd1066b5d9c1eb7c3b917677e9bd96b3c820aff8.1684116357.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684116357.git.geliang.tang@suse.com>
References: <cover.1684116357.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:54::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9361:EE_
X-MS-Office365-Filtering-Correlation-Id: 8102da42-3f29-4ef7-3bb8-08db54e9d4fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J40MuZMrK4MtLV0u2g4CwGDQJBrLvdQp1K3r0MKsR+wdc+Bl8rl0F1nwWFlrDAd0RG3w/R9BHr9qRYa3kBliRUvFS1Yvr1apL8xCGEv4TG+bJkVwTShbKsz3O2+WRJN7K3Qdu8MYX29JesLYu9D37sRnzPPDNVzp5UjAosf0nq2VQfzDYMjAjqy/i20iY6y7hWPyoIXet7CooMsOEManx/JiL9ZxBo9LnY5EiPSgHuFLuFDBCfBc117YkHrOS6P2QbLPF36UEt0BN7ipcIzp/5hHqoh1RM+R0668zg0UYSgegT9DZpfO/Qujv8xzhqxLJcpjXOtRYZYUyPFBuTszIjqn1fhY0toqO2ey9xb4QcZGbOoZEpad3V6OntQFLTx0x7bFyL6GU2km5yhfX58I11V8pz+bQ9viwvJFZPMH7bMyJ7D3xOj/yUE+OwZE/DJ1Q5ed4PH6a5xOwnFVCFhK+LTuepGOAIgzl/U7gjhdV4G7Bo1KZzP5MVJ179i8gaU06TrYLO276c+C4f6oXKxJnARHUapWZOytiyw63KtnqPaiEFMX0YNYq9570+J7Ydqz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(26005)(6486002)(6512007)(6506007)(107886003)(478600001)(6666004)(186003)(5660300002)(44832011)(30864003)(86362001)(8676002)(8936002)(2906002)(36756003)(41300700001)(4326008)(6916009)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TAJLwCzmLWXY4U4tHwNJQc61eBqeAS1E9YHvo0Hucxv7MkzCDkzG6/QXfoua?=
 =?us-ascii?Q?qJiLyTVgaSOVGrcxCaMXGM7SInVT+zhU669AIsXviOyEuNbyxLiVQSYq8cop?=
 =?us-ascii?Q?3VL4mA/IvOVApmRS4L8F6MnonQiLoy2H7SGSWQma2oyBHWmlUfDBkuM48lha?=
 =?us-ascii?Q?QX0J9S8h8OxzMJz+vpAeoT5lXuqo0qjR3SeHLVAEysjQJkVxGYx5E+zg9GOz?=
 =?us-ascii?Q?AgKw0LU+mPEmeeRHSM9Vl2PTz6XxH95hy3230XiC5OajyVEOiYJmhBlucYcm?=
 =?us-ascii?Q?Zj6UH/8HQoF5dsEljjOZ3CPVtPShkEt5rBmvvfBw/w1rOzrWz0pku9wYX1B8?=
 =?us-ascii?Q?TlptBgbyRnSW50/hwULKyH/s33yXU3GbvrkK+r6N95Ktecq4ysZIR6tvdhzx?=
 =?us-ascii?Q?xWAqHFH/gkqd7CMJkxueFDmFh88n2Nhtm9N2V66XESdW11B5jJn9gDRzrmXw?=
 =?us-ascii?Q?gqfkO0LWwEFuUy8PlXZKW99iY04uLZOAh3xm5fCGJzmIrcu9FwXlxLrYlM0S?=
 =?us-ascii?Q?SZqKldPbNP310h5FzzFE3BeABGwEbb9/sMVFL2KHLz8pSc4uZOHyKLIb0t8Z?=
 =?us-ascii?Q?uJZgPnUka3t6gpIi/OIxXvUrb5Gy+0OidW211Ilc96BsYdzz7NRiRQS1VRLM?=
 =?us-ascii?Q?NmnIWRCrW5gAS3/QZrvKrpJpBAXgz2kQgJaUPVBLmC2GV+M4ETJJl0nzp0cN?=
 =?us-ascii?Q?YmPuoBnwftE+bMdHojXmJoHq+TCxK607Oqgd2iOp4/FgyvtTqe8xqCC2dgkp?=
 =?us-ascii?Q?+z6JM5IZ8PHklzrrM5sblcm7EKl2im1VxCInvjukAz28nhVL7zBGK/I3y6By?=
 =?us-ascii?Q?29y1uJU+L45u57oDk0LHhDclTAjO/XaKM3sNa3ZXDbvP5TRxIoN222nD5SmR?=
 =?us-ascii?Q?mjanaf2reeA3gzSsUyn7KoGR43yc9CEz/lCeUqz9K3WtsfZeuD6mpD0qvPff?=
 =?us-ascii?Q?zGOin6ca90dyN2DvWAxHBSzwxhjvplZ8gzQa0Xzn4JaCe6JTEKb1EfL+3jmC?=
 =?us-ascii?Q?dTU92fKuqFoE5chXxBO+1Jp+/zjIz0Kp/s3aVDDuC+FhkakMWzPyRW2+Gf6K?=
 =?us-ascii?Q?jugad/JbVFslNCa2duLklj2VPehSOGxjYro1Val72Ps5lOsHSuNR2CIstjtz?=
 =?us-ascii?Q?UccJZe8IxwC+03K3UCz5hFgxREfxxylcKMwUFX8arJz6/Z2Tk+d1ydqaarWM?=
 =?us-ascii?Q?YSJdDsYv0w8t7qlipz7ywv75MwT06JSFVKZgtMZg2ccApMRZUAtlHsSX+isp?=
 =?us-ascii?Q?jIuli3EeQXfZPoQTdJYspskL+6mLOu3XgyYyzbOejZtY3QWweRKmPiHbpQzN?=
 =?us-ascii?Q?+gl5jtpJaf6v22TgQfFiqiz6LTOADynGFQafpjNojyiHOg0r9cKLYAsMO+hq?=
 =?us-ascii?Q?R8GLc0/S/N6MMMVtWy58cHTeYZ6VjqtIDcSu2XdJoTbLC+44CVYNA+vNfrtz?=
 =?us-ascii?Q?xt4GAdoEBD4P05cWA1GGqShRaC+pgAOmxWqj2EzkI11S5/0ZQrLNNOcTeLiE?=
 =?us-ascii?Q?bjwOujKgG37tLbNdonhzIBWw2pRda/MIUxn0c4ZSFkrgDEhpxJbEjmuiCpY4?=
 =?us-ascii?Q?YbPmDU3rTO/0M21jbQigvKsQiLTwuPIIosf2piVf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8102da42-3f29-4ef7-3bb8-08db54e9d4fb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 02:12:28.4719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVzfk9I5WLWfZZPJXjm/1MUuKX/jX01EEYc1O2s7I+k7z7mUEZ1idxBhfVp/BHNhQwslDjgvqxFfBXtbiB6UpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9361

This patch moves endpoint settings out of do_transfer() into a new
function pm_nl_set_endpoint(), then addr_nr_ns1 and addr_nr_ns2
arguments can be removed for do_transfer() and run_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 549 +++++++++++-------
 1 file changed, 347 insertions(+), 202 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d749ab8627ca..3a4eca0714a0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -699,137 +699,19 @@ pm_nl_check_endpoint()
 	fi
 }
 
-filter_tcp_from()
+pm_nl_set_endpoint()
 {
-	local ns="${1}"
-	local src="${2}"
-	local target="${3}"
-
-	ip netns exec "${ns}" iptables -A INPUT -s "${src}" -p tcp -j "${target}"
-}
-
-do_transfer()
-{
-	local listener_ns="$1"
-	local connector_ns="$2"
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
+	local connect_addr="$1"
+	local addr_nr_ns1="$2"
+	local addr_nr_ns2="${3:-0}"
+	local sflags="${4:-""}"
 
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
@@ -857,7 +739,7 @@ do_transfer()
 		if [ $rm_nr_ns1 -lt 8 ]; then
 			local counter=0
 			local line
-			pm_nl_show_endpoints ${listener_ns} | while read -r line; do
+			pm_nl_show_endpoints $ns1 | while read -r line; do
 				# shellcheck disable=SC2206 # we do want to split per word
 				local arr=($line)
 				local nr=0
@@ -869,18 +751,18 @@ do_transfer()
 							break
 						fi
 						id=${arr[$nr+1]}
-						rm_addr=$(rm_addr_count ${connector_ns})
-						pm_nl_del_endpoint ${listener_ns} $id
-						wait_rm_addr ${connector_ns} ${rm_addr}
+						rm_addr=$(rm_addr_count $ns2)
+						pm_nl_del_endpoint $ns1 $id
+						wait_rm_addr $ns2 ${rm_addr}
 						counter=$((counter + 1))
 					fi
 					nr=$((nr + 1))
 				done
 			done
 		elif [ $rm_nr_ns1 -eq 8 ]; then
-			pm_nl_flush_endpoint ${listener_ns}
+			pm_nl_flush_endpoint $ns1
 		elif [ $rm_nr_ns1 -eq 9 ]; then
-			pm_nl_del_endpoint ${listener_ns} 0 ${connect_addr}
+			pm_nl_del_endpoint $ns1 0 ${connect_addr}
 		fi
 	fi
 
@@ -909,7 +791,7 @@ do_transfer()
 		if [ $rm_nr_ns2 -lt 8 ]; then
 			local counter=0
 			local line
-			pm_nl_show_endpoints ${connector_ns} | while read -r line; do
+			pm_nl_show_endpoints $ns2 | while read -r line; do
 				# shellcheck disable=SC2206 # we do want to split per word
 				local arr=($line)
 				local nr=0
@@ -924,16 +806,16 @@ do_transfer()
 						# rm_addr are serialized, allow the previous one to
 						# complete
 						id=${arr[$nr+1]}
-						rm_addr=$(rm_addr_count ${listener_ns})
-						pm_nl_del_endpoint ${connector_ns} $id
-						wait_rm_addr ${listener_ns} ${rm_addr}
+						rm_addr=$(rm_addr_count $ns1)
+						pm_nl_del_endpoint $ns2 $id
+						wait_rm_addr $ns1 ${rm_addr}
 						counter=$((counter + 1))
 					fi
 					nr=$((nr + 1))
 				done
 			done
 		elif [ $rm_nr_ns2 -eq 8 ]; then
-			pm_nl_flush_endpoint ${connector_ns}
+			pm_nl_flush_endpoint $ns2
 		elif [ $rm_nr_ns2 -eq 9 ]; then
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -941,7 +823,7 @@ do_transfer()
 			else
 				addr="10.0.1.2"
 			fi
-			pm_nl_del_endpoint ${connector_ns} 0 $addr
+			pm_nl_del_endpoint $ns2 0 $addr
 		fi
 	fi
 
@@ -968,6 +850,130 @@ do_transfer()
 			done
 		done
 	fi
+}
+
+filter_tcp_from()
+{
+	local ns="${1}"
+	local src="${2}"
+	local target="${3}"
+
+	ip netns exec "${ns}" iptables -A INPUT -s "${src}" -p tcp -j "${target}"
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
@@ -1038,10 +1044,8 @@ run_tests()
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
 
@@ -1086,7 +1090,7 @@ run_tests()
 	fi
 
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
+		${test_linkfail} ${speed} ${sflags}
 }
 
 dump_stats()
@@ -1868,7 +1872,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 0 0 0
 	fi
 
@@ -1879,7 +1883,7 @@ subflows_error_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		filter_tcp_from $ns1 10.0.3.2 REJECT
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -1890,7 +1894,7 @@ subflows_error_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		filter_tcp_from $ns1 10.0.3.2 DROP
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -1902,7 +1906,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		filter_tcp_from $ns1 10.0.3.2 REJECT
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
+		run_tests $ns1 $ns2 10.0.1.1 0 slow &
 
 		# mpj subflow will be in TW after the reset
 		wait_attempt_fail $ns2
@@ -2001,7 +2005,7 @@ signal_address_tests()
 
 		# the peer could possibly miss some addr notification, allow retransmission
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 3 3 3
 
 		# the server will not signal the address terminating
@@ -2102,7 +2106,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_tx_nr 4 4
 		chk_add_nr 4 0
@@ -2113,7 +2117,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 4 0
 	fi
@@ -2124,7 +2128,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10
 		chk_join_nr 2 2 2
 		chk_add_nr 8 0
 	fi
@@ -2135,7 +2139,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10
 		chk_join_nr 1 1 1
 		chk_add_nr 8 0
 	fi
@@ -2148,10 +2152,14 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 0 -1
+		wait_mpj $ns2
 		chk_join_nr 1 1 1
 		chk_rm_tx_nr 1
 		chk_rm_nr 1 1
+		wait $tests_pid
 	fi
 
 	# multiple subflows, remove
@@ -2160,9 +2168,12 @@ remove_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 0 -2
 		chk_join_nr 2 2 2
 		chk_rm_nr 2 2
+		wait $tests_pid
 	fi
 
 	# single address, remove
@@ -2170,10 +2181,13 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 -1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		wait $tests_pid
 	fi
 
 	# subflow and signal, remove
@@ -2182,10 +2196,13 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 -1 -1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
+		wait $tests_pid
 	fi
 
 	# subflows and signal, remove
@@ -2195,10 +2212,13 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_30 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 -1 -2
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
+		wait $tests_pid
 	fi
 
 	# addresses remove
@@ -2208,10 +2228,13 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_30 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 -3
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
+		wait $tests_pid
 	fi
 
 	# invalid addresses remove
@@ -2221,10 +2244,13 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_30 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 -3
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
+		wait $tests_pid
 	fi
 
 	# subflows and signal, flush
@@ -2234,10 +2260,15 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_30 2>/dev/null &
+		local tests_pid=$!
+		wait_mpj $ns2
+		pm_nl_set_endpoint 10.0.1.1 -8 -8
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
+		wait_rm_addr ${ns2} 1
 		chk_rm_nr 1 3 invert simult
+		wait $tests_pid
 	fi
 
 	# subflows flush
@@ -2247,10 +2278,15 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_30 2>/dev/null &
+		local tests_pid=$!
+		wait_mpj $ns2
+		pm_nl_set_endpoint 10.0.1.1 -8 -8
 		chk_join_nr 3 3 3
 		chk_rm_tx_nr 0
+		wait_rm_addr ${ns2} 1
 		chk_rm_nr 0 3 simult
+		wait $tests_pid
 	fi
 
 	# addresses flush
@@ -2260,10 +2296,15 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_30 2>/dev/null &
+		local tests_pid=$!
+		wait_mpj $ns2
+		pm_nl_set_endpoint 10.0.1.1 -8 -8
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
+		wait_rm_addr ${ns2} 1
 		chk_rm_nr 3 3 invert simult
+		wait $tests_pid
 	fi
 
 	# invalid addresses flush
@@ -2273,10 +2314,15 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_30 2>/dev/null &
+		local tests_pid=$!
+		wait_mpj $ns2
+		pm_nl_set_endpoint 10.0.1.1 -8
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
+		wait_rm_addr ${ns2} 1
 		chk_rm_nr 3 1 invert
+		wait $tests_pid
 	fi
 
 	# remove id 0 subflow
@@ -2284,9 +2330,14 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_30 2>/dev/null &
+		local tests_pid=$!
+		wait_mpj $ns2
+		pm_nl_set_endpoint 10.0.1.1 0 -9
 		chk_join_nr 1 1 1
+		wait_rm_addr ${ns2} 1
 		chk_rm_nr 1 1
+		wait $tests_pid
 	fi
 
 	# remove id 0 address
@@ -2294,10 +2345,15 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_30 2>/dev/null &
+		local tests_pid=$!
+		wait_mpj $ns2
+		pm_nl_set_endpoint 10.0.1.1 -9
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		wait_rm_addr ${ns2} 1
 		chk_rm_nr 1 1 invert
+		wait $tests_pid
 	fi
 }
 
@@ -2307,42 +2363,61 @@ add_tests()
 	if reset "add single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_30 2>/dev/null &
+		local tests_pid=$!
+		wait_mpj $ns2
+		pm_nl_set_endpoint 10.0.1.1 0 1
 		chk_join_nr 1 1 1
+		wait $tests_pid
 	fi
 
 	# add signal address
 	if reset "add signal address"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_30 2>/dev/null &
+		local tests_pid=$!
+		wait_mpj $ns2
+		pm_nl_set_endpoint 10.0.1.1 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		wait $tests_pid
 	fi
 
 	# add multiple subflows
 	if reset "add multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_30 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 0 2
 		chk_join_nr 2 2 2
+		wait $tests_pid
 	fi
 
 	# add multiple subflows IPv6
 	if reset "add multiple subflows IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 2 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 speed_30 2>/dev/null &
+		local tests_pid=$!
+		wait_mpj $ns2
+		pm_nl_set_endpoint dead:beef:1::1 0 2
 		chk_join_nr 2 2 2
+		wait $tests_pid
 	fi
 
 	# add multiple addresses IPv6
 	if reset "add multiple addresses IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 speed_30 2>/dev/null &
+		local tests_pid=$!
+		wait_mpj $ns2
+		pm_nl_set_endpoint dead:beef:1::1 2
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
+		wait $tests_pid
 	fi
 }
 
@@ -2353,14 +2428,14 @@ ipv6_tests()
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
@@ -2370,7 +2445,7 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2380,10 +2455,13 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint dead:beef:1::1 -1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		wait $tests_pid
 	fi
 
 	# subflow and signal IPv6, remove
@@ -2392,10 +2470,15 @@ ipv6_tests()
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 speed_20 2>/dev/null &
+		local tests_pid=$!
+		wait_mpj $ns2
+		pm_nl_set_endpoint dead:beef:1::1 -1 -1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
+		wait_rm_addr ${ns2} 1
 		chk_rm_nr 1 1
+		wait $tests_pid
 	fi
 }
 
@@ -2492,7 +2575,7 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 0 0 0
 	fi
 
@@ -2501,7 +2584,7 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:2::1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2511,7 +2594,7 @@ mixed_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:2::1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2522,8 +2605,13 @@ mixed_tests()
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 fullmesh_1 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow 2>/dev/null &
+		local tests_pid=$!
+		wait_mpj $ns1
+		pm_nl_set_endpoint dead:beef:1::1 0 fullmesh_1
+		wait_mpj $ns1
 		chk_join_nr 4 4 4
+		wait $tests_pid
 	fi
 }
 
@@ -2534,9 +2622,12 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 0 0 nobackup
 		chk_join_nr 1 1 1
 		chk_prio_nr 0 1
+		wait $tests_pid
 	fi
 
 	# single address, backup
@@ -2544,10 +2635,14 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_20 2>/dev/null &
+		local tests_pid=$!
+		wait_mpj $ns2
+		pm_nl_set_endpoint 10.0.1.1 0 0 backup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
+		wait $tests_pid
 	fi
 
 	# single address with port, backup
@@ -2555,15 +2650,19 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_20 2>/dev/null &
+		local tests_pid=$!
+		wait_mpj $ns2
+		pm_nl_set_endpoint 10.0.1.1 0 0 backup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
+		wait $tests_pid
 	fi
 
 	if reset "mpc backup"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2571,24 +2670,30 @@ backup_tests()
 	if reset "mpc backup both sides"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
 
 	if reset "mpc switch to backup"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 0 0 backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
+		wait $tests_pid
 	fi
 
 	if reset "mpc switch to backup both sides"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 0 0 backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
+		wait $tests_pid
 	fi
 }
 
@@ -2672,7 +2777,9 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 -1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
@@ -2680,6 +2787,7 @@ add_addr_ports_tests()
 		verify_listener_events $evts_ns1 $LISTENER_CREATED $AF_INET 10.0.2.1 10100
 		verify_listener_events $evts_ns1 $LISTENER_CLOSED $AF_INET 10.0.2.1 10100
 		kill_events_pids
+		wait $tests_pid
 	fi
 
 	# subflow and signal with port, remove
@@ -2688,10 +2796,13 @@ add_addr_ports_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 -1 -1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1
+		wait $tests_pid
 	fi
 
 	# subflows and signal with port, flush
@@ -2701,10 +2812,15 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_20 2>/dev/null &
+		local tests_pid=$!
+		wait_mpj $ns2
+		pm_nl_set_endpoint 10.0.1.1 -8 -2
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
+		wait_rm_addr $ns2 1
 		chk_rm_nr 1 3 invert simult
+		wait $tests_pid
 	fi
 
 	# multiple addresses with port
@@ -2903,9 +3019,13 @@ fullmesh_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 1
+		wait_mpj $ns2
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
+		wait $tests_pid
 	fi
 
 	# fullmesh 2
@@ -2915,9 +3035,13 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 0 fullmesh_1
+		wait_mpj $ns2
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
+		wait $tests_pid
 	fi
 
 	# fullmesh 3
@@ -2927,9 +3051,12 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 5
 		pm_nl_set_limits $ns2 1 5
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 0 fullmesh_2
 		chk_join_nr 5 5 5
 		chk_add_nr 1 1
+		wait $tests_pid
 	fi
 
 	# fullmesh 4
@@ -2940,9 +3067,12 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 0 fullmesh_2
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
+		wait $tests_pid
 	fi
 
 	# set fullmesh flag
@@ -2950,9 +3080,12 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow fullmesh
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 0 1 fullmesh
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
+		wait $tests_pid
 	fi
 
 	# set nofullmesh flag
@@ -2960,9 +3093,12 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nofullmesh
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 0 fullmesh_1 nofullmesh
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
+		wait $tests_pid
 	fi
 
 	# set backup,fullmesh flags
@@ -2970,10 +3106,13 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow backup,fullmesh
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 0 1 backup,fullmesh
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
+		wait $tests_pid
 	fi
 
 	# set nobackup,nofullmesh flags
@@ -2981,24 +3120,27 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup,nofullmesh
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 0 0 nobackup,nofullmesh
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
+		wait $tests_pid
 	fi
 }
 
 fastclose_tests()
 {
 	if reset "fastclose test"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 0 fast fastclose_client
+		run_tests $ns1 $ns2 10.0.1.1 1024 fast fastclose_client
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
 	if reset "fastclose server test"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 0 fast fastclose_server
+		run_tests $ns1 $ns2 10.0.1.1 1024 fast fastclose_server
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
 		chk_rst_nr 1 1
@@ -3141,7 +3283,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 slow backup
 		chk_join_nr 1 1 0
 		chk_prio_nr 0 0
 	fi
@@ -3153,16 +3295,19 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		local tests_pid=$!
+		pm_nl_set_endpoint 10.0.1.1 0 -1
 		chk_join_nr 0 0 0
 		chk_rm_nr 0 0
+		wait $tests_pid
 	fi
 
 	# userspace pm add & remove address
 	if reset_with_events "userspace pm add & remove address"; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10 2>/dev/null &
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr 10.0.2.1 10
@@ -3183,7 +3328,7 @@ userspace_tests()
 	if reset_with_events "userspace pm create destroy subflow"; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10 2>/dev/null &
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf 10.0.3.2 20
@@ -3205,7 +3350,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
@@ -3229,7 +3374,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 4 speed_20 2>/dev/null &
 
 		wait_mpj $ns2
 		chk_subflow_nr needtitle "before delete" 2
-- 
2.35.3

