Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE43584FB
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="tY3Atvgq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G11MlQ/+oStcDfFX6/ahJpYGBxNUpX/HaTU3kdxx9/er60nshB520tBSAyj2MaX2j3GeleqzfvObBYD4FEhsgV9gtP+H3tDWHb18Yp8MU6e/uzSuROhOkcP7u/3ffCTcbJIuOV5hxU7Z3+QQX4PG5k9F5zMoWnuYavRWkabG3oxzvFdUEH/YqFRe9IjmSIuuhdRlaxnj3W3PfnUq0m2hchu//ppXQN0mYV+lMZaQF3PQTLYPE27dApRQCsqTmW3HObAVM3XkV51ZPCQF82C3nerXnUly7geciDvG8XhEIJOX9c3zSwt6CTPfYg3+Pn7I4zqf+05XUfJWCaDOZKvLcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdxkGwsXwu5i5ssV6HnoYRUJccqR3ApVuZ3iWlXG7Ak=;
 b=AWIUagfEyiOooe23f4g7ACHKa9Qv9yXhVec3h8pHvXc7YcXddmqxhv3olW7zeIfajndiKYxJzlmu19q7yGwiwM3HUMQIzvVBR1PfBRiPMfUWEJhKS93Swi6YIZRfkAaOapvvjSv57/yX3vcJ1KK23qDYRoTdZcQ9t5gE+9/j5sB2eMG9SxTbRiK4La1A2pvUN7ahtl/MMYZ4SC44rxDyVFUPPPx0vs3W8y1VdlW0ZTWKbvOIK5qzC+E5gcHsA4RbMPE+Es8gGneJNJRfqJ2rJe7vQlA9yXEouOoB8e9x/NjO2ljuKhMaglhzKhqBuPfXlu5cP0Lz2r2mb2rvVsAThg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdxkGwsXwu5i5ssV6HnoYRUJccqR3ApVuZ3iWlXG7Ak=;
 b=tY3Atvgqu7QPvGqm8RvJGTSZViOWWZI7ElG6OWiQzFSwqE2dLZn0TWY4zv2QvbUXTrESdhu4stbd1ttunOsVzRTeFlQALg46u1qJ0cdX0zL0wUjHfw4zfq989NfcS/bJDbPTh/LoUz9aPer09kyxO5P0aUaKEXIK6TvqJG+P5XZUpZYZf+Xo/W62zgg7MGmCjRW2JOLu9rJEuw9BXUIV4kIx1l5XPn7ud+TaAKj2k6aGeIegZHC2sdbdtczkmDcb/7P8jtNg2UgRR6vX2y2dsihvQT5pLIebczUXBreMgxesflplgZ8WqdHHK9AmDf0JwNLFg92wOAZk7EwBjFIyAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7045.eurprd04.prod.outlook.com (2603:10a6:20b:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:25:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:25:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 32/32] selftests: mptcp: rm subflow with v4/v4mapped addr
Date: Tue, 28 Nov 2023 22:22:25 +0800
Message-Id: <957643abf70bab8b5e0a79b7b93be7a32dc3e324.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f43ec5d-23d5-4ccb-7ced-08dbf01de29a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gfUIpwhnsMPQXyI8En0wjQWbvCBktGsTYmD8is6zs1PC/A5HBSGySvd3uUMJW7bdSdoeeLBlAAwoGsbwA/FOsrubi492FuL7IineOdphbAawb1HvX3Lxrb4MKSq/DS3xeCEy6Rr3IoioohkhJDu/K4lkXCp4TdsTh7jQ2sEVH4n6AfEqxs9tolPsIFHpq/LI/3QG6dwRDV3qmPOpJQ9dxAXEVfiOTgiTgiyyUoze5yyT23eRtpKYwoc48lreJtzenMHQ18GGrMoWN73W3i8V0Mz/T6xxXmYkdQJ/NgX/ZNtNbwnI+V+rWEONlBOm6qNCkXvP7WdJUVJ6uaiV/5xcXwH8GC9chga+aMq3mRdV0u53GdDe1oG2/L/vZpZSUGDfCMVZy551MSP7R3FLWqcR7nla5pW05aJA0L5bBeLNFS49rnmTzs/rn2p9BSMGr56bohklHDgntdfCnteMIu3lJTyEqk/1N+iEBS4MYzaOxOXdFdxtsN7K77SSOqNGg6e9mAGfpLh2U8tBBCzZXdfbEuWTJDB9gg6g52rptgDiALLhoVCHlXgWwY6M7pcphZTO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6916009)(66476007)(316002)(66946007)(4326008)(66556008)(8936002)(8676002)(478600001)(6486002)(36756003)(44832011)(86362001)(5660300002)(2906002)(38100700002)(26005)(107886003)(2616005)(6506007)(41300700001)(6666004)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HSx1LHiwFANBX66q9RKqUcIJqC+dve4Tef8DE93VE1eg8nrcyUafE/WxdgBI?=
 =?us-ascii?Q?9h3EHdEMO2dBCHSU21x3aW9ZUdkYpxFraNP5BBBEah5qP8CjXEmWiDsxws3b?=
 =?us-ascii?Q?/C+zzWOiBiJ2pmJORto1t+jCh6vz9nutKkcoEY666PvrpARpEIbWu3NLOfNj?=
 =?us-ascii?Q?fIMR4PyU037PGsKBC4A1Ll9P4vnd3Z8JpQHRmDlpHvBb7T/kQAXvPUN2g6eY?=
 =?us-ascii?Q?xiHdG0hem2+w7JcNmjk71vGyGidw6FmGRiXXmDx+tHTAMEwpVKlmgQ7vcuWO?=
 =?us-ascii?Q?Fve9LP8/gJZJEZQnfxifxXH0sXNXlt3jugHBxVkO+lEeEoxEcqZ8x/5bf/zj?=
 =?us-ascii?Q?P3PfKTeBBcBVgOH187A7x0Hz4jR2Fau1u23vBKToqDa0HF3MAU0RaJrBK1GW?=
 =?us-ascii?Q?va5Cw3CnkGs4ltvlom0NPWCQXxVAs5Ud4lamgZnjEfgTBAC+D+Gt8KyNcBq3?=
 =?us-ascii?Q?LDauXsZQ1UptoAyGq9Y8xmMm7/C1DiCXnW61ui46K5XwAuxh+DEarP7VLOI0?=
 =?us-ascii?Q?NjmzAu1pKdg3Ej+b8eQDuw9g91p5w/BQvSG8htXQCphtCYbyNFreoZGiVbC0?=
 =?us-ascii?Q?JEtxrh2v+ArNb1Z5wcu5vAwPp2Mpqs5Huv75xufyli2G3HCuqEbLmrq+vSxQ?=
 =?us-ascii?Q?SPRP5VYAAi+B2Yr13NcGfJS1yFNQINk6RqJRL5RELgZXg8IsJswql8/4S8Co?=
 =?us-ascii?Q?cLeF4D5BZiropsgFigBH5RM6b0uu6dMoUX6V1ifhWDFbwuEz8nwwGAJyEZUi?=
 =?us-ascii?Q?Owdpm6DmTSuXpyW2TUWc781eZL/PegIgirX1FlBOafSUVDNdOFd3KXSMCsKM?=
 =?us-ascii?Q?A/pabtql3EVAoQCKj5YJTD++FwGNffM7eObqKmr+gMHmDr6JePkdo4gdBlBH?=
 =?us-ascii?Q?XOsCm6fimFo6hepEVtykvUaCCHjYb0+sbk6vBcLeQXGAarOp31AQxrZLFp7r?=
 =?us-ascii?Q?xADA1vc3uxsJ8vC24TyyUHMUZkmlYwttDvymsyRTN5T2Kdatyi8Y7c372Kmi?=
 =?us-ascii?Q?ym9wDLmMu+oDvx3ODhgRToVgdYscgntNLiEm7+V96R2qbZRjsDddrirgyPqK?=
 =?us-ascii?Q?0uRIPWyJzVmF2VQMNoBZRXqnWS4JdQC3Kj6nWkKIxifvbg2njz0Gznod5Jgg?=
 =?us-ascii?Q?P5ZXP1+j1BeQ2VtBb43sv+py0ckPmpcWBi0cGytm9E/dG6fToxcYNaPjoELA?=
 =?us-ascii?Q?biQg7dbZxjwHuSQQbc6DxQYF2kIRmug6LceF/eR76HtlqC3x8PKNcZMH9xC2?=
 =?us-ascii?Q?P4QsCmf0fO6LoMOHr9leZvWAvvfyKwSJETsZjyjuebWwwdsnchIuro/FGmDa?=
 =?us-ascii?Q?X52mXl++eoGd3lw/pA7y3ZV3VIaIBSUJPGgtJ2JfGhdGxCNtCCHIc6SQmout?=
 =?us-ascii?Q?FJm9RMnvdhqzr8qvymt7CW5s7pOxk4+Ob73dqThgSH0nPyIU2TkH3O8hSkR8?=
 =?us-ascii?Q?IEQdJxAkkRP76ksGA7scxzQKRy0SljHE+kdHiE4Jwgak0gTJiPfcRbYB+w9E?=
 =?us-ascii?Q?5qqiYJXj2lZo+GElWZ4PtapMc1DW6eXMuMNdbUjsAeiTviS2wXuJDaUhRY7z?=
 =?us-ascii?Q?ED41rkIIiuBhifNrpOsDnZcCUTSX4sPWmrvAjo/p?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f43ec5d-23d5-4ccb-7ced-08dbf01de29a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:25:35.0684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDto1dUb4wFWCHNm9Y7KmD+3QQJKWLd6v/jZX3S25zMh/ChIsrygN0NLZCrTOLMCULaoTL2gEbGuwkIJMUNGOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7045

Now both a v4 address and a v4-mapped address are supported when
destroying a userspace pm subflow, this patch adds random tests for both
addresses.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ff8c852a9b45..048ac0084765 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3304,12 +3304,13 @@ userspace_pm_rm_sf()
 {
 	local evts=$evts_ns1
 	local t=${3:-1}
-	local ip=4
+	local ip
 	local tk da dp sp
 	local cnt
 
 	[ "$1" == "$ns2" ] && evts=$evts_ns2
-	if mptcp_lib_is_v6 $2; then ip=6; fi
+	[ -n "$(mptcp_lib_evts_get_info "saddr4" "$evts" $t)" ] && ip=4
+	[ -n "$(mptcp_lib_evts_get_info "saddr6" "$evts" $t)" ] && ip=6
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
 	dp=$(mptcp_lib_evts_get_info dport "$evts" $t)
@@ -3415,7 +3416,7 @@ userspace_tests()
 			userspace_pm_rm_addr $ns1 10
 			userspace_pm_rm_sf $ns1 ::ffff:10.0.2.1 $SUB_ESTABLISHED
 		else
-			userspace_pm_rm_sf $ns1 ::ffff:10.0.2.1 $SUB_ESTABLISHED
+			userspace_pm_rm_sf $ns1 10.0.2.1 $SUB_ESTABLISHED
 			userspace_pm_rm_addr $ns1 10
 		fi
 		chk_rm_nr 1 1 invert
-- 
2.35.3

