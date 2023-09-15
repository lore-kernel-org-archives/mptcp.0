Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789C83FEF
	for <mptcp@lists.linux.dev>; Fri, 15 Sep 2023 07:44:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOfNbJxnhmHHvSFPMky18sXYUvcxa/Jz26FVeeQtCwKObP0DyrcIzvye9QyVF9BdSS13BnPJmxMItldh84q3xAMYx9LzUtilk2o+DBXm0Abbzm1zfru7HrDb+OzQe0m9FMpyeOglRXrd6LiUVXdr3ga9gGacoB5eUNoc+Vx40T2qMJcxabBPP+sTU11ch9wZBWzzUvIqwWKNHOCZlphLFBY9sSNvXjLOhlRDpgc+IZDl7z7hU2JFF983jUQW8gGVVjDHIL+jB8b6yBop4bcZRvmkrgzC8mH1xU0UexJly0XtVaeX/WDa830i1VsPiK9PW//RVq6pRGU6z2eZwvaSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nR1OPqU6gXFlwK7zO5nLsEz7TgE70MHii4ubpmYAoMw=;
 b=DzQAGm8e/fqW6KPrKV163u3VwtHOEeJANK8M0moZi9QaJnmDZVRv8q2VqH1mljkG/ZNWqkf9DLPXopzqzBF3jajur8QQLoncWJFtEbG7okJaClfESkqKNK7oIplANgdoCoyY2TELFQyrmwMeMYY+Snyu1XKMRhpDt4hLC3hKBS88LxMemZvuWiQFVklLcphcQC9SN30tih0ISz/iLCd2CKWdGQqw1zukjzqfZVjVKva+H4QoLu78XtoCyIlhqpFu2iiU4sPQUhFX4/yfqkQ0mY+CDpkkzfb5Chzzn3BLfV4RYjaxsXKg9bBjHbtGnqkJYu5W+19004Dvjto9o2JqMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nR1OPqU6gXFlwK7zO5nLsEz7TgE70MHii4ubpmYAoMw=;
 b=HnGWdP5+A3Zy0KSATqJy/ggOHHfQ5ItN7Q5KGx6o6IaAbR9GBPzvpemjDvR4+Dza5KBqJZ5qNkV/F6q6XRlVnGgjoe5p/lvifHgMZJOCdN0hVmmYsehJ3xJ26xRVHyT3/k+Xz41rQa/av2xzai8KJhI8kwIDnZdq3WMOBdWOQeVKLz3c984+8h/as58WvP8KmPXSiecvQTrw9fxpYDvrIDZUxfS0I3purYxT7MA2V8G1igOU83cVU1xn3TEKHcdVrAcc+bhzk3v4tUNeHpnEFFEQNi6n8z82pzFqk3MH9sLbIGCuVUwW29jEOGDH2c7mOydXE1Z6zyZXSVBiJo6sRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7524.eurprd04.prod.outlook.com (2603:10a6:20b:286::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 07:44:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 07:44:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 2/8] selftests: mptcp: add evts_get_info helper
Date: Fri, 15 Sep 2023 15:45:12 +0800
Message-Id: <c8066c33d13589c37ac99d1b6264fdfa9d8bd8f9.1694763508.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694763508.git.geliang.tang@suse.com>
References: <cover.1694763508.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: b21c2a63-3127-429a-e1fb-08dbb5bfa5a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wAMrjPvUYJadPuGWOU4yQhvo/L8PDL+jMmu1vLA4LWmbTKsKdNVCjsk9/3cpRRkR1qZc4h1gA4qsSp1uV0DPrY4DLUZhxc+8zZU7UN70zojoN+VRWcjSoYzHSj+xXAJtX64F0VOjDl45m8oAEdz9Xhnui6GzLDmJlvbotjRvG2rtQwp4IsT3LbHww2uZAudamtKZaXkx3vZKc2CYwt6YfQfTiZaV6xp9yZy14XEwDE9nJxB81K0ELcPnS64pOR3ypb2zDlz31e6Qtow7ngAX5X2SXUFmfiz3qOejl6p8+YKdjnM0OF+xyMCysRapALRCUfdOedjNJi+cmXB8QF9SXJHs+TeSjyKYuK+zL1t7p7KTLIlqksVi5be+h9J0Rcj7zHaAd7g8Uo8pgjn1emTWfRjeBt1YNsX+EjCQw6zH3+q5xz9rslXmXb3j/uuWMg+01VtlbmzjHZmr/mUUPnHUk9nHau9/On5SlhaphfIW8TLDqEFNrOswWSrDYOPLQOn8ftlmUbnGD9kmiJLHsKw/Z7Zp9WVYN7JJVKfb8Nr2MdIJa6ynqJBf3wXjx6xowou5P9d9hmycWmlCyqlWcnwQE4N+p3AmNLOshcpoM5Zd3wE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199024)(1800799009)(186009)(6512007)(6486002)(6666004)(2616005)(26005)(6506007)(38100700002)(86362001)(478600001)(107886003)(8676002)(66946007)(5660300002)(8936002)(66476007)(44832011)(4326008)(316002)(66556008)(2906002)(6916009)(36756003)(41300700001)(30864003)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c+ePLKrhqK6pBqNhlWVBP126MkgA+OLVa2iRFhDuwpHvKX777pbKBd9FHxTS?=
 =?us-ascii?Q?8LET3zeYe3e1KX4E0rj23RGFZyJLUlNof6CvYj0+stQ2H5Xyl3mvUt4HLark?=
 =?us-ascii?Q?0UrdJSo9/XMdzqRsZLnp34CJ3nufc0wm/VoQslduCBGdUxh82hhVVikFZohD?=
 =?us-ascii?Q?UD3mTZRTXmj5plGtFsjrF9r1aDpLsQ2tb856IkIX7BAEtqFHyT4N5EinQf2+?=
 =?us-ascii?Q?sLZPbBG8sCnfGFMg7nOUAnvDYlb8PemiqpnMX9h9reXt7rIHpoHZ4GO4Hgay?=
 =?us-ascii?Q?vtunbvrpo9VlF2NUuf0wgui2KZPat5vQqkyDsWol6mEhF9De/KJnt70kP3dQ?=
 =?us-ascii?Q?imvF1immEzXyQvqmpWDnMjljPTvL4POOgt5gPLQUFKSVnqHZrhdPZVC1zfHo?=
 =?us-ascii?Q?m+OtLA0wslMxjbJbL1CCvPL6Z0TysbUGbVU5Z4fXSRcl2tY7EHOP0eHtCnUm?=
 =?us-ascii?Q?NC/OeJtXpEZkEJUDrfthu4GRmZvfXlerZxkRZLVVLaCW8ay8yjvziEg+lZYQ?=
 =?us-ascii?Q?XRTS0eKG1QdDevpatZ/mIoTEDJyYUZtgkJm9lt1jTYr9QKwRUGcZuCv0iewP?=
 =?us-ascii?Q?KGhIMeoh4D/V57qY7JWvM3St+VlPzw73Qiy83D710USnrp2r8FsmvwZinZiy?=
 =?us-ascii?Q?fHKDzDQUGNBIVYqqW5bvIP21fuqO5jH3ypW3aXkDpTnTS/Tmkj96Hcavj3Ha?=
 =?us-ascii?Q?C3sHTrdDuk/pPQfKY4tlzLenXndWB72nz+JEJDs4nKcAc/umrLwtOWQYfWYv?=
 =?us-ascii?Q?hRdUbiCSzjT4IaR2ZY671dREj8BCDv8Vnn8mQXQG9AxsxTDwa2PbtJrIcLdM?=
 =?us-ascii?Q?3uoMVenTogOsVWNWOZ98tafgs+Yp9jhdKuWwNjBDpyUaVjDjElL+N8apHsa2?=
 =?us-ascii?Q?VLk3MI7rUg/B9eZ02mhXvCdmaM0j2L0M8T4aJxzAT2ujpTMVYW+6a5Oe3kYW?=
 =?us-ascii?Q?AWNYgoy4airp9L3PpNTEp9eXMoZ3nV9fdTgRqaOEqurtGikizrQFHmdaM9qJ?=
 =?us-ascii?Q?qFvsNMcJvs0Cj7pw93OF8Lw7zk4hS4HtG+XcR6PJAwfJLwmk7b7N5VdRYU4F?=
 =?us-ascii?Q?83sZn5vtAN45olqgJBseeoFRtHNierm2pNLDcfp82ytW4J7eTQXfrtEjfA4C?=
 =?us-ascii?Q?0fQwTaL6fdRPan0XudgtMcqnl1JgZm03gZ8UCPZeJh+lLsHx/BtRQ+eLQfbr?=
 =?us-ascii?Q?MwD6Uk0CIKfGNoNFUYLh82Ok2t3IXPX4avIqUke9OfV+jgj1RchsHC44Bo5p?=
 =?us-ascii?Q?liSVTWcs9Iay6LdycD6Bc3Zd4mCH5jlQymTnd0ObSWHZXOSDVheN99n0kxIj?=
 =?us-ascii?Q?Wc+RFTjNuhUX7XD+yL0irvOBhBdvy9PtCov9R2QmzCc+gnVvq1bKfKtrEtiP?=
 =?us-ascii?Q?W+Z4VOZS9Za2lHp6v3UAb2+povn+JSIkWkOzI79dWm4byU/JzniNgH2gmN0s?=
 =?us-ascii?Q?usrn6Hrg+ktRxYfSLTkSnpNMsRKXVjmA05p3tUG8+0uEjeWxnilLDYxnuwXK?=
 =?us-ascii?Q?iEFNqrBDYmMoZacrkdUpcZfUmA9yaxgXT9M0VcbY7YmwfEFh18S5H9FjpIA7?=
 =?us-ascii?Q?K2LITS46qZSncVm1CRbXkeP9WHfe1Mf5N+16lfmGcxg5B6ObsE/cOyDC9Vjf?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21c2a63-3127-429a-e1fb-08dbb5bfa5a6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 07:44:52.7653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuYgOY9O9dscql53j9VMFosh8RVCNhs6ApfJ5c3DzB3Zsw6ZvyPs3vdAF4o0uKTBLDfWOMyqzy+FgvmqSGQjDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7524

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

