Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99302199B1
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WtPSKMof"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWmBcOGKEXOyN+Ao442XiU3huAYnZzFVpY2gOSaxHyeNhclWUqQH492T35Y+ioOhKqE48FyaflIkroQu3F09HsclW6yVOv/OAW1khDO+HjY3CfiILqyaJcc/slaVv4M440U8gPZL/jI8f8Sera3ZayVXgxSKOLysep0yxoVOUd42pEP+JJr8TefvL18emfEjeDjt3pRiuPKyjagJbGxy2fvaskM2t6BIFhyWAh9BZF/sKGZh3TsnUYk3sHgEKQH2Yo49WvFyCF2P8Tc8WKTyPYUm+SnkjKle501z4uj21mrZmbzh5fj7QPWtZA7EXL0jjnoyW7B4IdMuZ08OwXSM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HM4RxoPJZwDGutbcG61F6Se288v8pVVi6psQOSacEc4=;
 b=CemIRCw/Y9MFI/ScMoqFfVLFKi/R+sGn9orSNnh121w2+xs6txRB4BmdZ15uPIumiBJmrJS5cFzFsQa0vz+ftFpTQhA3HSpG/LZkBqCR3iJZ3LZUtdPCvZMVI8mxkXydX3O9wOrCsQDP9zwLuMbALKGIrzZTwiLo9P17gCHJSs2nJbNP+uRA148dOAMhm/eUMdLz49ZrgGEdyCVqCRU3UBgL6v5tDyOfwuflZS5/O93blUcIBBnOKjpFP7r6eAdZbjS5g3BMHx9V52nU7kztQN30JoTIFm2hwOhDR88hFEyERrzB8iYwgxN03gb8XTg3l0VrdcQloYZarWJzYNPv/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HM4RxoPJZwDGutbcG61F6Se288v8pVVi6psQOSacEc4=;
 b=WtPSKMof55onb2ECCT5EcZiVxMVBIp3frZsosHwywnyqPCjtpnMKjadoVwml04iV62UDtKhDQnFTIE8WtTriadFBF04KBjvk3bNU/pOyvYqi75NBamarIubXWo/gasoVKYg8NUXtyeJUscARBjq7j7JwjEY/P76RbVQRTXd0KxBabzy70wk3Mm7r3DgyW6P87Z9scbqJtbFV5jS+6evb40XDjk1LsPjoBFXEE0n7HmpmJqZZvEmFwKEdwYznratKpJpmiooArwXkWf9ZtCvNyXmAv6qXVQHUjw+GmEft83ysvDzfkFkwTpvjtgPsZGi9l4M747ilR2nBtLRMlSTniw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 8 Nov
 2023 14:12:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 14:12:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 01/13] selftests: mptcp: add mptcp_lib_evts_* helpers
Date: Wed,  8 Nov 2023 22:11:42 +0800
Message-Id: <9d3ef16b3027c701f1d634565c8e3b6f6886d563.1699452144.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699452144.git.geliang.tang@suse.com>
References: <cover.1699452144.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0196.apcprd06.prod.outlook.com (2603:1096:4:1::28)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 2100d574-ca2b-48b5-e9ce-08dbe064b06e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hwePkQCja+VqWCmiDPIwjn49SbyPjXHtQC8HiMCMaqxNdsywlHiT28Fa8TReytTcGtnLl9n7uwbB2VE+8g64vf5u54s7JDeevgS80NvByBD3gguKEZfTTGpqrfzPofQNYMjReEyhzWp2yUORJ6KfL1TDA9iwgpal6hZdadSfEQRLdYN7lSuuQsILnt5X1uQyTa/Jcr+8aJjcCR3GF07MghpYJU4xPvrdKrswpZL331O3LkU/Zw8hb+XKpRApDyNWUnm+hjYLn3iURFLQHZFOtkPH0CvRGkcVpgMUv51r/yFO3HfBsNz6dMb1XGG0sjsbVDOmxBCNkzpBcapF84RAQ2rkfpx7sgCVqvzCNOH5Kkwtk0WlRtt/bNNBUi6dCRCvGcFviBTJCDX+BsB4DHk29DfOaUMFVBPexMG8x0IxVDx5ANNbxYXAyLmFL7zK4B0JSpsg19cQukuH5I2M0sDEeySaD5ZIfMsWdERYEHhU+ntVD1ydRbJWO5fMnSAGIBeDmbGjM0HH7aYaghh1wiO+fi192eJCrynGrKws7TeCAZ5ylAMz680GYIv1YdY6IxAb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(366004)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(478600001)(6512007)(107886003)(6666004)(6506007)(83380400001)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(6916009)(8936002)(8676002)(6486002)(316002)(66946007)(2616005)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6GOumpN3cQdK7X41xvcLTPeDhzkS+/9sb0sKCx9iHG9durAvHpdZha8MP/ra?=
 =?us-ascii?Q?3RR4LGkp36Dx9S1hgwYfnzHqtwh869E/7Yi5rUfimdNDyevsEBvuuAxuGAM2?=
 =?us-ascii?Q?LpW0VjN+5dIoS8RUDJacsFMbIIue0WgSxaXhGpZXXo2X0bFlJOoaR5f7tHYT?=
 =?us-ascii?Q?kUaspMEmTuIhPzwkc4nEog4eBsJqst9mM/ZGgT/7gMp8oqy7AVG+pTCRUGet?=
 =?us-ascii?Q?WDV2qpP3sHJhlFkN030JAygxCwud5wTP+aFu+kfb2pOjAb8JkuSAAB++AYV2?=
 =?us-ascii?Q?8liTSRpJOlTWZrrJ2CTs8ZzxDz/aphigquRIMSsYi/0y8qaUMFIcLNWhyaxq?=
 =?us-ascii?Q?TqYHssLAnrt3AOdXSvWcfQbbEYHKpM/jclMNrqI/D8T6ugc69zicOCKfWjTk?=
 =?us-ascii?Q?wHyUJ7MBEngQBZQzsEeftWT7EqYiX7yGbuQouPxEmfk8P2THDVIO3unF3IEP?=
 =?us-ascii?Q?ajPH4JigiQTgFy0IlMvxcdFWUb/infmgeykRZ3OZp2jEDXNvpS1M+J0KKb7W?=
 =?us-ascii?Q?jPOuDroCdgd+7cto6qaXX4RG78rBUym+WiK9RcfcFfGBGTRBzRy0na5jm3aP?=
 =?us-ascii?Q?y71J17OJI9rJsSqTkS2Q1YDrbInutwPP+zzxIbFflsTNR3DqZszHF8wX9UH7?=
 =?us-ascii?Q?a1+0P7rjjb6/adTZny/d6sCRTUJUAHjYGnYGciK4x7SiITMpxfFPHAOr5B+R?=
 =?us-ascii?Q?+9kCfW0QxhE6os7W7eWHK+wnNzXJX98Z6atCGWOlo+nFPfIIiIbihCTTN4F+?=
 =?us-ascii?Q?AxGYjkx+R8DzuUu4x98IZRGQqgLiVxDwx7LhKN12dQDJ0xzzF3A7gxv7TAyv?=
 =?us-ascii?Q?YuEujprlsIZiYP794gnMeL50PxgiPq5E18mzzA65jjhrbnup1L9S73XDiZLp?=
 =?us-ascii?Q?7kBDMeYX+KF6zG9D0qQFNepZuidIvw15yTHVqILvTlYFZm417lFAIm0v/1bq?=
 =?us-ascii?Q?uDBUYNH2PmpvWjN/3k447tb8IHC9RPXDVnCY6NNI0yH8/YAHpxtG4tPdkQNc?=
 =?us-ascii?Q?GguYGDaL7l1eF7VRzz25VqRbtl2OP64lGQzGMABryEvKBfa0zhLNoR8acnKa?=
 =?us-ascii?Q?hy2z1g3HdsovAJgqYD8T93jiYPHECIx3y24gGynbh0cDlmrGEbJQyIqqYZVC?=
 =?us-ascii?Q?e9xxrM8TUX5Hp2kYw/laqFB9hI9pbxrZz9erndtD487lfStgCfJ9BOVJ5VW8?=
 =?us-ascii?Q?WO7FYPyNf8M5gS070ZUqodJV4g3CBwTYe+SgPRmsQ0R9WeKzX0PQWMO2ymMO?=
 =?us-ascii?Q?lGCaH1etZs5vpcRkMzOotwtTat9XD2OEhGsI+GNbhA767n43DHtpIU1kC1i1?=
 =?us-ascii?Q?Pmsd7WoqMmiqXzaXrhG6F5ZGd6QXMqrmKB+W0TinNMIaXasRyY1fh+zKj9qV?=
 =?us-ascii?Q?znKBUk6VUssGawTdKWAW4hBmsIMkJm2Wb1Spfkdinra4oCYv2HLwlA57jYfw?=
 =?us-ascii?Q?wTzchveTs6wxyYeLChlJuSTOiydvhjKYH5jFIcunY2lFfZU8XiW7Ztndia1E?=
 =?us-ascii?Q?A3kR6QITnlbTmlcHaLweO5fdIeUirATEunzxxg6QNsHlCKQ1z742u6Hn9ENg?=
 =?us-ascii?Q?75XU/Whhh4lz5s79ztjCrqO7d9lQCYfHc1QtZMLj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2100d574-ca2b-48b5-e9ce-08dbe064b06e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 14:12:06.7296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbMb6QczoYG4WSwYSG2ENiLSoySVKeaRmF+umw8zjVUFIQ7gCKmOWZP8OPAt/R/i60aFMMIx5vZYT9hLlGHoEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

To avoid duplicated code in different MPTCP selftests, we can add and
use helpers defined in mptcp_lib.sh.

This patch unifies "pm_nl_ctl events" related code in userspace_pm.sh
and mptcp_join.sh into four helpers: mptcp_lib_evts_init, _start, _kill
and _remove. Define them in mptcp_lib.sh and use these new helpers in
both scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 54 ++++++----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 63 +++++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 31 ++-------
 3 files changed, 88 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 995280882428..ac7cee3f4dac 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -35,10 +35,6 @@ ip_mptcp=0
 check_invert=0
 validate_checksum=0
 init=0
-evts_ns1=""
-evts_ns2=""
-evts_ns1_pid=0
-evts_ns2_pid=0
 last_test_failed=0
 last_test_skipped=0
 last_test_ignored=1
@@ -182,8 +178,7 @@ init() {
 	cin=$(mktemp)
 	cinsent=$(mktemp)
 	cout=$(mktemp)
-	evts_ns1=$(mktemp)
-	evts_ns2=$(mktemp)
+	mptcp_lib_evts_init
 
 	trap cleanup EXIT
 
@@ -196,7 +191,7 @@ cleanup()
 	rm -f "$cin" "$cout" "$sinfail"
 	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
 	rm -f "$tmpfile"
-	rm -rf $evts_ns1 $evts_ns2
+	mptcp_lib_evts_remove
 	cleanup_partial
 }
 
@@ -460,12 +455,7 @@ reset_with_events()
 {
 	reset "${1}" || return 1
 
-	:> "$evts_ns1"
-	:> "$evts_ns2"
-	ip netns exec $ns1 ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
-	evts_ns1_pid=$!
-	ip netns exec $ns2 ./pm_nl_ctl events >> "$evts_ns2" 2>&1 &
-	evts_ns2_pid=$!
+	mptcp_lib_evts_start "${ns1}" "${ns2}"
 }
 
 reset_with_tcp_filter()
@@ -635,12 +625,6 @@ wait_mpj()
 	done
 }
 
-kill_events_pids()
-{
-	mptcp_lib_kill_wait $evts_ns1_pid
-	mptcp_lib_kill_wait $evts_ns2_pid
-}
-
 kill_tests_wait()
 {
 	#shellcheck disable=SC2046
@@ -2882,9 +2866,9 @@ add_addr_ports_tests()
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
 
-		verify_listener_events $evts_ns1 $LISTENER_CREATED $AF_INET 10.0.2.1 10100
-		verify_listener_events $evts_ns1 $LISTENER_CLOSED $AF_INET 10.0.2.1 10100
-		kill_events_pids
+		verify_listener_events $server_evts $LISTENER_CREATED $AF_INET 10.0.2.1 10100
+		verify_listener_events $server_evts $LISTENER_CLOSED $AF_INET 10.0.2.1 10100
+		mptcp_lib_evts_kill
 	fi
 
 	# subflow and signal with port, remove
@@ -3257,10 +3241,10 @@ fail_tests()
 # $1: ns ; $2: addr ; $3: id
 userspace_pm_add_addr()
 {
-	local evts=$evts_ns1
+	local evts=$server_evts
 	local tk
 
-	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	[ "$1" == "$ns2" ] && evts=$client_evts
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 
 	ip netns exec $1 ./pm_nl_ctl ann $2 token $tk id $3
@@ -3270,11 +3254,11 @@ userspace_pm_add_addr()
 # $1: ns ; $2: id
 userspace_pm_rm_addr()
 {
-	local evts=$evts_ns1
+	local evts=$server_evts
 	local tk
 	local cnt
 
-	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	[ "$1" == "$ns2" ] && evts=$client_evts
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 
 	cnt=$(rm_addr_count ${1})
@@ -3285,10 +3269,10 @@ userspace_pm_rm_addr()
 # $1: ns ; $2: addr ; $3: id
 userspace_pm_add_sf()
 {
-	local evts=$evts_ns1
+	local evts=$server_evts
 	local tk da dp
 
-	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	[ "$1" == "$ns2" ] && evts=$client_evts
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 	da=$(mptcp_lib_evts_get_info daddr4 "$evts")
 	dp=$(mptcp_lib_evts_get_info dport "$evts")
@@ -3301,13 +3285,13 @@ userspace_pm_add_sf()
 # $1: ns ; $2: addr $3: event type
 userspace_pm_rm_sf()
 {
-	local evts=$evts_ns1
+	local evts=$server_evts
 	local t=${3:-1}
 	local ip=4
 	local tk da dp sp
 	local cnt
 
-	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	[ "$1" == "$ns2" ] && evts=$client_evts
 	if mptcp_lib_is_v6 $2; then ip=6; fi
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
@@ -3415,7 +3399,7 @@ userspace_tests()
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3437,7 +3421,7 @@ userspace_tests()
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3456,7 +3440,7 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3480,7 +3464,7 @@ userspace_tests()
 		chk_rst_nr 0 0 invert
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3506,7 +3490,7 @@ userspace_tests()
 		chk_rst_nr 0 0 invert
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 1f8be9dd0e20..980ef3dbb6ab 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -299,3 +299,66 @@ mptcp_lib_wait_local_port_listen() {
 		sleep 0.1
 	done
 }
+
+server_evts=""
+client_evts=""
+server_evts_pid=0
+client_evts_pid=0
+
+# server_evts(_pid) and client_evts(_pid) are needed
+# by mptcp_lib_evts_init, _start, _kill and _remove.
+mptcp_lib_evts_init() {
+	: "${server_evts?}"
+	: "${client_evts?}"
+
+	if [ -z "${server_evts}" ]; then
+		server_evts=$(mktemp)
+	fi
+	if [ -z "${client_evts}" ]; then
+		client_evts=$(mktemp)
+	fi
+}
+
+# $1 ns1, $2 ns2
+mptcp_lib_evts_start() {
+	: "${server_evts:?}"
+	: "${client_evts:?}"
+	: "${server_evts_pid:?}"
+	: "${client_evts_pid:?}"
+
+	local ns_1="${1}"
+	local ns_2="${2}"
+
+	:>"$server_evts"
+	:>"$client_evts"
+
+	if [ "${server_evts_pid}" -ne 0 ]; then
+		mptcp_lib_kill_wait "${server_evts_pid}"
+	fi
+	ip netns exec "${ns_1}" ./pm_nl_ctl events >> "${server_evts}" 2>&1 &
+	server_evts_pid=$!
+
+	if [ "${client_evts_pid}" -ne 0 ]; then
+		mptcp_lib_kill_wait "${client_evts_pid}"
+	fi
+	ip netns exec "${ns_2}" ./pm_nl_ctl events >> "${client_evts}" 2>&1 &
+	client_evts_pid=$!
+}
+
+mptcp_lib_evts_kill() {
+	: "${server_evts_pid:?}"
+	: "${client_evts_pid:?}"
+
+	mptcp_lib_kill_wait "${server_evts_pid}"
+	mptcp_lib_kill_wait "${client_evts_pid}"
+
+	server_evts_pid=0
+	client_evts_pid=0
+}
+
+mptcp_lib_evts_remove() {
+	: "${server_evts:?}"
+	: "${client_evts:?}"
+
+	rm -rf "${server_evts}" "${client_evts}"
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 6167837f48e1..f1dbd97c0c96 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -34,10 +34,6 @@ AF_INET=2
 AF_INET6=10
 
 file=""
-server_evts=""
-client_evts=""
-server_evts_pid=0
-client_evts_pid=0
 client4_pid=0
 server4_pid=0
 client6_pid=0
@@ -116,18 +112,19 @@ cleanup()
 
 	# Terminate the MPTCP connection and related processes
 	local pid
-	for pid in $client4_pid $server4_pid $client6_pid $server6_pid\
-		   $server_evts_pid $client_evts_pid
+	for pid in $client4_pid $server4_pid $client6_pid $server6_pid
 	do
 		mptcp_lib_kill_wait $pid
 	done
+	mptcp_lib_evts_kill
 
 	local netns
 	for netns in "$ns1" "$ns2" ;do
 		ip netns del "$netns"
 	done
 
-	rm -rf $file $client_evts $server_evts
+	rm -rf $file
+	mptcp_lib_evts_remove
 
 	_printf "Done\n"
 }
@@ -186,24 +183,8 @@ make_connection()
 
 	# Capture netlink events over the two network namespaces running
 	# the MPTCP client and server
-	if [ -z "$client_evts" ]; then
-		client_evts=$(mktemp)
-	fi
-	:>"$client_evts"
-	if [ $client_evts_pid -ne 0 ]; then
-		mptcp_lib_kill_wait $client_evts_pid
-	fi
-	ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1 &
-	client_evts_pid=$!
-	if [ -z "$server_evts" ]; then
-		server_evts=$(mktemp)
-	fi
-	:>"$server_evts"
-	if [ $server_evts_pid -ne 0 ]; then
-		mptcp_lib_kill_wait $server_evts_pid
-	fi
-	ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1 &
-	server_evts_pid=$!
+	mptcp_lib_evts_init
+	mptcp_lib_evts_start "${ns1}" "${ns2}"
 	sleep 0.5
 
 	# Run the server
-- 
2.35.3

