Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25742612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NIdRVl3t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpO8QkBdsnKyrW4rwUD7cC7hHK2L9HIk9+Eqh6rIw9pbnxxLzx6c5IMFJm2gpU0F3B37Y89owGrbV4hknYyjanPnSoN8CEQVlXmy7Ml/6tox0mkVMSmiUhT6v4RH67l/9IDUuIz2aHQBp4bfj2RvnQKHv21ydQPk9Q+/iIMptdbButr8CnegM/RgiHwofE9me5uWEZ6cJY6tGrEV/+VjVJ4t/xmtXF2ga549QrHoUs/Y4qP8/WDfGiTlLOiFeiq6RAaY7ubisMw+GV4FZKkzEnvTgu5VZZ3/5O26Er/Op7tK+vbsCa0KsSfpt0B+46V5Jih47noiuyMsBvIOy/kH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3pTcZmlnDgqtBPn6QYPKyX74olCJio0G4PnQmr+Rq4=;
 b=lwpBVz5Q3XBvh3+zSCbI92cSqwYfc7cjXzkFPcq4LcfJifaX1foRZhnQV/XFlq+biweGMuz2r/UZpV6JBb1I09zvhJpkKXEiPVQC6Wd4wES1gcJhR+Btyk7MqaPZb5O+6UV98AGKCPxYJMGOYmoej8ePayCal7gXPE7/Czjy5ER9vVyUlpESw/FXsSOMnzbjKeWZAhAX8qzFEcN1edoJ8fJFGKvHXioGu1WXjSkNm0n0GK41IK7fA8DvdDzzUaU5xc9dBMRgufafdQIi3ZfzUmtXXfxshcqjjAQxuahpS2rFCNCIbgYENBcWPUW9l3X00wYQ2jX48qo2y6acYUi+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3pTcZmlnDgqtBPn6QYPKyX74olCJio0G4PnQmr+Rq4=;
 b=NIdRVl3tRl3FZAw+wgIoI+03MxO9BtxWmw5B+DYx1+WkfEhe77wZBbFk+dbV9jIFTAWYbUwFVrWSKeev+Ita2xktJio3uX5tVuKvnS68di0KW8+yI0c8I7vGzBnNgFkSIFV0Gal8Z/LY7xpPXjGDmix+VSD9ReGhF+5oXTj0gkqaC7nnw1ENWhNUGGGhxJktdt7k+UzLpQu2dPW7aPVkBkVA/847tP8AWH10v3PYa8RkLTQu1VJhvOspVvEwj9msEpa5eTCTO69tTrWJ7m6/3POeMr2Ae2sRm063qFxMHb4xacWbfs1ZaBg0hcvX9MALgERSTRIiFYESDS7FTjHQkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:39:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:39:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 11/32] selftests: mptcp: add mptcp_lib_ns_* helpers
Date: Tue, 14 Nov 2023 14:35:30 +0800
Message-Id: <8eda57c54159909bc1ca77d991fe3640f917ae7d.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0216.jpnprd01.prod.outlook.com
 (2603:1096:404:29::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f5db98d-25ec-4ff5-c2ad-08dbe4dc70b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rsL83rgprQZXx1cRMaRBmmVpjvP3+jII5nSGY8l73zHXWashubAe8YQHzXiDcWz7fr35UbPEstqD1UsxlOufApFllH9/IusoBZlM199qHw/qMfseD4i5Ug0YFTpGbsHu6UQR/VEbBmal1tItUeHt/2CPifNIbONCowe/wIYq4kUuFe9ZqpZ0o6jWTRLeeDwiQc3u/GRhGwBhgRwYEfydNyC05mTbHbfsUtXhHGM4eRDrN1srC2rcIxR56xWvEqoAELQjDetdixCdVmTvflYLyKDTjPx8wnn+VWtAStq+Cl272wAW+D3Vb2+owJ97Il45LfQjzo6ZDOfq2RW9Lw/hnkT+4/j/DlOGHUa1+TywKcIFujRPpRisiAUSlRPUbrm5H8Mnjx4o0WCOD9qU+Md6la3kEQTZ4qtSjxzgH3jgZYyBJuUGV876rSDEGqtB4nZ2k5Ok2h3oQRUHypaBFPnEjbTWMT/SA2JOqLXbSYEc90NfSjNfqrOPPKLl7FVv0JuDSvFQTLEwiy/eOdk8U2c62jsrmdGs4MuAwcshIN380jf+98d6f0sgDVhCegarGZzg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2906002)(41300700001)(38100700002)(66476007)(66556008)(478600001)(6486002)(86362001)(66946007)(6512007)(2616005)(26005)(107886003)(6506007)(6666004)(83380400001)(8936002)(8676002)(4326008)(44832011)(5660300002)(316002)(36756003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+eK4H8UCkSHl0L7FvSdvgPx0FQTdfTsh5vh1pdBH8gfCxUV8nkzN+D0SBjY1?=
 =?us-ascii?Q?KubAvv1Z18B8wu2MWwRCkSCAEKGAemSz1LeM9yqW8WeakvgQlOGmIrSBoCM2?=
 =?us-ascii?Q?kihty/pGygBiNf5HcIDH9+1EmMrraZfx1fskvGmf/04lCd2VlaNWU73Sx4aI?=
 =?us-ascii?Q?X5I8M2PgBdA4JaZScCscZlOx4nsZBNJP2MpEmJdX4B6onC7J6ImaLWmdHaL1?=
 =?us-ascii?Q?zyhO0UUTpKrAly6TT7Lc5yAlTHUIl/89ao/OBybZAsv2/vHIwXeSp+PZLea1?=
 =?us-ascii?Q?43gPePre5MzaWWsRBpbV2uTBuHl0fHFWDHYnJV4YOZ1wALwBfjJB378pbHnz?=
 =?us-ascii?Q?sWHjKvrWMOEaagw31/HDwLtukF9z44/ECpF/XY8qezavRftA3ZQbdV0b983O?=
 =?us-ascii?Q?ref+A1u0c+ztAJc4qSHMDpXiFA17PJn4dv0n+vdM55vqzd+DlO31FgAUMfNr?=
 =?us-ascii?Q?S/m/ZX3YM+wH97QJh8jUordBrzo1qMpv9Ad21WU8vI2iS9AirXEdSAwUv/Wi?=
 =?us-ascii?Q?UgyVa6/t5cIuhqrmES0RR0BCW8IvtXKPjE0rdTelJf8Z/LiDkztc/QYJpD7/?=
 =?us-ascii?Q?tLUPFQhLG7ehWm+c1RbJR7qMqWDnz1Mr9NECTqa7vK1LicNxdLZ8M5h4c6Oo?=
 =?us-ascii?Q?G3ylXJ9Cn0Dz99nIRGfFFAo+25EJCkVQXY2B9zmKhf2/37fkwEtja1tSlN7i?=
 =?us-ascii?Q?DADYxj7Xe3m02Cad7EUhmRcBbikGQ49Xk+nAtWvrQbooscIDYjCfWwe0j/7y?=
 =?us-ascii?Q?ELGM85G65AnppHHMIK2CUeNjrINR7Hz1M69eIpOxV4f1JrrgfK4PaBl8MrMj?=
 =?us-ascii?Q?Y7+JDy4DlSvpOzyvcFpO2JvoLQiG6SVFPKmfPLJpowS/PljXz2g3O1XlscRk?=
 =?us-ascii?Q?T27l3Pe5cizSr4skwNGnk39nZo8hx31ik71l0bwgAcepKDl5MLPyDu8vQeiK?=
 =?us-ascii?Q?hvzYMu8bYEXOOHNfHLYkJoB1ZKLAdjvfsSRDWLJUlx6N6EBKr3PMDT7GU9ae?=
 =?us-ascii?Q?K3WppOjjtW43P/JGnPfRfJ5dW1iB/RI70BSrpFbtXhn0ofFOpMLV5O282fVh?=
 =?us-ascii?Q?PHvccnx8KVPjgUDn5HfNinpNylPUNPcuzcqXfLg2KNQklLIy4soaT6Oh+KeK?=
 =?us-ascii?Q?EACFTEdopJ6lQuvKj75YtbhHpwDUoV5uLFWIBtIACv2iqQZ+AxSpv54iMkTl?=
 =?us-ascii?Q?LsCqTki1PdfDust7A8BVWV+SVnXUfAUp+f/xgZTkCh51EdpESdiEVKjZ/X1c?=
 =?us-ascii?Q?yADyOnCmYVbBStlzsYLkR2vh5AZpW9BK1ekCKhhTEGLXkB7Z+IdkLU6ekcKN?=
 =?us-ascii?Q?lU8+kSBX4St6jeqX5UPYAShhYd6mhVMuhepEB5skCLitAXmmyAM636xWoUpF?=
 =?us-ascii?Q?Cp0deANV3rNVuQXbPFeXcBfFdw0pi78IATmtfXURcpfTW/ytybUbSarbwnFO?=
 =?us-ascii?Q?a8fm76louUSCflBycv3YgnhhUlzPuoBScRFu6SRu3uxfeg9PZX94RNeVWvzm?=
 =?us-ascii?Q?OYgR5KSYlauKqxNRFnC6K0NhsSdVpTFi5XNSftsZeCAqToh01b4AWQM0mV2s?=
 =?us-ascii?Q?aVYtcqp6F1UM2dCuC9DaV0TlMDFDw+nOHRJHIpw8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5db98d-25ec-4ff5-c2ad-08dbe4dc70b5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:39:24.1818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDxUT0Q9/3RJCSHkee0FnHfSe8/x9pgIsSajCoC6Tk6EaIFZnXL7nXuev22BAqjT8xGmI9YSQWGfkDzWW4FWfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480

Add helpers mptcp_lib_ns_init() and mptcp_lib_ns_exit() in mptcp_lib.sh to
init all namespaces ns1, ns2, ns3 and ns4. Then every test script can
invoke these helpers and use all namespaces.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh     |  8 ++---
 .../selftests/net/mptcp/mptcp_connect.sh      | 18 ++--------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 ++--------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 36 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 15 ++------
 .../testing/selftests/net/mptcp/pm_netlink.sh |  8 ++---
 .../selftests/net/mptcp/simult_flows.sh       | 18 ++--------
 .../selftests/net/mptcp/userspace_pm.sh       | 13 ++-----
 8 files changed, 50 insertions(+), 85 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index bc3f24c454be..3119811018fc 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -3,9 +3,7 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
+mptcp_lib_ns_init
 ksft_skip=4
 test_cnt=1
 timeout_poll=100
@@ -29,7 +27,7 @@ cleanup()
 {
 	ip netns pids "${ns1}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
 
-	ip netns del $ns1
+	mptcp_lib_ns_exit
 	mptcp_lib_cleanup
 }
 
@@ -197,8 +195,6 @@ wait_connected()
 }
 
 trap cleanup EXIT
-ip netns add $ns1
-ip -n $ns1 link set dev lo up
 
 echo "a" | \
 	timeout ${timeout_test} \
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 5e28292e1889..5e0263e691a8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -120,12 +120,7 @@ while getopts "$optstring" option;do
 	esac
 done
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns3="ns3-$rndh"
-ns4="ns4-$rndh"
+mptcp_lib_ns_init
 
 TEST_COUNT=0
 TEST_GROUP=""
@@ -137,11 +132,7 @@ cleanup()
 	rm -f "$sin" "$sout"
 	rm -f "$capout"
 
-	local netns
-	for netns in "$ns1" "$ns2" "$ns3" "$ns4";do
-		ip netns del $netns
-		rm -f /tmp/$netns.{nstat,out}
-	done
+	mptcp_lib_ns_exit
 	mptcp_lib_cleanup
 }
 
@@ -163,11 +154,6 @@ cin_disconnect="$cin".disconnect
 cout_disconnect="$cout".disconnect
 trap cleanup EXIT
 
-for i in "$ns1" "$ns2" "$ns3" "$ns4";do
-	ip netns add $i || exit $ksft_skip
-	ip -net $i link set lo up
-done
-
 #  "$ns1"              ns2                    ns3                     ns4
 # ns1eth2    ns2eth1   ns2eth3      ns3eth2   ns3eth4       ns4eth3
 #                           - drop 1% ->            reorder 25%
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9ad8c600e58f..52a4080b32d9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -21,8 +21,6 @@ cinsent=""
 tmpfile=""
 cout=""
 capout=""
-ns1=""
-ns2=""
 ksft_skip=4
 iptables="iptables"
 ip6tables="ip6tables"
@@ -78,21 +76,12 @@ init_partial()
 {
 	capout=$(mktemp)
 
-	local sec rndh
-	sec=$(date +%s)
-	rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-
-	ns1="ns1-$rndh"
-	ns2="ns2-$rndh"
+	mptcp_lib_ns_init
 
 	local netns
 	for netns in "$ns1" "$ns2"; do
-		ip netns add $netns || exit $ksft_skip
-		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
 		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
-		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
-		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
 		if [ $checksum -eq 1 ]; then
 			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
 		fi
@@ -137,11 +126,7 @@ cleanup_partial()
 {
 	rm -f "$capout"
 
-	local netns
-	for netns in "$ns1" "$ns2"; do
-		ip netns del $netns
-		rm -f /tmp/$netns.{nstat,out}
-	done
+	mptcp_lib_ns_exit
 }
 
 check_tools()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 09d948f45f59..d1bd8aa02c2e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -463,6 +463,42 @@ mptcp_lib_verify_listener_events() {
 	mptcp_lib_check_expected "type" "family" "saddr" "sport"
 }
 
+rndh=""
+ns1=""
+ns2=""
+ns3=""
+ns4=""
+
+mptcp_lib_ns_init() {
+	local sec
+
+	sec=$(date +%s)
+	rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
+
+	ns1="ns1-$rndh"
+	ns2="ns2-$rndh"
+	ns3="ns3-$rndh"
+	ns4="ns4-$rndh"
+
+	local netns
+	for netns in "$ns1" "$ns2" "$ns3" "$ns4"; do
+		ip netns add $netns || exit ${ksft_skip}
+		ip -net $netns link set lo up
+
+		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
+		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
+	done
+}
+
+mptcp_lib_ns_exit()
+{
+	local netns
+	for netns in "$ns1" "$ns2" "$ns3" "$ns4"; do
+		ip netns del $netns
+		rm -f /tmp/$netns.{nstat,out}
+	done
+}
+
 mptcp_lib_cleanup()
 {
 	echo "cleanup"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index b82f7b0b85bc..ff49ee9b9cc2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -13,11 +13,7 @@ timeout_test=$((timeout_poll * 2 + 1))
 iptables="iptables"
 ip6tables="ip6tables"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns3="ns3-$rndh"
+mptcp_lib_ns_init
 
 add_mark_rules()
 {
@@ -41,11 +37,7 @@ init()
 {
 	local netns
 	for netns in "$ns1" "$ns2" "$ns3";do
-		ip netns add $netns || exit $ksft_skip
-		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
-		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
-		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
 	done
 
 	local i
@@ -78,10 +70,7 @@ init()
 
 cleanup()
 {
-	local netns
-	for netns in "$ns1" "$ns2" "$ns3"; do
-		ip netns del $netns
-	done
+	mptcp_lib_ns_exit
 	rm -f "$cin" "$cout"
 	rm -f "$sin" "$sout"
 	mptcp_lib_cleanup
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 75c7594dbd71..32265d4ecb41 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -23,13 +23,11 @@ while getopts "$optstring" option;do
 	esac
 done
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
+mptcp_lib_ns_init
 
 cleanup()
 {
-	ip netns del $ns1
+	mptcp_lib_ns_exit
 	mptcp_lib_cleanup
 }
 
@@ -43,8 +41,6 @@ fi
 
 trap cleanup EXIT
 
-ip netns add $ns1 || exit $ksft_skip
-ip -net $ns1 link set lo up
 ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
 check()
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 3536c7160ce5..c1a21cd8c076 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -3,11 +3,7 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns3="ns3-$rndh"
+mptcp_lib_ns_init
 capture=false
 ksft_skip=4
 timeout_poll=30
@@ -29,10 +25,7 @@ cleanup()
 	rm -f "$large" "$small"
 	rm -f "$capout"
 
-	local netns
-	for netns in "$ns1" "$ns2" "$ns3";do
-		ip netns del $netns
-	done
+	mptcp_lib_ns_exit
 	mptcp_lib_cleanup
 }
 
@@ -64,13 +57,6 @@ setup()
 
 	trap cleanup EXIT
 
-	for i in "$ns1" "$ns2" "$ns3";do
-		ip netns add $i || exit $ksft_skip
-		ip -net $i link set lo up
-		ip netns exec $i sysctl -q net.ipv4.conf.all.rp_filter=0
-		ip netns exec $i sysctl -q net.ipv4.conf.default.rp_filter=0
-	done
-
 	ip link add ns1eth1 netns "$ns1" type veth peer name ns2eth1 netns "$ns2"
 	ip link add ns1eth2 netns "$ns1" type veth peer name ns2eth2 netns "$ns2"
 	ip link add ns2eth3 netns "$ns2" type veth peer name ns3eth1 netns "$ns3"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 22812292b00f..22a436c4a77a 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -44,11 +44,7 @@ app6_port=50004
 client_addr_id=${RANDOM:0:2}
 server_addr_id=${RANDOM:0:2}
 
-sec=$(date +%s)
-rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-TEST_NAME=""
+mptcp_lib_ns_init
 
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
@@ -106,10 +102,7 @@ cleanup()
 	done
 	mptcp_lib_evts_kill
 
-	local netns
-	for netns in "$ns1" "$ns2" ;do
-		ip netns del "$netns"
-	done
+	mptcp_lib_ns_exit
 
 	rm -rf $file
 	mptcp_lib_evts_remove
@@ -122,8 +115,6 @@ trap cleanup EXIT
 
 # Create and configure network namespaces for testing
 for i in "$ns1" "$ns2" ;do
-	ip netns add "$i" || exit 1
-	ip -net "$i" link set lo up
 	ip netns exec "$i" sysctl -q net.mptcp.enabled=1
 	ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
 done
-- 
2.35.3

