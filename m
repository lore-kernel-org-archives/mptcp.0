Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2053.outbound.protection.outlook.com [40.107.6.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E926C196
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ssvY/H26"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmB/oewaopVJNUH86xdrRgJS1yhs6DFzh5wPg/CQfXpWfDvrav9lVBiIbPMw0iF1mv/bhr9UWBiQ50nD308GD6iqDdYDM5eQl//XNyRkFP+fen5/3scDs8IAh81prVwFk/LCHByf4gKbLh/c2XsibSsfZfDpaR+C+qsepF5SmjnXTCZN5xXHZP8EIHvp+pornKKdpNshTSuGJ+Jl6MliKD/I3Xnk8ENR3bx0EqFXZX+puqY1MVK7C6CorDHZyb2bgKSsmwPrivmLcpfOEmUA8951YidWLpV2A+9tzhZMBQFzbeyb3/pspisZUvz9n1ZfvCW8zp4QYJRw4F4mXmD5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGMWuSNtN5WEu1VR/66Ln/eBxd/TdRIL0g9Bp3X41IE=;
 b=CgEnwpcql9DK6jphgkZSv6jMndtsNhJFvOBQmU6Lk88DVgQftEPN6HPjfB3axfpiSIiCUcY8h3MY6/BcLDh3wOx/CThRQ9fuYzMBZ0pSt2whZoTNeyU667TUoeSvwKOjqvp6RVXXepxUBTXQMQ0v6WQJrULanjTdvfM3cK6BhigJumU9T55YB9bNib7ZdqTPdj/hl4Sw+tvdrhCv7uytW6gQdvzOQ2qmUnYKHyeXgMhJfu35hCkWAQlPK8X09TlC1692raiwsxgYPtgY1m74uoa8sH9sBWBBTHifbfRcWZnL3UWsSJw+69bks6JrjUVaL+Q14Vuzr0Rkv/CFgg/jOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGMWuSNtN5WEu1VR/66Ln/eBxd/TdRIL0g9Bp3X41IE=;
 b=ssvY/H26FhgvenRzNSTYaVn2TbFIWE4ASzLOjsbglyBQ8Wnqo+L+hZll+tCZgutIAx2PFCrgFBpg+FRSBGeIypRAy9dXghPaw5ap0S/JG69UqvAMsKfODY7hbh+mKEXZP3VdDxrtogQ+LFwQFd5oEBl7VS2foIpmjcQp9PQ+iJYN4tgsmbmfazw3teCIcOQSAss9LD/2BF0LOswoCJT24+rmIvcenN92UP1PPPiXDuUUQbbtj+Z/2zQpU8u+I6EmbQj7699FiGqREokpNUTpUudhKl84U3UOKSp2kmvTf2SO2eE/sZlLThAS9hqHoMkV16YLz/oW15MWaKVIFpMnQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:28:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:28:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 06/10] selftests: mptcp: add mptcp_lib_init_ns
Date: Sat,  4 Nov 2023 08:26:30 +0800
Message-Id: <a07e08308eb6557dea2ca15ba7d443d6e8ea152a.1699057401.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057400.git.geliang.tang@suse.com>
References: <cover.1699057400.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:3:17::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 43321269-d166-44fd-49bf-08dbdcccfea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I1NQWfK9RgirXYMDBzztWftIO3a5Q8ek+6erxNDWa0pBCW1vZeLnzSBzM6bXztbsA4zg6nFRAfqOY88TAKHhmjt233Fs7YolH9cz4o0I4haws2Iwnre9iLvIo6zQRfySEizLGAw/D554IsMECv7coDavYN+REMd4tujyBd6NheD4NgxLQKRxAeq2Bb0xXrZDAI2CNUGLivWkssRHX7ysfnvi5zNcgjXXuFuIFtxQZMR6HAN0I2ItQvbOlxW0pJTWB4g+Gb9czGDpAcBEKPS0b+7fk4hrQ2HCIGva8pKQAq6aXJWIA6x/7QyzIAYAh8RTi0zRnx4CUAlzlR9kPIx3s+3uaIeWK2wC8ugiIZbl2NDFWDd10xLHi7XtIrL2dwZ+sejUZ72ImNJrU9bS18m7+ILjc52HG5GIBRqGQeMxN/4qEbIjuoZtFhoP/DoGnPquqiDvX1mHFsOqUWXzlQIKl/tEPyZ36tVLDWIWYlY0SaarXb5jz+IxdVsYwHIF+KsyL2iByebVAmXvK337cXUWbx/KACPR20Y3WjeCJ+R6ew6fwQxBY7Z0xDnnf+vwGT2VSu9IMYoKh6IjEOWG4gTfCXab7zDw60fBlU0w3L71zbY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(5660300002)(66476007)(66556008)(6916009)(8676002)(316002)(4326008)(2906002)(8936002)(66946007)(6666004)(478600001)(44832011)(6512007)(107886003)(41300700001)(26005)(2616005)(6506007)(83380400001)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PYJ8ISfv6YvcTZ2nlu3uavSBsxYQlOumgGFfsdEFVj3rkWqwLy65EBIBzMz0?=
 =?us-ascii?Q?ZicldQ01pwnw0yyfZ0f0fcla241Dn1/HqYPuxk/WeD72cuvYwrOwuzo9CBA6?=
 =?us-ascii?Q?c29TL0QvA2UUC2kmzHTrvlTirZj1/AA2MdxOb1al6LRYRtzu0PLlSAELYCuG?=
 =?us-ascii?Q?7hwM6QT8rqguIV1lJgp9LoL85t8PitUvz/VRLRELsPDquXBYwUzAXy4PNo9z?=
 =?us-ascii?Q?yK22kKm1rwGoBFdjyrVFEoBDgtqUWMk5/un+0dz8D1QMLnokLZjs9Jjx+gno?=
 =?us-ascii?Q?uyTQM2sl6OxMUmeDJNVL4a7/fds0HtUdFJv9Vjk7uL82Y5FNY5N7z1yv2MYe?=
 =?us-ascii?Q?1f+RKm6j3F+Jwq9dQ70k94gY2+L8Dx5rf/GVZ6O0NqXYy7YoAcuxJSZvBrKq?=
 =?us-ascii?Q?s/j/sSy5hIMRif00DC8SOaFoSkasjTbAUhLDcElsUffFveWnnoNgLAovZ7UN?=
 =?us-ascii?Q?X0QAdxcARLsi9e6y+QKKq9gruSHTwHuE0iwv781PWU2KHjr8FFu6xGn30zTm?=
 =?us-ascii?Q?aMLKqZkIztjSypvb3nWcOj6NOKhQu/dYOz+382CiA/j5SrCOMLcTBXWicGkb?=
 =?us-ascii?Q?ijKJh+dJTmxs52bFZZmtntsz82fJR9yMD5oNL++cXru2qe1RGVkIRuH7JHix?=
 =?us-ascii?Q?YQEXnfagowgXaBMDMQdDE2ARTOTlnefU/cnLaAUGT6FRYkjYb4y3wSW4DmXN?=
 =?us-ascii?Q?gXHPSEmWSFWZyyuYhVkkAeYXqVI88D8nU841RVtu7iiAeVa0X62A4VveS5qc?=
 =?us-ascii?Q?RBlsexeYMSMWFG9Ahi+G5ddiaN3SIYL5oNeP0Y+OvhhkGFJln5nMDRzVQCpj?=
 =?us-ascii?Q?oeF9TZVfSk9GgeFbuql5l0EMgdjMEKfZYjK0zjQc+bzs8nJPLO3RZz9Yy9MT?=
 =?us-ascii?Q?RSrFG1kc1uPQcIGnYJvcDNb60opiazXzV1AK6a4Uf19fV2Fc3cnhKA97M0z9?=
 =?us-ascii?Q?BMkTiLJ0On4zmHDbhX2TXufN2q46WT1vO2jnZbq6hLbYu0TEdC5XuD08IqQd?=
 =?us-ascii?Q?ulK9HiSLFwzXcY8Bn10Jqw94tWxwG8f9HNVEjbbU3gdHpVl/EK1O275S5cZ0?=
 =?us-ascii?Q?w2OwazJ6FK63hFpZV7Wel+YBW8ZpjgD+CwQ1qKBi0HXNbnWJZb7osKMxm+2r?=
 =?us-ascii?Q?G3iTj7QAMbx0OpLWbugO3w7GoGv/fTru9KsNLSLElfmGpZJXZyNvzOcpbtgK?=
 =?us-ascii?Q?fTXBSjV5Sr1WehdC2Eu0gTRw85WVtAFMftJXDE/i9GJ9KwzYOLI5oL/uiFrP?=
 =?us-ascii?Q?ox03e5xYMeDDumcIZS1pVdjUB3nPJC1Q9vUrwY2uiq2sqgQYq1whf+2pDUzd?=
 =?us-ascii?Q?2Sv/8Zj1qKARM6ZqGP3mwPIsTL6NkTX4fZlow11WXkfmC+nOtSvTFVG0AM1l?=
 =?us-ascii?Q?r91sSZ54iw29VEp7Hmt4PF/GmBBD4YbW4VR+l53nxrm3Tg7M5PiaB3rwrjeN?=
 =?us-ascii?Q?tukRmbgrl3i9cZQziCILBW86UmUEuE/AlL9/oqrV+jikEmmk0QLZ49zUXO6G?=
 =?us-ascii?Q?DoB5EcA4wvc2tXY4KgWtNqaCurQT3Dne1068CGJ2ZhavMvRkagobmYSThJBS?=
 =?us-ascii?Q?gxUyuO8keykA7jC0+WWPJpmfV9F2/YgJ1sNGtSvV3X7KzUg5acaIgcM0xhpj?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43321269-d166-44fd-49bf-08dbdcccfea9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:28:41.1391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ce4WPQ/pG1ZFK2YGwPdA4c4xa1Ny/4n941/yV85es+PKdh4pkj7QdNVX6OO937mvThMKP3rTPeX2S4/droNPJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

To unify the namespace name, rename 'ns' in diag.sh to 'ns1', and rename
'ns_sbox' in mptcp_sockopt.sh to 'ns3'. Add a new helper mptcp_lib_init_ns
in mptcp_lib.sh to init all namespaces ns1, ns2, ns3 and ns4. Then every
test script can invoke mptcp_lib_init_ns and use all namespaces.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh     | 48 +++++++++----------
 .../selftests/net/mptcp/mptcp_connect.sh      |  7 +--
 .../testing/selftests/net/mptcp/mptcp_join.sh |  9 +---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 18 +++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 16 +++----
 .../testing/selftests/net/mptcp/pm_netlink.sh |  4 +-
 .../selftests/net/mptcp/simult_flows.sh       |  6 +--
 .../selftests/net/mptcp/userspace_pm.sh       |  5 +-
 8 files changed, 52 insertions(+), 61 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 95b498efacd1..13c677cc2999 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -3,9 +3,7 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns="ns1-$rndh"
+mptcp_lib_init_ns
 ksft_skip=4
 test_cnt=1
 timeout_poll=100
@@ -18,19 +16,19 @@ flush_pids()
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
@@ -48,7 +46,7 @@ fi
 
 get_msk_inuse()
 {
-	ip netns exec $ns cat /proc/net/protocols | awk '$1~/^MPTCP$/{print $3}'
+	ip netns exec $ns1 cat /proc/net/protocols | awk '$1~/^MPTCP$/{print $3}'
 }
 
 __chk_nr()
@@ -83,7 +81,7 @@ __chk_msk_nr()
 	local condition=$1
 	shift 1
 
-	__chk_nr "ss -inmHMN $ns | $condition" "$@"
+	__chk_nr "ss -inmHMN $ns1 | $condition" "$@"
 }
 
 chk_msk_nr()
@@ -104,7 +102,7 @@ wait_msk_nr()
 	msg=$*
 
 	while [ $i -lt $timeout ]; do
-		nr=$(ss -inmHMN $ns | $condition)
+		nr=$(ss -inmHMN $ns1 | $condition)
 		[ $nr == $expected ] && break;
 		[ $nr -gt $max ] && max=$nr
 		i=$((i + 1))
@@ -143,7 +141,7 @@ __chk_listen()
 	local expected=$2
 	local msg="$3"
 
-	__chk_nr "ss -N $ns -Ml '$filter' | grep -c LISTEN" "$expected" "$msg" 0
+	__chk_nr "ss -N $ns1 -Ml '$filter' | grep -c LISTEN" "$expected" "$msg" 0
 }
 
 chk_msk_listen()
@@ -169,7 +167,7 @@ chk_msk_inuse()
 	local msg="$2"
 	local listen_nr
 
-	listen_nr=$(ss -N "${ns}" -Ml | grep -c LISTEN)
+	listen_nr=$(ss -N "${ns1}" -Ml | grep -c LISTEN)
 	expected=$((expected + listen_nr))
 
 	for _ in $(seq 10); do
@@ -197,24 +195,24 @@ wait_connected()
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
@@ -225,16 +223,16 @@ chk_msk_inuse 0 "....chk 0 msk in use after flush"
 
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
@@ -245,16 +243,16 @@ NR_CLIENTS=100
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
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 7898d62fce0b..8a0ce9ed1e9e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -121,12 +121,7 @@ while getopts "$optstring" option;do
 	esac
 done
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns3="ns3-$rndh"
-ns4="ns4-$rndh"
+mptcp_lib_init_ns
 
 TEST_COUNT=0
 TEST_GROUP=""
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f98166b232c2..8f6a045778cb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -22,8 +22,6 @@ cinsent=""
 tmpfile=""
 cout=""
 capout=""
-ns1=""
-ns2=""
 ksft_skip=4
 iptables="iptables"
 ip6tables="ip6tables"
@@ -79,12 +77,7 @@ init_partial()
 {
 	capout=$(mktemp)
 
-	local sec rndh
-	sec=$(date +%s)
-	rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-
-	ns1="ns1-$rndh"
-	ns2="ns2-$rndh"
+	mptcp_lib_init_ns
 
 	local netns
 	for netns in "$ns1" "$ns2"; do
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 0aea2c5175d5..ee5a5b9adc47 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -15,6 +15,12 @@ MPTCP_LIB_LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
 readonly AF_INET=2
 readonly AF_INET6=10
 
+rndh=""
+ns1=""
+ns2=""
+ns3=""
+ns4=""
+
 MPTCP_LIB_SUBTESTS=()
 
 # only if supported (or forced) and not disabled, see no-color.org
@@ -443,3 +449,15 @@ mptcp_lib_verify_listener_events() {
 
 	mptcp_lib_check_expected "type" "family" "saddr" "sport"
 }
+
+mptcp_lib_init_ns() {
+	local sec
+
+	sec=$(date +%s)
+	rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
+
+	ns1="ns1-$rndh"
+	ns2="ns2-$rndh"
+	ns3="ns3-$rndh"
+	ns4="ns4-$rndh"
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index c643872ddf47..f4dfeaf52c73 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -14,11 +14,7 @@ timeout_test=$((timeout_poll * 2 + 1))
 iptables="iptables"
 ip6tables="ip6tables"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns_sbox="ns_sbox-$rndh"
+mptcp_lib_init_ns
 
 add_mark_rules()
 {
@@ -41,7 +37,7 @@ add_mark_rules()
 init()
 {
 	local netns
-	for netns in "$ns1" "$ns2" "$ns_sbox";do
+	for netns in "$ns1" "$ns2" "$ns3";do
 		ip netns add $netns || exit $ksft_skip
 		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
@@ -80,7 +76,7 @@ init()
 cleanup()
 {
 	local netns
-	for netns in "$ns1" "$ns2" "$ns_sbox"; do
+	for netns in "$ns1" "$ns2" "$ns3"; do
 		ip netns del $netns
 	done
 	rm -f "$cin" "$cout"
@@ -240,7 +236,7 @@ do_mptcp_sockopt_tests()
 		return
 	fi
 
-	ip netns exec "$ns_sbox" ./mptcp_sockopt
+	ip netns exec "$ns3" ./mptcp_sockopt
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
@@ -251,7 +247,7 @@ do_mptcp_sockopt_tests()
 	fi
 	mptcp_lib_result_pass "sockopt v4"
 
-	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
+	ip netns exec "$ns3" ./mptcp_sockopt -6
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
@@ -282,7 +278,7 @@ run_tests()
 
 do_tcpinq_test()
 {
-	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
+	ip netns exec "$ns3" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 8f4ff123a7eb..1208cba4797f 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -24,9 +24,7 @@ while getopts "$optstring" option;do
 	esac
 done
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
+mptcp_lib_init_ns
 err=$(mktemp)
 ret=0
 
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index ae8ad5d6fb9d..8f8bad051b1f 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -3,11 +3,7 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns3="ns3-$rndh"
+mptcp_lib_init_ns
 capture=false
 ksft_skip=4
 timeout_poll=30
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index f99edce8171f..03b9353d93f3 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -44,10 +44,7 @@ app6_port=50004
 client_addr_id=${RANDOM:0:2}
 server_addr_id=${RANDOM:0:2}
 
-sec=$(date +%s)
-rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
+mptcp_lib_init_ns
 ret=0
 test_name=""
 
-- 
2.35.3

