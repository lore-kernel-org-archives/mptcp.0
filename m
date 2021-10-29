Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA572
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 04:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1635482496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXNM/YXN8K1PeAkM3YsTjrYAZv15tZMooEMHa/CLziQ=;
	b=mQmUxS9Jw92t2uRenCzIthFslhIXgsoXBOhC+d9SgEXRUyTpsuFI6pwWapVCY3gzggCmq9
	M31QDSplayXkYhDbntWi+KkNPOa2GZ/1knnTRw6R9I6EWWoLiUeDQ0NYYzai1sOtGcWzJf
	Q552dTQJ7zKeMjX8HtynWmyHCbOUt9A=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-10-T528rcd7OHqrXH_lVxxVGA-1; Fri, 29 Oct 2021 06:41:35 +0200
X-MC-Unique: T528rcd7OHqrXH_lVxxVGA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbWqRnOSvKozjMi5CFpKLQ74Ij4V2nz/8R8Gjz5T0l3Ei72ixqJiDwtO+1FY6QBZL25HSoDzrLFMSG69fJuMjMMokXG9jVMy2pu3fPD/YS2lCk4xeL95icu8yQ9tlOu0fTAAshaXEW3HQ3G0FAvBf6A3kHkId81XPNcyLdIHi6eSdKu0IRlpsd0Jz/IznkPzqdriGwbJjWsiA8o332tSRCvqv9kwwhAv+6/5Sn0yJGuUpiJIXxzjoEeVEzUI/vDBRzszvr1DzGNu5bwWmPqxuB8yQiVCU/oKWgy5FGgxIV6L7jNfOW+SlnQf7uBUYUyvd3Rf3pQPJub91Z4ogyUsPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqEHyzgkLpnFPm+YwgANN06MLwa2C8ytrg2A5A0Ut7g=;
 b=lPua7bk1FYRQYqd+5vKN6F/Mue26B1ln8Z4i7XcCz5u1eFHpvDHGV7Y/gzZRRXBSUaeEIcFzVPTL9QjwhA1wUbV4PPWIaTjT1yfZWp98jA67Ntdq0FFbzqEr7mTqqG2RzfHoIxjhiUOHcVpIJhO4gbFoKoXDcAdciK6a3V6VIfzgomctcaoFmp09GvS1TC3BizeBueaOttiwHPBB1xfrwpPS+BJJYwO1kUQVz6pdGyRmi3cVe9e1F7CpoBYaXR/rHtpYuW52OLkanCTfEfKwR6dFnmyGJaoJfckPINap2V/Wg7n/XE/lxF08FL8VFJMtPbbGVJ1jIlX+p/o5OY0g8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2652.eurprd04.prod.outlook.com (2603:10a6:3:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Fri, 29 Oct
 2021 04:41:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 04:41:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v8 8/8] selftests: mptcp: add mp_fail testcases
Date: Fri, 29 Oct 2021 12:40:18 +0800
Message-ID: <ff613391540609e31cf4aff5abefaa03fbd63278.1635481641.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1635481641.git.geliang.tang@suse.com>
References: <cover.1635481641.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.2 via Frontend Transport; Fri, 29 Oct 2021 04:41:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14cc7c9e-9ddc-4bd7-ab32-08d99a9662d2
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2652:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB26525451F94A69E99BB5F601F8879@HE1PR0401MB2652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9yvjSjxYXrWqdY1bW+NKgEMY37aEgPN44quP3QCHIAvtoK9yGdm/iTr0PrIcPCv6WDP5YnS1PqvMTTK4JDK51UQR5T1GNSaV6tv05mzC6Fb/aquhM1ta/ZfMpqK7i32ExYoBR75mGoC1v+wlC8CiWPmJkanHpGnihe+CvP+6e138bb8hutkTHvYPepE92Hyw7Ra3oQnU2WtWuLlSq0IjWZgnYjpu/tJfflkrcga4XZPNVVKKe5xgG3wtNxLn2tFulOHutfYecFl2FmLQoxk7Rx86Ll74dn5wQAsPBohpmpA4CdQ7/myYPoz+14XiNB3nXQ+99BjrMbm6vWoPhVhY3EfQ/iN3flJJVTpla35Z7elStoRj8E5TWnRxZn6d6KpH33wWRTlueFy7NgXiRaYdEdEeDrOgJrZnOsSgbqP8G6hRDQSO02Ll686FgozqVOu9yRS1De6yM3T7W9BQWCGIcx4jMLsAsGTwuTItzxpYJBckUFyPEdp5GT1WGR0F+hH7cXRVAUZsQ+c7QogLjHNOnNnI7dJoxuewEIcAjyvJttTxewBsWAhnTbUYBAfyqEU9dd9DttKErY51G4egO+WLaJdInj3FQfsi8SzqMP1Pz5374PqkE1n+uH86VoQ7Gl4T83W3ve/wq+DMQUo0mRo1zQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(508600001)(4326008)(66946007)(316002)(6496006)(83380400001)(55236004)(8676002)(66556008)(6916009)(6666004)(2906002)(44832011)(66476007)(86362001)(956004)(6486002)(8936002)(2616005)(26005)(36756003)(5660300002)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jxr6+J36mbMONs+0ZT6YsYI6BOvI8o3SrB3FrW87gQx8cU3NLtNIetVEOEfr?=
 =?us-ascii?Q?PvjHaHvMevOrRccyxehBb0xToVjxXvtL2Ro3xb+gG1g5O5ZmPocOVBjMweCV?=
 =?us-ascii?Q?6VzqcJusLATfwjTH4WK7eCCBA1TjXJo5Voi8KINXcru0o6RPKRUJR95bUbzC?=
 =?us-ascii?Q?H7W9yLYpV7KQupW8wXabNR0nHbDuqLSXZ7mJPVQbHrTP/yuvc/oSMfXW94Hx?=
 =?us-ascii?Q?3pWJfpbja9lo8hJjv1SWOGW8QRN5kAaXMq8XclD7G+kL+fdfCAv4Ek8L4kEs?=
 =?us-ascii?Q?chmjedCqErmaziHN6dZ7x66iIjoOS2Ez+AWHNqkZTth1wJGhtf+NvPEpdCIP?=
 =?us-ascii?Q?PObGZ/p54llbcOQEd+9o4n9bcxjpTNNiU/jvQPDURehLuCl7hqNfD1pFbMFL?=
 =?us-ascii?Q?fiR2cKzs6SLDZ8l3cLOUcx3HcFz/c+Wgg/kkqOHw+0AP0rL4mKlPDgKmgwvr?=
 =?us-ascii?Q?rIcsNIr5kmvem+KF0oDT7pKoY5H54e1GJQYn4mbQudQ3CZpR1kPCUGSdYgbU?=
 =?us-ascii?Q?meUfE39hrYsT/wMef0oT0YOcvohgy1pFBB5K2joRndG/b5fzm2TTRu0PudIv?=
 =?us-ascii?Q?7jq6VFINMnajD0G3iKn546Vp37rX7WGGAtZMqES1OPCVncY0pM+MDAaSQxQ1?=
 =?us-ascii?Q?QE3AJWlr336bP2BHKVrG31g9VKdyjz/o3k1yhHxUUHxMMOG/7pZYUFWMKys7?=
 =?us-ascii?Q?dwGepTQQYcsjb/Kp0AtrDFR+B2Lb8oPRSCLc8dPsUYSLWunQTNBlXdPX4PvM?=
 =?us-ascii?Q?k9Fr6lzARJev9gArCeS5kqb6z8ZP5cjG/+X6F6hSTqe/aeJPTI7gOnpj2OaP?=
 =?us-ascii?Q?m8Ei9nIPNPmDvxWx0fclDF9l/9bcLhbL5RkOgVMzx2aWkhkI+bRPWyqw1MpE?=
 =?us-ascii?Q?njaW+dao7y/SVM2KwIggeWNe7gT78WAjAvUwvlR1tSE0WKbNq3ZeqNLBQ6jz?=
 =?us-ascii?Q?tjzj6hWvPUHnHulU65UI34ntskj2aN8YwtoBWmLHiBs4ROJtgUlqjQ+ou1W8?=
 =?us-ascii?Q?WQTPRkV80vkdOAYMoa0oTtU25NWNkmEagKE9hUd2Z2HTKhkkJGzJ+jXTNJX7?=
 =?us-ascii?Q?9jHBIpr4ocvWUFeSTuFjMKR25/yXpwvCwGrs48CjptovBdx2xrUK8993cQmT?=
 =?us-ascii?Q?iIkPgqk/Vyf7l5lOI2dhE2cDkT29xNvLIWvWvF7d8CafFxCVswesM2kSF5em?=
 =?us-ascii?Q?gqhjPcnTI8AZAmJPAHr+XBQxBncpnC4XZVPrLoSOmQ663PrpON6tuY8t1KYl?=
 =?us-ascii?Q?tOipt8TdaU6MrlFTkgZWqrChR29nX5hO6z2mlv/9ftkD1RgV31g770TW9Q2c?=
 =?us-ascii?Q?OO2zo1bWyYKcoc9wHOJX5bkhvA87AaNvBwLTT9qB5izJ34pOhIrMAcKk4wL8?=
 =?us-ascii?Q?HDrCOU7MOvTUQt81OLchiUEmHFE5FzQpBVw8kMYSAHxF2sC74rJX2BbtuX8e?=
 =?us-ascii?Q?9GemFiS1T93J4bz66pW7FusOlSFcybWYg5yEbLrA1mcsfJexwwWQzfCBNn/T?=
 =?us-ascii?Q?pLrr8Wj+rGp0QSSXDFh1EbgnmvMBRYALLzcXt6PXReSVDDTcgeSKCh7M/Ojt?=
 =?us-ascii?Q?dErUJahqQYCLccNgw1OALLylRYk6lYjNhqj71Xp3ZOY9g09ryfHjCGDEqZ/d?=
 =?us-ascii?Q?fA+V80NJkRRXJ40KFGLueqc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cc7c9e-9ddc-4bd7-ab32-08d99a9662d2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 04:41:34.6545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38EyxMITZmdWTY1w+6dNvh1SyDs/wY5A/74uK8aFeiRXq39XiGqXiXcQesDO9osuiXIeIL58jFeu/fqLnL0xtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2652

Added the test cases for MP_FAIL, use 'tc' command to trigger the
checksum failure.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/config      |  5 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 75 +++++++++++++++++--
 2 files changed, 72 insertions(+), 8 deletions(-)

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
index 2684ef9c0d42..d33cb5ce0ff3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -178,6 +178,12 @@ if [ $? -ne 0 ];then
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
@@ -232,6 +238,28 @@ link_failure()
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
+		local pkt=3D$(tc -n $ns2 -j -s action show action csum index 100 |
+				jq '.[1].actions[0].stats.packets')
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
@@ -371,6 +399,9 @@ do_transfer()
 	if [[ "${addr_nr_ns2}" =3D "fullmesh_"* ]]; then
 		flags=3D"${flags},fullmesh"
 		addr_nr_ns2=3D${addr_nr_ns2:9}
+	elif [[ "${addr_nr_ns2}" =3D "fail_"* ]]; then
+		checksum_failure ${addr_nr_ns2:5}
+		addr_nr_ns2=3D0
 	fi
=20
 	if [ $addr_nr_ns2 -gt 0 ]; then
@@ -542,6 +573,8 @@ run_tests()
 chk_csum_nr()
 {
 	local msg=3D${1:-""}
+	local csum_ns1=3D${2:-0}
+	local csum_ns2=3D${3:-0}
 	local count
 	local dump_stats
=20
@@ -553,8 +586,8 @@ chk_csum_nr()
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
@@ -563,8 +596,8 @@ chk_csum_nr()
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
@@ -658,6 +691,8 @@ chk_join_nr()
 	local syn_nr=3D$2
 	local syn_ack_nr=3D$3
 	local ack_nr=3D$4
+	local fail_nr=3D${5:-0}
+	local infi_nr=3D${6:-0}
 	local count
 	local dump_stats
=20
@@ -700,9 +735,9 @@ chk_join_nr()
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
@@ -1837,6 +1872,25 @@ fullmesh_tests()
 	chk_add_nr 1 1
 }
=20
+fail_tests()
+{
+	# 1 subflow
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	run_tests $ns1 $ns2 10.0.1.1 2 0 "fail_1" fast
+	chk_join_nr "MP_FAIL test, 1 subflow" 0 0 0 1 1
+
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
@@ -1853,6 +1907,7 @@ all_tests()
 	checksum_tests
 	deny_join_id0_tests
 	fullmesh_tests
+	fail_tests
 }
=20
 usage()
@@ -1872,6 +1927,7 @@ usage()
 	echo "  -S checksum_tests"
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
+	echo "  -F fail_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -1907,7 +1963,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fsltra64bpkdmchCS' opt; do
+while getopts 'fsltra64bpkdmchCSF' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1951,6 +2007,9 @@ while getopts 'fsltra64bpkdmchCS' opt; do
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

