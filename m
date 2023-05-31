Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE4EEA4
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 00:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D98dQ8edfgovRwPV6+15ae0o73zCt36c3L62VQbMCgKdV4Qcway4h7FSnrj2UBlbIYZ7w2H+1DXqIhkQgi1qTZDI5rpYOdzQW6CJCsx8w8BLTAMys8DxFHCI50hR5aWBuccBEwcQJZS26OJSnOxdE21w4zUtwizGyz+1258QymuOurHyxeNh8JAcEKXJBO5/ZCvcZFJaRLkowPpkDedvlnKcbjlg01tpPWLt98U+llj93T4kEYsAX9K81RdIdbYEzaHk/ohqBYdHuVF1yIXyWFwyYxVymOfYMvy5ram8f6aiZlxkmQi4eLkuCHyt8WlqfU2GSTifCxRVZCuxZi942g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9d9VtrhuDbNimK/O9MYneNWVU6SyYDTaaJtdkHnMcGc=;
 b=kwTvyIUvK2r8ZlqSYhUu9gP/cRxy3E3M5y5p2GlAemoU2K9QjPbe6OBgsffBjItPhpqqVRFJL1nuOamWE+qSCZDCElBQLzairLskdsvC1DR9E4lixgnO7HPcCzkeVP/VHRIvMik5Yy7zPf3XbUX9eWfiPjf62LAd6IiCSUei43roizI8ZeNiCTO31bDXcGlPsDlhtZ4HezpE5S92FIaM+YlZKeRMlNXTP6Mms+LBC1nx6JLnmYW7/I2p472lVfX6JCLrzgdJfnL4aka2rcrTg3P3jby5iZTOE4XpdzVbRKq4Tm0WM6RcW9EhDJLj25fwiBxEYjbiRmZFkUgmLfmEEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9d9VtrhuDbNimK/O9MYneNWVU6SyYDTaaJtdkHnMcGc=;
 b=qTqetTSao3IKZKohUEv4aDCfybcD8udIOzp9ASqN+GJ4fYhxxqtqK0esq/9me7x/iDRXHwl7BdFXyjJ9YUyUBoc/3DmHSVN6MiocTsOBVrLu9qim7q31TLwdGzMnm2rUfg50bfk+thteyWTFy9BjelQAGHswPa1CnDUJ61i620uogRbdWq+2ePn0G8EHZ5NbkP/O6SJgKi0zATkuknAuQEKlGAMkQdJH6Zk6WHy3wciJBGmjgzQislW6TYeRRAzS6yiZ0Xb9r1ihfx6kuErSll7CkG7Nz1K8i8UPeY1ZBYAenZJdwXExGhMjg+cpAi1vBqpUlgeXUJz73f19yGnihg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7163.eurprd04.prod.outlook.com (2603:10a6:10:fe::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 00:53:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 00:53:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 0/7] update userspace pm mptcp_info fields part 2
Date: Wed, 31 May 2023 08:52:57 +0800
Message-Id: <cover.1685494054.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::36)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c2422b-3926-49d6-3cec-08db61716ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EdFx7uyJcvuMpu1VVim4K4GPnQELQ/zmeuIxzMk6ntn/JCvy3TMimVmpFR45C00FcsddXTguGxbDi8tKsucarCCxj92Nh2aS2U2Yo9hXm+obH28FSagRiyyS0b8VgeX7JaX93rkx/0XRGsetlvN7jPALhvhfei/JeDqxGeM0B/cqBFrhE4oULQaac0nJr2qBKmse3qJYUFp2ti+dlEspanUKS1yJPxLNC3OeQiQJuHUf0QD1uLvjuD6DmMapujPxcnLA6k249AjV74aQf7N0rkO1FHZEHnX3fAy98dn5DP0+5nOdCSx3GtOBVYYbSdhkGSmdW8Hmo+FUt1gN2HGpSEMd9tcpmz6s1GObGD/3S+KkHOYFUK97TeIImBTm0fL1sE43RpzExkkdFjWmzL2ixq7etRTGC8QKTATj8No2betGxoJGWGpJzSTWMUjzZA1TKo8IViJ4IsqJFlJsnpGhkfO3Q1xhUuvrujOdJzOlFguxSHX8xsRXhrLjBi8TeqEb75yFSXp6K8nR4mZznfb+457LNR7PtR41wYBAqNkBpqxZ4R2FFyPDP7jZBejEGK4D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(478600001)(8676002)(44832011)(8936002)(5660300002)(86362001)(36756003)(2906002)(66476007)(4326008)(6916009)(66556008)(66946007)(316002)(38100700002)(41300700001)(2616005)(107886003)(186003)(6506007)(26005)(6486002)(6666004)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/lCm9rgTsgXHws5Ji6EfYlpJfcca7g6nqYyuJSoByat669P34OiBwFvQAkjC?=
 =?us-ascii?Q?DRjqhAX+0Uuc0dDtI7hTbT5JZlKhTFZKplQtuVc5wC9+6Kdv5uMZt1MLg2Td?=
 =?us-ascii?Q?Hqs+rb5WpZgGtXvjJqHMBNbh4hDMVka5BZKxxJN1fzi+5UBQzX8cjU7YpdBC?=
 =?us-ascii?Q?T3NVpgY1ShNWFWmqyvxpj3mQy07eK/VZjXa3wRaBFjOibvSXystRDMMeJgue?=
 =?us-ascii?Q?gVet2IqbVVOZhytIVY3r2qctfHGbjJ0TMSKhrcdbV20lHRls9PxllE9t2QaX?=
 =?us-ascii?Q?iBbjnJZL6hn0pP6XWWiAl1aXslbkfvWZfkh3GJFEZKXIXDQLjQ7MqmzMF+89?=
 =?us-ascii?Q?dAIAIWDK9Y9Debb5cbrNE/DqDYPn6XWCo/cJwvFrIGYlM76eHPDMaCjth04V?=
 =?us-ascii?Q?K3ZrS3MSW4KSONpmQmmoNqc4nJH9hz9tw+admFT32LvipgceQe+1IIuyfMSl?=
 =?us-ascii?Q?b5JHwZIIlVn+qySQDHOyzIF38lGAYgi9OvP0D5Q499lNqQmIQCQOB+VLb9yp?=
 =?us-ascii?Q?aN82OlcmpJ4GdQiyTymj+RonGCjalkNDekaZED7MZP/RNyxleWTDMDD1ynCn?=
 =?us-ascii?Q?IvSBvgra7X0DurMuJI00GjFyNolzkaJZy/KSHzLdM4rhT9Hn0vBHoM7Uos1C?=
 =?us-ascii?Q?GATmYxyAtXELzlK9t3ZFg3Wk4q1KmXizRhjnYo2AoaiV8LFwChtWLR/5pVUJ?=
 =?us-ascii?Q?lCF5xiYpoir/6BfXQsEl0Jls5jQ358VpYHyF4Ekvf0DRpn9Sde+Wj3Py6hCK?=
 =?us-ascii?Q?6+1WZ2gsBlmlMm+cchL/Szg35EgGcO9rPy4M6Cw9SvwVvvb8oit50rJerzhq?=
 =?us-ascii?Q?LDpWH3Ph3RdLYrMQb4+2nCpjrDF2XLrpBENyE1nhCnbslSnFzzJT/AXBQUwG?=
 =?us-ascii?Q?3D3Legp630RKXieIACKCbqOl8AUFco+DMRIvga+RWPPLAxFqvKxsBy9I4dk3?=
 =?us-ascii?Q?YC0OhWABCxJt3aYLFZf1LpT1z7HMbHu5pPYU2P2MLs3Qi61hqc0aytZC23dD?=
 =?us-ascii?Q?Yg8f4k39has2a3UIhMdaKydPjJm3jGZSfgzF+l93t3XReUdN0avIwnGu7afM?=
 =?us-ascii?Q?HVBcceJpPruy8vvi87NBmBPTrVnUqwTlLT/LK6EcZsXn6qyF7n1JQKeDs5px?=
 =?us-ascii?Q?jEKvUT+9CrXKWTtwFe83OXUo5jKbZUzhK+zWKhXLuXw3Ld305aNiMo+KLL0q?=
 =?us-ascii?Q?Ky5NX3keNP45k7ca9SnPmKKjCs+ieuBKOHfqMNaibbUCoy1ezMmn1eLfjmue?=
 =?us-ascii?Q?AKh9/2APDr9tLubFEQSgB6R5OCNkm8E6KlbkjqYvsauFOwC81ZEPh9zw1wgh?=
 =?us-ascii?Q?FtuTo2VYsTq6tQncGrTQoYJQvG1P7swfaMdrolL3P84lEImWu17XYIaKN4rA?=
 =?us-ascii?Q?EtXXSgkAWCbqheMWCa0HKBRLgTnjkGCVulgNwWta5dyBmK4cYRxNxwC4E7ad?=
 =?us-ascii?Q?lBoFHXpIz85XVrFdoT+agSWBzE04mi3gSs6k7qrv8vU8LyQfhkZmegoQqq+H?=
 =?us-ascii?Q?May49NLfgFc/LPLpMTl/PerIMjMj6ZwPwtDilJriXwTftzL1GTci1dS//Rsz?=
 =?us-ascii?Q?M3eCHagsrJwWuBDUe7ny3kRdZBsJ+VObJ3mH1tzO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c2422b-3926-49d6-3cec-08db61716ab4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 00:53:15.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92hYaZfWcmSwsCBT3NaUCM+zhyr4disEDA9rlBmslG2zsqUHRkZxC4Kg5O5dRSgPIBg4LlaCq7e0fBgTDel8cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7163

v14:
 - rebased to "selftests: mptcp: skip tests when features are not supported".
 - patch 1 "selftests: mptcp: skip tests when features are not
   supported, v2, patches 8-37"

v13:
 - fix all the failures the CI is complaining about with the debug kconfig.
 - rename endpoint_manipulation to pm_nl_set_endpoint.

Geliang Tang (6):
  mptcp: pass addr to mptcp_pm_alloc_anno_list
  selftests: mptcp: test userspace pm out of transfer
  selftests: mptcp: check subflows infos
  selftests: mptcp: check add_addr infos
  selftests: mptcp: pass fastclose to sflags
  selftests: mptcp: set endpoint out of transfer

Matthieu Baerts (1):
  selftests: mptcp: skip tests when features are not supported

 net/mptcp/pm_netlink.c                        |    8 +-
 net/mptcp/pm_userspace.c                      |    2 +-
 net/mptcp/protocol.h                          |    2 +-
 tools/testing/selftests/net/mptcp/config      |    1 +
 tools/testing/selftests/net/mptcp/diag.sh     |   42 +-
 .../selftests/net/mptcp/mptcp_connect.sh      |   20 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 1042 ++++++++++-------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |   59 +
 .../selftests/net/mptcp/mptcp_sockopt.c       |   12 +-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   20 +-
 .../testing/selftests/net/mptcp/pm_netlink.sh |   27 +-
 .../selftests/net/mptcp/userspace_pm.sh       |   13 +-
 12 files changed, 786 insertions(+), 462 deletions(-)

-- 
2.35.3

