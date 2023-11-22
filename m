Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB4F51035
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aIgOHgwF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvFKSzKWtWbHYM4HWoCfsbfj2u+lLMbEUPa5DnL0JKflyaJWkarifsUqWx/1BPhEd1DMV8JaeHJQCTNhHPNVvqvu5vRlggpOI2trbeekwLBsQYkr8CqAGVb/JxuVFdZqhOQXIGPrDBOB9xvmj9UaJXY26LhK9i3wVF+bjOY2f603fInFKNSY+xLPnBnbgsoLGCCnGAwAmNlusoxlRf2T9khpr/oN4DeEcB608oI7aYtEsPpBTq5cQJXHf8s8PjmUsFadNbLYhWGbADQYaI3VP1h0UNIkX+zqFovor4fEbj+bxo1U+rFztiWZyZVoFg7Bu19+GM4u3X4DWSH7ob7ZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVzkXP+3qcAvTTM57Ky5vcbQ7JsnI6NNAjWs3rB7RJo=;
 b=NPevbatzBRuRy/Q+iFsgexVZvwfuwTLks/EBKVwFz+NIt7e1jm41UJ1ngGBXg85FBdiLJZiXNMkiO3v/CTUYIzVNeWhDJ8nvwLQuXCrWTTFCY5Gs+KwEYmtNhGJa7u6e0WY71t5tjg5qP7JuYEQ6TeOsiOcyy3Ts3LTf4wXbF+O2dRvv6HPJ6i8t/CCSJ8NcnLLoogvfbpxIVQgszoAcSmNQEqNqIbOd/tS9kkBprOSgiudDNNsQHuCjVCs1HR3LYIWk1vAoPbF+Ss+MSB7wVPrSQ9KbS99a0VE6rOT+0I1KmeOjOXHrvZVlfUcd7sEB9lwQmB6ZSbhZC+bQgmleYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVzkXP+3qcAvTTM57Ky5vcbQ7JsnI6NNAjWs3rB7RJo=;
 b=aIgOHgwFQBPOvQEf12WrdijejBgCOdsXhxfMvBQsrsgsl60+HeM8pFv1r8Q8ULvr6pXI8ttr9JC/bEMaiHs//xr1e4OX47zLDyckp+Gk1OkFo2Zv089T66iDJ/WDnT+fQzfTU/nHLZC4r3I5CHlhmy8yAQN3JcA09sqoO5/KOBXxVXCSxicsEDArb2oY1nzhM7CkFvj2mY7EQY8Hdqw0PQm+GneXP6p8mBKAPlANVB0yaTcdUqoNbnN2clrrmkYC2qAFC5J0Nb1bM5vmi8kJ2NhrMEsLTpk3GIe6+6jnLIpzgR2dxsJLxePT+gAWXxfzgiYwe+ZHPpMnrXP+kpm5Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8333.eurprd04.prod.outlook.com (2603:10a6:102:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:31:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:31:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 00/33] add helpers and vars in mptcp_lib.sh
Date: Wed, 22 Nov 2023 19:30:48 +0800
Message-Id: <cover.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0017.jpnprd01.prod.outlook.com (2603:1096:405::29)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 40504bb1-ab15-4a3a-0229-08dbeb4e835c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xeTPE9rwNoErjBl0AN43kAfJATyX9rrDswM7yjeqc6fxsGY0EkOFuuR0OGTyNCruM5G6Zjp71BIlwQ1Zf32Ryvn4QbIna3kyRd7jZ14br12W3KLRzZe/BQ8z+SiF7n8iYr0gxN8t3u0U7t5AFqr/f46FBRma5lGPt8fArKZuoU07EFSUENFrkAlpdUn19QzJxcKg9cgyNk4mLUxD0EJg/wi2VIQa260IapfUp/8GhuT0w36gEdOc5WCMvq2GEA0pBwmoSZInDrEppoCv9kdi0w9MpFRmiVP928PIPPnfwIfcsiPhiromJyOI0HBozx35Y92/wOMLpcZgED6EK6DW0zd4ljS7ptHl9UD0HwTJ5Kv4u0aoI7Z8tKteVtr5tYVNtaBKeD9GqMi3dVzl0C+QrST0awRbtn62kzbMaCkn4CfaVdpz3C7J3wGaENdKUOVRYmnnf5qgibGFI/tTiLwsoCIr7hTtER/PYMMRCnhEzkLyYC9JDIv/1qA0Ql6vId2saOtuRMV9RzKdSpx4f2I8Pl50Fn6axH9al+RsZWgHoB41V0JhjqQomTdGJjnRiajV9cVcIkoCwPA4x0pGW7HgH69zvN5qr76BfDtWk+gepeU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(2616005)(107886003)(26005)(6512007)(6666004)(316002)(6486002)(478600001)(83380400001)(66556008)(6916009)(66946007)(66476007)(44832011)(4326008)(8676002)(5660300002)(38100700002)(86362001)(8936002)(2906002)(41300700001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x0ErufDQqwS/MOmr0ZBRaXW/WqA4mfh0UosW/lZ5joyPWhADglWan8Y0L2xD?=
 =?us-ascii?Q?RHGGzEkcP2RLs3F0C0IiTgKbgsZBhGtCtZF6HnH3sWOoqQLZIGPzXLi5LcKF?=
 =?us-ascii?Q?FWXbfTd4syuvNbx4wuF/HPBpst/wszN8M/qYURHQIaIREMS9sLjtr6BRUT4i?=
 =?us-ascii?Q?hCAAjJv/Rb6njm02Q38Xc7wuePWWfkYABCSIj7T/UMlaQJ+Yf7neEd6D0krL?=
 =?us-ascii?Q?sQ00hHYzxEDYiCmddj8ZpNjTpSB+0HbewI/hWbmGdc08ukVSS+I7HNUMos5B?=
 =?us-ascii?Q?1Vx3+2Uo6ykDB5r42lAYhAIPRwRCyq2NPG0ARthsUgpuwnjei/MqqNdSumNr?=
 =?us-ascii?Q?iWUAXz4cz0SP64xDmei6X93K84IvmEiGprFIDhgngKFRIECT8rAj/d7cEQae?=
 =?us-ascii?Q?VNLGIoEUlQjW+JGOTmsgDTohqSTbgvAYqjB9cv6QGom5Q082znLf6fDCb9o8?=
 =?us-ascii?Q?/3xLOn9l3DpR/b03J/dJQZSjgfcQ1meiXsW5afK3YERupiJ8vSFh1iPTVkqT?=
 =?us-ascii?Q?QuOVOiY4izopMsRGHHoEAgBB7kPfXmMVvSR3pKSRA8K/U5z6RTZa5M7XGX8/?=
 =?us-ascii?Q?OGs/viKxJnSj2D0xp2kHVZ2fT/T6juuqHLEFudl3f5N3ftQMgdgolXR4uWds?=
 =?us-ascii?Q?1d5OVWrq02oNXzS7Y8883W0Dv64McLulqF2+tVZPSoqQz+yPFhFU4i+FsPHn?=
 =?us-ascii?Q?+o9pYQt77hngUVTIGIzkHQ+oT4e7k3YNrAf5RCXfEB00O9NUptQfcccc4bq0?=
 =?us-ascii?Q?Y6iqNufmUOJCKnBTlGRYp6wte2Z2IKWyII8o7LLEsRBgPZMrlfYzHIbUTv+b?=
 =?us-ascii?Q?qWwCGg7ikfvIfRS+lIxp7tLQFiwVL+j4stedRXiOR2S/XvUdSlwGXbiGNFyY?=
 =?us-ascii?Q?pTqeCX5zcuABb7EcgTN/SoPz+NUmz61djHzluAx6HcCsKvvCKGVLBtGA0cbR?=
 =?us-ascii?Q?uEIour+8s/qjjfTA3L7/cS1PxSM4XybE0j7WpzUpaWbmPrR5npgCHRisLOsi?=
 =?us-ascii?Q?01rwWVLM1ovxicPNsU3mU2FIWseljbQjY3PaZaHRlR7CABcMhiDrxbWaVEUY?=
 =?us-ascii?Q?ws6tmf3waRtopDkXC2FzFyocy8h6MLGfzG9ab/HJorHglvTlXXdru1oFDNLX?=
 =?us-ascii?Q?pZLEu0fXSzpsZ5VEbYaEXZlIf6f8bsDX0upuENwivs6vkN6iLrSX8n/zWJ2E?=
 =?us-ascii?Q?YF2RFVpejnonXJXqFQk2Q6Q8lGXcjOJjIBg3rjsfCMXuxHrjKv4lrev7clPB?=
 =?us-ascii?Q?FCdTJtuGqWSwZOaCxSk22I+F4ZEaqAoe532Aq0kKeJcDB3pIzYaRlPwqxNf5?=
 =?us-ascii?Q?+th9vmUWSb17scbDrdyWUYoc/hVfKmGz8T1M685BjN27I1PJs/R7nc3WCvxp?=
 =?us-ascii?Q?tSUHLs1+7MLZ8CfTdvBwwRjz+GYyRoZqobRSuh7wJYz5buoDgwSIYOUYfZUR?=
 =?us-ascii?Q?LaIweuP+vm8GJ+OfSu5v80BgHOUK2OgrHSMDUnrTl5BKHuFfdTe3JCoAkJsS?=
 =?us-ascii?Q?HySZVVuSuc6XPya5Dv609K1P2RwUrP0X+YG0tQctRzPy86N7l47EThjw3xM5?=
 =?us-ascii?Q?EFgf29W3oYU+gCIgSuszk2d8WFRFtvzp+EmIeu+N?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40504bb1-ab15-4a3a-0229-08dbeb4e835c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:31:06.7655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvrZWfz/DTLL+wseOA7SL1xEGinK95boZ8tUwMK07zbZ1GCn3NhB1AXDj2flfnmPmvzZ5Nt508pOVRbPRlQSFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8333

This series includes three parts:

Part 1: add more helpers in mptcp_lib.sh (patches 1-11)
Part 2: print colored output and test counters (patches 12-24)
Part 3: add more vars in mptcp_lib.sh (patches 25-33)

v4:
 - rebased with "userspace pm enhancements" v12

v3:
 - merge squash-to patch for v2:
 Squash to "selftests: mptcp: add mptcp_lib_ns_* helpers"
 - add a new patch:
 selftests: mptcp: simult flows: define missing vars
 - update patches:
 selftests: mptcp: export event macros in mptcp_lib
 selftests: mptcp: export cin/cout/sin/sout vars
 selftests: mptcp: netlink: fix positions of newline
 - update some commit subjects and commit logs.

v2:
 - add more patches.

Geliang Tang (33):
  selftests: mptcp: add mptcp_lib_evts_* helpers
  selftests: mptcp: userspace: capitalize test_name
  selftests: mptcp: userspace: print colored output
  selftests: mptcp: capitalize ok/fail/skip
  selftests: mptcp: netlink: drop duplicate var ret
  selftests: mptcp: export ret into mptcp_lib
  selftests: mptcp: extract mptcp_lib_check_expected
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: unify namespace names
  selftests: mptcp: add mptcp_lib_ns_* helpers
  selftests: mptcp: diag: print colored output
  selftests: mptcp: connect: print colored output
  selftests: mptcp: sockopt: print every test result
  selftests: mptcp: sockopt: print colored output
  selftests: mptcp: simult flows: print colored output
  selftests: mptcp: connect: add PORT instead of TEST_COUNT
  selftests: mptcp: connect: print out test counter
  selftests: mptcp: rename test_cnt to TEST_COUNT
  selftests: mptcp: diag: print out test counter
  selftests: mptcp: simult flows: print out test counter
  selftests: mptcp: sockopt: print out test counter
  selftests: mptcp: netlink: print out test counter
  selftests: mptcp: userspace: print out test counter
  selftests: mptcp: export TEST_NAME/COUNT to mptcp_lib
  selftests: mptcp: simult flows: define missing vars
  selftests: mptcp: export cin/cout/sin/sout vars
  selftests: mptcp: join: change capture/checksum as bool
  selftests: mptcp: export capture/checksum vars
  selftests: mptcp: diag: change timeout_poll to 30
  selftests: mptcp: export timeout_test to mptcp_lib
  selftests: mptcp: use KSFT_SKIP instead ksft_skip
  selftests: mptcp: netlink: fix positions of newline

 tools/testing/selftests/net/mptcp/diag.sh     |  81 +++---
 .../selftests/net/mptcp/mptcp_connect.sh      |  82 +++---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 176 ++++--------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 191 +++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  76 +++--
 .../testing/selftests/net/mptcp/pm_netlink.sh |  96 +++----
 .../selftests/net/mptcp/simult_flows.sh       |  45 +--
 .../selftests/net/mptcp/userspace_pm.sh       | 261 ++++++------------
 8 files changed, 489 insertions(+), 519 deletions(-)

-- 
2.35.3

