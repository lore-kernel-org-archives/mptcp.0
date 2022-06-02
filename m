Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2702C622
	for <mptcp@lists.linux.dev>; Thu,  2 Jun 2022 04:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654145728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m5kITzgRuokeQUPx+b8grfhOM1DFlPS2VGHl1t/7g4Y=;
	b=EOyQ/DF1kaRHwnQ/WUKwYNHQqS86Y8oD2j7JWWrHbAffFfJb7xlc5Jd4b/G/XKQ3+RLOxl
	eOyN3ZxSahqsYE/4RSlTtglJEQrYpBtzEQtIZFojAYAs5vDUTVA1AYDoAe8zTS7UsF4Lkt
	w6Fq+GuukB+U2HVpuIVpYLST2ysYyP0=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2054.outbound.protection.outlook.com [104.47.5.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-lYaTU1PNOCeB90JRxYGYzQ-1; Thu, 02 Jun 2022 06:55:27 +0200
X-MC-Unique: lYaTU1PNOCeB90JRxYGYzQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=il/yHWltdzr03EQ+tdoryEwN5v8CpFRDFDxe65CU65WVFrEYQnuHXFcmLe1LxMleK0uM1vwvUl48CoEg1OsEczwpE4mPw4MCpLnPtsiXe5Gvx6fiHBmjw16bifzfaQWR9XS/Ig1pYKWNbBeiqiM6Hvhev/nzCM7bwcRFU9vlsto8g9ahIuAqhxSGnjV8Dj/2SNbK8J1VPWTahFjrq7ABrzIVlX/9bN21gfRByxokW0Hrf/f78hXL44Vs3OD4ASQv4jvdm+zz6uQNRKZ9igqHsEHh3Edr+dhklX7DPyiB8SVnlA1X8mkeHE6eRyfkUEZERinmWzxjl3mmW8yDM2Ki2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkIQB2Sr0rLtDIjViNi80oIzaTXnUrIa7LI8f5QVLbs=;
 b=DRZlwagm7wd9z/jt4Gmd002BbKS0t+nwdHWy0DrjNfh+kcF0WyTFDq3QjXxSNGRiHEPaEmeMtRtj1AxOZTsIQrjxnA7nRVFnArlXHnX6BY2Zlvg3q5RjTPfZdsWsje1UhKj+awJHdp9QarpgceDnKg2sxbdP/3NpFSItFjz8W9xa7Ub6Jm41xAe850qDccSmwBpNPMUb3BkOTXR5m0qInSRfVZISLQJh4sNCKXycKTFsUu9v26qzpiJcHD8bceg8bJvt5uJ/NNq4PAse48LIt4TfjvAgFT1HMl3+s+Dnr1bieyzOqmdoEMf7kmXS36OYmOafhwtA2Wqji9K+QX3Xuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3384.eurprd04.prod.outlook.com (2603:10a6:209:6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 04:55:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 04:55:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 12/13] selftests/bpf: Add bpf_rr scheduler
Date: Thu,  2 Jun 2022 12:53:49 +0800
Message-ID: <bd2b9b2c6b514a52e00228b14bd46d5dccd11ee5.1654143895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654143895.git.geliang.tang@suse.com>
References: <cover.1654143895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0015.apcprd04.prod.outlook.com
 (2603:1096:202:2::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2bc2b2d-aadc-4455-0cf0-08da44541ba7
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3384:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB3384D71E91304A9AB3A0CDF6F8DE9@AM6PR0402MB3384.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qx84mnq9/I0Jdgp+5X5sMyl/8C2l9DUtGKJejKnACGel06z1rVAnZb8yM9UWLYVBhZ9ezk4zLwKcX1xRMV3CH4zbogj0AsKhVfL+1uE2iqgUdTKSvLn57OOaoqkfOVSGIwnirvrH/sMuAx884s6/5NdimicVC2IWhgeQrLiRbYOOeKEOj428TQ7N3Ymk/1yygzJMLsFpjt5ULX29I7ahn/2vDV+NJPxZlmbpbWiwxnBZe264zJ4KTadz6GdSkOlQi1mRW61+zPDQ8mlV+plRH4c+je7fBYgsDuGi2+6ZAxB51U26lQ1Hz2jXiC1wnLXcEl+wDsJZmwI15EOs+aHWhBdDu+QbVQOkqgSdDH0yef7v+G+5KXNpHah1wK8uGlJCYEdQ15pcUtkvXyNSPt6e3hyKEh9ShS/J7DiPYpFG4ipWiNjlU4HwXD+DiQx9SpCaJjSnZ4z5IhGQBF5P/RRysrAcdTnq0ikpP8GcLNwLmUrnQaXoc0kV/NE9rwP5qfX+7qjj9Qni9zoGKbgCFD6ciDDHPQJsyJy/LvR2qimAOxHIZtklWHvye+x8j7rtruxlty7QFKiFOLD/tk+7rNyU58jJmG9bnEwCt5P/fHsqrra6syJHtt35Cem3YIn0MRjyyswY+Z8Z/Bk4On24XjNSEZs4zoOewc394hcmLDJiMIJfytFDxVlZLDZTWRegzOALjGuG8oUoHrZu4JRr0gEalw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(86362001)(6666004)(8936002)(36756003)(186003)(4326008)(2616005)(5660300002)(2906002)(107886003)(38100700002)(26005)(316002)(66556008)(66476007)(508600001)(66946007)(8676002)(6512007)(6486002)(6916009)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eeFoLC4zkVc7KjEYvWSFmC4Npn6F1UDcrRBBW8iyGS+yQEN6uSeuRCR8aJst?=
 =?us-ascii?Q?rraE5D2mcR8x4PXG6oiZ7MLKsXqUqT76CLqjht3SOjfjb0ju0bTIIvL2RjkT?=
 =?us-ascii?Q?VI/N5Zz2pOiHPxiqYy3HB2GmC7f3YQgbpUMkLL1S1htF99e0zDESNX0h0u8N?=
 =?us-ascii?Q?qyGfMsPrPvJ/p+JqD0oH51AlKN5nI26W+rrcfJmMF0T5iy31tcVR9CZiPRe/?=
 =?us-ascii?Q?gmjbAfB7rw8vp+RewzlaEyfnnYZZ0bUzZp1UA5k2aACWBEEuZE+PdnUBVMUy?=
 =?us-ascii?Q?D66fEuTM9i+UfGnGLJFzGpGRTcGLDQNfVmnhqXu6hzOusZyzMyTTwOBehqny?=
 =?us-ascii?Q?9Juu4FZxLkrwxIl8PCh6Mo5pbeWR+i3l+W7XT1CI0JOTZHfkCSiccYSv4K8L?=
 =?us-ascii?Q?OHfWTwmOg2e3Gpng4QowzXjmaOoe46hqAXuwEQ9ms+ryP0qe3H+JvukDBJi4?=
 =?us-ascii?Q?QRZTTa9oCjSoIc+Uv7HhpMnyflrDx+GkJ4tP5Za2ZUXanjlSyn8VnBPf2Hpe?=
 =?us-ascii?Q?m2O1YWSO9p/puERxz5f/FmvXhoZnjFJV/rrSGvY0f4GafjlA5KhXp1SHK+br?=
 =?us-ascii?Q?DAav7chlC6ej4RblJ0JRoZpwG9R/zg2BGBCg2ccUOrLY2hQudRbjmRhlggm6?=
 =?us-ascii?Q?QXDiRLk+dpwLLYzbnWSsQMHzSdY/zigdL0jQ9kA4vrim8fd924loPksusjlW?=
 =?us-ascii?Q?mD0IDXrVU7hB78hry50F6Aj4L7YBTUvI61RBcGSxWSaaCLgNqa+Kb9WHua/F?=
 =?us-ascii?Q?Ggyn1rokHkcZaUBdPDv/GtRH31lV8qOQXt7EItXqzULs5rhkS447WG12UDfE?=
 =?us-ascii?Q?bjHB6g+BtItpLytxF6Pc2FNxeaCsLC2Lh8+TL/TDzEK8LscXoYPNC4QKUziI?=
 =?us-ascii?Q?ay0wBNJBjUG/sY5mLoM1rYod9HsXgk7NeBhj64OuD+sWzSTupqIad4WPgKF0?=
 =?us-ascii?Q?sfVs9qLV8G+GnhVxenofFogTFPYFE4IKNj8VsSTsPTWoX/3Uev6tNxvWnMP5?=
 =?us-ascii?Q?4KEaECwBE83Wxrw7PxzTjQVe6QGKdWXezJ5fv9pCA9KVJ60iRxyzp+PD9LzX?=
 =?us-ascii?Q?AiYyTy4Zkt5NCU1cjtkMDl0Cx6WKcjMFOZhvPKIcrZy+PZEHdSY9Z8d7CHsh?=
 =?us-ascii?Q?qjTvXTTeOXaJ9/HVw2lK+R/k+YUskx2/V/iBQMBQDBTN5Jfx0O9lb5NBZxNH?=
 =?us-ascii?Q?zo6y+zGBuCzrQDd9K51A+Q+Lvg4qGmYQiummw9SPS9+eQFYGf67C8AqncvN1?=
 =?us-ascii?Q?7Fynz8G4942sv4K9VwIx/tO4/d013aR14DWeNpDCG28YR+Adh4Qex+i83bqB?=
 =?us-ascii?Q?AE0GFLJky44pgEPuLCqu3tMCcFcNaXncCVS3jUxpcB289m8srAzUy04FwuKi?=
 =?us-ascii?Q?70bSq5oF/3QEEtmf16AGV4HfGnWM4xTpHz2GIkki0Ttr2n8V19tm4H29H+ku?=
 =?us-ascii?Q?oKJZR5wjOHzMgYouKKOq1jlLUqNM6PKzQSfkWKzKQnGeKj9Ong/n9VfE5HLc?=
 =?us-ascii?Q?6Gbwo0O847+fDa9BqWofaG5S63qVhaTVIUFLjRhR/qFAz1gr8YyD2fRsAcK2?=
 =?us-ascii?Q?OScOWiLw6iZtusJ1we7THaHXAfR6iuIgnKjzp2F2RxrqNr3K7A6DeEOdEyor?=
 =?us-ascii?Q?HbhLgzrdy2itcaINQX7RHsUT1CH3n8JqAE6pITwzkNBwky0W406Jwkn2gG/A?=
 =?us-ascii?Q?3Dmuo0h/KgdRn9S7sT4Dk2vCGYNZ3Sbss9CudFO0rftjwPNU3NriR3HZockt?=
 =?us-ascii?Q?SfrTZVTBtnVa7yZaAmTvvPcoF6Z4XJo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bc2b2d-aadc-4455-0cf0-08da44541ba7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 04:55:26.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5WuT7CVENKEIlTJCKp8onwYQyICIyBw9LrBZwExuQ4xBz2D1/SNJ6/2pcwTSwoKUOTw0fTAkdXuDvyrZMOWjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3384

This patch implements the round-robin BPF MPTCP scheduler, named bpf_rr,
which always picks the next available subflow to send data. If no such
next subflow available, picks the first one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  1 +
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 46 +++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index c8792e6f125a..c7d4a9a69cfc 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -257,6 +257,7 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
+	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testi=
ng/selftests/bpf/progs/mptcp_bpf_rr.c
new file mode 100644
index 000000000000..ce4e98f83e43
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
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
+		    struct mptcp_sched_data *data)
+{
+	int nr =3D 0;
+
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!msk->last_snd || !data->contexts[i])
+			break;
+
+		if (data->contexts[i]->tcp_sock =3D=3D msk->last_snd) {
+			if (i + 1 =3D=3D MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
+				break;
+
+			nr =3D i + 1;
+			break;
+		}
+	}
+
+	mptcp_subflow_set_scheduled(data->contexts[nr], true);
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

