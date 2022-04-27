Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC951621
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 01:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651024653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/RDlydWiAwHZ3O0hxyi4E5TKaVuJH+Dk8t/1KIGdEMI=;
	b=FoX97sGr8v0PS5q9S/XEuK3VNViyMyt4S+IEOR4UeabcoQwQN8XzfOl3l3sUG6wwc/76U/
	3QBLwWPc71sNKC3eHaNclEhznOvS7q8eIF2rRyT8RtotN5xUssTQSyhNpL5mDQpL5WbwyV
	YH+/MLSocpEQ674zABnerFYdhLXAIck=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2055.outbound.protection.outlook.com [104.47.1.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-u0ZMc8QLOV6_LvE_rbNOIA-1; Wed, 27 Apr 2022 03:57:32 +0200
X-MC-Unique: u0ZMc8QLOV6_LvE_rbNOIA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkzLDH5VyJRfVZOjs3iMPFQcTImcKOZN+OPp6R/4eC/Vjlln9VdxCwvmLRVTa5adMUCRaFNvisAJWTUNzhaOnyRUkY6g1g/Lc2SRpLn/hF7ENLmQmJkkhWG99rpjrJTLwaeKEKLWqE9QqkREYYb/RAh/Lpxm02lnOeYLf96l1I/jJ4+zWB53PLRkkbLArYzWm9SdCOmaRY+JsG0P17KLY0DP+3+zLvCQeWjEQhKc4StAG7oKkl247QcAnR7mYBy5wrDvL0WRlsMjLEbveDugcRqiulMoKfUhagTH1ZgTE1XCKcEUBxaYIqbDKLfJNGIBEV4M+qXYucQxIe34SUuyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2K1eTcXjHmFeX1syZLtPL8603gz/hgxgKtqjwkUSFk=;
 b=aO+v7bVUhvdgg6p9SONy7ScfG6ooMpIXnEnF0shCaPgLD0x/qiyqpnVHUQVYw9O4HjnnkvuzRsQcAVifd1/zb2tU1Iq7PoNFCOwsc/ECMaERhZiHBgCbc9nae0ZnXaAQiQrJ2njh6QC3b+oXZTQYCsu1nsHOG9jOt+i5nlOOAwKIWSKGYd1Sf5YUnFX9bC7CSWlr0wm53QbsTs6dqZb891l4Rj9fuN94oCeia57gO7FytA3Uo8OcgEKnFUqKiBfxE5FDdUSBt/3cUpNvkgAemMz880YVpMRjzGreqrxkMOOR7wgcUWdvqPMUjftbIYPuw7Dv8+3jg/cQqghkeltAEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4168.eurprd04.prod.outlook.com (2603:10a6:209:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 01:57:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 01:57:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 7/8] selftests: bpf: add bpf_first scheduler
Date: Wed, 27 Apr 2022 09:56:54 +0800
Message-ID: <f60f9466bef33ae97fed3d0d050d4efffc76a33a.1651024344.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651024344.git.geliang.tang@suse.com>
References: <cover.1651024344.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0001.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9dcfd9c-1407-4f78-4b5c-08da27f148e9
X-MS-TrafficTypeDiagnostic: AM6PR04MB4168:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB41685469EB9F0EFFA682744EF8FA9@AM6PR04MB4168.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wVJWueLl+uOmzLH1nbNzSwBfpnVeNUm0Jn9RCHYVFs85VVBMknGTGptZMRb22Z8iAkq67rg80Fm9LlFswejlMsQ8aVNi+pxjHSmVqgVBSu4sSZAzNMDFBv8QxumtNm5Lfp58jcAgpD+4toeYgyUON/LHbcDKZP458O2cXeaui4dxP+VLW1fi6ngS3tv/vU4vJZIEIQ83A4BFHdmZQGOiKE8NfC8MOt2/4Zxp3LdMSjO/M0AH/z1KI6bMpy1iQz50BzBJSI/0V3lMzqBAfgkaMAzBpHEYA2yHUTUp0rFvCORwdmVtDa60VKdUJh7zbp5GnT/gUH5bL6j/WG1Masy9jiLYZj482MOHkbZ4izf2dyjn8mOwkVZgEY8jBgWDi8Z21JE1iC4i6vyev7KrtDFSHRNpbGMjnpgsy5oUh29b/nXteNqVsez5yZVlLbXWgCFozdfNXlkhJCmqjP9k5Ie8M5mTJuw1pAP+iGbDsUdTfclSFYeis23x2+b7uVGs02Ya4mvnZHI23arbeHwgUX/7pR/vwRIrkDig+H2zE9+XDl/u06EAXxsIUTTGCnCeag3pWGkkCSgzzhssfjJ8BruiRrAdclQAzOMwdVkmD3F2wsnyPh+i1uzvkgpGnR4B/jBj3Z6atM09DZVXpkAZSJWYBFcDLjcJDm7miFDutjvlQ7uxl0XJuLfo2IxaaVowQZtRbw2iEkeaIXTQ4VywAltykg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6916009)(38100700002)(66946007)(66556008)(66476007)(8676002)(4326008)(2906002)(26005)(6506007)(6666004)(6512007)(5660300002)(508600001)(107886003)(6486002)(186003)(8936002)(36756003)(86362001)(2616005)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KJOQlQttO/LpAQJTMXiridytH8aeGQ0qbLfgIDzTYO7AlMwBQbUwX8h4diqj?=
 =?us-ascii?Q?m6gTMmlHVi992tumUntg7TvJf2+i5tOz055xNO4BQdhn4mHjeIva1eTJ/h/L?=
 =?us-ascii?Q?Q4ysgOxQFI+t3B8M+HG8gzMW0hwY/gjlEyLPuuPxA6dDmR68DDlxmALl2rWZ?=
 =?us-ascii?Q?Sj8SQURNN+62hV0iWoKod+8G7rHiPDzXuIQAcH9MdWS9N0X+GenY/zZkCvHK?=
 =?us-ascii?Q?xyiF2wZRHT9G3u3v8Ugg2e7ipX1s9U6KkipkkHZVGne+ssuewXtB+syMzrGW?=
 =?us-ascii?Q?FV3HkRJkmiNRn9GkiC+HRH5RewrPw7a09fwKmBS9WP7T6ura6V5O2cSwcwPc?=
 =?us-ascii?Q?9psbO84ieKG8rkwv4FF0ToNCv4tqlPtktX53qgg1h7WAKvf/Z/qvu8C3YWtY?=
 =?us-ascii?Q?Kgq9bDKx7XMAB7wZ0kjNzIsyL+Ekzy6p+t/JltOCezq1XR0OverncUfEW2bQ?=
 =?us-ascii?Q?hX1t8hS/csoJdsrOfFz7Ra8stKFKeFBLLPO+5YlloOAfSjiT87caBgKYTv6s?=
 =?us-ascii?Q?Ipm49clRE/sUOLTxeCxzKIGrcQVXwOJJMdWYJ9I1bvffN4FT5ypIvaMhNvjE?=
 =?us-ascii?Q?i78fe56ArIGYVPAWxO1+Teg5woAfQKuw0401blz8BVbvyrm/JpFfYZ2O1qJX?=
 =?us-ascii?Q?ciEwgrcGL+o0Gkg78BEZ2c7675lpDMS6SplTXxxEYtUvIQkSAdOtknpfwH4g?=
 =?us-ascii?Q?ScyP4IVLpfTlDd/8ZSBzArSI8XkEBSealEfJewGxY/Iu2IT4bF/bhGlG+sFz?=
 =?us-ascii?Q?YM9jmy/UBvbq7xTf+6UxNtZqPxPk++4IMOUng+UD1yVFTYJZeV3B7ql8QLPb?=
 =?us-ascii?Q?PtiKVoKt0iLjZa75oC4guomtwjPYPXkefpLluOyunrS4Zo5pGYb1zuAoGxo1?=
 =?us-ascii?Q?RMp+bTGdsbliqYHz3gJc92AhZHc/OR3uEB/NlvoxvZnn5yhwkevnnbZs67a4?=
 =?us-ascii?Q?hFDO4udWMu+taO7N4oJIcbgT+qsnRw3+p8a3R/xL8fAldKvONll0SKlTh9wr?=
 =?us-ascii?Q?utmGkbSn09XaJW3x/WbPIU8tJ3eB/f+sAbX699mwy4H0tgxDJzqwJceT/U9i?=
 =?us-ascii?Q?XPBwT7QnVmU/EoJSGYM4x3HZqW44YwuFnFHMjnZxbfP+k3GxsnnhDFCXzdZh?=
 =?us-ascii?Q?ygrGSarwjLLLDWZZbrdvTWJD3CDEx1kxtk0n8Dur/tQUdb9hrDS8nH3kjFBC?=
 =?us-ascii?Q?vkw0MkRFSt1LV65c8+QlwOa5b4+YLyg/8uYVcXgeM8B0E0RXUXyq0/T+4Rqu?=
 =?us-ascii?Q?J+IAwAw9UqD+ess6el62plnRDdmzEFj8uSGoy7SkPR+LJu5Bsx+TOwxvzQ0m?=
 =?us-ascii?Q?qkh6MND+Hl1IDpLbZ5ubb2Mm+aw4CoyTBHAiPxwaZLxYDOoCY4QdheLuaUVi?=
 =?us-ascii?Q?/h7Mok78nDn6iIWSCxEDxgMcChmyvBomvy2xrc7jA+vXU+ZBKvu12hGS/MIn?=
 =?us-ascii?Q?YsNr0KHseYsswMmuBGzjH1Jg0KDgPwDvRHjRTvV9SdYdH1zX6foTMcYX7Bnu?=
 =?us-ascii?Q?Mm+DPZrqKaz0N1rVR6WafSZ8DpHxgNkvF6Bp8QUoPI5+wTugla0keV0h6Icr?=
 =?us-ascii?Q?EJUbb9YvQR5BMB7fnTsBuxh9ebtaTHjPgU5M2cBbRzksNCWuyL6IJIUKcstW?=
 =?us-ascii?Q?NaUZrdnTOz0dNtJryhwZ6JoT7u/EqglnvS8IE6AO3teYs0Uh0KceSySU5UJQ?=
 =?us-ascii?Q?jzf3Qp+jYVfxzxP9KsLiGUc3v0PpS85mujyG8AbTQZNsxVxUZmNdL74RhGFJ?=
 =?us-ascii?Q?pguTHIeVQrpKf5/JXvedGJrp6i3tl/M=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dcfd9c-1407-4f78-4b5c-08da27f148e9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 01:57:29.5352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mde5HXO8zRBRYoFV157ONEU0bHPIlazljU/bBIazeBihxeHbbu3ZM+PZh/aG1rVfixCRpSndrvXi7ChkheVxKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4168

This patch implements the simplest MPTCP scheduler, named bpf_first,
which always picks the first subflow to send data. It's a sample of
MPTCP BPF scheduler implementations.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
new file mode 100644
index 000000000000..0ca9754c078d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
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
+void BPF_STRUCT_OPS(bpf_first_get_subflow, struct mptcp_sock *msk,
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

