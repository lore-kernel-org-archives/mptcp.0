Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7989F28EE
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 14:49:42 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id er5so7249599edb.12
        for <mptcp@lists.linux.dev>; Thu, 19 May 2022 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from:to
         :subject:content-transfer-encoding;
        bh=EoJSGzw1qJr2BZZ9ZwSP3EMG5iRmkjznKzo5ONBdzt8=;
        b=0a4OatK49XNN9N8ZDeU2YghRs0Fb2ttLhYCOp9aWdRFF10SPQgsjqMQ5//sJpCsk0S
         1QsczpgM+M1mkrkYMCVZvTdR5Bnc3YnCJeSnmtZHW1wI1aTBByOn/vMv4cCv+clUnUQd
         0TN3F+kPOVqwrwyEXy67dErTYln3vUi5Y5bq5jWImv9ZZ49HTt1DJ2BQM/mQjUxVUuow
         Yu9XLXvFImB7ejb6q9BwQEKwZMFbM4R6J3ws9Tx+/tgg+WfS1MVN5bMmI/UE3C/ycwT+
         exqp+B8aKM24JIEu9V9u52nFVhIZh+KwZVn3f1aZm2rh7K1fyBEIuqGX4wHsv40QW2qV
         j+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:subject:content-transfer-encoding;
        bh=EoJSGzw1qJr2BZZ9ZwSP3EMG5iRmkjznKzo5ONBdzt8=;
        b=gZ7UjHTW1h3v3t1UtXzgLOgRDfiI2TBY8vuOUbAWTPNDzj67GOOQDnJaCWAcKtrF67
         Bg9Mzq/4cJX5l1VS3H6gnPI9jV3Y4qAsVg0lc49ZblLyuJNqF+TmWChQSeg4Kzlu2TaP
         nVW+pnJxexG8Txe5YLGHKspkidUfWhBSH2t3Tr8QN7eW6pXYwoE8q0anTwbLnxPqwbyL
         n3V0Zhm4jGZhEJXbppRgPkgw4sVpL6F+Tiu+DrkLJHaMhax+s8GhCWysWlg9DwVxzzAZ
         fabP2fqItBxVPTV6mtpoTcdXAGqH3SOjoqYHHRPoUDd9CRKJiGYYcBv7r7ADS0G40cRp
         Lcag==
X-Gm-Message-State: AOAM533qLYH9F/D3xZQ8eUOxkJNDefAo20kX6QXoMlpcTaCV+dR/oa0L
	2CdK4KsK5D2KkSuXUdFmjx+B/BKglk2vag==
X-Google-Smtp-Source: ABdhPJznsVx5vmLRiwbpZn6BrguLnxwdLJSxQaxPTpZZ8L06xFkMX4ec7alA3Jqj0by7PAsyTZgR2Q==
X-Received: by 2002:a05:6402:2399:b0:42b:764:60e1 with SMTP id j25-20020a056402239900b0042b076460e1mr2552748eda.52.1652971780003;
        Thu, 19 May 2022 07:49:40 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:dd49:d598:4fbc:6d53? ([2a02:578:8593:1200:dd49:d598:4fbc:6d53])
        by smtp.gmail.com with ESMTPSA id j29-20020a170906535d00b006f3ef214e4esm2140243ejo.180.2022.05.19.07.49.39
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 07:49:39 -0700 (PDT)
Message-ID: <aaab7bbd-9a3b-27be-4ac1-6559e0bf8552@tessares.net>
Date: Thu, 19 May 2022 16:49:38 +0200
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
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 5th of May 2022
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Two weeks ago, we had our 194th meeting with Mat, Ossama, Kishen (Intel)
Paolo, Davide (Red Hat), Geliang (SUSE) and myself (Tessares).

(sorry, I forgot to send this)


Thanks again for this new good meeting!

Here are the minutes of the meeting:


Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12834735  [net-next,7/7] mptcp: allow ADD_ADDR reissuance by userspace PMs
12834733  [net-next,6/7] mptcp: expose server_side attribute in MPTCP
netlink e...
12834734  [net-next,5/7] mptcp: establish subflows from either end of
connection
12834732  [net-next,4/7] mptcp: reflect remote port (not 0) in ANNOUNCED
events
12834731  [net-next,3/7] mptcp: store remote id from MP_JOIN SYN/ACK in
local c...
12834729  [net-next,2/7] selftests: mptcp: ADD_ADDR echo test with
missing user...
12834730  [net-next,1/7] mptcp: bypass in-kernel PM restrictions for
non-kernel...

12837079  [net-next,13/13] selftests: mptcp: functional tests for the
userspace...
12837074  [net-next,12/13] selftests: mptcp: create listeners to receive
MPJs
12837073  [net-next,11/13] selftests: mptcp: capture netlink events
12837070  [net-next,10/13] selftests: mptcp: support
MPTCP_PM_CMD_SUBFLOW_DESTR...
12837082  [net-next,09/13] selftests: mptcp: support
MPTCP_PM_CMD_SUBFLOW_CREATE
12837081  [net-next,08/13] mptcp: netlink: allow userspace-driven
subflow estab...
12837080  [net-next,07/13] selftests: mptcp: support MPTCP_PM_CMD_REMOVE
12837078  [net-next,06/13] mptcp: netlink: Add MPTCP_PM_CMD_REMOVE
12837077  [net-next,05/13] selftests: mptcp: support MPTCP_PM_CMD_ANNOUNCE
12837076  [net-next,04/13] mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE
12837075  [net-next,03/13] mptcp: netlink: split mptcp_pm_parse_addr
into two f...
12837071  [net-next,02/13] mptcp: read attributes of addr entries
managed by us...
12837072  [net-next,01/13] mptcp: handle local addrs announced by
userspace PMs


    our repo (by: Geliang Tang, Paolo Abeni):

12836606  [mptcp-next] Squash to "selftests: bpf: add bpf_first test"
12835814  [mptcp-next] Squash to "selftests: bpf: add bpf_first test v18"
12834928  [mptcp-next] selftests: mptcp: fix a mp_fail test warning
12834895  [mptcp-next] Squash to "selftests: bpf: add bpf_first
scheduler v18"
12834894  [mptcp-next] Squash to "mptcp: add struct mptcp_sched_ops v18"
12834372  [mptcp-next] Squash to "mptcp: add bpf_mptcp_sched_ops v18"
12833688  [mptcp-next] Squash to "mptcp: add get_subflow wrappers v18"
12833672  [mptcp-next,v18,7/7] selftests: bpf: add bpf_first test
12833671  [mptcp-next,v18,6/7] selftests: bpf: add bpf_first scheduler
12833670  [mptcp-next,v18,5/7] mptcp: add bpf_mptcp_sched_ops
12833669  [mptcp-next,v18,4/7] mptcp: add get_subflow wrappers
12833668  [mptcp-next,v18,3/7] mptcp: add sched in mptcp_sock
12833667  [mptcp-next,v18,2/7] mptcp: add a new sysctl scheduler
12833666  [mptcp-next,v18,1/7] mptcp: add struct mptcp_sched_ops:
    - series: BPF packet scheduler

12833305  [mptcp-next] Squash to "selftests: bpf: verify ca_name of
struct mptc...
12832553  [mptcp-net,v2] net/sched: act_pedit: really ensure the skb is
writable
12831059  [mptcp-net,2/2] selftests: mptcp: add subflow limits test-cases
12831058  [mptcp-net,1/2] mptcp: fix subflow accounting on close
12829923  [mptcp-next,v2] selftests/bpf: Enable CONFIG_IKCONFIG_PROC in
config



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Jakub Kicinski, Mat Martineau):

12838697  [net-next,5/5] mptcp: add more offered MIBs counter
12838695  [net-next,4/5] mptcp: never shrink offered window
12838694  [net-next,3/5] tcp: allow MPTCP to update the announced window
12838696  [net-next,2/5] mptcp: add mib for xmit window sharing
12838693  [net-next,1/5] mptcp: really share subflow snd_wnd:
    - series: mptcp: Improve MPTCP-level window tracking
    - waiting for a review from Eric

net/sched: act_pedit: really ensure the skb is writable:
    - v2 is required
    - not in patchword because MPTCP ML was not in cc

12838182  [net-next,1/2] net: switch to netif_napi_add_tx():
    - ACKed by Mat

12834755  [bpf-next,v3,8/8] selftests: bpf: verify first of struct
mptcp_sock
12834754  [bpf-next,v3,7/8] selftests: bpf: verify ca_name of struct
mptcp_sock
12834753  [bpf-next,v3,6/8] selftests: bpf: verify token of struct
mptcp_sock
12834752  [bpf-next,v3,5/8] selftests: bpf: test bpf_skc_to_mptcp_sock
12834751  [bpf-next,v3,4/8] selftests: bpf: add MPTCP test base
12834750  [bpf-next,v3,3/8] selftests: bpf: Enable CONFIG_IKCONFIG_PROC
in conf...
12834749  [bpf-next,v3,2/8] bpf: add bpf_skc_to_mptcp_sock_proto
12834748  [bpf-next,v3,1/8] bpf: expose is_mptcp flag to bpf_tcp_sock:
    - v1 has been reviewed
    - the CI reported an issue in v2, fixed in v3
    - v3 has an issue because 'ip mptcp monitor' is not available:
        - Mat asked if it is an issue we need to address or if they can
update their CI
        - iproute2 is available but it is an older version in one of the
environment → probably not normal



    our repo (by: Dan Carpenter, Dmytro SHYTYI, Florian Westphal,
Geliang Tang, Jiapeng Chong, Matthieu Baerts, Paolo Abeni):

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
    - RFC
    - TODO: Matth: send an email to know if he plans to continue working
on it → done

12834484: Queued: [mptcp-next] mptcp: sockopt: add TCP_DEFER_ACCEPT support:
    - TODO: Matth: can be applied → done

12834420: Changes Requested: [mptcp-next] selftests: mptcp: add
TCP_DEFER test case:
    - set and getsockopt doesn't always report the same value → probably
best to drop it
    - TODO: Matth: drop → done

12837432: Queued: [mptcp-next,v2] selftests: mptcp: fix MP_FAIL test-case:
    - can be squashed in "selftests: mptcp: add MP_FAIL reset testcase"

12839049: New: [mptcp-next,v2] Squash to "selftests: mptcp: add MP_FAIL
reset testcase" - cleanups:
    - should be OK to squash

12839051: New: [mptcp-next,v12,1/3] mptcp: add subflows array in sched data
12839052: New: [mptcp-next,v12,2/3] selftests: bpf: add bpf_rr scheduler
12839053: New: [mptcp-next,v12,3/3] selftests: bpf: add bpf_rr test:
    - new v12
    - Mat is going to review it

12839387: New: [net-next] mptcp: fix deadlock in mptcp_close():
    - found by static analytic tools
    - deadlock not possible but it raised the point there is something
wrong there
    - probably needed to revert 4293248c6704 ("mptcp: add data lock for
sk timers")
    - it looks indeed not needed

12839667: New: [MPTCP-next] mptcp: fix checksum byte order:
    - Maxim did nice interop tests
    - Paolo made a patch
    - Issue is that we loose interop with older version:
        - only if checksum is used which is not the case by default
        - workaround is to disable the checksum
    - how to automatically validate (or manual with VM)?:
        - the BPF CI is using a specific arch for that, we could do the same
        - we could have interop test with multiple VMs
        - test with mptcp.org?:
            - no because there is still an issue with MPC+data, see:
                https://github.com/multipath-tcp/mptcp/issues/427
    - v2 certainly needed because of:

https://github.com/multipath-tcp/mptcp_net-next/runs/6308768176?check_suite_focus=true#step%3A6%3A3343=
    - should be for -net, we will need to backport it:
        - (was easier to do it on top of net-next)


12839670: New: [net] net/sched: act_pedit: really ensure the skb is
writable:
    - new version addressing Jakub's comments



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 271)

  274  selftests: `mptcp_join.sh`: `delete and re-add` test is regularly
failing [bug] [selftests]:
      - Probably linked to the sleep we do
      - Paolo will try to have a look

  273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdrill]:
      - linked to #48: MP_FASTCLOSE support has been added in the kernel
      - but we should add a test in packetdrill

  269  Allow having a mix of v4/v6 subflows for the same socket
[enhancement]:
       - it sounds important for some use-cases
       - what is blocking?
       - it looks like the PM only create (and accept?) subflows if they
have the same family as the msk (either v4, v6, v4 mapped in v6) but
doesn't allow different families, e.g.:
           - we can configure a server to announce a v6
           - we create a connection to the v4 address of the server
           - the server correctly announces a v6 address
           - but the client will never create a new subflow even if it
has a v6 address (and not a v4 only socket)
        - just a limitation on the PM side?


    Bugs (opened, flagged as "bug" and assigned)

  264  selftests: diag: failing on the public CI with the new
debug.config [bug] [selftests] @matttbe
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug] @mjmartineau


    Bugs (opened and flagged as "bug" and not assigned)

  274  selftests: `mptcp_join.sh`: `delete and re-add` test is regularly
failing [bug] [selftests]

  265  self-tests #94 && #95 failing [bug] [selftests]:
      - one remaining patch

  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]


    In Progress (opened, new feature and assigned)

  271  TCP_DEFER_ACCEPT socket option is not supported [enhancement]
@fw-strlen:
      - see patches above

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  216  The infinite mapping support: packetdrill [enhancement] @geliangtang
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
       - see patches above

   74  BPF: path manager [enhancement] @geliangtang


    For later (opened and not assigned assigned)

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

  272  MPTCP is enabled but not working [question]
  270  KASAN: use-after-free in dst_destroy (net/core/dst.c:118)  [bug]
[selftests] @matttbe
   48  MP_FASTCLOSE support (send part remaining) [enhancement]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.18):
https://github.com/multipath-tcp/mptcp_net-next/projects/14
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:


    - Fixes for net-next:

        (TODO: Matth: missing title for this section: done)

        - [c11cd8070c74] selftests: mptcp: fix a mp_fail test warning
(Geliang Tang):
            - can be sent

    - Fixes for other trees:

        - [76f0388e239d] x86/pm: Fix false positive kmemleak report in
msr_build_context() (Matthieu Baerts):
            - already sent and merged in another tree

    - Fixes for -net:

        - [00a84e17aee3] net/sched: act_pedit: really ensure the skb is
writable (Paolo Abeni):
            - v2 in preparation

        - [94ef858b8029] mptcp: fix subflow accounting on close (Paolo
Abeni)
        - [d91ecca06ce2] selftests: mptcp: add subflow limits test-cases
(Paolo Abeni):
            - the new selftest is unstable, best to wait

    - Features for net-next:

        - [08971c063ee5] mptcp: really share subflow snd_wnd (Paolo Abeni)
        - [1c0a25cd6484] mptcp: add mib for xmit window sharing (Paolo
Abeni)
        - [0e52eeb9390b] tcp: allow MPTCP to update the announced window
(Paolo Abeni)
        - [03e2c36812f5] mptcp: never shrink offered window (Paolo Abeni)
        - [610a564199a6] mptcp: add more offered MIBs counter (Paolo Abeni):
            - already sent, pending

    - Features for net-next (next):

        - [16f4e4773f0d] selftests: mptcp: add MP_FAIL reset testcase
(Geliang Tang):
            - two patches to squash here and then it should be ready!

    - Features for other trees:

        - [da6f7bf8bf09] bpf: expose is_mptcp flag to bpf_tcp_sock
(Nicolas Rybowski)
        - [9f35ccece76a] bpf: add bpf_skc_to_mptcp_sock_proto (Geliang Tang)
        - [b24c7eb32887] selftests: bpf: Enable CONFIG_IKCONFIG_PROC in
config (Geliang Tang)
        - [33b264f22cdd] selftests: bpf: add MPTCP test base (Nicolas
Rybowski)
        - [6283245f8779] selftests: bpf: test bpf_skc_to_mptcp_sock
(Geliang Tang)
        - [8f21f6916667] selftests: bpf: verify token of struct
mptcp_sock (Geliang Tang)
        - [85c55c44b693] selftests: bpf: verify ca_name of struct
mptcp_sock (Geliang Tang)
        - [f493b4b232a7] selftests: bpf: verify first of struct
mptcp_sock (Geliang Tang):
            - has been sent, pending

        - [9b4572af675e] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [df30f6d22e24] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [c5e12348e6a4] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [3c3448003b2d] mptcp: add get_subflow wrappers (Geliang Tang)
        - [fda1ed72ba0d] mptcp: add bpf_mptcp_sched_ops (Geliang Tang)
        - [1a3c256136b2] selftests: bpf: add bpf_first scheduler
(Geliang Tang)
        - [e16e1898139d] selftests: bpf: add bpf_first test (Geliang Tang):
            - depending on the prev ones, might be too late for the
merge window



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - still running, doesn't find MPTCP issues (but still find other
issues)

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - still running, see similar issues found by the public CI

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - could it be possible to apply patches for 'net' (mptcp-net) on
top of 'export-net' branch?
        - (ideally on top of both export-net and export-next)

    - CI (Matth):
        - /



Next meeting:
    - Next one on Thursday, the 12th of May.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220512



Feel free to comment on these points and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
