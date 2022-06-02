Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33D2622
	for <mptcp@lists.linux.dev>; Thu,  2 Jun 2022 04:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654145713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOEPPEcFgTIwsSWwuo4JORywH86YzX7fEFk6FKFpZlM=;
	b=GB7d2+A35Yo2WkuB/Rj5SPZKyLeY2rQOwMJYG5T3r75gMBQpFNhoBwVDEjeWPlXWfUURyJ
	exemRkxyL1cUDPrZOxEY/VIsk0eV1HZBPNMDZdiU+E3hq9Mynrtp0BUWV4YksiEz9A/dui
	KGzt58aKKWN98wlZ7wyfkQ2lpwrL1Pc=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2058.outbound.protection.outlook.com [104.47.5.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-ZlQdPi30O1agQvMPXKsY7A-1; Thu, 02 Jun 2022 06:55:12 +0200
X-MC-Unique: ZlQdPi30O1agQvMPXKsY7A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTP30F0EbmEINJzPEvaHaURxF+uypcqxHqMWU0WKQpYfsU88URX+S3iBPloCVm9rwNYQfE1VsngHP8xSh9Xzl9iqzvrfqXhvUqw+YHnDH2twfE/H6LUX1eqiyUoupb6KneNT3BQ7rltpgWgW2GBHaquO6kChf/Um+sjjZVY6JkCfU3vMmB00T0lNM0/05CvQ7tJJizd6F+NQBsad8TadVEEbo3LUgQSZdtsp69ajWk3EgOa7yy1GHDOL+QMWZJn24/CtPP6LV6gI6UvcRIgD7AGGDfBD/5mcY2N1Py5wqI++ly4+mGJOZF1mpq6vnLJlQxdx2Jd89278XAjDcwTk9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juzsboByBclRYgIGDgxMMCzLpQVw4fwsSARMfkdMYog=;
 b=du26dHcoRs0CUPh+NDUObx+hLDsrnxQOBx/a/nuj/OZxrujcmO9XOGncgkM5uXOqLjqIM1oyoe1VLi9QVjpVElHuErVEhNVbOmolu7SwIED0bsqJEor50GtfyoYzszBw9HLXT2Be4aTdwe7ARnBkambb5ElyfwlP4zzp02RXHEkAwtw5zxRNAqiBevtxuR6FKiljB7u61fhphnwMdyn0i4a0eTIynrMMvSiNRTVwiEJjqsUI4vW1Xfc9LIq054KIG84XWZjrbxi85X9P/hmPhT5lTRTPwHApHyKNBN7nqYSyUtEF/xrugp2hzF+XWWUEaYwOTWG4f808/pAX6BsZpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3384.eurprd04.prod.outlook.com (2603:10a6:209:6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 04:55:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 04:55:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 10/13] selftests/bpf: Add bpf_bkup scheduler
Date: Thu,  2 Jun 2022 12:53:47 +0800
Message-ID: <b2535d3cd7693130674af8fcc24f828a062769ae.1654143895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654143895.git.geliang.tang@suse.com>
References: <cover.1654143895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:202::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81dc949c-e22c-4dd1-e240-08da4454128d
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3384:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB3384F6AE609A9FA090F87AEBF8DE9@AM6PR0402MB3384.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dEXE6vYQyaFZoHR6NaQEIN1AxxXpNf7aqunWOw7oRgW2sOtZycXiq4HUBsssq9ZmtLV2rXtL9Fq8Y5B/KyYtLiMKQ2TU8dp5F/mi9bFJsxWcJE+g93ziJsGElL7MgCTBXBL4SKcJs62y7TSPVj65ExIOBc/tCOR4l4Py5c2gQ+2UkdR1d7OaDQlBiM95zl2ipxOWW52sgQc6FDwOu9S9xMoJsCsLwpgMbBbc7ZuTwDK9NhQFB/vocYeV8Am/+OpWA2jdbY7n1Ihu4OXaZD3xVA+Jm5FLefkMIiEISVCRlRQtqhMbTb9bB/lpZvkWL0ssw5oDtPHFy7l/OdN4+8EPpXLEbxYCd1HBEhy69crJWVW2iFcVv+w0Y6FgLAhH4v8ay716/eW4Ywi0P0e3fqgmK1OF5+PvERKn6P7yzIug4xgk7GBhYK8mYAZEkde7AnYz5QzRhMNDGCvUr8SPkHp/a3sElgq9Rc5nI+KrpFBhggQNM7b2ScB6mSUBQ5LIenTl+RLwSMx6Cy9nfBSnSr2BgqIBrqb/vngIcv7bb15oJI8IDhfHgNaa9PlHqtQfve1+fV26m5967W9IbIsK0r7WJwnADvwcJxamo1igT5afiWLvIotgJnVPATEKk7mpqaIwLsw+AjiBKc34CcQzLocaj4QzwAtEjkJZUxHAXCXFzE0FfWB2u4dkdLNxG0MOZL4cPs31mIFIqltqBFj4DbNHaQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(86362001)(6666004)(8936002)(36756003)(186003)(4326008)(2616005)(5660300002)(2906002)(107886003)(38100700002)(26005)(316002)(66556008)(66476007)(508600001)(66946007)(8676002)(6512007)(6486002)(6916009)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NL/3pdIE6uvQ+VuYBhPtw6xHjYuIHHS0igsQmSRK7LpZ0FPI2j7Gco0F0Lcn?=
 =?us-ascii?Q?4pHaoSbXbsi92XiTTbfigsrSRtMMn4iWBWukHmoIl229rabiuoQ9SxsIQkLN?=
 =?us-ascii?Q?cZl6f58V/hHM8zaRo84fJpRLefPIhLO8WIGnMtzLEsnvKmwsFAfPCGibkf+U?=
 =?us-ascii?Q?twCXJ89gWDoPJ5Ejar22SvQRBD1YnBqQv1tZOVvqGmQbadjJ1hD1M64gfCIs?=
 =?us-ascii?Q?ZkETaFFnGMnvGf9/65k3iNsO0bmto2/MI1aUlPHBYubhpntfEm/h247f2Nlj?=
 =?us-ascii?Q?nGTNy8yDJrSSidWjO9lhYOyX1JhaZRhRWVK7LHKl3QQwE1d791dPt2m8fy0d?=
 =?us-ascii?Q?ULSdv0rBPLUZp6bSWTQN5i2T0yoFT000p9mbW2kpyVRo7jl8eCe57+5hhPEv?=
 =?us-ascii?Q?5VUEu+pLKFpv5tLaA/dVX2ze5VUMQfSBdcJdtlD1DjznCrEXkhX92gXv9+4a?=
 =?us-ascii?Q?Ltjjg76g4VIt4iEedBYYfEFuSDjxLxMLAsUiG8FkTtz8vAghTIL7PV5SAdyD?=
 =?us-ascii?Q?/RyriK5PElgKblj1aVkmRWwWQQrF+AuNue6kTgW9zjSAi2HFYgyN+SQYI6IV?=
 =?us-ascii?Q?6aqtkTFQeUxVQG9ZfOuiT4oM2km+/maqhg1klnmpfbMOwgNZfaHnbry0gWCp?=
 =?us-ascii?Q?4OR8Z3E8tfny1oIOHAq+H58F1Pp6CFYQYodCqUOdtgmk5PDp9URFrlYwHvb/?=
 =?us-ascii?Q?WG4P/cLipUSJRaO/ZtegQMLsMdSYZtO0VAma+kKdhNiOowBsoaIQ16IDfZL/?=
 =?us-ascii?Q?prI4fDNhHIJAdg2wJXeSVnNPReB4r0+PfzU9R4ESDcRUjnSTK1fqGO9NSvEA?=
 =?us-ascii?Q?Nn8uh12LZAf0KZ9pTaYRliuaGLyBfsZuaLMurRElHM5wZzUosa31XMN72+hV?=
 =?us-ascii?Q?B55Vt5GyESB1aJCpeKKteR2UqQMeObBxfjwpf2PIXFlL4kb3ciasIS4nUgGw?=
 =?us-ascii?Q?x1lQhkiEvr2oUdSZ+kGkCzC4RiFce1qcz5yocryLR4smqPruVU7HnZZ23qpE?=
 =?us-ascii?Q?laQ8yM6cdaiUJZK1nvLnqF16gI0DTq0gmAw8AYi9R9nvz7IAiRBVWOHNLWR3?=
 =?us-ascii?Q?iJvTAByl8wiw4egNgqwyY1iwwohtDWP0QS84AoRRiqJQwarBGfkEYDgpRGS6?=
 =?us-ascii?Q?8lPZqyyG9zNQlkGa1ZEACdSCgXTtpoqlAAiEq2fnFG3lr6w8vtH756jWtybo?=
 =?us-ascii?Q?/FK8lc0nJGBDET9psNw9upBXJS3Zq9vsMy29/BgHVQTEj0bUdxjjXn20okjk?=
 =?us-ascii?Q?z8l2+vkEuq0xEps5JZpk3bnhm6Mp0YkU69JayUqIUWynl7cXm6IiQfVxd3O5?=
 =?us-ascii?Q?gOTikWPQbNnfBWuZ0VDpRoWvUUXnciAkmlgeMBGdLJahtU72op3Tl8T+Ep26?=
 =?us-ascii?Q?iizPXIg7Rlr8Fy14GwH9krbtg777CjhPQcnga+aXAHYkS9n0Vf7X8lwMbPj8?=
 =?us-ascii?Q?N3FxH14apnXDbFO5fRpobT0zR2Z/t73Sguez0aOshNZfIJ/3B/5E6OltzfxO?=
 =?us-ascii?Q?irtXQ9qK1utLJpLgE9+GB4H5DEgihhufcN9ZennYGsRD3zIOyXEtDAAIabO/?=
 =?us-ascii?Q?MBb1QB0O6OGM4NXJ7+p/XAsFoutVwKkZc91HqkHXBqQrJVUzT+zsWtrvtds7?=
 =?us-ascii?Q?BWJyMkP+kh1Wk6L+VdPfpHChZnADry8cMDIMiWHpQw+3J4qn7L9a6sbBgDmK?=
 =?us-ascii?Q?onBpGOOrOjWPbNNLASJHm0yPreHj7ED7+xNxwGQESBiVxO/GVXVY+89V0XUY?=
 =?us-ascii?Q?wicqWesOQ4rG/v5cyxUmEMkjmasTQik=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81dc949c-e22c-4dd1-e240-08da4454128d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 04:55:10.8701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTcSanjQMoTJ9j7wxYrqZ+qqS65brrPgA4tS5p6Cq2nL9lm5TzshKYBHA80dFRI4TRrAycEInJ0sKwqHKi56gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3384

This patch implements the backup flag test scheduler, named bpf_bkup,
which picks the first non-backup subflow to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/tes=
ting/selftests/bpf/progs/mptcp_bpf_bkup.c
new file mode 100644
index 000000000000..949e053e980c
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
+		if (!BPF_CORE_READ_BITFIELD_PROBED(data->contexts[i], backup)) {
+			nr =3D i;
+			break;
+		}
+	}
+
+	mptcp_subflow_set_scheduled(data->contexts[nr], true);
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

