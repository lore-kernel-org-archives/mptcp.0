Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2089.outbound.protection.outlook.com [40.107.249.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6CE9CA42
	for <mptcp@lists.linux.dev>; Mon,  9 Oct 2023 06:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IX9mhBaD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3DJjBmuxOduSRTUamMq/SZEZ0uTm2DzRCFTzhqvMjOgo4ZsM7FLBsYnuanfpMQNib6DMNH5j/0Bl665WgUJoQ3Oal+nJluo/IakIlX9y9/NFsXy+GNAbxGXQRim9+2Od0ZnZNtHG/edCIit2yGoLxQIHHYOuqFFUAxFqp1IdCdNSFLS0lSkx1/AeyTlU+vaXxw6vBYNxlJpglx4kOjDcbEJ4pylqM6xztihDJHHQWKWPBrXN4AJW9Uh5tVjI1Zptuchussh7CQTySUNKSXHq2wWQETlHIjlAldxnJjLPBogbG6REURQja2l4hiWl1K/P5heyswLfW5opLZMZyAL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQicpBDXnUCuDxb1J521AEYyxHv8QEMfeOLrQmv9eXg=;
 b=QQV1RCVRVJWVsBbPsLRv+C0LzaIAUbcEVW/Z+iAIjLkPKVleAXk5+tGd/WD9zd+0Y6PwwvF5G5E/W0s+2FHtcFjTXF/KtoKZMLFM6z3KYLzZIU2fgayg4WsY9MssJFN4sV2lpaJbr5NyO5VOxM1gYw2x5CIDWzJDykYfxJAqhblBQJza0LbvtwLwOfaoOk3eBEiXrnydVot32od7hpm480Cwuq8KQ9nrm9IXVppOlbvfLTUXzBqvx+pr+D9qBk9Wx9FD7Tkmqd/DPOrNzE8IaWKpOZTv75bQ6eq0DT1kRV+hCc8tDf4LMfVyPVSd9T3wQpo/XIjbh70adUBetvNd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQicpBDXnUCuDxb1J521AEYyxHv8QEMfeOLrQmv9eXg=;
 b=IX9mhBaD/POpeoSiQSd44WOoWTwUXZIPd7wzpxbbcM7dTEPVHJUgnEeOgrxb4IlY5UlRSFW2IyRsxdpG/NfhLIBIvAeuWPDVgxB5o+lghJ/qTsZV9/2n79mEegxysp7mLRR0fRVTyE7RkM2H2FuUgvq5tfcJXElcCj9Fy0T3zoUgMiUfyL+AELp53b8aS8K+TaB80WdZRnj2JDzyICdyl/o5HfZIkKrx+/hIAUvmQsrxnoDd+RSHDQvcK1DpOiCuwm7i5U8Q1bvkIDzVJWZLMGSORMNwI2Vdww7iEfYMVBp/uVYsw1qYgfX5sCE2jA54hnXntIU2DWsQDMXnAPE79Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9658.eurprd04.prod.outlook.com (2603:10a6:10:31f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 06:01:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6838.030; Mon, 9 Oct 2023
 06:01:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 0/5] userspace pm remove id 0 subflow & address
Date: Mon,  9 Oct 2023 14:02:55 +0800
Message-Id: <cover.1696831239.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9658:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dbbd3d3-28a1-4184-ca9a-08dbc88d3a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Z+r86R7QAdz0KPKYFpt7wexQw4Yxkx84/3zEg1CE/xEW512rW0H5uZAnn0rVZwDs6fw5Hrpvpo2zHl8ew5KK6FTkEFiv222bHCwuN+2I/bFE3mQNyc4he5jwgvQnabmZyIXfQ3Va/ThT+vcxntQJYISeq5rVWV+DhMA0RtvxENIQOtsjtq0QtFpsZTQ1gAEY6QTDKcsVNV87BAcJ5vxNjjampZ1BgvXW+CGHzsBFnlJ1+cyM1crH/gIwq7vODbooUy4kD/3tGLz2omMiibG3CPC9qyKl98f/LUvm7YA82igsmGvVf52MQUiRy+kFbx/7R2Wed+U4cd8WQoJOazpXkTKsrM+mojxXTaeIVC4xc7iZ2ljZSo0W5PdfHm1IaWjyBnIt3DmqTOGRI3EAM+cWeIroHSjbvZGTJSRwFMecRDonVv/3gXpeHFDoaIMb2gmZoH+Ducd+IxvhWY5CFoZXKEYU7nR/qclknTFIHronSyqh73RqJJMG1jJ7+yLWPJIgOuZ/QoNbIgbqSe1Gu+rLidvQnJRezLVEUgIyUIjZU5h0FH2UmrK1k63E0AgzG/35j0+sK3e1QOGoxBquQg5Nb5u/yeiI8L/jRB0aM38o5Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6506007)(107886003)(2616005)(6512007)(36756003)(86362001)(38100700002)(26005)(83380400001)(4744005)(2906002)(44832011)(6486002)(6666004)(478600001)(41300700001)(8676002)(4326008)(316002)(8936002)(66476007)(5660300002)(6916009)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k8gsfmp1mgRaJxXlxm5I1sKKFsOlI7LZLidLyEqifFxNd0sFAs1cWV8/MXyQ?=
 =?us-ascii?Q?lnOmaWz8avwi4VrA8FqwSkxOHVuwJux+oEqxqMgq7BjnDPYxt9UyEJmmtmaf?=
 =?us-ascii?Q?6dSVsT/2A7F6r4LGJSdE7oSk1WUG8euhiNq8xIsVxVOqJPBZ7vkH0UFSjeIz?=
 =?us-ascii?Q?RX7bUdLb7Bs40f5gSK41JTGVLckDAeCQIpUgN4g572g5Fxq/IL0V1HL1eI/x?=
 =?us-ascii?Q?uipyUc97Y4dBdMTccURtghHOFO8hFWmaDHUS6UHtvmd/5FLyqWdlBKAeU9nX?=
 =?us-ascii?Q?R29U3KxVA/PtLNnv0jRUsatrmGDVDyWgzyUdWen5+I3kCveVGusjlBJBwJIt?=
 =?us-ascii?Q?2jGS2FElyYhpWKC5HS6xmRUAEotzmP/VbY+L1LIDa/EgjJhnVybBet6iOJo9?=
 =?us-ascii?Q?1tc872DitRGPUT/xNM2ukLFFrc30HqdhXxUz/vOwXAAR+m0ijr0mwQHLaToC?=
 =?us-ascii?Q?OjjQgHudY6zmf6UfWrV4WtrpsLBtFFLs4XVBwDH1il8xWnBhyjX4LBmgtOJv?=
 =?us-ascii?Q?gdHqMOT0JkKPK2tVpu5JG+LDHj98BGSCS6vdJhRXAokudBdQM1JCL2Yyh7hr?=
 =?us-ascii?Q?ZL/ptozdl5yRiZ4r6Z6Esmh0vgM55CNbFbhFN0HSIZppNDvc/vUdLcil7evc?=
 =?us-ascii?Q?VVXqH4FGDYwrJ1OQ/dg94K3bqoT6D8oywoAIB6jp7smrXzYg0Pa7OBVQe+fR?=
 =?us-ascii?Q?k0zHPvju0bf75Aq5b5dzh8lr4PCre8VWOwf7/ywsfr01AwDv1Lhjos0Ybuz0?=
 =?us-ascii?Q?rQ36z/g5HxXTbBoYhnN4UQPOCKBryTCoakDOmmELh141/7NkDoBwEczmpvNA?=
 =?us-ascii?Q?jTb1q6FW/YrYS+SN9fetNJ7/fXnO4rwYZw2pW0QFZV6TsHbl0LWzeggzL9mO?=
 =?us-ascii?Q?tv1quBZ1prPB8SyAnJRktMprtbufWziKaYYcHdNndjzKEMJ5waewI5qK18sD?=
 =?us-ascii?Q?EBUQ8iSM0FfX5QbTbYWACZ5PAKYt/nFrRdSA6BR+Ha+d3CucEn0trJwkgooi?=
 =?us-ascii?Q?BR4scBz1Doy3EZg5BRrkzQxD3Q4RuTKGioaCAYtJ+9smKZItgnHLPnzZ6JPf?=
 =?us-ascii?Q?MWlgIvhtOBPtcQMJ5aLCWh1EIZhM1AudjlaeNomrOhLrpL7IiWDAg2RTu8qv?=
 =?us-ascii?Q?hFDpt+Rs17bEptsedhRmjdCiZpZojiZ3Ws6mQX0rdSpeNNsuznNElkXA9mTe?=
 =?us-ascii?Q?YyDsYeR2/ucuX8wzegtaESDp5D0iLvwS1Ydl+ChGsg0NLvBQcf4swvi2wFBz?=
 =?us-ascii?Q?lCGzZpovtXa5Ysoslj2Vi4hnPVhZaWEdquwJie+jnzpe0TkEpXgBPkjKNcHN?=
 =?us-ascii?Q?YXODX4FFhDk13Dj/dNyPYMwH64o+veQ4gYI/i+yuKByt2+wOO9vYnbUol+tn?=
 =?us-ascii?Q?l6ciVRQu/oj98FdObQSD6NWphayOKtlEA+/+NpbPLxfgcjS97pxRHLE25JVC?=
 =?us-ascii?Q?0w5NI59xi202Tni3xfOZK7mSzCKP/WayRxd4kQd5cbHhR/pfSqYRM/U8qnKJ?=
 =?us-ascii?Q?hKZT6fp21msNK25URgpesAsf4obvHtlJbTxaZN8hpk+EnpeCvgw+IX1tR/Nj?=
 =?us-ascii?Q?l4Mvb4uO/9biEEFHcTJMPkdVb7NAHLsYT7x139Kb?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbbd3d3-28a1-4184-ca9a-08dbc88d3a09
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 06:01:49.5407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rphcK7aMLPiuuZN4BuHB6AMqvlRsP210S+N6GluBXuHHUHKa09UFeHOe3RJE9Ts4kPfxCFxQ8rMoR3vTs1TH7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9658

v12:
 - address Matt's comments in v11.

v11:
 - avoid sending RSTs.
 - rename 'id 0 subflow' to 'inital subflow'.

Geliang Tang (5):
  mptcp: avoid resetting when another subflow available
  selftests: mptcp: userspace pm remove initial subflow
  mptcp: userspace pm send RM_ADDR for ID 0
  mptcp: userspace pm rename remove_err to out
  selftests: mptcp: userspace pm send RM_ADDR for ID 0

 net/mptcp/pm_userspace.c                      | 45 ++++++++++++++++--
 net/mptcp/protocol.c                          |  4 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 47 +++++++++++++++++++
 3 files changed, 91 insertions(+), 5 deletions(-)

-- 
2.35.3

