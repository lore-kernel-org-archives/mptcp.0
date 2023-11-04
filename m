Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D4B7472
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BoF675pR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZBocV1TJ7jrfaXFtyQEuHfTXSp2UCTtjinQFxTttS8BFehvUPDiTYVC9veexrH0EflZIsFps0q9ZsEAFtC/FDnyJYuI4EcsKlK0qRHBZxCx1kZt+hMS1EZqwAOoJ2vD2Sn2vCJavbNzMSXNNgaMAfqnJ3IBLelfXItBsMnmn5UlgX2oQTGcUyAfaR3dR2xKxbgUuMKZVImrJuansVBRrFlG7Ro+XdN2R6o4s/uS4jBx6r6CCiNoZsdvuNT/L5rr90GkbzbYWGXyCM5y50EPuWK7yIZ9/a17VTTgDNniQGCyiZGpEYSbUdPFNbIAgEieen3gNPgObZ/+0DR74Z4uLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gfiDGX8Rd7+ulmQx6wXe/yGOH7XYMgiw13MyNjh100=;
 b=mYtXtVU5jRFvVpopS6eXIubmHW8kk9kXiuXqggNXWnwgbAYb6Cqgib5nHALXucWug6SZaKbHmqVB8hiVrFsCRBoMpoyqeJojDlrDVgagvCIMMd2Fdk7zUa4uEKBxkAyeSLbEqop4lNNGrr7rjtixGgYz68ciWO77e+rVLO2uHu+cUlvDt6TieZaBpcqhIiHzXNUFFEU/4Ju05VCwReo953feWrf7hzse/sU4AqXdtlkEz5K0z+cIRUiUNC1xMOPZTHAs0XJjAdzZtOOPQst6gxuDUgc1O2NiPFIcUQyFg7+VcTz/luqKcU/zvv/UdnqFNhDtnAqaCbegltSl9X2rgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gfiDGX8Rd7+ulmQx6wXe/yGOH7XYMgiw13MyNjh100=;
 b=BoF675pRGZ+jvb3CbTKKP5yXmmP7ua5pVEwqHVLBYbuWwuuDnYu0QE0faeItOYbSBfXLUbfOZ6EWZVmPAr94CzZ4LbL2jf4dUayk1UQMa0m1r7MbFxhAZlTmkm2jKCKNP/z8SXWUkLkuoDm543UbT0fLM/73z8+Px3gEK21DN0DaehW4GR6f0nlhqu+HoDTEewKCMGaef7+5STialpo5/tBugHd6XjNFWd4/LY0XTCxb1KZAOoyabt95gjO11IdfVjH97469fRogDpmjJAZ+2ojwU0leo6TrKFUiC/ysrIzi6Ps+bOgEouA06QL55WjZUzh+NuHaBoxtv76iXofy6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8874.eurprd04.prod.outlook.com (2603:10a6:20b:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 08:37:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:37:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 00/12] add refcount for address entry
Date: Sat,  4 Nov 2023 16:35:48 +0800
Message-Id: <cover.1699086300.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086244.git.geliang.tang@suse.com>
References: <cover.1699086244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ce4fb9-e174-49cf-2963-08dbdd1138df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tYVwwpCJICXUj9v8lTZ42s/AcPTfoE0ksHE2Dnx/cyAgMz3j+EjUro1vjmsayW6QfPhTKxZViObZO03Q8ZQL4NrbF2YRcovKsKLtnJRiF9Y3ky2tH+X83PGKkRHI+wj0XfIYKonQi5MNgZ/XgwpCGUc2Z1CAoxLWnOsNNzazycCdSZwaUA/AoTDIFE+ex2bO1ww4HVLgSiArJpseWpXgfBJNoAmHLvukiLj1sYcIXM/YcocA6p7RjLry4wnDFRIA/6COkbdoRHdioV06aEGDeS7woy6t42jQvWY7XbQbe5Q+KfH5ScHrlqUjt/fO98go7ge8wAbtUiJrUOJJZOeeutAfXVOjFR9sPfGN8kPG4nzvq3+gwXI8ZdCZytL4dX7h+rkrgGfdf1ygmXGZEuphDrlAYY8ZZCU0WgimSEcIpbi4oeJp//iS/olIH8NilDIVi53YFMMaTUU7eQLpR+t/Nxrl++rzrv788ARAnIU2+d41Q2IWixQ4aSraQ64IQU2uXIdfX1lYOHH3lSvNGIKTsBox7pc9m6OXTag1ZeR33tdkC7XyZ49Y/FvhuU6NuV8yL7b/SI+Au11WiP4objoime7cBAlXSkAteFktKFfZEKM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(316002)(86362001)(83380400001)(107886003)(6486002)(8936002)(44832011)(4326008)(478600001)(66476007)(66556008)(41300700001)(66946007)(6916009)(8676002)(36756003)(26005)(5660300002)(2616005)(2906002)(6506007)(6512007)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aP/w74FFF6VxRCy41sGf86cRuCVF4eV+xK4g55nkxa3jNzzAFgpeAWgT/IMz?=
 =?us-ascii?Q?r79FRbZck17LooJo/Hy1CjcN3uKhABHHBEwXMQ2OJhCbd0EBdnGjriE6nJEk?=
 =?us-ascii?Q?dSDu+nu4Xynskh9GUwhmAXRJYbGUqOFL0dHJ1gcZfSsRNDfNMM5zthDPIX7D?=
 =?us-ascii?Q?rI3LuN7+iX+XteT8JcXtEIZP5LUpMEKv02zZGsFKxjR/92yjfkY+ls5YvmKQ?=
 =?us-ascii?Q?zefzJy/v1MUHfwjj2eH4X3rjdeOM3GKAYZp2Lmxy8LkxjCK1kQF9m4yEG4fL?=
 =?us-ascii?Q?GAHM2C5KAkzz7uClozlTI0WbMQHvrbOEVTci7td3yFDHBaSfwSqyC77rSxN7?=
 =?us-ascii?Q?IGklsxarU4dKFVUdAzwgEHKvugTrdxmMG+1IwnInCZdlpO8zz1vdFfrq/JhS?=
 =?us-ascii?Q?1+PPwf03SlyYhlDiN5Nj9+7T2bE43THSpNYaPP0c2BqWPlNfImdSfBm9eZei?=
 =?us-ascii?Q?gcgarjQ8iuLDvVihHzdH3a55xP/BehNSP/qvsAT7OUl3vhzwyJ7PZ/SBYDAW?=
 =?us-ascii?Q?cIX0mfIFCLgu+2X++0FbY0yUEtz8f/HZAiFDDjiJPxOPsWU+k9wcuDskRWyh?=
 =?us-ascii?Q?k7z6rBG/mbyPgy28+G15Ypz3CpzoLrBcsEQC+06YmAQtdiHpOq9aIga/u9Bx?=
 =?us-ascii?Q?Rd3OrNs79dmh/cos5EL3CXALmXz9ptTfqy3fKU2D+FHneyP3IlxGqfgwGe2P?=
 =?us-ascii?Q?9E3Gh8MoFpOf49TSophTROX2J8f/38zWBMxVj0jCH1Rc6TQJjdTR9tUfhfXg?=
 =?us-ascii?Q?D20FVhRimoQ675gOyEsYlsvl7FCXcuLHu06blliIKD3neoPulri8CLQhkcyT?=
 =?us-ascii?Q?F60vdsLKNyCYoAgck094AQlFWyWrDnHRateqJ1Jky9QmPI4+uTnE+4pt/eV2?=
 =?us-ascii?Q?z5mEw9CNn8kEU3/jjQTw+JXuT0I/iYoRs9ciki5nsxUyCwulL2vkeZMOk6eh?=
 =?us-ascii?Q?/9hBXNGuwxHD9Xm9tEmZl1HtFQE14z7y2xkCc8VN+mz+ZsFEx5kyOLPqbeI+?=
 =?us-ascii?Q?AeQ19Fcbz7h2qGrqRkEvauL9EDJRuqHRHcTTp5Nv2bI2tVYORY/XlssRgBEA?=
 =?us-ascii?Q?sTr56nIqQ5E6o9JRU61JnPMRwRX+Ik9x9V5KoLaDVdM6kRlWFTTmRmHnZpoG?=
 =?us-ascii?Q?7AH9awgTMOfKGgeAfxxXSMxe8/NtBjK6o6L051GcmAzWthCrg3W028+r9Z+L?=
 =?us-ascii?Q?MC8WzWTdbCpHs9V9Bt72qSc0cvbYLsdjqZ/88yOmFtLfSGqliWYTaW375QBc?=
 =?us-ascii?Q?D4zeT4J0JKy3a4+0ZxSDVUlo7f0KPb+2JNpWjB+ZK0qOgtUR/Z2nU4h0HHez?=
 =?us-ascii?Q?eAJoWsyiXiVINuxa6IrS58UmAZzyfv63xMNncShwTs1/EtwPP0jXCi3sGf69?=
 =?us-ascii?Q?zIvJ5LKLvi4PYbmha9gOm8ZkhO+snRVICxgXWp/1PjaD0bm0tmOgcazQJbWg?=
 =?us-ascii?Q?maZWB15XGgzNZqFLii0n4YwWJrght12FBtiLdsP86vE5ybdjqvTbFVaIlqMb?=
 =?us-ascii?Q?Fgr5LoWXQS7EZ0IHfNWdY/drKTRAbjn3o/SynenI886DAEyX5JaCiX1qD7C7?=
 =?us-ascii?Q?5jcfNHixgp30xh2a1uq/i0Iss0teXLdI1jLExMFF7yOYpWi6UI3/OUpi7qsv?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ce4fb9-e174-49cf-2963-08dbdd1138df
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:37:04.3366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5mORInKc+qxmnNYDumz9QV54QWCSjhO+sz/pMlrSskntCf1Woe9fxaXuDofUzmlPAvClDt2n0hnGV7+m50r7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8874

v4:
 - move two patches here from "add flush and dump for userspace pm":
  mptcp: add userspace_pm_get_entry helper
  mptcp: drop addr_match and id_match

v3:
 - add four selftests patches:
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: extract mptcp_lib_check_expected
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: add mptcp_lib_init_ns

v2:
 - rebased with "add flush and dump for userspace pm" series.

Add refcount for address entry.

Geliang Tang (12):
  mptcp: add userspace_pm_get_entry helper
  mptcp: dup an entry when removing it
  mptcp: add userspace pm addr entry refcount
  selftests: mptcp: rm userspace addr with random order
  mptcp: add netlink pm addr entry refcount
  mptcp: drop addr_match and id_match
  selftests: mptcp: add mptcp_lib_evts_*
  selftests: mptcp: userspace: print colored results
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: extract mptcp_lib_check_expected
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: add mptcp_lib_init_ns

 net/mptcp/pm_netlink.c                        |  19 +-
 net/mptcp/pm_userspace.c                      |  75 +++++---
 net/mptcp/protocol.h                          |   2 +
 tools/testing/selftests/net/mptcp/diag.sh     |  48 +++--
 .../selftests/net/mptcp/mptcp_connect.sh      |   7 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 129 ++++---------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 162 +++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  16 +-
 .../testing/selftests/net/mptcp/pm_netlink.sh |   4 +-
 .../selftests/net/mptcp/simult_flows.sh       |   6 +-
 .../selftests/net/mptcp/userspace_pm.sh       | 172 +++++-------------
 11 files changed, 341 insertions(+), 299 deletions(-)

-- 
2.35.3

