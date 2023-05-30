Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED991DDD7
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:15:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0moPsOwRXzSRgP3Ig2TY2MpFeSFBvIJE2Asz0+oRyTbxuZWlutTU2Kve8Ok/kvmhw2sDLZEXs8DqDw9rucIBzm08jZsHi1Hn1xOaG1p0jXm1zv30kHoqU2j8vOljGwaB3lKZ/FH2PNoPECiCqgP0AHBGZ9c0XBFicnBFtENGmuF6hl/LL//zONe2vKnrRFOHHx/Oiubj22TxFiOYloaq85rvlicgC+3tL3zwb4uEWywN+AxGGLaAwH5Q7g8/IUPWyzW+iepVoKelDAPm1p3DqQvW0M1MBC48KwCi/7+T7EGEo/XoBOkj1vv0FkQ4eoRQ0waLUZUMYuzdLrf5i1vsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uhu9S30h1vyyXZqEhHhLodFaCcyMWken6Oql765VisM=;
 b=YuG6PbodSclfj90snC7W65kTSfJrHp1ZXtXCBFbI3Fnv/2HluBsjW69J9EjOfBd5nze6kDrB40CcRJu6rg12mtwmPdgFAe/GTlAQfCM8J48mUyIDEDBEqtbS+iFKEG1l0y3Xy6THiogHwmbMMpyKvh3R18VFRVxQ0xx4cMu8C/uuRV132uMeG7VNhK5e/cxzjRJoC/PWKpDO3BVw3k6FG8/HnzZFm0nAMavllap7/p6yeXn0QeA205S69ujhPzPJEsNlw+E6kXXoUEO8x5zFZH1+VnjHxmqVH8VHaVsccPo8t+UzfJVMNax7ly3dG55DHkNdWUCiqIE6POaseC2xSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uhu9S30h1vyyXZqEhHhLodFaCcyMWken6Oql765VisM=;
 b=5xiry32O01eljYzJPI8J7vmWBTLQA4SP5eGciNSY6eHn4pndoYTw6w5vF39RS50945nD9PTCK8g5fJ/hMHZAiGEjN/MdIT1MhIMyKCCSI3lmguk5oTYOeiQLlBnsDgRGO33p4ciKolVSm24LfkPBENaA1h+XTHL6wY/6XhdRNxAYFTn4PMG+Sy2fP0B+5bv+h0iB8rIEd4yayG/mCksIJ9egrurZf/qYPMVthirEimjvEKS6GM0/2imn6qguXfxRsXgV00AMYHQs4s8Z17nOlFwL5qEamlXbPQNIf1mlxe+hJiAONlXiFvCMaOfEuVrLDDTOEximAQmruW4MqjVJsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:15:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:15:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 1/6] selftests/bpf: add two mptcp netns helpers
Date: Tue, 30 May 2023 21:15:07 +0800
Message-ID: <2447b5f6250b3070b53030ec83514932a1c15a97.1684331602.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684331602.git.geliang.tang@suse.com>
References: <cover.1684331602.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:3:18::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: a75a4efc-e935-4f29-8edb-08db610ff2b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YARKhf0WUj/EdTj5daJ2Bc0iGAkShCMobJyigJylCfB6zpYJbOgKrpYX3IalEGWSJySH4LJM5mmsDJ+vRp5kDnmgJRvOghKkhANJVCGvjRfKuZF/9FIJWP5hSl5E5RJburRvH1OFTKJVZdT9yi2qTANlNXvFcLJyt2ogIZp9pxdNW42HZJFqexNFarQNv3x19zl5Iws5EavT5nvVi2wfKChXQkdY0OoHlC8H94g/8lrIkb7wzVzvFr1VyND+Czc13uWaqb+0Xa13tpTd5Hbeh7JGmFdSr2GLb7lDBQ8R4Wt69VvMtKGDeg/M9r2s+WbwMliiZfYANVfaKOFN4fMNUEwnUq70pW23OyGQxbJlxIZ3lp4mP7Gahd5YwoH/KW2efMdrMryNLY7RpaG4pR24NJMmkXgsqDNtiZ0LxayeNKuRAQ9262snyUBp3zzEnceY5HAhWuvs4ygY3j7hGQ1HJOrhgch8XFB6qgXnG8WH0UQ6/cH5dZuHgRk1wIP2DJ7VbJPzYJ7pK3M2FYO2u/RdyCMb+u6VSG3n8KN/wEbnMIPC4N9T0+JcL1/og73ZFyzJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(2906002)(186003)(6506007)(6512007)(107886003)(5660300002)(8676002)(2616005)(38100700002)(8936002)(83380400001)(26005)(6486002)(86362001)(41300700001)(316002)(6666004)(4326008)(66946007)(36756003)(44832011)(66476007)(66556008)(6916009)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I2e2+9X9yhLtMEXLWmJsk2HblZ7XlmPnlj/pRwjZSAEBLFJQBX6ZwOpW9sUQ?=
 =?us-ascii?Q?btoCoGL8tvbTDu40qocLZdpQdLtdP/O9W1fBjsPldA9TjskWBDKGMyK6cUHh?=
 =?us-ascii?Q?GN6F+kUy5aARACJnmwGFI09Y9zPKLc6lulnieCYeNwaZqDmFxGmWiJSnZClF?=
 =?us-ascii?Q?VKVC7CozuFDRwmkqnJD63P5zbzMK9Q+R8o2pxJuuDmr4ptg2O1JR0F9wTW+r?=
 =?us-ascii?Q?zxIgw9njhv6WtqAee6Fv/aQBNcfhFDvf1jwrIvYJH+x4FN7wfjMwTbVSrCCY?=
 =?us-ascii?Q?SkNgfxt2j3JBDXdYQS7AO2b9cTFHXicgrVjxI+/th+HpEJ4zSP4D4Cfh3wiO?=
 =?us-ascii?Q?WyVJ1/fcvlRMT6bVyKsxiCtCn3LKRNVjGAO1afEXgiIoBih4QNs57Pr7DzBA?=
 =?us-ascii?Q?Lg6pYHFSGsgoMBKPQOYPtSsjMjMf+7IYf8o7uGTfMR9AxNSLISfyMvL+9ukT?=
 =?us-ascii?Q?wZZ0WPFO9bFt07wvnjYsDCuon43Oz9CNQzIOD5AJb0/OvNOLm7wf6LuJVaKs?=
 =?us-ascii?Q?hhYVXugeykMJTQ4Z1K4pwo5pFjqe6KjlQNZ0307um/KOp6PXG6jp1tktbHN1?=
 =?us-ascii?Q?9CoTgbWD9d+6qFzixzHXbAiabi6f5FdnzTyozZhN4DgA6sAsrS066R0+yGmk?=
 =?us-ascii?Q?yUiDvuT7m4EwTbmNKYE9BT/+Omlb/YDX3PC7JAVEqgF34PDsBehKh0K6N/EA?=
 =?us-ascii?Q?F4MWZi6ShXeIDPkJ7U3hesgbOGBjOSOK801Wl4J75p5QsPGeXIwH5LTy/UJ2?=
 =?us-ascii?Q?AFkpjvCbu0MiG29qVGTsFbYDeO5Jh4k57FELEzzSDOGoF27HdfmG+KxxOTSP?=
 =?us-ascii?Q?s8dUAfO/LPMNa/t1ScXzm/Ij0A51aBFQ2ZHbmK27YgnoJRiSdhqwm57ld5vy?=
 =?us-ascii?Q?E7Se1MXVcxOwrQhWxrpCGYZQVNOYNlRxLcc8aUjOy99vTghjp0EK2h8aiErR?=
 =?us-ascii?Q?nSWZOHlbSi5/ct0XfgdmhvvzFMZ4KQipk8E1kqy2pAMmd7p8atx68Gkq4E4c?=
 =?us-ascii?Q?nNdsmBAdQAn4ZBDYCvX7W26HJOLM2ac8fgQ3MM4sc3r2SheqCTB0uB4qwlK6?=
 =?us-ascii?Q?uZfsd0FmDD8BMCiMT0rl0wAJK+LEOeqH5NZulbucqm0OfM+TZJ4NfW0cCNeu?=
 =?us-ascii?Q?nUwTJpsJ9jhBmiR9JJM4wHqNwj2A1cPtJM7t+KDNtoRCV0CZKzb1mOVZhuxF?=
 =?us-ascii?Q?u7eVT/2VKMz5RJ4PiB51nBVbt3jcZX7cTFR3d/RTEpLWTD22w8YQkyy2+ldI?=
 =?us-ascii?Q?87dNg10BMu6qJRfus4guOrel12dby3G/O1xNZifhbU4F64yVs0DfiTTYWkOC?=
 =?us-ascii?Q?UY8Q619Da6j9CcxwBS83dMcvGftho4LP5mynbTJ2+LawZoonPb8BjMf+Tg+R?=
 =?us-ascii?Q?L54vItFVGRDK1KOjisY1tELClgZPQsrQ7lFropq/emVs0Kan2DLFZCb8JfWV?=
 =?us-ascii?Q?yrF/QMjON7UvDhz+VV9lC9Sqh3tvZyzZuAsSqNZ1K8EpRUIrorBS8gG9GtWs?=
 =?us-ascii?Q?jPAjYS119FAAvtZn0R6eWeKJElVWB7E13lJ6XNzXKnAeLZmNw3lWzjWZtBtU?=
 =?us-ascii?Q?SNhKPirfivqQO4jcM0YFhWpaXHU1BaCaQMmKzO5L?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75a4efc-e935-4f29-8edb-08db610ff2b2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:15:32.8767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGIAoExbkWK2xkjP6QYhIi0DkAlM8RIE7+IeOi/b6n8n09X9UyYv5XiW1cvepqTtCSuyo3jpzz+EjQlMrXWwKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403
Message-ID: <20230530131507.nBQrVuP-QYTgKe-vC7V7ANIJ5T568IXo7krhSFsmfJY@z>

Add two netns helpers for mptcp tests: create_netns() and
cleanup_netns(). Use them in test_base().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 29 +++++++++++++------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index de8b6c68fc30..d008388554de 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -142,6 +142,23 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 	return err;
 }
 
+static struct nstoken *create_netns(void)
+{
+	SYS(fail, "ip netns add %s", NS_TEST);
+	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
+
+fail:
+	return open_netns(NS_TEST);
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
@@ -151,11 +168,8 @@ static void test_base(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
-	SYS(fail, "ip netns add %s", NS_TEST);
-	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
-
-	nstoken = open_netns(NS_TEST);
-	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		goto fail;
 
 	/* without MPTCP */
@@ -178,10 +192,7 @@ static void test_base(void)
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

