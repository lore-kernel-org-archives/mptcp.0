Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09EB63C
	for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 14:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648649532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GV93juVqJbGmlM82UYU1ac0kY+3HzyejHTwHZOunsI8=;
	b=CapSZAeP59OGlLVTRW22WGySuUPrbGMI589ChPhR31t9HgEVAbD78UDLlRCjIC82puMkCf
	kIFjHIxorrWHtiQ31fE59ZAsiYXMli57ejG/4Q1VViYxL69uMiXxEBnPWsj1hqUYOKOEkb
	95VjDDwIkfhqRzgamj180WkSpkOyh7Q=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-HYINTXrwP1y399VY7LuwBQ-1; Wed, 30 Mar 2022 16:12:09 +0200
X-MC-Unique: HYINTXrwP1y399VY7LuwBQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxJRJhqAL8WoQm7s7NrkQqVChQvnkJq5tg8mTTBIeNbbsGZgK5pX1HR5rXJ4QEvk506epAdZoTXKc8MXmZG846T3VjDmGeNtnr+s9CO3kHWAYK2m2EH74LQwg6zTa2vWyDNW8CvxxwBAITka0TUsY2EcqRuU7zQjoX6lxdfbcATIKmaigj8GDPG5oekl8+0ieKW1jN49k0pgXBm5OrQQkbxlwvU+r3ZmH2xF1HhZFZBKrP+LhhaMcBw6d+v2t2LP1q8U5Cmpr4/ZOWl8Cchtcc6+rGqlRD7Q9/hQIrUUVqG4ARP6oZtIKdtyE4oc9l66rSNnNMx/zmLnds9EEqOiRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GV93juVqJbGmlM82UYU1ac0kY+3HzyejHTwHZOunsI8=;
 b=Pa5oeB8MGrI0q6vGnwT/PL2GSeB7jBtiP5B/8kfS1UxfmxM42bQzEEN7ybtMmCw3R3jCm2I58vGkw+///BrnIGnO0FEUDpx4+eB0J9T2HwoRjgoosOP/gLSJhRO0xfHaXkcmBQ1cYIA3GYWeBxuRsyh/YVULq+Lq3dzV8C1rzXNCsnTGJcx/sDPr56Q1due/K5b0VqnTTnSgtVEYSaAkPvcFX0hUZmj3knuX28wQ3BUVjc7GJztq0d1E45/URHc7hQU/3OtDbcnkCDHItfoUOBQsWBzciXAk1QSl03kMJcWwMAPYJDIRHCz2A6nJnJ+wEBWqBoDTdDrXwUApUyM6Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3938.eurprd04.prod.outlook.com (2603:10a6:208:7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23; Wed, 30 Mar
 2022 14:12:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 14:12:07 +0000
Date: Wed, 30 Mar 2022 22:12:11 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 0/8] BPF packet scheduler
Message-ID: <20220330141211.GA345@localhost>
References: <cover.1648537203.git.geliang.tang@suse.com>
 <bf2b415d-a5f8-907c-9a55-d8b6d2c317b6@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf2b415d-a5f8-907c-9a55-d8b6d2c317b6@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYWPR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67b961c6-8b98-4c9a-412a-08da125745d0
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3938:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB393880AF0A2690CB3DD9239EF81F9@AM0PR0402MB3938.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Dbr43HkXvZbJZMemHxiIDTHLmhhObqeDC8EhkZpyHcTQMTCOfVWfOgSx92uEHzur5IHXCnLPXH6nhkiUWbvMNK2Jxqlz0EQRpBYmsNuR4DdmsvezuG/Ov7FQJ3NkYn1F//U3EjOv7+/ZbArxZo9KtGhiKkG5/YyHBfmFf51tA/8AmY1oU/7O4LupxvBWo/hxJJKPafKih6FGSUX/0cacWzf4aLB7mjhzKUpDbUZ2B5kHwpxqBHOplm3DYE6WAFVVS1g2Y5oAl8dQIvfvTTUPyegNfCvHLk6nDqNrKVHoPfSWRiBHjxiiR/XoAAsa2UgzrDGPKs6slYFJu2Wr1gfdywYtvLie9SMZyM5Q4oymnysAWS/Hhx2dLdSxS0qp/MNDwigZit5fx84Zd/KslZu1V39GYbMlBMWMdSzVzzlc6cyvR1q62DXnDOwKIR+yNK6qxwm00v/BTqQc/8BhdQm0qzwsYbGmFD8eaPiz3GE2Y/M3ZgzqlMBBrLDL2NrK1vsjCBwnLL+kdMax7ZpM9qwzirs/VFkBfbWwoN4zQyBQnrDQtv3psQj5+lmVFEv9J0ML5e73LxICakB8oC+awkJap7IvzgZra4w4IAwh4HxfgG+hx3uH7nt6LZ5c+/uRuh86slwyQsjQFJawmWHvxzg9wUtFooQL8m1x1aIyw8KLKOceHz+0KMnzH6jMXrqJapvEnJ4Gk4fK6WsjNNthbG1vrENi9KHWLJ18kLdJF7Pc/OUXi4z2+S3WCEG6ij6TLdrjq1mJ0zl4hG7gRehUSf8CyYvD7MoKBvFvQko3J02IiUAtpBnQWQdg9DHb9jj90Z8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6512007)(86362001)(8676002)(186003)(4326008)(33716001)(316002)(6506007)(110136005)(26005)(6666004)(66556008)(2906002)(66476007)(33656002)(9686003)(1076003)(38100700002)(5660300002)(83380400001)(508600001)(66946007)(44832011)(966005)(6486002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I6odHVdS1sRw1GLDDcn9lefulImJAfv47Y9Xv20wyx1J8A1ywTpCwplZPimr?=
 =?us-ascii?Q?WoWTv+zCN49U4pAX09zL3ZUIerOekCOQqohLHXezFcvA3n26O82TaR+FMaFj?=
 =?us-ascii?Q?poMd5pEcYO1EOamCtZ6OWLJSkmRiatJd2UCYbagXifocHO2Q76TFz0U+PFKA?=
 =?us-ascii?Q?wkkjiHKIECzHPD3n/o5uApOd2GDK8r4F8URkmjH62U89BsHSIBeoumNN4fAL?=
 =?us-ascii?Q?9ObZUb5dhoDOWJpL8ZFFpVAns3EAQxpP1r8AcCfH81ijdhtWe0DC/nrenaRP?=
 =?us-ascii?Q?Mw2bxsiHmdg4pzfaW0UME2ybtaMNCH9UIQLnqCYeKmpojx8ozZN56iKYPsCu?=
 =?us-ascii?Q?R492oipE/uOQ0v//o+SRW8jNtT4dVm45pVNIaRgB7BDMI9MKFoqjf16CytAz?=
 =?us-ascii?Q?mogeJosGdc+hIulzVhVKxZbtLI7tWa1qvB1NBLytz0MSm7QM6vCNJsTwUX+A?=
 =?us-ascii?Q?rZWeV/+lXSvZ+HAv5xYFhIWOyVmQ+y1427Oi/t6+sAxIlWPK6GaBuKyARYFX?=
 =?us-ascii?Q?iM8f7WQstW9fBTnM46Qmm45F5TIFK4fkV6Rg9FoED/m+bRNAHZ34DOuYEcg1?=
 =?us-ascii?Q?LWusEuaEYYhoXpQsWbf1Xftj7Ix+/fjWpaPHoihvsDv7Zw67I5CAfCpBWj/C?=
 =?us-ascii?Q?hmS6E2OWWEFiJsFgloByj/enhb/WoFZl1G7DHyMQ9AOAEyQWbr9/qUvgfLGa?=
 =?us-ascii?Q?cZawifLXCd3GhFia6MIYzJT4wj0AIxdkmCtVG7kQ6b+YHLa3Bx36nN10Ienx?=
 =?us-ascii?Q?3xoho78FK9CzxOa2HxJLjlBMdDTBMYMQkWM42tLWfNt5c7hw5uvQgKqVw587?=
 =?us-ascii?Q?I3BpybtWD/Sio0bMfzAfI16HXr1ImI6sXHYGnjBUs5CQ0WVywkv2WbIafTDA?=
 =?us-ascii?Q?OHmpbFL/2DOnLCHEP3ytFWnqpjFj5W/8iFKqgO8Kc4I39ItLfJ9YZ1ir+VwI?=
 =?us-ascii?Q?/jE/RfFWHAXUpKEdKq86i98cXGIJogNDYrvXfJTG8rD18QYqMsj25bCo9tQL?=
 =?us-ascii?Q?HiAdBr97jmBAGhuHsw0NCWC1W00kE+5JoB342fPHieCxFoVfRJwX8L3I3dQ1?=
 =?us-ascii?Q?Rdyf8A9hXVQaYFe7OB4oK5msDjkObIBRdrhz1K+0TvRGYQuu6xkYUDpN5xKg?=
 =?us-ascii?Q?KeDcZLcePkCch1bPlGhpt5HlSEtTRgpK4bJPY9xZQf1m3UMWVmEj53PVnw0Y?=
 =?us-ascii?Q?R1fYfZ+Uaf1m/E2oADJtPfv0sYLGlOazgu5agXklJavUtjqPmQtjEizfRnpQ?=
 =?us-ascii?Q?B+0q+mXSo/QysgYfE27Kqk0CBb7lNDrUKgpmz9hH5Epqmxfpdb1nSzTjmSjI?=
 =?us-ascii?Q?hUw6d9dmH2WVQYMbPEepb/Z6GbaXTMNaYjDQO1bFRG5CV7GbaDqJMs8uJqSf?=
 =?us-ascii?Q?bI1Bvgk4eiYFHanRWI/O69N/7eavQACqEx7Q6OzQh9ETk5D1OxM0S5eQcuAq?=
 =?us-ascii?Q?ow1hd7eBHgWRkc2eRn4xi90bl2XM9fbNq0zc5JfKPCRwshWjSSQjvelSKYOq?=
 =?us-ascii?Q?kLl7ApJ/75a1O9TOlMQQPFZybHZ/T/60JJ6Wq/4WMQj4BEYvT2obZcGqzakK?=
 =?us-ascii?Q?2I4cgf89pD3BnviJg1Bv8rCnYpbYkn/x1LE+XE3G7VyMECzqcOIZvKkNLgZ9?=
 =?us-ascii?Q?CI74XwKtw6WL0Tl1B0F5DPdIBHJ7Z3M1j3YlmD+k3Z5nyH8PKZ0xxcGcg4AD?=
 =?us-ascii?Q?DRZEaW4TvVklXFX3vTgK0ww47D2NHocqzkDxGRqmOoVWSgVQsyda0dLgHFn7?=
 =?us-ascii?Q?PUUOCMfIkh3TgkBioBiuPlpSxmWueGs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b961c6-8b98-4c9a-412a-08da125745d0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 14:12:07.3920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNtKmiQg3/8iapRCVFCIMxUmiCREjmfhjAoTIXD3fYmnc5xKdCaVzBaisLwvFgu0pdTR0JrcJtiwQzWJxgFcHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3938

Hi Mat & Matt,

On Tue, Mar 29, 2022 at 04:13:02PM -0700, Mat Martineau wrote:
> 
> On Tue, 29 Mar 2022, Geliang Tang wrote:
> 
> > v8:
> > - use global sched_list instead of pernet sched_list.
> 
> Yes, I think this is fine. I had initially asked about pernet configuration
> with respect to registering BPF schedulers, but the important thing is that
> the sysctl can be set per-namespace.
> 
> > - drop synchronize_rcu() in mptcp_unregister_scheduler().
> > - update mptcp_init_sched and mptcp_release_sched as Mat and Florian
> >   suggested.
> > - fix the build break in patch 8.
> > - depends on: "add skc_to_mptcp_sock" v14.
> > - export/20220325T055307
> 
> Thanks for updating. Builds and runs fine here.
> 
> Before we add this to the export branch, have you thought about how subflow
> data (including the backup bit and throughput/latency data used by the
> default scheduler) can be accessed in the BPF get_subflow hook? Do you think
> that can be cleanly added after this series, or is there anything that may
> need to be changed in this series?

I plan to do that in the next series, BPF round-robin scheduler.

I had implemented round-robin in kernel before:

https://patchwork.kernel.org/project/mptcp/cover/cover.1631011068.git.geliangtang@xiaomi.com/

This time I plan to implement it using BPF.

In order to support bpf_rr, I think we need to do two more things
based on this series:

1. Get the subflow data from BPF, maybe iterate over the subflows
from mptcp_sock.

2. Make same members of struct mptcp_sock writable in BPF, say
last_snd, then we can set it like this:

        msk->last_snd = ssk.

Neither of these things is easy to implement. I'd like to hear your
opinions.

Thanks,
-Geliang

> 
> Thanks,
> 
> Mat
> 
> 
> > 
> > v7:
> > - add bpf_try_module_get in mptcp_init_sched.
> > - add bpf_module_put in mptcp_release_sched.
> > - rename bpf_first to mptcp_bpf_first.
> > - update commit logs.
> > 
> > v6:
> > - still use pernet sched_list, use current->nsproxy->net_ns in BPF
> >   context instead of using init_net.
> > - patch 1:
> >   - use rcu_read_lock instead of spin_lock in mptcp_sched_find as Florian suggested.
> >   - drop synchronize_rcu in sched_exit_net as Florian suggested.
> >   - keep synchronize_rcu in mptcp_unregister_scheduler, otherwise, got
> >     a workqueue lockup in my test.
> >   - update Makefile as Mat suggested.
> > - patch 2:
> >   - add mptcp_sched_data_init to register default sched, instead of
> >     registering it in init_net.
> > - patch 5:
> >   - move mptcp_sched_get_subflow to protocol.h as Mat suggested.
> > - patch 6:
> >   - use current->nsproxy->net_ns instead of init_net.
> > - patch 8:
> >   - add send_data to send more data, instead of send_byte.
> > 
> > v5:
> > - patch 1: define per-namespace sched_list (but only used init_net
> >   namespace. It is difficult to get 'net' in bpf_mptcp_sched_reg and
> >   bpf_mptcp_sched_unreg. I need some suggestions here.)
> > - patch 2: skip mptcp_sched_default in mptcp_unregister_scheduler.
> > - patch 8: add tests into mptcp.c, instead of bpf_tcp_ca.c.
> > 
> > v4:
> > - set msk->sched to &mptcp_sched_default when the sched argument is NULL
> > in mptcp_init_sched().
> > 
> > v3:
> > - add mptcp_release_sched helper in patch 4.
> > - rename mptcp_set_sched to mptcp_init_sched in patch 4.
> > - add mptcp_sched_first_release in patch 7.
> > - do some cleanups.
> > 
> > v2:
> > - split into more small patches.
> > - change all parameters of mptcp_sched_ops from sk to msk:
> >       void (*init)(struct mptcp_sock *msk);
> >       void (*release)(struct mptcp_sock *msk);
> >       struct sock *   (*get_subflow)(struct mptcp_sock *msk);
> > - add tests in bpf_tcp_ca.c, instead of adding a new one.
> > 
> > v1:
> > - Addressed to the commends in the RFC version.
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/75
> > 
> > Geliang Tang (8):
> >  mptcp: add struct mptcp_sched_ops
> >  mptcp: register default scheduler
> >  mptcp: add a new sysctl scheduler
> >  mptcp: add sched in mptcp_sock
> >  mptcp: add get_subflow wrapper
> >  mptcp: add bpf_mptcp_sched_ops
> >  selftests: bpf: add bpf_first scheduler
> >  selftests: bpf: add bpf_first test
> > 
> > Documentation/networking/mptcp-sysctl.rst     |   8 ++
> > include/net/mptcp.h                           |  13 ++
> > kernel/bpf/bpf_struct_ops_types.h             |   4 +
> > net/mptcp/Makefile                            |   2 +-
> > net/mptcp/bpf.c                               | 102 ++++++++++++++++
> > net/mptcp/ctrl.c                              |  14 +++
> > net/mptcp/protocol.c                          |  15 ++-
> > net/mptcp/protocol.h                          |  16 +++
> > net/mptcp/sched.c                             | 104 ++++++++++++++++
> > tools/testing/selftests/bpf/bpf_tcp_helpers.h |  12 ++
> > .../testing/selftests/bpf/prog_tests/mptcp.c  | 114 ++++++++++++++++++
> > .../selftests/bpf/progs/mptcp_bpf_first.c     |  30 +++++
> > 12 files changed, 429 insertions(+), 5 deletions(-)
> > create mode 100644 net/mptcp/sched.c
> > create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> > 
> > -- 
> > 2.34.1
> > 
> > 
> > 
> 
> --
> Mat Martineau
> Intel
> 

