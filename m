Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64039818
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 09:12:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6xx/Qx40ANgANSLT3s/M0tTdXG4nW3KBZjZOMSU9ItHf71+3Ume6jD5KXFFqYWsrPfDD2QhkWEYx4zz6U8vNF5+bhWlnNmllNm18Lc2yyDzhNsA4jIFRnHPEBHxOTVuyISFRjp2imfcre4n6ELTjx23vjElBa+zMocnEmBr1rn5hsKoPBN7CdGj5d2+cleup4vXBoR9GJWoPdEAXXv7jcHrtZ0Sihus7Lk5THzcBC5jETrSzX4AEjyp0EsdJks56zJ5d4NVqkNs6FlyXBioVdrqxO17TiHeadLx6R6rqcI/yATfQ32+h5olH+1xJ/cejB5jbRQ/U4xcD9fbzZwTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3tlLo1KZLco+YnpY6eyAbAQYuM3x6ND4bK0HKteHXg=;
 b=J6alEDWCioIwSGE3TYBQuvlmep3sGxU5U/YbBaPCm2ed+HlLfTOckwjhqCtlYUTJwtvD8xmLcj36K9zy/UPiKYOW0HWU6uGjXdAOpYUcS7nL8BOBtLwqdXdpVwWgFO7uMrmeY3lnuF44BMi4tHSWFdODGaPT3x5LxQ1emOK6isp1LGjLUs0SF/bz/gpRKNsVC9EkJEWK6KxrqtWPAGOc4UaaS3Aw+898ZbBFx0qY9fRkNFyJw2VPh4+eHZiQ7JRBTgfptY2Up733D0c5SvxP2bTqSRfOXMZWWd9VT3S1d5VKtbV9Z1MwyzamOCz9wgRKZN2+h02j+gMc01rNwqHXNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3tlLo1KZLco+YnpY6eyAbAQYuM3x6ND4bK0HKteHXg=;
 b=pkW952BdydrufTcUPhZyLgOT2K9t8PBsunJ5bJ5x+VM000vTRa2LdA7sWfURr5aYuRgBsrv2I86agDXdMf7yn0SPxUO2Fr9nRMPGHwyEFu277piwMaLl2/BL1gk5uiGGJ//nAe6Dugq+QEbGchFcWrrVPNx/GOzZGvKm/l4y/cF0cc34MuW9NJg8SQU+LPNWEIy/bY5l0/GPWelHdPWJLAqHKUoMGWXiGRDe1ECB8TNCVOyOZzZyDWeU93FVE+RkFLT2N9sLrp/214K3Zq6enko7DaS7wRFNRZKHfHxuMvBX5ZfBrQP8S2aJLDXepRLOLVi6t7kXEn087/n7p3+fvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7553.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 09:12:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a%5]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 09:12:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 6/7] mptcp: update userspace pm subflows
Date: Fri, 14 Apr 2023 17:11:09 +0800
Message-Id: <ba3fcb8e233b571eed4b83e0b38a43ddf1641ce7.1681463340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1681463340.git.geliang.tang@suse.com>
References: <cover.1681463340.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0240.apcprd06.prod.outlook.com
 (2603:1096:4:ac::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9ace0b-b24d-4350-4422-08db3cc85088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VMCW/W8pREP+5FMqcu2z+AM3gdhqkvDOeZbrkgmZMhI/QtJnuYtoAAPc+HnD87vZ4Miaq6CAA8m3zZ1bqOOe5Wl4Ksi/iwsfTpDrOFWTHvN57AJ6hOvii1oTVPTDNRs8RiHBzNfd71czFnb27t3iPlaDG179wtgHGeS/xBxhFgJ+CJxoMrMPDBUmtvAJYMEj0QzwLBQrpvJ3Q0K6lzahpyh5zcRurjunmhrxnKP1ptMViagcWZ9MasLZInPiIuEPjg6CBXitkcSZHWqbV9iYYZINQ070uv43SiwdPyQ0a7XPw+sTALpeCwMlxIAVSeuPFQXqawMcN2/LDFUf2NHgJV1MFSjXxSXzOSVaO3iBqQ54CtPqXlPdxaurt3MLIFm5kQ6CIa7UtsT/dgDP/vN9H3iP5e3jG4PhqVrakcETmMlk2HBLah9Pn2NwKk4n3O0fZDpPr79vc//ZJLQY1FIlvE/TmX/g+pu50IxYdAqyBJPXIWZj6q3UWtkUJ4fkfFAGBD43m7akXYuaXOFCEHeM2VJlyARGMWaKYQDDKdS3pqQH8hroZ5GvflSqsl4Iv0oH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(478600001)(6512007)(83380400001)(36756003)(2616005)(86362001)(38100700002)(2906002)(316002)(5660300002)(44832011)(26005)(186003)(6506007)(66476007)(6916009)(66946007)(4326008)(6486002)(66556008)(8936002)(41300700001)(8676002)(107886003)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y5OgwdrqMVXJducuePJc/YwC97SeZBjfNPg2lZIOvB3cj7m8KYtgPPO7z6Wo?=
 =?us-ascii?Q?OC71GYBOkHeq19Znj85op2sS6yIHVPUGzh0PmIR5rxD6tgZsqnUyWs6RMk93?=
 =?us-ascii?Q?AmIrIWlKXIUv+r7jXQ57w6zqYMbvsw0BRegXwukK7heqVf5R3ge8+IMcl67l?=
 =?us-ascii?Q?abNjMCXjr+K9MDqPPaDvz2ZnFBJ8luLAMQdwuhdOfHqcWgq5ab9Te5HaXlmG?=
 =?us-ascii?Q?PbPYjOmdm4TW8AyHBJIuKKnW/UwOnDFynTsFS+ZRdJrN8tmfd2YzqRR012cr?=
 =?us-ascii?Q?BmKWFjfGXR0VqTm6GaVdhV2S5BE0+uPmQsy8vkRIqffzhkZTngHpQFC370Xf?=
 =?us-ascii?Q?kWArac4JoHxpO75FMgdkc/tzGNrXIiL13yygu8FModrnE9pvWmd4f+usSJPR?=
 =?us-ascii?Q?DyfDgitkyHWvf9IBe9+qN5e3plFKrt8Vmrb8Qp3/WAA0/L5Ql1blUsut1gFD?=
 =?us-ascii?Q?EbLZFxtLVE7lcITQlxVDK+jVYVpnGjOAs795+b7fkTJA8QLOXiWhGRbtLvrI?=
 =?us-ascii?Q?K3l7PzWQa+8FQK5ge9jRhK9ds2tvcmQAo+yfI7npH5vv2djqjZli5iBJ/WHi?=
 =?us-ascii?Q?53KPu+ukDNFQZ6HOgxCqNcEI3sGhLETs7c8DnWsXj0B0VGZ+QOsQPXxWM4j9?=
 =?us-ascii?Q?pDfBiUoGdmvAlJEVgoGFYTzdPkzWqB5ocRan6hoIFfCtF6x7YqYDBf0fX3N/?=
 =?us-ascii?Q?XP1JcWoXPApivlDKdScPtO+/hzZLSEolQjl2dsUbCCSh1vT66NsSt481WZCi?=
 =?us-ascii?Q?TN/BDFprBisvNVRy729mXn3AWO6FAYuziVkLAm/YPL7LkRe4pmfKda6G7IG9?=
 =?us-ascii?Q?mlErzKyD1gAjgR1a+SnLrHDs6xLRGHwDdQYOthOdqvF+nB2f2vsR3fm8DF+C?=
 =?us-ascii?Q?tWuWUolxlX2LFCkEsFVZBbGoiYWc50V44cb/OlBXm7ww3vURsM8Qvypl9lQN?=
 =?us-ascii?Q?UKtI0InOLLBYOGZyZgatg25h/2ZRjiKZvF0cv2XKtF5sswQ3ZeXWF62NQk2K?=
 =?us-ascii?Q?RocgtQzKpINv3KyjN9MvmgfuKzznD97SaVbuRyJMyngPxbkcEj4eIkCC7MIZ?=
 =?us-ascii?Q?YZGhui50dzqRTADVEnh9UqSgA3wJSBZd2AAXkozmi46WTCkGU0o0+FUOpCV3?=
 =?us-ascii?Q?+DkSJSsvojoD92LhSgIM4rYvssbfUjSzjAc+CvOT7G0XGq6fJobrMpWbA9iu?=
 =?us-ascii?Q?uoguBr8QhtiXWXu/K5D9X2XU6EncB5qpeZsa1FcGw1zOxyAfs5yKG8AnfWFc?=
 =?us-ascii?Q?NzMb+WON0+cRp/xxses4H8SA9Vgi2YRi4KKEq7xOVSDyya0DAwGOrK3e/SX0?=
 =?us-ascii?Q?e1vBt+sAivh7jVdHCjggICD26ugdGH1WDfPnKnGysZNcdMBfesc1q3HyUqNS?=
 =?us-ascii?Q?dkDkcv2ivFu8g5OmKyZ02nx8bKv6TU+xJDNsF9NpoAosAIG1R6IqT5shkCl6?=
 =?us-ascii?Q?nhgcQKYGNLloIBrkEsPj5XZHEHUxPGNUCD0f5+dLarAJWUTze4Z81tap4+49?=
 =?us-ascii?Q?e881k0sQsVWo+Xk0KZeYitu8T81h6c1CX7K69MKHu1xOsdxBIUe30WlLZDcJ?=
 =?us-ascii?Q?G67t2P39pKPdhn+ijnhVmCpMus8CKNZDpfPVNm48?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9ace0b-b24d-4350-4422-08db3cc85088
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 09:12:04.8926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rD0iozcuYRFy76kYzC1jZPrO4Z+stDoJMlTT/H/Tgc6ze/KLqFTTeOPXaLJHnNN09I8lqwDb80KrHEcRpZlM1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7553

Increase pm subflows counter on both server side and client side when
userspace pm creates a new subflow, and decrease the counter when it
closes a subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c           | 21 +++++++++++++++++----
 net/mptcp/pm_userspace.c |  1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4ed4d29d9c11..bb01f15d8e0a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -87,8 +87,15 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 	unsigned int subflows_max;
 	int ret = 0;
 
-	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_active(msk);
+	if (mptcp_pm_is_userspace(msk)) {
+		if (mptcp_userspace_pm_active(msk)) {
+			spin_lock_bh(&pm->lock);
+			pm->subflows++;
+			spin_unlock_bh(&pm->lock);
+			return true;
+		}
+		return false;
+	}
 
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
@@ -181,8 +188,14 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
 	struct mptcp_pm_data *pm = &msk->pm;
 	bool update_subflows;
 
-	update_subflows = (subflow->request_join || subflow->mp_join) &&
-			  mptcp_pm_is_kernel(msk);
+	if (mptcp_pm_is_userspace(msk)) {
+		spin_lock_bh(&pm->lock);
+		pm->subflows--;
+		spin_unlock_bh(&pm->lock);
+		return;
+	}
+
+	update_subflows = (subflow->request_join || subflow->mp_join);
 	if (!READ_ONCE(pm->work_pending) && !update_subflows)
 		return;
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index e5b250d39e57..4da7f0ac7d8d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -311,6 +311,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_alloc_anno_list(msk, &addr_l);
 	msk->pm.local_addr_used++;
+	msk->pm.subflows++;
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-- 
2.35.3

