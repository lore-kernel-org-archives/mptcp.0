Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D74C2C82
	for <mptcp@lists.linux.dev>; Thu,  2 Dec 2021 11:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1638443831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zPpIibB59Ru8ky0pHUFJ8mHIC2mzFy7LPJrQUGuFC/k=;
	b=d3w5C7eqJVbxAJrcnjjg+omnOF/XP4HzLBobJtqfhqmQyg+iciID4HkpAQgdmKRgZWRl7W
	a59vLwnbebs/5yj6SQxjYP5Yv729HtlBg/XKU8QwoYd/XijLP2/ltejyrsrY7yhSP6kuwJ
	0nIVi2SH2i1WSdwckHjIsbdNt4T9//U=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-KcN8aM-ZM2ihusT1z3K0Ug-1; Thu, 02 Dec 2021 12:17:10 +0100
X-MC-Unique: KcN8aM-ZM2ihusT1z3K0Ug-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Guz3fEEuyrsBrN/l7BLnSInsOo5zZSCwfklkG3/i0oVQ0uqw3galXZA8ThvXLB/XYpQaTZqz/Zugz/cGq45zDRavItV5xraDskGUzJogRzH8IU710Cc3OeZnawauUEXcRuYvAJc8mUH8gjbo5PDu/2hiVy7tGCL56fmlxvc9iJZgUYjfE+Meun/8o3G7dq5KEJE3oEsHftySepnscv1WuRxzm629CitULpivvMh7dYKCjI6sYWfJWWaT6Dd2b+CgE0zWh5mOJq6sWXKpicvVemBxLmwIWnbYokQoKRq8F++s/9YT+GxTGtBmFUtolPMYGIOQuZry2iUorpaUMbig7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7J7FfQy2GppcQgx2KxyQacpVErDS6xOCYcRFcfg4NM=;
 b=JhUS6RExt4IepLe3Q2Lh4YMiLbNSs+nny5+SvsHTuwyypCG3psUVkI5sXk/geVYG0ZmXaDxG0f8QAj6B1N3hpF3xrDoRct/IBoZ7m3mJCOqSXGJyspKD7WRIktj0ICyvgAAmxv4ZnviRkatFZsf14FKqZGtrP+tWR7zM72GdP1JEtjDO7UVLsqOUFfOKZLyqtBQZhBl7GQq5qbv6vYkanfj+zgkHWUgg651wpbGqAaQuppQ+9R4qbWR0imbN1AxdLJL+7wLCNtJkPGicNVzQj/cNLUZKoavvNaPruPzl4M6YL2KJ5hXHQDRYfhApAlRqcnN8sUnuiLcMY2+GMTvAww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3434.eurprd04.prod.outlook.com (2603:10a6:7:8d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 11:17:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%6]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 11:17:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v3] selftests: mptcp: add mp_fail testcases
Date: Thu,  2 Dec 2021 19:16:49 +0800
Message-ID: <4dd1a9febb11730329ef3486c6dcb1eac3b68d9c.1638443671.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0073.apcprd04.prod.outlook.com
 (2603:1096:202:15::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR04CA0073.apcprd04.prod.outlook.com (2603:1096:202:15::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Thu, 2 Dec 2021 11:17:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d9e4c2c-85e9-4910-2360-08d9b585466f
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3434:
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB34348FA2876FF61D980FB1D3F8699@HE1PR0402MB3434.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gOHsY4IY7Jxcs26HnIhth5KJ4lMJYv+6v4HlBPzAmAetv6yjKDbvTfWy1RrB4M0o7nkjiO86icqOjklSUVecxkL77VwHj3IXgQ44Lap83KrhRpKPTcVrcHnVsWVBxtfqaxVBlsSGxhgYa0LS20yQpdsT/29q4JdSmE8Bg2N+UbH8urq4GkrTAj8fFfDJq+Opf9QnCtnjm7kY54an3Cl1RAvt1lf+/3P/xhhkvjTgjXhyU3c+Aj4FuQN2iCygPwhv+gHkuvwJz5tt99HTqlbWq/rAbQxiaX7VjEM6CQnDrz1yS2FMDZTVQ0YTpTLs+3pCl2+1vieyvlvvQfPJ1Dp6ckUo5X+yCnNuWqIBagw/g5RRkeOdVDdgLcIqvfgK37VT+61bibpdDdUYjl6JY6cWKDITiWaP3ZX8UxBUL2R9IpPyr3dTLyeemOKP09rbNNpWUctkilEPscQBrgb0kJDu8hADD+X7uR3Nbn5Fr1PPaEBnwHqSW4RMAjzMfcu9mzsg02MQvy++7h4OxiCDEhHkqwNohtHMH9auDp5jgwn3gWX6bQjJplgRN4f4s+qhadf06mdps6MUqJowLPAjKkutmBmv480sdq5Dtn10Exh5KRfbcD8f2N9mJ3t/fm4kAw1GxMmgMYPY50FiSbWmWF9nkQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(2616005)(86362001)(5660300002)(8676002)(6666004)(956004)(66476007)(54906003)(38100700002)(44832011)(2906002)(66556008)(186003)(4326008)(36756003)(6916009)(316002)(66574015)(55236004)(508600001)(8936002)(26005)(83380400001)(6496006)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L2LS+4w4EBK1Dyd7D9BFqzOgAPcQuWu/ZPis9hn3im0kRjdaAYfqx3+t+WHq?=
 =?us-ascii?Q?gE+ku5PVgF2TI/zD06M9nHtW+gbkG0SQeUDuQNr6UQR+4nuMV30ArrIpibnM?=
 =?us-ascii?Q?pcWhn5VTiYgVTKMzvuLR5/f7i+n05yXObWNKIteBaXnXZJuLiF7mK8zr/PAq?=
 =?us-ascii?Q?fbezxJP9q9twUNz125dWqM9VK8Vtor6PA9IuFAu3ygxFNdL89kl7rvZ4fq+c?=
 =?us-ascii?Q?uz8RscBMQruvwlltJ1hi20SF7RT9oPhpP0PKITI4AznH2ZArkf34Z9pzzZZl?=
 =?us-ascii?Q?u8WsSqXFaK/nw6RKs/f8hvEOldmWWvViqq33mK22gJHXXBuHDRIC3JxPlVEO?=
 =?us-ascii?Q?0F3LNKpC08HWLb8r8oHpCV8uq8eZk0b3BIdTuJXvO6/dZCYVKbhtd4YTxSeb?=
 =?us-ascii?Q?aRpXwiZfuj+yNjRA2ZpzgxPerVQCt/vYGqXeeZr4j+5m8BXdBVDsI6UPLVbO?=
 =?us-ascii?Q?1Uy98729c+I5E614A2s5UTK1d9y90GAsGa9yOFlXXVaCeGyEcWfa2nsMsVuK?=
 =?us-ascii?Q?n9v7ont6/GZKvhzVuVBDgCvdaeSpFUjCSbJrRSc62/9Jw1RN637NPU2qLQ/N?=
 =?us-ascii?Q?BUclHOt0onS7F2vOn4zePbNB5NtmiNlgVL1sud4r23+OUt4Ge2iCwKfcs4im?=
 =?us-ascii?Q?ehBDCHPSL+cvSzRScqWLSDLml5dJeiDZTDTmNJWla0HFpVw2oVxiXGrxbj9Y?=
 =?us-ascii?Q?9QcMT8NVTkejvh0ZH/xE1yQGHTQVzVo85oIJyBvkgeuUhxcwaTNssUGc3qyF?=
 =?us-ascii?Q?vHUjHxB6q4YjgDAd5p4on0gqIZXQVMMGeNes8PD/79ZW/3i9DJEB6wgAjHR9?=
 =?us-ascii?Q?4fCLT72ZRkaljeTlNzv/fj6ccsGAXDnxB71fQY9TGBYOmy09j9izjl0Q4s0n?=
 =?us-ascii?Q?uXp4IyaeaG8cn04+q4eq8rnHdW41dbvCtJ8InQN7Pr308F0tpo/8wdOYNsPc?=
 =?us-ascii?Q?Pfqd7GLliyCsTiatXbJRM7+vX0u6pXChYWki7xZtdu6OGxfS+DOXcAkwTNTl?=
 =?us-ascii?Q?kW18RUyXmu8eesIV8v8l6mbttFal2WR86jxpDA613rOYCi5hA3J1LGZk3zV9?=
 =?us-ascii?Q?DvA/nzLgMLzMtz1p/HX344PdkuBMyavRb3Wgom/p+OIAa9EbwFY9/kBbJIpr?=
 =?us-ascii?Q?A2KC9ricD6HclcYRvokW+CKtZJtMAZQmL8HmpM438AZLackNoASDiyB7s/db?=
 =?us-ascii?Q?vcRREXQqMjB3Jg/Z9zIHOBSdCKUevpWBVbaJKllFY+6DMBTSCWwgHcp+KFVZ?=
 =?us-ascii?Q?XuhUBUDv4l2rNhebNwjtg0wQNxbW0JJ6a3/mQgKsHZYymVyQ/YTyVjz/QJal?=
 =?us-ascii?Q?QKhYgHeW7DXSDfwCE3qx9QEYPGPSDOZK+10AuS8IqzaJYUlWvy3DfKNUWLmN?=
 =?us-ascii?Q?PZPZlV0Pu5JRmZtsNqVOqzVkOZbI4/Fs37/gg0XUqOGprQcz7gbwFGHpfD57?=
 =?us-ascii?Q?E1uWaEUpaAtjtDEbA/4zcM3GrS1M+4iF7qn5fZ0OTlrfgyO6wrWAS9j4VgD4?=
 =?us-ascii?Q?naXNEbRmWTzqVFW24A/ZrZVvbWbHAb0rLLxSE2XV14q/6Ayf/0WJB6GydR9y?=
 =?us-ascii?Q?8s1Aj2xoJv7KTurUl8VJJcmi6xznXtvv49TMilrAtpEe72ZP7t+lY+CuCI8y?=
 =?us-ascii?Q?/2AoNSnPpzaAmRYSrJHwUNc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9e4c2c-85e9-4910-2360-08d9b585466f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 11:17:07.3318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/c2T8uZj2KyO3SwYI67SIPwDRFff4dFJyDh8NWgEDdE8T0C576+k4VTwWFFxwNJNWPtnKick50euE2tNhiSaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3434

Added the test cases for MP_FAIL, use 'tc' command to trigger the
checksum failure.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 v3:
  - "file received by server does not match" still there.
---
 tools/testing/selftests/net/mptcp/config      |   5 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 108 ++++++++++++++++--
 2 files changed, 105 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selft=
ests/net/mptcp/config
index 419e71560fd1..37124a6891b7 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -19,3 +19,8 @@ CONFIG_NFT_SOCKET=3Dm
 CONFIG_IP_ADVANCED_ROUTER=3Dy
 CONFIG_IP_MULTIPLE_TABLES=3Dy
 CONFIG_IPV6_MULTIPLE_TABLES=3Dy
+CONFIG_NET_ACT_CSUM=3Dm
+CONFIG_NET_ACT_PEDIT=3Dm
+CONFIG_NET_CLS_ACT=3Dy
+CONFIG_NET_CLS_FLOWER=3Dm
+CONFIG_NET_SCH_INGRESS=3Dm
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 2684ef9c0d42..6de026689eff 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -160,6 +160,43 @@ reset_with_allow_join_id0()
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
+	make_file "$cin" "client" 20480
+	make_file "$sin" "server" 20480
+
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
@@ -178,6 +215,12 @@ if [ $? -ne 0 ];then
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
@@ -232,6 +275,24 @@ link_failure()
 	done
 }
=20
+mp_fail_del_dev()
+{
+	i=3D"$1"
+
+	for n in `seq 1 100`; do
+		local action=3D$(tc -n $ns2 -j -s action show action pedit index 100)
+		local packets=3D$(echo $action | jq '.[1].actions[0].stats.packets')
+		local overlimits=3D$(echo $action | jq '.[1].actions[0].stats.overlimits=
')
+
+		let pkt=3D$packets-$overlimits
+		if [ $pkt -gt 0 ]; then
+			sleep .1
+			tc -n $ns2 qdisc del dev ns2eth$i clsact
+			break
+		fi
+	done
+}
+
 # $1: IP address
 is_v6()
 {
@@ -371,6 +432,9 @@ do_transfer()
 	if [[ "${addr_nr_ns2}" =3D "fullmesh_"* ]]; then
 		flags=3D"${flags},fullmesh"
 		addr_nr_ns2=3D${addr_nr_ns2:9}
+	elif [[ "${addr_nr_ns2}" =3D "fail_"* ]]; then
+		mp_fail_del_dev ${addr_nr_ns2:5}
+		addr_nr_ns2=3D0
 	fi
=20
 	if [ $addr_nr_ns2 -gt 0 ]; then
@@ -542,6 +606,8 @@ run_tests()
 chk_csum_nr()
 {
 	local msg=3D${1:-""}
+	local csum_ns1=3D${2:-0}
+	local csum_ns2=3D${3:-0}
 	local count
 	local dump_stats
=20
@@ -553,8 +619,8 @@ chk_csum_nr()
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
@@ -563,8 +629,8 @@ chk_csum_nr()
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
@@ -658,6 +724,8 @@ chk_join_nr()
 	local syn_nr=3D$2
 	local syn_ack_nr=3D$3
 	local ack_nr=3D$4
+	local fail_nr=3D${5:-0}
+	local infi_nr=3D${6:-0}
 	local count
 	local dump_stats
=20
@@ -700,9 +768,9 @@ chk_join_nr()
 		ip netns exec $ns2 nstat -as | grep MPTcp
 	fi
 	if [ $checksum -eq 1 ]; then
-		chk_csum_nr
-		chk_fail_nr 0 0
-		chk_infi_nr 0 0
+		chk_csum_nr "" $fail_nr
+		chk_fail_nr $fail_nr $fail_nr
+		chk_infi_nr $infi_nr $infi_nr
 	fi
 }
=20
@@ -1837,6 +1905,25 @@ fullmesh_tests()
 	chk_add_nr 1 1
 }
=20
+fail_tests()
+{
+	# multiple subflows
+	reset_with_fail 2
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns2eth2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 0 0 "fail_2"
+	chk_join_nr "MP_FAIL test, multiple subflows" 2 2 2 1
+
+	# single subflow
+	reset_with_fail 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	run_tests $ns1 $ns2 10.0.1.1 0 0 "fail_1"
+	chk_join_nr "MP_FAIL test, single subflow" 0 0 0 1 1
+}
+
 all_tests()
 {
 	subflows_tests
@@ -1853,6 +1940,7 @@ all_tests()
 	checksum_tests
 	deny_join_id0_tests
 	fullmesh_tests
+	fail_tests
 }
=20
 usage()
@@ -1872,6 +1960,7 @@ usage()
 	echo "  -S checksum_tests"
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
+	echo "  -F fail_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -1907,7 +1996,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fsltra64bpkdmchCS' opt; do
+while getopts 'fsltra64bpkdmchCSF' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1951,6 +2040,9 @@ while getopts 'fsltra64bpkdmchCS' opt; do
 		m)
 			fullmesh_tests
 			;;
+		F)
+			fail_tests
+			;;
 		c)
 			;;
 		C)
--=20
2.31.1

