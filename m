Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5AD1365
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 14:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651243916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E7CKLpcNGxZqrshvpYp3iihWeuSQUakFE/T5ixnAswU=;
	b=bHJPHVNsBWFug869ux115Vtg704cW6eUczlGmA0x3C4KJu6URRd7y/ApwbakhpITaRB6Hh
	lIYN20e1KlQELDyS1iHPnOcAj+WFCd0cs0TFJTi1JczCdcn584m31z3P4048T8iN2iS3xC
	n8Jw7b2u+BUmrG5fDSA3wUDfouloEVc=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2058.outbound.protection.outlook.com [104.47.8.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-u5DngwASOxCVSTo57A7XWA-1; Fri, 29 Apr 2022 16:51:55 +0200
X-MC-Unique: u5DngwASOxCVSTo57A7XWA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzYXVudi2ZPla0TeMGBUyiWVs2r6Ceyo77TsAYlxvcF6vCOy8BBa/sBJiH3n+JK4MpZ/9dERmr8Q9btD44JtefD5yCzdCuO/nwsZmUTO54IvaXmSp+uAUchyH3R/rtJgoaWx4amtMSokwCWXIRxWLY7C7Rwg8jI/mWHNrrUW79BWOqo9pajFwCh/otPlSyylDChQmb18f0YHn3tCsS8ydJ2f2Vlquk5R8F6QhZs8tNpo2N+3KapNCullqvkMjoKozvNTTzzdPEhwgC6HXyoCAZkV9nEdn/saPz+3utQP37gLXybdokGzqXaCKdxoauH3dNkDmdB1jzNW1aPcxx5KiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhEgXaAaCVxk/YoPOHUxBUUR5mh4YSiaticfXEVWVJo=;
 b=RLIANQS10A6C80BsWcmPBN50TYjYs1VjoaLfuBi6r3kBW7ezCrr/rW40yS3IhSCS0LfKSJJmceRKNQAE2Vz7kjMw4dEbKJzkecByKju8Cw24E5MJwE+e8Dnbtr8XHnNJBQSYml+umvqXqbjnLqPmx/WM1PqViqFPk3NwoIeoYOGHR5nYqNbHpFO/MDOJsaaAjH4lrhMa1eaq8Khbi8xdfsMI4tak4dWDt621SleT22w1cYBF1YuAhP0UWHE+vBCTy3p1XVzHWT6MTSlQ+mIwJHgCdl2GkjGyKFUlolsby0yM7E1vB6F9h8zNdG0LG7VlVRK0tQH5LLdrdmM5LddAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7238.eurprd04.prod.outlook.com (2603:10a6:10:1aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Fri, 29 Apr
 2022 14:51:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.025; Fri, 29 Apr 2022
 14:51:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 2/3] selftests: bpf: add bpf_rr scheduler
Date: Fri, 29 Apr 2022 22:51:58 +0800
Message-ID: <1d2ecaada853df447dcfa6c8fabcf7bec5576278.1651243739.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651243739.git.geliang.tang@suse.com>
References: <cover.1651243739.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3685db0-5613-412f-f1ee-08da29efccf3
X-MS-TrafficTypeDiagnostic: DBAPR04MB7238:EE_
X-Microsoft-Antispam-PRVS:
	<DBAPR04MB7238E917E16F295F9C4E63D0F8FC9@DBAPR04MB7238.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uROslth1grngLfoUKlH6/Y9IWPY5eobcWDCyxc0L5kz+vCKzxBeDNq+YjefBGZkxmH+s97a82nNiXnAA5r2K+guGiDSsiWzQ3VDA2xsTwr0kMck0a5YTyidGHFvXQvh7u9qy/QxcKM1Kbj1HuCiUP3GGl5zJMS2MInnVIvS1tIpZ3LgHNH7uNB0cq8yVhfg63aP+soo7SradkaGB37UtvBji4oVIlaIV/u3vNxl7nP/sCRGpgiUBcEHEJoNr0chb14fXsS+dCja5zwBc9byI5w4EJscXlnvd4lxXNBaVwqFkxSC0nhgVwB2+bjI2Gt5MFfZHkvozdOwilUdT4956ZGTWINHlSS//k5QzKZOJXGZIJ6iL2eC8kMhpHqgjKjudH8cr+HbF3BbsQOhcwieYFS70mLg6UP2sm1D8mWAlrVJ/3D9QjAlY9onVzEx+zmiJagZLfvo7DA82TaToK2Ph21dvxmtpQXYfAu7K3Czj7p9cK43RB1dyteSEsXNT4xv+UhEni62X/EoCQGgClLo7ad6Rb6f7/HGMfIKvQOmTye/vIZPDKyBsbahd8UtV3bIfWcAeSss/Al5ZMD++L0H5L7PYhKcjH08brxounTEzlAoi0gvQZM3qFMuTC2/coh5s4SfdzrWgGR8/nQclt1pWAfJtLwu+oDLfra6lQRpKW/nz+8A3+enCqWQHHPh2OsPDay7WjmjV6x/Uu04cmZyB9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(66556008)(66476007)(4326008)(2906002)(508600001)(8676002)(6916009)(38100700002)(66946007)(6486002)(86362001)(26005)(2616005)(6512007)(8936002)(44832011)(6506007)(5660300002)(83380400001)(186003)(36756003)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JDHuomImGfm9rlYTeuOdeA01NTFsHADIdnDfC3kupSTxS1ZOUbGvnWTyLoAw?=
 =?us-ascii?Q?lgUBzc7VS6J+4si3E3HjmfHMQiQnDfo72J/Uk6bZt48TjoGv2QTR92A2arAU?=
 =?us-ascii?Q?hEP8dXfn/CaLAd2+ven7Rg5jtt6XVSasrCTDbn7SfBsErQP7UDBu4NhUAJc8?=
 =?us-ascii?Q?Jh7sgUJesfIxvrbJ/mjQA9rYPb9P2orDMKbb4OpxrKDMpfWuDG6eRoq7o64a?=
 =?us-ascii?Q?SYDH2N7bnVAIHnhoTA1uTketV7ZSSMVOMZWcWiwM7fLhc9OikAw8aVHvZj0l?=
 =?us-ascii?Q?mKtYJ/yIGUkKddfzOrNtusHmhr8ezueslDblSRABl8jR8AA3ezrKlxk5KGQp?=
 =?us-ascii?Q?0JA9nD8DP9cO0azK1L0cWZGp8oiOfhtAftMp8xR/pkn2DFAxvXl4CLi7LMOP?=
 =?us-ascii?Q?0fkht/iX1JpBFlpukZQeT7+0YIVxj1eYrvLidz4rMBel5ExDw2PuditGE3DO?=
 =?us-ascii?Q?LUGJjoSE70dwOBiTJe/J2ZtBbBCabUxP1qV34wZ2N4WqK+VWoVAcX4ZC9mhy?=
 =?us-ascii?Q?qY7MkqgoKSK819DH/bVtPS4yY2GFO4oOfRycGRAkww7UP7OqyN7KC2/xuI3f?=
 =?us-ascii?Q?wxrnODIiaEbE5kSBc/YxtH8by72s20hNzFFnp+GzTVIXFbqziEvFmt0ESdyb?=
 =?us-ascii?Q?CPErmYbg7GxxXOzOjLA0qK+MwbQ9QLWTpLtBAt+dtfSjm/g8h7DiANRwKmV7?=
 =?us-ascii?Q?C3V7+q/+G3XooM7NQqCnve2gcMFoKtb1VKJ/1e4t4FhVpUdPrQA6U792XxDt?=
 =?us-ascii?Q?15Trrp7dYV6+DvQ8Ld5RnEcD3A0iUJWzMs9cRqDl29/jlQbvDZ21e6PbKTYd?=
 =?us-ascii?Q?y6NddmjgQ+V9HtGGklFoDAs3wrOrpj6yafKrsm+JFklqWMX0xrtHGu1HkQk4?=
 =?us-ascii?Q?FG6FJghW+W5MgKhNvLJPLEke0pNwuj4mWzUHFkeo/VEq9cKh5Bzsc1JJcFVr?=
 =?us-ascii?Q?A97DvTMolPmQW0hIv7fsjPm6Son06UYJh0gVjEwGV6lmA1O0kWoaiza40Eiy?=
 =?us-ascii?Q?KJRopB7LuswDegtxQPVadi/d8+tnDuJ3/on/cm6qWmgVFadOog8UDoLjQSR9?=
 =?us-ascii?Q?0/OBYaCjQtrHrQyAG2x0Pbw51cJ8MSz3FJhBxvdwzYy00wdJaagI4UlCPH6A?=
 =?us-ascii?Q?gx2keCTqSB5+yg3gBAHwEwaLSTF3o5vpkEvZyrOUcOIeZrOIAE0e5hy/i33z?=
 =?us-ascii?Q?lI9ePAjf9oO/TnUYOjxS+bmb/YM6E+Zp/H6b7EESsndiptYYPha6myXQ0hyO?=
 =?us-ascii?Q?VJdeXSt73W4/PxIpcUZBg03a4MbWrjtDCntlhechKvm/Aqi6q+krGO5rzC00?=
 =?us-ascii?Q?tR+HuJwAOLNK8PGGiJ3IpSjNHnBgT8Y6QbU7uW2PO0pQe0RYjEK48Vnsaft/?=
 =?us-ascii?Q?0AtuR+PlIHoOEZyhKYu5IQbXvLoDP28/7qn4pnSrlnlpXgNbJmFXIG2UA6s9?=
 =?us-ascii?Q?RiEuYSDcyqQuBoFR1SEXvshZkNVMVu5xBdpetn68OYA7sBhl9wXMmjdgG2qY?=
 =?us-ascii?Q?gLhWsBgu0Up9KtQvnIpjfEnKvTJ4NObZAJ4SlB68KkahbFE2NbvOrH/7cF2t?=
 =?us-ascii?Q?0Mi1dWx+YYrzRPTT+KbadriZ6yCW1cn7TWNXhrpB9AY9GOmb7g6aUaH0fR81?=
 =?us-ascii?Q?8zZatW2+2W0YwgI2CoNi/6Glha3JRuxjkUDkjyVTkCr9G0KXwxRKRjLRYJxc?=
 =?us-ascii?Q?I+APfbR0nPKie06bVcvjWbqynh7z88Ho46kdyJ2+in0uRdbIreHBCvzNhl4c?=
 =?us-ascii?Q?75v9pZfS++LHVzWoz23NR4sY0F2qrqs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3685db0-5613-412f-f1ee-08da29efccf3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 14:51:54.1933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7OryeSGP/bvbYdyItuNvmd0mXnOPI9s/GWDuC9nh1BwRK9qrsAultU1opA+TY1V65sk5OowfLiu0xXVNYHf9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7238

This patch implements the round-robin BPF MPTCP scheduler, named bpf_rr,
which always picks the next available subflow to send data. If no such
next subflow available, picks the first one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  5 ++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 49 +++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index 1fe3d0a97429..8ce5b1603962 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -37,4 +37,9 @@ struct mptcp_sock {
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
index 000000000000..2f31de4cfc84
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include <linux/stddef.h>
+#include <linux/tcp.h>
+#include "bpf_mptcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("struct_ops/mptcp_sched_rr_init")
+void BPF_PROG(mptcp_sched_rr_init, struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_rr_release")
+void BPF_PROG(mptcp_sched_rr_release, struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk,
+		    bool reinject, struct mptcp_sched_data *data)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk =3D msk->first;
+
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (i >=3D data->subflows)
+			break;
+
+		subflow =3D data->array[i];
+		if (subflow->tcp_sock !=3D msk->last_snd) {
+			ssk =3D subflow->tcp_sock;
+			break;
+		}
+	}
+
+	msk->last_snd =3D ssk;
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

