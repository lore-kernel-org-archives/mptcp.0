Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1AF1FC0
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 14:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648131002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=el14mbDNzMQKfIz7X8FmdkOL32gSiWivSI0Gycj16jY=;
	b=ZhdGfWWkSaK4WxutyZC8ZPkcq52PZjz1QJnXs/MNxmq33KGSVpGVUJmNHOhFld7pium5av
	+dLD2JOP7VRWb7u3VeHWX8XmP5lo0WvkccLWMAmulrI1x/WQLUgfzIJpVmeJcLE0zAnHwy
	xb837FWxi7tQVOLhLj4m/OTg9REqC3o=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-Xt4BkLAuPy-SPLY28t4HbA-2; Thu, 24 Mar 2022 15:09:59 +0100
X-MC-Unique: Xt4BkLAuPy-SPLY28t4HbA-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+4liYcqB3XF54JYD07Tgy3sjmHfDuy5Pf/IE9tYqtapezEz2r0OWlvGKYI8JkoXtLqWU33cTfv2vQryI14FO+rwQF6SH4NzErJIEDvZ0hrmMVkbBD/5MOzXxbmVQJtfk6adboVgaay2NG6ldDTpi2WH/SQY3YXrw1LExXs+DF9NOh5duYuuXS7rfID7GJ3txkRpsj3Qa2ixsNoZKCpKIsLAfyjNZiLswjNOdzLflkpihTeXXosG60Ssch7x4JGbnX/3fEZhzvIjismgfYsi6DPS2bRvPLiZrOBZbgD1Fv/R6F1B76JdkEuQe35BRVqFZVl1YAv2DTM3B3bBhficwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5FH9XtcH7HyTwHY5I1wHeCwYLtUvyGzKzyt2JprDa8=;
 b=kguf4NJX4f8Nvj+Bzekyz1Hw9sf1jc+W77+EOSfjgUMSMZFzM3awhUtVsOGSdJ9arRVOcC84ABRKD/nH0cop6ouxnb5fPEhIafWtrG5prAhIYrFNR9euq1thTnkwOkxJHpGPoH2A1/tMiQDM22OppQfRWywDeHB9JR87mObzJgK51fSvrTJkWSWVwACoWD6XhPm/EdVNCYnjfbhhfiGDeTZzzrtarYPzKMsR5c60qc0XnQfgvFdES59Z9rDeg0Q7UAbxfQni1jfaKlaHmOk3iQ4y4W0yTn0IghBhfWPH3ko/0tUymvJrC6uqn4oA/ML81alN9dd75+0DTAsgHBOFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB5275.eurprd04.prod.outlook.com (2603:10a6:10:24::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 24 Mar
 2022 14:09:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 14:09:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v5 7/8] selftests: bpf: add bpf_first scheduler
Date: Thu, 24 Mar 2022 22:09:09 +0800
Message-ID: <15d75ff7f10942bfe491631ba2500f5ae9d4592a.1648130637.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648130637.git.geliang.tang@suse.com>
References: <cover.1648130637.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0201.apcprd02.prod.outlook.com
 (2603:1096:201:20::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed3b29d5-fc6d-4194-edea-08da0d9ff7b8
X-MS-TrafficTypeDiagnostic: DB7PR04MB5275:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB527564BFED804DD7CC6AECD9F8199@DB7PR04MB5275.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bMSST+TlI8zfreoJPGFFJra2tV+GE6afj71sb8Pv9rLVOsgQnudHDyvbnR408+OE9uMzT7wuIQWvH5lFf/jVdZclaz03gl8kMxwpGTJiSr1pMdXKKRLIFCvLJ3WJR1WZiezweo8QvwtOyXT3YX6RbrwleOOzacCVYUncbD4Cpkor5v9HsU6jdeTfG3/tMk8n2h3MPTMsPPIcV2xkYopxArF3/CJ1rc42/uTJoZReXsL7kgNG5ehfnWqj/HPzP5n/tSgKA2i+7QBIDXE5GD/X/7LQ8GJBidxLeS9SKGGIot8WI1zH4VdcMIvTC3VnO7/ZQ3KcA5New0K3GWb7hsTAgpdY33D8fpKDG0yd/kCBOOTtCcwcwE0lPlY3g/45JorBja5mce7oVxoxp0eLdffF0mVpuxN+H0CBA3VcZ7LHw0yrdfR3k/bylf7dZ7JsXFAQuxVjFpurpXA/5Cv9cQf1DuMcWUBB3zvlIKj/8KI8TlpZltOCDHIHEoO0yN49hC3T366TID9SmXS+mGnQb0c+xrfvjJfRzwqoyKiDadCXsgsJ0gdGSY4+JIT57s7bnV8jPZZWXxZLmwULspvugYrvqp5DkV6V3ljaZi7bodkTJczkCsZW1Xb+QKx9ahZIa1zOUgRQcBW2ND4LuEiTvb2mg8n/O8np+z9bVCYSHCGCn/VMh286w8wzZ6QvNGc0vpyD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(4326008)(66946007)(66476007)(66556008)(8676002)(38100700002)(8936002)(5660300002)(316002)(86362001)(2616005)(107886003)(36756003)(508600001)(6512007)(6486002)(6666004)(26005)(2906002)(186003)(44832011)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kM4jKu788+PYGrEMP7JnsLnSMTg0Amhh+o8eF43vO57Xf8/7SJyOTOgIekhX?=
 =?us-ascii?Q?T/VbiNmIMv7Uilagx1bE581q6ll6BxsBLZ16iZedHwHbXuusphbAa3uoDcI7?=
 =?us-ascii?Q?9WPFX8eJkERYTTo1a4PPZcK9yzwR89rJBa8xaSpo3LufMlEt+wR6IIOUgeVd?=
 =?us-ascii?Q?rZvO771Q0SFWVxoFIn5rrDB36h09BoOhdz/7DwJEgAX2o6DAKprGP121fdky?=
 =?us-ascii?Q?J8k8qDHB6KmobhxD4P9iD8jzpTtCuAX2TpjOXgYAEXG4Dzc08gxe3nSAWwcN?=
 =?us-ascii?Q?5AncpjmWJaK7IwpGd1CpgOGoiBDPS5JEsG1scpnjBq5WjzIarIpLvWuOVUcl?=
 =?us-ascii?Q?qgKEDWEAz+UtHe3wTNzdCkulJLNc57HpDk707KCx6PE4UdmlPdIhc6JUhoGQ?=
 =?us-ascii?Q?wqGiIrGypgnXA1be0wg6cxZLr4+rmvTNZbjmBhcgOrXgsNP4Iw1ajcAsU1w1?=
 =?us-ascii?Q?TANbxleZ5B8wLCsaWF043NN/e6mlTiPFGOP7KKUfXK/QUol3s6qi+0E41yBV?=
 =?us-ascii?Q?97eTJhpSFiL+XCV7rgu7IwmPw4tIbDO7JJUrivx9F7kVYnhqwgV744Zuoe69?=
 =?us-ascii?Q?Xnqw8IDfYLNisWLYjjl5u7HQPBWumsr4Ak1xGF36hlWAVPUt9vO8dmlqiFNP?=
 =?us-ascii?Q?zolAg9DEO9SE6EMusTvLBTX+vvbD4nE3RBeZ1tn0LCVN0/PoB5BVXJLhW8Bb?=
 =?us-ascii?Q?UWFg8nXLNIp5Wbhz8QywaV2Oax9exYEa9GomHK0kFtbSTDQNHDrM3LgpRur6?=
 =?us-ascii?Q?j+OToFQXAqOTix7v+gjxnRz2GPJJ9Dtcgwg48K+HfQ+QRKSSgbkJSFyYqkQI?=
 =?us-ascii?Q?DTWM1xSl8dHsEh6ZysMgKvTESQ9KSHTmfQUCPm62BPCweoM5sgQiP914Cz9i?=
 =?us-ascii?Q?r9uu8Z9HFuoHZYS5uob4C/cbEkktQ8LrpcOxI+tGBfuMXoS+RqO4347aDLCR?=
 =?us-ascii?Q?7lC0bAnUGKym6ckzgSzJGx1cibUSguRfqtK2h84VtqOJVj1NuL6vrCtaBVi8?=
 =?us-ascii?Q?WOyE0wAJfB7KPERMieAHIXV9EeEONh8vxK5P++KnGgvDV2jvd+irmMQzdAvR?=
 =?us-ascii?Q?bIPv/OY+MsNWSNZtde+pr0Qjj4F5mjJ0dcqBd/eDoU7EhK9I7wCDEePgmCqF?=
 =?us-ascii?Q?eDDZv+KRsT26DI1Fx//NoyZuAUhW9yQdzFlp1pSn/8PBHJ18ELBcNkroLdIX?=
 =?us-ascii?Q?7vnJEg/CBR9+n8yR4tg9amwAo1wiRxEs5jJ2M8KHvEQAsoOY9fuApamkbCP4?=
 =?us-ascii?Q?jzkedCqpH61OCQcsjM6EhmopLdSKzgNd/olpAKz8S8YxAVMY31SCFZ7VS8PT?=
 =?us-ascii?Q?4Wyu2nc/XQxDy2eg6dAal3Ktt3wzzc65+F6A36+NHE0iova2K4mWj+x3mhig?=
 =?us-ascii?Q?UkGoYXTFezrE9Yh1GzJhcmaBfNrOiDndhUy9lmwpEUl2aV+9U93fdbvb7zLf?=
 =?us-ascii?Q?ILybJJRjavey2s6udsJ2fhG8hQT0A2KXljiWcTuk2J7jQHVLrRcqJw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3b29d5-fc6d-4194-edea-08da0d9ff7b8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 14:09:53.6836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMUEqcQv6PhrPQBe00isNvSaucmYRjeDHgZ5rDcH1hqlF/E1A4d6Rg79rFGBuSo0ybOez9ZCi7IM9csyWTAFLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5275

This patch implemented the simplest MPTCP scheduler, named bpf_first,
which always picks the first subflow to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 12 ++++++++
 tools/testing/selftests/bpf/progs/bpf_first.c | 30 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_first.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index f92357597e63..5bb21b24231f 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -197,6 +197,18 @@ struct tcp_congestion_ops {
 	void *owner;
 };
=20
+#define MPTCP_SCHED_NAME_MAX 16
+
+struct mptcp_sched_ops {
+	char name[MPTCP_SCHED_NAME_MAX];
+
+	void (*init)(struct mptcp_sock *msk);
+	void (*release)(struct mptcp_sock *msk);
+
+	struct sock *	(*get_subflow)(struct mptcp_sock *msk);
+	void *owner;
+};
+
 #define min(a, b) ((a) < (b) ? (a) : (b))
 #define max(a, b) ((a) > (b) ? (a) : (b))
 #define min_not_zero(x, y) ({			\
diff --git a/tools/testing/selftests/bpf/progs/bpf_first.c b/tools/testing/=
selftests/bpf/progs/bpf_first.c
new file mode 100644
index 000000000000..3ae5c1eab5f5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_first.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("struct_ops/mptcp_sched_first_init")
+void BPF_PROG(mptcp_sched_first_init, struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_first_release")
+void BPF_PROG(mptcp_sched_first_release, struct mptcp_sock *msk)
+{
+}
+
+struct sock *BPF_STRUCT_OPS(bpf_first_get_subflow, struct mptcp_sock *msk)
+{
+	return msk->first;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops first =3D {
+	.init		=3D (void *)mptcp_sched_first_init,
+	.release	=3D (void *)mptcp_sched_first_release,
+	.get_subflow	=3D (void *)bpf_first_get_subflow,
+	.name		=3D "bpf_first",
+};
--=20
2.34.1

