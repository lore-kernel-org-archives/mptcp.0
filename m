Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB732C81
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 03:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1635390980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P8O9WPMfaJFvA9WLP3mnfnbYDI79fH5SVqvwKqg0w1Q=;
	b=I43K8YWBlBHOiAKZheBv802XlH5DmdkxIE/2hqcZb6Rk8PNBFtrf3lWV5sKThakIpjHYre
	wvsSKzOnua3oS2qXTujirrWFahdyWqmC48OqUCRqlNHIUJR4O08zPtMRIyqsKJHjzmdPo+
	nE+fn3AZQSsv+VPQD/m138FLj5QoJfc=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2053.outbound.protection.outlook.com [104.47.2.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-39-7batvIyaOkisTkNGJKpyBw-1; Thu, 28 Oct 2021 05:16:18 +0200
X-MC-Unique: 7batvIyaOkisTkNGJKpyBw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvmVGQ9S2VO4Jg45fGSji8oyo8Kr5pjN62SYH2kXoU8djC3+rp5mGWmYmJSHCYXK38NavlWF47PUu8r7azg63kTmnp5aN/SNi3W5mAwsafd1ggM4r0PipPZfsc16f1MQYIZ1licquXZL/nH9WXCx+dVCYLNkiMfLt1yG0RvNEcMG89+A0jg88LvFnDz6l7VebMXrSxj54Bg4xtzS1vQSWTFfyWSHi2HdPl/QcKpGZZZzXAcjxtykxfGGVJCusHhRR4WkpnO7wt427gymYfhanD3vN1Rfh3jaq/xmA2Hn6Kj95pfgz0QV+SZXGOcjKmQs7wcVfgbF0b5Nz2Z8b6mvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CljEqDvLOsM/jcni+mv8eHGOx1++1XX68CkPQhFYCj0=;
 b=bQHTPJzzfdUf7H4oKLsGvcktpcm+TmwdPt8MWcoUnNOUtOyrCM9tBd3EM8tllzY/T5g/CSKQ1vs4udiWWTADKbHs/GCj18M2YgbL03cC668hYkDKBn4cjQ9yNlNDD0MbOXjRYC8BnEiDMcuxNMZdmFmhOQZSW3OPbAfLVY60+4prb5D7fldSI441V9fedSPhYXbGJwjuOXeKqgrVWcy3c5G543tSjodYvAHzx750cpQO459slNKdzph6KZNvnNUmdyTUI9TV1AN0YkB3ZOHtoDmgpLMlOIyrJ9HAar3N4tybrsuSbX7FTQPmHhsYgKjCHoouNpjlRbjsTPoZNS8eHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3579.eurprd04.prod.outlook.com (2603:10a6:7:88::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Thu, 28 Oct
 2021 03:16:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4649.015; Thu, 28 Oct 2021
 03:16:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2] selftests: mptcp: add mp_fail testcases
Date: Thu, 28 Oct 2021 11:16:12 +0800
Message-ID: <bfa01f99cbb0479029ad284b020dbb250d19b941.1635390811.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0059.apcprd04.prod.outlook.com
 (2603:1096:202:14::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR04CA0059.apcprd04.prod.outlook.com (2603:1096:202:14::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 03:16:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e4a687d-fc3b-4471-2b03-08d999c14d58
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3579:
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB357921553B587DA07261E0AFF8869@HE1PR0402MB3579.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:389;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wznHlbRdAlwwk+imcH5hZCnEVBpsdnr46XJisLfZ+22A3LnzdRct7YhBMXAoPlIH4gdMkmGZ7wqihPo8+jg18oXHd9jnbOXw4c47uTsOba4GBscdWdUD9s6LF1DrKd5XCxKJVuD4XvPtjj6ytQzzAFplGv4xhz71PncBIXeOmQ2+85rwYnJb9oEZ8MRE1ju2hTt6ygULTj/bWhLVq16Ie+lrsBlPnB1u8DjMJM0b0LEla73WTLuu2+5fV3DPI9Bbj1MVIXpBWZ0+BMgYhTfMN5/CRy8XqdpTWcOJOjGksWi7DwEmH+aRV5Mbh/q5jYFv0pr/ipJwJYRfvQbBGVBU45qzAEVSiFWrY8/evp+V/A7ecwBTq+uiN3S0W1pf9gYUolzcIZQ3z7v7w/0dG/V5gJbaiI+4FomOD0rruCE6huZ+aTMHZfX+PUUcVVQQjyTH5IFB+1swVay7SJDhSa2I1GGOujAsjKJhGrGh4uX20E0Kx5MI3GHXRugEBG/DKvWGtoVKxKhLe6Wwnw0dSaedJ1SRuRmvnCqMXlJAk4OQ1sFmnbFX7IRrkXG251Mh1jkLWvEOFHi8k7o3rkDgvi2gwYXrUz/VugPad3ZiyclQe42dodjSiePAR3uxVUbcSXyOF7+8ry5DeBVqO1FZGBSZWw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(4326008)(55236004)(6496006)(36756003)(508600001)(8936002)(6486002)(38100700002)(54906003)(86362001)(26005)(66946007)(956004)(66476007)(66556008)(2906002)(2616005)(83380400001)(5660300002)(186003)(8676002)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CNbPnpunQTBDjzJ4wZMcvgfnXfi6zqctGE+5iD6uHTtR341WFZCzmq9G+gpA?=
 =?us-ascii?Q?0tYWkJAXGlQXFMdAQo9u0mAtLO/C9uGPld9TbDVEBYqts9ywpi9QCCJ4KZrx?=
 =?us-ascii?Q?b/0DNscnRk5W+eztQtREWb2RldEENcArsa+Y/ktJBzi/pMndNWjKzCkI9Lbu?=
 =?us-ascii?Q?GpMZZ+ircTxd32l9p30PNOMYUQB8Gccd5CM6sx/c2ug3i4kG1c7c0KG+9TBQ?=
 =?us-ascii?Q?cUymUh+Ud+U8jqtti5Dg8nCKBrEemGUy65r6P5jCnG2xFU75cHJSkEiAh41e?=
 =?us-ascii?Q?amvbDeE4VcNlIymGZJG+h8fQOOIOXILxd0t/jKw+e1IFzwSEb4Rk5BNLrOMw?=
 =?us-ascii?Q?Ni/ucsZCtMLgAiEzyr5cCpFWrBK7+bmdRPe++9jtEmIjWf9THm+OhN41GrTo?=
 =?us-ascii?Q?Nb8wS9RDjnPdQBuGJ/UxY6crO2RZmIoOrQs4lnrnh4bacc5cOIjmI+JuGbUm?=
 =?us-ascii?Q?N2PAtSyTxlg6j1HGsdOuYCqZZimNDc994gMyfWw48hhJE/h+du6eTMQ/vJjb?=
 =?us-ascii?Q?+RXvLHWa9Vcv3ytkaB6kLQEJViHmUwnUBldBVSWZ2I/eBPcmaOg+zqfU0bWa?=
 =?us-ascii?Q?bvKRICuFMn3m1AWNm+lLE6yENfWXuRkPrbKsheuTPc+4qD4B0AphovhTR3J3?=
 =?us-ascii?Q?Aa5ZmIV6UxALhXcCw/4sXfeCAXGwAjfT3xBNSm4ao+/Pb7vZXZOlNVpTlSUy?=
 =?us-ascii?Q?QGR0/4DVQ4pMgonxQVRFAKz6Yx9v+9Dvq9yv9BwOChXzwvdoXA9yOI0sGKpR?=
 =?us-ascii?Q?KsQ1NlF0vhWHM04p4GcyVHdP+gUfwIDVK79XgjsXb7d+jgACxLyk9cDUWEVC?=
 =?us-ascii?Q?wntUAOri2vCinXWLPOeJeBBk/KA4UoIPn5EoVEQmY7KYwN/qV0hSc90csEYJ?=
 =?us-ascii?Q?tazWYrL0c+tTjWtb8XCurKp+DjfIfCdiRShw/W5iggNCp56BuhkmnzTm93Wz?=
 =?us-ascii?Q?REI2MvT6K6tcUUwRM/0RDkHRhcHX3JUjy1HBcZZ5Q1y/M3lAy43yInYPa5M2?=
 =?us-ascii?Q?BiVu5CyOVGHeAbp/cXhPml5T5nl7BzE2qqLIA0lfrhUZsQyBKs9eGJJdqEhc?=
 =?us-ascii?Q?D/1FbEt6XT4vlPkFAyX/mim8LjQx0IsQEr8i94iVx+ekoFd9Lu+J3Tde4aho?=
 =?us-ascii?Q?cec9wXOLZJ/vGOICGzHxechQ5JUM2xiYq5tMGobiWOPKzA0hYTpgazvX89iq?=
 =?us-ascii?Q?NTODRTOfnTyEl8uSygX5NME7+UV3875i8vugBvxUySec4GL/DXVXqPx+8pdy?=
 =?us-ascii?Q?ZfRRuvugHQymt7pVyeK3B54Hm+/yMkWEB/Bam4O8JBeNB5jdN2V430HV5S9u?=
 =?us-ascii?Q?SU486AKW+ExxnpM+5CqDrahW4fh2lTZfRhODGXpGtPo/OLWqscqlt0EXmih0?=
 =?us-ascii?Q?GRfaidD5I7MBLMbceUzWZSRZ28SIfclcXyDhR68bN+tSv61iW6UtFDXTGWPt?=
 =?us-ascii?Q?zhq8YXHc6VeF21i/2+39p0RyVy/M6BC1b6w/VEz+PcTkdhAkYuTEAYZTxw+f?=
 =?us-ascii?Q?Hc3eK1fJHOyz0H/2oFQbuLSLQG+3hmBqQf+ckhinZxi4hf18NYLgEwOqysY6?=
 =?us-ascii?Q?ym1mWy9n/vSYcfyasKrcEx7bdBd6IeJrJPzVpyzdGg1Rb95zEJOgoZ/y9cAn?=
 =?us-ascii?Q?XPTnnrSqGNmdjubNpJgOKuU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4a687d-fc3b-4471-2b03-08d999c14d58
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 03:16:15.7203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jk4YRJtU3t/rKHCGBDehVgn9+zKunVK/UvJz7+V6lftCJ0C9GZfem6WtYrCn1cp31+sHaxCGbZEGxjRJNtRZKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3579

Added the test cases for MP_FAIL, use 'tc' command to trigger the
checksum failure.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/config      |  5 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 60 ++++++++++++++++---
 2 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selft=
ests/net/mptcp/config
index 0faaccd21447..f522288b2204 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -15,3 +15,8 @@ CONFIG_NETFILTER_XTABLES=3Dm
 CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
 CONFIG_NF_TABLES_IPV4=3Dy
 CONFIG_NF_TABLES_IPV6=3Dy
+CONFIG_NET_ACT_CSUM=3Dm
+CONFIG_NET_ACT_PEDIT=3Dm
+CONFIG_NET_CLS_ACT=3Dm
+CONFIG_NET_CLS_FLOWER=3Dm
+CONFIG_NET_SCH_INGRESS=3Dm
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 7ef639a9d4a6..95bac447f857 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -232,6 +232,29 @@ link_failure()
 	done
 }
=20
+checksum_failure()
+{
+	i=3D"$1"
+
+	tc -n $ns2 qdisc add dev ns2eth$i clsact
+	tc -n $ns2 filter add dev ns2eth$i egress \
+		protocol ip prio 1000 \
+		flower ip_proto tcp \
+		action pedit munge offset 148 u32 invert \
+		pipe csum tcp \
+		index 100
+
+	while true; do
+		local pkt=3D`tc -n $ns2 -j -s action show action csum index 100 | \
+			awk -F ',' '{ print $12 }' | \
+			awk -F ':' '{ print $2 }'`
+		if [ $pkt -gt 0 ]; then
+			tc -n $ns2 qdisc del dev ns2eth$i clsact
+			break
+		fi
+	done
+}
+
 # $1: IP address
 is_v6()
 {
@@ -371,6 +394,9 @@ do_transfer()
 	if [[ "${addr_nr_ns2}" =3D "fullmesh_"* ]]; then
 		flags=3D"${flags},fullmesh"
 		addr_nr_ns2=3D${addr_nr_ns2:9}
+	elif [[ "${addr_nr_ns2}" =3D "fail_"* ]]; then
+		checksum_failure ${addr_nr_ns2:5}
+		addr_nr_ns2=3D0
 	fi
=20
 	if [ $addr_nr_ns2 -gt 0 ]; then
@@ -542,6 +568,8 @@ run_tests()
 chk_csum_nr()
 {
 	local msg=3D${1:-""}
+	local csum_ns1=3D${2:-0}
+	local csum_ns2=3D${3:-0}
 	local count
 	local dump_stats
=20
@@ -553,8 +581,8 @@ chk_csum_nr()
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
@@ -563,8 +591,8 @@ chk_csum_nr()
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
@@ -621,6 +649,7 @@ chk_join_nr()
 	local syn_nr=3D$2
 	local syn_ack_nr=3D$3
 	local ack_nr=3D$4
+	local fail_nr=3D${5:-0}
 	local count
 	local dump_stats
=20
@@ -663,8 +692,8 @@ chk_join_nr()
 		ip netns exec $ns2 nstat -as | grep MPTcp
 	fi
 	if [ $checksum -eq 1 ]; then
-		chk_csum_nr
-		chk_fail_nr 0 0
+		chk_csum_nr "" $fail_nr
+		chk_fail_nr $fail_nr $fail_nr
 	fi
 }
=20
@@ -1799,6 +1828,18 @@ fullmesh_tests()
 	chk_add_nr 1 1
 }
=20
+fail_tests()
+{
+	# multiple subflows
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns2eth2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 2 0 "fail_2" fast
+	chk_join_nr "MP_FAIL test, multiple subflows" 2 2 2 1
+}
+
 all_tests()
 {
 	subflows_tests
@@ -1815,6 +1856,7 @@ all_tests()
 	checksum_tests
 	deny_join_id0_tests
 	fullmesh_tests
+	fail_tests
 }
=20
 usage()
@@ -1834,6 +1876,7 @@ usage()
 	echo "  -S checksum_tests"
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
+	echo "  -F fail_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -1869,7 +1912,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fsltra64bpkdmchCS' opt; do
+while getopts 'fsltra64bpkdmchCSF' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1913,6 +1956,9 @@ while getopts 'fsltra64bpkdmchCS' opt; do
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
2.26.2

