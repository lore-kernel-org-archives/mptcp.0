Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D50612D
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UsJBrQ7R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBTIQAn4n8J61sLqhdAPpkvC8dge/fvDbsyWbXga7Ni4VP8Y/VKIHmTBBrkoU30QiEBo/BV5eNWcoGPc4dNUfWEXl2ORQFqusGzOYKUE16jwrzck+trRq2rgs/j2ln/1Djkb7eHKuQvLdBYw8oBYtcMKXCDZLyEOON645KAWdtTHEOOHnP1SZy/Pfhb42Gg/64evQry/QvEH/0aG8Yo8arBmIgWlFVXTQyRUS1KPBmjyanrT3957oLoZzeLZ4FxE4zgdGepmwJl2Nnyyi1Rr+HTZ9h6YSSsAuB3a/56smgitDKNpjI7saqCfxGK9ov09K7YRL1cuAj/Zv6yfkD+eDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GByRMhoJmYKTOwoDzD3yf4AzdlJtmvjNU7vpI0qa3p0=;
 b=jTuwa57g5ws71YHn7vLuBDmeS0xKRQkVdYJ3M2s68IlF0MKtp6Y29V+TfDfpVK+wxo7wmt8CPGl4h5T9p3ZlEqoUV0CcTT+vjJOzQKtfQyIr3D1GRobXc1cDvKqdSFDJHtmDlU5dYNdOVJKQLsy0xjaG7/3QvFUbLxFfTqEymClrDWXKQKNxyM/arbZ0je6XDKDhjWUrwM8WqdSIBhH+w/+ie+OpnQwDdAPp5nJ+0+gL/lEFffJSEsa65OfxUSFA9xpwwD/cQy/IaEbpS/NIEkxTsr+tW/svvRkX7EDYsZ7/QL0LdYw59Yw64JCPkXnbL2xvpYkJug6D0wrzvMQo5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GByRMhoJmYKTOwoDzD3yf4AzdlJtmvjNU7vpI0qa3p0=;
 b=UsJBrQ7Rbs9uvTGzlcvz7St1OnXXb9Tj9JA1xmWiDIEFQNVV7wdoGW90CBzs2ZIdfEBPHvXvKQo6je8j+YhlmH3n4jJkbJfy7YHLZs/dMCYx1Po78oKg+EPDBHnfmJuTjUNBI805w2HgT+QdsWf5t/ULeJtPrs6LGv1ViRfAJvq0cG6w5nVd6a0rynwW/oQLXNMA+UWpxWcfwvCwgV/qiqkrYpRSNlYcGhk6StXUboY4tWNpLX9nYxtbm6zeB04kuhXdwgScZKsSaLJXk+fLz9Af8FAaOxYbA7S4r8D7MoTyTMcBZobXJaPRS7Vaj3BpDY5/SAhDIOe3lM/hggiV4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:39:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:39:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 10/32] selftests: mptcp: unify namespace names
Date: Tue, 14 Nov 2023 14:35:29 +0800
Message-Id: <16952ce5c8f2b17bfc683940ee96bf62d97a0789.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0213.jpnprd01.prod.outlook.com
 (2603:1096:404:29::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0b3acb-9305-4958-c8d7-08dbe4dc6b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T5j9oB3j6II1lKx453UVVHmkHQ/nvPCnh3ZdDKzDAz/rjGl5uMMSoDTHPvs08Hmap1BcD9v0tBgvcJLyqLeUKLRCMk8cTLTjTbihezHbS14xAzHhuw8Tw+FfZK9dJCp8w3h7ibIW+4e0PCwNb12pvCxOCB/wODtYvnxSzCOVbQqypcjOtkbJKfBoeua+MLNZ+Gu7e9GcEKqJqZbOuPQVLsU5WHpiG7oMfwFzcRCp2jU8HUysQkhxDT4JISADJl+Z9khNbHHfTc/RZ3fZ7cPtQ23sJvHvFFNWe9Yb7MehXTpqkZI2CCtsx1ui1g13LpHe0FaElsrqwT0jpvQViLqD/HbyuVhwhbTrOHjwpPl+FA3DkiXaKJMfKH7UEHaOymzzaUNeajNOs2Rhzbp+3qao2mN51xw1u7n3sdvTSPENoAsBY9HFGHX14xO42V9VQatH/ujm2yIc9YaXShuqeJXOcLE77+NubyhJOjUJbAZJ7t2yeN7X568AzdfHTcxzcu1o2pdxWuJRbGV1wBS/PjkBFbUkSKkBAo9mL8+iUWzbsHmvGS5ol7f9jvwLafoyHkcP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2906002)(41300700001)(38100700002)(66476007)(66556008)(478600001)(6486002)(86362001)(66946007)(6512007)(2616005)(26005)(107886003)(6506007)(6666004)(83380400001)(8936002)(8676002)(4326008)(44832011)(5660300002)(316002)(36756003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C54b/mXLZ2blXmNagfstdX/9WYumkWJE7AVRWiPjxDPUCbvrxFxPztbnR9V9?=
 =?us-ascii?Q?Y8VSs9FnrZn26jakI1eB6fGg4pi8c755aa9ArJ0SuUZU7f7in7wuT3LKY+cp?=
 =?us-ascii?Q?w/Lb7tsJ3txAyxttY6c36lGm2rdSeRV4oLi7QaqHnFgzhg9cSSg3QKnIjS9/?=
 =?us-ascii?Q?oorSU6raAgfcuI55ccMdw1FX6LBgzkMYS2GkVW4WZXrqbNoEC8zYhFFrj9uV?=
 =?us-ascii?Q?y/hMDwB/XYEMGgU+S7qc2YgpUFQ2D+Nl/NVyrHiDK2fXq9M4hgDTYyHEQikO?=
 =?us-ascii?Q?2zzwsfvID2svEvSAk71wbFe/YZ4i36S71iG3EeLb4azOuLMc+CGginIC5Zk5?=
 =?us-ascii?Q?zO2NxQ11PFv/c3JHomhWQXVn8KajXCSrfl8z/K9pRMp7wAlCScC/Q3jvVhKm?=
 =?us-ascii?Q?cH822SIyuLXrC/VpLOJnqE+cKhfEUboiPqBIRw80yCnnu2zE1ACzVAsCs7tk?=
 =?us-ascii?Q?gQ0xrOzn5g169d+0yarvRcdk6+e2sanSJCjz4Kj1iNluWA7HuEH7K1jRDn2G?=
 =?us-ascii?Q?EXkc3H/IqmrcmemhGMpx/2i/N5bHYQ8ZElJac/XI2JeenCAI1f9EoQ8pVO5r?=
 =?us-ascii?Q?D37c2Wa3YmCyO3pMTiMiN0Lh2o/qrN78O+hbxBUYLg1sDNbVfM9uLFA8S9oI?=
 =?us-ascii?Q?DZGVJ+zr8Uyux4a6kVgvyo6dGx5Srs1a8TXkEV9pJub14Vl23AUzqAxLt1+4?=
 =?us-ascii?Q?c1E9YqdR4xsJNiRTSvhTY9tTjBp/tVzwf7/huZibMNmKt9BTP31hYuc/hDEU?=
 =?us-ascii?Q?++fFtXvh3eQ3XOLG2Px/43c1yM+CEVAZ3brh51Rb3rT7oPiTBSzIjbfciGtE?=
 =?us-ascii?Q?r0AV3j5a5vjuw24+Xu0RCs6eHNiWz823mCUqZtOe3CwKSU/DJGDgOnQvYkwf?=
 =?us-ascii?Q?SlR5vLRXe9EOj3raB9PA9eulnwZOkmB0fDwym2Fhem5/ArLUmcWJC74QeLyW?=
 =?us-ascii?Q?A8vvgFP9Al4BTCu/W2NOuEnIilrt9rJGBot7lGa0g+7i0Ho3BkWfJ6wY6PYm?=
 =?us-ascii?Q?KXP0z31OKBfjxUmcL+9xUeeibjiAmkz6+sZX+96ZdlhS35fiYNAW1hF7nHJI?=
 =?us-ascii?Q?pMuLq6Yu6P0clEpNwXZlln7YQu2dW5g9wrr0qDHZy8PJSY+kDIOyZNqzoudx?=
 =?us-ascii?Q?klhRNFDRMjiEUlTOEPOM2XxirPrFse5KwYT8D8dTZ6yQrnEKx5PbfMq+zxLH?=
 =?us-ascii?Q?+bOMgR/Vnsva2ADw0WKoIl1TLusGGyqygCGiGmsCrB+y60eezdTifkiwYg9A?=
 =?us-ascii?Q?DGstYafQNmtS6D35T5Q9zo89/gs3xLRZxHaNDB4zklSuN7nQ3mbKDvfbtpwX?=
 =?us-ascii?Q?wGW5L5gPne989eP55Spd/MhBE+7R6Qi46ywXArrLCz+4RnMYxt4lJMXTtbnU?=
 =?us-ascii?Q?suHY/NKTuuVa/dXYOGbrjRRYv1eyWV6Z+nDyp0yY6YqMMa4f63NJoJ/rJiXx?=
 =?us-ascii?Q?p//eVpre/Y0ZPsUHLHCYPFL4ZxJuFmnl7q19yUrTrXuqOERrf26kWHr0UpFF?=
 =?us-ascii?Q?pOR7PHRZYodMisCaFvBJY84yI9ed6ynZeeAinmcoUm4Gz56rcdJPZPbKX0cP?=
 =?us-ascii?Q?3wivomAP8ysfeUbAcdYX4jYYThbBS9fUeyaTc7Xx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0b3acb-9305-4958-c8d7-08dbe4dc6b85
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:39:15.4802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUtAf+mRakstdjC9R8gk8MDJKYcI+7eRbHlXk/0qI4MSoZZkjMFNvD0QXbVd56a7Fvws5wM4TeY9c4/1M2dNbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480

Most scripts use ns1, ns2, ns3 and ns4 as namespace names, but ns and
ns_sbox are used in diag.sh and mptcp_sockopt.sh. To maintain consistency
with other scripts, this patch renames these variables:

    ns        -> ns1         in diag.sh
    ns_sbox   -> ns3         in mptcp_sockopt.sh

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh     | 46 +++++++++----------
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 12 ++---
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 300aec419dd6..bc3f24c454be 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,7 +5,7 @@
 
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns="ns1-$rndh"
+ns1="ns1-$rndh"
 ksft_skip=4
 test_cnt=1
 timeout_poll=100
@@ -17,19 +17,19 @@ flush_pids()
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
 	mptcp_lib_cleanup
 }
 
@@ -48,7 +48,7 @@ fi
 
 get_msk_inuse()
 {
-	ip netns exec $ns cat /proc/net/protocols | awk '$1~/^MPTCP$/{print $3}'
+	ip netns exec $ns1 cat /proc/net/protocols | awk '$1~/^MPTCP$/{print $3}'
 }
 
 __chk_nr()
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
index 45e5b5810a6a..b82f7b0b85bc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -17,7 +17,7 @@ sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
-ns_sbox="ns_sbox-$rndh"
+ns3="ns3-$rndh"
 
 add_mark_rules()
 {
@@ -40,7 +40,7 @@ add_mark_rules()
 init()
 {
 	local netns
-	for netns in "$ns1" "$ns2" "$ns_sbox";do
+	for netns in "$ns1" "$ns2" "$ns3";do
 		ip netns add $netns || exit $ksft_skip
 		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
@@ -79,7 +79,7 @@ init()
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
-- 
2.35.3

