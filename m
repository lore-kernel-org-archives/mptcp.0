Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD0723C2
	for <mptcp@lists.linux.dev>; Fri, 16 Jun 2023 07:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQ5BG9KVGYizKFXj1Azo7ET6BwpFhx1qfw+iaGlnGkQ6bFnba/9XINQ56I9vVhHALiifu49f5BxXSwu1+x7aX+dcmgfhWenenJcJrtCVTBuOAKlc9yqfOjD5sugnCSLiO5qs3hO59u4ZF3xNTorOBwblEeexzh04CasyUsKbmxBVBLPzy+wNcIw4K5S9H+zq3RPlI5DQp2P4+ZaMhI90LIXMSoh3j8vThIFfSDGiJDy4RvmfNGIexda1S67U86ilYL0Xj312DjR/43OHFL7CnQGe3iAA7zRr/eqPFcQS8Fefs6SxAKYPlDlrMb9y1wzp0oPYk9GZN4BsovE+/1Ixqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9Nwn73aXNohQPkPK8xE+JEiezsFIiKVCPWqvAb8XNE=;
 b=SlN+w+/L8cNu8QbZ4+8jrLPhrgZwYE33RTj5nIudNh1mYnxjMAc/oDAFkOLy5rGEPZWxF2I6/v1L2HE414+0neRamwpqri2pKiomfEhtmR3kmPK8N5+XqB3CThhfIbA+dbLhsr1hOV5edpt1388nvvFmcRFCpT/ShOcfvLn2mHHphzF57y1AQXY8zCJTfx9kHInETWSxCeMduOJ63x9BaybtbjGjrxHuzyuQLPwGXHAuiRGGUe0DJqypxzYT4iapPdlGMgJrd/2zKmAWB/0Ij25u7Oyipz6OgftqWfH1Xfsng+23jAHvvrydBKB9g588WA4Y5bdFjXgtaz8D9W4JWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9Nwn73aXNohQPkPK8xE+JEiezsFIiKVCPWqvAb8XNE=;
 b=MBe8wFpQy8uZq6zDbOx0MZEHbk1Sa33B0ncLquBxgtm/nCL/zS8qXHc/W+VOKlPXrn8spsxLl8kGXfCwsUDsaDnXJpVEYjOmSlRf4B/H997HlDFXZHGsSMpH5rheTmVlkRu/9/uFxlTv3Wz0P+lyBaHXhVYXThuRBdfrSM4GLtpOyOgUdGbppP9xuWKvmnwe8FSX7brcPR04xs5ZJfFONSUlADvDLL76nJTAgtTJXGq3ufeUoi68RNJ2DkuTqM/cq8ymmCnpDW0qsCM5Tmj57fhWR5AAsu6UFJB+UAJESWMAvlxgsbuNsayDWvbgJqf4KhhF7YCakIEVRe6OT5Z+Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM9PR04MB8226.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 07:31:24 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59%4]) with mapi id 15.20.6455.039; Fri, 16 Jun 2023
 07:31:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v20 02/10] selftests: mptcp: test userspace pm out of transfer
Date: Fri, 16 Jun 2023 15:30:54 +0800
Message-Id: <14db7188122fe7a2a13ca01e78225cd76b576a8b.1686900596.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686900596.git.geliang.tang@suse.com>
References: <cover.1686900596.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0118.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::22) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM9PR04MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 15fef9e8-cf89-4c1d-6af0-08db6e3baff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EUr6d0db56pSs3uA5ovQM35fbD6sDXaX7D59u4yYpRqQGJksJW7WY+8pNAtXsNDb2S5fJNdD5j8oTA4AIPzRJxQ7mYQ0XqoDGllpDSAma/Q/x4LYYV1pXvBF3kRqIg969gh0ib8+CZ02nKURVZAKN6s0RnnjdcMGJE8bO6kX05rnqBimohvfTR7YYCQLt/Wc0vN8nTXKG8DDWEmIzC6nbD0P7PSZlK/A/DZFyHJGV69/0G2YIoTBcUPRBZBvyWIBfRzMc0M4R6bPZiLBXJVCXbrjRQEz7v3QueJSGyykvFF8+Aq5jCyls2UxJq0pq6b5YNQT7vFW9h7sq0p7iIP0aWMmU9478r11X4zvSzhBf4aPLFuGTyryjoPJrRbG+m/YubfJ3ADQJ0PIHum/DFAsq89zC8yLnuPz4yJozwtXYYG0wKOYmSWPyUCE3ARM67mh/CdXArSc6ipmhTDM2OFf8vecSLyvvZGSuqFYTdITf5dsNw0WUVUoeHqTe+sK22HTB9szrnI/up35rpz/814JPsbGG6prGREFQlHJIRLhYwdOg3qGakeaZvEFLL9iy12+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(478600001)(6666004)(4326008)(8936002)(5660300002)(8676002)(6486002)(41300700001)(6512007)(6506007)(26005)(44832011)(107886003)(86362001)(66476007)(66946007)(6916009)(66556008)(316002)(186003)(83380400001)(2616005)(2906002)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hrmkIi8HnofOp9Rlz0sWLch66nFFOePwt/0OfsVyZ4SyM4oZqucwiWlWj/3f?=
 =?us-ascii?Q?IIl01y4k4T1hDfWiOjnMyRsWT9BGCBZzmfuV7+3YXoQVbfeVYB8vD6Ga0p0d?=
 =?us-ascii?Q?Y8OWK98MckGT7muVXLYcUJbBvi33WzLLqmc7gbwtFD3O5j8xxPJmp3yM/G25?=
 =?us-ascii?Q?Yb9jRryT1mC2VVi1Do/D/fqTlUhcsHAKqXtYTC/HxDwynWYIqXC1v7PnPFv0?=
 =?us-ascii?Q?64/c4gQC2b1pk9FAa5nPJum7WnZfba3rC3kqEVHmd5qRzoBm8FjKZDvfB9an?=
 =?us-ascii?Q?lf1Aj9ATyiiGnm0yXvzSEgmRNx1C8LfHqAQ8Y07RSbbBrFkIIrp/z1rViKe0?=
 =?us-ascii?Q?uGgRkGrL8WyJF9T+NDxIvKde5KPs0teGxNbYeGJJR8HkhryWP1j015rT32Lh?=
 =?us-ascii?Q?yuQru75XYi4tWXrT2b8OhyxvdE0mUs258BbDbY0PzD6ln/yB5O4zorbTBj0P?=
 =?us-ascii?Q?bPDF7Yjp8AqFhKUday8bkAScO55M+/wMswEDTK4UrfDKcgLEkO72ff4Y5drs?=
 =?us-ascii?Q?WfRj1OGhjqDUioi7yE4L9jbE2BN/Fiz6kUjE4yEXMCrX90c798juommGqALY?=
 =?us-ascii?Q?qSCclbW9VgRdKuEjAKW34kQCY9n6VxX2Bv7nXFlQiGQRL63NptVulcCjNTkX?=
 =?us-ascii?Q?MQAUn6K9Z1qrcNuZyrAqGCDZ/64LwCIag9ClnyMom7TmdSmnQAS4kvS9PCOf?=
 =?us-ascii?Q?g7Qbfzz4frJQpcvREyxYvHejaudINqG3swqotQPjJHkSWA28eWoteW5ByTXX?=
 =?us-ascii?Q?mqbjlm6qCOK4Jicb084X54Rv+zrSOEBwGRWpoEz7z9+W0xWOZdcS/eXetZ+F?=
 =?us-ascii?Q?wJqgv2JK1RfM6Y6JE1FKspehXJcqlXotiK3iDNbjXi4mL0e8MNDI4Vm3D0i+?=
 =?us-ascii?Q?mZG74Crq11/rtXceMJEbimDCzvGEucJOwaTFb5n5VH+KRqsWgpTvbXtLQzz+?=
 =?us-ascii?Q?fpjHuEdA7VtIUyXNjWrE+ptlYwtm9D8ynvToZy1HsXl+3UY54rOiput6u+y2?=
 =?us-ascii?Q?R7CYkT1+1wb6WHvjeaLtAb6SYE3+brEqrpLGU7XNIPjpqLLFfmTV102uGSqv?=
 =?us-ascii?Q?uyiY4KSK++NqBX6K6+ZOVnfcdiWSgqAGPhdyBcDvJfm8ZOV8DPhMAUEngzSv?=
 =?us-ascii?Q?ZTpnneUcvlBFcjhDOSR20qONXIcjXn6X2iS+RKCMo8vLEgG87RfJ1CVrbeCX?=
 =?us-ascii?Q?0n/cf9WRf/covjmgngBdpa2hEm8zOvD8qib71YVZjvUrFuGxzVOHAvPHMOTi?=
 =?us-ascii?Q?+kC565krmdPsjE86MCD1Puid1aAUt0ivD6njY32Nlojc72k8/cKUL9s3LkgX?=
 =?us-ascii?Q?4yscovjdVUpqQ1uvjnBlS4y7aucvsYhhYCho8l783FCyrpw0JK/c6hctEBol?=
 =?us-ascii?Q?/wUsVLJHLvI94SijNKQjwQOoO2Xt309k90N1XvgDWms6QCBZyFOgPlVhQwzP?=
 =?us-ascii?Q?g12hGFR0Qemq5OagZwvjf1DXB2DFoH9xt99+0kdePp6oZrO+SStdwb70pPnA?=
 =?us-ascii?Q?kGGuYWvC+skbOhNxQGoqI/plzYKQ9VyrY/QVQKegyu7egC52u++IRDKkoYcQ?=
 =?us-ascii?Q?Lwmjj5XWVRsOnhwH63fDxHJGea4yoKfrOcPigY9W?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fef9e8-cf89-4c1d-6af0-08db6e3baff8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:31:24.0200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRyODwDA6Q+AL5ItdXKiVOBB/E6m+q5iLwWERCTwfRN8e7oKD3sPiFIMSpn8yzfm6apLCY+Ys4CJfZlpdXkMYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8226

This patch moves userspace pm tests out of do_transfer(). Move add addrese
test into a new function userspace_pm_add_addr(), and remove address test
into userspace_pm_rm_sf_addr_ns1(). Move add subflow test into
userspace_pm_add_sf() and remove subflow into
userspace_pm_rm_sf_addr_ns2().

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

