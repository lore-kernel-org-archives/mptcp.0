Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587FA7B
	for <mptcp@lists.linux.dev>; Fri,  6 Jan 2023 08:12:34 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso2998338wms.5
        for <mptcp@lists.linux.dev>; Fri, 06 Jan 2023 00:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VG+QwLFKTrV7XyWrnz+FpJVspYJYpYlKmCo7dreVfo=;
        b=qolGd1DW8eqXj2/MetkC9rC7stpIlfuaNS+O2d4tHbaVGjl/E7zZThlF5PicuFGQ3C
         SVMmVq+WtbtQzp4h4JAEYkTHiNLwlFdNOWxoaTsbtS7LcZ38sVVKTfeQS65EJKOJ9i0Y
         74xw0eBKl0mIC0ixOuX42/BaQny6KYHSyhDrWfxsgMiSNByJj1PnL2wX+hqP8XK5VLmd
         TAElSKEw/3mEpGQM/2lwN3oZ9zy5kZ6x0Hzv94Rbybers7bcQLkb4+xDNRhw4oZbuBvY
         PeeuNqGthMOuH3gnO4F+YDVllhfq2sZRstqSfPzlSHhsd1he9W81WF29G4Pwv+8DOGOC
         Tskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VG+QwLFKTrV7XyWrnz+FpJVspYJYpYlKmCo7dreVfo=;
        b=gRjdK1uweUjGbxDNOqdoEFecbRh4Lcn16b5+R5fadXAq4f5jfXgTS9t2VcewUFTz94
         u1KfMijVMh1Rzf6VgRFV8/D5ubLIoBSQqgbIQ4eyiH4xLRtXmf+wYy+Y9/lUd6b57NgP
         pMgLyb19OdlPx9rYPZeqrGljC8usecmiPaHRnk6vka0LmF432Yf8/XHMhKkIL1K/Nu/f
         nIMntOOslO4NtmUeLb+cF/8Atl0w0iYrm/lsuzrWpC/LhsEZvVUyX7PmG4wCAa6bmcjM
         bFZmQp3QaMan3ZkUotgSevtdSUns8Q42MnJc4RzUOv1PRw/BYjee/+vn6Tn5KZlWK7Rz
         +3Pg==
X-Gm-Message-State: AFqh2koBCE3NBb8Ks5MTSkE/5c+i7fgLTRVFD4J76L7jRjC5JKpVVs2I
	+nepHzQGNND/dg27XeS76TKQDH1stFRV/BztdBM=
X-Google-Smtp-Source: AMrXdXuAJvFy/nPVSI7E93TyQKpojYtCbiP364XnJmageGLW7fkltycm4uVkT21mAc1at8k6VxRiAmYBFutjoTaJBbY=
X-Received: by 2002:a7b:c4da:0:b0:3cf:84be:aaf9 with SMTP id
 g26-20020a7bc4da000000b003cf84beaaf9mr2115296wmk.111.1672992752318; Fri, 06
 Jan 2023 00:12:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1f07a3b0-644f-f69a-fdd8-f4fc7a7baeb5@tessares.net>
In-Reply-To: <1f07a3b0-644f-f69a-fdd8-f4fc7a7baeb5@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 6 Jan 2023 16:12:31 +0800
Message-ID: <CA+WQbwtFEJ06p07MypSSmJZigAWA6KLgge+72EX_eP7_O9tr4A@mail.gmail.com>
Subject: Re: [Weekly meetings] MoM - 20th of December 2022
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B41=E6=
=9C=883=E6=97=A5=E5=91=A8=E4=BA=8C 01:18=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello everyone,
>
> Last ~week~ year/month, we had our 222nd meeting with Mat, Ossama
> (Intel), Christoph (Apple), Florian, Paolo, Davide (Red Hat) and myself
> (Tessares).
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
>     netdev (if mptcp ML is in cc) (by: /):
>
> /
>
>
>     our repo (by: Menglong Dong):
>
> 13076446: [mptcp-next,v10,1/6] mptcp: introduce 'sk' to replace
> 'sock->sk' in mptcp_listen()
> 13076447: [mptcp-next,v10,2/6] mptcp: init sk->sk_prot in build_msk()
> 13076448: [mptcp-next,v10,3/6] mptcp: rename 'sk' to 'ssk' in
> mptcp_token_new_connect()
> 13076449: [mptcp-next,v10,4/6] mptcp: add statistics for mptcp socket in =
use
> 13076450: [mptcp-next,v10,5/6] selftest: mptcp: exit from
> copyfd_io_poll() when receive SIGUSR1
> 13076451: [mptcp-next,v10,6/6] selftest: mptcp: add test for mptcp
> socket in use:
>       - Series: mptcp: add statistics for mptcp socket in use
>       - Submitter: Menglong Dong
>       - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=3D705564&state=3D=
*&archive=3Dboth
>
>
>
> Pending patches:
>     - The list of pending patches can be seen on PatchWork:
>       https://patchwork.kernel.org/project/mptcp/list/?state=3D*
>
>
>     netdev (if mptcp ML is in cc) (by: Paolo Abeni):
>
> 13076926: [v2,1/2] security, lsm: Introduce security_mptcp_add_subflow()
> 13076927: [v2,2/2] selinux: Implement mptcp_add_subflow hook:
>       - Series: lsm: introduce and use security_mptcp_add_subflow()
>       - Submitter: Paolo Abeni
>       - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=3D705673&state=3D=
*&archive=3Dboth
>       - We will probably get some feedback next year
>       - Will be handled by LSM team.
>       - Will it be backported to stable? =E2=86=92 probably not, not a se=
curity
> issue
>       - Once it is acked by the LSM team, we can apply a copy in our tree
>
>
>     our repo (by: Geliang Tang, Jiapeng Chong, Matthieu Baerts):
>
> 12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptc=
p.h
> 12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
> packets:
> 12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
> 12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
> 12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
> with unread data:
> 12321111: mptcp: Remove redundant assignment to remaining:
>       - State: RFC
>       - Series: mptcp: Remove redundant assignment to remaining
>       - Submitter: Jiapeng Chong
>       - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=3D500495&state=3D=
*&archive=3Dboth
>       - Status: same as last week
>
> 13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
> 13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
>       - State: Changes requested
>       - Series: BPF redundant scheduler, part 3
>       - Submitter: Geliang Tang
>       - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=3D703615&state=3D=
*&archive=3Dboth
>       - see the discussion below (Redundant Sched)
>
> 13074155: [mptcp-next,v25,1/5] mptcp: add scheduler wrappers
> 13074156: [mptcp-next,v25,2/5] mptcp: use get_send wrapper
> 13074157: [mptcp-next,v25,3/5] mptcp: use get_retrans wrapper
> 13074158: [mptcp-next,v25,4/5] selftests/bpf: Add bpf_red scheduler
> 13074159: [mptcp-next,v25,5/5] selftests/bpf: Add bpf_red test:
>       - State: Queued
>       - Series: BPF redundant scheduler, part 2
>       - Submitter: Geliang Tang
>       - URL:
> https://patchwork.kernel.org/project/mptcp/list/?series=3D704762&state=3D=
*&archive=3Dboth
>       - Can be applied
>
> 13077497: [mptcp-next] Squash to "mptcp: use get_send wrapper, v25":
>       - State: Queued
>       - Submitter: Geliang Tang
>       - URL:
> https://patchwork.kernel.org/project/mptcp/patch/db6dc5629093dea02dd3b6c1=
088f8efdf78ea03a.1671507997.git.geliang.tang@suse.com/
>       - Can be applied
>
>
>
> Issues on Github:
>     https://github.com/multipath-tcp/mptcp_net-next/issues/
>     TODO: check no label/project
>
> https://github.com/multipath-tcp/mptcp_net-next/issues?q=3Dis%3Aissue+is%=
3Aopen+no%3Alabel
>
> https://github.com/multipath-tcp/mptcp_net-next/issues?q=3Dis%3Aissue+is%=
3Aopen+no%3Aproject+-label%3Aquestion
>
>     Recently opened (latest from last week: 327):
>
>   331  MPTCP in multihoming doesn't announce all endpoints [question]:
>       - with the in-kernel PM, due to some limitations, only one is
> announced, then more are announced when the first one is established
>       - this could be improved but not that easy
>       - For more details, see Paolo's reply on the ticket
>
>   330  `MPTCP_INFO`: document and support `mptcpi_subflows` for the
> server side [enhancement]
>   329  PM: userspace: update `MPTCP_INFO` fields [bug]:
>       - both linked to #327
>
>   328  Problem using REDIRECT/MASQUERADE/TPROXY with MPTCP [question]:
>       - Not an issue with MPTCP at the end
>
>
>     Bugs (opened, flagged as "bug" and assigned)
>
>   320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @paben=
i:
>       - see above
>
>
>     Bugs (opened and flagged as "bug" and not assigned)
>
>   329  PM: userspace: update `MPTCP_INFO` fields [bug]
>   325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
> sometimes failing [bug] [selftests]
>   324  selftests: `mptcp_join`: test 98 `fastclose test` is sometimes
> failing [bug] [selftests]
>   323  selftests: `mptcp_join`: test 111 `delete and re-add` is often
> failing [bug] [selftests]
>   318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
> cookies [bug] [selftests]
>   315  Issues with backup flow [bug]
>   290  Not possible to `connect()` after a disconnect for a passive
> socket [bug]
>
>
>     In Progress (opened, new feature and assigned)
>
>   296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
>   234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
> [packetdrill] @spoorva
>   167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
> @dcaratti
>
>    75  BPF: packet scheduler [enhancement] @geliangtang:
>       - see above
>
>    74  BPF: path manager [enhancement] @geliangtang
>
>
>     Assigned Questions (opened, questions and assigned)
>
>   307  TCP performance better than MPTCP [question] @matttbe
>
>
>     Open questions (opened, questions and not assigned)
>
>   331  MPTCP in multihoming doesn't announce all endpoints [question]
>   328  Problem using REDIRECT/MASQUERADE/TPROXY with MPTCP [question]
>   326  Issue with streaming traffic with MPTCP upstream implementation
> [question]
>
>
>     For later (opened and not assigned assigned)
>
>   330  `MPTCP_INFO`: document and support `mptcpi_subflows` for the
> server side [enhancement]
>   298  CG Memory accounting for passive MPTCP socket [enhancement]
>   289  mptcp: audit comments for non inclusive language [enhancement]
>   273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdrill=
]
>   269  Allow having a mix of v4/v6 subflows for the same socket
> [enhancement]
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
>    79  allow 'force to MPTCP' mode: BPF [enhancement]
>    78  notify the application (userspace) when a subflow is
> added/removed [enhancement]
>    77  [gs]etsockopt: forward to new/existing SF [enhancement]
>    76  [gs]etsockopt per subflow: BPF [enhancement]
>    61  move msk clone after ctx creation [enhancement]
>    57  After a few attempts of failed MPTCP, directly fallback to TCP
> for new connections [enhancement]
>    43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
> interface [enhancement] [syzkaller]
>    41  reduce indirect call usage [enhancement]
>    24  Revisit layout of struct mptcp_subflow_context [enhancement]
>
>
>     Recently closed (since last week)
>
>   327  Number of subflows is equal to zero when expecting 1. [question]
>   322  TFO: possible circular locking dependency detected [bug] @pabeni
>   319  kmemleak: 6 new suspected memory leaks in -net [bug]
>
>
>
> FYI: Current Roadmap:
>     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
>     - Current/Coming merge window (6.3):
> https://github.com/multipath-tcp/mptcp_net-next/projects/18
>     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects=
/4
>
>
>
> Patches to send to netdev:
>
>     - Fixes for other trees: /
>
>     - Fixes for -net:
>
>         - [caf43b24883d] mptcp: fix deadlock in fastopen error path
> (Paolo Abeni)
>         - [abae24b094e0] mptcp: fix lockdep false positive (Paolo Abeni):
>             - can be sent =E2=86=92 done
>
>     - Fixes for net-next: /
>
>     - Features for net-next:
>
>         - [6c888567b8e2] mptcp: use msk_owned_by_me helper (Geliang Tang)
>         - [a17f5bc11fa9] mptcp: use net instead of sock_net (Geliang Tang=
)
>         - [b25bc11bcdd5] mptcp: use local variable ssk in write_options
> (Geliang Tang)
>         - [2140d45e596e] mptcp: introduce 'sk' to replace 'sock->sk' in
> mptcp_listen() (Menglong Dong)
>         - [3bc3a25c1267] mptcp: init sk->sk_prot in build_msk()
> (Menglong Dong)
>         - [2f4cc689c912] mptcp: rename 'sk' to 'ssk' in
> mptcp_token_new_connect() (Menglong Dong)
>         - [417c4c08a48d] mptcp: add statistics for mptcp socket in use
> (Menglong Dong)
>         - [04097b429968] selftest: mptcp: exit from copyfd_io_poll()
> when receive SIGUSR1 (Menglong Dong)
>         - [32fe254af698] selftest: mptcp: add test for mptcp socket in
> use (Menglong Dong):
>             - net-next is closed for the moment
>
>     - Features for net-next (next): /
>
>     - Features for other trees:
>
>         - [448a3435d4d6] mptcp: refactor push_pending logic (Geliang Tang=
)
>         - [b7d37993922b] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
> (Geliang Tang)
>         - [4a09e8f9504d] mptcp: add struct mptcp_sched_ops (Geliang Tang)
>         - [a46618febe39] mptcp: add a new sysctl scheduler (Geliang Tang)
>         - [2375224b6115] mptcp: add sched in mptcp_sock (Geliang Tang)
>         - [0212eb96c87c] mptcp: add scheduled in mptcp_subflow_context
> (Geliang Tang)
>         - [f356db97c095] mptcp: add sched_data_set_contexts helper
> (Geliang Tang)
>         - [89e8fdc3739a] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
>         - [0fbe9a607f53] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang=
)
>         - [c2630ca38c37] selftests/bpf: Add mptcp sched structs (Geliang
> Tang)
>         - [3fcc0619462c] selftests/bpf: Add bpf_first scheduler (Geliang
> Tang)
>         - [289c47eb04bc] selftests/bpf: Add bpf_first test (Geliang Tang)
>         - [598313fbfb6f] selftests/bpf: Add bpf_bkup scheduler (Geliang
> Tang)
>         - [c32fedc668e3] selftests/bpf: Add bpf_bkup test (Geliang Tang)
>         - [5306f79932ea] selftests/bpf: Add bpf_rr scheduler (Geliang Tan=
g)
>         - [6565e46c46c3] selftests/bpf: Add bpf_rr test (Geliang Tang)
>             - status: same as last week
>
>
>
> Extra tests:
>     - news about Syzkaller? (Christoph / Mat):
>         - nothing new
>
>     - news about interop with mptcp.org/other stacks? (Christoph):
>         - /
>
>     - news about Intel's kbuild? (Mat):
>         - no tests have been executed
>
>     - packetdrill (Davide):
>         - /
>
>     - Patchew (Davide):
>         - /
>
>     - CI (Matth):
>         - same status as last week
>
>
> Redundant schedulers:
>     - Olivier Bonaventure and Gregory Detal helped me to do this list
>
>     - Use cases:
>
>         - Low latency:
>             - bandwidth is not the priority, just quickly recover from
> losses
>             - Note: in this use-case, it is important to be able to
> quickly restart a connection if we need to retransmit too much (from a
> TCP point of view)
>             - (but MPTCP is maybe not the best fit for that...)
>
>         - High losses networks:
>             - does it really help because something transmitted over one
> path will have to be retransmitted anyway (from a TCP point of view)?
>             - MPTCP doesn't seem to be a good fit for that because of TCP
>
>     - cases where a "normal" scheduler might want to "quickly" reinject
> the same segment over multiple subflows:
>         - to probe one subflow:
>             - but OK to just take the last byte(s) that have been sent
>
>         - a TLP algo could be implemented at MPTCP level:
>             - alternative to TLP (tail-loss-probe):
> https://lwn.net/Articles/542642/
>             - Quickly reinject after a timeout? (after any RTO?
>             - preventively send on other links the last packet(s) that
> ends a burst/connection?
>
>         - opportunistic retransmission (re-injection):
>             - when we realize we are blocked by the window, we will need
> to re-inject the last segments over other subflows
>             - important to reach high speed
>             -
> https://www.usenix.org/system/files/conference/nsdi12/nsdi12-final125.pdf
> =E2=86=92 section 4.2
>             - in mptcp.org, it is tied to the scheduler which takes the
> decision to do that
>             - but the decision could be taken by the core =E2=86=92 react=
 to an
> event
>             - from an API point of view, this would be similar to what
> we need for the redundant scheduler:
>                 - small difference: just re-inject to one subflow
>                 - maybe using the delegate action infra would be
> possible because =E2=86=91
>             - maybe having a "redundant flag" not to "move on" would be
> enough?
>
>     - techniques:
>         - enough to just remember the last MPTCP data seq sent per subflo=
w?
>         - this info should be handled by the BPF scheduler
>
>     - to simplify the implementation:
>         - always send the same amount of data
>         - if there is not enough space in the sending window: queue or dr=
op
>         - or only duplicate if we have chunks < mss with TCP_NODELAY
>
>     - listing what is needed would really be useful to (re)design the
> scheduler API:
>         - what is needed to solve some corner cases for the scheduler
>         - TODO: Matth

Hi Matt & Mat,

I suspended the work of the BPF redundant scheduler in my hand,
waiting for this redesigned new API. Please feel free to let me know
if you need any help from me during the period. If a separate
discussion meeting is needed, please let me know. I'm willing to
participate if I have time.

Thanks,
-Geliang

>
>     - What can be useful:
>         - being able to ask to be re-scheduled after a timeout (can be
> 0) and pick the subflow after (or maybe enough before?)
>
>     - what to do if we have different links?:
>         - if one subflow cannot keep up =E2=86=92 ideally skip transmitti=
ng
> chunks to keep up
>         - always tricky because we need to keep retransmitting lost data
> and we might loose quite some time
>         - =E2=86=92 might need a way to "abort", skip next chunk, etc.
>
>
>
> FOSDEM:
>     - confirmed: there will be one presentation about MPTCP in the
> upstream kernel!
>
>
>
> Next meeting:
>     - Next one on *Tuesday*, the 3rd of January.
>     - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
>     - Still open to everyone!
>     - https://annuel2.framapad.org/p/mptcp_upstreaming_20230103
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
