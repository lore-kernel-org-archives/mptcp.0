Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846F22AB50
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 10:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cikhm7EHsvffbVgoUpjPAA7xmqMZfYLEAL13QvmIfQoYJ93qZL1s3vWX/UCsruKWz4wQ7iqzJkpS4J2bAoLCvPg7Hr5WW+A1nTrGHgSftCj3kwGjRz7ewJB2E3M9EgeP4mobQyeTZwook3ucIhpxztB1U8WVtnSiQgzc84zP5IkH0HKe3e3eDBU8bmsAhu3tkD5kl9mblyPOapADgW1Ppg9nWmfjuPYqfqxvQpkiKViQgQy8CPxscbjgnRB1oUq+WGSCXWUsklHrjkLXDZDwQKQr5AIuzrNt9JMvuCDjp2rrhUhoFVxE3J4vJcfEavH9nKsHqHC9QLZ0TzL22HDwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDodEM9xw6caYX7aY5MJw1vxkQe+htbCEoXdOq5RLC4=;
 b=JQkWRdAbTpFQy8KMWZUKgyclP1tWI3mYRo0A7eisOsOTdHsE5k1q8uSXHRvIX5MQ3YHR3Sw0JrljxK66cf1XUWNCjg1R0Vib8ygzmIdlAClWNu5Mdm19h1euDc8vtA9USvp/a/BWKsF5oQH+n9oTv/AbT5u0Chs+meBCq7Uay90ETokWYqm+n7mAD00fJhY57N4UWDks5CjEXKoWqnUGpZRL0galxYq9VY4wgbaia2zNxaA6mcff7mus9/HbVPx39Cwvt246UMKh0kPhWlZIzc+cIblLtlyRwpsF1ffD5bpuZC4bZ88kRP54BtA5LIQWl3zb4yFZ5ElZEG1kxYGgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDodEM9xw6caYX7aY5MJw1vxkQe+htbCEoXdOq5RLC4=;
 b=ygyIbVAywgIPJCTiUx8SnWJdy1lREVRUEfgMyYq/kgwWX1ynmoP6/1xiLxPrhzBAdO9Ahxi3j8iLHKHe9PLbyOR89ARW3Yau6VYqYZRmlbFRyI8BvD+wtgtY4c6BaetZJlwhBKuuUMXLqox9j3M/5ZlmSm/IsFUIwC2O1whQdfyVQgoMG5/seGe/fkPWZQTvXbCJdsrPLunR6RkkQe8uyLhXDp7gmMK83Mq4CiHHVanHX5/G3VemZZXV0b4ESHAKNYR6QYuc116pQ7DUbAl05s/lrG5glOvCYW27UoFlPuddrSAQzCqAzUQBWN1+ELzb2JoIqsf4vTq5FIdT4a7kMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8607.eurprd04.prod.outlook.com (2603:10a6:102:21a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 10:02:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 10:02:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 1/8] mptcp: add NO_INITIAL_SUBFLOW flag
Date: Thu, 14 Sep 2023 18:03:18 +0800
Message-Id: <a98118c4c5347fcc1c53909c6677d84485cb0651.1694685050.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694685050.git.geliang.tang@suse.com>
References: <cover.1694685050.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PS1PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bfb814c-361a-4045-4d5b-08dbb509c620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rNjPJ5Tgk1MO/Rujj7dNRRWhly1hYpFZCIIuxTMENxSva1rPbO78BvRq5xfIAYa2Rxg/sAngwGuNdhZdeDufYAA15m9weaDMH0GNb4pZr3KpJD+Jtk9YIx4Kq9LR1xITiv3nEej1UqbFJD/KfUQifWSQ+dNxNou7VmTuirz/Cs96sLfA8hRinFd2qMWNK1f3seY374G+XUXsHIsXy+GPTcsGt+R3J7rU9jYQwTiDINU8pNCC8PUhXk/CKgJSKn2f9KbkkHAtPDySo0tRmpFOqbUqyXXFJQo94Kc4TSMzuhkzN7p0Dh4wRP3TWXcIRF7ijIRDdHJqCw+5MDhNNxK3HvzyLzqmJJZwu9gudKfm94mVsJY+DvUvWJ86rToM21QJDNpIX7nD+1pnUJcBDbw+P1ftLevYS+BQaJDee3oZhnr4ovMQyKiCDVH5Nyg+74lj42kywQrntQSyGnfk1iWvJ2SMTXF2ANguYdvGCgatRJcB/8y3x3r26Ej3huVDniJKbjBiuOTYVo/Aw5d6u+xen6fyb0emYARKqBhnw+3iKqE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(1800799009)(451199024)(186009)(83380400001)(2616005)(107886003)(26005)(36756003)(966005)(66946007)(44832011)(5660300002)(4326008)(8936002)(8676002)(2906002)(316002)(66476007)(6916009)(41300700001)(66556008)(6506007)(6512007)(6486002)(6666004)(478600001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m2RKznQnmwTsghcgjihHtQ+gIUjK+gNvfOft9PqvHcgNw0wyv9prP5212Je3?=
 =?us-ascii?Q?Z1u4G/aHiY954q9+xfZRf7Avq3yt4q7t+UUPkVlGBaY2Aa78OxUHqxUz7a77?=
 =?us-ascii?Q?exBYl91CqTaH85uXuk8nKp9OZqGYA2n2n/31pdymKbM+kRZGec35SabBj8oA?=
 =?us-ascii?Q?4exwL9zOOy2qCTseFFP7GNZg1cR8YPg5PBvjAadpHz4sVAlFctDpRw8l7TkN?=
 =?us-ascii?Q?gRP7CmSwpzl+L+eUhH65eqqECL1JSpTWJTWJERhDq9FG5StLfQjS18HCul2J?=
 =?us-ascii?Q?8wlnjARybERUMJLo9Iqtrm6qGvsQl4v2JxKYR9BryKZNge/TXUIV7od0STwa?=
 =?us-ascii?Q?ta55WRkkYSgAmUw5eLw3DLf/SQQ2lH23PX6riXkLDfujoQGfeB+Xz0rrp4Ga?=
 =?us-ascii?Q?lKKSVPvW5G8v9ikzj5FjvZpfxbvkhxbwRfAJD7/SXdfhQoBwMGm2KZ/fb0r+?=
 =?us-ascii?Q?3gHsUQ2eiBe2a41yfTV8pIJE86wFVVufkkyhU6hyYPL8AbEEjn64UZriEA4d?=
 =?us-ascii?Q?hQri0v2tl+xNP/W3EfjyXhAiF74cqv7MPOqsICG9fAZFyl7Z94+1KboEhEb4?=
 =?us-ascii?Q?dXI6vxD7Tn7r+EZN7ENp0gry4i3NzNFz6Oh22c5qCu56lDWZ6CwFzpxkx7gU?=
 =?us-ascii?Q?wMbTBmmJQnvNX5ihIxE2ABkLEriTTPZ2YpMhQY/e+bU/wzw7Vec6dCFBC3WL?=
 =?us-ascii?Q?Wbes4Sa9hXj8XRvAbzCJFHHZbB3cShfUF1SX/cXcBN8LfVuOChNjFaK0jVhx?=
 =?us-ascii?Q?IhXbt/Qf7vlAQ9av1fb04D4NpJk4SbIx6AgwEo38lvrbaCn5sJY3w6FNv5CZ?=
 =?us-ascii?Q?EKAKeJBtIrIXjL4lraYWZ4Ze5jI2Cj0vNoAweIijUgv3QsptzVHV37MWrzfm?=
 =?us-ascii?Q?17ZxbaIttRREZhFuf+U8fimng+R9Z1UEaOWdAzYzcU5i2j4Owo1t+G6HfBuT?=
 =?us-ascii?Q?H2Aqdz9iUH/5h7ZjjK+EVYlbUnDmYalozIgj1h6d/BffUAHkcq1E/I7EGOFS?=
 =?us-ascii?Q?OvfBQ00nJdqSGAdoCFWEQhm+S548vHXgLPQ+l+xJWAOsKOZIuQL3/u4pksAg?=
 =?us-ascii?Q?KfKycxxdH4UUQX3dAVc/GZsP5NvC6htmliHfV/+8fWZ2jnHwn1JDkkhEQjmD?=
 =?us-ascii?Q?mXQ/2sIuHIEFiQSsnYXeN2VLruBjZcqAelcYZjFrGtvBzOvC2NUFtZJblHiO?=
 =?us-ascii?Q?CSveK/WA2UtU/rS3k4YrL1HFHQCCstwEylkpupalqOmNl6hLTjTzk0ydXIhq?=
 =?us-ascii?Q?1hcZcEc9F1iBoBobvket9ZC3GW5grqC0L/J1g9zdug0vw2bKRixLzDh7ghtY?=
 =?us-ascii?Q?PPRqo0Z2FbBQMNV+HD1wY/frES0csU3IQwIRdvOLqed1yDytG+o3k4tmuGSK?=
 =?us-ascii?Q?yaHLpgLtPGDs1fZX/ILrSHI4ZeNaaqtusK3/Ok+BVn2dbSPofAqJznmdl9jR?=
 =?us-ascii?Q?lnc9+SZUzYAs3C7AtRMELeawB1ReTrcpqYvL3kP+L8hgI7Vh0tfjDRGmUqzI?=
 =?us-ascii?Q?s9R/1I4jeAlFORTGrGR5q80iR4S5UQX4ieoiXjrrYaLdCR/i94Nb3+QIHsyJ?=
 =?us-ascii?Q?0btkhU9tEqKdjxbAz/Cms3VlyE6e4jKHDOKr1DFm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfb814c-361a-4045-4d5b-08dbb509c620
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:02:59.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skAdYwaVOffto7iys9Fdq6LkCq6HY0++I5+ytOzEk7oqQ8lpzc6Wf/YnUPn8y94VH2S4Rm99kgmCFdm1SWcypA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8607

If the initial subflow has been removed, we cannot know without checking
other counters, e.g. ss -ti <filter> | grep -c tcp-ulp-mptcp or
getsockopt(SOL_MPTCP, MPTCP_FULL_INFO, ...) (or others except MPTCP_INFO
of course) and then check mptcp_subflow_data->num_subflows to get the
total amount of subflows.

This patch adds a new flag NO_INITIAL_SUBFLOW in mptcpi_flags to know if
the initial subflow has been removed. With this bit, we can then compute
the total amount of subflows from mptcp_info by doing something like:

  if (mptcpi_flags & MPTCP_INFO_FLAG_HAS_INITIAL_SUBFLOW)
	  mptcpi_subflows += 1;

Add two helpers __mptcp_check_no_initial_subflow() and
__mptcp_set_no_initial_subflow() too.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/428
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm_netlink.c     |  4 +++-
 net/mptcp/protocol.c       |  4 ++++
 net/mptcp/protocol.h       | 15 +++++++++++++++
 net/mptcp/sockopt.c        |  2 ++
 5 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index ee9c49f949a2..c92421866aaf 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -107,6 +107,7 @@ enum {
 
 #define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)
 #define MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED	_BITUL(1)
+#define MPTCP_INFO_FLAG_NO_INITIAL_SUBFLOW	_BITUL(2)
 
 struct mptcp_info {
 	__u8	mptcpi_subflows;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9661f3812682..ffedbb4fbd25 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1462,7 +1462,9 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info msk_local;
 
-		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
+		if (list_empty(&msk->conn_list) ||
+		    mptcp_pm_is_userspace(msk) ||
+		    __mptcp_check_no_initial_subflow(msk))
 			goto next;
 
 		mptcp_local_address((struct sock_common *)msk, &msk_local);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1a0b463f8c97..420ccd08fe92 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2461,6 +2461,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 
@@ -2469,6 +2471,8 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	 */
 	mptcp_pm_subflow_check_next(mptcp_sk(sk), ssk, subflow);
 
+	if (ssk == msk->first)
+		__mptcp_set_no_initial_subflow(msk);
 	__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_PUSH);
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3c938e3560e4..b0090ef052cb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -115,6 +115,7 @@
 #define MPTCP_WORK_RTX		2
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORK_CLOSE_SUBFLOW 5
+#define MPTCP_NO_INITIAL_SUBFLOW 6
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
@@ -1031,6 +1032,20 @@ static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 }
 
+static inline bool __mptcp_check_no_initial_subflow(const struct mptcp_sock *msk)
+{
+	return test_bit(MPTCP_NO_INITIAL_SUBFLOW, &msk->flags);
+}
+
+static inline void __mptcp_set_no_initial_subflow(struct mptcp_sock *msk)
+{
+	if (__mptcp_check_no_initial_subflow(msk)) {
+		pr_debug("no initial subflow (msk=%p)", msk);
+		return;
+	}
+	set_bit(MPTCP_NO_INITIAL_SUBFLOW, &msk->flags);
+}
+
 static inline void mptcp_do_fallback(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8260202c0066..aebf692543a5 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -919,6 +919,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 		flags |= MPTCP_INFO_FLAG_FALLBACK;
 	if (READ_ONCE(msk->can_ack))
 		flags |= MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
+	if (__mptcp_check_no_initial_subflow(msk))
+		flags |= MPTCP_INFO_FLAG_NO_INITIAL_SUBFLOW;
 	info->mptcpi_flags = flags;
 	mptcp_data_lock(sk);
 	info->mptcpi_snd_una = msk->snd_una;
-- 
2.35.3

