Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2073.outbound.protection.outlook.com [40.107.6.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ADB51035
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HJpZuGQj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+jV0huIcUAgI5KhsOt8wtqNKNFocI/qbH7AeIgJT/KI+cOwxTaNsSfpg0cELG/Ks9bsymMMy3f2uNleeOJjBq9Xeu6gArpySDE/8U+kGpn6N3ggC/tyZ4PdZio3XjPo/9VPhY863Cp1ZFzPwlzY1pz+d063E0L1dFVnI6vFPxnHwXw87xbvTpO07W/hGI7QsRiQNNJrSH6QKHT1umgTyh/JsFvmL/TdRo8bB6NyCz2wEQwgHy9ELkmi/OJl2PD7j18uCV0vWbDExhsZTC3ZEG2nd6NrVfmg6tOx4kfCquE6bmxmizC6/PoB8Zg1nInC227GF2WhQL2WZ4BJOrBocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPbFrkXrcB7ELReVEHyEEIziIOmLkrcv9jyYbHUsJGA=;
 b=UUzmddrrsnvAeXUulqx18mVTfP18cV0D1XxsOBKV2zz6ex45pEZ8oPiFkwJh6fkZ0EPq+CtbJ48NJttA/Yuvt1yfYC3ONnVpC5MkItADQQdQtZ9ReNV+Ch1MQefE8La8So9hinq+6KEIU+bppRhTfKFFmI9fKEk8Ec7DfcWP1jGZj7MHgpemvQQAYn7PguAoON46pAMQZXMzs3yrsN6NfQ7at4MU2oBAGFCRC1gJXS6TO4s5SsWOzoPM3YfmNcaKRzonq4pbn1elev7+p76xsao3hCJomslm7DxQR4lT5Lxbc+XBe7YH0npo6pbZ01IeYjEcjgFFvuDpvy8DYOlzoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPbFrkXrcB7ELReVEHyEEIziIOmLkrcv9jyYbHUsJGA=;
 b=HJpZuGQjeSmbmz2zNGo05+HQPNriUmT1cRp1QjcaQhW26W5OtDoS3jnY2Apc5yhgBjlaJcmNv2d+NeUHtV+2+NBtFHwENS7ap9qPPRieCIY20GL5McYTbV9nJLZB4fJoGdNuOkZiqWQ6VmbBk/tpIihxPh06893E+pfXaqQ6tvVHotmuj4W0LaF6hT5IGrMihg6dvi/zJmg2Nx+CGqPF11XINRlY1mIQOg7u9ChR0cGvm0P1NuBeMdm/Qvj3hLXt9xzBM+W9QY7BqbGVjFx+EkswMy6TLoDrSFz4H2YkcffNCiZyL79Kaoo1BQD9HAeseMC5gI4O6zY4GrMq5qeMvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8333.eurprd04.prod.outlook.com (2603:10a6:102:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:31:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:31:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 01/33] selftests: mptcp: add mptcp_lib_evts_* helpers
Date: Wed, 22 Nov 2023 19:30:49 +0800
Message-Id: <6e1422d85db5ddc8f8c0fd017629e36dd85acf3e.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0013.jpnprd01.prod.outlook.com (2603:1096:405::25)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: ec8f98ad-cf62-4f7a-ca82-08dbeb4e895d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VWtNxIs9DYAgsyJIBrdfEpI774BlWumn2CasIRwxTjDvZBdl4olUIb0QjQ/BY+9uGeadojAze6nngWlO7F59fSXhTJsn6kKovgq0mISADPpwM11M2f2LgQP2vovhYasymrUv9I+L3kAvC4Zy6Mp4p3RGybLBWsr4uZWqB3Uqa1ZdvNLL+apy0EA4OH4Gy2+4wa+JAiJ3JD8tZeU6AHZT+hd32Nv/CPKWUBQOlzQuP6DgoAir6VH6NCnASOhdznXhEehghK74bcxMbe7BIcbR71wXpdYbukfW+syWp/pkdvy/xh+4ZOI+vCml46QnS03tBZYOeiaJw5TKxEJFxXJZ504IGhTULB5eC2fvHfbqHLiSswkUtNkWljH6hza4d7C3MivjPaLlL33K1vO0saKTKlOjKcfGLzlXTWv7pgTD06MIesMOmH0fqW/cJJp40c73Yp04K8k6r6QLXXv1cqGJjYYMx04XqB8Bni6H851OmXicPJI3bZu2i1VFcm1/kOxJBy5MP+tKq93PoyL+k1vLjAbEBAZXtbAaw0jXljwvrffxdv7Nl/41IGCLTWrhPozy+rbyMTcz8cU4QRyVAFo8xuRADpr3zZrSY9aPU3z5Kd8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(2616005)(107886003)(26005)(6512007)(6666004)(316002)(6486002)(478600001)(83380400001)(66556008)(6916009)(66946007)(66476007)(44832011)(4326008)(8676002)(5660300002)(38100700002)(86362001)(8936002)(2906002)(41300700001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?te3luiXkZwLCZXNzb8S69j2q3YcaiHbSsbVH41SvVaXEDXlNDt+gF4ZT+5mP?=
 =?us-ascii?Q?ryudOGhatrVDXdPk4RNy48+066hdRfwPpzQ8+3QOx4AHnGURAGmYkAnzRHLM?=
 =?us-ascii?Q?MAfFmiK7xHL2XyYGAamkqccaa7NcjPiBBKGKgqwcFEHm3+5UegcrBDoFMKAY?=
 =?us-ascii?Q?Rair2KvZJIPAx2F95gLZ2qjE7bKosciiZruPI/KuzU3oxHNtQ3NHEu+Ppi6i?=
 =?us-ascii?Q?S2kXVQKLr8Ypdfl7YDCALNN3qD9xaMSS77xeyeW1Po28BEeMGQpAhG8AptY8?=
 =?us-ascii?Q?DeS74O4x78LTc0uvVd1tz3XFrozZmVt+HcMh/ErieGxVmBmgTmvfzTdve45t?=
 =?us-ascii?Q?POUxFmHQX27mShcKsvscBpLUvrf6VUQkgeA5TIiWzU73QszachZ6vj0aFriJ?=
 =?us-ascii?Q?d7EZ3nAtt9yMiTpXPueSo+jNXWenivJeHpkz5ZyiNCqM1753xGVunB/XtdUx?=
 =?us-ascii?Q?bbjOMv6fV1zmBsH8LKamUrJbcH2NoAVwMsTrpx0f0DcwgtelcA0eWM3pCQ2U?=
 =?us-ascii?Q?kEYvlD4sdBREkxoxkARJFaYTT5s6jxpFf2z+eYYqfxqg+xxHxFVUXnXYv9WD?=
 =?us-ascii?Q?r3mUPBIJ9H23KNJUSso5FUGbh6H2rE29wBhiy4u2OqjsslCCSRgXlqEJAXLI?=
 =?us-ascii?Q?PwucPkDEL6zS+GfYgHlL8uRLJXmpB/AH9S6i6dclC+09nzqwHxxZsuCLLJcI?=
 =?us-ascii?Q?6IZgu+8ZfuTPGz2s15YfidlyiF/n3EQqAZnwKlD3RfFmftR8Ctsn58BXNgsX?=
 =?us-ascii?Q?YUxIR45VzqVgeNDGkDxaoPNKwDdIrMvgtZdigJ7FDXzRH5ZgQEPAzyBCu5Dw?=
 =?us-ascii?Q?mWEFwdJ+YFfdEBNwJ1zIHdqTC2gfLfKYyNmu57HDBkgRfgfKVAkluEyLG6Gv?=
 =?us-ascii?Q?ksdexJ3gUQ52tTqun3mUsLsEy0+9/hl5L7uxwQNoUIRHSy8N1NNkedzcGFAh?=
 =?us-ascii?Q?GayGmhNB8PNEdw7PYb5hA8+QVPoFYDBHHJ3W53Bs4/htgv76Tl7zdA8kZ8yM?=
 =?us-ascii?Q?hsxzHRYgDXAfOx10LWv+w0GEko7axMN+Tpp/9i1VNzLTmK9Ajg5ZMUIQxKLE?=
 =?us-ascii?Q?Gp0x+I9dBNF2Mh8hGJRBUC85RHUzrx6YS4Hq87uSYYgIbtn+z/PfnGM/5mBM?=
 =?us-ascii?Q?sI/UfA/INrR1ehjaw2KW/ccAJ6o2ADjvcywoEkSQWxm8xfYsg5SwX6kVErs3?=
 =?us-ascii?Q?XCvTJPLC0VUR8BCmZ0KqEJmdBKPLcK5kYNjGKOOnp41uyob+i/3DdYdd+yhJ?=
 =?us-ascii?Q?kvAq8BqvF6izG/WX13qdPOP+jd5QtQF6l2Ph/ypz0Wa9KoM7fWG1Aycrq95P?=
 =?us-ascii?Q?rs1cv2HmKrPohOM3qaVKWXs6BITcKmMBkv4gsEAZk+NGJzK9ZaotQ23Dbtci?=
 =?us-ascii?Q?y2P2vzocveQ6oEJHT1wdYlnmqOYM2Fy8khF42lTdF7GfwasckYHz1BMH/C1C?=
 =?us-ascii?Q?MyOi0W0h9XKyUJJ0XQVbo3+FBuCbQm6hHT9KWz+HXx6iCKAWNYCrEK/pmruz?=
 =?us-ascii?Q?36+/S0JAczuw4KyGl+JDecON7kODNr7/B+4OFXLeK5+wiXRrp5e4sZCDOvSX?=
 =?us-ascii?Q?ZrBGRVipSqqLKpwFDv5kTsB5AMLCoCbnREcGfnnH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8f98ad-cf62-4f7a-ca82-08dbeb4e895d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:31:15.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFlwX2VYjKrDREpsm8xR61Dg12kuE0eEFXQXUe6laSHJ42LLsyhXE0fMLqE+3HXvFIIt6Ldmwx3IUwCJSLsKSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8333

To avoid duplicated code in different MPTCP selftests, we can add and
use helpers defined in mptcp_lib.sh.

This patch unifies "pm_nl_ctl events" related code in userspace_pm.sh
and mptcp_join.sh into four helpers: mptcp_lib_evts_init(), _start(),
_kill() and _remove(). Define them in mptcp_lib.sh and use these new
helpers in both scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 58 +++++++----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 63 +++++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 31 ++-------
 3 files changed, 90 insertions(+), 62 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 68cf11ad75e4..ae326fd5340a 100755
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
@@ -2884,9 +2868,9 @@ add_addr_ports_tests()
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
@@ -3259,10 +3243,10 @@ fail_tests()
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
@@ -3272,11 +3256,11 @@ userspace_pm_add_addr()
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
@@ -3287,10 +3271,10 @@ userspace_pm_rm_addr()
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
@@ -3303,13 +3287,13 @@ userspace_pm_add_sf()
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
@@ -3422,7 +3406,7 @@ userspace_tests()
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3444,7 +3428,7 @@ userspace_tests()
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3465,7 +3449,7 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3489,7 +3473,7 @@ userspace_tests()
 		chk_rst_nr 0 0 invert
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3515,7 +3499,7 @@ userspace_tests()
 		chk_rst_nr 0 0 invert
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3543,7 +3527,7 @@ userspace_tests()
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3571,7 +3555,7 @@ userspace_tests()
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 39bdfc6621d2..bb22dc17b0f0 100644
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

