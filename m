Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9C520F8
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 13:35:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4F+Aqs4qkE8ekKFO6IoJhc0L+8zFXRYJYGzyqVTM4pV/cndo7+6Ffg8K7RftDqQIO6CCjUPNa52/8QtkPugBVDgKB3IGtmXK7nDnin+I/LYLaGvdsEX9Y0kEJuLM7TVow/mDRgSXRXIiXL2EMJponLmBWIx/c82F71f2BLldXjgYO/k80zgR+EewGExX4v1PL5AT8Gaxg8Pi3j7YnLz+sOVERoLA9k1EEWqoL44+LOgyUX6rkd8wFd9J7zjwzhLAfjy+m/r5ThMB6ov9kHKwQu1dC1WvPmr+iM/6MxhaX0IzfCHoESImKHmNtUE0p9LMlfaiGtrwTw8+2A5Jxnb5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvO+3p2zZ3Ldg5GIzcYs9iyuSERRw1RU7RGqcV6GilE=;
 b=kw1ugYj2mtilmBejhNTphirFqMy66UsO9jp1GGraaCFIcrSazJ63LuXEQdu63UScWBdUkDVUetf8r26YDGsL7EsXPYg57z6aPzr9UdzGYDI/dIaXWwn+OJn30Kl08/Hfl8ySBkDhseaSiQ2U/lYO8FJegisr6t0QRGM+/zQy1VVnkzBpslinyuCrVyiT7Chxx3A860EyHjRy9259sL3siSubNLhh/BFF+ScQns3EZbDFIngC+joyDcJyJYuENWrqf/EfFbm4WPvLJV1rMHbwNU7t34CYTw3l2YiB9ZiQeFzkJ4Mc3x5WijCWQ4lkeiebfp2Htqz6q6UytnV0ddAwiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvO+3p2zZ3Ldg5GIzcYs9iyuSERRw1RU7RGqcV6GilE=;
 b=OxQc24hR0pDsrrtwh4VbznH87gdy47ICMFS1CBO5nyAas6eK3/TujzMGBX0LI4ldVxQ2vpE80gnyX544AqWFhtfAoSl61hI0Ji4ya9hce8rhi9y/qfhvmjKumH7wilr3S65IEp81LzpwIwyw6pxBnYwUY1bN8/XQFsea+9iwQ3/sk9CtUN0Y61BtrsQMpcSjk4OcL2gsi4apFtE9YxakCkBSNsYQ8LNH0Yynqte6PJvjWgbDXYmkskgQhOjpNNrXjbPjpHlc/BAdpY+++nxJs690KnzZb4QvLEYQdgbns5hZABLIlkQctZV/Ah1NX9fq56VFmu3zBhbkz0+mKJPHtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9156.eurprd04.prod.outlook.com (2603:10a6:102:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 13:35:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 13:35:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 15/15] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Fri, 14 Oct 2022 21:32:22 +0800
Message-Id: <a03e67a73655bf701cd26be3dc58480372fdf8f3.1665753926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665753926.git.geliang.tang@suse.com>
References: <cover.1665753926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0085.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: afbc8237-020b-4127-6536-08daade8ea0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C0GCTPYucIXH0PgkeaCQ/n1kmTRa1ASmYkebtsRU48PFXmO8M4bl/U7wKH+z8jA1xO4hDrvrNWbkEJBlwvmTTnPUpqHM8f3rOOikyPFuD7jKFwc065sR5Rs51WiQBikSxse/05chi4P4YytKDFUY6H5iYeX2VpQeB4FeecA8ijUi4vLMjPygfsWvF6vMZs3Dyoy0wmQm9+5vLnwpr8F7zOWaPp9lkDXbJHJJFTppMe4ueKIW23vX/uz4VELIvEWdhMSSE6okmXG0r+beDiUglqrULTMJOoXpBJwypr3Nj7rrx9xMJkdMa1y+4vyTOexxgVYXemAec3ym4IiESkKj6STWEZej0Tx74fI4MoC3MOnHFFureQj2M1GyNVojr+/N8znj4K/o5FSc4VXKZZXXaHfFxZu/uPEB8vH7xTcQkiPAmFT8V7VII+XE4Kl3HTQvwM5UK9jXnSGHj+7cvMK/o9nZhJAmfWoY4meakUFf2VcWQQO+Fo58dRKVa9pfuH/Zx6OHPr4LVREkOWCM/BgSci2kK8lFpMd65UTN2JE/WTuxnOiiEtN95ZtWfxgFVbCQt0zP4IuIMioHVOiAJd55GSi7O3gLVBqitm933Dc+Rm44aAnlQwj+LauiDR+r3LjCGdka8yjRtpLcZpKkzjvsLt6sYzr88VB9hRtDuNeGIt5rfV3ZTAWih6XUwamVTM28bZmdJ+R5Eh+k3cgCE6Mr/TBUBKEbvLs6MqQXslyUpDoTVpffO5gjg8xaQA1XZnxN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(6486002)(36756003)(2906002)(83380400001)(6916009)(316002)(6666004)(38100700002)(41300700001)(6506007)(186003)(8936002)(107886003)(26005)(5660300002)(2616005)(478600001)(44832011)(6512007)(66476007)(66556008)(66946007)(8676002)(86362001)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PKjOEhy9GCRHzKdFFcNBk+1eTnkvM/Pl9ys9NbEI0l8O8+3oIYQETviL9Ptr?=
 =?us-ascii?Q?JF1kMsduqQB5t4JyS99+z9tyvb7wxFVdOxN+rSj+IePqf6ItkCnIElY3Xf7g?=
 =?us-ascii?Q?ybMQK5NCeZrF3GBONIJ15quJB1mhjI4c0kEnEnq1qcI4ws/21w4VBAWnhcTD?=
 =?us-ascii?Q?wnib5Chvkoa10VaVMXRdJARyJe8OdYbZhgC6kAZqZCXIqWwOo8NRFjnMhrux?=
 =?us-ascii?Q?HLqEqb0EmUJpgVOB0NRiTm3jHoZoyNxB+qUCq1eM0F4382UrVIkhc+pLNDbQ?=
 =?us-ascii?Q?Ge4Mv5BD9wsdHq+gUxldtOcGfmQL357tMw70HqNr+36HKSFYXVRDPe2aNE8W?=
 =?us-ascii?Q?/cy7MyaAbQ79yuGvvRzlFrFtXCcStvCOqWoVj5oxR+0By2yD/0Ur//9ZR3Ql?=
 =?us-ascii?Q?Kgrk1M5wvu+I3ciIM+JCiM4tkJ+vnl/jiYAQgB/TBrqzeg55XzLqsAtIfvEZ?=
 =?us-ascii?Q?3w/4+xwXVmtNRhmcK+b2TtlIAbvttX54/cuZFvlPQq9TEdMGfxjeGKym3FWC?=
 =?us-ascii?Q?AD9sS1rZAx+m5BAm9fvtHEd1xVFeYc5T33/zksj1qYF6t5den0JVr4RqLCnK?=
 =?us-ascii?Q?7uT9Ie0Rfz8brepO6nacHsbFDZ8AeJcN1aIutRmCTb4Q081a3hlA3aW6j4r+?=
 =?us-ascii?Q?eEZW56axXiXpWiAi+wxi9pwdcXLrf7ARz/GCZBoQ4OHHo8+tAgTnfIYEOB7U?=
 =?us-ascii?Q?LLNV+wFhhlVaj0BuL9nTox3ROj/AGChrj30GYHUk30Ac8Kik0XOuJP39Wzzv?=
 =?us-ascii?Q?9gJ4qD6NQCHZxGhqZEa608kNesQ+JNe/T7/I2Ej+yo9dfjJ7eswtIpgP3Tgw?=
 =?us-ascii?Q?utR6sE5TgTFyvqn1XdiE8B7rCznIhWj2E190XnNpUWujITBknGJxg+EM97Gt?=
 =?us-ascii?Q?qlgOvCyhu/M1ri8pIq6uwBpK9fBQVH0W8d0PbQOtT0qQxdRJhEBTJfGX7i1K?=
 =?us-ascii?Q?y/CX/4l3DueP5fCAEjQjrwlCfjKdbOIlg+weNmQa/Ijd/Kd021pnwSQ9rQoQ?=
 =?us-ascii?Q?D6pzJQn49OamLDOI23y1BY4nnYdJQfbecJMsdXhqQm+MIKsoZdWKeyWqpYZy?=
 =?us-ascii?Q?3f8VMOfo6dY8L9el4q0TmKr8WLxLs4oUl+63CubR2/B8MZk8qtCFVHrbK9sP?=
 =?us-ascii?Q?9F9lZRKskNNkfZifwZZ5jPxyfr7uzC49k9fowmFw1pqk6BVuoh9xWKCjGw4t?=
 =?us-ascii?Q?WKZrcZYeFArYhKqTPNuEF3YBormvp/ylvt1lc4TBIXmttyhO6v/mkP4EykFU?=
 =?us-ascii?Q?l0gBhibkeBqcq7Cd49WwagPcC020LMk99PvqP9gqAzy0jXciB561zBa0SxUJ?=
 =?us-ascii?Q?TQDXYgPrIXbsmB0MQDhFhuOngDhTg9WMa1dNbs+s34ax+H+vlqu2dEjwwH25?=
 =?us-ascii?Q?sdafHxtrP1YVySQdAYX9xQx+jq7J887djYbFO+uUd3u9VYkpZLqH/9Aken4b?=
 =?us-ascii?Q?uJvlimynGyyLhC2dgWOxA1nFQi20rw+fgD8uw/sj+XW83VaaNvkKi5+ty3O7?=
 =?us-ascii?Q?KpWeMxI4yErss72a28I5YgGyrosZQ/u+xvg2xDw+gBdnlXt5J5yrBjkNs+Ia?=
 =?us-ascii?Q?UZ2KjNjeCv2mlGYlo4kIU2+1an1fokqWguKgYvNGiwutpNrxPh35aDXSLiJq?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afbc8237-020b-4127-6536-08daade8ea0b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 13:35:10.0573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WSrQ3zX0KjmPqAUuiPdN2jwyFBF7hd6jZ1EoqY3beCIwr83VQPuBX5k9KVQprY6cXVAUf3MViQL2suaRvxWUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9156

Use last_snd instead of msk->last_snd, then last_snd of struct
mptcp_sock could be removed.

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h    |  1 -
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 16 +++++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 701cc31359d3..ee64b29bf9bb 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -260,7 +260,6 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
 
-	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index ce4e98f83e43..2d27523b5a7c 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -5,6 +5,7 @@
 #include "bpf_tcp_helpers.h"
 
 char _license[] SEC("license") = "GPL";
+struct sock *last_snd = NULL;
 
 SEC("struct_ops/mptcp_sched_rr_init")
 void BPF_PROG(mptcp_sched_rr_init, const struct mptcp_sock *msk)
@@ -16,16 +17,22 @@ void BPF_PROG(mptcp_sched_rr_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_rr_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	int nr = 0;
 
 	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!msk->last_snd || !data->contexts[i])
+		if (!last_snd || !data->contexts[i])
 			break;
 
-		if (data->contexts[i]->tcp_sock == msk->last_snd) {
+		if (data->contexts[i]->tcp_sock == last_snd) {
 			if (i + 1 == MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
 				break;
 
@@ -35,12 +42,15 @@ void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	last_snd = data->contexts[nr]->tcp_sock;
+	return 0;
 }
 
 SEC(".struct_ops")
 struct mptcp_sched_ops rr = {
 	.init		= (void *)mptcp_sched_rr_init,
 	.release	= (void *)mptcp_sched_rr_release,
+	.data_init	= (void *)bpf_rr_data_init,
 	.get_subflow	= (void *)bpf_rr_get_subflow,
 	.name		= "bpf_rr",
 };
-- 
2.35.3

