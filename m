Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8F02573
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 14:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654092547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gY/JDmfCBknn1XuTrBoWGDyuvrlzi68IbPvCndaVDb4=;
	b=CcIDvc8V3p+I7WMi9WenCEHWoboGnQLVZ1ImDFNI5/ROm179a7g+DtWDTT13AWByC+hvFo
	8KIthxhSjesCYN9cPJSqgMIFVWYBcDiueFPNIScEpBNVs0JL/WQ229yzQZqV727wWxgA9z
	BGbpZ3vJ38H5Dcf9EpgRG/0WOaw+DGo=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2058.outbound.protection.outlook.com [104.47.13.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-lZQQrJ0qNd6aZJf-CkF2jA-1; Wed, 01 Jun 2022 16:09:06 +0200
X-MC-Unique: lZQQrJ0qNd6aZJf-CkF2jA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G365U+tMn1MAXKeYbgGoD2bUmbXrFI5aINg7HivYBYmzg7DHSmtZDBGIHgTrZU++eY3pZwgW6dZ53kgZBfmMvudGSDCJQXjFhR0GvIseSx3OwlYcCWQ3+JaamLGGyVurK9uVCEHvWW0b58vEMmzXxwJzdAfA/mwRYBBHVQtToZd6tHRnL7fKxfqS9Bxa7W5/WIZbOiWypoOuaU+s0dx0ZZQidNboATiLvUixC5XjdsqyGwXlqHpG/8C/rnroL2iny5z7mDC4bIBKGTswJhx5d9ATTyMG+1nJFfGQ+yR+NSucOwCjCwlprjMsWLUxURFuBgHGZxGDHGEV1iauPFzGuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoiOX6GL7pRJrFzC8aUHrfQHOweu7/gz1gOwEQse7w4=;
 b=Cy/ElXoJvmM9ceqGB+t3WGbEfvrZEg8PQYmddEfG1bIQuAImImSeyQUhiqSaLfB+SCaWNOD5SgwJ0k0aektia4ZcwGQhwVLfa6n7YEK1kRjFedU/0W3aEiERmrySLqDrqetmTajkD/IdRS1OcAbuw0NMGW2o6+aJnkkB0SOk0K1qDqkjx6nOGlBf/h7ODfSneAHldNlHHt5qInYQ5vS2pPilKRpohUqYJ2Q5ilkD1GgQArdPsabIMvYNfrmfBX/K74NTumVY4O9Dbb3F4JJ/om004S1Gu3wT+gprqQnv8lYM3YLjyZr2grvB2VqXhFauWa3uMi4e3gPSkZFMYzfQgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4805.eurprd04.prod.outlook.com (2603:10a6:20b:d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 14:09:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 14:09:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 05/11] mptcp: add subflow_set_scheduled helper
Date: Wed,  1 Jun 2022 22:08:18 +0800
Message-ID: <b459c84aa68ea021299b89e2c4bcad208736ce48.1654092153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654092153.git.geliang.tang@suse.com>
References: <cover.1654092153.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0197.apcprd02.prod.outlook.com
 (2603:1096:201:21::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91f364ff-7246-4663-5ef4-08da43d84930
X-MS-TrafficTypeDiagnostic: AM6PR04MB4805:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB48053A572D3398869F90B8E3F8DF9@AM6PR04MB4805.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hw3AKmCbx7a64tDSwxzrV7CQotOgggKlO5nOhCckjZNuQbZJ+5Hr4eGnD1FnWC8tzkaalHEnuKwPJe+NrLKLYhv0pMQpn3DwnvvCLfg9L2feTIJYtpZV97fRGBOCT/xGNnnkCiN5m6bHH6t575GGJdcJGvHwhT7EECgu7Hm1hTsfYT7+IeJ31frcCpofsoEFuvyEZxYdStHL9B/sPPL3w7KZ13WotT4DlYYp7vKCLr+4ScrmlwDoCttnqR+e3yAPtn9x9qMompH1lYAOE0MKIUgnTfdb9McmYEObO9zAS+2UcHvOcSU2cQfwf6ZcYlKvbmxnZUGZDBPBTbTXrirYZ0s5uLzTUor2Geo6xH5HPrQK6+fdEqa6sD3LnM956FXZp183yx2nCOiZNCzpcq99bz/3ldTGjbhliAPOKgyALA3ZAep0/DAygZKuWZrw9Iy34iSG/Hh5KTDGZ1Ge+KVVLsexXbIZcdCkf1lnlcPs+P0FMvTHAjK6P2T9aShtGfsu6MEkk22ijrCRVYhAXShKf40Fs9RexZnZPgxCtWATXziRsUV1RlttCx9AqpVTHm40QTZE73mqIhjCH3S3cU4+xh9Rn6BUp5F/Z0aENnnf15nyPXBeHIThDtT5zLmUZdaqVPnSL4lpOVcHEVjS+R/DMaDxOpeNT7JljIyGAjnHJg6yv/wqxriZnyikuwMyD+Zexj+bDRqwjtkRYPTyWE80Ew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(26005)(6506007)(86362001)(2906002)(66556008)(36756003)(4326008)(38100700002)(8676002)(66946007)(66476007)(316002)(6916009)(6666004)(44832011)(83380400001)(6512007)(186003)(107886003)(5660300002)(8936002)(508600001)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KI+7toTQRDpdtHrfSRjaHUQbr5yNfQorRAfNCSnCkS9YoIcC4bnUJgd4B7oh?=
 =?us-ascii?Q?4q7MLfoOdE3d6jbX3WhLHb1xfFl2WKmSpPG3/5z+H4BCSP1BtvCNHkFDCNNm?=
 =?us-ascii?Q?IeOM+jjvQp1nkaWicITROA9zAwHm3cMYPdJK0mc+43eosaMdryKIFxwe5Bu7?=
 =?us-ascii?Q?PMHdvNnaa51U/9E/gk48bUUkLwUm78sykxKZ/OaNKy2fmUH/8fF06yap3495?=
 =?us-ascii?Q?TvvPtcf0flQQh3ZjctsaHJkX3cCdKLN5xcJEFKiSNFYFtcHrD9swpt9qOyGQ?=
 =?us-ascii?Q?N15mIgcMlWsfREMfBCHbbLK3WpZMo4UEjuRciKLrCj0gIlnMVW5hmx/bASuc?=
 =?us-ascii?Q?FO1aVi6AU5hDkVBgdD87orbxorpsgvs2uTVDBJ+a2UyTrrnSBdDFnufbhwi/?=
 =?us-ascii?Q?1MUcrIAZEP3SZzlEIvIiL+IkkkVrzUBhE2UhMxUPU6M0G62J28Agide5/VPA?=
 =?us-ascii?Q?6I96TLjaYcaKCumcyJHsfa0l+ufwrt/unkippDDEx8pbisxf2zT6LAoWeBiG?=
 =?us-ascii?Q?Ebm3J/GlNCBkRXzRKEBS/Ltr3EbSuHGN6fQLO2EnVzuBgAOQNnBstNEQkKc/?=
 =?us-ascii?Q?EPjSEX1OdMimanDwnUZ1hTjEZoDY8OsSZRuSmjfHFD7yhJRUreGORBxCFaAF?=
 =?us-ascii?Q?NtR1Al/ptFVOCTABhp9FxNcoMaVyxOJp4HQ42HMdkxMtEdmf+N0OulDu2VmJ?=
 =?us-ascii?Q?xY85ZO9zyk+/WGKiiOWyuU+JITukhf1oS6n2top5au2DiLx5VLLNZheZcFlI?=
 =?us-ascii?Q?4CCoKxpOmRcrslxAuJnYpCDz40ckfe+tURGg8NLQn/rXx2/MeLYCcWXHTzMe?=
 =?us-ascii?Q?L9cZfVf2DW3oH0ZmCDlJLIOkakvJeZSLp0gHC7Y6Y1/aEgaaxHjBzClGoA3T?=
 =?us-ascii?Q?WXA/tkQT6wQ28Tq83G8bvoou8qkvcoeEUO0aiCJXA3oQdL3y5oITJij+ml8y?=
 =?us-ascii?Q?kgV3YEZxmU/+Zuc3kLcB6klxRnZIX8QAYtEwPtXjJwlhVYNaSaGcNLFNHwfy?=
 =?us-ascii?Q?xHdETT9qvBCJrsfXooOk9xLOL1xZ3d0uJlyOPM8PxKU62HaOj7Mrm/C8jbK+?=
 =?us-ascii?Q?eC8B12gf0feTduyzFkCzOHCUDuB87UnX3bL3X1pf3s4mDqh9ZklmBi+21e2t?=
 =?us-ascii?Q?eD7FGuhofxvj64ueRCSBoqEcJu+27y/LFGm3zPItjVWGJ55zmnGwibuzUcvB?=
 =?us-ascii?Q?MqcF2WTCsLWEYZP+AvKV/MfgdTskRRQ5T5M9pRCu6Nu1aEHd5oAmutXZ1VYd?=
 =?us-ascii?Q?0yR1g/jBoTU7ZOT9+aA/yw6ZKl3RC5xn3RnXbIo55X8+q+DHXst30ADzKk5n?=
 =?us-ascii?Q?OkIfXPe4h6xmOCDJJmVoXue+mOx5PxhUjx1cQ3PA9tO8pJaTItLVR0RdOO0B?=
 =?us-ascii?Q?w6Z208+b9WffKVyWpdXB3YJA8NmSgdLB94AeXNxzfQuktqMnnWl4krqWF28o?=
 =?us-ascii?Q?4jKUXrDbAZnkYYnhL211FhgLM4tNKlYs5aOvx9BKNB0d6eizTdOn+mDRcwQl?=
 =?us-ascii?Q?oRCBgWnK70IWEh6zMK1mtklr19um4jyfW35FrvX3euLwDTopeUvKpRKGYqEN?=
 =?us-ascii?Q?9T2+Yz1MYNxBZTdkWEmECdpIYcMkri7e5hoS8qUAqg0qtvJfKL5cl+WrE8wt?=
 =?us-ascii?Q?pG0f3DAb4KuyzTyDbDmqFgCKQcUGLpwhhiFJRXK66JBNA79oF6T0/kWRrmGb?=
 =?us-ascii?Q?UqUZzFYHAWLPnKJHvE6CxC207GIb08domDM2e8pbMtw+Iw2Q18GpMLQzukAj?=
 =?us-ascii?Q?pxz1p/rRIg/vIUSnp/eCdEWlgftlhfI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f364ff-7246-4663-5ef4-08da43d84930
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 14:09:04.9374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twvb7586ShbrY79oIZb6AsIzf9TFZSSeCKtLf31cAs8uDegWqOAcEHnSx10iYPAmUHIkkGO9jZbnTg6orakF8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4805

This patch adds a new helper mptcp_subflow_set_scheduled() to set the
scheduled flag of struct mptcp_subflow_context using WRITE_ONCE().
Register this helper in bpf_mptcp_sched_kfunc_init() to make sure it can
be accessed from the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c                               | 16 ++++++++++++++++
 net/mptcp/protocol.h                          |  2 ++
 net/mptcp/sched.c                             |  7 +++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  3 +++
 4 files changed, 28 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 0529e70d53b1..e86dff4272d5 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -161,6 +161,22 @@ struct bpf_struct_ops bpf_mptcp_sched_ops =3D {
 	.init		=3D bpf_mptcp_sched_init,
 	.name		=3D "mptcp_sched_ops",
 };
+
+BTF_SET_START(bpf_mptcp_sched_kfunc_ids)
+BTF_ID(func, mptcp_subflow_set_scheduled)
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
 #endif /* CONFIG_BPF_JIT */
=20
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 48c5261b7b15..d406b5afbee4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -629,6 +629,8 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops =
*sched);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
+void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
+				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 6815654fc6f4..8858e1fc8b74 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -88,6 +88,12 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 	bpf_module_put(sched, sched->owner);
 }
=20
+void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
+				 bool scheduled)
+{
+	WRITE_ONCE(subflow->scheduled, scheduled);
+}
+
 static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
 				 struct mptcp_sched_data *data)
 {
@@ -101,6 +107,7 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk=
, bool reinject,
 			pr_warn_once("too many subflows");
 			break;
 		}
+		mptcp_subflow_set_scheduled(subflow, false);
 		data->contexts[i++] =3D subflow;
 	}
=20
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 5f6a7fa2269b..5e301e830a0a 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -261,4 +261,7 @@ struct mptcp_sock {
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
+extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subf=
low,
+					bool scheduled) __ksym;
+
 #endif
--=20
2.34.1

