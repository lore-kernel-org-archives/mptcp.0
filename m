Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534651FA0
	for <mptcp@lists.linux.dev>; Mon,  9 May 2022 14:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652108235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMxK/zWhA6TIMrEtdhbmajPYcIYe+J1UvJKoR15Qf+8=;
	b=Ui+pkQyL6nQ9lZccMo0FZIDTps+sFWvLWZ9QTsHe2kmF1oJBdW8VfcT8HFbSMF6U3Naujj
	hXBkJf8PvKTNp1AEielTaE6hZ1Jm14jg1w/VNfMLZGOOwv49xQgLG6QjS4/AH2+N3uw6dt
	AzD7kf+dyql1UC6YuVlbyibFO860pno=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2050.outbound.protection.outlook.com [104.47.2.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-Qq8C1bsGO9iKdd0A763HNg-1; Mon, 09 May 2022 16:57:14 +0200
X-MC-Unique: Qq8C1bsGO9iKdd0A763HNg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nuq8LgYtedyxG+y2TRlJfrqXO1OdUAYaRKWWuJmP2t4TsSPnyW1eK1VtDlYCDIY0Irx9TrpfW0nKfI484E9A36wuUE37JFYk+TtAAsnVKfqGV0YNxhAve8ASbrNwtQEnTAEWjKTkRVZfiji8nSa2H5wMC4aFMbhJ4z6tAqv20x/dZB5NnnqvzCHrjTS+/3tvNQCkuk/RaCJM/bJE5rSVOK7zp6FnUyC0sYslydSKfHvOfe2OVmSzUcDrEgn9MG9ylivRZZKq6FUt+eFI3hcImEvIXJQLhU4w6RiyW/gxME8vL3raxy5ut2J6n3oM1oN0XKSY/DL92B5FJjrpG1pliw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV227ptoVJCrpOygAP1VbRnMDaJEuf0CQaSBDg+ltng=;
 b=XPMdvPnDR+GwGCgVAU1O0zEhRm47EVXziexMaJZf5kIMbg6uiTYQo85jVvk7pQQj0AIpzZoOdFTa+GPJDfjuEvnGNBe4KDdT2krZuHmbogUT7FRdlZSQUYC9XuZhZcZ+MAkwK7ZrvMdZXDLog8wMwk6Gic7Hs7Xjj2wBxuk15cAknY81uNrVQeb34YBOdIEHDd+0451eVifD8jFKEeNsWpLGdxfHyj07MaSycsRtON3+38r3RG3ex2Ht0mXhGZUrvUiAq1BHBZvY6opKI6QVbDan7uDcGOv0SR29b7dv98vvIoeWwdtoYE+RC7nzOJLd68loYzqouw3QIdqJhF1I0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 14:57:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5227.022; Mon, 9 May 2022
 14:57:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 2/3] selftests/bpf: add bpf_rr scheduler
Date: Mon,  9 May 2022 22:56:48 +0800
Message-ID: <0e56024dd4b77474259fbb90681b8e6968c1a93b.1652107942.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652107942.git.geliang.tang@suse.com>
References: <cover.1652107942.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0168.apcprd02.prod.outlook.com
 (2603:1096:201:1f::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d21bb9e1-9c33-496c-7e00-08da31cc333c
X-MS-TrafficTypeDiagnostic: DB9PR04MB8107:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB81073D1472120331D68E5E6FF8C69@DB9PR04MB8107.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V4TxO34oRQtUiuLL5hL8wxj/phJXOkonKei+kMLki7M5S9QBcC8MsNVTFoJ//PqDG123WbwNQ2p0HjUcQ+NGAcyI8JiSDt68djVwYDDXs69YVC5A5QHu7BNWksiw0a5B7T+XKRrk2i7dK6AG8My5L69au5OMiS0NUblgdGMqZ9PqAlX5rinlUzkV+yi/UHAnYrn5t//EbPVPeQEgD5/ZYaBzXeKSkOsYVouYaf+blYN160+uqHTuthMMa5VpqsmQLcE1UIrDd66MyVCKEnm1uJEPAj+S7pfce1o8EqVq1W9D5lorIz3rmuWNQnCSpaOq84iYV0HpTMTHEjQFHu7pEmiVK4NYpiK6AXMtn+tkV78Lkt6u8OSxW9I/M2O84UKblDT0duzzKqN+LtgHafkd6agFcaEzg3lYItlK6QYd8ifszaMKq4z4C4VMlELxNK+ctjsDdTvT6jwpd8jc0PZmVdKWRJs1NezoFubrxzGilzZDa946BR7+IpHZ3d3q5D8nO5wPWFetCSxY+ZHg569VR3t/8gqyn2LsEENxznmIKtqhUJc1tvAoFwSySbwSFVI/E865YULpSkw6PECF5BrxOzPJr/qQT5YpiQts/lP63d4xH6mpSlMZmo3CjI8H+cQFFJ9k+lFWbPV+DVxWwHZcr3DnXAyV1dGiXH9GM1OlppzXVqRGMtM6QkYF1PseZWz1+NgK4+/HicjwCzLswyMIjA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6486002)(38100700002)(508600001)(8936002)(66476007)(6916009)(66946007)(86362001)(8676002)(4326008)(2906002)(26005)(44832011)(6666004)(6512007)(83380400001)(6506007)(186003)(2616005)(107886003)(36756003)(5660300002)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WjBPLe5gjEKe+D2ASwq5W/oy5RCHZZp9bgOikntLdfYBHeb8L8gG+BEgDi9j?=
 =?us-ascii?Q?H5DvfhLuF5SjbavDOZ4fQr1lyEe3pEeg20qn8ZZydGbyh2WMtOVcP53Wz169?=
 =?us-ascii?Q?OXyL1B1Obn6I23f1bcMgFsj78IXWcgTFzxQ9MexuOoCWnFZx6S2bLAV0KzU1?=
 =?us-ascii?Q?0pAjt2F9FcuhUx2kilGt818BjCht8+8Ue65xGOscgve3Q5B7N3Fbx2l/9vuF?=
 =?us-ascii?Q?n7CmwInRDAdJ4hsU89z5s1+jbYqdJ70QjAr0Mr/A6mgq1v2ilouQ1f6xTtwH?=
 =?us-ascii?Q?MPQ0kFwYxEA4hqY8yd4/q6fQq4EkVu/BeNZHPawymmd4CH9h3j7ox6Zh2X8P?=
 =?us-ascii?Q?H1xKRzmLs7oodLhzSQjXCYC3XqZMN0ps5tPEtSZdZjs/CvfTSEa55KjJD8Kc?=
 =?us-ascii?Q?pjoHMXOw4AusE3eFHVJugoGLPWaSTjKE69tpUyDyi6q5dDP4isjs4enVkD4s?=
 =?us-ascii?Q?9efk5njn0ztmerUjtqoXo5Us3aryXLGbGql32/iwyscmATCJ1fRPTN5nyCTB?=
 =?us-ascii?Q?H3T9+hBugdlY7mdqz6GYyEzteoR9IFyLu7R5cnOGyrUQ5se8KG+Vpn72jF3Y?=
 =?us-ascii?Q?lscWieCeKp4e+kViyEQu4hsWV19DExgm2KeaOJVN3klN6MnHH+5XXfHvo+aq?=
 =?us-ascii?Q?lpVMOEZewD+Ooq7cnd9ucz1n+x0JdDTEhxFQLk3Txul9n++qa/cvirkhK2Ik?=
 =?us-ascii?Q?GaYOD4ofV1Bafodol6vJTOwRY4rkAb62cH7xhnHOK0mMzjwig+RUKjWuaCnT?=
 =?us-ascii?Q?eCFxq5XPcHlFggsg1ADGwmvohcoRu6g3qv00r2DFas8PDg7WySal/gHCHxa8?=
 =?us-ascii?Q?435+npO16pHu8e87+ytgM0YsCC68w/l2BK9hr/fXo2dzqabrYGi5W3ISaK9j?=
 =?us-ascii?Q?0veB84W6AosEzkjKd4vZ/zEtapTk33XJHu+dLSqnirwxDbnOrhvOBsLFsu98?=
 =?us-ascii?Q?RK0LqP3lmbj4e5YlLdEnv/T8htdzLJByCG9pD//QTVMcpjELyc0DMYlW4U+T?=
 =?us-ascii?Q?s2c6eOzx4XC4Y2a4aGM9DrI1xGImKltLVueu7HnR3FrFROP8gY2i61anDa84?=
 =?us-ascii?Q?MFoKkFGiKeCg66g4DcBZ3h0lTNX7TjMUs2zcELHY+T81ZMx3YjiGs1WeF4MJ?=
 =?us-ascii?Q?s443EwTXywqVw8ljqeGmhw5TrOy9BGcmsIHJc22VP5VSpvB2z8/94VrDl/tp?=
 =?us-ascii?Q?zpRXEl6FtGOcQMlbDmxMdmsx4Qb/LpR0iFpgKAAMFWf+u/Toi5txBbBn1BsJ?=
 =?us-ascii?Q?jiWmGw/Fxzplp9UZhT4wTBEynvopkGljHYt5xPKz6m/LTAT0dQ8Z0PCfOeOV?=
 =?us-ascii?Q?BUQa0jwDzx5CAn/h2ec5urQrQlcnytwjcCGEpDs9yoC+bgTmdMM2/fjYJmWM?=
 =?us-ascii?Q?AjoCZdYJf4/PXtjaBdqM7Lz9ZabI3H3/hLex75AW/Mh3KEhgAzrhV12ATBlm?=
 =?us-ascii?Q?Lc3UUy3iMeh9ukyFucTQ9HLNzYBjZ5QCct6FcegmneyLGnCnpeur+TaCT9Zv?=
 =?us-ascii?Q?F6jRUKXUeSkNkwdajuYuZIYb6wv//KF7qABu3lWGEvQwLi3z9FbV0hx/winr?=
 =?us-ascii?Q?CFnvWbzub6/Zy7kadoFpYakjpLlXbWdCxHL7lrUGt3VkyqOgKe/XWXlyeOg7?=
 =?us-ascii?Q?UENO8oYnbYcgehpcij4v2uMhxetN3KU6R00VuuwUr7GmjQf8e2EJbQN1NYOO?=
 =?us-ascii?Q?YoDQ3wjrO0FQOHav60T5qfGGHVwmIIo9rn9Q/46yU3P6WQ+Gfb5qnIK9QJrZ?=
 =?us-ascii?Q?H06eS+txjsjB2UoMmX2lmhtgVUqPn24=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d21bb9e1-9c33-496c-7e00-08da31cc333c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:57:13.2631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfujXCzd0q/Y7w4iw0CcWI95kczfmQRmPsVYY/Oofl654e3y5sbo8mKAuhuKWFj2RGyUnWgdvY2lSfhTOwdP/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8107

This patch implements the round-robin BPF MPTCP scheduler, named bpf_rr,
which always picks the next available subflow to send data. If no such
next subflow available, picks the first one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  6 +++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 47 +++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index 7ecd0b14666a..2d5109f459b4 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -29,10 +29,16 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
+	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	struct mptcp_sched_ops *sched;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
+struct mptcp_subflow_context {
+	__u32	token;
+	struct	sock *tcp_sock;	    /* tcp sk backpointer */
+} __attribute__((preserve_access_index));
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testi=
ng/selftests/bpf/progs/mptcp_bpf_rr.c
new file mode 100644
index 000000000000..2604e0783067
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_mptcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("struct_ops/mptcp_sched_rr_init")
+void BPF_PROG(mptcp_sched_rr_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_rr_release")
+void BPF_PROG(mptcp_sched_rr_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
+		    bool reinject, struct mptcp_sched_data *data)
+{
+	struct sock *ssk =3D data->contexts[0]->tcp_sock;
+
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!msk->last_snd || !data->contexts[i])
+			break;
+
+		if (data->contexts[i]->tcp_sock =3D=3D msk->last_snd) {
+			if (i + 1 =3D=3D MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
+				break;
+
+			ssk =3D data->contexts[i + 1]->tcp_sock;
+			break;
+		}
+	}
+
+	data->sock =3D ssk;
+	data->call_again =3D 0;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops rr =3D {
+	.init		=3D (void *)mptcp_sched_rr_init,
+	.release	=3D (void *)mptcp_sched_rr_release,
+	.get_subflow	=3D (void *)bpf_rr_get_subflow,
+	.name		=3D "bpf_rr",
+};
--=20
2.34.1

