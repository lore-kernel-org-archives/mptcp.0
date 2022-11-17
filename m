Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00189EB0E
	for <mptcp@lists.linux.dev>; Thu, 17 Nov 2022 05:31:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqzxPStEBY/GChu6oiX4BwDHEHCuMtrbDQjtdnMre6VVGP0QmuEenfm5G6RiWB6A6zL4qTrDv93wRE1YQ14KzhzLKWjDvvKGUEENNejfmhG8mBw+ZYL3ZhW/qsI40HOZJBuDfaeR5v2iCACTgqZphwOdpqAKgN/ziAgLASNNDDK4TMrybGhY7y65Koaom/HCmCpulJt3YYpF3YGqf2xLKn+G8VSpqB7mypWCHVSgbU89JSzTVs+RHowyvt9DU7jnUnE+DTAlwgr67sk5XSZhFjIdbuAC0qHVBfc9x0JacNOfjeb0UhrZBLQtJKNMAjMU1kzIx2BEwibvXC1RbuQkDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+pH+Z8HymqUGLXc/bkuxNUhUaSmDZ/VBuEkfdOTdLU=;
 b=Zrx1c2wqmdbhbMEAHlYv63Rbap+qp0U/pmTmuFgXkW17oEYVaqEjrSjgEyKEaDjGWPM9OhdUgKqkz0dtUMGeLm+6cSjb/0s0Vf7QIIB7GMhcCYKI7LMxtuonZM8sFrYVna67jHPXM7LdDec7s5aszETEKGK50b4s/WI1DpsGc7hlQooRpvXQO2SxFdQunz7oKNg/hIdw+tD7yRaPSMRCn/iFfPJZx17Zgy36qR3SVzL6Tm7ZGqdEo/Pq6DaGisPYZylMtrprGfm8W+3lvEyl5oqo60s9yEseOFGjNssRxJpUGC6HkCrEEYRWLVOE1oOVdWFLzym66c+v4MJI4lpUfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+pH+Z8HymqUGLXc/bkuxNUhUaSmDZ/VBuEkfdOTdLU=;
 b=3H3lwxomsdp/PjzGIBZDMMwCzUxdJD5XpPr0/N5+i4xye8hfuaWeiWjEE9yq2jX6IIbwpVTI0fQYShDIwkZshjoP2HH//H1nWfWa2cSHFaG86G4Zb69mHFhrjHEVxOC0pYyjGU00AArM961qUifqGwZm9xZ6GEu3UV7v5tXeaNB3cIRGMqR3u5tSblXkXo/9PnOHWY4pNjHxp0SynJCDRo+pAl7aUeNCaFiKsQ+dCmjBw3ofUDO/L/sF5AQI4m7oqbM7iW+Nv85BCiOuro03wusQEcmwP8EccRcLjuNinCnwj2GoY3rqIO/rsZMes5miQ/MnzSNXA7Bw9qhaOjDXlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8620.eurprd04.prod.outlook.com (2603:10a6:20b:43b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15; Thu, 17 Nov
 2022 05:31:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Thu, 17 Nov 2022
 05:31:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 0/4] add pm listener events
Date: Thu, 17 Nov 2022 13:31:30 +0800
Message-Id: <cover.1668662624.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8620:EE_
X-MS-Office365-Filtering-Correlation-Id: 990bf4d4-f173-4bf9-b419-08dac85cee7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q/ABKpvJACDVOSPof9wis7gbZWhHb+Kujv2P9AH22UuW33vXjsBsY45wIkQZFlM/H847/bDwpIzeYBYmCzV4TsdUg1ZB11HxslxDyArAhuXFPZhxJ09mIFeikBjUikPk3MlV/xgN+yyjLOLc3s7zZjIh/KzzFevXjq34Bevo1VlsBzbm4sgDPC27viWgfLB1yvYQ4KbPjOiJiYlpVwymH72WMZ/k/KlD3VfUFKbYSP7HyNZBqr3JXlmFWZ0wqOnINpq89IH7vvxBbNjqmHraoCLDrMYp1TlX1XZtAZTjh7H5gqGGQ/kJlV2GvXZz2szRtczPUfFPWX0vBG2MNgvqcnXIkSXHFJS3TlF2F8mmRhFcq6SOPNaAg+wrHL97HFvb7iIQ45C0MqkIzgL91fL3jaqxGwzcs4PVuhFyLOMBGPy7lUqomig1SzL3BSXsviwdrq0u5kJSoOhbJtRuN014tuCewripRTsc79KYkjCzO74xzzm9QzdfBmHUGrWWU3PFF9M8db0OJjzgRovCyO5scbxZBO25g8oGm4gnRAFVAYcg9q96/GTOimOsHLPyuGOo6DfOCf9d77qsGvKRF3e6L0gOCodIfMUXE2NRFHmybtkIQ1Lf7c1TdzHr6GCuLoDQ0CpLkmq67KBREXiRFi3ErauodgxFHGoNLzLTBLQ3I/M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199015)(86362001)(36756003)(41300700001)(2616005)(66946007)(66556008)(8676002)(66476007)(4326008)(4744005)(44832011)(186003)(8936002)(5660300002)(107886003)(6666004)(478600001)(966005)(6486002)(316002)(26005)(6512007)(6506007)(6916009)(38100700002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hwXQcA+XVFQBZrtUwRzPjD6qvrJIv7PSS78S2JHMvYKlL2Q7oQz+Eimcspbw?=
 =?us-ascii?Q?VMfUFLRHgS3aNnarCCmnA0rTwq3DKXfWjvQ6poSx+caWZfp5oKIiKgN4fQay?=
 =?us-ascii?Q?F7tvLlHr0J/dle1ynkL3K4ETyKclE5rHvU8uSQF2fvQb3voDP6J80PNhjh9a?=
 =?us-ascii?Q?V5PqhWxyv3kSuEUHj6BUyNhkOlBwtY5J96DA02MyNN6rkmx5xjXnpT9c5G31?=
 =?us-ascii?Q?14zfh/ZIhDBNsxPhPbBc+BDJKPFSaRTmt+5LloD6e84t5FCYc0DtzTAyy9AV?=
 =?us-ascii?Q?b5iR6dRHhAmAeu9VUG5GZENy9a7NeNaaXAlB1pDf6BtuQaN5aU1S7p6lBdmC?=
 =?us-ascii?Q?ucdl1vysoVBb9x/4FTdOxFAfjdnjSHstNaqDlCUQFh3whwnFI+RxjlrFdiTy?=
 =?us-ascii?Q?aUk5yVgr7xv4T2TQrTbCVB4y2kA+iE50bNVjyvqt+oce6scAgZc/Co6FcJJN?=
 =?us-ascii?Q?ID42Fq2AXRreZ1Pdi/AxFVUiKAVYlpw82SthZJcKUZZEYnNBsSoSb6WqZOxt?=
 =?us-ascii?Q?RKnqORNbd2aPEG3L6J+Gm9scXDnuWnz0Cqxd+7+IJ2WLnGpGUdoOlf88lgk7?=
 =?us-ascii?Q?wWnKxWBXmToZNMvE/YtgiCdG5d9qhp5AIemA4vB2DqVWwdzJKmFcBI/6bKRp?=
 =?us-ascii?Q?TITjbS7azbjvPqtK+HG88qycBWzY2IMVLE6E+esUe3je4dhonye011a9la02?=
 =?us-ascii?Q?qDg86CsvQI6lhk7Te5miV+aAvcos0k9cnJ8cK5zUWnrTsSpvbVQrMLT/lYjG?=
 =?us-ascii?Q?Hbbt7DrVhPGxfcEKf3VkMiYygmqeZPWe7g2ajDxuyvT4/wiar0c7YPIKJEch?=
 =?us-ascii?Q?AmaG3D/WY4if9MW1Y/Zo+b0ltHxjV/FeNyGHTdTySk+yC/OuDmIUle+H7J3i?=
 =?us-ascii?Q?cy98FKQOxGFBMuhRvd5KZSFFi6EDj3TH5m9Oo42Joir+fenIYoHI0GrnJF9Q?=
 =?us-ascii?Q?o/NTfnrxBc0WgavyvtTu47K8MtQSKqtkWCbKiIEnnxJN34+edsXUCEvzQrei?=
 =?us-ascii?Q?iqLmzn3QTjGrMGmxWGNQnmBr93ZZhCQWP4Nqgcv2fJ52cDlnGsN852BMteZ4?=
 =?us-ascii?Q?RYb3ZGeuXvEK1/ITQSeM5FPVOGXwz2eyBp1nU+1o+xucThAmNfBYT5ioz+VG?=
 =?us-ascii?Q?im5FKp+FR4Vabo5fkVS+jZ8TH9F7bnFSC8Tb0boxy6AqpHhub+xCVb9MKO4y?=
 =?us-ascii?Q?0oNTQh+gmAqLWbumpshK0LWCoaoLAZ19qOQq7J2/YzZoKv3elq89sDLK7/Hh?=
 =?us-ascii?Q?XqfTx0sNZ5XLlByIEg4C41uGFJBcT3fvDGR5S40fd2O7ctOq4Ye/OW9Tqw3G?=
 =?us-ascii?Q?3UQvoHvHqKKs6F8iiTdhKdZMzq4ZFH7AyTxTJevGdIZAwtz0CTbeDkBwY8u+?=
 =?us-ascii?Q?EAQebAYeNzRxZPqmX8Nym0QC0pjeXA5zYqMOOYZr2gv2nGgIBQyTwddSYNL7?=
 =?us-ascii?Q?/vA7jsXU76XiRkT2xZ58nCcUymt0kAftorG6GYw0IIEKGCrAFhCIT2H88gHn?=
 =?us-ascii?Q?1kD1VbEvSnakbsuXZpalK8/9+PdkLkSJMlh/lxH/VryfsC1zWHWsDGmEuATr?=
 =?us-ascii?Q?GlAWN8FCC21JfrvIxFv6F6Jk2SeUcviQ0Pl+nei+gGu/adAiXl5ZWo8EmqzX?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990bf4d4-f173-4bf9-b419-08dac85cee7a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 05:31:09.1630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVH6EnFADVQsaEHoLfslpO1WQqQA4jmIOHjRjDGJBQgGbPKaAjlxXFyqKGhKl++c4Yxc9jT8+DYlqAh67/e5ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8620

v5:
- use GFP_KERNEL instead of GFP_ATOMIC in patch 1.
- add the listener event checking in the existing test in patch 4.
- update subjects and commit logs.

v4:
- split the selftests into two patches.
- do some cleanups.

v3:
- add selftests.

v2:
- send created event from mptcp_listen.
- add a new patch, use entry->lsk directly.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/313

Geliang Tang (4):
  mptcp: add pm listener events
  selftests: mptcp: enhance userspace pm tests
  selftests: mptcp: listener test for userspace PM
  selftests: mptcp: listener test for in-kernel PM

 include/uapi/linux/mptcp.h                    |  9 ++
 net/mptcp/pm_netlink.c                        | 57 ++++++++++++
 net/mptcp/protocol.c                          |  3 +
 net/mptcp/protocol.h                          |  2 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 65 +++++++++++++-
 .../selftests/net/mptcp/userspace_pm.sh       | 89 ++++++++++++++++++-
 6 files changed, 221 insertions(+), 4 deletions(-)

-- 
2.35.3

