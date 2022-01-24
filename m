Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C3E29CA
	for <mptcp@lists.linux.dev>; Mon, 24 Jan 2022 08:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643012238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e80tFFsuxbmLTxJhSDcIuyGRjieAMDvYyneD+k1He2U=;
	b=AJq+Nds4HYKgXgbp1pEVoDWJrup7VTUFC8nuacDzVmZ8eAZX5GioSwxRtzaSCXcK5IxIKQ
	LP9FG95Oh/tw+uBCk5lyealnNv++F/+0DddhjKlXN0K2Q4atQuvdklB8opy1NyKNrjyy9U
	fc6RNJHyMGLQkR6BSBjvJkCeniRDQKU=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38--H2Aqf4mPmqI6Xiiqlkglw-1; Mon, 24 Jan 2022 09:17:17 +0100
X-MC-Unique: -H2Aqf4mPmqI6Xiiqlkglw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4RqXakHQQK9l2PM/9Bs+Hds3CYSoMYwdKMWi1neXzogRBpPecLZIJ3fU60RcjoBKbjS9t6sy8xhdmEDjNWGEswFSvnClEHvxsACFZgxpkTBRm6787E3WJjrUskxLusoRszxJeqso3D2hbgATkZwZDSUkM3VeBcPsjv0fgcMdHQYZzWlMciuqyQdZKLbdI86WDTptsabVpQYF42X4KzRcbFZw8Z9V8yuy5nV9CzIZCYBLBdu2A6JEt2wfzefpDb0jP40bw6h0xjQApceBj+CCpIFcnwcPu1DR2JAYWsPSF+vpRVEgVaBEJZ3IrA0fDt8jbHnBw0+I7Z6xcYA1l8M2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCDvQ+FMMg5ttIx243yzFEnim3ZMA91cYDGPiScpQeo=;
 b=e7rETf1A2TomGvV/7BQrIh8mOtzam0LI1W6wXk/xk7OsxsQkS53sIqxs4W1bXKYvSWeTlax8sUJm02wch+9WC+BZxIg4oH7lxwFN60Cr1RKbsc7rWckHBoOmhmqb/fLiYGk+AJcWNefcz4xHOs4DSfX6gwkR3OLj0yG9na+fXL6tNXZqi/Uckpwt0RhqAk+2OhNlytlndEnAsDC2pn41kOJfML0qmKDcrG3OejTPtxscfsdw1KPcJE2XbMfopsKTDtLqEr96PxZHVM5ZZc3JeKiV++IhBwl4P/4c3swR2KkZOcECdudq2vKjLyfgh7rPR6eWd4lGn4fUZABamI6scA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB6136.eurprd04.prod.outlook.com (2603:10a6:20b:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Mon, 24 Jan
 2022 08:17:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 08:17:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v10] selftests: mptcp: add mp_fail testcases
Date: Mon, 24 Jan 2022 16:17:24 +0800
Message-ID: <28db1152f29194bec48ad28dd37b7706cb92446b.1643011961.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0239.apcprd06.prod.outlook.com
 (2603:1096:4:ac::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b649f842-268f-4c60-89b9-08d9df11ee40
X-MS-TrafficTypeDiagnostic: AM6PR04MB6136:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB613660BEA4497562B877C9DCF85E9@AM6PR04MB6136.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2TGFzLerrvckxaXkL2LY6frS5vcF0gIEeuVdSI1RZh8WroVxPFSziFg+WWAOF55oR1eC9Z/KbTk2ftOuybSUbhOpaPLlhGa3vPJn8/slB9lraFeUZZVRfYVwyfLrH/9WTDVobaAGnio9mqJWFYO11rw5d08pKBuusqDwSX96Pa8F+gBmczpvD3w/Kl3AJ6cy8Yq9V1DJj52sSF35tDjD5tAqEHWSPOo95s1grdurz/TorTKFF5FonSpwsNk0R7Q38FLQ+kjfSYhdesuRO8OLPmGrn29H+PmnzO9eBYIb0HPvBT2nDlpJA1FIN9y+WobYcaI7AhlwNtnM7DtjUvs41epXwxcu1LXRLPkGlRvfoeNYckIU7JhbgdLDIV+TPDYHx23XMTGY82RiPlWMeXsHZY5lOSjE5Ec4vp/uTQs5EoxiM5Uw/mfdFZIa7lEaSkV3G+VnFlEpnsVY2mjksCi4aXEjEP1OR+Jbp81KIYDBSukaqN+U7cz2tgkTJM7uH1GhAatla0XATGli51av6lpbxhzOyivsnZc+/vlw1tyIuJ4EuBMeDHTWrvDxYf9Z84MFtAmAKlnESKb0CW1dir5gPSlKzL84Ekm+7tcB8R/chqTEt1QyHDUMM6D08D+w/4gk7X5ElbqiE2rtJzD7gG9x2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(2616005)(186003)(44832011)(26005)(4326008)(5660300002)(6916009)(8676002)(83380400001)(54906003)(66556008)(66476007)(66574015)(316002)(8936002)(36756003)(6512007)(6506007)(55236004)(6666004)(2906002)(6486002)(508600001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?znq3Z25Ngia12GjHnhysyV2z/BrgdQj7P+TurgLSGE4R22petfMY5vlHBxwd?=
 =?us-ascii?Q?DPN6pw8og+w1ThVLy8hffIYJR/NOPcZQxerc4PS1Z/pn4XVng9UPtYq0d9Tl?=
 =?us-ascii?Q?dThsiDCGP+OsuVCYfKnCyC5/ArWXHukdTCdrqRPX+txqAhx7HYCHjGA+bZ2f?=
 =?us-ascii?Q?PxasHI7VXA/i7oBzLEfKwObf/g386GTV0fEhzTa6hE27E9iZza+iZmspdd5f?=
 =?us-ascii?Q?G2JSw+jGxQogY97X+tHapPW/TIisdeHqjIXSkrc9cJyL+KlwEXpUTNfCWcUZ?=
 =?us-ascii?Q?jdWdmilP3CMdVXOs27K3eaU19okvw4PxqOMDQuEGevkN+UHJmVuNqxYOliF3?=
 =?us-ascii?Q?D9weT1ObltWRK8Eol50oraAnDSwH11/hHJVHpJfbHF+O5VCapp1+APT57DGg?=
 =?us-ascii?Q?wT0k11Wkm3e8y+OhkbwvHWWa6XG+bHUl+bPSEK86tB86N/cE4zgqlwkCCYQ2?=
 =?us-ascii?Q?YMigFFUsCbhmMprteBQ2s0dZIV0FWcJ41fFvC38EhK6h5KqZldvSEMYEp987?=
 =?us-ascii?Q?h1/+5+D4ECG6Y0KWDXG1xJzin91gzL03nEvYYxlg9qneJlYgb/mgiLyM7NmP?=
 =?us-ascii?Q?FMBk4EFU9QDL8fMjDupADjouYbQOnHjSPhXVRM3u5SaZ8exe1Hi554uVm4cL?=
 =?us-ascii?Q?MIGm+ZXODhH0TDKpsZLsYPOXfdzDvQ1GaOQ4mNwt1aT7jfaaji+nmMlENrAh?=
 =?us-ascii?Q?E1AvDJ37/ZAv7W1r2EkbkavXxTgydcmbZcbnmymk0tIfjZVmD70l+f9O1uHx?=
 =?us-ascii?Q?MD495D+Cob+/1JVwJQeGennmLOOtV4ZPrX2ymeoDse+0UA5UEKFG482wIenz?=
 =?us-ascii?Q?iJAqs8yyKz80GqukNpwGfg+ihdZyPMx+zi3U8XJA7gTv3XJs7MuFvPPUltQp?=
 =?us-ascii?Q?xZdbkWaylNfuSt8nfYtic72/kYrk9BJhwtOLeetz7S0Z+aAn/a5Y1JUO2Tle?=
 =?us-ascii?Q?3caqbGVq9oNzqExydiQgKQeCioETXW5/NNjTi/dY0sxeKTpy9B8PSFytMFDP?=
 =?us-ascii?Q?MSbZVRhzm8tthkeuiR2Zj28vFEFqM5pEC7AR3b1H9f1IyQ0O6dNGx9pRflia?=
 =?us-ascii?Q?ufCKIHbJDBJ1XjADyYdUQTrXYTt+H6oi5cZZoRQfOg9H99mSrTTgqoCIqvKB?=
 =?us-ascii?Q?xUPBCOzk6XdCWSbU0v8uIXo/NJ0wHnDyeBV7nG2hQuD9ZTghh0GGxMDHOSXh?=
 =?us-ascii?Q?gPFnUmOoRxcX+QcYZ50s6G1gIixrhLSjynGaAOXubUWtBd72bOooi/XLDoAt?=
 =?us-ascii?Q?ax2L9g+Ap45suJm/CTSI+SDkUtxchr02/fjCop4GAEOAnyYui1ZWuju2TCIu?=
 =?us-ascii?Q?3FyqS/GHeQIxi9JPLKvpVrRZlDxvsDx4rQZSR9LLfrs9W7DycJSGVWNQ70Fs?=
 =?us-ascii?Q?uEiU09+FdUrBf1DwmCSGenVNhBRiXexb6x7wpypixJxAGk4bGnSBy5soIDDa?=
 =?us-ascii?Q?wjwdgTByx0K/qPOaWVHzk6kcC5U/xa2B83AeN730kRZWYNuNuRm0nAM2cpjm?=
 =?us-ascii?Q?Y41dQr3b0ZPjOlJgzRn6m9iikR91AJyp2jX/EY3hR6pJhOeJliGnc8NHnIc/?=
 =?us-ascii?Q?y4DoO3/gGXmTG4fJMsYk0knfP5P1O7Vp9YtsLZ9nJ3fGsWsNTYQu3QnajiZz?=
 =?us-ascii?Q?vr4CcBiMUf5Gb8aZml0rrlk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b649f842-268f-4c60-89b9-08d9df11ee40
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 08:17:15.8499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IHSW2lIvTReSyG1bcyytvwZ2ZX2/XqEdd1J5BfN0RlYukwzgCZ1oErJyySOACZ1bnw0KQP+Xc5b+cqhFKNs1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6136

Added the test cases for MP_FAIL, use 'tc' commands to trigger the
checksum failures.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 v10:
 - enable check_invert
 - use ip mptcp wrappers
---
 tools/testing/selftests/net/mptcp/config      |   5 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 112 ++++++++++++++++--
 2 files changed, 108 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selft=
ests/net/mptcp/config
index d36b7da5082a..26955abe49f0 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -19,3 +19,8 @@ CONFIG_IP_ADVANCED_ROUTER=3Dy
 CONFIG_IP_MULTIPLE_TABLES=3Dy
 CONFIG_IP_NF_TARGET_REJECT=3Dm
 CONFIG_IPV6_MULTIPLE_TABLES=3Dy
+CONFIG_NET_ACT_CSUM=3Dm
+CONFIG_NET_ACT_PEDIT=3Dm
+CONFIG_NET_CLS_ACT=3Dy
+CONFIG_NET_CLS_FLOWER=3Dm
+CONFIG_NET_SCH_INGRESS=3Dm
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 76c45c845d3b..32e17c9e2e2c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -17,6 +17,8 @@ capture=3D0
 checksum=3D0
 ip_mptcp=3D0
 check_invert=3D0
+validate_checksum=3D0
+nr_fail=3D0
 do_all_tests=3D1
=20
 TEST_COUNT=3D0
@@ -61,6 +63,7 @@ init()
 	done
=20
 	check_invert=3D0
+	validate_checksum=3D$checksum
=20
 	#  ns1              ns2
 	# ns1eth1    ns2eth1
@@ -166,6 +169,46 @@ reset_with_allow_join_id0()
 	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=3D$ns=
2_enable
 }
=20
+# Modify TCP payload without corrupting the TCP packet
+#
+# This rule inverts a 32-bit word at byte offset 148 for all TCP ACK
+# packets carrying enough data.
+# Once it is done, the TCP Checksum field is updated so the packet
+# is still considered as valid at the TCP level.
+# But because the MPTCP checksum, covering the TCP options and data,
+# has not been updated, we will detect the modification and emit an
+# MP_FAIL: what we want to validate here.
+#
+# Please note that this rule will produce this pr_info() message for
+# each TCP ACK packets not carrying enough data:
+#
+#     tc action pedit offset 162 out of bounds
+#
+# But this should be limited to a very few numbers of packets as we
+# restrict this rule to outgoing TCP traffic with only the ACK flag
+# + except the 3rd ACK, only packets carrying data should be seen in
+# this direction.
+reset_with_fail()
+{
+	reset
+
+	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=3D1
+	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=3D1
+
+	check_invert=3D1
+	validate_checksum=3D1
+	nr_fail=3D0
+	i=3D"$1"
+
+	tc -n $ns2 qdisc add dev ns2eth$i clsact
+	tc -n $ns2 filter add dev ns2eth$i egress \
+		protocol ip prio 1000 \
+		flower ip_proto tcp tcp_flags 0x10/0xff \
+		action pedit munge offset 148 u32 invert \
+		pipe csum tcp \
+		index 100
+}
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
@@ -184,6 +227,12 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
=20
+jq -V > /dev/null 2>&1
+if [ $? -ne 0 ];then
+	echo "SKIP: Could not run all tests without jq tool"
+	exit $ksft_skip
+fi
+
 print_file_err()
 {
 	ls -l "$1" 1>&2
@@ -244,6 +293,21 @@ link_failure()
 	done
 }
=20
+get_nr_fail()
+{
+	i=3D"$1"
+
+	local action=3D$(tc -n $ns2 -j -s action show action pedit index 100)
+	local packets=3D$(echo $action | jq '.[1].actions[0].stats.packets')
+	local overlimits=3D$(echo $action | jq '.[1].actions[0].stats.overlimits'=
)
+
+	let pkt=3D$packets-$overlimits
+	if [ $pkt -gt 0 ]; then
+		nr_fail=3D1
+	fi
+	tc -n $ns2 qdisc del dev ns2eth$i clsact
+}
+
 # $1: IP address
 is_v6()
 {
@@ -739,6 +803,8 @@ dump_stats()
 chk_csum_nr()
 {
 	local msg=3D${1:-""}
+	local csum_ns1=3D${2:-0}
+	local csum_ns2=3D${3:-0}
 	local count
 	local dump_stats
=20
@@ -750,8 +816,8 @@ chk_csum_nr()
 	printf " %-36s %s" "$msg" "sum"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D 0 ]; then
-		echo "[fail] got $count data checksum error[s] expected 0"
+	if [ "$count" !=3D $csum_ns1 ]; then
+		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
 		ret=3D1
 		dump_stats=3D1
 	else
@@ -760,8 +826,8 @@ chk_csum_nr()
 	echo -n " - csum  "
 	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D 0 ]; then
-		echo "[fail] got $count data checksum error[s] expected 0"
+	if [ "$count" !=3D $csum_ns2 ]; then
+		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
 		ret=3D1
 		dump_stats=3D1
 	else
@@ -840,6 +906,8 @@ chk_join_nr()
 	local syn_nr=3D$2
 	local syn_ack_nr=3D$3
 	local ack_nr=3D$4
+	local fail_nr=3D${5:-0}
+	local infi_nr=3D${6:-0}
 	local count
 	local dump_stats
=20
@@ -876,10 +944,10 @@ chk_join_nr()
 		echo "[ ok ]"
 	fi
 	[ "${dump_stats}" =3D 1 ] && dump_stats
-	if [ $checksum -eq 1 ]; then
-		chk_csum_nr
-		chk_fail_nr 0 0
-		chk_infi_nr 0 0
+	if [ $validate_checksum -eq 1 ]; then
+		chk_csum_nr "" $fail_nr
+		chk_fail_nr $fail_nr $fail_nr
+		chk_infi_nr $infi_nr $infi_nr
 	fi
 }
=20
@@ -2183,6 +2251,27 @@ userspace_tests()
 	chk_rm_nr 0 0
 }
=20
+fail_tests()
+{
+	# multiple subflows
+	reset_with_fail 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
+	pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 2
+	get_nr_fail 2
+	chk_join_nr "$nr_fail MP_FAIL, multiple subflows" 2 2 2 $nr_fail
+
+	# single subflow
+	reset_with_fail 1
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
+	run_tests $ns1 $ns2 10.0.1.1 1
+	get_nr_fail 1
+	chk_join_nr "$nr_fail MP_FAIL, single subflow" 0 0 0 $nr_fail $nr_fail
+}
+
 all_tests()
 {
 	subflows_tests
@@ -2201,6 +2290,7 @@ all_tests()
 	deny_join_id0_tests
 	fullmesh_tests
 	userspace_tests
+	fail_tests
 }
=20
 usage()
@@ -2222,6 +2312,7 @@ usage()
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
 	echo "  -u userspace_tests"
+	echo "  -F fail_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
@@ -2261,7 +2352,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCSi' opt; do
+while getopts 'fesltra64bpkdmuchCSFi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2311,6 +2402,9 @@ while getopts 'fesltra64bpkdmuchCSi' opt; do
 		u)
 			userspace_tests
 			;;
+		F)
+			fail_tests
+			;;
 		c)
 			;;
 		C)
--=20
2.31.1

