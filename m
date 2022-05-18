Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7F91852
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 06:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652854357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCLsj40x25g3Ark2+g+oek91EfM6HtjnqWHZgh8Ethc=;
	b=JzjsNfB3h8hhf8dxQio5CGlQD8fXtP4lIfY6AuqONEmzCYSy2futbMdMZ5vvrygu7Owwn9
	hDfczdLkQka78elYC2eK2/nr5SxwDoym3xryVITjxQDq8wwEMzneStb+FMJVj29wM+aBsu
	O0q6X4N8PRA475fKvm9F7CpQWdFtifI=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-en-p_6AIO3excRGCT_itSg-1; Wed, 18 May 2022 08:12:36 +0200
X-MC-Unique: en-p_6AIO3excRGCT_itSg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOmsuBVaIKTSCwpaa9XTi63RB4MHmsT687hC3OOS+gJc0KLPaUK3q9/gbpEZ2SLMCUUIYpCfqZrc/tCGrTq2XldUNLUcGPFjbbgsYQiAt9+5p7AcrkLohjib8YP6duBbY4CYaRF77gFpyuUQAQ0kmwSJH0WofV2MXd5pTswBc1lRtO0z6A7YVLL+gr3EmVWk0U+QB5Q20wVa0jUDh53wpciiLbwQJkWPosLVPkMNcVMtBxjaPKMEHgsdQND5rx/FRgssEk5gj/y9PHCAF7F7vuI5uGDFqQ43PyHOSLYKCfKoGMK2tz85F8TLayAd5tr3od6vSxkvXZgY0MQrY0KH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ka8CttP3Yvsn6gRKGFrDYl3jDV6fnSAIpIoXwGUrpfo=;
 b=MPnQo5CSkXLrsRp0mb6yLfG8BnYlVJq4dcIjvaA1qwmTmFtTDegT3ajMVrTFBR6bX8uEAABSN01rj+OKpH3I7ugDzZVSAU9wUxeVq2QuqQrTNOR/WgTpqOLwn/3kD4rp22KUyQo8YCgK64DCY+RmwHsawh8sWFGwHwI5NkxkdBpTKLZj3PaNcOGOICQgh9s4b+VN9W5CtoxwMxfNsEOEtsMX8Kn5GkevggHnIMprUoKPrM+lTpM8dMGNnB8TzE2Oe/pxNp1RJMP1Iu3p6c76awN22WxWOd7g7gFL4xFgaD2rlhMchi0oZ0ncbCFe653w1dIBtjdN7oCOS8vOgCPwOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2584.eurprd04.prod.outlook.com (2603:10a6:4:38::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 06:12:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:12:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 13/17] mptcp: add sched in mptcp_sock
Date: Wed, 18 May 2022 14:10:51 +0800
Message-ID: <6dcb2e7ab064697f5bbc30eaa9969f23d3e81ba5.1652853898.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652853898.git.geliang.tang@suse.com>
References: <cover.1652853898.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:202:16::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2203653-7f6a-4107-a5ec-08da3895665f
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2584:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB258433BB9490118554A2B573F8D19@DB6PR0401MB2584.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jeuajcLO1+UJtkIp1acWCWetuxTnemkPez6ZcVo6AwmEYaQhJiWP42VY4pcWOre1QMILGa+ZCQmiWZU90GCvvmHytWnFf0IcWsV6Uv4zClIwq9MCk2pk1JeHwo5DDb85EsADR/EQShXdsGKoGVTcCDhA4wZWWF/fdy5/Z05MbZLzzVxE8C0OetDTjD6ev/A1ZQ2Gx3oPnHyxsWe0xjdMZo7EvioqqAxRvzzq3heGmzp2wlY2glTl22sMGvz4gFMWuek7li5JvaLdgqS8n9G5MxzzmShXaE6tl9rx9AstKB/r9Pz/RKBQ9UBKuKb+lWi3XHr8rHsk/8k47ASQ7hBBKAmIrJwjvNthuQIWDHio2TeY/fxE5WVV83QhtlBqaza+b+dIrFwzqpioTkjJ3MCCB4dlFbYbZX5A3xhu+33uT2tjF8tS5trLjvhy1Ps669xampbCmlrctiJX//JJCNb5edz5KxnH7pcEt2aN3774MqFKi+bRhz3RZNfh7y1G3hHZvjdwLrnPv6SAV3WOqL12XYggvnpAl3lP+C4kw0bJ6oVsdRlwloJ0SBgldF5dardxQ+iKWKPk93opBhPwSDX/8byhBcJP1H+TsAwOw/B+7OMNPHBoFOFUN0ey+YBLgiHMA19+FNBYBtU6k5VgMxldWMwv1Uw0mMX3wxEdjhYxsxh7AmtCNRqVSrreA5FHgObkRK+ZjF2ByaYFq+AYTHcKBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(66476007)(36756003)(44832011)(2906002)(8676002)(4326008)(6666004)(38100700002)(86362001)(2616005)(5660300002)(6486002)(66946007)(83380400001)(186003)(6506007)(6916009)(54906003)(6512007)(508600001)(8936002)(66556008)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5jkpLuGHtuULawe52mkr8KzM0sn3SzLSrvsqOoTkL0OyJLOQ4vvxqrn3uArz?=
 =?us-ascii?Q?ctNeoiGuy5W0YC3r/LMWkQ6PGiLgYBbNjzXaJK6Gp/Ikvi2pe6A1jz76ErCp?=
 =?us-ascii?Q?jFz4zZXq7W9JUHhLGJ8/1GQ48/2hZwb5YG17RXrkqxWQG/VdV8nCYHHffFwH?=
 =?us-ascii?Q?n0EGHm13OzEGm3yBG009dfOGflvPhg/aHkGGhsEfsSRw/dhWGpX1IUgZ/rhm?=
 =?us-ascii?Q?IkEc9C3DncauPuciz17UCrQVYzn378z+cZbtGCSjRlFCxrsG9Vy5wqOLwiw1?=
 =?us-ascii?Q?CdcTLzyNa9apYv2as7P3xnfQDnAtn6KpCEL616wYyoUqQzSKrZr+8mNcu484?=
 =?us-ascii?Q?XdK38LIS4U24ZyWlexYjkDmLHbBBK50PERO5R5/2I+dCDNMKp3lzOYx5+SyE?=
 =?us-ascii?Q?7TkwAmu4O2RUyddXLcpEHKef9F5krUoknFmpanLohl6d0nc7kWTyau70Ij36?=
 =?us-ascii?Q?n7ozQW73cYYvgTibSlMD+N2G51sn5BrFYGT4lVyjdcUh+PUrDtlc5BmImhV1?=
 =?us-ascii?Q?5whSnBHlp5Ymyjr75+hbKRUQqhBCUR5OaC5QTqBzOe8luEwCjYhMB/t3FaAO?=
 =?us-ascii?Q?GQ/yw3IhLnY6X2ZTHauPYetAII5sZHbg1kJw+b3s0iWEueGMoNLClobau6nC?=
 =?us-ascii?Q?jvq19GFjJ6MbmAy+MTvNaEi2AwU/rPfkEYAx+EkJ5Ht3J0A6BkbEkpEyGJWn?=
 =?us-ascii?Q?1Z7ll2kcrVmIe++NneOYWleIMTKuNeIBZEfx3FJAqsV7PUjPrE4xzV0RTnm6?=
 =?us-ascii?Q?+fVWeDjkcEQcpllPjistxEVoSc3t1r0eLhrJ84oyYGatMISDpE1BlMCD/5/s?=
 =?us-ascii?Q?GwKJHAMbxLYnFr+o7TEqfvKbPKTp2GHnYeKojk1VufrnfN96i6QkOiRc852y?=
 =?us-ascii?Q?09Dge+c9uGsCCKSmhLj1w+BIwtF4VYLeeY8X9P8Z/DgbG9fZS1m2agY7DHTV?=
 =?us-ascii?Q?4pFVFoHhr6+5ur4vEgRVjUrzwhrMIIa92yVAXRrvhGtJ/e6jIm6SneFG6h1P?=
 =?us-ascii?Q?PXZjYJrVuI1KR2avd/xk3nME6JhtXt7t2FLix2l9ceCPYhWGhbs91ckUQhSr?=
 =?us-ascii?Q?9DvIzQy9vBJDX2Jl8QXiFU3ptqysbcyAPJS0dkYwfV4F26tGG1dDfiTHypeK?=
 =?us-ascii?Q?y06uT9cSRLFNs76zncJ3nM7ZLAIhJz+SXiFm/O2U7Kh5kleIA/EC0OWn6tzB?=
 =?us-ascii?Q?NgR1ytN47wuT9i4xHKfu9HGHWyW6AqP56nVIV5x/yHAVEBjnBHlJZhcP6l89?=
 =?us-ascii?Q?WpqaPgtRFW8cpqLIfNPqhv8KWGBj34HG4iUBnaSESW9T/GrH84NHDBEJglGG?=
 =?us-ascii?Q?+i5DLXGhsha1mfkuk6+zkYcQNsVUE5wk7AfRogxdtqxuk7/Jb+kMHpmHLxV+?=
 =?us-ascii?Q?YzsKQHAsDKzL/a1gAXqmS+iFilEsQ3adaajJlBTzTgl82IN6LBX0t4zWcMT4?=
 =?us-ascii?Q?zCCaTnFTdjEg3+UrUDnMZrbPJGU0WcGR7vlG0YDk487DDnm3wzaUQFb4vdmX?=
 =?us-ascii?Q?jCfIzyADZ6iyrOH5beIxspsXBC43pLBi4p9IvbrnHXQckXUBcn49O7MXQaAq?=
 =?us-ascii?Q?/os+6z/PuWxaL3H6uBUgZgkjFYPyeLqHYnuRCErbRsiUepRkY2FlByZfWw0K?=
 =?us-ascii?Q?6tN1fS6lKRL7OIkZqOK+e5RWhgXAYJPCaer4tq+x94m/9ZFHzhld9UbkzuYz?=
 =?us-ascii?Q?gZ3muwZ/F8yu7WtnRrPmSpv/UeTMg/oOjKtbnNQitQOpQeYUIQx/3YxuA7lt?=
 =?us-ascii?Q?cvb9Wk5XyS+Rs9wKBwKN/XPXsRln6+4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2203653-7f6a-4107-a5ec-08da3895665f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:12:34.8298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITbbfJIb7HFLthPBOFh/AVtI0f9nhhwN2dOFRkikWNUObG/JlmnZRbq3lscFqions1Uv3+zO9A4KzSuIrqHGTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2584

This patch adds a new struct member sched in struct mptcp_sock.
And two helpers mptcp_init_sched() and mptcp_release_sched() to
init and release it.

Init it with the sysctl scheduler in mptcp_init_sock(), copy the
scheduler from the parent in mptcp_sk_clone(), and release it in
__mptcp_destroy_sock().

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c                          |  7 ++++
 net/mptcp/protocol.h                          |  4 +++
 net/mptcp/sched.c                             | 33 +++++++++++++++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  1 +
 4 files changed, 45 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 17e13396024a..b7b7fbd2cab7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2643,6 +2643,11 @@ static int mptcp_init_sock(struct sock *sk)
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
@@ -2798,6 +2803,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	mptcp_stop_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status =3D 0;
+	mptcp_release_sched(msk);
=20
 	/* clears msk->subflow, allowing the following loop to close
 	 * even the initial subflow
@@ -2971,6 +2977,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una =3D msk->write_seq;
 	msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
=20
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack =3D true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 86a5ff5d3fc8..57a92db1e85b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -296,6 +296,7 @@ struct mptcp_sock {
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
 		u32	copied; /* bytes copied in this measurement window */
@@ -531,6 +532,9 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *=
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
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index bca318d2cc78..aca4e3c6ac48 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -253,6 +253,7 @@ struct mptcp_sock {
=20
 	__u32		token;
 	struct sock	*first;
+	struct mptcp_sched_ops	*sched;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
--=20
2.34.1

