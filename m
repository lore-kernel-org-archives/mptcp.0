Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D15125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:44:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jx2VNLgvZFmsY2J3a5wV0Fm6BntlLNbZ5aSx5VpFysoTPZwn5OXjuqpWDguQq/bf3Iio/mCiXlQWTvDIBUU4PDZI/FfDQ4Q2dt5LkPct+/sA79vo0m2MbgGoHmcdxhaJZ9WgVCeFQEKKpgGumLC/OyqZOThuvqRJmTsg6eNMjU6/6gepgmjMN3udTwFq1kXYy3Yj594HqNMk3Gn+Ko5ovnOBY61bNEQVqYh2yh4UyZcuU1AgIy26ucuX1H+rd/ZEXGARSpaDV4bUgaxdBIpOMPGlEVxM3UYfVczy93X8kwiUG/ziK2545MDSo5lrFfRfdaXzHo8n/5VUX/kSif7Cgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5OE8Y9OwqddXSFHppsqjt6p7uQNiMSdupJ01441QY8=;
 b=MDyN7d8WiU8uqJdWMKutGj4QliktZRrt/iIAHqF1L4ZA9Ne1We29RKxJr0djcUvaGzoCLaffNONl8VWYQls6UR5fK5Tv7YopBNyStZ7AN0uYkyoMzqQs84xZuphCC+YEfqqTqcayYfZnBVolkkyRQrJ6u7skXFn2XJ1uCl9YUXiJZ9Gia0nwsCEJESnhSun6LhbaFTvYYZ6/KfeZ4wKipcyqUh3m+a2VPCXBUJ9Pt6XJbMKuXxoNpJ7/7aOSqsuTi+sS1+VXKnpBJUAHBoLW6wufJQrz6gpMYSbNDukJU0Kd91zYH3J47rUO/x4yadkZlHSv0IXpXNIfSN1CPW/J9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5OE8Y9OwqddXSFHppsqjt6p7uQNiMSdupJ01441QY8=;
 b=DK+vs+1gGQgKciHPk8MvbO5rAwXxRaYSIy8ETPhQ3p0tAyiNTBdSWh4aV7iIh/R7MbqrHBHseHipYTvj1T10PGe4q3ZJIKwCNFpnZPv6FcW+TM99JVW9pzWqJ3EMiszfu7QB5eitynv5N21Qbi3IQr67TpbZ/QlZAT/GZy8Tov9H4VUqsG2IzOca3SYOS6OfaRVkBQlPAFUXuPKB3cXmG7JS7ianho7geK1VPvRTXHE0FyfFp3N7vM7HFiS6Rinc3MTiKjojJZomdaH9BaYg7BfIq2NQhw7SuBT/75AZrBxlY2DO9NyBHSry/jRWo9pqKTKf+ZpYpRHP+Vv8euJkcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:44:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:44:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 24/29] selftests: mptcp: add mptcp_lib_verify_listener_events
Date: Mon, 25 Sep 2023 16:42:03 +0800
Message-Id: <fffd509e2993c2058fb6e9207fd29a3a6c0eb09e.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 74655bc3-3af2-454e-f0c4-08dbbda3a17a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LaBabaCBjvBMVjM0bVA7oj67CuwgbIgk5wOtQ7QK0TdPjHV4DUHirsvbbRjE50gjxktMnUrWDUUnhP33T8kw/XzWGEFSfLJtpIg478MkdZEOLSqQY2pupJ3VKPu22d3z4QGW/E7jsrJ4la/9HBBScQU837yeZO1QYYrS/zsumwQP9+t82g3x7fW+uhAs4RXBAxqLzywqB0FNYTxDf2qrUuEPGKFAGK8SowwhcM5ygiDfKAZhiOnVeP/HObj5RYGNU2ac3CRQzNHv5ClgjJKH2/s3/vqE+Ow7jUGuMhOfshrjrW7miH8944Q/h1GhaTryRUcjKx+tEah1xaluYz8h4TarVGRGcxTO/4VlqzC2Ab1Mo1DLWbRV4QCvxEDWVIaT6L5E0vSpDHWKPDDh+K6FMHmq0e/JTQvG+tMLcISpWBMJMLnxKpCgQYZVbAMSD2cIAIcey1NFaf8EOzkPXjPzrwFYfHgbxJSJbTPFAjUf0oqCRWW2h5cN4vS8aRTovEkKHgvpB1rmIDK4sZ8MunlZ2OAeUHoPDqs4FACyRlamgaRpTCIZ5k61X/seZJvSZxao8GLo0RmTBzolsXsskNUPUop5hnPwA6GcuQ8YP10czyP78zEzc1duWM4w2AYfFY4A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6486002)(6666004)(6506007)(83380400001)(86362001)(38100700002)(36756003)(107886003)(2616005)(26005)(44832011)(2906002)(2013699003)(8936002)(8676002)(4326008)(41300700001)(66556008)(66946007)(6916009)(316002)(66476007)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UwHxpe/H/v3usol2aiYgHnnqkXsfaShokxXg1ZVylEX3rL65pf9WSE4Wh4y1?=
 =?us-ascii?Q?CNWPV1DyS90mCq6mV28PULvhXPi7w+dMUVi5hNjtEDG05TQVCkJYodbx4ksW?=
 =?us-ascii?Q?13lkX2rlcBHI5g/uK1tQqP4o/VhH7hDWoA4ghOpJXNX7t+IOmRvfuKsq+8r8?=
 =?us-ascii?Q?n4oDmPYuTnAMEYme7QtQsOd31BKJXE/cbH+S+8Z39vdWgru3ga8WOLXXNODU?=
 =?us-ascii?Q?Jb6yD/AidbOY/Pmzc/hWnQAPkoM7p78XstAxcumV0KFnLUtWg+Rod8l6/BKn?=
 =?us-ascii?Q?LG6q/jlEsOfyI8oKT8JGLrhcSutqYH22gftMEn8Gb/TUznd0wcW58gXvHJcB?=
 =?us-ascii?Q?1y2teXyMZmnGh9irlfPkEULj4YZpshHxA0oOH1gqN7giFpBwXcsULEWUHscV?=
 =?us-ascii?Q?V9iNDoD6Sm+1ZyCrBQTsSmrvJJ2GMoyY1j7Uf7QazkmdDYvMvl1tin1Sl3hE?=
 =?us-ascii?Q?tRU03KWXS9Wp76gMMmASMj2ONZm3mpOvO3scahOtHtn2TOrOfLpBjelP9/eH?=
 =?us-ascii?Q?goU3d4i1wjUMy85R9ISpKIJVwmYmt4+yG/hfT59c064Dpa6ZuCQlX2AtBuna?=
 =?us-ascii?Q?2WyhwFvlUAoiuyFVxiqqogbYSCijkFq2I0heIz/93mMPDNkuLzx9VLjzqh+4?=
 =?us-ascii?Q?6XL2v7IoUtXXGJCzg/YlwkiDLZUBvzdG02018ZXeqqlAzN3/ZkTXBkUfzrAp?=
 =?us-ascii?Q?cswBy3B0X40EcWKlYQL/tKSouyY9iti99UkbcVxvFG+pGPZeKjLqgiPeFYbh?=
 =?us-ascii?Q?qiBQdDumso7QGYCRg4pCXgJfFP0Ouyf2o2EsgUHTUkmIsQlPoJ06M0msVO0D?=
 =?us-ascii?Q?0cxIPi6Gapk2/OyJUbDjC+XgnVU75JB/7UY+0/qHqtGWPY/FLq9CjdBVbZxY?=
 =?us-ascii?Q?1IFu1fHaxNIkNYO9B7vQyPasLoqEcCLv7ClQl2ZrNFfvAveT2wxRLwpwR+Ad?=
 =?us-ascii?Q?dBdmC9mg3OWjzJudkPkn5zCFObeIeaAQ07LITJDTvA92Zt/bCK4SCxEWM3Au?=
 =?us-ascii?Q?/aEtud3acagiQQW+lSQtVGq18x4XHytvWPkw1ZD9//mE5Rz445g8Azz5h5SH?=
 =?us-ascii?Q?8bmwozj03m0dBGnj+JMKRZUfqg6eR8KPyk7kCnaJ+jLfNn/sCjtE8foGJA2t?=
 =?us-ascii?Q?DVqaLqVoq+AJPrYjuOjZ3QwC7KJbgj9VWM++wloXhjDzA0YK0d288cc7Ynrw?=
 =?us-ascii?Q?NAoHjwtJeA/G8zRLhMdjaAz2FbHVRN73WIhI1Rb3Q+xUDWAU+dOCHI6z9Jgj?=
 =?us-ascii?Q?gAzr9pBeYdMsOnSmtcTgQ3ry2eGbanH1V5DekCBo1ellRVlrN9QzxHdPQaq8?=
 =?us-ascii?Q?N/qSQkEYfPLlAgYzlXzvpJb2ucDjy1CNUx9zcjHaMKIBTIE8ltDGQG6n2njz?=
 =?us-ascii?Q?ZA5lAZwOG31U6Yyp0Bt/ij3ZP8Pq6wRlFZYEElEA7u/1Er4gG7B8AGGuBfFT?=
 =?us-ascii?Q?9y6oRo8qcIl6OUEJL/DPZ9bs+6nmMaf4Y1OowII+dMVDoua1I1XS5rsaKLbv?=
 =?us-ascii?Q?1SMP/xJn0ELyHnxryPkGMIokwpWQQdCGx9zw23+QSb3Z18QgOtXPGZH/KfyC?=
 =?us-ascii?Q?gSBxNYFFnOrwaJBbQXHrdC/Z9n4o2+B7V0JJ1cbo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74655bc3-3af2-454e-f0c4-08dbbda3a17a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:44:29.2525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t37gnSeKvQebm5xA1XmbHoKAX86LDD1asB3fe7zRmfzzaoyzfh8u7LQfaGOOko9bLPvdNWtV3UyIL0IU6RGVMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8510

verify_listener_events() helper is defined both in mptcp_join.sh and
userspace_pm.sh, export it into mptcp_lib.sh and rename it with
mptcp_lib_ prefix. Use this new helper in both scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 59 ++-----------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 56 ++++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 41 ++-----------
 3 files changed, 64 insertions(+), 92 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8c708b92a942..e59867eed5c2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2803,59 +2803,6 @@ backup_tests()
 	fi
 }
 
-LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
-LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
-
-AF_INET=2
-AF_INET6=10
-
-verify_listener_events()
-{
-	local evt=$1
-	local e_type=$2
-	local e_family=$3
-	local e_saddr=$4
-	local e_sport=$5
-	local type
-	local family
-	local saddr
-	local sport
-	local name
-
-	if [ $e_type = $LISTENER_CREATED ]; then
-		name="LISTENER_CREATED"
-	elif [ $e_type = $LISTENER_CLOSED ]; then
-		name="LISTENER_CLOSED "
-	else
-		name="$e_type"
-	fi
-
-	print_check "$name $e_saddr:$e_sport"
-
-	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
-		print_skip "event not supported"
-		return
-	fi
-
-	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
-	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
-	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
-	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
-	else
-		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
-	fi
-
-	if [ $type ] && [ $type = $e_type ] &&
-	   [ $family ] && [ $family = $e_family ] &&
-	   [ $saddr ] && [ $saddr = $e_saddr ] &&
-	   [ $sport ] && [ $sport = $e_sport ]; then
-		print_ok
-		return 0
-	fi
-	fail_test "$e_type:$type $e_family:$family $e_saddr:$saddr $e_sport:$sport"
-}
-
 add_addr_ports_tests()
 {
 	# signal address with port
@@ -2891,8 +2838,10 @@ add_addr_ports_tests()
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
 
-		verify_listener_events $server_evts $LISTENER_CREATED $AF_INET 10.0.2.1 10100
-		verify_listener_events $server_evts $LISTENER_CLOSED $AF_INET 10.0.2.1 10100
+		mptcp_lib_verify_listener_events $server_evts $LISTENER_CREATED \
+			$AF_INET 10.0.2.1 10100
+		mptcp_lib_verify_listener_events $server_evts $LISTENER_CLOSED \
+			$AF_INET 10.0.2.1 10100
 		mptcp_lib_evts_kill
 	fi
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 899c21ced5a3..1301af71ad2c 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -9,6 +9,11 @@ readonly KSFT_SKIP=4
 readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
 
 SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
+LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
+LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
+
+AF_INET=2
+AF_INET6=10
 
 MPTCP_LIB_SUBTESTS=()
 
@@ -267,3 +272,54 @@ mptcp_lib_evts_kill() {
 mptcp_lib_evts_remove() {
 	rm -rf $server_evts $client_evts
 }
+
+mptcp_lib_verify_listener_events() {
+	local evt=$1
+	local e_type=$2
+	local e_family=$3
+	local e_saddr=$4
+	local e_sport=$5
+	local type
+	local family
+	local saddr
+	local sport
+	local name
+
+	if [ $e_type = $LISTENER_CREATED ]; then
+		name="LISTENER_CREATED"
+	elif [ $e_type = $LISTENER_CLOSED ]; then
+		name="LISTENER_CLOSED "
+	else
+		name="$e_type"
+	fi
+
+	if [ "$(basename "$0")" == "mptcp_join.sh" ]; then
+		printf "%-6s%-36s" " " "$name $e_saddr:$e_sport"
+	elif [ "$(basename "$0")" == "userspace_pm.sh" ]; then
+		printf "%-63s" "$name $e_saddr:$e_sport"
+	fi
+
+	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
+		mptcp_lib_print_warn "[skip] event not supported"
+		return
+	fi
+
+	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
+	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
+	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
+	if [ $family ] && [ $family = $AF_INET6 ]; then
+		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
+	else
+		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
+	fi
+
+	if [ $type ] && [ $type = $e_type ] &&
+	   [ $family ] && [ $family = $e_family ] &&
+	   [ $saddr ] && [ $saddr = $e_saddr ] &&
+	   [ $sport ] && [ $sport = $e_sport ]; then
+		mptcp_lib_print_ok "[ ok ]"
+		return 0
+	fi
+	mptcp_lib_print_err "[fail] $e_type:$type $e_family:$family \
+		$e_saddr:$saddr $e_sport:$sport"
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 84a77ee3b633..98189b3f73dc 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -26,11 +26,6 @@ fi
 ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
 REMOVED=7          # MPTCP_EVENT_REMOVED
 SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
-LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
-LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
-
-AF_INET=2
-AF_INET6=10
 
 file=""
 client4_pid=0
@@ -878,36 +873,6 @@ test_prio()
 	fi
 }
 
-verify_listener_events()
-{
-	local evt=$1
-	local e_type=$2
-	local e_family=$3
-	local e_saddr=$4
-	local e_sport=$5
-	local type
-	local family
-	local saddr
-	local sport
-
-	if [ $e_type = $LISTENER_CREATED ]; then
-		print_test "CREATE_LISTENER $e_saddr:$e_sport"
-	elif [ $e_type = $LISTENER_CLOSED ]; then
-		print_test "CLOSE_LISTENER $e_saddr:$e_sport"
-	fi
-
-	type=$(mptcp_lib_evts_get_info type $evt $e_type)
-	family=$(mptcp_lib_evts_get_info family $evt $e_type)
-	sport=$(mptcp_lib_evts_get_info sport $evt $e_type)
-	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(mptcp_lib_evts_get_info saddr6 $evt $e_type)
-	else
-		saddr=$(mptcp_lib_evts_get_info saddr4 $evt $e_type)
-	fi
-
-	check_expected "type" "family" "saddr" "sport"
-}
-
 test_listener()
 {
 	print_title "Listener tests"
@@ -927,7 +892,8 @@ test_listener()
 	local listener_pid=$!
 
 	sleep 0.5
-	verify_listener_events $client_evts $LISTENER_CREATED $AF_INET 10.0.2.2 $client4_port
+	mptcp_lib_verify_listener_events $client_evts $LISTENER_CREATED \
+		$AF_INET 10.0.2.2 $client4_port
 
 	# ADD_ADDR from client to server machine reusing the subflow port
 	ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id\
@@ -943,7 +909,8 @@ test_listener()
 	mptcp_lib_kill_wait $listener_pid
 
 	sleep 0.5
-	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
+	mptcp_lib_verify_listener_events $client_evts $LISTENER_CLOSED \
+		$AF_INET 10.0.2.2 $client4_port
 }
 
 print_title "Make connections"
-- 
2.35.3

