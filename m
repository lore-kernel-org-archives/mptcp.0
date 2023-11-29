Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2080.outbound.protection.outlook.com [40.107.13.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE8B566F
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 04:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OioAOSFP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZIAcfWTeKWrua9A+d+vDjKTNDhTKx4510yU6xallhVH8FF8cO36HUmYruo2yKjpGsGpm/rXb8vqdDY3ZaKOTq7yquxp1S/HZEP4k9suf0v9cN0n6xuIKHAG50XeEsrlsILgL662hoE9Yl/F32PTAmVSVX7L7Np6jQBU+EgYIjZfmv+sCapC2uAhjD1XYxSecsJiV8BDgypHy2C8zOtSf40QHTELMrCNG2p7kr1py1Wb31uXbv9yGeHHeuYTrmlb6Qt4BWJdfso3qV+Bzj1pWV6YsVYtFP88Y53wWzf7opvnla3xL8viJzkstCGG1fyGX8mRL9pSqeFkAK2OHPCFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSjB0p8eF+L9rLQzSCrjmuOvxEFcgy8tIgNP4m0pVvc=;
 b=UtAayFu4eM43r3YuWhOK1vPejAAe8aaUNsygjLu8xiNnA2haCWZoAZ8Uwju9aQxOxPNRiw9gHlo5XwuJJJ1kT1Z5lVLuuGvMUZ7+PCti0JPc38KYMJz0oPBdPuWrkJOpRzCfCx0FU4gClAHbXHYQKIkxbsDrn9t1TBB+rnx7WRdsny+1xBuPJ5Cj01mp8p18vEpznKvSuwiAweiDm2CmlDBoxliLOHJZFCVZdLPooN0X14LTOCIss+EJgIUqlPIOeLyY1CVr0v9v9zmfVfxZGgcrVFqK3Helg+o+CVuE8Pa2kdwOnNBQqIt7T5Q9Hat1h8uIz1cf95oQCD3SmrxpSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSjB0p8eF+L9rLQzSCrjmuOvxEFcgy8tIgNP4m0pVvc=;
 b=OioAOSFPX/0G+rB7TnUhYh2gYWcIs9v48KOZS7jTvmHrm5w7xEa2qAh1aVnpWxjiljij9QpRJPTJqfcVPNG5KWBxNlistOJSDhyJYVA4zeU4C7nP8VDTAW89LT/vTT+V6phUsjpiX1x0dw9/o9JkRE44i3rJVWlTAn+qC4A+mBoMrTLSI5muNzi+FiI5BlvRQa6aRFKERUwx1KLVJh4QTxwQU+dobgRg+wgQeR9c4KveFlJQhnvk9IyC0D8OBxZkD2VIfZ0J1IQ6D3xdZCxoW2abUOAaGRuPvobdq/b5p/KLDburb8DFCmOBR2O+h9QKVc7oIdtZ2LGHhZI13OkvQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9118.eurprd04.prod.outlook.com (2603:10a6:150:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 04:08:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 04:08:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/4] mptcp: add mib counter dec helper
Date: Wed, 29 Nov 2023 12:08:51 +0800
Message-Id: <8308ca9192aa478bdfc274757dd31bc4e47bdc7b.1701230012.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701230012.git.geliang.tang@suse.com>
References: <cover.1701230012.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 5faecb75-0e22-4008-4a26-08dbf090dc76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8cQcG2CPp6bJhy3q0r/LO3d45zatZB6XDQEb36p9WR/Jq2SfNs9YZypTN/VJ/y8P5vig4a5uEbmTkBr7zLq64qbMSA/nHw71pzb3ut3CtDWGaTw2k/EUiKQVZ2DhTpqo1kmJPfGBzaduypWL2fpkl8yqouAfBioJyqNYongSAgL16PrMAxTtjjb+/Y37uVk2C5eKImLxQoTEK/L6uo6LAQUQUWCfgSd5OZtpp4knibvPEC3cFg4Fu423K1v1MgjM6G7dSK+Ei85lTOBJZF6AH1orr/bt+ut//KVxVu2XdzoYLzoP8pEpZgevhzG4eZI6G4daz+Y+Va/pq0HzLCqEemoYxjoSs+LkewFB1V5n8aF1W6oLqhOa7qzukJlcwoj6hgteGG+mg2ceRoBjXga6QHot6B/XrLMSKAwV3gMD9N1XSgh+NDFtmNiaJMRanP/NS3zHbIPkGMWMVKcFViFni+q89jqdiI0ufZkHpTNkA99GqGxc8Ie7ulB0PwfMd1MkzSfFmOAe1CV6KGRQOobf0HgXBug2cZrL8BKGCSLq9HWlPnq+ukUNRjqxXz7Ox0+0mGzP7ut+hlUMhiUBuuW3nqupildw1ezYvpnhTI8xsrM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(107886003)(26005)(6512007)(41300700001)(44832011)(36756003)(6916009)(316002)(66946007)(66556008)(66476007)(6486002)(5660300002)(4326008)(8676002)(8936002)(86362001)(6666004)(38100700002)(6506007)(4744005)(2906002)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0ubpumAUAqwjYenCGOwjU1LE8/zxCDo6k+3Oao7fFS6qpWOWhNdB05us8pS3?=
 =?us-ascii?Q?wFuAsofFCAXGtSdyaOPjhWkOBQGBR4VCeqDiMyWK2W+/K4ixaFVL2xSfgq9+?=
 =?us-ascii?Q?VumiTU6FZGl+tlgHENDvzt6mLzvBe/1wbKqRAyRso+qVdlLbF2IuP8a5g74g?=
 =?us-ascii?Q?BBgpPt50LAobdZFD4EIiDVwpfGi2s3G1h9tjF9ZgGFjI6uM9OcCGQlUHyLIS?=
 =?us-ascii?Q?U/bAxM/WL/gXbDIV+wiMCaSLE4JRwUnCePVNHQtsI9T2mD5deDsqTEyc8F6G?=
 =?us-ascii?Q?vFKoMZ7icaaHY2ggujH/9Omb91JeQLfTbdxb/R67Egf3x92awl0UOI2pssup?=
 =?us-ascii?Q?YzHd7GSvjjyQDdllfmFqEC6EjF/AKfX6+3d9vHsg4GKAx42f75ubQM2kKFXy?=
 =?us-ascii?Q?ACDm9fcWzQBGZM8mXMdTzVIntcWLWDrerzkCvINAauaWUpjy11tyIUOqBaNn?=
 =?us-ascii?Q?CCbZuwjnn+LyWjwZv0SulSB3LFByeh3KihA9MTsfIgGSLcvzNkVQ2bR5hGfA?=
 =?us-ascii?Q?qWT1xlGH3LpzDxu3PULvf/OYATRqcnvW3sTPCC0VSgBsV3PnfgO8mCBD3qHE?=
 =?us-ascii?Q?RWivymbp1+vVogKFg1QFfeYatjNkJI9KxTR2YTF4e8ZZHk+ShwyXyA20V6c7?=
 =?us-ascii?Q?H9TgFIUC4uNKBQYOEZ+dMFFl2x1gC+apCr+ZHsGe9iFF7tK3nBv32XLgn3oT?=
 =?us-ascii?Q?HV5RuyvHkdFZMvMnrSZoMPANvVB7UWyxWpHgSlfIuF7YJxBp8qdvdFi7g1+L?=
 =?us-ascii?Q?vSF44w430veVM6n/RZH2NfNlYFZUjH71dsNJCIrWaPVdReQC/zQwNDx063A4?=
 =?us-ascii?Q?QvlLJE/wD/sEAOJEApH5b7clxN3ed2uvNOCupQgsw2JpnUziSG5HrxvuXvyM?=
 =?us-ascii?Q?1+NiZyfqQkJuYruK4USsTn6VMzNTLVdv64GaLVQDdd590P/lSkajZHgMCHf2?=
 =?us-ascii?Q?khUfdxfmIQxlZDiioQ6DV1FOW/0VdysVlTg7gWH5GqLX6EaSaXc4AZFF0w9H?=
 =?us-ascii?Q?BMWsLKvBW6HNqGW3otsG3L++bGzCAyd/fhNGr/dsbxZiVNnZQqiaNq+BhaZg?=
 =?us-ascii?Q?AR2w9lDblZTUsP5DPqda8j9E5423FedHAcsoim/spY/OjOeb3TDXpjNN9Xsy?=
 =?us-ascii?Q?xPYGVwbzEX658n4iveNJDoIArd3RVtEGdHuycxFHeBxSiGx6AxelQIYqdTZd?=
 =?us-ascii?Q?mQjK48Be1f27FyQqrxyz1tTqymp0kdOQcWb7G9ZmpiteGFvT6j/vh58GOl0F?=
 =?us-ascii?Q?mlWEaj6BqcmnDNPKYvEzRsApw8n2J1iYXYucjolna4BAERDdZ2y7anFFqw9f?=
 =?us-ascii?Q?M/2fSwGnLKIYqKSNO08Ke2vyjI/aWshhQSHIPCNtcs/+7woprMSBq71toZMt?=
 =?us-ascii?Q?j2KLjQGK/WOulUJWTT8V7yRn/LD+XlZ2Bd/R/4c1Ui6xoDdZF3ensREi36us?=
 =?us-ascii?Q?1xkBGWmEVnCJvkaPja1SxHnO3gWh3kvWMVKerrHBBHHkwF3UtCNpD+JtkYfF?=
 =?us-ascii?Q?GZWanXQ/Y75xfhdHtV94IceUTNj2zdu8Q89xTYO/Z1vEiOxSjzQyASpUcDny?=
 =?us-ascii?Q?aUcfT0xVUa/gUxlyGMVbBvKbOv4yZDLmazS4JjYRgGui6GJ68jA/uIhMl5uj?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5faecb75-0e22-4008-4a26-08dbf090dc76
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 04:08:36.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMw4dGuTcAjlLnzu1jqn1EsbX3f5SuqQCZ/TwXrkin8X8da7hVPZvRbwuoCTr77rBnohUfYAEyOlWEaGLwWPrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9118

Similar to MPTCP_INC_STATS() helper, this patch adds a new helper named
MPTCP_DEC_STATS() to decrement a MIB counter.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/mib.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index cae71d947252..9b7c366675ec 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -95,4 +95,11 @@ static inline void __MPTCP_INC_STATS(struct net *net,
 		__SNMP_INC_STATS(net->mib.mptcp_statistics, field);
 }
 
+static inline void MPTCP_DEC_STATS(struct net *net,
+				   enum linux_mptcp_mib_field field)
+{
+	if (likely(net->mib.mptcp_statistics))
+		SNMP_DEC_STATS(net->mib.mptcp_statistics, field);
+}
+
 bool mptcp_mib_alloc(struct net *net);
-- 
2.35.3

