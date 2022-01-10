Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C33F2CA2
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 03:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641785422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=021S5zVs9QtfjMXcLvOravNDC6Jh/UfOkNzsERCl/hQ=;
	b=cNQUCQw74Gn+AVHQS9Vlv95rHBiD6CyJnMWyKdmyk30vkUYFKWGpnMqnVihC+RO0mTJgUx
	Isg1yx4azy6SHXDZ+r8wEqTxCTNqAH2p5DQXa3MmwNfOAvywxBWMClCmw3B1JutPCHzXpR
	ydsJCqUyH8nEP4WzpyF1f821GQv7Azc=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-HJWMwfTCM_e5-JU7hSDOAw-1; Mon, 10 Jan 2022 04:30:21 +0100
X-MC-Unique: HJWMwfTCM_e5-JU7hSDOAw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W77WVU9fFLi6x8+gd3yhcJfxIBMVc/aUTKq1HU8swLdvl8F1ve0Cifv3Y5aiQKW8lkIjj9mkVDYr2+EW1wyCffXFG7M7bfvNlJ416FeQCKZ5h1pSskc0lrU7idFCVh1pSb/NAXYvR1miC+7SnMeWD0xN/roy1hj8MCWE4QrBB/qDVHIaovlKHO5MDn+xGhlTATGQRO9KEkOgTP05zG1MW7Xu3jUSg0cGAilU5WvVajpjjwgsz7/ERmFXAnZOjbRN1fRG9L8+/AyG+yawHAoPHBYWNibTI8NT0lrxlwlHXQtVxl5wiAN0Y/XkmZv+80CO8XtgJwa+ksD7L5auZfThJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpXD8aYEaam0GGsM0LY4Yvbv+lLByoXxdIwAZ4j6LYM=;
 b=Rf5qnWqXu+mOeLkACtzivejfqWwdpHZvjgXRoylO99xM4Mf6XzVyG5wvJOjEul0GCExN6WXSEDvkFSswDy6IdxSmGBZDPOzvbTrpncLHy0rtIzreTCr77tPEzutmbK6MSOhUyei2klUo/Ybfl3mXUzZ/I3lwps7d1GxMaWQFjgm7JMCp5+6v9LpRlFpczF92E6D65FQXF7EBkPtUgmwuvsj5OqYNFqTZd1/CU3tqqP5qeRtaVkqX3tLwYkb4pMdJRif432ImAKikqR4TOOi7sxUpGTXj6bQSBhDr6/4jn2PtMlJax61zG3oRXXaabKp/x9y/FJSwhCnMJA3lTnsE3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2569.eurprd04.prod.outlook.com (2603:10a6:3:7c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 03:30:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 03:30:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/7] mptcp: fix removing ids bitmap
Date: Mon, 10 Jan 2022 11:29:59 +0800
Message-ID: <c0f7d6c068b3047308263d83a2470003858cfb8e.1641785106.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641785106.git.geliang.tang@suse.com>
References: <cover.1641785106.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b12b68ae-ae05-4d4d-934c-08d9d3e9878f
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2569:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB25696AD2F9AA68E46C7507AAF8509@HE1PR0401MB2569.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4BEkP8xBmg3iW3gCr5bWzhLAHU8CUgwZF2ljrUmOpHFWE16K9HMnkgqUhM+XXWTBlmTG3lv9LaZngiXZxntL60ql8ERb4c8Zk5WGlEYW1idMzSHVjFQo8ZDsaGf4fQfhiRVxihxBRl1sKfDMjCk4ej7ubOQulqlYK6bgHswfKSVcupWZwT9nrKhWe6M5MbEmb0q36GDZQPcr4tF8Rrl8lNgiAYjtj3YuYj/9udvk0JoPMVJha3/BF7LZDkkCRKHgpoX2kwDX8xYYwZ/8FVq9MQuTHrjv+A6Y50N9gW4/ldm+t2eYcm6s1qOEQhJPHlakOlYaoYCZTNDPegoLhIC/CevCUgeKyTGC10s2rusgvrgfg4mTS7VoPBRe286913+UTJV0R/nn6XVEeQt8hh4VJ4sG8/kUg0NWbQQ3dZMvKSZnd4iAaAugYHpENemSiAZaG50JY+ziaaExLXnRZifPXSR6laqGvjZHFK3fSQaFfqhSg+sEKXGa6HD/vACHpZnYiLQ/DnAUspVQgCnTqDgDxd3RWc5ktJlWCPoDsR/meejQCjiICHufqo8eDg1ZhhmAHTPR6isWYoYJ64W+Nf6JAxBiVV0mnFH0ZJcxrXDjAG83nJ2a8ZBuhgrJ7cG707Oyf9VKQxrRNnO96GYeJ09/5w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6506007)(66476007)(83380400001)(66556008)(6486002)(66946007)(8676002)(107886003)(44832011)(38100700002)(6512007)(2616005)(2906002)(508600001)(8936002)(316002)(26005)(4744005)(55236004)(86362001)(186003)(6666004)(36756003)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mj4X0bCWIwcyGeRHv3lR3iVsbp49M4QO1LIMbfh6SJ56u1zo9/Pd/mc3qWAD?=
 =?us-ascii?Q?Vl/snROvwbANGg2ViamVIcv8FOvldfA8ZnkfCN1yC/8Gg8TBaXQuP0bgTb2h?=
 =?us-ascii?Q?MmTUJahgZPvC74GUa0ikQKMulmsGi0vv/yOH99+Pi6XelJ1lS8YUc57/Oxvu?=
 =?us-ascii?Q?RENMHTsNlPWasOeyZeMMX1Jqa0H2uhMzXIVVkQXEllB1JB9vY03D6+c+gMfc?=
 =?us-ascii?Q?Af3lc4X/QhztzHlALDEyOAOdv9qc79ApKH9PaDdIyVFJcCHKb3HfZnw9UANQ?=
 =?us-ascii?Q?8HrE/yYLj/eRNbsqif7eQcUF2MgnWDlzSjzxLoD/rmY3/QKxs5XWa0Rzaeq3?=
 =?us-ascii?Q?P52g/4FGp0AzZiyUjcCcwesTsl/b6Un+Gcr+76HZ5TttsZ2o5McyX7KhF5Gv?=
 =?us-ascii?Q?UA7oXcRptIv93oTZCO2Y7jpuOrdhfQBViYBJC9DX+EJJx6nX0fGygWjkr0ft?=
 =?us-ascii?Q?nTD77LbOx7Ol6GHr4sQnyByInhIPCL5xKN7tIl2cNATLq54v2BUcsEokxrTj?=
 =?us-ascii?Q?Vup0P+0TQFtwfObPwVpHSBROZd8qJ810IBXuHG5H734DAN+CS2as68d7MDME?=
 =?us-ascii?Q?DP2372mQ4pTAfWPswOgWoMf+5IDrIRF1DxNiUsyoOmFClyrNfJztWdeM3bO8?=
 =?us-ascii?Q?oJI/WRjtkB100kI7ythCBgPIluSlyC1WNvrBSm9ry6BT8Aurrgjg6Ss5DY4T?=
 =?us-ascii?Q?kn3RalAOA/SPCFRZOc2UXxLzAY8NNn/4oqVd3afNTRMRMVIpWD4NSb35a6UT?=
 =?us-ascii?Q?EyyZXCmhHICi0ALiL3RulGz6vmvAtbVIjOBSJyt9iCzqRLdNcwxPLKUCkd5o?=
 =?us-ascii?Q?f8dbXaOYFYS1BGhuYexW+Voy0hF3s0jCOWckMkpq4AUCRFiSfJs7Ln8N+UcT?=
 =?us-ascii?Q?6EgUFbeHWtO5m9phRMtkb5h+3YbW9F+fRGjgnB8rrgKOvhoW16Q8HXQmr6yp?=
 =?us-ascii?Q?YKWr97bGObbnnmGvm9VRHnI9ZFA0sbyV2N2brvhvnrcchhc6iESk1vcoOiuD?=
 =?us-ascii?Q?evCtuwGotPC9BQqnXCrMzFkZCmcg9f4+QZ27rArtMJLmuw5U/EkXKkZtecgo?=
 =?us-ascii?Q?YK2Q5eQTh8ZkOTLcVCQxLhYFNG/DxZmpdG3xL4LAwrRCH2ip3g7Ohs0h6VlZ?=
 =?us-ascii?Q?vGnW25Fuj30FvQ36PY5kx6zfYQIK8yI9NNmEj/Yt/tzOd3Sn1pYZ/C5RpxaM?=
 =?us-ascii?Q?XhHnxiWchgEJ8NT73znA6hbJWbGOheKmIIGIsG13Km4cCQTmcNh7SCLL+1bR?=
 =?us-ascii?Q?jCFVC6Yeqiy+UP3MzEPVhNZIanZhCjN5dW/bP3BeB6DSsi6504nyhBfxDR3n?=
 =?us-ascii?Q?alJboUpqd1C/34kyiSy8IHAEZo8ikv7Kl4AnBIv/p/KFFKGGU6sFPl9yK7WZ?=
 =?us-ascii?Q?NxPbLoK5HJYe3aKIZd3SQ1Ht2j1R4vsv1IdHLL+ZU7gM3k39rrTo6F/8WkwV?=
 =?us-ascii?Q?MoZCCpLMPl4oW0ADcpcxWu6i2j+Q7S7QvbMlBNhzVhGZEW6IZEJZpJcUVCF1?=
 =?us-ascii?Q?l7RnP+zQBvtnhXGroSe36aUpXY1goIbyqhSk7ybYEszPF61Bn6hbcUgoFeJB?=
 =?us-ascii?Q?anH3D68lBjWnD9gUQbW2Vy+JkuSngZ/fmdMtQt3/Djz4a6BVKYh/XFFBdpuM?=
 =?us-ascii?Q?mrPAqNRJ20vYYJmUwPboUNg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12b68ae-ae05-4d4d-934c-08d9d3e9878f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 03:30:20.5903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVzV5aMxyXidAH6QFhSWVnST3r3Iv3rwVx1CCqp/y1/8h/iMeAj3RZnY9oTh9DUcBRW0A4aczXfLT+vithIPTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2569

In mptcp_pm_nl_rm_addr_or_subflow(), the bit of rm_list->ids[i] in the
id_avail_bitmap should be set, not rm_list->ids[1]. This patch fixed it.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available f=
or each msk")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f12effa71942..47ad00d01cf2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -777,7 +777,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp=
_sock *msk,
 			removed =3D true;
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
-		__set_bit(rm_list->ids[1], msk->pm.id_avail_bitmap);
+		__set_bit(rm_list->ids[i], msk->pm.id_avail_bitmap);
 		if (!removed)
 			continue;
=20
--=20
2.31.1

