Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E29116412
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Edp1Lmz1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYrPBHnF0pFdE7wGlVgo63SX4J6vGB3w4uPdWziiRX46wjPuECeNHV8L8j3lsMhdqkZmG+SnbIMrYmM6eCGYjzhkNo0lyPnLbrZVSept4o0zAShQlpHaYfnVxabEaCe8+6T8HDpebUu0RM72Me+8f6lreEF5S9zcZcCQz5tHfv1m5iGlsmkv3J3lLWuoEUAFukcQRTM6wJ/0iVGjzlQyKF/5/2Fp3KroxMI6cXPvA/ZzxKK/64GYVghOYhnaJ7UCh29LS6wWaUw1eCe4+qUhLH7BG+Q6nTaanZNYQl9wo1y73NakLaHAhfGUcMNbfi+ZFHequnQ/ZqgCfPe+9xA5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubiBzAOgJJZr4EAKsigJgo0y3x8UuI3bFjjZw8flUQk=;
 b=H7GlTIzxqRoeLwELiax0DQDtZwgzysoQ6bHu+3oiR96JgHv7y36hrrAiJdP1T7QWNaBhucHxGLvvQPT0zYjNXDia3gLOqqNSxipsHrVwP8GOIxzBDjBEM2l3POgZ4HaUNEVdVYshDCfczbsh4iDpMg8GTv3NSRCISNOWt6ahumOTL7pY8ZOxsGjyAeyR8fv2nS1DFJdaQuB8fQMJ97agXyB929KwJ48S+SXUnSzIwW6FRSrZ+j+gZLyZW/0dOr6p7lq/s12kzoABKuFKq/JIAI+sEVcQDQ800T9z4BBWGZWhCK2D9qLVD/4d12XhBb7g7I/eebQF+pGy2f3ZZ9Sp+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubiBzAOgJJZr4EAKsigJgo0y3x8UuI3bFjjZw8flUQk=;
 b=Edp1Lmz1N40kUhCNj8xWaQv2ETGHZmd40E3UurkEPj/ryvZUqhTd04Cr33/x3qUlPeAmdAKxv8myz2xeqHnOndEi3DazUZ9Cnp33xS57EUhajL/rhFQ5NUSyIsaWNv+8MPl02bq4hMW2rbt1GlbH3AwS1R7eR+w3eskWg7dnxEDN47TlHPtzYKYKAQp17CT2htIzDkM2gK2u2aN51c+Uj3FZDiE6JMFGQgewk/lkYg8tIpMpI6mmgRpF0gKf4KDy7wlrRVkzfArc/g/r99f3wKL2rmjRskvjna1iAy6g1Qg0nAkLp/0XlylWoSOOa5ypmLHSyepLXoxUYIDYccOzVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:23:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:23:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 11/33] selftests: mptcp: add mptcp_lib_ns_* helpers
Date: Tue, 14 Nov 2023 18:21:41 +0800
Message-Id: <6bb8a0f33d55f757baf16122e4ed67fc790bb313.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0128.apcprd03.prod.outlook.com
 (2603:1096:4:91::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de92878-9451-45bd-22cb-08dbe4fbae86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6NBCZ/wd+gmX4nf/rBeFCHzN9Rje8Hsx93itJkApc6iDC0bmErZ0UGNbUWR8OEtDCbKMUUgkcEDWMO0vYRGRB5q4ZjvxjqI58VEccIQG6BR0iuXc+fnVMaViTr0k8s4ZPzw/vndPpkM/6/TgdXNC0E9o2LfBvE0PpX9vz15C772ihWPSM6leyWNlj+/wABn8X3LMDM3csk7IXbhEl0cdzgM01UL1VQx4KYYRTgIZH0UkfCmv/b3dAk/6vmx3/4UPKET2v3dt9BFeZJBNmujGC/sk21XfhBoN49bcAGZZueO5dXhm/tT6jldzfPgQWIesMP3g8ye41yCTpq6RBpaRAIS6kE6mxK3Wkwjjg+FNoH6xknMqY/GRM/f/b6X3A2iACepYjRL/Oksz/RONr/vRPgxfTobvGN+2tQX1NMjQxn8NDaykFtzK+L4uas/zfC2S+D+Ovc/M5miDSqOwC1ImwPgKQ+xEdoTkfQb8iNxCc7uNQzcIzaZlS7w9I+CZSpjNv+/+8zQnqrz+INB2bgO2UQvh81ZzLymy63NAli6rk9Gj3cqwLa4aXTXYVOQYWGrV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(44832011)(5660300002)(38100700002)(86362001)(41300700001)(2616005)(107886003)(6506007)(6666004)(6512007)(6486002)(478600001)(26005)(8676002)(8936002)(4326008)(83380400001)(66556008)(66476007)(6916009)(316002)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xfladAZ6eNqR8DVgRtFA8Irez6wBjd8/V+geV67oJV6nYqaMwHnWjorYX6za?=
 =?us-ascii?Q?vU749WtyLL9uaSmXtlsLlB4LrKZ+YZPQCbr1JUAazARQbnPhYpKCl79wLjhY?=
 =?us-ascii?Q?az6KMTLphsZrVkkkJSAZJheUjljOirsi+qDF947N30hdXlSxOJAsWSqZ2yff?=
 =?us-ascii?Q?S0wOhASh25eAt4RAG9ToG59xkoU7zUYaj56qSSfONptDjuN6eiTERZmjtEOo?=
 =?us-ascii?Q?sUauHBRSpUfYVCBykYNYEpB9EUqGIoytaQIMqlq++f+JaI2CuKOEc81ASPn7?=
 =?us-ascii?Q?T7Lgb3RaGeuIY3a/utAXd+SM19hWioucDmJ5mZZtm9TFVfDHGSDHy0FpKGqe?=
 =?us-ascii?Q?QHe4XLgH+IJsVbQ0CpwlErvcGznXzHb2zfD3XC90uxMXFMqDaz46zqr65nCR?=
 =?us-ascii?Q?cMdgjSCst9AXwkz70VlgfKsPMaLDJ8hHALl5/DIQvRyvCRk7lNyQ8hIJiDTn?=
 =?us-ascii?Q?4SCxo0pmkW9iqNwEQyUE0ELXJTH2FURVSoROz7FFsFToJkx0ZE1qxhE8ReD8?=
 =?us-ascii?Q?vv6kAsod+Iy0AUWinody7DvlTt8tgmUYNX0c0qXwL2gb1j5UtBMNbcg7mV74?=
 =?us-ascii?Q?op5F7ljDQzmIzACgug3CRq7k5YWbx/oLbdx645KzLpXfD4yqb2UfvLeJ5ChK?=
 =?us-ascii?Q?TsUhFfc65zh4M85DfXtLxsocqyJKtfzdQaa+vYHNhsfBUfNsT9XhBJ0W0BWs?=
 =?us-ascii?Q?S1cvg9F8PkmVhnSYzd1EBfM9xUAGCs5NzZKwrifYYUJIPmDBV4lG2dqPScbf?=
 =?us-ascii?Q?FHXwhFxZ+roLRld3ATPI41FN6nrBQJNDEhU3DF2yQaY7m9xy83bv8ilvz08L?=
 =?us-ascii?Q?YMf3TDcuzjcIId75LbcfKu7hcAP1YNqHvkA7FMvGAgXeSrJvVv+GqYqigrll?=
 =?us-ascii?Q?q57sIldmDqLX8HvnAwVYXI/EcTP/L/19pFAtmQPaMUFButIDr29sXrQmzs60?=
 =?us-ascii?Q?kiEUFFDD0+mHL0BsqjMM1ub56ry/I5d+6iA5EzZc9KJWOkut4H1y9cRaI9V1?=
 =?us-ascii?Q?6oU18XiO7JLxJv5vPPZiHrvRKlwq/YgmIPg3ln8g8eR7lFQGJ0FRphsq+3VR?=
 =?us-ascii?Q?goX3xZgg1D+q1Qvrpwnru9HjqLjzMgYRRDLDleEPywcUqryl9DbAtDjDVU3g?=
 =?us-ascii?Q?WgfmguzVdspSiPNthWKmOY1+Bf1qhRgbAh2ZSms7r64WCO4J/lSkZ8/I5jsi?=
 =?us-ascii?Q?Hj2dEuzHkHxc/pjYqnWl28O/l+FaPUrV9U00+UsgaHfnYodvEj1E3QCRMePM?=
 =?us-ascii?Q?3AazlmvHkQv9cnCjQdibhJAhyu7kNcRnyxvO7UGUov/aiphwkCJrWFv4bCN1?=
 =?us-ascii?Q?jawvJm+lN2uWo4scjWLOPeqm2DdnuhRUhz1adpB+KVpNSh5KqZGAfz3Ra8/Q?=
 =?us-ascii?Q?6hhaGv2CqQNRVUMJofLrGrHAx4dTk4fxM3N1cpctnWiYD6vcQDauhwRn8Mnc?=
 =?us-ascii?Q?Zb7feehvvhUWJXKgRSvZuVjMRb3vG7fYKpk6f3EBFR1//ZyvpEE+9l3pqNfZ?=
 =?us-ascii?Q?5Ymyjlsn6PA6ceF2LhPF+t+Du6HMY9EbCc3+DKNefw2MH5ky20AUQRdAWupg?=
 =?us-ascii?Q?outKLASkMiBz9BdjeYq3sHvJuBytTXnxJwHDcBvy4lW/sWB9mhOTwDgA/Jgf?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de92878-9451-45bd-22cb-08dbe4fbae86
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:23:02.2240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IIaDWwSA+veRQUqE5+mxTk5/88Llr1JXuG9J4/sRwERj5jj0RQS79OvAoEIaFTqS7vSg1gS+AM9yD7hSf9s6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

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
index 7a6b85100c98..0498e3758b9a 100644
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
index 5e1d282ad3a3..6512d198ee23 100755
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

