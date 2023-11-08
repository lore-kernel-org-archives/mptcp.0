Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565F8199B1
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="kIx7Vqz1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+bVN9/njl9UjjILv6goTNeddb41CYMqKgezZwFEfDFaJ42wy/JcaOmlRx2Dqm+d/VreqaRc/xbyzmLv7VttnTCYpAJgsNggzNuVwTLSGithWIPjcLO6GmPFIhzkXi4WQQSHRvWlc8tU9tajwWIEqMZOPfEwgFF5Iue6bfBQwtMB9WkpLuO521cMEORc9JB8t9XWyBpQDZwK3v7X0AzWCuXEIx012DjH8kBYrTLc+cciuOeCsOpvJTRNkQCMWtEzwMlNNG+2wi9ptHzVIa8ed51nQq5443Ye5OwKdbW9e1QCINUcv+SRC33oJayFZBpuzO72mkbt+YkgtIFdXklgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbxmweeRI4R9fx1A8Nf1RSKZVDnqMfYEbIWCS7aXAww=;
 b=PRHOIxGDar8npV2ei4sSLQ2CYuNGiwaXGUJ+14UUUeWEmDIBrRvWxSG1Lmx75fBpT5i3GNPuh7CLHSeBJpmlTO7kGqyGJ5jXZ+UQ//DCSZx8zazLw2vpyxoNfjmE6nZaiE/wtJYNpp11b2kNGP5RELesAgQBRGg/O0uB2VCTYPIskPac6TfbDb9yX4Em3e9k33N0LahLqO90FpGthQGvs8tNg6psGnjArC/7onFlH04AVZS/AGPwWkfDzRkX3zt86Qjeemaw5ZTFVigxpaG8w8t58rdHmiZX0olD+CvWB2KB90Ga840cRkMZPuYRUNutDCwjH0gGi4XNI65Fl10loQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbxmweeRI4R9fx1A8Nf1RSKZVDnqMfYEbIWCS7aXAww=;
 b=kIx7Vqz1PwsJ78kite8QR96/OTQ4Sjam/xxbLs8xYGXbsq8UU/jB0CLmV0fq16SU17SkvSThpXkdjEer2hNYwUrsaIzky3ttYmm+R1U9Lpqc02eVsadSFH6CBP/D0YY1vHwke0JNOJpAeYaVYOwihV5h1B1In64KWn4iWoCNarsUXUeisvmjhdfcouyt4Elyhgo2b8IIRQB1sGFgJZaJoDpfE7xvWO78D+6d7o5UyMUw9fDZmQJM1YU3hEW1OEYRE/Cqs6qFZOwDysXoKUn00S+afPoKxBozETfoWh43XicYJ8Tv+fsQ4RBMMpd0fnFTX0OIEsiR/7S9X+8E96VLtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 8 Nov
 2023 14:12:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 14:12:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 04/13] selftests: mptcp: renames some variables
Date: Wed,  8 Nov 2023 22:11:45 +0800
Message-Id: <202275eded1999ccbccc3810d45388ceba17027d.1699452144.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699452144.git.geliang.tang@suse.com>
References: <cover.1699452144.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:4:7c::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a7ae89-d127-490e-6a78-08dbe064ba9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hcgc4YhbZ2mHux964yK5jUrR5yOj0MMGQiJTbLcUIVbrHoYSwqUnYgWr2maNztXKBviIxBg+k1nhXs7ZJBzl618FQwQD0qapMnb+4cMC22eoJt0WDNMJcdf0vBM2NOmnzddnlBCw2xcndFXj7WE1dTkliicsMjeLJlCHG1kddWFwAX28ng88HkX4g2d51y6wC68S6tJIKEgMiDn9SEsyPW4F0r+X1ysb9VaRw6+q/u6OWcjC4VrZ0Pyrfl3uP0YJxzdbl6E8CoCn+hsbbZ/636BQCB1T/XymHWB26d/p1Qp3jvDRih6A+O/b0eKMCQ3IhWRyyu+4nUoNQEFv0+ok73MlS6UuJru6WzTcGnBUUQ7O2Lnsj1Tu47ceUTADM/nTej35gs/XJ7yUhZbH7srvG2rSL2DxD1Tmr+pDMd2LUPXdoGNQuakJgH+8p/S4swCj73QJu2n50wLEOsSPzL+7epNCI50CULIw8TrBpwmRvfbqBHyLrrhzpWgHbZUB99mCSuyaPQCnYJDCM86tPca/tgwOk10oNpeSemTeRfnO7eBB8O0aiP79Fr+04soZ62Nl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(366004)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(478600001)(6512007)(107886003)(6666004)(6506007)(83380400001)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(6916009)(8936002)(8676002)(6486002)(316002)(66946007)(2616005)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cy6HR0GNzASx3gzihkNXeu32mNjML+BFXgDUzLp44YJacTXqdLNPmKft3dhc?=
 =?us-ascii?Q?B/215n3OHmoUat3DsXsn0LG7oOjqsdBNIRL8mNeiLMfOUgKrZE5+GbvguWHj?=
 =?us-ascii?Q?vbtmjFOyU/iBPyJIjiI2z2QzJjoTQO5tChcQGbk80bBJF2QIogb98LCV5TdI?=
 =?us-ascii?Q?XiGdyyJSUleyPa+QoBVwoCYGpJu2jMUpoaq0Mj5ocJxodVMgMpDXUKK17KQj?=
 =?us-ascii?Q?CO9FQIk/d/zLxuLK8mSXmc44yXmODGdgwnI5V1u9LtFI5NfxoGbgVxW5cq2F?=
 =?us-ascii?Q?reS4igBtVoDfRQiDPW7YldyvN3TXlflD4p90uT6AXvryZaMqf0RqXpPZpd2b?=
 =?us-ascii?Q?se0Sg4ClkEOP6rwe60X/H41E5+c4EayroYsKbdHCigZtMiSKTWktpm4VDs6/?=
 =?us-ascii?Q?5nPGamt4psShuRCMoS4FY0jCZSMznW7hpjzROpLFVWlfPs4Jn1j0hzC9PHU0?=
 =?us-ascii?Q?47xVRR5h4kMZS34QTRJP+kYjb7KocUqqhQpE0GR2NgdMzty8e+22X3eE/mJa?=
 =?us-ascii?Q?YnXSzExGB1XbMfIicEQ/0Q/TxxEkCfDLM2zzHGuYtJoARisxXTA0hOy9gbj/?=
 =?us-ascii?Q?/pND0EHVv8l9G8SCmuDawip1PB4ZgQvYRuR4xEjQm5Q45EMstZIZbTzcgG67?=
 =?us-ascii?Q?EpjhW/DNcVHtFGgO/+7g9E3VSODm9AneQP/H0EUCVJHZa62SstbHgparGqjf?=
 =?us-ascii?Q?uVrO1M+8OFPwOCUQAplMtXlUMY8F2MVGwlyBtUq1uD6QSojg5d0Wv1FofOmc?=
 =?us-ascii?Q?EVbh+dZLzsVHpVeK7RjIffH8QnfhAyhv8sFs8yN+lar1s9h2oh09YhATIskm?=
 =?us-ascii?Q?lmGAWI3wOc+QJKrk5rDDbFU/S8vyZ+6MKJaRATN2hopUd4Nlsg2N5Zke2dF6?=
 =?us-ascii?Q?P71N04h2nrkxkXik0uHt8ZWddml64GI0HrzknTkrgRKkxhYTiAvu1CRMlbUR?=
 =?us-ascii?Q?UTByJETVzZesbyQAgk/l1C3slbWFOcPNSVWfGij5gjRCwSfBWkr7/ZYJQ+07?=
 =?us-ascii?Q?wM53h1IF+IT8jwqScAMGMd8vD+iDDWIFqxRL0HErJEBqCyjbIDIfOwmmWLKC?=
 =?us-ascii?Q?Q7y/QCxpWt3qm+YQAhca/+72nlVaagyIUp8l5CZCzQUC3s7/Fd4tQkzM4UVE?=
 =?us-ascii?Q?Ma372xw1I1kgEiPrUddkDfAGy/h1d4HtrKmGcny9HVYrfiXxI8nN2fqL29t6?=
 =?us-ascii?Q?+Ut9qQPaO7YntOrtRw40Abbo194kn1Us+ujkvXz4KhcFHy5jyHO2fedIOrb9?=
 =?us-ascii?Q?2Ecu/jd7RJfP94tAkkvccRlOu7jdBPgUtDfRIqolhilTXP0KPIiytcSxUDWa?=
 =?us-ascii?Q?FXBWJVDE/jd/7sULv1uScrXI/V7dUcEIo14tj/EgZrYkXbyfoW4lgV6jiTGF?=
 =?us-ascii?Q?LZ1PTiCwb/RyXElSAWBLwFHt7UvUU3/7pdUI1dAwQgNSaebd4phpbBBoxc9r?=
 =?us-ascii?Q?EA3Z5qqGG5zIiB8ovwxNwNe3pLnWxool9N4u0OuUMG1FcwA7R+od8rKZQ0D9?=
 =?us-ascii?Q?Szhb9MFLtJ3Gyyy50ojrcKtm+gaISoAIgqARwckZkr6azYYph5ae+j2dQnpk?=
 =?us-ascii?Q?J6WsUpcu7jSkdwqp1LJIS8IzXEwMXOLolI1ruHwp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a7ae89-d127-490e-6a78-08dbe064ba9a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 14:12:23.7940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wl4z4wR9Y38Hak8Hqv6PUujhztk2iyEfYT/ArpPvIGi3YUDIvqL/n6vwxnoPGwyCOQws362VkIPh3i3YdyXUXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

To maintain consistency with other scripts, this patch renames some
variables:

    test_name -> TEST_NAME   in userspace_pm.sh
    test_cnt  -> TEST_COUNT  in diag.sh, simult_flows.sh
    ns        -> ns1         in diag.sh
    ns_sbox   -> ns3         in mptcp_sockopt.sh

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh     | 58 +++++++++----------
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 12 ++--
 .../selftests/net/mptcp/simult_flows.sh       |  6 +-
 .../selftests/net/mptcp/userspace_pm.sh       | 12 ++--
 4 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index e59d3b33bb22..043e199b0c62 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,9 +5,9 @@
 
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns="ns1-$rndh"
+ns1="ns1-$rndh"
 ksft_skip=4
-test_cnt=1
+TEST_COUNT=1
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 ret=0
@@ -18,19 +18,19 @@ flush_pids()
 	# give it some time
 	sleep 1.1
 
-	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGUSR1 &>/dev/null
+	ip netns pids "${ns1}" | xargs --no-run-if-empty kill -SIGUSR1 &>/dev/null
 
 	for _ in $(seq 10); do
-		[ -z "$(ip netns pids "${ns}")" ] && break
+		[ -z "$(ip netns pids "${ns1}")" ] && break
 		sleep 0.1
 	done
 }
 
 cleanup()
 {
-	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
+	ip netns pids "${ns1}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
 
-	ip netns del $ns
+	ip netns del $ns1
 }
 
 mptcp_lib_check_mptcp
@@ -48,7 +48,7 @@ fi
 
 get_msk_inuse()
 {
-	ip netns exec $ns cat /proc/net/protocols | awk '$1~/^MPTCP$/{print $3}'
+	ip netns exec $ns1 cat /proc/net/protocols | awk '$1~/^MPTCP$/{print $3}'
 }
 
 __chk_nr()
@@ -69,13 +69,13 @@ __chk_nr()
 		else
 			echo "[ fail ] expected $expected found $nr"
 			mptcp_lib_result_fail "${msg}"
-			ret=$test_cnt
+			ret=$TEST_COUNT
 		fi
 	else
 		echo "[  ok  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	test_cnt=$((test_cnt+1))
+	TEST_COUNT=$((TEST_COUNT+1))
 }
 
 __chk_msk_nr()
@@ -83,7 +83,7 @@ __chk_msk_nr()
 	local condition=$1
 	shift 1
 
-	__chk_nr "ss -inmHMN $ns | $condition" "$@"
+	__chk_nr "ss -inmHMN $ns1 | $condition" "$@"
 }
 
 chk_msk_nr()
@@ -104,7 +104,7 @@ wait_msk_nr()
 	msg=$*
 
 	while [ $i -lt $timeout ]; do
-		nr=$(ss -inmHMN $ns | $condition)
+		nr=$(ss -inmHMN $ns1 | $condition)
 		[ $nr == $expected ] && break;
 		[ $nr -gt $max ] && max=$nr
 		i=$((i + 1))
@@ -115,16 +115,16 @@ wait_msk_nr()
 	if [ $i -ge $timeout ]; then
 		echo "[ fail ] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
-		ret=$test_cnt
+		ret=$TEST_COUNT
 	elif [ $nr != $expected ]; then
 		echo "[ fail ] expected $expected found $nr"
 		mptcp_lib_result_fail "${msg} # unexpected result"
-		ret=$test_cnt
+		ret=$TEST_COUNT
 	else
 		echo "[  ok  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	test_cnt=$((test_cnt+1))
+	TEST_COUNT=$((TEST_COUNT+1))
 }
 
 chk_msk_fallback_nr()
@@ -143,7 +143,7 @@ __chk_listen()
 	local expected=$2
 	local msg="$3"
 
-	__chk_nr "ss -N $ns -Ml '$filter' | grep -c LISTEN" "$expected" "$msg" 0
+	__chk_nr "ss -N $ns1 -Ml '$filter' | grep -c LISTEN" "$expected" "$msg" 0
 }
 
 chk_msk_listen()
@@ -169,7 +169,7 @@ chk_msk_inuse()
 	local msg="$2"
 	local listen_nr
 
-	listen_nr=$(ss -N "${ns}" -Ml | grep -c LISTEN)
+	listen_nr=$(ss -N "${ns1}" -Ml | grep -c LISTEN)
 	expected=$((expected + listen_nr))
 
 	for _ in $(seq 10); do
@@ -197,24 +197,24 @@ wait_connected()
 }
 
 trap cleanup EXIT
-ip netns add $ns
-ip -n $ns link set dev lo up
+ip netns add $ns1
+ip -n $ns1 link set dev lo up
 
 echo "a" | \
 	timeout ${timeout_test} \
-		ip netns exec $ns \
+		ip netns exec $ns1 \
 			./mptcp_connect -p 10000 -l -t ${timeout_poll} -w 20 \
 				0.0.0.0 >/dev/null &
-mptcp_lib_wait_local_port_listen $ns 10000
+mptcp_lib_wait_local_port_listen $ns1 10000
 chk_msk_nr 0 "no msk on netns creation"
 chk_msk_listen 10000
 
 echo "b" | \
 	timeout ${timeout_test} \
-		ip netns exec $ns \
+		ip netns exec $ns1 \
 			./mptcp_connect -p 10000 -r 0 -t ${timeout_poll} -w 20 \
 				127.0.0.1 >/dev/null &
-wait_connected $ns 10000
+wait_connected $ns1 10000
 chk_msk_nr 2 "after MPC handshake "
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
@@ -225,16 +225,16 @@ chk_msk_inuse 0 "....chk 0 msk in use after flush"
 
 echo "a" | \
 	timeout ${timeout_test} \
-		ip netns exec $ns \
+		ip netns exec $ns1 \
 			./mptcp_connect -p 10001 -l -s TCP -t ${timeout_poll} -w 20 \
 				0.0.0.0 >/dev/null &
-mptcp_lib_wait_local_port_listen $ns 10001
+mptcp_lib_wait_local_port_listen $ns1 10001
 echo "b" | \
 	timeout ${timeout_test} \
-		ip netns exec $ns \
+		ip netns exec $ns1 \
 			./mptcp_connect -p 10001 -r 0 -t ${timeout_poll} -w 20 \
 				127.0.0.1 >/dev/null &
-wait_connected $ns 10001
+wait_connected $ns1 10001
 chk_msk_fallback_nr 1 "check fallback"
 chk_msk_inuse 1 "....chk 1 msk in use"
 flush_pids
@@ -245,16 +245,16 @@ NR_CLIENTS=100
 for I in `seq 1 $NR_CLIENTS`; do
 	echo "a" | \
 		timeout ${timeout_test} \
-			ip netns exec $ns \
+			ip netns exec $ns1 \
 				./mptcp_connect -p $((I+10001)) -l -w 20 \
 					-t ${timeout_poll} 0.0.0.0 >/dev/null &
 done
-mptcp_lib_wait_local_port_listen $ns $((NR_CLIENTS + 10001))
+mptcp_lib_wait_local_port_listen $ns1 $((NR_CLIENTS + 10001))
 
 for I in `seq 1 $NR_CLIENTS`; do
 	echo "b" | \
 		timeout ${timeout_test} \
-			ip netns exec $ns \
+			ip netns exec $ns1 \
 				./mptcp_connect -p $((I+10001)) -w 20 \
 					-t ${timeout_poll} 127.0.0.1 >/dev/null &
 done
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index c643872ddf47..3008f15c04f9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -18,7 +18,7 @@ sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
-ns_sbox="ns_sbox-$rndh"
+ns3="ns3-$rndh"
 
 add_mark_rules()
 {
@@ -41,7 +41,7 @@ add_mark_rules()
 init()
 {
 	local netns
-	for netns in "$ns1" "$ns2" "$ns_sbox";do
+	for netns in "$ns1" "$ns2" "$ns3";do
 		ip netns add $netns || exit $ksft_skip
 		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
@@ -80,7 +80,7 @@ init()
 cleanup()
 {
 	local netns
-	for netns in "$ns1" "$ns2" "$ns_sbox"; do
+	for netns in "$ns1" "$ns2" "$ns3"; do
 		ip netns del $netns
 	done
 	rm -f "$cin" "$cout"
@@ -240,7 +240,7 @@ do_mptcp_sockopt_tests()
 		return
 	fi
 
-	ip netns exec "$ns_sbox" ./mptcp_sockopt
+	ip netns exec "$ns3" ./mptcp_sockopt
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
@@ -251,7 +251,7 @@ do_mptcp_sockopt_tests()
 	fi
 	mptcp_lib_result_pass "sockopt v4"
 
-	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
+	ip netns exec "$ns3" ./mptcp_sockopt -6
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
@@ -282,7 +282,7 @@ run_tests()
 
 do_tcpinq_test()
 {
-	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
+	ip netns exec "$ns3" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index ae8ad5d6fb9d..6fc0e08985d2 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -12,7 +12,7 @@ capture=false
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-test_cnt=1
+TEST_COUNT=1
 ret=0
 bail=0
 slack=50
@@ -129,8 +129,8 @@ do_transfer()
 	local sin=$2
 	local max_time=$3
 	local port
-	port=$((10000+$test_cnt))
-	test_cnt=$((test_cnt+1))
+	port=$((10000+$TEST_COUNT))
+	TEST_COUNT=$((TEST_COUNT+1))
 
 	:> "$cout"
 	:> "$sout"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 5921589f0db9..601421ed4e49 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -49,7 +49,7 @@ rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
 ret=0
-test_name=""
+TEST_NAME=""
 
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
@@ -63,9 +63,9 @@ print_title()
 # $1: test name
 print_test()
 {
-	test_name="${1}"
+	TEST_NAME="${1}"
 
-	_printf "%-63s" "${test_name}"
+	_printf "%-63s" "${TEST_NAME}"
 }
 
 print_results()
@@ -76,13 +76,13 @@ print_results()
 test_pass()
 {
 	print_results " OK "
-	mptcp_lib_result_pass "${test_name}"
+	mptcp_lib_result_pass "${TEST_NAME}"
 }
 
 test_skip()
 {
 	print_results "SKIP"
-	mptcp_lib_result_skip "${test_name}"
+	mptcp_lib_result_skip "${TEST_NAME}"
 }
 
 # $1: msg
@@ -95,7 +95,7 @@ test_fail()
 		_printf "\t%s\n" "${1}"
 	fi
 
-	mptcp_lib_result_fail "${test_name}"
+	mptcp_lib_result_fail "${TEST_NAME}"
 }
 
 # This function is used in the cleanup trap
-- 
2.35.3

