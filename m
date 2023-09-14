Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2080.outbound.protection.outlook.com [40.107.14.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B1428E11
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 14:50:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDZ6TSm99QYCYPxFFIFv1ZlC7Vqk5lzGqFtLrd02G0dKIvyy017GbEnVby/fgETtozUeQgvhlYjd/SipOIYPSgsnOqJGkALryxFsivDPBiK0fqYim8t6zdfIDm1uLvOCKVrDTWD1dq15hpW450FHus2iuZHLD76W2GNq1SO6Y/wYRqHa2O+RxudTNnPCnFKrvVIti95Ql62NLQWCZAaPqXXuyKKVVI79L34xfnGok2Nm6z0PzpoSaYA0LvJO5S60Lo7ZtolCE/hEMSO7APbuK31WVjU1H2WdeUoaHgzWcrNT590UH4LGaXsAZXmWSmQW4nHFmMB35DXnkq6IknP2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GE78aZJ3v6xlnhLBrQKgprjSocMooXv8XYlKh+VFWac=;
 b=ehoLVgBU8HR7zavfM/3T1TyMruVLirGTgUR8aLz5o/SsbxCk55NwuxCXUP8HySLPU8hRphPsNLqVm3kiVA+R6++bZdefZG/5inZdR9w77psFljF8X7OxuQDYNawHk3QjXeI/U39GSNoiuswcQZQvfbzzblY8i/B80du510mfCL1hW3wmwRYfQRjcHP28LGPIrlnKltDPy+Db3X8POP3rm8UGeFZKhte5wSn44inZ3WFqm7gJUYQP7hrN80KJlWf9pQ6huB2FmVydHTR2N5xT5uATDGNTJxTlHqMwW2l8K0tP+SieADVFL65RDrBkG98mBeKyS7nWCgrkCpNC4yKX6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GE78aZJ3v6xlnhLBrQKgprjSocMooXv8XYlKh+VFWac=;
 b=WGzYMGk0lLpober916NGjTeXJFRW9PxHk1+50xs2BO4ONkfVgLJi0VigTr1XCpgQdetfRn0p0T62VctkwX7ru/6t2sw/E23npG2vKj4ljnqBNeNgyZoG0kfhONAGsdS3yHpYk6uD7STnqsJU7kU1X2afFT4QFst1NrEqBHfY+owwLwLgY9dr279c6MxK8pEbD+N9ghRJ9ab8MoovyvP5lUtF6zIlLZSAGdkFninipzZVFX/f6tAmthovQXm2xQW9XbO1zXYamioacw0jYHS1P70At5MLXY8a7hNeOTdQpViq2s1d3EO/kUQ/XkXCU6CUcE5Tk0aYVw/4BqKC0WUStg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB8019.eurprd04.prod.outlook.com (2603:10a6:20b:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 14:50:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 14:50:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 2/9] selftests: mptcp: update userspace pm test helpers
Date: Thu, 14 Sep 2023 22:50:17 +0800
Message-Id: <2d30fb2c3f49063beac6c802ec2401dfafbeb34c.1694702984.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694702984.git.geliang.tang@suse.com>
References: <cover.1694702984.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 718815f4-7442-49c5-bf26-08dbb531dffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KvlAZ3X2ExB2v8dj+Wc6+CcFJYcBUdslgOWL3yQfEf2v62W3W4anrm7XGuSa79wAX1nKYiEvtKou+x1fNsGuQD+lPUkVCQ1BijljcqTXkjklH+LVu+naN5lK9VM+MnGE9ck4jESlKQJA7+ppuiBHXgV7RZ/F9Ik/B5HdTgXX830i+DJIBrSYZ9C/wpq4owhLvZGIrQcxZEH+oJq1XWJ8M1xOV75FkqR0LdHbKGY5KyP8JDrABTET3jjNoB49j1kk1+YLxqD22wWfEkOKZIGRj5WCBCHE7vxbt8I1BrSIHG6H4k8SdBVfSgn8GyWFqWqiji9QTEYxa9jrKev5jl+JtOlNXiBPxMQwVomNID7nc9NATMNA0bcdm8P5vDTgAtmTV96q1sttu8Ch+7+zXjUsHQxv/EJj/esHjr60JdQ5AvVh4ttPUJg/KZR7fsUCVRBwH7lRytLJxOlP5wV0E15Mloj0/xQEPbgIqaDGXULRWjx8HMbx7JMrmEH5CIfnjyHoJEiXyqPL5Fk0ApnyZXDS2VF2YtPHMSTONYnAZntzr4G7MdRNMUiVybwrJz95Qw6NHwhXRgIPaPgvClJLi3ZW6JUhYe+qduAkkIhKvoCx6Pw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(1800799009)(186009)(451199024)(41300700001)(8676002)(4326008)(8936002)(44832011)(316002)(6916009)(5660300002)(66946007)(66556008)(66476007)(2906002)(38100700002)(83380400001)(6512007)(2616005)(26005)(107886003)(86362001)(36756003)(478600001)(6506007)(6486002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xUvQiSlyTHrl/IQTlPvH5MyiCVWytFkcY7t0BRhGRluehdpnUGxJA42spTQA?=
 =?us-ascii?Q?T3h18MtxXPqWD53JulnJSLsNWLL785FMgrbm5u5pffO7FyOK26juofAeHaQo?=
 =?us-ascii?Q?P+9uMAjChufC0/DNgKUeVUm8IDhyLAEw86UTDlUROZ/J6vPhLSAcqZcZOSIb?=
 =?us-ascii?Q?zR5BAD5eEoRAqWCC3s/KdAkFEPgJg0fjO4uhlt8xhd5aEAiuh/75fNvj+SZ5?=
 =?us-ascii?Q?YRTg0tVDb8LJswEnD3SxJQl48ny2NnM/PC6SZzzSTBLPXqb3ecYBB5zUpAAm?=
 =?us-ascii?Q?95ARHiKiss4cHd+oRC43lTflYFoWh5XbVZJZJV4wR0vrOyodlg+7OM99xa7t?=
 =?us-ascii?Q?VIzhjIm8+fh9pY0EDNGOZ1Nayc5diqtnswVdIASH+C/Vgnv/TA5DWzPxN46i?=
 =?us-ascii?Q?hGgKKXuAYNyV2akfeIJk6Uiu6bN7rZBGUfVhz7rA0q37zbNSsBxq+4lYGJFF?=
 =?us-ascii?Q?J0MhVPbwzj5amy/hcqFzIP/8CDSzR152/ieLbFszqAmqhSavlGkCuUJtiglr?=
 =?us-ascii?Q?m5Np9n7Dw0S60HXoTEsM3AiLiVpVudI6vn4yjEX1XKp5TZ8BvyLuR3A2DbtH?=
 =?us-ascii?Q?LcZTb9w8UtYVM+c2+1UuqIIfn87HOp1PgXtloWkhLwOsOtlCO+PRYflMvDLt?=
 =?us-ascii?Q?+83IoxcK3ChHqbyR88gw3ghScEwF2EJNXzDXKeSrnkjMToOwDKIoO/LCjYf9?=
 =?us-ascii?Q?bM4Zvk/3w+DsyBtRpsS4z5Z4RbK2+HTY0/31QEgKLc9AJWAEUGX7xMWSjRtW?=
 =?us-ascii?Q?QiUxkUevlnUqrWHgaGk1OudJ1bKxZJ9INbs6yARD/RKTMFjcSF3BHd/Gng8T?=
 =?us-ascii?Q?rc1H21H3o0kwyBaEjD93k26qLx1MLDZc4GNebh89MWKVk1b9q1PGb54hSfEL?=
 =?us-ascii?Q?DemnGoJIE9eY9T7Yh22AFNXyZYxVoKVeJOcJuNiRjHwD8dx6NxtJ3tiuIBO0?=
 =?us-ascii?Q?8OV6k+OFCYWpia3cZQhEo5Dcty3qsVXA9lgsgXHvJkIPoIUfk6xqcis4fiss?=
 =?us-ascii?Q?0pcN/6YTLD5ZQw94E+F3EhdsHeuvPkq4Un2TKWV7ozgPA9xqPIJgp7jfjwSe?=
 =?us-ascii?Q?Os7fhHY+SNqfmDo3t7BQ08SnLYNa7/tWu1EwegtCVFvo2D2cxldDCS3IGSPJ?=
 =?us-ascii?Q?AnEFICp+hLJ+2rZcPyzIXSwyBuo7qhAenYk+B7aiTb0/sdJ8VJqyYF71wF8C?=
 =?us-ascii?Q?mAezmBFElvWHa0WlS/hxpL80QucMbw0dRyY4BX6iWk37BA8gSd6QNy1ihICn?=
 =?us-ascii?Q?fKsLP7kGnYGg5Rusx6RKLtsVsiCaQLQnKLTeGzZr5RhYNLrGZoyRuVYZ2IhZ?=
 =?us-ascii?Q?NRWEZODU+KACdBnNZX4NrlbUzZOa/JG1uhKGOyR3jZhdOhLnUSt6xV62zGih?=
 =?us-ascii?Q?nkhpTVHhO34YxRy+QZL9Mk0Uz4/H/x3Pps0YhVi8pv5re0gR9GyTfnrHxRE+?=
 =?us-ascii?Q?E9g28SAnCACp7mLYgYGidhso6G3U8nlBI1GDCevnRd68avoG56ZhgnjcPkw3?=
 =?us-ascii?Q?Jpp49gepOwV7QMZ6qXW3rO68Z+eJoQACOxLGPNO10+o47wYpP1thaUryHmyA?=
 =?us-ascii?Q?zv3XAqTzjkkzms6MfYp7z69ZdoZ3/FGp3Ai3504bGAItXD7nR6NL99eFy0tQ?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718815f4-7442-49c5-bf26-08dbb531dffe
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:50:02.4406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wu0e22lrPqpVq8U8c687Q35siuOziFtM0ftdufa+Z2R60aNw/34H41rHp10unSjecyGNlrWOylZ0I3qzdFUj8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8019

This patch adds a new argument namespace to userspace_pm_add_addr() and
userspace_pm_add_sf() to make these two helper more versatile.

Add two more versatile helpers for userspace pm remove subflow or address:
userspace_pm_rm_addr() and userspace_pm_rm_sf(). The original test helpers
userspace_pm_rm_sf_addr_ns1() and userspace_pm_rm_sf_addr_ns2() can be
replaced by these new helpers.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 89 +++++++++----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  2 +
 .../selftests/net/mptcp/userspace_pm.sh       |  1 -
 3 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 27517ba770bc..2ebe1692edeb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3252,69 +3252,66 @@ fail_tests()
 	fi
 }
 
+# $1: ns ; $2: addr ; $3: id
 userspace_pm_add_addr()
 {
-	local addr=$1
-	local id=$2
+	local evts=$evts_ns1
 	local tk
 
-	tk=$(grep "type:1," "$evts_ns1" |
-	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-	ip netns exec $ns1 ./pm_nl_ctl ann $addr token $tk id $id
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl ann $2 token $tk id $3
 	sleep 1
 }
 
-userspace_pm_rm_sf_addr_ns1()
+# $1: ns ; $2: id
+userspace_pm_rm_addr()
 {
-	local addr=$1
-	local id=$2
-	local tk sp da dp
-
-	tk=$(grep "type:1," "$evts_ns1" |
-	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-	sp=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	da=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
-	dp=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
-	ip netns exec $ns1 ./pm_nl_ctl rem token $tk id $id
-	ip netns exec $ns1 ./pm_nl_ctl dsf lip "::ffff:$addr" \
-				lport $sp rip $da rport $dp token $tk
-	wait_rm_addr $ns1 1
-	wait_rm_sf $ns1 1
+	local evts=$evts_ns1
+	local tk
+
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl rem token $tk id $2
+	wait_rm_addr $1 1
 }
 
+# $1: ns ; $2: addr ; $3: id
 userspace_pm_add_sf()
 {
-	local addr=$1
-	local id=$2
+	local evts=$evts_ns1
 	local tk da dp
 
-	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
-	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	ip netns exec $ns2 ./pm_nl_ctl csf lip $addr lid $id \
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+	da=$(mptcp_lib_evts_get_info daddr4 "$evts")
+	dp=$(mptcp_lib_evts_get_info dport "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl csf lip $2 lid $3 \
 				rip $da rport $dp token $tk
 	sleep 1
 }
 
-userspace_pm_rm_sf_addr_ns2()
+# $1: ns ; $2: addr $3: event type
+userspace_pm_rm_sf()
 {
-	local addr=$1
-	local id=$2
+	local evts=$evts_ns1
+	local t=${3:-1}
+	local ip=4
 	local tk da dp sp
 
-	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
-	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	sp=$(grep "type:10" "$evts_ns2" |
-	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	ip netns exec $ns2 ./pm_nl_ctl rem token $tk id $id
-	ip netns exec $ns2 ./pm_nl_ctl dsf lip $addr lport $sp \
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	if is_v6 $2; then ip=6; fi
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
+	dp=$(mptcp_lib_evts_get_info dport "$evts" $t)
+	sp=$(mptcp_lib_evts_get_info sport "$evts" $t)
+
+	ip netns exec $1 ./pm_nl_ctl dsf lip $2 lport $sp \
 				rip $da rport $dp token $tk
-	wait_rm_addr $ns2 1
-	wait_rm_sf $ns2 1
+	wait_rm_sf $1 1
 }
 
 userspace_tests()
@@ -3401,12 +3398,13 @@ userspace_tests()
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns1
-		userspace_pm_add_addr 10.0.2.1 10
+		userspace_pm_add_addr $ns1 10.0.2.1 10
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
+		userspace_pm_rm_addr $ns1 10
+		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
@@ -3422,10 +3420,11 @@ userspace_tests()
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns2
-		userspace_pm_add_sf 10.0.3.2 20
+		userspace_pm_add_sf $ns2 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
-		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
+		userspace_pm_rm_addr $ns2 20
+		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index def35395a254..bb95dd967eb3 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -8,6 +8,8 @@ readonly KSFT_SKIP=4
 # shellcheck disable=SC2155 # declare and assign separately
 readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
 
+SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
+
 MPTCP_LIB_SUBTESTS=()
 
 # only if supported (or forced) and not disabled, see no-color.org
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 2413059a42e5..283c62deb628 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -25,7 +25,6 @@ fi
 
 ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
 REMOVED=7          # MPTCP_EVENT_REMOVED
-SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
 SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
 LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
 LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
-- 
2.35.3

