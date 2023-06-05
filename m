Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85F911C97
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 08:18:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTRvWxYKcQcwGR86cYxzIBX8O3RV45eSbuPek1y6xNymlSd2IXAh6h26mWRo5p15RVkXD4cij8JsTFqKTEkr5ELr+9VvOTu75nkFt2GZNZi8z4O4v4iuDXws+rA21hkSYaMfHs5KvcR7Szs8aQHNwF8Fv6d5/NSwk2QljrLwEBZFRut8HNyAoQaBK/9psEuPNLXUpGuLmsi+oASo0k2QsxTQ+4SrQ6f6iM6dVQhmADCyDEli2r173NWvN0MjAvKuPmc8gtW28lw+5aAJk6JPgxJU958HMUCv33GS5ThpO1HDOGDIM+k3Mwb8fYoTGI0qDoKbjmISz3Uynl2jDD3gPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg1ZArjbcHgLhB6FgIK1l5gCzhHASmTrGayfrlkVzTk=;
 b=QvHEcSay2765vDQhz4BOgKMeQdjD8K3zhOaL3PmxdquLupawnW5qFriG8obJc4HdXHzAe2H1X9jYbtvqDEHmjZC3prmmxBuPz9rhdWrqH8lzaVadaAP+QFsy28dftST0loXlsmwh/7IF47YSwhViUfyynikn8gMehEKiptbC0zwMJRJ7c1GBlHBJuk8JQ8E+vCJdeGTYxVarTNrVmn0gNRNwWaHPK22km64S3oFLh4QPvRSDhTDP1HKR2ZrezWfxv9+lbgxrVjoQp2I37NwBajmXw8t5Ljmwz456tL5qUtPJgrz2wuBlUGegXgwARg/jKu2+3mCT+oeRny8M81TwJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg1ZArjbcHgLhB6FgIK1l5gCzhHASmTrGayfrlkVzTk=;
 b=UZUITLstlAzFCTLDqFFjj1zKvVgLGqISkkc9Pa8Z18hcZDDziqtXhwLuv7dnN65GneHiCchzVUPAdF8s331lMfcjxxtuBEfpsgc2bvG/g/lcXd7W0mp/ci8fnaF7pWwj8vmnqhOjwuJRI74KrnizdJhuPDcBmve5MO43KvJR/D+BEbCJTaTVpUkeaXOOcG2rMSM04T29WgQQv0ykE2nBnWqCigTaR5EppQSMSsKEbNlogaWhmK4dz8Pw8pKldqFIL06W4hxFd7jDJ7hJilJU43kx+zinMT4ADKke0j8y02g85/MJPlBGJ0hvEGD+ddUl++zhc/BHBnRN83541vUpsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8799.eurprd04.prod.outlook.com (2603:10a6:102:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 08:18:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 08:18:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 0/5] update userspace pm mptcp_info fields part 2
Date: Mon,  5 Jun 2023 16:18:03 +0800
Message-Id: <cover.1685952776.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7304e0-b705-4f5d-30c2-08db659d6258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AAmULrYu1cJGs1GuTyyxdU62pJvS9/DSsL+LdD6aN3Uw5ygzC1A7q3BbMw8ndSaIF/aPal4r4oxQDV5eEe5urw/y1GwHZk8LTm8t1KHpZHsI+6P5Rcqj+U5ZeeyeF9l4gDhrKahc3wXqDAB1O8MwPY4Q67N9EMwL/Gr9qcxjHl+KhSuvHZD5oyQQ64OOLAG3v+LfdbJVBulFS9MfsVVPGIVVkUvLaKyUJwK6LY1kr61dnDNY5UCGy95urhiY99P3IuBlklGHpvVZIZHdFuvbyHWhda+64MD5CupFDC/2uats8v6CWwpMTpGauhL4T9aOMrFybpfjIwLEXQt/pNCmZ+SXSaWLsoFPO1YnQ75Bm3hywYTSyQNR0TbUglcXKfFC6eFIiOrWTTHNNapzgP/6GCCpk1z4IYoJ4wHEbnpPxqHnmTCx/cSqtP42T6kEfM0El/BjyPI0q7vCV79vnk1wGmCwTsbPktXDRvo0WbdMGsV01WxgBJhz+MNde5WjLuosv3vMcVAACSxARAf313QNxFLCVMan1+zmch+q2OSN12CxxigolyEsOR9MLefCGfcK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(478600001)(6916009)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(38100700002)(41300700001)(2616005)(186003)(83380400001)(6486002)(107886003)(6512007)(26005)(6506007)(86362001)(44832011)(5660300002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HeIIMnWvk6JYz5nk5LJSLALMWjrBfdwz4Iq3llVWYGe8TzWzfeyJdLuS3rjE?=
 =?us-ascii?Q?DRhzQVS7JZ5dzXyVoaJ8qbBsDjhLDdNju9IRdcJ/SiQqA2YwCib2gfk+1EZP?=
 =?us-ascii?Q?NJ4ssM/tTWEPu+mTBamwTntlWcDBU9glV/LplMXQu7eClL2LchRHWlw5bwEX?=
 =?us-ascii?Q?kZV7QXzCI/2LlFp4Zgs5c4xqH7We1OFVe9NRta9HGaLEgf27V0lLu7d+ptNp?=
 =?us-ascii?Q?MD3GrhGi6rELM13TE27+Oo3HIrmhur2hR2n0kb0oM8cv7wrNdef2jxcSKnLl?=
 =?us-ascii?Q?FrvDSmwwdNTPQPeCdYU8qODgwWCFfrYIHcGRXkbUPQjep4qEQHAHDNKnzE/C?=
 =?us-ascii?Q?D4sI22V+KKbCyz9mw9oXoKrlTuppw2qUSiOELyGlTVhHF2xU3IzUwMnLacIQ?=
 =?us-ascii?Q?yix4SRN1cLwhzxfGJdNSVn9w5DOnEKuo+O/oDiF2fMLZSibWkL9gmSAbLKtf?=
 =?us-ascii?Q?6QiWxLWUG4tbIdwWpqc2wSa8NSzoy/357NyeWJkmEZ7AzH0JqTiibTgAjErq?=
 =?us-ascii?Q?Wk73zWq7bEmvsCrwErX9Z/BwFukE8wYcgPqAWjO+HVveJqemT0EhsTR5POji?=
 =?us-ascii?Q?prnWf4NuYXTa9qgtObiRAhWA7QfWcIucW/a2RSKyHXb3qFxbzG/73BLZCCnQ?=
 =?us-ascii?Q?jDrIVApTXecF6atNLj9nYZi7L6slYBbZjctsBZIG9Xuqsi0pedfkKi65QZlk?=
 =?us-ascii?Q?6dZqUZ63cbAAmNsK5/xpVbcVHaG/VqAhKSW29j3Ow/hk96KRNr7YM1npSX04?=
 =?us-ascii?Q?vOaI8AxfriUBv5TShy0F+IjkNbTMf0AuIk20Uj5SpAKKW2acgA52UftjXnLv?=
 =?us-ascii?Q?OY+djPLFbXDtKt4cPaLY91u+J65EseEHxPIM0XfLZl5e0OHDOjjisArHpjbZ?=
 =?us-ascii?Q?03GL2XvRHEEkLW5mbQoN2tEpyyMi2c/SJAwLC3uMwfQEUwnxg/+5MHWEbSbW?=
 =?us-ascii?Q?augMz/8lvq9bkhKGvuihJIK9yaKY9eUtYGOwyUG4ExCGVDSlYzjE7IUWLSQ/?=
 =?us-ascii?Q?3eXyb51pfq1F+is9RkaolxTfBdT0t2SkoIKB1AEAIQjl6+qGRYH9I1D3QlzS?=
 =?us-ascii?Q?a+LtDyjeEgAq3RVwxzQmWPBY1tDJypV+ZblA2h79LbdpLtQ093NNgqDNiCfP?=
 =?us-ascii?Q?qIdJZLBYKWtUGZ0o267myDPKPlyBzz9/UnhM5p87yPPUdXigTSCpbDT1Bc1y?=
 =?us-ascii?Q?YJ0dLD5NmyJnxJ98/nB/bJBiig0R9eTGES+lxFdIthegHHMQiFsskLTx5G1t?=
 =?us-ascii?Q?pq1fh45B/YLINy12oZkmwTqvJShgjPHo8mE5GSEp7PK1QIupZqNM77loiCHF?=
 =?us-ascii?Q?EqC79SvOAxvqwW30iiVBPKp7t/jDirus2WiBrM7LhHWdYBZM0TZDqUTK5KXK?=
 =?us-ascii?Q?dTeXI+9pM+tmRExgMq5FKF/EOC1IMUkx2EWqqWplFiPQfEp0iEHu/gE4PAX7?=
 =?us-ascii?Q?QfwAhblCHoC+LnI+bPTb7lhxmWzRFX7IXO9cv3ZeNcPMpnChwQ3mX4LfbrcO?=
 =?us-ascii?Q?bRqzBn7A5P+i50rgfViypf09qAUv4Y9ojZLgBm1E8uEy5o4VRsovQKzHQjr1?=
 =?us-ascii?Q?1pyOBSJGW6554VvbM9gGmHAD0wx5KLco4IH31q9s?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7304e0-b705-4f5d-30c2-08db659d6258
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 08:18:03.9700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwB9jDogEta58k9pdRSGo/y2nLeOQeXksLpp8SC03o7VIHpyaxjbgPbOztuBlInAXTjr1ZVibT9I6uHsMdDung==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8799

v16:
 - address Matt's comments in v15.
 - the last two patches in v15 is deponed on "selftests: mptcp: skip
 tests when features are not supported", split them into a new series.
 - this series have no conflect with "selftests: mptcp: skip tests when
 features are not supported" now.

v15:
 - fix the failures reported by CI in v14.

v14:
 - rebased to "selftests: mptcp: skip tests when features are not supported".
 - patch 1 "selftests: mptcp: skip tests when features are not
   supported, v2, patches 8-37"

v13:
 - fix all the failures the CI is complaining about with the debug kconfig.
 - rename endpoint_manipulation to pm_nl_set_endpoint.

Geliang Tang (5):
  mptcp: pass addr to mptcp_pm_alloc_anno_list
  selftests: mptcp: test userspace pm out of transfer
  selftests: mptcp: check subflows infos
  selftests: mptcp: check add_addr infos
  selftests: mptcp: add pm_nl_set_endpoint helper

 net/mptcp/pm_netlink.c                        |   8 +-
 net/mptcp/pm_userspace.c                      |   2 +-
 net/mptcp/protocol.h                          |   2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 410 ++++++++++--------
 4 files changed, 236 insertions(+), 186 deletions(-)

-- 
2.35.3

