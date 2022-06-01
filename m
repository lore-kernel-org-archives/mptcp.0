Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C9256F
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 14:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654092557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7EZhHhSvsAoI/RkdoRoPe/JgmiR01FVIpRd1YYAZxM=;
	b=Sjrcp+HNeOy7E+qctq+l/KqkTcccsTZW1Jv0yUGzIdZkupXCdq+811tLH5DFx3kJO2DG0N
	SrPLJWbE7BJ6gxCKeZtiJ9PaGX+lpSzBpnBj0+FB6l87lOyCFdwCpwZJEVIlL3yqPYk9Fg
	I8IJKRO1FYquhklAhc+pZ0UEyBN55MY=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2058.outbound.protection.outlook.com [104.47.0.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-mLZSLOF9OE20owrKnZPigw-1; Wed, 01 Jun 2022 16:09:16 +0200
X-MC-Unique: mLZSLOF9OE20owrKnZPigw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAXSaqSm27Sv4UUE38I5lXWiytjHTYTg7EOQvkOcg9xpAlqLz+QYkNEF6Xi65grkXAO3V3PgAz6HaHq1MtmscppM0NTnOCGlswNbQ61tLTmKiPOKt7RIjVWT5o5nooLEVwt/p6+z+Q+X/1njM65t3g9P1Y5LMeEzrybGk7f15+MOWUA+2yQVeuwd8FqRIjmWxpN7+tKrNgi06PzXoFmUvftJkDPbRcoT3bIOf+fqxGu+lNVUY4PE55nuLqomBwSRPv0VGjCmKqOV73/frAk+ng+maFEKbzMvqzI0KL3c2kDwMcM6JlmoWczUXXMwRXEF2Fw6Is1t2yUvLYZ869OYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOB5qnNpU7a/lHcG5AZwW1QKtS7Bh8v/oKeVWAVr5No=;
 b=NOMFyyZaebXrH2QsgoxuM4qjzH2FPJ8kLdud8S0hVcMT81CTQ4AC3qDTNp4apAXAseoj9eqGR9ibjBuSwIXiTmnRimR7g34I8ef9F1Gaj/AIA2nV/MknTqXwWdpowe3QUSt+PgFyji/ETBl8SLfpHPQiqC54uEvRBwWs/0Pt59nzq7l8KfUvYDEmaixfrRpci6flh1HmR14AZ7LbELgCHegb4Ilj5MPHhj2qwfjweY30DwvzQ+gLhp2IjYv6BlCNBCM9u+5jd/KdX/AK/FYmApQcJbGZmGKdJfn5e3bBt+BLD74wjhZ6/XoMjHcEfUEJkMd+CGaVw0c9+jsO2Bc3jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2935.eurprd04.prod.outlook.com (2603:10a6:4:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Wed, 1 Jun
 2022 14:09:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 14:09:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 06/11] Squash to "selftests/bpf: add bpf_first scheduler"
Date: Wed,  1 Jun 2022 22:08:19 +0800
Message-ID: <605a683f2dbbe4f0f50c4bc6c55116e5f0fa9110.1654092153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654092153.git.geliang.tang@suse.com>
References: <cover.1654092153.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0179.apcprd02.prod.outlook.com
 (2603:1096:201:21::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf2553b6-23ac-4025-a336-08da43d84e81
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2935:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB2935025CEA5D1BE30AD96ACAF8DF9@DB6PR0402MB2935.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vj0fI+NJGIVH6lhmrpmkkW4PCBCLgSr0K+qDiaTrVWbmT6ZAPy+qomSIGUgPVmlc4ntRzNmHadHyV8CJsYRsvviynhFSkgGfKSdSpxtwMwGTV8ZzlCtEhLPVJijIEDnvDiniVDC27LzWL1y/L7i6QLuQLC/BEW4/ihYncr1o2B/+8kqNKFp/GMDhXRCfz5zxApUXdZ6JuFt00VVVLhUIBhFdY636cpNbDP9h4wugfvXFYEGCA/aWcCosWuAJPOzj/UXzBZdCx4gugLSfBwDY9OW7lziNboqk52iSemGsLARxYGA8om0yjzG5FTrzkFnsVDgn3CGl2fine1xQCqn5jHH/QPuRTEJVXqycBWlkkxgPB8o6ZQkBWcMkfuVPWUBpt1aonka6OEcEcbzsZdNRkCn4xh0n+XXO8Ka6ig/e9s0QvOstw9hFjMncGSzTw3VhJSPlZVP5oDKJBF3MuUqCiWmJcPlTekljeA4mK8Gs2XHK1a+GmXipD+vvzDUTF5S4ohpMg8LS7f5sSqfb+k3qt7Jb4F8ctKzsClrApz/xfkx7UDuMLSvvPoFMPCrvyJmxaJY0GC25daIofpmbSrEc+i6ISF6sUt3T6lCQSETBT0Qy+37PhbiNHr6n02HMJZaHLdTmMSwFAqAyktJDQx4GqpCVPaGEV2hRrmj5JtsqpCKp2cMf/tV5MMy4/6/Isyr3wLgu3Deln6p7wm99GzEomQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(6916009)(6506007)(5660300002)(83380400001)(38100700002)(316002)(4744005)(6486002)(4326008)(66476007)(66946007)(66556008)(2906002)(107886003)(8936002)(2616005)(26005)(6512007)(36756003)(86362001)(508600001)(8676002)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VM3hBsq8+XObAQKfPEhqJXPURdMai7wnRSiHb49uXueXRRBBQfiZ0zKVhjS3?=
 =?us-ascii?Q?AzQObQQ9bG32itZBH1wKtZITNpaj7/I71q2Wi1dxylVfynCyINzqd3HJovx6?=
 =?us-ascii?Q?6+E4AnblxbcE7SGou2xVK9w/HfOD38VhpkVYzDsHEMcH/KYZ2sFn8ThqE4A8?=
 =?us-ascii?Q?ql373ijN9Cz0pS/khBn7ay3b1zUUQg/GA+/VIpnRyf5mzBKZqre1/ItwjXbn?=
 =?us-ascii?Q?0l+DSj0l08kxTJPuMvQKdNCqP+UDuiupIGiQ40HqqwfTOm+QO7D2bdOAAZKH?=
 =?us-ascii?Q?lEUktlWDN5Lby0Vq96BNQ6S3lmX8oatGm3vMVlly69V0gBXCHR+3X2eyzKxz?=
 =?us-ascii?Q?//voRSTvWwHccAkM0MgpJIkF77r8zATLbdOoj6ZIKeFJEwFOkECJsAHtLzVz?=
 =?us-ascii?Q?8KBwPOCNUaKxtRR7Uje5aT2yCXDv626CyZfPTSAI/kt5eF6BqP4RoO2B8sn4?=
 =?us-ascii?Q?vRE/vrvV/CLx6scmHuYd0Ian4bRdDIBlnMt4fuqlZIOmE3WptSHxqMg4nvzp?=
 =?us-ascii?Q?Vi9HFvqwqqYz2yE+daWepbEC9G+X/lPc/CutAVpMVu+yPKF8OuttQDAVCjx7?=
 =?us-ascii?Q?1EHzsi8Mtod73N3ZFTzS+8/iexWmkTma2+qhgZdT4617d/RBTH7s1Em3Fs4L?=
 =?us-ascii?Q?0NbFDW+UCeQcWj0sxmIMgJZsqDqZeEloDi4WlDQhLpJei6ZLe7jyybpAHjoC?=
 =?us-ascii?Q?lETzotHq62L4SCNBtYxu6JqCNML8xd+O0PYR3AvP0S/ZDRrY2wNby1BEXV9p?=
 =?us-ascii?Q?BIwkspZdBp/DRNTZ9UefSGR7mNjMkzKlQWx8rV+/ShAhQZKdn/55scbJbCzW?=
 =?us-ascii?Q?X0JjBlDnopgk/RYHmwBg5Nqw4SYwE5X5Z60lU6yeTnYHGtxZa/gaFjBOJrh9?=
 =?us-ascii?Q?IxBeQUVDCOG3n7pOdCfU5zHHhplNU1r+Wz9wAbRo8iu3I/gwOp+yP9YMbLVQ?=
 =?us-ascii?Q?9HMcAnK966blVy0tHA2rS1xaFUnxl4bNa2pAHUQ0h6ueoXRzgDejjRsyOD/G?=
 =?us-ascii?Q?qF2yYdSNgO6D8718J+BJHbMwf2a98HEJLw4/avZOceiR95KyNo+zk236v9xl?=
 =?us-ascii?Q?Xkz8bb6WCRibypQHBnMA9ys5zBZcope6ntzckkj/nAd2bapzQa4lrN9F+txP?=
 =?us-ascii?Q?Hup2eqr8ku9VflEqWQxQztDMHwdtSZELdS3YO1ttFmKj57MBS03KRayGWCWe?=
 =?us-ascii?Q?DeUq7l1xpf3TQkHl7WAwFjYbZDpovrvGInTDcfkDfXwspp/FnTmE29JSO3i1?=
 =?us-ascii?Q?ERaVG1plddCkQvMmVQrge1zIch0C4SkRn03yJSNP6idLI7CAJneo4jvIRtzm?=
 =?us-ascii?Q?l7s3IYtZm/OdPQaBuab6DI6w/IsezBlVES6tfmw6PTgsbuw3ucYav7m/xI20?=
 =?us-ascii?Q?+BnR30YhlguJmF8d+z3T0iaqfQJf17W490IjxoKnYLv+UgiYYRbJQG7/xm0a?=
 =?us-ascii?Q?ID9/lwMrQfjER/lkBqczoA0p2ARI1xIIaDQGrvMBTvfZkfHNS8C/UL44MoS2?=
 =?us-ascii?Q?Wo7UsEypjxqCAtlBk+14mQ1eKZAPWd9J8F1c9FCegNXpOD7U2dgFRn5O4szz?=
 =?us-ascii?Q?Vy50QtY00JTUsvpRDVvapMtDhtTGeG5rw5EkoOWdLx7O4WKrKpZA+V21y5fa?=
 =?us-ascii?Q?Yk70507DMxfvr47HdBMh2T6sDAtsh49kv97JwCEcEZbbcBYuOVNjlYZ8TjBD?=
 =?us-ascii?Q?VfzrfunnbTitBc8ugL+A1nFAUCGvlpfFdhaqPW/x/YN1tQWlYfKpm/aX0oYz?=
 =?us-ascii?Q?ykYhBNHZOoGrl9u8ATCyRIIHMG4yfjc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2553b6-23ac-4025-a336-08da43d84e81
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 14:09:13.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHb2OolfCoQXBbz9q23FDghHCjX9Fdig4CqnP4Gp9wHTD0dqdTvo61MgKGlSzSD+7be+wtm+HBJvzQcBwEim/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2935

Use new get_subflow API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
index fd67b5f42964..fcd733e88b02 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -17,10 +17,9 @@ void BPF_PROG(mptcp_sched_first_release, const struct mp=
tcp_sock *msk)
 }
=20
 void BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
-		    bool reinject, struct mptcp_sched_data *data)
+		    struct mptcp_sched_data *data)
 {
-	data->sock =3D msk->first;
-	data->call_again =3D 0;
+	mptcp_subflow_set_scheduled(data->contexts[0], true);
 }
=20
 SEC(".struct_ops")
--=20
2.34.1

