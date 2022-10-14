Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253B20F8
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 13:32:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K40spdKW0T/1xpSLJ9wgqE1LGqjbQqlWdsiRyr7KkEQRXms8SpWXhggxv9wpStxR4qhTNFlc55f3Uwj/8EsUtyX7bXGXyFIpm5LNEDuc4D4QuCJFNr8LKDrdYTNzfDFf0SQozKYKSBV1qW1DIDd4uNTaAUXRs10x9eNItAvHTxYxyfHdlM76Paqnd3bDbBZPAj9imyx6k46Gg2dBj357HZVLM2xfmex9ImC5c62jJ9Xu7k1zXWP1jjrkU7pg0Zuf6evHvXxHRMN9eoLBC/Nkjnfgz8kOL07tUHFCVF8+chFbDijRwMdVzTrE7utast9aZmSE02QYf4QMAM5eh6zQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TabJlQ2rnxaruRvdVjNG3wxQe8WaJ4WF6yfJB1qDsHc=;
 b=mmmEWB2agJWksicrXxuCEOnUj9nGx0/dw/T22g00/yvkanGkw2JceJspdI/rSqVzrh9wARjxtLlOQ0GsaM+OfEMgDmEnZMbLuphm4TYmcBMLjGyPXQxUPv/3hg5NdJBC0SAwxU0+6/jfnkfPrEc7IbvrL/9uOP8xCzt87n++rfP7WSeWAZjlhhv4tW0Ije3on2uDeQrVSj9TqXm1gkqdgu5V81Uj9GqwT46qt/wCcZWR1YLC0kzkvFgCGD6pYT33REQJG5SpFpbY/bhec5M50mbhdzvPCqXyVginT++Xb/i/vGBTTr9Zc+xCaTfhXZR36tHfIFYi3lSAOqTn1Va1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TabJlQ2rnxaruRvdVjNG3wxQe8WaJ4WF6yfJB1qDsHc=;
 b=ITZiCe15s6hZafvkClwf/bzQxW7ep20Fy/IBwioQMa4CtW6bGgqDkau5LqLSVP0HpnIgicPQWHCqFBQpbmKF+OJgl2CGrxOuubATDceDeP3KNrfXLNajUYrbhtQadX/p05KzTKWNwhHVhAh2xmPoIcwjQfVcxJ+QDOti9euYiWNmY9YFAeGvYE4tGg+kHtnUuRyFEeq6yxgk8FDa2tGuEd4NG+9kZbEIQOPuLD5KYpgHydH5xnKE6BNF3Mn/nP0iNtdZXDJ4m64MaemSVt1GtFtNkKLzteF3dwrO3xyzfDmP8A5Hw7cJ986ODbQUlsIVZz3o7nFyeo03ikRhSi0I+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 14 Oct
 2022 13:32:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 13:32:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 00/15] refactor push pending
Date: Fri, 14 Oct 2022 21:32:07 +0800
Message-Id: <cover.1665753926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0065.jpnprd01.prod.outlook.com
 (2603:1096:405:2::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb3b54c-c01e-4dee-9b52-08daade88edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	76kZm8r9OvsmuOBOWoHjRfCjY7DEXEG6olJQdZcnpdw3sky8xboZ5gjZpYlsal6WsTpx5Ek+vvfhB87kZVlFC7bY74GhYPPL+baZU9g4kT/JjMGGwHJ8YZN5vQ3iqjK7xLzi6EUWtcvc0eL6tK2vEHNC16xBv2mStMQvqqVNd3OxNmv5xGPdH8jK2eLW9nwqdDSF0/Ni1SFFan4WCXwhKop/Jib7o6/8aQLutFPAoRElddn5LVz5Lu4QdWSeNk12Yle4W8VMyHv5ecvPDTwvSg4UWhe3WQdtyaEStNPxb0TNtAMXbDLAuDDCOMLYGd+4koSc+y+o03QDFF53R2H4Zt2Ex447XvnTYtNc5hS1cfKPnybAh5Ko1llLTr2PITSU0/A9LGvrQDIpULwLusTIExLoDCS5iYMZxQsM8zNRaEM87EIgpGt8fqS/TjkMpC1DellWZwLbxQ6fyqKPs1hp5c54ObdeaARxa4HFuF0R7dmZqU0lN4DEKySQcvOVeqTJ0SyIQwyY/Ag+q2jrmvsqo+pESH+sRW6W+qLrVIPGOgdsZCozHVyF+hlyUOng6tnanNIMb4AV55MdyP80lxNbZPOBL896fesHU575UeZG+t/xzbI/poyhEh1gDhtI/7q+1RjjvELoMxG7Q6TtUESA20uVC7CV1o+ozPMWjT1pBWUWhhSOGuFk6Vu9vqxA8BTn2ciVW0Kq+vHfOFUi4g2kh/gAfal9/im93lvuxDfzXiaKvIjYyqyQYhnLqX1H2f3N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(8676002)(38100700002)(6916009)(316002)(478600001)(36756003)(6486002)(86362001)(83380400001)(44832011)(2906002)(66476007)(66556008)(4326008)(5660300002)(41300700001)(2616005)(6506007)(6512007)(66946007)(26005)(107886003)(8936002)(6666004)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KJqegT96psjYiqF1s+zJtSg+pCFan5bd96aybz6UISaM5JnH92KH9Y7AwbPP?=
 =?us-ascii?Q?QYr5bVFHdqJ5a6Bf9GpEiuM/CSEw43Xb9biVXVyzguk9JvkStikm7m9C2mBQ?=
 =?us-ascii?Q?e85WOdI80f6OwBu+erkpbnlJWMhwoyW+3Frz7eTkrAyuQhJj4xtPf4WW6YN6?=
 =?us-ascii?Q?U1aCgza2vdAg2HAo+nLMt0ZIzMfQjZF6gJ1ARuKqq0kjBrG9bMMi+ja8OjyV?=
 =?us-ascii?Q?qmOy3LWfcaxQgmftDo+5/RF45gC6OYM8lYVNiiS234CoXpia/fyimGZomF23?=
 =?us-ascii?Q?nEK35IL2KiTfqIJbl5f1X2Y1Og5U7gvAHqnzOO4+D7mPRvW9l3mvFwoJ/xxV?=
 =?us-ascii?Q?lvSvgObpoypRiesw64eVuQmjiyCY+SS90ecvXvX8Jpx+DxYaNB1f/SSz+iEO?=
 =?us-ascii?Q?Dc9NuB9dfpYxS9HgPhjt/ybISdbwtL5vHNRbZE0HVxo7pjUyQ6du/dwVhSGj?=
 =?us-ascii?Q?fMaPosKuvegARedQWIjSvcxwbQ58QGsIrSsZGEr+cqkXewSBb85Sk5M6tvJn?=
 =?us-ascii?Q?Q6z0imnQ3NzCMJK3jKHZwmlVtVQoyNzrEVLBJqeaXXzpNpp3d1H7gq17/qJb?=
 =?us-ascii?Q?eHGnOvOrRcwlBngz9o+5hP/B3lqELNQcDmhPrsABZBv0/rPI4NBNKaR2MMgY?=
 =?us-ascii?Q?2gE63jOOg0WFJuIo9nwl/Hl2bZd8NfYDhOznCXWUJ4dV6LOXR2AN3E88OUOu?=
 =?us-ascii?Q?HwrqBOMqevnBv391oLNC4s586qunCQiGjULIG0V6zOHNH4XEF509Zp7whsTJ?=
 =?us-ascii?Q?BfTfmOd8V+V2+E+60DD5YBr7zDK2UChd26gsUxGOakLs+7fEKcPpBET+9AwN?=
 =?us-ascii?Q?hdPPbabxw3mv2YJ4MIove6VdVPInFW9YySWgkSfflvdBRF03Qh81hlhlikWf?=
 =?us-ascii?Q?opZDXuxhJxpGDmuQgDuqH27gTwzNV70ZhjPk7NxOwIAS4Vzg9ls18HwArIY4?=
 =?us-ascii?Q?dmsi+/vrLJpKk3BQ9ik1t/hUe2gJL6+T/zJ4s41teJRA7L2tIJDEPaRQvA4E?=
 =?us-ascii?Q?HJe9BFo7qdQvE4ecTzK6geQzkEW7VApvQVaPasqx14IZR+GEKIZed1GBJYg6?=
 =?us-ascii?Q?CZUvGxOqFS+WtgmFxbUGyPWDMMkpzkyNtmVJ23ZjMF0dlehpGh6jAv3MXd8W?=
 =?us-ascii?Q?Bv+Y7NfSuMkEFCz2GydFABc4NzwcvOW6f9H7iwYSZs3+qSuGmZqXZFilngVQ?=
 =?us-ascii?Q?oSbhiS+NScK9arHGW6lTwx8IBJxp75ddU/S7kaEBOSME1ul7RpFyvjGEVqVW?=
 =?us-ascii?Q?EQr0lQakNzMFFkO+1ug8sO+nhszk/BfPM10p3pvuMEZAmKAt5UtN9vPSPj7V?=
 =?us-ascii?Q?7AuJEy/+LCSqhwiWel298ftLnNbrXFIETiB1Ks4CPErduqfo/EWGlRVi6TaP?=
 =?us-ascii?Q?I9RE+q2OPcs5o2p3YSj1uMDLyLYAPHduQBUobKGlYODf3nj5UJeUcYhNI40A?=
 =?us-ascii?Q?oJ6mjSBrbGHH1D5j5rOAaqsANmY6Y1uE1aLKl1TgGoLIZEutZa3WumcPuAEr?=
 =?us-ascii?Q?86v9WPOzUaIi6ALE6RUdLsG608HtqMQqVNhMA73TnEFgfa80256yLAqsOWLb?=
 =?us-ascii?Q?1yytZ0n3HEWan7ETdD+mT4lTV8STJsI3VIVRm6/cz7D7h0uWZ3SxCnr6rAL2?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb3b54c-c01e-4dee-9b52-08daade88edd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 13:32:37.3189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXdTVcAKogqBrUtmN6mdm7cH2152ct2VgGvAPXli2fVgpa6I4Zr6mk98zepwuoMAHZuHbfKN0jc5sCvV/sTWDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975

v8:
- merge "register default scheduler" into this series.
- Move "multi-subflow scheduling" out of this series.
- This series should be merged between the commit "mptcp: add get_subflow
wrappers" and "bpf: Add bpf_mptcp_sched_ops", except the squash-to patches.

v7:
- update delegate sending in patch 10
- rebase to export/20221011T063543.

v6:
- drop all msk->last_snd, add last_snd variable instead in patch 13
- fix lock_sock issue in patch 3
- merge squash-to patches

v5:
- address Mat's comments in v4.

v4:
- update __mptcp_subflow_push_pending as Mat suggested.
- add more patches from "BPF redundant scheduler" series.

v3:
- add a cleanup patch.
- remove msk->last_snd in mptcp_subflow_get_send().
- add the loop that calls the scheduler again in __mptcp_push_pending().

v2:
- add snd_burst check in dfrags loop as Mat suggested.

Refactor __mptcp_push_pending() and __mptcp_subflow_push_pending() to
remove duplicate code and support redundant scheduler more easily in
__mptcp_subflow_push_pending().

Geliang Tang (15):
  Revert "mptcp: add get_subflow wrappers"
  Squash to "mptcp: add struct mptcp_sched_ops"
  mptcp: use msk instead of mptcp_sk(sk)
  mptcp: change 'first' as a parameter
  mptcp: drop snd_burst in mptcp_sock
  mptcp: refactor push_pending logic
  mptcp: drop last_snd in mptcp_sock
  mptcp: add sched_data_set_contexts helper
  mptcp: register default scheduler
  mptcp: add scheduler wrappers
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
  Squash to "selftests/bpf: Add bpf_first scheduler"
  Squash to "selftests/bpf: Add bpf_bkup scheduler"
  Squash to "selftests/bpf: Add bpf_rr scheduler"

 include/net/mptcp.h                           |   7 +-
 net/mptcp/bpf.c                               |   1 +
 net/mptcp/pm.c                                |   9 +-
 net/mptcp/pm_netlink.c                        |   3 -
 net/mptcp/protocol.c                          | 208 ++++++++----------
 net/mptcp/protocol.h                          |  15 +-
 net/mptcp/sched.c                             | 117 ++++++----
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  10 +-
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      |  10 +-
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  10 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |  16 +-
 11 files changed, 212 insertions(+), 194 deletions(-)

-- 
2.35.3

