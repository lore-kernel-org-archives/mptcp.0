Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2082.outbound.protection.outlook.com [40.107.13.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD9728E11
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 14:49:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2Ijl4yxMZuKqPVDofn2r0V5FYc3oMIwR/PrQ7bGn+yujeIMC8et7zC/PVm+hxNnpvfuu2FoaAPiptvBz2RJc8UcRonIEdy4HTPyOkKf0kwHAyyD1DnM+JvluQ9u1jKb048vHGebIs02RfmjK2N7fA8/ixeaW9P7riW6Wg+hkjNHtO+o1B3YeQNgHiKfKlzZMVMmd4UXYOb4aiZ4kNbdFm0NrNd53IJ6Tr9Cb9NI+Hm3fJtxxR7eiqyZTg8CHOZC5oi11lRmfLl7p4E8Eu9UFrDqnnDrsG3EAdrHELkeL7zj9KiC2kiWL0cIPCmjmXRXorxGPPxly3a/KpChA5mynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nR1OPqU6gXFlwK7zO5nLsEz7TgE70MHii4ubpmYAoMw=;
 b=Pa9eUzOjdou8yqhliL5MPUAyiJjfwfYCpfdxY/4qEEdcYuJs4Nb7sN1SP9zR1gQ+bbjI8+iAZeCxgAvPFb6fNbK3ZM2BBfJedT0Eq/4N7aefHmb7Hr/Ha7KWbrO/Pc14Az1tpqTeuMN1c18lucZCfsGuLdzbzHYeNBMar69r51Wb5xakY6CdwHhwBPyANDwtmmO4Pa/oxlUYp0VQCD7YHy/QpH5IEQJwhWSjsvl9NKMrkOGGCH9MsGijzYgr0CWC7D97YWzmrl1tpXRc9fu1eRRkXkbG43+gujKB352FBqzQGVrjBpdTI0EMQXuW7ygS5hUnZkDEOtcbozf7ratdkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nR1OPqU6gXFlwK7zO5nLsEz7TgE70MHii4ubpmYAoMw=;
 b=rjeFKpdWmLMjbp4KnlaKJCdqV+ZckZIrBtyqgCX0ny1K5V67WNirtOHkqIti00REBpHkICbEO061GOsluyWy8K/9kpnQyeU3/gtcKMBxbrJpHZ7fimxw7ZKvyivVjXbOx2NQv9TJv6BQ9Q2gkm96g08+/fkBMbj+RYJvcOW1ZARfTtn+IZ4C5p/SxANbjrgRowP379xkDEVn3PQhWAjQlR8TPjwGA2oelWBc3xTQ+f5y4mEiTUmR6BZxQBpkA4tA0V8baJ0l/xFBomziA3/aY4z18V2E5YK57OE38nEcvTmSreTDf23W13K+OpLB2bvsVEEw0aNi4S0wivx8BITR4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8356.eurprd04.prod.outlook.com (2603:10a6:20b:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 14:49:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 14:49:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 1/9] selftests: mptcp: add evts_get_info helper
Date: Thu, 14 Sep 2023 22:50:16 +0800
Message-Id: <c624580cb5a93a70c6504261ba1cedaf32ceff00.1694702984.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694702984.git.geliang.tang@suse.com>
References: <cover.1694702984.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef1ae8d-638e-4967-8a5f-08dbb531dafe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lsrcl3axb36lb42vaNL1S1ueNExlX1UWr5H5gDZNexGSaZb9D6G0Ep3OIKpN8hqVGgRbk6VWqUeRYQC9uHumaRrcFyBhjHrFwgyF1EMWvma2cN7zOXd1a/vi8IIAYUuRosRNo5fhbzjXcX6n56O97NrdbELGDtu3qQk7YPMJ3HzN0K32JTguZ1iFpOMlAyvuLUPZUQf9ko0znhD+4yeFzIm2734xpMJ+en67jZJ1QQ69mjIMsIqGfehDULEjYIz3vfo5vjsrjITXQr0A8xc4zek90KRLddjVc/ioMrYa0rZIlkCbNmOfg0bxqsM3seqtNECADprYjtRgE7uQLaYu1+TPef/OxizOEjDFA+jSjIZrvEGO1Vp75DVB2BD/gvnZJzX5+QUGnFclqJT9TNTcgPAkUzgKj0po+Ue55DAleXV5j0rxL+WevpJ/qe4fGksUIHFPzxMc7/SYp6WnQp4qOiQhur2HsG1klsqF8GE9Se5ylCf8kxwM2c+iBkAIqEJsGw3467QGxORC1vYdAohjjnKP+sAoWNENfu22zhoe715Er7iQEiWAtPdwvNQQlwYCs6EyXQKPYnfUQxToeQgLGEx9i3J35OOmTzcojPVsKL0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(1800799009)(451199024)(186009)(38100700002)(26005)(107886003)(478600001)(6486002)(6512007)(6666004)(6506007)(66476007)(41300700001)(316002)(66946007)(66556008)(6916009)(36756003)(2616005)(83380400001)(8936002)(44832011)(30864003)(4326008)(8676002)(2906002)(5660300002)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+/uzsYcYyvCZl7lgY0+/eQO4DSb0G/SklmFS5qx78VWv8t2pR7QpNYWtQQyu?=
 =?us-ascii?Q?lmH0VQR+sMevb4tXIfJPDwa6DQNrOiO3oep09sntbczAxKF3/AP1NXW5WD4k?=
 =?us-ascii?Q?vzPeIk3svzc4J8rZfLQFkW9qMastMm5hiqXT0L5f/be+KpDCKOV38Ftzc44G?=
 =?us-ascii?Q?3T2T/gmglCcsgdehG0lPldimoI1Kn2cX2lmDpXztT2jSWO/FyJwNte4YR4JT?=
 =?us-ascii?Q?f/mgOFutUGACIYkEUv5XBTmMOQbQtWbsbjlsVsTY2ZGAH0pqBhcD0O4yQC+U?=
 =?us-ascii?Q?4QyhXA6KgqrEdvEmx9Oe1X3SE6JR5SURU85NqRfQIQT0tluuTmDEcfSHDDOC?=
 =?us-ascii?Q?voedejG4d7EnJAvyr/IrlRivSkcaDfY5BYGcyeM9dyO4N+YEMtFrEO/bvJ3J?=
 =?us-ascii?Q?9C+3qz0qcy5Mr3ckkqpmW1GAQLUu4vx3MWDKYyltZTsnPt4qdYU3VZkTzxfL?=
 =?us-ascii?Q?yrHb3vvAApIhbhiImZgayOVrfZ7VWHuKPvlXVUM6tNpcl2o9QGyLmJPohQt+?=
 =?us-ascii?Q?fEJc8eFk/7wMJLpFzfjSXgUdOqX+FmzcHUJNfdgrYntwzRYoG1OYPuP5b5D1?=
 =?us-ascii?Q?IIEuiLd4yNP97YVJRFebjIHNdN/+On0/V2D8IEnlN5vdlGG1H5fyCCDWDZSu?=
 =?us-ascii?Q?2PT9UqDcxl6zVfvneUWiCNf8r8bJaftzJuPAqNB0QwgbUDQRz+uwMiNmOU0R?=
 =?us-ascii?Q?tPyuVqDhIM2+kNqDvGh19vscx1wTnXNlShtiK0VzN0toIuVKVe6KVLbi4uIQ?=
 =?us-ascii?Q?48PM55p/XjgXiRPHLLqNH7qS3lmD4NhPzmQcmoDEkxgRgBgplEmUz2dbTM3I?=
 =?us-ascii?Q?+sNPiBXckq5XWUz8xp61Z098rx9jlIsQGx+7RQbyLEFSwjJYgELSl+FBKZvu?=
 =?us-ascii?Q?+RVWVcD3NteyhwJ3LSt5ctx5d5XGunuucT5gjkZlue5mqaBGiFyC7O9iGRYB?=
 =?us-ascii?Q?G5QKpe0XB+DvKWu3E0zk490/LHXs8B2jCWZ+4ocKqcs5LE3h47EgfO5Vr2qT?=
 =?us-ascii?Q?FneK33y5p6882wXwyNnkbZP4wW9FyEewYa2/AinrVqcUtXti0lLceZUnMotp?=
 =?us-ascii?Q?bqfOpAHWgSFDU9/VIz2p6Yvn2bx25W2mLVJSNtkhIiRQ8YEguG2Abt/cNMg9?=
 =?us-ascii?Q?1v0Z2y24Y94jDHIdmRbpTK6FX+pEkgsBJuiduFdlY3LHrgfnYKy+a3UMN/s6?=
 =?us-ascii?Q?ceDxMfNhRMUg2zCj9o3vmAeNAxShv5nOUC6YcxUYK8g4LnLKNrRMRbNJ3CeR?=
 =?us-ascii?Q?x1gFAg+/qTP/mhsl/Se6/1HQz5s/neGIpfV/6V1pJYpzSkCynosXsTqMuNwI?=
 =?us-ascii?Q?xiWjUTgSpkYYT2niAlgc3XH+81qsAnK0nh5nwV/JMtlw/HFHM7tjfkGYprIU?=
 =?us-ascii?Q?dux5CYZ5B57YYPaGa5v1l8/9llI0geclwJUUGCrLAqA421PwjldvDvJWnzde?=
 =?us-ascii?Q?to8/49RLwImGOBODnOi1M7LMCsfR6NNtLTjyooHpamFGiNjyO+YBDLOfSXMN?=
 =?us-ascii?Q?/pfKPdzxyUap8ZGOVG6CTz5nRgkThUXZ3TnGQ1NUCp6QtCI9iDzboLnBN9BF?=
 =?us-ascii?Q?1b8a+yvtaHpxyXn8/tM6YS8I3z7aWyDMOW51+YLnvTjRSZ7LlyWEuvHtqd5L?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef1ae8d-638e-4967-8a5f-08dbb531dafe
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:49:53.8225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRb40nBLWI8ZbOjSZZJO/pfA3vjRuji9XWG5cMjbriVYwlb1G3B5tu+mNR0t4hB84Ce7QDUUOfdsmTJj4gcMnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8356

This patch adds a new helper get_info_value(), using 'sed' command to
parse the value of the given item name in the line with the given keyword,
to make chk_mptcp_info() and pedit_action_pkts() more readable.

Also add another helper evts_get_info() to use get_info_value() to parse
the output of 'pm_nl_ctl events' command, to make all the userpsace pm
selftests more readable, both in mptcp_join.sh and userspace_pm.sh.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 ++--
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 10 +++
 .../selftests/net/mptcp/userspace_pm.sh       | 86 +++++++++----------
 3 files changed, 57 insertions(+), 58 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ee1f89a872b3..27517ba770bc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1862,10 +1862,8 @@ chk_mptcp_info()
 
 	print_check "mptcp_info ${info1:0:8}=$exp1:$exp2"
 
-	cnt1=$(ss -N $ns1 -inmHM | grep "$info1:" |
-	       sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
-	cnt2=$(ss -N $ns2 -inmHM | grep "$info2:" |
-	       sed -n 's/.*\('"$info2"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt1=$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value "$info1" "$info1")
+	cnt2=$(ss -N $ns2 -inmHM | mptcp_lib_get_info_value "$info2" "$info2")
 	# 'ss' only display active connections and counters that are not 0.
 	[ -z "$cnt1" ] && cnt1=0
 	[ -z "$cnt2" ] && cnt2=0
@@ -2828,13 +2826,13 @@ verify_listener_events()
 		return
 	fi
 
-	type=$(grep "type:$e_type," $evt | sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
-	family=$(grep "type:$e_type," $evt | sed -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
-	sport=$(grep "type:$e_type," $evt | sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
+	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
+	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
 	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(grep "type:$e_type," $evt | sed -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
 	else
-		saddr=$(grep "type:$e_type," $evt | sed -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
+		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
 	fi
 
 	if [ $type ] && [ $type = $e_type ] &&
@@ -3229,8 +3227,7 @@ fastclose_tests()
 pedit_action_pkts()
 {
 	tc -n $ns2 -j -s action show action pedit index 100 | \
-		grep "packets" | \
-		sed 's/.*"packets":\([0-9]\+\),.*/\1/'
+		mptcp_lib_get_info_value \"packets\" packets
 }
 
 fail_tests()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 92a5befe8039..def35395a254 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -207,3 +207,13 @@ mptcp_lib_result_print_all_tap() {
 		printf "%s\n" "${subtest}"
 	done
 }
+
+# get the value of keyword $1 in the line marked by keyword $2
+mptcp_lib_get_info_value() {
+	grep "${2}" | sed -n 's/.*\('${1}':\)\([0-9a-f:.]*\).*$/\2/p;q'
+}
+
+# $1: info name ; $2: evts_ns ; $3: event type
+mptcp_lib_evts_get_info() {
+	cat "${2}" | mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index b25a3e33eb25..2413059a42e5 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -247,14 +247,11 @@ make_connection()
 	local server_token
 	local server_serverside
 
-	client_token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
-	client_port=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
-	client_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
-				      "$client_evts")
-	server_token=$(grep "type:1," "$server_evts" |
-		       sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-	server_serverside=$(grep "type:1," "$server_evts" |
-			    sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q')
+	client_token=$(mptcp_lib_evts_get_info token "$client_evts")
+	client_port=$(mptcp_lib_evts_get_info sport "$client_evts")
+	client_serverside=$(mptcp_lib_evts_get_info server_side "$client_evts")
+	server_token=$(mptcp_lib_evts_get_info token "$server_evts")
+	server_serverside=$(mptcp_lib_evts_get_info server_side "$server_evts")
 
 	print_test "Established IP${is_v6} MPTCP Connection ns2 => ns1"
 	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
@@ -340,16 +337,16 @@ verify_announce_event()
 	local dport
 	local id
 
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
+	type=$(mptcp_lib_evts_get_info type "$evt" $e_type)
+	token=$(mptcp_lib_evts_get_info token "$evt" $e_type)
 	if [ "$e_af" = "v6" ]
 	then
-		addr=$(sed --unbuffered -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q' "$evt")
+		addr=$(mptcp_lib_evts_get_info daddr6 "$evt" $e_type)
 	else
-		addr=$(sed --unbuffered -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evt")
+		addr=$(mptcp_lib_evts_get_info daddr4 "$evt" $e_type)
 	fi
-	dport=$(sed --unbuffered -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	id=$(sed --unbuffered -n 's/.*\(rem_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
+	dport=$(mptcp_lib_evts_get_info dport "$evt" $e_type)
+	id=$(mptcp_lib_evts_get_info rem_id "$evt" $e_type)
 
 	check_expected "type" "token" "addr" "dport" "id"
 }
@@ -367,7 +364,7 @@ test_announce()
 	   $client_addr_id dev ns2eth1 > /dev/null 2>&1
 
 	local type
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	type=$(mptcp_lib_evts_get_info type "$server_evts")
 	print_test "ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token"
 	if [ "$type" = "" ]
 	then
@@ -446,9 +443,9 @@ verify_remove_event()
 	local token
 	local id
 
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	id=$(sed --unbuffered -n 's/.*\(rem_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
+	type=$(mptcp_lib_evts_get_info type "$evt" $e_type)
+	token=$(mptcp_lib_evts_get_info token "$evt" $e_type)
+	id=$(mptcp_lib_evts_get_info rem_id "$evt" $e_type)
 
 	check_expected "type" "token" "id"
 }
@@ -466,7 +463,7 @@ test_remove()
 	   $client_addr_id > /dev/null 2>&1
 	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1, invalid token"
 	local type
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	type=$(mptcp_lib_evts_get_info type "$server_evts")
 	if [ "$type" = "" ]
 	then
 		test_pass
@@ -479,7 +476,7 @@ test_remove()
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $invalid_id > /dev/null 2>&1
 	print_test "RM_ADDR id:${invalid_id} ns2 => ns1, invalid id"
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	type=$(mptcp_lib_evts_get_info type "$server_evts")
 	if [ "$type" = "" ]
 	then
 		test_pass
@@ -583,19 +580,19 @@ verify_subflow_events()
 		fi
 	fi
 
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	family=$(sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	dport=$(sed --unbuffered -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	locid=$(sed --unbuffered -n 's/.*\(loc_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	remid=$(sed --unbuffered -n 's/.*\(rem_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
+	type=$(mptcp_lib_evts_get_info type "$evt" $e_type)
+	token=$(mptcp_lib_evts_get_info token "$evt" $e_type)
+	family=$(mptcp_lib_evts_get_info family "$evt" $e_type)
+	dport=$(mptcp_lib_evts_get_info dport "$evt" $e_type)
+	locid=$(mptcp_lib_evts_get_info loc_id "$evt" $e_type)
+	remid=$(mptcp_lib_evts_get_info rem_id "$evt" $e_type)
 	if [ "$family" = "$AF_INET6" ]
 	then
-		saddr=$(sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q' "$evt")
-		daddr=$(sed --unbuffered -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q' "$evt")
+		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" $e_type)
+		daddr=$(mptcp_lib_evts_get_info daddr6 "$evt" $e_type)
 	else
-		saddr=$(sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q' "$evt")
-		daddr=$(sed --unbuffered -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evt")
+		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" $e_type)
+		daddr=$(mptcp_lib_evts_get_info daddr4 "$evt" $e_type)
 	fi
 
 	check_expected "type" "token" "daddr" "dport" "family" "saddr" "locid" "remid"
@@ -630,7 +627,7 @@ test_subflows()
 	kill_wait $listener_pid
 
 	local sport
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from server to client machine
 	:>"$server_evts"
@@ -668,7 +665,7 @@ test_subflows()
 	# Delete the listener from the client ns, if one was created
 	kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW6 from server to client machine
 	:>"$server_evts"
@@ -707,7 +704,7 @@ test_subflows()
 	# Delete the listener from the client ns, if one was created
 	kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from server to client machine
 	:>"$server_evts"
@@ -745,7 +742,7 @@ test_subflows()
 	# Delete the listener from the server ns, if one was created
 	kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
@@ -784,7 +781,7 @@ test_subflows()
 	# Delete the listener from the server ns, if one was created
 	kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW6 from client to server machine
 	:>"$client_evts"
@@ -821,7 +818,7 @@ test_subflows()
 	# Delete the listener from the server ns, if one was created
 	kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
@@ -867,7 +864,7 @@ test_subflows_v4_v6_mix()
 	# Delete the listener from the server ns, if one was created
 	kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
@@ -933,18 +930,13 @@ verify_listener_events()
 		print_test "CLOSE_LISTENER $e_saddr:$e_sport"
 	fi
 
-	type=$(grep "type:$e_type," $evt |
-	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
-	family=$(grep "type:$e_type," $evt |
-		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
-	sport=$(grep "type:$e_type," $evt |
-		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	type=$(mptcp_lib_evts_get_info type $evt $e_type)
+	family=$(mptcp_lib_evts_get_info family $evt $e_type)
+	sport=$(mptcp_lib_evts_get_info sport $evt $e_type)
 	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(grep "type:$e_type," $evt |
-			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+		saddr=$(mptcp_lib_evts_get_info saddr6 $evt $e_type)
 	else
-		saddr=$(grep "type:$e_type," $evt |
-			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
+		saddr=$(mptcp_lib_evts_get_info saddr4 $evt $e_type)
 	fi
 
 	check_expected "type" "family" "saddr" "sport"
-- 
2.35.3

