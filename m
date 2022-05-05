Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46436D
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 04:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651724834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAOcRHBZSD3mIP8jzONRIcRhQktjxIa6D2q6pe75Fu4=;
	b=Jx79dXMrxa4Y1rA1QiHuy/0xKplUNkTrUrIuN64SGaCF142cHBSZ+rShDIvpmz8Qvz0hR1
	FGgkAV6RFnWl+dvZBvbQNh7ysqNzdTvnNFXuEHZM9MYPFmmWof5TZb7850V7H4K2gDTF9C
	9wAUXrJnDNY/BZTIlIvq3CF6XcZD3lM=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-UEv_cawQOkeNR48B5doJ_A-1; Thu, 05 May 2022 06:27:13 +0200
X-MC-Unique: UEv_cawQOkeNR48B5doJ_A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZS0JbN89KbfaJS1tj5eift7thF4IpuBLEy0bbKJf6vQnQ4Oi7705VIHicxTMQ639ieMaEf1gR5HCMbuyjbwXlY++JVrZ96FsGv7wVg7d/hLCDp7YDc2R3g4hVXq6VAiE+vt9ROIDfUndsdHbdVl2BoMSJQ2v80x7Tgdj6ivGKaIKR/Cmcv+Qn3ARt9DcKa0+VurrS4P2aVGVB23CneCu/M+xSonDKqNX7ANe9CvmcpMOJu4gBPOhxGGWpK3nllxLYU4k/cDNxamAKyN3OxZNxIcsoGv110c9pz0RfZZleTHLw0OLewKsVHOO+GUJvKlrMoLAdRfZRDcGgXza4zNtJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPjGpUakFCHz9R6BAcFh42FQD/PR+k4t3tmFfXHrJG4=;
 b=deQKxquWCA83ur2ftcVxVHErtskFcervN/uRA5Zeytg11BMTbx+LtVT+uaL/OA3+qaBFC7f8328UA9sDTb1/1aPa0j3ZMwdlgiz63Rwy13oa6INty916V5kt5LkcrKpD3GRxSSyJsBIFsgY6oKV+we6BTagsqg3l+urd4lBfSx/kDguxUBekOiws6uI/kVQUUXnuZtC8z5MHv7V4AAks3Q+ARh5zVlymZHFL5rVB0YCUf9KjffhndONv9sDDL7hYn/qFOAekNCQh8PRT/oGJQFYQOqZ8pV1YvHaRy7VYEbC1MG0ZjgflqxSjfFjq0CpfzArjpi12d+SgfpNQxUEjHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7861.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 04:27:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 04:27:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 1/3] mptcp: add subflows array in sched data
Date: Thu,  5 May 2022 12:26:57 +0800
Message-ID: <8fcc28cd2913c480e9181780ebc6a4b53ac93fca.1651724418.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651724418.git.geliang.tang@suse.com>
References: <cover.1651724418.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:202:17::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c7d6797-c43f-4d55-5139-08da2e4f862f
X-MS-TrafficTypeDiagnostic: AS8PR04MB7861:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB7861F4D666F144B5C4C31455F8C29@AS8PR04MB7861.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rgs0Lxz+YBtn7ywHfL2iIPGpPuVKDI8SPJ/KbkSqujjGT0bioO1mJVVyWmZbmdaiBOf9V6Uzz9vn6J8otOPOaqHrg5wbt3qCPPS+9NSlF6BWbPSRl3XsgVC/HMXZ673utjidTOJBicu1ui/O3F0A7PqaaXaBK/2OWAGx8+V+MNkQtKgGYFeAhbjuQxV/7OM57plGNE3MmRk32j4rw1rG3aQhKo5R+AFmxSzNEDUZsWRFvKk6tXnrOyMiB1stenqxfxFsVz61ZBPyXrmObV995Y2+GWBQ8717FJOxZlKedrF2Fz/+AZxrSDpHWjgiNQy9cS52wx4WD/9dNs5qvtk0MIK3R6oH2fCuO/+2Q4uvf9FSzHyNoUxrGZFStvlm59U+pJ5accrvUT1OLXqeXN8svaI74r9lZGext4mm6wY9S0evXAQFK/STJufyOaAREIgMyIFIIokw/zZnkzxeKWEC4PG3KQrRMnKaPOSjL1+cnwUaM0n57SA/9vnnS4d7rNxLVEzrp7BO2QUn4mT7KfDtdra8aM6yJXJnU+Lz7t40nPDYP3+HRjRUnP/Fh2xb0DyuZ3kMKo9PSNWtVD5xL4NbRLz2rTDeeWKE+S58nkeKvOIrTiT6D4erPB62CojMuIj/dc9CDcS0GqESv2hA5gwmLhHx/y9pYbbNDisftswxYCQXDEUv4UsvzDYZ8fWoMUTP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6512007)(6506007)(26005)(86362001)(508600001)(38100700002)(8936002)(6486002)(36756003)(6666004)(44832011)(5660300002)(4326008)(66946007)(66556008)(66476007)(107886003)(8676002)(316002)(186003)(6916009)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nH9QnU6iNeYtvu1v6HO/rjTXA+nqch9qrs9cc0ENejGCEYHvRn3jUJrUmJ/H?=
 =?us-ascii?Q?WGLi3BdGAgzaYwiL537pZYngWXE6NeYKQpMQY3iLFZVRqQttrZF2XVoA5ViF?=
 =?us-ascii?Q?tQMHKLsykCfkKlEinzRYoivnrzRMJkyRAeFaqyH7WK5m4QCyn6LOigqtE7K0?=
 =?us-ascii?Q?yBdQu9XVwueEGrWnnEQpDaF+HOeNuUuOqgRiSGyCa+dexw7yKezAHPMaYvE3?=
 =?us-ascii?Q?G41zVaZBuGzLdHU2Lo30QCEYXTO1DTrQbE2N7Sntj3nWv0NKRRFE2QYFNBAg?=
 =?us-ascii?Q?BotOTrFpKnFjgpZxrwcek5THQGmtb1zhPiDGnMeMr2O/8G0WjZ6Gv4xKU1Va?=
 =?us-ascii?Q?/6eL5GeyL4jB46tbceqra3eenCSDXmhacEbbu08SjN/o+TcI7Sb6CddbJuAk?=
 =?us-ascii?Q?Z33Q7cCmU/dnqJ92FB69es/GUYKNXJ09+VU/fb+Hq11+7GHNLV6Ki1uYt8ao?=
 =?us-ascii?Q?4Fb0GjpjzjnbwXT6z8DzvFGiEUZuXElWp4lnjdNgckqjzQ9pLILXNEdpzQfB?=
 =?us-ascii?Q?DjUf+zd6mu9433/VIfPPOXDHfRkl2KnTVxwzYkfBBgxxVTCta6ejnxLFwZTI?=
 =?us-ascii?Q?S9XQ3fmTNj/UasO/0qnYJ4ZCs5LMjAhYRO1IO72h/YZ68kfJj2KOj4fR/u7T?=
 =?us-ascii?Q?dNfEU+CpgnR4UsUpPoZXk4UWyOFI99iqJqBkTdEBxFuKvgTpfy8WcsDRAxcL?=
 =?us-ascii?Q?lXZ1BNHHwpkO8AGpzcfelnJSGT+Yw3KZNk53m3REKjGM+tSy4ji7QBK0h16j?=
 =?us-ascii?Q?hmLajI7Sn0gODOaQmXgwcz5pWal5YLEbdEUhtTit3cZTjmr5ZVrQWa+7zpKL?=
 =?us-ascii?Q?pZrIzHifLBz/6k8skuBfT8dUSS27lgXNKLzc9vYXNF2mZ97SeKpSuvU7TOPr?=
 =?us-ascii?Q?e0bzOvh51eyNoRNfo0DX5rLDjIJIx0VCCJ9KsSLW8hYWX7kjQpvviWMS6JbO?=
 =?us-ascii?Q?sSIeTS0cvGqOYv6FUfuzs2Z+MyNFqeBcofUbMdFueqAChxYbfib5TRHfilE8?=
 =?us-ascii?Q?i0ky5rKtC+UFNGKgXaTjdNM7isKKTVEab8Vsy7ScVbCW/2y9bCtf3kKsIBqk?=
 =?us-ascii?Q?QC0IZ7Q3b4XVCaugUT1X5AOZvl7XN5q7QKVdnfqUM8SC+xy5Tt0M1rCEiqjO?=
 =?us-ascii?Q?+drK8hHZXklhYXVJsxmJsGof1WJP5+InS7AT/3FRBlgwJuQlnDCYpgBF9zhi?=
 =?us-ascii?Q?mWq1e3HR1cJYqAg8yxfvDHC80DmAmtxXMOlLqOGwxDGXLaentPwz5n7Q+N4O?=
 =?us-ascii?Q?2DGUUZV24WPAoIEgNgdCI861H+xY6zQJlqsvrx0kod7noWIh8qlYKGxyiDcR?=
 =?us-ascii?Q?re7sooRYF+BmAYxoCAeZJ4/uubuQifAoUY1FA07t30FQeTlV9BOYbSr0GVn6?=
 =?us-ascii?Q?Sz/6WOosL0+9DE8XJ/GZdGuOboI/YIu4l+OA0n/MqciP05S8E5+91c3SD63i?=
 =?us-ascii?Q?zVwPW0zJbqQkVsb5L3wh8SHzylFRZY556FBUbLmmcxevlXXvOVhB8Be/bXi1?=
 =?us-ascii?Q?qtmLmfAz0R4InXGCvNZfiRm98gINd8Sr6Jay3ca4dXiN/WY/jFaLKiybqLCX?=
 =?us-ascii?Q?o4uAu9/8N981wHTuYvEGhy7Ls5n7JwVzONx7kF7RJtARbTQ7JpnyeVKue/eH?=
 =?us-ascii?Q?rptaF7Kt8uuTHs2PzbS2Ql3BEBjeAh2FC/xJwcigrMxCLbfFVpbSNXwI3Fek?=
 =?us-ascii?Q?VsyEVJy/MLZ/1+J/BuDEslm7oOL/Mwtc7qA0XwF70Tp/tfPHD6L85KCPu/BE?=
 =?us-ascii?Q?hZe/HufkUDHcspYUGIcZY7GArP/jwks=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7d6797-c43f-4d55-5139-08da2e4f862f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 04:27:11.7857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wS92LRbaG2fN9P/nvfHoUe7j5ATsf5fbcsd0U1ScNzy+qd0d3ZVMStkxbnJL4uovHBEiIcHie9l9HgydmZ4vqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7861

This patch adds a subflow pointers array in struct mptcp_sched_data. Set
the array before invoking get_subflow(), then get it in get_subflow() in
the BPF contexts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                             |  2 ++
 net/mptcp/sched.c                               | 14 ++++++++++++++
 tools/testing/selftests/bpf/bpf_mptcp_helpers.h |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index b596ba7a8494..345f27a68eaa 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -96,10 +96,12 @@ struct mptcp_out_options {
 };
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
=20
 struct mptcp_sched_data {
 	struct sock	*sock;
 	bool		call_again;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 3ceb721e6489..9ee2d30a6f19 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -91,9 +91,23 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 static int mptcp_sched_data_init(struct mptcp_sock *msk,
 				 struct mptcp_sched_data *data)
 {
+	struct mptcp_subflow_context *subflow;
+	int i =3D 0;
+
 	data->sock =3D NULL;
 	data->call_again =3D 0;
=20
+	mptcp_for_each_subflow(msk, subflow) {
+		if (i =3D=3D MPTCP_SUBFLOWS_MAX) {
+			pr_warn_once("too many subflows");
+			break;
+		}
+		data->contexts[i++] =3D subflow;
+	}
+
+	for (; i < MPTCP_SUBFLOWS_MAX; i++)
+		data->contexts[i++] =3D NULL;
+
 	return 0;
 }
=20
diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index 4b7812c335fc..7ecd0b14666a 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -7,10 +7,12 @@
 #include "bpf_tcp_helpers.h"
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
=20
 struct mptcp_sched_data {
 	struct sock	*sock;
 	bool		call_again;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
--=20
2.34.1

