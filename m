Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2052.outbound.protection.outlook.com [40.107.14.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932BE7B
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 07:55:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2nNs4C0BC6S1YBLqb2UgouD1kaPh6HfcmYRS5iLq29Ez3XIGctUDJ+kysz4PGSSCSAh9lMIL66swBf1jLaoNfDf5bfOylaZKjeuj85YphpQnOwoE4b/w5rgyqGBYRQp+dAYrP5JguusArUuQze9XW2btOvuB4BkYN9edSITj7TMJi/8c75UdkTtOXBO8S0A1eZD36/xG5s9cYr0ccwFHM9jEQncm5hskdBQLN9baqqksQvZjsyj35PzKFZeJj2x1yGvq1SB/9xHJr+wf0Vfm8OsTj9WrcfXnTh2IPCf+ZjN4hHAwC1ysuPqhz6w0d9bEt/kqjc096jdYRovUPBsHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JHnmz+wM3agjHzdacUzowmuCNM01QnNL7NYbNbbY2s=;
 b=B4pM5p9LpS6OWIpbAPgHq69O+epofxBs5r/OcR2CzXhAmtSEDLyNZVPu/HDQHCFfZ7isAnpnYgui3Ieo1+b5dNhrsruj6lyu3hUrhcGXmj2kuaFv4KXWIjE9WJHm1cERNXZdXx86zeY8BNe3LM2Hyyt/nVElttYDI1hSf1Po9MxUDd6E5ccOUFiJV2rjGD0q0gHQfLpa8ohjMX0V+3RdA3EKlQMvMCYFCvC8b74X9u2tNvtSLteT8YU9UL+tgFgfSRHc62ZdU78QXCWt0nA1Z6ri2GzjHfF5VikHuEbdiQu15mUAj471WX+RW+G5hefac9gRE65DwxxFoz7M3a9Llw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JHnmz+wM3agjHzdacUzowmuCNM01QnNL7NYbNbbY2s=;
 b=iTmHEpJWwxS++9F67So8M0lLib1CKbbYqUyRePSpygcWi718QXeIosKF7L6HGdJCd1sqETNR7aWl9jfiwegMTA9PliwRAGgrgMVMU3hxeZ3wdd5oUvtH791DshuaBizSlovbvDkbOAzCqvlI0bXMZrycTiFhzeEHaeg9vIQWPamrHujtvdqyN87O/r4y2+0a8pwW5EsMUeD/vJX99X3KnZ6Uenjqe5NbRJI0PS5sj6IZMI8PFYL0VdZj1FMiS8Tv8TFFl7Ke62ofcpo7sH0d/2H8Zpa6Q4w4STtEYMchRU7dg9SOuMalaWJuXHsx6QvAxSmSREc5mC8ZOCWlGdkJCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Tue, 25 Apr
 2023 07:55:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 07:55:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 0/6] update userspace pm mptcp_info fields, pt 1
Date: Tue, 25 Apr 2023 15:55:05 +0800
Message-Id: <cover.1682409247.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB9366:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f103dc-0713-4aba-17a2-08db45626f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kDpxPXnT57SiFbXVqPszbLEeKuJNA17BTmJzji1lkWQl5qvMSXKaHr1/uNTHK9QxZfYjFdInGaHChOaSLKt1nbuaBpeDzNoqHPEr7ni8MAI1lZ+prSzT/6ZWwlk1xTPESYJTQ/xwJlla8JXCoPbIVsrlyz4OMB0oyJY5onKkXZLGai4d47GNgGTnoUfllTAs56si+xslkH6HXvZiGD43E7AjUvqsEgUL/xWlZnwSj0or1tQyiPEP3Jk5Fh2KwrpR3X2QAXxd7mL4eOMw7sKfsj87PHhrq5c7BWyWHwxaDnK3xUXK+u+nI7O+TeAiSfMC9gOhGanEFdn6yZmaeEKX4mUSx8nHRreXZ9jKNysz+oB7vYMSqH6QgW7WdVlerPj2sHf2NcFkVc5TS51pHHOZApXD4exm6zPTVKozJMVpUuVjxMr2igGUsAhVIUSsRy2P+OhpWhX52QPYfgdx2qyO0uizIs+oFoF8kgn4Unvxi6o1kK3mxpfAjMZbjEC1Wig79V75yEkHWHioJ9gNWbNhUMMQiJ9RrnR/JwNgTInO4yzyN6QNx+ER647W5FYxaRGW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(478600001)(6666004)(38100700002)(6486002)(107886003)(6512007)(26005)(186003)(83380400001)(6506007)(2616005)(5660300002)(8936002)(8676002)(41300700001)(15650500001)(2906002)(4744005)(316002)(44832011)(4326008)(66556008)(66946007)(66476007)(6916009)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l96eJUbpoN9lscb+muxHc7THrqC4YSg24h6N0dwDOk8Xc1w+BMVuiXrk1wD/?=
 =?us-ascii?Q?m6ZNw7rar5RWJWVyIqpPBMrJFUjNCO8PuXzSPZ9tn0k89Rwkm9qchvmr5I8H?=
 =?us-ascii?Q?j0pF17vjmBgS54fk6YTOQo3YstMxMBvMAmDxEWKlgaNiS2BCJrjeJNumwipV?=
 =?us-ascii?Q?SwC1fjaYOG0etIMt48/wITv9zLb/JW+WkNsn1GcuSvCTXa0HM2nBUvSJPnEV?=
 =?us-ascii?Q?PJyDQHXgea82PVZtssinZ5fk2lQJ+FJZ7p6KjO8HyZbC/mTCgaNKbLfMsIya?=
 =?us-ascii?Q?4KshKJpiroYCaR7Ws/TzjdQp3/bwasW0qm8cjcOp4t1tZfstJqxoRVblJApy?=
 =?us-ascii?Q?eTKTARBWZWS92Nzo0SWG/EC1t1ibXDkdiQl2gtZhPaZ1adXfNSNLmLrEVpvN?=
 =?us-ascii?Q?7VlFJPBYngkg6IirP2Oz60x46ygV4gJYEU0SMazMLSlE/rp55sVSptOv7jnu?=
 =?us-ascii?Q?EhLVZdiOVJtHfqvnDbvI9WMASiAqzGPC9lO3MLdK5DaH0u9/nOLEI56/sc/2?=
 =?us-ascii?Q?0VI6aC3OvPQNtBE8W4/5avcsHJ3/0oswEzO0XrgpXzxaTO4h+9pNBOY3yd8/?=
 =?us-ascii?Q?Vfbaw6leMoxuUSsO9uk7LsADa3/SF5DxmndfyQ3nXdZbTL0ThcdZUj8qAaIs?=
 =?us-ascii?Q?BIwTKxn1j1Es0kqBXKJrzGLka+Yu/2EIshiXboaF4OlGT+mXVosPIVbp03Rb?=
 =?us-ascii?Q?ao0OAxY6QDmGJv7xITMJdgjFtmjK5xH0xvKm6SddEFFm3/wZisYvUBE2g6He?=
 =?us-ascii?Q?S6CurE6rbbojRXc9cXAlwHnqubZfsIaU/iIv3wGTWEEYjybLj4DxOJX2GcMl?=
 =?us-ascii?Q?jyaJ04YWbyNPFYr+HzUuqoUOmiBkZaGnGxKsS1flvCnubtN46D6wd49T4tXq?=
 =?us-ascii?Q?C1UAoM5K2FjxRdlWuxl7MQFNW6mhMXHnpE4mxeSTFKzSR4iZGWCqKqMNFNvv?=
 =?us-ascii?Q?aFWahizew8q6xO2w8tkVeiW69MTryzmPraFV3sRsK+NAUQksBNp/+10h7Vw2?=
 =?us-ascii?Q?W9Vk1IZs+zcriXl2WQBCvsWOp3+jYgM4FddhBeCsNlmF35DM/lz0ncOBAqGH?=
 =?us-ascii?Q?FKVvA24HWwpkyNwEbFDUtN6wUzdjZyodVgHgezh+hjN8qY9gv+TXUivV97qk?=
 =?us-ascii?Q?Eu6dcWY7uMV039d7/8WiHWWtaKJ/hu0iH5DGT1qnzLTlRMPKN1dCzs420jcc?=
 =?us-ascii?Q?1hT0l+eE/New6HLalN9ezEYHJYf+TaGgofjKkQ+6I3PVP6EmZbpRnB+3rK5c?=
 =?us-ascii?Q?wF2eRhRI/e8p05Xu2XPKQrF9MNLCvgnkDkbjw9FBrHeOA3a+rGE3oyzZM9zH?=
 =?us-ascii?Q?DT+BB71odr06wuOIaa9/m5Q+VpxNFhLWNsSlVm9Cm4uH5o8THHWcpH3OvwDR?=
 =?us-ascii?Q?ja54qWZ378MokzstDJeOsx+ujWwZuaOIZX4G/bEHX4XQMUqbFZH12Z5Qz+yz?=
 =?us-ascii?Q?FnfHNW5zmvGkq0obxaIkkTTBLMKMSs0HWIjBUkLE6lemsJEjEEvw9K4Jf0vF?=
 =?us-ascii?Q?lQmOkpDZ9b6tRg7YQceydg+jXobvRc5/b2RBwpXElMr3E5kN4Ddb49xKXRym?=
 =?us-ascii?Q?puS4tGr+uHxbmuL2H6Qg07zIdLKTFuajmjPbxoQ5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f103dc-0713-4aba-17a2-08db45626f2a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 07:55:27.9187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWVm7ifl5iU0OLY0VUcFpPQD/0kKttJnvrYFN38aOTPMumJxkMEIUxAU995HhMFrYmubXSrAp2JD38tGrWkgXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9366

v9:
 - address Matt's commets in v8.

v8:
 - address Matt's comments.
 - split into two series, pt 2 will send later.

v7:
 - fix userspace_pm.sh errors reported by CI.
 - only remove addrs in mptcp_nl_cmd_remove().

v6:
 - send a RM ADDR from userspace.

v5:
 - fix a memleak error reported by CI.
 - add more delay for userspace pm tests.

v4:
 - add more patches
 - add selftests

v3:
 - update local_addr_used and add_addr_signaled

v2:
 - hold pm locks

Geliang Tang (6):
  mptcp: only send RM_ADDR in nl_cmd_remove
  selftests: mptcp: update userspace pm addr tests
  mptcp: add addr into userspace pm list
  mptcp: export remove_anno_list_by_saddr
  mptcp: add addr into pm anno_list
  selftests: mptcp: update userspace pm subflow tests

 net/mptcp/pm_netlink.c                        | 24 +++++++++--
 net/mptcp/pm_userspace.c                      | 42 ++++++++++++++++++-
 net/mptcp/protocol.h                          |  3 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++-
 4 files changed, 74 insertions(+), 6 deletions(-)

-- 
2.35.3

