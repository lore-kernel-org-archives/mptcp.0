Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E537F
	for <mptcp@lists.linux.dev>; Tue,  3 May 2022 02:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651543678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yOPj+h7rPYscf62V/FGMkheIekiMZnjTNxdp9YdNmnI=;
	b=CqEcGjFblDjmsJQmBX4Lt5HOX+m4gPkPz9FpnHBsAqK9UFfebauQRl9lbpdTmRidv52fnC
	XcYoFmCJ45tWpJqk10EEyV+9//7HTHqzO8muzO5AcOYuo1vXZSxOhzyw9R+TejuX2xg+0l
	g2u9lExdqTD4ZGfrUa/DXKpok14mClg=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-Lq-ALXykMNeHijDZkY_8LQ-1; Tue, 03 May 2022 04:07:56 +0200
X-MC-Unique: Lq-ALXykMNeHijDZkY_8LQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbW/HrWmydo0VE/WJE6V1mpu+rQN9tVy0PTYnxHy5SW+YdF7XEMdAso9rgook2HMygViNCej1zJzEx/kQzCxMw2E0FGArMAAlIWWVVDRKJD1tFisoQcsQt7leZIP90FzBksME3lR7ORqAjM5ldA5Alrs4DfAeq6mKUlpyepytsemsksFGgOumZ4lD5lwF3PzF9H7GFivgKIPlHAqifb2ZuBQLfJZe7ntJEQUSvLMaZwnRDn9qr37FlH4c1j03cTc+2m2jI7pUaIO2tBZes9THohCgqAWrLmknC2WYSo2Ll17JJnXIGpPQ/vTstXvYTtA7QwGshHepnxaZCfQEnaMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfUEx3wbVYGGv1YUAtK1mv0Yp9On/yNmhVxlpKNwTXI=;
 b=RJx1ntUg6VnMguY+UqorlYAEpE/vzEnxFoOdO0StFZmk0I36L/XQKDInGmlnTkZ9gYufNw4eygNa2Yhqt3dgCt4m4MX6CFfZUXeaKX9FEkyE78SnE7yE9r10l3qWb1SMVLP7jj3R61eK1UEx6alDhav5wmD9SaIfZOvCXy1KWmH9U8wjJtUlNJ1eY2Ko643742SRzpkebM9ZjRunBi+VT6tUQnQJh3WjUwWaWM7OzQk069vD2wb43+9y7jNydRuBxdFUIwJ02zhf6vXCxv2yUCm5yrKEAQhAiruxBWgGgCAWUIPS3tHASaFUiWuuevLV+561GK6qJ8qc750JAIEhhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6364.eurprd04.prod.outlook.com (2603:10a6:10:10c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 02:07:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 02:07:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 2/3] selftests: bpf: add bpf_rr scheduler
Date: Tue,  3 May 2022 10:07:26 +0800
Message-ID: <763b63514d2829f434e89521fe9a61cf38e0bf38.1651543362.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651543362.git.geliang.tang@suse.com>
References: <cover.1651543362.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0194.apcprd02.prod.outlook.com
 (2603:1096:201:21::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26b52ee8-a5b9-4384-ac41-08da2ca9bca9
X-MS-TrafficTypeDiagnostic: DB8PR04MB6364:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB636458DC06091B25B960C73AF8C09@DB8PR04MB6364.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m43dwsPro7Gy2PW504mgrM8zuWwFzgsTPzBfwzsg2YYVsNAXP01aCC4OOWhIeGTtAbLK2BtW+na0NI/IUvogtBCgCCvO3i59mIdeMReCjUEZO6o9BZJdb3Iu9Pe5iB4gsRcr0xv0qUAPGt9FOb3QIxp+jFaJPhQSq3UgMxcNRAP6gbXE7w2mDmT7c6pu9j6gdb8qRUvzQ409cXvl27OVnHh5Xu9gOXXnf8MVeIZzPYqzCL9ASULmBp71Kb6V57BJRuchNDqiky0iU0k938UC4eoQtb7kJ5VdpDnc3YLbR36LnqUdl4HpBA9h2ifwzwfFO2/riH5RgySOFY8PHXj1HbqIeie+KfWA2506BtmS9yvpRSVX3KkR0M7CXJesoepAAhDLDVw52Bu5QgWZZuLLYJQykKFcorQ1EAjeEoRLJDSJ2LR34QKgmITjNVZs1UpJBLZMI2cJvLPkzPNTlOd5MbHtBhfrMkLR/CKVR9Uv1S+f+aEzBz883j4y3aK/gCuBZ96LfLN0tM+uvEJBzMj6uoh4CzDBKbRknlL7JrHzX8710N/Z1znkrb+hMVAXaobuvhR6HT0L8U2YCTsY9deTk4uQCa2SZdfpyOQuGWexHTY4tcz2GIGfbT/+Tsla941F5huudnSW7JxVNddGFqvp/f4Yv38XKWKNd3A2adUjbqOy7RkIPQxq0TDuBGwr0JSGkgYuUdPKJB6xLK3H+qKtmg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(508600001)(86362001)(2906002)(6486002)(38100700002)(66476007)(8676002)(4326008)(66556008)(66946007)(44832011)(6916009)(5660300002)(8936002)(186003)(107886003)(6666004)(36756003)(2616005)(6512007)(26005)(6506007)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JGvqn+YJauUAeLh2hfT7OsarESBfKdIyqXlnWaLnSXKScaLxSOy3rSMgV/HI?=
 =?us-ascii?Q?1vVbqOT+zxuSY882GAFvVaTsiVryay2o79dR3tfs6E07ES3Ogs1CHFVsaVih?=
 =?us-ascii?Q?2TbmyJYqcqpaGp+ei10dbh2s4a5WRqj23nUwtAuIyJfYSjs4r37rAy9AZaXA?=
 =?us-ascii?Q?ivM9QXpEJOYQlAehOZ+d6MR3U1sxGrROnqjPVit7uz7v6CBOQsYh2FSHpKM5?=
 =?us-ascii?Q?Ez4cJXdo7zYy17voL6fEm4WLljkBiQHU73yIhGsjN5lTSY2s56JMIPRtX5+z?=
 =?us-ascii?Q?USy8Udh6TPkVIAXQS+ALsPoqFI9qgu5Q+rN0m+AiVUYU+uMI7/DrnNXIE50H?=
 =?us-ascii?Q?SmPwhOnQKLLN3L2lRTGPztGmstJfgVS52CsOzVu4KPCUuv+hxSfr2McKqBH/?=
 =?us-ascii?Q?a6JrGL4RvSO/aovPPniFMYYrbwfPKMPLFpPuEeXE6vS+6+Xl3JlsGKm7uBjY?=
 =?us-ascii?Q?EtkXaImcLKY0wTCk0m9+h9huflp6vcj8S8mCiCBplQIRp4j+sa49AmDlKtP6?=
 =?us-ascii?Q?Mw1tEeQ5NeRgXRA0kHyVMi91hhEvcfvIpyKqjkdiNNDbOJkKDie2+8haMdIR?=
 =?us-ascii?Q?J4SkZ10pHnjRXFqH5D38X/UmuDhTXg9N7KWLpPk8Fu9NhxHepkl+j7bDKrbQ?=
 =?us-ascii?Q?jW3TqHCUoHgtw/sT4eJrXGwjRkZUSJluUpgcHKFi0U2exCWlFjDdy0HDR+3y?=
 =?us-ascii?Q?9d1enqGFDaH98qBFBjKZGbA5sfL65lmalRMck5brp8guNzuYMmVSrZrG1q/x?=
 =?us-ascii?Q?ySZLOQCSrUq4ThT7KIqiempgTP+CGfgzXR5aOI8ZrN3PFqPHYFeSZ2+58W87?=
 =?us-ascii?Q?CbeyMktEsdap95lN0z0eEZkwhTXV/nGIMuAPDF1jC3rXE8Fgqa84vt0gFBxs?=
 =?us-ascii?Q?p0wKlYGkEiJ/wuplOz5KN05gof7mjqZULC0eSbe+68R/76VgmGO1L9Ra36OO?=
 =?us-ascii?Q?e9MNI1dlbQFKU3YK5tmTww2GUrzGkM4HIijt0+fIV33YGuOXQXEE4YqTJFEz?=
 =?us-ascii?Q?sll6WC+Cl0n0XllK3EnF3RuyzxiM4Gk5engB9DPa2P9s2rANu6ESheY28I9O?=
 =?us-ascii?Q?JxE4B+mLuJukHWOEdRzoN1uh2NJ5IiBI/rtCOY25zODNIm5eKRHiWbfhfEz/?=
 =?us-ascii?Q?b4TgmCSTpZfZiBAORy46ABUJo30kH6G0AzHR0PZmcSXcGPKimeA63sN+n7po?=
 =?us-ascii?Q?Zdypkb4RAKRoXlF7tCJ2dFIImEqSv+SgbD8At/hMmNcXosKcgy3Iy7SNGEnL?=
 =?us-ascii?Q?FYnhJ/SzZnENXVE4s4hVt8xCvIhPrvtQ6nqB6JPjo2st/qfXVhA/AgGipdGz?=
 =?us-ascii?Q?xqRBQyopfC/x2QvLRcJQmpwhspSIAp5Luc/WkUAneQprO9MLZ2DuqySvSpCc?=
 =?us-ascii?Q?23yksVBy0S/JcXbKhNfGDCA0KoyhpKhgrq9mgz1D/2XoieqeWTfKjswNbpby?=
 =?us-ascii?Q?JXQ/oL7kB2VKGuUzgn1RNAinm0MTYGsM+IzWGsdtOgSJv3awhEafryBQCnAO?=
 =?us-ascii?Q?JFrJsIKQwoSOLNQiTZKB5a795X+laL1BTxjkMbPC/GS+K+YFD4W3cJa9PVZp?=
 =?us-ascii?Q?pMHqKkJ6VA6Pco1td1BNyQup/Cxuni10dCbwxo+8bxG9Y0lXXH439C8zAZ8F?=
 =?us-ascii?Q?kqjA1xz6fhdOPDcmi0GwUM5V25zgsK+OtrML11GAFJJu1pjfrHeBNS+0oh0t?=
 =?us-ascii?Q?Re3b8HspIVgf0mCxNSeZ4PkTVdRtH6wfjXKjLsuU0PbeYYaek10KlCVKoJhr?=
 =?us-ascii?Q?C0pHZ+c0I5/gRwhpZLjag30ZymAFKpI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b52ee8-a5b9-4384-ac41-08da2ca9bca9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 02:07:55.5333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdjq2XbhqRin9Fd6KIq0eUDZG+HUfVdnwDBO/2fMRVB2a54BkUH/q700NkcK2yIG18TBCdOQMjO/rzD7HvYxGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6364

This patch implements the round-robin BPF MPTCP scheduler, named bpf_rr,
which always picks the next available subflow to send data. If no such
next subflow available, picks the first one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  6 +++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 48 +++++++++++++++++++
 2 files changed, 54 insertions(+)
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
index 000000000000..ab0bb2a38891
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -0,0 +1,48 @@
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
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk =3D msk->first;
+
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		subflow =3D data->contexts[i];
+		if (!subflow)
+			break;
+
+		if (subflow->tcp_sock !=3D msk->last_snd) {
+			ssk =3D subflow->tcp_sock;
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

