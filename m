Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6478D6133
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="4TwXrWQR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbbQ4iSGqM6RAH1SBzHIrHFe3b/Z2m6GniMbOA5vitI+Y662IJE8DegvP/Sr4u1vVzrzBPRflJEn4qAontqAzzPkBwv49qRcX1cdV0ovuFydbJRI9ycAP6p/6UbEQNkLJywQImkg3RTqpNN+qAJsEkZhVICfcecjXEJKAmqCQkhvKzxU/3QsMqg7N93m2fRs8RDI7dx34yjmJlRVqdJNN9xAlkQ8N/DV8hGVsVXcOHwxxU+km8jY+S0o2eyje2aG4DTi0zbtAENtonIk0i/Fueavqv79llcSG+6Om4JuoTlcIyfnhiI1BINDHZmLCWlH/1JVRHp3QMeJ0+/6fFYyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYuEwtPTT1Xgh2FC4RUPWfAfSYFJlXOMeXPVpClzi64=;
 b=D3i5nSpgW/Cj4XsXJRiCKV63hsVE4VRVQ2gEDCzU2WdTB/CiK9jT/F/pJHW9lNMpGVojOl7G+OIbkmvBSYqN4pemnzzG8eZ7ZjB0/IsEC7jrpbeqsV+ShALPzRH/A7ma0c5qeQo6B4upieheluU7Z2nj16g6Gi7nubfkh547JFf5zwO3MoJ2gEdCrdc9PQXrx0onUn2OeoWA4FSkzPxMa4HoYZ+5G1Nx3JHVinSavTCJCTGTisncb4vA3Cy/nOU5b4SsAgyDNeS228mWPlQflMfkowCCfw9lZS0sHI8JXxm5UiX3PkCd5SObs3uC5JP+swmM0AoOZHNjMQMh/itlDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYuEwtPTT1Xgh2FC4RUPWfAfSYFJlXOMeXPVpClzi64=;
 b=4TwXrWQRCOjqHyy+A6m4DAEd2+qcwswPh5g3SgCERpyVmCn+vLt8E0jyfxS4c2jwx9nQN/q5+6+C7ElMFjQ2j9NPGCJm+STS5yJxMI7poTCBJqBP/ejaJ2mWNkaVGr08LkbbCHyxK8GzqflUhLw2LIwZRWmT92orHvsfik0K/QXIe5uxAuDfQa3w2QdLUV2GtPeeGIHy2OiS9tq+iyllyR2jLlV11w/eKOLf1mh3jnSyV8bEvmY+IBJySI5xw7l/qggldzKGpBOf1Ev+DrRtXCzHUV4T6+iBjRJwKXgyvVR/OK3WODGFxt2K6T7fD3Ghl+HgFTAkalWguy2i1Ne3oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10052.eurprd04.prod.outlook.com (2603:10a6:800:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Tue, 14 Nov
 2023 06:36:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:36:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 12/21] mptcp: add a prefix for free_local_addr_list
Date: Tue, 14 Nov 2023 14:35:09 +0800
Message-Id: <8291e2fe2ec489f7cda62168aa604d0093fc4d5e.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0095.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10052:EE_
X-MS-Office365-Filtering-Correlation-Id: df8cf125-da24-4d8c-6ed0-08dbe4dc198c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NBiYqk+ArdzA+wT6ImPi5tLqZrAHyBCw/Ccp6bza3m+ma2ssnkzYT9NoCKHdZHPNzQD+6bx9nGx2vsbmikC/+S4wHG1uOlwpoeiwQX/7K22PmEPGmNjIYnaFuDTv9BfiAekxUg8bUJPk+vbQlWJVEZnnzX/a40JLcFsG2wxRovPvsY8vhZlUoCFJZoTZGCl63XTn+gi6S7O34XB7fCIyS86MyYuyCTl6E47FUzxMxiN2VQiAWxfyF143ZHkon5USMZ9xx4W25npUazqvZHa5ADN6o3xOEblpqMaaON6g0+NE1rfLvpFZnoWRPh6dEHcb+64IyHYin6dtgvOUQzWZPluMEoZix9/LIiFfl6pTwg6Jya9kxJsxnxDylE/SqUtCfEVtsJwXM6ZJu40DH+ltzudQblLSf0NSrHQXhFWSBhNeQtlSy9i3JcLRRr2FAiTTVpsWcUypJtU0+eGXRoodcdJNTfr3Y/FtkPzus+eJU1l+yShJJADC/9KMfwZMKBoX4FvGZiuqEs8WDO6fyYdcMrFdv3dE1BmQghKyh5i+gZJDIaVB6an4zCAHXZIOtPXu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(107886003)(38100700002)(66476007)(66946007)(6916009)(66556008)(86362001)(36756003)(6512007)(83380400001)(6506007)(6666004)(2616005)(2906002)(41300700001)(316002)(478600001)(6486002)(5660300002)(8936002)(4326008)(44832011)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NeHUsSJjKEfQV9/aqlQcm76C50kl01eopTWmYYxJpKl4udmmTPnThLNdDwTg?=
 =?us-ascii?Q?DT2dC8SflkEEssl04HV+dTXhN4TDMEY2DWrvOIY+7aCBn4qPGonG21CP0AI/?=
 =?us-ascii?Q?9e0mk5YWmUAMvhD41OnZVtNry3Axlce7mgp33zob6czsUgUoskB+BNP+Y9bG?=
 =?us-ascii?Q?QNsEy6bpaACvCJnyr/sG2uwVtRZYFjZOJk9t3TUpHFKzT911O+lKwQx48gon?=
 =?us-ascii?Q?8YrXOhpKNz5fwrmGDAru2kSTYZKYJ6EKOiaj3jRtuZgC1ES/1WnR/BEiLl0B?=
 =?us-ascii?Q?gRG8UggyD7wHflvoRE/gtBEWRGyxnX6iHbKkhrehu7nO2CVX8ESfgAahsG0q?=
 =?us-ascii?Q?jVfs1bQl4G0sOsDaEwjfCmYtw/jJpGNXjQG8/pONmOBkFKf3B0zCxZ6DFyJz?=
 =?us-ascii?Q?JrT1bcQbFy01uy2tPSjXMkLOvB0DdinxjLjl/C9PpsHA+KePBAewXolouSkM?=
 =?us-ascii?Q?/I589PSOjitnaXM062N3jO2MB5St6qHqvF8A/oAg7P+Ml2rA8Tm/7XC0uJ/f?=
 =?us-ascii?Q?l17AxpEu82nFf9CXxrZWyEnqSB6+xJySDk7Fhh0UhYbCXAdBOH+G8oj5olkv?=
 =?us-ascii?Q?dNKmmRWXW3xOHnL3v8l5FzyPpjF/g0j1Bt9nwb3OSnzbRsVqbdpBnF0PE5hK?=
 =?us-ascii?Q?QZmJja6aUhjfuNN9aFaOqs7hAJK0lJGubYRTt/yini9NslZP3R3uRThoOarp?=
 =?us-ascii?Q?9PAnhfQmb7qEeHduQzJ1T7wSdVxP5iDZGqnMMtfiHdBikzlNjXMBbJKoDXis?=
 =?us-ascii?Q?3B4HzizGbT7gojijyaQmhTeTEOCmoxZdYIOJQpo7lTNXEI/YJ1kBP/X/uc4N?=
 =?us-ascii?Q?hAIUd9wLc3i5mh+ch28KwPBgvt7S1PCcCCReL4mCXs0jl7nfKAdi2dfxZZN9?=
 =?us-ascii?Q?xYFFCfTMRMlPOrxAdWAU4DeoUcVJyhXUtmwQActCTLNe7Q5m6/+AmzJef2oi?=
 =?us-ascii?Q?2Ez0kHIBEb27j2C/4egJ9lWaQeXvr9KK8lFp6GVvYrpnf3mgnWtwjv4CJdc6?=
 =?us-ascii?Q?NOGfMH5zcnhWllDlTAEn0RSdCk4lhgYMuvKgwMsNl5jLB8AfHIcoKxGsi72h?=
 =?us-ascii?Q?wnRZVMEgi8dQ+IjgzOZEEfruf0lMmmkud7eI3hPnCO7En6MqAdNlf8vYGUWi?=
 =?us-ascii?Q?86xGs3Qb5JSFHQgElMJ/+o5vFN01YOW1Br4L8K2UZ0cvWP2H7bHdW4negSAF?=
 =?us-ascii?Q?keyOcIoivU/niQieSc+OSRmnxVMKmfklLwHtfvAVs9BbebKQAdCj3/Pba9Tb?=
 =?us-ascii?Q?Sl91RLXiaHRzH243dL+etKMzi3PMyflJSF/fnJQiKRzIwxMru21thIRCLatn?=
 =?us-ascii?Q?/XAQg6c980ptC6QoiXHg8MJCvTdIDQAOaAs4gLi/bQXHpiTGWNupAV86LQce?=
 =?us-ascii?Q?RHA4tNYp3Bs3OWwgp/d+X7IaxU6CKSXbxzj/lYHkZVsNTRekdPy+VwVYSKLz?=
 =?us-ascii?Q?zdVV84v3O9vMx+e/gIx1aoDLBNvolR7lD7qyhEaRduLT0dxqu9tD3uMfF7Kc?=
 =?us-ascii?Q?Uvf8pjK1yyD4YZ9NlpEpbwWDj8XIlNgLkXk+oHAxYRZyZ2aNx3TFcijm5YtR?=
 =?us-ascii?Q?xCMHvRXvcwYWZaMM1iSp8peDUGH2TL592Rszmfo08QjIZih1PBqy2DE4usKb?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8cf125-da24-4d8c-6ed0-08dbe4dc198c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:36:57.7270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SQ+TG+VJFBohrBGVBgwBgBe8hCmRmvBJQwo4PJFkMOxOYmSERFhmzDpJeEavF1zFd7cYxCi5bQkh01bYyprjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10052

Same as other functions in pm_userspace.c, this patch renames
mptcp_free_local_addr_list() with the userspace pm prefix as
mptcp_userspace_pm_free_local_addr_list().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.c     | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index de10be21bf26..70f6a510e3b4 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -7,7 +7,7 @@
 #include "protocol.h"
 #include "mib.h"
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk)
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6956fde61c68..f2f0ce608219 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3321,7 +3321,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
-	mptcp_free_local_addr_list(msk);
+	mptcp_userspace_pm_free_local_addr_list(msk);
 }
 
 static void mptcp_destroy(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c30e59278080..76981adcac22 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -943,7 +943,7 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.35.3

