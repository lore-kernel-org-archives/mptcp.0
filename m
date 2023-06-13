Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A7361
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 05:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQlc6w+1Rd6d1Mbmf3ViPKgELxeQxUue8LXiPXCy2iUru6PhSoj/vKddK0LbMqewRkcqi7xx9N9pqStIoY2fLxei8+35PRxK/aJAOrujFR9LAKEg/L8lsn0koKKWar3jan7XKaUG9L8a2tXhxli9uyhds7HjP04oNIzY12ueNw8Gyw/9x7vmMeBLWtcy4cmx/QtxAkLaY3ZiRAPaj8xNkG7j55tI0Xj7okJ3/C3BZNaPXYg1OSm+1GhZ54Jh875Rh7fyn3x5BghW0R/FXaVYPDI88i3bcvFLC9nj3MnA4cToUP7UhWsRfC8HTAcHtidcbT6bLdbxBbtjjXo5MiUn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmFsQCZhRAnAfNqk5ZD1lOpOs7MjaAZqub+gxXaskW4=;
 b=AJ0Lol18OV2xFesAHjop1f/d/Rf1BqxXpKUAthOhb5gsTG2TMNU6cTyRQWgHJnFsr3oTK7RZiiPzg8bsqaEbdKgEQVtu/sD2yR8oT8gU+u9ouB907nWA6LfpC9JxT5iIRXG+sVwEpCPka6GsaqV/Zl3wMKav3hHi3Iw0cOa4ZJmfNKNrr9vEzMbzzX7tKgZo15TmtEwVRFKTfkYAtlEbKdi7xLpSFWiLsmvngtqWUlQWB3i13PJaMAFe8vz92GZ+uv0oaH368FS6eS5d+2rtttE2vwU01sYEFS5oU7vfOsDFSWz1eTs/u6v2EmoxwHUnGTxeEcBc+SuovgQV4S92lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmFsQCZhRAnAfNqk5ZD1lOpOs7MjaAZqub+gxXaskW4=;
 b=PVsT2KWK5VvIOZbWYfTvc1U8lFCgsHKFOICguAFAIdWu1fdzYbF3V/ZjHdfOnoJaQRfNtf+Ou2NZQGY1wwQxd/02YbnTJpUwR+vzgpv4LjLnTgxNV+BHSQ8o4Eea7zw3qJ230P/QTLeG9Bq0q5hyH2JfkE2Xnt1YmTOt4jOg9uQK1L2IsYrZZlGtHR5PgjbSVeFL5/iUZXNt3rgNMPSvjhERUrQaLrrF6GDS+3cH6rZmCZpyVlN70haKpnreR7RqEi0qWMEZhP+vrDvY5kGXfmw4v76sy0xh9aKn4HDLbbNmMStlm1NcmqRbGPz01ug6MaB0Gu7S4PBAR6vI0Z6Leg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9504.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 05:31:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 05:31:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 2/8] selftests: mptcp: test userspace pm out of transfer
Date: Tue, 13 Jun 2023 13:31:09 +0800
Message-Id: <393f054fd2acd5cc6ba77117d83a73a6f65229aa.1686634037.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686634037.git.geliang.tang@suse.com>
References: <cover.1686634037.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0120.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ab4512-1190-48d6-ce89-08db6bcf7f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IuyKfYEKa4LL/O6+GI5PxiV9L1IqTZUan8VK0o8bjCVVZSTewAc+s3vhNgvrqVQWsF/HRdyVUr1uMFSQj51TyGlfAb/2RNt1VfHVRtC8etba1rpyY/XZVqL4FKmDZoL8IqHjjgF3Ch7dv8BG9A/rHQ+uGsKSb5eHirhZ6NU66g6BEDQYikgvqDS0M8g4L7D4d9rptggcP4r4YZmrlU76XZQYIVNNx2FXXn2ZEYiPncO33psYObOAEptQkw8yiaxyqFJJt3MEMPfYs2jqOkuDFNvKpZJJHgWZUMrCclzBgEiP57PFu1heeK+SpcC+Dq+wFNwcZFUq3LA+BE20LGlhd80BJBrON/rHrl3oqtdQvl3AmL2c4iMKfdy3640+aj6pFT2a5vXJy67Be+CLq2TLcnuacnYWctramtgAvxrOexwCWCU7hAR1e5luIhGH/mgTAYilZZaJqPQ3Zcu8kcPT8JSUz8plXxyl92540iC4K90qT1jerWPKQUA/QHCr3v2HgXq7SqikyAwoBBf0IGwzi+1VasQx0+kd/XSfjHH9BHc5Mm7LZCEukadrQbepELVc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(36756003)(2906002)(44832011)(86362001)(2616005)(6486002)(6666004)(186003)(83380400001)(107886003)(6512007)(26005)(5660300002)(6506007)(478600001)(66476007)(66556008)(6916009)(41300700001)(316002)(4326008)(66946007)(38100700002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cLH/s2195kjDcIsCljHkBL1lxMfZrmpGRpTDMkatcrtU1IaeKLM1CPnjCB6f?=
 =?us-ascii?Q?CSuGJgFd1rN3pRAgBVzO0j2ZkozR952AA1Nyshi7JeIwfctsvZVJUg7J1vem?=
 =?us-ascii?Q?cYs2hnCxddDT2dTDwouZr0vNA9aVe9c6mXwFpIHy1ZZYq8Hg2w9u2SpIZNrq?=
 =?us-ascii?Q?YXBbuFozAZIwo4lWuPtjq/uS1j1QnIi2wNxkG1IT5kw3oqVn4NiCbf0E4wAo?=
 =?us-ascii?Q?E16y5KgS18ZQeS6rbcqPUQG67LAvPo1RbZjWr6Y+FbE+N2OriFpt65xVe7si?=
 =?us-ascii?Q?x3HGMkM4zNI+DkrTGVBcZ1A//5dEmSwlsHrXoI3+u5olX+PIPtC0er264CM8?=
 =?us-ascii?Q?hvalXvVekEVgwx4wUJtioT4fJ897GfMWVVEwIHF+xz63//fhx2ZrEodQtEL3?=
 =?us-ascii?Q?7eLoIfCm/I18eHLZbv0f3MWZxgcaQzIaiPzOxD8XqhMV/yivpzJEVY3fHkhe?=
 =?us-ascii?Q?INw/5QT+d+NbaXrHx0CieMugR8pYdQj6ycG4Q//Vj074bYEE5sITdsvBF1D5?=
 =?us-ascii?Q?uzzFs5AywP8MP2dAuxjFqRqLscf47oLn5ccqtW9c7NtFlBG6CTzoyozUsRgh?=
 =?us-ascii?Q?R6QI1rvutZes0IK2Q908j+Pl46PXLws5uTZyguxmR0426quUVZs4ss5llimF?=
 =?us-ascii?Q?9GraINmFd6Ad0dF41lsYALsDvQ8HzUJWo3r3zyO6agk9N46l5/fQP9/CzkoV?=
 =?us-ascii?Q?OyvShyBWdFsedZzldcg7A+/cXCi4JUFN5jabKCxuTSeU7I1jAVXby5Hm5bY6?=
 =?us-ascii?Q?5hqcQ9iqg2XCnqHVJSp8kB46lPRoqVsRdcugV9j081jLT1nXqupOOjvRlljY?=
 =?us-ascii?Q?tlEZZ7slNGb+RRU3EX4KkucbTB7ycalSv9lM1Hh80KBFK1tvlaLtzjZP1F6G?=
 =?us-ascii?Q?856WRXhS8Ys0LI9TqFk2dvcGNniQ9848L7207f9cKGPgIpHeMuJGon5a5kgl?=
 =?us-ascii?Q?LsjqPQvr78QC3u9XyOK3ph+DV4yMtRmor0BDe1K0nggyUJyUSJ3aGIWxJLXX?=
 =?us-ascii?Q?Qnn8OCttIwFOmSowDbMi60rIdyCtDUNQng4kw8ZLXntkhwInCC7pTO3NpTu5?=
 =?us-ascii?Q?J7ViwhMnzDH6hsTjnandMDRpKOaiisuf3LCnnDyLH8QF8yZqHXrk9qmRfVC0?=
 =?us-ascii?Q?UoVNDpsURU39Qb35mXtcRkPGuvwQSza5j9p7YoSjKjt0s7bn5YfpOhUo9d+R?=
 =?us-ascii?Q?FM5LuNdEMdnQPyfesxNATXvShaysKC2JUQ8A3emz4dIWzgNj0LUPbladNB6w?=
 =?us-ascii?Q?BEjp8fin1eCNxyPoUv5DIsSY43mHxeW/eYd2g7FNGrkoqQyWPLvE+sn+ISnK?=
 =?us-ascii?Q?E7HFDrSYBPDcZXpXOdx/GnY2jebbsl0MEejgskrI08us51h6PflH+9WlH0Ga?=
 =?us-ascii?Q?//tbDa3wwVZ+33huUU36t70iOWfLnIIOqwaWfieBN0Eb+OJcnTW2m2VoSmMK?=
 =?us-ascii?Q?/AFB6su03S3B+BWMJPklfmOMOLSJrZ8e7t3rBpYZApz4JEN72OLMmXI1DLs5?=
 =?us-ascii?Q?fqfzYpCRsEFXRGmW46TY5rQhJXKZTlE0cYZvZCgXZdl0D61kGJqTKNjzB66e?=
 =?us-ascii?Q?CijuGgWhGH3CxYBVZ5uFEwsetIy/tGolfc21GmfJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ab4512-1190-48d6-ce89-08db6bcf7f9d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 05:31:54.9992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxHJy5wwhJPaB5ncNhtq9Y6FRzEo4nNBJ8yyrwGUv+cda/h9q5488Ke9jrEA2+KWyz44zcuU8kaQyXMgn5D1gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9504

This patch moves userspace pm tests out of do_transfer(). Move add addrese
test into a new function userspace_pm_add_addr(), and remove address test
into userspace_pm_rm_sf_addr_ns1(). Move add subflow test into
userspace_pm_add_sf() and remove subflow into userspace_pm_rm_sf_addr_ns2().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 145 ++++++++++++------
 1 file changed, 99 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a7973d6a40a0..3baa6ac3b03e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -589,6 +589,26 @@ wait_rm_addr()
 	done
 }
 
+rm_sf_count()
+{
+	get_counter "${1}" "MPTcpExtRmSubflow"
+}
+
+# $1: ns, $2: old rm_sf counter in $ns
+wait_rm_sf()
+{
+	local ns="${1}"
+	local old_cnt="${2}"
+	local cnt
+
+	local i
+	for i in $(seq 10); do
+		cnt=$(rm_sf_count ${ns})
+		[ "$cnt" = "${old_cnt}" ] || break
+		sleep 0.1
+	done
+}
+
 wait_mpj()
 {
 	local ns="${1}"
@@ -813,7 +833,6 @@ do_transfer()
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
-	local userspace_pm=0
 
 	:> "$cout"
 	:> "$sout"
@@ -850,11 +869,6 @@ do_transfer()
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
@@ -882,9 +896,6 @@ do_transfer()
 			return 1
 		fi
 		addr_nr_ns2=0
-	elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
-		userspace_pm=1
-		addr_nr_ns2=${addr_nr_ns2:10}
 	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
 		flags="${flags},fullmesh"
 		addr_nr_ns2=${addr_nr_ns2:9}
@@ -938,7 +949,6 @@ do_transfer()
 		local counter=2
 		local add_nr_ns1=${addr_nr_ns1}
 		local id=10
-		local tk
 		while [ $add_nr_ns1 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -946,24 +956,7 @@ do_transfer()
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
@@ -1008,7 +1001,6 @@ do_transfer()
 		local add_nr_ns2=${addr_nr_ns2}
 		local counter=3
 		local id=20
-		local tk da dp sp
 		while [ $add_nr_ns2 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -1016,21 +1008,7 @@ do_transfer()
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
@@ -3205,6 +3183,71 @@ fail_tests()
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
+	sleep 1
+}
+
+userspace_pm_rm_sf_addr_ns1()
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
+	wait_rm_addr $ns1 1
+	wait_rm_sf $ns1 1
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
+	sleep 1
+}
+
+userspace_pm_rm_sf_addr_ns2()
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
+	wait_rm_addr $ns2 1
+	wait_rm_sf $ns2 1
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -3283,11 +3326,16 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr 10.0.2.1 10
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
 		chk_rm_nr 1 1 invert
 		kill_events_pids
+		wait $tests_pid
 	fi
 
 	# userspace pm create destroy subflow
@@ -3295,10 +3343,15 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		userspace_pm_add_sf 10.0.3.2 20
 		chk_join_nr 1 1 1
+		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
 		chk_rm_nr 1 1
 		kill_events_pids
+		wait $tests_pid
 	fi
 }
 
-- 
2.35.3

