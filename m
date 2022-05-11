Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB44115B9
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 07:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652255873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h2R3aIfRF88N4fKuF7WMISdk28j88e6veR2C6sFhhHg=;
	b=UOYgGDdir+jFXEKamZU6iZSnHS6kiRDzyJuKrYWIKBK7dVO1alO03b0TkCieYyJJlEOWcx
	lpj/kaoe/KCfT31ZVJxLQFWX8WFizfOxvxSz3BlGS2LmsIUeb7VqVWBIp0X5y5USncfj9+
	9n/aJMoP0OUcuHZUwsEwr2MH5SsJEr8=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-HOMkhzXIPEuv9rXXHIHTVw-1; Wed, 11 May 2022 09:57:51 +0200
X-MC-Unique: HOMkhzXIPEuv9rXXHIHTVw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/ApQIB3lZNtAWKmWEHKtUdxyfJL2j5hsyoXwg4LKIdmpgct5OK3wd9pWEu4f719J4siPnOOe4PKZzVoA5A27IwzgcE+sAgjkHyjqe4IWR3tZgqfkdKLKxTw0/NBO8pLMiy256WRwCAAzN/LUn+OWNrBcQ3B3GQ4qiliZZ1BFsuomw7A86trpr4dBEbQFtdhi798rWSYtnr3reOHyKjuLLQmDFFK70vQ2ezBYO3eXWF/b4L7t8z1TeRJC5FLPOPTK08ATpB20pC/h/1E3S1kKMN2WDMBwWp5f9t6SxosQI6TldyutSYx9onizQOBtYMM336NUpMW1w0OZ8r5nX8FnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOMM6qvB5KWBoElwhlSGobiSp1e0WnPwL2Y/XX1dHAg=;
 b=l2027g4hTV3Ns10gjGgG8krZ3cKnqnlmLyvu7VjaqsHoJM/R4x6sDLUHB2TvNrFm8LEiFHMXzeGrhh7oG8ffV/BA7jV2n8AtFOOwJUuHA6RXt7NpYMpj/1kE0CJ1kOGYIlL1ZFJab6gIybRDaHHJyP134A0wK4wcWhFcFMFluHDSEdtgumzPCX6PpYQM8RWndZ0eBEukX56KUh2KDSDIF8bOv2pNVew6lKrK9IKF7C5XW/e/HX5iPN2CbacMbDD01rZAqSNjEBWBM7y2FNUuo5GXfGvrJIJeNUkkbk3ujZ1S1vGeW0XviL3U6/GTEUmr93Yaqv0jQH4r1U/w3nI/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DBBPR04MB6169.eurprd04.prod.outlook.com (2603:10a6:10:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 07:57:48 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:57:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v2 13/14] selftests/bpf: add bpf_first scheduler
Date: Wed, 11 May 2022 15:56:19 +0800
Message-ID: <e95e5e35aa1d98c3248cd965f1fe290b912ed94c.1652255616.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652255615.git.geliang.tang@suse.com>
References: <cover.1652255615.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0235.apcprd06.prod.outlook.com
 (2603:1096:4:ac::19) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc6c967b-9a5c-4155-16f3-08da3323f0b8
X-MS-TrafficTypeDiagnostic: DBBPR04MB6169:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB61693F9601A0D0BA1B49A28EF8C89@DBBPR04MB6169.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MxOXWLgnyKQ2FJfllI/P7fkmiVmtlFVhMqFF4qQE2qOvAZHJKHOadJiYVrttbzBORORZF0Aho4fTSkcbMdWItSUembB91eH+WicuIF9OcYxFC04zJ60spiR5g4EmiXRI2mGPmEyRHuSh0uIJ7WLhMRXvNsXaAWeYDAFJcJU2F3fPgt4iZQ2Gjk4DY0PE7CIM/n9uaIV2peUEeGNHTmSUdIM1cxbutCoj6mSEKnMCJ8xaGEEXm0HdrAis3ofNrPm9LGFd6rxMMeDPOXkAvmJPZwF/LyKBx65Te1tPmhCbuCShkGzUInrpBAUTRSBgQx1yzQXm48yvfwmgq3DOT8iiteqXNfRDHpHPMHaWlfAESDFPl7zpLipSrX3+frrh4JI2qZISHBFB8ZIog3yHk8sEe/aOzAsAPC7ERIuYUB3QBVBwefLxVpwevySF1+a39j8cYdjMQ7X2ocdI5dzLvAbXCmZO6odNArWnuSr5eaktkCY/zSXubmumVkoFV0Tx1jBkSCCwoil0ZQyYOWa/0j5dDG7v1Q8UJDyqqa1AmtZAhNFHG3XuSGJMDGBKh5wkETGDe0NcdiknJhgokf43tsUkni//xC+fArMUOzem4rmAJYNFO1MZ5JeZrMMkT9lG/GxzPIc5Rnz+fwx64ea8ayWSE5A5QWZpCIPyjy44hXvArwILpef+U9FZqXrqkfeh5XPYhuxUaTcEAg/cJ9wz57gjDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(186003)(5660300002)(8936002)(6916009)(44832011)(54906003)(26005)(6512007)(66556008)(316002)(86362001)(2616005)(4326008)(8676002)(66476007)(6666004)(6506007)(36756003)(6486002)(2906002)(38100700002)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ASAu5p4LFrtLFLP7zXRYzjsZXUCezkpFTiNQ0iNaPVDNMRiC3OHb5djqMCDA?=
 =?us-ascii?Q?rWa8Tf4FrP914PhqDMMwhL27hGtzMxdqbwFCqxsZYbTfzdUUt/yXeli3/SLx?=
 =?us-ascii?Q?wakjsOeGmx1SXELQGHB4CaICEgaiK/xeZ8qL/S4tioDu0t00U7V4JN8A4WWk?=
 =?us-ascii?Q?hnpnwqjR+gxxqEJ2ZqqARGwXBUeiRN0n6f/HvlRcdYgu50NjUboRUeflbDvK?=
 =?us-ascii?Q?nwfWtQCJlqP66Xsx4K0IUE2+JZyKysH1u5RD7B7i0S3rOJur9GdZb+vG60ez?=
 =?us-ascii?Q?LS8ZV2Fm+FrpoWirPI/VblV1blpxqDHIIjz4XXRi1SLRlz/2ektOTawx6eR4?=
 =?us-ascii?Q?cZa8Gc2aQCYZelFA6GRoLmWE7LMyxtgRWEgsfXzhjNmelBd0kZEAnaCHUZri?=
 =?us-ascii?Q?+RFVhHHdJmAQuIcxusH7PmidnfljAldcxK4ja0BMhMNBESZf5VJwonL5tl0F?=
 =?us-ascii?Q?4P95f74cD/6z7msyXesdI1D0Dz4FsgT3N8Rrm522r9sP1DVgQHpPeeLvzrfr?=
 =?us-ascii?Q?6CPd59Ftb80PplZ3oSiao1Mc/MqnimyjTXKhhSabnvkD4GCKwStpEyoxQTyS?=
 =?us-ascii?Q?9mU76qINiLrlgIzGJVNLRT826VzRXOL59oTH7m3RoolvmXWuakqoL5Ajdkxh?=
 =?us-ascii?Q?8Pe5kAv6L9IF73kGBheeF6CPRLOjEdlMtgirIQLIL383knCRhUBs4DazpDsl?=
 =?us-ascii?Q?hM2fwO8krEUG3BKamYJgsVk1W1bKxNxTuqZFJZAM+YTVU/SrZFCBSSv983bd?=
 =?us-ascii?Q?oKUgXqbAYKfOWTGwt+Yc1aFPgkTlocevwC1JKFNy+JiI8vegkPOD7IidNy8H?=
 =?us-ascii?Q?6gcDo244guh3bOGdZKTohZh+fwdZjPiAYxrPiwN/s5raGrlV3vYgXY5RN8yl?=
 =?us-ascii?Q?YOKMRk8DLl23VkYmKDKDDmtX1AQQS2ucUQ2MAMdg+DHgKC68D0TmpNE+N3ae?=
 =?us-ascii?Q?2fentZym2SYb9F0Txa///ZFOAuGqIEZh/16wrj4LwCOi/Tb0RLyKDIt16VgM?=
 =?us-ascii?Q?Co06AweAEzZa0NajqS3SdVZBC/7WV7k7ZkN+0h+mrAx83GIDcAbEqeYii16C?=
 =?us-ascii?Q?+EC0Z/Cype2183a3psMbcMxx5fkSR4mNsMTVj7WScVTnSEBef0jfXIgRkW7Y?=
 =?us-ascii?Q?9OHlAZ7UFaRJ0z8PwN10Oe4AS/8yOjIkYj4Gioh+uPIKbVsw4/c1u9xDEfLJ?=
 =?us-ascii?Q?1Q0CFcMo9+s76+wqdlblbjT0UIp+UDTGGIarO+OkVtMhxS938Vr3SJ70f/Tu?=
 =?us-ascii?Q?1AUpISdqZB4gNgIaOVWmpYQ1CSyuKlqUziYmNuFc2mpxg+mHcc9UtwkTxAO9?=
 =?us-ascii?Q?dGDUampq3NVridz9eQ34od7lvUr1kTtFyhzzpjzP6f6bHTt0hHjBNWhk2qAH?=
 =?us-ascii?Q?57Pi6UyFBv57zwU07k2lA8iVw4+KP/QOnqMVu7o3Ci7jsjiJfVjZT7O7WSvS?=
 =?us-ascii?Q?W0ljAkKnh93xLPuyBhKpBlOXD8OdOVg+0S+Z24cXJKHCL0BtVqzVj4eKJDGl?=
 =?us-ascii?Q?bnjh1S+lY2/j1+arWbKBUvHhn3YfuRv8HKQpPb6nWfIAJui8f/bVGd29lqSV?=
 =?us-ascii?Q?jiBXIbjkKHAupt08AsyPpOujjM8hyMmI8/aJlJKldGZhRPm2WsbhyGosx4fP?=
 =?us-ascii?Q?kUU9KSqcX88Ffo92qAFkd6+tFfza1RpJP8/E1HFbUyXJ/OkK/QHT3rbbxw8e?=
 =?us-ascii?Q?t0K5ViZ9BxCqvq2SR7Y5OjbL+y3IQEfwPP3ljrzfOhehYlhi7oo0ph9W6rXR?=
 =?us-ascii?Q?Fh5Cr3e9CE+14Zi1kdu8pV8qcp4w7/Y=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6c967b-9a5c-4155-16f3-08da3323f0b8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:57:48.4314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n14js8Qn5oENEsML+DUdySWsAmFuSiExNoy79eEgHfyf0VpQKcVdNMB0Y1SQMaXtzeRWFfjHFz6NfB1pNQ62gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6169

This patch implements the simplest MPTCP scheduler, named bpf_first,
which always picks the first subflow to send data. It's a sample of
MPTCP BPF scheduler implementations.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
new file mode 100644
index 000000000000..fd67b5f42964
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("struct_ops/mptcp_sched_first_init")
+void BPF_PROG(mptcp_sched_first_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_first_release")
+void BPF_PROG(mptcp_sched_first_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
+		    bool reinject, struct mptcp_sched_data *data)
+{
+	data->sock =3D msk->first;
+	data->call_again =3D 0;
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

