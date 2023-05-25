Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2052.outbound.protection.outlook.com [40.107.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9771FB8
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 08:07:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZ3DuwF1zGOQxg8yL+uwP1DZSo6Xfizmh3wEGQxB9UhUHj30NlnGb3elClfpgt3PXpPFSCwhutPh2dDUj5kCW/Y0hju1oTx57d3pEXQ/cATzm1meEJy+pumHM92FtqS43bC41aRBg1L+qFTIR4fIqCGjFy/nM1lrN7vyZGUNZCzV/34rzzGcnOgIGZZiUtdidL6PWLzgbpb/LM0JyRxcHB8hSTUNJmZ0XiKXexDJ8PvoIHPipLww/kzsBAEyAIn+qA/X4HeXLvU5pfMI2mYdkHmB4RbIaWskjAlB8uUK/D6kNuzSKvsU7NdTc46NKpcKdniIpamNMXask5gT0Qq3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJMloZqJ/xdk/pcCaRdXRKjqjKO2pMP5U2jcE4BYu80=;
 b=hAUe71LH5kNq+xbIQ+kpoeM3TJvSce7VO7KtknZ8pX8Hx8UBzTb2Klm6LqyeEfr6dJu2rqbJGalqivTcySSg4lXcmIgNJjEdBPNXCy+uB9OSmZc+9L22soTs3pLztHLl8xn3ggFzjo01wsOZ4aXw8KRNYqbsRi0X/kJF910XzWl8p/v8yOPSw/p0R5tbxHA99rtVAv5vlYFiz6Kp/JRFC9YtWlEUDS/zGyBhkvawPrBgi5skHWcovKbHsgITf1BN0WP84mlQ1mseN7ToHyj019H2Qu/Dxj1NHKguGlcf1dTFpiQA+NcWAgWxyx7AczLopeE7FkxIf9c1wyVE3e1i+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJMloZqJ/xdk/pcCaRdXRKjqjKO2pMP5U2jcE4BYu80=;
 b=UHdPlRk33ySZvwb+vXkHAR/3WScAUq13X6cmwIwGKuk8FCJ4+FGs22H5STLIPTI4VVyrT6TaYokarbyQ71Bm9GmTTIpXax+LJBal020TjyzJZot5rNiU/z4gH07z49J6rgCxejLDZPdE5kE277ZFq0v7R68ylxe2qrRvi8NfMbb5A6yhM0lUioxUI7u4qtvutXVO15Cl8niQLb7rjYrZQsB510pf5u/xGMyHo1gcJMT+hF6JXR6JvX7w4/BoLZqjredoZABQA1pSUgMI3H2Wucqh8qta812nA8AD1z/yroDnOgqKZXq+NngtB5A1Vh6Pyii/Suy70p0WKZmpF5zhMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8075.eurprd04.prod.outlook.com (2603:10a6:10:25d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 08:07:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 08:07:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/4] unify in-kernel and user PM interfaces
Date: Thu, 25 May 2023 16:07:06 +0800
Message-Id: <cover.1685001897.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: 911f9b9c-1878-4b1f-3c46-08db5cf70d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BW87bSljZSARs7H14VVSMHZ4sS5YXCDKYuf2acyWAW1jN4fyWO9/ZRz+GTPeicmhZZdALJdmRbJFDg9j2VpysQwpsVETyfPA6/0b3cMDP/bUshE3aQRp40RHeU6Pc+cA6756YGGrC9LDsusGwA8iFtcUK4Wn47DqcCy0VIHq3w1RM8jdwznXrZQtx9FP0lTpi0XggUSXcltEkhkbSLFwDV/PRbzCSjR4U1DZnsjGBeNotVN2r8dYAhyq0ePxCdXYrPIPDBEFeuS3QQolvL4Mep8AGUEGjdMy5dEIjAjGdYo4j/H6MGKclmKUQztwulopRYbH2XMqI+y287T+MCrQBS3ufp/lQIgxHWkjzihdT1lWjAt49Fp8bPWdiTSjDTCtcJ5h74TOu0+bLB0hTzsHGOlDL/H3gTyNUDZKh5tOYw1/1G3tw14s8X2ksnQ0gqhJlGxF3AYhahs+6Lbx2w4oypPhlI2kJ5eKImH2Tsls/yLYasSTyj49AIyLnGe9XIpt4bCpaDMSG4f1yg+AWNqmB532KnPYtPrWGrpuleJQeku/WrAjPuk3oTi6zsIZZdWV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(5660300002)(44832011)(36756003)(38100700002)(41300700001)(66476007)(66556008)(66946007)(107886003)(316002)(6916009)(83380400001)(6666004)(4326008)(6512007)(478600001)(4744005)(186003)(8936002)(86362001)(6486002)(2906002)(8676002)(26005)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3PHuRSbaL9LLBDL6e+/JNUYLpG4dYDjs8V0Jecg4467qWD3LKo1dXqXhZrFJ?=
 =?us-ascii?Q?DPBN2yWCmu+m7WSUk1cAMqodSF2SaAAy/XIVyZvF5zhLbnVfU1DtypnfpXEH?=
 =?us-ascii?Q?L1Nh3MTfWFM7+Sv87ycRYi9osYzAb6pqDIRTh+UUgSjfDpLJdMZJ2oPBiIrE?=
 =?us-ascii?Q?9pk7lP612wVyJqjJLD57FxGcYLWiY8OY+gdk8iecTcK3xw4m1ZPcPEwnSRnz?=
 =?us-ascii?Q?oyBScMKlf4KbzJl6gDNVejA2RhrwALUa1Vt4rQADchBVFr1CpMcDpvRIIKZT?=
 =?us-ascii?Q?dlmXIyeEsfi64uYRA5yNFNXLjSbk5bI/USaTOyhrc9b9BvmvkA6RAdadmCeg?=
 =?us-ascii?Q?sTQOeYGBMtfwSGsW9Gb0WNFDG1EaFLd/irMhiZEAC0BmnOrEsN+KypRE1hkr?=
 =?us-ascii?Q?32nheZ5FCOO/sHdzwtkiZHKFD2L3PwO289aOTjQYcq+gpYnw4DskQS9fsJFJ?=
 =?us-ascii?Q?GL4+DxOYp31+5hgiYx5YMkLRcvbnrn1FDfLyvG9Llf4pm9W9hn47/WlfAhgJ?=
 =?us-ascii?Q?dPTsYDtP9k96kjuDjCE5AoY7LNkcnpkrF5fnYt/nT397+yxXRUMqhhCHLNWG?=
 =?us-ascii?Q?alwvBQUDPGB0vnRpCHb3GtOaprY0uirZtjFPfvpZ7YGmgDT7MZ8qKFLZg7Xp?=
 =?us-ascii?Q?jQHDecJQlI0r6FA5gHIGZJyYHCD0VodZ2AogkAf+m7a/ClgfoqQuAxrOoFMi?=
 =?us-ascii?Q?tJfUTq/GOvXOpdfC6l8WPfA0krwxWO2wFHd4EkTVV6H4nnbadgJX3kFqT7sP?=
 =?us-ascii?Q?vjdyjRdBFpUkSV5mfV9eFsecc63ncaSlkqko8Yf1h6pPZiQiXocr2UTV12Yq?=
 =?us-ascii?Q?rJlSuzcK6nOETUaqyn4ZKxUzwO3VrFPerrb36+x9M8qucEAgF0nQ3MLt4MtQ?=
 =?us-ascii?Q?pWoM3LmEB8yIEEhDOQJIOJ3PdHafOtuT3FmPkSRpwFR4xqfE3Z7YFYDsk5by?=
 =?us-ascii?Q?PkmAP+q1vAYF44B9cw0lizalhbC6Vl+JDvBEUsd4ufOYnlZwhE/D9zfBrorK?=
 =?us-ascii?Q?sKJ8Kbcw2sprtUHX1WRFiUwKzpGXs6W7Yacl2OEA0eEPIYMfOgThjnoEfahw?=
 =?us-ascii?Q?5SUsxi+wHtlXL7+I6x56tKn9fztkOunyGWcPE4q6WtlvZoHfL6NY1KqHUR6f?=
 =?us-ascii?Q?CzYbtcCSbN2glUrWul6f1HJq2ua3xDCdJ7GWordd6M2h8qUaSn8Uf//si70S?=
 =?us-ascii?Q?Qf/O/8QFE3TFVNm4I81KxTNhIJxdIih3RJDtLbMGd50QFV2b2guMYBbXxbmP?=
 =?us-ascii?Q?5NAliVTGHAnk3xCiNFwd2yY9eLh2rbq/fP54TKmr4gV9rKklRZ2ZLAU/SScu?=
 =?us-ascii?Q?X8UABeZDaM8UO0qIC/z+Xp3I6tuhSt6PFNPYWbJu7EvdbgJMD31/FeVyeX25?=
 =?us-ascii?Q?AiJiuQzp+NXg6olLNFbGVQXXmU87JsA7PhaXKhruw2gSiN9TEZlwSWMwR0DQ?=
 =?us-ascii?Q?5nCdATSddMz4gGdydZVSsqcyUz0p50UXBlR6PAVm2YmDiHxrwLtQami4j8Oe?=
 =?us-ascii?Q?EOzc9cZY8JSMq/v+F3/0N83mhWV0q3SNQbbGlHADSkICmclTn2Yse19Zi3Fh?=
 =?us-ascii?Q?dzJg0mibL9Z/8nHB1a2DIx+OYTte/1d8ClirDxwG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911f9b9c-1878-4b1f-3c46-08db5cf70d40
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 08:07:15.4368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1BMBd9qMORehG6XuyWekdQq3Q9dvDFZ0dfwPkq/yz0MsPwkoqwK4GZqnA7huJLq3cwMFkoU7g7TVeLCt/Pt4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8075

Unify the three PM interfaces: get_local_id(),
get_flags_and_ifindex_by_id() and set_flags().

Geliang Tang (4):
  mptcp: export local_address
  mptcp: unify pm get_local_id interfaces
  mptcp: unify pm get_flags_and_ifindex_by_id
  mptcp: unify pm set_flags interfaces

 net/mptcp/pm.c         |  30 ++++++++++++
 net/mptcp/pm_netlink.c | 105 ++++++++++++++++++-----------------------
 net/mptcp/protocol.h   |   9 +++-
 3 files changed, 85 insertions(+), 59 deletions(-)

-- 
2.35.3

