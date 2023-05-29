Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5287C
	for <mptcp@lists.linux.dev>; Mon, 29 May 2023 09:18:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcEDb1JTBoBD3iwSfMo8/5G2wSjc4nDEVDhpMmZX8/oCQwmFjaS2obnjz/xZ9AviedPd9tl0kDhnzqQLDzybbVNQGAZEzS9DKsBFPXLq11mydVlul/W3e3+Pw//kOtxGWkWcpeWkgHS7ZCBF4tC9YyZhvTspnYtvARWO+s1sdFw+5pfpGPdpe5mfAMXnVNqCh/Qx2TkZSDZjgCXis2q1PJBV3v7CzasisyhSrVtEgNIJO0S9LD2B8w6UWXBehV9s2fd5j6A7A+9SciSD9r4Il4nzjgxbQl+P/NTdQMeLm9yfZdkC1a0a+YK91egbzLfGt8HTgD4Pd6FDaWRAyOJG6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSzAFs3/qZI6Q4dv+DmGZP9ruan88FqmqHAQlWmZZmY=;
 b=ONXFq+7G0bymAJMpuEQK1KPoMwxVuPyaktcAxTAorlCl7VU0slHGJ2qXVNdl9v8bwAD/aocTYYFdacT2CTfvArKvjBz5YuJXf7pQMpLEWknWL1snh177HrhlpEbbgCvJZoLknMvsLUoxVB55cJVmElH7M+lN1aKkjN8b0th0IvlT5lKDyH/MtZu7WdYr+isc52HaWYlZfDt2zN29gA6MKV/b365KyTbMLuy4EvekdPGLvAXxJmH3Gh9cm+Sc6RQgX5wI3waOM2ttY3WGfSy/N7SbIPeJExQK+oUkzBOpo3BvfKPTxsT6+elSmbOtrpYb/J99oZkXRU9ZvZ4a/vVtiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSzAFs3/qZI6Q4dv+DmGZP9ruan88FqmqHAQlWmZZmY=;
 b=M1z8eueriTPamgqzYrr/0+YPH0d6Aji20wqrQQUxWzp+RHi/YgP9AOR3Mgmuc8Ggelel577uLNtttcqsPCkkRUKjTk1EHMQ2dU7IJ4ZDs2vSVC35Nkn97Zv2nLwELcpnHXkLMuDsWD7/ocdMO1YkFZ2kUsBWyEqlDUfLFau9G9JcHZvujtHOderrHGUbZYRPSamZXLnTEQT63Lwh1IeNl5q7jmwCbQwunDIr/6rocMQAl4+afmuC4lXLA9MwUi0JxplMZcPbfmpaee/3UX0K8zHv+6xvQcMReZCiNWjHUbUqe//Z6BzojXm/2j6zRp7lHElaNDGhzeydLrDdm3G6dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7321.eurprd04.prod.outlook.com (2603:10a6:102:82::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 09:18:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Mon, 29 May 2023
 09:18:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 08/12] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Mon, 29 May 2023 17:17:22 +0800
Message-Id: <fff9dea11f444d5f66bb7013d41432edcdcaeabe.1685351620.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685351620.git.geliang.tang@suse.com>
References: <cover.1685351620.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: b575e0a8-9cf8-4510-6aa4-08db6025ae8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BnZWdjiQ5EoXVaX4NHJeP1V6opqTGR5H1KTrEDaT39w4ejpidgxcDghbAX1FOj4u0RUXEUQ9eAf7IrFDZw4wpab19pLl4EAerj2s8EwQcfCnU3ZH0oobjnCSg+TM/YeyPhRWD27hVNlzjnt1GhWoSxWLDlnOw7l19Qd+Ce/JvbXDVQZIlUUoCa8VC4Qc0Y/1brZc6fXQXW1uC/AXJjnHeQH2oQHlW8rJSC0Q8vm6KLHuWkzR1c53YQyq/sy23E0HOok0GKOUPqDgiSr508e/bPCEtVfA+V2dk+Dl/ffKaOJkhCMOh+OkhXYDH6CRHFpjjEpMVhIcW8q6fnH8GBqPG6PJfGJJwH2i1u8HSX4GQYY600K7QWkmlIcLrc5Mn+dzOX65x0TN+paiEgykAjbyop3u0KFJmsBMMFCXbKYbKdx1hsol2ubGcum+PbPMfoOk7EzqB1LUFWtqmWy+LFvlvyS6uHvxz09SAnvehai6Ts3tUHsMKZ52mb3ek3BeOdGE83f9WRURt/VKwqj5GRvrrgytfpqOc/3WAJJT3HVAktmehTzg7JYIUPLphA7lX7ok
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(66946007)(4326008)(6916009)(36756003)(66476007)(66556008)(83380400001)(5660300002)(107886003)(44832011)(86362001)(41300700001)(38100700002)(186003)(2616005)(8936002)(8676002)(6486002)(2906002)(6512007)(6666004)(6506007)(316002)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oF+RCZjJd6igoiAntKCK7QPyjlBz3sEHRB4J3zlcUX+FWc+FVB2nfBbH/Js+?=
 =?us-ascii?Q?3ezhlJViXa27bmfwp2RqYfSXKFweJwYNmH2VsUvMeWBxvavY2tFbR/8vAv4a?=
 =?us-ascii?Q?wkL8g6mUeX+9LdXHKBxzm/Stf1JYwhPO0f1nhM9qJkT5xzXeknGuvao4CwSS?=
 =?us-ascii?Q?mLExenpNOin/h6bz2ca1WYUFJk7uIC1hs6JYaZlR8+kYkAggCEQ9ndGx6c/6?=
 =?us-ascii?Q?YvAwmP53Ohl4DjNyud0P0UmO7V6HlQ7/zFyF8DZu0w8leJKtpGGFAKl/gVfP?=
 =?us-ascii?Q?VfBIs7e6HXc6ofonkPw05xGJ0FF7cQbe07S44zDOXd1TmdlbvKb7BZ8F3MWn?=
 =?us-ascii?Q?wTE5L6e2q5dGv7zUV3Ikb3aVBfuci72+jblPywRA45hhbg9Y3iElk8kJ4KIq?=
 =?us-ascii?Q?9fhVJZNXrWyN6zms3k9+lOVqFNopR03A1uEPN7+i0F5eGwyykkoxJRG3x6r1?=
 =?us-ascii?Q?1OXm/ZbdyIuOCjqeARnISnknCVTV30pbGz9Ooj/Xf6XZu47SHmQmPzhCWdYJ?=
 =?us-ascii?Q?QyLOhw1UswDASDqrtAAaiGV9rv4ejanfYxOU80QmUwymCQhzCSPHxNOIXHob?=
 =?us-ascii?Q?fDYZTyGagiT2dLFs6HwKrG/bZzNFndu5wXJRqMe2IEOGlIgvqGcISsnfW+ec?=
 =?us-ascii?Q?ZLh+ZiJtDvi9Ndz/gN3gTeN429oLmJNVIq+cdfZkL9CCO30d8yVViM2WLZTC?=
 =?us-ascii?Q?zthPeTB33D9o3QvJffX4MM8qF7QD20GULoBLPAHIJdHZHfYVczK+ZE6BIqcW?=
 =?us-ascii?Q?vCDZO7fP2z1+AbtTMXqQWlDncD/HulT5An/4I0+1cY4UeRkK9HOSErOAP9rn?=
 =?us-ascii?Q?asm/qvXzEccn86AGpihsIOP1upylB6k0UoXSyC/WCYPnJvasslg3EVt5+5cr?=
 =?us-ascii?Q?w/69eujCUB1y/Tq0rzSzCs441oYHGmymLfNTkJaiWCPJqKzixco8PjrJ9Wz4?=
 =?us-ascii?Q?ccpNsp5k5LwdIhEpoUhnqhJfhUJoNjdvCsT1DUtIIPO1bloJwLEuyRcopgff?=
 =?us-ascii?Q?jBrmg+7kMHZ78jt+/vuDf3p5z7b1PreSX6YpDXDAkEdOocsaODq6SThmmFHk?=
 =?us-ascii?Q?K3W7yZYsEav4kpo81fFJRjLjSO1hvZmLVDBqo1CiYIETJzC00JOatW5YaMee?=
 =?us-ascii?Q?hxnQbYwdSGJrv2Zvp1jjBbDtnAq8NvylAlbyBArlvmcYlgi9CTovQBY8re31?=
 =?us-ascii?Q?l5GBEFbislBlQsaTgAVcq1QhOi7q3CBFdPzXJa75pRpZ3Iwh3xTzl8nr4Fqp?=
 =?us-ascii?Q?Mb0M1Z9ePDdXXWN2OpJj9FXiSbr4zWsoTaAyIIjNxuKJFaXyfZL6Lk/2NKO/?=
 =?us-ascii?Q?zungAIUewlbA8gy6tX2SxItokx4AWsS9gvY0ejtMV21fkcllUAlKysckUqLh?=
 =?us-ascii?Q?pbUR8VGx97c+/bcsfasgZh81FN6US8eKlbafcoEoDKdQyTYtji9YVMlUFD5W?=
 =?us-ascii?Q?K6Mqv4R09zu23x89GZoS2MUP8RYkoa55+pvDcE5ak/vSjvWfSFLkUoAMYuJN?=
 =?us-ascii?Q?KTR2zQnnJPdGk8tDlSVWY3tac2/xDAIae3Ky+VqhL40+SdWEyxaOOf84vHqb?=
 =?us-ascii?Q?G0YwuHVfqfOGHp9o1zZQdb6S8mHbZCqyfS79iybL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b575e0a8-9cf8-4510-6aa4-08db6025ae8e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 09:18:36.5008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Xd67y/mdPsJja18eJxDufbsKIGRnxHP6+lWclaPeQHqu6CSLTyErW+w3OLl5lvO3GKI+cfL6A3hngAkc8O40A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7321

Added into more functions.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      |  9 +++++++++
 net/mptcp/protocol.c | 40 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index f2ce9acc2628..c5acce1409f5 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -175,6 +175,15 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
+BTF_ID_FLAGS(func, mptcp_subflow_active)
+BTF_ID_FLAGS(func, mptcp_timeout_from_subflow)
+BTF_ID_FLAGS(func, mptcp_set_timer)
+BTF_ID_FLAGS(func, mptcp_stream_memory_free)
+BTF_ID_FLAGS(func, mptcp_get_linger_time)
+BTF_ID_FLAGS(func, mptcp_get_burst)
+BTF_ID_FLAGS(func, mptcp_get_pacing_rate)
+BTF_ID_FLAGS(func, mptcp_rtx_and_write_queues_empty)
+BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 27e86a2cc16c..fb9668c7f4bf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -483,12 +483,12 @@ static void mptcp_set_datafin_timeout(struct sock *sk)
 	mptcp_sk(sk)->timer_ival = TCP_RTO_MIN << retransmits;
 }
 
-static void __mptcp_set_timeout(struct sock *sk, long tout)
+void mptcp_set_timer(struct sock *sk, long tout)
 {
 	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
 }
 
-static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subflow)
+long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subflow)
 {
 	const struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -503,7 +503,7 @@ static void mptcp_set_timeout(struct sock *sk)
 
 	mptcp_for_each_subflow(mptcp_sk(sk), subflow)
 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
-	__mptcp_set_timeout(sk, tout);
+	mptcp_set_timer(sk, tout);
 }
 
 static inline bool tcp_can_send_ack(const struct sock *ssk)
@@ -1408,6 +1408,33 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 	return __mptcp_subflow_active(subflow);
 }
 
+bool mptcp_stream_memory_free(struct mptcp_subflow_context *subflow)
+{
+	const struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+	return sk_stream_memory_free(ssk);
+}
+
+u64 mptcp_get_linger_time(struct sock *ssk, u32 pace)
+{
+	return div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
+}
+
+u32 mptcp_get_burst(const struct mptcp_sock *msk)
+{
+	return min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
+}
+
+unsigned long mptcp_get_pacing_rate(struct mptcp_subflow_context *subflow, u32 burst)
+{
+	struct sock *ssk =  mptcp_subflow_tcp_sock(subflow);
+	u32 wmem = READ_ONCE(ssk->sk_wmem_queued);
+
+	return div_u64((u64)subflow->avg_pacing_rate * wmem +
+		       READ_ONCE(ssk->sk_pacing_rate) * burst,
+		       burst + wmem);
+}
+
 #define SSK_MODE_ACTIVE	0
 #define SSK_MODE_BACKUP	1
 #define SSK_MODE_MAX	2
@@ -1457,7 +1484,7 @@ struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 			send_info[subflow->backup].linger_time = linger_time;
 		}
 	}
-	__mptcp_set_timeout(sk, tout);
+	mptcp_set_timer(sk, tout);
 
 	/* pick the best backup if no other subflow is active */
 	if (!nr_active)
@@ -2273,6 +2300,11 @@ static void mptcp_timeout_timer(struct timer_list *t)
 	sock_put(sk);
 }
 
+bool mptcp_rtx_and_write_queues_empty(const struct sock *sk)
+{
+	return tcp_rtx_and_write_queues_empty(sk);
+}
+
 /* Find an idle subflow.  Return NULL if there is unacked data at tcp
  * level.
  *
-- 
2.35.3

