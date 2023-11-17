Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2049.outbound.protection.outlook.com [40.107.14.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88ADD28E
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yx9VUSsP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UB88Rt3mkAIcuGB3fMzQgh0KIlloloX7+doyict+aiteOFAITCiVNuXS5CZCIMxLGN2S6REC9IvZ7Z69o8DJIBbm3emQLhltZkbN82Xmo7Wl116IAmsXWuFIESNQDNaACumHxONZiYjANeR0U2eHAe8ELVeD+cnRqrBQjAbTNsoJ4owxEnNGJZJ0jzmmCJZUSgciTCqX3Irlz1maWkJEA+7Gpbtb9F7j0Xh/aQmWau4NEKsYwg40rK6XKHYKW6/VUuP9egOE2jkPpqxfN0d4eZ2Cy4u/bs99rP87XlcrGaPQNNNCA1L+YfjRYBfZr6dpC/HDZy3AImI3cE6WZqs/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zApnFQdMLG4tzE/lj8RpR2Ius2mP54New5jPJdLe5ro=;
 b=X9wMEXPWIXG35FnEP4iOeGKjFcraSeUv+X9YepQiy3U4EYzfEs+wjORGFbjXy3UL4uwBU7g0ggJHBhwL+QKrVfczOQBwF4ugMtZula8xnbcNLjjqvZU5g9jxtAKCXJUodyrmhunDnHjYC9KPuYe7jaOPeZle+epdzTLqDmNzM/Umi3q5aWhkmqaAhG9UQWH5BoKv2t8GUnkCfKtOffML+vGYyJDetA03I2iFqMfl7V05YuLlhMLK75w7QWNHK8BuY7Al5zDcSU4uvrrF1auVk/bWzwTMHQCCZBO9+fPq+h/G6Hb10VealO9jKG9jRkxhOXySP0GhQKSUWcavy2Kc4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zApnFQdMLG4tzE/lj8RpR2Ius2mP54New5jPJdLe5ro=;
 b=Yx9VUSsP/WZ8MGrCZy1+7Uulx1T9EZEwIsnB9HftNA9ZR3rLtrP4LMjb7UqNp4jioaBwpJRjxNUbXa8EvoIANFPDgLhV4ncuUy3A6AtST+J7ZBZx35kus44n5BriXjr4VIow7wE61VoUD1n/3oT22ThziWoGwdtX5MBEJaWBEyLdKZ4Gg+kG8m0cSTGQWWNqzVzfuzgGA2q0AaO5dbwQvdkfdAYkgzGvq54H3oCCPR/2uLoFmyxtalzmN3aAjILK1UPDsswFKPnY9AdoODzSPYJPUKkj0tOK1DXPCqYSXltQOAeqVU2oDAOfFnnao6wt9sycieJqqtjVPw6z2vlB3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9975.eurprd04.prod.outlook.com (2603:10a6:150:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 08:58:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:58:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 19/26] selftests: mptcp: flush userspace addrs list
Date: Fri, 17 Nov 2023 16:56:12 +0800
Message-Id: <280b1f758ada6c52641ce1896f7b765108ee390c.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9975:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4b279a-db70-4d81-b9c7-08dbe74b5728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SkKzVjCzUzmG/J6C1Af9GoMWPYEU8hmvASMJgDxx3vFWeM+mbRlTo4LY2XVHLCvqa/uT8PySl+E7ke5aPhRlo+OfUy4QPdYdPm9t2Xq0J32o59xJHGRDoLiaSqwWEbYhq3jqx3GjwgcVScexZwZaNykYKROVKjRnBHWznUshAgN9sCstzzT5K7uTQwp7S3lAFAPSdaEbb1wiHpP5+sgMHhZQQCJB48tRLIKdgguDytK4/125Sx1aelG3EeyR8u3P/NTStar+j0H36PPx+23dXyBvGuBG/MVtjQ2E+O8GvaxSgIknCmrJW4J/SgdP9g+p0ZepgO5W+x0BNZ1ArVlkrbOsFaf0Sdd1dmE4XqR0bRR6NJTc+e5a9fdHHjQ7fVAwooMNnn3WorAvAyVdgVeZcBlgr3kPd/OuZtNQvkx+kM7+1T6hrYtJjcQZeWInxceGtwR2DCA+cvaRRkK/vtcs0vzWyQUMKqjzzyIK8PbiDjcnm7B91jerdnp8ndk/lrHiAU4z+hIhdgriol0MYLlzyL0Qx+ay0Ss2ugggWIwFPd+nYWQpc132hunMIgBSCFe+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(5660300002)(2906002)(36756003)(86362001)(6666004)(41300700001)(316002)(6486002)(26005)(66556008)(6916009)(107886003)(66946007)(66476007)(4326008)(8676002)(8936002)(83380400001)(6506007)(6512007)(478600001)(2616005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0+5Gh3xuUVTpHWB3dK2RqVMrDDIn7hK7zJcn+zLzLSf/06zHHI3rOL/XhyKS?=
 =?us-ascii?Q?7VYCKrLmfOifcB/9pJbGf2chrA0qWmC2csDPxBY3Jq9DXj7KOsL2ipso51mC?=
 =?us-ascii?Q?REY2szn9W7Kp5xAry4V10HBdwxcq1hs369y7zeGXGwaEzhqbKJSExcFk3m0j?=
 =?us-ascii?Q?lttHMOAtVopew/RCXqG5evPcB+tn8OY3eo00qWpyUm8Z0SgGnZR6IIFxrSKo?=
 =?us-ascii?Q?QVfQZlLQXsBTzWKp/qB7L3RLWqI3iE7F3dHHNjOZUIZyiyLSvlV+HMDQ0jHq?=
 =?us-ascii?Q?oKSbTDt/kOgDOAOv5S5W0P/4a2vDAdt9S0s898XrTfs4E0jn8wZ5cKyrCuhr?=
 =?us-ascii?Q?2/ZgnhWOOIUR9pokGuc/gxKrIgISsxVMLmURE7HAJqjyjJSjwkL5yQsfbYzr?=
 =?us-ascii?Q?xTNrLXDoogEWBlILy50OzFaq6iWDH8GuwjnO2TQUOm+xT+NQjE2OgDgbNBPw?=
 =?us-ascii?Q?L4biAaKA62Ob7xmW4pJ9LmP9E3v5DJ9HY/MGuxC1lF3EaJEvWhBnrmUi+gS/?=
 =?us-ascii?Q?MnMMr9E9Wid8PH/HZYHK1xCNCj3tPVYcV+iCMD2kPpsUfOMG/NH4GTW+AaOR?=
 =?us-ascii?Q?SpDEqXLTWVjTr54prwGtI1jwwB7CXgKkGtYZTOM9mIAsAAH2HDSy0sCPxxXu?=
 =?us-ascii?Q?vRsu2LrXuZzWfR5+6JCVIMi4Djmvg47hkUgRvaW4bfZ7+D14GBGvFyEsDcM8?=
 =?us-ascii?Q?i76B/5dxuJXYR1TNzVUBzLXL/F+OrQqIzGztqIFuOcApU7vcKH4TgoEmo3Uu?=
 =?us-ascii?Q?TslJr0ihq+bmA0ABWbmKk1to+j9wpgo3fB76xM6xd5hwSrFe+Ii5mxKXQbEC?=
 =?us-ascii?Q?kKmttZxEzL8R31QzQfGllwAALdrwMo+7zWtLeYL7vPox6oKJYKcsP9wR0Y+4?=
 =?us-ascii?Q?I3zuoIZTiR+2XOOo7Zd3RlGKyY/7a0FWgZ7IlvyymOC4pMJ0QqFCDUKJvFud?=
 =?us-ascii?Q?gE1VKPqoNk3XQZk4IHXXws2peHikSa8sO5bq1a5/brho4F3iDBhdhN9Vs3dR?=
 =?us-ascii?Q?09E8rRYZU3sH60a4Xgx334GVaWYz14pPuHe6iK80oBlCUp9u9FxfLFpDc9NJ?=
 =?us-ascii?Q?s7DAISDmpQFiMgpGqTIw4mrYcfdT3rgYRIr0Ma/7PkRJsDN2iNSkOU5r0DiM?=
 =?us-ascii?Q?Pci9j2fuAX4At6EKSdtKA9jrT5U5MCgxR7eAXJFGN2Uz7vKNaTLMrA0uelsw?=
 =?us-ascii?Q?YOI3nidtuj61rBG2Mci+VWoME/U8P6G/6mmv7NrpIchdM5+lEkqITR7ZILCJ?=
 =?us-ascii?Q?2UNsyIvPRq2BL8c6FQS6DKzTDZ3JlD/R4/0aUZbKpY23NGcORH7V3YCpVO/F?=
 =?us-ascii?Q?3zBXFPQTaSyq/5KGTQYwI9r0E5Qc34aqecY2zEhMIWXPVXU8XAcJrTY8y+zt?=
 =?us-ascii?Q?M/v/MsDwgB9WCz8xBqVVxhCLlKzDxuVSeIqgIuryn9GhOIpspLEuIiGb7a0U?=
 =?us-ascii?Q?ecNHeBK+56okti2sph2TR+gE5hxGp9i5OntoaT3BZR3a7MhnroyaIb+ak3jI?=
 =?us-ascii?Q?KbAZQbuK7yFmyV5NhHFti1kH6PWlHrY7OdB9bIledhOk2z2Lt8L2QToE6gJi?=
 =?us-ascii?Q?53ImLRRnoMLyrUymOi3SLdc+Z01LhaPJNp0HXGtsLuEPjooc0qt5t4pFRNZe?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4b279a-db70-4d81-b9c7-08dbe74b5728
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:58:17.5266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmnOtnKEa3sulsAS0cpNdLkByYCp8Usa4KnUyJdFZEJC73XxgMilYcGNzGwjps6w+GBK/KqZQked5qUs4v+ZSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9975

This patch tests newly added flush command for the userspace PM. Add flush
commands into userspace pm dump address and subflow tests. And use dump
commands to check if the userspace pm local address list is empty after
addresses flushing.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4fd1688498f1..372c2d83b4d0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3513,8 +3513,8 @@ userspace_tests()
 		wait $tests_pid
 	fi
 
-	# userspace pm dump address
-	if reset_with_events "userspace pm dump address" &&
+	# userspace pm dump & flush address
+	if reset_with_events "userspace pm dump & flush address" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
@@ -3530,12 +3530,18 @@ userspace_tests()
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		mptcp_lib_check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 				"id 10 flags signal 10.0.2.1" "      dump addrs"
+		ip netns exec $ns1 ./pm_nl_ctl flush
+		mptcp_lib_check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+				"" "      dump addrs"
+		chk_rm_nr 1 1 invert
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		wait $tests_pid
 	fi
 
-	# userspace pm dump subflow
-	if reset_with_events "userspace pm dump subflow" &&
+	# userspace pm dump & flush subflow
+	if reset_with_events "userspace pm dump & flush subflow" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
@@ -3552,6 +3558,12 @@ userspace_tests()
 		mptcp_lib_check "ip netns exec $ns2 ./pm_nl_ctl dump" \
 				"id 20 flags subflow 10.0.3.2" \
 				"      dump addrs"
+		ip netns exec $ns2 ./pm_nl_ctl flush
+		mptcp_lib_check "ip netns exec $ns2 ./pm_nl_ctl dump" \
+				"" "      dump addrs"
+		chk_rm_nr 0 1
+		chk_mptcp_info subflows 1 subflows 0
+		chk_subflows_total 2 1
 		kill_events_pids
 		wait $tests_pid
 	fi
-- 
2.35.3

