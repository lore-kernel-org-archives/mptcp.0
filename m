Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4CF362
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 06:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654066037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SXoPWKRO4BRSq0k59Z6b+g7NFC9HuCQ3a4BYMVPSoE=;
	b=Y8gVE/ouWpwJDRZ7u4HGJJMXvSTEHED9Z6cVPCro3FieAAyxuXJSmZQ6vzrhbbsgs1c0Bz
	JOUtpVwHbUu3WfRy/6hqqoS+iCpozxdPIIv7Flnvps6Xb4yB32NiIxi9iHm//D0YK+s0nw
	8W62RTUC/E/sGnTWyWrUdl91tqjPrTU=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-rwomZzfFPXOOjdQ5I-MHTg-1; Wed, 01 Jun 2022 08:47:16 +0200
X-MC-Unique: rwomZzfFPXOOjdQ5I-MHTg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iz0NFn57mrcHDKazN1IxSk8xaKqeLiqC/55crWztoKtLByLxZjUdlhDOtbbN1y/EojlxCf5tGaxVvpkllLP+vnh8ghta9noFrK+WuWDpwQFEi0GfHtxtYEgVRsOk93z8Xpxn+otOp6s2mAnSgmVZ2iM4OVWMew1dIgWiDTGuM7qeSzWqfZMIYrVR2KnwTt2uDoF/RT1J5nCeqHJ0kDBbcyPgGhcLGTMcwZ3OG7HRak7VynK1bjvepf9nPXIa5ADGUOd8DLfg3NWY+q36upVwZEyb77D5Gy82fL45WuVzswvGrmUkqZjnxhRs3rujeU/owi70y5iRg3qrRE9sSc9Qyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqibEQ/TbMetM/fzNMrN4bdtnCavo7ZkoF4SDeW3tgI=;
 b=CPbd9Lwx0eXDYs6XoLoytAOJjvh2ak7FnDZYuuEjTsCaHle1t9qPzwsR0hSWMGPiVHIDzjEZJ9pNAaxS67my1ncRdX53HxFrYZTgVjmibT651uDsgLarYX8CnM16GFlPMtM4ZBMSui0Mz4+OBiAlHvZYLtt0nLEKVF5YnGGYXn8lq4JQWEF9r5gzhOCU5ysdu2dbVZ61l/nxjFEAXLIxyhBtQqcJ+MKOVXlIjkQeN40nQpBqTKlaHY6zfYTGxG56jMg0mDfaoDGWEOFBsfJG1oxMnhgyQ/yrRNOj5i/iILJWBXDFaJxve7gt5/n2xTIxt/Uqz9egkuAMbpAObJQ7yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6904.eurprd04.prod.outlook.com (2603:10a6:20b:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 06:47:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 06:47:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 10/11] selftests/bpf: add bpf_rr scheduler
Date: Wed,  1 Jun 2022 14:45:59 +0800
Message-ID: <18816df87d7d36fd8a832b191b28ab34201084a5.1654065674.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654065674.git.geliang.tang@suse.com>
References: <cover.1654065674.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0049.apcprd03.prod.outlook.com
 (2603:1096:202:17::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c84107a1-bf96-4f09-cf83-08da439a905a
X-MS-TrafficTypeDiagnostic: AM7PR04MB6904:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB6904EEE258DC7A3BE8F48A8BF8DF9@AM7PR04MB6904.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZXNXLYFTbxSL73LTbc4SyFCgzwYS7Mx4CaEBKOLrfRZqwPvjWdG6QrZb9sm/p7bcfKkDkjbcTr3XhY0NFvm4JqXgOFUuX6cy3fUj3YglmXY5unBBA/u6B8l/fjeZ6b/EkmMEtL1/KtohUP5VtRZGvFEhXsppt4xZuZrQ5EIYZgrYzxoCqEaoJIW6N3OLCoBJ+ndwcQrwTt9FSeP5LnCiVI+vOGhs9jZEZ+OSaiTCZ0WtR4s68sVnVJtl4f1S8e/GhV6jeJ/4HpWUqRabyU/mzYKP0iQJ3OMWLEUqxGJoUm3FvPzbG+J5Yq2hY1x5Ve/tFdNfvukfNuG/YenGB3mJVSvqtWG/V084Ivz6hzrD86R9nBijKsKeVR143GQiLV5+1/oeA1ALy/Nj/NJewhsj9OLuTfz/bNf8+pzjWxWhxkXd9Pa5801w8NVZLWMXpj8oWEf/AbZ8DVrB0V8NWouSZ49lfYDP0UgAexMOL14uYb9OoKLDcIFXZZWEioUQ9jUu83GmXjX24ccTO1+pYSYclN+eYEqEuEZa628yDllwC+r2Pjqb6IhVxQVrIdezjqDNVnIMtcduPwWnpUwuwMBAUNAvoBdQF4peMAv6C/g2Z9T0DcTCarU2EkGWtp78XuxckbL13i/Xp/xlfD6A1HS5S4i8WSwn9guRR9KfVc0lYRjolgSwignaBZrwLPp6HN2GQWSPZ9aYgEJ5mnq0QzQAtg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(107886003)(86362001)(6666004)(8936002)(186003)(38100700002)(508600001)(5660300002)(44832011)(6486002)(2616005)(6506007)(6512007)(26005)(66946007)(66556008)(66476007)(4326008)(8676002)(36756003)(316002)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dwfIJzdaaQOpjd1ydfXUe6OcB23nTc6Wu7wqC/tWUzp7W2LhfXuylwr0HoX0?=
 =?us-ascii?Q?Gxlt+wmTjGJsyJ1j2uhBeXNZH7uhNs2fFo7M5hDCuI8HAuVp/hEKEpGi1f+1?=
 =?us-ascii?Q?drtoJKKz4BxiiIYXtGCzbtzQMMQk025959W9HLr13z2LohNlmfqFYPpFVLCR?=
 =?us-ascii?Q?jCNkFoufmuPjdY48ReGo5jUPya6iZHDA9QSAMTVqAA9dbhoykMiFsz4xIjZ+?=
 =?us-ascii?Q?Gr/259QbO8RSwzkOmyrjKp3AjOo+uuZhMh58cMbBD8f55ugeC6iaKIh0X1Vi?=
 =?us-ascii?Q?4NYWucoAzmyd/a0ZtnIyvDuWi2vXJ3PwBbif+Eioy3iTNcmrInbcWx0cQqvR?=
 =?us-ascii?Q?rqWvFjnWpOumOxOjR5ZJsOsf1C+2sO0p5Hhw0VD0aG54MOrhJh17+QnRbmP2?=
 =?us-ascii?Q?S9q5CArHLz6bRAZxYO3ws8/tLezBZU+sk9dkc53NkXNnlaJ+Sq1wPT495mBv?=
 =?us-ascii?Q?bbMLeiEHaY4QdoZUPp9PCuUZ1HKA0qwHDYc3I80UIUa2XHW6v4+Rl4mnAUW0?=
 =?us-ascii?Q?RXD/iUAMwMB3yUGXfYaGtVgcdHyAKL3v3MOJ473Xqt3zYfc17eJOSMk6q80a?=
 =?us-ascii?Q?JHJihZYvWTHyN9O5k81YUCAuyX82GgSLrxeqfLsKQVzv0xZfuODQGwObqJy4?=
 =?us-ascii?Q?Qc1phR8QC40QlPxILEdXvrIBgCjhOAKgTWlvSHWCE5nI4YQan9Jq1S07Y+gn?=
 =?us-ascii?Q?3QGAgsXAunw3gi7xoU+DK2l+twjL4BdLGRV2cP+QHhLI3hqyPWyMTVHiWdBY?=
 =?us-ascii?Q?y52kUJcIK73SHkD8Ph3+24SDby/N4HGEBzb7p66lQpqY8Jzfw4/z5A7bl3uA?=
 =?us-ascii?Q?hTXkdCOSDa11d8g1wvtct2B29Yw6MKjAnL+Gx/c/EvY9kyo5Ptilh8+j4nVu?=
 =?us-ascii?Q?txpNa464snPFtKkIAt/vsfsDFiAN/9Xv16llVc1pvizqQjRoN/MC9c1Yne3u?=
 =?us-ascii?Q?c4JI8w9wyqP+aosxVCDFDAlOOy8llvomZObF5u9fQbTICkZJ3ujk1pMbVnEz?=
 =?us-ascii?Q?MKAPsZ32vDd4K0TQmORGfqs9p0YKV+yK7qVZp4VhridDhIFWsvoNdmDbe24k?=
 =?us-ascii?Q?pa0HJHkGrApkFCVhDprfgIQRf1ek4wx4JCSKEMm+fnol3crVyXYKFfPVwS5s?=
 =?us-ascii?Q?jdOZD8kl4BKK/rUiJsZmJwcEW0xZh3Jm9Fqlg6gDRRmTxKfzLS07MO5ELCYs?=
 =?us-ascii?Q?zfMxzDU1YwCn5E2YcXmhW6taLbF/jGhywt/4sbuqR9xV+oWJnrEU4CFW4MW3?=
 =?us-ascii?Q?yKqMihMuFApfiVYmbRzOb0R3Lxx8/8tGoI65vuy/HsEPwnasanut/tsWWpQJ?=
 =?us-ascii?Q?2fXXNAa73RlNbehcf9Z8+luzMoTJ4QrR1QUUcN3nfPTBX8IKlxNLI6JsEr7X?=
 =?us-ascii?Q?h7lny4lvJ1nq2r+LtBTk4enWSGobCWAuR6ytWOlrnfzV6BCOpAfkBefj7e3n?=
 =?us-ascii?Q?iU57/dmj7EcgfdGDUyS1W0fy9nFC41mA/VOYTGnTpgd5xShGuWDxO1jd1XXA?=
 =?us-ascii?Q?wLkXPLfnxfAO7lh2cgunJiaqgbgT1Hm3RNTkCgTPCewmsgzolzu2Gfng9s3x?=
 =?us-ascii?Q?gi+f7wLYYSOB6LsY8EN2Yp8lEOI5W7Q84u/bMh7qIGl6rv4KU5jID7ZrKlxU?=
 =?us-ascii?Q?csqksVz3+3leV7dk3Sh8KhQ27biIToGh5nbgtkj5HsSCTBzRnplnVc7y8ZIl?=
 =?us-ascii?Q?VqWoa0+PzBS5wERcyUB1IBUWwaFA71F6jl/hDFY28wlBpWdcWgWjYrPu8/K0?=
 =?us-ascii?Q?gyXMFHZEiKJWGO3FFtB/I1x9FIwUuUU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84107a1-bf96-4f09-cf83-08da439a905a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 06:47:15.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /C1GXknIv8hvXa4dsfn1lZ9WTfJCeWF4yp9M/wuV+xJFgcwJXBWt4ivehxtM8uz8OQKPIL6fwp3f4GxpYowSfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6904

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
index 1f8addd61f14..928f34cce4ce 100644
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
index 000000000000..c59fe2eff420
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
+	bpf_mptcp_subflow_set_scheduled(data->contexts[nr]);
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

