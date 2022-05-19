Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B686E28EE
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 16:27:43 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id y13so10244706eje.2
        for <mptcp@lists.linux.dev>; Thu, 19 May 2022 09:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=DMfNZRPFOeNjES17KfWvKgINRbkykQaERMBvFIzkhkg=;
        b=p5TdmxxJmOg7zVIuQyWZ05v8pwRUeCotLFaz8be34z0ujiYvx67qTmxxWVPjxosTgB
         h2NKzQiiE4A+B6CIQPNCJ/WUCo0/NolyP7YlMWePUaCNabY2Dp5WzK/vawqntX6KTavy
         L+FCzq3OBExOYVR+OZwjZgVCGWfyRE+fEdzmYcRO7LY0m+66UXj/tPfNvKJkrl2TQZev
         MBpetVoN3uR+bD4wIIUdG1zgTruZIbvZ4BRl494oXuxMX9JrQG+3HsxGsk8JtB4+pvGT
         fzEL5wSCJBo/uUr8qtvk2ZdfpdNFZ8S3IFAtsnWxBuigMhcfgQG9B8UzIaiJw0SvFBTs
         0OIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=DMfNZRPFOeNjES17KfWvKgINRbkykQaERMBvFIzkhkg=;
        b=En3OthQV2vSfd8RADY+VPovgtBt9C4L7qP1suDIJJ96Hwwa7nQJprHveNl6L04ChAr
         Ble0UG/SDjS6oGhgTUDk09M751Lurgnaaeq3ZOU3wlQrEo+wTW3X7pLNwS0PLexc6pTo
         wt4YyKCi05P20Cpa1H7Y1Ni4zLwEtO9EiER1DoaGkwlIcBmN/FWLmSyJDX4qUTwUzPUm
         sPHW/lbPlS8pexZ74xAwo/5kBJJUXDAqGK7WuKFX7LgYnJpjly73bm2d22aKbgiW14Hw
         2XsWI9vw7VDXcJbEfrXr1L7VjL0p3dg9lJPYw3K+XDzX5kkXflm/ddqR8JZQCc/h4b9W
         jDjA==
X-Gm-Message-State: AOAM5318/0C2gfawP3MEyc6s7n0vQppojDO+9DxgthJx8CqExj+Lwnrk
	Acq+PGvJdGXWI6kNv3/VgobbtVzqlgFQbw==
X-Google-Smtp-Source: ABdhPJzcQbd3gjRQtyCpP2KxjmdXDYfV7LXTU8o5cpwRkqrpSOmbbHFlW/mmIeReFgayKwnFl+NPjw==
X-Received: by 2002:a17:906:f17:b0:6fe:94f6:cb8a with SMTP id z23-20020a1709060f1700b006fe94f6cb8amr4815303eji.456.1652977661239;
        Thu, 19 May 2022 09:27:41 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:dd49:d598:4fbc:6d53? ([2a02:578:8593:1200:dd49:d598:4fbc:6d53])
        by smtp.gmail.com with ESMTPSA id f4-20020a1709063f4400b006f3ef214d9fsm2262262ejj.5.2022.05.19.09.27.40
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 09:27:40 -0700 (PDT)
Message-ID: <ca0a356d-ac5e-59de-73de-b051cd65571f@tessares.net>
Date: Thu, 19 May 2022 18:27:40 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 19th of May 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we just had our 196th meeting with Mat and Ossama (Intel)
Paolo, Davide (Red Hat), Geliang (SUSE), Geray (Parkyeri), Poorva and
myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:


Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12852823  [net,2/2] mptcp: Do TCP fallback on early DSS checksum failure
12852825  [net,1/2] mptcp: fix checksum byte order:
    - should be backported to -stable
    - likely there are conflicts
    - we need to wait for these two patches to be in Linus' tree (should
be soon, PR for -net sent this morning)
    - Mat will check if there are conflicts
    - We should be notified if the stable team tries to apply them but
there are issues with them

12849595  [net-next,3/3] mptcp: sockopt: add TCP_DEFER_ACCEPT support
12849593  [net-next,2/3] Revert "mptcp: add data lock for sk timers"
12849594  [net-next,1/3] selftests: mptcp: fix a mp_fail test warning

12848200  [net,2/2] selftests: mptcp: add subflow limits test-cases
12848199  [net,1/2] mptcp: fix subflow accounting on close


    our repo (by: Geliang Tang, Mat Martineau, Paolo Abeni):

12854665  [mptcp-next,v2] Squash to "selftests/bpf: add bpf_first test"
12854664  [mptcp-next,v2,7/7] selftests/bpf: verify first of struct
mptcp_sock
12854663  [mptcp-next,v2,6/7] selftests/bpf: verify ca_name of struct
mptcp_sock
12854662  [mptcp-next,v2,5/7] selftests/bpf: verify token of struct
mptcp_sock
12854661  [mptcp-next,v2,4/7] selftests/bpf: test bpf_skc_to_mptcp_sock
12854660  [mptcp-next,v2,3/7] selftests/bpf: add MPTCP test base
12854659  [mptcp-next,v2,2/7] selftests/bpf: Enable CONFIG_IKCONFIG_PROC
in con...
12854658  [mptcp-next,v2,1/7] bpf: add bpf_skc_to_mptcp_sock_proto:
    - full patches, for upstream (v5)

12850273  [mptcp-next] Squash to "selftests/bpf: test bpf_skc_to_mptcp_sock"
12850208  [mptcp-next] Squash to "mptcp: add sched in mptcp_sock"
12849591  [mptcp-next] Squash to "selftests/bpf: add MPTCP test base":
    - for upstream v5

12848254  [mptcp-next,v2] mptcp: Do not traverse the subflow connection
list wi...
12846759  [mptcp-next,1/2] mptcp: Check for orphaned subflow before
handling MP...
    - already upstreamed

12846743  [mptcp-net,v2] mptcp: Do TCP fallback on early DSS checksum
failure
    - already upstreamed

12846201  [mptcp-next] mptcp: stop using the mptcp_has_another_subflow()
helper
    - already upstreamed

12845899  [mptcp-next,v2,14/14] selftests/bpf: add bpf_first test
12845898  [mptcp-next,v2,13/14] selftests/bpf: add bpf_first scheduler
12845897  [mptcp-next,v2,12/14] mptcp: add bpf_mptcp_sched_ops
12845896  [mptcp-next,v2,11/14] mptcp: add get_subflow wrappers
12845895  [mptcp-next,v2,10/14] mptcp: add sched in mptcp_sock
12845894  [mptcp-next,v2,09/14] mptcp: add a new sysctl scheduler
12845893  [mptcp-next,v2,08/14] mptcp: add struct mptcp_sched_ops

12845243  [mptcp-next,v2] mptcp: fix checksum byte order
    - already upstreamed (-net)



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12854189  [net-next,4/4] selftests: mptcp: add MP_FAIL reset testcase
12854188  [net-next,3/4] mptcp: Do not traverse the subflow connection
list wit...
12854187  [net-next,2/4] mptcp: Check for orphaned subflow before
handling MP_F...
12854186  [net-next,1/4] mptcp: stop using the
mptcp_has_another_subflow() help...:
    - waiting for review

12849553  [bpf-next,v4,7/7] selftests/bpf: verify first of struct mptcp_sock
12849556  [bpf-next,v4,6/7] selftests/bpf: verify ca_name of struct
mptcp_sock
12849555  [bpf-next,v4,5/7] selftests/bpf: verify token of struct mptcp_sock
12849557  [bpf-next,v4,4/7] selftests/bpf: test bpf_skc_to_mptcp_sock
12849554  [bpf-next,v4,3/7] selftests/bpf: add MPTCP test base
12849551  [bpf-next,v4,2/7] selftests/bpf: Enable CONFIG_IKCONFIG_PROC
in config
12849552  [bpf-next,v4,1/7] bpf: add bpf_skc_to_mptcp_sock_proto:
    - v5 in preparation
    - our export branch  seems to be up to date, we can send the v5


    our repo (by: Dmytro SHYTYI, Geliang Tang, Jiapeng Chong, Matthieu
Baerts):

12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to
tcp.h/mptcp.h
12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in
reset packets
12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support
12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp
stack
12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes
socket with unread data
12321111: RFC: mptcp: Remove redundant assignment to remaining
12714439: RFC: [net-next,v2] net: mptcp, Fast Open Mechanism:
    - RFCs
    - Dmytro has been contacted by Matt, waiting for a reply
    - (after meeting): Dmytro had to pause this, he will be back working
on them

12846119: Changes Requested: [mptcp-next,v14,1/3] mptcp: add subflows
array in sched data
12846120: Changes Requested: [mptcp-next,v14,2/3] selftests/bpf: add
bpf_rr scheduler
12846121: Changes Requested: [mptcp-next,v14,3/3] selftests/bpf: add
bpf_rr test:
    - no update, focus was on "bpf: mptcp: Support for mptcp_sock", v5

12846138: Changes Requested: [mptcp-next,v2,1/5] Squash to "mptcp: add
get_subflow wrappers"
12846139: Changes Requested: [mptcp-next,v2,2/5] mptcp: add redundant
subflows support
12846140: Changes Requested: [mptcp-next,v2,3/5] mptcp: add call_again
flag in mptcp_sched_ops
12846141: Changes Requested: [mptcp-next,v2,4/5] selftests/bpf: add
bpf_red scheduler
12846142: Changes Requested: [mptcp-next,v2,5/5] selftests/bpf: add
bpf_red test:
    - no update, focus was on "bpf: mptcp: Support for mptcp_sock", v5



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 275)

  276  <linux/mptcp.h> conflict with <netinet/in.h> in C library:
      - Ossama has a patch, he will share it on the ML
      - with a Fixes tag
      - for -net or net-next, doesn't matter, we are just before a release
      - maybe not a specific MPTCP issue because if we do this, we also
have issues:
          #include <linux/in.h>
          #include <netinet/in.h>
      - with Ossama's patch, it is more to help reducing issues for
userspace


    Bugs (opened, flagged as "bug" and assigned)

  264  selftests: diag: failing on the public CI with the new
debug.config [bug] [selftests] @matttbe:
      - no update but it seems the patch is needed

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug] @mjmartineau:
      - no update


    Bugs (opened and flagged as "bug" and not assigned)

  275  csum: bad encoding  [bug]:
      - Mat did various tests, including some interop with mptcp.org:
          - there are some issues on mptcp.org's side
          - (mptcp_v0.96 branch (on top of v5.4.x) can be used instead
of mptcp_trunk (on top of v5.4.0))
      - TODO: can be closed → done

  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]


    In Progress (opened, new feature and assigned)

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  216  The infinite mapping support: packetdrill [enhancement] @geliangtang
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
       - see patches above

   74  BPF: path manager [enhancement] @geliangtang


    For later (opened and not assigned assigned)

  276  <linux/mptcp.h> conflict with <netinet/in.h> in C library
  273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdrill]
  269  Allow having a mix of v4/v6 subflows for the same socket
[enhancement]
  266  Packetdrill: add MP_FAIL coverage [packetdrill]
  236  Review supported sockopts list [enhancement]
  222  Netlink event API: add SUBFLOW_CREATED event [enhancement]
  215  TCP Urgent pointer and MPTCP [enhancement]
  213  add MPTCP man page [enhancement]
  208  better handing of ssk memory pressure in the TX path [enhancement]
  202  Add sendmsg support for ancillary data [enhancement]
  197  more mibs needed [enhancement]
  180  Get an update when MPTCP fall back to TCP [enhancement]
  177  improve retransmit subflow selection [enhancement]
  169  packetdrill: add coverage for ADD_ADDR and MP_JOIN on a different
port [enhancement] [packetdrill]
  150  remove completely workqueue usage [enhancement]
  141  avoid acquiring mptcp_data_lock() twice in the receive path
[enhancement]
  133  PM: Closing the MPTCP connection when last subflow is not the
initial one and its IP address is removed [enhancement]
  128  When the last subflow is closed without DATA_FIN and msk
Established, close msk (after a timeout) [enhancement]
   79  allow 'force to MPTCP' mode: BPF [enhancement]
   78  notify the application (userspace) when a subflow is
added/removed [enhancement]
   77  [gs]etsockopt: forward to new/existing SF [enhancement]
   76  [gs]etsockopt per subflow: BPF [enhancement]
   61  move msk clone after ctx creation [enhancement]
   59  (MP)TFO support [enhancement]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since last week)

None.



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.18):
https://github.com/multipath-tcp/mptcp_net-next/projects/14
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees:

        - [9ab07397c64b] x86/pm: Fix false positive kmemleak report in
msr_build_context() (Matthieu Baerts):
            - applied in another tree

    - Fixes for -net:

        - [a5832bb90371] mptcp: fix subflow accounting on close (Paolo
Abeni)
        - [21e54d5eac0a] selftests: mptcp: add subflow limits test-cases
(Paolo Abeni)
        - [bbf84da5aeee] mptcp: fix checksum byte order (Paolo Abeni)
        - [235188e818f2] mptcp: Do TCP fallback on early DSS checksum
failure (Mat Martineau):
            - already applied

    - Fixes for net-next:

        - [8e72f260d41d] mptcp: stop using the
mptcp_has_another_subflow() helper (Paolo Abeni)
        - [92480f22248b] mptcp: Check for orphaned subflow before
handling MP_FAIL timer (Mat Martineau)
        - [d489b3f71797] mptcp: Do not traverse the subflow connection
list without lock (Mat Martineau):
            - waiting for review upstream

        - [81f0bf9004c5] fix up for "netfilter: conntrack: remove
unconfirmed list" (Stephen Rothwell):
            - was needed for the CI
            - probably another commit with the same content will be
applied in net-next

    - Features for net-next (next):

        - [aee7ac863083] selftests: mptcp: add MP_FAIL reset testcase
(Geliang Tang):
            - waiting for review upstream


    - Features for other trees:

        - [0949ae8e0b82] bpf: add bpf_skc_to_mptcp_sock_proto (Geliang Tang)
        - [f7cf2b38dcac] selftests/bpf: Enable CONFIG_IKCONFIG_PROC in
config (Geliang Tang)
        - [ceed7b801718] selftests/bpf: add MPTCP test base (Nicolas
Rybowski)
        - [3f7486bcb834] selftests/bpf: test bpf_skc_to_mptcp_sock
(Geliang Tang)
        - [398bf8fd43a8] selftests/bpf: verify token of struct
mptcp_sock (Geliang Tang)
        - [2e1e0d684b0c] selftests/bpf: verify ca_name of struct
mptcp_sock (Geliang Tang)
        - [21584b33ae60] selftests/bpf: verify first of struct
mptcp_sock (Geliang Tang):
            - v5 in preparation
            - Mat will send the v5

        - [e2610c47e6f0] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [3d1a455e2636] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [bbb790daf8e0] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [c487be440767] mptcp: add get_subflow wrappers (Geliang Tang)
        - [7da6a2e4bbd1] mptcp: add bpf_mptcp_sched_ops (Geliang Tang)
        - [c6596495254d] selftests/bpf: add bpf_first scheduler (Geliang
Tang)
        - [2bf3e64c532b] selftests/bpf: add bpf_first test (Geliang Tang):
            - depending on the previous ones, we need to wait



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - nothing related to MPTCP

    - news about interop with mptcp.org/other stacks? (Christoph):
        - did some tests with the checksum, seems better

    - news about Intel's kbuild? (Mat):
        - some build issues but not related to MPTCP
        - some issues with the selftests

    - packetdrill (Davide):
        - some modifications in preparation from Davide (IPv6, core)
        - Poorva is checking at the checksum issues, will share patches
later
        - Poorva saw that a RST was sent instead of falling back to TCP:
            - it should fall back to TCP now thx to Mat's patch,
recently applied in -net

    - Patchew (Davide):
        - there was a downtime last time but it was probably just lagging
        - Davide is checking the email account to see if there are
patches not marked as applied
        - could it be possible to apply patches for 'net' (mptcp-net) on
top of 'export-net' branch?
        - (ideally on top of both export-net and export):
            - not easy with patchew: only one tree is supported

    - CI (Matth):
        - Recurrent issues with:
            - diag
            - mptcp_join.sh: 95: Infinite map:
                - mptcp-next:
https://api.cirrus-ci.com/v1/artifact/task/5640387103555584/summary/summary.txt
                - Paolo was not able to reproduce it easily:
                    - only 1 in 300 attempts
                    - quickly looked at pcap
                    - looks like a timing issue: counter is not updated
when it we look at it but it is likely updated just after
            - mptcp_join.sh: 32: remove subflows and signal:
                - mptcp-net:
https://api.cirrus-ci.com/v1/artifact/task/6108300839223296/summary/summary.txt
                - mptcp-next:
https://api.cirrus-ci.com/v1/artifact/task/5077437150134272/summary/summary.txt
                - to be checked if it is due to a recent regression or not

        - A kernel WARNING has been reported by the public CI twice this
week:
            -
https://api.cirrus-ci.com/v1/artifact/task/5443925702868992/summary/summary.txt
            - https://cirrus-ci.com/task/5443925702868992
            - not reproduced all the time
            - without a debug kernel config
            - Matth: try to reproduce it locally
            - could be nice to print the reason



Next meeting:
    - /!\ No meeting next week /!\
    - Next one on Thursday, the 2nd of June.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220602



Feel free to comment on these points and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
