Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E93915486
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JAGieKwI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbyTSWcxtkhhPXZJ/KXASLAsFoH6DAsIJoxPA1LGKaKnFl0RLHt50kdd/JL3vRUBZAw33VHZwb/kqzvX4xc73i9H0gwGdZ+tghYYA1y86Klup37/9Bf79hUVu0eM7geiLV8+vgQZR/O3W51ZqLn8bRqxfkki2dV8QFtProphJ+JcXdq71/hJDBjrgdMKrRB5BP6Q+4XWEE6Ry4wXVhXJeVxmGmG4sVtY+LqpdXLV4T2ISGy82MElBlYmPvkpvgswYst5lHdEtf7/tPS+uKIOJ+KNAlGLKPgqBMPMU6G//TNqphvQ5R8js5gopvH+MfOVIprn+If8fBYAHWNqjx92bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/L6tzoQJbbHxqpWK66TBqhNM+jPj8BFDM7bbPCmH0w=;
 b=B6TXGYkb4nv9eo3Kr8b5PZFrgx47H+UrybLPfJT5gNvNYidDTThpOkP+p81z5BsTM0peOdzYcRRLbpDbsEohNtZDDLmsdMpd64qQbT2uORJkv33ZV4tyH7W4KYrbUHrffaAWCQjP9/4FAgcsBVx8u9EL+iZCqtYkABHGXoVV+86BeyswFSv1OfMT/q3B6O2hmC8jv/x3VZ+ymPII5nMEj1w0LbSXJfw0LxySuRWoPfArIkBEyrbIgUQuDp7ZtHFHCCp6bTgz0YjSArbECveuIipUEjWACXCbwN2dwOQ9PaZjddKIsDmjOPZiG12gQuK0VywrrvTDW39xnTS1G7uhcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/L6tzoQJbbHxqpWK66TBqhNM+jPj8BFDM7bbPCmH0w=;
 b=JAGieKwIsLc5BNqTggk9VyZlD0bxNHusnWI6UF/Hifrdo0K3QUhcuz/tnbx697A28kAoYbdHu9bsmGiRq2ZfducgAwJU8KUsD3IrfANlljO/+u1/4HD3RDP/kux1Vo1yA1rpFbu1l6ayYMVEsMwRpZa3kA+RS0Nm1qf6bMXyWtZRA+OpkIT9kOuOU/jPtvFO5yKPJbJ0kjCBpozgDz7MsusmVZ9b3si0iFnGg+p3i9a8fL1bx/XAzNL9VGzTc5Wp4NmHaEY09LRfF/IG5nj8/jnC3DIKNpJ3OxZYIHq9r76GGDZNGk89oHnG7p2/GTgI/IQxj8sOtO69siOa7T9ZOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6820.eurprd04.prod.outlook.com (2603:10a6:208:188::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Sat, 4 Nov
 2023 14:17:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 14:17:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 07/12] mptcp: check userspace pm subflow flag
Date: Sat,  4 Nov 2023 22:16:21 +0800
Message-Id: <c008e3b038efa6020cf29baf2dd709c9dc882eb1.1699107275.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699107275.git.geliang.tang@suse.com>
References: <cover.1699107275.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a16229-8c82-43ef-5dda-08dbdd40c0bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dzlmlUm/bbMrP6Z2Fv7gyjyK6inhCeiVRpI5i4K8coBWNeos/w7qg2w3FB7rNdh2Sd2kqlnUHdy8ZBN0qhyAGekPJshCOTyF9lt1TADEShQezKmjGOGqVqNEY1Y2k4C0IsfLIpr3otchF+n+Dnp541kQD9iT2fEPwT4xumM+bIBmXApPgFpzq7TQBEdSPwbubZujFHsrL5cLEg1pU/2MTlMfqMsPDFAzgD/pg4Ig4H7S7219ra5PbH7Yo35gtpZmraUu7Kv1k5xKd74/3KNOCQgjHaJ3x8KVJxEyFEF3DC5GfLdofbJ0koNtX9m8e1jJSjLNk6L2oZ5KNe2hPGeP6LAHguU6L/xRZvjxlSBm/tJ7eTGkSMm3VFxED+DRuR5o1CMr9+H2+YX4qSsgL7Y3QG0rw2p5MhhaTDlftviy8FQDaTO4x9SdqVQZ3GdgCJU9Xmla44oYlKVjo+M+DUR0/J1X/kM4XcQXmG1nN7fNcArJCO/Z32welC/qC47AXmogIEqH8lHaBCwxcoIxooSc0eY+Tn2qzLEkN9oFE49eQ/iokYrXYGpxnAMrc1ANQZ+mQAwFkHUUsc5rsYxtLHxlImeTR+Mw3f5UNDhM20FKYgg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(83380400001)(5660300002)(2906002)(6512007)(26005)(38100700002)(2616005)(36756003)(86362001)(41300700001)(6506007)(8936002)(107886003)(6666004)(66476007)(478600001)(4326008)(66556008)(8676002)(6486002)(316002)(6916009)(66946007)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tYRk5ngr11xplrEgChPZyj3GmYmVFZr6++KWgXgtetJyJrzLcbOBV10HnOw4?=
 =?us-ascii?Q?YrQ/4VfnBnaC1PXVmGpZOrxL+pHYsvgW+XywmUDB8LPxrXMipt4V8TGf+317?=
 =?us-ascii?Q?tVOvfSzedKriDIKE0+RPdXsclv5vHvzIWQYNCZZ/+dA14YLI+Vx4+oYh0TXB?=
 =?us-ascii?Q?cKjYCtGfoPrQ2KBP0ISwfvN9Ou0MKgj+lGg1VjijJ6HMn8ulTD3VQ3mhfkTR?=
 =?us-ascii?Q?E4G0YMJ1Li+R87sv6E8RQ6z0gMmyjMUa3n6TiY8bT0oilZNKKvPU1cGcOZLq?=
 =?us-ascii?Q?TeoU1O90+iXqhZ7RWFaBp/8RS56SUjQhYFC5iyxDAhyYrlnT/aXHZMbg50ox?=
 =?us-ascii?Q?WHJwJ1sHkMrSEhk/E+KSmBSAB7mlGh+HBpPCxRv5GhbuDI8cpMK9FvurBOjq?=
 =?us-ascii?Q?446hLBCJWRUhfOwt6J30xDnyLRITEx8mAi5VAipZKCtDT8ZFcEGWEtvm0gaV?=
 =?us-ascii?Q?lCwWb2KocUafvM0B0PkYWgKqMMD2/OtlElVWuXb1Rqiryi1ZiNy9kkWvtXh/?=
 =?us-ascii?Q?I0jM5Uwu0DLF/FuoNDaN14iMis9FcSLRvLUJ/Lw2W+KowGFB0KuIzHQlxK0s?=
 =?us-ascii?Q?BTXg3pgwMbIMpRUjemxp2EIiaLwLHOVXP5iFQtFApwEgB1D5gSxWlsa53i7v?=
 =?us-ascii?Q?F1oLGLYGVQxLrd1mx/1B4g+RpnarnrRoC0swWT3B4wZ74F4eDWljaeG4Mfgh?=
 =?us-ascii?Q?dAXie3yKCiEfy1byCEnuqazk0+7WsB3p0UozqJXMdSTRRzPZsIq4+aq2qn3J?=
 =?us-ascii?Q?NKh3La1zJj32ixVLVDHb9I6KL+OgJ/Rd5dMhKZv2V8HOrWz3SNWJv882Fhld?=
 =?us-ascii?Q?9WmbwFNZyFsFaf1hvf/NdnK1Gzaj1WTmwBKMTTvj2ehuNTb8yz1Ax/AVIoxf?=
 =?us-ascii?Q?4tDv0trrKe7T2Zk9n8twbn26IOaP5Ur9AxoDYtHria/g6Qd6R3XFkVc162w/?=
 =?us-ascii?Q?XoH+OirIiIkrqatjGagZbu/h4B6ckBgQclNyGeQuAkOL1BAiCdAB3uUN53YD?=
 =?us-ascii?Q?14wccPDszPp9i7qIVGsOJHHhkxXcIGmockCyZOkzTW9Ib+w0QRY4XJdQ2xKo?=
 =?us-ascii?Q?vKKHnr8T5xOoh0nzm117SIck7GvssB28Imdnwn3xHWUt2UTkd09a6GLUF7pR?=
 =?us-ascii?Q?6tB/dyqG46337oo/rXvzm+xH4CiyhSaZmG5CLJRdP0VYd7OVtOKKd7zRBjMD?=
 =?us-ascii?Q?fXaFf4qXZFCZNIGHB8Zs4Fp8U6mSSYfVUHWZJ8q7hMKPKPRnfih4YWviE/Gu?=
 =?us-ascii?Q?fY0flkGYbtux6ipZYxcDkwTbW2lFgN5IvNxYaAI6OpVDF53T2oszqypR9aHW?=
 =?us-ascii?Q?PZpB8Fng21uC1B5Gda83ra5Uz+1YNnW8sW1s2nPVt9MBA4aiD0wXxqSSCSQx?=
 =?us-ascii?Q?nVqaTUOOdfpfTCwVEmnSF3Z2CLlLtjUgEMzrWN/kad+bn8GeBQEo9gjk9oI7?=
 =?us-ascii?Q?ucrCWcZIf/Ra3MVgviHMQBPnc1Z5U2O1IYJcEVFo7oG5j7jfT6xmUPc2L2T+?=
 =?us-ascii?Q?E/6XsJRKpfF0pb4Ol+wDl4R/AIOm6lqhYm8Ix4o0Al0ZWrZ9JuyMf/6qMIRN?=
 =?us-ascii?Q?7lifbaZD9lFuTnVT71VIOgn4/3ppd3GYzc5j+i410XU8xnnwbJQHmi9yHJgP?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a16229-8c82-43ef-5dda-08dbdd40c0bc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 14:17:18.5301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKVSNrsJ2AQ6FizF/4+3iFu9DPOxRdxXTBxkPsx0a65Ge446qmCpil6mvZ2bsQrJZCSMMRlN7Km14rHDARHmEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6820

This patch uses mptcp_pm_parse_entry() instead of mptcp_pm_parse_addr()
to get the flags of the entry. Add MPTCP_PM_ADDR_FLAG_SUBFLOW flag check
in mptcp_pm_nl_subflow_create_doit().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 9c03fc46d9a9..8ca715288872 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -350,12 +350,19 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	err = mptcp_pm_parse_entry(laddr, info, true, &local);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto create_err;
 	}
 
+	if (!(local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		err = -EINVAL;
+		goto create_err;
+	}
+	addr_l = local.addr;
+
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
@@ -368,7 +375,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	local.addr = addr_l;
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
-- 
2.35.3

