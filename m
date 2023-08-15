Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2053.outbound.protection.outlook.com [40.107.7.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B2567C
	for <mptcp@lists.linux.dev>; Tue, 15 Aug 2023 06:29:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIwetWB6ckQUO9S58xvRrxrtG9CURZmgd3P8lYB41XY0TpMAjxOrNC9LgSBt7pIlfA272MK0cdCEiTYN6STrlQ0stFKIouHIfSs91U3GoQ1BkV439K+jT12KN+CHRc0Gey1RY/EozbGhgpG1y0kXP/zLB4KXUDdFNTUneF21KKLObX/Kqa6vaEcCIi+kHnUGhT4a3s06tHDMX78j0E3dN3ESo8e6LO/3P57ghiFT2cgZWQck2OZDjL+8pr4DKqtBCjmrp7ufBgWCbIidyEy++N31IHfJXZ8GNYSM8ojqDAzE51JoiOhbHzJgitgAo7gUeD7r4hjUCAkybBPN63cEXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lmiede0Q15VwH7mbjSjdRDdL/6M/XbCSDuuD1CHR0Q=;
 b=n7OwGkiNaR/1SzTrq0Ka0TKWuYceHLbGOZcTS1BEvUnZw/wPKIvRRBT9aeH5p4yRY5U+ew5q/zQ1thSrV8D2F97W/5s0RVmlxBk+FvtCJ9IdPpGabt5Yk9Xjh9FvNwIjJ1mL2l/Y91SDHhZ/hkoZZU4V3QYOCuHx6X1lCTWkLLylPjPV8RXvTaBrBMzt6jWAcu4MiIpY/RwEbYkrCleEa0xXOJRR9z0sBeALgArLoJ6qmjqdGSx8Ps+8dIDqCq+L7FKcKMDZGW4kpmCzPKsR5blBKpLpN+xZ827IhwrAPqQ5mdogqUFHtMK5BDza0O7V342boj7Q9AW10EnArD68Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lmiede0Q15VwH7mbjSjdRDdL/6M/XbCSDuuD1CHR0Q=;
 b=yQlG+Jt5bZQoGff0ow1znh3TtYKy0kfItP8lu4JEAgj8M+u/qKGzIGb7+RJRahP6jTUFH1raxZT6p9lkD7jYkT5PtXl8EembveDh2yUEf3SnpLrJn/rDySzuZZwoDGdv5/ZrMizzAqAX0wVNaZvcOebxk8c3QwPMFnjjaauBoQhbnS2DxnbBFRmShf7c4Xr5OFy8RdSb5yetqKkzrX8NK1pqEdS4Y2UPEi3VlNK2usQ0ksYokJvzlgBa/N4z46fEE3+KE+D+9Brmujl3bzXwj7K4qWs7xA3j0hHhuIIsXsLjxV9bcxttcRehtzvCGhrD+RR+DfpVGQy66dOtyVowQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7239.eurprd04.prod.outlook.com (2603:10a6:10:1a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 06:29:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 06:29:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/9] Squash to "mptcp: register default scheduler"
Date: Tue, 15 Aug 2023 14:29:23 +0800
Message-Id: <eb604ff0d378148b269c8f5511401b220be0b233.1692080803.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692080803.git.geliang.tang@suse.com>
References: <cover.1692080803.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0001.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cfaf69d-7af5-40f2-bca7-08db9d59076f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aXuxuVSeJHB8ie0U+i9nm4jVHMhSBCHNvIBBXY3yKniE1X7Xcte99IRlfBSTmIuG/IqExLW87iow4Rfi7LiON5DvfKTWirziR49z/undp2C4YO8HH5rP+GiO08fRU8ds0MrywrHtk2NNlgr174PYLLm4p2cpiqeEUJKcbTRzQ7MNRH3CRClDKYCvHXmoFUuQq98otmh1Q3Jpv+0N5dxbIyo7RfH0eijbBztJhvTbDegGcmPsXwko9CupWC8OMFJoVlw6JBPZW8iDc4PAwyqBO4nEEc2JpK7Oipy6envQOBzlaii4H+FcmjgsOqdTgKLInETOJsPfJGaqmOIU2es/d/fwF7sqMiYh4UptFBa3A4+N9uJluyyjuEZFQqtGIGxnQaF1YkHUSdHuJm34Kk5C3QF3mxe22dY5+IS1Uc5uRyEb5dVoUSik6V5a77wcScHEj0KRRfDTF2kbGmLXvW9Ordwg44QP/cPKnTZi1a6e23wAhCterSC9a2TZLLFD5xB7wo1RXp8gsWSEell4xvVH0+E2GsZ2XzQ8IbSWVwNY4RHRu4Rn2qsYskuC7TIXWEK30c4lgGf6kmpPw3dKOcJ5F86Da2Xdyy9AGWEnERfDjJ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(1800799006)(186006)(6486002)(6666004)(6512007)(478600001)(2616005)(107886003)(6506007)(26005)(2906002)(44832011)(4326008)(316002)(6916009)(66556008)(5660300002)(8936002)(66946007)(66476007)(8676002)(41300700001)(36756003)(38100700002)(86362001)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MyXO5qE8sdl4EdD9jQsQuqHpVxF8Ly79tNw0o7wPZajy9/Yl1tNrj/WW9kiR?=
 =?us-ascii?Q?YZthZeB2WheoE4Qz9lyMG8WWlPRqUCa2Zqy8kFyuDmschOmQdy2zI9u5tARI?=
 =?us-ascii?Q?oKNJSm48BfxzOeWRvqmWaUOioL5OA7nKeoJBKF3C6U7aoNci4vwukdJFpOW1?=
 =?us-ascii?Q?R6XCADRqGEXz267FISwvG5PDyaz+wVBnaCsY9Hb2Gnl/wuI+56O2PAKzZ6DC?=
 =?us-ascii?Q?s9Reey6dqVkwNWyjrddMk/LgLsLy4McevoUsN2T6Yln7hnPQnZxNBv/RtI40?=
 =?us-ascii?Q?ScMrq5eq56ElUimB0unUj15uZdq39EH4WcZStg6rySHroCOGot2FAGrf/ASZ?=
 =?us-ascii?Q?16RXRed/spRJ+IGvipNSI3QuMH4UBQGIKy+9L8oY6apto1wAaniSYxXN4hR/?=
 =?us-ascii?Q?cE1juqAY7vidxniQIFtrei7L7GbSrvKWPnIaTDjwDgBms23+InsJm2ThLMr/?=
 =?us-ascii?Q?iY8sOI/aUmzrr21FF9zPGGh7lXTptfWB+ll3GYURrpalUJAzfnHLpZn2P1jD?=
 =?us-ascii?Q?xzNQ1uu2iNk6RDLCk7R/DVj1qrpl2RVAmuktu66yuWmbyjdGp2xSqfx/uCtd?=
 =?us-ascii?Q?D/06JlvOM+xmbMBxwIpSiJSPZL8VIRd2kQXcA9PJ7J9AG/19eF1w50zmIFDm?=
 =?us-ascii?Q?qA4KbqiPfW8MPfFL+6PvCqNxxKD3BmdC5mbIEnAQjZmqay14/Daej1zRj57u?=
 =?us-ascii?Q?sFbIQ8IgBMYblIH3xM1wC1aslICgoVMQw03HK8egGaMhD3DwO0Yll/ze6fIf?=
 =?us-ascii?Q?mpEclInYOVmFSyh253YUJUWenBm2UNqvVeVekRd62isR9c9P1qKqp2qLqyll?=
 =?us-ascii?Q?+l+o9mDmdU92ysK4jw12e18CAomZlk3HN8MWNdTrwODkCq/973/Tuq/bzvwC?=
 =?us-ascii?Q?1kI3+XJDfMrdlqRIZQR4FnRmMEXQG+FrSv36ViVJo7fTHgDCF3UOd6Z48zMd?=
 =?us-ascii?Q?XF1T+R1JOkCMFVRtKmHOxLKRxg+9Pw6IRDKi6zTJw2ECkD8HykUTDeteNu3x?=
 =?us-ascii?Q?oXfHWxbR7P2gObkEu5TT43lHZqWoGAih++TX8fl9Yd1MJwiVxf81HlnKMrCX?=
 =?us-ascii?Q?90QnqDXx3TNHD/vOJwrK4KW/zVf8yXDAq0ORwW2Fy9hvlx5n4U89+zuisQxa?=
 =?us-ascii?Q?DtOilviJKLIoAta4ihouWsZG0RqHbmOfRP53LBRRto4/8GbeBYWW050d+JOG?=
 =?us-ascii?Q?sYdSuLSE6n1SJZpLuRpm+Qrh1jtLnA7GAjCGU9KtS3yg/UcmfFjKY72QS+I6?=
 =?us-ascii?Q?yieGiEt8LTCcxF/DMnK3WxVk17qfFzoAgBpHMk5E/T+ArDH98sEXbmQtzmCH?=
 =?us-ascii?Q?m3Yj+Uq9bdNmdJM6BCwdHfaU/ggVngBdGFUFvlByWCxCG7Oz6I166C+DVpNo?=
 =?us-ascii?Q?goWWhfpK8Ji/eMagzWpGyyDh+quLdLzBbCXP9lbsZuu56/jHoNmJnrGxb5B+?=
 =?us-ascii?Q?LUX+6sjZBzfMNLItMKtHQcJ3FEOG58tlpW9XaVNx8E2tG5Ql9+tNqCLMmh3t?=
 =?us-ascii?Q?s01q73tV4Lt531bUY85fJUsxvGuwWMQ4EAuTYlrjgjmoA3sltHgCQtjQU3PR?=
 =?us-ascii?Q?3f5nesZCnXq8XlWxUoInsLraW4ciUOxjgUjGVZiY?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfaf69d-7af5-40f2-bca7-08db9d59076f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:29:50.9194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+OERoATPx+74oTjui7/7vahNdplqPgzZNQxbQ5CgNMb72utxRCwDMLI1cfNMzT87T6Mrv6nIgV6c6xvXNW19A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7239

Please update the commit log:

'''
This patch defines the default packet scheduler mptcp_sched_default.
Register it in mptcp_sched_init(), which is invoked in mptcp_proto_init().
Skip deleting this default scheduler in mptcp_unregister_scheduler().

Set msk->sched to the default scheduler when the input parameter of
mptcp_init_sched() is NULL.

Invoke mptcp_sched_default_get_subflow in get_send() and get_retrans()
if the defaut scheduler is set or msk->sched is NULL.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 31defb8c4e30..162604f3fbea 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -16,13 +16,8 @@
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
 
-static void mptcp_sched_default_data_init(struct mptcp_sock *msk,
-					  struct mptcp_sched_data *data)
-{
-}
-
 static int mptcp_sched_default_get_subflow(struct mptcp_sock *msk,
-					   const struct mptcp_sched_data *data)
+					   struct mptcp_sched_data *data)
 {
 	struct sock *ssk;
 
@@ -36,7 +31,6 @@ static int mptcp_sched_default_get_subflow(struct mptcp_sock *msk,
 }
 
 static struct mptcp_sched_ops mptcp_sched_default = {
-	.data_init	= mptcp_sched_default_data_init,
 	.get_subflow	= mptcp_sched_default_get_subflow,
 	.name		= "default",
 	.owner		= THIS_MODULE,
@@ -150,17 +144,9 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 			return 0;
 	}
 
-	if (!msk->sched) {
-		struct sock *ssk;
-
-		ssk = mptcp_subflow_get_send(msk);
-		if (!ssk)
-			return -EINVAL;
-		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-		return 0;
-	}
-
 	data.reinject = false;
+	if (msk->sched == &mptcp_sched_default || !msk->sched)
+		return mptcp_sched_default_get_subflow(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
 
@@ -180,17 +166,9 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 			return 0;
 	}
 
-	if (!msk->sched) {
-		struct sock *ssk;
-
-		ssk = mptcp_subflow_get_retrans(msk);
-		if (!ssk)
-			return -EINVAL;
-		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-		return 0;
-	}
-
 	data.reinject = true;
+	if (msk->sched == &mptcp_sched_default || !msk->sched)
+		return mptcp_sched_default_get_subflow(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
 
-- 
2.35.3

