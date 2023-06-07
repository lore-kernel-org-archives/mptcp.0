Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F172749B
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 08:39:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNCghkyYckCs62EQAaCjUz7p4/pmopy7XZk3WRc0WeTmwkASTufS40wM+N/p2wjHIXLs8loaKFuhsgNdjIUs+LeuXlKQfaofbf04V2hUiOUt/0USynGk2e6KagLTEWK8FN3VFMrAOu6WqIFy2rCq81RnXf4SHnJpiPtfhlG2fpBTVt5Jv6+RQx8YHLVqVJmRMUku45452VXBjfAN4NY5BG6Fh4zL9V/iTeVVTuSAUWYMsgcWw+WI6atNVStUt2PkKnaOYOEw+YUJQIUL4C2VxkQXp1pPzkE0OfnLtQL+BvsVo8ZYsYWDM61QDI8fohEwKntyeEc1bracsBy08A4b8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jFD3qSswn83oCaWVCSLbYQNfMIu4XTz1EKt3ubzvIk=;
 b=FM0E5pfMb367M2iRsIFMjN9WVxoNPynv0TpEXnsnqCrzinI47rIzis6FlSz/2i26dl5dtl62VODswz/UCzd3S/W1aPpDzIwrBeOTl6QZOA5oOEXL5H4gLOA7c2w38r5IzNuFF0x3UNOqGSgI7A9hN9e37KoCOay2HvEr23r4FC8CIVgtF9p6lkt8M6P1W3EWz6cH6b7lFA+YqDqYWoF/DypUEuJvUg/OdYzwF/rgwca0LmPDaz6LIdhUJ/v+Wn+eVTriSn6wyf1RrFsqMYMWFu4yvWKVDfH5WEu8ZSKhPABpelkvbPpWEz0hAF2/DrIRQkzJhthQUAhq+aM8GW67zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jFD3qSswn83oCaWVCSLbYQNfMIu4XTz1EKt3ubzvIk=;
 b=vLxCVuc0fATiKFBu24Np/1EjTmF/5CkEg+BXsGZ7+m2HG5b2hRDwuzgBElj248EnnJvJvhnYcVoMRk6NyOJtT/ldeBGIjs+/ucden05Xiom7O0u2MvgyNLjP3Ep5m4Sop7O4mzF17h1vLIgbXMy06alfHtxr0waz7gG3SZe3xMwTO1RvTbbprx4XO/H8jAqdK448MdUyPBL5+APnz1ohzZ8qOYk/WQUl+/s2vi8BD3fzlqNdKsfsO7vfTGsCAzsQdoWvbiB7rRx8Fre/rGRN4xdrtJYOjzBu+iNNPN6MCmBzA/0pDqJ81ZJD+FBAP+t7RYKmW8z8NzMouMI7vfdNLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9404.eurprd04.prod.outlook.com (2603:10a6:10:368::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 08:39:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:39:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 02/19] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Wed,  7 Jun 2023 16:38:17 +0800
Message-Id: <f857ebb0a238f3d64104ee793553abe7f35e4304.1686127032.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be7c482-d308-4940-2bfa-08db6732b077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eM/pKHFsFoUT7kgQY5BgOxrK1MlYBsC/e+baiK0mP6eOwiBGUWs0/jdNO56nZJI7j4SoBlh1dn25UDicf7e7iT5ttFD0hK5u7+MzfPm1SuVaUCW/p7oQpx14W7lZpzgmTt9zTvXuHni1+NZsTZXVOkKicMip8HQHuIagaFKwLyiPVv9RHFZYuxpw/rR4QmMX73Dv+DT0FbmoUAtPVMJLGz/P1DCaIPGMoz2/WpdLJ8zscuZBU9JI+RK+mB10trf+rNsfekH42mw0pjW2VvqAnkdKpsP9aLY2Uw0+fkZK52PQq8jAju0+gUcODLp5qcrGCONmN/WWjpyxxCk1SM//0tYECQ6paZ/m/xxsu/oQqgtrSVjZsmLABldkbKYnnV8+qiBsPoJdHu+ou/05JIgAk8hthyOilfV5Bn1i7Qr8QDaFvNI92fN3JHe18blaDRQXYhubY9vJaCwK4oALgT8Euvpkk/cpPqgdf6zpIBMdf2GOjcTWSQdi7bH3ow4san9hn21FeGR1fGNfv1MyK6kpX9IK9d9/AkX+3bHuViQg6/3HOk+RffLL1vf33+YvrWyF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(107886003)(6506007)(26005)(186003)(6512007)(2616005)(83380400001)(6666004)(4744005)(36756003)(2906002)(6486002)(8936002)(8676002)(44832011)(478600001)(6916009)(5660300002)(86362001)(41300700001)(66946007)(38100700002)(316002)(66556008)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7wClQukwnSgLMQhluebSDHhumS/XfGKjkLh7HtxyFZalG9/U5uOHMowLJwsd?=
 =?us-ascii?Q?ThL3IYMopDuFxuuFfXS8dRuU9EE7Lr0Mp2pJjw2LPFP5qmV3C22jvzNHYHCq?=
 =?us-ascii?Q?xtFbr4sKUv0YkrJfHMqELeAFYwG9EKQaH5UUJpesDB7hUgSRzr7B5FPszSk/?=
 =?us-ascii?Q?7UAnQSGvaGA8DD32XOkylqi8+eefHlT125PH39NmkUZzYJBz6085hpyYHbmV?=
 =?us-ascii?Q?0TKf7TUghs7d4S/JI+8Y6gQNPovBb6C5aI6NkOCI3edlSVJGWHHvFOynsl3d?=
 =?us-ascii?Q?4O1k/v0BEjxYfrsUWUBiVEgZxYXsD3oi0B56WYaemsOkuCVtZ/QgqnW2H4VL?=
 =?us-ascii?Q?96S7sU2R5GDORrSb6dHJogxYya/jgCpX9TIQnHPQJE8DTKapCrgAnOmXpkyc?=
 =?us-ascii?Q?pa0HdpJ8CnqDifnD2ybiyvTnBwcJCg4lgwfN8kgrhGx8Etx6hV6DF51afHqo?=
 =?us-ascii?Q?JavHftHW6uIbvov9J8Sm/JtCzkX9Jvm7LSQKcixOUy+qe909+bh2LirTWhR6?=
 =?us-ascii?Q?czhD1tGscX6MFux2MMwNMZp+OQVlhgAoRq5DNaxyAKv1/EOHI8ieN3O20Ym9?=
 =?us-ascii?Q?gyXxw1f7Upu4xSootu88isE1cTZgM9Hrv/MpYm/a/MCAoBielwoNEG1iYhAt?=
 =?us-ascii?Q?zefnRlnEyrs4Indvh4nG++zOxr7dXj7GzFPaEqT1lmWg9aiFyEikl9mWYXXy?=
 =?us-ascii?Q?7MfZQXoJc663AqFcUW1e+LEjJNCICTO+CBnWmradtNEcia9S6yoy6qgK9d4N?=
 =?us-ascii?Q?c1tNcO5++ncmH32BdqGisu2K9fJ18XlqFJunUAZ+sFm5O/7G9HoGv4ZykLKI?=
 =?us-ascii?Q?dmaxfjsENxgK6AAuq9aGeLoV1ToHEEMU65t/8CWwbdExgs9xRaejuKOgoBfk?=
 =?us-ascii?Q?sUTe52txPt9XI8JhsuV8RLiSEF2RRqfTVNCXu5+CFDu7/b3rBMSZpbJ06KGy?=
 =?us-ascii?Q?fOMKvEe8wIxlwonhSAqTWmKRZkS4A9Hao1jd/WyvI6gcD+rpSwCzsS8m0iMK?=
 =?us-ascii?Q?vO2YE552kjupmsW3RzgH8l5dXB7mvYwndd4k95tyf8L6ZVfq0X7gmbXz0Kwk?=
 =?us-ascii?Q?7FBk6vOAaB1XrRY3aNt4bFDzZ40ZGCA5Si0Fsd2TRbcLzaxwN2ow/jSGivLS?=
 =?us-ascii?Q?IiB44mkgJhr+1emXe/SH/cgYccM972bpR9Vj3/e25lMsw2OK2SL/n8DjXQ6B?=
 =?us-ascii?Q?NvC8H/45NX4sO7BfPmm4DJFWEi+z2XbFQAkyQZAVREIr0gFO1gyN2sZnR9vq?=
 =?us-ascii?Q?vBgrZAjktQFsQcC9GUDo6dzUE5sICkAmE2iaT7CquNIfXMT01eolBlqPTJg5?=
 =?us-ascii?Q?j38EOzNMTrcD58pT3Sdu10SCIiQ7Q4Gx3MxJT/JommjhTJjWKv+IyOGNRZdW?=
 =?us-ascii?Q?xU+m1ArDkHk9kljMmEaUkNaxTbgdjMJLjCUB3Y4uqg+v12KrR6CqKLzuS17A?=
 =?us-ascii?Q?uw9MO0mgUYRNr4WokTf4lGbcPySOPYJodT1Jqy0byPxiUkWUSkGFvokddDQz?=
 =?us-ascii?Q?xu1YpTUUCg36nTZZXCOSN9Wqhcsl3PIAD/Bj2ow6ZLvhnm9tC9MFcuJuvEkt?=
 =?us-ascii?Q?5weiEE3zr4nS09QLrbasPXEgYlkyLwwGsb6c4VI2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be7c482-d308-4940-2bfa-08db6732b077
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:39:21.1106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkkcKPKA4aKEDNg1diWbJK2CLcj2+5loTacFrbV9QFfT+fIK/UC2wYTW2g9H5f0F2rA1ppxPnqCIATsN5b1aWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9404

Use two tabs before reinject.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 828b10ddabee..4bba29c99172 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -100,7 +100,7 @@ struct mptcp_out_options {
 #define MPTCP_SUBFLOWS_MAX	8
 
 struct mptcp_sched_data {
-	bool	reinject;
+	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
-- 
2.35.3

