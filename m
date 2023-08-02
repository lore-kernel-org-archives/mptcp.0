Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F02B5683
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 09:34:28 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4fe2503e3easo7658475e87.2
        for <mptcp@lists.linux.dev>; Wed, 02 Aug 2023 02:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690968866; x=1691573666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCifSKQyIeO4sI5g9wfnzw0kvGSiwSaObDe5j2O+VWE=;
        b=roShq+OkNWCQIdIZwaw7W7aceB1vh8Nkrzf7/D2Hg7FIIk8LRWZk8KacRzgZXvUZ6m
         FcMDq6bx1XiAdvCOY1Xy9yYaReSyAKLpMVVOQsN1OuhWVefUR00k77q+0x7JEoVBN2vI
         4fhwOj5MWIWZLUZGiLYR15JhreGjscHyA6EK1qIsfw5krvY7fsATsu0AX226gQt0wf6h
         MaYg2JdvJHf9iMIjhiLc8E+P5e1ib1IOa9fGziwbsEWy43S7ECb3zxkpQXBOZQE03PGI
         QzDftnCJUqugMKqv0z+X2qyC8jgjsla3D3AaAH0dA638TYt4MG2ICKWut5EgDxdFT2vh
         cK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690968866; x=1691573666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCifSKQyIeO4sI5g9wfnzw0kvGSiwSaObDe5j2O+VWE=;
        b=YnPspuR0szrmcQkf+gZpd4Tjtlu9qe/i3ZgzybJz7QpqWzYWljidwAJ6xumiNDeaBe
         VD3JAffKSf1L3ai3nn5L1ZZRhBdfQcAB0NjHhbmZxWMiLoEPzVYiQCOabvI/t2TAqQUK
         Yiztpw6r6qe3czftFRXhtYFF9tndiKg2jqt5Val6mRV6Uk9NIsbDDXOmxF0i17qU9qnl
         Ou6cXMyS02topxpDnaAvKzVoISIEEqlByqS2Ow6bQimcJVmj9yb4fOUESzJLiBScXLoO
         Oy9F5igzZBsn41iCGkSB1jABQ7APuDuJMOnR6C6q/lSHcHaBjFFdcG2ea08RQqvwd/KO
         ERcQ==
X-Gm-Message-State: ABy/qLbX73bJQ5cIfcEFcFDHkguKQS4l2djSkG++715UhIuo8wNx3sui
	LYag7l7p2k4+RRSQMDT7dV4CCaVbjpOQ4bh/W48=
X-Google-Smtp-Source: APBJJlE3aNuhYER2ke7+qjh0zHFFpIAgK2q6Tj0nE/4QW1qHFyYcXwSLwkdCV9AZBuxEtDkBTLYSqmIL9Gmi+AQ06M4=
X-Received: by 2002:a19:2d59:0:b0:4fe:2efa:b847 with SMTP id
 t25-20020a192d59000000b004fe2efab847mr3773555lft.23.1690968865575; Wed, 02
 Aug 2023 02:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <336e8b92-8416-44a3-917f-5fcb1ae3a919@tessares.net>
In-Reply-To: <336e8b92-8416-44a3-917f-5fcb1ae3a919@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 2 Aug 2023 17:34:35 +0800
Message-ID: <CA+WQbwuhjitKkgobY7vgFMSQE5JTsPpq9VjC0KEO2Ldm_TT2gQ@mail.gmail.com>
Subject: Re: [Weekly meetings] MoM - 1st of August 2023
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Mat Martineau <martineau@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mat & Matt,

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B48=E6=
=9C=882=E6=97=A5=E5=91=A8=E4=B8=89 01:28=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello everyone,
>
> Today, we had our 252nd meeting with Paolo (Redhat), Mat (Cruise) and
> myself (Tessares).
>
>
> Thanks again for this new good meeting!
>
> Here are the minutes of the meeting:
>
>
>
> Accepted patches:
>     - The list of accepted patches can be seen on PatchWork:
>       https://patchwork.kernel.org/project/mptcp/list/?state=3D3
>
>
>     netdev (if mptcp ML is in cc) (by: Mat Martineau, Matthieu Baerts):
>
> 13326916: [net,1/2] selftests: mptcp: join: only check for ip6tables if
> needed
> 13326917: [net,2/2] mptcp: more accurate NL event generation:
>       - Series: mptcp: More fixes for 6.5
>       - Submitter: Mat Martineau
>       - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=3D769437&state=3D=
*&archive=3Dboth
>
> 13328385: [5.10.y] selftests: mptcp: depend on SYN_COOKIES:
>       - Submitter: Matthieu Baerts
>       - URL:
> https://patchwork.kernel.org/project/mptcp/patch/20230726165547.1843478-1=
-matthieu.baerts@tessares.net/
>       - simple conflicts
>
> 13329814: [5.15.y] selftests: mptcp: sockopt: use 'iptables-legacy' if
> available:
>       - Submitter: Matthieu Baerts
>       - URL:
> https://patchwork.kernel.org/project/mptcp/patch/20230727084522.2035300-1=
-matthieu.baerts@tessares.net/
>       - simple conflicts
>
> 13330149: [6.1.y] mptcp: ensure subflow is unhashed before cleaning the
> backlog:
>       - Submitter: Matthieu Baerts
>       - URL:
> https://patchwork.kernel.org/project/mptcp/patch/20230727141457.2522904-1=
-matthieu.baerts@tessares.net/
>       - simple conflicts
>
> 13330162: [6.1.y] mptcp: do not rely on implicit state check in
> mptcp_listen():
>       - Submitter: Matthieu Baerts
>       - URL:
> https://patchwork.kernel.org/project/mptcp/patch/20230727141625.2524544-1=
-matthieu.baerts@tessares.net/
>
> 13330163: [6.1.y] selftests: mptcp: sockopt: use 'iptables-legacy' if
> available:
>       - Submitter: Matthieu Baerts
>       - URL:
> https://patchwork.kernel.org/project/mptcp/patch/20230727141721.2525575-1=
-matthieu.baerts@tessares.net/
>       - simple conflicts
>
> 13333355: [net-next,1/4] selftests: mptcp: join: rework detailed report
> 13333354: [net-next,2/4] selftests: mptcp: join: colored results
> 13333356: [net-next,3/4] selftests: mptcp: pm_nl_ctl: always look for err=
ors
> 13333357: [net-next,4/4] selftests: mptcp: userspace_pm: unmute
> unexpected errors:
>       - Series: mptcp: cleanup and improvements in the selftests
>       - Submitter: Matthieu Baerts
>       - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=3D770890&state=3D=
*&archive=3Dboth
>
> 13336048: [5.15.y] selftests: mptcp: join: only check for ip6tables if
> needed:
>       - Submitter: Matthieu Baerts
>       - URL:
> https://patchwork.kernel.org/project/mptcp/patch/20230801090716.2234574-1=
-matthieu.baerts@tessares.net/
>       - simple conflicts
>
>
>     our repo (by: Andrea Claudi, Geliang Tang, Matthieu Baerts, Paolo
> Abeni):
>
> 13316705: [mptcp-next,v2,01/13] Squash to "bpf: Add bpf_mptcp_sched_ops"
> 13316706: [mptcp-next,v2,02/13] Squash to "selftests/bpf: Add bpf
> scheduler test"
> 13316707: [mptcp-next,v2,03/13] Squash to "selftests/bpf: Add bpf_first
> test"
> 13316708: [mptcp-next,v2,04/13] Squash to "selftests/bpf: Add bpf_bkup
> scheduler"
> 13316709: [mptcp-next,v2,05/13] Squash to "selftests/bpf: Add bpf_bkup te=
st"
> 13316710: [mptcp-next,v2,06/13] Squash to "selftests/bpf: Add bpf_rr test=
"
> 13316711: [mptcp-next,v2,07/13] Squash to "selftests/bpf: Add bpf_red tes=
t"
> 13316715: [mptcp-next,v2,11/13] bpf: Export more bpf_burst related functi=
ons
> 13316716: [mptcp-next,v2,12/13] selftests/bpf: Add bpf_burst scheduler
> 13316717: [mptcp-next,v2,13/13] selftests/bpf: Add bpf_burst test:
>       - Series: BPF packet scheduler updates part 2
>       - Submitter: Geliang Tang
>       - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=3D766762&state=3D=
*&archive=3Dboth
>
> 13329965: [mptcp-next,v2,1/2] selftests: mptcp: join: fix 'delete and
> re-add' test
> 13329967: [mptcp-next,v2,2/2] selftests: mptcp: join: fix 'implicit EP'
> test:
>       - Series: selftests: fix mptcp_join test
>       - Submitter: Andrea Claudi
>       - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=3D770082&state=3D=
*&archive=3Dboth
>
> 13330435: [mptcp-net] mptcp: avoid bogus reset on fallback close:
>       - Submitter: Paolo Abeni
>       - URL:
> https://patchwork.kernel.org/project/mptcp/patch/ee258a29aba5deeede5aa200=
f53a1d7e9284817a.1690478147.git.pabeni@redhat.com/
>
> 13331980: [mptcp-next] Squash to "selftests: mptcp: join: colored results=
":
>       - Submitter: Matthieu Baerts
>       - URL:
> https://patchwork.kernel.org/project/mptcp/patch/20230728141833.916787-1-=
matthieu.baerts@tessares.net/
>
> 13332062: [mptcp-next] Squash to "selftests: mptcp: pm_nl_ctl: always
> look for errors":
>       - Submitter: Matthieu Baerts
>       - URL:
> https://patchwork.kernel.org/project/mptcp/patch/20230728152845.1020528-1=
-matthieu.baerts@tessares.net/
>
> 13335556: [mptcp-net] mptcp: fix disconnect vs accept race:
>       - Submitter: Paolo Abeni
>       - URL:
> https://patchwork.kernel.org/project/mptcp/patch/68f1f65f9b5542fd200f9958=
44f7ed71bdfbfc30.1690840586.git.pabeni@redhat.com/
>
>
>
> Pending patches:
>     - The list of pending patches can be seen on PatchWork:
>       https://patchwork.kernel.org/project/mptcp/list/?state=3D*
>
>
>     netdev (if mptcp ML is in cc) (by: Geliang Tang, Joel Granados):
>
> 13333075: [RFC,bpf-next,v7,1/6] net: socket: add update_socket_protocol h=
ook
> 13333076: [RFC,bpf-next,v7,2/6] bpf: Register mptcp modret set
> 13333077: [RFC,bpf-next,v7,3/6] selftests/bpf: Add mptcpify program
> 13333078: [RFC,bpf-next,v7,4/6] selftests/bpf: use random netns name for
> mptcp
> 13333079: [RFC,bpf-next,v7,5/6] selftests/bpf: add two mptcp netns helper=
s
> 13333080: [RFC,bpf-next,v7,6/6] selftests/bpf: Add mptcpify selftest:
>       - Series: bpf: Force to MPTCP
>       - Submitter: Geliang Tang
>       - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=3D770806&state=3D=
*&archive=3Dboth
>       - v7 looks OK (just patches that need to be squashed)
>       - Waiting for feedback from Jakub before sending the v8 (without RF=
C)
>
> 13333856: [v2,11/14] networking: Update to register_net_sysctl_sz:
>     - not directly linked to MPTCP, same modif done in other parts, just
> 1 line for MPTCP
>
>     our repo (by: Davide Caratti, Geliang Tang, Matthieu Baerts):
>
> 12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptc=
p.h
> 12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
> packets:
> 12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
> 12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
> 12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
> with unread data:
> 13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
> 13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
>       - State: Changes requested
>       - Series: BPF redundant scheduler, part 3
>       - Submitter: Geliang Tang
>       - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=3D703615&state=3D=
*&archive=3Dboth
>       - status: same as last week
>
> 13294008: [iperf3] add MPTCPv1 support:
>       - State: Changes requested
>       - Submitter: Geliang Tang
>       - URL:
> https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce=
70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/
>       - status: same as last week
>
> 13305089: [mptcp-next,1/6] mptcp: sockopt: move tcp_inq code to a
> dedicated function
> 13305091: [mptcp-next,2/6] mptcp: sockopt: update supported list
> 13305093: [mptcp-next,3/6] mptcp: sockopt: get val in a generic way
> 13305090: [mptcp-next,4/6] mptcp: sockopt: add missing getsockopt() optio=
ns
> 13305094: [mptcp-next,5/6] mptcp: sockopt: set val in a generic way
> 13305092: [mptcp-next,6/6] mptcp: sockopt: support IP_TTL &
> IPV6_UNICAST_HOPS:
>       - State: Changes requested
>       - Series: mptcp: sockopt: uniform code to get/set values
>       - Submitter: Matthieu Baerts
>       - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=3D763505&state=3D=
*&archive=3Dboth
>       - status: same as last week
>
> 13316712: [mptcp-next,v2,08/13] mptcp: add subflow_set_stale helper
> 13316713: [mptcp-next,v2,09/13] selftests/bpf: Add bpf_stale scheduler
> 13316714: [mptcp-next,v2,10/13] selftests/bpf: Add bpf_stale test:
>     - https://github.com/multipath-tcp/mptcp_net-next/issues/349
>     - We still need the behaviour but implemented differently
>     - Ticket has been updated
>     - Mat will follow up on the ML
>
> 13321790: [mptcp-next,1/5] tools: ynl: add uns-admin-perm to genetlink
> legacy
> 13321794: [mptcp-next,2/5] mptcp: convert netlink from small_ops to ops
> 13321791: [mptcp-next,3/5] Documentation: netlink: add a YAML spec for mp=
tcp
> 13321792: [mptcp-next,4/5] mptcp: uapi: use header file generated from
> YAML spec
> 13321793: [mptcp-next,5/5] net: mptcp: use policy generated by YAML spec:
>       - State: Changes requested
>       - Series: convert MPTCP to use YAML spec
>       - Submitter: Davide Caratti
>       - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=3D768188&state=3D=
*&archive=3Dboth
>       - status: same as last week
>
> 13334411: [mptcp-next,1/4] Squash to "mptcp: add sched_data helpers"
> 13334412: [mptcp-next,2/4] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
> 13334413: [mptcp-next,3/4] Squash to "selftests/bpf: add two mptcp netns
> helpers"
> 13334414: [mptcp-next,4/4] Squash to "bpf: Export more bpf_burst related
> functions":
>       - State: New
>       - Series: BPF packet scheduler updates part 3
>       - Submitter: Geliang Tang
>       - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=3D771148&state=3D=
*&archive=3Dboth
>       - issue with the build
>       - Mat will look at that
>
>
>
> Issues on Github:
>     https://github.com/multipath-tcp/mptcp_net-next/issues/
>
>     Recently opened (latest from the last meeting: 423):
>
>   424  KMemLeak around `__register_sysctl_table` [bug]:
>       - not related to MPTCP
>       - Matth sent an email to netdev
>
>
>     Bugs (opened, flagged as "bug" and assigned)
>
>   417  Verifier blocks access to tcp_sock fields [bug] [bpf] @geliangtang=
:
>       - Can we close it?
>       - Wait one more week
>
>   400  packetdrill: data are retransmitted after the `close()` [bug]
> [packetdrill] @matttbe
>   290  Not possible to `connect()` after a disconnect for a passive
> socket [bug] @pabeni
>
>
>     Bugs (opened and flagged as "bug" and not assigned)
>
>   424  KMemLeak around `__register_sysctl_table` [bug]
>   420  syzkaller: WARNING in `__mptcp_move_skbs_from_subflow` [bug]
> [syzkaller]
>   416  No new subflow when removing an endpoint and adding a new one [bug=
]
>   398  syzkaller: memory leak in `subflow_ulp_init` [bug] [syzkaller]
>   391  PM: userspace: unable to create additional subflows with the
> local addr ID 0 [bug]
>   379  userspace pm: ability to send `RM_ADDR` for all local IDs used (0
> included) [bug] [pm]
>   343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
> [sched]
>   336  Issues with BPF packet scheduler [bug]
>   325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
> sometimes failing [bug] [selftests]
>   324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose
> server test` are sometimes failing [bug] [selftests]
>   318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
> cookies [bug] [selftests]
>   315  Issues with backup flow [bug]
>
>
>     In Progress (opened, new feature and assigned)
>
>   403  userspace pm: local_addr_list: use a refcount per entry
> [enhancement] [pm] @geliangtang
>
>   353  sockopt: uniform code to get/set values [enhancement] @matttbe
>      - see patches above
>
>   349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
> @geliangtang
>      - see patches above
>
>   340  netlink: switch to YAML Netlink specs [enhancement] @dcaratti
>      - see patches above
>
>   296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
>      - see patches above
>
>   234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
> [packetdrill] @spoorva
>   167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
> @dcaratti
>
>    79  allow 'force to MPTCP' mode: BPF [enhancement] @geliangtang
>      - see patches above
>
>    75  BPF: packet scheduler [enhancement] [sched] @geliangtang
>      - see patches above
>
>    74  BPF: path manager [enhancement] @geliangtang
>
>
>     Assigned Questions (opened, questions and assigned)
>
> None.
>
>
>     Open questions (opened, questions and not assigned)
>
>   412  shadowsocks-libev not working, need guidance for PM configuration
> [question]
>   411  Problem with IPROTO [question]
>
>
>     For later (opened and not assigned assigned)
>
>   415  ss: display new counters from v6.5 [enhancement] [iproute2]
>   406  Compile and run mptcp bpf selftests in CI [enhancement] [selftests=
]
>   397  Doc and guidance for users [enhancement] [documentation]
>   396  ci: periodically run selftests from the export branch on stable
> kernels [enhancement] [selftests]
>   394  selftests: ability to track subtests [enhancement] [selftests]
>   389  packetdrill: increase coverage for "early `close()`" cases
> [enhancement] [packetdrill]
>   383  TCP_KEEPIDLE, TCP_KEEPINTVL, TCP_KEEPCNT are not implemented in
> mptcp_setsockopt_sol_tcp [enhancement]
>   350  scheduler: API changes (tasks) [enhancement] [sched]
>   348  scheduler: frequently probe "stale" subflow with reinjected data
> [enhancement] [sched]
>   345  scheduler: "penalise" some subflows by sending less than their
> cwnd [enhancement] [sched]
>   344  scheduler: new callback to initiate optimisations [enhancement]
> [sched]
>   337  in-kernel PM: listen socket: support "behind a NAT" use case
> [enhancement]
>   335  Server to Client subflows: option to allow joining the initial
> address and port [enhancement]
>   334  PM: in-kernel: send >1 ADD_ADDR before the establishment of a new
> subflow [enhancement]
>   333  New MIBs to help understanding issues when PM cannot create new
> subflows [enhancement]
>   332  scheduler: implement a "opportunistic retransmission"
> [enhancement] [sched]
>   298  CG Memory accounting for passive MPTCP socket [enhancement]
>   289  mptcp: audit comments for non inclusive language [enhancement]
>   273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdrill=
]
>   266  Packetdrill: add MP_FAIL coverage [packetdrill]
>   236  Review supported sockopts list [enhancement]
>   222  Netlink event API: add SUBFLOW_CREATED event [enhancement]
>   215  TCP Urgent pointer and MPTCP [enhancement]
>   213  add MPTCP man page [enhancement]
>   208  better handing of ssk memory pressure in the TX path [enhancement]
>   202  Add sendmsg support for ancillary data [enhancement]
>   197  more mibs needed [enhancement]
>   180  Get an update when MPTCP fall back to TCP [enhancement]
>   177  improve retransmit subflow selection [enhancement]
>   169  packetdrill: add coverage for ADD_ADDR and MP_JOIN on a different
> port [enhancement] [packetdrill]
>   150  remove completely workqueue usage [enhancement]
>   141  avoid acquiring mptcp_data_lock() twice in the receive path
> [enhancement]
>   133  PM: Closing the MPTCP connection when last subflow is not the
> initial one and its IP address is removed [enhancement]
>   128  When the last subflow is closed without DATA_FIN and msk
> Established, close msk (after a timeout) [enhancement]
>    78  notify the application (userspace) when a subflow is
> added/removed [enhancement]
>    77  [gs]etsockopt: forward to new/existing SF [enhancement]
>    76  [gs]etsockopt per subflow: BPF [enhancement]
>    57  After a few attempts of failed MPTCP, directly fallback to TCP
> for new connections [enhancement]
>    43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
> interface [enhancement] [syzkaller]
>    41  reduce indirect call usage [enhancement]
>    24  Revisit layout of struct mptcp_subflow_context [enhancement]
>
>
>     Recently closed (since 2023-07-25)
>
>   423  syzkaller: BUG: unable to handle kernel NULL pointer dereference
> in `mptcp_stream_accept` [bug] [syzkaller] [reproducer]:
>       - Socket migration is a bit of a mess
>       - But not clear how to improve this situation... (but maybe the
> problem might "never" happen?)
>       - Paolo will fill a new issue
>
>   422  syzkaller: BUG: soft lockup in `inet_stream_connect` [bug]
> [syzkaller]
>   421  syzkaller: BUG: soft lockup in `NF_HOOK` [bug] [syzkaller]
>   419  selftests: `mptcp_connect.sh`: disconnect: MPTCP =E2=86=92 TCP:
> Unexpected revents: `POLLERR/POLLNVAL(19)` [bug] [selftests]
>
>
>
> FYI: Current Roadmap:
>     - Bugs:
> https://github.com/multipath-tcp/mptcp_net-next/issues?q=3Dis%3Aissue+is%=
3Aopen+label%3Abug
>     - Current/Coming merge window (6.6):
> https://github.com/orgs/multipath-tcp/projects/4/views/1
>     - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1
>
>
>
> Patches to send to netdev:
>
>     - Fixes for other trees:
>
>         - [24dc018bd9b8] Revert "Merge tag '9p-6.4-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs" (Matthieu
> Baerts):
>             - fix for 9p for our CI
>
>     - Fixes for -net:
>
>         - [8c86a7fc8b69] selftests: mptcp: join: fix 'delete and re-add'
> test (Andrea Claudi)
>         - [4427ac02e212] selftests: mptcp: join: fix 'implicit EP' test
> (Andrea Claudi)
>         - [42cb6043f333] mptcp: avoid bogus reset on fallback close
> (Paolo Abeni)
>         - [5d91d167668f] mptcp: fix disconnect vs accept race (Paolo Aben=
i):
>             - Sending them at the end of the week
>             - Matth can do that =E2=86=92 TODO =E2=86=92 on Thursday afte=
rnoon
>
>     - Fixes for net-next: /
>
>     - Features for net-next:
>
>         - [08c6c7924e02] mptcp: avoid unneeded mptcp_token_destroy()
> calls (Paolo Abeni)
>         - [ad53e2a8af97] mptcp: avoid additional __inet_stream_connect()
> call (Paolo Abeni)
>         - [98672bc49dcf] mptcp: avoid subflow socket usage in
> mptcp_get_port() (Paolo Abeni)
>         - [11c410c7370d] net: factor out inet{,6}_bind_sk helpers (Paolo
> Abeni)
>         - [7996572cd2b1] mptcp: mptcp: avoid additional indirection in
> mptcp_bind() (Paolo Abeni)
>         - [aecad8093118] net: factor out __inet_listen_sk() helper
> (Paolo Abeni)
>         - [df9450731117] mptcp: avoid additional indirection in
> mptcp_listen() (Paolo Abeni)
>         - [fc478fadd8af] mptcp: avoid additional indirection in
> mptcp_poll() (Paolo Abeni)
>         - [cdec0b90452b] mptcp: avoid unneeded indirection in
> mptcp_stream_accept() (Paolo Abeni)
>         - [cfdc56c6d94a] mptcp: avoid additional indirection in sockopt
> (Paolo Abeni)
>         - [230253d72860] mptcp: avoid ssock usage in
> mptcp_pm_nl_create_listen_socket() (Paolo Abeni)
>         - [0620fcb3b5fe] mptcp: change the mpc check helper to return a
> sk (Paolo Abeni)
>         - [ce8bc1ff9963] mptcp: get rid of msk->subflow (Paolo Abeni):
>             - Depend on the fix for net (=E2=86=91) to avoid issues repor=
ted by
> Christoph.
>             - So wait one more week
>
>     - Features for net-next (next): /
>
>     - Features for other trees:
>
>         - [30c925a26900] mptcp: refactor push_pending logic (Geliang Tang=
)
>         - [d92e7c3ac566] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
> (Geliang Tang)
>         - [2e2ed433f72f] mptcp: add struct mptcp_sched_ops (Geliang Tang)
>         - [8d3528b3804d] mptcp: add a new sysctl scheduler (Geliang Tang)
>         - [36329d82af78] mptcp: add sched in mptcp_sock (Geliang Tang)
>         - [58b653130078] mptcp: add scheduled in mptcp_subflow_context
> (Geliang Tang)
>         - [b86a7f3f4f2b] mptcp: add sched_data helpers (Geliang Tang)
>         - [1da743dfb834] mptcp: add scheduler wrappers (Geliang Tang)
>         - [172ae1f29b25] mptcp: use get_send wrapper (Geliang Tang)
>         - [7449b11ec26b] mptcp: use get_retrans wrapper (Geliang Tang)
>         - [abb330dac85f] mptcp: register default scheduler (Geliang Tang)=
:
>             - can maybe be sent?
>             - Mat will re-review them to see what can be sent

I read these bpf schedulers patches again today and found that some
patches need to be update:

1. mptcp: drop last_snd and MPTCP_RESET_SCHEDULER

The commit log needs to update:
'''
mptcp_subflow_get_send(), it makes some msk->last_snd useless.
->
mptcp_subflow_get_send(), it makes all msk->last_snd useless.
'''

2. mptcp: add struct mptcp_sched_ops

The commit log needs to update:
'''
mptcp_sched_data parameter, which contains a reinject flag and a
mptcp_subflow_context array.
 ->
mptcp_sched_data parameter, which contains a reinject flag for
retrans or not, a subflows number and a mptcp_subflow_context array.
'''

@Matt, could you please help me to update these commit logs? Thanks.

3. mptcp: add sched_data helpers

This is a BPF related patch. Maybe we can send it together with the other
BPF patches.

If so, can we just move this patch between the commit "mptcp: register
default scheduler" and "bpf: Add bpf_mptcp_sched_ops"?

Thanks,
-Geliang

>
>         - [df10e80bc7b9] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
>         - [205badd8a007] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang=
)
>         - [0392c68093bf] selftests/bpf: Add mptcp sched structs (Geliang
> Tang)
>         - [ed5e40663b8e] selftests/bpf: use random netns name for mptcp
> (Geliang Tang)
>         - [8d774c6ebff2] selftests/bpf: add two mptcp netns helpers
> (Geliang Tang)
>         - [0f8b8f90f40e] selftests/bpf: Add bpf scheduler test (Geliang
> Tang)
>         - [6424af7f5a34] selftests/bpf: Add bpf_first scheduler (Geliang
> Tang)
>         - [b8f8f6e79466] selftests/bpf: Add bpf_first test (Geliang Tang)
>         - [a15a288f12f1] selftests/bpf: Add bpf_bkup scheduler (Geliang
> Tang)
>         - [c82f4ebe8b1f] selftests/bpf: Add bpf_bkup test (Geliang Tang)
>         - [bd9489a4f35f] selftests/bpf: Add bpf_rr scheduler (Geliang Tan=
g)
>         - [38a942382205] selftests/bpf: Add bpf_rr test (Geliang Tang)
>         - [1f3ff69927de] selftests/bpf: Add bpf_red scheduler (Geliang Ta=
ng)
>         - [d489c7b69e9d] selftests/bpf: Add bpf_red test (Geliang Tang)
>         - [5c6f2b004209] bpf: Export more bpf_burst related functions
> (Geliang Tang)
>         - [b960a09c3e88] selftests/bpf: Add bpf_burst scheduler (Geliang
> Tang)
>         - [9246c1b0dd1f] selftests/bpf: Add bpf_burst test (Geliang Tang)
>
>
>
> Extra tests:
>     - news about Syzkaller? (Christoph):
>         - do we need to modify syzkaller to test MPTCP Netlink API? (is
> "everything" tested?)
>         - TODO Matth: open a ticket =E2=86=91 =E2=86=92 Done #425
>
>     - news about interop with mptcp.org/other stacks? (?):
>         - /
>
>     - packetdrill (Davide):
>         - /
>
>     - Patchew (Davide):
>         - /
>
>     - CI (Matth):
>         - selftests:
>             - would be good to add more coverage on the listener side:
> one listen socket but with multiple accepted sockets with a mix of
> fallback and non fallback ones
>             - not something we can do with packetdrill
>             - TODO: create a GH issue for that! =E2=86=92 done #426
>
>
>
> - Netdev 0x17 (public):
>     - Vancouver, British Columbia, Canada
>     - Closing of CFS Sunday, August 27, 2023
>     - Notification by Friday, Sept. 15, 2023
>     - Conference dates Oct 30th - Nov, 2023
>     - It seems nobody can join: TODO: Matth: reply to Jamal =E2=86=92 Don=
e
>     - Maybe next year? fingers crossed
>
>
>
> - Netconf (invitation only):
>     - colocated with https://kernel-recipes.org/en/2023/ (Matth will be
> there)
>     - Net maintainers will be at netconf
>
>
>
> Security issues:
>     - Would be good to allow reporting security issues "in private" on
> GH, just in case
>     - Matth will look at that: Done: via the "Security" tab, not the
> "Issues" one
>     -
> https://docs.github.com/en/code-security/security-advisories/guidance-on-=
reporting-and-writing/privately-reporting-a-security-vulnerability#privatel=
y-reporting-a-security-vulnerability
>
>
>
> Next meeting:
>     - Next one on Tuesday, the 8th of August.
>     - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
>     - Still open to everyone!
>     - https://annuel2.framapad.org/p/mptcp_upstreaming_20230808
>
>
>
> Feel free to comment on these topics and suggest new ones for the next
> meeting!
>
> Talk to you on Tuesday,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
