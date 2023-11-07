Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E121FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GFPUeOpO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBkJzpA5OTKTO/61FVrUVCB6ERMlcPSxtYsMvvJZKkHXpKbmTe3Gxa94tT/hxV1u1zAmrwj8EDrFKguw5kCI62E/b5STs2hZmu+CT6f2pdQ4NOm6NYNUdF4UPHbHSmDEmPs/RKoAoB+IFmrFRZQhJu+ZK86LQkGE7oHeg+tVG0+Twy5CE4jwV/p81WU1yZlmfPoHFv0l/5kf1fpTIiXpF2ZEj28W6FGYa9Nf/hyCIDSlSVY3AZt0Ta/zx1oe5qlWhDzpcbLnKvpBUoY11Xtka/1fNf8J4FnJfo5x61rfPZfo3/YqBxwFNGfNZpmnyfIexzn9ESIXXeO51ouETvb4Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEa3icsJljVSZt88JI3x0G4nwC+dYrPCYUJuunm1rPg=;
 b=ei4eJGo/xggF5ZmGGQnE0512ZXDnTKBVAceS707G0A4Xow/fwayxpetO/T/ifSk8VeToiG1efHbNkGzB0Lef/7vvPAj07VXrL9c5Zi+ePr7zYKOsUKL1G9Ju/IgY/tiacN95B9DkHnFvkT33pz6m2jyq3MM0PWIL9R7MrncGdFuPw1x2VFyqUIWgnlO277W0mfa2j1rpt1T2HvYQLXDZLUrh5jUS1qeOtP2+axEWN6QPmdVLxsS4m7cxQR9EIGqnd4iT2mhHZ8eGcUR6hB5CH8zh0Z+lVNDox8Fjv4CnjNF38XEQBTc8QPtPfXGgbotOAXRqBE5NnDOenVZpS/FARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEa3icsJljVSZt88JI3x0G4nwC+dYrPCYUJuunm1rPg=;
 b=GFPUeOpOGKSNK37KDb41Kd/YQxFi/BHc7QOlR3zzMX9FP+FE/Av4bfZdIu0cDF64OjTrGASgATUwlHayKfngEqbS6kVCLS1toIP9UUiD070Bgl26SVw4UG4B40s3D/dy2Xur1sUosiE2evOd7HD7oGQD9S9Jjm/xfoyrIdhMPjrDFdt0iW1ghj0n/Dlf3aG2XK8wkzZIsu89RD2U/QwHuoOXq6zrayQ9b02Io+dch7H74wrc07+XG4kDQnajke2ox75bqCJCZBmZCBb9xkZfs3AvLZ4JysQ4q3cGoCFuFvNyvZF0oXkqo4woh4n6GVKWEmavXcmC+WArt4HvHGw0Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9669.eurprd04.prod.outlook.com (2603:10a6:10:316::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Tue, 7 Nov
 2023 06:02:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:02:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 00/21] userspace pm enhancements
Date: Tue,  7 Nov 2023 14:01:44 +0800
Message-Id: <cover.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0162.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: d674f329-766f-4981-c911-08dbdf571033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t555Fnxc8jhZGKYA/Nfgti7eHbwolQNvHKn+GG9spETzTfhTKkKJg1LDYckF6OTcSLkKsR30xmagycJpjRgUPSYekTYK1Lskef6XheCZB/dBzOjg1Pp+aCjHONb0lpj4DSPmU//YgqDOPFXfx+uEOMYEEwlOFaxdbIr5iMCs7IXQ9JOYFFPKRlT4EFn7FptA0Ai0A5mE895yhDikkaaN+wQV5D2iWFhxp8udPqAoNc0HtcoK/AT5xu6gP6EwuilxHVQX5HcIrhouWPbb/RA8U7094pdwmTEXy50rfJlXy8JBQlkRuBlAOvYdkRTYC/DLvcBf4hMKFtgaMkIKdxHGctMlsyAEDI2HHlSBBRd44i8Kj+D0Uo02HRGXV3E3w479dBBuKaw9OeGzlvTsHZdzBtocNqlO7YxPL7fAVFbHENXGAocqx/Nk5K+pKmQcFu4b8NbNMI1mOdGabSNmFGBuSMEbOzf7GEZRdGew4L03yyCD3/85NpBoXwMcuM31p2/3F7wmPlL+Yz4EfyKasrU/uw51MBO3Z+kSqbJAX9k31dnElB8mv7BGi76Wb8pVwTyYqqcc7Unrmt/tNe+I4EgPg/s+3PujRayeBmFgrcBblsmydFEEO8hqfN99iCl7LRG7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230273577357003)(230922051799003)(230173577357003)(1800799009)(186009)(451199024)(64100799003)(478600001)(107886003)(41300700001)(6506007)(2616005)(6486002)(6512007)(6666004)(44832011)(316002)(4326008)(8936002)(83380400001)(8676002)(5660300002)(66556008)(6916009)(26005)(66476007)(66946007)(38100700002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9BtYkV0gN65SKacMcbk946Cen+MTQp9s4p3iwp/8mDDGaF8hlM+1SStzn8+o?=
 =?us-ascii?Q?0HZq8GM4DNZSKJAPtPtB3msH9JzHU7u4Dm8mbYYz//s8Pocf9ivKaC9mNPKh?=
 =?us-ascii?Q?WKrMePz/GaZZvIMcozzmyi+TMGZpO6lZSCB/4FST6Q0YClc6m5047gwrSqpJ?=
 =?us-ascii?Q?MJtzKkX/C37jdC9aVvlqz0X6oZbULpssftIthgyQ5NB1TlG6/WNMbv2exVLu?=
 =?us-ascii?Q?KhOMDRk6qD7Gn3S2hRIitDywncCsW9SMrXGluTQkMKGhStJhjMsoy5TXBihT?=
 =?us-ascii?Q?qc/VP87IUga/BPoJ2Ep/v82nict8jd9PqY0mA8MmYLY8OV/laqcGj8OYnhQm?=
 =?us-ascii?Q?QVq3H8s4KwRrymOQzaRfLzu0oKcWG2b+i2vErORz1fCInG1LeN8aSRnBWmDP?=
 =?us-ascii?Q?57JCQnhh15kXJ7DgasZ3Z0j/5uXP7gRFKjXlBRHIpvX9Qt6BoHX++hwuC3kY?=
 =?us-ascii?Q?3Wpd72iqCqeFRcJ9v1NNx9ZIpFceSq5R9DlAFxtOUvl7poz5YHxmGCwYhQok?=
 =?us-ascii?Q?fx4BoJFwwjxPgF4W6DOt/4KgeW5xyO0bbFuDxssrmh6rdNJ1gt+l9j3nnHt1?=
 =?us-ascii?Q?CC0LKUt4U6/JSTKlK0RDbGT5KzkbzmuoYKxtJrDMhVu/1XedexsWaeZJP39V?=
 =?us-ascii?Q?bxnJXnoiWlVnhWNy2V0mKmHm3qXbD1DS8ngvkkZmBBPQDW+e4QlpNtT0wfpc?=
 =?us-ascii?Q?F2CiFXSe2ZujbMZI3bQ0al+O0WExfSCOeXZS+QDgiwr0GdV/MZR80CaU0jHW?=
 =?us-ascii?Q?CWILC+3quLpUecYwXiO/wXKaNt/D7g4WO5DwF7AHxzCN7HeH0E4Xm8Hc21or?=
 =?us-ascii?Q?nPsDmYvB8FBn0NDfuNT+7/CaKk9/YmF8GFJd7YerJBPSwD6xgW/BT1bw9dya?=
 =?us-ascii?Q?Ywywexspp5UyNrbTmn9rH7pDIX5Y+lmuabDxI0W2O223WopaJEIPhBGfu9K0?=
 =?us-ascii?Q?BB62E18gJfGFmrHRtimIQpdmboakMEI09hR6ELCuZEPyrV2omGCeMN5D8Ckb?=
 =?us-ascii?Q?thupGPU+XYHy+17arFjO8BpBKDOTUxEkJJaQu7meRV5YnI4PFYNlgAXyP5yn?=
 =?us-ascii?Q?+FuNy9Ro3aVLRAhzB6DpHkRwDKTFgg3HBCQUkoQpa1RE/94tzzCltAcm1Vs5?=
 =?us-ascii?Q?9JhuqsQsqS+ftIKTr5aZHrvzjnBnL2dNNpnz+1dFscrjnT5V9K5TtJ0Gbgf2?=
 =?us-ascii?Q?8hnXdNsCM7RsaZYmKAVPhBbfTphbg+ciO44O0O/EiV0bUwKMZ0goTTyv7gCY?=
 =?us-ascii?Q?nXcd1+rctBjYXog4RFThEbRHta6/2zDwbK759PiiVwrDhSZU/QaK/bo9pVOA?=
 =?us-ascii?Q?tLbd3/hhQsBdl09v4cdf/DIVVEkAUaZQfwB100nGdfbzU/OSV1KVFEO6gUOZ?=
 =?us-ascii?Q?372yediLZ6BurydX5cwTlP/n3WVIB0J5F3Bi1GX4H8B/+tVgB4gj4Q3UZxbn?=
 =?us-ascii?Q?Y7IExNS4rGkOtepwTKSf4e6f+DxB4/asFCS4di2PvwxO7kjoW4Zd7VPTDT3m?=
 =?us-ascii?Q?M80d2BMgeov1NoPyZl5aZ66xdn0mPsLkONSmbufAVs3l965taDRbpULnqU7Q?=
 =?us-ascii?Q?JlIdUowQTejNnOQ1sYBrc2ZNQtCnWVGkylL5vw+V?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d674f329-766f-4981-c911-08dbdf571033
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:02:03.7959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxKQb6BjQGsqzyEXgKkeZ6H2Z3ZPki/TJT9t7o476t45/KFOOmXzC0LCXu420r1uDGEuMjcF5q3MKjtSvn5Nfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9669

v5:
- Put the two series "add flush and dump for userspace" and 
"add refcount for address entry" together for better CI testing.

Patches 1-12: add flush and dump for userspace

v4:
 - fix the deadlock issue in v3 reported by CI.

v3:
 - fix warnings reported by CI.
 - get id_bitmap using pm_nl_get_pernet_from_msk.

v2:
 - add two patches: "mptcp: check userspace pm subflow flag"
                    "selftests: mptcp: add userspace pm subflow flag"

This series adds flush and dump commands support for userspace pm.

Patches 13-21: add refcount for address entry

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

Geliang Tang (21):
  mptcp: export pm_nl_get_pernet_from_msk
  mptcp: drop mptcp_pm_get_* helpers
  mptcp: use pernet id_bitmap in userspace pm
  mptcp: add a prefix for free_local_addr_list
  mptcp: flush userspace pm addrs list
  mptcp: add userspace_pm_lookup_addr_by_id helper
  mptcp: drop lookup_by_id parameter in lookup_addr
  mptcp: dump userspace pm addrs
  mptcp: check userspace pm subflow flag
  selftests: mptcp: add userspace pm subflow flag
  selftests: mptcp: add mptcp_lib_evts_* helpers
  selftests: mptcp: flush and dump userspace addrs list
  mptcp: add use_id parameter for addresses_equal
  mptcp: add check_id for lookup_anno_list_by_saddr
  mptcp: add userspace_pm_get_entry helper
  mptcp: drop addr_match and id_match
  mptcp: dup an entry when removing it
  mptcp: add userspace pm addr entry refcount
  mptcp: add netlink pm addr entry refcount
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: rm userspace addr with random order

 net/mptcp/pm.c                                |  16 +-
 net/mptcp/pm_netlink.c                        | 148 ++++++--------
 net/mptcp/pm_userspace.c                      | 181 +++++++++++++-----
 net/mptcp/protocol.c                          |   2 +-
 net/mptcp/protocol.h                          |  38 +++-
 net/mptcp/sockopt.c                           |   9 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  83 ++++----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  70 +++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |   8 +
 .../selftests/net/mptcp/userspace_pm.sh       |  91 ++++-----
 10 files changed, 385 insertions(+), 261 deletions(-)

-- 
2.35.3

