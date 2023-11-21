Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3443C081
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A6TjaFV1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hG3QysMnMc7P1z6mqS/UWsBOARvLvxP/FbFPAeIuj+CJBfZoYQu8OIU8SIsb87lX0QyjhPjxvow1ThvPc+o7aGYECzG/OZaZk2QxYZD1IN7ItUHh3aSUFjTDas3JeBsstC4cUqcxOnNTNZfmWvUxpNOeg5qGMAeRQgQFHExzfFBdPbNmctk39/KKJ2t+CuEbNmkRtPOcnNU/5dcun5wWTlBJlm6bSReswZhwhRHCEGOA9Z9JPL8S0vZWeRofmh4ap7F7iwHXH/7p6kCW34yk5qiACf8DTDxrNsgOgc8KDfrxxkMzb1YO3IXeY/Gahl1WHHjHcBn4r5jqmPlya4Q9Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxjjzLZ6kHF8UAV+cJ6wZQea+75Dlq7CfTcoZPopX/I=;
 b=JJrb8Yr+DXCoKpBPKhXho99CJRyGIvXZHOQuSqUITXKG1kv/dvF9gvxHLJK537HCKrfhHVIHxEi0zlaXdhLBKBqI5M20vZQ80r2lkjloejhY1TbNWcBEB7TKISrKbGc7HR9n4p06GJKC4D29ZjJAXqrCmcTIr4ZZ0eSXkR4IbMC5m50P+WC6YvBBTRX61OMmY9I2JYkG5T8/vZ1B1nxKUxREijHy6fPBfNf2ecGTWBZpzNyQIt3NvPsWzPNGsHJidaAsU0vUheKlLt0EwDNS08zMwipnjJRXGdvSKjTir17VI1g+Dee/WmnO3ubjPvB2nc6qlTlWEG19zzO9DuhLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxjjzLZ6kHF8UAV+cJ6wZQea+75Dlq7CfTcoZPopX/I=;
 b=A6TjaFV1wpZk2f4d75VwzIQ65HjHj3aNjyc7mOEM1xF64TsKyWTTjS/NDX3JlbUkAUnm4ZihBLfkzc6vTMgPGNsDLlRxaGlCH0Q3uf9yKwkOVlzzi4oX4ogYbUQOmI+CKTdTaQ2el4SIcSwwn2Na/yfiYHY0vyZVGWlNDgNyNxIIkJH1ESRlzkcH682ZTZbRQJaKxeEYR9XFmmVROQ3CuHbYUtYlIXC4NNu/DSdfcDSIuQcLnbul9iCNaHlP9JV5FG0WL0ryNi2HhDSZO1CMEV+t4wWB5a6EhTN34Z6NHsSP7hRIdBqW30Q5G9WfIx4vxc+tAEEs7SVRROeIpheq8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9667.eurprd04.prod.outlook.com (2603:10a6:102:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Tue, 21 Nov
 2023 09:56:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:56:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 26/28] mptcp: dup an entry when removing it
Date: Tue, 21 Nov 2023 17:52:49 +0800
Message-Id: <674773de0b087c8a49f7dd32289be9a3c3680c26.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c16fab4-9e24-45de-49ef-08dbea781b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NHSE/GkyfQ3jKR52GygsLivYw6UFhwm2gnF7LMzXdAQQHGna4e8D3gziqlgP7QAUJ02Q20nyUc6kx8DB2lbc/U940GvxZb33CsLNUPO0d+8AgaoYkL5JXMM0FsqvwfcNXI1bVxlqAFCi0Zy1pxi6Xgf2gdPoHjBt2YZY1Kas1+BP8rp2clUCj+6WJICFMjZ5sD3uosXuSlNE8B2uv0J/BPEXm2Glri7RSs0gjT/61sjuyxWaApMfmUfSbYBT0Q9UrVh2ID70ynByI2PxM9o0qG5hPkgh6XqKKzLVRh7KnygYNxSi/S5NLymPaszHvYPm3CZ1b7+RaXx5hBiVx1tRyIkA2VPlFzZ0uor11iUwGXUJx3wcf88ZRoU5v0k3dHFiWWMNcQ4eXt6l9d0QIH+ZNzSl41gePN8G/EHa6KDn18t4PuCS7hsLqmh2ahpTluxjuZfaTBlhyQFavwlIJK6npvetxOE3zh240/iF7E2svwoGZ0k79rinCiz9sT8IOX6PUjUOLL90pyuaEL33/TJT95kUge1StNse0T5+XkWsu1JdwzL/v+eTFwo1E6HpxTm9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(6666004)(478600001)(2616005)(6506007)(6486002)(26005)(6916009)(316002)(66946007)(66476007)(66556008)(107886003)(6512007)(38100700002)(8936002)(4326008)(8676002)(44832011)(5660300002)(4744005)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hJXzCk9kThHSlTuMS7hV6G/whwU/7QyIyMbKR8xv/OGtrVy8BwWYkYWn7sbZ?=
 =?us-ascii?Q?6HyFrjYGW6OBqDj3ptiKqAVNLEqNWV2/UBDs1cMcTkzm/FomuWaHH48FzZb4?=
 =?us-ascii?Q?meQTIbudHlDQ8YqcYynX/uBboJr7I3SYl4CiftyyCZ3IqYxBUuuIDYv9FpXJ?=
 =?us-ascii?Q?KeQcC4RX9aYovXGrNHlcFLP/DJBQyAGQJ/c83pBWeJt8G/4snpZwHlP82lSW?=
 =?us-ascii?Q?7R6FKmShLFDsCT9PoWNel9lg9LKX67iqKHC3tuNuQlZTzlr6Z5xTh/6iVT4x?=
 =?us-ascii?Q?6PyfNBl2orqhWPoHV8rTmc/rnJ0aWxmf2Gaw0KtZZS48Gvpj2Piix9KpaUx2?=
 =?us-ascii?Q?NUJvzQYRUhA+2yjeyJuJzr/GrC4VtPj8F0nw+oPak3wMj2TU7vMqMdE8MM2v?=
 =?us-ascii?Q?ouWbtnFFzO7UnEhNQNkMiK29v/1tcn5UuCjakld1oJ98xzvcFe5o09NBH29N?=
 =?us-ascii?Q?7Tjap3fXlcG0tWvE8TKMzn2zvMWhI++5gX4zLRzzHp9IV4oxFGDbEpOcQVP+?=
 =?us-ascii?Q?X7i7a1PyPeltuG/+0wEW/fJAFhhBQ1svI+mAo4fxHzGySd9nWV5erCYxKDS2?=
 =?us-ascii?Q?FotJnDQ51/UJqUsFWK1WRmtSHDb9jStRfNiptQsG3qDWiHv2u8nF5hKcymrt?=
 =?us-ascii?Q?uosmhLPIFy2Ds505zSercHU8GNYaGGq9/BQR2GxGxbIx+y0eXFSXyN3cNI+D?=
 =?us-ascii?Q?aD56G8YxCRCVs8VYNXxdBSwryJpS03chPgZsJA/eNsBSryAbwDmGZ4c+kcUe?=
 =?us-ascii?Q?EQQQdloky13gEIkGpS3TCBa6JosB3XHWjE9AtlmJKbCllHQRr7uVA27IEo0I?=
 =?us-ascii?Q?pZS0Uifb91IFSH4z8FrSXN3dTCxpYkKc5b8rO9s+FFecXEiI1h2piI4t6aqn?=
 =?us-ascii?Q?u8vxjXcoma+WFcfWE4WKxiUPRhYjEFw2pOZiw7F9sb5HNnjZSWDeVYfmiLXk?=
 =?us-ascii?Q?E5SyY+xB2jJSlklWwLMbsJYCYw/GDAamqWAy5ulj54VFsHNm8O2yNMrvO7xB?=
 =?us-ascii?Q?wsMZEuEbXG+lcWj4eYdzU1l2vOZ1n6o9KOMbQXl+XjvRyk34jltKScJ8o7v2?=
 =?us-ascii?Q?Z+pdLhqqYg7v/vkNVpZNwY/1EFKYZt+f6n4SULfxP3FDy/koV4Fm87aORePW?=
 =?us-ascii?Q?4s1tiE3nIbYyUBgm0nua2UecEp1WunVOP6UpSn1tujZcOJt5Ps6PrN5bK433?=
 =?us-ascii?Q?+7PrxiUKN2lCHj+knpk0ek1vMUMM5eCgHHWuPi2HedoI0l8CVEbxCf1zGW3q?=
 =?us-ascii?Q?MtD4R7aj8zdWtDKS5KXCUM78LdWpzJPjpeLj0iTY0VuYUgpGsYpOPpnqnqWp?=
 =?us-ascii?Q?GkUcsgHdDh5Ro5d16ZaRXPHWvFmGWsKvpn5xogQE1GD9Ijfi5W65IqHZSnxg?=
 =?us-ascii?Q?r8wiroxUS/BNqL51fw1WtmZKmwWZFg0MXh/VvKHsf0zf8TlImbjNzkjrSDcg?=
 =?us-ascii?Q?B3pOmUt5vEZg7AtOcWVJFnordGRbNiYWLj9TCgFp0YSnFkc04ApLdwg4dU6m?=
 =?us-ascii?Q?OUoFmo+nBkkCz6ARkMdoqot9dh4YVFPujJeUxBIbC/eAYpYgjLk9fadeCWtU?=
 =?us-ascii?Q?CRU6r6vH2wFOVUObHbggkzwWGizHLN28UKsRgeWgqltzfGPQfxYNDEeQie1o?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c16fab4-9e24-45de-49ef-08dbea781b31
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:56:17.8171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ak3ZIarHhfMHVFCkGLxQixDEX937EwjV8FTGxllCW0S2qt+iGGS3/V1kmO2N0cRq4fzVa3VYX2L84IzF451rKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9667

In some cases, the address entry doesn't need to be freed. This patch dups
an entry into the free_list to separate removing an address from freeing
an entry, so that the refcount of address entry can be added later.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a608166af121..99ade938eef5 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -312,10 +312,18 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	list_move(&match->list, &free_list);
+	entry = kmemdup(match, sizeof(*match), GFP_ATOMIC);
+	if (!entry) {
+		err = -ENOMEM;
+		goto out;
+	}
+	list_add(&entry->list, &free_list);
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
+	list_del_rcu(&match->list);
+	kfree(match);
+
 	release_sock(sk);
 
 	list_for_each_entry_safe(match, entry, &free_list, list) {
-- 
2.35.3

