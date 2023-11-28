Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2088.outbound.protection.outlook.com [40.107.241.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4976235888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="4+e9aQ4G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5/YSWxHETxCQgUk+JnI4cH07zWuf4kf6GNSUGl7+3hEzxRyAT3l7xZfjC2CDG1RSPuGJlPYkZO9gb/wLm4D+SH345ODWGexpLIutHQzbFxgUml+ixSwema3ZyK/OQPRpSCwtU2LweBjze7LmUJP71gt5EWXLNb5O4+Uank5LZQ4f0GZhHZqO1+yllgrLSY+//qcV9pO6A1DxhxSIoFZQ1piB7tSXCbFUwEzCx7rd8BOCbUMouukIPz1+B6964VUx/9Ig4zgw13WXqMghPphC7z37jvoWEvzBFqqf/0ADXZYe48mmhQYyTdsIpFv1vPrFsptoqCJv5mAhHhoRlaOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=258KaDdxK+39PcXMpwwPvAYImmDe9VWWlY5xKNU4Lu4=;
 b=eO0gP9N6MwTjzOM5JyJxwLvwCIlL+0QjtBFQtjBG1IXg92PkqslTcYcE4TlbTSSF9Qjtaa7K5KVkBCquwwoSuP/ytxj4HtDDo7sfvUb6r8nKN1fPZX9Je2mawGv3kbjdetFcnHW9jYrScAUXmVFKMLwBb9gjeD8MGSwb/6V/SNl0Zjmf5FPJg5L8G9n2/Ss7D22cy41KWe0WHIJwgChjvFQEkap41C1Yq3aTRen5J7qqylWMk3nEu0lWEO91QBckqJJZuzYgO13UH3Lr8DiF7rnuwXXhmmoo8Cbj1PxyJk3xL9wIMUcgBu5Oc6Fd74FjxBK0N7ZR5YmSQb20/DQKmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=258KaDdxK+39PcXMpwwPvAYImmDe9VWWlY5xKNU4Lu4=;
 b=4+e9aQ4GU5lHH/2DWPeHxyKvjMuZ/pagYmOCjJLJkIVTpz/D4ZFGzZemQXcRh0VcS9CrN/ONDtg7z9+XvDC657NemA2P76iqu+dtXig+uzLdRPwVvtYRz+HcCEDiffF89FkOtgzziPr0aNLddiLAqNWt2OY7gR70EwGV6AoMJ+OXezoV3CP8fkJ0ZUfc7y7mfG3Ek7dgx3g2UBpW5wRyB1h54SMGwU+3IXgWPde06a56AAhAqFJYqiZS95bKQ22I3wWXthJ1zTHpNZX/Lzqt8t61HWOcEXb50Qkxl/zOFQRej/v6Pd+yxWStwqvKcaJlEiTkpEjU49KNbwdqqRfhXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7001.eurprd04.prod.outlook.com (2603:10a6:10:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:23:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:23:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 10/32] selftests: mptcp: netlink: drop duplicate var ret
Date: Tue, 28 Nov 2023 22:22:03 +0800
Message-Id: <b2f5af55972b883897de2c6563dcea47acdaec68.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0199.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 1223e1db-b87f-4070-5bd4-08dbf01d881c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	clNLtuORbHivv9ywa/QY9eOcm+BwDRHLN5F8bDazchQ0YkPZ/+hM/86xfpQG5HxnzhrhUqxLd6mho6FjT2er1Qk7DqUcao5qfFEh6pCXVQL10kVOumWswDlTNV/ecpweAKfZjCvR2Rz1KwSQFIiEY7LJ59SvfA7Hl3th9oxEvkZM8/RUDuMgn94j9B4w7xUaJFx1hgrYGzRQHmVBNHvaNKfvuffuopytSdb9lv2NHUgW/CD7ozVnGpEfeBwtYJe4v15N01UwkeCRFHHy1I4vby0TvqsjDiWJIrTP+DFp7eeDWar126/elbqqfEdWAaPbOuG1xzjKBhYfx5H6aYPAFTayzr0jXwWewqryIjlT6UTrrFvXmVNuvCtB/wRvibsFP3dwblZe9MnSr/3c/McfAwMvuAx26nbv6ZrO2ItvpGu51tyS/qt2EnXf0LFWt6Bqnnu+M6ZmeSY2C4/R2CxdEVzZANyJ/aoYaTifU9M4WY7ebEQCUUEM/Rjn74DxAN0+izT2QEUhw8Vre4z7Xn2adhz8NGQmf4n/PSyZByN4GD5kWYPFv6S2zkeaEHsprhjl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(36756003)(5660300002)(4744005)(86362001)(26005)(6512007)(83380400001)(107886003)(2616005)(6506007)(38100700002)(478600001)(6486002)(44832011)(66946007)(66476007)(4326008)(8676002)(8936002)(6916009)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RhrEiqUQX3V9EEbi4GsgDiCbq1s0B9S2JFE9DKUEHQ0tyIvGBaMMu/3EEUrW?=
 =?us-ascii?Q?mpFNJ/CiX6OWrwSs1lY8nAxdeJG0VWkrv4elhYF8k5tOJNchYbPPo9rI+19K?=
 =?us-ascii?Q?PCqX83uYRsL8StEcX7J5zXwKYSX277bAG2Lg2xR1+lVaF08XJyNt2QMxb1jN?=
 =?us-ascii?Q?karZiFCcSW9GGIpXYL3Ucvrhg44e5vyXxuAoDPGPpHiMDsxWKowTpXhQ3oH0?=
 =?us-ascii?Q?4lc0kphabjLrhN/OxSedJITR1unorbXftJCEGL2+qA/De8HJRqGapDsikMID?=
 =?us-ascii?Q?Q7ZZMkjLutS7lBl3iwjXMpWkN54lKmgKgroNLMwDo1Vby/xQj9H3RNS3vCWk?=
 =?us-ascii?Q?WYfc/nXCNhO/+6EnEyWUPBGvemKBa+HSatb3E7502WUcDHAmnNW9z0wFMgS6?=
 =?us-ascii?Q?opRqmAHxR0h1Y3LxnuXmQ+8/XsUkl+WkKkd+yeLA5jSIB1VVTipgHzyTMriM?=
 =?us-ascii?Q?k5B0ZtfJkqdiZgjqO4LcXB6ewwardAPl+PRX+/gIlJbfrKCaEb1ieKzOozlh?=
 =?us-ascii?Q?vlQ7jpyczG7+Lr/HU9aiVPcl7aLtV4p0XG/MCII+wqEKwRh5FYn6feEhYusG?=
 =?us-ascii?Q?KTNbBMBbI8eXUSv7gg4DO8jQJgdda+JxdmvcbIsInF2ZEzO8OjadymclIJmN?=
 =?us-ascii?Q?9rqk/kOS+m/hQB0ZfmrcmEiIpd9vG4R+OSLlAifDCb/f7EjlyTZdMCOzkTsh?=
 =?us-ascii?Q?1mpFc6wd0BCw0wWkdV4JvE6SXUf+VqCrxFLJLtRYPx6DOrL+sAXS3l9SxiDn?=
 =?us-ascii?Q?+f8Ik+1kFhhOAQtftrb53XAdFbU+db1ZTbOLmVcUAj8TdqAyJs3o76H/KShI?=
 =?us-ascii?Q?wA44XKToWpK1viHcX1QeTUtn5JkAUq4PtR1El24me1f7ErTzDlCFZ0fy0dSv?=
 =?us-ascii?Q?JA93xoMTNf+lxyJeWr2d2oDBzrDTnH8Y4hD2KFkJffeRmW2stnra5qg9VySr?=
 =?us-ascii?Q?EwlD3kxnIg+wekGiFvqygE40ddJM+8CPwbgK67Y3C8MOtqiiqfoHTFVxMjmu?=
 =?us-ascii?Q?pBTioJZpLZdOlgXuAcWGXFnP1Gi9YEeFIwEHdK7U67I177gkBI4nLQH0deqw?=
 =?us-ascii?Q?BBo/TpSZ7F+782/eQsIzed/gzR5ClkozFVcNTiNLjWr49IGOcrgkRiLISMRS?=
 =?us-ascii?Q?oKutMe9zhm2u5TwVdCcHsG+BoXxTlpqmUPixiLoPTq5S76xJAWDBzaCKW2C7?=
 =?us-ascii?Q?tHk+MTe/XVYacjw8t6AWZUjwfQODWhnFsKDeT0y8B34L69ritCbnVpynpQNs?=
 =?us-ascii?Q?0WxpqAOb/uW25NjVzYVOxkHxYwI2/yByIAin9NAKQu4+mA0+Thyq9Ds2EQIN?=
 =?us-ascii?Q?0M0ZVQM3vtKBD33AeAnzNFhU2AijyVtHPrarofcEA1huSrCD1fQssfo4HJ/a?=
 =?us-ascii?Q?aFt09au1tzVh/YjEuj+hNyrWdF1x+U23CUkyDO9nD15Fkk+0sK6Tg66AjZgZ?=
 =?us-ascii?Q?4lJQb+KDll71rHnC9JT1jSS7+wZHRLBhUc0O3yDGNkYUSe46yd+DL4ODIHuH?=
 =?us-ascii?Q?/7OMtC0mGLgRIxaJU8zYDD/zowhb+eFWkw1Sg8in5sdgXXpOg6PbxhJ4eGua?=
 =?us-ascii?Q?/VYiXmlYuDBZbbbg1/Hsc2T/KE6nRvmnOEQ4aR74?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1223e1db-b87f-4070-5bd4-08dbf01d881c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:23:03.3300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JM9S3UA6lJP/JiDtpx1dC6lMstGiWvcqbXNoRbaTlkhwPWDL4dZMmmkLdyheRZnVxHy0uvDCCfLfanBU+sv4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7001

The variable 'ret' are defined twice in pm_netlink.sh. This patch drops
this duplicate one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index fd413b4c8123..c0b6faed50c2 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -28,7 +28,6 @@ sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 err=$(mktemp)
-ret=0
 
 cleanup()
 {
-- 
2.35.3

