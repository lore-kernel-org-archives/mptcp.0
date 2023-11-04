Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B5196
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ewSNAQOU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0S1VWNN4+okdG75aWd4qNu6IdzfX9CZ0lQmgKPWw7V9u9N1xaNZWwcun4MKN3mVk3TIAWqesZTw1j3ZyW47FRlQ3T8/QJT3CPgr3qNZfJCy1U8lukXwl6FNTOAoNZbtWMTbHuf+xFQ9VdkydNXH3IvuSwP2PbDmBGQj7/01X67jw4NuStXbKAGYL855vBdx6sWp8ljg0Dm7wYM+8dk/ncuaYf5abaos6EVGVHGplQBW1Z7zgiogAzuUxdvRYJe+Cjittw3epvv0BR+lE+hwtk07PrP6s6QsY9auJcl6VG85TR0YQzy68ihPvy1RgvSt3ql+9yXbxGk1jCHbhH/7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88eY/+78rVr7NXV1ENYcTCoMPjajYB5HwYTRqHw5qKY=;
 b=Mjdo5/Fb22ElXFCNjju/miXxxC+kzdiADfutfRUoCS2Y5mEVTML5Z3CWx7b/XsznDWJdNIInEiBFxI0N/2/qpfudjgiCKYW9azWsiMRYz0QFaIU2QUWjsf5qqjbp9//2IKm6MFAvPfY6+9et2AwbdjaTuMo2jwMQE6FWpbKHOSOQ4Y4gEv/TSQX+1q3NQ+9XKXHaHHuKXm1yErP9MV++LuER3ZlKlMbAJUSj68IA5fuwee6eOJEEIpeHu857PkB6ybC/mS513yW0beHKn8ZJ6tX0LELGFili6UYx/KEr3rccoBftNSSeTTd6SLAyYiUVmNkjwXFn7f0ScbyMn7Q7kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88eY/+78rVr7NXV1ENYcTCoMPjajYB5HwYTRqHw5qKY=;
 b=ewSNAQOU2vVIbHJPaxgAK19HuE5+ZY9V1iWI0KBo6N2brrGR5yul+zQXqDKfDvCWiZIavmzjIJCG5QmzNbSKqq7z/xm8xZH91gcEeXXiDeey3tQtnkXFC3HuNTTyWAaPn0Wgj61hzHJv5JmDCHxrum+7Jo62Cbd17N0lXxnLHMSX/iHIZh/uXInOxIV0fS5LN2JfGQPmA8go4aAU8bdgdU9v9yvdnkV/xc0JUdJ9Z4fighjZhN1pF93yNjYl/JIy6XvWMHMzanpcLpLvsDgzqF7AU3W3xYYX8bxvZkB8HuL9ft1sxgrJh2PHaUqlZk4gK0QMlr+gKVqQOI+8HgI1NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:28:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:28:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 01/10] selftests: mptcp: add mptcp_lib_evts_*
Date: Sat,  4 Nov 2023 08:26:25 +0800
Message-Id: <0c96f271f857bfcbbcf63c495904c2ade4e5ea4b.1699057401.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057400.git.geliang.tang@suse.com>
References: <cover.1699057400.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 855c50ef-7b4f-421b-b9d8-08dbdcccec0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iWYnY5c6An7a4Bd2o3RMYPij/bKBPeN4mZvh+DSfnGD7u6XJjGNHliAkkiA0pOV4v8NkFMDGVMjT/+wP8oPI4Kak+EWugiGvM9EdhL9GvtMN/8Epev7vlkA3FFKKxhLWeZXiJ7UwgO5BpMyNvI/pEP/51hHJmou4DrGhAxN8Bki03lvbNWqkZaHLsEZbQKvVLFJmQsiEaYCwnoDmk4bHhNTCJthcRf94H5tucE6da8EqZaoT43FBnXVhk+842FV39NGwCz3fDBWxV0UpU/CdilMgA1CVAEP29ZHwQ7NjMoJvYi7ST39T6RtDZfxaU7DVpTthyEJpaQK9c6st71m6k/J/L96a6U1pJQH8DfZIDRr1ho93wYsVe2x+dE++55i+75uedU6FgHap9AGuMLhfezD4Qd08/vyHXyeHzEFrN2RGloUg2xF0pG93jnnDujnqJb7zUlLqnlcYzHxsaAx/gjER36liYBnctzYSXjKm0FXTD2KaF7ibq1RTxvp0PKtBnpZaVtV5imUzTpgO4fzVwgBS6Omox+nAqYYPjI3mPPVBl8OEc40kcuzRleD4X91DETnQhfIG/GKFgnhLU6GmKlMdBeNK6D9JVZ6YMQkNp8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(5660300002)(66476007)(66556008)(6916009)(8676002)(316002)(4326008)(2906002)(8936002)(66946007)(6666004)(478600001)(44832011)(6512007)(107886003)(41300700001)(26005)(2616005)(6506007)(83380400001)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g+irbrU/RFXG7qn9Bk+r+8ixG3lgl/6l/BXZ6AgmlvlxxGdMMytnoSsW76IU?=
 =?us-ascii?Q?Xnl51piDgGA3fyHXArWhDQVBF1y5SNdfidsTM1ymlzahvlIYuXJhGEw4wRTa?=
 =?us-ascii?Q?TWFna7pBqe2vE1q8Zq0a1jyB0/gJA9UK0EB/nqLEd4dfGbJ9sO83AejzxLTg?=
 =?us-ascii?Q?WpZxY+4tC7HrNnh+oJceeUPVit5BVlmuSS785NrjQwc8E83rezlpONXhBOY1?=
 =?us-ascii?Q?kv0JxyDPYm1FklsgiiQDKycIVjyVN0+rq50yrqYrPt+OKYdsekp5MH0iJWij?=
 =?us-ascii?Q?P7Lh35jKfB8TJdqGzHH1Bk/BsEyJem+3zlIeXT5A4Phl+35rhoLsCSmQeHB4?=
 =?us-ascii?Q?PxL1SRUMSQFRvhxRoz+tIU1BUh3bcHf8ol0pGs35qpeVNtF+X0SZVlzB/zKi?=
 =?us-ascii?Q?3v0mOy4lnDlvJfN/E6ZVz4MC1WaBiAifmezNazu7++pPOwTIKJCKm4rs/MoH?=
 =?us-ascii?Q?Vp64HUR6y6cXGuk54gecH0Ao+nXvy4tnsZPdYVjKy9sTxhUJR8i7GHvOL+Mu?=
 =?us-ascii?Q?JqxbFxRl2jQjUTfLH1zgmvTPKKdO3FQKgBGhSF55CpkTfMgCV9vMdPppbEXn?=
 =?us-ascii?Q?UtuXNRWQt0qukzLqQmEYjZude6JShKd6w98G+skoRJR2jdT2DKHxpCp3Dzd9?=
 =?us-ascii?Q?AjCVDlanHKC7H0THp4fLe3yEsc7FyBF4tMZ9tpeEFGpJyOmFFTgYmqNViPGv?=
 =?us-ascii?Q?Uu0SgtvOTHIdxAFnDLCxEAXMwBJtxaCDu5elWpvhg941EiifRtyQ9cnVtfNf?=
 =?us-ascii?Q?QV+WjCFBIEcwgE3vRlian/2i6+qhU1OTaMXWGYrCOh8WVEKaDXD8VtV0AHkL?=
 =?us-ascii?Q?UcRdvWprT119I21AlS3k/C7c2JulD34ruL9FaNOVASY53HE89ZeZTi2GZQ6D?=
 =?us-ascii?Q?TuAyKPlnCLlw9qWqwRC2ZdGaZewxGBIVeCxxAWUfkT2JTUb60nKb6KP7sf5l?=
 =?us-ascii?Q?rQwgzvBPc/0nQ3BpL5WEr3cCKgrBlUGXBr68ndc5ELaDm1I46dCU7edVRaKu?=
 =?us-ascii?Q?UAiKHcel2iiiG+XGAIazu9rx01HCg47vxVWf1mqZqJWVBgBMNcRxntpZ+xeE?=
 =?us-ascii?Q?qAfc/1kvJIPnQ37M663cX1bhpm9yq6wOEkOVfCQT/CNsWGVGrotmhO0/ndaZ?=
 =?us-ascii?Q?/TCqOpkqTwnYjBuh/46b2K0HOu0GKRiZrPCUlbjrmagSD2vQzQrKJ3hncqtb?=
 =?us-ascii?Q?pT38jJowfyAsMGAyJ7AXXhHmbZdsNfPhRIbfe7gqMbs6GcCuQv9dikqAqdGf?=
 =?us-ascii?Q?myLxukOi2HazgvNdD2oNNnjdM9T+coc56eapLOrqsEj5AY4azdDya2WyR/0S?=
 =?us-ascii?Q?it0P033VxlifhUv9wOAh2ubIZj3OsudHnxFtHPrbnYAovXt15Lhf3RhSazn9?=
 =?us-ascii?Q?LL+InJPl1Nj6XKj+P3HijtY+4Pi0g3dSGsiUDWeg+vVRDglMRldu81RTH5kZ?=
 =?us-ascii?Q?SQ+ex0cQZ0GWu6/p/w/rKGA1eRPcqSFXOb/yCc2yO8eQVUZyfBmqNE941asf?=
 =?us-ascii?Q?HOguF100yGADT4z2VmfD7LszU7pEOyPxqqbQYrIgQ+y5HX62iKeZDwTPHnVL?=
 =?us-ascii?Q?bSm+mVr7jze6FINz8M6dTDdwRPm7VL8VQQ4Dwl34ICdnAQ1scg/rWLnLKhl6?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855c50ef-7b4f-421b-b9d8-08dbdcccec0d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:28:09.7396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gg2R5RVAXg/KYmizCJiJuI1cn1VKPZT5Hh6RVOcu2PiZnBWeBpM2JQ2i5VsPo7AqarauzDePgO0kZe2ABS2mag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

To avoid duplicated code in different MPTCP selftests, we can add and
use helpers defined in mptcp_lib.sh.

This patch unifies "pm_nl_ctl events" related code in userspace_pm.sh
and mptcp_join.sh into four functions: _init, _start, _kill and _remove.
Define them in mptcp_lib.sh and use these new helper in both scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 54 ++++++----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 63 +++++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 31 ++-------
 3 files changed, 88 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b56e141547db..634b51e40435 100755
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
@@ -3416,7 +3400,7 @@ userspace_tests()
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3439,7 +3423,7 @@ userspace_tests()
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3461,7 +3445,7 @@ userspace_tests()
 		ip netns exec $ns2 ./pm_nl_ctl flush
 		ip netns exec $ns2 ./pm_nl_ctl dump
 		chk_rm_nr 0 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3485,7 +3469,7 @@ userspace_tests()
 		chk_rst_nr 0 0 invert
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3511,7 +3495,7 @@ userspace_tests()
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
index f9156f544ebf..bba42f165340 100755
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

