Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303C436D
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 04:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651724841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFOTQsjpEaARblar7w8MBlNFxCJjVEQp+HjRVM660cU=;
	b=h2HyUYfZxP0VX4+XD2QcKJV47mAOVfF7neXQ8nV/1GtAaevmelp0O5CMwK0jh8vfsET7+z
	JirS2HF2eAULBdZkZrGh7ODKbUYOybGGwwREhr2D3PdkzlRqMLP8vsGcWt7XsEiOWVLvcF
	AOQKRAVcJAkGoHUzLVOV6Fc2gPMp3SQ=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-llvtbayoMEalvyqLV6Hspw-1; Thu, 05 May 2022 06:27:20 +0200
X-MC-Unique: llvtbayoMEalvyqLV6Hspw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsRBrisj8C1AP2RmfpiGRXF/Ki9A/BMMHUndAnXugTEsbcUTGGowybCBcA1fIlXrd0lR2ExkKOzMag5BJrX9Hh0ZNuBJmPHCrnI8abjixGONfoJ2gVjBM91nTI7fElgy/6ZfDb6MvsHF4s4dqAIkmlEF1DWKHWZbfCgYYY1f17gw3+iHBb0HzO3jFf0CRgWDPk555JWL6FXxcHLmZ0Svc8S4uLQ39KB/k7uyuiNRstJljERLcJu5hWaELJEqwByHm3Rhm4JQGoEaXmhDtpwvH5R1EoAed7zKq0WMvdbVvxSyOLHDRyU+hy//le5HYyYHJYAij/x4mVqNNRQr9fum/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFVQ5UXfLBnvoUc2MFhdtO2NkYy1Kz3sHqzTnSlq8yA=;
 b=lwJTURkHar/sQYiTPcWx9SmkfO9zoB7s4E170E9qbgmht/MCXTfCJHvenB+9PgtL60aVnWmpdzZ7jiNbNLrw9Uzc4I2kxMfCJdkA+nUEnl+4+7lloGFJrslEAjPK9FnoLDy+D5ltNgapvBTyZ5GHRxxmRfIcKOtEigwy44Q+4dH+NhM4Kt2PI2CyjTkK/mPI2+ZJmeE+XIV45HaJ4mgTWgLQbQDm+6qyl0njhY/yZwNcEr6Np1XgpolcEKI0LyDSFFY5xJsceGSHWhdBU3cSDRQW4Q+dtKRu/EEI3KdzsC1wooEly/QIy8oGQehPFxC9RNy0r05VT+ek18jy9SuDug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7861.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 04:27:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 04:27:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 2/3] selftests: bpf: add bpf_rr scheduler
Date: Thu,  5 May 2022 12:26:58 +0800
Message-ID: <25be2b1db834c7b6b05c1d77ef154fce88abde81.1651724418.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651724418.git.geliang.tang@suse.com>
References: <cover.1651724418.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0048.apcprd03.prod.outlook.com
 (2603:1096:202:17::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3405d821-5b99-494b-d9d6-08da2e4f8ae0
X-MS-TrafficTypeDiagnostic: AS8PR04MB7861:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB7861D534746E03E435C29602F8C29@AS8PR04MB7861.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cPC1k9daSLbIFXGSOnYnlJdbJwDptI1qOLeUgJy5zGVnxMS212yxeWwX8Nnou/WmDpjbZfiQGGqryuRzraKIhSbVuWgf/7rUriZzxCsPPLM3EVFSOUqYXuMMCnGjgpIWqSVuhJQKOE1Lae0Fm+8t2eDtPW7y9H4iqQgCAppvUROFTFNEDBRGl/kv9oKk/a6JEUNTQm5XvLSOXA2Atgb4K3jXnTWGnRp5yHsuzMCeTYPwIdQvNMmHI7h2ZZVrnSV7WIyJ3ZIQz2ZvfMztiFUkP2K311moNiTjD1UYPZu0tDeoyKjbB4JdkrxOXQtg7Jw2BiaJa7j6lqJXX0QbkRpy9yzvTtDOPraQvGWtM+go0wPfMZSCC5T+lYkqMaudXYq0s4QxaxXKAg2q3oVioxJ57Vi6sE4DLbE9mmyaPhuZDbqeiwOw7u1dg0vaUcV8EUfqUGGvJ3gAAPwhBFxDaR0tEi+xMPM5Iqyy+39FMkRQM1VHXvKrmyWhtH41k1rcUAR8LP7o8H/uY4Cr3zwazy2hZ67knUvVfIDaHHqSD9qwwyCpVWwECIuMgT2IBPjkwKeYxOkrxJkuvh8yfbHB/peJlZcVXBjEUF6NWxnWMZxJGGolcSzV3Bj3AYCe1u7VqeznQiQEfLxzmyC0p2buvagBlSBgStNyYQ7LV268fg0RSGBDQA42a/NE0l0ZcSzFUCNY8i1L9UgU+aNRJmei/3naVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6512007)(6506007)(26005)(86362001)(508600001)(38100700002)(8936002)(6486002)(36756003)(6666004)(44832011)(5660300002)(4326008)(83380400001)(66946007)(66556008)(66476007)(107886003)(8676002)(316002)(186003)(6916009)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3DSJEVhMfcGhJRResWcJvTtx7p3CeSbT7VcIfVLz4HnTbwJ4v0vq+/tEzwmR?=
 =?us-ascii?Q?gQz1TZkMGGwSfr+RpJ2BxUW/g9L/vvbMeZEPuBQ2IIiiNboDoDCnzes54qlB?=
 =?us-ascii?Q?7d3N7ULWFTydItb6aQNH87DGTZJ6Pja8EfqTwNGZQLoOLrG/RCvQfsatge5P?=
 =?us-ascii?Q?a92CX6JIyZwYzBt0BCnexsh2bRoKc2R2nIig06anunIZ9Hghbg2yqtE5e/ef?=
 =?us-ascii?Q?YZOAykvZgcI5QS+OXKteWNDA2y9ufsK4A55vzTVTsNslPv70MnEDnk6dMOKU?=
 =?us-ascii?Q?/vw8x5DjHW3EopuAau5FTA68HozTN8Fdf0FRVBlmKR1VbQMIhl8GIeRVJH+R?=
 =?us-ascii?Q?SILvujwS8vHJpauuX33RmV6i+qUBE/wwmjx9dCom0w9iHJbrb0L/P6PRz4Dg?=
 =?us-ascii?Q?V1zehx3FNY68bVI2pRtqnnyP5Fk9yPOrEZdAlC5Fcn7Ezq9Gtj93BRKDYyRp?=
 =?us-ascii?Q?H2VbqUamwwy3+gqtPUW3MZWSNlOqCXsEufa9QwjNmnseOwHF41LHB1/jWlY0?=
 =?us-ascii?Q?MHiT8zOXiem71ZCZAtj+tfCz4kB4y0FFr+8DXWsdZe40ZGiq6NY9T/7CpMTU?=
 =?us-ascii?Q?wnOTzdNCXXQP6Y2XFKe7V/tudc4KyGwJu/kh+ofLybvlCZ9OiE9finfU2RtS?=
 =?us-ascii?Q?zZ4F82YuQkdV+tSeRaCzPbe2FfrMX3uJIC2+I0ohwxIDRu9R8tefuZU9eGqw?=
 =?us-ascii?Q?DFWvv7iPdzO5xAKhQDwKi4FpWYyUapppJ5UzYOKR05ZkVaiykQQVAUhrJzz9?=
 =?us-ascii?Q?7GtVUK3D3g8AJszuNuXAbYHwo5rOEuSsyGuxh/gJxOl7RYBBv9mfYOrfJUfu?=
 =?us-ascii?Q?ckX6wwIwB3+yUCcKKDvoRttlJWXLpMZ6lb8Qjve0SOtGR/hjjs+cBtralVuZ?=
 =?us-ascii?Q?D3lW8PVqPmTsqbwl2QlvubSIBsA16LPLAo/+UNknhJrz1PXGYMpsdzHHLo2j?=
 =?us-ascii?Q?JxXqYIhnpsvw8NxKR/fwYgHc7lAlKbbR5sj+InGvPGJjAx895liUyswIE8kR?=
 =?us-ascii?Q?aptnQ+sZuyGmb3SgZPMEZLG1f69TEDtkP/ZDKklnJ69FfQ83XjSyE6VvRz8g?=
 =?us-ascii?Q?LSN/3aaahLuIxwduOAc+cvbxzmp/6iMtI+rrVQVxfrhhdC8lSjvyMFBRFxRi?=
 =?us-ascii?Q?sh9a1ROl/wF7EQfnPms8yuWXLhKZdbxWVZGx6hsdmVKKwNA86kXh5sfmEUCr?=
 =?us-ascii?Q?Jc9YaWr3CkzVBjVrXcnqL4xFifc0k06ev6aZepqPk0UZBIwsu+5Vw6rTYbU3?=
 =?us-ascii?Q?3kI/TpoL1Q3uzEj/HSfpOy8h7DylUOtLR8LCi2Tgn4QGaAaN3T7Y4gNlVkfQ?=
 =?us-ascii?Q?q8N+YUqn3Z2aGlfPSQLYZNDdt0g8Q4f/8+/kLBlh6PF+kyc7hX1BmD2VTBhH?=
 =?us-ascii?Q?d9VV60wQ3XNKsV4hIW5s03Xi1FfFV+4OxCSqX1A6/Eyg+f2sDCwTNjU0FAQL?=
 =?us-ascii?Q?9Lm6kQK6Og9sYsCTmu+SgumXw97KxdQu8bGCYSO7VBbypmMnrIhe261Qw2rt?=
 =?us-ascii?Q?M/0CRznvu073L1vqELWodQumAtYnrNBljHOn0axRdOc87pwtB27FEHJQahPa?=
 =?us-ascii?Q?2GCr0+UpqoZSc7gphcsUMfRXkDT7KemlRwdHJhCTVOehL+VHRv+zNLhRAXzf?=
 =?us-ascii?Q?xmr5fG06M3z46HOrXMJk8i06RDbAyeyRkBbuKbP7w2rlXN39b4uy2XM7Rerq?=
 =?us-ascii?Q?/ZHIQUc7E8f9unzU+GQ9v6bE5iSE7DGfOST/cEFIGMtt3ZPBGPe0sVvXPgAN?=
 =?us-ascii?Q?uM+zcS6v7GTSEtDfAVQZhBK3m36HJNc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3405d821-5b99-494b-d9d6-08da2e4f8ae0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 04:27:19.6756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSCaqVjsz1jZ8Ka/H41U2Tkcox0IDt87lZG/zFykxX4nqlx4SRRoOsFJMjCsCJunXAWnNWTUeWOeX2KpZ53LgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7861

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
index 000000000000..b2e1bd876f0e
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
+		if (!data->contexts[i])
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

