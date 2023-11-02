Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B14125DE
	for <mptcp@lists.linux.dev>; Thu,  2 Nov 2023 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hxHTu1JL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNqHv5helBm+ALRFNW/Bt844r3B7GNXIgjWdq8Ol2LbthzW3B6FrPBuVBcE8xEnsajz+jOoHx630MnGh93KfjmyJXDhomKCVsV8SyeTEg/0whJJlqX7T3vCwOmdTDFresN0+fIUuCF/wZpvw4eELswGmP6TloC5nPb/Z9bTGWZzBQ8gn11jPchK9kTzl/C+Th01oGGWyGYrTU3ubxZw2cLdl+565RDEHITxptzFFrytwrLoWSbHrUgUXgL/MDVdOGIIQnepXG6IP5ud/tqqn7K7IdsBEZvPVostHOiinevCHYXn0bDxwoXTRS5xgDLj5Q0pZilYw0XMmeoK7xhZ/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0az9oo+KZtGPN3pKz2u+iEDZmW/cGpnGQwgyJIQReE=;
 b=TGP7IH7lZnqhX3Owqu4STkfx2pm4TgUEbmSqNZWI1Ctn40O5KQKj8hnv+XpbvD10c/Xey0OrHtEIUJN8PDicH6D/iiGR9Fn9chHKFU+wJbDmUPAys7bIchOeFF/YpFkJKPLU367MS7e7nJhaNumrtPH1ac64HC/OQkfumPH44CxyvOth++ThDhThctbZGDQl6OSMfC3v3J+tOsG6ejHY5oy36rGhuuV/i0K68F1UdgpYkXmhKjbUN+GUImeaD7zlgP5jiAqQeU15TecIV93o4P3aBTEEicElFA0oJYx3+5WSqzZm1MQa3Dk8mq1ZMoJ4HGJVYQwqYR+c6wP0Bu+88g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0az9oo+KZtGPN3pKz2u+iEDZmW/cGpnGQwgyJIQReE=;
 b=hxHTu1JLmoZ7z1MSBaN2Lb3IR4NNCMYIPnGUtPV0yjxj16XuirYNU6lb8hfh1yWXCFGv/3mRzt3xLgyGBpCFeB7lb1q/d81VOAtm67SCh0qz3eKG2sCv+mOE/lpG82LNnV3Q8tblQKdt1IbEgZT9kPYxajllezPdcM7QDOr6kJ0jfZUTyJ22oWlm2dg7lAtPK+BZIYsDtm2tOzyHlMoUyXI70ytKolc8JvFCS/WSXD+Zs17XfiPoyXoH0UrIUOWOV8Xdkp7+zrLHDsnByJahiZBXRToFQlYYxeyJwWSWztOQDPKJVdi8tCgzaDabqOcmJThRhMf73VyhyZU8CJsHFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7686.eurprd04.prod.outlook.com (2603:10a6:20b:290::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Thu, 2 Nov
 2023 10:06:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Thu, 2 Nov 2023
 10:06:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 3/6] mptcp: dup an entry when removing it
Date: Thu,  2 Nov 2023 18:05:54 +0800
Message-Id: <4a215f590c34c9c53ea82cad347d60927725babe.1698919435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698919435.git.geliang.tang@suse.com>
References: <cover.1698919435.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:4:188::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: a1285d96-ae10-44d8-e76c-08dbdb8b5615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nIHzY/YBe5K20X3RGr2pJXsEdoIsC2u9YMEF2hHj77sA5JvHZC3rSEm/qz2YLZpqhsC+GIwff1+Q3oflJQi6vkJIquy5EZYfTql+LxIG20CvpEBeNc1OJ5UrwH0BTNzCsnve6ovnCm+U2MI3KU6NZv8rrq9Md4ggbnnqWGpVSx1qjnpZm8um9xP2wI802cahxNi5Y79zMn5/sFniwkB9CUX2EDFhEWtgxKk7EpFXsgebFBdXdTiUy0XBApXb43RKBVUKz6GeWBkrirggTjNB3CZVin/dbQehvKDpSFd31BtEXHNnw8EKKTDSv3LJ8BLz2OjHMW7/QrApjRQ3JbHKNvWat+XvXyrJyqtuee1xK0XTa8s/g/F4a5GvSZ8qrksYc/y/ephr2HRgps2mArtHD+S7Ihy8snoMSkwkNMK/fueJBPln8vlBmlDS5mLHdGIa3hgCAF0fUoh3Pxom25mNjJ4Mfj9QAsZUPPlc3LI4oXRfe+XkxRkxdXmuowo8O7XPSrMlz9QOhiIOkdwKcn5Wd0kRU4xLUu43oiQwj3ue0nB0fR7kEHeYDKqOqTEhYKFINzob7q0KY5gqL0hMsXYqnbvglvcwwW/cZdpj2RLdDLg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(5660300002)(316002)(66946007)(66556008)(6916009)(6512007)(66476007)(8936002)(8676002)(44832011)(41300700001)(4326008)(4744005)(6486002)(2906002)(478600001)(86362001)(6506007)(6666004)(36756003)(107886003)(2616005)(83380400001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/MMVfWaQ0UJg8dRaIalQh+ASdltSzeKL764PdFjwda4wSprtXV/rVv+5ZHGp?=
 =?us-ascii?Q?Kk5RcOp3MTsttdYTanfmWI/Ws8ioWOI8MzJlglY+OW9hBqXPnKhQnVfsvdgZ?=
 =?us-ascii?Q?rd2NhZkPVpbDFNu3Uoi6q6ZZNzoiE+EWh6QxipmHCI6FCWKFfE9Tv7U3xDyk?=
 =?us-ascii?Q?t2k9oncFpmIMBxGbQW5Q5sKIVSLGmQxSVUFEPPs/036X8ji4uaUW0jxbUYL2?=
 =?us-ascii?Q?cVnEopJaSpkJ6wuiaAQUXfo+qO3GcnkwhIrkxvfFtILnbZKWtVrjfjFLgHgy?=
 =?us-ascii?Q?6A8+WYyRYTOQzjIeZQsH9somGxFnuRHj38tf595EKtBxGawGBXF6W9ep4hcf?=
 =?us-ascii?Q?dHTB8xIi/axBZP4AdN07xPVFsYIsT1/gq7xlO7d6Doc+sDxuJ4b/6I5w23QE?=
 =?us-ascii?Q?xV7edcnxl7bHPTutIMpoN75NtC72daAqnO5vzygQcowBx8BdfJTRUvZEf59C?=
 =?us-ascii?Q?ZVO3KWCsZ6TvMkr4yL6rplt9QfSfXZ/EXkeLQp0P0wRLMBUrUxPKqUa32v0N?=
 =?us-ascii?Q?o2BFPhAkWUl1V+KLljc9uhf9wa18eTOiXpAbYK7HjJeNiHT0gMJIcFqG610N?=
 =?us-ascii?Q?c40xp0bNDFFHXbIDv+qcshwHKTP+sJicms5nlGaC16sAivvGLZnevCrHRG7h?=
 =?us-ascii?Q?5U5RJ1d733eY2ZyG/QJlLU/aT33kRsLOdT+IG8LMHLjW0Nsg+oR5IbJVcBoB?=
 =?us-ascii?Q?2TobQPSFw4x+TNB/V4G59G9HwDNkdL5uShZedDovPpamMMkuZfJb+pypgXSl?=
 =?us-ascii?Q?TikGj2CQ8R8EKSJxVlRcUJ9DMcFUDmbSxT7/CrtQfNkpRgz8cn+p7LD970Vj?=
 =?us-ascii?Q?FqjZEF1j+i2ORcfTkp0Wx2FAl2qRyeUMRFbnmuDcavE03Rxd2vfpNa3MS2Op?=
 =?us-ascii?Q?LkE73ukYE88I3kbvx4+S/vJAITgqSYPJzMrBpDcCZK1wxRMnd1UydRK/Xdbu?=
 =?us-ascii?Q?uYvjwOtlXV9k0uxLgGssfWaoNz9hhXH0D8tejy+FoFzofqz1dC1BS8bGE8ds?=
 =?us-ascii?Q?LHZBA4KMP2pSrppGUd9Z8M21q/mmcWw6ulb5GV1TJpP4GKgaXx+aARWrUECI?=
 =?us-ascii?Q?kItzPVac8YJ2K+C7TjsAkFtlumkRrPNmFWjlKuxfFWNDbInfFqN/G8UCoQlS?=
 =?us-ascii?Q?0ErdUZAZXnvcz1uXoGSz/qAm6m1F+LIquxOiZY63ttG+vCKSxFE6BJiFDZbk?=
 =?us-ascii?Q?7XC+YWoj4yBblO9wM/ZeAWhLCRdExdmqhx9JOrkLHX/oAePPtl7RKCel2X4V?=
 =?us-ascii?Q?OKpA0E33EBLd6xHY1uNknwsWtq2o/jTzabLmGvKcB2M8tk6RblXd8umm/b83?=
 =?us-ascii?Q?N5P8XMccRsPhPaWy0oJnrm35qkFj8sF4YNx9YXw7E6n1/AnSHhR7HtAHiTWy?=
 =?us-ascii?Q?m6go5kgDw2YLHm3eXRDLzqmLX2tuPC/EV21PrnspPvki+cOjbotxrbrFTsmO?=
 =?us-ascii?Q?Srd5PSbecXLmKxBRjkKzR4tB38XfRULg6dah4WbDB0I2DHm5vWdq38If+1VL?=
 =?us-ascii?Q?nDHX13SySiI/94ZemhqsV59fJRrGsXGozYMpGE//sSzuuv3kgQwCi7QPG1kb?=
 =?us-ascii?Q?EAIcHsLK9PwZ+P9LoonZMgOu1UvaGplXtx6IREiCXCPuMAIEONww8yDUzwmP?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1285d96-ae10-44d8-e76c-08dbdb8b5615
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 10:06:09.5162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPJKedVRbIzRaoHcMRuOS/F6knBMRQiFoMLbg5/RZYALzzzIZDNzQWW2TExjohsGNSQR3+qgwsFV3+cCYFBYXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7686

In some cases, the address entry does not require free. This patch dups
an entry to separate the deleted address from the free address, so that
the refcounts can be added later.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8166d733569f..be95fdbc5055 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -307,10 +307,18 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	list_move(&match->list, &free_list);
+	entry = kmemdup(match, sizeof(*match), GFP_ATOMIC);
+	if (!entry) {
+		err = -ENOMEM;
+		goto out;
+	}
+	list_add(&entry->list, &free_list);
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
+	list_del_rcu(&match->list);
+	kfree(match);
+
 	release_sock(sk);
 
 	list_for_each_entry_safe(match, entry, &free_list, list) {
-- 
2.35.3

