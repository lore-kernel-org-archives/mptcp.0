Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9CD4AF66
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QFItyE5i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XP/B0MP5roD4V7s0LOYnruW2DpV7eWkitylrSSeovysaEzzrBp0UPvFH/MeYJt5rjREZoYBQf/C3DxA8QL+emLD/L6KoXiViSWoRzxOzS9ATPEyX8jDYesTz/J8y2AaFymTeVf0vZZxDP3qjMP8p3HN7vLTw0P8Xu7bkHX/aAtMwZlsLkrFcDV5ikrjf83GWscX12ZtD99X9Sp717AdExTLzRWmQH+2FLPwOvIW3qndazl0tjLUfZIOqOlf3cGPSccwTXeN+hrpsKrBb2nXmNRZh0mwNezKUfsDNeZsoVoJvScay3FKdfrFToOYVR06ZJt8VZo8k2xb3jtNm0eEsKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppbpJiv/ID5CZUNyMRbeCxK4rtG8qjYSCPuK+rKK7dc=;
 b=XCCC9VQ+6ai4aJfcI+0sdb6DhFRhWgw1YZPgPnA8xMdsaTrpby5BzLBCNcW+t7GlyppACKn3DomZelr3Yc6K0i/5I2sZg2+g5gbypNTGFOMzGd/XbzuSgoe7FgOTpyagjzOyxNIGWfGO3huSMCS6LOdEVolQkhedBbN2LjvHgNrF+KUNf1RrEa1rmsIcdlqlny8NqiEeUdYrZYGhaQYegY69sobgdBHekOkrGNWlnvlvsEBcX3aLp/DPPrys7UDzo0/owyf7JHyR4bckpKqPq+bn8XZdkAipZ8xRX/oaTuD0zINhkQJ1Dy9XBbYTMyFHF3QIf69shrGJW9GXWS85mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppbpJiv/ID5CZUNyMRbeCxK4rtG8qjYSCPuK+rKK7dc=;
 b=QFItyE5icRkeZfdXBljOZNR1f3nt24PLswtBmJebbIBeMIRKYW8nMDUqf74J45ur+qJpZcjXO+cwhZgjAmBFTicmQKQ7EyN2up3JsfGG7R14Iqf3qS97zmNQFtqzs21r+02wpr4v/545wXD+Tu2XYd0G7qVoi56xcOv0bMxeM0tK7qfvW9JgK3OItfU7+YIOKC+2q9NFM3uL5XepaoFTtTUWwfbVD+5GnMl8xU+FXtBu/WZYvZ83w127BC9vwy+xFinTHuLpcaI+R+8y30qDdJgg8Cv+QvdAn44PohGx5njgW/dJqykQ8cINLWIvMa7TleO+QcvZ5+eh05nQlUpmEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:32:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:32:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 11/33] selftests: mptcp: add mptcp_lib_ns_* helpers
Date: Wed, 22 Nov 2023 19:30:59 +0800
Message-Id: <7a8935d0bf46abf614ec51a6dbc702f9c65e4e35.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0020.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 381f6e94-6e5a-4ccd-4776-08dbeb4eb7e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b40AnQxf7wtktZr+mYepB+Dp2nMIDCBeYPMqNJ5d6qwgvPH6INR5zNhynaL7PSUrt6R5Mywf+ASlsmYBi8Vh2csE62FNfYz8vbaBSJhVFBxReUaKjKrELHk/qii18dMXdg7qgnaoD92FeomdbBnFHnpNZMRcJJY8pcKQulHJHPiGM3IDIH0rLTGueCcYOwx+/p3//a0FRqHWMiQ6zWTY1s282zFEyjeBe7IrNCJgq6q/+BqiPcgftHYOkT1azfgoPjh8fOb3eJUV6CNuUojhj0frngIKqaTCNONiuAnkWvoWfLciytWoJA7klijgwQlSNkhWwdxscEw+wdNpWNA6PoEJzG5ruFUqo2nO3fMobWBmwc9IOTzCAT0odP9EZybuGZLHgbORMZROt6/4W2s9H6tzNkx2rtgoV7lWDLs58fqqEF9WtRDTcFUiCi2wlpwBrCxVbNCkYiwMXynTq6nwUzW56FxmqC7zQ0q98VC1ewdTs13IpA2xbC5oMQIC/P8W7gfeNasKZ7xAp2D0PQarsZRdsz6gs+83NhFQoduOs2jTe4pzRePOyRFSMZsFao8LL391Xzpz1Rwiaxee9OEq9I4W3R5Widb97NG8+ZoIMhE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(44832011)(2906002)(4326008)(8936002)(41300700001)(8676002)(66946007)(66476007)(316002)(6916009)(66556008)(86362001)(6486002)(107886003)(478600001)(26005)(6512007)(6666004)(36756003)(6506007)(2616005)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4wAm0jbqGlg9iR3fLDTQTFrtDaQXk9dJB+0aHFSK1VK3TyRt2aR6VPOLP77L?=
 =?us-ascii?Q?oc/1EnjhogvSWsDmKPFjen2BQa5SjymIZdujZ85gCwBztRTplgZl5Bx15e+f?=
 =?us-ascii?Q?NMq7n0KsoMmwwFVvLUc57jcvMbaTnReFC852Rjls4Vaaocerr0I7ug+yVvej?=
 =?us-ascii?Q?+uxtJQn+IWi68+AtpB67h9aGkgTV4GuUoO7f6hew90JgnceinT7V+gNepZ/J?=
 =?us-ascii?Q?n162dTmdMRpLnBlHxnknVaKnEP/6b1+A+hFZB4w099QFc4pY2lrXvWkIfV4P?=
 =?us-ascii?Q?ttrNHdiqAJCOTKnfv+wY7QgXAfCSJpg3PratoYhcvpd1rfh9Hl5KUDSsZyxw?=
 =?us-ascii?Q?1EIURzy3Y62r/igLr6P5Nmkg3fPOJlg8Ua4FsdkVXN3/B9Gr15dwnN7wUCK3?=
 =?us-ascii?Q?HqmyW8zm+yl896MefwRMHbJa3Ett91UHHmj4Pd2NSYDxaMW7a4dqBiyxSjIv?=
 =?us-ascii?Q?WkfOh1PoGgGYFNImRvkDCof2EVRZ0lXBMrhp8iIpRrinm2YKFj8UBnQmN1z2?=
 =?us-ascii?Q?gH7tZeFklPkDcrIL5m1ZzIWT91OlBYWVo8mquQQ3rK1FTArt1jpoS+8FBu0d?=
 =?us-ascii?Q?s7ox5oGLc242+gaeTCOgul6AwLEYtVC+1K7/hWAk1CCchFyK8wSx3nPzB/1Y?=
 =?us-ascii?Q?lEt8MxM4yni/U3ARioBWr3Uayp+DaQQROOig7Lh9A7wBjuoIxvuMc2OvxUbF?=
 =?us-ascii?Q?fB4fIrR92/rzniDtgSu24wyMyk3X9nTBXDyTm2hV1saumPMm3A8q9ATuOVCK?=
 =?us-ascii?Q?WaL/K4zVkCw8LYxh4k7JbI9FqtB9oS0VLduZCzaAotjLZwVU2+JYmpDphmrf?=
 =?us-ascii?Q?WEAEp3RThiZlDo/McRt5u0We119LSj2JQsChL+bU2XWhn85BGMIx10Y1EZ4Z?=
 =?us-ascii?Q?aKs/l7g3mf1rdKRQKqnNJ0YfyelncWf8xMhUCY8EPCcDito/QAms2VJ0r9yj?=
 =?us-ascii?Q?a1lMxpg3/aWadjf5pM6bvbWNKJz1rSL3jIJ3HWGpl670ilYqCCAUHgIVg6Ag?=
 =?us-ascii?Q?xtDl7vg8iCAPTtX/fJJH7WmEXr/W5yXnkQ8DvTfG6IgkdMuBdcFhGd92i7Iu?=
 =?us-ascii?Q?en4uzd1AWQ/K2sVBMgltKS31Oby9skKKSnUryU33X3OutGgQb/EHlMJ7NP47?=
 =?us-ascii?Q?LS8C2nURkFzXzkPXCYEygbkGO3PvG4n4o+AgEomN3EKSTgCBM2AP1UNXablG?=
 =?us-ascii?Q?Ry971/NNG+235oNHF8e7zj9l6lirYTLlKL5Y+1eCoB0Rp3dIaEoJm4iuxwiT?=
 =?us-ascii?Q?u+arQNT6wAb/0b3V+7gDV7zNCkl8yk+COqzoey1buE2Hz22acCQjuBhFcBGk?=
 =?us-ascii?Q?ZP/Oy0vivREXhoNVBV4nvCIzjeL4YN9UttYmR0eVlOHoQJfZ6ZMhUiyFYi94?=
 =?us-ascii?Q?4d98E7QH94hTcdqD/lnQRrnvh1U8GgNu/dTBobGJs0ifAMy7PrUiGxHr0/lU?=
 =?us-ascii?Q?QelOm2tv05qeVsgsC7nqCB0AVDyiYHzr3m6GOe4AeVjjXBja08gpp/SQH201?=
 =?us-ascii?Q?mMXRgB3sLttlCb2YxrVKuoCJsBupRQXz/k5oQqiJmM4o6Gp5GERIl9J6OU8s?=
 =?us-ascii?Q?dLpHCG0Hkpy3bDNmK8Vx7oAXAacmFdho0V/I3/AtBYsWQdt3Smvwp5n4craO?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381f6e94-6e5a-4ccd-4776-08dbeb4eb7e0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:32:33.3030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaCfFsil4TqCI1M40I+BcqGnKVL0t9FpORfxaxWJMH3f0HaH1MrlYlxbO4jpuHSP70lwgcEu5T0Ghsj1LR5EpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

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
 .../selftests/net/mptcp/userspace_pm.sh       | 12 ++-----
 8 files changed, 50 insertions(+), 84 deletions(-)

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
index 69bc8d16fc14..7b9e3e3ea8c4 100755
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
index 20c260aa68dd..2d28d0980b85 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -466,6 +466,42 @@ mptcp_lib_verify_listener_events() {
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
index e78a79da3960..93f8b200ce49 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -40,10 +40,7 @@ app6_port=50004
 client_addr_id=${RANDOM:0:2}
 server_addr_id=${RANDOM:0:2}
 
-sec=$(date +%s)
-rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
+mptcp_lib_ns_init
 TEST_NAME=""
 
 _printf() {
@@ -102,10 +99,7 @@ cleanup()
 	done
 	mptcp_lib_evts_kill
 
-	local netns
-	for netns in "$ns1" "$ns2" ;do
-		ip netns del "$netns"
-	done
+	mptcp_lib_ns_exit
 
 	rm -rf $file
 	mptcp_lib_evts_remove
@@ -118,8 +112,6 @@ trap cleanup EXIT
 
 # Create and configure network namespaces for testing
 for i in "$ns1" "$ns2" ;do
-	ip netns add "$i" || exit 1
-	ip -net "$i" link set lo up
 	ip netns exec "$i" sysctl -q net.mptcp.enabled=1
 	ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
 done
-- 
2.35.3

