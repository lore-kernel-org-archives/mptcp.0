Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAD7639
	for <mptcp@lists.linux.dev>; Tue,  8 Aug 2023 05:38:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mo6MpDQaxTo9W+bVjkzWly+/ywMSxqo3puzaih3LBHHn7s8QiGeU58R1G0Fk5818KdyAehKmKnSMQlKgRAWQIn1lL/jzot6589vQFfbvPdLcBOCGHdXyVSDCqJIQbPTOOnkXMjZNvlm7pzU941rQcxK1bHL9TgseLoOe/ZPwVCSFU1awTjgDqzNsMSyGQR+M7DpEwFnuOBrZ9pNGP8plnQY5934k0dsqU0fSRP69SNOXUuO+DZq81Mp0BWekVOyvf3IOPihDKtvev5D0gJ8/gpHYQ4b6dY6QLZwCwLAXvXtRZrvkG/EIFx0degpLSIdkkZmTSL5Pt+2xefVupLCb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEDVwJeN7Y8x5qDuPUC6kPoHyZI9plD2lkRiTRWzh64=;
 b=eGdMwKFSmcOeohcZZ1FD0bSMJeg5oVZztklF6mvpglQ0QJZYB+jL+joK3BKUiQp/nrlyfTBrcIhDsnXo1ZGuqqjiYp3Ni5/cVQ2tRaw82g7KD1j7dVlzkYTROkbIuMP1vFnd1XIcT5zEoX91nfBHALRagfnUn8hdmIjiWBTiu89noxTZktda+T221fUZe7VU/OOlS7sWhAO5nZyzt+DrfdtGu463Yzkmn0IDfQo0KlPzqfVi8yybbraQf7UCK1Ry9Qb+NHlwmJ9Y2GapSISCv0302l9EqWpu+JtIV+Q6Uj0AYexU9xjUynhJ1l/7Gd65E32InrgvozYjkXa22xWz0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEDVwJeN7Y8x5qDuPUC6kPoHyZI9plD2lkRiTRWzh64=;
 b=HzpdpzXtHET4Q4RB/ICQ14ViseOLI1qfY45Q5Xqc3+lPpXgNflRdh73D6eP8boqIV6baspm5px4nLpWibD+5fkDaQYdeOiTD+flZ3/EZV8Peiszo/h0JW2YvtGc+NtGwYJhDYTJMFWoDkllPy2rtBO9IjnHefOqZZ2hAZ8mrHdhihWkgEm6mehSso1RGdjA/SnTG0m46eVexgb8bLNdqYPh6VWCQL2TfhqY9BZrLB2mgsF8PsXpQ3DGuYKNBXdny4qzgQqtXQ4AhttlzVInlCSjkH5nYUjmrjAk+OMS0t8kNmEDgoWvzezOzpclCThz4JmmlUAo3lQ6b/t3y/S+k2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by PAWPR04MB9864.eurprd04.prod.outlook.com (2603:10a6:102:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 05:38:14 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797%5]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 05:38:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/4] userspace pm remove id 0 subflow & address
Date: Tue,  8 Aug 2023 13:38:23 +0800
Message-Id: <cover.1691472939.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|PAWPR04MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 214be829-c2cb-4de8-3208-08db97d1a864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f5/JK40nnJXHhcA4JKLolxjn49lrA3n0ZND7PyqCc8HhWd/T0u7B38U2wIOjKUK0CSi6QFW6yXneIgY0cZUUls9arcf+iCBGirwD8dFnCLPI5O5rYzr7CQQ8NoZ0u7arbNI3vBQ5KM1ops2qtOBFQKUEvu3XqfKvWybrEM0vPT2oHh/PhfNwjV7jHfVejw6z4L9SLyDvPx4gN/O0Cn+JeZSZ/a/oT+78DYdVKL6fM5PMpn5hEISFGYCaYoVJ6QXLQyy/q/m0jl7bh/lr8Jv4657rFJbG4L/0WK2yKK5GZW+o/fuXxfCp1P7iA7fAdblAfaAynwroS6nYnmKoFUPlLXVS3kiLj6w6NaH7BdfDPIT7DvsiRWV4T3gwDXGLnuC/wBRbiwNWTreo+D7KL77bLm7rqtVRyWLCEtKwcLKjkd/G3D89PlqOAwWEVAykzLK+yqBc4Byd3pd61OEZIT9u3gXG4r2fo/rKY3WM1nHQdfmU6G1c6rPaOyGN61b0xgG9MgD171uPMXSol5HpgllBtaUZUgyyqvXGaDF8LbAveGEAlXK/qi4WxjpFfhS1Q6UKEt4cfEoqcChbmJCqBQCwyW6MmvD5ktyNqAQUMXrefpyWVPhMvQfdAHo/P45kyGhUt4MsVyZNPgN73JeK6/CxmauoprpIEd9ynhTJfo7//dA7u3xE0cSPaLrJcFAuaL/tZF5V3E6cKgcHu4HjLCy5Xw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(39860400002)(366004)(396003)(90011799007)(451199021)(90021799007)(1800799003)(186006)(2616005)(6486002)(86362001)(478600001)(966005)(6512007)(26005)(36756003)(6506007)(107886003)(41300700001)(4744005)(5660300002)(8936002)(316002)(8676002)(44832011)(2906002)(4326008)(6916009)(66946007)(66556008)(66476007)(38100700002)(6666004)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wR82aKxMHVtc2afGKmw2Q6VmT1D4hyB0zGuzY3U/N9u+GTnuCNj+YM1UFtM2?=
 =?us-ascii?Q?KT38NkH7PhCCzeVKtsThB1zstvMek5FWl3ayRVq/wKi4mWSOo9JD2PR2w2HT?=
 =?us-ascii?Q?uLZzZ9ItOXNv66kmiRuSU77XiBqGM1Uos1IWpgaaChXl7lJFFHltVpX7RhgC?=
 =?us-ascii?Q?cvfOc6Qu6WYVVA39MS58xWnDjWc+vSduJWDmdQDmg2XxyaxOVJ5b8EeAA94s?=
 =?us-ascii?Q?NcU4IreFNQGnltNuVBzr8SdqUQwmiXhiIBLwa8WOFEn5efHP1ic25Qg6qBLT?=
 =?us-ascii?Q?hkRD5D3oKFzs+Nr+wOOWh84+8FQpiLKUiswFwK4IjStgwfLRtqeWJlojlzDB?=
 =?us-ascii?Q?usKUnRVVpz++hs/R/w1L+fnp0nNFGXIHRizFvjm8dOvakY6aOfxfru9CicU6?=
 =?us-ascii?Q?h5nVaNVjKoaBOql1vxMprZsBDTsJf2b5C9u4n5CO6tV9Z1vxv9KbXAhZdkOG?=
 =?us-ascii?Q?wSpTL8NHU/vV2Yxcsqzpl0W6xmN7gDPPojX4vLmvSOVavEXQF3aYEop+pTOl?=
 =?us-ascii?Q?fVgWgeenjRWLA1mbh7kNL815/UyTz3x/T4fjQRAVMnU48PZpITVrMcd4wN8W?=
 =?us-ascii?Q?RKgms4mHxD7p+V520ruf5a++UpgkNnRNUNGCURiYLe+nCMaskDvfgeApK2iY?=
 =?us-ascii?Q?yxs/gIoJv+rAmlvJWG+TbCu99gavJgor0iD/uIiZzhPnj9NbryQYHZUTBMPa?=
 =?us-ascii?Q?3GY8nQvKtGoVGBNKz+6AWuWY2gu1PEcQ2R58Fa74HeSXnjsGlA74+jWgzomG?=
 =?us-ascii?Q?tU4frP3pdrXE+TCILzQA/gqE/gzbIbIrfysTKueYSEFVy3f4JKJRfIo2vOsk?=
 =?us-ascii?Q?gbKvg2duvL6XJQ3yDDFQ0lW0B4axWucxwxsq5xqxx4F00ChabnLa0OZtcCZV?=
 =?us-ascii?Q?FGFyCoCGwKm8HAUkdBgZahNX9pVNz/jqvDjQc3xhb5Xpj0tByj3VhVPsJVRF?=
 =?us-ascii?Q?lH1MR+bBKqffJwVrWBfqKm3w7USvk8keOfY4Y780IkbxDVAzED3CU4l52jZy?=
 =?us-ascii?Q?q9bg6KlUur1XmZbCJI8/nWLHBFQDIDrk1s6BFU5MzQgtPVqMkPST2upFzDOR?=
 =?us-ascii?Q?skqXYvswt1SuVO+hB959c4DbnT/Z8BB3L2uC+sj3QeJpn2kosxY8zS+NA0SM?=
 =?us-ascii?Q?9XJ/jQYoUF/Kv5EzbKuZFryVn0/t81miyOt0yKogdpF5v481QlZTV7q09JjY?=
 =?us-ascii?Q?V6OeMeBS97QouE/X4uWrk5wRudW3bJaw3Y0lN0fKzs/dpMDGaXcqnDF1MhK6?=
 =?us-ascii?Q?cWTL8Y+I/5zf9sgoqxWPls55LHQnO3Z2GkIUT4aSNi+qVrV0yN5O3jFMmbho?=
 =?us-ascii?Q?bhEg0I5b5GlaDsw3IL/0K/PPV683fr9/Cza2fGna9HOEXcsOzHg8Zz2/SYuf?=
 =?us-ascii?Q?zUYkQtuebPV/8JtFWnGrzeBmY6JzGytRi6RqE2noMn8SoGl5ZHzHtjSKx76t?=
 =?us-ascii?Q?11w0Fn1y4yTC76ucE6MDi2ZQoYHI87qTU6MLmy/RBORf2UvY6P/cMKYxOb6x?=
 =?us-ascii?Q?bG5FFTMz7oo5dUjZfXODWM0gmd34ZVyTfzx0+zlmHuNkxs0ve1H9eTW1lm6E?=
 =?us-ascii?Q?O//5eCmlmMoGKdk1Z0rqubNUS4TM2ANUkDFXWRKL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214be829-c2cb-4de8-3208-08db97d1a864
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 05:38:13.6091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGwyb0/4H0TSRsnJc1qtHOueh4NA6xgVhn7WlzYoEeA99VFGz7c1zD40UtfDP/97ZirRY2PC/cirgQmdGA5W/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9864

This patchset addresses #379 and #391, add the abilities to remove id 0
subflow and address for userspace PM. And a selftest.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/391

Geliang Tang (4):
  mptcp: allow creating id 0 subflow
  mptcp: remove id 0 subflow & address
  selftests: mptcp: add id argument for dsf
  selftests: mptcp: remove id 0 subflow & address

 net/mptcp/pm_userspace.c                      | 41 +++++++++++++++----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 +++++++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 33 ++++++++++++++-
 3 files changed, 90 insertions(+), 8 deletions(-)

-- 
2.35.3

