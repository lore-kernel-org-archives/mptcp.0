Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2043.outbound.protection.outlook.com [40.107.8.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D40E79D8
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MKk0xch5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImvXbjbNTqPaib5WNBc6gfETyu2F8gs+I4wNj3CTEX4Qq93ZAF2YO+Jywj9eJaJ+8dVxamP+nxFPJYrkxuv3lxNOezI2deY+Mg4d1nx3a26PCMcr4k7WOmDOEf41xxlmVHoQ6zMrxDYSIk4PnuC/MY6XMXtm5/nLqeA4acXG8PFuKgxNfyeryJvmm3pQ1L/K1lxdu42IroLa2w3LbTJSuFVzAxPCK/aRdfJa6uKAVlBui9lsAq4mUJ7Ca6/jcCNaZWZeY/IlicOyeA9y0dh7nkczK/ilRZgg/sdH0SRDM1uLOAeNHZqWo6n9A4gW6+zcv4VgkOyiGTHooLEXKy3bWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dph7slE2gv8EAzbuXoW1AIj1s2dm2ND+F4+zezBtKwE=;
 b=L/fk2rDM8eScLVHmlynFtoKVltpGt/lPcJ68PGvtaCh6PdTrt/chjt/Bqhd/RiJKHLajZ97vTbLATZoRJO8CFHvFb7CknZrwCPdiTgV5gOI3VUoH0FgPc2B2VAHm7rosORk0rqFVPaKC04hGR2oT4AvmOeHrXcSLZW9teMAle8ytu/OYUMx6VxWCFk03FP6g8i3G3tjH0l1aNdtavQyA8ol2OXaeLVk3h4gnw9CMKRDSRcImnHhoLfEHe6uJWZgP5EuVHI3hFxkzf89nNh/bgwF4pa+iNE0IJCP5mkTdzdeCMORsDTksnq0SZiioYKO+RjOCYZo215GQKWoqlru9sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dph7slE2gv8EAzbuXoW1AIj1s2dm2ND+F4+zezBtKwE=;
 b=MKk0xch5nmRHOyzNWn/RgqkFaeJnV5XQj4bTB8C+WlwNa3j9jvyqlRckTRO8NoZd90JOqaEvJxjD3PDffwqVg/61kfH1Pl7H8BTSmBYW3BKj2wczU12O1kI/M30HhDyU6TdgpUnELtVxGM9IMrIuvHlp6gl4awTAbQ9ZyKefzLT3whSjyUsDYEBytNTKupGwn6pu8vw5SiUSSB8FlF9okO+C87k1aFEFT3vYyKQTfGv7/S0VGs1NlR3boJU0cl19aE2P742etXJ2IrMkhQngbVaw16sTMYb39gasABO8wYhgjc/gAUX7Uzf4GqKywjMm8XXBp9PfBQP2w0zHd5ezTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10038.eurprd04.prod.outlook.com (2603:10a6:10:4db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Mon, 13 Nov
 2023 02:49:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:49:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 07/22] mptcp: check userspace pm subflow flag
Date: Mon, 13 Nov 2023 10:48:51 +0800
Message-Id: <1a488bd7ce07fab41044f1cae9615e06179d75f0.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10038:EE_
X-MS-Office365-Filtering-Correlation-Id: d1942945-b288-443d-d9b8-08dbe3f32e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fEZ309IOyo4bh9sEGf256V3mXSZ/NLGEGYDkHd9xlv7VZ9sqA10FLt1hmFlibDBXu5FVWrnZVP6H7+ozu6bAWFMGmFcjM9lZN78E+jNvMRuImR6Akv2Wl3lMCaV0GtPj4NViROp0mNoXtsmrBmvmKw/kv/sCr8+zn7wn5rODBF1LVvHl6ftKbMhj1oka2NEsCoEEMGfB4i1ueUg3uvQcAM75+jiMIfg4S9+3WZcLceDbV8l9gQQ04LrDiu80lTDCsgNgJ1fqUZUCZdoqrdktPzjv0dMvTbXfs+gNrtVYYYI9UYtHXrGOpQq/GB17DlCqWsfgbVLA89zqUwLqm+LIY0NQwqPd1JUuJjDqzOGs/kl4TiZ6Fv9YL2Xlw0Bcq2CbWvAZImmINSgCd+DcTBRjCV79EmVM5xEGDaSNofjVZIV0IYCootjxjFRU6dGGGvD3axN+QJUec4sjXVUFyBUvszkKm26oJFL9oz8D+N15gNIToiHWXCG2xxOZ+ZXOjO3HIzJI+0ESfYFvczK51dbd8dBs2f1qmXoT8uxlPJZxIapTCaFyO5PuddrTC3DWLX9C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(41300700001)(38100700002)(36756003)(6666004)(86362001)(2616005)(107886003)(478600001)(26005)(6506007)(6512007)(6486002)(83380400001)(4326008)(8676002)(8936002)(44832011)(6916009)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NhdKsQuWsnoQJxGkZBzx0txHvrxtAAw0/In6qkSSuTj7E3yr5nzfKdzsRVqI?=
 =?us-ascii?Q?G2nFwehADqOqXJu5OZK1qwVjRp7ywctcwVsr4T+COotRxMhipHZcYMkAiLc1?=
 =?us-ascii?Q?ppu5+1XidbT9aVXjTgIQug2lY/2jqTzGGxOLigozWVbMmOOmN9lvMEv4s4W9?=
 =?us-ascii?Q?i3pMYeiL6No2IYc06ZvkdmOrVgwp2r9eD0+tQJ2gg//IRqoGP2kzkkHbXQzc?=
 =?us-ascii?Q?kNc+9THx3niHcqesJG9lHnihXZO3O0xRrX2LC8xmpaDwLHpO8XLcZWaljdvr?=
 =?us-ascii?Q?xseY1V6awXSLWq5XH2RZjb5uttjxksoZnJ87SUPGTaJfSxy3YvnOddP7jmGW?=
 =?us-ascii?Q?LKXQq19/DVfOu3QJpU0bpFECchdw01FMObxxinj3O87hf6Xhvs45jQqhTqCZ?=
 =?us-ascii?Q?rsRxgwl/M4r+7W4gqNZUFT7O5hMnYduT+ZvGOucqJpyHzKEAEuqigkTlk8Sm?=
 =?us-ascii?Q?eZTCixts4clT6J37AIhPQtZOO4LB11x58Q2nIJZhKUitU0g4EBK9JK6TFUCO?=
 =?us-ascii?Q?Gu7rsGTS59URT5FSRR+AIENQVlD+nywxEy5eSWRQdHwFjAWPV8OUdKAH+Od2?=
 =?us-ascii?Q?mVy+YNsFqionnFJGpJkjGm8MyTo8MCPAcIjIt/5mgM4Ae/SAErQ77GHoZvFr?=
 =?us-ascii?Q?/hqnem8o53ztXodbgsAzCAsm6K5Uw9rLk7VnATJdTWOqWKh4Wa3O8MAgmkx4?=
 =?us-ascii?Q?dQ8+Qx1dr0f1vAuk7cHM5sVH8A1ioYGPF/xSnbl+/E6U7Y1Dfy1KJ6DGkXLU?=
 =?us-ascii?Q?QT7BEdZRav6ywvlWYIs+1pRuj5pSDhq5PGZo5SdOWWOLgAmCo564rQP1CwPc?=
 =?us-ascii?Q?ZhwFvQ0cy4VxIfUeWhDM7ov8ZN50W0AVaDtZ7sojFIg+cfhiHoYD4jeEIRAc?=
 =?us-ascii?Q?hdMm/r+LkXYVjs7vmz/oQzFXj3T3v50C4x5EJiw/JzIJMCRdgZC+h9FozzrO?=
 =?us-ascii?Q?4kb9UgRXJs36ruqe9PQFFyRd1N3VklMuEyV32GSY4A5Q1R1+lf9X9ivUkC9h?=
 =?us-ascii?Q?bd0q81QFNodtw5tx679NLMU+b+UKavWQop76AKRMjPbZzbOXruIlb76vAwaB?=
 =?us-ascii?Q?0/IqBS8ZnwzQxaOA6FdvgrkFxzGf0TYYJ8PsDXevWSBH05YfXzoSBA8uxhjw?=
 =?us-ascii?Q?oymuX5vY7vUcTfepeYgqnNUSiWtq9FboOAif46u8kd0dUWfggx4RAvSM2w1l?=
 =?us-ascii?Q?uKy3+gXWeLi+kWqEW6T25KoNDfsAx4GKbzxe83KUehKUaIDXYNNLcCmN4QYt?=
 =?us-ascii?Q?/IJ+xJFym56rgRE8+gOvYpsx+H9vhtx9mGAd2HDJpe+kKlXLHFP3279TTAtl?=
 =?us-ascii?Q?CGiIbw2/sGIvLwJ4DjF2aBFz9n92Kj13E3NHRPpf4eE0RbMgwXVAja/7wPzQ?=
 =?us-ascii?Q?t+dCN/Cxt6yGCl8UuCPfUOdSnuHP1oNh3fpSWbFTMcVb/xGfHXVIpxpxbDhg?=
 =?us-ascii?Q?V6f8A3aY9cBdrUPvOgYFxeR5qVCAnGVM3aafGTPt5r++I8t3mPkrsUn90TRe?=
 =?us-ascii?Q?WrrkYUO9pI5U7hSaiZaoxcMFp4DcvJ48Y1tJ4W2P+7wIyU1o0RLGr4CvZOIv?=
 =?us-ascii?Q?JS9Mpoo1uYl7RQ5M/YNUdlHJX8989mTR2GMV2cS0?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1942945-b288-443d-d9b8-08dbe3f32e90
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:49:40.2469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sj7VkJNAGFPjWlgAPAubssHQhOuKuUijCkoaxVH6HGoL2A4eiAHSiBW08b5TUNuTuQmAC6AqsdHhhGhj5616CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10038

This patch uses mptcp_pm_parse_entry() instead of mptcp_pm_parse_addr()
to get the flags of the entry. Add MPTCP_PM_ADDR_FLAG_SUBFLOW flag check
in mptcp_pm_nl_subflow_create_doit().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5e45e36ce1d3..de10be21bf26 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -347,12 +347,19 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -365,7 +372,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	local.addr = addr_l;
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
-- 
2.35.3

