Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8428E0
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 16:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648224750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QtjvyU9aOEPBGLzEGyIb8ErK+k5uInPy0LUr6OJzhg0=;
	b=j0Ef91SfAeSjE2SBlmyJkwx5Am6J0tYmIHSttGXzGNkmtMXexI8g2EaSrkAwnAdOSX6pZY
	d98+9du2GDerk8qRtA05ie0i5bTH8maPDPIPw49TcRUjTTLQKJW9K+f9ReUrB57WklS3Pn
	RPdtdP/MD193irBRLRGBO+tcwhs4NWE=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2052.outbound.protection.outlook.com [104.47.1.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-wdqS_LApPdGxTYuMupyWkA-1; Fri, 25 Mar 2022 17:12:28 +0100
X-MC-Unique: wdqS_LApPdGxTYuMupyWkA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BinhtTqhP6VxNbrUr8BfildM4iTaQZru0Afc/w6EgXldS4qJGYn/56rGrpX+ARrKsguww3d+BApfx5iba1gxLYiBUDlisvghSQApYuWqp6HRxz+CIwiCM5gm7TbMnMHXowdLmOLJrNO9UdxixxZQwZ7FemNuQfkc45OIPVzCjt7RYrbsJZiG1t+HLcCsUfpu1dkeOdLNfGQNU/x6WGeIYholSTwr7A0Uip84VihDSnPXzZmBrWPRYml+7TLGmrgxsokwOCL0QwTNWZpFbzoQ5u+06ZJjA6a0i+Wld861Dc3BjZyzQXWXOJ2J9CPBRP4aGzSsL2eHoGsNaEXu6402Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Je+nwPPiSrmiTb+i2vDKojAkjhyQlj4YfnvGnrRuY7Y=;
 b=a6QnYIMIs8AJVkN/sHuBslad5i0l/CrtUgQZ93gB7L6HQvKruPnCN/U2+TmhsoIURyvrknnG5ryoK+0j9009jNb5Zw07dq/a7Fn4Nvv9/1ivK2DUgrCyUMqZ0oOqk87fH+HwPPbYWEAs2aiQFpgroF1qkFaJkDZWQYabVUAgYtFzgUxOYEa7o1RS33oCst+IaBwa3iDpkh9tzxDkWB3tZ7h1PKNsRUEKbiE68WOESFWEGpeyh4k1Gxt8nl2wM2qjtuNpDKyjlEepxaBigVu24IT4kXh1vJHK9CUPM7vUXdajMsov1iA8LeaepA2plsRgy5fEg9qfufP3evVK6T2TDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3938.eurprd04.prod.outlook.com (2603:10a6:208:7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 16:12:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 16:12:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 0/8] BPF packet scheduler
Date: Sat, 26 Mar 2022 00:11:56 +0800
Message-ID: <cover.1648223504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f5600b5-bfb6-4ed6-bb83-08da0e7a40cb
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3938:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB39384F0E783AFD82BC4E1562F81A9@AM0PR0402MB3938.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B/0oNcwhZ6DdPUGh5sX/ICLM5dbcJBg1Q3hkfbutxTuccWb+ZF0aoxAYC8v4Jp1ZnfS+Xa2xvXTuT28wezEjE1gWqp+kvuFn7VDDYoTysIy7enSwJvFY6N7JeR+Dyzli6hN9vZTCPqKmUsArhi859qHC961eiXm9rZBLmqy2VLheai9cYV0HuocZwZ5RSxohmpNOgdkkiHa87dlELsAblczHd3o42eXIrmA1lAjR9zWgluoGPGKrmi53E5pPg++Z1TaVqJmJTUbu8KKLy0M+78EBMqH4mFRnYgTRDl6U7cUVGRDNpPhjR6l24KsHNuoSyxNySarCLP9+boy6xm3igCOMbrT2+6uzWH4AJQzseA3MJrCzmAWzCfdOzCyU9kLhu8CcEAim57OqpBxaKgKeTMJytVi2rHbwAm80sUyeA0fPpsanr7/hozGnlANJ476ziZ975srEoOB/bkcML8/4/4Jsl6KrHIBIDqCPVull6WPCJLjYBAoNsJFzKWTjYllXHZzjMDWYJeyd3qhgCKvm0zDqS60scv9n+CpemMWzYzkybdqF/z55kNhtJPG2bgb7N1KsrDWg25SqCEt5xD7uovtC6JJmZ5nznmq2pAsuOiOydjC4Fp6jVHxTQvV91QBNAaBMbW5TWuiMpy5Uu2Rdt7uqod5OjF+VwzZrYDPRmnkPBRDzVsRyKZangOS47XYpG0OYDg5/SK0nU//Sq5tdXSgoR02UymZ+oHYcsvlpJTS9759DKhUDR01OycHxqgygDQ7YhNzani7WREAz8EnDhw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(4326008)(508600001)(8936002)(186003)(26005)(8676002)(66476007)(66946007)(2906002)(38100700002)(44832011)(5660300002)(66556008)(966005)(83380400001)(2616005)(86362001)(6486002)(6512007)(6666004)(6506007)(107886003)(6916009)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mPNRah8A0poLenFRQ8bdUIs4OmwVcQPZQ9C0A4hVHE8Vv4Fo4x2xJALj/oIJ?=
 =?us-ascii?Q?is3mrjIp2C+sQM7Uyt2PGNnLJVCZoJJ1OzuLGnTnOnVVNfN2Zn8LEgTcc0P9?=
 =?us-ascii?Q?foqANGPLwGQxicbeMhfjAZ5om1awnMmAV5QtNGJU5J2quyOVaI30Z4d/Epzf?=
 =?us-ascii?Q?Ah6t7x3YaoBpcEhwP0IOffeUA5+igtAoI4xInpKDJNcbZZCRBuODmNs3t44f?=
 =?us-ascii?Q?i7j82AZR6uWsjZhVKGfnBdw58uLi5sudCAZt3YKNHi8Xv5lQrVBfCjW4vtft?=
 =?us-ascii?Q?OaxcqZESMcrYf4yh0LSmbKNQtfMQXDwL5SGGx8Owkm90Sf/+TLCfLX5t+yIW?=
 =?us-ascii?Q?hECcl+egsDxGoPexiSJpbUdxpxvRrclpFv/yIaazR2gE8WpSnBqOqGcNkDzT?=
 =?us-ascii?Q?eAKB1CxV2hnnoyY+21/BukeBTZob73q91nr+zAHMi/cHcM/AyQsPxc6dDOtX?=
 =?us-ascii?Q?3Kr/erqdLp2qNGPUmJFgpKLABQw/NJvjkxGH5yPY41Zu6hixGdBXBVnLIKIf?=
 =?us-ascii?Q?1LLhhUz/xf8CFCuki52obVkUaYVeGR3Xu6mD+mp0ropMR0dkoZRK+DIiQqRo?=
 =?us-ascii?Q?EdFqHzzSPuerrYIIDiRydKRwfRyHTqT3k7KaZ3q1nj6+CoAzHP5gvUoReINz?=
 =?us-ascii?Q?I26yeAOVn5LJl0N52sHSkjFuuhw36WZiV8MU4JmNxAjHW1Zy+U7c6a+Gpj4n?=
 =?us-ascii?Q?IakkOdNaoch78qDcHLQRZH/KcfOeIqx7vwKLw1S0He8eggYLAIZorz9IMa+w?=
 =?us-ascii?Q?kzvl+YIP9Vd+JhPmYxbaICaH/f8am0FzupF+mDxy9fg61h+sCgBKzdGg6rFC?=
 =?us-ascii?Q?0dVKDWO1WDJmt/u+hUA1bkeS3cLY7c/x9gEDOfcZbwdTxe5TbfQAABxorqhs?=
 =?us-ascii?Q?xgahsRaofHAIxQQdHJlBZzie93Zpt+a9F0JLFmZeGfFcPRZl05ipGk9p9oOh?=
 =?us-ascii?Q?IV8q2H9+DpH5kM7HkamtoAg15g+UI8fhvFWw40YGbH5nZwTaSACBpnG7O7/Z?=
 =?us-ascii?Q?Fx7D1Ih0r/AORmgzEpLvd5iVO4TU3DWwdogAvZ0yUHRXXP7LfJ8QDNUr88/B?=
 =?us-ascii?Q?d4oirgduQjQm6goQllwafnZcuBCMJp+EJsAwCGy3SzUM6ptpTQ9zPON5w7a7?=
 =?us-ascii?Q?n7vLfYFfSijD7S272c2mb+2chmZMZJSbJKMJpQGmHP64MYScbjpjIRmd52BO?=
 =?us-ascii?Q?A9rtD1c92qUbigEcQDQM1f9qfhFKRwN5ORGgDm+tjDdlcJjx7kLgA2BliYae?=
 =?us-ascii?Q?t50SWLVUei9JNNcrtmryau7p6y2pez7oWYhfSaAMPBfcnyt7XZYLx5WGUE/S?=
 =?us-ascii?Q?qy5jkCv5FeYU2FK2ubIRrtESfUxR1P9JrWblJUYLZNe290HKjnFacttD2AaM?=
 =?us-ascii?Q?3LvNGQlxV7tTlr5oRLAgDH7gWDZBlehCF0gPAINBpIFygqzAy4mTkzSPdgds?=
 =?us-ascii?Q?MlZuSB2vK556/cQdGz5kVor72Dhn3tgU43C/d3OggiziRGkHtyvnEs92Dusa?=
 =?us-ascii?Q?fGqE7hGurYgf/+HPpNACI49/M6nvPNqG0bltaG+Uc1GFjC9yfLPJgU+f05Ht?=
 =?us-ascii?Q?5cIk1ulA0vYY/SwGl7tORmZvTIC+Ram5aqQyBN8j99cTVtDYUYoObVNawghJ?=
 =?us-ascii?Q?IcfQeHheH824mzxwjJil4aYSjfciQYA0NHxfDbZJkpHdxKqi7J5oeW/+3pxE?=
 =?us-ascii?Q?gdqKK162UWHaGkXeJMHZrdvxeMHOrFLNTkLUKc+7v9957SqJtHVURc2CmZHr?=
 =?us-ascii?Q?gxDPob7MG3M3nzxr5FbYsZn5rcQpLY8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5600b5-bfb6-4ed6-bb83-08da0e7a40cb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 16:12:26.6613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8izS+hAixV6jUwjK9J3EnLNP48OU/LSZ5qhy66USBdtGR0aU53EX850F6jL+bEXjRFxnh4yypDzoxy3GUDnZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3938

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
 - depends on: "add skc_to_mptcp_sock" v13.
 - export/20220325T055307

RESEND:
 - rebased to export/20220324T054815.

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

 Documentation/networking/mptcp-sysctl.rst     |   8 +
 include/net/mptcp.h                           |  13 ++
 kernel/bpf/bpf_struct_ops_types.h             |   4 +
 net/mptcp/Makefile                            |   2 +-
 net/mptcp/bpf.c                               | 103 ++++++++++++
 net/mptcp/ctrl.c                              |  14 ++
 net/mptcp/protocol.c                          |  14 +-
 net/mptcp/protocol.h                          |  20 +++
 net/mptcp/sched.c                             | 148 ++++++++++++++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  12 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 114 ++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_first.c |  30 ++++
 12 files changed, 477 insertions(+), 5 deletions(-)
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_first.c

--=20
2.34.1

