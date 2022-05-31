Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9BB210B
	for <mptcp@lists.linux.dev>; Tue, 31 May 2022 09:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653988232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYublUNBZ+A7i4qIxc4G3H8J0EBhnuQTjtoIdIrGdrU=;
	b=nEReuYu8Rx2QFMzaq0zLQsA7a7qmyh+2T6/ccdqt+DzRrHg56xlxDejM50pWJEEE17JT3R
	9ybi3KiF8hvV9Ocn0ptJTvugUQemEDPBZ5YTN93KDI8HNncU/vuGz0wc1nE1g8n4EKi1F5
	RjiGdbuqVZAjGqKPu7YfIhweuVs0k4E=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2054.outbound.protection.outlook.com [104.47.13.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-LZFJbNkbNIiayLagufXQCA-1; Tue, 31 May 2022 11:10:31 +0200
X-MC-Unique: LZFJbNkbNIiayLagufXQCA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TssWd1N5edOHlP3Mpv/DLqrpWdG9qmPPE0nD+37jf4uVa/oopfHhkD5PoeQtNy9BqxMhIqS/BksEpCvl70aEAsSHxxfEEnx8kWOXUW6iCXvAAh14MwDyczNvgaWYDTD4+3/YYMnomYbXf8QyzwPSJGdj0SjFl4eHGXTG1Tpb/6pNCuXfqlaxxnxvbjWc0r5nzBb2IiCGjWEFKUJ6OBw3WfX/X8k3Boa8CnEHPQIfM6gpBBPZ7xvNJ5vptve821+NZUqEhwXX4TFHpzoxON9Sr/k7jUxUBz8MUVDKPq2IQ/48G6UgMXsmSocW40fasA8ufvpNCnUC5AqWO2bH0Lt4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cGSjXHpU3qkUSuwr5iWOW2osejYDiANCbsOgUU5uK8=;
 b=mmWrH4p0PhnHtThY/RMmo1hpQIc5MoueuI9qgIYIZS0oLzTGseo0wCbPHbIorld2ThLiNANLsKJj+uGvzvh6Dh1/csXPCZyDXM+AOMFQSt6Smdg3PLiCmThy0d3k13ELJOIc/K7v02nGnEYyHyMY1e2ABN5Adoi/z2+cEnylkQd4wIDw8k1DAulJ6L9BNmMOPs/CF0tUs5KZGS/ggUDaAJoeHB9H2SZ0DMYQLrzGJIKYxrC0gkqTK1PcpPx3GJhmCbNRbfL6WI0539LxWTsVJiM2rqeuqC/ko3KMTgWcSc33wGLSxHtjbFWLeNr4B+jVjFyceLGL/Up/R8aX3mfIDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6434.eurprd04.prod.outlook.com (2603:10a6:208:174::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 09:10:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 09:10:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 07/10] selftests/bpf: add bpf_bkup scheduler
Date: Tue, 31 May 2022 17:09:52 +0800
Message-ID: <fb54b554c1897f5205d1e146d0a7d1d25f7a8a4a.1653987929.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653987929.git.geliang.tang@suse.com>
References: <cover.1653987929.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb44dc73-b21a-4e85-e88f-08da42e568e3
X-MS-TrafficTypeDiagnostic: AM0PR04MB6434:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB6434E24F0FF6D3C8EA2D4401F8DC9@AM0PR04MB6434.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SWD3+AAnjyLc5w7AMAzzO3RPkkovrnF7gc35VxTBL8I8GnFqZnq7BkLcGhu389HsJPyjEX5F8rG4ZARMZymeAnCRppk/6iSmcwCxmnpP5XX+5JQWwU7RtAu1FE4+vl/Ne4wd2LSkFaOSSYh0bdHmZNZCPt41S6cZQNxcpVFQU3mZ4RlgbJkQQsHy7QZZulbV1n73Ij5TYaKBv9doXlX/bgVTSznyoEgijmCy32KrEVhSeDFG37SOihg0y1GDO2LlRGnUjh1cdBW6xIgy1AYF7cnRHQVO6FAiANJgaS2jK2kd0PXo0eBnjhmJq1EX+sTZnJ2edMH8iJCBKquN+wNQEPmAte/jhXAJNpnppmFoEDXcfvTxKe+FYCpr/JzjWAcE9JR/8EHCS7USu3jjTSiDIXO/8ddb3BmCBz6BDrisOoXvdTCQDA0YZcy26rosWc1nytV9Cur7ivmQ8FdqdM6Qjhr51XkM7/3/tOrVl9Es4jHMoGJnRfU7uuZ8oVa1vmJZ2BG1Cn6BnP1mCQq7hnt5NhRZnbvznb+ZgDMjvbhk6YvKR9gCyGTJJxdCvnKOmB2JbGhAPGOTwDniPHRa9gF25JfVzglxYUy52H61ru1C6RlHbO4MpY3dXgM5APPjrlms762Eu56Pv+uHTXTQ84J/2lPK64H2G3WTSi+IAq3HctVWGFjya2CLcw03Obp2xpHg9wP5J7ENdIPPzrVfM6Ipgg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6666004)(6486002)(8936002)(5660300002)(508600001)(38100700002)(44832011)(107886003)(2616005)(86362001)(83380400001)(6506007)(186003)(26005)(6512007)(36756003)(316002)(8676002)(4326008)(66946007)(66476007)(66556008)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T/J6VGZx2F7IjDX9C356xP18aWicD1v/JcMtiVsIQlDoyiqmddJK0jU+vbHC?=
 =?us-ascii?Q?naEe+ob2Cn1HMTRIrQz7yYOL5F7UH0yzUB3u46C6V6MG+rFbv4JUT558POlm?=
 =?us-ascii?Q?vt4TIFMBryA8UcWIY7e/DANggmz9M0aytHQzEACS7Tp9Gyqbbax+dcY6Ku5C?=
 =?us-ascii?Q?S7EYEjOJ1RZEBWz9lfqzK/QmLecgTb8eBiFH86GI2naZbKEXisnRy//F/Qb8?=
 =?us-ascii?Q?JkYT4jWZTlp1OoaaG1eU7O1mIAK9YD6xHvw3w3A7FGbejFL9Zq3If1j50m3+?=
 =?us-ascii?Q?iDP7du6f3lelsAX4/C/jcWCAnkHM1A0t+ue8ETvRUH19vX9HnQMHFzubrpC2?=
 =?us-ascii?Q?p6cTT305vroTKJE3Je8s+0ixUVIezs4EL0yItGN3okmjYCVtz+xKvEbNjoPa?=
 =?us-ascii?Q?XBs6Z/ivVAVOSzsDsn5EXEMLYU9ENMI1oGtuytbzMemKx5OmoGGAOhdca1Wc?=
 =?us-ascii?Q?iPAshZIGS7d/i4ie+vAWl5u7YGZFhtMKPxzajMA3dzrdK7GfVyvwr0J1CqBl?=
 =?us-ascii?Q?prdjDjU5wZ99m6vbTNiFfo15qPfgI9m83sWI6snT2JWcrRnp6sVNKfZC96GU?=
 =?us-ascii?Q?u3uWNDSRPDy3+aQhaP5dtASKE0pn6vCFcqrIjzu4AApLjA+s4n3s4ynb7DVU?=
 =?us-ascii?Q?TdF5TSiCHZsuf3G/F6HCQYRh9zK2BMvOseQkza+HYeoCy7SfknL7YLHLWM3Y?=
 =?us-ascii?Q?CpLnkYVTyuC5U8FrQwJ+/zVoEfC+z+pHNU4W3BiPqRDJP5TcSZDQbBe1wGn2?=
 =?us-ascii?Q?vKLE6Zscr8JCfUZruTpUY15RTs2CwA1LLzqra5av5Y9Ypc1Ej8MUy/84JBdC?=
 =?us-ascii?Q?8ij8oF5oWhpPekEa5j3Gd5Ig2z8H/tGrMq6Z91e3wviJFYed6ve+P2uz4HM2?=
 =?us-ascii?Q?pZctjbJMhcgS2OBWjQAInH8QusXdnCFokHSyK6vN8sBzhgJwCmNiTFXTWrfV?=
 =?us-ascii?Q?TE0NfZ4BVZ/V0R7VkQ4iqE6xf08ZujVFhJDIbHzK52p+x0ZUMDA4p0xC4Zh+?=
 =?us-ascii?Q?6T0AQbBtjJR/aBRHjsiWkeqqHVtq0s3bEjiQvnLYME41gILJrrHO9bP9tGYg?=
 =?us-ascii?Q?R15Bz0PPDd9yMvPm2BidAzAZ73PGJaIWUQni1xETtr/jdGNfDHkNtJzcaVKn?=
 =?us-ascii?Q?0ID/jp0rwYqrbsvo/iqNaLdOQzolx+fAzd1eGzngN9vrUG12p+zlE6u8LLh6?=
 =?us-ascii?Q?tM+qAbqHGbdaNvQGLNc1/7X33DcYi/7pMM42ezL09JeeqclZMaiaLpiCP58D?=
 =?us-ascii?Q?fbINOoh3LFB3bpOOjg9BgL3ihv8VorOMGAGGfND55lKIrXXGs7QHhSONQQmj?=
 =?us-ascii?Q?1b/LCTkM0kPg4OdImfWa8cJMN+bQLpdG1KWJIanzlzw3E6m5aMFcJ6rJ2lTf?=
 =?us-ascii?Q?JvQ1jTVR9p36nArpKiw3tN0xnQbG2SlDAN2p9u18FcolFfIZZoE8GfdzdXZw?=
 =?us-ascii?Q?0kIu/8vyjTFN5PaeS0HZcNBB3T6Q/VNcSOqVpPu+01e3Hb2XW5AmGPjyHqsB?=
 =?us-ascii?Q?3fW8mK8NJzNZacrH6JLqUL/gYECL3qrYSgp2SoGz6Bk5diuG0wIH88QExSGY?=
 =?us-ascii?Q?6hrv5e42kljHf6/8cR4JV2MK+Kt1I0QVh2bqCOSHpmg5tzV3aDDKsLr7AyCw?=
 =?us-ascii?Q?MQ6IJ3nBRh/CHNxzk1lxPcIEL/YHQw9+EEbZPt8tOMySljGWijd4SOTVuz05?=
 =?us-ascii?Q?GO6J16MeyAyehXvGmb3uEjDTQC3Z36dr0St+Xst0VzbhUE6nMvYnHxo0LJ84?=
 =?us-ascii?Q?OMe2pDrNbXJuPBGJ5xIM1+H6Uv7RX6A=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb44dc73-b21a-4e85-e88f-08da42e568e3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 09:10:30.4181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMbDeuIrJ0NUqQmtD7LqBw4IitSpRGK+s1eI0Cq9pdYPNqPhULiZDUh1nYXm6LN6EGfaUdkuK5qpsOaaitcRwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6434

This patch implements the backup flag test scheduler, named bpf_bkup,
which picks the first non-backup subflow to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  2 +
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 43 +++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 870deb5cf5ed..6fa496a65bef 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -234,6 +234,8 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u3=
2 w, __u32 acked) __ksym;
 #define MPTCP_SUBFLOWS_MAX	8
=20
 struct mptcp_subflow_context {
+	__u32	padding : 12,
+		backup : 1;
 	bool	scheduled;
 } __attribute__((preserve_access_index));
=20
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/tes=
ting/selftests/bpf/progs/mptcp_bpf_bkup.c
new file mode 100644
index 000000000000..ad2b2b4de8a5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("struct_ops/mptcp_sched_bkup_init")
+void BPF_PROG(mptcp_sched_bkup_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_bkup_release")
+void BPF_PROG(mptcp_sched_bkup_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	int nr =3D 0;
+
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		if (!data->contexts[i]->backup) {
+			nr =3D i;
+			break;
+		}
+	}
+
+	data->contexts[nr]->scheduled =3D 1;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops bkup =3D {
+	.init		=3D (void *)mptcp_sched_bkup_init,
+	.release	=3D (void *)mptcp_sched_bkup_release,
+	.get_subflow	=3D (void *)bpf_bkup_get_subflow,
+	.name		=3D "bpf_bkup",
+};
--=20
2.34.1

