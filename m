Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D74E2F56
	for <mptcp@lists.linux.dev>; Sun,  9 Oct 2022 15:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SU6q5cykqVnPFQGnKNA/SZY2yOhmHSqqM8LD0B7VACc1GQ+/Gd368gMtV6kfQZf7MlzTBKiupQwQBx39gOK/VoU4iZ8xtQkiQMTCS7VxpQSM1Ytu6LH3emWbR8kfIZrtnc4QOqo5hfZ4qHf6lFeYz1Y0nao1MEZmY+8Vp7IqdiaV6HDL+T5e0E7TW6/nqE8jsuUv+ZhlLSXaB9lOPmfMQ1QWmi4u9dPmCI4sxURhVzJCBarCFfQfFjluqZz9PEw/i7x5sun9BNHaZHXCD7jpFA3JrI9cod8LoQSMxIhhfq7EtjtgLbFdiL7cNpHabYU8hmQKkaS7gAGwMiWkbWWKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEgzPTNJ458NGlYnEHbf56MC4RpnXSIAD1JzeiYi+h0=;
 b=FNF1WevT9QuolAYQm9ShZ6lAhhImMTyUVOO81GmvtbLnHaGeDuTM/ob2yNexI9JGaiZeoxpMeAVbjRua2hmcyUko6ZTZ6iwDC5L7diK0uP+7OtteaK0wzB/5R9ol4yUBV/6shV9W4Vj3ljdmOP5rMu2XAH8hHJtq5WJPw6gSd6vPlyTybPp5vL2cNqclLhPqrUCWVvoA82JaH9SCJYLQtJ6HGxDerRRp3O7wSuE1EWQgUlI8HKv/jTkbNboVlZJM4zE8lAiEzOwsIgpqY5nP8SPXdl4kOp+C2hpGzR/Slq6BIdfV3uBbpXvGWt8vV7dy40uxgZu4KN5VXfYlzoVjdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEgzPTNJ458NGlYnEHbf56MC4RpnXSIAD1JzeiYi+h0=;
 b=RF7C2ByucaykZmYJ8ZmpTgqVGC5DpUKS/OX5/+nE9Z4ch8ebmQzcT9pfmNG56DIaTNY2MmAe9i8m0aeWu/S4qIk8dgnsh99IJn0ZktBDRmwUQxFhEj1UK0fUxa1Kex2kACOO+6oF5FXaPT+8uv7Xk4Y1H2UWGp7BzZUBtPjYQiJ91spZGKNe47tc7hPSNkcl1QH2S4+REaBE43xOeFSftsen2jUfvCLH3pxInMw7SV1Teqy0WTbBCPzqq6bk1ityweZkX/fs3UK76T3WMm3XEgtDngujGNTaIZ6pJtCl6mHcbaLa3pkeadgOm9TfSSjAfGM5p+P5+YMasQkxfiHA2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8853.eurprd04.prod.outlook.com (2603:10a6:10:2e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sun, 9 Oct
 2022 15:44:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5709.015; Sun, 9 Oct 2022
 15:44:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Sun,  9 Oct 2022 23:45:31 +0800
Message-Id: <20221009154531.11543-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: f7826d3d-0986-4042-afcd-08daaa0d332f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qX+122YrLqSB1ejHkjqfWFqxeU1KEHo//QGEnAellbnRD86muxw46RAp50rLXfcB0ZfHL77WPTyFJvepkf6DCCJQzcaEIigyMVeM/aqmN6Zg2r+CASaaGp4p6p0LMyzfv8tpmVIaVFFBl+Kg5yFt06HP2Yl+RCz0SwIqhPhi1+LS2T+x1BCV50izZFl5zJndOV/xTXQolm89ySDBNNe8EO51JlbLCnO54XeyzGeeDHUJBhoEXAGWrUZ4IRID6oTU3mLsbrNm2ASeUKNfmklosaQxmtFbo+Y1XciULIHrE5zzbVaNddbE1Wi3higO0SzBmZq9GO0VR47dxV8/l32jOM+pjS4SQtLLlsDv8wCqtrIwyqP+Y+NX+KzaSKnx7qrxaA9UfzliZBNaaqVz/AbkRIAqCw5RifJb3MoDzVgbTyXnF1J+vkKPlEv37ZS2UkyodIgC709JKlCtBaPVDXDbsuPCwhMHxahCwzcMxjCfdjjvWMxTe65yO8mutAfAnxDd1esoqPKLbqOlP8QFXQJczC+IZKU0Ba9gQFCNKCcyponl4l5sRDNGrefXmB62r1dozNmAqTqVB+37c5anvp2xifES9VGcBWQPdFp2WWeFEWp3b++zFq+80IqyIyOdr2Z3Avvsv30Awkk4dXR9TRriMR7meRRNLLyw+tYEM0T/rIObNhFR6UwzQMdgySzuN7F1MJy1AjTdCiirjxUKnvD5PCwKDXtPW6MKqwkpF0SQstYG3P8Ky/qVXjEYgnmhAq8a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39850400004)(376002)(396003)(136003)(346002)(451199015)(36756003)(6506007)(2616005)(41300700001)(26005)(4326008)(66946007)(6486002)(6512007)(66476007)(478600001)(8676002)(66556008)(38100700002)(86362001)(1076003)(186003)(8936002)(44832011)(83380400001)(107886003)(6916009)(6666004)(316002)(5660300002)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?chxfMWTKZULaSl3BaUq4iyvGwWdy1h1T3EEly0jbU4G/wZ4RTT3cPG/FfKw9?=
 =?us-ascii?Q?Hfr/WFKNYZeRzE/dInVE8rlKJ50qyzSjQQ7KxUtM8sl5pWgy0MXE5wm6Sygh?=
 =?us-ascii?Q?9C6yXxPZrenBg4Qc/FLxmyPzo0YJpzo6v0mwEeIdHrkOabqtTYgHdxBSY1WN?=
 =?us-ascii?Q?OqTMOmxBsqN6HDx8+c9yXm5xnjKfzyhkMglENCFUC8tYB48CrwdmE+S/4FUM?=
 =?us-ascii?Q?JH3c/tmUsBbWsWfT3EdtbuiLe0u8fGIHHgnL4d5xENJLiwGsEkSkJ+j2u0PS?=
 =?us-ascii?Q?Hy6MDE3mubMWsTfYppJZCa9ErirfvcUd14iFo8pHElOhY6/vA91+yZ7JX7Y8?=
 =?us-ascii?Q?LStMt8YHNcjEzzCWJcImhob2Y0uiam5hq+FvRCYsraydUk8SHnay+ChLZNl9?=
 =?us-ascii?Q?x7EjBsxbWTz0ZCgCc4CaZY968h5OS3YtuLglzPengbrP1JWcMbM7fF6JOr4+?=
 =?us-ascii?Q?qJDofwSAmDoHvj5a165P5Gfb2rWrL4QsOP/OJjTYNvhCFVMu4aHhjuA69EO6?=
 =?us-ascii?Q?ga0i3QWwxV6YK7hInQ2/BgGpDZlV/5MhcYqQoQS+DWSPX7UnatNRc2LizGYw?=
 =?us-ascii?Q?uon+U61GeUy2NZFidU4sjbT8SpNgMpP5RzQbJlds55ZzMB6/bW4F/Muym5VX?=
 =?us-ascii?Q?kYjDPI68P+ojNKekmrWN3XYIr8o936pTY0Zt+9OxCkFPzMKtuz4tBrpE9DhD?=
 =?us-ascii?Q?6pImM9Z9Z5cO7BRKIh1o/nngZoSIZ2/C4a4P5CPDEYhsN3hN/5mRmGR1jTb4?=
 =?us-ascii?Q?8Tu3u9P00kmDgiZMwlnDUK9214t+zQhM/+fcU5fTq7hhAQ6LuD/pIGYncM9b?=
 =?us-ascii?Q?jpWkYkaIwijL3b+lP8hKmV2TF0OCISyRa9wcynHBqR+ZTj0Qn0RDxS3gFPG/?=
 =?us-ascii?Q?t/ZVq1HcK8w3KgNQHKdAax3mgbKH2nKpAdWK9Pp3yOPWGQ5Av1awm4FzJ8xr?=
 =?us-ascii?Q?WCkr19dVS73OeE8ejbMT/P4ilLGG27a1ZdQIOGU/j7dVJs1TdfNDhSI1Ue96?=
 =?us-ascii?Q?ljE7yvimKi9ELETtvlicczcOkVEh9jZC0vO9G238sMy0OZfsc6ZGZy6ChE+w?=
 =?us-ascii?Q?dPHxy4ed9DJW6nb9PmqzxGFMoXiYeIWV6uwbT2xS/HBtOmQI1m40psM4lpSM?=
 =?us-ascii?Q?5AGgS5lCvmAhSf4tfMlENCSO+xkglbhLGU6qgMN0MN6eGwKzgIX1RMvWsXrM?=
 =?us-ascii?Q?UPhF17Qpx5DvG9rF03c+4MmZ+nH8lqipk8fB4tc0lPubHfds0o3eemlE8nEE?=
 =?us-ascii?Q?0DWLcwoVog3uxrYEdjk56RIVgfM4kZZdG1SdnkUiLc7tXyQivPKWgtW9x7xC?=
 =?us-ascii?Q?HKi39F1f9xWifnx0CgXudVoQ/bJfVJaXo5h+WTDi+sxqaMzawFUyZY58oGTb?=
 =?us-ascii?Q?qZO4i1RA2Ryab9QDOL79HLVuzaIC4Rd/sZd8IhUWYsb80ty7C5k/xc+ZzLz5?=
 =?us-ascii?Q?YlGsQlGwv/icywT0Uw1D8EmtnP3BKQzA2zlO6Dn9gnmFNZZTIgsOtKvuNAMQ?=
 =?us-ascii?Q?FbCaZ5qC55S3hb3jHpdmn2mcLcwO6/MSSSDacWeXnMuVt2eXUrshka1eZTV8?=
 =?us-ascii?Q?XcXbKmu0H+OcyxHdNu0fVqfm6w3creQpMk6YItNxFhKg/JDK1cny2WN1XSQy?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7826d3d-0986-4042-afcd-08daaa0d332f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 15:44:50.0156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ge3F6vlZ6pJgU7+jWEX9WCr6oaLAyU3ZiPJVrPbZ3elqCq0Nknzn9+y4PEXnr2ufI7LWX9BuoTOJOnAon+cTMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8853

Use last_snd instead of msk->last_snd, then last_snd of mptcp_sock could
be removed.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h    | 1 -
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 7 +++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index c7d4a9a69cfc..c8792e6f125a 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -257,7 +257,6 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
 
-	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index ce4e98f83e43..65d4f7f41bc2 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -5,10 +5,12 @@
 #include "bpf_tcp_helpers.h"
 
 char _license[] SEC("license") = "GPL";
+struct sock *last_snd = NULL;
 
 SEC("struct_ops/mptcp_sched_rr_init")
 void BPF_PROG(mptcp_sched_rr_init, const struct mptcp_sock *msk)
 {
+	last_snd = msk->first;
 }
 
 SEC("struct_ops/mptcp_sched_rr_release")
@@ -22,10 +24,10 @@ void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 	int nr = 0;
 
 	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!msk->last_snd || !data->contexts[i])
+		if (!last_snd || !data->contexts[i])
 			break;
 
-		if (data->contexts[i]->tcp_sock == msk->last_snd) {
+		if (data->contexts[i]->tcp_sock == last_snd) {
 			if (i + 1 == MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
 				break;
 
@@ -35,6 +37,7 @@ void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	last_snd = data->contexts[nr]->tcp_sock;
 }
 
 SEC(".struct_ops")
-- 
2.35.3

