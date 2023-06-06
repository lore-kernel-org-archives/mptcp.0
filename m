Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2077.outbound.protection.outlook.com [40.107.15.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E5C125C0
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 09:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfSFCM9fCFsSK9ITQEX+vHIxhMpoDzCl3NfeIwQ3rYqOuuz3Nb6CFuYyC6EAF+01iK2+eOY8vX0fEaLQ0aRdgcOZdESzBOVxdo1Y3NoNiDa+3gDC6ptbcYTNX7thH2ddSxLDko2HK/DU+Zl61s2XmeeoOuVZXh+bq6YKNUzoNwRZlS5YamWlj5Rf4yGAV+wAJ38CcuKjAt2gfh1KKJo7S5unyV3CUmbCOMSoQf0W+dcI+mxb4VfOnq6IoTi0U/VAEDoMsx8CNm8w0Z+a232/Ic8j+s/emKTAMuzCnfNlbK2aKet4KT7s3bMPluxJ1VpfSrQD8EDVqllYnB+48eTr7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uwa1GJEC/FcOH52kEYSkQ77nUrYIAb6lJ46RkUkfRBE=;
 b=kAJz3FIufwmqyiDh3gObuTjb6Q1zLC76tlLB7C/DkReaItohfIIkGa4ZaxKYhMczbyeocnsX4qaN/v8s7/TNaAPdPeROwx0yRT04+4ZZa56hE5CKu8T1/Ouj7o4ZSbyFPrG6lJP/y+nh2nGuFtTiWF73YVkG4tdIQ3z6ZaKGubFEgM5VmUmisg/POZ80HUDQGl7o+LyHQB3Oq2LOZEmoNmBcUfg6/sDdOJvxEceQquBhDqe51ujjQn7osuqgEO7ylImz9w3kve+/XifJfwjM2EgNcvW5FyOLo/adiFkOW9GGmqr3p9dlWKBBwjDlEsBL5JMhJdTUtxI5VmGc9qlA3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uwa1GJEC/FcOH52kEYSkQ77nUrYIAb6lJ46RkUkfRBE=;
 b=nOp0fLHbcZDkaD7STotqnuK7Bm4NZ69A6fb/x2didupZOLYMadr3hw11h8rHxhZ+u6OpdW06FmlWXvmSIEoRa4kmgMNySoBdCBLN6PuJUNvVibYygw1SQyS4lZywlgL5cCifopaJINtJdopjD0XyfOQ+1PWTUm2eIZXPPuZKMk947gjRVsaSsXM5WEMKgst5gKOpi/PWxlMFqhh+NQeyFu+qRDzos6o7M0hsjnyXI+qZwKodt3H8g55SfQ1zEiELkGlREOF2Z+zX9aGsveU4kiLpSJnkTkSvcR+DfhWTWYU8SndszbCrr525GSv34GZWTRCxqbltJ8IK5OdN109m8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB10059.eurprd04.prod.outlook.com (2603:10a6:20b:680::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Tue, 6 Jun
 2023 09:02:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:02:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 13/18] bpf: Export more bpf_burst related functions
Date: Tue,  6 Jun 2023 16:59:27 +0800
Message-Id: <40c0aaba36afd5180f19cbd6d54a58fbab48313a.1686041504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686041504.git.geliang.tang@suse.com>
References: <cover.1686041504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0197.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB10059:EE_
X-MS-Office365-Filtering-Correlation-Id: a2672d2c-af67-412f-3a7b-08db666cbb15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ENVgE4DwgzOyYRq0o+nLSB9rqKRxIq1JctsOalFw9LOGtVtuBb3LIdue1fq9KxP/6x1aSurQjGMSzUGaSUPMTuc++dTGwq7izTkWPTV1WG5fYKEflfb2vBlZ/nSqGJJN0cFPVdLlTSSjSLs5EZ/J0QqTk9prLEiUAYMFPt52voG9mj3ChnwmpOU8PkUu53SLJtgPAfb8tEuMBAv893uUJD+CFVKd4KDwHEa+/V6KT+YvrHTDLyQ87uqaT4xNc4yqGm8WvwC/KiYHe5AUVPvzWARACUjPiNlsLKh3W6/gHW+fEG5nBnZBEtBWuNXdJlUaVJbGi4DqYRVVlxvFeikzo6v28YVYKT5Uphweh1PSghltqCQFYz7v7i66QXqQ1Aawhgmcwmf+jHJqxKiEErEb6vaqFf7bh/s7nkA5pH/DkMYfui567rVQ/b4VjA66IXrqeEWG9vpeH6frevRsO6DeI3YCa/idZ+I5UZk0xdDdBj3V6cbTPvpcrht2VR0BNVrQ6+zDgjPTqu3mrXP9OF73yBqMdtiRYTSRgAq6SYPCUrrqwjKPcb0Tb/2Ccy2Vrxta
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(6486002)(38100700002)(6512007)(26005)(186003)(5660300002)(83380400001)(6506007)(2616005)(8936002)(2906002)(107886003)(44832011)(41300700001)(8676002)(6666004)(66946007)(36756003)(478600001)(6916009)(66556008)(4326008)(66476007)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9PADLxyAObRFyossj6QZMArRSkRy0iXkiSkci6Vqr8U41+44CU4rWYY/lN34?=
 =?us-ascii?Q?6DVDHIQwRscvKXjfhecVZz4IQfBZEAnZ/JUrz+qLpAovov5CA8tYxL/wk3GS?=
 =?us-ascii?Q?l12RQmNddM91WYcyedX2Gdnf84FfCmnp344hxJ5HK8Fn/DS9fm+EJor3cHio?=
 =?us-ascii?Q?Ja4CkC3Ra3E4M95qH9/0RBitCGWgpQODeyZZpmwnXXJZsV8CkyR9bJ3OiIgx?=
 =?us-ascii?Q?vci57pSDfFs4zEw+7tNp+8OCS7GVdG1ZlRS3gZwWGMdHDDUAvmQkqUPXbpIw?=
 =?us-ascii?Q?VgGapcQ1fTRZygzYb6z9dLWpLCSuI0W5UWm8+eVj+U1yO0iizX1T9CSktuq7?=
 =?us-ascii?Q?8quDHHH2NuYtgLP7FUC1hExi019gxdszXgxTj/4UhL+vh3lAeymwPlW0K17h?=
 =?us-ascii?Q?RZ7+4e5E0N8RXkXG7wfer3f8JF8Jq9JauX+JWZ1zflCQs7oxpM8ASk2fE2h+?=
 =?us-ascii?Q?8CwxvPLu3GIH78I2ykYFW/aA9VdR9opjscqPsdFG78FUL+Aqa30liMOr7b4k?=
 =?us-ascii?Q?vMAJRXWuKZxbuGixJjofZRxhjUSubo3n503FSSxh70hg6y0CMfhFZIOWgvJp?=
 =?us-ascii?Q?q4OI6VsdNyc9Z/VCgCfd4cdpGRZmGHQ+/2ZxMO3FdHC4LTQTuwXD0KScKW4T?=
 =?us-ascii?Q?2pVpNQMrFRTds6d32Fdd3JySQCjOss4zrHa3Fc+lokEeihU1hpZFevwXOi38?=
 =?us-ascii?Q?+g363BP55g1QsAANz2WZYjVzTlm70SY409zlQ/gD7O0KqzdqrWCaomkBkF7R?=
 =?us-ascii?Q?3X6jy6eaXD4Uqd4j5IEjhIfswZHHutb5TeD+msMfe/ho4owt/HIu4vANchEh?=
 =?us-ascii?Q?ySp6BadNPiDwuk7waAOb9pQH6fPmvnw7hqDSvrsFNbRWtpZGf1zBH+2VRzWh?=
 =?us-ascii?Q?KBvkhDpJujfKgBBluF6S0Rc41csPw5+PNs6zJSOkpR3gyv7Zhr0VbtMV1Fi8?=
 =?us-ascii?Q?luRuPmGIKEfIZVsipnESjWKIFC8XEguCLDbPs89kXQvHStZeZjpaOVe6GIGv?=
 =?us-ascii?Q?VBiKehBR0BwqO3PHjK6LLZvUjv9vkQEh5ljY8sL13Sj+7KLHWoZ3nxQWtg66?=
 =?us-ascii?Q?EwmRxaXfeedJn/zEEmB87zzgVINR9wB2Ix+kf12Bcfqu39mMRPQ1d5v20rMi?=
 =?us-ascii?Q?MTjf6jTrhjraTelIjWhCRZWcwUViwu+HIiQUf/txvoxXyxkPpiYsnIvTsJpg?=
 =?us-ascii?Q?+aPrzooq0xN4pTk6Fa+OGTFCnWrwuou5r+DlCr6wPvhaIzZ059EDnJC5JB+Q?=
 =?us-ascii?Q?uMOwHfjBVlL/qfqWEU8CNU4g6YviNsmIikCN3D8LGjubdH7RyDAxPJzaCYxx?=
 =?us-ascii?Q?gUl7nOR/Q61gAuB85BgafpE1ULMdaO5xfAE5bbkapjOj/mZE3okPBuc0JoJn?=
 =?us-ascii?Q?XVpPXJqXbMQ0zqUif4HhcKi/BYOMmzutSx3cUMySXid3QKIh6Da5UKNXJ9us?=
 =?us-ascii?Q?HEVtUJ4HoXg5E54d1z+Js7EhAE4WqfXR6vYXGG5ehwG9d0Q0BTQWU1+y/JiJ?=
 =?us-ascii?Q?pNSlnKmtNbU/PdgA1LjXvz6WGjS5KBR7UPSqdGXmFFMxR/gs7jdTJeqE3NYO?=
 =?us-ascii?Q?pTycgdeC8wEQEIFhoh4vzRMivr3ooTFVMXqsZA8p?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2672d2c-af67-412f-3a7b-08db666cbb15
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:02:18.5574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLRwsJVGERsmZLHc4avv1WmrVRQBsBaMAiv4+RRA/hZH7df1DZX2VxljAj2Ws7k3/WIBd3aiSeRyj9gQGSSVGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10059

Add more bpf_burst related functions into bpf_mptcp_sched_kfunc_set to make
sure these helpers can be accessed from the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 7 +++++++
 net/mptcp/protocol.c | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 719d673ad346..ddcd803227d0 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -187,6 +187,13 @@ bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk)
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
index 55c2be2b14f2..e416e4a7b82d 100644
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

