Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A0179E1
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 08:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9nQA0HrRUsBg19BOqJcRv3oVb9RPlja4FjCyX5AGoqBHWoiVhBjTa/gUjz/3I9Q9IQH43CXx82h8LJmuDA1Az+EXmegrWktn9nX9e9aYwBJdC1HflGuu/cZwYxYRS1R485CQU0tdbXQtbQBUpnZxNCm6zJmzOYGOL0MLGkpGjAhVs03bfQQeAfQgQmmyVAwVS4U4OsZVyqIICRK8veZMQbAW4KM0JGhMnDMCey2COX2N52mujXt3m6fU6dwcA8sK+jPBDxIqjtNclPIpSQQz5qpjXFsx+CqsaQvUOcRN9cn+Gg+Q4ZpgAOLDLhoRCSvgVPZdn4UxLCemIGsrx1gtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNuytEjl2GMpQLq0cjn9vyDQ+tuD+fchPB4KvvTRix8=;
 b=QfsJ7c4Aiq8GKyouarRL9SLOmDuNrukiUZ+kKh5GCWlqShw//5rpe+qCOhH1jnyYLGGCZZ3qxF4FauvysNbBQ2QaXFlcCWS/o3awTaNgw/IFrgTWRMCmfYJi2wwKB6IbIpc68PLPSTd7zVtNtmxP+Vzm9TDVYvh/vGgsmGisQCrg3TISx7EH4c2QxZSEjKn8G6kzonFPfWTlDJBT4J2cYpbK0S371m5cr5L1U/xWKG8SmjekAaJbCMOnKnh9fyuCEtM2jdFWQxzkJpRsNixQWCeW7h3z0UFblvqpjTqmNNxnbRr3KcAwUHhQaM3H6WQ/+N0F+bx3w/URuNkKsoQHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNuytEjl2GMpQLq0cjn9vyDQ+tuD+fchPB4KvvTRix8=;
 b=qWTTwRTIPZiIquCwWVW74PNzoJV1Axxj/NVFL0IVXKCCQPfNXJPHz8IGbqbl+FTU/fXOBCncQQWMk8JBp/oltIrru68ch0zOk/Oc3GxOJYziRfZoVpGX90xFl1fGjEDctRujNUJYJ2mNlss9/iKwRlxAVT7fpwdiSbLTcAMuu8VPgUa723wwiIBOpp4h+b/1S5/Iltpp6Cvt/qZxQsEqlQuir5VXlEEgNAu5C6zl/+psy8ZrNSF6YLfF5ejxbyJAgXa6MkxiFT/ACrHp73DlKxbxYeOIGX++M4tCRtZz4XkaxA7DDlARMIevVTQm0C0ID2BeI3aNfFrGjGUtFwwFHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9404.eurprd04.prod.outlook.com (2603:10a6:10:368::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 08:41:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:41:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 14/19] bpf: Export more bpf_burst related functions
Date: Wed,  7 Jun 2023 16:38:29 +0800
Message-Id: <06065430f5a66cd8d086983f744ad296dced6c9c.1686127032.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0202.apcprd04.prod.outlook.com
 (2603:1096:4:187::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: c3bff153-d97c-4a75-8ac6-08db6732f16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O/rcW8FgFOeThli/NwvIhC5IBVBvpfWVrysrp+2lXFoqSkXUkMQkNbThoK4oUuII45sJZbQqVgMZTeAX2ATTGmSC0sBvUGTMMMKH7XwtG8rok7QfjUSneKVCF7Y3qf10Kvk0z0OJ50ZMTIQnjAsdhiXE4/eZU5RrHoVj7mk9CluSUmhk7/QBvc4gGKBpxxv6Yr3kIB4E2YjWph6QfY0o+Yk8Jp0e+nfEDUVgYKR6xELwmFJqnx1YUOhATmF1zg0dLfOfWetdrGlzCqRc9dwgjWcHbqcaIJjuEXOgeqfWjSI6Vm/04hZt20HOBAFRg5nENHO9z1Jp+UJLmwfLJFgrcBRaaUWpsBfm/ma6D7o0/Fu4w4tJALkz75fYnZQy/M7FKvG8PqtkT5INpvm0Hvdk+XbATQ8h3+mtKdRYnukJpGiLZDbO44rbUqVr+PxSRld1YiShoyoliNJEYUkAK2U9xxxUXytA+Hoyqwtek7uacg56y1cQeNh+SyDIBBw3M+pyF7uMUzUqmnF1Qw3Mg8i6ww2cVIqH4VOPQsJZvInIxuwJdpWl9hekV0WI3iQkt92J
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(107886003)(6506007)(26005)(186003)(6512007)(2616005)(83380400001)(6666004)(36756003)(2906002)(6486002)(8936002)(8676002)(44832011)(478600001)(6916009)(5660300002)(86362001)(41300700001)(66946007)(38100700002)(316002)(66556008)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y64A6zamjvKVSvse1FEnos8RIzgCHKTr0EQl/1ddZN7vaaWZ9B5xI1xsMT12?=
 =?us-ascii?Q?nhwQOmCwvz8C9QaR0xjdafl1ijk+oBlVj1PSSkNT527JrYRMvn5Su73ShGJn?=
 =?us-ascii?Q?r1Q21SmLVAulwGj4a3X+XiisMn0Kfm0pAH+Nq/rNfcRlFpDMkaSQo8n9M9iG?=
 =?us-ascii?Q?xSgC9O2eYYZivg6n2GiEJsauiXA8xEDLyApp+6nqkdH81XxGWEjt6FwUTGa1?=
 =?us-ascii?Q?36ENKRHyXIxJhg25i1vJtgr0R86/OPDpvvpSx8Rd6L8ND2ZOBD2N30M9JUpg?=
 =?us-ascii?Q?1ytxKTg5Y+i3cG9ER5KSnzfF1iG5oU7MSM3Dm4vNIvOcb/tJF3FPkcsZz/x9?=
 =?us-ascii?Q?Rz/cKUfj7yQ8bPFkou2JJALtHMpzdI0rrDr3fcA9+r6tbAWVaA63U9qDObV+?=
 =?us-ascii?Q?Hbp4OUXlkHqXWBtwFQYh7w8+/tqZMefBqC/Q3pRT1Smaykw5e0HE6jb0cDUL?=
 =?us-ascii?Q?x8VmzAZkeB6mb7uGTMRDPPk2fyoAEFjEEmelBCv9Ef+hAOQgYlYnFesMCMuN?=
 =?us-ascii?Q?7o/Jht7y2JbWNs+M8OAYQfNdRnDNQJHP8HslyF4Pv8mRsc1zBba+LR9kVGjC?=
 =?us-ascii?Q?XcyU+SkD98vD+tis1Hattdk6AcC+zzzT9jYndcxPoaCOce1VVvQvG6qERmC/?=
 =?us-ascii?Q?jMGXWintUHLeUqP7jVK5LcpAdzauqQvaTxYU64U4Z0UbD/TPzEfO3fJX7lZa?=
 =?us-ascii?Q?FuI0dvYTH2F/ETFTKhjX56jaNs5MDQo8RDM0Q36zJSiTUIl2jUXqsWD7+573?=
 =?us-ascii?Q?N1HNNAWKSCHwf//vniWksYMOsoACMZxqyxS5XEpKXhYEVv5PbEgsTvD5Y/oV?=
 =?us-ascii?Q?RdQQBOIIK03rY8WQAkehTpJQRNwrFUNNRkNaCWOdds+fs41GzRQKRXl2oCHu?=
 =?us-ascii?Q?n64Znlkig+/PXaalxUxm6S9JEApYRkdnU0lNUWFzgBK/lHrINJKZc5O38IoA?=
 =?us-ascii?Q?jvZodmVwKw9uz3hxSxSEC7EBvm4Abu5nRRa6nqkwpmm7KkCHEi3ghSSiPdDC?=
 =?us-ascii?Q?ZA9GZPwDOeKB151lYFL56uU9NXFjSvuAaekietcXspYFrb9am45TDVr/UMR1?=
 =?us-ascii?Q?Rf0Ovq1unPFOIYXuzUq7vImhFoRosKp5MFJmGZngX8EDkZ1uRGYiAeR0eP1E?=
 =?us-ascii?Q?cDrZ8iu+Hq/r8c42Gs7O6jzu8zXzFhZr0Gy9bIM39kuJMA2erVEm+s8MzhdP?=
 =?us-ascii?Q?PEZWepCXLxHFlLSa2LSikmoHNYG6RCA7qb0iExo5Avg+xPGBpEDLIVSAqo3i?=
 =?us-ascii?Q?oXotjuLtHYNl5P8IwfnKeiSAXGNynVQ/hjw3qyPGUeEvv5Z9OLLOMftC73uD?=
 =?us-ascii?Q?W+vUoWmy2O1z/ENthm7eeTNWa6DX1nCVptzqGLRYaHmE61CSDfApGpCvfZKD?=
 =?us-ascii?Q?K2l9PW9wd2PySXrt2a9KWYpNdAweNlYhi45IdiSLOJSbCWFlIFXdCIQueKdd?=
 =?us-ascii?Q?8jNOK6xOlaSRFg3XiICGn3q5byCewKLbgSZhjlKST/abjP0Cc+TxKfZhC95R?=
 =?us-ascii?Q?7hCbKsMfJIXy6FsfoeB+YkNeGOhT3pMY5strh4+JuFK2d019Ev7V87TRk8EG?=
 =?us-ascii?Q?o1adLFCGz7gDzg++8Sezm+F05+v++yQuCoOTO8mP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bff153-d97c-4a75-8ac6-08db6732f16b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:41:10.2710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UiIIYiclUuaSl1QfBwbVFhNSsU4kKzllZ7V3lpcLcCdlE1pwOMIfyz3z6b2O/WsRT3nEPw55KLAuat3fA0TVtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9404

Add more bpf_burst related functions into bpf_mptcp_sched_kfunc_set to make
sure these helpers can be accessed from the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 7 +++++++
 net/mptcp/protocol.c | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index ceaf4fbfc430..d82e09d86312 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -190,6 +190,13 @@ bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk)
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
+BTF_ID_FLAGS(func, mptcp_subflow_active)
+BTF_ID_FLAGS(func, mptcp_timeout_from_subflow)
+BTF_ID_FLAGS(func, mptcp_set_timer)
+BTF_ID_FLAGS(func, mptcp_wnd_end)
+BTF_ID_FLAGS(func, bpf_sk_stream_memory_free)
+BTF_ID_FLAGS(func, bpf_tcp_rtx_and_write_queues_empty)
+BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 887997fae41a..be3fa13cb573 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -50,7 +50,7 @@ DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 static struct net_device mptcp_napi_dev;
 
 /* Returns end sequence number of the receiver's advertised window */
-static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
+u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->wnd_end);
 }
@@ -490,7 +490,7 @@ void mptcp_set_timer(struct sock *sk, long tout)
 	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
 }
 
-static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subflow)
+long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subflow)
 {
 	const struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-- 
2.35.3

