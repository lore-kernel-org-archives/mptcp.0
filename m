Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0077B
	for <mptcp@lists.linux.dev>; Thu, 28 Apr 2022 05:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651123450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0hsbGgT8rkplV/zoZyrj5uV7DMkRXDlcBuTiXXD+Y8=;
	b=FpuqXNS8bQN/FBXs87dP1awh5LUeHvn80uNo7ukWVtZFwPW/XvYg/R4AR9ZE8sCpJIst5S
	yHUgmMNHfhRIprOwmHSyXTinGQwOje4f8QUngfJWnptD1LA7kqrUmRD94fbGObMW6HvUCW
	DZCtyrmKeycMgrBcQheOVNqvISXt5Bo=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-yl_nhbbMPBebmK9U7RlnzQ-1; Thu, 28 Apr 2022 07:24:09 +0200
X-MC-Unique: yl_nhbbMPBebmK9U7RlnzQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftlfjrljlBGkOZzAX0E0X7uaoyWeGih+M4Xu+cdMgDwnXhnxsGO7GzR/MvHq1fHk/e3U4iPjlwOskxc5pKKSfu2CMBDgU4N3H5X5npqwegPOEop4xt9f8rv1Sf1N86G+9xn+zHKd5C8XiK9mqexp0nPoIBafBYHkhRVgXA+486zfRkhhPTz/XbtckLBquIdS1iHYFrM+478OtY8el7ULqrwSHWKc7yGTsvXlLw7MGBL2neHnbl4yqyRFruMnY1A2rqIfKqNUei36RRWtY9L+eK4T/rGjAEUn1LhI0Zs6tf5jatYxaNcaZK/Ar4pPEkWyaZNPTKnYrQ6GelmDeaY7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0HdrBSaF8k3CJ9iUhGS4gwCNDjkhfE9Kgoo4PloB/I=;
 b=iFEdDd5EWC6ZPFiLvKVuvOsAZwecS4cRnXNUGJNnT7TOQPaVM60x9VzQoI/F7mqhEouVbjd66O0TUlo5eFX14r0LNgbffqpOHr+ReUzGoN9rwMh6UQB930VvVR2wHp42QiiPYfvhVT88N+Ruq6ot2h5aetGKNw1fx7HgI9qSYv9u54ZrqdEmBwneWKaYAsCHrjAqsLQG17dn0ABr+o4uPBe8Qk3qFVBLcNvU6tDy5Tm3URNqqVYUX146sdTH2W9Gl552UZP0DyXGUgb/CapgD03OmNeo/7lxhPUs+iu9H6WQc5aUOcYbbPqFfJLrSxbgbc/ykhCIDY6zXH3pyKeQdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2885.eurprd04.prod.outlook.com (2603:10a6:4:a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Thu, 28 Apr
 2022 05:24:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 05:24:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 6/8] mptcp: add last_snd write access
Date: Thu, 28 Apr 2022 13:23:33 +0800
Message-ID: <60a9490aa49e64c1db357ad2096d321d7c54713a.1651123078.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651123078.git.geliang.tang@suse.com>
References: <cover.1651123078.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aeaaac07-b81a-48c5-b90b-08da28d74f85
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2885:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB2885BB69BB00EB6FCB3662F0F8FD9@DB6PR0402MB2885.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o9KEWS9MV22ljljNCeO9o8MPIDrwsmxOPfvsg3aLsr5Xn9E1uM8eKXEigcHelUg8UMOviUh9jiSCGtETCwsDkxNTTnZBZTOwFMTrpkYStVU/tEud/52UwQyUHSB7UyljoWGXTglRgSpaZCFpRmVIaq3Cap2Byexn9k72rswwZPr03zH57HB4l9JpirsESm6TYE7cuhS6UT9qmfYlWVwofPmSb4C1czxCeTNIWxgdAx69pXvJemtIp7V1Twr9t9eQeXSCacQPtc9KkNhalcfpoWCd+LcAS4BGuteqVRVF8jEwjhDachG/N+jfLXAxCdlbfLtH/f80zw2CEFkQ995sW5ydXDi4Mplx3wKkkPlpU5m79ibEJtaIq5Fbc7rMPT5LjVOX65xNuP5R2mDRNviBxhV/ewEj9plSF4t7ILsPhpf6rqhk6H7vjO6aGVIcgNLdNt+mWTbd+/X5CMNXu20PWFxh9Do9awmbKpuADelvGz3pXtzZdmumbBvth2pgW8KqRBzCXo7M8b1Bv3aG8Cm1thsDLwNmSG4mxnd0hvLoCuuqvCVWWAmmWAP0Cg9E3GgFt4sVtm9ZJLa4gTNzW4t6RwQR5zHk+2dE/1ASE89NOJ5S0pkGflugd0oxH/cD37u8vLUb30Uk/PkzGPO8fUGSSpugHOOodFERdK2pZPNANmx5j5BKbTmc2pE/GRL54GgU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38100700002)(6512007)(5660300002)(36756003)(2616005)(8936002)(6666004)(6506007)(66556008)(186003)(26005)(6486002)(44832011)(66476007)(8676002)(4326008)(508600001)(6916009)(83380400001)(86362001)(2906002)(66946007)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oEnCl/ZCB69QYB+5lkg1DjGq5Ad9WroWuPlUfnzdsocmBjfPRgfXZJ+gSkyD?=
 =?us-ascii?Q?G3lCGNQZrL4zh4EcvJy702Ehb1OXA11exJtbgIDzqNYySG0vttbmJB0TmRyE?=
 =?us-ascii?Q?mzCYSEhHI63g+0epd4NknAr2wV2SE5eY9XLCw7ItdEySMsnlZkyhIHEMzB2X?=
 =?us-ascii?Q?O11dpNH3W+ltab+CM5Ls+Z/Vs9qLFzlFXktrCkAcCXLYonpNU5HCE/a4z54c?=
 =?us-ascii?Q?fpu/WNDqSAn65z8N2UBFBEEFGTwIj5lD+Yo5hkDt43B+mWG7fpnWsk0a1SiG?=
 =?us-ascii?Q?E7TOZUgmX/cYZBdOd3TTikXwYVE6KGbNeBcWCLM4fVOUyn6/9VjkYLx9df/y?=
 =?us-ascii?Q?y2nqIw00X7aXmSCLYFd4+Qf6bGCdl25XgHfJW7G2tsf+hbznApo+73WaoqG1?=
 =?us-ascii?Q?fvMGOqBn+AGSZ+6kLeE5pJwG/h5d+kR670O7VY5ghEhdzhiQD0g1/rbg3Txq?=
 =?us-ascii?Q?+tm8Y60MO87qdk0Ssi1qR8BrKN6KrR4BX0dZs+67PTXU8ljUPudxnV8nfNz+?=
 =?us-ascii?Q?9kPlf3v9NMjqgyOXAhj6q1Mc6twIpsn4ZIO0pmD4gX1HlYyfkpIz8p0oxrHs?=
 =?us-ascii?Q?Ga78vL0xEvR4DvJfx55zTP8oT+wsxEVIIx5zdxYRNhd9VptfKaTvGpiO54U1?=
 =?us-ascii?Q?r07/QVUpxKTCBTA375EcYoBl37iRZ6AxvQ+GzHnI9cCS5W6mNt9C69KHYQHb?=
 =?us-ascii?Q?bwa0e5mpWzZ8683dgg0AG4g9Qk1fn6Qq3bKIzW1wHJiRGW9jdRpSdftDb+LV?=
 =?us-ascii?Q?xZputEL+vASVOvORKeQ+y3IQd9Zk3b5KmAWG9XbSVVnN7ZDpVWja/c7F/Sq2?=
 =?us-ascii?Q?0JTgSsq1Dc/Tx96+rkU5JT8eskxCvJvkEKLyqEAFeW3FhaYxJsuNTUDouEpn?=
 =?us-ascii?Q?EI0kxQulyFRlKcFTlZS5MqUMOQ+Ijfoq7zgZ197Pmxr3ZpjkVWYXxsJoNKp7?=
 =?us-ascii?Q?LRgOTGp/q4c/bFBRTkMBFAw07O6zhF6Glf31PMOmt6cmg2GxiKR+caFyd93K?=
 =?us-ascii?Q?rrVySH5qfRAIP7YrB70Gbo7d7rlLVyO3JV/inu9ku1Atx8sdGGxlB6a/CZoi?=
 =?us-ascii?Q?85Z7+SUvLshsP9FIWYH1dRp6osQDuYmH5serZz1wKCVFloS1xiWaIBS/eDsz?=
 =?us-ascii?Q?8huwzXtwklk9nhToipm5/sO2LiqRi6cPYd7Wo8ueI1DRCH90Ns6GRwEmXnEh?=
 =?us-ascii?Q?oUyr/5UScepHgCu8Y2VMuGU2edQU5n7abNASzusFWSZVVuZMmpjwnQW/kuoN?=
 =?us-ascii?Q?y8DNDfGtYitlsttxQA7G8jN9oGcOGl83TnzFQGt6OCRhUPu1AlOewnPPztyK?=
 =?us-ascii?Q?EWcB88o6txjz4Hll6XDrZGVrJm/mqxwl8oJDs9K0HBnzzmuSUyEGoDiSypJx?=
 =?us-ascii?Q?MhBeqLmW5ncSV49v+/3QaC3ajTsqFmbL/zCaJueunAfjyZIJMFKu4w0Nr1dR?=
 =?us-ascii?Q?Z25/52uNZf5RCEFDqLYmBC+Rj4QkYi9dlVuyvXx+W9G6DGZ4ZjPWNWoKSkD6?=
 =?us-ascii?Q?oCtJ6vfAcUfNZXItbDbzMACuVxaIsnXDwluIs1HAZ/tlpkS7D7GDR0iQYXY+?=
 =?us-ascii?Q?PMJSqKj9YCR1/VwnL5rHqomsVxPVZL2Y/x2Ph7J5F01RXqIMETw61G+TtBMf?=
 =?us-ascii?Q?dzFLdocw9GvnJOkLkNrXLmfcIT8SWDLxY2C/eM4JfuL3H7ttqgjQcWE8JsCQ?=
 =?us-ascii?Q?HI8+Iyon+7+ciMqaXQD2mgnGgiqjj5IBb3iudAlBnVb6rni7hzsMxSRCUTnM?=
 =?us-ascii?Q?6NUzgxhqP/cGr69hvnMMoGhGklOVxLc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeaaac07-b81a-48c5-b90b-08da28d74f85
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 05:24:04.6402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTByOactkfNEvZhO2GjSkSlc6IUYbcsTPy8EMXkeVdZnG7kOrnggLTnTqCth2DrfiArclFvbUom2j5j4F1EAXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2885

This patch exports the member last_snd of struct mptcp_sock in
bpf_mptcp_helpers.h, and adds BPF write access to it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c                                 | 15 ++++++++++++---
 tools/testing/selftests/bpf/bpf_mptcp_helpers.h |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index a085c72fe695..300493f9a2b6 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -18,8 +18,8 @@
 #ifdef CONFIG_BPF_JIT
 extern struct bpf_struct_ops bpf_mptcp_sched_ops;
 extern struct btf *btf_vmlinux;
-static const struct btf_type *mptcp_sched_type __read_mostly;
-static u32 mptcp_sched_id;
+static const struct btf_type *mptcp_sock_type, *mptcp_sched_type __read_mo=
stly;
+static u32 mptcp_sock_id, mptcp_sched_id;
=20
 static u32 optional_ops[] =3D {
 	offsetof(struct mptcp_sched_ops, init),
@@ -47,12 +47,15 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf=
_verifier_log *log,
 		return btf_struct_access(log, btf, t, off, size, atype,
 					 next_btf_id, flag);
=20
-	if (t !=3D mptcp_sched_type) {
+	if (t !=3D mptcp_sock_type && t !=3D mptcp_sched_type) {
 		bpf_log(log, "only access to mptcp_sched is supported\n");
 		return -EACCES;
 	}
=20
 	switch (off) {
+	case offsetof(struct mptcp_sock, last_snd):
+		end =3D offsetofend(struct mptcp_sock, last_snd);
+		break;
 	case offsetof(struct mptcp_sched_data, sock):
 		end =3D offsetofend(struct mptcp_sched_data, sock);
 		break;
@@ -145,6 +148,12 @@ static int bpf_mptcp_sched_init(struct btf *btf)
 {
 	s32 type_id;
=20
+	type_id =3D btf_find_by_name_kind(btf, "mptcp_sock", BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	mptcp_sock_id =3D type_id;
+	mptcp_sock_type =3D btf_type_by_id(btf, mptcp_sock_id);
+
 	type_id =3D btf_find_by_name_kind(btf, "mptcp_sched_data",
 					BTF_KIND_STRUCT);
 	if (type_id < 0)
diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index a0b83fbe8133..79a16636400b 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -27,6 +27,7 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
+	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	struct mptcp_sched_ops *sched;
--=20
2.34.1

