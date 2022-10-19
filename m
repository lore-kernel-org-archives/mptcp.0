Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CBB2F47
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 13:37:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qa/VaYoPxdre5Xd7JFWCQO5BU98+WaR/qmUVa9hzJH5T02NK7qGuFUmG2t8vnXot/mOyh/jJ9PKDc/gNL1J0NCTw6MOryF3ZJmpXSIJikMPxDwUO75yA1iiqqi5nGOCLCK2CKD5ruR0sRVbnEQtscWo7fqioNQ2LTmSJ2QsjB4yhpvqHNmpVxaaqCSmGgFI/XTAXNsQaUhTBDUOJFta8ASx/okJfNhACdw6uK0a9jGhAat6zaSWbI0gqIsXOo9/r2BH1DqymFvxGJuYjw45q4EXwgDH1CHOJ+TD7yP011+a/rPjrjke8AT6BG5e/XZDofpDM5BErGnEKLXme3/oiaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=RWDylEpY3wSwSWvgf0CmaqiEhDBn3Hd5QfEc5pKt0YyfHKJug7jT5Oszqddi3VCnUkrXTHnt3eZ48tY9X8GdmyYrwtdF9Ks9EkBFabgB9H0f1zOiSFSNWhmLiadU0j9a5PRDgMou1nWb+9CmNeVmxpSkjBBqqmaTQl1e3ySSui8U/L7GwLdmCFEr5EnUstSiye8cMM3gEB9mOkKbNYzIvlDwH6QPmaknF0k14xzfUwszCc7PFdRK+KbpAN+aRul0ZpmspapgFZt3ARzdXzqwvy5bXYu3sXV7/8ALCga1C5nR/Kf/BiIBbSZLbnFdF/UZ8J7XWmIoQ0tJjafOWUyAQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=xrlbDDKJzdekRndTGZxi6KKJYTAN/dcXkV3klEOCnyvOHpWBVEdjuxjI9yraoX+7DaVaq3SCinQ2Fn7RH8elh9hA2duaPtCWqIERTsc9R+KFlH0wi1Bg/3viqeQFlacFaZGgrl/IphMGhA6xVa01JJsuo/+QntW/O1Y2ckPXM4aTp3LFgsY8HNQGnMk8Ae+0lKVa0gTB6fWoo0e+hzthszCLtuQAvhTpftiwwjm9Oxfvv+bUmOVj1c3+2+cAeRC3GrfYnGplO+DMaH5rp3/LMVwya9BXWLf8ooo59aJKMw0l8v3U5Kg3jMULeyDLPryjdiBhLwmtsd/OTVYDbB9WsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8261.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 13:37:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.032; Wed, 19 Oct 2022
 13:37:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 7/7] selftests/bpf: Add bpf_red test
Date: Wed, 19 Oct 2022 21:36:05 +0800
Message-Id: <f6a931ef6854824fcfff427648ae384bcc0d1ba2.1666185947.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666185947.git.geliang.tang@suse.com>
References: <cover.1666185947.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0154.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 807737a5-0231-418b-89ad-08dab1d70b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0VB9M7L8EVRZdHKUFsWIrTJkVcIGY1+mv2jSH4fSlYv4qkljihSawyRRX28GfRXib6Z8N6KuL/qBwMeNcL7S4uikRqspLtPMuG6GULrZelR6Y/Xkw1Asn8VtfSRDWEyBpJ/inCSXwqzWzX5TtisUn4HPqNqVY36DjFuxm/8pOX8G1xo7TrdIaIOGu9WmzAGcTU5ejuaXZ/zfFX4VuS/JmdXOE1Y9QDRhjpPQDllEA/XoxJr6gi96ic094TJ27bAArZJY0rMlUxAj01H5VJauLBWEBDjy2xOxxjrpAxtxoiiEfJFKbsDyHvNpHs7hgBMk9dkTAK670dS0kugdi2uGomEqFPJHBIWRnZOJMUXiojlyADQm+1FnGsv1QAnSewgXdD+OfoIgs1QU9YRpBpAAPK44j6ysC7EL161tZgA1XN9tLsT+yvcR+iOt+eP0QAgd5vS192MQp03P2mCLUTKH5j8PMTQFV2wBxJ8paicR7GRai7iuGS2RkQ8t5XEFkQDeZJmwWAJyehrCRqRURLDyd2LnJ3kgI7jUZYfpM09myIjm2iXz5VX9h/j+ZA2UP0NNN3isi11JZiYwMbb43ywKQvgelKUGU6Q3lq6o/IK7wQaPO0oV+k+JkMNBHzVGh6bQaGAUkBc/85LntrisGxG2+P8BGCpaedVUCwOkDfrRa7eXLnQSBdiD9mZFX6nWfbf5WIMLMyovIAC+Dc+dcE8httgnX8OLKQnHeQkx1uQpsriw9mr4TtKxE6d/unCIoWGC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(83380400001)(36756003)(86362001)(38100700002)(6666004)(107886003)(66556008)(316002)(6916009)(5660300002)(44832011)(8936002)(186003)(66476007)(2906002)(6506007)(2616005)(478600001)(66946007)(6512007)(26005)(41300700001)(6486002)(4326008)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fNLPEnYQDLNO5H2nkqS0FvsikT84vBiXwCygxCsauQcZT9PNgFUmrTg0vlpZ?=
 =?us-ascii?Q?tNKb6/nbEF39rdYkg/MfNCCI5Q1Wyr0gasAM+kQP7YL5HDmnpDQI2URLxyku?=
 =?us-ascii?Q?N5Ca2fIW8b/JG0xsNlfg9GILYZwNP5UYPTItqlzsWJSBgcLUCPWZcS783o1y?=
 =?us-ascii?Q?OekpftEna0GdLEEzxhy8jh6M8cVxIKTx8N/0Mu7xVfxpHxEBupLLKVqR7QOd?=
 =?us-ascii?Q?Fqb9B+oFGmfxZo6NViNcmXozma1rrBwikCsHnM+It+IeWmkleVbn6dVHclMf?=
 =?us-ascii?Q?RRJrOQ3Sd5lsqFl7vnfilRLIiiVBjhbBq0rNjOautZXdkWeyRKJ1iKqmao+R?=
 =?us-ascii?Q?6d+6GqCyxOi0fM9U1rfiQXjqoA3r5rX7oUg8NEqmb95LTydirD64prOdvReV?=
 =?us-ascii?Q?6SkLQj3cb2ijTkmaMNLgHWPkVXUtphKcESzgTFn36OsWckoNGioJoo0Ybwc8?=
 =?us-ascii?Q?4UXWfWf4YJh6JGXzANPsZ7CX0vTxZbHVupK+S5EF3dsZmnvp7GjeoaFH+ht5?=
 =?us-ascii?Q?BWdRsg1cMol3ydeIYElNPyebUWeIpdaKhrowLM+kyEhtcfZfit5g7KI94voI?=
 =?us-ascii?Q?rC704t7KqBv9FNifMIEQGx3AQkmjObeQGtnETc6uTE1x6tuBEg2TdbyXkNhA?=
 =?us-ascii?Q?nGzCU1t9WmZKr8rFq8+9QmEj8cgjoomzEBhhEaIWDdhpgaBxeTZWA2/sHYPD?=
 =?us-ascii?Q?OL7fJFTo1vG3RjyOyzWh2hbguoSe0DWSmVaNpkz13HF0hI29brqygmVnQWEx?=
 =?us-ascii?Q?MY+dpcH1gUfNQUBqEI4mrESbWZ87yrM2Ul4/pO0D/32qmZLjoBE53SLp+8Ye?=
 =?us-ascii?Q?TWIgXbbfOXjPDgDc/1ceCXribm69A6Tx7Tg/9vpb8pJvHt0X/pLdkcdLI1k4?=
 =?us-ascii?Q?SCYB3EDkTAnGIaROrg6DCn7cj0IUlHe9HmRqN42XAw555YRstPyUS6Rh+ei+?=
 =?us-ascii?Q?FTEX1lnLS30COqDlSLMpJnUo0I06fFPmhezEPdEe8r/HmDhZvWW8B7Q/S+gn?=
 =?us-ascii?Q?mHm+GVdLiPL+LXvpiDDMf7Q0RQxY85N8i+bmiV4RNlueApoBIcV7SKQ0ZDsd?=
 =?us-ascii?Q?YERdiuhwf8lHxcv+V8RbknCseAoQF/Wmi8IW/BIUg/28fWciK2ixztGNl8WM?=
 =?us-ascii?Q?UxEnXm+hG0i9raLZjKFGCsjGa1Z9pSmeeXp9x8R+TzNOZWLPIljp9X/+xuss?=
 =?us-ascii?Q?5dLytWhdoDF7gDh0IXfL3BICbzsZYCeVH3oCxOQBSWI/JnGvyVE/ZyyTbRon?=
 =?us-ascii?Q?gc0RnWtb898bNlP5X4h8Y0HOzy9I+uy/UtEL4CK7K1rkmADVejTKnW639/dw?=
 =?us-ascii?Q?ESDfMmOJQ+SyKEA8y8C0BKVk8i+FWui2npRtHovXAmiZWxzIpm0y8wGHs7l+?=
 =?us-ascii?Q?PZcYUa6JVU1EVi+YJEsASdrjNL8ZHHcRqLSUkVO9Ps8QZ+1axP7znrcCLCry?=
 =?us-ascii?Q?11JL6MqIxxB+Rz/cOibZx5Jhhm7JBVXhbnYHPJkOUXo3TrlhvmHaac/595S7?=
 =?us-ascii?Q?Z4oZO68RH+M9L0jqwRfFimLNlefZLMaLmcK+WWpRDrCeiXNJ/um1n8WeQE4U?=
 =?us-ascii?Q?65V60f8osbC78Va66toqekiG5FWea1OmMp5nnbDsKVOW2AN2J3e9jM+HOMZR?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 807737a5-0231-418b-89ad-08dab1d70b05
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 13:37:18.8593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcsnoNHkR6fFGN7VXuPlRnx+85a0O3mWqTsY7p8frBfeiweZIJsvsCorDcEELUrfNozsG9a5IicmKViF4Ate7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8261

This patch adds the redundant BPF MPTCP scheduler test: test_red(). Use
sysctl to set net.mptcp.scheduler to use this sched. Add two veth net
devices to simulate the multiple addresses case. Use 'ip mptcp endpoint'
command to add the new endpoint ADDR_2 to PM netlink. Send data and check
bytes_sent of 'ss' output after it to make sure the data has been
redundantly sent on both net devices.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 647d313475bc..8426a5aba721 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -9,6 +9,7 @@
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
+#include "mptcp_bpf_red.skel.h"
 
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -381,6 +382,37 @@ static void test_rr(void)
 	mptcp_bpf_rr__destroy(rr_skel);
 }
 
+static void test_red(void)
+{
+	struct mptcp_bpf_red *red_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	red_skel = mptcp_bpf_red__open_and_load();
+	if (!ASSERT_OK_PTR(red_skel, "bpf_red__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(red_skel->maps.red);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_red__destroy(red_skel);
+		return;
+	}
+
+	sched_init("subflow", "bpf_red");
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	client_fd = connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
+	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
+
+	close(client_fd);
+	close(server_fd);
+	sched_cleanup();
+	bpf_link__destroy(link);
+	mptcp_bpf_red__destroy(red_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -391,4 +423,6 @@ void test_mptcp(void)
 		test_bkup();
 	if (test__start_subtest("rr"))
 		test_rr();
+	if (test__start_subtest("red"))
+		test_red();
 }
-- 
2.35.3

