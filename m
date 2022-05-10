Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A877B
	for <mptcp@lists.linux.dev>; Tue, 10 May 2022 04:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652156641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4PR/PlBcOdN5w7Rs4TacuItj419fGxDDuTWJEjJ1OM=;
	b=LC/1lLqO57ck8pM+k0Bof2hco6vz9EyZUlB5GrD0IMDNM66h/ThgpvL1oj+UZykTWE7nPX
	0kV3IMHOIxhuQ76r3tuVaMsNsAjfahSOTAk/GrraTZv4qoksxXxhi4otO/B4vWgI7H6nhY
	nIZn4p1t1MuX8ptuxflfBYyokHgNzh0=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2050.outbound.protection.outlook.com [104.47.1.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-x4ekefOvOyqbCHVKy_r6Yw-1; Tue, 10 May 2022 06:24:00 +0200
X-MC-Unique: x4ekefOvOyqbCHVKy_r6Yw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vy/FvWPRtarVgJ/9HJPo5UJNRIDm69t1CE3/lGvHSGvalIdWAZq5QjXEjOKN879n63jj+H4qPTNxbyiR6bgEBcamrdtuR1iBiIx5wpFYuq3kbvQRTXKd/2cOUUDo480hXGYJmvRmSpUk9UiF7MYke3+G7qQVAZWW5B+0DJsP8mWdPqHDj3wEmqOOt6BLJ2SifJGg1wGR2U+Rd12u5Te46Q8B4eq0TyzSsWnoVUOx9CGWHV9pvXsTuDvlwQjdXuLiLOFzxIzfCHirgZAXs+GlIx7nvmT+OdHlJPJzsOOJqEhCrzqnITFtddjXX4Yf+TJU8QzrLelaS3pDdZJAZBfs5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvUpd5S2YTsM2NKWJgeMU25QnY0eZ0lKqoz0GuB+iCE=;
 b=FddSz8vWm6gbAgdEXPKIQ0mT8MXAm3XZFXNkZO6Sv4sKpOplsQfbYsV34LfjXWF7kS+odY9dYAlflsipX5YW6QG1dvyyOLtPKhz1oKV9MjkQbTuOCRYinB+K+QmglBhVQZaE7BofVDSnyTrLEwlU6MEIA6nvXodaiyoZ0lqZfZYzcqJHb8LnHHpBnmY7T7VrSTdAy7UpxNlxqlKsgBjHCxIrydi5St2PTG7NiHO1H0Qpv9U8DIiz02uxj/u6XON2hOnxo0wTBXjyZpF4Z8UZeV+ZUOWtey1UybgTRHLH5/gkKf8eP2hAWj3/Jtyh9L6rnFP3P5Z6SRogDrOpWFii6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB6224.eurprd04.prod.outlook.com (2603:10a6:803:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 04:23:59 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 04:23:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: add bpf_first scheduler"
Date: Tue, 10 May 2022 12:23:46 +0800
Message-ID: <173d7544cdc6bf773f6e84cf64a53583db6df634.1652156553.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6de915f94665491d2944dd7aab1e6f7a0f3abcaf.1652156539.git.geliang.tang@suse.com>
References: <6de915f94665491d2944dd7aab1e6f7a0f3abcaf.1652156539.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:d0::27) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec5b396a-8ba4-4c5c-213e-08da323ce7b9
X-MS-TrafficTypeDiagnostic: VI1PR04MB6224:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB6224D18CF349E37828165C62F8C99@VI1PR04MB6224.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PGC77yWDrXtnBuQSrnJeWvJ0ZnX1IjhdVPP6FlzMRyoPOmehQ8zinyt4RP+QSVPMt1cvRUZf4GDkBT0KpsNZFn/43OVwfrR8sDhFf4y1WvkGqVzR6MOvnXQcSYuKJQBFTibNQ2Psw9sdbxpU/w9Gtm93JjoKGn/lfNW2RGb6IEj5zJ/qvcM9mx5fpkPEw40BpsOUbvxdobhOkFUFhDX5410ISWGGUDvSC+FTegf+Kvt4PKN2bFBZLiE2GIXA/VokYwWU/pU6t5Bu59+VpyIXcFvM4R/VoHikIjVPmAKhfkOxO6a0ekSmckyC9YBg83KKXhaNnptw5ocxSdYwEy5txzn7YWwcoeTDvmO2a4Y7+JHqqDDfGRNQRx0Lzaqr3CcQmTKHZOcVLxHvyNiFNYYPshbUy+q1GfAv4b6GoZZ+3bXKbRmhxdhWiho+HICvPq8mtQw28OFuO6+6fxUs7tIY+DI05FanHF1y5lvnmsE8edBh4KX2z/3EZk6ilfVcPcKrurT7VBLNUl/Ip2Ti10RyMA//qXV6uDmCV43rFPWOzWIaFdasmQKYjWs9imMP9f7l8YUHRhUkLki7NmX7+oal/j3HTOFtfckl0lS/abvUsyFRxOLr52f5Z/orAOziQuYU/+4f7FBc52wtkiIHZ01iBbzQ7RER6rdMuRcp8vYOoNkZ229jHXsIQ8gf7HT9eRDB0rspqIvYTSg8WO235B8KzQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(107886003)(316002)(66556008)(8676002)(66946007)(66476007)(6916009)(26005)(4744005)(38100700002)(2616005)(4326008)(6512007)(86362001)(6666004)(2906002)(83380400001)(8936002)(6486002)(6506007)(5660300002)(508600001)(44832011)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BJXyC0KsqDpETteqtPNx2TxTxCusikLGu3FoSjKzSiS4gRzakCr2Ar8U6TUj?=
 =?us-ascii?Q?zHL9ZpQ0K8Xl2gXObbQljiyBhwoywbwrB6wx9HBYMNz9wP6VzhBdOonZPuD2?=
 =?us-ascii?Q?6Ws/9IS8C05s/oeOnOC8vI4j0QwER9RKjW8UK7XYzgrG+r3LanYmI8yHv/xQ?=
 =?us-ascii?Q?lTftcuY4KSS+Jr390cba5dnEWoLKmbv/nLtHW5YxG5yFu6w46ooxS7RakKD1?=
 =?us-ascii?Q?m3Sa3M0r69ixqWuKklEtl7j/ShA96yolDbcpFQqA+GDee/ImnbAwDIlHPed3?=
 =?us-ascii?Q?WF4jUEfU5orbLEgTZsZ5+Kyr0znltobTOfq08+HSMsJJXLIiNnewf3OkjFrc?=
 =?us-ascii?Q?VmQUD2Iu7ATIRTlP5oJMgviR5pQRouSYN2HEKydvBfCTNEGmiPwTnSAL+Vmr?=
 =?us-ascii?Q?0r+nRs2x5CMPYmyVYtY+xiVo+UQK2wBywTMoIIo8WJ0Vn/DkWs9FuVB4rgYu?=
 =?us-ascii?Q?aEVqK1hZJfHku4Sg6Y7MCVj27LfjQot08ml/blx4NquhkBRyBaa9Fh5t0g+M?=
 =?us-ascii?Q?U5TbCiPC705J0d1jCLcS//3DK7jSqUYKfy+W55g++Pdh6OPGgdOpg0j3zzh9?=
 =?us-ascii?Q?XSouTJrzSYaEcdRdU/sqKq1sC3BvA/aSejmPlJolYYLkvOCRaMC4Cre2SKAk?=
 =?us-ascii?Q?hj/gzvd9wNknrSMeDPax1k2D1GF1VJdzCxFekPnUCKEdtiRjdHvzdv3uhCHL?=
 =?us-ascii?Q?ZnblDXvQGhwt3YZCrTK8gmMXo4hkPpc3rmi5jZZededcj56V0kdAAGaS75ib?=
 =?us-ascii?Q?ZV59rM7jQuf9MC3qXsScbZU3YHLEO3Z0zRa8NfUH9YjAT3lqV909fW62j7wG?=
 =?us-ascii?Q?+Tz7JUSyBFjNJZ7RS0WGtvzOw23q1nCLIKNrj9IEA9M5vF7SRjrZtsbWIrJy?=
 =?us-ascii?Q?9yL8VaZvy7Ls5oril2einfdbGvxyui7qQsMd/XEvU7fP3i7fkDp7hTDu4RBx?=
 =?us-ascii?Q?jstW11i1R5kWwoR9bPXi9KD5zwdkZ8CyZBdsHlFfYH4FRS2cLJUBad6mW0wr?=
 =?us-ascii?Q?Ge2ayra+mDxUwIKnXJStCMSLx6TqXLXrzxgurIIKPJf1hohNc76ygDPrrK3m?=
 =?us-ascii?Q?gC1lURY7Wy+OCqkyK2DT023Y3QmZRH62iM9qoKutBG/Yq4//f8s05CGusD1I?=
 =?us-ascii?Q?xuHh2ELJpBMIDzu+MGvKMGsrdmkecSBZ9ClD6OmSuSxPFFLMq2CAmYb1JiiC?=
 =?us-ascii?Q?yJP+NrKrkvqtyP5RKPxf/h4pVMK6EqGowDKIeToG596EY2cdGPqlA4oNpQge?=
 =?us-ascii?Q?mscqt/BNShbVSumJQKGY9sMfRa/AnkZqc/KZRCQ8IAZOQaftsyoOCCozh9Cq?=
 =?us-ascii?Q?MKGvgt/kme43NohhCy+QWW/FbCwlfhxkD6IQoqJmCgjIfg84K8hi4W25C7Mn?=
 =?us-ascii?Q?U9O3LMjBOGkbicEu2OoViAaDQ3jmRioE9LPPkBO4EvL8EsnrFZm6OvWYhtlG?=
 =?us-ascii?Q?ul8iDviCkX4E/Q73zIKnrMBIR8ke3GQYcLg4Z9xhT5JlpQMoE/ew3p0tntJy?=
 =?us-ascii?Q?qQTMEN4ptTdS/q5rscksjadVFUaqgZyRNHsKNBEYKVf+P7N0D2xNMVNmUG9i?=
 =?us-ascii?Q?v4Q+0HOWgM8R5JEUpR07EPAkwVp6nZNWVqwY2uXr3NX/2VM5p6FpKwmo8tPe?=
 =?us-ascii?Q?WiUAnfePbwA5tmY91CLwUn9vjuz5xFCqB6refSlfCntQHyonJtukGBRJEKLp?=
 =?us-ascii?Q?FxHkhXf1rOqQqJluqjZPnNAP3Zi7uluMBvCRWj13gLG6vbKY+EDOLwSmgdRY?=
 =?us-ascii?Q?3S6A83aHvZHgWH2HmLbmLHQPBcBDMuw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5b396a-8ba4-4c5c-213e-08da323ce7b9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 04:23:59.4536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vewpEx2fYJG8NMH0NtEYqlhZbqSJMr1JJeCsT6m/SrfPP1nVe3vhQqr1OSfjOSDcxXOfm2yn7xQWf5WkLJnA8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6224

bpf_mptcp_helpers.h is dropped, include bpf_tcp_helpers.h, instead of
bpf_mptcp_helpers.h.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
index 8c8acf04fb92..fd67b5f42964 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2022, SUSE. */
=20
 #include <linux/bpf.h>
-#include "bpf_mptcp_helpers.h"
+#include "bpf_tcp_helpers.h"
=20
 char _license[] SEC("license") =3D "GPL";
=20
--=20
2.34.1

