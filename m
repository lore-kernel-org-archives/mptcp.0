Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2055.outbound.protection.outlook.com [40.107.15.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552757472
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HYPO15w0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSL0NoqfUHqWghz6g2iTdWt7GF7RADy18Xt5jmiLLx5lqstyHc98qhPxGUI1Mnfg+kvMZIAzA3J3UsZHnpO6IRYJMPIkksWSzafHxgv6VNYHmnfDfH2AUrwQtKsWHLtlLoeilc98WYdXHsypBo5YyuMYVPZXcdQPIvDHfvyilbQMeOiBN7+5eqgMluJH9TY1uUWsT60ZEFmpA7BGfo0Hr7NrIg1anmUHT/m0TqStGDayVYP1IFW1f+iMyZzNE8QMOmAnXOd/izdmtTxakvsh5+Y596KTLI2KW0Uk1VACaLTmEH81/yrr383ukkWMWSVFQIgRVAaN0I3J2B4XcgeJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkGZHG1mA9ZPVzCeXr6f+1mRVNC4uPp6KiA+4KD5HoA=;
 b=QgQhRS7bQPLL6ZAxj1UsSnHf30dasXkJqsBS5692CHqDGV24wyYY8ydL/VShTNm4iBEc5dSoQtBbaUGe2jpXnDZoFnx+LdysrLtNDPL8dAx85TYSjubSz0cJOtSo+1gVVG2Z3YlROyrDsV1ddARA7zmCaD6/XfPL4mDRzibFJNn7dLagc7t/K0w2YiI28Lc1jFtlKMoNBp8nXNReEgF2t1m0G79oKgMmZWFJvjYzumSqsqezWcM/eA0okWMuFOeysIbzVfQjcFld5NBhXjL43Uffx+ogBYRYTZt7niCk50P19U4wGv9It2UgeGVh/b+E6OZ7GCQPcrS5bC+VBb3ilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkGZHG1mA9ZPVzCeXr6f+1mRVNC4uPp6KiA+4KD5HoA=;
 b=HYPO15w09oPFsrYjVGHyU9IJSCAnaaSAD962AEqfAwov3wvJqdSggqDDwt8lY8p8EGa5ThhwtZB4iCqup0/GLEzUNiHavsQCpv9PLpKdiJTcgxmk6Ri551egNLcinRIcmSlNKqz91x06TVUms4mI0+eXsj/o69va3vDzKfy5XoERMQnEqORpgjEeuq8Mu6U/A0rjRVmazfqXWnixQByaynv0ghylibrk9BQ5/N8x2Abr6HfEVwLAXa4m1+7nakc1KZX5PTsh/L2hbDhZ3V+WPnelY8ezVjuVFg6Vj2UhDKevgmQM0kbs8mv4xYJibMQUZzX1frQEzSTnmlBc/djtrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7681.eurprd04.prod.outlook.com (2603:10a6:20b:286::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Sat, 4 Nov
 2023 08:38:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:38:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 12/12] selftests: mptcp: add mptcp_lib_init_ns
Date: Sat,  4 Nov 2023 16:36:00 +0800
Message-Id: <1fbdbfebd7caa8052b764e3d78fa9fb8f41f03b9.1699086300.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086300.git.geliang.tang@suse.com>
References: <cover.1699086300.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0354.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f00b9f-81da-483b-a502-08dbdd1164b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eN+45bLfg5eFs29n72EiAyiTVvWbCCQ4+XsssEofnA3lRCeJ+diWU2JQSUED/QH7lvweVRwCqcpVgHJ4TrC7SWkTZdaDKh+8UqR7r3cOBBwt3Jm79N4hgHrGqWQ4uz84ffXMD/H/o+2izQpjw5PS+s6pR18FG88Um3BF+nsEVaxpMjujFi5J/Oon7SZAjOwJ43aWXEd0jCOqmo/5YvnUpdKaHNXEfx5u0HjgcDFwPjMmi2GIy85Iumcfegsa0MVztqjX0F9uyMIa7HA8jn7oHLyLO/9hYFaj8ptOXvPW6QxtazVl+l+hAdnZBPQzxdIC9fHDA3DqCRao9MMcyS+OBwSqNokJcWqRorJ2X7OQckfCFrt1XFvB7AfKm53mBCPSY0E+5NFRtiggTf5oN38ul6Fswd9OoosLhnYv4H3oL6QeZExYc/zg+lK7aqT+VeGrdvzRt+oArDXyk4peFzNrAdPRQQzbWycEOtymBvA+vXk4x35Pkk3XO+X0Txjz7Bta82ZLb4KeglBGEbA/Ulhr4ws9e+B0QPOCJIS4WtAuFvTA6oTSdYme8x5iFIxRYEuE6X0aysHIWLSOJbY5Qu0eHVWeX9pQSGAWWNNORDTz6d4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(36756003)(86362001)(2906002)(6506007)(6512007)(6486002)(44832011)(478600001)(41300700001)(6666004)(8676002)(8936002)(26005)(107886003)(83380400001)(2616005)(4326008)(66476007)(66946007)(66556008)(6916009)(38100700002)(316002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nDy09fzDp5fAr0RyTqmv86VXaPKpopjE5AXQAJzVE52SYQ5Vd7CG/DOqWxaS?=
 =?us-ascii?Q?w0yGgW0BrUq8J5FDHEZobL3avzPD2LQy0H7sf8PmGVBx43mCBYg1Dw7BUWhw?=
 =?us-ascii?Q?K8nPccdKes/CHcFtJ1+v7VcFumhp475TTpvOFKOIR3TzZJLNNFROeEJfr+V2?=
 =?us-ascii?Q?1pGpmLHoA6wAzvAdTfqP6OvNi6uZML2Vl0q5ecCsOZAHKLc1Cs64yNj64icZ?=
 =?us-ascii?Q?26puGResj8CXo8utW7aQkDDI1cj0+Jvw2ZhaKRtgwAxM5RIOMe3kgfMlFU8Q?=
 =?us-ascii?Q?lX3lre9ZXs0Lv78JJSpukJLexS1PtkngvVf56yF7DW1Lm6+d4M5WZtysSWgK?=
 =?us-ascii?Q?RfGcmHN8JRIHHORNDs8FMnZI1slqNbzAfQunMZAfy4M6ux1TFfHct1e3Xs7O?=
 =?us-ascii?Q?FBW09Y81xjJbeGp6gD+DczJeO2OlSBLeqEHC1FA20bCZNTZZb3qKUD84U7oS?=
 =?us-ascii?Q?FhTf37KSnr/1v93eSMEW5HK0II3LVmApnoYKKDF/qMFTRTqNU/VUItOUQmcj?=
 =?us-ascii?Q?lTAT7hwu0nX2okbIOzluKdlg1jTfofl2Jcv/aBMe/MvLl2rLgUsO5SDJ8BM7?=
 =?us-ascii?Q?sUJw+0s6wv58yYucpvv9ObP+d5i9USAy1O5HQRpA82B+oux4bjaG/1Qk/gwd?=
 =?us-ascii?Q?U1+7iPFm+6VziknlomHMkh2vU0UCLARVWnc7IJGefAOAsQf5ffrMR+90dMxE?=
 =?us-ascii?Q?sYRkfPus9nONd8u/JPTbIyeCQfeYzCIYMOB73uq3DE/dJE9tmKCUtJwknsvr?=
 =?us-ascii?Q?E2O9F3zdhWVIGbvZicMxmhmUU8GQeEtHX7+3KNGnozffkHYA0r3Q/PF0bMBu?=
 =?us-ascii?Q?u/M05O3e4nj0Jk97P2SFr0oibh9AJ8CAk6toGru32s+OPNZeA/Odisw7iYjw?=
 =?us-ascii?Q?k7dKpiWdLa5JuGU505DgwthhEADkGFJ85zL3r4evJNeCJfaD1d7+uUs54Ltu?=
 =?us-ascii?Q?FyQWj82iepTFhLjBGdKgKDIqnVXRAB2BltuUMjV93iovFCTTlltPUdm0Uv+S?=
 =?us-ascii?Q?+3sWWOk+1xcCOG8lTvPLkb04lgKqzgweahTEfdKrqQbVmPSXtsB7GAiu+Jys?=
 =?us-ascii?Q?lqap8eUdBMstuMVgv3YeN6UhG+NhP7bmWIJ+E22ZdrV8MbapF3oFYUemQqvA?=
 =?us-ascii?Q?rcjdL4e25TCHL/9WaJ7mJgNdASmmTGjxHJl5KhzAMf16J0shTjhDgu47to+U?=
 =?us-ascii?Q?/m+Ji+RIvq+l9JlqrCxFkEPpPvY+hRSlZv3QKHTdThpdR0Ahfwpv836W4ZxI?=
 =?us-ascii?Q?MTqwHHzDAKDVM01i4zGFukvqd6PKhmWOaY5CLcPY92ELduezGRSLc5PxK0ks?=
 =?us-ascii?Q?2MssrDJ0oL7PU1cypJA6INJPfkJ5eqczdI+nmk/adk59uYUc937qIe+7gee8?=
 =?us-ascii?Q?UTxoo7MFt48T7vax+6sQTrZJHmie2dL/HV7X5kNEYrnnEFVG9Ft1P7DBdBAU?=
 =?us-ascii?Q?TXmfPQXng8lIl2ShexStzCe09SKit+dw09fLkVhQ1KoMKfvf2AGfYMb+b7yv?=
 =?us-ascii?Q?UeoBJ5fkAahw/NIvLskwq1c2aCyQMWZ7zECEDW704TXvP87HH7iOZcDf/yEx?=
 =?us-ascii?Q?cRaNiBzzTNeATh6gx8sjHj1/beJQuRUOMQMLLp/WhU/LPhVHIwskyN8DlHfZ?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f00b9f-81da-483b-a502-08dbdd1164b0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:38:17.9486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKzr3XyVMK3VaqIi4fgZIbhbfwwrfezQGWj8fNl7T7n4+HWJ7FRGZDRhN3L9TBPPxIcOM9rdA6BY8AAj/xMM8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7681

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
index ae58a38d941b..8109f92e56a0 100755
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

