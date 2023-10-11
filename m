Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AA71F928
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="2RRZBBwl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyyDnsdPhrna4xYAGwbzWil12ghlMVjSumtFpjQDLydlSBQ1llpOJh3WB+U6bsDBbiuiJ+EpBNynEG4H9DoJx5J+lpBD0tl4n6YX4ujploz5fORgGDkFes4+73Dzmq8omxGlAjGCEaoeKgoWFexKEuomB0XbKgXEpee298IMRQ7d+bfJ6o89s4kya+lynD9jlX7S626/afZlJ+IKCNH4YOYx0lT0xHvVP5CrNUrPkINdx1oFqffKEcm/gn8/kfasVDxm6s1jviMKo2n9u+p2KUaSLOTSioGcaJCgnbsVhg18dB1u6FWsnfF0Ge6p0rbviul1fBw4TnzD2CfrW1s6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITrTqUSiTFPQLH+n/E4UD7SU+WUhgfcHxzNk2VWjDqk=;
 b=L+GRMk0D8iivGlXc9MKhi5QnBrm1DSREOnVlX8hK3yA8TGM6gRhoA9XUxpKt6i5KZ1sMT2dSCJGBmWH61spRDNZPZJU++1qufLkoOvZVTL6k4RUCOgE5Yn+yrUTnMwcyHv2UE1KK0GgvW7OVRNJN5bDxyxix3GjPmv9zMvatGQujs2rJYBC7ci3r7syOHrTYPw18mWS87cnIG2mS2UrUv4Om8YI4L7fHzzvugTgsL1MhOGOoBnKJ9TIT+SGh2LtWTJJ3g4LFIxgIQtBcgnNGvQd72Hhm/ncjDm2fAFhVXPyecRH4cf91N3Y0NIUIy0WEARHeBuagMPifXg8ciJisHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITrTqUSiTFPQLH+n/E4UD7SU+WUhgfcHxzNk2VWjDqk=;
 b=2RRZBBwllaT+UqI9lTkBvPnWcQUNhEmMfOoS2WWsreIh5dDxCyFMe5tC6mjH8oRWL5tFtNOBeeK3sbUDP87qRLT5l0NVQZrdJ57XKd8s50MMjo9Kve2KHADf9xXO8mD3WrEjg+d6vdmIv0qa39HJfWaZ49OjLbVnRDZRKOZHPNPN/9fNAOw/+Wc13njEggqNozvcuJydBPU2iEJR9USKKbeWNFXFjiyH9c3h1FOC1ZHQfYMNjKcOF35Hyx75VlmRfhXscbZ74M787uViocLtODdHWYk77Mf798qlRW2coemGIHzRmNKrbthxiqqNGvbvaGxsFqOOMRXYfipQqHA6yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9139.eurprd04.prod.outlook.com (2603:10a6:102:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 13:34:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 13:34:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v14 6/7] mptcp: userspace pm rename remove_err to out
Date: Wed, 11 Oct 2023 21:35:01 +0800
Message-Id: <34ddd27d7daa9fd19e5d250f529cb768f2de0deb.1697031190.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697031190.git.geliang.tang@suse.com>
References: <cover.1697031190.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 1961be97-8f8b-4e15-84cf-08dbca5ed779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xXYfz9w7Xkpto0EJPJITyucJrAvOcAlOAFD+lZe+rK9cLvz7QoAI7TL7kcBnwJOudB7UMbRGE7jLRx7aSGYr1bSEoSdXVuwkzLLgxWqbvmjvkXif2iFjTBLXyBgQ7vMNe4BhBLldehsEtaMSHXOa6JAm7AYQB/IFmWRpNTrhFlOIDAMvfQ7AC88+/trWRbYLORk66B2YW+qqFRL3XW1fWIx0y6BCgTZAOVJoQSv3/RFkPSjhN2XuX610AjZkwzqmO252D9r1He5ebkGI67IFJxP1yU0tu+H/fYtryRt4DWPaSSSVdGaeFsQmBV6PAFQKt+fDxVMtDRM4XWqVaicmFK190fCy1ZWWspuOVj5iKavY52DEJUjNuEY0amTAJdL7Xd5uFrJjMRXWr94z6EoR0i6LOM1zVMtPI/T5HBLhQF7vWNWxwT2v0I6OkEeJvpv02H8MfgfgRluC2bxPvoH/eUK/+1oI6qKmFQViQ1UlAjLPG8Lz74dU4J7JTApFoBTIMK24JUomPVVMtr/DaahlVIr2mt2KG90+NDOA/Xq5QSK+XzNfL4uh3npgvTpnwBdh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2616005)(478600001)(26005)(6486002)(38100700002)(6512007)(66476007)(316002)(66556008)(6916009)(66946007)(54906003)(6506007)(5660300002)(44832011)(83380400001)(4326008)(8936002)(41300700001)(8676002)(36756003)(6666004)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BXa0tdvts4AmeX4pNlKcHAAvbvvYQ6TB3JGAUuhmtcTSO0/faSXvvGOQtkeF?=
 =?us-ascii?Q?J+iJZK85Bz5SZYcyO2VtkJAklYFRHiPqA6k25gjsjGnA7c84V973+Fx2FLt8?=
 =?us-ascii?Q?WtVeXu+5HBwmvnwLFM/lQxsG46N6iyzub2594XEZa7sg9YRZx1rYqxxzVMJQ?=
 =?us-ascii?Q?TqMQqMPkF9UDHblyRrnYQCXDnmt29urePcVWPGWC7rZPkhH4uB79GR+tDote?=
 =?us-ascii?Q?xuJzRhnBfHTdgVRbr+J/4m//NFPnBZ9q/hAc4TYbl8MebzPey1wljjwdimTP?=
 =?us-ascii?Q?t7F/qptqd9rtAYIy+iUcE7nXhMKeWpedmEXqdXPqFDC23wLykOEOYI+J1tmo?=
 =?us-ascii?Q?WICifHdr5EW0zU9rB6m+fQTMLZUMWXguF2LPX6cuT/1Z6MZk49IrbyID7jeb?=
 =?us-ascii?Q?7To9a1RjQUgbv6UTzLrRwphyACxlyqUIIoelW3YZkSzojV6O0qOmDCOxMdqi?=
 =?us-ascii?Q?m8Cdnux4/tCRF6AJsjeVH2jGr1EvDdglCe/l/nEMpk2ljG9BCLDOkpealKVt?=
 =?us-ascii?Q?3ZyYJPekIcBzzEe9RmfCNb6lDCnqS324sGAFkF91ZOu2lveEIlXQSIH+/Y3K?=
 =?us-ascii?Q?nYoOKusHUaz4utzesYUbybJ1v87dwiGQmGhqhdH25UmMH7GKDI9YhhioKmPY?=
 =?us-ascii?Q?CY81HuyO9UmaUgAGt0l+BAVHZ+8LWkZmZb17UqqJH8i/DYoshmUr6KwSKvdO?=
 =?us-ascii?Q?7aWl+DbMGADAIbkRBszTrIKhql9KR0JEMp6sJELaQTWbgxRHylASpxiOnkhF?=
 =?us-ascii?Q?c2RwTL6ADbo+LLWGr3EJkId7U2goDSnnf7Pl5HWGmVv7xZ2283Lv1PgzifUp?=
 =?us-ascii?Q?YUmmBm+/RwmNnEfQ4qLAK8rE2c7agw6zJSq46b5ue9kdV9YhHPDK1rR1CLSE?=
 =?us-ascii?Q?7vpwCVxqC+qdLuOP5NQdC93xLWgQjBFVvN7qlLTzaClTL+Sa8DqJagdn5xpG?=
 =?us-ascii?Q?unZP+0XXWqWZsBT19rJIN9v/9O3ReSgA/cCxWslV3y6UGgsKjlhdtIARlyFu?=
 =?us-ascii?Q?ovf13yYqE/FnujxyI9QJ/UIc4pmIjKbRihVU3TV1t3IIWfQQBOSJTgWSmMbN?=
 =?us-ascii?Q?Z2A7b4vFXehIh+jx7U5BIFKaUxltkyCOQUZ0G03inDIuKAEQsY4fCAFjQpgW?=
 =?us-ascii?Q?YCasEt8Ml944FE2NC+fleLCx/7umN6KpYon9cQhZahture4xfq5PKiAIfBdO?=
 =?us-ascii?Q?1KAOQHDFoloP9WJuUnHfLcCGSOfiMhgUmHxXTLFJqj8tiWbb+2yjMb1GiZkw?=
 =?us-ascii?Q?NLoePBQ/gokvk7o70EMJK0TZ6nTG+7iU4IH2ITzGdHeNj5vWVYXMhJ3X+CHM?=
 =?us-ascii?Q?FeDZPbc43ZDda9btt6R+XsMl/4QkdSXPh044DGO3iI2jf6wnQj9aaV7khHIg?=
 =?us-ascii?Q?nvIbxjouDzO0pQDTHuJZmEdOPfUyQkglhZgW3YtYGtlaeyjqjET1msNjN0jh?=
 =?us-ascii?Q?Hy/BtxEdtxlnVkpKlw96BOiqAEZ7feeX9DgtQV/syaUhU0aoRZD1Y8bL4L/l?=
 =?us-ascii?Q?s8fkJ2HfNE0+eCLIfdeKFuXtaeDoqSUNNKt5bHcdkQst5D+Q5ovUuqv0dNhO?=
 =?us-ascii?Q?OUd8wkr9TmBJTfX9bWij1pM0dhzchEuj/XxquYV5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1961be97-8f8b-4e15-84cf-08dbca5ed779
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 13:34:49.7217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vx+J/BiGyLWCZTk4GYF1Cg7wRA6tfGXmzIe0SDlX790fLyMXJDKtav9XfuFjcnQqCs7rf7l5YyInmJB835GDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9139

The value of 'err' will be not only '-EINVAL', but alse '0' most of the
time. So it's better to rename the lable 'remove_err' to 'out'.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ea50e694125d..cdff3e631d2d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -276,12 +276,12 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		goto remove_err;
+		goto out;
 	}
 
 	if (id_val == 0) {
 		err = mptcp_userspace_remove_id_zero_address(msk, info);
-		goto remove_err;
+		goto out;
 	}
 
 	lock_sock(sk);
@@ -296,7 +296,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock(sk);
-		goto remove_err;
+		goto out;
 	}
 
 	list_move(&match->list, &free_list);
@@ -310,7 +310,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	err = 0;
- remove_err:
+out:
 	sock_put(sk);
 	return err;
 }
-- 
2.35.3

