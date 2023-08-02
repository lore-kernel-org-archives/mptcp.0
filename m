Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2068.outbound.protection.outlook.com [40.107.104.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9365C110C
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 05:10:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1NPhdMw413lDxexI0JMalJZxXwM0mybpdSgqumjuvHBQQxlRBs43MrZxUU2g4ya4iAuxIQFpVxMCdEXClw5l83v5RXkM80tD1g5Ejp5SAoXR/K4PHp/lVRm6ktMybtqRBHRfNwDuwRHnGXsv9gfvehJ8We1jdD7k0TqwheI3XOhUtNAi9P6jk9xlOdcAjAG5jSz6I/RV13RJdiss0Bsm1UyP6s3gRWUUwqZ4SvZYilf0gyQB78sFuT7TfceFta2Gq3wPnX1vvfBJkRBZJ0HZlla6fNQ3R7aThyKsm5gsjgUCoAY4Ok8OFdNg0NkQ3vHTekNdbGvlNGsmd6qX71o8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKzKU5Gd/yBxw9UlqmeDsyGKToCYW58FIU+teWZ9hVY=;
 b=athlusKzMRkmjCfAWJARojHfKJWihUp/+m3F/paLQk5VTASfZDGJZzmv1U/JThTaUDUb2XW65pPj8YQCCNc3NpxvAabVlVM25ceszldSqinL0ZV1gP5ClmFmnS1ZewVUO0SbJMf4sYAnKm+0Qk9om74vGv9TNF72EbAYAk73ob7uCzjzO1VuyepP8oGqeo5Nx2jpWJDuN+MCz4g/ZWnGJ+x7MTnxTnllhYewfcH6wvN0FBy2rSiyVTBpQVPduXtVqoSQNqB6b6LJMQYr9OLaML3uRyDUZBvPNmJJ4oQRRkM1awWY8YWT1N7c8abFfrUwa4xpX3vY9mNVkZ+qTQeI8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKzKU5Gd/yBxw9UlqmeDsyGKToCYW58FIU+teWZ9hVY=;
 b=PCvA03OUsdYVSUPGovhceICxyzP7MRn5064vQahhWRlhf9PwoFm7AUILcKX1b0fhVMUYxgQ82Wj52dJAm8PqsaQAR2PBJzEjv1Gvjiqof872tIW1P2rjSM1bB9qLDi/lCecR8J9g6bSQb6ro5Z4Twb2F2i8aJWLgu1hlukJ0wERQqeQ9VHfoL3vyGGNEdVujJO/88SjxW3Goc8vEGboNUnfz9RoJ0qjbgNoEj0OlAGSUcQcgYe2hs2uPozYj8RJCmEnQ//2tqWCRUPxyGQpda8le5aYPu0AS4U5XFZrpPENqTgZuj6+xwXX3D7lK7Iodj82gE2fYsZ9e6j0BJBliFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AS5PR04MB9826.eurprd04.prod.outlook.com (2603:10a6:20b:673::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 05:10:52 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797%5]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 05:10:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/3] selftests/bpf: Add bpf_stale test
Date: Wed,  2 Aug 2023 13:10:20 +0800
Message-Id: <5dc7f4dbc799ddb5937c24dc002727c0fa27b70b.1690952908.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1690952908.git.geliang.tang@suse.com>
References: <cover.1690952908.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0040.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::15) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AS5PR04MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9d6d79-80dc-4ac8-dd32-08db9316d7b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VDD83Jti/z5J7VpDETg867qws7viSRczBYxnL1FVWDAD7KyhArKR7D8cJiQNfvkI+J17iH67u5gvpbjvbpTgsGrbr06IwqlWbaHiDhCAGc5sNaQ0jTcbreG81+yGlQvwCgv1A6BGBfCxPhDUEyCrIb2r7pWvJ9UhWD7MU8cStoUkv5pjo429n+wwqRediyy8OF6rfoooJIE7nDCGf+5NkgXCM0+hY+JjefJ8RA83xpOb9R1F8lCYYS8rcyGsygjNRv+AYw27B5XFV/TwCwXZFlWwcx5P6PWeSA8yGIJjzzUOKUBlLcvPWauJmhj081nu5Xqz0g8E+OY08oRqw8IDPhknVdhJfc1WvYSeSD4CaXuUc5vGEG+TT4jmBvyQG1Njt6mPKKE0aexBxfmp6a4Pz6HO7nLodxgJkp8Sc7YjS/0upptdC92WAFVTSJsKkbbizb154NTIlLLiwWE2NV47HD9bcbljYH8Bmg0ITB1V+nRJGTKy3/eEjx4/1X0cWF8bwN914waGl+H+nec+AEDiy/74k6MZqVLT4GrQnZa8iXYSIRCrtn6NKBxIjJ5FECcMrhf44W3utejpmpFrafTVscD8t/PBE9S9Cm706soTGQc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(44832011)(66556008)(66476007)(6916009)(4326008)(66946007)(2906002)(38100700002)(2616005)(186003)(6506007)(26005)(83380400001)(86362001)(107886003)(36756003)(478600001)(6512007)(6666004)(6486002)(41300700001)(8936002)(8676002)(5660300002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S8nbHXilGMoEM9oEAwoZAJuXPv7jFsLsf/BQm3jjjA0Y1oAtwFMUfNTYB7w9?=
 =?us-ascii?Q?tLrhEWhGKEEkFRW50ILiN5bUsLUGt3ByobjcjjSKtmdhCZZ7x1jYmWZJSLUN?=
 =?us-ascii?Q?NF6pxfKhFnACuyFwEfVOIQuT6SEuZ7cah6Bjlp/7NEqk6fpUatocWzF9z0UH?=
 =?us-ascii?Q?bf8ZmP1m6a3zbpM3xltMOmbARUnldQhpf3lVc2ipaEUCcndaMGzg0MQWI2mE?=
 =?us-ascii?Q?gf4AZ8qYejPTrngm7KnEcX2uOyYti0iDIfXGF/BUgQT+biAhhs8e5qXkZjM3?=
 =?us-ascii?Q?j3MAFlbK3ikgWYif41DJm2yOWe7RNdzH03DVMHcy1EJt9I8zDoG9FzTVoR0y?=
 =?us-ascii?Q?bnSqCmyXkTQmQ5/8cYhN6KXDTS2cicr2/+Y6ErOl0GN0X8eqK6ZjnHe7doIM?=
 =?us-ascii?Q?ei/cRJCu03n//9AvRi0JTHj6WqlMwSzMYSzU9tIYfdVil4bJaytyG6izPza1?=
 =?us-ascii?Q?9D+JUmDChlFiNa+jlpdBNNssVaBePkyQOAJQDskggknXXlm3pjWLTbXQNn84?=
 =?us-ascii?Q?C9biV1Vin5/IpiXYercPl8aZEoYDxS+GfOp7ARyT0/L384BLm5/SEq7l/Dx4?=
 =?us-ascii?Q?E8zwXNJcJ7JJH0iPGy85qOnFlEWMmiCcpKDGuSIuffQz7tb/n+CIHhA6QKGp?=
 =?us-ascii?Q?s0/bNpNZzIcEQ98ZRktcm+MWlIa484nmzehGBAN1LXkK5HPC/NGxsa2jNF4y?=
 =?us-ascii?Q?K+yT4a238ocp9BsYBhvc5EHDnQ/sd6rtBWahpkpTZdpgGeUiZYoEizwNyNRx?=
 =?us-ascii?Q?dlw0jYKTtRAXZtKq01BVnFI9yTQL47Rh0rXjNZP8dMIS8WBHc7tuLiHCQ0Qd?=
 =?us-ascii?Q?nl8KfEtqZPismNdTQBwDUD5KwnSt/9/UpPz20kS4Gvzb2ckTN9o6Y2VEQTon?=
 =?us-ascii?Q?lPEjheChOc+WTA0eVmOwpd5o5B87+gJYGidOzDoiqpYQNTMShmGqKO9ZLFMI?=
 =?us-ascii?Q?nujnKvUFUU/W/BkBOFDq0lHnzPo72c16NUeDSR0NbAGmoFsfuebdnVoPXMGt?=
 =?us-ascii?Q?qbgI5fCAQKYKZ9wzA1gy7jhoUXBt1a7NyTkGO2r9gut3/2r3rvYMNaZwrMU8?=
 =?us-ascii?Q?6TDuuhdzepWxS8dg18wtaApz+cLGoNQOR2wAwphFqHujc184CJ+6Q6J70N0+?=
 =?us-ascii?Q?pWTmQaRbd5cbFD6Qvvwn26KfE5reZQjor1qy/76JZyB1R+3n23jlM+uUnj8G?=
 =?us-ascii?Q?s+fhu/ovxsMz5QZ/C7HwW4n5YO+IQkEcdn456SGn/EKmBHysPQKoeAWH+e+b?=
 =?us-ascii?Q?WLfXr0UOh5rBwfHDst4AnvMqoOvi4Hn78N8zS7xMdL96evC6mY7EZQ0qE5mS?=
 =?us-ascii?Q?RfNOf2Jg/lXxk7itSM9Rr/KSOpAFyKt9CigXyT6LRjv8leFMknyNxopTmgLP?=
 =?us-ascii?Q?HCxWw51U7EY3zH5fR/SkWJi/zzqQbXB9nToocvTpaty89oiSD3bAMH87j4eL?=
 =?us-ascii?Q?yHbE9I3l2TdDL7By6Xnki7M2cIKPUQiYC+GefYwQVvwjPnr6uoWIFVJqeA61?=
 =?us-ascii?Q?F+7/4BX8smtSrcS1Y+PDQZh3y4Zun5yATvNFuIjVxXaj3BMW+9Z7XFw+POQx?=
 =?us-ascii?Q?9tOzOm/IXDsejuqVpYE37sJXC349MUQRCDQj2vNy?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9d6d79-80dc-4ac8-dd32-08db9316d7b7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 05:10:52.2175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfGAkYjpcpWtBoc7WgnUzPocsXq90M9E6Mfr06FPyER1sKf0Tx1aD2ycwqw0zzyZRwVYTE8uSM/NpK4xbTNf/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9826

This patch adds the bpf_stale scheduler test: test_stale(). Use sysctl to
set net.mptcp.scheduler to use this sched. Add two veth net devices to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add the new endpoint ADDR_2 to PM netlink. Send data and check bytes_sent
of 'ss' output after it to make sure the data has been only sent on ADDR_1
since ADDR_2 is set as stale.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 09770aa31f4a..5accc34d35e5 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -12,6 +12,7 @@
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
 #include "mptcp_bpf_burst.skel.h"
+#include "mptcp_bpf_stale.skel.h"
 
 char NS_TEST[32];
 
@@ -524,6 +525,41 @@ static void test_burst(void)
 	mptcp_bpf_burst__destroy(burst_skel);
 }
 
+static void test_stale(void)
+{
+	struct mptcp_bpf_stale *stale_skel;
+	int server_fd, client_fd;
+	struct nstoken *nstoken;
+	struct bpf_link *link;
+
+	stale_skel = mptcp_bpf_stale__open_and_load();
+	if (!ASSERT_OK_PTR(stale_skel, "bpf_stale__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(stale_skel->maps.stale);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_stale__destroy(stale_skel);
+		return;
+	}
+
+	nstoken = sched_init("subflow", "bpf_stale");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_stale"))
+		goto fail;
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	client_fd = connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd, "bpf_stale");
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
+	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
+
+	close(client_fd);
+	close(server_fd);
+fail:
+	cleanup_netns(nstoken);
+	bpf_link__destroy(link);
+	mptcp_bpf_stale__destroy(stale_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -540,4 +576,6 @@ void test_mptcp(void)
 		test_red();
 	if (test__start_subtest("burst"))
 		test_burst();
+	if (test__start_subtest("stale"))
+		test_stale();
 }
-- 
2.35.3

