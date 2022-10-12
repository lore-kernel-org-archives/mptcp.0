Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140058.outbound.protection.outlook.com [40.107.14.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426BD17CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:50:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfVTlXGYSMC19PPzOtP72l+tpUR6O0WGBGXvep/EKZmBo+3nKrojzaOJd8N0Q57x1iyQN3nW2yKNmLJaQCcInr+HwCDFhJgGtvDjm8DibwKO5ZKmTUHFLi8ddbzzHhMo0zclk8ttcy2UdrU+nuDK+c2YMZeghdEjiuiGYAKSvTG93nqHBRr2hSVNqhUzNU3G5tjhhm8MwFe8R/sAdGoPitrnbY2g8d936V51feo3iszGd+AQlK4UwClFNKdnJ3CNF90MFFu5fNovPpj70FppnBHqZlyjpkbMtko7OTE/OK8ybEV7Ai+Tt3d5PTfMpTfO5rsW6kM0H4AxQJMPn0MQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aUcKBGL6kQHu95Cv/sTjbCAP82GyJX/o3NiW9u81UM=;
 b=ETMmyHVgGE5qd0Vv+tusGa6WbAME/hG0ZfUBnOm1/mZYmdiB7yjB72FXzblqSOxMGV0JzQ8+bu9LAS8K/ZjJDPFUoRwaJ5Unmn0ZI+sW/v+0kFzHZ/d9Up3ls4eHvu9XPRj7vzXr/er4jJUKdoP/4ZDab89uA14RxL/hwhc4wIvNBV/pnvWRIDaGAEq3V7VqzLeA/21YfwtAznJBPG5enNPeDBYGfD7zQd6VtOJ1CUAC24dds+n2gm1QxNs941bP53IuPYRShuXRw31a85ZxgaMiHc2Sq4xz37aNPa+Q1iDvMihUZfliG4SOShWBFPuZgmrBXngmO2blPvgUNgN6Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aUcKBGL6kQHu95Cv/sTjbCAP82GyJX/o3NiW9u81UM=;
 b=bQa55ZQvyj+/P9gK/2litQCxvIRvTqXmK+9Yd2kvoAv56Q/P7I9wEaZ2TqCJFT0MlsGa47XpjUYX0Seib/4h+um+1R6ojWkXbBGvxzknwKxU4fkzmYYYZXJ3jKTBmLeTSiD9m6/zRP14thN/jshPufzCElP+V9dDmu6mQUQ/y8YN7wvB3C1yNr0giittmR9T0Y6FTp1YueFoe5/Lzqxa7MdP+hvKhS58cLoLo0OxWlEUz41XOkMS8C5MvdSVdVvMgsd+bf+C8oNBkFGXQ0ihwI+t54f9Ua86QcrfKoPDqaAQIIo7JZEYlc2buRdA+AhCntVPhOYA4KrtPYqljYGJWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.40; Wed, 12 Oct
 2022 04:50:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:50:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 00/16] register default scheduler
Date: Wed, 12 Oct 2022 12:50:21 +0800
Message-Id: <cover.1665549881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0182.apcprd06.prod.outlook.com (2603:1096:4:1::14)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eac5245-c4d7-4989-d655-08daac0d51d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xjDo0ChiQBxEEkIdv8N6vWrwrCcsTJl3HodSaFDr8yeiJ7CKIBvi9uovlI9DEo9zsGD1KUDJeHzWQn1lOZe8bIkYo26olX4BwAFePMta0BBig+6ZJEi5FiWzn3KQarg8TGtdW9iqPV6NcZmsycZgb0lnDkZlLT+S5r/yW8Uky17/qvY6b2dZ5O8P/CRLNIOTBr4iIARyk1JCsTfOxaJQqqZJBaFXshFYDA8T3x0X1tSKcWo3disLjeRKBShSjfWgFV810/bW0HH4PIriRrmNxEaYR5N7stLwBiFo+oLJ4jaJKikSOe1r+O7K6yNfnNFpA+bBMo7CgEA+PdzZr1D/tJi9ij9BWK9U3i6JHKDXG/I6G0rHWXGpT0RdCr23O05/lnkaap0rPz+oQZPM4YdjnhANY0UGa7v5VZPdhDuLuKZn7J1+i+FyeBGNbySk//Z6TOWbdNZR2Jg/8shmuKn4JdaxQFSJFN7AEBqWO/n68mih5HM8Qe01yKtSXLFQbaIoyYF3R5GTexHmRQqiU7tLJD9t0osf8GSzzqVM1kNz1FxzOzR5VZX2JTcjFM1Z+kuHW/htYhGf8a+wR7xel6UajGXGTr9eCgL3IWcIXF+0INXJgVJia8L//wXo2N3rLAZragHNYciU3mhp4EtdYZyHH7Ml3hhGk/cvlD5KwT5fN3cHfFY8VEIpMaqX3DmLMbC9MwKL3POj10T3XglKsVSUNwDB6rfwjFtJSzG5FAPc5o2KpaYOaE3FuykKFVo/yywd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199015)(316002)(8936002)(6666004)(6506007)(41300700001)(186003)(38100700002)(83380400001)(107886003)(2906002)(44832011)(6916009)(5660300002)(86362001)(66476007)(478600001)(36756003)(6486002)(4326008)(66946007)(8676002)(66556008)(2616005)(26005)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n9RStrKOZ2f2HSRMohWgAg8rtLWWfgfv0gibauLn3WZrxYCzqTgvSZjlREs+?=
 =?us-ascii?Q?EO11M3A4TH8rTV4d7LjQBTFQcicX2UX1scE8w4iXqdlHUPTzEPcPTt1O7/cz?=
 =?us-ascii?Q?DVFE4f0o+S6cKQ41XZ48CrqxHlvO5RukNxupLrjlzJe8XU5/Z7hHBBpYDWA9?=
 =?us-ascii?Q?yZIaXqpEI0KOlxQvyf0l8eXGJ6ZW4h2oinXSzcY43Nb7wf5AsIoD0aJl2ikI?=
 =?us-ascii?Q?m4DoE0DWn56n1Ft7d+6iMiuIWPBYZ3YktmQzuOOITPcksyYEe6KTDDDf6R2L?=
 =?us-ascii?Q?vvquA5UIuGGOQgphENBEoHsaqpJaCeFNDfsE/iSGTUkWC4+fOQ7pP6uBMFuD?=
 =?us-ascii?Q?kcLCtMGzI9sjcqJ3Tmc+ToRXjfGdfOw1VJCn2ML482XEaKu5zYFk1UWwACGA?=
 =?us-ascii?Q?2wicwIvQEeVVCf+UlAXkWC5AxDPKmcAXJXbnqKecA6zRl69loVmycHkYPV1D?=
 =?us-ascii?Q?uNT6Y+c3SUpsWro97MfyOpUakAKtW8p1vWoBPVAvjdiJCtt0BZruwabz2rWZ?=
 =?us-ascii?Q?E5KiJstvcR7nGdAcEMIz+Pq1PtFo2efRuNJWGcMyRJpgHG6aci8GbOXjNIz0?=
 =?us-ascii?Q?gNQaan+UJbeermBsDUpNUxfwYDI3yBaAWDX33nz4a5SitpB5jPJYbx/d8HHO?=
 =?us-ascii?Q?XfuCJ2+lsuQRELXQlryOmJcdEmmS3ABd+SvcA3hxJcxNmxrV116s09fWmV3J?=
 =?us-ascii?Q?BvvIjOyRqHd1MO5Y7V2iuyXaqN0Bdfejxye+ElvrNZWFZjps0UUAjk14r2RU?=
 =?us-ascii?Q?4AndeT8SO0sOkMLRanvJWNjRMWMo5S1o2B44bJg01rTJ2v1PNajI4aZZCDft?=
 =?us-ascii?Q?qol439BuwAKjUWmfcV9KVG1Blk3hBI+ids/5vcJtjYwl+HWFta9dY6lNuzBF?=
 =?us-ascii?Q?wQGh3pjCf9ggisLhVXiGNFIlbKzeovEcUoBy1cgd8965Xrr9XXsEYmpUyZ9C?=
 =?us-ascii?Q?wwnKSJZdKP2OxRZM9HjgpZJD7pKg6ApMB/Ej7ndnMTQJmzx872pJAan0+Adm?=
 =?us-ascii?Q?Zsd4rBqcSKv0hwZ8asylbf3VA9tto/2VZxRodUb1qM7WtK2b6nrphdAx7Qor?=
 =?us-ascii?Q?kKEGaj7QpxoPjGCPpeE6YvFnCZeKYeznduhQD+gewCu5D1KGBRX7el/c0WuO?=
 =?us-ascii?Q?BoV2e+e5vOon28L9XESu4DO6VCHy+Zsfsp6R44XJlnZQlqhiuZXBaL2HkeTV?=
 =?us-ascii?Q?3zMbyZuBIj1AUcE/FZfONNvShuOZkKg0OUH+GXk2b2eiKDfEPsits/ri3xYX?=
 =?us-ascii?Q?M0nteNIQ77AoMpSyJ7zuJaWVNj5a0emuTVDNE19qAajJO0jej5ldc1IbtutX?=
 =?us-ascii?Q?nw08SkaZdc+0VYOQy4Sul/qVkrn6epz95ut4OOWYHGpUYlNT/j/FrJnCyHqI?=
 =?us-ascii?Q?3nUQeH0wCOWsnRThFI2C1QyHNY/pkid1vDdcMI1P6IsgzERiD7M55T8uYK+S?=
 =?us-ascii?Q?Kh3dG8lfGssfFr1Ik4ZiyWwI7w8spTi+i/n62Z84yl1PcVOSil2ugDoBnXCR?=
 =?us-ascii?Q?LLmmQct0uMt9hdaQxPxUFRSYBLR3NuXE30L6q6noF39GoudNw9z/j/EInYvK?=
 =?us-ascii?Q?bcNVhqzMfJ/5bQZo191iTCMZuWBd9LFQjeWJPbOlEXmU11DvNsOKZT8d+s0y?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eac5245-c4d7-4989-d655-08daac0d51d7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:50:43.5092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWTQBU3DiFqFPFg3IxYORM4H9cJTLaz8Z1GdilUYbir6wDcl9jXDTjvhr0vMQ82j+JWsOf7U5kWD0qb4q6+jEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7020

v2:
- split "mptcp: add mptcp_sched_data argument" into 5 squash-to patches.
- split "mptcp: register default scheduler" into 3 patches.
- depends on "refactor push pending" v7

Register the burst scheduler as the default one.

Geliang Tang (16):
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add get_subflow wrappers" II
  Squash to "mptcp: simplify push_pending"
  Squash to "mptcp: multi subflows push_pending"
  Squash to "mptcp: simplify subflow_push_pending"
  Squash to "mptcp: multi subflows subflow_push_pending"
  Squash to "mptcp: multi subflows retrans support"
  mptcp: use snd_burst of data instead of msk
  mptcp: define default scheduler
  mptcp: register default scheduler
  mptcp: add mptcp_sched_data_set_contexts helper
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
  Squash to "selftests/bpf: Add bpf_first scheduler"
  Squash to "selftests/bpf: Add bpf_bkup scheduler"
  Squash to "selftests/bpf: Add bpf_rr scheduler"

 include/net/mptcp.h                           |  7 +-
 net/mptcp/bpf.c                               |  1 +
 net/mptcp/protocol.c                          | 33 ++++---
 net/mptcp/protocol.h                          | 13 ++-
 net/mptcp/sched.c                             | 92 ++++++++++---------
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  9 +-
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 10 +-
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 10 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 10 +-
 9 files changed, 116 insertions(+), 69 deletions(-)

-- 
2.35.3

