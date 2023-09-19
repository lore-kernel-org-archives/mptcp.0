Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FA934CCA
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:03:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlEqC6xvxJ/fVxDRYIZIEiE8ColuV6K7LGAcVF8s7HDdunpK67JHRF/geZoZn8XVxZdwE0sXVm2EXzSv6aMhHNVr0YIywTNynqQY6QzDdGpt3kchpJKWU6vRKqnFMFRVwwqNwz7ve5Vld8E+eApCISUI05rAQ5S7vrdGxm6phm326ZEe3uuKBPbn2tHOejJ1aWCX5/vw7rDnSKggn1TdeWUIDhvhJ8KcSkmsA+Hxj9tQjbNkKhzqEtdume4woRXZ3Zj/5ulKoghtfcfZPuyxkiA3gDAAnpZUjF1Isqe1VQ3ErkunNnYQB0FqDYj2nZ2yPbdNeFwEuj1q6u6Khn2kCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku0tte1dpmSJPclfwZOKkIP33liMO10cxkuBvsGrOHQ=;
 b=jP/scP2WtD28S+WglPfM++DDDfLcRVSuJeuoQSkcXz2tjUn4+jPGNuVdQfsFr3j/ESA2raImPipkwxFUCYfOwanBMOPQXKIAL+hjKNR7vpy5iFROcnMmouyPM8eR27dg7VYkeTOTVopjMgyawi0N4uwCfCIUT2SOql/+KI53e6f0BNFai3P9nNQodI8EucukEXQ+mZB7xLwYq5984pwGEXgpdRABRQ3MHwUM9nWwY3IzF5pBpPAgKxP3mrOsbO/pKIj48gKhfIlckpKaClxyKx3wcGP5qjIaTRH3IXGCBk8xSbQqZxjG6i1KPCiw+XfG4++yFlsyxyqk8Su5XVdRfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku0tte1dpmSJPclfwZOKkIP33liMO10cxkuBvsGrOHQ=;
 b=vbO7bRsiDF2ix6yU8LODd//Y017beQ2bNW9K+Kd1M4x/jTaT5H005KEMMX8BL2waVSLnkLJMWtjx7RvpnFTrrFze/BaGEIkkXjWj/t6764ErSZHKfOV0BcgwvV9LAx3xHHTCm3z0Hd7SyFn4ZWYm1w1hSZYynVfV4LsbvRmvAPdJjDOaPH9wENIAB7YB/VDtq6N4TJkqAhDl3LFAlDipsPwc/8XMHJfpbEabZ4zab/G/DaEGZwYsDVfNlu+tkEnJRPRtKWBi5nqOS8u5dIdBoleEXGiQ5MT1mKteJCQBXmZ+IKZzfynhts5UhGJq4wy31INAdChrUQzL8ApMp6lhPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:03:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:03:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 11/30] selftests: mptcp: add evts_get_info helper
Date: Tue, 19 Sep 2023 12:02:12 +0800
Message-Id: <c158b9c0c152342b0b01fedf9807049372200541.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0178.apcprd04.prod.outlook.com
 (2603:1096:4:14::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 55eab7b6-3b9a-4b09-712b-08dbb8c55d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Uvmmo3bqF7OXd51vwiUhdaVgDeeDgUw0VEqGkfH1f90u/emsOvW6B7K0oLvbLdLqX1geEFiAPhU14VSQVhgV0GdSaclqSmzJdjFQZMR7ltdTbeOwdiR7Eb0zXc1QA9LCfwj8TvanIdojINxnCoDvFZHa7lHWd3eNk/Qe2RxRU4Ub5/bHv1H001oIqnUfXFr0rE9iuiua0vrFH68gRt6fNKKOkMItilu2+3auQxkWLourABdwaRKFilc4b3bXJOmE1591B/f13kKrqR2d8v53AlPACDeZrGr3UUx4MbqUkoQt+JBYBXenUw4AC316282MlYKCd76G3iwEIQruafOqyyVa8dLRbHUn8lu5oOqDjldcmq1aZ4t1FSBSM4F4R2BHtvilmxVTm/mncrIyEfOX9EdxAg5ezClyaVNZFDzh4Z6Gvcqdyo7VTdiRfdbznNnXeir6SYofSbmgFFE+/npmu/v75HlmHkNasyCd1b4BzYb41iHqVKwjQhSim06JE4l3XlOu3iuUWP2jjsRtmw3hd19mt+kulJP5px7/2Pzj/cupWAclz6S0HiCuZS6hzV1+oMpmlUPmF4By9Fjmb1+FwIIQWHeKd9SfunFch1Gyn+o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(36756003)(30864003)(2906002)(38100700002)(6506007)(41300700001)(6486002)(2616005)(66476007)(66556008)(6916009)(316002)(66946007)(6512007)(86362001)(26005)(478600001)(44832011)(6666004)(5660300002)(107886003)(8676002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0jNeZZrXWsSIdyyaj8X7dBWysOEAefbhoZGYXNcZdojAEy2XEOmj6oV1OP1L?=
 =?us-ascii?Q?Ma8hVGSw1L/3c8sEDbByqBfnatys25T3A3/ayMoLAvaJr0XOa1uGfLr2irYf?=
 =?us-ascii?Q?gww6O4RSmoDm9K1i2YBoiuTkQPR80qvWEibUUrMRhLZWgm0fYx6MLpwggOAx?=
 =?us-ascii?Q?MaVfez55q5dD/p4GbMvhHMFM48FfQ9vocfbIMzmZ9W2y5AXNfMiF1uERou3/?=
 =?us-ascii?Q?1Msn7jtO24w8SlLLtyehFX8edMwU7fA+jO2KBlRedx80ipQyWjCh2UxAFngq?=
 =?us-ascii?Q?DB+laXBGoIjrBJpFpP1w51PhCJRScea0MNYNQZ/DOn2bijGOLYwBjGP3OTGi?=
 =?us-ascii?Q?thA117lBvZoP5nrZI/AYMggnt+oVT27x6P4CtmSIkeaZbBQEvKZ1EA1xjQS+?=
 =?us-ascii?Q?00QOmizcYGRcwvRxX4V2uPDvU31rozIgTE5q1tyamgbclKidhHKz6EsaFoTo?=
 =?us-ascii?Q?JVvLvtWE2znzJXShB2Kwk3EjAujRcUqIRVgGipKV50IvcNgfMtMjFSjikk0F?=
 =?us-ascii?Q?FTTyv48w+/dXICmASg1X4uq7IoeF842ZgiBMhtT/ODVkjZRf2Q2psBJsJpxG?=
 =?us-ascii?Q?QRfVWmVEfoN3V7D9Wl88D1WQYael0VIX/NvxAnOKZiiXQeY4OekA3wVPmsbo?=
 =?us-ascii?Q?qtIy8rtI0ad4hhOYaNHmUfRW7jWNex3bYFgIIlXKlk8jcAih02xcgPj3Bsb6?=
 =?us-ascii?Q?sMX9yDe+k6UVH+ixu8KSQJOBaVS1eFDZcoIS7EmQ5NjZhS5hgxxwHZG2Vujp?=
 =?us-ascii?Q?qhIJhXpvaWJy6sTayQgFqtkPusHPL5A8il6deTMTQqgV1TDi/YjPjsUbiQci?=
 =?us-ascii?Q?0HPDx3fJShMCAAOmGgMU44Xaj4WCmWjUB2TUqR54pA6kJ5P4UL+Zn6/eG2bL?=
 =?us-ascii?Q?VUXlFw/BOtXsB0qHIsOW0MF8RplaDFpazxnXBXtTpWN6A2EGYFgvEjcbZ/zi?=
 =?us-ascii?Q?HvxXNMDOYT4XYlVixHmYv3dp2w9ZwJ01iDAaH5QF7CqcNYp+LFjXANXqjSWq?=
 =?us-ascii?Q?SecZNbSvEWPDEnpkE7/Bo/OGzuoZvNnD6hDuQT3czY8X8RbZ44Eq21GPVZ32?=
 =?us-ascii?Q?reeo+06zY/CZS9mPTM4AaAck1pAqulKsRasSwaiDxs9k6GEhXJKKTrgsxgG+?=
 =?us-ascii?Q?ray321JleMeONZvZu+KdkmOb5WHBtbKWYsiQEUpZzHGD5O2oWT1+shaxxpvu?=
 =?us-ascii?Q?qi2WsAXzbLqxuw8g8CRp6KKz/A/pz9MQWlY0mqex7PlSSggk6sPS8IIXEq/2?=
 =?us-ascii?Q?iuqXR84B545ZJV4s7pCGd0VgbShyrQ2BNwVzCyL2fJEdg3ln+GZeunhdGFlV?=
 =?us-ascii?Q?qpozE6G9TPZHJ/QpEGOMOOmFlk2LvZkVSaQsZbFIdiSQj4M++uMDgi2aRsGV?=
 =?us-ascii?Q?21ViQoRxu6j8l18P1jhv/ZKNaUx325Yr7vJHcZCZJCtJngjP03slrT6Ic+nf?=
 =?us-ascii?Q?XF1XKqPV4JPwd+9iNFWBAdC8t3J+iQu3GFgoZARAHojTG9bU598zCiQ2m2ca?=
 =?us-ascii?Q?nVsPcLRmzbk6CMO/GvrqDXVfEJvJkbGkzTKWHrWl3FgPt055bn2f5lhOKEPX?=
 =?us-ascii?Q?VHe0xbdwTY+uYD9ev8fXVMu4sJzXaEvTaP6oH0a7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55eab7b6-3b9a-4b09-712b-08dbb8c55d5e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:03:22.0909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFEL+G9t0BNlvDSgCarfWwQTmWVNH4h0SlamjfXfp8adw442pNJAKye74LBrHVr7F/2iu0g3O2sNwlQpOZszLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

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
index 784eb695f42d..3e24ab7bc221 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1864,10 +1864,8 @@ chk_mptcp_info()
 
 	print_check "mptcp_info ${info1:0:15}=$exp1:$exp2"
 
-	cnt1=$(ss -N $ns1 -inmHM | grep "$info1:" |
-	       sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
-	cnt2=$(ss -N $ns2 -inmHM | grep "$info2:" |
-	       sed -n 's/.*\('"$info2"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt1=$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value "$info1" "$info1")
+	cnt2=$(ss -N $ns2 -inmHM | mptcp_lib_get_info_value "$info2" "$info2")
 	# 'ss' only display active connections and counters that are not 0.
 	[ -z "$cnt1" ] && cnt1=0
 	[ -z "$cnt2" ] && cnt2=0
@@ -2861,13 +2859,13 @@ verify_listener_events()
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
@@ -3262,8 +3260,7 @@ fastclose_tests()
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

