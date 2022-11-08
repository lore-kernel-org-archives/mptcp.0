Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2052.outbound.protection.outlook.com [40.107.104.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D679F323C
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 06:45:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlDYeF+VyOlMNpjBDrN0KAg35g20WnVZ7LpFV5L5cyt7UgN0YENfTCP+I4T6XgirIE7COkUnOzHQaUm+YvW6wkf54UU8FhAcaR/k7pDnD2BBEsTz7zHVfBeVntPY8cFgG4fhQ+JNHQP/ConfXQsMjBBDRZY+rT63WOGFHX0n7CN1rCHjru+8izRvuF2vbO2Ey026oc/E+KsHiOKm4StjIEykaFr8mbqp7peRIn8h6g4f0kn2C8Q36EjmQwDMQllFeEKV796YiMGA70/IHfc6hN2Qa/vQQ4/1Q0MHWtV4reT/nvkSbt0Gp+YGNNzGDyLepoAL6te+K0WO+3Rou4dMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKrkdCE87NzU+XdrELRcXHVhJvKWasTkIYQ0i8XCnJI=;
 b=dCUXXmON4I8OS0QLpIKQb4HIDFRVgIhK5NMCKyHbVerCv1WNRbtW8HZ2IMH4XoPItLUMkQmo8eQnmKeVtPSa7KprsXaWDnXm9KUQR4PnjfrIqINOFAv/YzjvMpp00dv8519AyglepbvveI8wJmOLk841PWwX0HTvBsWQMDN6C4MZDAPcOgsKvqpRjBWUm5l4FJKwO7PBoYMaewcXqfHW9H5o/fBW/CqcW2YrDea6kZyvzSTIpGppPfUGvPefNv/1GS4jTOsdcPQ3DWbTLb5RrklI9ha6y3kv7KwBzWwAl1auLItMK7I+K9D0TpfdlCM+5HVOAtNUgI4+iVYKR76rnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKrkdCE87NzU+XdrELRcXHVhJvKWasTkIYQ0i8XCnJI=;
 b=VjpyikWgGgYlIKkgi9Wtd3if5cpYiQCQJ18BfbMv0mkuBud9ZjzF5v4T3fD4xLIX3uQ7spdktSdZKGE9Jn4UtfCbw3tb+nrTC3YqxYnWj4WpSjIsQAlt/FvpP4lfP4VVTDQ1+YYMud6IczE2++zoN/n91WRLi3x1Un3wjM9B4bQ4R267GkrKs28d1OUXOEVkxVMCdk3KcbIG1BRsqaQPB9YQAByKFg3dZENmolHzXrN7LY+a6MrZpYhEB70xIgy2NawR5s7urgODyTmKcLg9gnxlYUjjw/kK0W5OMfLxa9uzGf3aZsZqLpmtXrk0d5oDZJUzVQc+7b7brQJ8axo/Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 06:45:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 06:45:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 05/15] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Tue,  8 Nov 2022 14:45:04 +0800
Message-Id: <2365b8dd4da80fdd436ec86ff9935246f218b12d.1667889809.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667889809.git.geliang.tang@suse.com>
References: <cover.1667889809.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe04875-48a6-4a5b-7eef-08dac154d71d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F+VZ3QwnrPs5eC82SKdJz1sdyjD0rBpd6XaJD4ZtykSUG9bPSPF/2gSTSU4tnVaArzsR1bVjvy40APqQM+2g/p/iWfKUAnKNTjQJp9mSXsvu7saIIc/V8GNp/UAh9q1TGi8CBx+7J8s764dqd3XSB190Gy88UGgzU3oyUzMEzsBpwGheyiPYt479f/fb7t1d+wB8o63UfNnjHtODD8Hzmlqn6c9YXsyn/UtaJrVEfyBE6MsJ1HSpqznVPm7mB+PuUMc6qn9L/UbWz2dVI/K5M+dbAfa4pRclqv0WULRJfaRkF+akkinTcfU6VQct59Vre3nuuK+YPjPEG09QUX8+JDsBibifrxhiLEud/tkg8jxakgOxyJNEuc7JPxs185YDFMgZfftCwV7sZ1lYDhg+SjAQwkzlAhdSazPODSpCb4sOmyS44BC6O12GmKBeY59L0SqDTRAVTjAX6/Ne/P5Ful6+oWbBC2fNrf/jF2DABveHcEpqxBu2oxxS0YBU3Hu6HZ7scUxobqIpjpJcBoqxPdc3Zl/rc+uvMrVmYOSbuhkcyujLH+saKGcuhNWQWA/06ORDkR/ws+M5Yzg5ZfxBzsvfvfvQT4zvB/0lIdUquApWDPCsRhmXbt70YM3LXQjR91LPtYfE+TDQzyIg6gnOrEi3RZsmItABOlRlhZCkH2jmn0I/S1JpUqy4AmvkPs8fC6Pb5XzPZnQHeFQpS5B04luOZKw6dafC6NWFbWjdZ+Fvz9V8MgOUXZpK7aOBTEXJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(44832011)(41300700001)(2906002)(5660300002)(8936002)(86362001)(4326008)(186003)(38100700002)(2616005)(83380400001)(8676002)(6916009)(316002)(66476007)(66556008)(66946007)(6506007)(6512007)(478600001)(6486002)(107886003)(6666004)(36756003)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tBm52b7D+0xuIbHezTFSY7cSRXaFP4IJdCIyeGDxfelpW81whXliqyimS2Kn?=
 =?us-ascii?Q?BrXvDq1eWCEMJx7wOUSPYrymwKsu9N7cfiIbq6PATcdRHzl963LuFMLXYTU8?=
 =?us-ascii?Q?B+JXSmISc14MvG0pdAPiPUnfp8hpGR1HKL9b4L7y1d9OFdaOA6iqfK2VBsl/?=
 =?us-ascii?Q?KLJOQ9KgUzkCdzMEA7kP1Wt3+r0QB6aM69SV5b7O52pA0Q2znfSAYs4WdMdl?=
 =?us-ascii?Q?9copnexQks5R5fB5LXRrW0X1PvruxyA4eAsm8NsVA/j+ErlORutj+WX4jWdF?=
 =?us-ascii?Q?27ujVjVE5BiNzSt93mTLSs6TE2RtmBS6oxGFjouIMM528Feo2gF8ZxH+TG7P?=
 =?us-ascii?Q?ihqV+yANEAYgoFbZVU6kB9dJYgG5tX3T0lcE/jTwkXA0F4qjjzBQyCbJnwLW?=
 =?us-ascii?Q?5j8LKjIZT5WFjqfFcn3MkPviCL4UxN+SjEF/R0MGjLV3lk5pAb3OWEEQvcjp?=
 =?us-ascii?Q?BtgZDa3GLtAUZxBs7SgTKAEB53HVkhkaj4OyLZFyoYD531MA53TEuPfHr6C0?=
 =?us-ascii?Q?z3bp1egcvzcSpDPssRUodgodlc7M9WJFqhp5gqv5aXFc720vgiQROnnlxZot?=
 =?us-ascii?Q?UBR0gEHTgO+BvBga6refvb6z22yhxwk7q9jNEekl/DG0suOucVsT4cxw3HKx?=
 =?us-ascii?Q?OqyNJjMdY+VYIIketKP+ZvTtuoH5s4SPpcDtG0SLWCA2HjMsXM9MXbdaqpo8?=
 =?us-ascii?Q?yGxEqkixrTX19hQ/bbgbB3RMBvXWPkttFKpNEKGnw1jvQK7qEct6kcYFM+iN?=
 =?us-ascii?Q?hM7rnDXGMn9tdgYeZscKlY//IIQ4KS9z2DZn3Nk+C3hWAt46If2LHdAhiKh1?=
 =?us-ascii?Q?XEhyvLGe9cKNc6ymYEEUpIk/oaBtwp4DEJSN3OJWGg1OTIqhMZhVDUmxzUFz?=
 =?us-ascii?Q?LJRmvxAswgZ4jpSNKlGqJrtgV4Z1V6l4UUC4lyan3SsC3m0jj49tJCtK6XnT?=
 =?us-ascii?Q?5SHyjScl45bopbeGZjSbw4LkU3efzYmmBtROWlFYwuYqOYdLH8EZJSZo+J67?=
 =?us-ascii?Q?+zc9Etxt42jraTTjYHGgNBWzLXPsvTWZxRKmum5QL59vKZ8YbYEG4B4k68t/?=
 =?us-ascii?Q?st6GePBoVeD9YMNPYAIkyCfkUdd2nVNfXm2TfMhb81oiCNqeTSmHLGNulY9d?=
 =?us-ascii?Q?ti8ta0DMU+yBJBAwmark1beVGA4X7M5AKv1JZ9A7EiNUzCV5BVKeLbIx/egn?=
 =?us-ascii?Q?khOIA/EqcV/I98p6op9qZXgfB6K2hjyckobr/u9NN5K+JtzZQ5TLcNFFTTaj?=
 =?us-ascii?Q?l25ceceah3zhIwBfQIuiPwvRM8aA6WOAMhPdNzuZT+uNg9ZfiJdEqKoeGf2/?=
 =?us-ascii?Q?osvPipxBC+dAxRqm3ABiCbWeKM63sLltlmb3+kkm+qd4NbT2FBNV0pAX5a0e?=
 =?us-ascii?Q?MOSyC7Mih5Wnv1at2qWGOAg8wOTbAtL+GTRB52pOXFuE57DQnsIsR6V+6SMS?=
 =?us-ascii?Q?Cauy11SXwu+lwelm43SNV7h4jvkqOpCJiaxV6Q6goh+h5+6SDgub9330E5cQ?=
 =?us-ascii?Q?j4XXft8hKqcWqY1woe+4TfOsj7ect+hS7H0TAzlvBWAGT5hT3HV3TzFsAMYM?=
 =?us-ascii?Q?WERSzVE0YX017XUKd5Uf7lCHHARUQawgQ6rkl3N+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe04875-48a6-4a5b-7eef-08dac154d71d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 06:45:35.7888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+ymlCZydN/t7sPwh3NSAVMDOHxcclNnUgh5oajnA7ab45RINC5IQ+kXHjxBdQqKZP4Q8GGh4gRngh5qQ5501w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index c7d4a9a69cfc..72c618037386 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -249,8 +249,10 @@ struct mptcp_sched_ops {
 	void (*init)(const struct mptcp_sock *msk);
 	void (*release)(const struct mptcp_sock *msk);
 
-	void (*get_subflow)(const struct mptcp_sock *msk,
-			    struct mptcp_sched_data *data);
+	void (*data_init)(const struct mptcp_sock *msk,
+			  struct mptcp_sched_data *data);
+	int (*get_subflow)(const struct mptcp_sock *msk,
+			   struct mptcp_sched_data *data);
 	void *owner;
 };
 
@@ -265,5 +267,7 @@ struct mptcp_sock {
 
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
+extern void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
+					  struct mptcp_sched_data *data) __ksym;
 
 #endif
-- 
2.35.3

