Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25EF621
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 01:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651024601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XNwAcH+bYAli0xXDWmH1bNePaRizJe+2l++T7sKBVhM=;
	b=KdEFN7THjCrZKb2hYdukoxragzylUV0MDIqf1cKqhg1YfW+FKP7/n3QU5VNEHD2ZnEWmiI
	FAwQhbGPJhOwnw7yZxPvrciUytcgbqDS8gws1HZfwaVTttiVDa5Ou1s+a0tTH86Jwv/vt7
	6ri0/07nlxk6DfUUAUzgC23S5LczsZ4=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-b6GEf1NAO9yK6SVs9WXEGg-1; Wed, 27 Apr 2022 03:56:40 +0200
X-MC-Unique: b6GEf1NAO9yK6SVs9WXEGg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+DUHShLoZpNdMumhE2E/EX/x0sUSz3aPjgobA8cJDOb55CjfPQLfyx2kNrXPkLe4zZdYJDJoNwAsp6QaqlMFypho+ybEdM2dDhqadLq8wwA3PQQKaroJBWypfd1pyOOdjU9MNdgmrV46FPN5D3IeE+GVh4Gsdd55PNqgLvwZpxJ9Dsstc+qGg1wiIiP5kJjRnjdneoqOX57SWKo4pVW/DgDgtpo9rh/ZEHNlWEOq4TOfu5YoJLO3hnWnuFF7XUV0NJBAFfhTRvePqek2AG8BUPjO8waBYVJzaGkimz6l1flmFfaxM6066CMhEB0Oyckz+nu6fIo39272+8zVX+koQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVox0o4q7NBpq9p8sWUKjnU2mcFzQifQ9JgOwYNSpIQ=;
 b=FrxvxApxW7KOG7CtU1f3o3dvvvROwB1QsKtkO45OyNBzsiSJPbTvN8zU6QQiqQh9aXLh7nsPnCD5z9blX3sByNvORm/7zj0iCnccP0PWT9dYWYm5Di7FnO0iYYHA6+0S8q/mp/eWZOTNC7ayuosPm6tCrfI90+vpMFWGutwKxYY2wZRQfczeOv8z2m8zJvmaAsG6hm0EjCRcopgUE8EjhjDMX1qjYVMnc08VZdkCrOFAlfhA/jmd5bcGNpNDjR1muzLLZF5PKfUKhbgmZf26m29bzii2L7wyWj88LiFAWMrQNexn4QNeM6AdcRsjv240etUZbBhXqvd51pDJuihAzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7661.eurprd04.prod.outlook.com (2603:10a6:102:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 01:56:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 01:56:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 0/8] BPF packet scheduler
Date: Wed, 27 Apr 2022 09:56:47 +0800
Message-ID: <cover.1651024344.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98f34123-69e7-416b-2962-08da27f12a9e
X-MS-TrafficTypeDiagnostic: PA4PR04MB7661:EE_
X-Microsoft-Antispam-PRVS:
	<PA4PR04MB7661C38A74D4132E4316DB0DF8FA9@PA4PR04MB7661.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gqlfXx4mpSvEdMsm7rM/M9/cz5v/fHNZl7w+Q8MOEDn34rJEB4Jeq12IReShrPPEIRgM7O9CCb5hNjFFEasFXZOycax/hW7nwFnOeB9WTm1UbMXlCCAtYY88Hl/40x88p5rxy730zmi8viU5w5mW23tMyug3JAR6fUoVWOCOI85gdNDSFkNNWLV0FFiofR4uLGH08VoSxbGsUWvtg1WU9cs1b2EOgLTyr2EjI/L4fsd/3h3RQFEbd1upwTU28UQcwyCb1MWOlnvC1Kr0TPhOuE1hzLiqT4mPvSRRS2muQEFRQyhVr6kbuxzUnuQbbTyCEv0cq6wqWMvE373UxgePICoPk1M4onhyycaZDlz08fAHv4Lse14sZvAG4qhPyN3I+eV/VA89bXBYttwiptW15M0KqsP5rMICEDL+9AO0pzfYAg5JNuHY789lQOHCnJ9RS/rxOHxS1c7ZysBrWwUtQISRPwUiVDDhFidNXSPszf+Y6gSbR7awp4TG2PcP8YN8XZkLfoF2nvxO0DDKCzEQZWMp6Oon9AVvoLcfIeLEncoqUoG/hODIoeiroN0MgV3pvzzxsDgHKd2nBGEpmX/n6qzczIB7fR4uy4VkXR5I6XGHsHzW5riCa33iW5j8dWihjMhU2gVWwpw/6I3uOaj5lMsjrXKEcrz8VWs8xb+dFqyrzHQw1Gu8UrnRTNQ0Ud2hXS8AB7iDspOOD5RDnH3VgqEkqcHN997oed0pPD+0PhSHxZBLr4FiE8jpWWFmDdfrCkisq1gcMfwWKYK975UHBQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(86362001)(107886003)(5660300002)(6916009)(83380400001)(66476007)(66946007)(44832011)(66556008)(8676002)(316002)(186003)(26005)(2616005)(4326008)(38100700002)(2906002)(6666004)(6512007)(6506007)(508600001)(6486002)(966005)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xdHJTR70J2yjt1b87fiEkYTSTUFQarjN3NTU4LDNEFrFu4Y/u3D8zSj4wbXe?=
 =?us-ascii?Q?TRrAQDD6P1FJpRhdVU2ueh1/QeNT1v1jGGg2EcSnom6RJ5ktmkI8AydN1beU?=
 =?us-ascii?Q?pF3FiilbTOjTFjpLbxnV1KUuk3WkKeBxhfRvd1qHrN61j5grfKW19Y00TZ0t?=
 =?us-ascii?Q?scwK3mWhuTiI9tA4mebz00ivvhD8ED0t7LtGLzoyKVHLWB+Ui8iv9PRscR4P?=
 =?us-ascii?Q?Xsk7IY3sYoDpOgHLDTg9/DEsj2vjUJqBIVUYBOs+sOtYIM+eCnOnbBVXuUWl?=
 =?us-ascii?Q?16+AJ0gQgsjDWEAvHctlcV0tWRKjnYg4/TrhNDQqW3tkumRNCwynaXS3bMZG?=
 =?us-ascii?Q?VlG0FLh286ycWmtvqjAEjd+8hBXVzcpmk9ie/98XaJ6qqUEXxeLgq/SFSRjV?=
 =?us-ascii?Q?89E2Fbh2OqiSamARsa4cUkU/A60DKXXW8UPBB+36nA/itSHSY3+Ja6bMSqan?=
 =?us-ascii?Q?6hrhK4JeBCBC6v7F4DJpF63JU3mpB1DXU72bgapI1OuDGjXbuThuCandw0cQ?=
 =?us-ascii?Q?65TGp9FOtJsXsbkqeFeGWTeGk1LaVYjziExEQ0b42JZYLP3jCRB3DMaURZlK?=
 =?us-ascii?Q?ZD/GWjyvliFfJKIlEpR9R2I9RdEKMLo8ncvdxNlibRLldSglOufXultL7F1L?=
 =?us-ascii?Q?8PO9YF42vYoGdO4oYEArc9juFkEBfY9+sho+BOnh9lM2wT2jAXVkxH0G+KCZ?=
 =?us-ascii?Q?pw7CvqnEru8GeGWLXghq2axjN0mCbuRjrZBsy6VtBuOcjRsgjBf5UR/T3nNj?=
 =?us-ascii?Q?ZP8i/dYKZYIRrHKrbb9TazanpvKLPdlsCSoIgOIoBY3ICnt1lp0YcmsDhmZ8?=
 =?us-ascii?Q?8Isd3DHQ8jwy8/gDSe4RSTRBA/3VmQILTVHpshQC0LZBaWNvO2mYF0YL56U2?=
 =?us-ascii?Q?WhQaPycqfaHs8kcLk5GlWN1SVKo3xO28YxZBwpkMAnZ/rzapns+yJNcwZEb2?=
 =?us-ascii?Q?xGS/Dp0sxHpcfdsIGPzGKJgNi1h7XD6rq8s/S+xIRXM1xhlj9ihejNkU2/sY?=
 =?us-ascii?Q?Yiu7TEGAMSd1e63fCA+XIBarmQ6Xq53XvRxt/5R7azdfLk8v3jqWaDeaP6B9?=
 =?us-ascii?Q?L0RXlRiu224Vzel9YydvDGwDXwagndhR+CxNzNwy6s1xRUXXfL+FvJALlWwx?=
 =?us-ascii?Q?70iULmlBkRbfbuVrHXMQd7p8QeomovFPJFib1VDVwY1/kgP578MlDY7/mL6m?=
 =?us-ascii?Q?kBJ3VUFdFaoa0wtxc562wiQOEL+ITJAgrR6m8PVoTpRegBD6phbI+po6fqxS?=
 =?us-ascii?Q?oiR92wsCp9pe5kD6WDWFtB1VXrJUEiC+iCeCPBd+1e9uO9SpjQgVw58xmbDZ?=
 =?us-ascii?Q?cPlxYFvs3ZLCUXWeT2pmQrkqLUtWVjKiE5HV087eZrY9J5zrv/hvN7bkQaB9?=
 =?us-ascii?Q?9mX7C2n9uB4RiL7L8sYRdYSfU0QRTSh0VQTqUYSbXc1NdkEwPXdQJplfUMbt?=
 =?us-ascii?Q?SyhqGhXFXObGhRLKYX+zSPZNp51WW2M54ZMrasNS819ldHVvChstVM0kuP0p?=
 =?us-ascii?Q?73v/080xBdOzv8QgDOn6aaQKl1rw/ajP2BtfTLAiptBTz0XD79nuHMrfxnLh?=
 =?us-ascii?Q?8Nllq5C14M8VtTT/80AWiANk37+0kJWzC9AAGqyd5QFF0SIbJcXNs2tyeXml?=
 =?us-ascii?Q?FV9/oxqXibqna/w//bAMJW2zw6zstXYBEB1Mnn6QNGp0J9o5OHqS3/0VIih0?=
 =?us-ascii?Q?KEmTNUApr68mI+BIDy3lgEGzaBm0XkeiT5HtOC3Aw2sp3i4A7WlgOhT3i0Bu?=
 =?us-ascii?Q?/bAElnMwD5HFNLh3KlhVrSDUy9yTnAE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f34123-69e7-416b-2962-08da27f12a9e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 01:56:38.4924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDv1tc3FOhx2nHe2wTlrCHP1UUmWhyGqGBXFpV1FyJl1eDT6x4dXYppgYJD9AuoGi6AAIWmmJSEt+q2CewDMQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7661

v16:
 - add CONFIG_BPF_JIT check around the scheduler code inside bpf.c
 - depends on export/20220426T102605 +
	      Squash to "bpf: add bpf_skc_to_mptcp_sock_proto" +
              Squash to "selftests: bpf: test bpf_skc_to_mptcp_sock"
              Squash to "selftests: bpf: add MPTCP test base"

v15:
 - set mptcp_sched_id and mptcp_sched_type in bpf_mptcp_sched_init().
 - add CONFIG_BPF_JIT in patch 6.
 - drop '#include <sys/param.h>' in patch 8.
 - depends on export/20220426T102605 +
	      Squash to "bpf: add bpf_skc_to_mptcp_sock_proto" +
              Squash to "selftests: bpf: test bpf_skc_to_mptcp_sock"

v14:
 - add struct mptcp_sched_data.

base-commit: export/20220422T060337

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
 include/net/mptcp.h                           |  19 +++
 kernel/bpf/bpf_struct_ops_types.h             |   4 +
 net/mptcp/Makefile                            |   2 +-
 net/mptcp/bpf.c                               | 151 ++++++++++++++++++
 net/mptcp/ctrl.c                              |  14 ++
 net/mptcp/protocol.c                          |  25 ++-
 net/mptcp/protocol.h                          |  27 ++++
 net/mptcp/sched.c                             | 104 ++++++++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  19 +++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 112 +++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  32 ++++
 12 files changed, 511 insertions(+), 6 deletions(-)
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

--=20
2.34.1

