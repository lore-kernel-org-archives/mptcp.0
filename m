Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D057472
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bQveEUc9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNW3I5og7xWJUjD8rupdm+YteCb7OcMY1g1s5knPOpieopXd8L6T+EDkNj3OmgE90Ep7PQ2xvH1diFBgXp9W2goRvJzoF3nfNNKK+wsphKJh4R0dXHwz581mnWh+bPYpb+M2YVGdc+rXR+JwgOJ261DSquaeeDdWYuGEq0hRLj3vHWCQhq7XymuLXraXWhfmia4d459ze06nTBu7Fpn/psjZRN4TuM9+tP+D4nkhwzrmoCAPvl81mWS/WoXWQrgqa1rQgUvk98HCfGsbChczyczuimSsLYlKMnCDukADMYv3oeCMiICoWmGAUysDWLr5lrWT6Y3YhBJu+bzqNCsg4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkJ49a0iZp3LtQHXisLKCovFR2zwiUNVIlNH5LoAgDk=;
 b=KI/HNULbqlH080yEvmBMwxe3MJICACLbNoOPWoY7zWWXr7eCZYxx+DUWs0NQgAzZHjuFZMbZLgoqK53bbaEWfMnWHjJ8nGFrthHXehHp5Cw1pHJRsIYLO1Jr5oPH8U/rReHzia26tmTf1lOu93ZXvMFdK6u8DjzZafJbIkGKMTU5XhCVv1X92rf+KkXlcNrZQEVPbSyrdIX4KzH2YmWQfpTV89jztJiPCq0gVu8zGE95g7VarCITT8+7O/9K9pZ9n7XHICj7YsGdqtbOJL4DDjNwMvCT3QM2ZSQGonKkh2mOCJqEUGMkaGGckuZrxM4CdRtlxUnJoo0ykiJP2a2S2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkJ49a0iZp3LtQHXisLKCovFR2zwiUNVIlNH5LoAgDk=;
 b=bQveEUc9uohb3mM8UJkVL0XIzJc9QQqO8x9cLYZI7D6taq6INOOThR7mReFTcsfhvWPw+Btx8QiwNJDr1seXkVR9NUURnwXnZ41w05eYZJCMaOid4To5Uf6+Pfur9hU0V0fvO5ivg4O2JAhhovC4ujAdaW04R/yr8Acu00wCBXUl958kCyPjUNWzmwLz5NQq5dU14rhdPxonUtcPfy8HUpWi8yYxt2jR+rbK1fdu7wZKa7c0sOUIXeO9AtcydiLEV4K4zIvdsrefrH/LATdcCWWTIl+tIZXMPbiMyrkGP99kYjDcUg7Epe60+A3SsWsOTnnQgtf5oDcXAttCg1MJPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7681.eurprd04.prod.outlook.com (2603:10a6:20b:286::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Sat, 4 Nov
 2023 08:37:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:37:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 09/12] selftests: mptcp: export event macros in mptcp_lib
Date: Sat,  4 Nov 2023 16:35:57 +0800
Message-Id: <7de3c39e9ca47cd44009bdd1faba32d8e5de324a.1699086300.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086300.git.geliang.tang@suse.com>
References: <cover.1699086300.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a0d1eb-f1d0-456b-2936-08dbdd115555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TWRy5uV1xOD+t7mNGtYCVdcMdrp+Pc0uMJnYxibsGfto8c1wmrQ/POmPP8Y2lXpx6vKe7bA05zO7RjFE6hyzn8BW/a7g6PD1Bl5vDoORrgJEEBN9vZXnrzdqbxdB5zVnXnfMfhTuKXNquYTLfQXwPN6MQ2m72PRnVAevu90JEInGxUmy6dOE0I35Y4Q+Pj4/lvzLYc+vkYJnaXv9iyArCLseIydaT24mYR0IJRlXlOGxPvQGb9ISXELY2Tv7UKcTZ+e1XLjtgV+lvln3zeiKVrFEjibhOkZ9+IgNpUTCiB0XntheTMyL8qvzTPkvdWXQSsdjXoZpPBrUcKfwAVnO/CiVixE2FVzR8w1OyuRGdUh1UA3UEsSHcFd5TJ6hqml1lD9RoMPEXR4BKQj5VtKFDOyQTm6jEmLB2A52TUZYlpYBYvXEzyY6zKAriehG7iY1Lr4ImBFz2pG5sixMsSgTt17XZMJU4d+vG+veT0j9uBWkFgupxJP7lFJ+4GOdqKpknSh4PEXPzBgX0V4lUSmJvT/mpT0C5WI+rJdT1wm88ngeGu14e86QGyw0NoIfJSrwhA0qOPiDjta5lm2OiS8T5ee9QGtbz308HpRPYzvm9fI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(36756003)(86362001)(2906002)(30864003)(6506007)(6512007)(6486002)(44832011)(478600001)(41300700001)(8676002)(8936002)(26005)(107886003)(83380400001)(2616005)(4326008)(66476007)(66946007)(66556008)(6916009)(38100700002)(316002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aJIhM8E82xggB6bWt0aytc/dSqjSTesJW6EXXr3D44jVgFvfnptYgvqj3yeR?=
 =?us-ascii?Q?1DCt6GPmv/K/CBeenl7dCzQgM3lKhhjA4K2FYXkEtUP2qDVPj8yhDqpIOeLe?=
 =?us-ascii?Q?VaZib0CYh56TP9MZO/FtMh/qM7wJRa61/WPPW79M0uxcgZzHgsXKrDtH5UVP?=
 =?us-ascii?Q?zNnmsDXRHhlOQO5A9nmf89elKfG4zPoSPneuGIyCIMVfzS425SJSt0gqqBP3?=
 =?us-ascii?Q?sw9Ug1OZfq0x4MMVE2GevEiZ9J8Pun+iFjXLNR/PzrJWb2xiZiwmPSjELSxg?=
 =?us-ascii?Q?FYSGzAiDUkiACAtE+ogLuExpXvkWQEeT58CsSkneILNm7/A10hJ7OhKenALH?=
 =?us-ascii?Q?vFU9rUDtnuUMxQL9SDgIk7gYYSThqXr4FL6cFWgO0uJpnVD9uqB4RZjNQDbz?=
 =?us-ascii?Q?XNKv3mzntHlrnEY6x0pbYQ9+gQESP6btzeEzJsbaVF1pqMbweUT0pdVCdjBQ?=
 =?us-ascii?Q?IKyBmdFHB70m8+KKgWW7VlGU7OQPicFHbtt52dOOs+02xCKu0PdSOGANwdMU?=
 =?us-ascii?Q?UpGj9CkHP7qs9uGRYOLZuOLiBB14zGAjATTKzoT1HEfUADSemtsIX5KyH3iC?=
 =?us-ascii?Q?OzZtoKqr8Y7KrOxOevMttaQlm88ww5EJ3RgZ/Gy7qvAAAfJ+0vKwY5R6F6Ce?=
 =?us-ascii?Q?Q+8pscqynAWRxJu+SzQWw4FM+KDP4Zn/wyogAhJiLqnzx4W/RsYe5SnmuyLB?=
 =?us-ascii?Q?9qEBOGT1RXMT4sElO4hPP3CGahyNAToEDTBJ3jzTjpPGTbMbL14bPytisVGT?=
 =?us-ascii?Q?nJgcIP1/dG6yeHxDxFls99C+fnLvnUT7y3GymapbARmuBHKNjUTudJ5EGjsp?=
 =?us-ascii?Q?cyKmiSBBKyshQUt+RyEFuxlAy10htpyxZXKOlE5ZcycTGPRnRUKa2liKtQgW?=
 =?us-ascii?Q?i8FOtWyrBzLdUR+pbZyfl2hj5cOSLsk1I8Q16ZwIgJxCeDcOEyBkiSOVt9LJ?=
 =?us-ascii?Q?MbCaEgJbL+d0RrFYVRKFGzQGAfrNuDQnxjT/epnsUYMYB0ItJnTpJzO8tkVm?=
 =?us-ascii?Q?qmHxvGcbXuqFBzPcF9JQi1YBzShbjPF7Frx8jJbZ+arnH1ONCP/6+LxK49bA?=
 =?us-ascii?Q?/IkDtyKg0rhPkYcaB4fF0CsMYL0o0TZbBMAWOqmn+6Jq1Ob8FeFcd69KFchL?=
 =?us-ascii?Q?FIrmHTOQNoiymf7NXVF3w1aKTizZeJq+nTce61dKgFQ23DE4Pl2ccv63x4Ni?=
 =?us-ascii?Q?7rzZ29NrOBCYbX1Vov0ae6PDI6Ad+qAr/r+QnpoMAExjq1WCv85St3c+wJ89?=
 =?us-ascii?Q?rHLQ6KqD/WeqbI+kgVeFv/Ftx/WIF6jn0zLdmUexwu/UVEc9OmoIUpi6PTro?=
 =?us-ascii?Q?a24+TpCpcy7FUohNYSOhv8Ap5K39/+EbP6AbT1sUJi23LvoF+CoD1vnXtsXj?=
 =?us-ascii?Q?dWfjCUTfIgU2Vw1mgWlSM4ltGyY5rw2gyUqJx8RYSocHlPEYkHUzIcXu21dV?=
 =?us-ascii?Q?7FUeo8P+a7pmMkkzaY/DmXshXNIq/wiwRGWStzJ1dQvr1lfmrA1ZpwdBL8db?=
 =?us-ascii?Q?Kqhp1nqWHoQ9AH29Cg8GF8v/wT7e+9KzrKrWSxe8QPwiTQwElDdzB/F07axX?=
 =?us-ascii?Q?uZN8hwMFoaHBMNdCNynEZE/pr9h4DmhQ9YMNS7lIZ+qeEQ9VXSib2YDW1Nsm?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a0d1eb-f1d0-456b-2936-08dbdd115555
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:37:52.1647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMwwgx1W5aI2g6fN0AWrhz76JR6Duq/e0517Tt+lMkbBiriqneDsfUY5vSfKxk+ie+fhr/1kiM7W9jw3c31ofg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7681

SUB_ESTABLISHED, LISTENER_CREATED, LISTENER_CLOSED AF_INET and AF_INET6
are defined in both mptcp_join.sh and userspace_pm.sh, export them into
mptcp_lib.sh. Add MPTCP_LIB_ prefix for the first three and add readonly
for the last two.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 23 +++----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  7 +++
 .../selftests/net/mptcp/userspace_pm.sh       | 60 +++++++++----------
 3 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9b614a214ea9..8f7112cb120e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2777,13 +2777,6 @@ backup_tests()
 	fi
 }
 
-SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
-LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
-LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
-
-AF_INET=2
-AF_INET6=10
-
 verify_listener_events()
 {
 	local evt=$1
@@ -2797,9 +2790,9 @@ verify_listener_events()
 	local sport
 	local name
 
-	if [ $e_type = $LISTENER_CREATED ]; then
+	if [ $e_type = $MPTCP_LIB_LISTENER_CREATED ]; then
 		name="LISTENER_CREATED"
-	elif [ $e_type = $LISTENER_CLOSED ]; then
+	elif [ $e_type = $MPTCP_LIB_LISTENER_CLOSED ]; then
 		name="LISTENER_CLOSED "
 	else
 		name="$e_type"
@@ -2866,8 +2859,10 @@ add_addr_ports_tests()
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
 
-		verify_listener_events $server_evts $LISTENER_CREATED $AF_INET 10.0.2.1 10100
-		verify_listener_events $server_evts $LISTENER_CLOSED $AF_INET 10.0.2.1 10100
+		verify_listener_events $server_evts $MPTCP_LIB_LISTENER_CREATED \
+				       $AF_INET 10.0.2.1 10100
+		verify_listener_events $server_evts $MPTCP_LIB_LISTENER_CLOSED \
+				       $AF_INET 10.0.2.1 10100
 		mptcp_lib_evts_kill
 	fi
 
@@ -3397,9 +3392,9 @@ userspace_tests()
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		if [ $((RANDOM%2)) -eq 0 ]; then
 			userspace_pm_rm_addr $ns1 10
-			userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+			userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_SUB_ESTABLISHED
 		else
-			userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+			userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_SUB_ESTABLISHED
 			userspace_pm_rm_addr $ns1 10
 		fi
 		chk_rm_nr 1 1 invert
@@ -3424,7 +3419,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		userspace_pm_rm_addr $ns2 20
-		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
+		userspace_pm_rm_sf $ns2 10.0.3.2 $MPTCP_LIB_SUB_ESTABLISHED
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 980ef3dbb6ab..ffd78187237b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -8,6 +8,13 @@ readonly KSFT_SKIP=4
 # shellcheck disable=SC2155 # declare and assign separately
 readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
 
+MPTCP_LIB_SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
+MPTCP_LIB_LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
+MPTCP_LIB_LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
+
+readonly AF_INET=2
+readonly AF_INET6=10
+
 MPTCP_LIB_SUBTESTS=()
 
 # only if supported (or forced) and not disabled, see no-color.org
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 27ddbd8cf03f..fb05d207fa44 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -25,13 +25,7 @@ fi
 
 ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
 REMOVED=7          # MPTCP_EVENT_REMOVED
-SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
 SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
-LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
-LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
-
-AF_INET=2
-AF_INET6=10
 
 file=""
 client4_pid=0
@@ -520,7 +514,7 @@ verify_subflow_events()
 
 	info="${e_saddr} (${e_from}) => ${e_daddr} (${e_to})"
 
-	if [ "$e_type" = "$SUB_ESTABLISHED" ]
+	if [ "$e_type" = "$MPTCP_LIB_SUB_ESTABLISHED" ]
 	then
 		if [ "$e_family" = "$AF_INET6" ]
 		then
@@ -577,14 +571,15 @@ test_subflows()
 	ip netns exec "$ns1" ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2\
 	   rport "$client4_port" token "$server4_token"
 	sleep 0.5
-	verify_subflow_events $server_evts $SUB_ESTABLISHED $server4_token $AF_INET "10.0.2.1" \
-			      "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "ns2"
+	verify_subflow_events $server_evts $MPTCP_LIB_SUB_ESTABLISHED $server4_token \
+			      $AF_INET "10.0.2.1" "10.0.2.2" "$client4_port" "23" \
+			      "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
 	local sport
-	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from server to client machine
 	:>"$server_evts"
@@ -615,14 +610,14 @@ test_subflows()
 	ip netns exec "$ns1" ./pm_nl_ctl csf lip dead:beef:2::1 lid 23 rip\
 	   dead:beef:2::2 rport "$client6_port" token "$server6_token"
 	sleep 0.5
-	verify_subflow_events "$server_evts" "$SUB_ESTABLISHED" "$server6_token" "$AF_INET6"\
-			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
-			      "$client_addr_id" "ns1" "ns2"
+	verify_subflow_events "$server_evts" "$MPTCP_LIB_SUB_ESTABLISHED" "$server6_token" \
+			      "$AF_INET6" "dead:beef:2::1" "dead:beef:2::2" "$client6_port" \
+			      "23" "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW6 from server to client machine
 	:>"$server_evts"
@@ -654,14 +649,14 @@ test_subflows()
 	ip netns exec "$ns1" ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2 rport\
 	   $new4_port token "$server4_token"
 	sleep 0.5
-	verify_subflow_events "$server_evts" "$SUB_ESTABLISHED" "$server4_token" "$AF_INET"\
-			      "10.0.2.1" "10.0.2.2" "$new4_port" "23"\
+	verify_subflow_events "$server_evts" "$MPTCP_LIB_SUB_ESTABLISHED" "$server4_token" \
+			      "$AF_INET" "10.0.2.1" "10.0.2.2" "$new4_port" "23" \
 			      "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from server to client machine
 	:>"$server_evts"
@@ -693,13 +688,13 @@ test_subflows()
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2.1 rport\
 	   $app4_port token "$client4_token"
 	sleep 0.5
-	verify_subflow_events $client_evts $SUB_ESTABLISHED $client4_token $AF_INET "10.0.2.2"\
-			      "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
+	verify_subflow_events $client_evts $MPTCP_LIB_SUB_ESTABLISHED $client4_token $AF_INET \
+			      "10.0.2.2" "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
@@ -730,7 +725,7 @@ test_subflows()
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip dead:beef:2::2 lid 23 rip\
 	   dead:beef:2::1 rport $app6_port token "$client6_token"
 	sleep 0.5
-	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client6_token"\
+	verify_subflow_events "$client_evts" "$MPTCP_LIB_SUB_ESTABLISHED" "$client6_token"\
 			      "$AF_INET6" "dead:beef:2::2"\
 			      "dead:beef:2::1" "$app6_port" "23"\
 			      "$server_addr_id" "ns2" "ns1"
@@ -738,7 +733,7 @@ test_subflows()
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW6 from client to server machine
 	:>"$client_evts"
@@ -769,13 +764,14 @@ test_subflows()
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2.1 rport\
 	   $new4_port token "$client4_token"
 	sleep 0.5
-	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client4_token" "$AF_INET"\
-			      "10.0.2.2" "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1"
+	verify_subflow_events "$client_evts" "$MPTCP_LIB_SUB_ESTABLISHED" "$client4_token" \
+			      "$AF_INET" "10.0.2.2" "10.0.2.1" "$new4_port" "23" \
+			      "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
@@ -814,14 +810,14 @@ test_subflows_v4_v6_mix()
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2.1 rport\
 	   $app6_port token "$client6_token"
 	sleep 0.5
-	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client6_token"\
+	verify_subflow_events "$client_evts" "$MPTCP_LIB_SUB_ESTABLISHED" "$client6_token"\
 			      "$AF_INET" "10.0.2.2" "10.0.2.1" "$app6_port" "23"\
 			      "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
@@ -881,9 +877,9 @@ verify_listener_events()
 	local saddr
 	local sport
 
-	if [ $e_type = $LISTENER_CREATED ]; then
+	if [ $e_type = $MPTCP_LIB_LISTENER_CREATED ]; then
 		print_test "CREATE_LISTENER $e_saddr:$e_sport"
-	elif [ $e_type = $LISTENER_CLOSED ]; then
+	elif [ $e_type = $MPTCP_LIB_LISTENER_CLOSED ]; then
 		print_test "CLOSE_LISTENER $e_saddr:$e_sport"
 	fi
 
@@ -918,7 +914,8 @@ test_listener()
 	local listener_pid=$!
 
 	sleep 0.5
-	verify_listener_events $client_evts $LISTENER_CREATED $AF_INET 10.0.2.2 $client4_port
+	verify_listener_events $client_evts $MPTCP_LIB_LISTENER_CREATED \
+			       $AF_INET 10.0.2.2 $client4_port
 
 	# ADD_ADDR from client to server machine reusing the subflow port
 	ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id\
@@ -934,7 +931,8 @@ test_listener()
 	mptcp_lib_kill_wait $listener_pid
 
 	sleep 0.5
-	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
+	verify_listener_events $client_evts $MPTCP_LIB_LISTENER_CLOSED \
+			       $AF_INET 10.0.2.2 $client4_port
 }
 
 print_title "Make connections"
-- 
2.35.3

