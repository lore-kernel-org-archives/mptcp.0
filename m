Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707EE2CA4
	for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 10:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1635330425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R7S6HiKRdxmhnVcwhN4Zpn2921RxaArHWS9dLsNw+KU=;
	b=LBHR/uAvMpUUxlVeMngAKvJKdImmzVbAQ8YqB8LwDDJHwOggZRvfrdxYd/2Lj6JTyY8mSW
	S4W0We/XSknAHOAe3XYGKw2TCSeg5i+EQ7ZlHoERjifrZYYuAjeBaNsoCeCQ76hIouVghM
	pLSUWd+g+tKh4MPtzDs6ZhsK5g8rdqs=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-31-JOTNgkTLO8uaFBw27WMaRQ-1; Wed, 27 Oct 2021 12:27:04 +0200
X-MC-Unique: JOTNgkTLO8uaFBw27WMaRQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T24xgY8/Axr9SoKXi1Ki5VP0wM1diN3/DBVW3K5uIUYUB9VtB53UYyLifYyDuzePVR9CwujDC7LB2SGnQrwABHK9kNoQBaqQN6O3pBnBtniBKX15vHr32hG3qARba1Md30V87msvKCip15Tndr8m01d3tcXJudOeE1PQLM2gxsy8BF3buYmOPiFy6gvMDQxlatTPyvkwDzAwPucbhliX5coAclcQtq9f0GKx7tR3Ro1cCBs/27QrKC99XnV1UylVE4frvR+z/TQ9RV0A6JpPgOCxQyjJ7pNawe6DhRoa+t4Gweghx43nX5AxAZZSC2wD72TiWX2gSSeb1yx9v7RRvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BipHXDBlaq8Xs4qEaXO8z1YOD9qQzhtbQYrkS9DIN6c=;
 b=mcx36P9dCLPKovPjuXgla/ytd5gZbXyh2YE0ZZczundAO3vf8F6IUkKaHLQ9sHQua8197t2x425HVMrE0VaONK9i0laz5WzBIqOzcL4vN5MNqfUWuKIADML965TFz2VfJtWlr4q3SAJ3XHVXs+0TXu4QAjtZ4IRXVHyDqnkU9TFL/02BrfPN/xT5jXqH7/VtpqqbKoLa1QWddzRnpc1H9dNTodXyTZQ0hK/fY+MJoQyDMC9Iio78B+MV7oLcAiXXAa1hw1So8t8eGIW2kcmRI/VinAn+2OIrv/3jSnUorhJcZwOzRbIaQzWEyzIajmjhChPG9GQH34j7qcU3jyzzAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2636.eurprd04.prod.outlook.com (2603:10a6:3:89::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Wed, 27 Oct
 2021 10:27:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 10:27:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next] selftests: mptcp: add mp_fail testcases
Date: Wed, 27 Oct 2021 18:26:54 +0800
Message-ID: <98ce131530c3ae91bf2ca29e6566ca1f7debe202.1635330390.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0055.apcprd04.prod.outlook.com
 (2603:1096:202:14::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR04CA0055.apcprd04.prod.outlook.com (2603:1096:202:14::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Wed, 27 Oct 2021 10:27:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caa29d66-d754-49b6-48e3-08d999344fed
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2636:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2636BF490254A7CAE37FFFFAF8859@HE1PR0401MB2636.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KMAmze5pL67q8qp6375RGWrZm+0426/NM3GYvFcUXQJA2zxSHUjrjvP/f1yytHEN4+hUstpGKEKejJZ5xnp9ZW/DgbtuFQIKEMLBn3fxGIFmwydLAoUpCOWpIfIXp29BLqUzEwO4daPb/G2NS73tlTwqd0Fxo7zFTGyvRtvX76qLXu8fnvKO0eif6LrLinem7wrYhCB8ME5u/HPV0LzC/Nr+jWdWsHX52aLKofT1xRMTgQwQlTCjDSgvzQDNB8Wly9skzVq7Wx6Da1uZfd0KFRgNJe3YHbGlE0zUCEHybbJF3f4Eus5ktA+7VKHCGd0qjDns6pHicVjj43nHBhyi8ON3i1L1zzuVPw61DG0R3AQhxRaDhKPdOr0lSRkupkxk4E1WYmzqgEl00v6LJJq7Af5s6syVN2sLmgp7M9ytCMS5HXF206RS2Bj1XFd2jMrYBKPs+JCwQPMxFiKweSAcrgyWnkRU6ZdSsWXFrf27ILPPivWIX444ISbSLcP2PJ0SwswBs49AacvnFXg494kO7HVWxsge6lhFsm3Z0w7WBDXsYFhbUU09gPjdybZ1KYm2rPFX2A2Y8vc1KNjksl/4+zPWvNQc4JBNojSLh4UN1VJqC58l0JOpboO6tibznTTQ2IGoNCFWl8Tyx1g706cHfg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(26005)(508600001)(38100700002)(186003)(36756003)(6666004)(2616005)(956004)(86362001)(44832011)(55236004)(54906003)(66556008)(66946007)(66476007)(6496006)(6486002)(4326008)(8936002)(83380400001)(5660300002)(6916009)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3RzFm4gs5OaBbEb/F8M3MaPpD151qcSUp0pTEPl3d0dHu+VOSMIL4l855Hz7?=
 =?us-ascii?Q?vfscJ+Q+BPvHbfRtL1+PvcNE4PzCDTg7viFhPWkv6oqGWiTLmRIijQA9nYQ1?=
 =?us-ascii?Q?RZJdUrWjPsEJ0ks5d1OZLaY9XUNvAWtSKz6AKqWAessUfI1GvogP8GP1rVwi?=
 =?us-ascii?Q?hAEng4NzDeX87y6B2mTviY2lAD4laZ6/MabSARLQqk68VJfeX4mdNtyddw6z?=
 =?us-ascii?Q?d+mAJXX1vtnM78WW6Ymr/GBH0LsFXHT82bd9nqALSj2iUJVvt02WVKXriW32?=
 =?us-ascii?Q?Wx/k2/ke/VfulS0S0INVNjrpbm0yg1+M6jl04Vvolt3YkktnoKVdzS7AjHZH?=
 =?us-ascii?Q?NEJhDPEDqczE3MpZW+7poUscX2B2zjdhtuzX09rhd7RTYvBV+gt6wf/jeHiy?=
 =?us-ascii?Q?i+Jmp6jYsKzUgbM7492j6f4/CLTXCTpCah6MosAfHzUK2EeGMuR6eUZbaf/z?=
 =?us-ascii?Q?7CXp+AEo50sebTCVfWdt4ETyE/hLIXA4kxmqUKfpyg2ZKm8zJsee+UcEjrvW?=
 =?us-ascii?Q?1K1ibkZc/6vfH9WFhDLcyfcy4gO9jIreZD5C15r1Z+bG1bMQDFH8Ep7XRQmG?=
 =?us-ascii?Q?6AM3ApttOm0GaI/LF1/4gzJY/IGE86hboftGXXpFwVDsCPtTxh74q4j4b4tr?=
 =?us-ascii?Q?HzsHe6eHaNgkTFYOHiKNS/o0BDMCw5/KaVstuoXp2naVgX4hhJLRShA2yOrp?=
 =?us-ascii?Q?F2R9oohs/Z+KKu0SD0JdC1qpPMnFQf9HogipQMssgU5ax4u2fS4+GrKbELkb?=
 =?us-ascii?Q?g0jmyJxegv8xpv9PDIX2DAOO0ZxfT9jqKINN2CjpDkRf88heWGIHpiqiOTsN?=
 =?us-ascii?Q?mwCAj6erspWN8PZF2bljLP9Q3Gcnz0b/yGw8ABaOA4DO+1rHAz7JEah8NnnI?=
 =?us-ascii?Q?cAJSO5DMVWqfJ9HKDF1ruGhvIfjfYcXyqVbUAP2EQ5iOFNfQ5sOrVCla8Ifw?=
 =?us-ascii?Q?/SwObXtexeBTTPovFkyJSaJrvO7uB78JBKtJ2oOlnDH5Dui6IJ9EusGzsWKC?=
 =?us-ascii?Q?iqoQhHNH1k9nLkUpt3YKHhSvnqim8ADUKjWXcQn7QxYvtJw+xKNYGp8vy0bz?=
 =?us-ascii?Q?PMw6/PVMup5TV5S5DJTQBO0N9361jLmJC5RY3Dhg9ki1608p+WeZ6cO/j0vh?=
 =?us-ascii?Q?1IhwxItcoj4reiJ5ma7imUcq/RguFO9H98I3yvehWUxbEMsJyYevS+R9dYZA?=
 =?us-ascii?Q?kdARLPjWu9LwouMcBsur2g09X3ps5yz5+uafsYq1aRDmSbIjB4H+w0e8pPkt?=
 =?us-ascii?Q?X4fo5OpBCphbvjQ4z8fs1Sgeu909smVAAv43RJPK6wdGkqNJyB64fobLVasA?=
 =?us-ascii?Q?BNar8lFy4Q0XvAD4QTkLsxDYHiBFEwrudJIdPCqH/cwiViXFNnRwJ15Y5dkG?=
 =?us-ascii?Q?PGVo3eNV1Aai8I+ezNEmrof+b8N7XF71ZIuQZ/S/bstv95VIvN44ws6mtdir?=
 =?us-ascii?Q?S+10JuwAQmkhKNP76IY7ZITxbNuWKdh1aCdl2jlHr3xtaTKJEAFKVC8fv3Ml?=
 =?us-ascii?Q?g/EyrFnIt+fNf7/F8hANlRNDd7oUqht3XKl+JyYsXfmHPBgoD6BXNFYIluzS?=
 =?us-ascii?Q?WwVvCV6lRDhPH7/Gm69x0WC2Ko0EVdkT3FlX2RM6Pn5SS/WH/QyFyN3QpXqB?=
 =?us-ascii?Q?OWgGvJTwzAGbLUU5XH0G04M=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa29d66-d754-49b6-48e3-08d999344fed
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 10:27:01.0016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5VTwQs0UobGgwyq+xp9mkF+oKMW33rExckaKKN2XEG8WyYmz7RiuiZ6NMNynNWObG6xCIzBK+HLMQE3Lpvmvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2636

Added the test cases for MP_FAIL, use 'tc' command to trigger the
checksum failure.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/config      |  8 +++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 50 ++++++++++++++++---
 2 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selft=
ests/net/mptcp/config
index 0faaccd21447..dc7d5d1d5861 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -15,3 +15,11 @@ CONFIG_NETFILTER_XTABLES=3Dm
 CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
 CONFIG_NF_TABLES_IPV4=3Dy
 CONFIG_NF_TABLES_IPV6=3Dy
+CONFIG_GACT_PROB=3Dy
+CONFIG_NET_CLS_FLOWER=3Dm
+CONFIG_NET_CLS_ACT=3Dm
+CONFIG_NET_SCH_INGRESS=3Dm
+CONFIG_NET_SCH_HTB=3Dm
+CONFIG_NET_ACT_CSUM=3Dm
+CONFIG_NET_ACT_GACT=3Dm
+CONFIG_NET_ACT_PEDIT=3Dm
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 7ef639a9d4a6..8bf38db1d54c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -232,6 +232,20 @@ link_failure()
 	done
 }
=20
+checksum_failure()
+{
+	tc -n $ns2 qdisc add dev ns2eth2 clsact
+	tc -n $ns2 filter add dev ns2eth2 egress \
+		protocol ip prio 1000 \
+		flower ip_proto tcp \
+		action pedit munge offset 148 u32 invert \
+		pipe csum tcp
+
+	sleep 1
+
+	tc -n $ns2 qdisc del dev ns2eth2 clsact
+}
+
 # $1: IP address
 is_v6()
 {
@@ -419,6 +433,8 @@ do_transfer()
 			fi
 			sleep 1
 			ip netns exec ${connector_ns} ./pm_nl_ctl del 0 $addr
+		elif [ $rm_nr_ns2 -eq 10 ]; then
+			checksum_failure
 		fi
 	fi
=20
@@ -542,6 +558,8 @@ run_tests()
 chk_csum_nr()
 {
 	local msg=3D${1:-""}
+	local csum_1=3D${2:-0}
+	local csum_2=3D${3:-0}
 	local count
 	local dump_stats
=20
@@ -553,8 +571,8 @@ chk_csum_nr()
 	printf " %-36s %s" "$msg" "sum"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D 0 ]; then
-		echo "[fail] got $count data checksum error[s] expected 0"
+	if [ "$count" !=3D $csum_1 ]; then
+		echo "[fail] got $count data checksum error[s] expected $csum_1"
 		ret=3D1
 		dump_stats=3D1
 	else
@@ -563,8 +581,8 @@ chk_csum_nr()
 	echo -n " - csum  "
 	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D 0 ]; then
-		echo "[fail] got $count data checksum error[s] expected 0"
+	if [ "$count" !=3D $csum_2 ]; then
+		echo "[fail] got $count data checksum error[s] expected $csum_2"
 		ret=3D1
 		dump_stats=3D1
 	else
@@ -621,6 +639,7 @@ chk_join_nr()
 	local syn_nr=3D$2
 	local syn_ack_nr=3D$3
 	local ack_nr=3D$4
+	local fail_nr=3D${5:-0}
 	local count
 	local dump_stats
=20
@@ -663,8 +682,8 @@ chk_join_nr()
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
@@ -1799,6 +1818,18 @@ fullmesh_tests()
 	chk_add_nr 1 1
 }
=20
+fail_tests()
+{
+       # multiple subflows
+       reset
+       ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+       ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+       ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subfl=
ow
+       ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns2eth2 flags subfl=
ow
+       run_tests $ns1 $ns2 10.0.1.1 2 0 -10 fast
+       chk_join_nr "MP_FAIL test, multiple subflows" 2 2 2 1
+}
+
 all_tests()
 {
 	subflows_tests
@@ -1815,6 +1846,7 @@ all_tests()
 	checksum_tests
 	deny_join_id0_tests
 	fullmesh_tests
+	fail_tests
 }
=20
 usage()
@@ -1834,6 +1866,7 @@ usage()
 	echo "  -S checksum_tests"
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
+	echo "  -F fail_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -1869,7 +1902,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fsltra64bpkdmchCS' opt; do
+while getopts 'fsltra64bpkdmchCSF' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1913,6 +1946,9 @@ while getopts 'fsltra64bpkdmchCS' opt; do
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

