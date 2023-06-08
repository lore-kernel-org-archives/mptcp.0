Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A9E46B6
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 05:48:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA7IxGG6D3j698p3l9x+irqOld0YSeyZtUTk1wNG6SrFBm5qnXuHEwTY/p+A9BTLmx1BFLbKuXURCn+QpmtKFQClP/DYE2npynmMVSp+w/XY+f89LjD7CxDfNzqI7rAbY4tUmbl3IMYQo+KKwX291J0w6KXHIkaPrKO81tzgPtGC+I1+xBkyzQZuz2QYmT/calPcu+Kil6lxcUcQEPnvrybZ0aeMg4SFe8CSkTJCwMCyytOYB6nbBtMK5mOTVVTOMHN66qhNxqp4KoAvvfrKIU1nZfyxpRyd9EOJAWRvmotLinUEgoFpFHOwMra1w3aUCVbGlYJVtNSHqFSSONbJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pipv7QX4TsZzVPT4mbhsdvvzqwc5rpsoRci/bIT6RPA=;
 b=fve8JP25scldJjzRlHpzYmaJzFySlcfTRm3vkm416Xx00RTwyJOWfGuw9mnUluTyaJoeS4FVwszECNzgJivRxMCvE6WPhDhthfDnZCawJjtOeMliSOo1Ct48y6va3N0V7qPFjvFrjYXsQEOhQ1Zh2wKEFD7P4LZyAT9GI1AXhKDs8ZOkH7mTvS6bkHuaK+e3iL5GkhnSM+9McbAND6O1nAitAJoogh6AdKKFm1lOVHFI2UuDRvWstUEGwaHz8sYkSg3rXtD9Aa/8OTNQU5nVNgxxesnvuK905l8/K/QIAp8CTJgjOgSLFU0wzN7gY/GD+l8IeMUWp1Gx+a3bRnc71A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pipv7QX4TsZzVPT4mbhsdvvzqwc5rpsoRci/bIT6RPA=;
 b=Kk9lp4DG4hUgy34ZyB1r8w3Sm8HUuGDRfCLbCB9QwM1Csi3ETO45UwJF8vCkrnnCcjeZ4WlxUXZ01uKqXsma17vB4mHBj2DkK+fYosbwsLZgfUJ2z8ZOW/kXOCv0SSY9/kzFWVgRdp/IfvUOR4GXeLmJ2qi+nqBtRgd7gGCOl3PDqIgynH27TAMfgtyXC8cPC0U5g2K2sMDDIGC+uADVaLNM1plBI3djvbNb3E3Gzhj4CC/C9QQ9cVXznTkbAl1nl6syRdyW0pvwL5flJC2IdADs6t2Lsn/e9aKDZhAlodzGbsyuIi9tGmZFjSP95xSRmsvcDM6HuvfN8WQ9er09wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8609.eurprd04.prod.outlook.com (2603:10a6:20b:424::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 05:48:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 05:48:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 04/17] mptcp: add last_snd in sched_data
Date: Thu,  8 Jun 2023 13:46:42 +0800
Message-Id: <b29cb707beb87e09a452c39cf7f108193ed22eb4.1686202841.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686202841.git.geliang.tang@suse.com>
References: <cover.1686202841.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 66456060-f65e-4b96-8f48-08db67e3f250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+Na45jRv8iyekaZaya9NxFA0sAjrucSEETzp0odGv2fvwYTsoWEY8VKwsf57VdMPDfnLwzDhbAVPa7tEpkv3avDWnZbVgjSVfe3Xf8DLRF8/v7jkxQAcD4mHyAoSkHReWrAacsMdCggeznNTYO0mZqnbcbHg4A+UFhQPUy1iAD3ZyPtOKsv6fKtCwA4xiQmNzZDNKlAOMB+ByxHNJZsXfDI7Wm+igNFt94Y1O0ipotWYx5s8WLfextJkfOItzVPdSLEDoSGtBA3iQbvk+gTJsXGliLFLbRGYQfr53lW7DB+HaSuhi03CxiKOxkyS5YSd4bkw55QzQ8KgERdVF+QIYS4CMbN5nO/sjphQgIZNv6+X7UvjOPAMh9a68JXRSvjxk9zxHa9t7p4PR68L19ZyTYDvkHOt0RRZ3vSwbOrC5cl1dF3z/TUk8kzzu9YXRGAdypMbb1qAOcVS9uZvsJvx0qkFEG4NO4FDh1SFJWTqnO/Id/WG9n/B1ipLUE8XKZTz/2tcq7ftXQ7UEK7yHHLD0kRtb1qmxDHigSgH9hVJLmTEnKLfC2nRaHYpNyCpe1KW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(66476007)(66946007)(66556008)(8676002)(8936002)(36756003)(5660300002)(6666004)(4326008)(6916009)(478600001)(41300700001)(316002)(6486002)(38100700002)(186003)(26005)(44832011)(107886003)(6512007)(6506007)(83380400001)(2616005)(86362001)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T7pLnciBaxf09bRTisx69ZTUnEB/PXHu+xe1QYj3LyNF3TMF5l8e6xPAaZD8?=
 =?us-ascii?Q?ie09GE4zz2yAz727reoLaiiYqePmCAU9pqO5y2qX3N2XI32abwqPh/wakPvd?=
 =?us-ascii?Q?HLPYqEb46ZvlQhcNlutPGH5X5KJYt2hOWyULsKM2I/Wtdnt3Dr7vQ8x8nYmU?=
 =?us-ascii?Q?hE2e3nOVVl+ImkuhhcvJD6AR5nBp8OjFZOWFHuj/qxX4o2x0VDA7R9pKUn0A?=
 =?us-ascii?Q?t3H5HVOxG8QKKJtwokarpLayB3y3TUCCF+lB723gNYN4cRgCqaZlgreDiMu9?=
 =?us-ascii?Q?G2QzYqWIEBz7tT/grOuVnJRZ9u3EEaoZlXeHVMOI/gajSPqAyE+7cUdJ2UsZ?=
 =?us-ascii?Q?tC/JHKWKZimM3jvHoYhvrHJiVnPOoVFYeYxq1wCAwXmoHM8T+sBpu7SwKnDn?=
 =?us-ascii?Q?VreFguAXkNVNQbvNCy4j7Z/ZdqkD2hfRhUYKJoVqr2ZTaSJxXyMqIpFLUVaQ?=
 =?us-ascii?Q?1phurwTkNrtvtXo7OWR/uwrOmxJMvEqw4g1Qpat/hCcykwibVnqab/mqLnUC?=
 =?us-ascii?Q?7Z7i55XufWYtDb+JyeEN+Bcuc5Kx61jDTPMsMBGTaaRC2DlIJTZ3YcN9ADXJ?=
 =?us-ascii?Q?eUfKTeADK23CfPR5VDywfS0+ziXOxlCTf0qh0HzpoMSGg7HSNJKoiO7hkxJY?=
 =?us-ascii?Q?IOt2M3Fv8Fu9Qd1+gB3MC/sJKnrTSBFcAOIfByc01rSVKyA51Uphm8yM5/nW?=
 =?us-ascii?Q?Iv7Z/xpUQNVf56X+sTRChdD0ADyfYeOql0Y04cFzmE5uruM/EN5KLNQoUwTJ?=
 =?us-ascii?Q?XRZBJi4xQ6fM8vzyEwLCjBZLMBZ7QhjTpUznlk6bhyeP8tPwWu+wpILsw/NZ?=
 =?us-ascii?Q?RuTpjdaEs6Dx540/RmAnsKrlWZGncN2aBQ5goFUbUZVwMREA+F//woISm/fS?=
 =?us-ascii?Q?CqOywGTxJ6Cuzq7XJ0wnOT4YzP/irUMx2/nHK/72+wHsZ1wmFWS8MPG/O9+t?=
 =?us-ascii?Q?b9kP5Lj5xf+bUKy7cpbHPxZad5SOvQOWUbSI8IrdkLVOqPw4N59tBm2CSX8m?=
 =?us-ascii?Q?hQ9LlE48SX5obBXxYk/cPSyunx4jj00ZRwVwhSU3FJHcI+v2ynQcpY/tQroD?=
 =?us-ascii?Q?urFixE8unwOinpSCrAChUZno00pBZkA+fXMyUROObHih895/xRn6uzFyTpsP?=
 =?us-ascii?Q?65IFDVcwvNG6LukVRIalUjTApzJx4ZexVRhDE41Efro36+UmVE3So1mKanDX?=
 =?us-ascii?Q?U+pS+63CYiedR3TVOBsA5n8IXhooo+LpDu4mX6LGQw6WZMDMDyibPbpruSO3?=
 =?us-ascii?Q?L+FDiYBgatgX7IivTuuI1vACkMSrDd0nRKN0cw+EYEwc9d0hk4ChI7wCVTOX?=
 =?us-ascii?Q?W9YkTkHcyc8nNKZBPBvMLdOj/LLJGt15fJA0p3vwNl/EGeHQZ6FBMt2PBujV?=
 =?us-ascii?Q?BFXSWFqaAHTZBSdANmJgs+H/FGHH5oJuNpWWxHUUnwZAcYcakkTnk5NAQUsM?=
 =?us-ascii?Q?h9A0hmwQn6vfevr5d8u9U2JwF1C6y3RGwmt30eXUHBb/lZi5iTjcV/8uvuJy?=
 =?us-ascii?Q?i2dr6RpoDTakehf29EQ3KrJILIzIwInGpsuChjnBL4O/9+NIV8HqxGDhvMl1?=
 =?us-ascii?Q?e9ji9WN/PlLH3503jz0jlg+JDXpUk5idHrfggP94?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66456060-f65e-4b96-8f48-08db67e3f250
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 05:48:12.5245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFDBCATlDJaJcun0JghXPO427mPkQwJkDsDDbRqzkZy2v0cDUX3MVWy32kDylvSF2cHfzNrvVr0Bsqww4xUSnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8609

This patch adds a member last_snd for struct mptcp_sched_data to make it
accessible to bpf schedulers like bpf_rr.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h | 1 +
 net/mptcp/sched.c   | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4bba29c99172..d52aeb8b4485 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -100,6 +100,7 @@ struct mptcp_out_options {
 #define MPTCP_SUBFLOWS_MAX	8
 
 struct mptcp_sched_data {
+	struct sock	*last_snd;
 	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 37cbb62a64c1..dd182078f035 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -81,6 +81,8 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 	if (!sched)
 		return;
 
+	if (msk->sched_data.last_snd)
+		msk->sched_data.last_snd = NULL;
 	msk->sched = NULL;
 	if (sched->release)
 		sched->release(msk);
-- 
2.35.3

