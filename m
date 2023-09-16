Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521BB1107
	for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 11:38:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UG25JUZheedBe4hAm1UvTtF+htUgIheS6T9JIF8neulepA2VvFMmcF/s4FNFC+y+m7iN3TVgnKiUcxXn24WnixYtLRCN9w7g+8KNCzTt7cv60LqfGfEfp/P5YkgP33H5MtArXFLedyOw9wX2bj+0zeyHUsPMfOk2f1KlZHPaBOcd6OCSxiIzTMgERP6WldWjaLt+rJvOXGhUEDxuHg9dJIrYv8uPK5LzJocT4QjVZ10VxguB/l0IdPxaHQgMbMt7lcn9sUDmqXCdMssBGrF/r5MSawxNT0SXh1oJw6O5JeYLcmf8hmGwNdOuXthHFnbXvuwh4avV625eT0gz41nU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdapZy3VHL8/rSV9ddO6iLmmZB/ipwSsYOncBeSeRu0=;
 b=V7BOVIPUKSgFhqySNs46t/O5As7ABuecwRMEbiGU/DBv1Qy5qzuS2ixOMQ4pnLHq4USzNb8OgEUV/1CZoSn4tVanjN5MXc+QILKINIAQEKxVp/ww6QoSb8JqQ6IEe2gFnBcf5Hm9nSzXenyuyiZhCymYMAHd24bEQZZ3Bm0LzlYV1Cretha4ZuNQbDPBpMp3Vmz6+zIFAj1gsbRwxcVHpElrCOeP0D9UU+Bx2BVGJDSPq697DYKAIwUxQnwOCUIQBKO6D9ybkWdZjmSqDAee8F92N3Miwb4h3U1TSYJPqyokrBp5/r9leo83dSL7uhNwK3igdTCSvvH+QW7AUkU9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdapZy3VHL8/rSV9ddO6iLmmZB/ipwSsYOncBeSeRu0=;
 b=UWOwAW8qSTZ5DUPnqAwzgvPvGFZahCP9ZbiFAizlP+8cyO9bugo6KzfcU0qCkqYFZCFya2E/60EQ4XZ6ly/wdoMyg0ziUO4fRKck7f//nrOA1PvtSDt6uGog1RKqRK7BGWWbuRlc3orxBN+xUZoBeaNe96I0dEhPbHLIELcSgtszYSNzSCPCzrHT2UUa2R7GThw4IEI0faWdaoXRPIMzsLnoZekI329tlAtik7vIQkU7GDKau0CfjYUANpcQlbe77hWHcT1OgE6WPIiXSDRe6+Wp5guHw+Sn2w4I7qoSwhjYgpwZR84Hhq7jjffj0UCqCoDGiuUfJ2G3JpMzYm8cyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Sat, 16 Sep
 2023 11:38:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Sat, 16 Sep 2023
 11:38:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 4/7] mptcp: move sk assignment statement ahead
Date: Sat, 16 Sep 2023 19:38:38 +0800
Message-Id: <4310287afd86c7c2b2f18664bec6a094e7fee292.1694864093.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694864093.git.geliang.tang@suse.com>
References: <cover.1694864093.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: 19738ff0-588f-4794-3178-08dbb6a972ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	elWlIpmnWbqZ73M8BnrkGnpKk2xX3A16ksSlTjsASgFCN3vcPb/gMh9/9ijjvePWSYGZxwf8LEqk+E5qoxCUH0ch208Al0/jJXHqZmqqMm5XtfeIFv3STxNIrEbh+RKdMHQTKEvYKVvUbOwkJVl1gAYtZFvPNszFxlKPom6/ec4adzZpLC3kpnhpZeA73zjl3IyfvQxgEvfkbeRKaqB1GSxT6JhKi7Ha035j0haeoYDInEGJErYJlcU5VTe66pU7Z9Bsq1qrKghcYgiJja3utXOA6dLK8U8PBUAWevBa3eA0DifaG5oFL5omsDP96vy4xATyp//9OQRHEaPO6YdnCLziMftcUTIUCNAxYjTKFsB+dPkoGR2f0jprBAZFkh7O+r2IKCoYJas93bSGl8+Q7VlyhQmhXS9qqADsMUHaC+YAKnId1rhP/WHh7XhCPUtABYh4E5ogqHDmiikkdKglSPxlFROUzdFRTSGuPBJ8T07WLgvTLsfnMamJUfxyIk+ibmNYqSzktRQceQdm2unbCiq6ShgO57x5BLhD8ohv7E3Raf95ZkMmKcYHFzg6t+xGHyl8THFrVshNA5VoGOQM8zwVichyfA/gNGPVWcZ2oAo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(1800799009)(451199024)(186009)(36756003)(41300700001)(38100700002)(6486002)(6666004)(86362001)(2906002)(2616005)(478600001)(83380400001)(107886003)(6506007)(6512007)(26005)(66476007)(66556008)(6916009)(316002)(66946007)(4326008)(8676002)(8936002)(5660300002)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q7iW64W5Ozk+3cpU+ggG6UURxsxg8W3Z1yW4ZKhVLERH4Edx+uPPazu3cImd?=
 =?us-ascii?Q?zdtrdBOasTlnaI8U5c+HBhkY5y9Hk4V366huMB+nfyROLd0A8Bi/JulHQIhc?=
 =?us-ascii?Q?wpfHCpB4Sh3U+gSJDn3jIM36qvHpSucKIN+pDW/+Q7/2eJo2GCQapVryQU6v?=
 =?us-ascii?Q?Zb35zdfQlaLWYmsU3ZwnzNzpiDoWpHvP5AsKU5abqcMxLWWwg4sZ3515/uBD?=
 =?us-ascii?Q?nVWMbAj97NYy7eeuSPbaPF22fScD94chc8cj0I6khn0bHytIw2fz2ntVHb13?=
 =?us-ascii?Q?TDNI/FEC6IXN/VM0wj6Mri/ctLJ+mKlC6fUqNLJLddI1epY4oz/26Zb2pLwK?=
 =?us-ascii?Q?yO1IhTON1VkS9zcQ0CUVpVAfQxTd27+koRVeKQtCcq/PqRlj2pRTrMzDiHKP?=
 =?us-ascii?Q?g3l4SCLCtXmYXkr/MZv5tsGPvM7KLHmT9xzkUYrDMELK2UDrhwAg6aZqEnYN?=
 =?us-ascii?Q?JWxPZNLpvjXlD2a9mS4mA+Oe2Hi06yaGaJqD4fEN4s7NKM/nDbXYpv2rqWOG?=
 =?us-ascii?Q?11Kg2lU3q/ZSBiuFx1IqH105xzKm9eGNYT7UBudPwLC38jgB/D9SfPGRGkOD?=
 =?us-ascii?Q?pFuHcN8nXtEF7WbThLZMPS/gnstStFuKFhxUfaJskoKBti+yNL+3I+avQac3?=
 =?us-ascii?Q?K/sWRddsRKE9RSzQ3kqs5Xotcd22VmZZlOfsO7fMbYF8SjU7HKuSlEWiBZia?=
 =?us-ascii?Q?3ghq+8pJIQY8E6AMT9SJbA3SAPiezckZbtfJD0Zx7D4Q9fa3CEX8z12SgPUw?=
 =?us-ascii?Q?3K34H3bbKddEpCgz2zq2GuZbgc4p7Lfeer4puJC7glReqI88m92e9+l8T1Db?=
 =?us-ascii?Q?PNNhty3baRFTYVGheKP5BGIkcPqTFj4wGyN0cQT1McFL6Z8WO3q3KNRrhVqi?=
 =?us-ascii?Q?mSxdadVeNxk1js8hOUrhLD7KGpSLlkJa+PkzOEBPXKyrcJEROFvdVjeYduEf?=
 =?us-ascii?Q?P7VRZIXXi2qpC32g5Llw5nJy+ctSQdHc52wdJRfbjnq9a/dDcbw7uGJe+7fd?=
 =?us-ascii?Q?DCcGUIWw5tqss/TdFlopslSErbkGftvG/M3AU2Fnx3JyQt4bqExugEq/aqsW?=
 =?us-ascii?Q?eT37FoPQ6KO2HLkg9iIFfAVZHTsvLxjLzlJUH1oS0E++asTEf5q6q7zRcNgH?=
 =?us-ascii?Q?SePq5+F1v+bYyzDwqtYkgaHBLV1fE50fKrimX9hAc/JTl3b3YbAJNhloFiGt?=
 =?us-ascii?Q?x8M00JuTkYWK/Iaw7x4nr8oGAZFWmrlGQfzzaTsn6OGvlz4855/a/308L4rt?=
 =?us-ascii?Q?xz48J3b+hwXRPaXSSHOCRjTP5IrMQQCud+0AcsCrgNzqTCLQfNx8tT1+5es0?=
 =?us-ascii?Q?Zz/664MDzqjIj/Q/aig3fvAX65zIqY+Bh1s/B5Lp+ySIi+BpY2+4KKlnRp9i?=
 =?us-ascii?Q?ZyTFBNHTA/ukVKx9OFLBAanogs4x9ms+nhEIOxWNmnZZv1ifnCn/JAr3Desr?=
 =?us-ascii?Q?VrnjAOseFDq8tZScuyJLAJR0xmf08bso682xmbTvDpbcT+fW1ZB0R9nSI5KA?=
 =?us-ascii?Q?HX74ZpwK+f/RZQOHkeo2/qDODgKA7Fc18xApA0D6Gkxx2gzbGvp4mfxq6Bsh?=
 =?us-ascii?Q?ZemABHQXAfqQ3WCPfm9ZN7x+2LhDDg4oMlnNuqTo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19738ff0-588f-4794-3178-08dbb6a972ae
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 11:38:29.5698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ir0OWalnncucQGiJiKbq4RwyVXVpyikUgLpktQxSxo5j4zOKAohv0n6yKBF4xZfeYAkogbEuvWZ8unH5p19UXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371

If we move the sk assignment statement ahead in mptcp_nl_cmd_sf_create()
or mptcp_nl_cmd_sf_destroy(), right after the msk null-check statements,
sk can be used after the create_err or destroy_err labels instead of
open-coding it again.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b5a8aa4c1ebd..78b935ab7d3b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -296,6 +296,8 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		return err;
 	}
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto create_err;
@@ -319,8 +321,6 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	sk = (struct sock *)msk;
-
 	if (!mptcp_pm_addr_families_match(sk, &addr_l, &addr_r)) {
 		GENL_SET_ERR_MSG(info, "families mismatch");
 		err = -EINVAL;
@@ -348,7 +348,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 
@@ -425,6 +425,8 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 		return err;
 	}
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto destroy_err;
@@ -454,7 +456,6 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 		goto destroy_err;
 	}
 
-	sk = (struct sock *)msk;
 	lock_sock(sk);
 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
 	if (ssk) {
@@ -474,7 +475,7 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	release_sock(sk);
 
 destroy_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 
-- 
2.35.3

