Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C22110C
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 05:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650430974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1tJE6v0HiaEKHNl2ImePulvShcI45JuV+vq2yeTZWo=;
	b=lQYT07U5+h0gadEj0PI2DWs5iwmKCBvdgYKq7BECxZBmnA0H20DUYmNhj0xOz+KPqmVUyp
	sWu7tHXMP89y7AGI9Nt9PZzwVdkncg9agc1Vq/gncSMjMBcsv9sc6DFLVDUo6hz9dJVXDr
	aC8gHb8Okn+L5HneZfuDFk/raiiHQr4=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-UnLsa9-XOeiFfznmCG-vpw-1; Wed, 20 Apr 2022 07:02:45 +0200
X-MC-Unique: UnLsa9-XOeiFfznmCG-vpw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8y5LrzMw2rR8ugVyPyCvvxi6dwK3gcLqFglrVp7CxqyiE11smdojtu1kqkdwjj3uPagmE2Cc6LeVY7m5aQdR+MPmsoIWAhhbuk/pNx1FtpI5POif8uNGCta72PrSDZbqMQD32nGuarCYZ6hU00mzfPJaTotuLbSZApEYpd+lUxL4b2sT2XcWxk7n9umGI5LUGi+z88hqRVXGyNMuhjI0PtwLf7TDRxMMwUiKggjznQ/t6BZHBVUNKxTdFuE869pp4MvGFs/FOszcnDl1GnA4mHIzqX6tHFZq7MBaDkjJVoCBxmJ11etSNwx1GgGgwx7bDKM/6vuAMzX0qtEP8GOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRZcJ1V4bSMvIATKFWRYyI0OfgDNGoJXg8CT6qQRBsk=;
 b=fDD/QuV7OLAHrjphv+VBB04VCuStKKyWy2pcSOJF0MbxyJspPPCjFTaEEmSea/uzWuJYUI4aMuBgIZFYmfaoay7aMKIe7j47e8tHp5tvICKVKiQqgkTdgw3ar166ljLVgPzyOZGPi9kIRofgXzW9f0YHu+rLq4ufOYazoBNukkUC6OHI5JMWoqtbL8zIaItyeHJ+aMr9z0Q/zOcE5qmsVq5ip6AxmyU4ly6vircizE/VbLElk8cg/Z2FxdmGyGBDiiWcmJw0yiRgQSnyjAK1g7iOR1L1JWbr9Sq52ePTISRs0mkb0W9DQoS9oIbbVei3KgamwHsnAAS6S/S+7Yjc5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 05:02:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 05:02:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 1/3] mptcp: add bpf get_subflows helper
Date: Wed, 20 Apr 2022 13:02:53 +0800
Message-ID: <ae301086b72a06a1257b6a6c3b4d26840f212150.1650430881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650430881.git.geliang.tang@suse.com>
References: <cover.1650430881.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0178.apcprd02.prod.outlook.com
 (2603:1096:201:21::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0357349a-6aae-4105-f546-08da228b0102
X-MS-TrafficTypeDiagnostic: PAXPR04MB8638:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB86382E128753CF7A0A6FC9E2F8F59@PAXPR04MB8638.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uRYPQTwHHWc6r8fHG8aDsInGxR8sGJVCXl6kka1IEbtL4XaUoFGbLsRKCRqQ4UKE7t5wxKuhuzqRpk94OQd+aF+q3wFiYPsoxElR2oORs0ISEL0j7YRtF12jo8Ys+Yuwox6vZjHPZtb20ajNjYuhLLGcQ6tPpRytDFpEcy41eAPK13lVwpU4isRI1tQLiKJFBZkzptE1mWdb5soHfwzXM1aRQ1HGDZQzw4wbelwI0rVpkSY9e5u63jM3sXzX+XossoAbiAOGjR4kBwc4LdoeamlbtZRoGwq8qJViO/Ur8vA3ko70vDhd2fYaRibWi7IfUUOHZ2iaXJkD0ARC56FvPbczA1bolfDG1LJeShleNyx3dejLvUvK+qVWfGmh4zs/Xut76qnNsvDVPSp78Frdy85mHsrhaLZyOT5ElrCi6OsOwMvYLNTiG6FiJL235BtGnNfyWoYNaW58OQyDv0/dH7oioUzzchbN5f2xGJn4lVCSqo3rYKYHzMSkbehmu205jcWTEr6DZW3A1o/lmmy8EYKjfmDbQNLaKEU4dHJ6U6QTjkNuJvTsex8LdPR+UmtqDHAjnwP3RvLp+n/o2WXrLE8C2kXyWH+fbVAXoj1BIeUHQjBd7FDdo5CmTPzIdjD68kdFl+lmpf+npi42ijadL5rmbpv3iwXAge/pQgkhe+ySQG7nlL/7EODBlEttyvAxKw36Ctq3DZIkkIREIsQsZQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(86362001)(38100700002)(66946007)(4326008)(66476007)(66556008)(8936002)(5660300002)(2906002)(44832011)(508600001)(107886003)(2616005)(26005)(6486002)(186003)(6916009)(83380400001)(6666004)(316002)(36756003)(6512007)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x8w23oQNk9t5OgKfj7wEPVTqxaRRwt+wn/XVJxahKULca5YlsHUJyhpEeoNT?=
 =?us-ascii?Q?qOoYeSAMXBHIMobsALEjQL4mAZNkUzanIZ1jTmQ5okzB+2yRQzz2Fv7YAFg9?=
 =?us-ascii?Q?zDEDnkHIOkOek1oNo/Z1O4pnia9LPbkAz4W9aHn7fttrdICMPWBE0w/XPuMJ?=
 =?us-ascii?Q?F7ECIoPWkbC8BmPopu1Rd/ovbd76Brb7JohkmBIBq8YpVdZHFFmTdTcIge3E?=
 =?us-ascii?Q?18keBz93V2YHFsLsaPhtcSps5BM+PySY9z4KetDQJCsaoc7CFbka+LRwpTE6?=
 =?us-ascii?Q?edyYoluL2DwMNW9n9VhlG7B17G62KKf45/wHf9ZcQiwynbmPr6WCnwR65T8D?=
 =?us-ascii?Q?qX9RTxFBo9eLPS4mrVAagP7dR1SinwJeoDVNUlyexYTMt8hwLsvj6Clkd3u4?=
 =?us-ascii?Q?z6cY9Tu+sMR6JgBT0dV7bBrNDWNgJfrEZu8wdMUGOl80rYdT0cQq1XnPTOeV?=
 =?us-ascii?Q?QDz0nmdK6cu8utzaYyMU1Xy8tV5MHCRYLBBAQgfnO0NZVFRO0OAjq6UbEzk9?=
 =?us-ascii?Q?9vMu3qtA9eDz3AX/tUBDP3KAMumqc8/6GfA0KhQ/yShvS77p8lDIF68iXSlC?=
 =?us-ascii?Q?dNIT/sAZxooWMDY0kmxgyRlzcVoi3m6+JetoVudy++9E5onPpwJ1l/BC59xz?=
 =?us-ascii?Q?AI7J2Kxpy+M+Cw8gqf141NHX+d2ALtSBAGOoy0damEI51uDO4GB36Li2s75A?=
 =?us-ascii?Q?LdPMMCaZYJI8kQW/9Bt1V/rtMKmzwvh6d9yyrdZQHzWt1no6UCgS7ksH3ZB7?=
 =?us-ascii?Q?a//GmOoyY/FU9riJlLf7uSSNj8BUBZhFnHEk9zTngeZiYAUy802shy38PNvg?=
 =?us-ascii?Q?fe0pC7FW9X4n8amsv081BrW77e7lio0f9nYGYuqZzIYEIOPy102DONEHneO2?=
 =?us-ascii?Q?V0ElGR9Hlvxm/zqcbUnnnVA93eLI+77nScp0OrpC2QbHqgiuyZPo9DA+1ICs?=
 =?us-ascii?Q?8xgv39MIBnKszvF0w7OoyQmO0Enuj6ZEj/28Nr3N5Yw8nvrk9jCgYcOjRNTp?=
 =?us-ascii?Q?eaRnOdxziXMiM959QWmIrbeC8hzKZqBVufTqSWnmWXQgqnown/u2WCNBtPSz?=
 =?us-ascii?Q?ZSkCFv56guravG8rwXPOqwHDOgvpRy0qqLgx857xCgYZJbxiqFSzPQBFJfAm?=
 =?us-ascii?Q?+HZwsnHfmchcR3ncGloVxnqzm/2w5K3TeHm+zHSDBC84akKJFr1OeaMuPtQH?=
 =?us-ascii?Q?EnxT2QNe+gECBd6IAM2iOZ7RZXF2conGAC5sx6IO4LsfxY2zsBJpiGPVJsrK?=
 =?us-ascii?Q?joqSfPp04TmZoXZI1jNoeBnjvvKghJUn28XPN4pihIsHoLy18BGjiiuHeBqH?=
 =?us-ascii?Q?TQTI/BNcFsPFg3XSIjiU2pJe7O4eKMukag5ohdW2d7XwReYn7TMq2UlCb2wg?=
 =?us-ascii?Q?DaEbJYcwVw/7TphGVeCVQSfshaTQPPaUXqBMGaud7AkI3wYNz+Fi3er75rRI?=
 =?us-ascii?Q?PwHbkHgDNVTLr8GXTnukvdAAmWQ9OQAwFW1g1mfqGJSEiLZNB6H9UQPBW/Kp?=
 =?us-ascii?Q?2hj9vMiYnJD0YaiAOeMyLcEVcc2L8DL8jU2IM1KobkFwhu1KRbv/4THg2FFR?=
 =?us-ascii?Q?rPU8/jhdoaFuLjS2wkZz+IW1ci4pOHY/8ediu6vZWU4Gb52V0VAu0ckx6KXT?=
 =?us-ascii?Q?hQ26q4niHGeSSOlCu0xBlRXkdMP6gcsI44SF8o6/u25SZa7fpFJlfw2BSeWD?=
 =?us-ascii?Q?k9aEdKSwtteZ50mIqVj3IYZCLjccnHyI2qbdpF2zLnvzDsSwKeJ6s2NYmm4X?=
 =?us-ascii?Q?xSuXXD/BNVC7RCWSWe06FCTJ9vlwup4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0357349a-6aae-4105-f546-08da228b0102
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 05:02:44.2865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6F6LHmTRToD9D83H3NuLxiFQL6qYFQuItSs2NI0rJS3Y7ePSI4o1tNis0MPAAZPVAGKg9lm//pI0ZcXNVdQpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8638

This patch implements a new helper bpf_mptcp_get_subflows() to get all the
subflows of the given mptcp_sock, it returns the number of suflows. Add
a new member subflows in struct mptcp_sock as a pointers array of all the
subflows.

Register this helper in bpf_mptcp_sched_kfunc_init() to make sure it can
be accessed from the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 44 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  7 +++++++
 2 files changed, 51 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index e203653860fa..113a2efb183f 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -160,6 +160,23 @@ struct bpf_struct_ops bpf_mptcp_sched_ops =3D {
 	.name		=3D "mptcp_sched_ops",
 };
=20
+BTF_SET_START(bpf_mptcp_sched_kfunc_ids)
+BTF_ID(func, bpf_mptcp_get_subflows_array)
+BTF_ID(func, bpf_mptcp_put_subflows_array)
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
@@ -168,3 +185,30 @@ struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct =
sock *sk)
 	return NULL;
 }
 EXPORT_SYMBOL(bpf_mptcp_sock_from_subflow);
+
+struct mptcp_subflows_array *bpf_mptcp_get_subflows_array(struct mptcp_soc=
k *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_subflows_array *array;
+
+	array =3D kzalloc(sizeof(*array), GFP_KERNEL);
+	if (!array)
+		return array;
+
+	mptcp_for_each_subflow(msk, subflow)
+		array->subflows[array->nr++] =3D subflow;
+
+	return array;
+}
+EXPORT_SYMBOL(bpf_mptcp_get_subflows_array);
+
+void bpf_mptcp_put_subflows_array(struct mptcp_subflows_array *array)
+{
+	int i;
+
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++)
+		array->subflows[i] =3D NULL;
+	array->nr =3D 0;
+	kfree(array);
+}
+EXPORT_SYMBOL(bpf_mptcp_put_subflows_array);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 58b980660d20..cf4cf69dde32 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -501,6 +501,13 @@ struct mptcp_subflow_context {
 	struct	rcu_head rcu;
 };
=20
+#define MPTCP_SUBFLOWS_MAX	8
+
+struct mptcp_subflows_array {
+	u8 nr;
+	struct mptcp_subflow_context *subflows[MPTCP_SUBFLOWS_MAX];
+};
+
 static inline struct mptcp_subflow_context *
 mptcp_subflow_ctx(const struct sock *sk)
 {
--=20
2.34.1

