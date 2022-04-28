Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832DF7B
	for <mptcp@lists.linux.dev>; Thu, 28 Apr 2022 05:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651123425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yq2JfT5nk8OB7W21oSjURxVuNW6ex/ve5XNpf/rJBgg=;
	b=PrYIEqFVA5xHJkM9WaiWI/geIm+TzJONT5M/2G8AYof30Fg0oTeGoGIW3hqa2wfMj52Eqy
	4K6zmeVVmy4fAIZKK36xVNWpb7tlDjB0jL3vy2sXHxL6T8OxgJbRpyFsBle5eN3NkEMkmK
	6B+ZycRuGbgc7tAI67OtmUHIPCIARHc=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2059.outbound.protection.outlook.com [104.47.8.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-gUZdTCoZNCOhAk2NF6nH1Q-1; Thu, 28 Apr 2022 07:23:44 +0200
X-MC-Unique: gUZdTCoZNCOhAk2NF6nH1Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbSS6HHU+Qf0bEUW5Dc9Zd6sRDZmLC/zdygfi01B3WdiMSmEI/vrGZAFFzY+G2X6j3MBsNcXSgMbr5HMu+agDCqi/1YombJwV51NPd2wBsfkovke264fkRrNLq/CRGeSAlUiBR2SUkWYihBneYZlM6qhWEHNlWpO1UBYTiFKTNbCYj1VCo9IxRT1GeGl4uUZdeaYs5wrhybrI4Zo1/S6WlpKshHBlJEUcYtCEZ76XHf4/dCp4gaPCL+0pMqlFYAf+vjvOFfOMqf/xl5nB+Kf51fS+xlbJy3X5C4khuzFis25YZJXikCtfHhE13SGOuGNdFSQBfbdgiURzmVIDFDRUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUdSSIarwe/cjQWplVBsLsOF94GMvWL1e6fcj1kULxY=;
 b=VENeB9VTdRAmh9nunM0SDz0BUwKhVYQzC1j/nkbU/PQpDWOX3rLkkuAPoGVg8maNLE9gVCkDplSFzZpaMWFgH11big7ezInOBq0Z/5NCVWFdnjYv64nj5D2IXTvHxz+1bkxi1RrCi1FkxHhmT4nO2ATDiZX5kTxcsdAOEYzaJgg/Bkt2871dtphyltj/Rwx9UBx96vdODPAfmkTcv9mMlCgQ1Oqsxqm8FqjhcAmNi4YCMmLGiVL2S/z82UCMb7G7o1Zym8NO20Zi66GPr5aM8S9z119gXlslgx7ULctw9IJL9gZ71S7hGd8gKptaKp2fsvwAnE26+U8afZt8c74tHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5653.eurprd04.prod.outlook.com (2603:10a6:20b:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 05:23:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 05:23:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 3/8] mptcp: add sched in mptcp_sock
Date: Thu, 28 Apr 2022 13:23:30 +0800
Message-ID: <01d9e01005e1697bd14ee1114222306d44883691.1651123078.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651123078.git.geliang.tang@suse.com>
References: <cover.1651123078.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:203:b0::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37c2b7d0-d911-4a12-a6bb-08da28d742c3
X-MS-TrafficTypeDiagnostic: AM6PR04MB5653:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB5653F439537FC6CFF3EE0D23F8FD9@AM6PR04MB5653.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9hlRMi04zTY052tWy3LnvqIVEQVJwIDxFpZj5jlPB0Apb8r6apOwXUxZtPjJQ+Q/msbgRUmmrUcDe2jKENQs657i6kczmyJ03ACXw1Ng8Ixa58iPUFgiwib01RU43bJ1xdHQxSB3fu5Bg/nwE7xTMz9GVQ0v6aIVGzcmolJhBLz/llppnVzLZEzG5i9xJUGvULdmxfPW9RgkgCqHhokOP+rV+xH1oaM9kX3jbQCJ8+H1lYdA/2xb0oNtnd+rAU/M/D0QkrzoR8D/p8quA/o3vMrTLDrD3kmorc+9vVKAVdqgb20341aySQroACwWbEvhMjmpp1UNvOh3heolknrPx0z56/UvS2WscG1HsPqtNL+6EtWuCAcm/n+2GavFul1LGBoYY5Zj1GsVQjd9eBJzIwQoSJHM4Y62Rd/KpaWOC6A3nXdSFTFOjiXoei9YEXHNLPmDOzkJaAkFciAFCclfeiKEkKzq7ZSEJaXn4QvSmWsMjrZKSWapu1rYamVcMOm2ZaZFDZYv69N9DC0UZ3vB0MvxuKcDVvqgfSOuwpfqIaPKCWECYJ451ufSJg27sZ8NwirIQ/9ZVO93yTKoDMeXSS0zrZhj+m0V8grBb5neUhoUxtnLnC4l1/HrAhyrtFvUtkLa+Dr1AmhSJl/1OjDQPCwZfLBTrfL6TLBZci42j2vtzjRnCEajEt1wip/XPLxXH0UwOyosW4YgeafyTmEW9A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(2906002)(8676002)(66556008)(4326008)(66946007)(66476007)(6506007)(38100700002)(5660300002)(86362001)(44832011)(8936002)(508600001)(2616005)(83380400001)(26005)(6512007)(6486002)(6916009)(107886003)(316002)(36756003)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ttumj+/FiSY9qJa1SR70/lEuMx5+6kZbd5KEW7G8UN+taZwcDU8bKgJ296vt?=
 =?us-ascii?Q?Bgz4pmFPKEt3kSpfXsza2vNMgZSX4BkTuqx24mh5/X2EARryFSfqHWfrLi6v?=
 =?us-ascii?Q?Xrb9nY9T6/+Atyb26b+TZlF31sm5/AHMgl4/MVUpd4yxan1rTdENI4uNljIy?=
 =?us-ascii?Q?66cJ1v0c6USv+gK3BdWABMbxQGhigWmAeu4RclcgQtAdVU7MrydVAxmpHWak?=
 =?us-ascii?Q?GdULWtRq/VXg7Uf5xwSLkhLVH+OLVC2DqgO3oV6cvp4Ai5dU1H2QRbfRVm/Y?=
 =?us-ascii?Q?hyQ7O3rGSo8bA1K8W0cRgRuKLfHqN1Nu8NPyURh+ftSZIVh8q0N1nPb0ebeu?=
 =?us-ascii?Q?gtLMOZnJYkSRKEvt2wguLTgJhDpNySiqwye3tEA9t0t7PcClwTjbjv5txqca?=
 =?us-ascii?Q?qVn0hGrZ6XRcQHc6kIW+2SCOJ5RrWvOid2i9tzXm4UOVmOkuR+DO+/XCrje0?=
 =?us-ascii?Q?FPfu60coZSfmPSkj0qqjf72hZ+Fv0xSOo8KV3XEMEBbPBoVPU01n3AC/kPD3?=
 =?us-ascii?Q?wbdAin6HTYvnF2zkmVazO0XTaeq48G/adL5Qn1DRuQw78w7rB3URfbkZzg9f?=
 =?us-ascii?Q?7wDkYzoEY3qpTdiXLHLxaLOp5JiyJR+DoDrM6Fec3pu5jonop4dveBWTIFsS?=
 =?us-ascii?Q?gPyTOaRfVPWjuwlt59Y5SroVi+scdDz4y/7gGWLHMc9WvX5Tf6Z8vD/cSzAs?=
 =?us-ascii?Q?d7+IeL20X4ld8tB2FipvA5pnA5UycunI+GstDG5XvU0AwTW2ob0OAzj1AVtz?=
 =?us-ascii?Q?wJN+GY6Hr7DVPuSBd05A+sVyBDIEVBMNJdEFKjsNJfs7NcFwhSk0fNK8Rj1c?=
 =?us-ascii?Q?JjDw1JbPRL4pW7aJ1RWNOg/dEOOZfyHNW5TNbJ9LY6OsGFRuewBmcnFzle2k?=
 =?us-ascii?Q?9XIQPXoGwCEpVBv9ZG9aQjeYSPQ0dFmOUFIaDMLDF1ARekVL4PnZKLc3WCu8?=
 =?us-ascii?Q?TPCnK1iw1AcZc5A+KSRRQe/Ecr3xLRvWr3gR8nxEG4p2g1uE0mGPQ76c1XS/?=
 =?us-ascii?Q?+bRVUYagOWz49snaWrTPjedi1MCdT/JBjHkpd+AdH8KFoM3hdGJsTIgKyFeX?=
 =?us-ascii?Q?FDjQn7H8BGBz7C7unad+5zNVxWwbZapNR4ORWYaMgqzR1KsWb/eCZEguYSw9?=
 =?us-ascii?Q?rbuPirUljbclimSzrp33pmA5qbwcIo+6OMElb4kM3DrKByK+WVz8rMKLEm6p?=
 =?us-ascii?Q?i/Oy3BWeRGtcbV504D63Jx6NnzZkiZfN9uSoW1UbB41vFSrwCGpK2lEC25MV?=
 =?us-ascii?Q?PfY9GwmmovKK3BTypHIHIkFPsj/FTPNdBpw0yR3ZBqCG9+rTnPXK0U7Od8hX?=
 =?us-ascii?Q?SICfwGj44RVbT9Cm6P964DUyw0cRjQCUIXK2dit4remnnhE/cttr/8axmSin?=
 =?us-ascii?Q?3aGCQzRB8ye/XorqqhNpUuAkd89KFAKF/vEhyaVrYX+/lLQmZijkivc8Xfa/?=
 =?us-ascii?Q?ZBJ+6foOTmw7wWceQjYScXJUoEIUtK562o4XAQ8M96kctTNYECYKAdoh1OmY?=
 =?us-ascii?Q?2heC0AmJCaEFsEyrWNq4bIq7mLzRdo2rGqV76cmrTf8U+LNPD0h0ZR2J5ulF?=
 =?us-ascii?Q?+z+e/bI1d8gOFmT0stMjUAkZgueaJVPmepBqw+5BDNYc1gArb0KBgVTBNhtN?=
 =?us-ascii?Q?pPNlXezDiqQzQxFJAwb5Htf0u0iwjjUtc7qZMOCEEb7qVmwr/HVBPZin9j1J?=
 =?us-ascii?Q?ScTuc2M+Rozf/NY4xR/0Izl9XKmcm8KjO9kGf2rEFCf7LEFK42UDPUw3KS6r?=
 =?us-ascii?Q?CXFhfOfmQaBHWzIaEO4JYX9+C5n7K2k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c2b7d0-d911-4a12-a6bb-08da28d742c3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 05:23:43.1263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8sNwg8ejHZZ1i0uOkgc/7V1sdCqFibP6+/5mkU1Tp56hJStpLW4TKE//RHvcvruBrit0VSE4gIAvzeY6k3Nug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5653

This patch adds a new struct member sched in struct mptcp_sock.
And two helpers mptcp_init_sched() and mptcp_release_sched() to
init and release it.

Init it with the sysctl scheduler in mptcp_init_sock(), copy the
scheduler from the parent in mptcp_sk_clone(), and release it in
__mptcp_destroy_sock().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c                          |  7 ++++
 net/mptcp/protocol.h                          |  4 +++
 net/mptcp/sched.c                             | 33 +++++++++++++++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  1 +
 4 files changed, 45 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 653757ea0aca..f599b702415e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2665,6 +2665,11 @@ static int mptcp_init_sock(struct sock *sk)
 	if (ret)
 		return ret;
=20
+	ret =3D mptcp_init_sched(mptcp_sk(sk),
+			       mptcp_sched_find(mptcp_get_scheduler(net)));
+	if (ret)
+		return ret;
+
 	/* fetch the ca name; do it outside __mptcp_init_sock(), so that clone wi=
ll
 	 * propagate the correct value
 	 */
@@ -2824,6 +2829,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &sk->sk_timer);
 	mptcp_data_unlock(sk);
 	msk->pm.status =3D 0;
+	mptcp_release_sched(msk);
=20
 	/* clears msk->subflow, allowing the following loop to close
 	 * even the initial subflow
@@ -3001,6 +3007,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una =3D msk->write_seq;
 	msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
=20
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack =3D true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2f5ad12601cf..723141a888f4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -298,6 +298,7 @@ struct mptcp_sock {
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
 		u32	copied; /* bytes copied in this measurement window */
@@ -625,6 +626,9 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *=
info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+int mptcp_init_sched(struct mptcp_sock *msk,
+		     struct mptcp_sched_ops *sched);
+void mptcp_release_sched(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c5d3bbafba71..53773668b5ee 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -54,3 +54,36 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops *=
sched)
 	list_del_rcu(&sched->list);
 	spin_unlock(&mptcp_sched_list_lock);
 }
+
+int mptcp_init_sched(struct mptcp_sock *msk,
+		     struct mptcp_sched_ops *sched)
+{
+	if (!sched)
+		goto out;
+
+	if (!bpf_try_module_get(sched, sched->owner))
+		return -EBUSY;
+
+	msk->sched =3D sched;
+	if (msk->sched->init)
+		msk->sched->init(msk);
+
+	pr_debug("sched=3D%s", msk->sched->name);
+
+out:
+	return 0;
+}
+
+void mptcp_release_sched(struct mptcp_sock *msk)
+{
+	struct mptcp_sched_ops *sched =3D msk->sched;
+
+	if (!sched)
+		return;
+
+	msk->sched =3D NULL;
+	if (sched->release)
+		sched->release(msk);
+
+	bpf_module_put(sched, sched->owner);
+}
diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index de20fbdb6d98..a0b83fbe8133 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -29,6 +29,7 @@ struct mptcp_sock {
=20
 	__u32		token;
 	struct sock	*first;
+	struct mptcp_sched_ops *sched;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
--=20
2.34.1

