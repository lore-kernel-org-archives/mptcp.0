Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80084.outbound.protection.outlook.com [40.107.8.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4760D7A
	for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 13:06:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odQNUYUU6JrQPBzyf3CxfXABmV850+1ACHM8d4Qgfe/roD9RT92MRRGyPA8gUI9TWts2p/9ErQbLmpQ9SbVjj/DQRccQbiT7DjcHNJxFjYJL8ApyvLWkaquEqh7YeNMU5qf/W4rEyzp8jZ3vsKAht2yEdZXBbgE6fm+1YGMxYvordZ2DU/MrpT4HZMhyRX6JjSTTFlp4vB2F8khlyFZeGjgsnINay6W5AfUBQBKr0xc6M2AfZAEUEoDq73JcqS4cQIKzaEvavxLsvF8WQlp+H0JhurwEKO0s1ry5iWHYegaUfbyk6UpJaCYVBmFQLAOAg63JHMXAkW4HNyo2W6whKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k//k8OTe91q8gEkdwGPu8BzoNho4qVLoVa1cgp5VN5s=;
 b=J+d+sWvmOxLwe7FFsaNT1rcScN5/uC2fN/+RjNzRHweQt35YA98hF7KC8pVgPsVgOl2qBgGBBKNESJRD+FsyAxyiJMMEk0zuUJWH1tEzBxkzoJ3U6iWDvdLIMxqAOIsPIT0NXD1Q4kOPpyB8lGsWZcHwt9uONE++JdT19ZtevbX0SttgkqAgbMTLT7H4rNxi6g8ugvP4Cjt1c+M1ywgDQEQdpWtJuCQnXWE5et6hu9VgqPSsOw6GqFdKalffKinY84KvlgUUeXMSBuVwdpZG83vlQ5wx5tued1bgYTk7n4vVKYgizXgmDFth4qFP6BAEOMM+d0tn2UCeIKbPmjSZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k//k8OTe91q8gEkdwGPu8BzoNho4qVLoVa1cgp5VN5s=;
 b=iV3shq65tDNog+zv7EC0PmDO40GGI/2HTKK3QcGKrrKPjkj7PfxuB36bWup8U7lpQg8DfXnLMYO1EOubPAyvzW4zCyBlm3nUcvP8I27ez1bQj9yjsHjmyOHj13DD04Ve7M6C0UJvzS2wiHu96fFcKZokKXtsxtx+Kg0BD8DM5e+gyDbGcrhQc+fIDVj0CsyB+Ow7tLRQl4ZaVKY2TVA2qfJIWwxFfpGjpXujDXuO8DhwyrnRy2zWbLfCWJLafxMIrbGyjnmMbjyskz5EUzXrOzvfJXWM2+mLxlDWSmsTC2gvPO34uhVoFR10s0FaUi/NOSd1aQar3grqG4N0qHYNuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2725.eurprd04.prod.outlook.com (2603:10a6:4:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 13:06:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 13:06:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 4/9] mptcp: add sched_get_retrans wrapper
Date: Fri, 10 Jun 2022 21:05:29 +0800
Message-Id: <8913ed36185b60f09a3f0fc9dabadb5e11395432.1654865847.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654865847.git.geliang.tang@suse.com>
References: <cover.1654865847.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0132.apcprd03.prod.outlook.com
 (2603:1096:4:91::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcb7de0e-8729-48d4-e77f-08da4ae1fe51
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2725:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB272529D77E8843FC423B404CF8A69@DB6PR0402MB2725.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Mks0ZOgMG4KxDIZZB6vMYegygnVYyvoGVH6HpBWb73Ht7YAZiFMQyZxOPZx43Q76aqq6m5pbH8a5k7Qom+66Y7s3dACSzaSxKsYMC/3GQaU+ttOp+lRdXjKqV/XVm2nMrwITU1MdRhgUNfYd8kyauB96zxVazbGJv/CI/9icwq2ydZNC96bFTjoKMBwJduuaLQtlLcJd/uBrvOMSD5u2TRiV/Jg42PW3f9XQ2Z4Mz38eKM5crv7RPoZHRBrFndV9/hVy15WUTsopGUkFkwc8PHU73FrB7q8yz36FiCeFxy3uC59H87OMDUA6rBSKmr9pL1nIf3Ch/fEVDKbcKPrROWLk5j1l4NOcm5pPLD9kcISDzbdZj9UAC5lEVtTuDczfG1ulCJDk+sTa07Rj8TDveSwy2mwD8BDMP4LE/kpXpibRFoowIJ4fzewt9gBH0Re7RvdBxSqqIHldNRQKS7KapfF8y1IpaHr5JnuJlbROPl/js2250ZkFtHCVazTYFrdIYRMiYk71CaIlonOBr/Q4E8Brr0D3XJ74Rviru4XHZqq9pjQonb55wxSI/gfZCV82d5/lvJrJap42k1wyPkMlIueLxpVh2OHZG1G+M5ynYR0632py+47b0cTG6fXxSkwExICNOLaR/KFMYymCTQaYGUSqHwc6S5000B4qt5gstrlBvv7RkrwSFUe6EoUvu1TTYyhgm4OWzJKIdPBkZrYJKg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(26005)(6666004)(2906002)(44832011)(86362001)(6486002)(508600001)(6506007)(83380400001)(2616005)(107886003)(186003)(8936002)(36756003)(38100700002)(5660300002)(316002)(8676002)(4326008)(6916009)(66476007)(66556008)(66946007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yqukfgF2BThJ73hni7EJOa1Cxazf2CVETLrDM+9DCRhuhspK5v/ALNxkv9ql?=
 =?us-ascii?Q?eWrf09z0QT2H7XE2fnPkSv9ZdXVK62Aax1wdD0+j28Lb1MeE3H3D3I1uKtSn?=
 =?us-ascii?Q?x2gmsUfnT13TQjL6bXDt3XUhvOflALpTtSt8nirL4swFswaHRYlvn+gLSGt+?=
 =?us-ascii?Q?9QOOBz2mR0KOP/uZwHRPKTXHn+ZA4hk29/OIGg3MGbhLmGrIXWmbIAIyMr/u?=
 =?us-ascii?Q?mmmdgiO1Flw2wNN6chxpnyK6/tMYKFJwDHV2KSo99pRTuawT3tcTTIM8Spfe?=
 =?us-ascii?Q?msZIyXPh7Ne0ioWvU4qFs/MYWKeieSm1YS79PZDdo7xMOFmKnFGT8Ryb/TAz?=
 =?us-ascii?Q?wsQvtS/GSQ1AM7fnEfr/GPPGU6I3oQPmf9DxeL8CHxb1+iG2+UVao9trl0M9?=
 =?us-ascii?Q?yoBCTac9XoJmbCkSuVaMpLraZDlKLzhImyAe1ScgGGnZ0VNn6ch1QvlZFnTN?=
 =?us-ascii?Q?CB2QF8BfjsNnnmwMyY1ZQO9AEfmBteqQIprRLVpmGFBThebklfQeyix9jW3L?=
 =?us-ascii?Q?bfMx5z6SknD9QwLPk529NQMzreBSYCP1ZLTaaZvSeExw0ESx4swvux/hghbb?=
 =?us-ascii?Q?fPqsEtt7bmo9z3OigxWgkHlOjGewnwa2koK0ue3Hl7j9zmzhkFk1MhjnxKxa?=
 =?us-ascii?Q?Y6bp25X6V7NtzEl5GQNCpVG9StEAMerGk9ltifIrmho0n9iP82xE084FRRs+?=
 =?us-ascii?Q?+41Mq0h7ZOJzSH82FSLof6eP4UIpODKiMTxWxUBlyi7A9QkwpNdAwBAzhaGG?=
 =?us-ascii?Q?7ZAkXgR83MzAr+JO6AiprKsl/G12u4gI3/2+bkmKajPum5DkcqaJvKn6cLNE?=
 =?us-ascii?Q?VwJj5/jHokg0Phir8Sqw4sLC8BYRJb+fjpo8OnDukk0MtJCF7o37bv6sewJ7?=
 =?us-ascii?Q?ORM19hrLXJ92Sbh/qKD5QHp7Re5kJkIO/G+r336j8qGNOnHN4GvQLiN9H+ql?=
 =?us-ascii?Q?1V7neXgPC0bv4wJO+bV2erVcy+rYP94kiv/2I6UjjSIUlo1kA+rTfmJykUp8?=
 =?us-ascii?Q?snU8PouJTGN7PAiQWqrINedqjp0gggs3ffmrCCOiuiguNdiab7DrGffZObrn?=
 =?us-ascii?Q?BemS5JhXtufPlsBxWH/ojmvoUsulTpTpGfmJ5upzvHFoM9Vj0IVpYZJzfV6L?=
 =?us-ascii?Q?fYzCifyO5v0vRd5PQz3fUOFkjS/Opoxu38OJtpfScxddDiTcLr59MDTEjFFD?=
 =?us-ascii?Q?qxPef1PyhD3RylwO5rn0iBSa2PFg5Fynliizqo6tmf+9B/EvjYCHEZjFjLhV?=
 =?us-ascii?Q?+W9IHvfbR4voy3cMvd3FdNR2ZgTPlQ/xqvSueBCSB5pYP5H2KVHBNVXiiQ52?=
 =?us-ascii?Q?TW9j2WhKRfhL1Kqm0QNOmHf7Wn0UXnTJO9WVkjngqOnY5zBnOl6L5ya0gbeP?=
 =?us-ascii?Q?BxX3INW5OYTqV0dVpc0tlscoz/XjPNZn9CbjUVTJqV7B44+t83rHF/skENvl?=
 =?us-ascii?Q?ce/9wjWkFajjDYdg+A9Ytn+ej1Bra0g8rAnTxhMXrbSOm0T8k8wRssXTccXR?=
 =?us-ascii?Q?U1DNLvRoNg4KHTZFWGtX1Za3N4gUnDIjDTieL/Jgf5COv/V/ReqGCPfE4y0A?=
 =?us-ascii?Q?LweQu86+0II5ouy4oRwiCHbDxs0xgKaGgHUTnwQ3SYA0IK6PA4GjjbJLSsY8?=
 =?us-ascii?Q?U9oKEfksOjxs6ysvoPumoYTXiM3tWbAdZXVU/zZv+NjnY0tJFHH6VmPvQmmi?=
 =?us-ascii?Q?44Tf880gs1VHRd7Wm0k41wi3IBXZ1n0PisJn7ssr56mIsq+XweEwJCGi4h4t?=
 =?us-ascii?Q?sRZxfh5vW5cKFhSMPmEYPWIxCTSerhE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb7de0e-8729-48d4-e77f-08da4ae1fe51
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 13:06:12.3723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4G7e7RPa2Dn2Jlj87gio90a9ecK3D9559Mi+yLrCQ9IRFYAjCr9I2v6XsSFtPnEK+JOyoy/DJrfRr1L8oK8+EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2725

This patch defines a wrapper named mptcp_sched_get_retrans(), invoke
mptcp_subflow_get_retrans() or get_subflow() of msk->sched in it.

Move sock_owned_by_me() and the fallback check code from
mptcp_subflow_get_retans() into this wrapper.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  7 +------
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 25 +++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 257b04315271..3bb3445c1eaf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2241,17 +2241,12 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
-	sock_owned_by_me((const struct sock *)msk);
-
-	if (__mptcp_check_fallback(msk))
-		return NULL;
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a5a6e8aed5c7..c4ce576458a2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -633,7 +633,9 @@ void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, int *err);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 527ea07982c5..0ac80eb9a428 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -164,3 +164,28 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, int *err)
 
 	return ssk;
 }
+
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
+{
+	struct mptcp_sched_data data;
+	struct sock *ssk = NULL;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_retrans */
+	if (__mptcp_check_fallback(msk))
+		return -EINVAL;
+
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	mptcp_sched_data_init(msk, true, &data);
+	msk->sched->get_subflow(msk, &data);
+
+	return 0;
+}
-- 
2.35.3

