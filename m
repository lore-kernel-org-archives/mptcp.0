Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3592E256F
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 14:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654092539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mM3+XND7/C7tWp8dWVpcgU/hF1flnJ3n9SUIKtqoJ2A=;
	b=KqoSvXWg6y/f58FOg7f7979NxrJmCuSX84qhJ6q31D6x11UzuPvjU4uFBQuZNwGG7+W2nm
	x4L5PSn6YU3rJ9Xd3Hu9Hx6nKdmCaBY5vCKwKO4tUK7dL/s4B7P7SIcCQIAJtSHKUxpBra
	a9zAycb2TqMksXcgSah0fdGuv1Ymt2o=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-vkSTkHPwNB6sXfJxJKUX_w-1; Wed, 01 Jun 2022 16:08:58 +0200
X-MC-Unique: vkSTkHPwNB6sXfJxJKUX_w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJBR8Z2MynsIqeM4QbRP7Ep7LdXbjjN/dtRCFvRiAONwNzbgLbp98PBZuLEm7XIHWHthjDtyzmjtvZhdMVyhqloMcT+ZunD+zbm4ADBGoCitdFDtOhdU44GMUKWWf1Uon+lEpOOhPbEjuisalVzQIlpjG+4rvDCvX5ln2/p9c1160tdCEeTx1xkrnd7gyuxi3UyxjTiDU5fQcVHF4efCyjizdNY8Oym63+z+Sm9KcOrFw01N9CPJwmBLODtb99rxVvMjIs4bKyvEXEasvVN1jfeLq6FwSmdnu6FIqrboL/bxvxANxolIO744YY6baobWAOblnNCIh+VQqIXQ81/8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnB6QZnX3QjWi4Q6M3PhES5A94xjRZKIWP1wm4KUspo=;
 b=WDEjF4BEGKk7yL3O4qqnxOI/XC3uPM41N7Db9URbbno2aFUz63RrphEdNMUpvvtd3fqnoUR/IiEjcMfo6OBDnZXOalBhdKGE3N5B01jXY3g/DgpcgotdpTuotjSpgC2P43rsPn6LXHZYe1/yYFVtmujb0tpaHD9hi6fkagW4cvz6wapNuzEKCLT6P4o31lk5IoZU79vYF5OKyMajsBTWD/wN9gLdEpbd3NzUuZ09/UIOkFrn4PuSQdFkD+NgLTEDJzIT1DyTajUTgLmCz8ZtFaDd5b975ldja6rLAHWx4YJB7QBbkc31ARL3wWDtzgEGrCqyzjimwgKkpG2FHCEvVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4805.eurprd04.prod.outlook.com (2603:10a6:20b:d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 14:08:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 14:08:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 04/11] Squash to "mptcp: add bpf_mptcp_sched_ops"
Date: Wed,  1 Jun 2022 22:08:17 +0800
Message-ID: <882ee128ea5b02074258c6c6a3e9b2842db956d0.1654092153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654092153.git.geliang.tang@suse.com>
References: <cover.1654092153.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0043.apcprd03.prod.outlook.com
 (2603:1096:202:17::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc36db5e-5b2a-48c2-ac37-08da43d84496
X-MS-TrafficTypeDiagnostic: AM6PR04MB4805:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB48051E59410E655173C36E27F8DF9@AM6PR04MB4805.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x45TM4nBt8MIzat78j4cZLigjQhSsiuLBIHUTVf+RyaX0eyTBjC4tykP7a9TUUwme/vjwdpTLbFaUuAI3hmItUUZEN1FVFXYg8OtEadWjti1ZU+XCm6ule54+/DztoLOmzAXGnE1RC0rKLKceR5w1hpNOr64il8Ubdq2Nwhr3YPFPvH1Qf8gJEFYo8RlPdDMbmvyWIwCUCfZTmQTURO/tm2WrGPSNhLhlqSGqrl9xThpA2jyL3E8MuYMpkh4nLNxjCQ/ahIhG6c1VUz2Xb4NQjKOlkXHlQDA+KaI4/FP6kpV7oyjFdF3ESuyLHwHRZ1tolsbKfEYakc/DwfNW3L3Vxw5qBgxKLOotLAkIOgk3IlY+E5FtGtOqqtRjsspg6xu2VgDp05J/h0IA/YeOyucBEd40r2hFon3SYKs+KxfXBTP7/s9ddgDc3rOU1FaZYLIHGijWqfxW4swgr50709rBo7XUVgIOiVgKb1sLIcVTmg1vtVTIDkGCxk0VFD+unn68JoMudsc6yXONZWn6ajtYeV0Zfw++nnk1K3zZ/ENKyBftkGgLVkBXK2GzUBBq2Qt+Ls+08Fq35qSTZUjSNeZMpSMscN/qmvhx23RLPSLjdjQRriV8LUx5qAQPKHdpwoi8wHfZganl4dt0QQXBtFaabOy/oshywKGp+BRNQv17h3AQ0PpvpcPhGw5MGLjPz3X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(26005)(6506007)(86362001)(2906002)(66556008)(36756003)(4326008)(38100700002)(8676002)(66946007)(66476007)(316002)(6916009)(6666004)(44832011)(83380400001)(6512007)(186003)(107886003)(5660300002)(8936002)(508600001)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QBfZG4L7V62P4SqQCCCLuPvn+nlxN050zi9nO9Wl+ZPMCngRciXiMOMOG25t?=
 =?us-ascii?Q?dyXh+PAnhXmpXG7LtZON6B5ERr6U/A4vd/sy1DUFtVLtvpAxPFdRt+X9YBle?=
 =?us-ascii?Q?tHTdfvZU69U689OREL33sRumbWz4FAjuoAzuZI5RUIfDBnkuLiViAosKvpYH?=
 =?us-ascii?Q?TZIgf0/H5kKoxfWI0nyTgGSoIc0WdC+uLqEr535+CVtW5SNrO61wFVLeppOn?=
 =?us-ascii?Q?08i7A3qqAtkMqZDDdOb/VQoL85mbb0HpRXWBBEm+Zw4vJmcRmkejYNKwkDVe?=
 =?us-ascii?Q?Mev0Z/cG6xbAL+2vpgv/4ScH/tTJkWHZMvmDwvM4hWvSqMHZp8bU2uoZG2rH?=
 =?us-ascii?Q?Iq6VFDEuz5YsKNz5c13J8pvEezGm7JXZHNW1C6QalHgkkVYMNR+RyapA0P68?=
 =?us-ascii?Q?pkt/b65HFTSQniQs7GFx+BxCyyFg7gzgsxkmIEws6O8A4Nlw+G3DkhIC769f?=
 =?us-ascii?Q?U1DjjM/rp4GuhkJbLkvRRuJTbsgPwM//5LcBmj5VrsbkDdiZ7tqm6AOqL/5l?=
 =?us-ascii?Q?ECYrhkrBJnRE+FToYmhUS3m74dV3+lY5jndqCIirIE97iSE1MPWlF/+w++ZZ?=
 =?us-ascii?Q?bUA1afg8lQGnjIQpuoNjvi9OrEKjr7lRvnhB4/OI9vboNuOhY6lwvGKY6MER?=
 =?us-ascii?Q?fuY0vYHKPgE0md5RdTLDHQpvhRet/XYDuQvVnyxdb2oZ990T3zME4Z5hReu+?=
 =?us-ascii?Q?+rdHr2lT8znUJ2nw9BIgIL3StKQqbmg3Zcr3xg9Qe8ByfDnKAsZDEb7AXjlI?=
 =?us-ascii?Q?yB3r7iO5tThreMPZXdA+mn6qRU1tfkCIxvFUpzIRWcpcHos0NX3nG13UK1d+?=
 =?us-ascii?Q?VEV1mpbrTpJ2ckWAEOyD6XdLljrlPPSurlsS6gt+PdFRyCWCFb4g30uWEMou?=
 =?us-ascii?Q?GDubmbhPWrKmvenQU/AJFpAiVmE7qi905yVo/2Be5FOTNeueHAKKbdUj0hJN?=
 =?us-ascii?Q?vdadDeTCBrhI9sY6IssuVfKAKSklRZOrKZjfnqMRnPg0bw6Seq2AlpZuLS3u?=
 =?us-ascii?Q?P6kPxUqQszEmFRbKhAQRLtowvV7LbiCs5g8zwpYwDmGMNeHIU2KqO7x+7GG+?=
 =?us-ascii?Q?MlYI5Jj7yrNx3S0IxEgM+PtgIjFriiDKeueLqRN3oJF1kSsn3CdnUDV6cnUI?=
 =?us-ascii?Q?MnGqLwxkS2Mmtv5Som8Vbgi/zVfaAk2JOHoAVVfaL6lo5EwqmZZEDJBIDvyZ?=
 =?us-ascii?Q?mBix1kbsZmiaaam/uVJlBN7hlqUNc6z4TjnE0O+b7bwZ1o6z5NcCYxUfGT6w?=
 =?us-ascii?Q?lMAwqcUSMY8LW5R0FIt6qk2MXa7oWH2eY39jVrQpBz9pZmTjN9gGNbjRGQuh?=
 =?us-ascii?Q?HyEQM+iku+xnuHhYF6KULyGXeOh6GLYzvcfnxwNsm29oX0pbkJ3bfptrGgdb?=
 =?us-ascii?Q?yYxqwJYClkyH1iM0/XX770L9sY5PYMGw0xvQYnoyqmkxL0V7QxBNYK2n5lKL?=
 =?us-ascii?Q?wxUiAa6rX6cajv5PzY0WeYxrxz87J6FzillAGQNXqDyva5H1LJgQtgD/UwPn?=
 =?us-ascii?Q?5E4UQnncY7Ha/SBM8h7Xkv3hslES9bEOsFToC+gy5QVVIinizqVCiGMGpm+2?=
 =?us-ascii?Q?eIvX97d/FlucopH4bRcg7J8jAky7kr/8gOKWH61ITT7cgkVc3YIfGQ2M89Fi?=
 =?us-ascii?Q?qZPMD/vl2ivCTV3EwGrhwA36d0GuQJWgXhDecW0UVN0dMk088i7UhWBtgZvE?=
 =?us-ascii?Q?t/V/f7DJSunf11wnx2QUHtgrpwvFD6niaz/65+cmDbB7bH7RpujFTYW+5/mx?=
 =?us-ascii?Q?B3NjkS/Z7tlRJWn1nfMiH1kHInRNX38=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc36db5e-5b2a-48c2-ac37-08da43d84496
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 14:08:57.3443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OZI+s6iQSqBIScte/QdyzOmxwmMrywdFpshPo5fL8RETIpsoXSuELmQDHYBXxrlG+kn7sun2boZKLxRE09gTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4805

Change the access code from mptcp_sched_data to mptcp_subflow_context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 338146d173f4..0529e70d53b1 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -42,29 +42,27 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf=
_verifier_log *log,
 {
 	size_t end;
=20
-	if (atype =3D=3D BPF_READ)
+	if (atype =3D=3D BPF_READ) {
 		return btf_struct_access(log, btf, t, off, size, atype,
 					 next_btf_id, flag);
+	}
=20
 	if (t !=3D mptcp_sched_type) {
-		bpf_log(log, "only access to mptcp_sched_data is supported\n");
+		bpf_log(log, "only access to mptcp_subflow_context is supported\n");
 		return -EACCES;
 	}
=20
 	switch (off) {
-	case offsetof(struct mptcp_sched_data, sock):
-		end =3D offsetofend(struct mptcp_sched_data, sock);
-		break;
-	case offsetof(struct mptcp_sched_data, call_again):
-		end =3D offsetofend(struct mptcp_sched_data, call_again);
+	case offsetof(struct mptcp_subflow_context, scheduled):
+		end =3D offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
 	default:
-		bpf_log(log, "no write support to mptcp_sched_data at off %d\n", off);
+		bpf_log(log, "no write support to mptcp_subflow_context at off %d\n", of=
f);
 		return -EACCES;
 	}
=20
 	if (off + size > end) {
-		bpf_log(log, "access beyond mptcp_sched_data at off %u size %u ended at =
%zu",
+		bpf_log(log, "access beyond mptcp_subflow_context at off %u size %u ende=
d at %zu",
 			off, size, end);
 		return -EACCES;
 	}
@@ -144,7 +142,7 @@ static int bpf_mptcp_sched_init(struct btf *btf)
 {
 	s32 type_id;
=20
-	type_id =3D btf_find_by_name_kind(btf, "mptcp_sched_data",
+	type_id =3D btf_find_by_name_kind(btf, "mptcp_subflow_context",
 					BTF_KIND_STRUCT);
 	if (type_id < 0)
 		return -EINVAL;
--=20
2.34.1

