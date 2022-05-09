Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30131FA0
	for <mptcp@lists.linux.dev>; Mon,  9 May 2022 15:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652108501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PNmkGlg+6hr+3FqLH3HzZX0Cg1KYLfhuHq8SnIIrAcM=;
	b=T46H+jYZ72UFcqd9CLzPxMk/7taRGVHZCTDRUf697xagsbPEp3gMBMPtlXOjWIFccKP2NI
	cnSGqp9uoy+99ohmBpIXRKibJpj9OY00ALm2JRsJem03IMxYscqwUE3Kefrry7u+5voTtB
	tYN8MtQBat1U7G7oOdVI6aB+OG3pDlI=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-zYJMrnZYMFWxcDC_FGyv7Q-1; Mon, 09 May 2022 17:01:37 +0200
X-MC-Unique: zYJMrnZYMFWxcDC_FGyv7Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5y0z4Fi8A+0/D26dKlAzuVDY4C2GsPXClZIGAG/AFoNdEM2XF/7M9lH7Ssoy+nXt6dwYe3Tm1iHGWcsHcRFWhgTMVJU0QNOoBEFh1DYjrbSjGdkMYHoyT2Nl+3ogKZ68BWHkHwcj09+8AVz2yA3Xegm1Yta4jdycvozDFDWY++j38j0h7qhQdMM6aFse0Rm46n2KdW0iBqa7XJx+aWKlJwLDaKqoLub4bfTQc2sE76bTTLQlRdU4CyYk4UcH0xoXo/zK/zdxitqswoppBMfexCk5HYwWqd8BHoVTxeFCftr/2mt/ZuNbSDVzdW8JDcKzcfGqdOjLaeVKDe7KJRGXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vvpofmtt3DZd3EotYYyUSg4dPxSMWEYswF+MK0Gh5PI=;
 b=J2PHDfxe22OrHoy2jY4kpJS9pMNYw3JqZWDkezIqE0gYCknBH5jDTVP0aWzuwZtxamQdEHQ8OwRu15JXou17kPG9Hi0h2D0wRDovcXInxYOmGg7juVpsRC1Dx++7KA2s+Z66ebbE++v5hPkr5xN86f7PmlWc7Owasyl2/YJWUJ2dWE4ZFOH9z+C2dYSER457BWW+xLymh7HVt4bTzQOkCYKIlOmtRBv47Cw638XtkX/LY9IvgfeHsW6w9Uo41cnyhlQFgeHgeO6vwLjYp3rNkmSLxUDZ1O3fVDJcM1wM007x8U8LKtuhvBnABnbauG1CjIM606zxIefT9++3kVCN8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3924.eurprd04.prod.outlook.com (2603:10a6:208:7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.28; Mon, 9 May
 2022 15:01:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5227.022; Mon, 9 May 2022
 15:01:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/4] selftests/bpf: add bpf_red scheduler
Date: Mon,  9 May 2022 23:01:09 +0800
Message-ID: <bbe04c9dbcf975025680d638d4b5bdc72aa5db7e.1652108279.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652108279.git.geliang.tang@suse.com>
References: <cover.1652108279.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0047.apcprd03.prod.outlook.com
 (2603:1096:202:17::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c14ffcb3-2514-4615-3256-08da31ccd00a
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3924:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB39245AA331E773C89375F79BF8C69@AM0PR0402MB3924.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q68qMfTyETkRfxIgooEmt/taDJlWRWj1TwRsafrifzIcvrZBaP/7sbzqawCmMG25P06VLY4iss2PJXInFpLaSaOJPxArIPs7NbNw+RNSpBBRrkfczQLYP6Nqbnm2bFUg62ObWCDOP/jzozMaRTNJYEUyjQPopWlLigy2jkk/RpkBpxB091yYFzqzuaivTusw4dySxU7e4lgb/ue8XhaLK6/mp+q136zeWuLZRi+pYsckB3XghnrKIaVeHdC37wh4jd7SrNMkl1ahEU+qSKujx2T1qcozjeGFC/szaPzu0TCo25+zl0ZeFLY+KeqDBxrliaxvKMVxHPq2W6PrDmU9Eld2ISSm/VMwF2H7qvX22QL/b+QJI7HCNabhvkCkg6wok4O5WBEvsDz0mgHEqQoyTmAxOg7e2mCtjdabIkQya3BvNQzvO5NHu4qZ+ELpiUnoFSmSb8wzNi0poxioZJXooqv9/9Rb/pB7dWBD9Fuw4FnMmP5M+WAvxkw6pygtcUBwXmeNvXorxDM1x28AqpcSxH53n/nAjMyuPXBDoTIPXYpcY7NtghDVtOus/CaeC+a/XY42GITFCW1fl4ySO9yo194snVNXmNpl6yJr5Gg1ewhGZj4KpTXHiJIOfh3mvr6K5AIkBE41ztA4kMVvbnOLAdlLV8LzNoiy7/R5p5IaK2Ticpd4RgCLG/+4da5Ernqc9lq1J91gaGUKIk1ux4ERFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(6916009)(2616005)(86362001)(107886003)(316002)(66946007)(8676002)(4326008)(186003)(44832011)(36756003)(66476007)(8936002)(38100700002)(6666004)(5660300002)(6486002)(508600001)(26005)(6512007)(6506007)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jn32/HBwEotsXwN2wobRYdBQ5XGK0zRWlgdcQar2C6RS2r7rhsp+G279QZBD?=
 =?us-ascii?Q?9Yqb+1HMaAwrYAa9Ghg8+9wV1TonXdERokmVLYfn+BDn14qw2gRgbUUt2lfh?=
 =?us-ascii?Q?9zCYTJgYNjGO4EDXrr62nkMLX2MuLxxLITmENzLN/E1pSXVetIskCL5BwOWD?=
 =?us-ascii?Q?4ITcSeLI5pS6asrCCSePPuzmi0xgmJVOZ693B6wj3hl2QXNOTpVfn7jgZWSH?=
 =?us-ascii?Q?AAO8ayhdRQkuiKMDpyv1VcQU21mVIaWfN54PyCUsfa7yHGmQ/LUZ+sYcOGMi?=
 =?us-ascii?Q?EcCtauuNtOjTqqKr+qAnYvWtopBQps5t+t3FdSpk8Zs5n6DMMW0YAgvUUjEs?=
 =?us-ascii?Q?aMEyiFnNa3Es95+b7xLDNxqh/vcz3h9F4gHMtIZuWodLfYeMHA6JxNxuA01A?=
 =?us-ascii?Q?ovxYZGAV5MSAAunGL/iphvmmdRUADCTokjou5OoQcmhc6anXPkLzZowYRMFx?=
 =?us-ascii?Q?AMuoYjA+BFhTVV7Fm6+C5EuuzRwN+Q7BSQMSN8oKanxcXDgEHOL79QqPDAQe?=
 =?us-ascii?Q?Tta4NPBKWvyw/NAFQm83iXbwH/8Ci850te5Gr4uWZAJKmNimk3tjRF9v+g1m?=
 =?us-ascii?Q?RYX4Fojdoec+j73O4PcW4UgRUyPAryM29xMG73TKgcM70X54dze4Id/6xpHt?=
 =?us-ascii?Q?o45MJybud1ToYWPmBkQGlUDuvcJKyRPHFPVPA3nL1NIsgQy+GnXqPfPz8XnZ?=
 =?us-ascii?Q?QktkpBSfrIq7TYx24Q6Eg6qDRGqx64BG6FaMNGhaWASzfEztYeHPaK1h5z7r?=
 =?us-ascii?Q?H39TRPpoadbtoAmItCSSFX0uahUJDjsbPC4QRyCXSqv9GrYFc7R0fpfxqj5H?=
 =?us-ascii?Q?GIbSJ6YLiH5IreW54JFiPCKVoYxA4PTu/elAyQvcBOifFUaUhjhhuxW1g5ix?=
 =?us-ascii?Q?anvL5feB2P+53wiXyD43/MSYmEHXt1fe4I67/OZvr49sx32nI08ZkCeHRObG?=
 =?us-ascii?Q?eczR1dA30O5lhX9QRwy1z9QpijCFCNk/90ptp1d4BBih2AM7P8YaWYxzCowa?=
 =?us-ascii?Q?0e7YuScp64Li1/6LQNpvRJjvrtl9jvGVSous0zrUBAwzep5AGV6AKHpIn0eW?=
 =?us-ascii?Q?pWuc2E8i/NuU/1U8EsIChOWk0whLfrX00aiRXv3MLzlwo7ig5BgrNjiIIuYi?=
 =?us-ascii?Q?IcwHFN0QhRmjr1D68xgRX1iC5AHNTqCDseA0WyyGckJS5MzXhCXsiflA0s2J?=
 =?us-ascii?Q?RgUVZl76GHzAKcDdeYtcksdTV44r9bJJmJtV57GGxvy2Gqh914CV97NyvJ8b?=
 =?us-ascii?Q?yymwdYiSul7cSr0uwwmspI5rZPKBnQNBjlOis5i7JSqo18P4qgboquZgyv3p?=
 =?us-ascii?Q?7eDYIYXbrXl/kVn1klvJ5QtJQe4DqihlgBITtkMipHXLBci3tiTEmvINIs7G?=
 =?us-ascii?Q?Gfpl28JwH49RlHyqJGwtl+L6hta8Fh4bQq8a+zV7DFn/R4Q6cmw3990TfzHV?=
 =?us-ascii?Q?FZ+V9jbeQ/6ncvtxbCfzJwHUhLWk4xBNVkZN88oAbiCNKq6GUKC1x8+5mG9a?=
 =?us-ascii?Q?VfCf1O1+4MKOH53dwHuL+ecUiZ+MZ80rTv6XjKAeTAncBJzC7mt60O1G2gsN?=
 =?us-ascii?Q?XzoWsFHs/2/q68uEgTZgMI6JX7ztxvM4DDqESjkw9tIJbiX6JGTmeccrJzjd?=
 =?us-ascii?Q?DtsKSRmeFGHcB71+PoAgMUnHc9U3HghHUqeb+3kIP89if9emkyucPhhoP5Vc?=
 =?us-ascii?Q?ETNnz83jWBGl+hxkX87shdEQaz2TppJi5xmMvBv/a6VqOOlWL4qLTqcIFPLB?=
 =?us-ascii?Q?Xir0keKlUH/VSWcqtU19HzBgPaN0Upw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14ffcb3-2514-4615-3256-08da31ccd00a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 15:01:36.2889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vNf0pDjm9Py0Jb+f8xHAhyrpczARb78qq0NAAWmKoY4bqLF32/cy/UYIZ6QnlQ2AxpXRG42DY/0k9SBRySl8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3924

This patch implements the redundant BPF MPTCP scheduler, named bpf_red,
which sends all packets redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  1 +
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 52 +++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index 2d5109f459b4..9004947ee4e4 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -12,6 +12,7 @@
 struct mptcp_sched_data {
 	struct sock	*sock;
 	bool		call_again;
+	__u8		subflows;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/test=
ing/selftests/bpf/progs/mptcp_bpf_red.c
new file mode 100644
index 000000000000..74c928e8154f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_mptcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+char fmt[] =3D "ssk=3D%p call_again=3D%u";
+
+SEC("struct_ops/mptcp_sched_red_init")
+void BPF_PROG(mptcp_sched_red_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_red_release")
+void BPF_PROG(mptcp_sched_red_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_red_get_subflow, const struct mptcp_sock *msk,
+		    bool reinject, struct mptcp_sched_data *data)
+{
+	struct sock *ssk =3D data->contexts[0]->tcp_sock;
+	int i;
+
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
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
+	if (i < data->subflows - 1)
+		data->call_again =3D 1;
+	else
+		data->call_again =3D 0;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops red =3D {
+	.init		=3D (void *)mptcp_sched_red_init,
+	.release	=3D (void *)mptcp_sched_red_release,
+	.get_subflow	=3D (void *)bpf_red_get_subflow,
+	.name		=3D "bpf_red",
+};
--=20
2.34.1

