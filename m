Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62877A
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 04:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650430620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JS8I1yorThJvAc1jjHW5tU7Q/5uTp12Km4HqOBZ6n5E=;
	b=K+wM7OyNYIa8LNZeUzTvyxgSGQoqBZ0KivosZh4X6VuHkJbclE3fXSC04GPlXpOjC+Hnxg
	aAscM7MHUpWV0utNljmxKm+9vLjUPfY3ijBk+kREf9xIzWidTPnk38UB8CXQc2CLnSVtIA
	dcZ7wkcmO3bWiPpmLsTQhut422FHg78=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-OKW_-XNcNjC-8JF8OqFr1g-1; Wed, 20 Apr 2022 06:56:59 +0200
X-MC-Unique: OKW_-XNcNjC-8JF8OqFr1g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtXGYDa4eoe1UAc+ztR2DCr9hw9+p8NZsmzbRolS17TIa2BtB7Z7z6kwkYAX+hYhafUXlleScLUcycLw90HZ5gw7V2wPM8rvcgGw0QzkdT+QPJGj5QElr3RDOpfzxVqdhMeChgSVCkyhLYTE0vI7BFP8P6Tzlg8plxit4HQobGqMAnBoXJHeA5nQbOeyxmewfML+io750J3PW3qKV1XZ+D/iSoKLk2v4Iq4k2LVDaRlnpQTJuOD5RqXnTASk9nFCob98ZdVJc4AR0VLD8SkQeFQ/3G7QoVnvpKrmOdEKaKTZPB6yF/9bhn8urUiNRUzbc4mietRJ/TD2CSefQJkPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TviwWcKMg3gClxiWzPBZrBjh+vIbMQJ8WECUHXQYfa8=;
 b=Rj5oVefwbSY+Mzxuhnr/o1sWh2niJtdcjVNHVCgHXqar8woMET0Y9XWXv44awJRyf5Pbr0WevPMoNK92ZhrRakvFQmvOfVukjfCwRlMJulZbWRMHP4N1THatIodRUvM5cjLORyhQ0cmz+ATHx/gEGNzYpvqqdHI4M+gZNp8ZxxcpFYdpWwEUPlnCDn7YcosXv12DPlWDTDBftsMwUUovfjDxwkwkawYHJN4KLFLUjR+3HJV5XF6jvf8X2Ydr76TunhBRFtaFrJuLEgve1Xl/mN5w+cch+56q1/eh9Ls1B6UvJ13/tiTdawJkYar3n6sVPlR86scAejXOD2u1lFi0ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5752.eurprd04.prod.outlook.com (2603:10a6:20b:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 04:56:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 04:56:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 00/10] BPF packet scheduler
Date: Wed, 20 Apr 2022 12:56:59 +0800
Message-ID: <cover.1650430388.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0059.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eebf047-84d9-46c2-1a72-08da228a325e
X-MS-TrafficTypeDiagnostic: AM6PR04MB5752:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB575220CD047CA3EFDB0DD4F9F8F59@AM6PR04MB5752.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F+2Rzlf9GWKjmfiTPHGB5BlPTFYkZx0bSvTRMyWH8nle/hBThRX4lL1NJCTFzxxlUy+l2FnGT3oP8/4/fu6rxKffLVnzJVQkIoWMPOVlQC+NVo+HEiypbJ1QmhLC/tF9RA1/xoJchsG9mtwsUZPUaeNrj5Mn5/Lx4VbFlpiropoysjK9cFP8Hv0dMw+3oew/QG6gmJpKC1nFI4D21d4M90bKaag1GGiszUKu2jetw4EvF05ySkTPbwSDBqxmwcnJ5+HHzDx4XTTcDLPJt+aSiGCd1EuDeVA+ouPwcjH0eHyz/l2DU8cRkkmjC3S+RQWWK1UMvTevT5kFsoBfmooctMxovhuQPPZNUP4GwyAUZGKrVHZWS+Okfluzd6VbI+GWIhwlwHi7kTUn276vt8FaOwMuZ3PtheYfwG3bKAHwYxWkVoIphku0tivwmOoDZalOjCZZXfJ/9y2quZqvBdrg/CuEFyPm1hS7FXeGxzJojQ38VUow3DSbAjK68TSaB6+TSvb+FfezI4BsVwb4542DywM4YnviOfMA6V9NIkk6XMom7jwrCkAvEeEOgGxSPVyBmCEsSSJPhHB721utcExhnYt5zBE/By42awsEsjuKWH93SKiMGLkuZMd28Qb9sCqi3r6opq0Oniph9DgP6TJQh8rvwLgKkT+SxO3x5MXOc/olvv4c/y+VsFA1VfFCIjD3aBMmwQoyxq0TKwE7l0lGUmyI5SohnRKOwlT0m+bCwiE4slze9RqRNc2KRUwbxXksCOq29Jjl6zHU5jlzDF+E/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(38100700002)(508600001)(36756003)(316002)(6916009)(6486002)(66946007)(4326008)(966005)(2906002)(8936002)(8676002)(86362001)(6506007)(44832011)(107886003)(6512007)(66556008)(66476007)(5660300002)(186003)(83380400001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tVnpqnY5UF4UrNYTmF+AaSeqHxj1DbZruxmKJY/VLk9Tkn/n1rDYl9QqBx+L?=
 =?us-ascii?Q?JIY4JFWz5H3jqS7X2h5JeOEsiwNWoC1Ipq4OmC7rJBBsw+D+TzJo+VDJBIIG?=
 =?us-ascii?Q?PnTSFUHLCQyj9ih8JYeZ2cUmlKsJIusW8PwYw0W8pC3YKDwaG3wxbJJcLKaZ?=
 =?us-ascii?Q?osuNwL3tecKhfrDGiP+Uqk/I2mamQuxN/CZwScX8/xNbsQ5y17K/EK39kNqe?=
 =?us-ascii?Q?4vgKy7NLiIDZrA6YY2x1nD3FAKRYNNjVU6AsyVUL1Vg7qkmrZiKxoVKkeKIc?=
 =?us-ascii?Q?FcKhPBj4+4G+EFTzU7mhfKanLm2YTVwfrl6gb+bYxWJxJiaQFxMOje0Yx1Wa?=
 =?us-ascii?Q?T+FEpro5xDlVuuTQNK2xwSyYPFKhtM+6sU4dm28At7Jchm8LJEuskwiGsyRs?=
 =?us-ascii?Q?zWWISa/xfp5bX8qLSj8F22XqPI99UPf17YjLKWCGBYvqDGh3RbWlwEfq4suS?=
 =?us-ascii?Q?Ge4ZbYWoyB2na0K4oJyrgU+DSdDesglWcuwpYpSrc2OwcLvifWD1RZzzdfGI?=
 =?us-ascii?Q?7hYL7amzAWysXU+osSHuV3xU3vAnBbZvwtntP9p91PZ/ryd7uHD4ia6z+8wR?=
 =?us-ascii?Q?A/rlW/KqOFyNLTkdKYPa9ZLSXKy9p3UigktvVEJh+4EgdxoaVQ0R3Y9myujU?=
 =?us-ascii?Q?kusTAFrz36fWdnPKoIAplH9XltKeDJYPsqM+OeMjJHeX7jNsPLt1MCslAGvQ?=
 =?us-ascii?Q?1WMYIr8Oh1roh1y1vZaXR8NlUAIOfwI4g0aVdEYE5+6LttzV1NT6n0gkXOcp?=
 =?us-ascii?Q?15U7f7O0yc7vNRxpZdChE5g+usfrvrxPdLoKEOorIwI0MN2JotMgDBdn/cCf?=
 =?us-ascii?Q?8nqZfQQaYgCsXq76l9vjLgHwGA07lSa2fylv1zvBqXV7hTwKgCnsD7IiPkeN?=
 =?us-ascii?Q?KKNqJnr6p1q1sqP6n6Zeo1dzF8wllTt26cdQrWYbS819Nf+stPLl93fhk8U5?=
 =?us-ascii?Q?/2QKjjDsRw2vEcW6g7NwQi3mimX5nfsAPDAKp3SCl0ZsxUKV7jDcwfnhLUIV?=
 =?us-ascii?Q?SaVnabfKbZL4Iol8v7Hhw6C2YdynFvPYq3a0Xlm4d9LPBN3PZ7OA3k0LLDTK?=
 =?us-ascii?Q?MzfvoaZZXs9/VkQo9jwparu51O1dZ+bS4V0OjyGifLQIM/3kg0+wr+hFxje5?=
 =?us-ascii?Q?x/ZgInZpCVPDVpl86mVi1zO/IB1Q2DA/gHpL9rIvbGU15ymDDH17kWYP7smr?=
 =?us-ascii?Q?ePZ8J2a0bVimH6znm4IXRldiaddYfV78QhEFtMp7tHILoqAciYrcUtq4c1Wj?=
 =?us-ascii?Q?ZbCNZh9aMlR7mwF6cBvLIhk+kx2zQGzw09YLFp1QB23YPip2zTKqxNT8UDXd?=
 =?us-ascii?Q?VwX9JRq7YhGDSiy2uUHCTId8/qovNODLS0So/EDYC/v7weYUyIEmzp6tqy9h?=
 =?us-ascii?Q?jSa+st0KQj0S0jM0TPwP+uPJMgEqPcIjStTwj2uD25PcPTG+OnS6evxspmzK?=
 =?us-ascii?Q?wFTJQaYNKoGN6gWa8xH4qgkeLJDBlRJKxRi5LrfVfl5wC7PGifXW4pxRI2pB?=
 =?us-ascii?Q?P7Qwj82MB+t1npmdNZZqTbHfkR+4RpnFVs3m5Zn+v8jhczl1jZihtqIQHB6w?=
 =?us-ascii?Q?Q55RFE8+AIv+/4JGG5hh+yKoP5eu6pk2w0J2HAEcg6lW53zXRq5YQpXuuu8o?=
 =?us-ascii?Q?GY8zM5IXiybWLZKHa85XgnLD6DuiJf4uosE/qRKLU2osLKSfhBMdRAQQ+oXH?=
 =?us-ascii?Q?JzAv0XB9nwSvi9jHOQ4m0qSfgRTlqwQjYRWMLvSgtbx2RrHLtQsFcgP3Y5Me?=
 =?us-ascii?Q?2RMXNz9GpyQFdL90R1G9P4xUMVtLZB0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eebf047-84d9-46c2-1a72-08da228a325e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 04:56:57.5799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grHyhsdG/iFIzk3ZjROL433nbfWgRjzMDMIzocmO4szCxM4exugw3fltqtAnbC8m9SREXwWV/njGpNZNy+ozTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5752

v12:
 - add call_me_again flag.

base-commit: export/20220419T055400

v11:
 - add retrans argment for get_subflow()

base-commit: export/20220408T100826

v10:
 - patch 5: keep msk->last_snd setting in get_subflow().
 - patch 6: add bpf_mptcp_sched_btf_struct_access().
 - patch 8: use MIN() in sys/param.h, instead of defining a new one.
 - update commit logs.

base-commit: export/20220406T054706

v9:
 - patch 2: add the missing mptcp_sched_init() invoking in
   mptcp_proto_init().
 - patch 5: set last_snd after invoking get_subflow().
 - patch 7: merge the squash-to patch.

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

Geliang Tang (10):
  mptcp: add struct mptcp_sched_ops
  mptcp: register default scheduler
  mptcp: add a new sysctl scheduler
  mptcp: add sched in mptcp_sock
  mptcp: add get_subflow wrapper
  mptcp: add bpf_mptcp_sched_ops
  mptcp: add last_snd write access
  mptcp: add call_me_again flag
  selftests: bpf: add bpf_first scheduler
  selftests: bpf: add bpf_first test

 Documentation/networking/mptcp-sysctl.rst     |   8 +
 include/net/mptcp.h                           |  13 ++
 kernel/bpf/bpf_struct_ops_types.h             |   4 +
 net/mptcp/Makefile                            |   2 +-
 net/mptcp/bpf.c                               | 148 ++++++++++++++++++
 net/mptcp/ctrl.c                              |  14 ++
 net/mptcp/protocol.c                          |  24 ++-
 net/mptcp/protocol.h                          |  18 +++
 net/mptcp/sched.c                             | 105 +++++++++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  15 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 113 +++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  34 ++++
 12 files changed, 493 insertions(+), 5 deletions(-)
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

--=20
2.34.1

