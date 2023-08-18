Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2042.outbound.protection.outlook.com [40.107.105.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59000812
	for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 07:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HATgvn69cOi+jvya8IVHYfQ/64weannzyJvqwaMoMdjOKZta13OoQveB8TaONszQbGe/cAHCnWqvDx/8n0JOrQiYhW5iMgo6NzU83ZPqgC1WjJeXqT+Sp/33UYv2inv1RWdxV21CKDxrLaztE/2x4YCoKZ9eqpziY4LnfXlEgE6BqW4FWOZK2gADhBxPQDsEDXgAALg5aCM2G4gtvmm5sQqXxUZKhGljRzcKJ8z49iWiDfEGFOEj/FWCwwWJSOHWJUbgETbS9bfTvunFggN1llxJZVbrFRW6vscT8Gd8RUsuMPmgd0Kt0JRHE82hB5k0JHVfAeBQv22B8x6KDMZAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSAF9pVPQMGFCRRIZ2CWkJOpmYr2QAARJNPwTMUnHq4=;
 b=dKHwEQnPPccuix/g+9I0kPcNlddsd17bjEwKj2teoQVOrXLZ7UTgMqzI4UIlcGFcqa50ywO3leResToLOPB1Jo10au6QjeCH3/7/qNET6nnbuuwSpwNiOggBJRLPPtzzwzvFc6jyMJT0qS8F5IHfQywAojgFHFEpO9JBROnbHeEQsW0QvdEQY/8C7OwcoFlx+ip5G1WJQU6o5iVQWoPH7ydxeHwHRojprZoZpNmCRk0XocnSkqnscY/4wKmyKhPe//F0buPtg1Kg2KtyJreCNeTosvERjX6D2kZWwXItrVL+IswEWDBbwwfD47EFPZ8nUCy0wZOsyhtJ3UnUpN9cRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSAF9pVPQMGFCRRIZ2CWkJOpmYr2QAARJNPwTMUnHq4=;
 b=M4gvAh6aoLN074MTUJhnPpWQwhEGhF29gmThiG1lXBh1YbAYeREGNIc7stJOE4Q/PNptFfJgAnGy56+nnrH2ORcXV1D1y9rBf5uiBhJqcoPyv2ioQ8W6fJStHIOvmf6KKKrXOn9b7+wkbUDuYzrg1fpdq83dXgFD+HNql0xs4Z9E5rIBKajUiYFYPiZX+wDXgzLWuiVQnVWWeay12CSmo90NfkefLQU/o6kZwuQ8JE9/ndd/Blx5N7ygnts1DyddQa5p30wPe2IDTRh572D91Pgs6jG8dFQbWID2E9aGHyoUw9x/XOlUbzI5C3IWdC/x9fHZdfm1JSzWymJNVCbjrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Fri, 18 Aug
 2023 07:13:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 07:13:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v4 3/6] mptcp: userspace pm allow creating id 0 subflow
Date: Fri, 18 Aug 2023 15:12:02 +0800
Message-Id: <aaa271f5bebaebb01b1fd22645c4f7a97f3024a3.1692342519.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692342519.git.geliang.tang@suse.com>
References: <cover.1692342519.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0069.apcprd02.prod.outlook.com
 (2603:1096:4:54::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d9aae0-2cd1-4a3a-f047-08db9fbaaef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Eobl3YlOhNGJSEExq9abt3Nsew21F4L8X9wRNQ/fk9zvTCV3t7JCaYuQIjRx3EURkBNdasl7W1iJu+++xVCSFvi4r5cGDmhSE+7ggbdrWy/wnVP23sDs4sZtGFmBfJxL8XOMXDC1j09eMXVDspPOSUPZeapoZJHwahNUAk022EgG0bkLnc5pKBEGxuXE/G9YehLI8BR7ekMHOynpArphIJRdf6b8z+AmTdo/xL5YIyAyugOvSJvjznIcNu/q6JHEibnY3sD+cp7YvY9Q6wXBKcsvGKvsGU9eeyuMyG0yWVPDnD04/NC/q9e4GM0QF2cMSEQkXT+SC8C0uboU71DTw6CBlZS9G/0bah/jxhVd4heEQ4VTEKMQcvMDjnT8trUihazrpLnVA7S7GgiN2Zg7RRpKX30ZYN6/PCJhToRLyhyH+yD7YZP40eK6KzaYS65GZkwIi0xKe5FKnRw8pYMRyTvC7h/XXdmqHfbHB1CVbp3K5P5Q1C+qWFuUHO8aiZT0WuLJn2itwS1Ss8lP1BlBE6YOTEkGeR5mGrRTCsKlpfbL3VeFSajYOXSB5/9+LO8wLC2to9xB/7uzG5cxjqx7QtjBHkhEjYnPpXI5ZEZ/xqo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39850400004)(346002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(6666004)(6486002)(2616005)(6512007)(36756003)(966005)(44832011)(5660300002)(41300700001)(54906003)(66476007)(66946007)(66556008)(316002)(6916009)(4326008)(8936002)(8676002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LBvPmY7igffAHfUM7czeqiCRXqNNoGLoKEznSe9C50a/wH4YiZHDXbsQgYMo?=
 =?us-ascii?Q?1EJ3FAIGMlRmKylggrDjnWoFTMA/zU7BydnHiECRVRmBuUeGiRIc4zyyn2LT?=
 =?us-ascii?Q?x/fSLJsBoX9w65WojT95nXR2SarfbKd9dJ5eCBtbjFg+QUwHZCm8aVoXtQjX?=
 =?us-ascii?Q?kvHg3d0+9EHYa8aXO7hI1BsioANMGrkLnp1KulGmunEIGi9hd97x1444oUpz?=
 =?us-ascii?Q?LNH2Zd+2bSe18w/43ica2ReuS76+IGJro+2zfxKiEuf4HAnfkrJMO+mqJddQ?=
 =?us-ascii?Q?veviFtphbGdsF2rtDqh/QktD0a8mtvRlXRqtZ38D8glo4+zlK78mXlLIAyw4?=
 =?us-ascii?Q?vDGuJ+qC/vS0TVoPQEcjFBUHN6lH9+0pvuLdM/6za2OSsmYa0EjfHJLDF3rs?=
 =?us-ascii?Q?YWSKF8omsI9kaFgLS9nKkO0zsZ/tCbzQOYb9odXiZAOppMjmTqMp4SD9Xpxl?=
 =?us-ascii?Q?+d6tr7eEsNPiev914AHklFXWd91a7vZsgcUDvf7+OUAs6UJ6qSAaaqqmA7Wn?=
 =?us-ascii?Q?FAT9VhAPaANmMhacupHVm8hd4VetSu7y7ahxzDEcIDCc58J9t0mGVrexXlo2?=
 =?us-ascii?Q?rEIC8D8SokXHfH0nqVcFPPh2kfEezP6dY7kcNv8kJ1ZikqP0xGHMfue6iSJi?=
 =?us-ascii?Q?wg5mAuzgEHmC5bL79IPc4wM8gxu5pZ9IzIHITfHNxRtvU3B7Ouhqs1lKBygf?=
 =?us-ascii?Q?eTQ3paTb7m1SptFvmh7vDbcVB1gFXVrWobVSVAiiMVzzuDKsIrAHt4KOxEJn?=
 =?us-ascii?Q?hzmT2Uzy803ly65NeU5Epd3x+q3hFHrWzDwToDUewG8QR/Wd/nrjSMmVglfJ?=
 =?us-ascii?Q?ZWMD9K7lhXsL1l+nrqC+vRMwobXqBdwiSAGpTYYQLOk2llkUY2SVoP36hiNO?=
 =?us-ascii?Q?naJhO+BzcQos2uQo/xlAvGeLbAmARPh9zPc1XJ4oxIPDCKnOc2aC0qEXpBrV?=
 =?us-ascii?Q?/pKNRs4RrOCVh94F0/CaVH4XAhVF97TBeZsXV85pC709jtpzhOS0PrpvyN6Z?=
 =?us-ascii?Q?OJp4xL8k1rrP/M5AO99fwpgKpj9+tbD0TJVUD3NQA9rhDZlL8EPPoaCETRzA?=
 =?us-ascii?Q?Pekgkb3D5cnQY0a3HTXmTjGwybVY/mioIBYXCSrMkk0gfu4VDk3y0pK/3NAg?=
 =?us-ascii?Q?/bUGaLyHW3tJnDyAqf+HT8AtW1/Fq8ywCFRGiKQPnTyWI4/ghy12WxQ30nD1?=
 =?us-ascii?Q?YJEhAxch1DeREw6A5g0R1FuMfWzyxGqFmvC9blH+OniviWhmptxgPnkvYMk5?=
 =?us-ascii?Q?JBBAVpLCdnbPkvfvxQwll8w1Z8rvinQ700I2F4GPNc+K5UUa3q7IjNuQAfL6?=
 =?us-ascii?Q?sw6kaPmj4tDOPTurCSqwBeq5jJ21ih0aOJQTRr5ztw9mJMjHpiY3sEnL3LXt?=
 =?us-ascii?Q?2Rb5f4Nkc/OUYwVaM5Tgi3XtCePTfJfP+YxIuBSH/iI+3nvEyTjP+bQZUMQ0?=
 =?us-ascii?Q?6zDaVgSkfC1SPU1ofLKQvw1D+Sa2xqKGG0/Ooayf2V3TG65WHJkOlNEngz0e?=
 =?us-ascii?Q?FUvphTcrNRPd5VugVRYgLJPGT155kbNQLkked95Rll4urtm5R3EKbOSOfqgU?=
 =?us-ascii?Q?n/mfkac8zH4KkvSu3obJWPKpE2KzLHC2DzN2hf+y?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d9aae0-2cd1-4a3a-f047-08db9fbaaef8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 07:13:55.2149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjcz4Gl+cwKy8IbMGcACwShIPzqofEJlhfezlaZGA5bAOb3EN1DIwUAkTSmRk4VbGELdcf8BEEVeOf1C1yndzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975

This patch drops id 0 limitation in mptcp_nl_cmd_sf_create() to allow
creating additional subflows with the local addr ID 0.

There is no reason not to allow additional subflows from this local
address: we should be able to create new subflows from the initial
endpoint. This limitation was breaking fullmesh support from userspace.

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/391
Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b5a8aa4c1ebd..d042d32beb4d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -307,12 +307,6 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	if (addr_l.id == 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "missing local addr id");
-		err = -EINVAL;
-		goto create_err;
-	}
-
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
-- 
2.35.3

