Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90DF2C9C
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 10:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644403383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcCDJzHNV6kcFpm6QUQWBx6GY1KwXHjb2MCAhKpBMzI=;
	b=ODyrCd1W7ixzKmpkb6YhU2F8aFuCsjSPlYZbvqc1et7N+y2SUrTzfO7DmJdv/lhTDeOIbM
	Bnry+X12PmucBdkFkl9QV9aAOd6sZMU7Bu8vXwhnfYWUfQ/2UIY47r6dSoqtfJwW6z1aQR
	YNLDfbT7ufr3woLx6lVqLAV8Ua1j3vs=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-62PrpM5UOwCFxzQHaWYfwA-1; Wed, 09 Feb 2022 11:43:02 +0100
X-MC-Unique: 62PrpM5UOwCFxzQHaWYfwA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlV3xWh+e7StUA5ecNY1D9+xzO60RCRSgtLgBKf11GQ/MpKRGes4+RDev/fuYhCRnTq/9zB9sGqtD0KttmhuEN5+/tQHvzPgWFtjQzNX8fH1DIZq4C/6LBHgEpYuwZjFVAmF2ZyNMRLk1tOqAjolwQb4DdM3o5TgcMrMEy+HXNzqgE3j4TGyQj3mj8Z6i1PVfuYjraBWiZ6weKuaDyJDGH2eOJuxPPdz0V4DHHxXrXepetvHwrTQBMnyfXA4MaD2T+90e9zNx1fzJKFDqtEA+CIhAmv+n1Gooe3daJsdX33/CmecizTQmSvwcss2AC3KdySdw07vY0gWUN7vZl5unQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a26/8dAG+o98EF8E3cZi1/wwV7DYzSfMYnFb5dQLUqc=;
 b=RZybAStqVhzBLD9OJU1Yf0M2Zu28tL2wGMdJWlxHzwL0Mp9gUbpL/BAHDH0X6YHPzPzQ4u4KvoxCRmphibFqNtTOjrdIF8TzSbQerUoNRJ0BGJTLA3exLpinfmOHNnfAoZpddrMcjnlVD44FV21fT+FZnXSjFWI17c3+5OGZ8T2GChw439DivbNxEi20YUc6G2BFN7Nt1s6r/6OyfRlbBdedeK1iBM8vg/QvM8wokQV7FwLbDvsuan/u/fy83Oy67bygB0fYXvLBBOH6rBATaIIpwfJomOZrIwZDnmY+kw5+BafRQQBGqc1ciecgs5Ymqc4kakpLRg23J5qOx2sr+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 10:43:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 10:43:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 1/5] Squash to "mptcp: infinite mapping receiving"
Date: Wed,  9 Feb 2022 18:43:09 +0800
Message-ID: <621a0237b6c15001e3590b27358dbb854c2ab6e8.1644402973.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644402973.git.geliang.tang@suse.com>
References: <cover.1644402973.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0181.apcprd02.prod.outlook.com
 (2603:1096:201:21::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59416844-8458-4f06-7072-08d9ebb8f16f
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB58071A40532BF653C5D6D6CDF82E9@VI1PR04MB5807.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zjpy7IHamqsIQzuSRw0C1bFCKHRwpEfHo4Ge6wF2iFqCEJyJd0GUe5C8/Sg62PKas1+yAoJ3evrqhQWePWBmSltmt7kq+BgJtOPEg7QeVn1vOvQQT3i5VESWlxqv0dy7tX0tqAUj5D/vzEvCgJLC+QWmV9i2YUhk9yVSs/eRhkmqK5e5K21s6pYZkuTPkPPmxHhWnfFe/YhcWwQF31FT9BNv7bTBBpp75nTM6TUu2KEGdI4Xr1ooQ7KxEB9dDMFugXsCkEoYWMamgjZ1jyq30v10rMTsseq5Dpba2jOEBw1/W1CaTzWsmPaGBcDcoUBq1xaV2PXuOLV5GGrl+cKGgKEiuvix04KBA/16lAH+7rQHEhG0Yf84x70zPl/Zb92b2LDpDBIILnzYN7YgStUn+UGPF2/DbjgsLxZAmk2ecBWYizptN+q3EXPy4Jci+8P07mWPraGwfTdqAnS3arLJeIUvvzce/0+e0r7YhW7IuHMPPRO5UBn8Vmz+wqFljq1Uus/0ouqmueoOHNaapdGYtbq3UsiQvQcnRqzlEqoATDh/IWeg8KWENOIpTfquRAttF2xtlW3dqZvnuL1A/3HY//8w/RtPVpr1Cu3PkX5ng2opbm0TY8hvr9qACcy5tw2Ki0987wDNPIIBVmMuigYNdg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(4326008)(66476007)(6506007)(66946007)(8936002)(66556008)(86362001)(55236004)(508600001)(6486002)(26005)(186003)(107886003)(6916009)(6512007)(316002)(2616005)(38100700002)(2906002)(36756003)(4744005)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hN1A55apMUPeAoo94subwPUyM+8jmQvsl+m+AP7i/v5/y8yDi6qPQDu2xbL8?=
 =?us-ascii?Q?trVr0vixLfVSez6VAFWS3XMBP4KFoBhKq7I1tF53YRHlbRoDqIdEBGI0/7im?=
 =?us-ascii?Q?HUdqOntNKTeq2OXCh/XxLago0k8HMYAcryERvXIY8M31Q1fzv5GqvEcGflsx?=
 =?us-ascii?Q?dKQfbmf0lKgFqLOO3RWfJjju0+exauzSClINsiJehDXTbzKrazkJG06TyaKv?=
 =?us-ascii?Q?yVdUN47G4HCP4WB7sL5POPRxlr9RnHZrq1msc9+fQobsQVwhyRWWWt/GKCmr?=
 =?us-ascii?Q?Pzb8KJc+ueOpL3igUrxbTsa00NwtTQJBxZJGK4i6/8kp8Pz9pHp4WAK3y7Ix?=
 =?us-ascii?Q?JrBmqwXlP5UBt3rCH3suYKUDBjGHcK9lnX+DY+zzshxrCu6NIyd8Ho7dPN/U?=
 =?us-ascii?Q?ZsZJbg/Me3UvbN9nOjttGGiiUDlA3W637auOPTe40QoklkbzJNF9rxB3yyT1?=
 =?us-ascii?Q?66p4nRKTaD9MSikNZc+NhmSqfa/yZzzPKxSreiZmz10Fny28QGLbKl2EIkW6?=
 =?us-ascii?Q?DJR8umzkqeGlVa8Mdol/+yXVUTPyNWD6llzfNlddIrtjO/pFSIRZwiCtuqMr?=
 =?us-ascii?Q?LDTKPTRvuM3O1uFoJnIqS9jghUomBGG+GJYzFNhze/w1rBgLDhb/xghPnG1O?=
 =?us-ascii?Q?XciCABhTlFZHSNhX0wsCK75zAVcKKuuKNENlZijJMKmB0818Qawze4KmsVfd?=
 =?us-ascii?Q?r+P2+PlraGeQq3xaS2SHu8rfAtiNabQszxvz0iYLlwqRjBFRLKix6aQru54b?=
 =?us-ascii?Q?upqvN94A5VbZkYIFzUR50Y/V42frEzDlxZNOm/+ygxzBLMIBGdBm1yFGItsj?=
 =?us-ascii?Q?zfhs2Irxo6Tr0U3uWseWlMEByW6FNO2Dz1c4APPKWf52eCORPw8TMDHEELXC?=
 =?us-ascii?Q?3k7idwoZJ22Xr4NdRGNN+qO8UY6ZKQ4C1TopiD8E5ZOdfxkJPKZaLTBAg/kU?=
 =?us-ascii?Q?P8pszySJQqoXk/HTA8rbE9VF0c7AbQLelsGzAChTDJUj4dj5PZJehRoNvLOh?=
 =?us-ascii?Q?BpEHlmcG47yx1tjnpXxaNot3QneNeMwP2O3sVhw0sgTRCGlWCVQPfX2iHuO5?=
 =?us-ascii?Q?rpey404ktiW3yC0EPri46+vVsEyteQOf5unx0l8/lAGCIBOHfSJvS/uk43uT?=
 =?us-ascii?Q?4z3arKDzry45z1WJG8cSLigPxlLDwlqVXcNBZC402nxh+920BeCx1WA6EXjl?=
 =?us-ascii?Q?VPJIzD8eY6gM0b3GqXKgia+QfPxJeHT2zh2qwSHFxluCOTjqhj/V/TcdOhXf?=
 =?us-ascii?Q?r0SDGWVLhNPMvivEYWEprHb6InBdm72cxCXNNAj9FgMAUQ4sFZDO01EeqNK8?=
 =?us-ascii?Q?cJsNpJJjjHFn7yVYpTMl6dFJ18NH/2Jh7PndWHbOKaY1CCPVvpxyTz4igtgj?=
 =?us-ascii?Q?Rv7/mN01ePAjuwTuh+auFGrUqAEjW2SXqgTWkj1a29rXKRixsX3x4fsuldMM?=
 =?us-ascii?Q?ttl1pwtje9v5tXeJr4xuXECLSQdk+75Bdg66Hhcag+GNzBVpurAzlxWClz2a?=
 =?us-ascii?Q?BlwNBOpaNdBL4HwRDjmrTgUGXXJeVn0i/7G0OOQ74xOeLdycbZj0fvLsT0Dk?=
 =?us-ascii?Q?0FtwtrRxL95h434SaUqfDp4gEurri6wPsiUQI0xh7ZIJwJOgpPz9vJDuTbyg?=
 =?us-ascii?Q?gPIrE9300A3rbgtg7Oe+TO4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59416844-8458-4f06-7072-08d9ebb8f16f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 10:43:00.7695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WCHc+SaI+gLPq+RmSVlIZ8+zPx5rhyrD3tRxqPh1cnW9ru1H9FwELsvce5czRww/YMCQwG4jSYjCmMSyzeWew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5807

Print out the infinite map received info.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/subflow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 485f00dcaf84..ae4d855f3c2f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -962,6 +962,7 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
=20
 	data_len =3D mpext->data_len;
 	if (data_len =3D=3D 0) {
+		pr_debug("infinite mapping received");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 		subflow->map_data_len =3D 0;
 		return MAPPING_INVALID;
--=20
2.34.1

