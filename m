Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B827923CD
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 07:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650613369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vAiDX/6vWy9v3/c5QKzSXMLxMl/ceOCb4y7rfA1m7AY=;
	b=RCKTHvzq6bL3qk9BxMqWLWHwRUu0B2d1fgIzHjucWynP1+cmFecmEvqhf8CngHDkdI7rHc
	lhFrdzsYlgLfeko4urMQcYZzFBlF8oLiiDmyxvuyjpOdqlkcSpykHTJ6iq6IS/GemBKbRN
	W83/uM72fvthLaieta51Ha7jtjmibBQ=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-Hh-PslzJM1CdVOcjS8xdqg-2; Fri, 22 Apr 2022 09:42:48 +0200
X-MC-Unique: Hh-PslzJM1CdVOcjS8xdqg-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCSZ6bRpM/SBLCxxJ6kjnNY1Rkf/V6NIVyXa2lDu1SstYUBAx+4yMZLMzSz3z+YUheh7T3EYoCjoyJOqe/sZy+KWHwQIANzRsyw1gmPIjfaDLZQNYYeHdqknWnUhV4q9hK1VoNBY+o1hPzytPUmKZLO7FknmYd2k2EhS5U2hRuNSx+CSbTDiGhTgCAhCdcAUmdXio9Xs3NWPlE81gBFkKcsmEomSgC4nKC6GVJ1LRSj7uEiOyltuVyyt/3HxAvBGe7IRvCv0YJP0qwF3MXT8sOnNfM4wvd49l8aHtD1Hc5aMJF2Qp8m9QMLE/5yl6I3480KjrGYsPPDjZ6HsHt2E6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54wmoNkWZXHWUVmxNnaP6XPpWwnxpPPD5f5iRZ/jXDU=;
 b=YHXZ7CL8wr2OEJ21Xx7HiJPoCTpGEX+xWnED85aGJy/bnf+3Lay6Zlz+kODVXe0xA+w8b8mZKkBmNodr7wxkzqi+wDRua5lLYE1p3u6fE1apdluU7J6WSHms81W/uW+/tptVMKgXO1PzqdCwQhYgwHOdrY+zKM+lv/jTTA8QyyUe+r69CcA0AWjPQYTDwiECcV4G1QJKpXvZvBTr+vTF+hx/7siLKChx2xn7NS5868imBcu8O/1n95pHKYGWeOcsaEm7xBzVK2AK9LvyK1Y/44m+aJrK6f2tZqbqizCcc04nnZ/pct9CO44iCOah2EQnUDWjYGNrGi1UZlPwS8yXAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7251.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 07:42:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 07:42:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 0/8] BPF packet scheduler
Date: Fri, 22 Apr 2022 15:42:48 +0800
Message-ID: <cover.1650613134.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a54fbd95-56e0-4f94-f367-08da2433b126
X-MS-TrafficTypeDiagnostic: AM8PR04MB7251:EE_
X-Microsoft-Antispam-PRVS:
	<AM8PR04MB725175381DF783927E2B68F6F8F79@AM8PR04MB7251.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6MQTOMwz/3LgURoB/MNZiOBAKT3CV4NiiKZcpLWYtn7S+ONJI4NvauQUhTCBSZjDE8g/bt2Tw32vLSpiE9h0YJEJEvPpTFflfAj8JTtj+qlNgBA1n+cwrWVeNjeb/7nDsIaQwFHJM8ML43gm7E32eAZG8WFAMHaUMRJKJl3re7+LuDUupXH3Vu+LDNamy4xYaqeqewUyc+UgceAacnTOsTpODa9R3SRtn2+nmYdoDG/Q40GEgtJ5/DlY8ZJlEQ880CF5WBOSdUUPApLXBTR7D/6mY55hyEEEPwL0/CVWPdwwtf53sFIkpUW8D5/ssLqaf94to7iPZL7syKJy44T9l9A8idzBqOXltUJqYFgeEzrjNf2d93zrHY8duU2tA7axTxkawFdh5Dt5/MZy+77K0tvvaXYVw9zUWfe15+B2cQKPb0p5KGAxD4ZeHbLCip4eZ04oM7pIqCuTPJWlc0IadKJX6wBO69HgUQPXZ28XyI1xj50oHrMP4x9PUw78iBLtlJLMGyWm03Y93TEHuUbaBpq2FSoRQcS1+9UMH4lpqfeWqh+hM2duTEpi5HZXpTSGmLVXoRLuHqC+ndYrFi63/mdNXoE8wy5m57kvDcsAVxZ3F8uuI+2iOmueDhq8Mlw4Z441UAeN0FdnKrEK9vaothiabHT993msJ62afjgeIKH/XzF34U6LyM4yBLH8uXnsRGSm/+ngOhowYZ1VpcJWDzlUMIlh7zbZn/NUhwAPniSUpJHkk9py7TbdoAH8+iyHuB8qTOYCKK4D0GP062H+uA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6916009)(86362001)(6512007)(2616005)(6486002)(6506007)(966005)(508600001)(38100700002)(66946007)(26005)(107886003)(186003)(66556008)(66476007)(83380400001)(2906002)(36756003)(5660300002)(8676002)(4326008)(44832011)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q6I8v35pTJdVC/UYSryKuMhXIAZqLIeb0xb903RvsrKZPSBSbKtXC/qxgGu6?=
 =?us-ascii?Q?QxlbSKdNiJ4pxgtEBS//8htXptYrro7FtWtx+UM4TNonAzr+MtiDU7jaHvpy?=
 =?us-ascii?Q?I0dWBXduGCGtlWtb/TKmeQAODhi6FRaZOY70i7HVNJEoGHZ+wP/yOhQ1NRg0?=
 =?us-ascii?Q?jH4tZZyZvWhSRHEQqaU65hcRL/mhgJoGSu4+viNR0nweOMLH7iAJY1VYbDga?=
 =?us-ascii?Q?8Uf0V6rWKzk4NHCup1syuzk3OVKXuHgkYC5jT5O6C+nsiCjIs56qJmd7y7r7?=
 =?us-ascii?Q?LABdZNjQO7cH3LNmNt6/xkdFj5oMdGC6Ld4HcBfE61gXt9yBHLlAXOKuHmd2?=
 =?us-ascii?Q?JfCfanYhMpR1zwNd9lJoCql1mYy5kWweApbVeU3h297oYmWS1xTS2AG7aYp6?=
 =?us-ascii?Q?5b7983y7HTjIJWRnpkWc2NuWOc73PRfyXzFBHkC+FU4ZuwijMJLrDXNVGJid?=
 =?us-ascii?Q?B6Ce2d8/+oVXgcPWNTIZbjPU3ofsHmB6OgeAuvDIsFToKYL4Hwhua8bIBcTR?=
 =?us-ascii?Q?2jQOozBFVzb/7YI4HpEMXL4yYN9KsWn60lSJ2FRAY2hpWWl2OfaT5FocYn0C?=
 =?us-ascii?Q?VZZ6h/Bzk+/TZTMj2FMXyhLsgmzY/Eu1yhJEX3arGffTq3ie1gH8T/s1fE98?=
 =?us-ascii?Q?5doKpEBnv/ZLOi+PisDLGSqqVaz4oUDRt+j9kmpAYGHzcLHdj5P3xI+gKNTA?=
 =?us-ascii?Q?DTptfiYy1FHCpbS1BaqIDgX1yBj05vjVRGvTSbsGGY77BCeAyoLSN8BWhjzY?=
 =?us-ascii?Q?cJh0D1b2e01vXdw/Pv0i0jTZUU4hyVAvjX6lpDxTJLijOuhfdwxh9b8OoRho?=
 =?us-ascii?Q?e4WmtaW4MfZhyhA9azgijWhaZJ3Jh83HwNhqbc4oJR31JUZufJxsytM3e8+S?=
 =?us-ascii?Q?wZ+KkRN4oOdRPXReHSDSpUTmmY7RJ7FOkynHjtLoUuY/sd8ZKyTwNliXKzQ3?=
 =?us-ascii?Q?w5ZmQ1/cZ45hUXDM7IVI92EGIuaz0WGz77draSloSKZF3QCMMwgJ/VDgdrUR?=
 =?us-ascii?Q?q4ADSOsEtkbKA7vIT+8xGDbSOdWrleYGULAZIr0jhUq9l1AACZJoNPp2vzhj?=
 =?us-ascii?Q?sRxNk7wYqNR13jk/2HpoFWbfXeqVJpeHoTa4XZi1HPcB7eAtfVdY8tNmU3Gz?=
 =?us-ascii?Q?A9unaZ2SPr2cZH6XOUGDl3bjc44qkzadhMu9WBSAqOO7/eoWAuMg8HTIF7SY?=
 =?us-ascii?Q?ojsSE/nKXNONK5VNZKmi8xvVMYeMGCAcnXGaYU4N+oaIvTCDHiHyItWIdt5C?=
 =?us-ascii?Q?/+dkfqeYsDWyQTJgmRfzZtGtrrJfcxuWMhfxp2y1oCxbXaeGh/g01mQS4M4C?=
 =?us-ascii?Q?syw3140juDn1CUyzX6dxXT/9A1uug9rzsXrJmTrEgE0xttV7Uk+OWrRSLL0C?=
 =?us-ascii?Q?Ta8Tj84y0rWlH45gS/IDu4L/2ci7A3qZCgY7BhsmJzhyE0Fyb2F53d59++qu?=
 =?us-ascii?Q?0p5a8doWtpet+DgkTO6DfVUm2KhfPOyWlNbQgrVLE8tQDZeSO08RfvzL0Lgc?=
 =?us-ascii?Q?eY2Tw0iAYlBPTEn93wcAWodBEL1POf4LstkdmZVq7/WChQr/k04s6+ah7M5r?=
 =?us-ascii?Q?8gCpd4QEi2yKK/YmtzKoDq0918hiFNG9F0M/GwGGOWE9upC0zln9ot96BYhx?=
 =?us-ascii?Q?gR5lck5++O4EUawuNG65N4CmEEFqzpqOaIE72NCzrByMhSK+cKiVJHe5gSPW?=
 =?us-ascii?Q?bDOgMqEhRBq3U5ZQgKbKglomD8MhPQYHXwicNTyp7S36kd2xLiTKQBn7ywFi?=
 =?us-ascii?Q?3NTIIikOAWBjLztGsG0/glRYVhhn0mU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54fbd95-56e0-4f94-f367-08da2433b126
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 07:42:46.4148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGNRBn/S9dvUIMvEZdvFqxvatcdV2CFJDoA9VOYb5zUMXXPLCPITT9dnOO3F88v+BeG0A1XRzRPE0DEmKXeSXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7251

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
 net/mptcp/bpf.c                               | 148 ++++++++++++++++++
 net/mptcp/ctrl.c                              |  14 ++
 net/mptcp/protocol.c                          |  25 ++-
 net/mptcp/protocol.h                          |  27 ++++
 net/mptcp/sched.c                             | 104 ++++++++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  19 +++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 113 +++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  32 ++++
 12 files changed, 509 insertions(+), 6 deletions(-)
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

--=20
2.34.1

