Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32427168
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 10:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641376814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AyshT4oTwATe/kPPf+bT79Y/yqOL2CgiCmeFEpGnoBI=;
	b=b0TIcwsleZe5T5RlwFmHyziZdGwjyT8We1RLfakSC4EyP+qMXhaRvty/VwVR8i3hzpFokw
	6XyyM2Pwuyuhk4RWLQbrZ9MCWLO9TObCQ/zPwqr48SVRFLR2K1/F00VL3meBkAfoyZz3rE
	J793Orbspx7foYOYJ5OJ0nijhX1kmzc=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2055.outbound.protection.outlook.com [104.47.1.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-QUu92PqTOkGsnoV5c-s3fw-1; Wed, 05 Jan 2022 11:00:13 +0100
X-MC-Unique: QUu92PqTOkGsnoV5c-s3fw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGSWn6eoBZa0AcgLe75hT9SzOsrEmDBuLG/KYSpbcyqzrHvI3EtSQnKo6fWYGqdeHbXlQXgvWJoVx8AHWxcAUpK47vooW1bVte1wIH1xB3GtDZdbiTFS9SG6viLk269J9jg7kcZu2BEPSmA5uz5wFanrkgEoGCAHCFin2K0tm5QCsOZN4rjDDevSt3NVygQHZ2UJQtTsqAMd4xh8tR15ItiCwuQe9mI0kru5xPmx5P3KUbhrk32U9O/Gn9WtYLrp5FujY4yy/98MDTNZe5nM02NlC6LuOc86+Y2/Nee/mzssE8UN6a/6NNgITQQ+PyHVKKKZ/8WOOF8iyjOE/pOe0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaWFsOZx8o4A7zVM13pW40HLkX/5b0+GpQqRR+gtSTg=;
 b=JTh6SZbLs2l8SsOGFR+Fx486n/k6wc/gBTBYMv+X+o/bEfSunBxSgwq93sGmyfsBVu/iArgFjqy7E+LpEDgwE/IcE0OEilJfjxB89bMcqq4GnrwRJfC+F4M2sLuKC6mZOdSTvJ5CuvecaJj+5eB1EQlDbHK1MLrR8ai2LawhjYYtzPHL3PGMEqtis8OJpgiEhwq8PDBDrszCqxiU16Ahz8hcTwVjKFjKW6Wclv1NCZz5boytHSxxQHMxMrAaxNOrWwDCM+kZ4NqFjjWhjCTNi8NNukUFOIpgnX9+d89gwJNOFWF2vpy7gH0mKLc6wKZPsJEv2d8AHPYxcK6x3EyWKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2828.eurprd04.prod.outlook.com (2603:10a6:3:da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 10:00:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 10:00:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v5] selftests: mptcp: add mp_fail testcases
Date: Wed,  5 Jan 2022 17:59:59 +0800
Message-ID: <9228a8ee992d67eadb7d3bc158148ae67df6d7e0.1641376651.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0051.apcprd04.prod.outlook.com
 (2603:1096:202:14::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcc08260-a461-42d1-895a-08d9d0322866
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2828:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB282880506CD2AE06C5450AECF84B9@HE1PR0402MB2828.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ob9SAnsQwRCXq7H7oRzXjhybXfCA6J/ctxEGHrxr9mWz6PrmtsASKBCPjgkCBV2VrnGV5nPpxNWRcVUihk89Zs10Y5krLODDT8JDeM1/hlFt3aUy84M3f1dAMFhp4jvXL6T2/+XAcWXxAhiv6wsFashbTxjj5ZCPRbnAHcxeP2Ld8q1bQP+uY6ae3mKz7Z1CcFw1mUpsziD/Uhttx/0KIQFKLXyXbQ10bNfKaLMhxA7Z2Q2aEuFzp9mDlTNGk+nyCXCX7R4z5kQ93Ql4EuNE/BOu/cFCBFh8KtgKXlGegFj97ZlhIogyIfHU9o5gOAK6pTlEb8nv/oxv5CvESFHzTwjNx5NbcDCRY8BeUoC2znbtvDJKAcJSZjJF0SqsnXfml6umDBuOV7FYGUk4yO5PAyQPiEJlRgtHm2u375srArrEp8+n59Bx3/HWUEKD330ZJYjnEXdWqjIPyoui/S+wL1PD6DY+8tEVUkPY9SNr23inohyMNkHVvXs4g8IK8W7ozvZAh7S2XGZCwloNWbUZvvcXrgHR/5OeRvqtnHjS6Bd9IxmDhavf+75E8gqJ0cstOQ7DE6eglI85ocDy+I3M1571jiZJ/8cDUIUCCd1qfrim34vFNptGTx713pz/kELqeJPDQrTOrElY+dL04am5LSPaJhnMB0mje4FlinSwe4YxOWNW9IBHr/p2SVJtiW/hYLGyz5D3We/dhyRF/6uRYm/RUiWq+PbHikX5oAFwkk4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(6512007)(6506007)(4326008)(55236004)(5660300002)(186003)(86362001)(36756003)(316002)(66556008)(508600001)(6486002)(83380400001)(66574015)(26005)(66946007)(8936002)(6916009)(38100700002)(66476007)(2616005)(966005)(44832011)(54906003)(6666004)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NqVfoCkCE6sQlBwU3KFXSh2Ufq/yyrXiBjXyqTKUtUXqDn5pOwhH/AfEO9hX?=
 =?us-ascii?Q?C2eFMtMjt12vcrPlSZ2cT4oCzuq1UDcvfFddxsvgDrGiMdI10yWSLNv4gyt0?=
 =?us-ascii?Q?I2FQ/pceuxLJJ8CXMoc7BsqmCvN++xvvU+AxKYnJd2F9N/ZB8rMaD3kJBxJ8?=
 =?us-ascii?Q?25puFsdArKSVxnCb3Xq5jgskO54YpJ87LcsI5/2R8c6BvPVde0JavA6FjrtV?=
 =?us-ascii?Q?++vC8NjHioZ5ycABu88k29UYwgmRkxBI29sJar9UgbtiO4EvT4cMN8IAWplU?=
 =?us-ascii?Q?uk2zdsP0TtNWsmgSG1bo/X4Q4SQCg+b5C3Wbx/nNWT4WOhzqwNa0Q9FEAcii?=
 =?us-ascii?Q?gG8XGgShqMqILAU2VQ7arxk6Mq68fRh6zUPAMgFYDOQMvNh/bZaMdSAaPO1l?=
 =?us-ascii?Q?s66jDaRMfDTumMxy/QOGYOEwmGBQXwK0S9+nNajPAPzl0ARAooSwN2WPlpH4?=
 =?us-ascii?Q?2BtStRFR0bSV7MQtgtnSAtFtlI+B5VvvPSX74OAOrSiYzI54u/gqOIlws5J+?=
 =?us-ascii?Q?obtEj+E5muyMX/blEJeQ0P9kS3wUEQDQO6L+P0HP4Vwv2UryB4ZR+YjVDa3D?=
 =?us-ascii?Q?yaZx6DGq6zRSWL8+Sht3CCbHWtOFmJZmk2cmlpBetsDgsNPHexwBl2xzJwAm?=
 =?us-ascii?Q?UP1rZ6Kv7hJlZPRIbtsFmxmH5dbcNeicjrHaEpUQT52aaoePfrjPDuiy2rHR?=
 =?us-ascii?Q?UMRLUVRy8UuWWwiqIomOnVO0GCX8864n2Mqrf11bbZEPLhSxTIIc5mp9GvCu?=
 =?us-ascii?Q?ty1EwODzntPD+fzzG0w2LPo/9GLU4Ar+833v4pUQBRemCtyZPTQf+oVe3Jve?=
 =?us-ascii?Q?hzgIbdbaUsqhS/SSEuJHFnb8tuyKSg6nyy5PmnL3fFoaa3AhBl+If5G4mKHO?=
 =?us-ascii?Q?m6o7TBiFeJyCiz8cTJCqR50CXqwVTWUcOrNY7ErB5IvMQmnpPNIjykDRS3Ei?=
 =?us-ascii?Q?fsTXG+15BZ246MV5gNYfKIALnAcR2dEFV35XxeXXMruOfBPV4eI+z4I8e93N?=
 =?us-ascii?Q?Uc7uGUcG/CbavssAb1re9Al2uHueYLdQqsjn8oRNLMxbUIQFTTuMk3XHt1rf?=
 =?us-ascii?Q?ugxUAOciVgfqeDUL3+UYB8X/+NpnFS7vWY00tE64SefOLn0IVR5/ktFTmZHS?=
 =?us-ascii?Q?PbAAbQ6zKOYLeddqrXSjrLqcLiw3Qkd1aTdlq7k9n/Zi7mvO6QSRwzvC2OFu?=
 =?us-ascii?Q?65sAy1hbCM7/Ye4oGyMXg79u6ibUpQ2k42suhs/uLFlXqbVZ/kWFsN+8zn8X?=
 =?us-ascii?Q?+cXUiJtrtGUkZAWV/t3bAC6Zikk8t7sQ+JXTxoQiXhlI9alWzttVAnZ2Kgut?=
 =?us-ascii?Q?IZZxYzvzGyF1fyhxIarBlRFWAZvx5kyd9maRPK/V4XHpWuJycWvs84HZkGOj?=
 =?us-ascii?Q?NuWGwCTgQQZcUb2jkBC0juo0ZKRH+rxw4RLX7ZmUip88Du55PW9YgUcOXCNH?=
 =?us-ascii?Q?Ly7/Q4cmJcS8i/1VMeM8xEIuEu80DEC3M0f3Fsq/n9uQoqYm/4CPtvWm84zp?=
 =?us-ascii?Q?bwePsnD+kHrGKcZ977EvQCMezOm/xyBvRVkDGWObJ8VckUT35iuiCkAvYZlz?=
 =?us-ascii?Q?bvtiA3V8JlxcVSmYYHBgghRazxcurhzZ1unvFhqOQCqzoHB/9duzhw851eyR?=
 =?us-ascii?Q?XGP2iotuV+zGLiLPsnJuQEI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc08260-a461-42d1-895a-08d9d0322866
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 10:00:09.7979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKPdaf07T1EikPgKwYfisd8mwIzI8wQxckXuNgKwfbvmxwM0+NyKwTHGz9XScS2rE+6++v4Cyq4dff6F4RDQ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2828

Added the test cases for MP_FAIL, use 'tc' command to trigger the
checksum failure.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 v5:
 - add validate_checksum as Mat suggested.
 - drop make_file in reset_with_fail() as Matt suggested, reuse
   the test_link_fail argument to make larger files.
 - drop mp_fail_del_dev(), add a new function get_nr_fail().
 - this patch deponds on another patch (v2, the new version dosen't work)
 to send MP_FAIL + MP_RST together:
 https://patchwork.kernel.org/project/mptcp/patch/5a8c6024481d6106c662c3e89=
2ae5e499b4a7f76.1638156809.git.geliang.tang@suse.com/

 v4:
 - enable checksum in reset_with_fail()
---
 tools/testing/selftests/net/mptcp/config      |   5 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 111 ++++++++++++++++--
 2 files changed, 107 insertions(+), 9 deletions(-)

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
index e48ce23d2386..535baa3c01e7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -16,6 +16,7 @@ mptcp_connect=3D""
 capture=3D0
 checksum=3D0
 do_all_tests=3D1
+nr_fail=3D0
=20
 TEST_COUNT=3D0
=20
@@ -58,6 +59,8 @@ init()
 		fi
 	done
=20
+	validate_checksum=3D$checksum
+
 	#  ns1              ns2
 	# ns1eth1    ns2eth1
 	# ns1eth2    ns2eth2
@@ -161,6 +164,45 @@ reset_with_allow_join_id0()
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
@@ -179,6 +221,12 @@ if [ $? -ne 0 ];then
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
@@ -233,6 +281,21 @@ link_failure()
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
@@ -589,6 +652,8 @@ dump_stats()
 chk_csum_nr()
 {
 	local msg=3D${1:-""}
+	local csum_ns1=3D${2:-0}
+	local csum_ns2=3D${3:-0}
 	local count
 	local dump_stats
=20
@@ -600,8 +665,8 @@ chk_csum_nr()
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
@@ -610,8 +675,8 @@ chk_csum_nr()
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
@@ -690,6 +755,8 @@ chk_join_nr()
 	local syn_nr=3D$2
 	local syn_ack_nr=3D$3
 	local ack_nr=3D$4
+	local fail_nr=3D${5:-0}
+	local infi_nr=3D${6:-0}
 	local count
 	local dump_stats
=20
@@ -726,10 +793,10 @@ chk_join_nr()
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
@@ -1985,6 +2052,27 @@ userspace_tests()
 	chk_rm_nr 0 0
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
+	run_tests $ns1 $ns2 10.0.1.1 2
+	get_nr_fail 2
+	chk_join_nr "$nr_fail MP_FAIL, multiple subflows" 2 2 2 $nr_fail
+
+	# single subflow
+	reset_with_fail 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	run_tests $ns1 $ns2 10.0.1.1 2
+	get_nr_fail 1
+	chk_join_nr "$nr_fail MP_FAIL, single subflow" 0 0 0 $nr_fail $nr_fail
+}
+
 all_tests()
 {
 	subflows_tests
@@ -2003,6 +2091,7 @@ all_tests()
 	deny_join_id0_tests
 	fullmesh_tests
 	userspace_tests
+	fail_tests
 }
=20
 usage()
@@ -2024,6 +2113,7 @@ usage()
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
 	echo "  -u userspace_tests"
+	echo "  -F fail_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -2059,7 +2149,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCS' opt; do
+while getopts 'fesltra64bpkdmuchCSF' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2109,6 +2199,9 @@ while getopts 'fesltra64bpkdmuchCS' opt; do
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

