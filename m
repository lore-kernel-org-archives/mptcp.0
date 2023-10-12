Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCDA1D53E
	for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 08:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TZWAkfYl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuEFJzSVKz4D9SBCaoitemjGvdNxK2tVXCD/WtIGDDvgqT5fOERBfGSJ+GXgMSDyG8qQndRA4+S1PXd6Vz+zor6STmMvYDn33E0rgCKYok4Gi+ljlAjHTA85w1feslQ7JYtmjCMFeJ2qwtfdgbPH1xMLL16iC/+cEq/T1Rvua69LY0Jg5wips1w790h0l+xdo3WiPfizjuThcYgKCXTctD6lvzHGMT/pNaTbY6vxmMbRxcV37I/se3Xu9jmSzFwzlatEahxCoPT/QpwS1aCfQx1BHDOGaZTqet3XFXdy26YvcVHgKwIrBNWRPfNbQhQW5MZKyymAlAuQq5RuJ9w51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUEfaUpg3ds7kvR3nhG2UUQ/9pHx7Q3VN1a6vHRpTCc=;
 b=OXun0evRnlrreL/VD1w8/iklYi6t5T8DuAGIYs5cFABlmG3LdGsei6tj0o9JRS89MyKgKh60bUFqKg2VSMOl3d3n+7uxnh4QiygJaNDrNDOEUYZpV0HwTIpMrcjNxkWxhp6pDF1RRwKJdMtOeexD+yuaYH8KceAHpSm2cQJM59K6D1PilyVXaxFhsbRvozpT1DLBAuzrQLvfh5lRb8leLqQx9S1v2d4/U8+qIPcc7uwuEqlzhDpbgCsZ5Hxw3UvnCAL7Ztj/WcckRBnGlalYXcQuRcvYdhCVSI8nJyuiJLhGfj/9iPSxJAmMfiA4XZd5XSsjzQTAKXr8A3BEiSt/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUEfaUpg3ds7kvR3nhG2UUQ/9pHx7Q3VN1a6vHRpTCc=;
 b=TZWAkfYlWPMnuCEeSxpwCUCAqoOIPR9bIHG+gZfllE47ZxFv/gdTFkLi6/+KUbMLHqfn5jU4W1KUJa0Gr1uCVDmTlS4SMhEt93g1p8OPBq9BlDFLpwoIbf3q9WJAlpwwdUzaWbwYwsTFSb20vgUnAFgrafIpwU+goj/XT+NAhHgKdafkJ/oJrruT4ouSlu8DdPWU6RQEajmQaVH8au4//uFyBLUxtEnAIr/fF8o6SP/xbRmwrDKjH11XuZv9JyHOl9lKBzkfZsYc0YTap961KIQjBsQC9I4XX11te5unfVi9XgHxUya0nftx0ESk5Z+1bWbENN1oa9IvQSIYwFxQew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7923.eurprd04.prod.outlook.com (2603:10a6:20b:24b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 08:51:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 08:51:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 4/7] selftests: mptcp: userspace pm remove initial subflow
Date: Thu, 12 Oct 2023 16:52:02 +0800
Message-Id: <f13919cfd0f090a63d05a9b3d7e769416a2c27d1.1697100600.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697100600.git.geliang.tang@suse.com>
References: <cover.1697100600.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0025.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 30934833-dd65-4b40-dc0d-08dbcb007447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x595rdlCPvYrzbubBku6rpL5/5kRx2olMKPjsBo5r/U7sC2+qHvxMpvwP3O+YKGm2Ahf/tAIOcKJokaF51hJQc/m/KWFwfMSYfssgWep8srwA5Rl1XC8qEWt5lVeScx0T7lgPvQ7DlAYcBKNp68Cl/IxXWLCK9MjjRG80UQXst198/wfx/+YIIB1S/ol3tO+3YguWjCDSfM63WTxyIXKJQoWMHVAO4QPhGGATMY1hA6lsoeFCcmh9CBJx7KCAoSZ/vl+ulWb4W8UYWDAtD0xzBKikTLVcpOc9Jo2LgOGzAMfNCNntjBl7IXH5sCGr7yxvrW87ghiAbYsxrx49/loeneQWqJfNqVEHkSudJbyPFDkpAYfO8neq9hu9lXZmQqwRtqRBcMamw9V084J+iMzRphrVqQaXYPBqvCcAMyQ70IcsQqrBw6Eep24M0qEo3Y3vJ5Mq2XRgUxFX3qtpJgW6a8n/8FXqtl5mhBiYi/551EXwZ6+E1cMDkXMZBiI77vBgeAJ3kbY+2gEfOq4lX8Cxw5kFsIXYWkqAYfatTHUD/VF+1A3p6nURzbZCPzq4Pdf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(6512007)(107886003)(2616005)(478600001)(6486002)(44832011)(5660300002)(8936002)(8676002)(4326008)(86362001)(2906002)(6916009)(316002)(66476007)(36756003)(41300700001)(66556008)(66946007)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lv8LzVP47Serjx0ep54h1RcfaCgPHIH5GdmGylBHsxZdwLKKm3csWSDeBAO1?=
 =?us-ascii?Q?R9XJeoretgOl8CQPTZ+ysMM4fyysyf+nEOETsypDs5ueE6wOqyRsUTvUf/WU?=
 =?us-ascii?Q?5fk+XJ18tDhEwkFmOi0vEpt16DdD1eGQams5CXNO5ankg7oHIV8DqddmJvbe?=
 =?us-ascii?Q?VGW4uVbugx/y3+0+PoCmjJ9s3g6UERwk0+L5U0/t70GRhkF/xRW5qrj8WX/p?=
 =?us-ascii?Q?eO/OvGMuMR1WR0qYsm+Jcs0LztspqyW16x6PWV/XkGu9JOapaFiZlHL69M3w?=
 =?us-ascii?Q?AjKD4ChtcLUiLeVJwwglFXcp2jap+qo80qU1RQOpO2jlMnhPfQdB1so88cVO?=
 =?us-ascii?Q?rud1D4qCej88v3/42cbQSojKgezf2a4lgsneeDjojI9F2LpimHgyg0Isu6yT?=
 =?us-ascii?Q?OwQ6pIaicCHbBVyvjfMO5/oYt1b0XPmS/FrOJ5CdMvv+sZdNXuLhQ8efmG9K?=
 =?us-ascii?Q?egOcFmnmONE22eL4Bb186yGjoRzLr+CxU8eME7YKZZrshzOv2O9762Scpm7n?=
 =?us-ascii?Q?ZU5a4J9DHGYLdGTq1IdiCsJPJJOd40eccir0E3GzKyJHOqqP6eoLGZVptwrz?=
 =?us-ascii?Q?X4akF69r42TKZthMvi0r1evWXzYuMZwTu1Nwbr15Lew+LauoXGaxjzg2P4CY?=
 =?us-ascii?Q?7MbDMS5bTsk4eo+TOSqtjWSDSmotTaJMO6wXlCTrUOSqXCP/suuoGUtXk+Tt?=
 =?us-ascii?Q?S8zYVTV8LrhIVBOTy7ceTfQiDEfZdaXcqzHDxGfY76ruyq3PDnKsy9izhEnn?=
 =?us-ascii?Q?kEZI77bTPr8ZsnikR3FFQvs6gSLB1olrNBKxSumzVqhkF6lAsQ1V37Umc++o?=
 =?us-ascii?Q?ckiEs6Pj7jTVuRd4IoUlH9jHJA90IURlgElI2NmIw08Eyjk7jh9HVOxoceUq?=
 =?us-ascii?Q?GAUVz2TSN6CzAAsh+2xVWEy9rLh26AJFmHf61KrNMX/7GDD6WAh4tHbUWx37?=
 =?us-ascii?Q?wbS0MmkwySL/UWgKZ4hNgTomsLVMfGv3so7n6w5cGDq/h4MaEBNLGnCOWg4a?=
 =?us-ascii?Q?nqabWQKPtYNaM/VFlA1luXa+/y3+PkJOUUQ0gjLp741FOCOq97/VZyBlg/Fp?=
 =?us-ascii?Q?0RjPGLLRS0d7IiUXHXoYQZWc9OnTXSj5OdylmZ96BdhPgHaywuIgr+jaYtRY?=
 =?us-ascii?Q?3CoMNTUZNpZarAm8bFksOw8Cc35q984WGIGgSBH1msP2bIGtifnPpHngoC2k?=
 =?us-ascii?Q?oVTQBs19osJTnb8D/6pGphrsFuCBm6y57AdwDPFDRU6I+XtoAzbcxihK0Z+L?=
 =?us-ascii?Q?ao0aWE73kTf/mlUmGB8c5GDMPaveEMlw47K0A8V1VKWlQIlogc3s/8y8COCR?=
 =?us-ascii?Q?mjKR/ACNiYQfd3OWZjLvM7tks63paCpRzcfZw97J3iEORx0k11NbI/BxW/Q2?=
 =?us-ascii?Q?jwrXb0mE6zihPLOy7/47XNzb/Bu7vZxTGLEDA2QNRNw3k9sf0HfmwgRbfBwq?=
 =?us-ascii?Q?muMFBPfCAYODUBthGc3woupEp0vcInyW4esH3+QgVTpRc9+4WQ2wNpcoAIIw?=
 =?us-ascii?Q?93YiOHi0Qe9aOHYqICFaGdJbCiMOIpk2DmfZNkUWAPo+gxeXkfboNsaC2/jU?=
 =?us-ascii?Q?c0soyWSes+bPMdwdH7pehguLdbxhtbq5Qe1RGKF6nw9q7YLqqV+b/v2xUT9t?=
 =?us-ascii?Q?1/UbBsLjJdvsQ5ulQlp2BU6jNtceP8V2dQZmUP7Gjh5w?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30934833-dd65-4b40-dc0d-08dbcb007447
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 08:51:41.5427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81H4vyOwZjKfCnleU999Xgi4hpI1EW4cAwmhMmA9A7xdLwwqFMjwoZ2Hy/wvUgvoOnZ6h4LTh0iof9RAoP1L9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7923

This patch adds a selftest for userpsace PM to remove the initial
subflow. Use userspace_pm_add_sf() to add a subflow, and pass initial
ip address to userspace_pm_rm_sf() to remove the initial subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ab6908b7b143..154978481409 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3507,6 +3507,32 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove initial subflow
+	if reset_with_events "userspace pm remove initial subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		userspace_pm_rm_sf $ns2 10.0.1.2
+		# we don't look at the counter linked to the RM_ADDR but
+		# to the one linked to the subflows that have been removed
+		chk_rm_nr 0 1
+		chk_rst_nr 0 0 invert
+		chk_mptcp_info subflows 1 subflows 1
+		# No subflow removed in ns1, one
+		# subflow has been removed in ns2
+		chk_subflows_total 2 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

