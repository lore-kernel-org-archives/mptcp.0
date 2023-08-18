Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB7E14F9E
	for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 07:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwFeuCJkmuwX0U7plgbNPoppo54XoiLMA8XyS9a7hzvx35qlO024xJqjlPHJQLryaf4q66Lh6wcZR3Rr4vNcyfehjWXtnbDDRE/6Fq4yOMsnu95130q816ZPiNKMx3PRs5SaCDi+nvv1/0uEisIGbfApeUcDt77u/VnPbByWQT8Me9tdHA3wQ/eZg1Mot7F6W5M8M+JoRGyK7YvDpSs7ps8937qHKrmjU0z2ona91u8sBiGsjho57Vj4MMQdFx+kSuBbrNTbUwPIQac2acqJv+LMj+oJG0SLmifMNbYwuXy6OGDHYcgUe9ELDQqbimZJRip50YWXCf1GCoEBQnfmlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKHdwcTbQNbtgN36xPoFi1ty9wk/djn0TVAIMuM2Xr0=;
 b=K2Cb4fPD9XKWlIWOF9wmrllPZB6JfyMyWTu7Ap66Bu8AWXrTuMoYnwLEoditjpU2TEPQHz2TlfZyClvpvkBLp1qUZpHbOw4hjciM1PAl03yxbRFWOGL6oZV8EuMuHH/iZQCbpxoSlE22iI/ISOT7XqZoUIQSY5LWyHJaePiTX+hWn/Torff8PhRxPlv0/45KN3PTeOeoj6Ujwky7j1lEzOMxrgV7wypTsQHtXHo2ecdFMbg9iu6KqSFhEUrUxy6x9LFFP/2aV+Pg5rIqNhG3l8yiVUzRncz3nyWaLdnJO/XT1Ptowd3vyLqrYYpclMfgOKyV1cMaNThlkyKa34fNDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKHdwcTbQNbtgN36xPoFi1ty9wk/djn0TVAIMuM2Xr0=;
 b=emIadzsqqzcw0EmbLtu6WZ+hbnyfjW4TMpat8iGpOq9cqAyt9+rYhXwgOOv+Q0Y/hzqctWAQy2mqrsqkQnPqXEf3NW9UC+aSHy9Cjz/qCyJsOZ61iFpXaDreHrZdBb81tP8iB+AlfHJ84IyBXRMXx+3m7TUmuldU+/EmrtupLM6mmbV0iw5ibpj8ctBLczBeaikowqyA9t9g9/796yYAfQyUZLg1SMgh8HpNrlTOvvBpLe+4Fj9Kv5ei0csmNUj3G8bp352tsgiFv4pL89SnFTqjepNYj4DpHjm8j+TSa64uf+C1rOcDEHr2BCPBdznMEpFjoMrC2xXEod5981UkIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Fri, 18 Aug
 2023 07:14:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 07:14:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 6/6] selftests: mptcp: userspace pm remove id 0 address
Date: Fri, 18 Aug 2023 15:12:05 +0800
Message-Id: <f59ec3473deb3ebdd2a3e34bdab23ba79086b747.1692342519.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692342519.git.geliang.tang@suse.com>
References: <cover.1692342519.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 800f854f-f2e1-4138-ddc0-08db9fbabbb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ayErUcWkO7BAwQkd2+HWXzSdy9+WsJRXW64/klo6B5C+qYEOlRw6oK2ckhaCjF0LGMw4Gevz+MxQ0FG70s7DS+6zu+eF9Nrz9M4fs3WWyoh7dVZQ7HMEVRlR2BOe3dzoq5k9Nwt7zqxuNIZaM+930PSVjFhizoMQn4DbTB4hQnMzR7imWSk8v98InASN+1zyE8D7urCwbJt9mUSS2bKVZ0XNPhkRhLcWM7+Ya4N/vTKmuWlh7f9JcbTmKzqSUm7OxJbiSBm3p6G0XiLGf2/5V1GxNI3LGRzLNpMMCBe/IYkA6BstH3ijxej3kZyaVXyRhUUNWmOJ5AXdEly1Td5ZZ1r/V3OHpsJzRBitXIlvfGehjhjPxqVfGffrr8wwkqyDej+G4SWbvQymoX562yJ16+5+6O+q5x9KLdrEJWyc3C/LlrTtDkwHNhNWIHhdtHbCNmGsHxGx6a/RbEqfELSV2dWxE7vNKyT3JZCDQwNs9T0bpu6POsJcF48zwqoTmz1hTzGycvsLql+jQV4+4crKm//S09xP06qwfYXoKkEgZdRIWLSlTyz6NmZ2FxXwUf0OQLgCHNBqj5T1L8aZEX8uxnksT4/+wnjZtQJqHdP0Qc4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39850400004)(346002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(6666004)(107886003)(6486002)(2616005)(6512007)(36756003)(44832011)(5660300002)(41300700001)(66476007)(66946007)(66556008)(316002)(6916009)(4326008)(8936002)(8676002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BzHxoqriaxcRicgE9KZSol1Zk3ze2H6Mxqniko2Cbb0Q/FiljBQ0RqntCpum?=
 =?us-ascii?Q?dRNFBGbNRx0LPxs5z9NY6a5aKmp7gIv1ozE793PF5PAVhBLyVfwJ/6rAPCnf?=
 =?us-ascii?Q?nNKgXKAn3Uf9cDtpX4WWXTSsSGct3LhKOklIu0/FK6AyczQue+lYM+EMsryf?=
 =?us-ascii?Q?8Gg5doCkeE/pP2KEEVQhSAshdHJHnHolX1MtnjkCfd9rWRR796vWYSmnW8/Y?=
 =?us-ascii?Q?Mm+u1JRogQ5uV3VDjOtADiI18uGI+YSjHBEQRGggVGMk2Jg+pL6hD3lXPOES?=
 =?us-ascii?Q?tzeD14iGJMq6aMl9OSkLhXkNca7sQiFBkSIOdfcbPhxRfoU2dsnkTleyKusI?=
 =?us-ascii?Q?lwiMxUv9HDECehBhirczUWo/YVjhWYfE7Zkh1uKpjKMKhumhuZoMqpyb2c6v?=
 =?us-ascii?Q?bKDwJdLUH7xCgNb7FMuVAEOolaQvoEXTUtQVH9ApnaRR8zYC1hN/rdw1QyfU?=
 =?us-ascii?Q?6BRtBiyJauqsAOJLoEr1qdyCpPMrzFm5tmBvo61UYLweCvmi/V33LLTioUha?=
 =?us-ascii?Q?0iODCGEWkc3NfDmJ/MPrQqZmkvSvo9Bl5RAUECwpS3ebn1MY4Et+KqQkYLZ0?=
 =?us-ascii?Q?Tok7fH+27m3pXfgKtJP6GvLyfNWgKd61l0Bs6/5EWCghwiWxejbzCNImcJr/?=
 =?us-ascii?Q?2kC0Yyz6KWAn0V/eyTFoKrf2cnTh36QuiTfvRP/Vw/LUQR2r1o/+mZC3MgG3?=
 =?us-ascii?Q?/I/KJYxHV8pQURudf1ttfnQAHUhsPpLwWptMmBgrRhVH/xl/2ypJfEF6isUB?=
 =?us-ascii?Q?2BOuV4j5KB1vHejD57bIvvw9ybdvU4frR1SnjWfVSAH2PhFdTbGciekZG4aj?=
 =?us-ascii?Q?RL9hCUD2jyzrFnoq/XuIJMFaem9+8YfW5PcsXXhdolx2EQm3A5zRD9orhah/?=
 =?us-ascii?Q?7GrKAgt9hv+YueDwFJ55s1v9xOO6BsrN/X+dWwnoH4HLJlfEDQo9pOacS6M3?=
 =?us-ascii?Q?OTGfwWT+zvrPv+0DV1HIBUZ1beKSJDdHiRJCyWwu7Nf57cUBahJBrqzyNbRd?=
 =?us-ascii?Q?rn4c9XMKFehuRz1bxcwOZY5weVM7UNTN4/4VehE9+1+EXwGQrc2+J5V7bi+x?=
 =?us-ascii?Q?OKHSvdohfK+zs7YuaClMt0ttQ9tT6kqyvFPH1/RvmZvN+XLojxYbEr7fmgC1?=
 =?us-ascii?Q?l37qOSxe3YJ2PG8rFNiYqOZE54Y5La150Q2aANciDtz1HOBPdxiSsDdzy6Rh?=
 =?us-ascii?Q?qaCIPYy0S2UJCs5fJ/Eyi7g9T+5B8dQ/xYTZEwajN38+K0di6zClJv4YL1N+?=
 =?us-ascii?Q?fQLKVBctB4dkD/CBmJNBD1Ij0CWq3jcJYP0UraERpX7lTntfhdsbC3YgT8Yw?=
 =?us-ascii?Q?VV0Hzfx+T8e1t5lAhZpERGvKp1fC8PEgleeDRgKXyryckqjETXnCeU3T2VTe?=
 =?us-ascii?Q?jdur+Z53FRM2b4pL4XekkqQgLOipR7ob0pII0vtindYaX+Aj917Nf4tIBhdv?=
 =?us-ascii?Q?wnVH/+MJm1SbQj4M3c+9diVYjFgjEDpJ8T9wr8seSXdk6+/vbKSen28aLe66?=
 =?us-ascii?Q?/hDQJikawkEyi7E0vUroT/MgUDdihNMBzB+oH3QGYC3CfOmtIsg6s1IaZuPI?=
 =?us-ascii?Q?Eb01mtQYSIHAfN355fzUOt7d6Ehc/1sx59jm/jghfTzmxubGBdr7YYsCzrwY?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800f854f-f2e1-4138-ddc0-08db9fbabbb3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 07:14:16.5884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNZ9w6Q3khKr6Fazo6x6vyTCOuUqKwBX6U3OaWW0Vpzo+vlbdvtOID2rE54ZYfomoTG9dnWvf+LfigETyw06cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975

This patch adds a selftest for userpsace PM to remove id 0 address.

A new helper userspace_pm_rm_id_0_address_ns2() is added, in it use

        ./pm_nl_ctl rem token $tk id 0

to remove id 0 address.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 322adac0cb1b..1c5c0bbae38f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3336,6 +3336,14 @@ userspace_pm_rm_id_0_subflow_ns2()
 	wait_rm_sf $ns2 1
 }
 
+userspace_pm_rm_id_0_address_ns2()
+{
+	local tk=$(evts_get_info token "$evts_ns2")
+
+	ip netns exec $ns2 ./pm_nl_ctl rem token $tk id 0
+	wait_rm_addr $ns2 1
+}
+
 # $1: subflows in ns1 ; $2: subflows in ns2
 chk_subflows()
 {
@@ -3514,6 +3522,27 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove id 0 address
+	if reset_with_events "userspace pm remove id 0 address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		userspace_pm_add_sf 10.0.3.2 20
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows 2 2
+		userspace_pm_rm_id_0_address_ns2
+		chk_rm_nr 1 0
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

