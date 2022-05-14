Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B5C2565
	for <mptcp@lists.linux.dev>; Sat, 14 May 2022 16:14:20 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id y41so10276139pfw.12
        for <mptcp@lists.linux.dev>; Sat, 14 May 2022 09:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7+T2uvBq0/h/gxAF1an2bc57EGIgbl2JRLthKhJsm6A=;
        b=MQjjZf6baoXJSg4fRNlqpDQiClllC9tks9XPAjcWJhVKdEP7EnwPzlrRptsOETuzwl
         iQ2BpNNLiTdejUqUSFGdAlNwnY6NOod7e2HYVbha5mJsP+Wk0mRr8PuXHwd03+NhuOGq
         xIvw7+2IfNlXVlurU632Wt5N3mAjXBNQxQ5X2dpBoEpuYaGaa+CMzS+SNlKbcnqpl5TE
         rHgfBwcW4VWLK1WmtEeq3ya9STUr8OHvLKHJAYu+UsBYr8jv90G2ANxLbduYwFCKvbPq
         epIjr3xjrgnqakWpGs/7iUaek9z+YeWpwdvOSa0xprnDHnDRQV3Rn17Aw43Xiz4Ll7Fe
         m0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7+T2uvBq0/h/gxAF1an2bc57EGIgbl2JRLthKhJsm6A=;
        b=zNk6BWkCOrJNOZFQKhSDOKl3YClQF/dLPFja/e1AR1MkVvIU2t+ZrlHk8nJIq5Zvbz
         Sz/uvAs03/gJDVW4Xgd0nPI5vfQZHYy43Jrwr3Mt39Mx1bfFBxON7MPLq2c1J+yT2Z1l
         467eVF/sTqD1/Fgga+E0wXL1/ZysEz9kPHXGUrSLS0G65BDGNrAe0UWjpgE90JVqEeER
         lu1kKNnUTpewyfkn8R4Vja0V2ihZyo9fXBRnIuqMwEmIiKbffF3Z1eMoFvPRKwjRh0zI
         N5W3zAFOGCH5zizsBp3Ctw8PKliZeqm38+GZrjH/yb4KkPGLvNSkS9zdZKrw33VMWxYr
         tR+g==
X-Gm-Message-State: AOAM531qStNgI2eEkoj7Ib5CQpYnxoe/i6AMKfmhEUKFKeJBVrbTxWSx
	C49+tY35OPBPr/YYFsW1xpzrHGQNrhdW1vpM9ywjYSPG1R5V8A==
X-Google-Smtp-Source: ABdhPJyEBNftzWc3jDhDItGHrlx6hshImQ91ALyTxEWcDhEYEvDLVlNgbOCe3l0auPc3Twja4VxFaPSahyNo3FatPfw=
X-Received: by 2002:a05:6a00:1a08:b0:510:a1db:1a91 with SMTP id
 g8-20020a056a001a0800b00510a1db1a91mr9565195pfv.69.1652544859977; Sat, 14 May
 2022 09:14:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1cd527f8-6578-7a75-24c4-7b9ab4df5774@linux.intel.com>
In-Reply-To: <1cd527f8-6578-7a75-24c4-7b9ab4df5774@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Sun, 15 May 2022 00:14:18 +0800
Message-ID: <CA+WQbwvXp06HWX1Mdj9pD=EAVAu61tN_2wMR_8eS74+7sv3f7A@mail.gmail.com>
Subject: Re: [Weekly meetings] MoM - 12th of May 2022
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2022=E5=B9=B45=
=E6=9C=8813=E6=97=A5=E5=91=A8=E4=BA=94 05:51=E5=86=99=E9=81=93=EF=BC=9A
>
>
> Hello everyone -
>
> Today was our 195th meeting, with Paolo (Red Hat), Geliang (Suse),
> Pol (Tessares), Ossama, me, (Intel), and Poorva.
>
>
> Meeting minutes:
>
> Accepted patches:
>      - The list of accepted patches can be seen on PatchWork:
>        https://patchwork.kernel.org/project/mptcp/list/?state=3D3
>
>
>      netdev (if mptcp ML is in cc) (by: Jakub Kicinski, Mat Martineau):
>
> 12838697  [net-next,5/5] mptcp: add more offered MIBs counter
> 12838695  [net-next,4/5] mptcp: never shrink offered window
> 12838694  [net-next,3/5] tcp: allow MPTCP to update the announced window
> 12838696  [net-next,2/5] mptcp: add mib for xmit window sharing
> 12838693  [net-next,1/5] mptcp: really share subflow snd_wnd
>
> 12838182  [net-next,1/2] net: switch to netif_napi_add_tx()
>     - Submitted directly to netdev by Jakub, acked by Mat
>
>
>      our repo (by: Florian Westphal, Geliang Tang, Matthieu Baerts, Paolo
> Abeni):
>
> 12841878  [mptcp-next] Squash to "selftests: bpf: add bpf_first test"
> 12841877  [mptcp-next] Squash to "selftests: bpf: verify ca_name of struc=
t
> mptc...
> 12841876  [mptcp-next] Squash to "selftests: bpf: verify token of struct
> mptcp_...
> 12841875  [mptcp-next] Squash to "selftests: bpf: test
> bpf_skc_to_mptcp_sock"
> 12841874  [mptcp-next] Squash to "selftests: bpf: add MPTCP test base"
> 12841432  [mptcp-next] Squash to "selftests: mptcp: add subflow limits
> test-cas...
>
>
> 12840782  [net,v3] net/sched: act_pedit: really ensure the skb is writabl=
e
>      - Submitted to -net tree by Paolo, merged
>      - Merged version has slightly different commit message from version =
in
> export branch
>
> 12839814  [mptcp-next] Revert "mptcp: add data lock for sk timers"
> 12839049  [mptcp-next,v2] Squash to "selftests: mptcp: add MP_FAIL reset
> testca...
> 12837432  [mptcp-next,v2] selftests: mptcp: fix MP_FAIL test-case
> 12834484  [mptcp-next] mptcp: sockopt: add TCP_DEFER_ACCEPT support
>
>
>
> Pending patches:
>      - The list of pending patches can be seen on PatchWork:
>        https://patchwork.kernel.org/project/mptcp/list/?state=3D*
>
>
>      netdev (if mptcp ML is in cc) (by: Mat Martineau):
>
> 12834755  [bpf-next,v3,8/8] selftests: bpf: verify first of struct
> mptcp_sock
> 12834754  [bpf-next,v3,7/8] selftests: bpf: verify ca_name of struct
> mptcp_sock
> 12834753  [bpf-next,v3,6/8] selftests: bpf: verify token of struct
> mptcp_sock
> 12834752  [bpf-next,v3,5/8] selftests: bpf: test bpf_skc_to_mptcp_sock
> 12834751  [bpf-next,v3,4/8] selftests: bpf: add MPTCP test base
> 12834750  [bpf-next,v3,3/8] selftests: bpf: Enable CONFIG_IKCONFIG_PROC i=
n
> conf...
> 12834749  [bpf-next,v3,2/8] bpf: add bpf_skc_to_mptcp_sock_proto
> 12834748  [bpf-next,v3,1/8] bpf: expose is_mptcp flag to bpf_tcp_sock
>    - BPF maintainers requested header changes (use existing BPF tcp heade=
r)
>    - Remove special code for is_mptcp in kernel code (requires BPF check
> for flag existance)
>    - Preparing v4
>
>
>      our repo (by: Dmytro SHYTYI, Florian Westphal, Geliang Tang, Jiapeng
> Chong, Mat Martineau, Matthieu Baerts, Paolo Abeni):
>
> 12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to
> tcp.h/mptcp.h
> 12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
> packets
> 12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support
> 12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp
> stack
> 12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes
> socket with unread data
> 12321111: RFC: mptcp: Remove redundant assignment to remaining
> 12714439: RFC: [net-next,v2] net: mptcp, Fast Open Mechanism
> - Still RFC, no change
>
> 12834420: Changes Requested: [mptcp-next] selftests: mptcp: add TCP_DEFER
> test case
>     - Decided to drop this commit
>
> 12839051: Changes Requested: [mptcp-next,v12,1/3] mptcp: add subflows
> array in sched data
> 12839052: Changes Requested: [mptcp-next,v12,2/3] selftests: bpf: add
> bpf_rr scheduler
> 12839053: Changes Requested: [mptcp-next,v12,3/3] selftests: bpf: add
> bpf_rr test
>     - Superseded
>
> 12839667: Changes Requested: [MPTCP-next] mptcp: fix checksum byte order
>     - Superseded
>
> 12843746: Changes Requested: [mptcp-next,v13,1/3] mptcp: add subflows
> array in sched data
> 12843745: Changes Requested: [mptcp-next,v13,2/3] selftests/bpf: add
> bpf_rr scheduler
> 12843747: Changes Requested: [mptcp-next,v13,3/3] selftests/bpf: add
> bpf_rr test
>     - Superseded
>
> 12843749: Changes Requested: [mptcp-next,1/4] Squash to "mptcp: add
> get_subflow wrappers"
> 12843756: Changes Requested: [mptcp-next,2/4] mptcp: add redundant
> subflows support
> 12843757: Changes Requested: [mptcp-next,3/4] selftests/bpf: add bpf_red
> scheduler
> 12843758: Changes Requested: [mptcp-next,4/4] selftests/bpf: add bpf_red
> test
>     - Superseded by v2 (next group)
>
> 12846138: New: [mptcp-next,v2,1/5] Squash to "mptcp: add get_subflow
> wrappers"
> 12846139: New: [mptcp-next,v2,2/5] mptcp: add redundant subflows support
> 12846140: New: [mptcp-next,v2,3/5] mptcp: add call_again flag in
> mptcp_sched_ops
> 12846141: New: [mptcp-next,v2,4/5] selftests/bpf: add bpf_red scheduler
> 12846142: New: [mptcp-next,v2,5/5] selftests/bpf: add bpf_red test
>     - Discussed above
>      - Addresses possible infinite loop problem
>     - Need to figure out how to best integrate with the various tx loops
> (main tx, subflow context tx, retrans)
>     - Maybe use the retrans infrastructure for redundant sends?
>     - Outstanding github issue to consider with retrans path
>     - Another issue to consider: how to behave when subflows have differe=
nt
> speeds
>     - One fast subflow could run ahead of others. Gaps will be introduced
> at some point - is it important to try to keep data contiguous on slower
> subflows?
> - Could only skip DATA_ACK'd data on slower subflows
> - May need to limit this optimization.
> - Or could just continue sending based on MPTCP-level snd_nxt and have
> less redundancy
> - May be necessary to track which subflows have previously sent specific
> data ranges
>
>
> 12844360: Changes Requested: [mptcp-net] mptcp: Do TCP fallback on early
> DSS checksum failure
>     - Posted v2
> 12844528: Changes Requested: [mptcp-next] Squash to "selftests/bpf: test
> bpf_skc_to_mptcp_sock"
> 12844529: Changes Requested: [mptcp-next] Squash to "selftests/bpf: add
> bpf_first scheduler"
>     - Superseded
> 12845243: Queued: [mptcp-next,v2] mptcp: fix checksum byte order
>     - For export-net
>
> 12845886: Queued: [mptcp-next,v2,01/14] bpf: add
> bpf_skc_to_mptcp_sock_proto
> 12845887: Queued: [mptcp-next,v2,02/14] selftests/bpf: Enable
> CONFIG_IKCONFIG_PROC in config
> 12845888: Queued: [mptcp-next,v2,03/14] selftests/bpf: add MPTCP test bas=
e
> 12845889: Queued: [mptcp-next,v2,04/14] selftests/bpf: test
> bpf_skc_to_mptcp_sock
> 12845890: Queued: [mptcp-next,v2,05/14] selftests/bpf: verify token of
> struct mptcp_sock
> 12845891: Queued: [mptcp-next,v2,06/14] selftests/bpf: verify ca_name of
> struct mptcp_sock
> 12845892: Queued: [mptcp-next,v2,07/14] selftests/bpf: verify first of
> struct mptcp_sock
> 12845893: Queued: [mptcp-next,v2,08/14] mptcp: add struct mptcp_sched_ops
> 12845894: Queued: [mptcp-next,v2,09/14] mptcp: add a new sysctl scheduler
> 12845895: Queued: [mptcp-next,v2,10/14] mptcp: add sched in mptcp_sock
> 12845896: Queued: [mptcp-next,v2,11/14] mptcp: add get_subflow wrappers
> 12845897: Queued: [mptcp-next,v2,12/14] mptcp: add bpf_mptcp_sched_ops
> 12845898: Queued: [mptcp-next,v2,13/14] selftests/bpf: add bpf_first
> scheduler
> 12845899: Queued: [mptcp-next,v2,14/14] selftests/bpf: add bpf_first test
>     - Header changes and upstream comments (see bpf-next v3 notes above,
> patchwork ids 12834748-55)
>     - Reposted patch sequence replaces patches on the export branch
>
> 12846119: New: [mptcp-next,v14,1/3] mptcp: add subflows array in sched
> data
> 12846120: New: [mptcp-next,v14,2/3] selftests/bpf: add bpf_rr scheduler
> 12846121: New: [mptcp-next,v14,3/3] selftests/bpf: add bpf_rr test
>     - Ready to review (just a rebase)
>
>
> 12846201: Queued: [mptcp-next] mptcp: stop using the
> mptcp_has_another_subflow() helper
>     - Ready to apply
>
> 12846743: New: [mptcp-net,v2] mptcp: Do TCP fallback on early DSS checksu=
m
> failure
>     - Ready for review, Paolo acked on v1
>
> 12846759: New: [mptcp-next,1/2] mptcp: Check for orphaned subflow before
> handling MP_FAIL timer
> 12846760: New: [mptcp-next,2/2] mptcp: Do not traverse the subflow
> connection list without lock
>      - Paolo reviewed
>      - Consider removing timeout flag? Worker doesn't run often and might
> not be that much work to just run the MP_FAIL check.
>
>
> Issues on Github:
>
>    275  csum: bad encoding  [bug]
>       - Patches above for checksum fix and early checksum failure fallbac=
k.
> All queued or pending review.
>
>
>      Bugs (opened, flagged as "bug" and assigned)
>
>    264  selftests: diag: failing on the public CI with the new debug.conf=
ig
> [bug] [selftests] @matttbe
>       - No progress
>       - Have noticed more intermittent failures with mptcp_join.sh (maybe
> unrelated to #264). Should run tests on net-next to see if it's only the
> export branch having problems.
>
>    181  implement data_fin ack retransmission for subflow in  TIME_WAIT
> state [bug] @mjmartineau
>       - No progress
>
>
>      Bugs (opened and flagged as "bug" and not assigned)
>
> # multipath-tcp/mptcp_net-next open issues, labeled bug, by created
> descending
>    275  csum: bad encoding  [bug]
>    248  packetdrill: more tests failing due to packets arriving later tha=
n
> expected [bug] [packetdrill]
>       - No recent comments
>
>
>      In Progress (opened, new feature and assigned)
>
>    234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
> [packetdrill] @spoorva
>       - Started looking at this. Working on extending packetdrill support
> for checksum header parsing, attempts so far make it look like some of th=
e
> low level support may be missing?
>       - Checksum functionality may depend on pending little-endian checks=
um
> fix in the kernel.
>
>    216  The infinite mapping support: packetdrill [enhancement]
> @geliangtang
>       - No update
>
>    167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
> @dcaratti
>     75  BPF: packet scheduler [enhancement] @geliangtang
>     74  BPF: path manager [enhancement] @geliangtang
>
>
>      For later (opened and not assigned assigned)
>
> # multipath-tcp/mptcp_net-next open issues, excluding those labeled bug,
> by created descending
>    273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdril=
l]
>    269  Allow having a mix of v4/v6 subflows for the same socket
> [enhancement]
>    266  Packetdrill: add MP_FAIL coverage [packetdrill]
>    236  Review supported sockopts list [enhancement]
>    222  Netlink event API: add SUBFLOW_CREATED event [enhancement]
>    215  TCP Urgent pointer and MPTCP [enhancement]
>    213  add MPTCP man page [enhancement]
>    208  better handing of ssk memory pressure in the TX path [enhancement=
]
>    202  Add sendmsg support for ancillary data [enhancement]
>    197  more mibs needed [enhancement]
>    180  Get an update when MPTCP fall back to TCP [enhancement]
>    177  improve retransmit subflow selection [enhancement]
>    169  packetdrill: add coverage for ADD_ADDR and MP_JOIN on a different
> port [enhancement] [packetdrill]
>    150  remove completely workqueue usage [enhancement]
>    141  avoid acquiring mptcp_data_lock() twice in the receive path
> [enhancement]
>    133  PM: Closing the MPTCP connection when last subflow is not the
> initial one and its IP address is removed [enhancement]
>    128  When the last subflow is closed without DATA_FIN and msk
> Established, close msk (after a timeout) [enhancement]
>     79  allow 'force to MPTCP' mode: BPF [enhancement]
>     78  notify the application (userspace) when a subflow is added/remove=
d
> [enhancement]
>     77  [gs]etsockopt: forward to new/existing SF [enhancement]
>     76  [gs]etsockopt per subflow: BPF [enhancement]
>     61  move msk clone after ctx creation [enhancement]
>     59  (MP)TFO support [enhancement]
>     57  After a few attempts of failed MPTCP, directly fallback to TCP fo=
r
> new connections [enhancement]
>     43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag interfac=
e
> [enhancement] [syzkaller]
>     41  reduce indirect call usage [enhancement]
>     24  Revisit layout of struct mptcp_subflow_context [enhancement]
>
>
>      Recently closed (since last week)
>
> # multipath-tcp/mptcp_net-next closed issues, by created descending
>    274  selftests: `mptcp_join.sh`: `delete and re-add` test is regularly
> failing [bug] [selftests] @pabeni
>       - This fix was trivial (timeout change), was squashed.
>       - Mat saw this intermittent failure recently. Maybe extend time
> again?
>    272  MPTCP is enabled but not working [question]
>    271  TCP_DEFER_ACCEPT socket option is not supported [enhancement]
> @fw-strlen
>    265  self-tests #94 && #95 failing [bug] [selftests]
>
>
> FYI: Current Roadmap:
>      - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
>      - Current/Coming merge window (5.18):
> https://github.com/multipath-tcp/mptcp_net-next/projects/14
>      - For later:
> https://github.com/multipath-tcp/mptcp_net-next/projects/4
>
>
>
> Patches to send to netdev:
>
>
>         - [4f599a2f092b] selftests: mptcp: fix a mp_fail test warning
> (Geliang Tang)
>         - [b0aaa535508a] Revert "mptcp: add data lock for sk timers" (Pao=
lo
> Abeni)
>            - Ready for net-next
>
>      - Fixes for other trees:
>
>          - [5b04359b4e1b] x86/pm: Fix false positive kmemleak report in
> msr_build_context() (Matthieu Baerts)
>             - Already merged to other tree
>
>      - Fixes for -net:
>
>          - [0fc3e8a68406] net/sched: act_pedit: really ensure the skb is
> writable (Paolo Abeni)
>             - Merged
>          - [c66fe7b3e1f2] mptcp: fix subflow accounting on close (Paolo
> Abeni)
>          - [d034c33eb0f1] selftests: mptcp: add subflow limits test-cases
> (Paolo Abeni)
>             - Ready -net
>
>      - Features for net-next:
>
>          - [1b97691cb7d2] mptcp: sockopt: add TCP_DEFER_ACCEPT support
> (Florian Westphal)
>             - Can be sent
>
>      - Features for net-next (next):
>
>          - [bee176602283] selftests: mptcp: add MP_FAIL reset testcase
> (Geliang Tang)
>              - Mostly stable, depends on pedit fix.
>              - Send to net-next after pedit patch synced to net-next

Hi Mat,

I just checked. The pedit fix patch has been already synced to
net-next, so this "MP_FAIL reset testcase" patch is ready to upstream.

Thanks,
-Geliang

>
>      - Features for other trees:
>
>          - [31f889a05b1f] bpf: expose is_mptcp flag to bpf_tcp_sock
> (Nicolas Rybowski)
>          - [11ea3a4987ca] bpf: add bpf_skc_to_mptcp_sock_proto (Geliang
> Tang)
>          - [d63d3713c9aa] selftests/bpf: Enable CONFIG_IKCONFIG_PROC in
> config (Geliang Tang)
>          - [ff47004e086b] selftests/bpf: add MPTCP test base (Nicolas
> Rybowski)
>          - [c17b8064397a] selftests/bpf: test bpf_skc_to_mptcp_sock
> (Geliang Tang)
>          - [68e0de300349] selftests/bpf: verify token of struct mptcp_soc=
k
> (Geliang Tang)
>          - [904e3d36a172] selftests/bpf: verify ca_name of struct
> mptcp_sock (Geliang Tang)
>          - [f56353b65803] selftests/bpf: verify first of struct mptcp_soc=
k
> (Geliang Tang)
>          - [d0627442d66c] mptcp: add struct mptcp_sched_ops (Geliang Tang=
)
>          - [cdcc9fe2185f] mptcp: add a new sysctl scheduler (Geliang Tang=
)
>          - [3e10c3aaa352] mptcp: add sched in mptcp_sock (Geliang Tang)
>          - [e08ed807738f] mptcp: add get_subflow wrappers (Geliang Tang)
>          - [e6f420ea37ad] mptcp: add bpf_mptcp_sched_ops (Geliang Tang)
>          - [04050c87c7c2] selftests/bpf: add bpf_first scheduler (Geliang
> Tang)
>          - [db74fd7fcef8] selftests/bpf: add bpf_first test (Geliang Tang=
)
>             - Early patches ready for v4 to bpf-next
>             - Scheduler patches still iterating on BPF API for MPTCP
> scheduler. Not for this merge window.
>
>
> Extra tests:
>      - news about Syzkaller? (Christoph / Mat):
>          - No new MPTCP issues
>
>      - news about interop with mptcp.org/other stacks? (Christoph):
>          - /
>
>      - news about Intel's kbuild? (Mat):
>          - Same intermittent failures as MPTCP public CI
>
>      - packetdrill (Davide):
>          - /
>
>      - Patchew (Davide):
>          - Patchew seems to be down today
>
>      - CI (Matth):
>          - /
>
> Additional topic:
>
> Netdev series modifying MPTCP diag.c: https://patchwork.kernel.org/projec=
t/netdevbpf/list/?series=3D640767
>     - Changes listen hash throughout the net tree.
>
>
> Next meeting:
>       - Thursday, May 19th 2022.
>       - 15:00 UTC (8am PST, 5pm CET, 11pm CST)
>       - Still open to everyone!
>       - https://meet.google.com/edk-rkrk-vaj
>       - https://annuel2.framapad.org/p/mptcp_upstreaming_20220519
