Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E9F20EA
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 04:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649304624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hpnKGcuzoqaH1LS3bVQSUS33uAroWdU8scpM0BJorkU=;
	b=Jp0ghtqCZH6sCCbsAKhLiPeLc3YOXFfJnknyKB4OtqCFjOpKxoceud0HLJgFQ4sI1TZLsE
	SY1lfwCGnysTLlF/vUzAvXNEtkM2QhlnBH5Fa/BMK9FuC0PTVU1BLEzIazY2Tmb1d8rGWX
	14PtxzWTFu+UqF6hZUONDA9XpYQyCaU=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-00pG0JE7NOOCFqT5H70NGA-2; Thu, 07 Apr 2022 06:10:21 +0200
X-MC-Unique: 00pG0JE7NOOCFqT5H70NGA-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmjmI/MCmrKunbdwGKx/RV8zd1Wx8jDisITZbw1wlvSzPbOPOWH/Ne7UGWOuWgXglTnPwV7B6r9WqC/qbL49jcI8mzq72ayOic7BOhbvbrNLRwYyJ5s8f6ZFD3m44AsGaSGL1RmoaFK5e0f/DaOHTFGSJnrxNZyFrXyYZjM1caxf3Cc7nDPIO3rauMwOQaYBDXFR82Xe4nfLdgc19h8g1jPr74b1DxMn33kEsWSnsURceEIXuM0vPLHwSoYkRwn3gJKRlmdA15c38+E5BzfQ0Jg6jRUzOWqvZ95s3WnLgxyWgaEdQ4o+1K19TUQizsNIsLjcHaMu9q7HQ9aecRpjig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fc82hv53r02Ko58DsKa3d/aIKLxlBza4OgNVKT+HDOE=;
 b=Z9Ujmk2o75dtMgRAnLkGLMAkz53IJBaqkk/k91w4RusJrRs97jzgUMjZqRyhGut5XzLOcspStLmH7ekdLcfiy/R88ecCPESvCS4fl9GQlMTx2TNvUf46cUEbzQp6xfSnE7slqhjgJzVcd3dyPWM48fYLhKcOTVuxQ3iX3tzImL2xgot6rFZfrFczHKRRFUax0VoWULmJZVlDnNlm6yp2tDrPLjGsKfq0xAoGLDA52umyRESZp1DsyMGrF4s1+7aIz2fBc1nQ2tS2xKTu3bKfexUu+L2N9CYLeF06nOgVCUx9h32OPOUT/eo+SNnnq9HtvpbXUYECv3uRqTNAMcruwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3354.eurprd04.prod.outlook.com (2603:10a6:7:85::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 04:10:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 04:10:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/4] mptcp: add bpf get_subflows helper
Date: Thu,  7 Apr 2022 12:10:09 +0800
Message-ID: <0d8768d4ab4e8207a60d28ce5ba0d4c9c1a6c3a0.1649304364.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649304364.git.geliang.tang@suse.com>
References: <cover.1649304364.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0027.jpnprd01.prod.outlook.com
 (2603:1096:405:1::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 035eb874-5d41-4735-5769-08da184c877b
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3354:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB3354FFA3714D93FECBEF1319F8E69@HE1PR0402MB3354.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YqX8Z3Q7nxPXmeaQNdtBjHTom1HIacbEq+NVEo3mbAxeOtqgQRmQfGiXYGslcGSXJFKvwTC4LN032Iz3WGSntWMZuMX0JnCT1GP+g2pThy8VTZ399+D26N4Hwak1FcNT0psITbrTtRKVPstbK2HoxAzfz3RZPgWSfw4KTchgSSzEo+LJFKM0kW1esaT8T+JEMDyQGoABpM0+UmF2oQw4rqZTbQmjijIH1lJbDrSQViYJMNlYKqOusoFexYl90ti/ck/2sgSqZ1DEf307V9Zb67xDegVZplQsPpwjjQziI+IfqUUNhGIedrGWIV9w7vokUw7lvD3aBuGMv0GmBQ6zeOfp/1T6kadWiGPqyZQf7KJhW1YKxdEimfi9mC1Mxz8giCzXx0aCXQ9x/uCYEZ1CBeYY9gxD6E8NAs+T3guIQZOT9M84m9bR7je7+IZSnSlqvGQ9gt3I6R7ILFM5Mn+xELFQdf3SDKSGi8kyMXRs+Nwy0wabzAMi87uMQ0nb6KZfxxL+65ChuLXAS7ht0JhJoWBV+of7qRxz3i92hV1t3qMn8GexhcO2/t4A+qnhNQ1mjsVqE/rG7NxuFlBB+bWLE35ADhPqrtcxe3wfcGpQDqZ20eEQDYmfk2UN6EAczCbHHPaapd1Q3a4FVrqBRWVTO7z4ezLUgI40SzGXA/99d2X0Aebs+u2Iy5qlQ97d1ZlU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6916009)(107886003)(186003)(66946007)(8676002)(66476007)(83380400001)(2616005)(6666004)(6506007)(86362001)(316002)(4326008)(66556008)(26005)(38100700002)(2906002)(5660300002)(508600001)(8936002)(6486002)(36756003)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uR1UHmcEdT/1bJSHzfCC2GQZKwILV9dZmHlora0aWF4OPlvHQBnh83zPN0kz?=
 =?us-ascii?Q?JvQuOi2TE1jNnyl0bPpxiYb9x3Nn96tFJ4KQlW+TN6e79IGZk9ePwW3CMtJI?=
 =?us-ascii?Q?esw0FHdyo9RtGpC0Bochl0Q2pHit/QDKIXekddmwUvt5r9z3uyOkFTA1TZPt?=
 =?us-ascii?Q?6VhLAoFvVF3fJ5G2YTeXOOBBoMDvpEngnpqq2xTKbC1zucLkug1gKCOTeeHy?=
 =?us-ascii?Q?xzZDAJZH8I6Um4nWgD3FaNvVte/lAxlrhjLPjnjkZvnwZg7yZHrGg7DudFYt?=
 =?us-ascii?Q?GPBw6WhU5uMxSf7gs4MeCJx6UIJtVyM0WCZhZUfzi3TCj0sDZCB80ktX05BW?=
 =?us-ascii?Q?zZEzmVUNyGezzJd8cmN3OgxSzCnN+jfSCARCysFTXABPHRhUjbp+RUm3XkGh?=
 =?us-ascii?Q?D1qIBwlxxtydQJCVrtXRRlL4ps0HSDR+5nIBCX447PWgokh4tjHOUTyNr0Ro?=
 =?us-ascii?Q?1T+trQcl7Rguq77T8J3ZoVKVPPmw30xjyDxBSjzDiJ/v5Q+Lpz+sla3QVaSD?=
 =?us-ascii?Q?+z4lXd7E2FIjj0rHY8lXkVx8i1prhDjxI/ETQhy9bpvfB4iDL643a5aI4ks6?=
 =?us-ascii?Q?CluV3VvBHWQvwFF0ppQKkJryvCQJiMP1Qs0P9beeNNPwmlquwjZroihROYuh?=
 =?us-ascii?Q?Cmr2ogobRcUuvEAtoqYA8jFPLmfG/EspUULGvp08pfjrWd20Ga7qq9eICXol?=
 =?us-ascii?Q?KPL7maA2VbY+nPxpyzCqPr8VUcEUpTLYSVRlUN4H8d1V2TWbDFrV299fDMBr?=
 =?us-ascii?Q?8rnb8rdf1siLe79HCIKgP+x68RvS8b6NfKU0/qLOymBa68IB79oMCVQFNVpv?=
 =?us-ascii?Q?8KMQr0LtSvpksF1RVaXzj3y94nEjLwBTeDz7vYHXTUIOzz2Z4bm9dtWmPYpU?=
 =?us-ascii?Q?mn59/SSWkLUZIsg/x0GV4xgGGHGq7hhJi1GPCMpdbNn7uRhd/pnS4Qc89/Ov?=
 =?us-ascii?Q?mTQio2yid3mCOcUi0VddTu2nN/C33ij5hADUuTf6LfXTNj758dkHV6q9DkuN?=
 =?us-ascii?Q?i3MqD+iSQoqVPOvUvZdgZiovKEnK5k6dlJiCnLN73QN3SpB/dWuaQii6HAc1?=
 =?us-ascii?Q?hb0k/un7YLfv3QEoRemXS2d4GLLYrIb1bGrfWrumrYWIILTb6W7RYTZHQyc9?=
 =?us-ascii?Q?vg6Cn9eRJYboRLb8YcABSjSqwPhxCD8lQOFMjL1gQNaMPFJo6mIDojewlv/B?=
 =?us-ascii?Q?DNpc3YF9aQgrde0DGFWEKt+hHMtQ48F7lXC6EKrnnHA4zJQYqRrWI9Kovbhx?=
 =?us-ascii?Q?CtJHp6boSwxFd29pFziXBNklNitL5V6FUSWkz14KKs6L23NIVCdtBIVZlFpg?=
 =?us-ascii?Q?BwX31erC+XM6A4m+73awWKfJ1hagecxl8fyEQOkbB46sqYEajGJbZKNGESyR?=
 =?us-ascii?Q?1Xd+iXFG3Yjj9bTwvBfGAUQ/bPLQMQrKGDUJ6hxJ6GUuyChHKRNPj6aRnWx8?=
 =?us-ascii?Q?0aVd0zyInUCdgVD+vpuDjX55nqFYknRRc5LuaUIDImJ92NPEUyACLTnFqzVx?=
 =?us-ascii?Q?70uP8Kk9O/S+6HQ2xylHEwv/uCi5tHGv6bNpWp9jdTiSc+apm0+OXXbb8bo5?=
 =?us-ascii?Q?eFD4iRZz1v9Ym88JE7v6YsFAc4RU8rFs7RXD2rDVtJFMavsiL0ItUIXh38D8?=
 =?us-ascii?Q?yQIolDlTzVCxlWp7w/3LwXxiISfmN7TkCHUN4QOi3F7rlO4pxnG4K+7JEifY?=
 =?us-ascii?Q?97iVK77GH5lDhvyFN8Ja41RB76uQ10jWPDEuMvyIN51sttg3hlO2y0e/aVOs?=
 =?us-ascii?Q?mgMpBbGdqgtXyoiuYKFUD2S1zqsdmXM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035eb874-5d41-4735-5769-08da184c877b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 04:10:19.9059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCZ8vcl5a8KaOT9oe1BX3ISSLuw8c3kEilVnicx7V2L3i1BicIxLGBgexTcHB8C9ea1HUAopIN2DPIAJ53jMwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3354

This patch implements a new helper bpf_mptcp_get_subflows() to get all the
subflows of the given mptcp_sock, it returns the number of suflows. Add
a new member subflows in struct mptcp_sock as a pointers array of all the
subflows.

Register this helper in bpf_mptcp_sched_kfunc_init() to make sure it can
be accessed from the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 28 ++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index bd3c50b07ab2..7f8782dbfa6d 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -157,6 +157,22 @@ struct bpf_struct_ops bpf_mptcp_sched_ops =3D {
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
@@ -165,3 +181,15 @@ struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct =
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
index 60d6ee54a899..5000f9db4913 100644
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

