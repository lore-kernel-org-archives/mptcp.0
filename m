Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5461B7E
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 14:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650981651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xh/dKCTzDftSjnjt1bB7FPxvfJlfhJ/dv2N+UgGHMiY=;
	b=PxHgVA+yWF8Q4rrbSu8h7JFnLWlmswNAjRNmX36Bq3ZYDI3GnXM7mY8d/rs7rpLS0KR+Hf
	7LD0cEer+d7+2PlYkmq4wSQRGOBWrXv4g43KkHD4SYVOB+YOnjxKgyxxr8ioPPwIhGAgpx
	IoBUYGKbHOXIvid5GbFyxRx3NrOAVdA=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-_d5WipJKOo20Ue8guWvACw-1; Tue, 26 Apr 2022 16:00:49 +0200
X-MC-Unique: _d5WipJKOo20Ue8guWvACw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwUP57GJnj0uu4CFmlTD+3qGq1ip+UuUYYKVCzwcwg2fnWk+7lPDoA9BWCd4AlsTwNb3ZUa5zqxrNPWFz0ptbdwaBjPigwcjsfzI+MH4v7/ns5qDne79Ettsm/A5n6GjNbr5882KzfC7ah89SArWjdPX/x1B7kuSmBHX6Ff0Ih7Sd+B7uMknfIqJBuo3gQ0q+SjXas5U0FCIgEgK4eQv2lQFrwE5yN4bAvHyfhpVx7znHzD0kobzhcqJo4QKXMatw2Fve0ksZETR+JElcVR8OOm+4UtmomvzVwfJ7HjZSKdzf+G9mV2a6T0Ta3QJ+8s6ZfzlhWX95rVAgaV7huldvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjbMl7wUngDwT+E51QV9LgYoOSCjOo9itXfuU76cqjM=;
 b=BwZi36906v5RUV1T2Q3eDqrf/yddO09CKN49TBoUQUJBkz1Ycyb5scVIPvhs3NFNqDf5V/UNxKfdO+3PPaM3Gkq/3EyUu+vMFg2li7yZFxsh/U6Ergjfpm6R8m3T75NVyJQX8VhGCDRY7nJWU6urKmsV/SyA/9cl21JCOj1XO7CPHIxEr4G9KhAFcj15B2WsvI3G7KO2jxxJkraaAam988qpyiy/oihfi0k89cHUvLy4JzirjlGgLCbvQen8LrddZKe43yMT/Qt9qgnzb3jXMGN6ZggVvPKRuGOEGyTOuIr/aVtr+mvDlNdN6cq/6HUc9Fl0Ljn9VthQMMOamSeM8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9460.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 14:00:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 14:00:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 0/8] BPF packet scheduler
Date: Tue, 26 Apr 2022 22:00:51 +0800
Message-ID: <cover.1650981078.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0162.apcprd02.prod.outlook.com
 (2603:1096:201:1f::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b4ae5cf-a854-42df-3f9c-08da278d2918
X-MS-TrafficTypeDiagnostic: AS4PR04MB9460:EE_
X-Microsoft-Antispam-PRVS:
	<AS4PR04MB9460922644DCD8628AE16969F8FB9@AS4PR04MB9460.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	of/TrfQANm3NJXCJZCLxatQ8ppC08U7LDhfKKv2zDgt8pJDDdmFpel0TykN32VrGBf7s7KaJUzM2CAunQWFCFvEVs4u0NW4CS8IDIZ5uN9E0xAyYb7dq6p68nVehj23doi/8Py8yBvqCEHPfUb9E+hUAZVgJaIBgJenYt1ScOPtxeVuA9Mglxw50CKRWesognHoRs5bpEvEk4Avz1Y6ryA+/xa04YN0YbL/jxHGkYBzFdtU4VJQ5DTRNsUvJmAxJz0/XpwLi2YEz44tYo1KfIMVh1otFZv0qWVbWISjdNTX7YVI/62s6xbXCtapXrA4cbxTvqa7C1LdmKjZef0BVT9/y0BJUpy6XmkXm+OQQN+dWWZP/XdF9QZnFbai7I1DdbEf0S3Sb5BSfgDMkxpgREoSxD+JGHq/EADe5hBj6LhHbA/NfVDBmAI4imwmMo2T2PFDjx2F8DmgbJGmdruroQCM4K4elPkqBPQImIiHl7KTtY4GAEyk8BZCFtJSM6y3U0VIsqhrnyRZQ3/A4NDC8pQKdnKTJ6dJ3lVoYAIDyRj7QskkHPAoHp+8MOFC3D7WniJc4dIMzeP7n1kdnqGe2Y8xRkETit89P8sVcg3rTauo/wf5HUt9Qilj4DGZT3y0NgkF3K9QqmC46OfX7sL4JfkSz/PsaZnIVQF86A8dvPG7uIOjfbQsmeeAbSl0tneJb/U5Z8kNla/zYgnGeBvRT1QiQdVYr8VoWC359mMvvdXzvXiY+mZXmt6x+7jqQC6kS+i/J3oGhI8bTeKGy7dAkeA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(107886003)(66476007)(6916009)(38100700002)(508600001)(316002)(966005)(6486002)(4326008)(8936002)(36756003)(44832011)(83380400001)(8676002)(86362001)(2616005)(66946007)(66556008)(6506007)(5660300002)(6666004)(2906002)(6512007)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tQtWppBaBCrrTCeuag31iwjWwQ8bJZI2bUfyTmIGF339hyH/s/yMy/pPJIdh?=
 =?us-ascii?Q?FBi6CQmxqELneYk+QgfJWxMKWNYLAJhZFjV3MtudnOcG08aSkJfMUeQ07wvD?=
 =?us-ascii?Q?LliKOn10RyvzN62Iaf34wcqwP6zj3rHzgxZH0aWNRogI1kpnwh166D66ZEmz?=
 =?us-ascii?Q?H62QbZUAbcvjfckNq5y9D/jZQfE8mGvxXP/zWTKrtVN7akEsvw/YeIpy8m9b?=
 =?us-ascii?Q?t46chlzFVYGu5z2NY/0WEbYhlxWPQ6WQ6oEQycItO1iaLm0hjrJwk3X8sNTg?=
 =?us-ascii?Q?q7noFbcWh7R548YElct2MYZVR7LY2ZgJmWN37NJrkAPq5cuw0gzg35K3q8jm?=
 =?us-ascii?Q?p4WwweZiewArmMYDzI1+HNU91XGpS8gsIqaaEfhUI67eXJl9Z/EYAN6EPORn?=
 =?us-ascii?Q?DXVT98XJlTxk2Cb/6MyN60bk7ZgNydu4BV3rXW6+hrdQHY/TLliahxQt6bD9?=
 =?us-ascii?Q?LwpHL6uV6eI2tnUk5teTn2gWUjTJ6WYeExFbTnAdujEY2p3bKW+/D/px+3XL?=
 =?us-ascii?Q?JlxC4amLGtIK4T7tD/N6M3xaThUWzzTL66BsYVRT1wpDZcT+KOdz3Nh7j5Rh?=
 =?us-ascii?Q?0ePr7LNRzSP7sbKsxJZ8Mj66OcflhIfbs8ozwANP9EMTDogSu9aylBLS3HOr?=
 =?us-ascii?Q?aEhSMnpa2lhY8MNdBWFGFANhNEtJELDYKlQd79HnhpXsxTDYTVUpIEiznA7r?=
 =?us-ascii?Q?60uvKfO61Y/A/ILSuT7wYTueMWgisXMicdX4i+4fRfHuMKx/YA1YLhlr7dkE?=
 =?us-ascii?Q?k8kJM5gqBwUW9+l+dtF55KJMa1dGU5CLRcRxEWgg2+C+RdqmzNH/B7inM8za?=
 =?us-ascii?Q?rctcOLF85auQ8DRP/08e1N/pNbDFrltvnAHANdAFVIu1Xo0FuJDFRuRXuNiL?=
 =?us-ascii?Q?wlHX6P6RmbeDbisRyutgmqmMmZEH9G53j98Aw2GqAxPrbmr0lj5sl0kJg8fY?=
 =?us-ascii?Q?B+H0vEOO0075M/YaPUjlgrJILe0H5b1ZvCBIenD1EzSsHvVul9zw+V7pFnMf?=
 =?us-ascii?Q?6LpvFcCtKqVJYoCzCf1zywmiRBl+UAEtqWxvqwZr+j+QWe659U4uQYBxUob+?=
 =?us-ascii?Q?/wWKk39jXPkKZIgnRMUqJd9W3onq3HYEtBjjW55zNgSFuOyfnkZGA+2OYVOH?=
 =?us-ascii?Q?BTspPNeljjm2I/lDJHb1gGac+e6GllqEmrS4Oqrmp3LUuUVgDRhwXsPFaDUB?=
 =?us-ascii?Q?0OUb6rtBo43tJk8KY0Q4IkG1McKp8Qev6iHpOYy8Sh7eckqJ2ACePVFEIRWY?=
 =?us-ascii?Q?AQl8keKudbrXafby/uVmQ+PwEhe334UIWSigqW1k4O8G+El9H4kMYXL6OvjT?=
 =?us-ascii?Q?E0KGW+1b6RkxEaPLuMGb7gZOUkqYHE1w6VOWhkqAL97fCXLhQst3o5Ar91Sj?=
 =?us-ascii?Q?Vi/7NkwfoDzyjr7tiNqbJZu1+BdtMOGYgE9ITqE5uPPvNQW0yp5PLfUFb91o?=
 =?us-ascii?Q?reGbDmbwCC8SiA6e5HH5rzz//M6luIsBOlw0XFnwbG4SgvdqWptkjiG8V1Kr?=
 =?us-ascii?Q?N2AhKS5CPjhkQFIszt2Vqh9c0p7ECoJhlvvyPv/yToLKDL8iSvWD7biA+Yoa?=
 =?us-ascii?Q?Zfk2+B/D0dRT3MWY7jdUSUR4nj1uq7JRmIbFgKaG7qEhIjZq+nKTKpbqFHC+?=
 =?us-ascii?Q?NrIz7sHs/LMiBbEjXyavbcqQ0pDZbKDDbzcB4td+WqInt5tS/znFLZO6vaac?=
 =?us-ascii?Q?BQzxbhYgPYxqrzhtK1UwtupJQWelmGeiHbLoVITIkB9BYfwuevSaDnXeJpJE?=
 =?us-ascii?Q?fi3uSs4XR+YasfII97lTfxHBhwddO8A=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4ae5cf-a854-42df-3f9c-08da278d2918
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 14:00:46.3579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PgG0gZ4VOV4YYKGLeouYT3PbtqfjfH2sEby4Lnzvwni9CeOlTJER4lhMXvyhO3BOrqTHoVHDeOjC8rGGXBKuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9460

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
 include/net/mptcp.h                           |  21 ++-
 kernel/bpf/bpf_struct_ops_types.h             |   4 +
 net/mptcp/Makefile                            |   4 +-
 net/mptcp/bpf.c                               | 149 ++++++++++++++++++
 net/mptcp/ctrl.c                              |  14 ++
 net/mptcp/protocol.c                          |  25 ++-
 net/mptcp/protocol.h                          |  27 ++++
 net/mptcp/sched.c                             | 104 ++++++++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  19 +++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 112 +++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  32 ++++
 12 files changed, 512 insertions(+), 7 deletions(-)
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

--=20
2.34.1

