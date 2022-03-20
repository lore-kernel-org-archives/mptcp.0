Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0752033D3
	for <mptcp@lists.linux.dev>; Sun, 20 Mar 2022 14:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647785387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MfH3hdWyqlKw9522kDkQmEBVXH2ibBELkC33ciaBLFo=;
	b=TCfIsYZbA839zYomPbfM2xlwRIlJ0WWbHdLJ8PgKAf+OECYtN6/bLlHdOhnIQ3FiEBPUgH
	Wn6KUdj4tUZ+tKDHthBnfFCmqfYmrfDMl7YF7ghtFs3LOrwd9b2eI2CSV3zCPaZ76z29xA
	H+pjtZ1queKi/JITWZP/hL8FgHENdCg=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2058.outbound.protection.outlook.com [104.47.6.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-uqVvC4UBPEKVfHAg4IcuEg-1; Sun, 20 Mar 2022 15:09:46 +0100
X-MC-Unique: uqVvC4UBPEKVfHAg4IcuEg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiEdsVrIIs4PuaOOheRdaMVHn05wgzbPRJe4BQ9eEprBOth29AO1xw+vczqqIgOB3c+ivmzww0k8BOJezRrYR1FtUDPgIpoUG7Qg2A5FqEn4YtyaDZ2sF8WXveEmwYk92BSzO1+l6u1l13Gk3SJ9MKuIi43ryZ9k5f9PcI02eW02eT/7IqVGgL9cj9VoD/OVDOI45liHk79B9lT5O4YXVpI5J4m6jfldWa1C5yeqrcbT1hIanVOkywHYO+Yx8/+KWhUnJs6RF5PIEUgK7uleUYqanjhzzMCb9znYvKLlXizRU2IX31rYhChFHmMM+7dHywjQqJT/PpuUO4d4l/QgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9XOGTNLGsZdMAVOwUKoh+cSbUrneDbY235pei5/U44=;
 b=VsL92dqSBOEfsPqFtSajAutwBwHYQvf+zoKQkrGAmBL6MIhDLGNoYbQKvdhrfx2o6pr7FcS3yYk8bmenklwXguNiXrnkFlhqereTQLFkeSHR2IkUSOFSpOEoVllsWZ9lncfUePK7W7xK6a7xqb/dJky6phUldZgFCnCnOMorKX1fK+hd/sHig7BSHD83LnyP6Q7QOhcsjCqF0boUMMcf/Kb6dXfiFJ3pjW4Oo1yR9Z0rvLKkofF9kkl268kUmlUB4Zf3kRvAx1UeFdE5aSxyPk+3RSC36ujRz8mhyosCl+kk6sS95zEATy1xx3olzJzQ2vQiONjWr/aTsIN6TbdGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7035.eurprd04.prod.outlook.com (2603:10a6:10:127::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Sun, 20 Mar
 2022 14:09:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 14:09:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 4/8] mptcp: add sched in mptcp_sock
Date: Sun, 20 Mar 2022 22:09:08 +0800
Message-ID: <3da994e7f2bcc1a3bc03bebfb7215d55cd56bef4.1647784679.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647784679.git.geliang.tang@suse.com>
References: <cover.1647784679.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:203:d0::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e2bce33-d743-4d60-5c31-08da0a7b4914
X-MS-TrafficTypeDiagnostic: DB8PR04MB7035:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB703527A38327BE873D4CF6DEF8159@DB8PR04MB7035.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qUEDgE7RVePtqnbgK5v8SEuuHxfAaSWtnsAnThD8acLs6hFNgXHC8ea4GwCmpHCGNfE8+gCPoI/ugkiJF7+8S4uBuW587zDKBJgEU48O/OIOfVqa4mdnEqHrbCzDATwU7hI/XbZecySzFrGIFG5IUbqf82QtlNQF8T1Hvm5tz9FckLLHgX/9eiKqFdDOGJp1TZiCM73v+L9jY2o6jnleskoXpQKEc0PdaDYNRjjdnqpQYF0d8jVv6VjIU2Rn0Zvpey2mHx6x3QeP3Efsms6anAaATrjj5VMUHmgeDpFF5SGdelZ9tOIMFbIm9vL3WoMqMvW4PZmcGsVyq4h+GufgM1gGqoXTjsU+V7umEIUA773ZpqIx6Qp776enTuHih+gCGADZGAt43kLzwRrpmEmnOlykIESaSLhJssgoHfIQR6VQAs6svx34W8eNBsq9CeQTIQpQ4hZhC46QUs6gkW61lQa2ltvJkjzXkH5LtSGII1xB1JVHAF7pXGHLxb8mZeG9sPXyTiovRAcH/nbMbqG7R8xooZL6sCZmPjxvKtVDApLFz84ihVLaTDBHZ3i4tV2fLL/59WCL3wT0WTCvUWiW2IaFiDurrb0hNE1s1plTr+2TssyZMqCzaWgsFSUiyJztPnfMVzDA4Zt3YPkrxhn0QVsyFWmuzwcodYSejeRG2MWF0mV2/FglnUAggPUQW41TTfClL7/terTmazu+d4CQXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(83380400001)(44832011)(66946007)(66476007)(8676002)(66556008)(4326008)(6486002)(6506007)(508600001)(6666004)(2906002)(36756003)(86362001)(2616005)(107886003)(186003)(26005)(8936002)(6916009)(5660300002)(316002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ihSOgglkIu9nfBqDZ8yczV0wgWOPfnZ1N6qJP2+/PEJo80CNCPyuQimutHZ?=
 =?us-ascii?Q?ZbrorFiv8Tv9ADcPWquVoY1g5+zDgFG/ViXLDLC91Esj2DfoOnKAkytV/kRN?=
 =?us-ascii?Q?6oJae6abfu5rRPmXkU3hTLV3u80zsagnvuYaEcitP4S7tzOBSH58Hk+1n3bl?=
 =?us-ascii?Q?4D+NBKeQroEOIk4myiIabjVHxehvFRuCb3z3k+2RcdLn4Rfh7OzDCNF9Gd/L?=
 =?us-ascii?Q?ihtl0073ga0SFmRImcsE/6zYY4cqsPYAUoBBYFCNVjWe8kFKaoaA56Vh+s+F?=
 =?us-ascii?Q?6FPNBJOXjXdPeUEZL0/a6iR6atgUl8fgV/La9rJ/rjHCx7jZvywgHrquuL/r?=
 =?us-ascii?Q?u0e/y5tv+hFtVndB5TIm5St/Giz+S+ejyWYBWiNuoQyLw+t1K4TZEvD3VGPm?=
 =?us-ascii?Q?GSnGLimzMat/Ct8Pu85NdomVOLrw7XfyACQz+mfvtEQceqsEzaY9cqHnVJMI?=
 =?us-ascii?Q?SFLkW5riBZxbKuIrezcFoWc15+vUNBs7Bkr+ICTx3loWTohU1PQpUwB+Lach?=
 =?us-ascii?Q?qv4QL/xPwiWHpr3/+1kDtILfUShkdSLXQaZvZkvXyx0sztnLVM9dzW3AnUP9?=
 =?us-ascii?Q?SJ/FoU2M/xAoK5wIm+PF0l3Nhx0lAHojgUdGQEgAcrPsOH5/3iC7pi/OVsN8?=
 =?us-ascii?Q?mcIaYeSjYjNewCvSlOsw4r/6XAT4YBOHWMPCBuoV9WU3fGAex7+if1SKwlBR?=
 =?us-ascii?Q?HoZjM05vC3hALqjnHWZDH8eKBoPr9ohv/KtinLu9hc/U9sQ6jJKnzkUn2Hsy?=
 =?us-ascii?Q?XoYwEbp5DUzq9r0Ll2rM8YvLEa4yUJ8vWDIfAAjL+4ouBnEvuqEJBxT2un79?=
 =?us-ascii?Q?saYeLjjreGmNvJqAeF5SwNSpyU+xX8IzXOD0OAkeVOpGbTNHzYIePLFqkUrO?=
 =?us-ascii?Q?28ZVbGQXSUL++zwx1RKf2NrUpF9GVEk2ftXFQG6U4z2zVRQOkPohguoI1NkR?=
 =?us-ascii?Q?MJUJ7GL6a9Rs+cfkD4tTj2QrHFEtftp3K5Ewg9/rFYoRxhYB5YatFo9uqzbr?=
 =?us-ascii?Q?6mwInxkQONvGvuKEnm6jZU/NL/tIB7JHPCOaJ8SktN/zmHuAWbzfdxJpSFsK?=
 =?us-ascii?Q?mAzyb7NyyeYCvR/XyAYKM6k8W4eVeo3DeRY+649dQGE1DxhzAUPj0YQyU2w/?=
 =?us-ascii?Q?zYZf3FPOspyu5VkLbrhUmHaBfUeLaDTyhe431YKGhKe+9mEsUxMYqBbqmLdd?=
 =?us-ascii?Q?Sb8EyGu2k95yMic+qMDiMU9oMK7ofvthRYmgSdcssPXNVf1iF5tFaAzILEDk?=
 =?us-ascii?Q?Av2lT9HA5/geeEQN4Wcl69WHDfgZB1MvyDC+Vj/L0i3hKSawzGqtRaJysSrC?=
 =?us-ascii?Q?jHZ7CbqwLZ/Lnav6QHLnG/wqR4qfJXjtGIZ+I9hxbZV5+XjR/xICs3rwIaB0?=
 =?us-ascii?Q?bqETG5U1X3Tb37XW7CpXhgd3phoazcID+Va91DI/klKE2YYZBVfowwEiZahn?=
 =?us-ascii?Q?uJU1m9TsrwNUcC79XbpaaTovo/IxYUO0/5XXWV84zJ85KzC2zlrQ6A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2bce33-d743-4d60-5c31-08da0a7b4914
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 14:09:45.2797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+3bc3pLR3iGIkDD22bYFUwaSFKZ1jGe2BPHK0YXzf5S4wXt0fzD3hMMNNDtdOJHfHplawtu2sBhiC48t9F7Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035

This patch added a new struct member sched in struct mptcp_sock.
And two helpers mptcp_init_sched() and mptcp_release_sched() to
init and release it.

Init it with the sysctl scheduler in mptcp_init_sock(), copy the
scheduler from the parent in mptcp_sk_clone(), and release it in
__mptcp_destroy_sock().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  4 ++++
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/sched.c    | 20 ++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 11e19ac9d5af..c892e3b6b65c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2609,6 +2609,8 @@ static int mptcp_init_sock(struct sock *sk)
 	 * propagate the correct value
 	 */
 	mptcp_ca_reset(sk);
+	mptcp_init_sched(mptcp_sk(sk),
+			 mptcp_sched_find(mptcp_get_scheduler(net)));
=20
 	sk_sockets_allocated_inc(sk);
 	sk->sk_rcvbuf =3D sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
@@ -2760,6 +2762,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status =3D 0;
+	mptcp_release_sched(msk);
=20
 	/* clears msk->subflow, allowing the following loop to close
 	 * even the initial subflow
@@ -2933,6 +2936,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una =3D msk->write_seq;
 	msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
=20
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack =3D true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f0bd2e17f2d6..21bb248a2c82 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -286,6 +286,7 @@ struct mptcp_sock {
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
 		u32	copied; /* bytes copied in this measurement window */
@@ -609,6 +610,9 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *=
info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_init_sched(struct mptcp_sock *msk,
+		      struct mptcp_sched_ops *sched);
+void mptcp_release_sched(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 void mptcp_sched_init(void);
=20
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 331e6517622a..c1a4c5170b8d 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -54,6 +54,26 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops *=
sched)
 	synchronize_rcu();
 }
=20
+void mptcp_init_sched(struct mptcp_sock *msk,
+		      struct mptcp_sched_ops *sched)
+{
+	if (!sched)
+		return;
+
+	msk->sched =3D sched;
+	if (msk->sched->init)
+		msk->sched->init(msk);
+
+	pr_debug("sched=3D%s", msk->sched->name);
+}
+
+void mptcp_release_sched(struct mptcp_sock *msk)
+{
+	if (msk->sched->release)
+		msk->sched->release(msk);
+	msk->sched =3D NULL;
+}
+
 static struct mptcp_sched_ops mptcp_sched_default =3D {
 	.get_subflow    =3D mptcp_subflow_get_send,
 	.name           =3D "default",
--=20
2.34.1

