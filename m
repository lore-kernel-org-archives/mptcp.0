Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150075.outbound.protection.outlook.com [40.107.15.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C37B
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:02:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fy4gXbb9WcE780xE0eKwdcFqNrgpTyNmZtnC58pMQSVOI6UbLSyFg6NDXJELhc3DsNh9CnjPXI+7sfbhjDof00jIjTYQwMo6URsJt8uOvr3hJz/Us8f+A8geBX81Tf9MmiRt1/YmXxbjXek9vAsG0bd9W6xzgRUOtV7IX5EvKhjXzpxIaei3l6zkyfKTnMzdyCiUd1Fk5ZFWoCIaWHh/tNzoAw8IcX1ZAYZ6K36dkwrJcAFNs/rb5iW1MUbnkOwCZUMW5UiN8vzLlr/+X7d9wFM47/WoMNAsI8/Ymj3hypRtbncdORy807DOTfNCcQhu3oUX1dp4XdRJJDGvt4EUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PVfXsdGgJPJNdmc3V3dkJQzFVGqb+WIe+7PEFL3m80=;
 b=JlgKoUfqlEQiaxeC1/nDMdzWeI3GPXB9sen/vTXeSBTw//rp76keMmZUAeyV6SRJjHgunyQDyeIxAml+EONLVv0iDfYw2TT2a0qul2MDZbsvLcF6Lqu018WQpTzy/o4jwd6SNjZDyvvOqtr1OrSp555UlgyiZaybQXJmfPLkMvmc5h7rGXpPSG2TlWBvS5F+9n4cLW3Vq8BnUMtdQDBJRbkZ+reEUvSoY0jtGBbDtbLD5/ElHHMfrTK42ZK94Mm0CdruylDBpik8lPSV49G8mzX6yg1UBse1HmYvtO4X6i4bynXi+Rebwi4sMbxJ/ftFYcO7Qc7912Jc18WjcLVByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PVfXsdGgJPJNdmc3V3dkJQzFVGqb+WIe+7PEFL3m80=;
 b=FcXAUJDf1jKUzNNBdRvsWwxCmbL9GYE5LCixrYsYRxDULKVDwTkz7H0rXC5tmPO09bYqPJP1qKUnSKeKwnoSMaTApObQDqP/wm5zI/0RTjc7FBhS4PdGvm/mb0fE7j0qXRypponkwfMKFzdP9fEzps1I6oxJ0xiF11d1lNl1b9Da46H5p0vz1GyRExLTPjybcbt4dekvji5BvhnwWonhdPzvLf4MgGTR4jNNRE0WSlFDR6+w7GoY0WM7FscKroPP4elqG0DbyUp6kBK5evm+vNy3KnGxMguOcYfS0/Em1Zy31ZlUXYo7xiHJgo3bX93hqZSKinz4Ou5ARNejz5VMqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM8PR04MB7281.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 11:02:17 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 11:02:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 10/19] Squash to "selftests/bpf: Add bpf_bkup scheduler"
Date: Fri, 21 Oct 2022 19:00:02 +0800
Message-Id: <d4084c221dec9a2488adff801cae201473cae2eb.1666349129.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666349129.git.geliang.tang@suse.com>
References: <cover.1666349129.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0148.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::16) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM8PR04MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f1a7859-5996-49fa-004f-08dab353b759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6xYCGcKdGgahFmz51B97HW3GPadOnXnb+nSX+2bpF9GSt9Akf/2AXa/Ibj20+hFhW9MwkST4ggnFo+Ev/eDl41ScxkJmGJbReKlZT37+3lK4bkxs9IZJOY2ytOnOKZDwUu9GXzmrNm3APFweWXGMziag5VjFxyGIOu5CWIDwBBT6yIcDVa0KGzxVkr1sQPr0+jVZDdzg746iLGc3LH/9VVJ3rlXhI0KOc2LH4Y6gB5n0kxkSG9GK3njtQQF2fCL52Hd4BrqxHlvqsWZqQ0mBTIrfcpVPl/+e7/z7VENLc9EQk++93q2ZUlbZGvvRSvU6dTFU2gPT2yPDYbd+JqH/FBaVYoBrDWzg1Vkwsv6kODe6Tv8xlM+HAuKVIgIWBLy15MRFROhZzd7AbNoFrEv81iTM1YIQnDytkLPaTfg/i2nvtbHYZ3YEkcszF2EuP4SmEyfbv1EDW4XCsNgOMyWWVwbgcclwooRCVIj/7yBIOSGbYvY6PTdIzjJL/ptttuylFtuY3ETvJwokNA/uQMsqOX1mGLE2vRNk7cw+hoSFBfqsoAhnxMw3ByGlHqR/wFsUJ46VF2/pQ+xUhfU0atW+Bit38YP2vF4VOVgoPBCzk8Qpp/9mdNqqPlARRSObb+Z8hWFtXqFFxz3l8+duEGcISMZARrOX8+jAhP5FqOy6fFfd+zVpi4GvJbIdK8njYzyEN5soFBFwBqM39am8ElPiwMllQvcE13Ptt1rhqohsV73ItRY2p38MAx62nBnhIV7l
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(2906002)(186003)(2616005)(6486002)(26005)(478600001)(8676002)(66476007)(66556008)(66946007)(4326008)(6666004)(44832011)(83380400001)(6916009)(38100700002)(8936002)(107886003)(86362001)(36756003)(6506007)(6512007)(41300700001)(316002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2nW1s0vNvGmcViItLNyowLiQrYRharRaj1aqh6yi+UAMv7993D/y9kjwqGki?=
 =?us-ascii?Q?IRimdOcWDhOto91FuKY9cwXhKrSMGH52Xm1M6maHeMGNDgtG4ELXyH6b88I8?=
 =?us-ascii?Q?jM9zQpW951nXgz3awejsCHWkX1qOCqVY9r8+1L4Ov8InMuQzCnw8zbnw7uBp?=
 =?us-ascii?Q?A6r5rz8kn0cCVWuq3/5uRcGzt6fxgG6pMXpoEPXrDkyigdN3rXiu7j+g4unN?=
 =?us-ascii?Q?CUaFigFFeMiA3mqkkCRGkE5Trv+JDPw/ZpNVPiDEHoL7Qh/ppWPpJFrLNJSe?=
 =?us-ascii?Q?aXQLpqK+BvlKqaRg62DYts+qJS7Ac0gP3pUt8CUmxcpOPIzJFwbcyNYWtsap?=
 =?us-ascii?Q?cARVeC1V4aLUF/CguOOTmeeBpFvH+LyQ/6fu+h8JcyTAP6EoBvIqm/iy6TEg?=
 =?us-ascii?Q?LDgOlMWWzT5o1QfrjnzSwUS6yrF/yAM23UbRjyIBZbvuZqYe8PIQ1T0O5v9k?=
 =?us-ascii?Q?5YVNQ10tI7T9jWrgf4HSL2knzlGQP+7P9knvzyg6IIsBxNjiRMSIz0hXS4uu?=
 =?us-ascii?Q?4JDnxf6KTLgNgTC2KIWRdwZa8M23TO7oxlJ3SkGv7kWDXwYBcUNEMca7WE+C?=
 =?us-ascii?Q?3ZIdcDIqGxXmuyKnayhaU1znxYfF2ly0k73sLoffJQ0YXn5VMLkKrduZO84a?=
 =?us-ascii?Q?58aB7yLBuH3FDkP7MYGPfo71RjGRPY+0wst8mq/PnoRFnsnbg9Emxp1eJ/uC?=
 =?us-ascii?Q?T4SDzhamg617KX3DeiUlNtJ9NPh7mPZ62eSkYJavzj1AvUbSepsuUvYxTa3j?=
 =?us-ascii?Q?OGFSNdDZJmNM8LF1XYMYo94+z6BSNCxqvVNuN+/Uy2ZjTVvs6cVeNjata2BV?=
 =?us-ascii?Q?Ci4bG7Krze+ulEOm5GNl3G0fQLPihgYWngT3XiUHhXwISp28nZ2gxzQqPb2W?=
 =?us-ascii?Q?mUDDXUy+IvVRPQ4GlEDsuyJpjGeCFk7mwNdG7mFCFxW9yqy4C3dH23y/Ubda?=
 =?us-ascii?Q?Zrwt6I+ode6ifDc3ncCgBrpyT9aTDseN+4pz/pJMT0b+XvNcsr180GEn3A1r?=
 =?us-ascii?Q?Y4N3GoUj5egFlsIsdI82jp81KCMEDshDVjg7DjkN3mA2a6oPYcdqAL/XN6bn?=
 =?us-ascii?Q?4Kvc8YXG7OO+KsHgeDAipdLNoZa9+NkzOno1VRrnxzrmNQpL5A8DDm6x7EnU?=
 =?us-ascii?Q?nus3v7kVzHrmIGyiVnE7DL8Tmc05/iX1KAVBkYtelIz2fJ6sINsKGFbjKHPb?=
 =?us-ascii?Q?B+nDlBOBkSiLep/zXwgjnRbykV8D9RaFqkMVZPLQp0wF2L8NEkroBPpVm3ba?=
 =?us-ascii?Q?Gn53tdJaK3X0gn60iFsqPKwQbv7Kf2m0oe6jnXZrNNnbKGxe+D4ENmfTcszU?=
 =?us-ascii?Q?khBrQOE3A5YBxYtsyTljjsy4L+CRRs/1qLDX2Sibdss6Yd/Vk0/iQmN3USTr?=
 =?us-ascii?Q?sTtxKHbSmZAoM9MOaxT0KzCdrOat6aGilec9AOXS7KVHVbJqQRP27mvYjEA3?=
 =?us-ascii?Q?eJpoOWqLLvyIaEeoaxNYH0HIwTMU7ZXekYE93IdVKrr/ue/S7ITIkhLo3b+Q?=
 =?us-ascii?Q?b8GK7U0kl/YoaO3iKgZ6X0Rs6O9J7rirVS4PhX0BHSip/NEfurZmYS+v5dvy?=
 =?us-ascii?Q?QWapSdW3LPZKj85pEJDgIQNWj3oip3uUN3vf1sbLVZN7g1XPVDE3+W7T79z0?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1a7859-5996-49fa-004f-08dab353b759
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:02:17.1379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zbpxu66iCVYz+VUlX1l9nj7+eK1WdIJGm52jZLNYK0m+NRVneejfq7y83lNfQe/jl63xHHA1D2rcIbccr/yZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7281

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 949e053e980c..b2724426676e 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -16,8 +16,14 @@ void BPF_PROG(mptcp_sched_bkup_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_bkup_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	int nr = 0;
 
@@ -32,12 +38,14 @@ void BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	return 0;
 }
 
 SEC(".struct_ops")
 struct mptcp_sched_ops bkup = {
 	.init		= (void *)mptcp_sched_bkup_init,
 	.release	= (void *)mptcp_sched_bkup_release,
+	.data_init	= (void *)bpf_bkup_data_init,
 	.get_subflow	= (void *)bpf_bkup_get_subflow,
 	.name		= "bpf_bkup",
 };
-- 
2.35.3

