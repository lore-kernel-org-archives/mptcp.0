Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543D115A5
	for <mptcp@lists.linux.dev>; Tue,  5 Apr 2022 07:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649145201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXHnfk6jl8tltEx2mXHub9NIDIzZS9CY+kFvWCi5BCs=;
	b=S5x2uuB5KblI0SNcCwtx/dKCPJC88zgZl1uwzOEI3RCY7jAC6pBKSmhXpto7GIGEUCVEp9
	RnZmNI2ZaJp8FMe3zFpt1RRpHBHUec7Z5QsiKw0FVfJ7g+5bvJAf8j0XjAot5cB9yjWUvz
	fMgjlE6RvAVwl/7QlFqWuU9tnHSid9k=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2054.outbound.protection.outlook.com [104.47.4.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-f7ocY5IOMWOy7vvBcEnP0Q-1; Tue, 05 Apr 2022 09:53:20 +0200
X-MC-Unique: f7ocY5IOMWOy7vvBcEnP0Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CE+Jw3rh/MKplcDr4X0T4Elx+E5PzCI94W2P79cxOH96PlWG9XpS+ekwlV7JpgJvfBslZRzwQLv8qnBqDLMFNdy06xvAxBLzH06Xk6a/yjB4cRJx2PjV1wrIHZt9xymstGq+yIWV+A9puVzqx4KgzGt+HIOV46gX72ClBbvY11HYJD6u9gZkY8mJS+M3s6KHLSnXyVQ+Ioc3fYN+MCJ4wf4juYMcnPQw9bee3ELgu+0qHhtuDaPRWNcAhJkkR6S4UD16dcCoHXh2mY+CLBabUsbgN/XkYEqWYTInAVzcD+53pIcPFpR+x5NqGtyI++7XkwfiJKznG5vkACZlbrH3tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY1WrxNdyKdyBNAdwl0Kf3PherxKbSzr/pimqbWs7vM=;
 b=gZ90iXUxitL9qMIYzd0UnnC59Ot5ib2iI8gmCqtmZVO93NbOwnfko2JJpWFNEmEKTx0pn3a3atLeY2u6yu48I0ikIPa0NoUJk/yvDLIB6i2Ot5NdEMHsha6WrUZx2D94XB7HxLwUJ0U5ZNl7XqoZ1Y248kBw1lJCjzBfCic17yYt7OhDOChfvSnVuSz22+uZg+NO8Ks3UbpSMSG53OrNKGgnbHl+s0gyL3z6rF6n3HU5XTIQN9fySWfZhHOlNdwzSbjg6nFBU2B2Rsh3B6vU5K+k8FsL9OaUC59IKnPySQ2oDfRpqbYqzxpPU4k2WJPoeNbIj1k6yVx3c1iCYxZy7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4950.eurprd04.prod.outlook.com (2603:10a6:20b:2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 07:53:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 07:53:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/3] mptcp: add get_next_subflow helper
Date: Tue,  5 Apr 2022 15:53:19 +0800
Message-ID: <24b32ee79efcf62f10328b8832f60f4dabe7d18f.1649144853.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649144853.git.geliang.tang@suse.com>
References: <cover.1649144853.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0101.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17cc8f8c-7995-4dcc-d41a-08da16d959a1
X-MS-TrafficTypeDiagnostic: AM6PR04MB4950:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB495074F0557EE7928EDC7BDEF8E49@AM6PR04MB4950.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PqmyrblLhwI4p+WeB8b6RUgpTVJmPUGeAJA+FPfB6vyKYJEVH2Vrj4B0ofU/gTPXsfv7d2WXxpof4nGeKBnJ1p1Yh7Br38SyOdgwBZUHcUW30STqT20+Ao/57LGYx0z3L14AMHpqLGT+q9tMP5+vSsoq9Gfw6kYuFX5C2Oc07zV0B2Uw/xjT6iAa92VEmHvFLKItA31q1107Ce7kGtpKQgoVJ6dHMI2cK9rW4hX45jLbuebuUxPW7DwMGNVeRn8ZHQPlWr2YGVhrZPl/IoyAxvIFO8+OXg+W8UXYM6Idpdk7/wgysjA+e5H9JChbcZSkSwH4uxc2dNv9Gdu5m65xXgakOMI3sC/Rl3NGWrp56zdWCUQHwzHZqwdaVBjikP19yIEVfyQV3ycg5sRaHAByROdLjKtkM1LUZ2rLjNRE+89QwMfP10K+Ap97pGaCgVW7+HJ36cpqDEaK2c24VYN/aIxmuc7Swx1tCO4ZfpWHb7JkfcvJw/coKUrMtrHdKq7DKO9fvjm0gKdVJCPKj+MkaV6S4B3Inj6ed65IZ4lksGC4hwPHEKxbeZsv9eFa5s4edESMjakbgTBtdH92VFxyzmN9l1SpUxTtuEo5aDTKgHz7C6N4+BkgWTIMpDnOdsx+xtvJDhY2xmd8QeU3xNHf9KpaHfT7rq99tuuAMxzdS4HL4W/aPhi8L5LYBOb+AUotGbxPL0LLxrsu2W58hddlHw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(107886003)(6506007)(2616005)(4326008)(66476007)(8936002)(86362001)(66946007)(66556008)(8676002)(2906002)(5660300002)(186003)(6916009)(26005)(6486002)(44832011)(508600001)(316002)(38100700002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3IkWr6U7DcdYy4TZCnK34F1jbRmZxGi2cMR6KOpNRYqJmlZHXG7T+gqnm77d?=
 =?us-ascii?Q?LtSdNgE/4klgeqkUu1CHL4RTSeWbUAInmGVsgGYzxDi17fHHlOlo+B4tzrfs?=
 =?us-ascii?Q?YiyV04sskrlV7w+FxWvUo8SEf7Q4ttbkot3zq7GKzCIq01vqfFTTQdy8sUn1?=
 =?us-ascii?Q?C7t8pQWPpLRyKzcNDwqGsfcQlMVFnSBM8x+fZipiB5qRMWCKNVgOgrphJXcQ?=
 =?us-ascii?Q?aYAwhVqyg87Xizizr/kmQzMuRNAC+R03tkI1qZg2R5OZLZ5t9gJXi3XvDD6H?=
 =?us-ascii?Q?gl6eNIbVRBvJYIQmTQ7SCKwyyYE2XTeMUbSHPsx36Mh0T+U86hrfPtm13zcT?=
 =?us-ascii?Q?Rq8vOM8bsJJBYmDJQ3G4IZWVdp8cVWRYSlU4NoZaZ3NdNUh2uTRfvdJAB8mR?=
 =?us-ascii?Q?84fmzIUlqVcLTWK4iLGPiE97QFZ0qbKFUrZQXrvQq0hDiFMOQY3qLJGVxlsM?=
 =?us-ascii?Q?uvipO3Uzobcqe/PZR0xhhqPUeGbDbdy6PZyCnYV3Rk/cjOCZASgwc0cGSHzu?=
 =?us-ascii?Q?VM47KHa6aJOW0iUucFg153rWxXYgBMNJA4tGPihDCbAsTdK8MJ94zofFfPzJ?=
 =?us-ascii?Q?OJp2OGAzbyUPuDKMlydQn4KLQYDSE42cHfT+xguBqUbsxYcojGOfANELBL4p?=
 =?us-ascii?Q?L8soV1awUCsO6FL4fx0ovFXH7dCzdZc08biHAM8+M3AZAbMQjfpG4RfbRrle?=
 =?us-ascii?Q?uROeW3OEGP0zxb+8EAq287rQ74uBMFiSaBNxqM9uQdes73sFLwazXk8Yi3kC?=
 =?us-ascii?Q?tdV+j4xmyIm2hPi0qZfgRbuB7IVZtKt2xjSxHNHaF6I9ry2IwmIWyqJHYLml?=
 =?us-ascii?Q?KbyJLGBSY+0IC+hr/34LxFuU98s993jVSmq1V1FeyhBqZ9XcAbjgvXl6BL1j?=
 =?us-ascii?Q?5UEqYb0zZSNJ5QIFsJIwcHpImlPt391rr7Kt1iEHUXxUV3KpIeZVNW/Iw/Aq?=
 =?us-ascii?Q?11106wgTmAQiZ3MjZ96bjKntSDb/h6p5SHQfu+7Ss+zIYpZ7fJ48jjGSxoI7?=
 =?us-ascii?Q?AlIg+f1as4U8zD90eVS5UshDuFF8K8oKqB9WKd4j7t+yhJDPESZ3BShRgj/z?=
 =?us-ascii?Q?cyFSKM+a5LpVSOA4veTo53Y4uC2uO3EIqnUCPzixvIsHg2NOj+9Texcdpyoh?=
 =?us-ascii?Q?fSXQwoJSNwVtHpeYQFQwNropqnUkm+nSiRrX0/M3q8i8FIRcMHJPV5ZRsc+C?=
 =?us-ascii?Q?Q7vBoKS+452rQl+NDCr2mvPpVuXNUM63cuEBGQeL93YUgBfz+E1L+ahTH+Gh?=
 =?us-ascii?Q?G60gAlO7rLIMMVjLyHyxF+/ceq7R4pJfQw9sN5aHu8EowQMO2By1mC0+KmE/?=
 =?us-ascii?Q?Z94JWA3RKtiU0GACGUsoaKzuHdKpGiFzdWLdKGVq+4LCJoN8Cd0v7V4QTgIY?=
 =?us-ascii?Q?K18furun7RQK4fiHHFq/CTtiasesD3EC+woMPj07l9u2sgzZw8VqH0X5ioyS?=
 =?us-ascii?Q?0w1/9GzLfT/4XDaSuTRe0OPlzdfxKAgMXdUG0Ri9stzlhUcndNSU63+rcdWc?=
 =?us-ascii?Q?EkJnzMaz2/AK4B/TDx0qBQNlLJnmgQLNWsTs2SQl7Ek7n0KIcrbWkdmmCCTY?=
 =?us-ascii?Q?l35Z1tLhABEZzrm4b2qCz7DVFrADgopUKD/NjZxi57XdXmHAF7SYCPLjX8v3?=
 =?us-ascii?Q?9kOrui51jt0ogfxVaCFdFhK5RFTbMZLMvxo0/NwS48wf0ZYFnRWKLhmFsWND?=
 =?us-ascii?Q?j939jpSrnm2T8CEL2YBsYEBqJu8VxU1rE6VnuSPF7EItO40QusN1ubTgeg/9?=
 =?us-ascii?Q?ex2rMza8/xMdwxWpk3p/kAJLPY+nfZY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cc8f8c-7995-4dcc-d41a-08da16d959a1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 07:53:19.7119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjYdKyRdGlSgrAWhsohpd6IImfsN5Do5YjNs0BQNvyEL4dlcnKc8wxOiSEvyU9PLgTh24APQH4J1U0xr7pcqJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4950

This patch implements a new helper bpf_mptcp_get_next_subflow() to get the
next available subflow of msk.

Register this helper in bpf_mptcp_sched_kfunc_init() to make sure it can
be invoked from the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index a3c41c079fe4..94671d5e80d1 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -114,6 +114,22 @@ struct bpf_struct_ops bpf_mptcp_sched_ops =3D {
 	.name		=3D "mptcp_sched_ops",
 };
=20
+BTF_SET_START(bpf_mptcp_sched_kfunc_ids)
+BTF_ID(func, bpf_mptcp_get_next_subflow)
+BTF_SET_END(bpf_mptcp_sched_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set =3D {
+	.owner		=3D THIS_MODULE,
+	.check_set	=3D &bpf_mptcp_sched_kfunc_ids,
+};
+
+static int __init bpf_mptcp_sched_kfunc_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					 &bpf_mptcp_sched_kfunc_set);
+}
+late_initcall(bpf_mptcp_sched_kfunc_init);
+
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 {
 	if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_=
mptcp(sk))
@@ -122,3 +138,21 @@ struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct =
sock *sk)
 	return NULL;
 }
 EXPORT_SYMBOL(bpf_mptcp_sock_from_subflow);
+
+struct mptcp_subflow_context *bpf_mptcp_get_next_subflow(struct mptcp_sock=
 *msk)
+{
+	struct mptcp_subflow_context *subflow, *next;
+
+	next =3D list_first_entry_or_null(&msk->conn_list, typeof(*subflow), node=
);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (msk->last_snd && subflow->tcp_sock =3D=3D msk->last_snd) {
+			if (!list_is_last(&subflow->node, &msk->conn_list)) {
+				next =3D list_next_entry(subflow, node);
+				break;
+			}
+		}
+	}
+
+	return next;
+}
+EXPORT_SYMBOL(bpf_mptcp_get_next_subflow);
--=20
2.34.1

