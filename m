Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2070.outbound.protection.outlook.com [40.107.247.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB6815486
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ciMWf92k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFjc1r/CFcj/Pz02ZdJBYImYj9SyTqEsr7sarMea1EuRrjm1it8DeevO8EqGidLXXv/Y3Nz0jNeD7SwpfuAzX7tT5Wqoyo/znS8gBFLDkwd/HkZVAzG0uFPwfCXBJ9HEM/LgDJC/BniAUPJEC6cZoRroem1lGYtkHBtDaLVcBNaokSzQxxyCcYGN5fRYlVE3w/Z7X07kdYrg8Is4pkSJDo4exIXCNCpklwO3BKKswMLbUw5rTCBQp6ArBGaTUIBemosRiO3EDL9bxgBBNpvvRASriZOvF563GLqVEPcPE8s3QWWkcUFh1HJhZGzMne7c8TBJVh/Old2xnlk9VcALVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/v1Yt463ZhK6D84ho6Yt0l0Hc7qQjTI0gLTYzE8syc=;
 b=c8kIxAqRcVkG72jO2CSMPJyZB4QEptZlfT42pIyriZ1aixPD48LFBdj08nmT0uOuiN5jbHCYKYfllrkwWA9x6yo9ZEB+3NtS325PTfs3rQxnqzUY+37TWfPJXanzga+JryaQhvbB8eNIRb9sdmi094orfoDm7MX9ih4i+sKbk5fqiRbHuNNrhbIE+XeJ/cP4V0+NfdGjfdHaWhArZQJW1Uzll5UYb1mHcCHkqzTJRHoGMbJIXpsy9vlCRkMjQAbdyz8gvAJWM7pg9oVVJxRDwtwzqARxhNJDNqBI99pRdvZivJe9ekEO2bqDKlTZvYGBXrpcnS0rj+kyZqQAs0VMjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/v1Yt463ZhK6D84ho6Yt0l0Hc7qQjTI0gLTYzE8syc=;
 b=ciMWf92kOyY9lCuodV5m4wZ3tVatlVbkf+1PoZ74igQvppbCPMOfIF4Bivj6Zzz2Muj5msg8AxtKrY2AjLlTAaKlnF7s2dbloRrC4cT36CdiBHJ/pOeTIJkK8TgU6O2FL7KnCCNARK3dWDUpRnzEF+iaoQ8A4koXWP7NgGZdhFKx7E6XDY59U6hbS7K71JBJIABm66Nqq6Y7gRaEHsiIPClM6lRXpPzhGjWGbcAfqJl+4v8+Idg7r0hwJEiaNf4Nvmu357emtwrk9a5ZQtxULU0O2h/BxOvE6mvVSXP+RApNbSARY/5tu49nT/DYPsFoVmQYiRaRNExLt5JKIsYtbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6820.eurprd04.prod.outlook.com (2603:10a6:208:188::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Sat, 4 Nov
 2023 14:16:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 14:16:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 00/12] add flush and dump for userspace pm
Date: Sat,  4 Nov 2023 22:16:14 +0800
Message-Id: <cover.1699107275.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 39961045-eb13-4c23-0b21-08dbdd40a968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5dPOXNZo9Xp8TbFMi6b0OdoosObfB1k3E0u/Rg7fSqUgT7eMYuGWLs1/jKA1m4+5f8aBQFdSeT6kIpHRE5mHv+K8Mg0LfkpOtqdAh8RqfZHKCw+VZo3fY9V6FrsauGJRrEHl95jAdcujmBwXWCZeqWV4q55nn+7ML19hWaZhTojNKP1yp9Upcz8OzzWtBsF1pbjRmEA0w3V9jg3EH+0l+NwAz8k1niUBKn1uwYWNg2voz6Pg8LFhjJGJR5NP6lI/jhT3Dl9IfwIsTvmpHxgk0+so62UD+s3hZSyU6H5y+gecCsXW97nU2nQW9bjaIAwoLQ1NXARgrQZpyWTpsnilwsF83RKDJGHyPerONNHZ+EkneOagCIBsRaBm4cmvZpLw20kL/CGF5RrkjJXbZ6hS2TLkQg/T1sGdEfaWOitO0epeItqwWwC+vAW/nI7zlqizdeHMedpFoR7mSruo0xZo/mM6FyXVnhzG1mtQYv30ppmfh7TctXH1lZV6GxZPKMsShSJfEpcHmtKYkimuQhy4dvfO7DpEkdRIk3szhE8dJb87i1Y9ICvXivG2Zk2IeSkYGyGG8TJOyYSHWQoBe0IRfsKrrROVF+k31T6Daxys8m2tkzzOPnYCIyPrN84AgfYVA+3c8bt+oKxdgGM4TuWPgQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799009)(83380400001)(5660300002)(2906002)(6512007)(26005)(38100700002)(2616005)(36756003)(86362001)(41300700001)(6506007)(8936002)(107886003)(6666004)(66476007)(478600001)(4326008)(66556008)(8676002)(6486002)(316002)(6916009)(66946007)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?adCOonXstnMiR9+2jw/880SFDbH/MyV37dPztebsNTpzEg4J+nAd+s7ZNMoc?=
 =?us-ascii?Q?PQ9iyrc8I/qEI4A5dPO73yrEzmJuvK2bOEphEB+dg5xV+bJHTLIG0au/XHKa?=
 =?us-ascii?Q?rO38TWz+Tp3JR8Jb1MJobdQc/TVfRSUGSuZ4fVuG/4jcO5gI8b4lPc0Ql4TO?=
 =?us-ascii?Q?sm9f/cf6DrgoI0BhNEWOuyGrGdALX8yo0ZEAgpQZL9v+qwAk7R2pT46v6I4q?=
 =?us-ascii?Q?rE3DF4y2pSa7XHShnqCw0QsMKv4APdL40VWXHvexoSUm9TuRjB5PKI11SiLc?=
 =?us-ascii?Q?W5gC778b7qMeURcKzJomgXA/pe0Yx0D82kyTWLZOsr2nYHQfIFo3qKYLgGEH?=
 =?us-ascii?Q?eMPFSqda+kw15LqrUiZ2/2mIvTAb7BawhpVq9yBkVS20eEOtpBW8UfKKGz8O?=
 =?us-ascii?Q?vaHY+kTjtko+7sKaiEoO76Eg3RUOyOv+D7jls0DxOOnaJKQPM6bcR1KkHEgK?=
 =?us-ascii?Q?vE/NfkFtoMrD8BwshTGuqxoaBqENQ5UMvFUlxDiIsAzSPSK0h113qte9/gmq?=
 =?us-ascii?Q?mixZ9qEjZDiG6oPWu5yO2mxnno8T7DoMvGLGIuO6EHYyrZtDdz3HwPmL81jK?=
 =?us-ascii?Q?I6f7lsdAF0EpuE90ZrZyzMCDtsVvg/Z7aDhrMSHPS0/pvYSu5BLHbl/Ch9Kl?=
 =?us-ascii?Q?25uUYcm6jcNxtEXNkdi+KXqT+Ydcys9/DoVSacCHx0RpJJf70vfmJBF8Gs8n?=
 =?us-ascii?Q?roD4mEX2G7aHOq/WOqn8L92NvsYwLB6RtL15RMVEWwVX69J0WvQ6aBVxunMr?=
 =?us-ascii?Q?3SOla5tlZ3uX73My4Eo90gMWqOCcykgiG+RBQ22WKcUgI+MCrpVR5a7c3Zfp?=
 =?us-ascii?Q?YMqRCN9s3qCJn1/lnChZgu127l3ZcHgnL4Gx5506laqcP6B3VDi+DFQ8DKBM?=
 =?us-ascii?Q?EfREZXJtUJzJu3/+WBo5R6VXt3BEQJF5cCsUUM0F2DNP8Sbz+G72sfKTJzTC?=
 =?us-ascii?Q?MhyKGqQJkbNbbjxv86/WsGMc3boZ0sxzJo/BASzbjx2Hn+/RsQXLvjFQh6CK?=
 =?us-ascii?Q?uGS68GhsHTCGbZLswAaab/i4OQd1AoBsAr6fFdP/yLq/8VcauoxIAJdSvTTM?=
 =?us-ascii?Q?+PmtwjjsA7v9K6z0+9v/Uz7nVBWD6kxHTwXrry3phvzsTLmRwdRJnK1Q0aQM?=
 =?us-ascii?Q?AhxPuHLnjzlGrSOW3CpLpxv4bL9n+GB5WwC5qeS/I3pDkXoaZsaWJXfK4QCs?=
 =?us-ascii?Q?7GrK9RGCkvEikkbN7z1JB0SvuKtPc0SQu1yshCN0XKfbAj7ngc44TYOjgY7/?=
 =?us-ascii?Q?rUuZhfnkI73LC7Nv3LnemJ+pe0/K9uXcIvN6MjyE4WNWPBH8rgWnE/dGLEii?=
 =?us-ascii?Q?g92e68H80fq5Cd3pMykEVXWozkAjPYHONj3cVTV6efzlyVdze+UxRPP/eeSl?=
 =?us-ascii?Q?hQkAx2GklhJv7/g2F3MzbP+yD1LjGlSHvTe2joNHmZ7tlztJDOuORujbBKm0?=
 =?us-ascii?Q?LLK0qvf/qtWi2+VcDrkNZk/dgDe1cTs2AKqfFeOqgIkuE5lFhVwqyI2EYt9G?=
 =?us-ascii?Q?POzaEDDv15mT91MBZ5yRyLBbwn3KfIEKs5RZr0xnW5RsikcqgUBMSQUC+lkN?=
 =?us-ascii?Q?blNED0/3IuHWZZinp+ZIgDf0/NQYGbZmx/gB2Nxf37XmxuoeyNj7/tpYQIQG?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39961045-eb13-4c23-0b21-08dbdd40a968
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 14:16:39.5168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHnBt61KSxyIAobPFClO57Uzo6oHlIprGByTyrirtHVo63/XtM7ZbUahdfj5g9DAUqB44sPI3Xg/Adz9lgoN5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6820

v4:
 - fix the deadlock issue in v3 reported by CI.

v3:
 - fix warnings reported by CI.
 - get id_bitmap using pm_nl_get_pernet_from_msk.

v2:
 - add two patches: "mptcp: check userspace pm subflow flag"
                    "selftests: mptcp: add userspace pm subflow flag"

This series adds flush and dump commands support for userspace pm.

Geliang Tang (12):
  mptcp: export pm_nl_get_pernet_from_msk
  mptcp: use pernet id_bitmap in userspace pm
  mptcp: rename free_local_addr_list with prefix
  mptcp: flush userspace pm addrs list
  mptcp: lookup_addr_by_id helper in userspace pm
  mptcp: dump userspace pm addrs
  mptcp: check userspace pm subflow flag
  selftests: mptcp: add userspace pm subflow flag
  selftests: mptcp: flush and dump userspace addrs list
  mptcp: drop mptcp_pm_get_* helpers
  mptcp: add addresses_identically_equal helper
  mptcp: drop lookup_by_id parameter in lookup_addr

 net/mptcp/pm.c                                |  14 ++-
 net/mptcp/pm_netlink.c                        | 115 +++++++-----------
 net/mptcp/pm_userspace.c                      | 102 ++++++++++++----
 net/mptcp/protocol.c                          |   2 +-
 net/mptcp/protocol.h                          |  33 +++--
 net/mptcp/sockopt.c                           |   9 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |   5 +
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |   8 ++
 8 files changed, 177 insertions(+), 111 deletions(-)

-- 
2.35.3

