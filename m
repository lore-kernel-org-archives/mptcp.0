Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B4A7C
	for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 11:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3HIvpZyC2T8PeSv6U9F0uzjTHNcZco5W5dNG0uOOnIfViSuGycAPBRVjnHna0lmwttn8UPVRDnxqJ6KowcEmU8+lZY61wtUJ2GzMS5YILajj7xQ9kt7sqIMaXSnuppw4wz0SQ4+ZmlT9gDp3f7QkVjoLmWd80QwFcauspp2DQ8gsTTR9v5PAx/Fr6eL3bDPgqtgo1//9qUBR53I6zWHGZNy7pxE8DbIiDSuCqv+wAoDrCWPemegSOmFYm5LbrJGRNPSqwyzBCQv/jOhj56q1Lluz3z3/9qQ1SARGqJ/wMZTMCqbmHX7B336h1U8IjYtFHebB7OpltGbyIS9+vuE4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+k4VasDEIQ+p++3yA2jwZlrEBm/fegEZ5frDCHZyx+Y=;
 b=ezpb3X58mZO9zz2wwuBfzgN31wbObiP4iJGqXMgDYmsKgUjyAS0qOcjatLrRUPGbNzAAmEBZsK5hXlsOpdiVfEum2rWUNK3aRTNgf6gqQ4qFYveq4XTwf//6dEt3ZcF04rToUNBzSG4JT6jyT0VqqHKO9kyhOReN8V+dEqfda21LiP2CJtSQyVG9IsZZEhFJwcNaAedpdp8edt2dKPMTaYMGRa12QtEERTh+k3XSyOEsB0c5cDIeoXJ2Tk7ndSGxxTWbByV6QBEd8DXW5Tczvuhq8g/VOgJGLfMSiY9DkqFrHOttGtpzVr5VbHknYsDk3etWLAfAx8/DMBOzlwWyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+k4VasDEIQ+p++3yA2jwZlrEBm/fegEZ5frDCHZyx+Y=;
 b=ubDUKLNzBFfcXbwLBnKGGtlcLr+kbfdkZ1C8/rddaOS/N7AlE5XFtlsETRe6oeUrq2PM+KOHagAU6MJnkW2mQMENNnj9kR8smcvYcWcDl2ztyFgReyei2lU3pDlxuDtuG0f422qXhffmG8za5LoVVJt5vPJWSP0i5BvRe0ukVLHdN4iA1qvGWKgFW2Qt1YxrPmhB8LPAaUZSxlGrbfAGFXl/xXEg4v/ZyqvOsvpCXDCGwONQkLs0gbkJPZDKuzqNVEE+BoouJqm+dKVHaD8yKdzQG1Tz97KxsU3nNJyZjxZ3D4WFpfL/hTtuy2lajQWhSeB/T4coms49Pcu8Ayy8yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8430.eurprd04.prod.outlook.com (2603:10a6:10:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Wed, 16 Nov
 2022 11:46:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 11:46:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 0/4] add pm listener events
Date: Wed, 16 Nov 2022 19:46:16 +0800
Message-Id: <cover.1668599064.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 33641fd6-15ab-4242-516c-08dac7c821a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ry12aRQu3f6VmmNRaOj8Zx5Y1b8NHZZQBPYBF9Povid2oTMY/d5vRQUWEdlgzlflvJPRW2j2FMpVaxnlqiYHauOsm/In5nBBT3xEp+HeKfG8Og2t6sMVmex6yDS/qvA37fQJ7GsvjQI4mGbBDwcm3wpQW6NQdKpVDgbQRJigXsT0RvjdZXOfJzLNUR+VBFNqRau3PXw+cslU346wgBnkmtXRIP1FbQoRbsMxo8OLz8EzNaCrotdxl3vgUekWfwJ6gzd5nx/SlZRPAIaX82desQoo0lCbf4HcOQIcg785lkYOdq6uoUJWSCdSI78kuM5Yul7I7Adr1SFnEug9hFyysRt1MEZO/68bAnRG6oupdeV3Ufa4aei0DVhfakeGUB0H3N2eJ2YChXSQrK8Yt/ZQC9wI5lj+4RzshaJnUApUmuOgVlB1n6G6QYSxN/Y+Ozmg5CnHvVlDGDTrscnKy6jJDeP9y2FU31AW+RBEqjYLKWsjxryE1/ediXoZVZ3uK/0aTpXnfRnbYF7SSq6Z2tNrHqhUmRoGSH/FPIbZIRv1Nj7r4J3N6wphSrdzytLHt9VgLk6JqhSmTLMt0QrUwyLxv8GO4w0lcvmflVj71fqM7umvre0HZ9+Ae5/47DX6kODjXRqxupGZVV7Tk5+SeSBWIzQO2xuViRYutofFnCM6Hzvqnlv/dHedhN5jtS0cQzG8/PT6szSHtym/lX7YkAk+CSlpPq212tr50uoTGE+NHZY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199015)(107886003)(478600001)(966005)(6486002)(6916009)(6666004)(83380400001)(8676002)(4326008)(66946007)(26005)(66476007)(66556008)(41300700001)(36756003)(86362001)(6506007)(316002)(38100700002)(186003)(8936002)(5660300002)(44832011)(4744005)(2616005)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I9S4Jya21itoM3OOagb6pHwWkuXICpzhdSRJavvuAyjp6FJKwCKn0orQVgql?=
 =?us-ascii?Q?BlJpoPkez+WMFTwDD0iRPBcWeafnW1eYIZf5s9/9kBCQ7Ww/O9w1j9opK8aE?=
 =?us-ascii?Q?3g+iIaLP/Ziz8wq2OMcje2Ky+MYUU3Dyill4WrRuVsEipOXbMmj3BZGvHk1g?=
 =?us-ascii?Q?qowby5uJwjnuD0YS5DDI3oxkzmhnOxocKB/0nv5UsAP2hniObQrCSw87ywJA?=
 =?us-ascii?Q?/IlhcmzZnCapnxOOAWwSvpk3bw+DF5lSqUKImH/dBnBFnj0EH/Rpot7CsZ3D?=
 =?us-ascii?Q?eM8uLWFHPSkDltUZHMZuFAtJ4ISk7xCGYtDKlXkM6On1M7CYF+byVFKXHkl+?=
 =?us-ascii?Q?AYSojKEFhd3MB9g+SoAM+dGKViR8zIgPary+sE9a6hXMgnxxZQQM0/m53qJ4?=
 =?us-ascii?Q?bNS6g7m/hVLJrMXbPmvjg18b6+Yer/y+gkeCNC6Ag1ka9qQKDpGF042j3yog?=
 =?us-ascii?Q?848eG+Tnh5SKgj3loMghf8/ggKaRecenrn9XvfoZujKJeLXmgTkwmEN0QR3n?=
 =?us-ascii?Q?e3jslJ60u62xCL57W/5iyV/eElv0uM7XLNr0T2xHMUg0WamirzY1m9zuEsBz?=
 =?us-ascii?Q?DjLjZEhke+6+zDd0sIw2EWvAwg8aZxa8ofsqlc2Pn1ob1e+lMoYYosZfcahZ?=
 =?us-ascii?Q?qQQIwSh0gWEV4kBTyl0FpQi5oBLo5yRRryfE2pOLircu/dG8xVb/ijdPm3tF?=
 =?us-ascii?Q?K3FVynVfhKA1gRh+S4idzRxY8JkFIxF2oQXDW8wjJspAHeLGaPh/9n9O3Zni?=
 =?us-ascii?Q?4b46THLPhwRdKdC4+IKsuu0WxJFw4Bx2bXZk8Fpimefq+F0STgUqtxv18dpM?=
 =?us-ascii?Q?yWo0Udnvoe1wPPFkvk+EoE0Fc6oVmqJIYOgMJRK+A2O33h+qD/avrgZ2d4O1?=
 =?us-ascii?Q?SpKqWRHd0bHqimgNnX1D6XJaMywLsLOSBQlmczCNtvPqEPRVMNlS0oHdUnW1?=
 =?us-ascii?Q?7M49JhuZyAfS30QlcsUtRSK8NrJreh/Oxlhxkxzwd1Y1pAnq6FrevCFjCmSA?=
 =?us-ascii?Q?dDfrRpXeOy2MAsEV72KAR9Z3UBxEOLojfegNyeFUJAtxU1O7lkRvnjUh8hvS?=
 =?us-ascii?Q?ME9t4rvakRYig7Q0HvOS6nLX8Uhv1LbEv6pzjiwjN+RUVq4xnxMnVC3UUmjI?=
 =?us-ascii?Q?VExxImbEPLImtyaG3WbYjhlwd4UtoL8pDwEaw/RIRZ8tThOHRPRltuOlfFlT?=
 =?us-ascii?Q?UC8jfHzhol1fdOz5zVZU0xAd/EgRmlnD/rtvktDqgexdn2JDXJkp9fXLVzDA?=
 =?us-ascii?Q?iSgD1w77f2eX3G6q6P3WofI3+tcZ2scdIdb6P1h+AQBlvtElEqrw8ic30eMx?=
 =?us-ascii?Q?ZfHumBZ8LJ22on1G/T0MJb1TP33UhkUS6sQa8HIaJbGXIaCrr6Ruaa0iyYvF?=
 =?us-ascii?Q?ripfXl10Bf/CwOVPzNB4imk8msl+ayvyfPdOEg+hjdG/PcmrRWNyiKYzNTYI?=
 =?us-ascii?Q?0BQOFrvu0fafUUWk6aSiyr44fXTzIAY7h+2bStzqWoo6TV64qAuI1/jRzAX3?=
 =?us-ascii?Q?5rQ61xbXfXBxUpzj4BmAj89dLd9IVq2FazkRLt4yTEdNucrvR1g4uKe8PnlZ?=
 =?us-ascii?Q?Q7fWyVRqu2GyGZXqvBz5sE+FdUM4j0EaYIllAThn3mlbhL2EUAvOg28tmv95?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33641fd6-15ab-4242-516c-08dac7c821a5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 11:45:59.9621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsEbDnKlE/dY7uJzBi/Ef9WYBPpaTWQHM1bJSi1QWM0HYl/ElIatRCOUc/eOEEzvb8K1KZGtLmNl2OS7lIkR4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8430

v4:
- split the selftests into two patches.
- do some cleanups.

v3:
- add selftests.

v2:
- send created event from mptcp_listen.
- add a new patch, use entry->lsk directly.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/313

Geliang Tang (4):
  mptcp: add pm listener events
  selftests: mptcp: update userspace pm tests
  selftests: mptcp: pm_listener tests for userspace_pm
  selftests: mptcp: pm_listener tests for mptcp_join

 include/uapi/linux/mptcp.h                    |  9 ++
 net/mptcp/pm_netlink.c                        | 57 ++++++++++++
 net/mptcp/protocol.c                          |  3 +
 net/mptcp/protocol.h                          |  2 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 75 +++++++++++++++-
 .../selftests/net/mptcp/userspace_pm.sh       | 89 ++++++++++++++++++-
 6 files changed, 231 insertions(+), 4 deletions(-)

-- 
2.35.3

