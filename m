Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0584868
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 04:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1638763211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4sFlif88EkaEDzUsQp1eixsHwCXdkfjJR8TX9j/jkM=;
	b=ZHJfvRudsBhJiJU7h0z5km01YwOrNvoedsBdZ/bPXIZwIvW5F2tCSbhH8JvA2rn45VB4Bv
	KEEZk9M0yULN75BJrMtRhq3BZ0/F1swBew5pyu0Jw5jMJSMS4tIvB4ykw6SWgxoA06aosR
	4iPh8obbuNO6K/ol7Icb53NZDt1V26o=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2054.outbound.protection.outlook.com [104.47.1.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-07VNUOUoMRyLBGSXefwRxw-1; Mon, 06 Dec 2021 05:00:10 +0100
X-MC-Unique: 07VNUOUoMRyLBGSXefwRxw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liSUL/x4p3eqMQY/92tZhZXpLh23ddrYPK/2e4RrfPMUqTvNQvPGX60CnjS3kAfzJcgRcAIG+O1cUqBUgqthi9rHHuekOWg8YUbC3XCQ7VFFp3FoMh7zWDDfhmJkkQNm/xLY2bVDjh2e6bNfIkyUwaDvrG4391Y6OoRl3Zh4p8NQGvFA2rNjfnK0BXBkjPUD32VQXovFMTi6EXrqSwz4lg/IMyPln0zzVHMqqqPpuchMzzXPKxOZvYYJ/iLnnVKLfuhTTMg+kGV+0bezVQKJBkV/qUR207wO8bcvckYeF72glfM1T6x7xtuVnw44LhoxOWBWuKpDkqAogKHtQIahjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7n/PxHexMEfyRItcIU9DlXSU2XjdefgPKU4LaaEhJA=;
 b=iZddstCtlcsFlg0IgP4rJgAj0wDiL5o4yH/xfWgissKiG5b0OyxiJDa76RZUbuyLCrSsk9Q24p7MYlJ+bJrppnamF0Ln47ZUGraJsH7n91ohri+C+ei4lrssIbBzvCcBM4qelj3zm2dzQjAFw2nn06dE+Yj/M3/A9L5rDrQJEZYJtNN7VXaunmFzSX/wVJm7vAGkCKirXJ2D3hrqSEUvcWrP8CggduC4EEF+9AIrSNgZgau/3TlkBsva4nqLrFDpPIrYKmzeQHKnD040+v+5yitZd67iIJTaJIokDTjL8qHqZ0/7o9WNhp2DkQGqKNX/Qb7Mqoz6LPAvgsDSYdL//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3065.eurprd04.prod.outlook.com (2603:10a6:7:1d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 04:00:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%7]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 04:00:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v4] selftests: mptcp: add mp_fail testcases
Date: Mon,  6 Dec 2021 11:59:36 +0800
Message-ID: <cbe88a11722b5d7ce89760410a90c237870bb4f2.1638762863.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1638762825.git.geliang.tang@suse.com>
References: <cover.1638762825.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0066.apcprd03.prod.outlook.com
 (2603:1096:202:17::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR03CA0066.apcprd03.prod.outlook.com (2603:1096:202:17::36) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 6 Dec 2021 04:00:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe10535e-e70f-4e28-99bf-08d9b86ce525
X-MS-TrafficTypeDiagnostic: HE1PR04MB3065:
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB3065434A3C5422494AAE25D0F86D9@HE1PR04MB3065.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7gF1soSwVzUvzK6uDAm1JklWSk8YNJDL9+ZyKMJ4y2ufjsYQc7u2A7KMGLMtfsk5TZObb7ZxMwslemYHbh72KN+HpdCAucfvdfUMIfJiWISQUbpzwp8hPMJ+NGq4gMlxNSJXIiKg/rn19+phrD8aDj3EX/YR9LJcWL40J0Hl3IcuBSAYwSyBrCKEJPR0SxGRNf0cYwJwlMFqAcX83JXRo5uD+00YcEY6D65SQVNts2Ssjx8bxQ3Zj5GvpLvZfyhuHb99sPqvjUSNgGSG8RTfDM0eP1eVVG1lCpAWCCP8kV6CHiJ7ONCwgRPOpN2N6aE0nYuQki74D+sRNe+jfMl2NkSAIeHL1A5Qf0ujs5aq2gDyIDWGLyKaEncGU6XXplJdvJDZmVT48fja3nsGmisVVcG8RBZ5WLV9JFHA81yxVrZzC6ki5/FQJSJ3JZ1KfVpvMabCY60soA6qIwaMiGWXcq9pOEVDT+TRSmCKhBX18jfM2uRte74CzvPqP8Nve6sAGUwaVt5SkxQuzGhld4p7RijzAOFG2nK27hFEZhqAacxVVjcqJJqwUe2mo0OGZTbhhCZiB1LkJ6TvQKz6yYhmTI8lZIa6Zg0cpBxZANwESGo0JXdE6iTEZEK7LRSARjkQnywAtVT09uIGq41cIafGJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(4326008)(2906002)(83380400001)(66574015)(6486002)(6496006)(8936002)(54906003)(38100700002)(86362001)(36756003)(956004)(2616005)(6666004)(508600001)(5660300002)(66556008)(26005)(6916009)(55236004)(8676002)(66946007)(66476007)(44832011)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iT9ju8eYhTXI40ei3yhNfHPh/Km1gE9hO1juzBaZT/NT9aCUp84XB1wc7Uoi?=
 =?us-ascii?Q?9H4ZubAmdIpnxiR5HdKo7vC3xkcL4JUrBZxiZ10HDyw0yZxVRRUug0bG3JHy?=
 =?us-ascii?Q?Zki0kTFkK7rP8oz/kx1vwZSWj2W2k0YN6Ga/7dq6x7IC4HFzytWVMi1IFrKJ?=
 =?us-ascii?Q?3REYEJuu2to16CkRpbZ/0529xcXVmpe4PGbiAWToZc/gSJKFjg20V/lE+J8j?=
 =?us-ascii?Q?b1/0m8i0o+t3rYh7Od8JCVUmIylqRWB08TMqE0QT4twNdM5LCY6MksEDV5Za?=
 =?us-ascii?Q?uPSNvXMrEjg1V/TolE1TbQJh1JZj2xjKUblzWCQ9n+njFv6vgqcXUzHuON6+?=
 =?us-ascii?Q?LaCoCCLASMn1W+MSnryhjXONIMKCNZXcKa9uHB0peZdMvi3+vhPrQe3S4ko6?=
 =?us-ascii?Q?emE73c5Tp1N0lLbF6FU7OR93iZ2/5sSn8oEGqFXOTE89PPRn25YWlwVz95aJ?=
 =?us-ascii?Q?D4l3AFaMTATd8Gp3C3rpKtzWuPrRTraR0DwI8NiEGhqPxZ0FigJFsKhqKwtE?=
 =?us-ascii?Q?Y4V+Vzjt+BPWG5WNgtaODQd4vXzwtZwneTOuixjbQfBw7ln+IBH6+w09Ze+U?=
 =?us-ascii?Q?cvRlQgATfPearxnZc1QcV/DVVyTtGoQRU5GB5b3I+kXA19zUAx6nbzDwZNCs?=
 =?us-ascii?Q?pqdpkCSWuuyHEuF5ASJq/KunOLDhk0GMBaGDTModI8qtK9gU+QJT+DtcGhtb?=
 =?us-ascii?Q?R/4Pm8LxZ5YP7QLbC43KZibmlbDFANBdNn/1BfDboXFMMO4MzaP4ZvtihOAD?=
 =?us-ascii?Q?F+0VXea+sYb/i8GoGaBoOZqQndnv13h9Xezondi6FjM6HtR73f5911wfNayF?=
 =?us-ascii?Q?1xoFp4O2FgDPfKdf9Kx+PDR897kJsM3yIa7x/h7akBDu0MsOsFJZWkwpBBMe?=
 =?us-ascii?Q?+qvm8Iv9Sa8aV84ZlJtJtZZdJ8IwwCeFjxGy9QgXVDOMpk2udvZkh/KxbyVb?=
 =?us-ascii?Q?EJ4G7tYyHyQQaAaOmrchOx3sLOvk4tMRsd83VGG/bIc8kx/v0oA3q0zGydww?=
 =?us-ascii?Q?eP8G5TJIq26pSUVdYnpM66aJjZscj3jna89AswkkoMd5oo/DgeHWDV7SXmUE?=
 =?us-ascii?Q?rOUzdTF4nfH28saQ1sBxJkX1kggFs1sLuZpaIQd5CctVdRYabKx/yni4RbP1?=
 =?us-ascii?Q?XtFDI7AZdwoyaIDQwrxzZVgvDSQCVBwED6VAXKfGY5mBryIsYnD0r+PkCM7d?=
 =?us-ascii?Q?fZ5mKsxWabNIvCeSfseqIxX5DcelHokMpLvKaH/U6IbITEm5wLWkN4NCAOZl?=
 =?us-ascii?Q?TkmYE01iQU78gYaSQfkPLgbgkl70EvO/2wCYCHzsSnJ1/WsOdoO2D6Uj3Xbc?=
 =?us-ascii?Q?MkMY3cfWKmAZXV5SXkcSOY93MffkDXUAbymB9mrpliP6gL5TFzUWq4641RD2?=
 =?us-ascii?Q?3iPOCosGhxpHNEEGTzzW0HdHeUF2tsBK5/ymg002L/YrglsfetXKxmvbUh+y?=
 =?us-ascii?Q?56tBMvRM97IYaBevki+IeR1KrX8LdLqEFYCz3IoWbU9yml0leZl2/wFTfFZM?=
 =?us-ascii?Q?izQCXmNVgAyi+1b6hMZjgIEI9MRrtfOWrC/8hq0Rl4c3fa0fxBZZU/7kiXJI?=
 =?us-ascii?Q?4nxt5ro3mRpOoU5o13smoSMYe7t5Vwn/wvhDa54ZCb3f19v5lzUL4EQUFDHS?=
 =?us-ascii?Q?MNIVUxXZORqV0kX3OuaCdTs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe10535e-e70f-4e28-99bf-08d9b86ce525
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 04:00:09.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dA/ArbBx2QoESeoQNeIdyoMuP+71M6mOiUB9mW1WtfHi/5DZUg4iVJLHLZr5sgoqtRGrRFqNtgmifFT0sSREZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3065

Added the test cases for MP_FAIL, use 'tc' command to trigger the
checksum failure.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 v4:
 - enable checksum in reset_with_fail().
---
 tools/testing/selftests/net/mptcp/config      |   5 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 113 ++++++++++++++++--
 2 files changed, 110 insertions(+), 8 deletions(-)

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
index 2684ef9c0d42..7a9dec7fa648 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -160,6 +160,48 @@ reset_with_allow_join_id0()
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
+	checksum=3D1
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
@@ -178,6 +220,12 @@ if [ $? -ne 0 ];then
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
@@ -232,6 +280,24 @@ link_failure()
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
@@ -371,6 +437,9 @@ do_transfer()
 	if [[ "${addr_nr_ns2}" =3D "fullmesh_"* ]]; then
 		flags=3D"${flags},fullmesh"
 		addr_nr_ns2=3D${addr_nr_ns2:9}
+	elif [[ "${addr_nr_ns2}" =3D "fail_"* ]]; then
+		mp_fail_del_dev ${addr_nr_ns2:5}
+		addr_nr_ns2=3D0
 	fi
=20
 	if [ $addr_nr_ns2 -gt 0 ]; then
@@ -542,6 +611,8 @@ run_tests()
 chk_csum_nr()
 {
 	local msg=3D${1:-""}
+	local csum_ns1=3D${2:-0}
+	local csum_ns2=3D${3:-0}
 	local count
 	local dump_stats
=20
@@ -553,8 +624,8 @@ chk_csum_nr()
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
@@ -563,8 +634,8 @@ chk_csum_nr()
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
@@ -658,6 +729,8 @@ chk_join_nr()
 	local syn_nr=3D$2
 	local syn_ack_nr=3D$3
 	local ack_nr=3D$4
+	local fail_nr=3D${5:-0}
+	local infi_nr=3D${6:-0}
 	local count
 	local dump_stats
=20
@@ -700,9 +773,9 @@ chk_join_nr()
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
@@ -1837,6 +1910,25 @@ fullmesh_tests()
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
@@ -1853,6 +1945,7 @@ all_tests()
 	checksum_tests
 	deny_join_id0_tests
 	fullmesh_tests
+	fail_tests
 }
=20
 usage()
@@ -1872,6 +1965,7 @@ usage()
 	echo "  -S checksum_tests"
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
+	echo "  -F fail_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -1907,7 +2001,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fsltra64bpkdmchCS' opt; do
+while getopts 'fsltra64bpkdmchCSF' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1951,6 +2045,9 @@ while getopts 'fsltra64bpkdmchCS' opt; do
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

