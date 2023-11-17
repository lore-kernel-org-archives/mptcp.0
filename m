Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2079.outbound.protection.outlook.com [40.107.15.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F4D50E
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="nfT9LMF2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1pL40w0H9rxuPPvfWxUgRxbWV+fnhz4CZajjLZIrjDLOi4tQJCvku+1+YM0gakassy31LPxi/3UndCpzWPFroFlPjURbzTT/SwyZuqgrSkFkxU0c74JHKGVD2ZDp+u5poQ5Yf4QVBWryhUeBQOQKBAMDmUzv1nmKcI8EqU9cGzSllnMBjyaisVvVhD4CStSim71x9MlXv7SRHP5geiX58RO5thIqCiMRPnu0Q3dn58rYhdgILB1yPSA93kE2Apt7RfVvJQtv1CHQCaMNeY3a8fZBnHDhWVSvW0bo5HzjzmpMGV6XBV9YhZmmf1RF2X31QpPT1HuM7omEwRXBRjqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPzucahZzrWyTGZzHgtlzDm7ivVVd4BptFf4tWz2Lj0=;
 b=mtD9gEFEnpqgTldS0EFSm7D4zzchK9edlUoKOZPvGKTamDblRUqKakhJt1brfvQXFngILuMqb4LdhNev3Z31pR8kDYxO/7sINfX6RIR6XKqbV7LsC7DDjke2kSpFQmu1bAHzPDIoevion9Fbn4Z256LduVW85hFQtiEHdyJxNv4znHUN/lGzlpqDZOhrAFunsPcbjdfgwgNEtIUoNXqIe4cha94ahFXGy7qB/hlMP2GlSPt6mO1ryvtjdMj+au6ynLlwD0w6dSjmtXGofO4afZhx9T8vYZnMP+ljbquST4s1lm/3jJ8pQwQQgP3q2kqOvOwsiBwRliTVTo9cGcwaGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPzucahZzrWyTGZzHgtlzDm7ivVVd4BptFf4tWz2Lj0=;
 b=nfT9LMF2DZ5C4UzkZP9bY6RkjYkV7SmOgM87GdB1cBnVxPzgluiR+gohz/chMfx8yeFSLycyA3rrBzC+s5Zxs3GilVlrq4VkTj5Bma0390JmcsmXSb27QBn0RS7ip7gJMOVqG7Z8aR5+OoK9+6DQv5a5ASExNS5qZGq4RamFqJ+c7jTMhkyb+Ipor/oGv0Nirk62iXH5D3QYyXbtuSZAldMkT8JvSJW/bgNxCk8x+1YTPNITJ+6Yj0nemeFsuMzwNOVMFn1YM+kYaZL6XLdSX+UTb2pnuvZx6JV/ibx8hQZim8j+Oqq1+yjbNsiygXsKZVVOdNSM9SsC/DOVICADrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7271.eurprd04.prod.outlook.com (2603:10a6:10:1a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8; Fri, 17 Nov
 2023 08:56:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:56:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 00/26] userspace pm enhancements
Date: Fri, 17 Nov 2023 16:55:53 +0800
Message-Id: <cover.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:404:42::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b356fc3-b0c7-428d-a354-08dbe74b080d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	42CjfBDVbTmWOrDB7A4TLvApoMA9JOvJkKe48wSNVvCu4TRgZyV+kliAQs003cQV4+jO3W9TemtvFY7Gg/F5zeYCtfHVc8cFEsW3bd6aYgVVS7ZzKMr4PQFtgIMklPo2WmvWmb3kchCGEnQlqXnCA31SNEY9wKdhYsYtBv1/xulGZYT0rPtsbKdnvmWoHypTAsr9AJ1Pmv8O7weuUoDmkuojsTqorc1eDjcMat8creWup8OmFqUppq1KAKfoL2t/BQF9hdAN0H6dgxDw7+0U9yv6uXonywb86u9sEH0TVfyLZ91Rbm0ha7mwIuWun/N5R+0ApFDXtOCEVrxlsAbDzhmAE4Fz/C98+rzGT55m/7km2ge1Cpok01KrK3R/A+CpjZ1hB5T07l2/lyp75dZbhSJn4c0DtryuMxS0LeHEO7V69zXNc5+KieGhV2xjbwcZQVgNOJB8XVyBbHiu0Udrw4NVkMa0/peoXmtSBxOKNMA+WsuIKbR4Qgv0nX52h/z+pTlaJwFRRH1LM4Z32udcKZqkagCXcyT8zg37LEAfcJHjkzdcVlXEZCOm4XZ2zI9s0LXOP7tQ9TSSu60AYMEd1fGDGX/qhV1WpFkE1XL7YaaAefJOQTonMqOpCLW9Gs1f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230173577357003)(230922051799003)(230273577357003)(451199024)(64100799003)(186009)(1800799009)(86362001)(38100700002)(36756003)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(107886003)(2616005)(6512007)(6486002)(478600001)(6506007)(6666004)(5660300002)(44832011)(2906002)(8676002)(4326008)(8936002)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nVf0nahMz2lIVQw5aqJpLfO6nuaBLRK86tC/P5kQneLFNBZH0jiw7sdhS8NP?=
 =?us-ascii?Q?0ZfdXBF7Po4Bgmok0zTF7H5yXSh/KTKOqdZiFL9tykRv8YwwOy1RBWnfiFX3?=
 =?us-ascii?Q?W+PqPOfpw1XTfZQ0xmAUH/98nhm4VD6Hr5V9p6oL21GZiwhgHuZwH/wP/wxk?=
 =?us-ascii?Q?vaHSDnHNqc48NZiEZHDGhkQyZdo+9RiVkiBYRNYpkCs2/YuQNEHACtJiHVWW?=
 =?us-ascii?Q?fnyIqw9oqFLpAq6iZ5ns6MtF4VHDnWS4Hhs/MhdcY9RgsMzE3VbOLQ9cQ8Nu?=
 =?us-ascii?Q?YBR7vGvWPzhBpPyKKcec1Xja0yVH71ghCKPQXF2AMShTB99j3tKJYY+KOWOi?=
 =?us-ascii?Q?5qKXmo5lM4XkQT7y8+LbNBUridYxk/MR743+Oi/z+QQP46NJ8jM/W1w6tFW2?=
 =?us-ascii?Q?sZKhilGfywe3KnggaMVhemp4ECskiy+9heCHufHbQ3z5zSqQ4bWMjaqViRPB?=
 =?us-ascii?Q?tbdkeqMXtIJlH3Z5/TCycPCuxCSraD2l3OOgYWFcEuEZ3iEPmDZzoDX9Retq?=
 =?us-ascii?Q?AOECoicxzfo6rJZYKjDj44xq7Lpzve7fgZbqDTqPwcHU+iZJ6V5bi3GOwxq2?=
 =?us-ascii?Q?drzgrxa44kyxj04vgZsSprCks1H6LScU8b1ul0xGEXJHVp1TTml3npQcWnIc?=
 =?us-ascii?Q?baSVLSqscVk0s7ldGOrPHdLP2bpi7vvFJ4UmWl7+P/afFbIiSth+kXe4y37M?=
 =?us-ascii?Q?cM+EdIg67PQPATBFoYecsygUHPejLneIWqCaoiPk0uHxKgVx6DKHtVXVu25c?=
 =?us-ascii?Q?S/jx8k5CybHOft/ZjA+DsLbQ57ljxwgYXQtn1jlK6ty2N4IsRgpLCzqxvm5g?=
 =?us-ascii?Q?pFk6pcd3s6qTvn0DCfwYcjfXPL3NX5wf+RgVdy9W1P6AvSN78PIdutwbs0KI?=
 =?us-ascii?Q?Bc4U3gSumdx/1YkKExLFm7b6QFDcSEALREz8jjYoN5W4Jtg+YS290Aq05tLK?=
 =?us-ascii?Q?6WAm8uTteZnQLuPdT4EphrFGgsk8nifiGQmIJtbyIC9elf2FK7m0ohqp+o7w?=
 =?us-ascii?Q?HLwJvde9vLimNpVzIQH61GwKix39GxZm2aUVP0RcOkv/mTPgyFjMQGAi1UQL?=
 =?us-ascii?Q?tkgsSVQU2dtDS7DW7FbOgaPMzd0ZH/A5e+mb6+KkVZ70u9WgRtVY6na+ThRG?=
 =?us-ascii?Q?XlJ6ibeXrHU1T/PhwRS6yhtc45N77ZUwzd/iPkbCBeXChX5sDf0Wr3iED451?=
 =?us-ascii?Q?zjRkXGzgFkJ/+bV7cSeZiD0tW8E/m5VuyH+bRXa9dfs0+Uq7u1iONHiqF+vC?=
 =?us-ascii?Q?i7f3HbDvJN+Z9qrAITGDXCq8GKiOnRcKH7qvRDA3sdlIYnOTCHgvnZJmRW3x?=
 =?us-ascii?Q?DFTBUyn+KtPn9P32usQZYuKpgKrDyCh1iACElOsohFQhgHbEHV5BrlMwewSd?=
 =?us-ascii?Q?bmqG0cSN+zUPn0JILj0r2sRLSr7TJOCBtN3E6s/K+A9Xmdomrv+8prxCBuuh?=
 =?us-ascii?Q?F50IPBWcHKSx6UopUiUsAKpAWdDQ0zvKROtjPr4arZyzfaC294SzeksEaDV5?=
 =?us-ascii?Q?K+1yhSVFpGra8lf4hsHJLNIGFUE9vvN0B+sTZKMJc5wDXn4HPuRgfIaNe0/m?=
 =?us-ascii?Q?uK9t3Vhy+BXrjZPFaunw6ddeFfNv7iageDtmsKUP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b356fc3-b0c7-428d-a354-08dbe74b080d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:56:05.3202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ua6IfsXVSY+hu949ZPkxfzCf4uutFdGb09kTRsHcb/HUs8N8Hz2FXg+GQIMutxxJP5Y4HSrmgirqnCulwephQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7271

v10:

 - add "fixes for creating id 0 subflow" part.

Now this series includes four parts:

Part 1: dump for userspace pm (patches 1-11)
Part 2: fixes for creating id 0 subflow (patches 12-15)
Part 2: flush for userspace pm (patches 16-19)
Part 3: address entry refcount for userspace pm (patches 20-26)

v9:
 - Fix typos reported by CI.
 - Squash two patches
	"selftests: mptcp: pm_netlink: print colored output"
	"selftests: mptcp: add mptcp_lib_check helper"
   into one:
	"selftests: mptcp: add mptcp_lib_check helper"

v8:
 - add mptcp_lib_check helper

v7:
 - merge 'Squash to "mptcp: add use_id parameter for addresses_equal
   v6"', fix packetdrill_add_addr error.
 - fix memleak error in "mptcp: add netlink pm addr entry refcount".
 - split "selftests: mptcp: flush and dump userspace addrs list" into
   two patches.

v6:
 - fix kmemleak errors reported by CI.
 - drop a patch "mptcp: add netlink pm addr entry refcount".

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

Geliang Tang (26):
  mptcp: export pm_nl_get_pernet_from_msk
  mptcp: drop mptcp_pm_get_* helpers
  mptcp: use pernet id_bitmap in userspace pm
  mptcp: add userspace_pm_lookup_addr_by_id helper
  mptcp: drop lookup_by_id parameter in lookup_addr
  mptcp: dump addrs in userspace pm list
  mptcp: check userspace pm subflow flag
  selftests: mptcp: add userspace pm subflow flag
  selftests: mptcp: add mptcp_lib_cleanup
  selftests: mptcp: add mptcp_lib_check helper
  selftests: mptcp: dump userspace addrs list
  mptcp: set set_id flag when parsing addr
  mptcp: use set_id flag when appending addr
  mptcp: check addrs list in userspace_pm_get_local_id
  selftests: mptcp: dump after creating id 0 subflow
  mptcp: add a prefix for free_local_addr_list
  mptcp: remove addrs when freeing userspace pm list
  mptcp: flush userspace pm addrs list
  selftests: mptcp: flush userspace addrs list
  mptcp: add use_id parameter for addresses_equal
  mptcp: add check_id for lookup_anno_list_by_saddr
  mptcp: add userspace_pm_get_entry helper
  mptcp: drop addr_match and id_match
  mptcp: dup an entry when removing it
  mptcp: add userspace pm addr entry refcount
  selftests: mptcp: rm userspace addr with random order

 net/mptcp/pm.c                                |  16 +-
 net/mptcp/pm_netlink.c                        | 168 +++++++--------
 net/mptcp/pm_userspace.c                      | 204 +++++++++++++-----
 net/mptcp/protocol.c                          |   2 +-
 net/mptcp/protocol.h                          |  41 +++-
 net/mptcp/sockopt.c                           |   9 +-
 tools/testing/selftests/net/mptcp/diag.sh     |   1 +
 .../selftests/net/mptcp/mptcp_connect.sh      |   1 +
 .../testing/selftests/net/mptcp/mptcp_join.sh |  67 +++++-
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  32 +++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   1 +
 .../testing/selftests/net/mptcp/pm_netlink.sh |  30 +--
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |   8 +
 .../selftests/net/mptcp/simult_flows.sh       |   1 +
 .../selftests/net/mptcp/userspace_pm.sh       |   1 +
 15 files changed, 384 insertions(+), 198 deletions(-)

-- 
2.35.3

