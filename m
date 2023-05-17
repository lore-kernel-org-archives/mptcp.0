Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3698933F6
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 22:30:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZe+6VFRv/Qni28/WxrtVoVrOS6836vPExV3IWoJ3UlrMhaAIRp1vIMtRZ6oNTWKVTP/gTGPHGNxqyvIzmmMUcLotIk7eSmVse9rCAjNYvP33TC/dE9iY+q4gzFYLbbbyi37Skm1OZSSabq0h+VdLfsZGOjIJN12nS4GU8sU/7U7ycUEh1Q7OmMTtYAXs9TAUusyS2CgQ4ndF45E+byMOH3Vin8Vgn64SPI9xxLtl1wtl7pvxI4kM/NhLI+7pqnhoaL7zWAlHj71uiN/NQ8ZNrJQoSMWI22Hj9CWR7DetDoahOdjzGRA0n3DLIkg+TKur1bPnu3gYUGVHzEONT/Ziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuCFe1gErKYv+PAx2PukfM+MJVg1SKHptwG/+6T55bY=;
 b=Tb2wl1BvDxSRYZuw0qUbxcePyS+IojUNpxRhwGDmYyN8D6To+Wic9BBZzIvarBejVlgYIWkPPCUFkbN37RHBd3ti0p6LGb8M14cp8/N1iuLBlZXJIDg0C+LYk/6mRXUNLPV6wqR+GygcURR37hOgTJY1wEk9Uo6LiB+unU4eDPJGBHm1UfOmJmHKjoC/Sgib6bbmQsKzghLh1NRn5lVuz9OulRuCgIJxn20H3qs9n/H85MDG4akWmjT3ZsZEIYMUq1NfJO5VvMym+hMUJubdLmMJvby1+3h3Q6arTaFaD/D1TvQsItZeFmsyixNHOTNye+bmOYxB6z5RT3PhYxo62A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuCFe1gErKYv+PAx2PukfM+MJVg1SKHptwG/+6T55bY=;
 b=20IylVjfM4xdOSw35WSYRt+5FfmhL9UjU7zCAe1U+r3YYeAKP5Ti4oMA+VvzSRRUBlKbzUkCmxV1jtYYwZ1e1xrJiJ4WgvMtj8ZaLNtPd1CAKE+SWorFh+BgsnlPKCqOYtJlBRuuryZX3uFgjW0GvcjJYjDxyOYjqEK/BmGceeeEFiKYFIsJ4BgeD+rdFdIC/1vWw62jYjMAqeCjtSBnJDDuAWSwhp28EP0SRDn8u7VIxaCzqFBbRbu8a+H9qWH0EP4zsX51GO1Ms4UWeym+NpIKVOOXwPZo2BUJ5U3Ur4J5kZO57fxoEbEliyJNkZLe+g5nqA8hAvSWQgIbp6PmoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8549.eurprd04.prod.outlook.com (2603:10a6:10:2d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Wed, 17 May
 2023 22:29:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 22:29:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 0/6] run sched tests in a dedicated ns
Date: Thu, 18 May 2023 06:29:36 +0800
Message-Id: <cover.1684362296.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 16979118-1508-4784-16c8-08db57263dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DPM+xUg6ApqyZrM6EVm7HvMiSkYJnpRtI5+QIT9beSM3piznK+omH9WGgNxjxG+5g2BGP2Iu1yg5qHXZ46Ya1MWi5tIogR41mcHrDh7i43y6LQih9o1+NQsaKU3D/iJ/7QsAVrnI22vftis6LjG1UL4V1ZR/W80EtsZ4uQiNrucqv4nk8HLT70KRHU3u3fOgwtB7t9ERyxShuMyxzd+spRJBxj38u9sKZ0easAG0PrYBhIz5+Mw+PSz8359h95fIztDgV7ijMlYARfsoHewdJHs/qSg+ZYZpFrTvkil1vMY5yHX5LnUgQ8NTSkMDkrpQ4zG1K+YfavMRDR9VUXCR94ZsXRZPg+kclBn9TCvczVjSyn79qQf32P31uszsKduXg8acaSph4xoWzJdX1GrKgnb+uxSNbDYyLDg2gvbXl3LWuyX5+8TkQSltGWjPC5TGi2K5aKf+nLy7lspPasN+h/cf59N4hcDdlZPTPZsDZ6Q5fYdKrKo72VhfM5Qxtc/RH5d5dPBqT12pbwkNbDFzQmz+iTfEvOO/ARKHUguGMGIz6w22aT6NUtp9Vcqoa3cp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(86362001)(36756003)(316002)(4326008)(66946007)(66556008)(66476007)(6916009)(478600001)(6666004)(6486002)(44832011)(8936002)(8676002)(5660300002)(41300700001)(4744005)(2906002)(38100700002)(2616005)(6512007)(6506007)(26005)(107886003)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?09FrFzKhB5n+7DdfDVsRscoTL5IpBfFrDVKd2mkoyN1nAdOfN4UErCO3M3Lx?=
 =?us-ascii?Q?aiI7nqzDGT/2VtZgr+XxNj33t1VgqAIY2J6TWjovEC+7IlNcjetWCYp69WK1?=
 =?us-ascii?Q?N97S5VSomx/mA+ZJLa0QC2w3xhVZXzOTQpC2+Qj56chUop4hOnaFjmFKnO6R?=
 =?us-ascii?Q?zR6sLbwAdAbDR2Td+pY0gPKTZsT7vODNBQcru41yPuOcl8KGbaPCd1F2QQwu?=
 =?us-ascii?Q?s+qqXcAja0N1qVZ2zS749gTJ9KDopZVNwGG1jirY+bhEIjYeq6VmQYjrpOCD?=
 =?us-ascii?Q?FZu5wFTVrdL1vXS1P056lX4/cYwEv5Mn0qHVm1xOMJcMHN0QzYB/QctVUFuF?=
 =?us-ascii?Q?ym1B3D3p1doodhspVXB56gCYEPEo+ZdTYLmzHp0SNnlsX21DPNmqDVR+ESkc?=
 =?us-ascii?Q?W51ykypR/6rtgtz+n+Bd0SjXQkphzVufvek0DdKopKAxEZHSL2PSMZDM9Vzf?=
 =?us-ascii?Q?D/lIMxe4yufFddvu+RENmoB8f05t7Qtl3zvAyFhw6XzBP70okIpHWncNmOoV?=
 =?us-ascii?Q?XfmJFxA8K71pVmfFWsJRvGnXw6d0lACTeRXZNXXCc+hnB0FGL3QmsoEgotaQ?=
 =?us-ascii?Q?iC1ZJKC1vAOrr+shv3DcAcYwV5/X3ms993eY9PIYlLXCtIJ8kl8+lIMSTTFD?=
 =?us-ascii?Q?ybV78LfLLN4HgxUxEBLOwiFpQpnAaYAzZ5lqUjDaRpqvk8/44vV0Q8Sy6xaM?=
 =?us-ascii?Q?KBHXXWu5qqDMNVAbwVODpcvFNEr5tn7GK4Y+Bj5JDYMAWrRlH4WF8sYQH1Do?=
 =?us-ascii?Q?Q1YkrmnRu10uyN99HkGnnuZrj6/1zVlJz6qDAQXJcg3qrUPm0RWglRo+rjt/?=
 =?us-ascii?Q?wGACNBQozHWlUfJK/e+u/dTB5V9SBhlgeiM+zw1F0EI2pOwwQOljdf/olIVd?=
 =?us-ascii?Q?8JT61FXXap3hJ7WTgOH2vtQRi7PoR3F5f+EqB7KKOKKOZ262p1H7ZJKW0MH7?=
 =?us-ascii?Q?bcNSPK6hG2xhscQkyGNA7/5EFOg+TsK0UpYHjijmOXCs5okbRR6sHlgZonWz?=
 =?us-ascii?Q?VFw0E+EWaikUc8FCHQ3i59tiRGz5zGXyH0/pHn9+y05oqjOUm9IK5aJ7HsP9?=
 =?us-ascii?Q?/DzW+63yw4PaDtUwrDvl8Sg9IWLGIvW/CPyi1SqQIzh1CGvzVWJLpw+pNg5T?=
 =?us-ascii?Q?l4eSyKb+n7lWd0K+YuCqy1LhL58ZgcUWsrqy1FbZzw+ZCnST2aoCAp0kAcXH?=
 =?us-ascii?Q?qHNG3UDiQapC74cE4obov/UuVVolOSRY5IdJLaMGcCqe3rskLzrc2eqjtuVX?=
 =?us-ascii?Q?Ad3jsQneXfbO4dljMiFHrxBM0ldJdNLXyQPgs57Ei8tUm+iB3DI7+Iwjcbb3?=
 =?us-ascii?Q?sY6yPJYczIdQarCTYTPUDw+KzBmx0a3DrG6eFii+ca6F4fPjquSswwVlvg34?=
 =?us-ascii?Q?6jqgDsqn2gWUg/j6vWJlralOkEMW7CvibqO6rdgHBAoMFyXWoivL48oubw+5?=
 =?us-ascii?Q?hiMF8jpi3lmDceWnrARAhDkCgR8EGS0z8Qbd4E7kQc4LxzQogtVqKN4jBDQ+?=
 =?us-ascii?Q?fuSZnqBWodtPfRtYmKJE+Wi6CteKUZ3xrUfvWoDoCXjNcD/sB2VSUa8cZfn6?=
 =?us-ascii?Q?l3qrdznx+3Kei5BMcd1oWSdOcDZAZikKRbUiV4JV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16979118-1508-4784-16c8-08db57263dfb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 22:29:56.5554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5K0ZvV2kHJXzK7r5F7Me2RX+YYq+UQ14E+RskYJat1kIIjwyKc62AownNlvSAS081aTPUKB+3K2FX07GwOkYuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8549

v4:
 - patch #1 could be merged before "mptcp: refactor push_pending logic"
   as a single fix.
 - patch #2 should be merged between "selftests/bpf: Add mptcp sched
   structs" and "selftests/bpf: Add bpf_first scheduler".

v3:
 - add two helpers.
 - drop sched_cleanup().

Geliang Tang (6):
  selftests/bpf: use random netns name for mptcp
  selftests/bpf: add two mptcp netns helpers
  Squash to "selftests/bpf: Add bpf_first test"
  Squash to "selftests/bpf: Add bpf_bkup test"
  Squash to "selftests/bpf: Add bpf_rr test"
  Squash to "selftests/bpf: Add bpf_red test"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 109 +++++++++++-------
 1 file changed, 68 insertions(+), 41 deletions(-)

-- 
2.35.3

