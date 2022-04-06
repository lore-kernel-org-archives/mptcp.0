Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB96033D7
	for <mptcp@lists.linux.dev>; Wed,  6 Apr 2022 13:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649251590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zfw3I+EnZv96Md5OTD+XGEtjZ10dn0d5wybs6YfoSqY=;
	b=MjNlXLbXZMSZ/EFy1PYfPgXpt/0gtyouZD/uXJTMnQ5k4SP8k+PysbPSlocM/6Px7cGYtN
	cVQfbcoBC0jEvj+T/NtnKkOIRdAszbirURV/yyceQJ/su0AOffq1Z/wdkinSXkuY7R5N/b
	9/9JMCr1GBGlcrun3PINdu1stj8pqEI=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2058.outbound.protection.outlook.com [104.47.13.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-xsrl6VNTP0WqzmRlhXAwBg-1; Wed, 06 Apr 2022 15:26:28 +0200
X-MC-Unique: xsrl6VNTP0WqzmRlhXAwBg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiiVVFtMRdYu36X9l/G/AEQ2zZdnULpwATlPXtVgU5F4L+MROQXzQj5hxAI39YWNeP1qwT6ogDAtB499pSNPN4eyoM8xCRilZ//08j7aAQ3MGOIFFQZshaJL9fNddk+AzRqs0YVYLOEv2+IW3mPHF1UYoVv4FGRh4DmhezW2MkbJczFrAV6acd1urWk9lKyoyL5kNuG1ney3EySQ2SzROArTmbSnFg2wbTNmHksZtZ0dtqPKxVZwqejGAz9J1XjXAOjq+NDpTPp1NUSk1VWwJn/SIt9Cuv3uJAOvbiefcW30+Lq9yUSsJRZonCzxhnBEH9Lmfm9aoMS3kdIisHv1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKEXh8cKLkNZqRYM2ojXASM4t9/Rot/LXOULKvK39Vk=;
 b=OFNtlflizdttLXx7V0VlTKSBJSSNRnk8ZsDclnJ+gsft3hwKG4Bgn5OFoQ4PK1w0RA58ZDZ2kotOw27w1bUDerF6IsKYV7cs4JnJTzHOurTeb1J9psVJpv13fXIMs0FvjnumFRGqNYd49xpCHlGdwBT8Qi3IMWTxMW2xnk9z1j6Xu016Ov9gvpuy8GCbde15klrqB1FNIF+EOurJ/do0ZWiWO1irzZo9Zs5tRL2aZmjhYdpZ4OzjEETAw8KAi2j06HpYo+5E2GsUpYnsgNj99gp7RXOYhPETklj6mJkvLhUxVJFqYZ584QTLpmErt+sC30YlIlwcFnFhplToenHHpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB4187.eurprd04.prod.outlook.com (2603:10a6:5:26::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 13:26:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 13:26:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/3] mptcp: add get_subflows helper
Date: Wed,  6 Apr 2022 21:26:19 +0800
Message-ID: <36a954b187c30d34459b3bb7b883e3efac3f1aa0.1649251279.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649251279.git.geliang.tang@suse.com>
References: <cover.1649251279.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7749516-64cd-48eb-0d51-08da17d10d1d
X-MS-TrafficTypeDiagnostic: DB7PR04MB4187:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB41879C9A541497F2F288B578F8E79@DB7PR04MB4187.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ue+cQezhHz9HECq9e4BVluA6RKNprxFA6C1yUhCY3JufzclBaCSQQUK8kY7xFNgcxYxC/WEBmW75c+ELcRBgABTzNDaVOjiB4AM9iQjZRF++Sno6Nh/GgTBQf+/eiJ6DiHwYghdmT+HVDSA+gE1ps/+5uZiz7CGrgOWfFNFvdiMPuD98fqA9Sps1QtWoDx2yAoWwI9xUvHE3mkTT9YrZzE/GmrAB/9IF4MbMI0F07eEIqRF4MN9HllECZCIxSf+UCgU7wOlHIY9gWVMhUa+bgQ22MSFcJI64sYf71UU5EGCWqq9GRjcnInvkotmCT+XI2JUwHQwDenr2ldiV7o5gSEYZc3HSbtVAqHbJED0oRSihq+EMG4DmCkIBz7cZtCuNJaJzMaR4nChEaUuikV2vmYhBQEttlBmtOAWdEmUCf6JTbvVYVFn8RTMD8lBWW8k1WSUsqnfvpPb/S03H0saX4LwFQl1VZljq/f9HMuChpyZPoiToKRePt8SrqMCcyo1inenQwjajBLmMYopwkcqsM+gR3Pj7CGTYkaCs5DFxnYRaWb8j8n1lBNT37l/Ow7Y5t49vF9sLLaKfFDfmy4f1aEa6YJzywPPbJb0XuYx5AUrCehIjUIeW898oG7sSPkgdtBFseW+1fsogIOSF2pMecuBJEh0bL7WIUcmpJ2FYnUMSJ+6cKiWVgKJjRkUuU6b0gkoUiwfIGsbldgJ0E3sYGg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(508600001)(6666004)(66946007)(4326008)(2616005)(83380400001)(66476007)(66556008)(6916009)(316002)(86362001)(6486002)(6506007)(8676002)(107886003)(38100700002)(26005)(186003)(44832011)(2906002)(36756003)(5660300002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K2fGmBqzcIMRb7MFqvEDHGz/H9hR0sxlGD9KjX957UVStWLZARolOGrhGkDb?=
 =?us-ascii?Q?gihoSGN65ybNtV+mjiSlJB5UhlQSnhp8vT8IOYn7v8OWCV+7LIBDfP1gSOWe?=
 =?us-ascii?Q?TUhY4PPLFguR+BE9kgUsESkWaQOvZnXQrt65yHC+cqYKcaX6rX6RO6r3AUYO?=
 =?us-ascii?Q?rW0K0YMQ5nzgiLK9TU7hN9YwfDDQ3hhsUqu6BdIV3CxoJaT0AlOpKDNjwNNP?=
 =?us-ascii?Q?xZIjgDoyHd3bd35veDsB8F6yTwZGBjE0jJGxOwk4kUDtls/iSjiuQh7i+5+H?=
 =?us-ascii?Q?F1y61czcecByIm353JsU1VAImf5R57JO8z/E2JDXijJ21VxC/P07J9TIzmXH?=
 =?us-ascii?Q?9D9IFzSwGbthA6nmAXV5jYGrxpJDMey+xY5STE0FM3VvSCh6zICsG3KieN32?=
 =?us-ascii?Q?GuUFcZPIW3rFDvH+nPHIevIOZa4jv3LoPO3OTZmdP8lwEbZywfieJ30CkBiN?=
 =?us-ascii?Q?k0A4v8gQdrkKI6QKTFav2CLfRpvYk7g65Ntgr8jkGuoQei0FGUZCCBiGQNe8?=
 =?us-ascii?Q?/HpiqpNN2lPQMSMka0s6fqyrS9ggN1pAOSrLdz74ttFErkin3lEiaaaNM5l4?=
 =?us-ascii?Q?11Fjo/qjKN0XdYlfbFwNHwK8BNqr/Wdre4yN46j6OgDn5IkB02YhG5AfPIT8?=
 =?us-ascii?Q?v1TsM1oYyRaB6NJ49sCzpcm8VGXloBkvO2GxV2RgJP4Kkv8yvJuv/ZzOpZIa?=
 =?us-ascii?Q?GPSzegFPBiwf5vn75vS/4ixRwgk7u9kh6Mj0DwSCjvNIbvFuVI2GLL4wPRNW?=
 =?us-ascii?Q?+gc3iytB58B8LgHpgHbusoX0HYxfep7pP+/vgSVKpKo8M5x/GNcLZV3+IdjW?=
 =?us-ascii?Q?Hk+T9K3JGVRxoDk8jHpZvV8TTxaX8zP/6eHWidbRt6glHxmsIB4tKRq6IZVI?=
 =?us-ascii?Q?ANQ8qq++Q4GrHoyMl4PD/YaHBsovBzFHKpwOq/gvFxOjc9LXfcF6CATs28pu?=
 =?us-ascii?Q?uWuXi8eL3UlWHWy9KlxWqDRDGWUFJcrOE3Whf4tCazGqeT2Kk3lpVdbxda76?=
 =?us-ascii?Q?lTepnOmwCMrPDeiWuiRQD9UkpGWVl51P1HkIuYuXUapfxGevcrIbYMq79F1E?=
 =?us-ascii?Q?WTXhG4/MWVruxRaQbgOXdDggWc9f5ap6lsYpm1dA4CC6We27ivhkDCySCkSB?=
 =?us-ascii?Q?T2YUAuOHbyNOMxyv6Z+lNIdbNDFlWJ+aH6t2xmB5xH4e+Q22sEMP48blNJJW?=
 =?us-ascii?Q?Yv99Ubdmp/ulo1UVooRcB4HpF8CwuBmwT8F+d71c4vN9weX4fJEclCX29CPU?=
 =?us-ascii?Q?ynueGFJbW/e9LuCzsnvX1+juUkS4EfYjjyAvFmuTLAKHloQ9jxauWyBF4bts?=
 =?us-ascii?Q?5Y/VdghMHabGl4XrDf0zkU/cfZl3mmXSyKd7nw62LEeFj/XuxMOzVGW9bK43?=
 =?us-ascii?Q?c7zIgn41IcJKmMnTj/l+/aN8q3tbgUJKKC6FavT+/0x5lpRvTVUa0KPheOH1?=
 =?us-ascii?Q?e8/dCt0J3ieQCJC5S6+CIJ0/biDsxeKkgrfpIqgc+rgPnOP75VISEWJxV9Ka?=
 =?us-ascii?Q?qBQIPpwUVtLKzOohIrZSL+0/L7SrOuwpmcyyaUoPDgqAM1055jMza3q6fi1/?=
 =?us-ascii?Q?4ANuWcHH+ACPzt0R3MDKhA/fBXwvxApq90r/sYFcs0c1fAfmKA5zj+jcCpdC?=
 =?us-ascii?Q?gF19Ua2KivmnYGrjOmwUqTYGUigFpe3chjBPrVMcU3qNggnyi0EyOMOovV9h?=
 =?us-ascii?Q?MI56Aq6DWbs3mEdQAlJso5yFpjn7zAB/T7OMzZVhoXsTkZVpvZe1fODksthe?=
 =?us-ascii?Q?7kML/EHluz3Ap+fGL/3AndQKi1IMOk4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7749516-64cd-48eb-0d51-08da17d10d1d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 13:26:26.4614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggKATD9m3qu8v+02myCId7KQUaaKGfXOqeRsh+djMEUIkODgZrwObwHoqdal+gHbmsxAhR7S5hTaa+J6WEOw3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4187

This patch implements a new helper bpf_mptcp_get_subflows() to get all the
subflows of msk.

Register this helper in bpf_mptcp_sched_kfunc_init() to make sure it can
be invoked from the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 28 ++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index a3c41c079fe4..660579f1589a 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -114,6 +114,22 @@ struct bpf_struct_ops bpf_mptcp_sched_ops =3D {
 	.name		=3D "mptcp_sched_ops",
 };
=20
+BTF_SET_START(bpf_mptcp_sched_kfunc_ids)
+BTF_ID(func, bpf_mptcp_get_subflows)
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
@@ -122,3 +138,15 @@ struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct =
sock *sk)
 	return NULL;
 }
 EXPORT_SYMBOL(bpf_mptcp_sock_from_subflow);
+
+u8 bpf_mptcp_get_subflows(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	u8 nr =3D 0;
+
+	mptcp_for_each_subflow(msk, subflow)
+		msk->subflows[nr++] =3D subflow;
+
+	return nr;
+}
+EXPORT_SYMBOL(bpf_mptcp_get_subflows);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3caa1a08b7e8..1990ae5c1397 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -238,6 +238,8 @@ struct mptcp_data_frag {
 	struct page *page;
 };
=20
+#define MPTCP_SUBFLOWS_MAX	8
+
 /* MPTCP connection sock */
 struct mptcp_sock {
 	/* inet_connection_sock must be the first member */
@@ -298,6 +300,7 @@ struct mptcp_sock {
=20
 	u32 setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
+	struct mptcp_subflow_context *subflows[MPTCP_SUBFLOWS_MAX];
 };
=20
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
--=20
2.34.1

