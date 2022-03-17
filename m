Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E675C2F38
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 11:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647515092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S+8DQTWwBg54u4HD1asCD2/lqwLIWDyGOP5n5ze8a3k=;
	b=Ibd+M8TR9zw+5PKqwQZHImUdQ3/CTfqC7+7N6eDDJzeX4kuWtBcw9z60Q7qadPyzyTyWDz
	7i8UIc217ds07a4231O45At7pZheJKtPAN8I9STxnTV+F5kv7y9nGmPjeX56nOMCIxJyYq
	93TjtAQ3JgX8WUOSm0szeh4d+EoJoFo=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-OUQ9BtL7OkqoGM3BdgDLiA-1; Thu, 17 Mar 2022 12:04:50 +0100
X-MC-Unique: OUQ9BtL7OkqoGM3BdgDLiA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO8v2wmkruZPVpVGw4PglgATIEWKCLWI2Zz24B2Y42illObHBW8YLsGQqkADrdhsQsbCDW6LedYeEkS0d8Rw26SI3OX09KgyhTQNNkuJBbdBQ9wvg66mawKJ9j5ze6WtNIn+d9TUkeyuLT89ZqHfDWHnJ1MfMEkm0CXjXKumc4/yCpNPOb6rXtesDO9gYxIrlj4PMh5reqnXUKGKitbq68dlTE41L++Mztm8IUlX+CS8YutkqU7UvoNAVDuduhqmS5lRmdZAm1nDnxkl5BERbQS45Ea9qJXS+b/nUa2sxqX+V2TlbR/utHXAfFC49gNID4yOUJ5lndEL6Db31BfC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzFQCVJThSkRX6bINziLzP/83L0XTDet+SEbJ1ZqVpI=;
 b=JStvOLbxQmal4XnEu3e82Esa5WKa3C+0Y1Icfj3e5h3flu3I014djM7sDD9ihgxYdedWaAY6PWZt0Vj9LJhjJwmSt1vROdod5zwAusmXuF7GcKZ6h8dglGbbeMV/l7d55gs5Oo8ZqiV10puV/uKZrrm/wQG3iGYmO6kIzd8pItwPCGFgWBTBiz3w2Cadk4rjtAELXXeCqvB/Q5FEtw7rMk68W3j5Q5GnyDjr9SnNrk5hny3yrCQBIaWRiQxVyHQgvAdB90dIJ+skxSoWBbub3WQo71zD5hVmBPhhH2KiKssaOk1l3Oz6sJuIhUvm81WudGoWUY0einyAKgOUnH03Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4462.eurprd04.prod.outlook.com (2603:10a6:803:65::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 11:04:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 11:04:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/5] BPF packet scheduler
Date: Thu, 17 Mar 2022 19:04:41 +0800
Message-ID: <cover.1647514852.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0155.apcprd02.prod.outlook.com
 (2603:1096:201:1f::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 537aebdb-29ba-4ad7-c117-08da0805f322
X-MS-TrafficTypeDiagnostic: VI1PR04MB4462:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB44620DD059030679EA3C10F8F8129@VI1PR04MB4462.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h+I0ih54goaHwatxRnL/OfYGviPjaYeYPP6LjrpGNkYKmCyqOjgLWABXqRYQFir2C5aOUXQTg5SBUt1cVNrIpCoG1sVuj32Iia9EXoVGoFMhDzbuT1ShSQIMyqjcf6wPURo0/Wvxq8hz7nD0c+rCqSUFPu7w5UEXfIf9rNL+0Ty8dIhDPyFDmLko4DBfGTFm//OZg3JMua1vZTjqR/l+jP69P4/mq3ZP43Y34h0MKbmQSG1eIY9rArJDZS64ujQ+x69k0iYAEpTJ9APLclEl+RHI/R3O2qw4aEGx3JUWBFEgz1hHhEc81+I5CZ0iVcXQ3LrkqLM5VH4scCslUR7tWcG5hnndodztdXPi8oDm3wh0nQ//ZKSA4jUuMx71/xTrV5rKjduZa+UlNGW2OBcaiw6kDauBcdwixDVWzithDxvGP4M8KKsFrMAS+Sh5eKAtbr6s5Rj6+cDDhMXzX6vLkGSLJPHuVIWqHW7DJrS9ZEHrwdTGIOl+dJ4/A6y56K1IOHdNxENB0uoBDABe8IzWcoZ58mPP9W9n12UANAWvjhdby7TXO15y0KTpbB7Rvx3k+6PqkKKnIgyQyH14PHUBjoLaeXkvm7D6+hW8N6YkKQ4UUHYwdVV53+cDLXlOnHivYAO5NbeEG6UscfGJxwf7HFmqYFz3e/XRtRlOn0W5mgz67Jnmq97xr8fXvRb/UdQs9NzqqVaPvW/5uWrF76+h+/IX/qZyVMlJKgBWmyuv12U34XkIJep9ZLtgxyU3RV23bxjcWW2CCWSVe+jjCFbcFClZiIvrYTcHbUboPfC9P4wkAE5AAftMYUV7nNittFEh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(6666004)(4326008)(36756003)(2906002)(5660300002)(107886003)(508600001)(8936002)(66946007)(66556008)(66476007)(6506007)(44832011)(38100700002)(86362001)(26005)(186003)(316002)(6512007)(6916009)(2616005)(83380400001)(966005)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YG+03YZ6I9Ul1XSNI+FzVaDIPDkWGELjgFNnF9TEQEnLev1F5CXMV4CiwjMN?=
 =?us-ascii?Q?goimMxRaQTsjOTENUf58bbbaLRKFTF6zMjbM4XHwcxvV/7P9HTTKEb+ohhO3?=
 =?us-ascii?Q?tGFiJOcMfg7YM2Ing3I+V+M2vxwXFt5xc+uKBe9fe7eZKHcK6AQZgpjmk50w?=
 =?us-ascii?Q?oCz2ZW0OIOwNS7b3riN2JUQo6N14XcD59jXXSRX/Y7IkrkmLxDGwxhEQYuZA?=
 =?us-ascii?Q?0TC8GEu1F+gK83bs74bOB0Gxao8x8Do+VwJGMy4OPZtAibsCqamdqpE3Pd6z?=
 =?us-ascii?Q?ohCRI/Yg5nO1hXS1z6HNAPaWmSJALRCK9PHz6X/YfHD1rdgm/LvmO/Lpt9L6?=
 =?us-ascii?Q?f8lIUzVrUAxT3pK1msrcHeKvCtWm61oijqjRxf0tGQtKBBVPYKLHP32QzO6O?=
 =?us-ascii?Q?jJ3z19iCS72IUtpCo+AJqxZST1/4A9MVTS0CuJlX4gDBL4bfmi/8/B4KKvf2?=
 =?us-ascii?Q?JnLt2ehsch9ExHYqGbaJOhs1QL87HcVienEegq8EAZTCrNIhTANHSs0/KdMm?=
 =?us-ascii?Q?GyiyEMY2Ky/JE570PTVcCBHxQxUM9u2HnQosl2AYLc++T7xGmx4iE6ISxuoO?=
 =?us-ascii?Q?EZEqTJCKoA4nGbGFuPODADNbaR6wjPE9LZj94CIpWBdcHl1lAnQZClsxHTEb?=
 =?us-ascii?Q?cC5csTgYQpD6WBPF39HJesstr3PnQzMRZf4fyn0aiq44bY8X1dK0xBeeyxR0?=
 =?us-ascii?Q?dU5BKVmidtGv9DDfJp3xpB729dpigB/v72iep0zTyllCIlH2j1RdksosYquY?=
 =?us-ascii?Q?2jlhs67OPXEAC/nymA2C98pZlpw5+YGn2Kf/dHROcdXBvDHLKQu+aDlYEYdE?=
 =?us-ascii?Q?2L3X5TPcztnQ5VdV0NPxDZvH9WqmkcVkZcuTwNWN5i0CWgomOv2BlmHk6EMc?=
 =?us-ascii?Q?oa6xyakAkYJY85xxsI85CXgSLxmT+Ft0B6x3Z8DCyluxauY+6d5x9vC8OEL6?=
 =?us-ascii?Q?MPa1K0YQTc+gOixC9vxt9MBC7ZDSX1BfuTQV8W6ih4FbwrYawoSBZn6iiQXg?=
 =?us-ascii?Q?xZNLFRnbSZ/aOi8TKkiquGVb1aW9XOHJTt5hqCDcopo1bLr80RafOeZRPwTy?=
 =?us-ascii?Q?6OzRXiB/rbk/rmOnrFSQAkraTSgIlKHb51ExpdHPtUPdlBKB3XKJ0tRAq6mM?=
 =?us-ascii?Q?DuZK2gxLcM+95qjguIl6Ujbt6r+YUNQIGl1o/P/pKTWO5oxMqF0e+F8CtB4H?=
 =?us-ascii?Q?egF933HxLFOi3iNyuQyZuefPlVAgS4U2lFVWv32df4+7k47CIBRuUuDmEdmt?=
 =?us-ascii?Q?RHJRDELmWVz9EDVVWuJqrPMlWtoLdsyguGn+dMjETT/yjVIb6j3voMJvm0Tw?=
 =?us-ascii?Q?h+vkh0+WY6ENcze3xsXegcEGguZmL0JlneIDgYUAPk2fu5HMY2n/k+Gmubdv?=
 =?us-ascii?Q?AHf8bHnNcLMt+oGhoJ1P1ert7ofn4OWy2bvEKQSXrtz04r2Eg1EHNn0H9jDk?=
 =?us-ascii?Q?55nJZ+H0H6g7nm0SFd3l9cEYN/Bi4Lt2Cz/d0y4cyk6h+kK95Sw65w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537aebdb-29ba-4ad7-c117-08da0805f322
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 11:04:47.7252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BG/72co2keNlNtPJqer9tURCqpBs0nEYHGtffy/KbYiGs4j57FicN0gUmNrZekeZOjxPZahoQAPm3rTGGIPdUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4462

Addressed to the commends in the RFC version:
https://patchwork.kernel.org/project/mptcp/cover/cover.1631011068.git.gelia=
ngtang@xiaomi.com/

Depends on the bpf patches queued in the patchwork:

7541fe09cf06 selftests: bpf: add mptcp sched test
1fa592f2770e selftests: bpf: implement bpf_first scheduler
5bbd1d25b994 mptcp: add bpf_mptcp_sched_ops
ade0194842d1 mptcp: add struct mptcp_sched_ops
23bdbd0af9f4 mptcp: add a new sysctl scheduler
772471a34280 selftests: bpf: verify first subflow of mptcp_sock
f3484ecf1bce Squash to "selftests: bpf: verify ca_name of struct mptcp_sock=
"
0cd058c7c489 selftests: bpf: verify ca_name of struct mptcp_sock
07a66e354126 Squash to "selftests: bpf: test bpf_skc_to_mptcp_sock"
168ee1d1a118 selftests: bpf: test bpf_skc_to_mptcp_sock
7a773e6af914 Squash to "selftests: bpf: add MPTCP test base"
a1933407b912 bpf: add bpf_skc_to_mptcp_sock_proto
0095d8ca9a67 Revert "bpf: add 'bpf_mptcp_sock' structure and helper"
2856d8c8020a Revert "selftests: bpf: add bpf_mptcp_sock() verifier tests"
df0e2a4c394f (origin/export, origin/HEAD) DO-NOT-MERGE: mptcp: enabled by d=
efault

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/75

Geliang Tang (5):
  mptcp: add a new sysctl scheduler
  mptcp: add struct mptcp_sched_ops
  mptcp: add bpf_mptcp_sched_ops
  selftests: bpf: implement bpf_first scheduler
  selftests: bpf: add mptcp sched test

 Documentation/networking/mptcp-sysctl.rst     |   8 +
 include/net/mptcp.h                           |  15 ++
 kernel/bpf/bpf_struct_ops_types.h             |   4 +
 net/mptcp/Makefile                            |   2 +-
 net/mptcp/bpf.c                               | 102 +++++++++++
 net/mptcp/ctrl.c                              |  14 ++
 net/mptcp/protocol.c                          |  12 +-
 net/mptcp/protocol.h                          |   9 +
 net/mptcp/sched.c                             |  89 ++++++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  14 ++
 .../bpf/prog_tests/bpf_mptcp_sched.c          | 158 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_first.c |  30 ++++
 12 files changed, 452 insertions(+), 5 deletions(-)
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_mptcp_sched.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_first.c

--=20
2.34.1

