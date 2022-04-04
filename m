Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D7C23C8
	for <mptcp@lists.linux.dev>; Mon,  4 Apr 2022 02:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649038279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jx6IKQC9z34VKBusTZ4CCTPYPLTazbGgC44jGOchtYc=;
	b=Ah/YvI2ztWrPfDO7oxexF/yyG24BHJoR7hCEFzUCh8HHzKjOaO3zgZpbwQVX0qplmBBLx7
	rfCWmaKsxto2QQh8Kz1qUYYgzyeJAuPUzUTmrQgbRVm5HepPbN2FkCDwRfSC4RmoP6EiRY
	odNqd7Ta39qFEpvMuR32Uf1Nn6l4Hpc=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2052.outbound.protection.outlook.com [104.47.8.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-wQnogzdCORO0QBxRBGEWIw-1; Mon, 04 Apr 2022 04:11:18 +0200
X-MC-Unique: wQnogzdCORO0QBxRBGEWIw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISl4beFw0e9BY+T0DJGn1Yn/el5568wliALwzxtKX6MvYs7MsKxjutzNqmYe9L1b6PfmW6cOnizgtp+MGrzvUAAemb64UcavoJmFd/seJcgSvdF0wrmo8VONe0GrNt8J2n5ug+7o4/oA3fznaIF4f+wa6zTf8jQ1S0k5bhQukjNalTx8tS7dcEuwQqp4PX+E7dLt5OF0GpJEUdMN83Q9bFF3X641r2rkthoVKKcN41JHaiNDBHfp3/XdZlrGitFeXP6vULLSMJmcPnaYvUsztu+cO3Kg9q4Adcsn3a4hfWyLQ3zfSL96YJKiDWj7nwZztSHJiDbjQNKtd3mtbSnVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QpFA5G1Y7b4YzT1l0T7QB3Peyp1+TB2HFuvSWRw3fk=;
 b=PotBKJf6gXGfdqkzeNZ3c2swb+mSFjNRImCIO07OVwVHoA6gZMKPvf9tGoyjq+875hXAhPpr5I4krbaTvXUgveRaQwkAyne8f2vsL7d5U6FrCyZtlG2FhkSvjZI1u6h99dzPztZFhfaHx1rnBqSDA2eRSQRgMesC2iWxYPUB/B57Aos553Olxmu7KWwnVmvCDxuCjNGI6ZuCW/Aig47hEa8j2Xh9LZLBbdRpZNkFaFYVGY6r00HxZiBx+tdFmOszmHyhVKN+Rz8mrf75vvrMMg208X9/4loMuvKE3KnWqO3jRxW2g9VGc9A4jnV8kV9Fn+D4AWh5kKP1BMmOHgJYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7189.eurprd04.prod.outlook.com (2603:10a6:20b:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 02:11:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 02:11:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 7/8] selftests: bpf: add bpf_first scheduler
Date: Mon,  4 Apr 2022 10:09:59 +0800
Message-ID: <7a71e3b1c69e92d90ba02a6402f4617f837797d0.1649037838.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649037838.git.geliang.tang@suse.com>
References: <cover.1649037838.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0163.jpnprd01.prod.outlook.com (2603:1096:402::15)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20353e2b-4845-4168-1e3d-08da15e0670c
X-MS-TrafficTypeDiagnostic: AM7PR04MB7189:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB7189B1390D10171F26B0F6E4F8E59@AM7PR04MB7189.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7qYDzWHBx94okBIn1Hiap+Mo3Y7zjlV1Q9TCni0A8EFgiCHz3lQLBuO3LpwK21H7DstKJxq7s74I+e5NhW3MgK0nCBrw+NLl/fPj36vTH+waEeog6SSiBVa0SCqk56WAl6eLnPvtV4aY/54UAECVFXyWl7Lo2Va9edzo+cJllOAmLvCmhmVAkd+TwlvmiWuJEAQ9eNFJ6OyxIi/yPfPXOmHy6hGdSpDXV3AmXOFAQFqXPtsMCsCTEDhHqi5D16JLZ6+HbLedxeuVbdTm7E6teGuL8VBaXl5IUPmViWKIUtG2lob5E6x9yV9g8qFIuCugrjq8NSKKq8URc+pdA9iOI/3lpHiC7nUKNEwvcRg08L2qwMsIGV3PNKW42H0kI2Fl64XJriZoRJZ9CM4gWsX0RCU98AZXeVKrFGEK8mT4En8n5EY6mAnexuGGfABh+5keH5+dl01TI3krQZySN1cBa19oXe1H6FMW7qMQZiX4j29I5KOISaBHedcMLdlxtvJ0WUqtuOCuq+KNZSKX0n80xCDdEANsVvq1gCzojIYbo2btzSI4QydargKIAmhkpyNZzpAERzgC57kR1iqHpDqnt6mca7i8obaC3ToVcqT3fcTm0Z7AVDIdGK3YRyZOfRxD/WMgJRZlqT4xFJQMN99sZkzFamBLmCrYlNRFzGf2mXRnIWTbkYa4PiKGybmWLV/1t8RZvLQBtwmjfL5tVhv04A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(107886003)(6486002)(5660300002)(83380400001)(8936002)(36756003)(26005)(2616005)(6666004)(2906002)(508600001)(38100700002)(66476007)(316002)(86362001)(6916009)(66556008)(8676002)(4326008)(6512007)(6506007)(66946007)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m7OueHPrHMgNwitPvlhKvTQgZr5bUumNMLLDM/qLTwxg6gGwnOFxdkVX7g67?=
 =?us-ascii?Q?L8yWZp4vCtBT2uhZeW6ED5/Qr+DqPXzi3/Q5lUJKyWWt3xlTd76PUKz0FbMQ?=
 =?us-ascii?Q?u+hdQofQDmCBIY5hR7sKnhw6ukm17EbOrdXE6ohPqJHu/OMssHopdDqFnSU9?=
 =?us-ascii?Q?hQ8K60aOe7mB9ETehzgdoxalg8dxsREsfDRj6L1pgNS4s9smuR1702aLmyVO?=
 =?us-ascii?Q?NxEf8IQ+3zc1/wsuI7g4fZ36QgQbMGOMNLM8qSsJXqBFwzVcihox+0IDdtCv?=
 =?us-ascii?Q?2dQ+QJUSUMezC2ypqnsDxV6SBLx4GLt5TeC0PTCrVrErjBSJ4NQv32OGN3ES?=
 =?us-ascii?Q?Hki2bR9L49+KvAr40wY778hRro+rjJlCsN5ZXyZZKux+t1DIGYlNcRM+u1+V?=
 =?us-ascii?Q?RHiFxdfa225DO4HrdhkjVYNMDTqYkWfDggMVlszL110KNpujP8Yjv5siSgTd?=
 =?us-ascii?Q?kCf7MqJORJgQ8a2boL4woCcIIR8keaFndJTidUSijajC79DpSi5uZ4u+HNpf?=
 =?us-ascii?Q?IrSQSBl59I9kIdBxbe/lHcwNf9idC1M5UHkssAXaVz8qerNuMnqVyHP91K/U?=
 =?us-ascii?Q?vfNzFMTvRxzDIAH1uN5LkJR83ScWKAIAgIfnCqnoLIeSBtAqmXaoMH9/Ngen?=
 =?us-ascii?Q?8WzYjkUUq335/bEbVQYLHbooCnTRZCIgr7KZlgM8SVlZ4cJ0sy9XpcVtxXxJ?=
 =?us-ascii?Q?MqqbfsPUWrPI8Lg/pJ/FNH//eXyVMio1hi5IijlFxTh2x76uETJYel4MshOw?=
 =?us-ascii?Q?kpytboOMtt5uGtjAaDOiCoCP2PsfEineZVRUKpZCwvlVF7IEqqvqNr9bK8MK?=
 =?us-ascii?Q?9+n/rYP/fvG5iSbwA/9tz1zL/iem5asHvboUtKOSQf9qNckpblyRyd2zs8LG?=
 =?us-ascii?Q?w7JGFa5FowXYKtMnLPRPApxm9uLBwR86+lNXTrpIYjFDEcQq6o88mvDgJMhP?=
 =?us-ascii?Q?d06wim02pK7lP6v6wf2Mnl2HUswzjfIo+GdIUYB8sbquX/EaMSOwiv0hbW8B?=
 =?us-ascii?Q?SdGxH7ZBwk+Y86zK8KojA684qGqFsI4AaWmDBczUk5RysZFykjmMXxB4j8xX?=
 =?us-ascii?Q?GwbIiQZ8UBO08xdrNpO1NXuDefWxd290d83DwwnwNpyiqzNEa6mhLZ7PTq63?=
 =?us-ascii?Q?UcXgqrignkzKDV5s3sap5N47khDhJ/gw2A1SHfVL64Gf2eiQz6uMfuSTlGG+?=
 =?us-ascii?Q?kTPf7rR++OYWTlUp+I5+VjT1G3GcNVwOOBOyC4ld3OKIx+Cb8exA9A30I2/P?=
 =?us-ascii?Q?fTyl5kqQ3RQH+WEtOQaJ99jVbVIm02WCX3/cM/dKpgxxbLQ2ti+pS9oH7q9l?=
 =?us-ascii?Q?U60U+mx/NdPyI+gS2M6TWGvezTF8/2FTtMiY5+JkKerzlWhufiZMIG/vbS8I?=
 =?us-ascii?Q?+M9zRJr6e5cyZSbnZupOom0LQLIJe887HuGc737Pos1gCNLzSsMXAg9IrTie?=
 =?us-ascii?Q?KP6Odk5p5JftHtqn7pXphmrwu7ldcG5eE87LKtk+0KpFwRjLQWnFu+kbbwuK?=
 =?us-ascii?Q?3C7bj9ylI7ql4vVCIfKKF1PNrB8HsTlo6IYSiea3xbrYizZTxpeMoIXKh+xp?=
 =?us-ascii?Q?gceUlOgH0Cn3QheViAiDbTzm14n7hO5B0+0ep7OblVuM6ivAb48OMvm/L1oF?=
 =?us-ascii?Q?Y+gsZRNpdu+fy9gjnBHil4x/CsCzIGMswaRs+Vq9Xi3KNnkENvMIpG1seY6/?=
 =?us-ascii?Q?Klu0tTDwqhWEoo8Nt9OTQL4Ob1LTUl6DzxiI3Oa3vK8TQAvWeXCXnDCBSL+Z?=
 =?us-ascii?Q?nMUQkirmaBOaNTFWskSGmTxqEZOEaCc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20353e2b-4845-4168-1e3d-08da15e0670c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 02:11:17.5020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MWY11KBoCn7CvsRxocday3meC0PyzdB0ifJtqKHGDfFnG2DtXHzyHiKnaxk0Wdz+IxBV3AwCcMM7RVfoJAH8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7189

This patch implements the simplest MPTCP scheduler, named bpf_first,
which always picks the first subflow to send data. It's a sample of
MPTCP BPF scheduler implementations.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/bpf_mptcp_helpers.h | 12 ++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 30 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index b5a43b108982..5135eb6710e8 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -14,4 +14,16 @@ struct mptcp_sock {
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
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
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
new file mode 100644
index 000000000000..21890a60f9c2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_mptcp_helpers.h"
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

