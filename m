Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D6C23C8
	for <mptcp@lists.linux.dev>; Mon,  4 Apr 2022 02:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649038202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/6kkxQrXB8ZzStQj58TuL+Oiqvc7Bvha4PB6r3BTqBY=;
	b=AWnu5jL4/vXzYhSyVdCyextYFwV19tbRCW9dzcY5oiMgZYQ0XTeogqMK/xkWmw7+wKTCKm
	A+Y5klLp3qxrSl51Il7nuh6kmPHTQ73QEgAu+uiJEPHIiBXKZV9mSeaoR6yBYKcgGMekUA
	JZP0/DoJRqaMvCR3Cl2Qa+a5k0jH//c=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2056.outbound.protection.outlook.com [104.47.8.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-HCOVCtCcNBG9V36PuwBhBw-1; Mon, 04 Apr 2022 04:10:01 +0200
X-MC-Unique: HCOVCtCcNBG9V36PuwBhBw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS9DwFkKrgM0LVf9Rx5wlAnuUPuEuOxsB5SlcaEVrvC+vkxbw2Ykpsubqo7a458+hl2thmQ5riCigMDyf2wSe+chpLzepq2EIRy+VxeNNslIciwhRONfjMiPw5LSXzYYOJmUIyPER4hUDY73M+HIYxlOP4Sp9zhgU4s/PyPaZ5tiLprUJQqVM4gk+7z/xmB6429pqy4kX9bZ1UPk/u6pRtSQCX+bvM42E215zn7NBkG0o/NmjlosrimZd79GQ6JrQByTvHSscVCshv27AOc8iJdzabW4cxFvmPJ+DHvDbS9FMH0z29Oev1NUnPWsXM7Q4mEYAsJMOzZPIC6pbYMlRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nq1SX/gOyVktK0ocTxASTmJIECTgaeJ1UES+fsIS450=;
 b=ljTnl71xNvUcsUI4qOJ4d+0BgtgiFGSBCWNCkE6wyc2gY6zRLh+p0uxCKFf6zI2lcCr+1Zr0IC85Hl0zir8VXPuTC1cM5xqLmA5fQKiGEXXbNBrQXdddibt4aeaf6iHacFjjOeDWFz4ln0KaLjwpl6jkh0yz4+E/qmW7cJnUdmgWBudZSjIpEgk2jvYFXisVfLgVJAFl+KkAgF9HWLx5iApL4SVUrn7+JdbtCtMqHsZoRy5ipZQnwJtBtrkfxSB/p+UHECHcEqs+GdENQ3ntC8cM4HGztr7SCEW+AJMdB3rgiSfLZDQFBF/niTqb5Uu3YkfRb82OJ5YWZTr6iS3jnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7189.eurprd04.prod.outlook.com (2603:10a6:20b:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 02:10:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 02:10:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 0/8] BPF packet scheduler
Date: Mon,  4 Apr 2022 10:09:52 +0800
Message-ID: <cover.1649037838.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0090.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0526e46c-3155-4e5f-bca6-08da15e038d6
X-MS-TrafficTypeDiagnostic: AM7PR04MB7189:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB71896D5C10FDAE3A39B8EF1EF8E59@AM7PR04MB7189.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/XX01D+Ywsqmlg46ArJN38dItvw8NgsRy52I6Gvj58uHdqVsySsRhkDJqZ5xVCVfMxezg9LUA9kCabjGEHV6OakckaFdnlTlL/R+V0rauFeLOl3QZucblhcQ8BnSvBKQzF3k97yJAV57RU634g4tm4OGK9rWQ7ZYTc9irza7Bw7eLt/HChhEpwezePVW45D0Sw1drc6Kh7uagd28+FFiXAnEpR6P+GpxuBEUpIcAMuv1/PHMkbPQQP3PYqf3fsEoHS3cZCFfMySVujuoqRZEv1AaY0Xti/FhqHEUJpnuNFfqIO2wHXDAegcH4rVPmPrxTgc1mZgdABPHxBMXhtpLGizyHHpvfnKDTcklPpsnxHMJbqdt5t83dKOq2wZBNEt5BUgP6c4DmViUakI7Kc2UgyawnR6ciGBW0igncYUCL64DBQJehkNN/bSC/9I9pLT06cD2ftickCu2TTUZVblHqSJ5bXH6ec/MwCBPEKpwmpZECzWcY65aqOlXYeV8FRO7NGPdcOX7pD911WPwQYAjW76wf16c0ZwxlMZe+4JUE26T74CgC7T+T2mmXBNTXg1yqnSA138f6ieT3J6xV8HgpdF3DmtPFg5/1JLEV+AgCVr4NPO3cttEMNbvYutqSjXLD6GXHCkPLJo63NXjcM0kkfouBI1Q7Dhtp5cnClCcBiY7cqPcqGdfZZGFDpOgVW6rVgbkBjBjA9Uz/7aP5NUr0M6c8LgRfhZDv3wEszKtQDqiMr54tfyJzVoGN1nQ4m+qMjul7SQLbBTdbHXSuw/7Aw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(107886003)(6486002)(966005)(5660300002)(83380400001)(8936002)(36756003)(26005)(2616005)(6666004)(2906002)(508600001)(38100700002)(66476007)(316002)(86362001)(6916009)(66556008)(8676002)(4326008)(6512007)(6506007)(66946007)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eg2KhLDtsx5/hahPeLgI5h5/Ob5tNTc60Tpq7IPmz8lxpaZ3KHqFRKS9PKh1?=
 =?us-ascii?Q?vwMmbX2Xx1ikveQWtZlMOemT5Q+JLDZxrnkgIRvruobAcGzTDNhBRZCyeKg6?=
 =?us-ascii?Q?HM609WxNGW69a51O8SHUAoMnJSgl/OGd/wrU0OIujB3Gc6KTBYnZdSKYb/so?=
 =?us-ascii?Q?cOi4Eg7DTSFrzCub7ubsr48mZ3/uNyu03D/cF5J1/wuCLLd8L7V61r8Q+6qp?=
 =?us-ascii?Q?PIhdtdl31z33ToWgfU59hNsK6UTIhS4i1n4NGoYvHDjOUzKrXWZtC1JUcm3n?=
 =?us-ascii?Q?zBJgSbNL4D04Cigc7ZOFNqJamV1W2DMCsCjsqTug4Xq2wemnLcrc0Y3Y57zh?=
 =?us-ascii?Q?6sIOfqV+yNrqWtUI+sHBFBXhtxewUbllknnZlFcXWtDWrRjeG5o1mCH9mUIH?=
 =?us-ascii?Q?QEEiJz7UUuxxH8Bz8/N9Tg6Gc4ZbeN0yw3S3xtmm9+m6g3UXPzDI/6+szTSJ?=
 =?us-ascii?Q?m2m8cweZE7CnrWB7dMTkTKcQr9OKz6I9AIzg5L5vU6tT72WqUjboy+wNqJui?=
 =?us-ascii?Q?9KHeu3eOrKEAK+25e64uglxXKA1lLTjPGSp2YOZ2i88KZkForHnQfWlxxMYB?=
 =?us-ascii?Q?eqoIGDtceuZ5w/tQSHr1GzHJGJNsETyc6ROULUGkdS4QXz68IO55jmDMIlz1?=
 =?us-ascii?Q?szV432SiJ1TsSwqBy7DBjAhR5FKYw3GBqlXEe2cI++TsA6XTcxwsoeG7+Ty8?=
 =?us-ascii?Q?ujeGDiWHPC4vI2q61u++CKW8r5y6KQed95Guvr9/so/q8fbprfhTDaCB1Jbs?=
 =?us-ascii?Q?dECORLDOE1xBxUINYcz4ur9IFVSM8/XNVg+8WMGbITbzHK6cSnkE5mlEp+yT?=
 =?us-ascii?Q?XpO7Wrm9rx/tg0WR0oqytTqI4KgYjMDCho3V0dk109AQY4UwSJWZHJiOSOv1?=
 =?us-ascii?Q?rq2CuKJj9sN4MGFHX/2Oqv6kdIki/7zDIInRmLDL+gP7cbj/n/bCaUyXNOkj?=
 =?us-ascii?Q?+WRx6SztCzNF82ogHQ/70ycj2gRLBYZ1lUe62k83YB6guv6debxOU9HmDdH0?=
 =?us-ascii?Q?x5rky84ZBnGDhjB2lCWFCXrQZ/zLC10aNh4hFLfayd4E605DTCmBIprfSHBx?=
 =?us-ascii?Q?V6f9CD23qe6iy8/yGdsIHx1KwZZNT8tmN/APPCVQ0eGdEb5yA5GbO+q3IAjG?=
 =?us-ascii?Q?x5IgqmTBtkASDiB0IGKKWU7OJz8WGJwes5/SCibj5UInAGgjA1UoonMu/n0J?=
 =?us-ascii?Q?xRP1mEgro/RtzIhagq8tRAg3i67a5f5lhy+p6bUAYUEMtrIYHmrCGlmy5LwO?=
 =?us-ascii?Q?MkS8OkL7G/+fnmLGTUXSRkhkCg925osy7V0pxcqopjypDEb14MEnIBJhUn+F?=
 =?us-ascii?Q?O2dtG1iaGPFKJCwI6GfhnbiMPV+As5NmrcOV2YI6of1V+ZUOvWu5mHX1uV1H?=
 =?us-ascii?Q?/luWtrxcN6dJws8wpKYJXkbIpQz14VuE5IRZimef2gu7niElMDP5FL0oVnxS?=
 =?us-ascii?Q?kDG8ZMDv9IImRo06LLaYnDrw7xP7Qodp9bmtSOIMiTJyj2Q7CHv9wrLFkEMF?=
 =?us-ascii?Q?rBE/pQ6+p4Ncwm2VSLCbCPXux5gPsSH0RMEatZN6GIZQsmaLb83VmPKZl3T+?=
 =?us-ascii?Q?EsKD91IIHg5sZbP0343ykGmkbU9vsyOZZdUXKPq0FmUEXkN6AVp3UNyMnzgt?=
 =?us-ascii?Q?uq633a60UXvpc/IRfHJioE6a4UAmMyqopwn1An4bhJnNEnqb41n7TxVHxyKm?=
 =?us-ascii?Q?hQ5g03HBHa8Axm6ggl+kJErhooP19aCh+Q7BxCtk4h437YPEjaR43BvBv+de?=
 =?us-ascii?Q?EU2W5VD9yhuMBoT8WDGsAtce9xC5P20=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0526e46c-3155-4e5f-bca6-08da15e038d6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 02:10:00.0707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdwBytZD05zW0j5d8KUPUvmXu1MO8gd9ja9wGa+QvqKr85qEH+0mUqo4dRmlzsklYjCGKE17X+CqfjqkJ8qyZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7189

v9:
 - patch 2: add the missing mptcp_sched_init() invoking in
   mptcp_proto_init().
 - patch 5: set last_snd after invoking get_subflow().
 - patch 7: merge the squash-to patch.

base-commit: export/20220402T105856

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
 net/mptcp/protocol.c                          |  17 ++-
 net/mptcp/protocol.h                          |  19 +++
 net/mptcp/sched.c                             | 104 ++++++++++++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  12 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 114 ++++++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  30 +++++
 12 files changed, 433 insertions(+), 6 deletions(-)
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

--=20
2.34.1

