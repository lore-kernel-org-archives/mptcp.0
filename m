Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9048475
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="5iNBFzli"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONusf41iPRmGO3EWmJymCw2DOikLx017+L33JGov8/qO02MxHP+l3Q30sN+iel/reHtT/CDxSWc1iPmWXITx2R43ebl7UpZthGwFOGs00F/nYH/TFsRqN36McaVWKYOOtVibmuuK3xmFUz85UKstqQ3a25QjThhF06T/FOe3BrJu1pbg1vGkRLdUzBVNH0GDQKWPvsozagMG4rD2j29NVQopFqPLXiw3/QBtmcRugoepFu1q/ETKIV3VOoDoE22wcQELbEpQzrjrP6OdYt6y3GnR+pFQckXDOjXVCj122UsSR/GMFYsY2j9ZD9pU4Ysi4spDunMcUw2mN64JnWwNLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRB8zxFBU6CbJ520ZhdrXi/aDnTmCf5dRqZ2OF/qh2A=;
 b=BYtzMaFcjxlmgZgllB+SWZZL7fuBTnZFrC3ijyOOrqFGGlbUU/ch+65lxnqiZ3dpbemzb8urr9CnvDP2MBjKJUbQ5HVBcKn6seXFECTPBqwWRS+xMiQIywvfuG3NaVUsndEd2snQFyD4c+dahED9yvLKYuPqK0Ga7GtFjo0TI70x+egA9IiBZOrb5wBasjhoiMg+zxtzLE3wAqdsxZyn8a9qN5sU2npGI7xk6zScvOTpjTJZh/fAFE4SzeUH5RKjg29yjoJEmSKA83XWbdsu3Tk6kW17pfiuy92tAMkgnSSkAtuNLDZ0+ZRoV+aEYkdqn4pxM0WUaG3hN4Ij32+6Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRB8zxFBU6CbJ520ZhdrXi/aDnTmCf5dRqZ2OF/qh2A=;
 b=5iNBFzli4FEUosU/JJfabgawFFQ0uoc9emjoOz5v7Hu4ndP+UL2npRnMJEG9QlJo6L9TkhHNdnR/yID0mbg2FGMbG6MT1C6QDhZ3V8SzH4/TkNRY8PJOPnavL2vR706UOsPnBITIUqjfyiYWcmZ0PcaTerrPxTyM3GJtD61B6qAZHDQNWMnJmPPiZBu/O3QiuGkmC3Ekj8ZkuJcB/LnfqP0WpSJyyQQLafRmz/GE2MnxO4JmTlKwB7s1Y3zkFPV7+MYDZsCetwvmx0cghaCMLdcfe3nHnuNFSiFclQtJR3Ogs0F9U7r2WC4qX0eK33mVdxitzrn6dLZmLvGBWlX9rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10038.eurprd04.prod.outlook.com (2603:10a6:10:4db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Mon, 13 Nov
 2023 02:49:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:48:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 00/22] userspace pm enhancements
Date: Mon, 13 Nov 2023 10:48:44 +0800
Message-Id: <cover.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10038:EE_
X-MS-Office365-Filtering-Correlation-Id: 85997323-de09-44f8-0fac-08dbe3f315de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P7nLPDwMn0N12KxHxvjYtekJ6S/vC1RuGwUwnsaOI1+EB71IvjIJ80dF6qMw/U2PPzHUnZZOXalx6WUksdUTBmcCMcrgVL7Sf49LFzVZDoapOhm56pSZdaSCGNwPbYk+Ulm0dXCbuKSrkyIB04YWthyXCLAOanSpa6lq3kjtBd2qYHXIwfZtq190CnWbRPg5WrQ5R5YJjzcrEZhfTbWTz2NFpCnqj8Q39+tKnxrMP9nwbT++/rSrMimChfFiu3Te6th54+pw5wHwlmLrEcSuUO9y9WjxsahGxWPS+KWPVHIXvnsXSCjgaB01OEL6N3EEVL45LP3hvwtm0jBdz1C7Bnq9ZcVQTjTuBfIdOw2a5PaVXiywCgtBjXcUfZBXQF76QaLgKWdku8pSKVFG7b9a9cCmrwyl2KYVlZQsS+OvPX9yjfalxOFIXWND7tYHq2E/40j17KmDwCVfDCaolWp0U5npVTZIE4YO1hxVDxkWfwpydtdHaylUyFYs3dppEgImgxtDGAYXAo13S7QivL38W9iJ49T/CK6jk+I9AJoQV5C31nKqzHY3NkNhbDHFdE1a+a+D3vQpN6vNOXwfNUXn2nL5lZp41hdes0++WuS/Be+lToTDUc3zdmYVYO466dnN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230173577357003)(230922051799003)(230273577357003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(41300700001)(38100700002)(36756003)(6666004)(86362001)(2616005)(107886003)(478600001)(26005)(6506007)(6512007)(6486002)(83380400001)(4326008)(8676002)(8936002)(44832011)(6916009)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5V2NF8+WWpTJiX5Do1bVaCLNVRiNkKbFii3OOMQrPITb6ty5gi7ndCl9tOEu?=
 =?us-ascii?Q?00S4ODb7/L2oxW1fCNqCYHRvL2+lRe6glDsLSgbrtvbRtMWY/isFHWSKBM6m?=
 =?us-ascii?Q?GdFWuZ+o79RwuqOsfUW0daogGL3UeiPbiRF5PzmxQrlHBdxEoqXC4r2TvfJw?=
 =?us-ascii?Q?2MNXjG7I1Hn6scn55KQdQt9CRl9Ttj+LLgR3TnME/X+9Z3hyEHjaCWaGX5Tf?=
 =?us-ascii?Q?UMwGLMSuuHDjm8ZtGjef2w5EpE4BMs+nkReIdJDuplo6VjFWaAmUMMPeip7B?=
 =?us-ascii?Q?734nrmqWjyj7ItTcn8qoEvnJB92He9SQr7z6lE33GtRWcgFES7XqQFFRmm/j?=
 =?us-ascii?Q?nEM3U1vnJlUU5Uc3NQI1OHHGpkkGvCYzdtT6s8lS7oQ2HkUH1UB/R+Ik2l3k?=
 =?us-ascii?Q?QeCXlJTatoGhp3fSda2W+GQZS8kiQx8k4Xf5BdY6jbbAPgIv9Kq3fk32E4Q1?=
 =?us-ascii?Q?EIzmAuzJ16EgDxZNI9gwdj90YFsmUqTzgiWw+cKiQqpRItNfosSW8zIi4Rv5?=
 =?us-ascii?Q?AHmz9q7HcVTCSQkdHxuV1TnTwJw/0uetYuiUNBZUC9TAxKaj3RaJo5Z1VcOt?=
 =?us-ascii?Q?PEP21cUJ/EAHbjSAyLQGSZ3EoRV9BOeJ+8VyRaZzvZbesD/co8BKsgjzgTX1?=
 =?us-ascii?Q?mlYCrADxWjCZrwKA4mVlPGnN5q1+fcz1gsu33yRLRwYxHJmkoH2bQ76pAA+W?=
 =?us-ascii?Q?uV9C4V0QBysukEExR2znSWJ01ubpWVSrkT1XtlabPErtvqzchG73eRoo2+mR?=
 =?us-ascii?Q?zQjIgFLTSeXxXywLUNfWS+RAhNQVEOJHTe4CIwISxkQ9wjisvetnoLSgkxRq?=
 =?us-ascii?Q?YZK7nVzRyzin1N++UL+/LM/LYkGDGQ9TmM0bf2atKkqJ7ElNqvFkTau8VkBr?=
 =?us-ascii?Q?g0cGv3AOXb9vu5oDtUdvj+SCXujXYUUqWZ/zviF92BBH2CK8p7Jaov76rWE7?=
 =?us-ascii?Q?5JmrbR14TKURIxX4cAitFG3uiQkHSHqWAE5HK5IYSgGBBKDZTACG8chq5e+r?=
 =?us-ascii?Q?0rqZovGqolbu8k+HN41iHTKJR12VcqW7vlMWe3TJlgitB7Cv3ZmGgflaCcLL?=
 =?us-ascii?Q?7GUI4Qpmwj/5xF2JmSaTHySj6b/zWxTl1hbmk/nYzkuWNidRb4G4CDrwP+ye?=
 =?us-ascii?Q?SczQLVXCUdcc1nqCFEW6xsbnpiM1nzZL7c2JbWrEX1m06BbVPcCcr+GgzRJf?=
 =?us-ascii?Q?ZAgSOTGhyXzNLX9hvICbXMMIX7XpgiWNUwW8M0mCMI33c8d7th9rtGrwPtwd?=
 =?us-ascii?Q?rRyKAWgTPtYIxU/UHmCr0/r+XAGYruC3JL6kD5ynOC/FzNGCHWI7IMeGmaCn?=
 =?us-ascii?Q?KZPsJTzu8KH0Zu7rZBVvqiCtEkj1pAixLbx2fXQ/PUCEXE0HtERcsbqn+H69?=
 =?us-ascii?Q?wSinl+o1ETOwwvAt5gDxgiYcGGD1yJtFc2hk5DDuy+EbC1aiV6tLjgT07h/b?=
 =?us-ascii?Q?MuNpaKyI6KlditDTv2Rd1LPyEHaMzplEh5eNqlQFZpDhC/GNVvIQI5uQWmzS?=
 =?us-ascii?Q?wWE8zLkQRvZ/hDG9E2HwJ1nndTr6MDAkUSqh6PHaL9k57ns0X1dJj5afDZOy?=
 =?us-ascii?Q?rxwpOH07Jeex18R9jZSFq9uiUGOT+WA8sojhwiks?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85997323-de09-44f8-0fac-08dbe3f315de
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:48:59.2173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MZOBe3px3v246aM7Tf2absoMaXEcJqt6Q2hQpdFNhH8QnhTY6IQgCSYBSprY97rcuMZmjZGh4VQm3dzLH+RTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10038

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

Geliang Tang (22):
  mptcp: export pm_nl_get_pernet_from_msk
  mptcp: drop mptcp_pm_get_* helpers
  mptcp: use pernet id_bitmap in userspace pm
  mptcp: add userspace_pm_lookup_addr_by_id helper
  mptcp: drop lookup_by_id parameter in lookup_addr
  mptcp: dump addrs in userspace pm list
  mptcp: check userspace pm subflow flag
  selftests: mptcp: add userspace pm subflow flag
  selftests: mptcp: pm_netlink: print colored output
  selftests: mptcp: add mptcp_lib_cleanup
  selftests: mptcp: add mptcp_lib_check helper
  selftests: mptcp: dump userspace addrs list
  mptcp: add a prefix for free_local_addr_list
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
 net/mptcp/pm_netlink.c                        | 131 +++++--------
 net/mptcp/pm_userspace.c                      | 181 +++++++++++++-----
 net/mptcp/protocol.c                          |   2 +-
 net/mptcp/protocol.h                          |  38 +++-
 net/mptcp/sockopt.c                           |   9 +-
 tools/testing/selftests/net/mptcp/diag.sh     |   1 +
 .../selftests/net/mptcp/mptcp_connect.sh      |   1 +
 .../testing/selftests/net/mptcp/mptcp_join.sh |  18 +-
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  32 ++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   1 +
 .../testing/selftests/net/mptcp/pm_netlink.sh |  30 +--
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |   8 +
 .../selftests/net/mptcp/simult_flows.sh       |   1 +
 .../selftests/net/mptcp/userspace_pm.sh       |   1 +
 15 files changed, 295 insertions(+), 175 deletions(-)

-- 
2.35.3

