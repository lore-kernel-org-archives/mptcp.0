Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2E54AF66
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WINl1MBG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uu2JsoDiNgGRTlYhoP60LNRU8ZWYbSplVS5m+C48x8L/x7nJPSbAg9HHRGLUjuqX1ZfKzNv3kEHR+EIeq6UxeRvfRlSUZuqV82+JKQRBEprGtmOCn0kD1lmTLXbDzW2JxeDqPwrF60Jwa5QJAS5q53o5JDjGaoyfoS6oXHU4IN+88iUBMZazJXlE0uu6Lh+rRJdCQ5bHkotq/CzNnKsjBjD6krk91XDPTjhkKdbCcvDeq3LRqm6D5L40RiPlNie4nm6FYl79R7HCHs6eD3i2VqVDSYUENyyX1NKCPzc9NrqF9BB75y0pEhJkR24rZPqqvXMac9HmCOqKqhNCWbDDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GByRMhoJmYKTOwoDzD3yf4AzdlJtmvjNU7vpI0qa3p0=;
 b=SJ27a8tmzJqsnqUi+/bP+Tm/tUHOU8z8t9BVg6GcoERze2yznIFB45SlsL6bWnqtnBkADLdogN9BJ3xpDqFP+PsZQ16RF80gndrjZvJc/kIG2b+l8CxUrDqgCj91WXCWLBe/A+xVc7PQK5xAAVS+CJse09Ka6GPtnU2qqFOtAyjY90Q/GHa+kdsuu3E9MXHR2Lo2DEsGflT6DG7uBH5ysrmlMkVWjeTN5uDz8Fav3FB2R5ARmNHyAi4axwhvlXpcDU10T9W+XK8dWkXTlCDNudQJczaCJ2Lpj3XU74b6JfpvZS6azwkSgKikqXHkBMAgeWICnDRz6FByvAaz31AyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GByRMhoJmYKTOwoDzD3yf4AzdlJtmvjNU7vpI0qa3p0=;
 b=WINl1MBGdEXZf7FxLJCg0CNOkI0qebqwrxb8vhQXeqEYb//JSQXKiqtz8cFWRRgbHA0YOhdpGTFDZVZzrUaoSR53iS424WAfhQHJAbDf83ePXpTtdYR+/YKNOwWjySsiMq6vyVhOMhUHu9ffZC+6Rxii7hcQ3ZAnZyAhOywSWFMposR8Ai2PvOo8kElKAOxRNTpWwwK50JptMi4I7iASl32gQOlz2aGol8iFjKwGx6MaTxAjKLu+0IVXu/BDFB9yfRUeqUNCG92+kzO+x+H7AJX+ktwzH3j4cfWx6dUrLDKpKIT1nxEWzcre3+DkVT55dDBAm193S41t1V0B7Ene8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:32:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:32:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 10/33] selftests: mptcp: unify namespace names
Date: Wed, 22 Nov 2023 19:30:58 +0800
Message-Id: <1480d7fcbd5402855655af6e82e3dd310fd01232.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0027.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cdcb9f0-5bde-48d6-16c6-08dbeb4eb258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5TUssMqL0qKu+p9UDFkbi85tnEyYQh5Z1vGJINPX28EJ1fbYZv3UQFy9XFnsj8r1XUdrtwihzxrS4hUF0AcXPegrH3xpSkVusR+qWnRGB71V/thzmGNhSbKrDgUbYjBfmuvxOCNBFriBYMqxIn2ewE4KWIzxK30acNh97ZGkwRqAN4DHCIou+/jXAFfoEaLB41QHiFE6PHthtdlYVLXUYZWjp9rkZMu+sLqFMbUYTTFx04GC5F1XClgesiOwsX3DrF1Esl/AKUcd/j3f01uIOuZrwTy/uL+UR8zqkOkzEp3tSF9RPZWJYJgFwa/BboREbxLyOoZggMoGwZmDJoKD1C3ONY+CkLX/Jl5tD04iksl0NlolaMHfJ5njXBi7p88i1Nsr3+LM/VAVMeXf0ZSQhJonQZLhFN9jihGWoiXy8RdpK9Hv8o+WGJy16esJ5l0fz8N3pOVnWWTaD9Kj600Mk+dJoCfadFEAQ9DnuOrrdVCv/pIlNigUVnnV0w2+Kzr8irPAsWZS8yoFXAMuhXqRStEna3ARhv0VEH9gJBAJyWaJ925jg7jGvBuFmjAMDrdGQq5HgIpxUexLfzJohCCPP8GKJ4VQfL9CSvBNogKFJX0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(44832011)(2906002)(4326008)(8936002)(41300700001)(8676002)(66946007)(66476007)(316002)(6916009)(66556008)(86362001)(6486002)(107886003)(478600001)(26005)(6512007)(6666004)(36756003)(6506007)(2616005)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oB+H8UOcNsdJpAgTTR/NxopBwDbUvBqlQHWReXXLCcVQFEvNGz/cHt0BIlH3?=
 =?us-ascii?Q?NSaXOrGZ5ricJZynfvc81Fnib75x7ng9C9fkp4jPf/gBf+wurBIwpqPPTjxc?=
 =?us-ascii?Q?uNbkMfDfwq+Q6ll4fr62H2BLQxgNTnk+E/QFQOeyRA8k9HPfReRxLTKFKVyL?=
 =?us-ascii?Q?ctBZATP6s2+/4e8Y61Kvp7qZxbLgj9D1dm7jDExOMlEe97ETyQsJSci3EZQu?=
 =?us-ascii?Q?otm4QL8KPoOJT/BZU6kdP5boeF6AZJTB8HNIAIdXyeYItN7K8/Yk9jdoOCir?=
 =?us-ascii?Q?otR84flzMh/XJZ6bMheoGJIT+OEMBhGzAeywk3A1MT7D1+DA8P/01hVo9jwD?=
 =?us-ascii?Q?DdG1OQeH4d/1HS3cQYa+t/khYqQeVCVT7i3N7N8VhoO7wllaA/GCrnMC70tI?=
 =?us-ascii?Q?2WI9n4DxwOQm2ljid3apKdpOBmPA7ElKC6LmA1X5dviLrfeLRxDh7lLJuc3R?=
 =?us-ascii?Q?srgNj/OupM3oFBg8sOd+woa8zyw8x7kWbN+V6b1lkT+nikNpcBHpzu3eJUBd?=
 =?us-ascii?Q?DesxYd6ikIZqmLpKn00tUMqLoTZ17U0lts6cpE/EaeMcDi9qLsLsQL6cFVvT?=
 =?us-ascii?Q?sx/FYsJu3cuts4Db+vnCXL3NQFIw8SSWv5oR5TzRivFu8cldwfsEaKwRiELM?=
 =?us-ascii?Q?uEVAlNULFt3zdRdBw+vh3zmQa1387/x6KrZ1A3NKv6ZrpTqwMSavCBFZAsqN?=
 =?us-ascii?Q?hEpX52PkMsRRkznSqiHo6hu1rSAKTJHyGPLaZ5uOHyU2CDtpEFCy7v1rc55N?=
 =?us-ascii?Q?XlY4egzTLsx5plpUfwBMCoIjVqx85/dkUCK61O39m1aGxTcnvdOpYWz4e+zT?=
 =?us-ascii?Q?aLtwVWdzWPczGAyDxvy/MnbL5hhTC45Db8AiNwVnWLTjpzjLwzUDTxjxahpQ?=
 =?us-ascii?Q?CSQS0HxCjZOQBChI/mrsS7BVue9/8BUd9MEZRqqv6N45enS15xk90EjgHLKV?=
 =?us-ascii?Q?nhKLc1K+k3cd0c/UT56eZsK7KQ4gRgjQJY9K6JqC14s7Lyd9sRehvx1Ugc2D?=
 =?us-ascii?Q?9O37pjxk+txD9M5bmfPITVmK/q2HPQE+5/3gmenyQrqVR0IG5BKeuYKN+lU/?=
 =?us-ascii?Q?JRznOIu8pi6JY5CJhrPdQjyZUv7Y112dKA6u7iahc/kf/yy66dfCrnFf+lKN?=
 =?us-ascii?Q?5saVF2ZyKmsr+Wb3t0ESoS9kbIBZ+1/ei/a29Rr+bviAyvjBnV6xbNivuP5k?=
 =?us-ascii?Q?m/g3Zqj2/tFesExVnuGHebGqmohHACKE7eKj+5ZkKj9Uoz2FrPNAg8Kz8q8u?=
 =?us-ascii?Q?6o9WDqe+9y/oaDRreKv0inT5OHaTxxzBoj0oJ3GlCJ6WeaY1juy9uK4wuBsK?=
 =?us-ascii?Q?KRoCbt77z15pp3N+O44tqr2GmnnIypvm6dkTNllAkC3Q7B3sY1TTFKWTZpHk?=
 =?us-ascii?Q?Ph1xTfp99G6eP0Y93X2XNUXYxRyOkOzBcGHlINa6OWAdOQJV/rDqiUyfxwog?=
 =?us-ascii?Q?mYKDVHSSNcd5C6SSpdKiFtZtCq2a/sO/k25gpTu/Jwk1fRQkvZspz/fG/8g0?=
 =?us-ascii?Q?tWmtvKxWPTdcB6Cay0oxlaPoejiv5Xv1WNY/Y3+9eU7VvxLW6ePj5O53tH/7?=
 =?us-ascii?Q?PYBHDSKLhugfJIpOnKrB1xQABULyKXztJ3qKk/emS5gmpsTB23gBBWJgmUxz?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cdcb9f0-5bde-48d6-16c6-08dbeb4eb258
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:32:23.9219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Skd/mnSN2/Qr0+LucHZyji/pFPMiLOVQEk4dTJEFyu7cL4blNFRd3AW733dzDiBLET6IhMOFrU6IuXAGqsT1Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

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

