Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E9C1A711
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gBBAFl+4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lldGYvK5VNndVdvYJ/6/hjlHmS8hwRKPC68Dfcrd4bDICDRVQPvYBAaM4vn8RvMHEaCZMENg3n7O2Ojm0vVlpq4xxBDRFttfuw7fdCW1Nbif78Y8/H8z3sUEcE9EFpfAT24FTFg2ZrZ8/zWq0oGFyF7Td5LVm+lVpfZcPCYYN8niSdoDz1mcHi+AovWyp6o/dDPK7+K/CD+qgglpmf0giHhnPD48AgPuD8Z3HhSuUxpo2wepKCXkINHYbRWXT39raP0vAFKLTh+jOrnV15z3r2fp6hgrb7TPaS93w4hhSbc2or/eCqIrp0+ssmc1Cuw2Qim7O3Ep1gjGwxRuBUWD2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITrTqUSiTFPQLH+n/E4UD7SU+WUhgfcHxzNk2VWjDqk=;
 b=IGDfotVFiKZO4ZC6pJndm7QzxOpjIh8mmpEq1aV/hQNDNmbaONeR0YNSBOmrA3BApznHxt41gvIFsa2Zy0T7MhPwRtsHGapojHNHwNE30wL99yD9WHknTtshHwioChwPIHhCxKpa2Ei8mHdg7z+p9gU3wet3pbxyTuotHLb5ABDhLJSsk27SujqlQt6v1pvE9vv7A5kHH6ietRSuP2/xCumj6c+tRQhXF2D8U9aJecBwDDW+8AtgOFwkS8HgHlN7tnCQTR4z+976v3H661GepMDZtVVC/RVTzeeNLt8Ysb0WvIDn1exfClc23NinxEIaD8Cv2zLCDheJfuDoEWH3KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITrTqUSiTFPQLH+n/E4UD7SU+WUhgfcHxzNk2VWjDqk=;
 b=gBBAFl+4/ndzL1vnT8q5dOf07EJlkoOQu8KnYLLDKo2fgkEI1oKY8Ni9c4PhvrFVcMNh9yxsb5dBIC25Ud0u4F+SQHe01LfAzZuv2GMUaYgUoCKLEd05qBgrZ/irbJUCmW+mAZsLdYQPS87aUXfsdtry7w+M6g55N8y0IjLi+2P8TIO+DA25mOM+pF5f+sbnCjaGt9bMfRMAio3C8xRIHHD45pS9stTI/bhAlJ6xKrG+VaHlqkBKfRZ+z3cxE8DRbhMv9/Msu8dR1sjKAONsF8+GbGDQWfLBzVLDCQuhWE10iYdpegpbXRS2gavrPtXbJuNtAjTxMPuDiW8amE3ttQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6960.eurprd04.prod.outlook.com (2603:10a6:803:12d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 09:49:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 09:49:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v13 4/5] mptcp: userspace pm rename remove_err to out
Date: Wed, 11 Oct 2023 17:50:28 +0800
Message-Id: <632571ba0b905193b4537b04e612e9ae588bcf0b.1697017655.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697017655.git.geliang.tang@suse.com>
References: <cover.1697017655.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d14f0a-0325-4455-c9b2-08dbca3f6721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nHfknG007ZU+XsX225HBzFxVZhZ9Y7HFrRRMaBx1w2O4IZdAtuyetY76dbabeHfgbiX4pu7kGq8nNRRU2TZywvxA/DVgm1c1Rj820dIXh4ff4+J9YF+w87yS1JjToxegkQtlzQ5kmyD9zp1SX+Krq2HcVFhJ0f9m1mCljxF/16oIDclOEV9/2qCbd4zJHwcdhQtg/0jY3L80qLtBqpqKunsGbR9YAqXFecW2fqTy5HCoZ1L45tTEWBVsgpohpEqVewrEeR90LfqGxnn90jrrOujP/JNOmz1tpd5NNzycYz8gouBKy/KTGxfTB5RuuOZ63YoU2KwMVfllDJpZSCqKAPqlW4QPF23OX5hYkRvcg3p68VGRUnvVYmGDEfep7OF3MDjGXO7gE3ukNYMCbZByK5bZFY+sfAQrDoFGLhb+GozCHwZEElVqfq/y9b8ZJevXiHGzIg1FYJVh/f0fH2EMXfmm4QBicqzK1tYvxQ2qi4uqTbO6KFz75NPCF74TZREAiLIv+DYmMHRUn2pPL06hHVYHFvuzZ4MEVf7osYwlPqYpNOClGJD1GFc7iiPmVJT4JUc7BgmLc4hstkljT1t6+DHftYpVea4WAp2hECpeh3Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2616005)(478600001)(26005)(6486002)(38100700002)(6512007)(66476007)(316002)(66556008)(6916009)(66946007)(54906003)(6506007)(5660300002)(44832011)(83380400001)(4326008)(8936002)(41300700001)(8676002)(36756003)(6666004)(86362001)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H5FLsbJWGwbhC8eJOSZl5UCZl6UgGWWTDwRGqzTWG6NO8ytkowGv/kRmLx0B?=
 =?us-ascii?Q?L3TYmar507qSSBhJ8bH1Hs56LrL9+S8uDUF1AW+GFq9nOdASw3Zh1dUPT390?=
 =?us-ascii?Q?sOA4EUmFKjxbNNLOk74rRH7pz8UeO8qt6TeDai5JYMTqr7SnbFuKLgT96/RW?=
 =?us-ascii?Q?9fZqnDF6th3rjbKFTuM3gAWg2dUu1P3COnjJnzNAyfoGmXGGv20wGEUwVMk9?=
 =?us-ascii?Q?OzA4Cy41cH7m9Ueu8KDv2aNbYr8ql43e5EXLfrI1eQELZNOeYfWpmMfL5T5W?=
 =?us-ascii?Q?4r+z6tVGIR0BbE16ifu1dTuobohZ4lEvVXRk1AtVBFIlS69m+viYnCDtIuoF?=
 =?us-ascii?Q?lNdgN704m9O3AyF3SGuEsRPY1TUcLWHY1LFDVFmgUZqPUu0ckj8unkIbrloR?=
 =?us-ascii?Q?sXUcdSwmMx3QoNRlHrGXAEE9M75XSt610NpHSAnEYZaf2hkD5J4giLQUPHA2?=
 =?us-ascii?Q?BxAe+3r9x0bg4lXn1Whz6JzKMdSS3qECth/4V07hRuK7RSf2uMBmiWDz2Eqt?=
 =?us-ascii?Q?7nRooIiWz+A0duWtWMPS6/ZWRN1laYbc1bOGEK5eyo+vd+saqyql/cEyt64A?=
 =?us-ascii?Q?s3OPg+BHiSvVMDmUQzixcstFEBrTvQGRXwGrTAJ96QdledbUmDSV9ciN5tVA?=
 =?us-ascii?Q?No56RJrPdZ9Tp15S+Tc9nf4w/LH7byr7bqXBw+lx990Fmc3PjLerVAl1Uvjq?=
 =?us-ascii?Q?8N0X+N8MUkm9Eskka8turaodXTk8QTcuYb80eW6mkq6VtcEMWXnj09Nlhy5i?=
 =?us-ascii?Q?4xXyuENM4H06IdqiIk16qpMgEx/tQ11ucSMi0FuHhXKqsa8BU3H85rh1+j3n?=
 =?us-ascii?Q?6GtqF9DTeiQKe+Kb9MjwBRjW+IBXAteYX3CVPGjy40edHecuKyXevi2kRubh?=
 =?us-ascii?Q?k91vMtLBuEHvlQ0ls6X56UIFQs6ofC8GIxs9tAtnGybV6H/c/qyrpUWdQXRg?=
 =?us-ascii?Q?A8OoO0ThItpSoOIZRj3r/B8M9DJKcp24IV1WQUDkMvNhYgflSzhqvrFmX00e?=
 =?us-ascii?Q?huIPHYQ0VQiAEvHr5DR4NpAt9qYWvkqUMdsPgqc6h2qNcroQXbs3H5Bfb27j?=
 =?us-ascii?Q?WNIvPmpdHYOPhgC1/H4ItvU5S+gtMckXidTAPAXvypvaMEqkKMyncNyXUXkg?=
 =?us-ascii?Q?FDoe2xECnkba0zwJ8+NlgA2D1vzKmZx4NUDX6ijBUa4XfoiIAL/tHgAWDbn7?=
 =?us-ascii?Q?xWXMHAPSTkFZ8kfVYL25+OI3cyA4EKiPe4Btwsn1Xxw6doAQx8MLzbfKZupo?=
 =?us-ascii?Q?KGQ4jhOtff6xgnTHuU7CAY0bHLBcKp40Jht9Hq7FzG6M+P85wikyyDVl8sO/?=
 =?us-ascii?Q?On0O6uJAj4wH48imtODBw1u8brSo/t8Q7zo9zbEhTHTwoy8FSjzRvXZXnWyS?=
 =?us-ascii?Q?r4MSUio/qyc8x91Ik9ly9gNLnh5bekoEkhMm/ewLHCLoARWqa7rHb+jIwUon?=
 =?us-ascii?Q?rkbc5EIp6Z3pEBvFZBd2L3+7X4KcGjl1OPD/u3H35CjjC8Sa6d7+Irj+WrPd?=
 =?us-ascii?Q?zfLkS4py0PCacpc1RD/zeiRUxHuKM0tbtvjfXZHQwoBOhVHZYN2BTp8JWTvb?=
 =?us-ascii?Q?aOIUVIars3CvzXKL6lAqM5wa9pJJDweU/mm/7OG+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d14f0a-0325-4455-c9b2-08dbca3f6721
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 09:49:46.6404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayP6z+roW/fdeNo48MLbQNlEN8toj4COMW1Cw+iCvm/HwlTkQqI2pnTgizQgQAh4Mhs5oOL1nY8+8ETFYt/dtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6960

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

