Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B3E18C1E
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Cfzo4boY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXeRir7m/GJpo26hpuongGKHLXh409ehIC+NeqsUUVPsyMxx9YI1Mv2bfKIzb4fTzBxtZCjHLxyakX6KlQ0zugphbf4RPSxYVrnf7I7R+/oV+B7bk9cBGfNU9WlqGyVjLyKEbNbmbzENKKSvXIbD2R9wWsnZjp+hWG41GnrRTCK8FAuQLDczIHsAXH0p5s1DPGHeqLuEUNo7AiPggI2pAS9Onb5eA7Ol1Af9BajFq/I6ryoCPv/2+XyGqWxi+I2bPHGRVM/eLffen8B5KWDmvUTwV+phP+JRvbYw5H7WsVTqxjbngYKjC3qdx8F+OK5uVuyC7lLGYOq3A4gEtYxP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZOiNOxf8gKs8PpVb5ZNltwtTx/my4/f6Ehn03Ca4Qk=;
 b=mEhEoUGGygEa2oTQH1UseikXw/S3WsY8BwZ45xxpw/N7LrnyKmAkqoLRen4fICacLjQ3pyReOU2iO2/TRHe4RUTlfqgxv7h/LppU7FIo82aRhlTtE1Q6K5ynh9lB01C7E1rWJTZzhchlCQjWXg0losLe9Q6MeFUdXu8PmjVXKHf57gp4mj8v1Y9MzLrXrhXbT6YpJ1VaECHCSddvW/w2Ucsy9cHGDoNLrj80AOz4eVcJOLP0IY5zAgPoPdHAO5DbfGy4auE2Qa3q421w6wt6+eJ5ioHH/F9dCaoPIdn/SuKV73PM0393YhQXMWppbGOd5rsGAWYYXowj56Pu7syFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZOiNOxf8gKs8PpVb5ZNltwtTx/my4/f6Ehn03Ca4Qk=;
 b=Cfzo4boYjEAtpYIJ+BSsoGbgBnsFVbqwkGV+a5pH176HAnVULc3JM6d9sNmk7Pk8RTXDh/cfRYJbB+ZQaOVFo8dYy12NXV+Lawu4c7HEfiZ2nTHC1LSACC6J7PZdQCsyLEAFV1BxrvK8rcodKJBssdk2IhoX/nDh6jhl8xCszx2xB5/fJiOwsmeelNbvnVWLmpSYYovnqdH5EIzfe1JqVefkc/YTtdCIlFSnJ7hYrhb1Cm58Mlm0FEYybLUzT02SIZ3ED5sS2/4P6zx6YdhQyTLM5yYRL/DdS5Gg8+o1Kln4QlJWhq9KE7a/905/u8Ed243JGw96H3AfKBLY304cCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:22:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:22:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 01/33] selftests: mptcp: add mptcp_lib_evts_* helpers
Date: Tue, 14 Nov 2023 18:21:31 +0800
Message-Id: <59f3177412c97eb5b0f881bb047b80dbed479bef.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0175.apcprd04.prod.outlook.com
 (2603:1096:4:14::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f0507e-3f87-45ff-50b7-08dbe4fb89f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H8aQEXiT9FnjOYp4vchpovqMWdeXTvSmt2+Nvnulon/UV97dxXPk+qPX1nIvXIb1DQqsrBfo0lIPieAfo5GOUb5wCZyLg8UA2vnvCYfsELi8+QBTlhZ31nifdLoaF/bxChdB+BpmEdoagPncaWGY1Q1y1/lbObPzlib2Mo0/E36FBxKdIMuL4ep1CJwpd0rv2atl0kIWFfQqtgeBfaGpljNu3F1Na2NU7G9Kmp5VXiM+wVQrKa+6aFQZrS59HR6lnZZKdC5wSCCmXSUZTls+aq+9kYipVS2N+5iGDK9ufusHJS95aH2/dIOnHRHoCro+wschamPWuXoeuSJ54nEepTcE9XBtcznw96Fc5i/4xsEE7b75aSHhMCgGpreNwoVW6phjSKAYdXE4Wbw9FpYm6eljDuQQYP0wA2M15+E+1tfOeLRvv4v8LAUqIGlQ4eRW8yCZSVo8zzxA7hdD2azhjyb0ziDK6a4SDwrZVTV880y6bL0fspKr82mwXc2uS5a68fFARgN8WGDBtzmw83QkRD+DgrTHvyY1PfzZ99RY4cE5jve60o6X1rTFTsc9eb9g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(44832011)(5660300002)(38100700002)(86362001)(41300700001)(2616005)(107886003)(6506007)(6666004)(6512007)(6486002)(478600001)(26005)(8676002)(8936002)(4326008)(83380400001)(66556008)(66476007)(6916009)(316002)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HTlylINPgR2lqWoCUlQOT2kv8WVlTiNjzFD17AleknWLBNNkRssOrw+4zgIB?=
 =?us-ascii?Q?l53SU8cvlUYW3b1MvLQgaJCMiBvRCPHPEPU6wVV9o3O5hE5WxGxkAuf+2z9l?=
 =?us-ascii?Q?RxzO1aMl9YqHudhTDlTAmcbQx/uflMzb2Tm7SaNqQ5Xe3NqHPC8h6P3S0UUo?=
 =?us-ascii?Q?v1Afv0oxn9wpZ8HMaTk6UFNEHuAP/g5fTHkuAsYmHhOAejSy7vXidVJRPHs4?=
 =?us-ascii?Q?inkX/ibNib4FHvKaXM4L6eOPMavHpttr82KH8EGatgNYi93DJNLt8l65Owt9?=
 =?us-ascii?Q?NCcKSKf+1NEaaR1hRZhP+O1PJt32uxVzyDoEqwi4EYRIyOh42uHBm6mcTwOq?=
 =?us-ascii?Q?p1Vll65MCvXRiTRBOzU/VwzmnKLLmPc6xPAcOdddCUrnsSBkZXoLWrhMy9kl?=
 =?us-ascii?Q?lOFNXX44QOVB22RJ9RS/uJ0fnbL+7WzsRgkMqBl9XXUbBCyFk1yiQfhCRLH8?=
 =?us-ascii?Q?10sSOGdLIJVBwTzNFwdrfi9rBeiG5SdFg81QE7zVbFVr+uKVZg0zXgU5JEuy?=
 =?us-ascii?Q?fYKRaCjB0MAyDzDosDcoKThP4ma8LNU2rfY9LErynZSE9BDL37Tbpl4hp4Qt?=
 =?us-ascii?Q?im8VYIJejllr1r2R8QluEJjVFs+6+rbBrP99Vt+GFs+ASCIZrj+cKTYRFkfV?=
 =?us-ascii?Q?P7JZXzSUTeRfP/xWh0UGOG+7EhN8dy4wtpCWeCjLlpYNCUfpWJRnV5p6DOZT?=
 =?us-ascii?Q?RKOG5nHkP76ZLnZmMGJPAMUPJ+zAu34hJqcFkWlxbnwUd0QD0+iDFucImHz6?=
 =?us-ascii?Q?xNn8CEnd/gYpKVT5NnJdjbYwM5HXHHEArULRP2EsnbFBQnKkv5dUW+XG0AWZ?=
 =?us-ascii?Q?Eon4ELM53ErYqWtCI4+tmzqXTuSZrG2ldTG3R3eapJ/YRN2V6STYWiyXdy09?=
 =?us-ascii?Q?PjrdJ8SvibBO3Ek/ghfJJBp/CNj81DDskwql5R3De6EwfMdC6J982IumV4Io?=
 =?us-ascii?Q?UhyMhUj/V1NMa+unL3HBail0CdHknrvg01OzDI1Es7D2fOFN1r51wW1/1Jb2?=
 =?us-ascii?Q?jKkZ3JtGJ7BSzH8kJJcITX3ecs59z90evA+YsbODrj6BWD6bndqxAY5bD2ex?=
 =?us-ascii?Q?u10yK8fXk6JCVJighJ8U33D4rDOS25OWQJqjYhB41nCdQQhCXc547D7bZL2L?=
 =?us-ascii?Q?xD2Y0Zd/83+giYoeJc3JwEQGKKZxbZriqZLb87NjltI+35JhW+38LISwjhCw?=
 =?us-ascii?Q?7jrnKZlW5RBL6HGEuLAPg3Qoe7RfHStjdpdOa1f0uvJeKYI5/I3umJHQGR3+?=
 =?us-ascii?Q?5WdS8+I2wIMQOtnBM6q4Ngp42TOxCvZA2pLMpbDjw0zd5jF2lJDB3tw2zJqr?=
 =?us-ascii?Q?enEQvH51qELr8Je11SK/ztH592yZekvnv+Txv1yV9O6oRZRZuKzxutUJlBeL?=
 =?us-ascii?Q?A9ktHa/yYfd2+K+A8uqfyix1NbXvN4nh1pYHDe1TlqoRzrb/S+92U2o06BOT?=
 =?us-ascii?Q?P3DxAyNI5INfdr2nNblS3HtmhO7J/MIjXV2f7DLVwbkAKctiTpmZymgQw8u8?=
 =?us-ascii?Q?qeQ1LiM4MAEDMx8ko/7C1pl39YeRe3cwxh0UVgws02BqXK8+biQO2iWBsnRU?=
 =?us-ascii?Q?MYKZEM3M/A8Cts0B2xDPtnvtCCl9pJs4KXogsf6u?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f0507e-3f87-45ff-50b7-08dbe4fb89f8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:22:00.8956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DaSbQjVQhpX4bhy4HZrk2On1GOOwC0o+o+yzqNwCLVrlYDzfuK/6SvJCqxMN2PjsnGtdzgY+XK2sNNb3Q0/6EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

To avoid duplicated code in different MPTCP selftests, we can add and
use helpers defined in mptcp_lib.sh.

This patch unifies "pm_nl_ctl events" related code in userspace_pm.sh
and mptcp_join.sh into four helpers: mptcp_lib_evts_init(), _start(),
_kill() and _remove(). Define them in mptcp_lib.sh and use these new
helpers in both scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 54 ++++++----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 63 +++++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 31 ++-------
 3 files changed, 88 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 24a55f7622f3..42f3e49db74e 100755
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
 	mptcp_lib_cleanup
 }
@@ -461,12 +456,7 @@ reset_with_events()
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
@@ -636,12 +626,6 @@ wait_mpj()
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
@@ -2883,9 +2867,9 @@ add_addr_ports_tests()
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
@@ -3258,10 +3242,10 @@ fail_tests()
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
@@ -3271,11 +3255,11 @@ userspace_pm_add_addr()
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
@@ -3286,10 +3270,10 @@ userspace_pm_rm_addr()
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
@@ -3302,13 +3286,13 @@ userspace_pm_add_sf()
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
@@ -3423,7 +3407,7 @@ userspace_tests()
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3447,7 +3431,7 @@ userspace_tests()
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3470,7 +3454,7 @@ userspace_tests()
 		mptcp_lib_check "ip netns exec $ns2 ./pm_nl_ctl dump" \
 				"" "      dump addrs"
 		chk_rm_nr 0 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3494,7 +3478,7 @@ userspace_tests()
 		chk_rst_nr 0 0 invert
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3520,7 +3504,7 @@ userspace_tests()
 		chk_rst_nr 0 0 invert
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 466fde97d3f4..4f741725436c 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -326,6 +326,69 @@ mptcp_lib_check()
 	fi
 }
 
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
+
 mptcp_lib_cleanup()
 {
 	echo "cleanup"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 005251b61d7a..55ed3ea0a691 100755
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
 
 	mptcp_lib_cleanup
 	_printf "Done\n"
@@ -187,24 +184,8 @@ make_connection()
 
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

