Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120E57A
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 06:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650522138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TbJXrCDfDDSDGEBKljDteZdY5CqlmfLh6QwTQOngZEo=;
	b=YwIVDNz1Jv+ZeLME0lUfYEdOjvtSEOR/+DVYovKIIbjfG4dKqfXA6E8Dn1E82E8imzmWWZ
	o7cciGgno+zTOsEUlgh8dupb4+XijDr5SPQooG/yUDHXMdl94dnsP0+NJBs9xMai/ATbBr
	zRA6Sqojd81iPMvR7ZOkPUDvbogZ8Cs=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2110.outbound.protection.outlook.com [104.47.17.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-HqoLj6u8PbigJ07sX31GoA-1; Thu, 21 Apr 2022 08:22:17 +0200
X-MC-Unique: HqoLj6u8PbigJ07sX31GoA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2v5zlXDSnmskdrUn18YJJHRpw92VLDalYW8V+B6gkScuW3naXyK/L6sh2xhNeguvjh9uMJDM0v1+mxMfxp1a+VGNw1uSer3LN7BqGNgvc8Y01GAQyaQ3WhQ614GyvV8r+HE4iERXFDc3Of+LaXV7Qad6fE1zHb0eSsNKvPdI/hQNwGKSgl/3DtvY7IPS6c5He/fS2xpgmMwHA7lvUZdDTRYoTJ01eiQpJtj0bJkjMBX59vWFX6DIpXq4fHfs1H9tAogj3XsD+0yDO2aMzQ4HpNeDa6d8jzZjfhh6zCsHraJ0VqiPo6DGp0EWoMiNflIKQ2mNRiDdhx++Ci1rcfWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8n2gVxYm49PadlxhYZCAHCPaKZ3x/iCsDZVKfZR+xOw=;
 b=YoUktywUdaxtEDR18FJ629G5szGBmizztZLUbuG7nJvugmGT22EHE/y2huKeLLs7pDM9dc/gC9g8JOwtAb5oISOnKbCKi4xFL5KD3cam1cJEopwU//+anwUWzja8QDGCIf1gNP6jqYVY4bFxW48lIiw3M8osOPywFz2bIH/oqLNGZwt9OoPZy9FKMRquvh07Ypx21UpEbvMxfxNRF5IpgGXRRwi1Za9KtbEdRDyJIJ6qECkb+wiqK6LVzdDazNWAzrX5ES206ZrMnhc+a32gbXeBGXwoMybeTvNw9zk3HABrVwEjILW3DC0Jqntno8hOdg6669EIuh3c2mhBNVxADA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 06:22:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 06:22:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 0/9] BPF packet scheduler
Date: Thu, 21 Apr 2022 14:22:18 +0800
Message-ID: <cover.1650521788.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:202:2e::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7334072c-ed90-486a-7aab-08da235f472f
X-MS-TrafficTypeDiagnostic: AM9PR04MB8100:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB81008BA088AC66E85DCA2D83F8F49@AM9PR04MB8100.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x0xlogKR7eR8C8wsJ6N9ZQP9k7Hnth5AD5ZpHW1xIW0lxwX58/hyopQzjBV9w4yuFOsvF9SD5Cz4J3TIli29rFONP7SHSw54ULS+z6Poflpr/FlnsvuWBbbKqseX6qsB8nF4nJ09dskR8bc18sCj2N1St954RxKiM2ofvUZ6HvEgRewncb9qsL6LrG9yC96aIoaYnN6fg15Vpbt1+z7r2QTrdhHrUk3eO9dJTtHzDKa/Lu3dr+ZEhk2Wx95EjCP9aeQmwveU/+zH1JV18sEv/9q3SV5uSzvvkPhN1pys+UJb8TAn7IGucmzkVFhe00FUqYQFMQ/XJ4nZgTSoaIGJfFQ4WKJ/NN8EnvxIlNFUX3eEbCIwmK8g0mGuwkO+BEx02mttKdHrhYbquWUk9uinJlgWoIQM46Re53gjT2ukCOo5QfBL4rminS5QhLtmJgocsSJkc+4JKe5/cqvIEuJx7TRQH1nv/hAgJB6EBaIJzXh2YeRfFD9IdqLtm2rg+ChOr9MwdQSvg4pGH1seHobfOlLQihPNggkzwwU7lNaaFf86gDAN1JFdKfJEStZL+eZ2vrQjDD+/AUDZFHm/8ncqb77NGylscZRLfVxNiQ9Be5ogyEd9c8QFkodH6g2YhaFRumUjfexxur7BkSnCr+s3+7+U2WNbriiDWGHYd2uy5l2daxAh5yzKtNUvG1OYcB4UHzGhlLNsR8+QpK9HycaFNCY4JS4ynWnqyAmaf+L6ABwLWx3Rdy5KJtlxlhk7oqTYJrPHxuYdKzPg4fgaDAxTlQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(86362001)(6512007)(26005)(316002)(6916009)(508600001)(6506007)(966005)(6486002)(38100700002)(66946007)(66556008)(107886003)(186003)(83380400001)(66476007)(36756003)(2906002)(4326008)(5660300002)(8936002)(44832011)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fVNkWYIOiQ/HOijF1Lo183nOjTbgZmYZHxVVJdkETli31Xwy2uWsXC8wwto+?=
 =?us-ascii?Q?qtBPLcHczwATVwupPkIvEN+Hz+EsFOdtF1HGLe1VdVSFAFtjw+Jefjs7lHfR?=
 =?us-ascii?Q?hC1VVBZNAVtYb2xF+G5bWc141hPUXCyoJlJKaP0+MTE/YEsR1SJaJKgHIyA5?=
 =?us-ascii?Q?hEzFkxAugv37KJPb+W68AJg8PZv9DLOAHHXDtBjqEpUmRiVrnsSwipiLdmzl?=
 =?us-ascii?Q?TfrB5RLvrDtYl7sGf74USQHoR2ow/Mh1f/aHjUpnPBxOcNm//M255tzcx3Y6?=
 =?us-ascii?Q?9kncTvHce9hbNkI5ybBLEoOZay1cmhIkjjUGxXfJD+N8uqQdMjcyO7eGS2GC?=
 =?us-ascii?Q?QNbB3021KsI8FxNkobqg0+LXBs+64w9KaNe4kqueNzc8MfipLGdi4wKDXTZF?=
 =?us-ascii?Q?n737UeXppyBymSuBHhbY2SseQgU3yXSkVKPADsex7dyC59+jebuJ5kR3BcK2?=
 =?us-ascii?Q?HAbv4qQfHfl0SSrnvZvRCoPPYJ+3WOfmpjSo8tkzKbIEhbosrtHU8ksV+fKb?=
 =?us-ascii?Q?HlFzkGsO/PBGM04NczUwwKNGLeb8y3RmqjNSR7XcOKEMhcuPQJ6eDEGMzxoW?=
 =?us-ascii?Q?YZkZAjHJPLvz9hTcXNMBsy2hfxmI0+vx2eJp6H+n7ojiMVIzct9Do2YsZ9BT?=
 =?us-ascii?Q?LOjPJJJ2eqNdB4gVylig3w8e2ODITA4kmDI4+7i+kMLIiy1CQNF0ydkI5GBA?=
 =?us-ascii?Q?+LW7ExJayLFx4eEHdMRRcrxnQqsHCvQNLmBThTTroGdfda94oI20uu/m3XQZ?=
 =?us-ascii?Q?9cj1+F3wqaWY9U+C9izlHUtxwda27MIAiO5RazrTd0Rv6uZ9q80YnuVCSQjm?=
 =?us-ascii?Q?aKPLAyS78iJJQRJykS7RKhI/Exa/1UKfZSheKoVzgj5F7vpuJVtY7i/17HtD?=
 =?us-ascii?Q?9wTOAgOHAmGrOXNTI2FwqWGD1kWeUDqMb2rf/7KwAaWyk6XPRYHDrzH8JG46?=
 =?us-ascii?Q?GFRm1OPGJdfO0bcJXqt0JaMaDtvW2zJmFCSHm/XsGu51XQBcoZMX28MMAjCf?=
 =?us-ascii?Q?hEjSpQIDwGrSqRxB9SuYKlnY8zm6kfvuy5d8BjikPsGoGAZfOMWPEqhokdSl?=
 =?us-ascii?Q?7T4qO0kZrNv1BGb8pxSs2BogloBIm9EswDT1oYGblne4e6/bg/17SUouObsd?=
 =?us-ascii?Q?QcWq3ywUq2qS+YLPcpFEHeot/Gy6Q5RK+lJPYguKgY/TMo1L/l7mwTujugjP?=
 =?us-ascii?Q?O253FutgSgdexLm/mnrdtBsJvPthvoa5SwWKoYuVKY/3tguSDLCvxbTuQO1A?=
 =?us-ascii?Q?wu0azramUAPSu7kiDyqc8ZUnfvh4hiwv+ioVDnTClTYvHV94drvvVs5XimH2?=
 =?us-ascii?Q?vkH7KON3LW994GZqwAE8fRHwQwR/RkVm4QE36GiOSSVYfuU5xzoUX99vc81y?=
 =?us-ascii?Q?scBEqTl5vQR8IRial8sw2+PpppoTyspjZ/qtBIoJ/t/yyyFRrTvdrhipld9N?=
 =?us-ascii?Q?8vDEBKQhpL81H8pkv5Kh8irABTgEWPsObAMWpa6CBB0dRU5fhcSpIZ9qLLIL?=
 =?us-ascii?Q?EwC5ZQFMGKRuO/Apo9vtcubApnot7FsNoog1Q4WilCuA+j45Mc4tWpIjN1KE?=
 =?us-ascii?Q?RyXRkr0rjlyCVaDdetIidCyRvKehSpFAFEIG7sbSt4UQT/QF+Be59BRiEXaM?=
 =?us-ascii?Q?MrQscpOCrvWYq1ObC2smv48DOBu5VaZ/oY0DWvwuY7vI6F3SHETDDPqOKwSX?=
 =?us-ascii?Q?kQij/VvPS7zzFhFA/YsbGpo7jNZ34/UOOgulIuNrkeGMBfIpNRbmkM9NfHaf?=
 =?us-ascii?Q?EtFG9FW87Udl0v6j7qAcOzSyKyYAGJc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7334072c-ed90-486a-7aab-08da235f472f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 06:22:15.3724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RC9+86uAylonXGUxPCzxSbxVO1iXarcgJZJGw0uArI/6cqOgy4nU6pwmoznLKMfYILtqrs9yw0BaGqOhWgybHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8100

v13:
 - rename retrans to reinject
 - drop "add last_snd write access" patch
 - change %lu to %zu to fix the build break on i386.

base-commit: export/20220420T152103

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

Geliang Tang (9):
  mptcp: add struct mptcp_sched_ops
  mptcp: register default scheduler
  mptcp: add a new sysctl scheduler
  mptcp: add sched in mptcp_sock
  mptcp: add get_subflow wrapper
  mptcp: add bpf_mptcp_sched_ops
  mptcp: add call_me_again flag
  selftests: bpf: add bpf_first scheduler
  selftests: bpf: add bpf_first test

 Documentation/networking/mptcp-sysctl.rst     |   8 +
 include/net/mptcp.h                           |  13 ++
 kernel/bpf/bpf_struct_ops_types.h             |   4 +
 net/mptcp/Makefile                            |   2 +-
 net/mptcp/bpf.c                               | 145 ++++++++++++++++++
 net/mptcp/ctrl.c                              |  14 ++
 net/mptcp/protocol.c                          |  25 ++-
 net/mptcp/protocol.h                          |  22 +++
 net/mptcp/sched.c                             | 105 +++++++++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  14 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 113 ++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  33 ++++
 12 files changed, 492 insertions(+), 6 deletions(-)
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

--=20
2.34.1

