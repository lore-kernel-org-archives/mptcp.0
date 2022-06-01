Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B5E256F
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 14:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654092517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yb4iPGrUX9cts8HHtjVGVyh+GzCizSil68EXyz2+Sv8=;
	b=fJA6no7XoARauRiJ2n5TW+G8LOR5KcQFxTToxXLMmr3aFXp9imSGFr7WB3ZtxNpsc41G3W
	IjxqD8Ay4LgqGyA8V4aP3Ep5iH6P/fO+8UaCgXf10uvLWrOz+nwTHUSNP4nx/xvkvZFwIf
	QtCvIUM7S6B3qQLDvQsGkkcZeSaVbjA=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-46-FXWcdpg-MeisX9cXL_NSpA-1; Wed, 01 Jun 2022 16:08:36 +0200
X-MC-Unique: FXWcdpg-MeisX9cXL_NSpA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhwveMcqySkQXnopzidjaC+rVO2FRbB/IYRFLdInr4m4a9nNtyXViYhlFVWuQAeyyo0R9t2gKXHlV2QZLsDXXeua1ZeMljYKnYamx9lddzChCq8KFYAZLQ49egxr5z60XIoPXCYnXHfsXMWvt1OR3J6jPGG+f4mPlwaZIx3Evtf4mejMIvTVB31oVecADOPLsC1BynQUXXHE7I4Cqa5OM35T1T/DEWBrK2306xvAxysT6Xj0EQ6U32km1/L0+nwCRotkhpLKK1DMyUC+izL9lEaRg9OF6wSzj9Zxk7+CoUNCE+nTa4SX+/UhhDh4qWH+s/S81HIGQ+kGV9eGzH1QQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1kX8/zRtbMNU6ObA5bAo4EHAJ9E2/txENrsCWcWHVI=;
 b=Bfh9vsjLvaV3HZl0+Xb/f0VsfDL/PPxQlCbDftvP0eJseG/Tbau35EQM2N9Qy6X3SbBYbKDi++WR+7pu+FMwRLgK5cwet12//BEcRo4PqBKdNsSjIcmdhXQtpLPupx18ZAQCvfAE0jBqmdAUtpWE+ionFxIRwg0cMzW9Pr7N/JPGJEypVRz+1dokWWWLr42dWa3p9mYJheDeodRkMbACAj22uuQPaYVCxh6JPQAjM+jxVoKi9K8IBo3Bq5r0bgimjjfuWZ2Bjn6wOtQruZbQxvTbAivPnJXtrXVD2Fi5gh1Ue10q4tVxwvcm/7XK/LIDBl9dJvXMjHc0F8vMrojkig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4805.eurprd04.prod.outlook.com (2603:10a6:20b:d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 14:08:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 14:08:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 01/11] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Wed,  1 Jun 2022 22:08:14 +0800
Message-ID: <6a61daefe1888661fa63a50c108b043bd20775a1.1654092153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654092153.git.geliang.tang@suse.com>
References: <cover.1654092153.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0217.apcprd02.prod.outlook.com
 (2603:1096:201:20::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6c7c0d1-1ca5-4244-9c48-08da43d83777
X-MS-TrafficTypeDiagnostic: AM6PR04MB4805:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB48056A31C434626E11399C05F8DF9@AM6PR04MB4805.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kyi2F4/CUtoeovBKbrYQDMsJwvBSyRObadNKAGbsYiFOSCJc/CPAcZC2YY1ldzziodJ+2UNEQb0wdYUxyA/lJZGPttcy/rfjFkyhKyonCkYM3NtMCC9xVncEBF70FNXSwldcYuVcRm4SVoNXVoYW2FV4h1XMpPxi3R7omXokoUakcbxu0NyhE9SlrvtFI5y3x+XK7GPpgdu3+XNtCSjEtccRndlniY7UuzeKtdgGSlaYCQyKkin8c7a+tKJhRVkJiDyBMjgyshSh08/iazUve5wa8E5unslN9dDERkdS9xnSEOOlHTl1l9vX0gVxyLskgnvW1pUXZDiFvOvW/Cj0ceUf4OHRiPCPPAMAFVzVk787s7xr0wCRyUKcVVCW2XhLlAubtt9HKHCSLSCU0WxvzXO7t42GLjPHtioek6vErhipTLQ6z83QzyEw6T4mW5gk+9W7bKjc1ZN+pxQPYfTZmvoc7Rh9Fg9FU3qbflt1ig/N8QqqbbmvDRNwsafoBbRsdWCtPIDUlMp144NvzwGW6neCAjZdtXQcpFoM5JMWsn+pDpGahQiymLEKbG5BKgH3CIwHUNtEMUTHBNwVCoDSDh70/lg0gs7UdxsKN3+ghye4A/vxKG4+hooHlrYailnR78gbYU/5Qq/ACOqj4gHE+Mkg5/+0cr9lmS9F6fipbbJqp1R9281wYEa/iVGtdmPI/kdx/1O9THc3x/Rpn7MBcw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(26005)(6506007)(86362001)(2906002)(66556008)(36756003)(4326008)(38100700002)(8676002)(66946007)(66476007)(316002)(6916009)(6666004)(44832011)(83380400001)(6512007)(186003)(107886003)(5660300002)(8936002)(508600001)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e/EuysqC4VogjnmKgxCAvCtrPR6dfMBJtj4oY2+eK+RlA/HrJQxN4WEtczyB?=
 =?us-ascii?Q?ntGU1L7Oq0mIYEr6VaJQVhPbt+IyXVMo6MhUccfo5xiXzJeeMra3AcOVeRdR?=
 =?us-ascii?Q?7v73CHC3h1HNJhqB9RhjDFUkuivqp6z7kJ1/0zuzo69Tcrl3KX7qh1BgYDb7?=
 =?us-ascii?Q?COCLneDKglxNCy0IaQe9os8ujwlelxaBKuobXIpLXT3v7R2/gZh7XNUh8mEB?=
 =?us-ascii?Q?fO9XoLpKutqKXfLFsXzMGwUpubFd0y0/tg0gMeLDElBq3/wYSRtt9tERJGTm?=
 =?us-ascii?Q?J9CEpRePTMVf2oCcswCnwIRl385IDMW/HRkRCfWKoucYF23CPT2ezyNVAzUj?=
 =?us-ascii?Q?GZvDQblEedezSbk0W3H1TQWyGCrpyzAeUWLYkuRPk+MzS2fVv1TjSxjfzt//?=
 =?us-ascii?Q?+X2oN68X0NLXtvxt3bIafzPjb8ztku86qSVIPFpSYhWmXI61SWkvWizpkXOk?=
 =?us-ascii?Q?KdaHlbjivIMAmKUpFwedF1BncaJDF2eOd02BXrg2Ah8PzuAE22jf3QEqAkbR?=
 =?us-ascii?Q?6u4G0D8NSLHv3xPM7+wHHAbGNONtqYU6vuusrOs0KxvtZi4OQsOOmK7fkvqa?=
 =?us-ascii?Q?sGQAMgVE9VHHxx5xau8qpejStU9qWp5aDorAgp5AJBvpGMelwY8tHXjAJcxo?=
 =?us-ascii?Q?LDRotz4W+21e6utPLltQPkDOOo86bD42VRys3e8WAjXMcI/3pFdxyPds8bkg?=
 =?us-ascii?Q?lG46SHo+kIBB2ITgYcXuewoEiAO0o677n3+nMBRtVdQot7EglZD5++Lbt1EJ?=
 =?us-ascii?Q?+xwJ+/8rh8wEG4I2jQ8LF5li00z8pQ7RO+3i0MT80PAiqlYlVkR8KxwqZ23v?=
 =?us-ascii?Q?4Gd/3/MgU/VuK2VbpQU7t6hUmETORlLqZElBu5IdugTscF5aluOCN229IkXP?=
 =?us-ascii?Q?JhaO5KjiHbtmvRanaZYNiwZP8yNf/1/3xYIP1xD/K7q6Z2xD+inNyDTMDcsB?=
 =?us-ascii?Q?2ItQPxaYkjAui3rXcjQruxbads2VdmbyToUaXFI/2fdBSVanwoJaJ9nrzyL0?=
 =?us-ascii?Q?ux2yA0I7bxhRQhLRO8fZ7B7LRX7FQjV5cfEAD7iuJoj0RT2Qxr7rR+WAYUBy?=
 =?us-ascii?Q?sm05OL4/WapoR95s/nU0OoI/5dcGYPk9mKPUuokWI4xXQpOebLSXDLSzG89K?=
 =?us-ascii?Q?8/Sj4CXhq0fTu4kGgZ1U4peczmxiTrU7SaRbuitcUo2WP1TwMk3EfBujUCj5?=
 =?us-ascii?Q?CJnWLPDkgxErBC0GjxGi2qkMHjF/QgFgnqGVGAW3ZX5e+K6pOxyRSbQVs/TA?=
 =?us-ascii?Q?K2WSI2c5ttzxS74fWL8FOCYGhs16WHZrJs0b4XaGE6wO0qLeKVUpqeVSMCi5?=
 =?us-ascii?Q?8RhrBqOKkiavKpRt37JgxPcAVeuOqoFHhEwe3cpf5IogzIkb2P7Aghq/ozDm?=
 =?us-ascii?Q?j1A2ifKImEt+xmFZ/L3XJ7uvh1zRAqmeKaKS+AzR08QTvcgwygUxnpeJTRSP?=
 =?us-ascii?Q?9NWNYqjp3braUvUxxGFBQHVPKqUsl2oQt/UJ2Ku5W0ZvkVsJ1WSVjUNgpv2d?=
 =?us-ascii?Q?FU3T/J5PsnS3sJilzIYLHbUzZEvZhALwUrTbu7R6BC6kGSjur8mLd0xGoG5b?=
 =?us-ascii?Q?HLUscKXNS+QNzM3Ls8ycNNH0N61sHX9HLLC1jYvTBGWmP9nymgIt4BXu8/OY?=
 =?us-ascii?Q?DQIcujZq9FxQ5InWYXEIjuSpUMhqBEEgEVVz7GX5OVqBUeu5ntvqco1Mhl6H?=
 =?us-ascii?Q?KBFjy+YY/GriXynHrsZTXeq1wYr2+RG5iQNrDLw6PT4DicOFeWuvoeorqNom?=
 =?us-ascii?Q?UUuwUzsn+SIb6daS6iluaSs6TJRukLg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c7c0d1-1ca5-4244-9c48-08da43d83777
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 14:08:35.1741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZyTaGITA63IbtmgQE+g3SS+BB9iI+zEvECtvBtLGqgQX4LZO1tmdTphnCE942f2cPSTbsigMzAWCriZkJzepQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4805

Use new BPF API.

Please update the commit log:

'''
This patch defines struct mptcp_sched_ops, which has three struct members,
name, owner and list, and three function pointers, init(), release() and
get_subflow().

The scheduler function get_subflow() has a struct mptcp_sched_data
parameter, which contains a reinject flag and a mptcp_subflow_context
array.

Add the scheduler registering, unregistering and finding functions to add,
delete and find a packet scheduler on the global list mptcp_sched_list.

Add a new member scheduled in struct mptcp_subflow_context, which will be
set in the MPTCP scheduler context when the scheduler picks this subflow
to send data.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                           |  7 ++++---
 net/mptcp/protocol.h                          |  1 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 11 ++++++++---
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6456ea26e4c7..7af7fd48acc7 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -97,14 +97,15 @@ struct mptcp_out_options {
 };
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
=20
 struct mptcp_sched_data {
-	struct sock	*sock;
-	bool		call_again;
+	bool	reinject;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
-	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
+	void (*get_subflow)(const struct mptcp_sock *msk,
 			    struct mptcp_sched_data *data);
=20
 	char			name[MPTCP_SCHED_NAME_MAX];
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8739794166d8..48c5261b7b15 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -469,6 +469,7 @@ struct mptcp_subflow_context {
 		valid_csum_seen : 1;        /* at least one csum validated */
 	enum mptcp_data_avail data_avail;
 	bool	mp_fail_response_expect;
+	bool	scheduled;
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index aca4e3c6ac48..8338c7b31f87 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -231,10 +231,15 @@ extern __u32 tcp_slow_start(struct tcp_sock *tp, __u3=
2 acked) __ksym;
 extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) _=
_ksym;
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
+
+struct mptcp_subflow_context {
+	struct	sock *tcp_sock;	    /* tcp sk backpointer */
+} __attribute__((preserve_access_index));
=20
 struct mptcp_sched_data {
-	struct sock	*sock;
-	bool		call_again;
+	bool	reinject;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
@@ -243,7 +248,7 @@ struct mptcp_sched_ops {
 	void (*init)(const struct mptcp_sock *msk);
 	void (*release)(const struct mptcp_sock *msk);
=20
-	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
+	void (*get_subflow)(const struct mptcp_sock *msk,
 			    struct mptcp_sched_data *data);
 	void *owner;
 };
--=20
2.34.1

