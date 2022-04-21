Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991767A
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 06:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650522384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3p8MFyz9bwj+Je/MO804vFSk6Yyr/Ug9LsYkdHCocY=;
	b=LcXhMe3GQzKCRzYZW15nhzmSURwIQxm39n16bJQqMRdwW+ofZte3jMBf4KRvzoYkVemo31
	ds3ZIAIGMkdMSKlVREy4SbX/wCzQGJBOrRFOa/Zi7Q8aWEOvoah/t0rOlbK+UZ0dXI/cpY
	QQWOHHmQqjonDxmV2Y/EzYtoXDDjILs=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-HnxwWWjzMEi1lvc7VUkhtw-1; Thu, 21 Apr 2022 08:26:23 +0200
X-MC-Unique: HnxwWWjzMEi1lvc7VUkhtw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6DztzFvcv+H3Rvgtm35MaySlnOpAAH5flGx/iLzEMLG2FO+hf0a7uFh8CsaB/XtmPaEsXFAFyqhFPSUnS+09CIfbE5mFOT8QlKZM3B9XIUpXMB0Y/aaB3BQ81Li/tpVQNg0gYTFBvQdi188h7rhm9Lv/zxPi7KxWvlJdfJg6xJ++OxAGZC9vMppXxjddwYMAjvMb5/0XVjbTn6UQ9LhyML002EV+ywxxQEhvwtypj6XPyZS+1q/QcCMFr5613zuu7TA48KY4ZwN0fXJGTMGNKvvrgviV1/PLEUxQtavAs/A8+o8lZPOaE6MZ2DKE4NnnWSeMs9Hy9EUDGVG0FrCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvlFNaXbjFyUMGcNLRAnJJxtvxsnLVXyWsHs6xiIj+Y=;
 b=fS4mw2opfbbjOorJe/OTGG3mijz0N2+MExVGX5929hu8Mb+Y8NRi25FjqpfNLfAP1+/l5AvproNije+BGZlkIJ5sja1BUgOI8tp3GpoOUJuhUa4hz+l5nnwYDsJSQR+CrbUXZrJkGi0PHQSG/Qj/THnhAu5yZA0DeFxifEq15JY7qP1roZnX3GvxIH/izgRKDPBbojmtvSSTFX8RUAEojGjdaSamwu9KOb3C6yousVXeuozgsRyt4i5QvWzTo2206SmTtwYS0+I26HtE0oANtv/epop0bLWU+3lA0KxHzya/6ghdvdpwlXe8OCFMIF1/mvXL8WPzLaHhkyjNlqoJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2247.eurprd04.prod.outlook.com (2603:10a6:4:49::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 06:26:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 06:26:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 1/3] mptcp: add bpf get_subflows helper
Date: Thu, 21 Apr 2022 14:26:32 +0800
Message-ID: <85b34bc973f6f708aab67b5639e6dcbc9bde7d2d.1650522297.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650522297.git.geliang.tang@suse.com>
References: <cover.1650522297.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0082.apcprd04.prod.outlook.com
 (2603:1096:202:15::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6050748-9764-4a55-3305-08da235fdaad
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2247:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB224795EA6823E6C192A99265F8F49@DB6PR0401MB2247.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y7yyGH4k7rdOGvkoh7GjP2WGq8w3YImo4Fc2HybkqnbpiSWN1TCaeNVMpQata0/cgp8dwuaNdLG21AXbmAJ5bPAwIPXPr2qMbtNsbHPq/67w+ak2FB4Ep/mqI7E99AgPsN1qrlbqte0EiLIf9o3YwWSXR7It0uwWWh/h/E3CIRKXF0t8aHVZ4vlNLj1uvoPkNKsfyPBKIPJe84Ba8CTzepxAZlksthxVHKxjWnkCaNB5SopSyGY7oMj+re26G39eLCKRfwewTZe0fAnoGYPeg6dlNUbPlkbroeumi3ayJ2oqq1m+AwEKRb9jX0PrWcKaubbbc6V8h3NbxO3km7nmLKls+jikqXYBjS+46Uhlcyy6zrysR0Df904t+xpVbeFx1s2FpMkF88iM6PhUt1AWqfRp/1eXCJOYAukPahcBgC7UG/pdjkrDQ6ebfCrE9zFDpbVEdPHmC2m0ZlF583wP+lEQ3TiJ+BdU2soDUxC13fl8oz1zZfQPA+2Tl85AHXRUKEltP/96yZEYubQaBPgSA/Ih7CTuFrFFrEmAA6f8CR67t5i4OPsT9CsJxdKxNn9RW62YYQNkfiYbwXr4YYYkWTLxiIHhzuKw02SkKzVYczn9SjoXQc2R58AlTwyfnNXRNO371p8gMLHPt2Aff23N1znjiBLTQbZI4WMUz/zZuNXZgv4qVRT1dHlIje2rq8zPTTMmBwz++bzrWKM7UcsUVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(86362001)(6506007)(8936002)(6666004)(316002)(508600001)(6486002)(66946007)(6916009)(66476007)(66556008)(38100700002)(4326008)(8676002)(186003)(107886003)(2616005)(26005)(6512007)(2906002)(44832011)(36756003)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ZVDDRBfJzg1VyHklulP90ndfbBJri5luo6PsDm/Xj4piVHwdHrsqjYxD0sL?=
 =?us-ascii?Q?xce7y8RgjZb15rdVf1biysTuvpDXNv/X+ojSiilZjVFtBk+mCX5/CQ6WVI/0?=
 =?us-ascii?Q?37W1zQ6oVou9gPLU0dXEk9U3inbT6QCPyzbayL2hK3do2dhymqzXPPmIe42l?=
 =?us-ascii?Q?6KPMAxbJCHDnpEO77+d/YgEyCTj5qLCMNhFlnmAb5vDkchACaQb04NSBMCq/?=
 =?us-ascii?Q?Gj2zgsn1JyRzTJaXi/dfwvQn+qm4xoFaKD+tAuY0RE7RTbS4OxTsFJ/yTEiT?=
 =?us-ascii?Q?/HXHb/1xgkewvxgci2eFECBF4sCDBLGmY3eDK3gUYgGhPG16LlSrg3/2DW8y?=
 =?us-ascii?Q?GbhBI+m5fbFPTYRKvONaom7ygD/3EyPweT89BkTGQIfyUCYYACu3GGEmOVRc?=
 =?us-ascii?Q?xfP0lt9smMBeaz7z/Z8Am2moqE5T5Df6Xfea+sQnleTLCR2Uj6WEaX82Op7J?=
 =?us-ascii?Q?21Js+9isU5SubO6j/Sa6m2X2O14WhfpYY3Eiie8j4OIy7qe53gHPyo4g0KDI?=
 =?us-ascii?Q?cRBPMciA32UHm+9jHDpeZ61h9xIt3Qi5UJyEkCFf6W6XSOktWJak93JdrEwJ?=
 =?us-ascii?Q?6G0fjDxPyVl1eABzY1BCFmM0PjFNAAjbz6k3asjdwpySYO8inMhgmQ4xw+gT?=
 =?us-ascii?Q?VxopZGGETuNX3GBLQZ6YMNRNYqoyt4v7efopPCJSp60oQOs3jhGJog4Fbfwe?=
 =?us-ascii?Q?JYj8g21cQopDRoqr5qrMlk/AhACL04CZK90aejhqArSUmh2RQ1D2XLTOpWvZ?=
 =?us-ascii?Q?LpDxnDkWK8s/+MQE25k/BmgiVMQFg+vKm+e1fgyWuyeJzF9xBjL/h6RGfU7G?=
 =?us-ascii?Q?S8xD2zi1jhJ/2pm2p7lPy7R8ZkJsT6vdx1Ctq3IqLYhrlI+9FhdAD8xhwDiL?=
 =?us-ascii?Q?AVFkB7V0Jbh9kSVi+DhsRx1Pga3Vk4CcD5/3MRsmz2meAWx2zf7D6mkb+hKm?=
 =?us-ascii?Q?rPDEC1+FWX2aMwxs/d9tm6JZgR53lr0T45MZW8VJV6PxZfujuieA6gVs93gP?=
 =?us-ascii?Q?3ObaZH2gYxsfILFGJZsibCCCTaM5rVE6tFT6HSR9wlGV/QSqQAX0bRv46tFI?=
 =?us-ascii?Q?dJqAJuq0Sx+I/xatsXhFMstGf3Hu9yKd9esx3Oyg2ci5ZdqnnXpVS3PtGqS4?=
 =?us-ascii?Q?yXuL8ISITyxF6Ddv35BqdRQVTXIKPLA8U0KuiiF6hHaYPLpTgXAZ5ghPc9yZ?=
 =?us-ascii?Q?fFx2H5p7rJAj9sne7r0O5eRkqfpow3Zv5PnGZfDNnoS2vpEe6cK0lm0x82GQ?=
 =?us-ascii?Q?KX8v9GnVKysiP8nyNAfoo0PQeVIaS6Cq6jRp2xZ9MY2VfhFXElUrqj2u8nmr?=
 =?us-ascii?Q?ixxYbpaKHy0LGuNTVm0uvZIq8gCDAXYnjaBHJYux/cYPASQN+ZF4gTv19xA+?=
 =?us-ascii?Q?/Qnky6WdxbMpnrfDrxz85KtNvDgDaTbHwCk0ztUsndoHXM0vjfWZdxOPAdqX?=
 =?us-ascii?Q?OCzQf8A5frXmFsAuzKbL8cdnU4LV7WI9wAAFhridlTGVGDDk+q8QMwk2lZEJ?=
 =?us-ascii?Q?wegLY0jH7lMonV0V8LuQRnWNMXZiAgNKcIRGEPPwGYd9zaUw+PPRiWlMz+zb?=
 =?us-ascii?Q?ikgE/VjM95g65cXeps4EiVhejPU1CzXa1tobSl0sdYc5Znk8To04ORirkWrz?=
 =?us-ascii?Q?HbBOak9FVrP0iEvBR0mt3ZsQLZ6w/IiCFEwMYTch8kMx6ed4zES/4vnxNHRW?=
 =?us-ascii?Q?3YYw9BZWNy3D4tBzOMexLUUp8pzxJiXL0v6dlI9gea4jpjPc/b9FJx7Bq3XR?=
 =?us-ascii?Q?edvYYIWZvki9ruSAqT75/Sa5bHzRyBE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6050748-9764-4a55-3305-08da235fdaad
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 06:26:22.7432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTpBp0VAQPFezU3QmG3pMqo0stDY9g26qVt+VOsNp+biNKsOrzACAm6N5sEVTRmYOD1MFG4C1Tlo7s/9v/BeXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2247

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
index 1611dbe63eb2..b0b9376ffcee 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -157,6 +157,23 @@ struct bpf_struct_ops bpf_mptcp_sched_ops =3D {
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
@@ -165,3 +182,30 @@ struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct =
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
index 13c6ad5fbade..9eb15caa94f9 100644
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

