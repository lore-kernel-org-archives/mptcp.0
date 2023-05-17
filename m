Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2040.outbound.protection.outlook.com [40.107.14.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C7C10979
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 22:30:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAi/jBGh4hhjQsXqIQuZ58dVcYamtKLYRtJ3xkew9fS+dmvdzgmUpUPSycvE5vMuKuDPIbFEJ5WkpD9/BvmSrmDC/L3vQok7Bk634VIlBkAf/TvQ/PiHAzO29Skwy87EpvZl5cNVaVe54+Z+cByPjJdzijEI2Ub0oQaUNvNKLdBmiDB3ovoxCgX1g6A3BcqfK6Svl+Roo/vLenhfneI2oaWM0oGIpKfRxdKIrgH/PNOD/RLKqA1q5ytpJqVwMoUSrBOOXTonmxpFLroJOxwFfsmu88akk/HpCxTZRwv82tBtt8lhQbpsuY2F04c/NLPcdliR4jna2k5Q3kE/95r1sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XRXc9keQ/Tm20Q1VzXZL2cUFSAsIrdN66YUA0VimXc=;
 b=WOftGLzE0sYGQPoqc+9LgtKP1zmOlTkS4L2Fn16OfmItR/hhbx1Bka7wYB9wAcn67kzL9gCb03Un0Ema7eakvFvAwQAex5m3OsGDpRUSnoUQkr96t/hAGZYXFomBACJPPR2TK2fTgBUsYhLqO/usDOe1c+H6FAOnRdgMcR8abKuTJgjsNcsLCyUjMItEZOzgdPGYPeXDmGbdh2vBpo02xR3DAwrY4G9i87pG+MbJ26nsHhovw4cMISiE7u3lcRF88vCUTn4A/lGuiUCv1d6qjNQdjMcWF4WNnjfNA+xeqWkjY/QNMPX5ZzZ9/58PiIUxIA8n1JQacnAf1pOVo/zNUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XRXc9keQ/Tm20Q1VzXZL2cUFSAsIrdN66YUA0VimXc=;
 b=Emi8nSYbpbUmTSzc+IHk4hTkkCdcqOSNM7tNBn/fw45Sk28KJxFiH8Pjc/cWyqkkuf8J9UZT85jAjV/V5zSls3jaDLs8TiQ5JjKPhqEFGStqyEg2MqmAbfr9QTWBiFj2dIunL0ZBE54Ba4qjOxfH9MjHflHCicrclVfQIyICxxHE23Ut3uGV/xK90TgJMHe/4aeS28X/yLpBBNMWfD6wf1CEDHSliVRRFN4bsTh8hSBVVloJlgEsMLkyiMHI8KEKfFOqMWv7OQ+6kOHw03iDRld0T9IT1RwN1ClpAn2saEOqvb0+nYPCG/taOKLdeb0/AzI+OacIjRK7PhHGBIOqIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8549.eurprd04.prod.outlook.com (2603:10a6:10:2d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Wed, 17 May
 2023 22:30:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 22:30:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 2/6] selftests/bpf: add two mptcp netns helpers
Date: Thu, 18 May 2023 06:29:38 +0800
Message-Id: <c098dd4dd76ffa67dc4e5e7850c3838882f2a32c.1684362296.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684362296.git.geliang.tang@suse.com>
References: <cover.1684362296.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 46718c22-b208-4aba-2610-08db57264653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hSBx/01CoHjEORpd3jlryI5iwczDbsrx3F3JyZEsF5eJ4CaLHSGtMwP5MY/k6DCHC7YzJ70RJtOYTplSTwOr5Fl6/Yu2sEuaOE7Evzyjw+JOSCWQ1LlaPut9GcpejtB0c3omp4XqLn7d9qq9DAaJ0Sgigt80wr1/D9SftCA8aPxqz4AvS+oy9mepx1hmB6lcY0C+/QKHunlgE01yKGcb+SJYIdinxxQGent3piTS6eCAUIgo1slcsLGEUteqL697s+E6IvJfpT5aqXBVx81pqC2P3aZt1WyKNhwMZqo000jF+Y9YgNHrBaEVbYiNd+dYPRSCLcSTZ+7flClYludB29t161URInfiK9IheBNBD6HxxUDLdJZuErvC8vvHlbhP/znpVe/5G+0eY+q2il3N/hEdjH/nFY4LShkST2uzv9B+fTEWAon3uMEYFF1ZZW3FS/2XKuQUY9Y5oj66lHV2WoD8TGlCofl+fMimf/LXOCfe3WEoswrgPs/agni7l5dPzMUdi5SI1kdWntab1rtL2d+VFxqnFVSbO5/K23+vXQyIL2ElOTTU3cIZgGP98pXq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(86362001)(36756003)(316002)(4326008)(66946007)(66556008)(66476007)(6916009)(478600001)(6666004)(6486002)(44832011)(8936002)(8676002)(5660300002)(41300700001)(2906002)(38100700002)(2616005)(6512007)(6506007)(26005)(107886003)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CoZ7/KlkGSsBhXQqWOkldOn2RPgWKrmjIPvyUDqG3NadXTanyrIiIOQzDSpG?=
 =?us-ascii?Q?sbIHUoooSgr6zD+5QtAlhIVB8jqSoNlq9UdfLoMdzKzs1o31xbMQaWUQsuBw?=
 =?us-ascii?Q?FOa8Yk2zleEPN5RAO+xjhRGfNMYC0Cs9ygzFAFE1KD6j0zhb0h6FkTEZhoPZ?=
 =?us-ascii?Q?iE2QEIxcZR2/5tb8IGclfChaukZOUWW/8Lgz91hdNV9r1d1bXpPSc8Qj5cEJ?=
 =?us-ascii?Q?0O/Al2fhZzWdx8zbjLClgevtytvP+IIgcYiP1ZjjRU0ObjxjoKXdQgPCmVpg?=
 =?us-ascii?Q?1GgTHIh6mEl/6uKZBanPmNfllLIUPcC6jGLHbO6TMqG0AqduZ3xtp/jHAiad?=
 =?us-ascii?Q?clNKLKWj8v2kAbIH+x2jLliz+DKaFPzOEqQObsqCNWdNvjY0gyAdrieekQaR?=
 =?us-ascii?Q?4Nu26KXCcjKM1oJpuuU77+Ei8wRCZu8R7mKiyx9QevzlhSmjTKBg7pMVT9IM?=
 =?us-ascii?Q?zetZqXEkKQTSOF0r8eXeVO0QtADt2byzrPOdVX57OY9iGP4Ikx60dOErrP/v?=
 =?us-ascii?Q?gpx+5mxLHrL51F2kAIT6h7sqtnpnxmAceiSCcsMEk2f+Ss4IvZh2AOcdOEzy?=
 =?us-ascii?Q?Op+KXxKNkRLfC2EQp8iETeVHeVezw/wReaBhsGleG5ERiSLXVX3kHJPtymOx?=
 =?us-ascii?Q?co39ow7sF6SDBC7vkDFuWBvgSVqyWlOmc2yp+kS+AOhJhZwiws09LhxL9GC1?=
 =?us-ascii?Q?AuVvXvEaFmsgTSgJDk7weVVeN1YM+hfiyK6fcb3rUG7+UQVIJjZt1RKPW2YX?=
 =?us-ascii?Q?/FaoxgyL8XOOWrXcpuO9or5mBEPG4nxbYAnfxKBGWsHhlu+CNaiO8HkdaPMk?=
 =?us-ascii?Q?ARc8knO87D5r8q1poRBpoCiE3VhVd7UB18V1fU8eBQkBrcrlp8wsefS3PjOp?=
 =?us-ascii?Q?8HEiInQEunGI9sWBtlhHb2b+ym7HC0tRJI5jsMz/zJPtHBREWdtN5hp19F5T?=
 =?us-ascii?Q?v2j9Uir6R4SJ22jkJVL37JR2vxCyFh/s2GJUrlToZFkGpZmWWyx6H7jLPMno?=
 =?us-ascii?Q?g9Cv1oL50Q/0kZ1zU60OwKiljmNvfP3AYb105GaC4BPSpl6eWvSuJXPkU6bG?=
 =?us-ascii?Q?oDpRYiw8LvgdOOC+cQGzN3TyOeUVCoZBqvRuCBs33jvR8RrEiO5hIZ8TtIR0?=
 =?us-ascii?Q?cyNExtt0Q0H1+ION440WGHUvWVt8jkY5c9JeWEYe2IE6eUfM4QkPHxgz62lr?=
 =?us-ascii?Q?nlEAyaWxIAZ+ygnt81GjvvQbye1jkN/WbTsrsmQJ9SKAaHKdehGceifSjVg2?=
 =?us-ascii?Q?Zj6+u5RJBYxVP3nrF805GdVW1N1C2zZmDoDm+jBbnCkEBC1aKwGY6PrmQ1qa?=
 =?us-ascii?Q?o0LYIbYvP0je0bgI1RFHMVAszt4KEU7NlCDaWO3A+NSTDgVK0Gmvk+h1WnlD?=
 =?us-ascii?Q?fwXk3tbxYwoS9jgI+i/PNJDMhiJ/yNLK2ESjL/teMZ/x+CS9Xik3OJLIpOkC?=
 =?us-ascii?Q?huQxMnbVNcLc2t9C9gFfR1GlQTG5vLMC0LEl6REChIEB7m4IS/2tH4R5XkL6?=
 =?us-ascii?Q?xgZ26L7QjTTfzycoR3s17hg1Fw5oVDJdLuLeG5gaxBWYRZGgZ5UxHpD7kc9C?=
 =?us-ascii?Q?5Vs6NzVuwZzI1FC/E66fumqDGCb0/o25QR/RwSYe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46718c22-b208-4aba-2610-08db57264653
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 22:30:10.5030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+SWb31LZKLHVCwsa4y9jItdrXvHog4sEPSewo3bXEQyBXXlVOJlueezahJPcAWTZ17zuchR/irxM99U51E55A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8549

Add two netns helpers for mptcp tests: create_netns() and
cleanup_netns(). Use them in test_base().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 34 +++++++++++++------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 8040997e4aef..ce9dc3ef3d40 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -142,6 +142,26 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 	return err;
 }
 
+static struct nstoken *create_netns(void)
+{
+	srand(time(NULL));
+	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
+	SYS(fail, "ip netns add %s", NS_TEST);
+	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
+
+	return open_netns(NS_TEST);
+fail:
+	return NULL;
+}
+
+static void cleanup_netns(struct nstoken *nstoken)
+{
+	if (nstoken)
+		close_netns(nstoken);
+
+	SYS_NOFAIL("ip netns del %s &> /dev/null", NS_TEST);
+}
+
 static void test_base(void)
 {
 	struct nstoken *nstoken = NULL;
@@ -151,13 +171,8 @@ static void test_base(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
-	srand(time(NULL));
-	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
-	SYS(fail, "ip netns add %s", NS_TEST);
-	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
-
-	nstoken = open_netns(NS_TEST);
-	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		goto fail;
 
 	/* without MPTCP */
@@ -180,10 +195,7 @@ static void test_base(void)
 	close(server_fd);
 
 fail:
-	if (nstoken)
-		close_netns(nstoken);
-
-	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
+	cleanup_netns(nstoken);
 
 	close(cgroup_fd);
 }
-- 
2.35.3

