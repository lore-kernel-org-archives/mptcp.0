Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2042AB50
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 10:03:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6UlYfW71zZ5XfGnXwDZHeA7ONcl9FStH2JAuu9HVlOR0fEzJQIkKCJALUUd5z8hwIN0V0jEv05lTvGid2RuOSdQCfIQ2DnqOsWiX/xrjZKWYC9JSTXu4N3Hln7oA/RpwGPnENG6ksl8vuRfWS+6NBBeYop8BSoGiSOcEzt/B+tL6l9uEr199Ln/inAON9brB1N6ONEesye/P9+CACndjEViKEOtfDi1CKspt4WE8y7LTZdKgyzq8Kt+lRYVEhd8NW+SALvWGfh/L+iZylWz5SrSYAltrjHpD4Tof3uvKthsIm07DmPKqtqVrjLPXnDuJOT7Q9no+wjZvH/Ccc/Aqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nR1OPqU6gXFlwK7zO5nLsEz7TgE70MHii4ubpmYAoMw=;
 b=HAVPlFbFQBlTQ7hHmSXjE5oSmKblA53yEroEqtAGpCwUQr0XYec0xT4QMMWEp0GbKbJEiAQBHozvQlWz/Q0hJve7+lBT7EpGUBgnUA3KHJmuLKkaMdNYvJ/8A4bb/6g0inv7BqQLuEiX9ccNm8BlZwZvsM6CFO17NHTdSG3Bt4Yua5QzZ5yRG/5iGDr/qVi7dorQpVZec/XGA/q46dF1Bm8kaCIWLP1GFNdtRJp4hOGTVE010Q+JNy6rfPa2c0lDHS/Of/bfozDvkR4L4SIvo7PGHBM7CbvK1dCK83IIkIBhDgU+XcOwMndaLUF2a/TLz7N1iJZTM8VI2vZlOvQ1kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nR1OPqU6gXFlwK7zO5nLsEz7TgE70MHii4ubpmYAoMw=;
 b=umZgTDIUKGVY0Fw4HnxEmj51jCz8OWKKmmVLbjkRFFirLSj8jT+dKYLCE0cTL89TPBQR1wX3YPtJWgMT9c3VuOiyZKyZnUJw+h5E0td14CsKvUJ0r7jwB2RsAG6TleC/qsgCwatcUR0bIWKyAVYKFjEFAGSH2EiDo2o0l3F9e3PLMb6Wbh+tVezCOJdyARtHIWXTivA4CKvIDal6gT8DSXiZX7r8daGoIT059P35nwXIOK0RxNoLjhKXkeF8IyijtJ2Tf4vufJsHbRyQ8NlDmbGteJM/E0K+fTFuUSPmsTP9hvno5HMsNRwJ5HXwNKS7hER1vX+aDn4u4514VNpJkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8607.eurprd04.prod.outlook.com (2603:10a6:102:21a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 10:03:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 10:03:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 2/8] selftests: mptcp: add evts_get_info helper
Date: Thu, 14 Sep 2023 18:03:19 +0800
Message-Id: <c6e803856f683e5d2bc51d822473e95db26494f0.1694685050.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694685050.git.geliang.tang@suse.com>
References: <cover.1694685050.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: e283646a-b708-4708-889c-08dbb509cac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BDwqdKl3MjjDiQ3NDIXp6gyg4y3twGd2eyTs+3uyohIa2WhhImgySrI5n16Q2EVM0/wlf0nTdKoxDC3GbJkvTEvDMwEn7KRG/Kd0kIjlO+5gW2+rOJ1Z/0lQEiOkAdS/xVce7z1PTxPYaBaaSnXo+TKEJdwNCoBRIsKd8me4C9HHWH/8dSnamv29BroTKBhlFbcjYbtDO2nNmZbzo5r7M2I52QsG2uNxNae0MHe5h9KdIuvYEuhotncYZ1xgKA5IlKrcVS4OQEINMsot1ysXW5ZCrwc+wHuskPV6EcPwXZmQmXSZHWmYuziqfK/UcfRIt3fK9LX+EHtlqI3/e+CF12odClFw81d3n77UTrvzXbBpezDnPD8PQadCeVXRyk2rlhn1EaJqaS7AJgr8bHiY7YIxB0CMZR7sWeMkBAKeFf9FHtDPmUf0QMzWM10hmopVN3JJBwoKtd60v5smGmxpX0Hn/fUBVDq8LnfOlY/bbYCcbz4uVOYWZdFMWhwpSCExpDtRu++kqLRrxRiSQKnETPLU6P7Pn3VvRa16smO3y/C/WLklyu1TusPjq/cWKMqM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(1800799009)(451199024)(186009)(83380400001)(2616005)(107886003)(26005)(36756003)(66946007)(44832011)(5660300002)(4326008)(8936002)(8676002)(2906002)(30864003)(316002)(66476007)(6916009)(41300700001)(66556008)(6506007)(6512007)(6486002)(6666004)(478600001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IlvGFWL2LU0VMl351vwFkgmtwt8GiL1loL+dMKoQsrxtRfW5U9PPMtB9no2N?=
 =?us-ascii?Q?fYINAH3Ay8mSWfB7+7/dl2iaUq77uLQvbTYTZT+MNhIZkbkkS4afVN0XyAyr?=
 =?us-ascii?Q?Os7NX05INLcQcWNYZ2t8tzT8BJXuw5F1CynZayRTLiOTEPVm1oolWl6FcydK?=
 =?us-ascii?Q?PvDk1Uucx9/ylo3h8UvpLfoEh7KuN/HHZjgOs+J9Ad691SrZ6Yi0lKeDYFKI?=
 =?us-ascii?Q?bPkFMnV9ho0JAtIH/bJ8m/8wqvhlIljlBT4EPeqDZZsispbiQDFTvUaJKmmp?=
 =?us-ascii?Q?0yKS6R+B6OMZjVY5mZbM5tZKV1ZHjnGJImNpOn1Fq6n83kYviwvfdA78pERf?=
 =?us-ascii?Q?N7fxauWsIpvJW25aWL0tc9Wz/aWsMx4Du3APe4WshHYg9uMSNuY3tT8Qmsbl?=
 =?us-ascii?Q?SuecxvZHMjDgomN+UAVge0FpFGxgN9hBIMmK/cnFR7TvSRKY8YN1ZPYVNM4w?=
 =?us-ascii?Q?sd7mXpFIiaH+NGiEJRwbdGB01yTQz7CGvDAAXVqY2SwE7rZbef8kbcn49BHA?=
 =?us-ascii?Q?7GlHcSOByD32ABnpdkzTJhLBcihkBXMVJB82DBMFFSC3QnxSSXdJ3lRqjvdc?=
 =?us-ascii?Q?XKA1J56F2UgJWGX1oGHpcagaD75QIiEAPew6wzUHFO3Y891yEJ5TlXSBTF/9?=
 =?us-ascii?Q?lJpnePu0u9frz3pGtWhVM9fAWQnj1DL8o9Arvo40bJ5jWmdLyQQ4LpouWlNg?=
 =?us-ascii?Q?B/vGkFIhopkeNan6NF9MWs716o2Wm91Mkv+sUhxURHko2NvbcFR4+E+lv/+h?=
 =?us-ascii?Q?bmyasbZFEOl7FEQPy7pvpO053EpPD3cdSy+B7CniOr8kP962VVENRuZmYC75?=
 =?us-ascii?Q?7WdXtqJHvQXFkPvyvBvZUAL6vLylJE/RGfjoUjrQSuNcxgN0DJAU+uHkX61S?=
 =?us-ascii?Q?EDBKUNkNUiPpGJ4/L48umsFmJcI029E8fwQg8RTT6kXKaadgVF7V4sHqjhbx?=
 =?us-ascii?Q?sT1FxbBbKXM8kP6MMccH0fzgMZwsrkJaXpuh3WYuV/b0nYiL3Bk3Xyn4VVQH?=
 =?us-ascii?Q?PMzK8ciw+TqCrByPf9tz5Bsmz7iXJ8mhZJvepntu/lTsMxsH1+dB3NFM8YXu?=
 =?us-ascii?Q?rQU6PagzyO2gOIL04cE1MM+dFTUY5w5EwnN4a78RmvyQrM4Ss9Gc/q6ZNsoH?=
 =?us-ascii?Q?RaBMYXjAZIgxH0KitDNCb/4FbZl1IbVuZIlli+iqalwoJSj4luJrXToNnQNs?=
 =?us-ascii?Q?KmNWMIkMOAWocjQu6QmYp55A2uQYPiopXdjZNQArID6IGoO2oravnSPCjtoB?=
 =?us-ascii?Q?F8uUQjHugZoojee6i22ZhvTpDoP9WMTNLNQnKZWe0uVu8hQrccVYuhpoV1nK?=
 =?us-ascii?Q?4FNnmdmrzsJBIYmyKpmm8B+uXlwtLcQpMFD7z7r+YmfY3sg707jjQ4n6vjTH?=
 =?us-ascii?Q?zk1tFZ9yGvvMDWK6Ve4HAos/Tzh/gYr5uUzBjSaAGBb4WYAkL6tTNuRwRy3t?=
 =?us-ascii?Q?CGjm6kTTDAM86TOqdc8I+zS+LuSUGWBlxiJLI5wzjPWsakoBbM4yY/TEXfKh?=
 =?us-ascii?Q?qFt7R2VSSlRmRDMh/iD2vefKqASf+zKGK65iyf5giLSq27XBhG9ILDf0vAi/?=
 =?us-ascii?Q?SUYrrHzC9J0Mh5Nxl6yLBGpFN9FsfqpKUQaZRFVV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e283646a-b708-4708-889c-08dbb509cac3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:03:06.8469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmorBbuVvwpkXWBmJ+uvR1WAwVlhOVOS2MLz9hjI+BTmoo9krOU8DP9GwNkKAB3Pw+izCobxQ/b6q/L3hHyLrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8607

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

