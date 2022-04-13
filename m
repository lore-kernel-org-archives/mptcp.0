Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5EF23AE
	for <mptcp@lists.linux.dev>; Wed, 13 Apr 2022 14:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649860239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSFgPcvdO72r2EepbAh+rQT2nwtXDgugNBcmBUAn7uE=;
	b=Xl8zDGIktv2/HJdIHxi9oqsuXmLRShpuDLRGfnJSRjyz995A5dHDRxJHCCfCEx/A2Nncjl
	bg7KNIdwgJ83fURDiop17TjbKpbphprTXToRmDCUJzJEygNYsrGqtuk6glcosiiMZGyprW
	Y/FHn1GBHjUM5qXdYmPLI1mJAXSST7s=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-NFuwq0XWPdGN_uvxYbnLYg-1; Wed, 13 Apr 2022 16:30:38 +0200
X-MC-Unique: NFuwq0XWPdGN_uvxYbnLYg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkwFPbyc4Ot16StDQt0jA2Tibxq19CVHYsEXH0pPh7dJH72H06O90Iwj1QXb6x8TZlBxuqGrlnjS/QMZKL51jNogm/LHK3RDg4rbpLEJ2MREaxeOJsKvi7k6g5H1VlcBwBKlF4KcuZIJ4pJWZQAxDnv7/7wFbLK4DRvGRp0NQzALIUjXvKXkGfMPfyXDjvoh32Qinv1i0guHM7MwBp8ZLktpLjLKsqVI5wfs94dPH0dPX7IudgFCMxq3Om5sToNqjzFp1GoZ86J7DPRl4KWwzhlAaM5K09W17D36uSRqDZCJcSHM6y/MLC/kscsKtQTla/ugElXR+a8ci80SdezhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wfmtsoc+aWoVMOsiIYJYT6lGswSkJwXXCdvYaWGmzxM=;
 b=Jd1j4xnblpqo+7eEWDPV/ne0glX2FguIy50ZvZjuvOCqNXxkOh5PAxXx6JFR+T3t9UAHW6CiaU5HF4iSG3hSc328RVq8dSHublSoHWuz14UVSLiUdJJ0QSImFuw/npLvR4YqHWJHECUDVgRyfjLqn+JASri8QuRA7iurLObL390oKEO+QhedVJKFCWARaUhWK5JWbuDnN5Azga0rnTb9oFXzjNEoOvkLvkJE/kPsmAZnHCOX8GQgAitd0cyT89xPnJQxLnt3Q9uATrTsYS0myKTW13jwrRd6xQ31aE0HbKr5jVkzeCVM1nAm+LtLoOyoxuFqcO0JCFKWY0x/LIlM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Wed, 13 Apr
 2022 14:30:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5164.018; Wed, 13 Apr 2022
 14:30:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 2/4] mptcp: add bpf get_subflows helper
Date: Wed, 13 Apr 2022 22:30:21 +0800
Message-ID: <0431f68984e7857155a6ab2a5835f6747b4ff0ef.1649860043.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649860043.git.geliang.tang@suse.com>
References: <cover.1649860043.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:404:15::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45bbb9fe-4a70-4484-b0e9-08da1d5a2d5a
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB9351760BD20C36E8F69598A2F8EC9@PAXPR04MB9351.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K8Hc6jXiRxyataSmjR9ooDPGVnyv7Gu5X5hvy4Ejq+lhkQvQPAzeuO8zg6aKOawLbCa4qOwQoPMOvnD3840HFMOlhyHLuSclZGQIICaKeg1raFx2K0YTkNkNVuT7OCa/CM8rB9nF/k33pb2x7q7yqHP+EXeG0WSOdHbWNRvvBgwrCdoGsOEgpUwOFv44BLmPszHE2kxInnV4vafXkgqWd++lwSF/a1WFk1FmoLDGq2S6+336GNBW5pZdJun0wXuYfO+3QCJ9qx8Fxi1AU0ItToOSMAJSZmUBoH+4HGHsr5nMegznxvUvHKQaDHaY2a+lgA/tYeIo6+3BXpj6Pt1BBwuN3Ev8egqP/DU/84RkKHIE//c1GYPVEMH7GItTtjX79s7rDrflBRJvUyivJQWxDnUKWKib3Jrh5Ua7+HlKa+FR11bSV4WTniFx1jPaEjBkZjQO1ti7ta9Bq3UxgpXj7dixx18zWNsIuPs6MhPGeixccnR6CUoAzdJToSvSHSpf2hE5fKu73KuljbkJdgQ2KtCjCwxd4ewi61lJAQBNshM0jEftt6PXlj1WmKaEMeEPk9H4w1wqYmu91ddneH7wBgH8g7IArIU9fMV/rltqCAW8KussI9GZwvTwGycR2qFHnjUA6h3sK5s/tbgEIYGRXByOwaZ0SKMCjWlwrPRagN4DfQDfurFtskbnkbCuzI+HjqQ9BU3bgoq+FIyPqY+CXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(6486002)(2906002)(6512007)(8676002)(186003)(66476007)(6916009)(66556008)(44832011)(4326008)(107886003)(86362001)(508600001)(38100700002)(26005)(66946007)(5660300002)(2616005)(8936002)(6506007)(316002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3bjbpuKBb57nAvxnaHF0733E2ljPl+ZgHrf9D9MHE+Je1prDJSw6AWbSYz4I?=
 =?us-ascii?Q?fWtKds3AZdZxCDtAD04Edk6Wgb1iAdF+o16C9j/ANG4rZUormRd2K0GFRI1a?=
 =?us-ascii?Q?6EnnKbFYur7XMlWb+uxTcdlaaXm+K5cN4xjAh92HQifXZ0QFqNrLUvbnYQ6p?=
 =?us-ascii?Q?xTtkG4S+72KLWKlAHoppFeUNrHoIdWx0N8WIMrcaBWMPzO99mmLJA6+2tTNz?=
 =?us-ascii?Q?4hdBud0GCiuh22DwijW2K6u9oGSgZ2cKVSBvvMnNS3yF9ahyOwidrXUFGCdo?=
 =?us-ascii?Q?vaJcidisu0Ki/CD+09Nd+VGX5pWEHzDh97Rr38CS/w42we3ptiK9tNiCowkU?=
 =?us-ascii?Q?izrmHeqdCY94Vs7tqVSnDgq07l74tyjG3sa9Cb3DbaIZ+HxKOH44YihmuQn0?=
 =?us-ascii?Q?wyYKbF0G9tP4JEBnheduSY6QbFiVTwiGRRVHcH8I7kCgwtK/C57PXlpb4B0F?=
 =?us-ascii?Q?Vdi0M9A4uE8Kx4FEX23KJh1Ubdn9tyhsOU1HLrUnPW7RjnWJRdREZBCOx116?=
 =?us-ascii?Q?d4I1leDTQlyT4y37hcq8y2z+/3uCyVWUc15v0DpUKmqZf6QIYKPJa9w0u1T5?=
 =?us-ascii?Q?8A90DBb87vB5ep+QKCgwh7yukqPYdOx06Plp1inD76NZ74pfmPfSKmlt0sNc?=
 =?us-ascii?Q?02OcMu3gKdyi1xhGmLJOKicUu3xDT88l6puQVt5bDlKtceZDFfSNYz2zHWbd?=
 =?us-ascii?Q?2Pwqln64fMnTO5RP0/ebyWE3cAlC3eXR6Hr2eje8vwFMbE1Pdewc8B4b2Q6F?=
 =?us-ascii?Q?6HNIMnfvN5OiH4tcTJx1n7Qf9mimY5e22qOTxS/xbbdS6kUToISg26oW7hBj?=
 =?us-ascii?Q?8UfLmIM5pZqMCbvWgEpjx3tuIv7IN+rcBlAMKP2n/1SWWMrvJUiHzN0HKu94?=
 =?us-ascii?Q?n3VB4OMFMLOruOU+1ZwM+WV+Ms4opTkib6/qT1sMucbubr6TOKRUSj73iDBt?=
 =?us-ascii?Q?RrSAbSDLsBNJz+QpI8U0ULjYvjffTa+VpFKa08MnXvAtx0RuIICDJv95O/ky?=
 =?us-ascii?Q?gpSL5KCqjv20y/wCXuYCgAG52Pp0la3m6leSeuYP4Fnh8/02BShfPGw8o9B/?=
 =?us-ascii?Q?vJV8kvofH0E3ADY4sHPDgsr4z9wNZXOMTyXX1grazaQsYJQKzB8r41q9Z+fH?=
 =?us-ascii?Q?8QvltWTd/A6l5/+Da1Ybvu1vg0I4/BGXnLSD4WfBq5X8XSTGrGBbdCf/5M1F?=
 =?us-ascii?Q?BjefvoHcWoUrZouu8ab3CFOLO69hMlJxiOzoxtpN8poynm+3M+4n48tiFena?=
 =?us-ascii?Q?/aURC5jfKmUs68bo9CU2J3NWBalq8a0akObtATjW62UUcdR1nm95IxAPSTA6?=
 =?us-ascii?Q?EHYlw7dQahtt5/TxdGC7abekaBzCxrDCKKjPeEA0PbKSZTI9aiEvdmg3bn3w?=
 =?us-ascii?Q?oRJjxZ97iAIOJtRGbRMZWKzY+oDEtt1zsax6BJke4g1B8P9tJ3xWkIx1G8hH?=
 =?us-ascii?Q?/sYOaLa7lfKphsi3FgBzSziE0rdeWxoSXeInbbxHvEsAFLRZ3CDg2AHf6Xz9?=
 =?us-ascii?Q?EXitlTOtsMLU9bZxAtRvoGIkIzs52LATXmlKHYkD5lX6hi9H1Tbf295z17jP?=
 =?us-ascii?Q?LSZ2fMbLi1ibBvwqWh/zoKbmQE51rN1vqumiG17wotZKxDoZTJ4jKx/X4vLA?=
 =?us-ascii?Q?C/1jie/pZPR959Pa6HfrEe1ET/boDdh4sN5ntqzCgA2iLWeT0iXTG9/ACp1Z?=
 =?us-ascii?Q?ZKH144wXWW9kjea0leeh8ZpJsytBintbchjvfXVs4IMDza9QzI3Top78n1kj?=
 =?us-ascii?Q?0Z1/7gRYwfiz0JMZXI3kbCzvFOA48Zk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bbb9fe-4a70-4484-b0e9-08da1d5a2d5a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 14:30:37.3245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFz4ujtyC9lshw2nza7q45UV5WbGLWXjVDVekvsPKkpkPHWsDEFKFHw5/YNZ5TA8jV/JMifS3NHoKa4we5D5oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9351

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
index bd3c50b07ab2..823e5af1a2f4 100644
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
index a58c5c84e72b..5581b37028ee 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -490,6 +490,13 @@ struct mptcp_subflow_context {
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

