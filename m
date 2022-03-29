Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7755920FF
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 07:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648537771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V6IoScQHh7OdBCIXixoCNC2x+pDkZXYRAwpZNWgieeE=;
	b=lG8MprF1XM+p4h+r07PHgMuZp0NNf0fEj9b9CFxkGUmNsnmh0j+j6djUdoZrCF66k7xc+R
	BA9Aohx9GDRInZvsLftf+UIav1VndJ2BZ2Gn+LjIxMU6++4gopqNpFq6vEd5XoVrqSZdqN
	Qxoesz+XccFaAeMQtYX5TCrsyJIyeDg=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-RM2T7U7iPti5UbBED5N8wg-1; Tue, 29 Mar 2022 09:09:30 +0200
X-MC-Unique: RM2T7U7iPti5UbBED5N8wg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcT/1zy2OITRdmvx02AhEv5q+b04QOhwl8xHDoJIWBEPfc5RTiwAr2HYeeBlOz7T8n9Hek15iktkOH9OCwAlaPmJwZwu20x+meIEY+q7ygkH0fXxxAKzUBoS5giq6z9c6Dao/SU2xAvJBtgxCHUB4IHHq6ozPYBu47FmBQFOjmCZfUq3qf89yvCndu1ssFNprI5h9jmQtZyJh7QcypJq9LV8DVzUiSMabqWKkdvW0SLnknmIMhL3du3MUZ0B5bvBfi42b8al4vxFo+cao6u9BM0j9LkgnIUiOpODQU7eTYfPN/ABKpitn0oSZ4UO8KdsDeC5ZbmfF+cw5CNULa/fDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcmjkvPt/s+H+/oar8F5BP7PzfKx31oSXDDQxaV423I=;
 b=BLyJQ9aap+b1oQI1TUGG2i0dhbifUPMAcM208gVimTx6OMOv8Uv1NSbKc43YsDjY/4xpPmstjZ/hqq8LnlWLLUQGfaDyv3ozghL4tUdXmUjt9bOq8FJNI+bEuWmgp/YyMgV0bG4WkRn7tnqt5avnTwq0/42PsVMoIUaR61M19RBiQmUwF8mCink5nIEnJnyeCUaZUOaZby7t9JYwD2DnpKjc0FjoDR+hDKMtFJSj72RwkF4K38/TIghskL/G4E4IVNBC3bSwS3oOhLGhDKBS1DlFNdcJ0gCmaOuC3KGiyf6bS7dhG4Mv+whKlZZsw8pH7pTp8NDGtJXeCzB6YOs2+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7335.eurprd04.prod.outlook.com (2603:10a6:10:1b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23; Tue, 29 Mar
 2022 07:09:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 07:09:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: fw@strlen.de,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 0/8] BPF packet scheduler
Date: Tue, 29 Mar 2022 15:09:19 +0800
Message-ID: <cover.1648537203.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:203:b0::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7205a557-48f7-452c-fbb7-08da11530fa1
X-MS-TrafficTypeDiagnostic: DBAPR04MB7335:EE_
X-Microsoft-Antispam-PRVS:
	<DBAPR04MB733529F7E1430107A82D205FF81E9@DBAPR04MB7335.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R/xSPAeRPHPfZF6khzJC7ElUH5/yzVVpPnTY/qmx1focdpvAXKNcO7d0QNye8oRlQ1KFCqgIfWz+z+8chxXyqxYQZpwrswwOmk+brSyfNdO8XkhLH+j7naf1xsrqmAr1TlEkPJc+qrABaQ8RLQFzgiAkoBkF30SFXKdL9B8Xxdk1eX+Sv3qH5ARVMe54TGISNO/v0aIY6H4DU76C4Y6IOvPiHN0lWjDW/yR4rmUI9CHCxJNbQsQrQo2Pi8oYn/f+8tTQXWxR8xTWFs+D5etzmyMSYE3KeBA+O6ntcuZp6YP7lZJuiJgVpMmIf/rXF32QGQtEVB+RFzfmX98lkpiwxdL5y/5dg/u+J4esj+TIKFXDXQmqfPWHpRu8DW6ZAFgcVxsTDoSeYND+/lKp5+uQLUh24bMR7f8w5fWAXBB08SUyCPVO9GMvVjOaVFL4lKkfVpYDfF7k+f/iYlfq9NHeYub7okrsO7L6sgACWaW3cziWhoJY1kUjS/0U3+KpvLA181xSubofbZsHGbPD2TdSnCJu+A0d4J0Ko8YMJGaowhY/bX3s7XzkY4chFSg74aWbaPIpVk5BSzzOjMEKplETQ3kSBHjsX2rLJofZBIoDarPtyvm/LzLeLjHabtBPFlQB4fu6w7L547rzgS6COUswYzO6BoHr3kw8lVXy1qGi7ousUTYO22p31SOBcPi1Xll3Px61MEbl8mZRqy0JHVfoZRIwiwirFDeVEqdEvHQpMso26Ge/Zrz5r5x5xyb7c/8ZhJGpKbPx7R8c+ifAL6yORA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2906002)(83380400001)(36756003)(6916009)(26005)(316002)(186003)(107886003)(38100700002)(2616005)(4326008)(6486002)(6506007)(508600001)(44832011)(66946007)(66556008)(8936002)(8676002)(66476007)(5660300002)(6666004)(86362001)(966005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oUEjP8Q+rF5iA4lu/pAbJmL180NiIZjykmpJ6IiF7sb7D988ZUZMfYTOwOUd?=
 =?us-ascii?Q?+4hdd5DkE+Q5pSfJKbM0ol/X9eGR1pey6N1Lhia3XA8kylRPOEUt3JMSSHO2?=
 =?us-ascii?Q?/umT6trqiasZH1jqcsaXmR8Te8rk2WDNnKnTjlfBV3vkkSWFnqIUfkbz4qhJ?=
 =?us-ascii?Q?wn2sgY/L9921ns8vGGLOMpEbjzNfYJgbp7FaNsEPmMkJnGDOEfg+6VEKKLDu?=
 =?us-ascii?Q?0gEFb+MiJZY4wvf069X/AIc1Q58qPVjooVpt1UZfgtXMhPDP42R22+ROAQiU?=
 =?us-ascii?Q?ehdmSAJ4CbwckdWFCG5z9WrWTd0wRcNHagv/wSwHPKx2o6LaHDhu0oObxijX?=
 =?us-ascii?Q?T7V5mE5CvvgqoQzVBsD5nmbLNVFiXIB6282j7QDek6augXhNOvER3TfF1aKf?=
 =?us-ascii?Q?zFQMBW2ubx8HL2e+fahtvKJmpMHUPGRcpiOuScs5K3YXwQW7sklMto9hxmxE?=
 =?us-ascii?Q?6XmZKWXM/88ECmTuNEqnZa5sanrEXB3qHecFBGvlJo3nZyhkuvDSOXZJE0kl?=
 =?us-ascii?Q?M5ulzNTsXBMShjYHU9biWdZkyKFFhHW3AFIiK2q30XwLl4Z1cKeOD1DMQJSD?=
 =?us-ascii?Q?Mo4OvkVGGdkw/0BrrqqT7HtEjSxJjPw/ctj9dqCuORiDqoMo6QmU46gUKfox?=
 =?us-ascii?Q?b26AeVkvMphJRc4AOcn3GQ4JQd7pwI5RSwbuuE+ZFrvb1Q3RzxQ1t2X+gmXc?=
 =?us-ascii?Q?K2ASTIJ7XLdiEIp58qoatxRXfHWTIBIZYB9hs277mNOQVXt/jpeQM2HIgUmc?=
 =?us-ascii?Q?HSvasjGxZ6gHI6a/dZWyNyOgabNlzgtH9lH94Fkb+Hr/v95eVMmoP6wWW/9D?=
 =?us-ascii?Q?k5Tqj3eDFvaFrHFHvdqV9yChCLDGdAFKfxQQaMLLTuP03aW0M6IxGxbg6mhJ?=
 =?us-ascii?Q?zKJjzUWnFXWbpyZXMhdIYmZGnvsnPl/1JJPG4KEZYqPzlIj0jYPCy2GYyaBs?=
 =?us-ascii?Q?f3c9Ap3FE6rKsyYirb3K30uHj8gXNseSBoy+oQSQ5ZaFYfH2EM2iX6hbiZZV?=
 =?us-ascii?Q?vQMzUZRygwEdQ+QuuRwzYz9ZnoxjvFOew5m+TNJhYYPxo9NFaidxwF+AryhP?=
 =?us-ascii?Q?UrMbNpdonDLyyaLgmJqIiXFbs0FxZMOOz2zvO+p+g/vZ9NouAr+WBmwAWZJs?=
 =?us-ascii?Q?5lGmtNHZjj4MGXRI/9vxDgVwUea1eHUD4vTkz0hiGdAO7/a6g/qfAw3kmBun?=
 =?us-ascii?Q?6HNjsm1SRP2y2uSWmwoM1vq8opudeJHUzU4jtT6V+VVV2HQSDlJYgLkPPa6E?=
 =?us-ascii?Q?ClE7hMrq+jMC0Hjo2VPPrS+Lx181zH2AfKucV2UUM3AmMXGDhiuqUXYGdJvv?=
 =?us-ascii?Q?YVy4DYBOwBTrApGm+5XYct7A8Ve8iCC6uDepGEVjuasxRwXn6YxRjnZthAUZ?=
 =?us-ascii?Q?cEjPSOjzBoeNrn7yGBgQBI0xyldgTLHyhikNpHwWyClVyiO5nuOrxc0kpyM1?=
 =?us-ascii?Q?GU2Q92kKSo7IJToK8vBmyFKNYvq9UJXfVMDBLTtZK2Zynk6xHKppVIQ3wBem?=
 =?us-ascii?Q?/PMndMBCz1czEY7IFq1Kq/Lf2j5/F4PpQsfZkgdoz228Ye6uOFl3D3d2G+b1?=
 =?us-ascii?Q?22kvto+kaMwIVHmZuQZbC3YQb+PZWSs8ROfCX+FvBCMXrvVtZbzti0A5V45M?=
 =?us-ascii?Q?Cy5JQBlGP7KDJwbqPs5YkMIt3LSrBb19dzjNBgsEezZ1Nml6oMIYo+Xx5eYi?=
 =?us-ascii?Q?IGY/PVmgYmx9iklqSbNNJhClmwEVFrn+v+WAVV52HuxYBI8D+Dw3B4m5NDWT?=
 =?us-ascii?Q?Z8Racs79KMBHMmtvPVI/dCzfBvJCP50=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7205a557-48f7-452c-fbb7-08da11530fa1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 07:09:28.0920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKOuAWcINRr/P6P2rDe7fWF4SM09rVaS4gGlptOJLi5ph1IHbgpXFllohaI3ukJfuGA8l9EnBgRzZ3qqnIeKXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7335

v8:
 - use global sched_list instead of pernet sched_list.
 - drop synchronize_rcu() in mptcp_unregister_scheduler().
 - update mptcp_init_sched and mptcp_release_sched as Mat and Florian
   suggested.
 - fix the build break in patch 8.
 - depends on: "add skc_to_mptcp_sock" v14.
 - export/20220325T055307

v7:
 - add bpf_try_module_get in mptcp_init_sched.
 - add bpf_module_put in mptcp_release_sched.
 - rename bpf_first to mptcp_bpf_first.
 - update commit logs.

v6:
 - still use pernet sched_list, use current->nsproxy->net_ns in BPF
   context instead of using init_net.
 - patch 1:
   - use rcu_read_lock instead of spin_lock in mptcp_sched_find as Florian =
suggested.
   - drop synchronize_rcu in sched_exit_net as Florian suggested.
   - keep synchronize_rcu in mptcp_unregister_scheduler, otherwise, got
     a workqueue lockup in my test.
   - update Makefile as Mat suggested.
 - patch 2:
   - add mptcp_sched_data_init to register default sched, instead of
     registering it in init_net.
 - patch 5:
   - move mptcp_sched_get_subflow to protocol.h as Mat suggested.
 - patch 6:
   - use current->nsproxy->net_ns instead of init_net.
 - patch 8:
   - add send_data to send more data, instead of send_byte.

v5:
 - patch 1: define per-namespace sched_list (but only used init_net
   namespace. It is difficult to get 'net' in bpf_mptcp_sched_reg and
   bpf_mptcp_sched_unreg. I need some suggestions here.)
 - patch 2: skip mptcp_sched_default in mptcp_unregister_scheduler.
 - patch 8: add tests into mptcp.c, instead of bpf_tcp_ca.c.

v4:
 - set msk->sched to &mptcp_sched_default when the sched argument is NULL
in mptcp_init_sched().

v3:
 - add mptcp_release_sched helper in patch 4.
 - rename mptcp_set_sched to mptcp_init_sched in patch 4.
 - add mptcp_sched_first_release in patch 7.
 - do some cleanups.

v2:
 - split into more small patches.
 - change all parameters of mptcp_sched_ops from sk to msk:
       void (*init)(struct mptcp_sock *msk);
       void (*release)(struct mptcp_sock *msk);
       struct sock *   (*get_subflow)(struct mptcp_sock *msk);
 - add tests in bpf_tcp_ca.c, instead of adding a new one.

v1:
 - Addressed to the commends in the RFC version.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/75

Geliang Tang (8):
  mptcp: add struct mptcp_sched_ops
  mptcp: register default scheduler
  mptcp: add a new sysctl scheduler
  mptcp: add sched in mptcp_sock
  mptcp: add get_subflow wrapper
  mptcp: add bpf_mptcp_sched_ops
  selftests: bpf: add bpf_first scheduler
  selftests: bpf: add bpf_first test

 Documentation/networking/mptcp-sysctl.rst     |   8 ++
 include/net/mptcp.h                           |  13 ++
 kernel/bpf/bpf_struct_ops_types.h             |   4 +
 net/mptcp/Makefile                            |   2 +-
 net/mptcp/bpf.c                               | 102 ++++++++++++++++
 net/mptcp/ctrl.c                              |  14 +++
 net/mptcp/protocol.c                          |  15 ++-
 net/mptcp/protocol.h                          |  16 +++
 net/mptcp/sched.c                             | 104 ++++++++++++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  12 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 114 ++++++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  30 +++++
 12 files changed, 429 insertions(+), 5 deletions(-)
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

--=20
2.34.1

