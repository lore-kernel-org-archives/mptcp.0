Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CEC5CA1
	for <mptcp@lists.linux.dev>; Sat, 28 Jan 2023 14:16:15 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id m14so6911192wrg.13
        for <mptcp@lists.linux.dev>; Sat, 28 Jan 2023 06:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdwgBIrn5mvo8g9k16kaNpPdpw7pFC0vrcrLT0ijfHY=;
        b=LgirYIlOF3QDDYej+iyAFgZkz2u4jnaO7GMADMnIcFQPERtIVCiZZd6ymvXEO4O+n/
         tloFBHH8BEp6RXLCPXNl9Ip3gSOg6Xi69700VRQYlcHTr7AQQYUAYCX/Ann23tEnubm+
         WTJoR54b28tzdhy7x3vWlBJ6B3EtNMZw+3iUMODFmXgQl2h0IWcGGI3f/5qobMcgZhVP
         JJbJsi8m2hr9V0Mkoyl2UPrOAMX4KAkm4ZZTfanwylKD4BUCYY8lHzADU45YNAC4MXTG
         ROpcluj7rpRznm5Xvw9Y3kXcmKiQreLwuquwP2AItpXe+uFyM9yqbaBDirONFM689eK2
         5O/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SdwgBIrn5mvo8g9k16kaNpPdpw7pFC0vrcrLT0ijfHY=;
        b=vuFE9rqfc5TVZF7ivr/tIXj10y7uHVQi8N9xBFdesYBF1qI+25A5IjPZWBxLMEFIy5
         mUYkHIU3e0hRjS9xQ+Z1perL+Zbf8jqaN4EIaG+G8VA1Cmur3eYkjfLxXbk6d22OmMZq
         JZR1IvqcU8VVMJswigYbBdpAX3941zGKnR7/rr7YuMVZohedgksKh370WdEjHu27/FSe
         IjPduiCoUhVwAxNLFhvllMHWKKmIynxri2Bxz/QSbG7FigP0bOt5+QpodXY3SLJFCMwk
         muF6xBxlpGAYfUqUg1pzyB8nl21KxZ4cETda5c1ZAgQAQnxaVCx0jEu+WJQ5G227U7B6
         ETSA==
X-Gm-Message-State: AFqh2kpSbDxmDhECDYXROuetIzjAh9Cq6mLs+KpsVF2kAqmQKrLcpf/6
	nT0HAeG7djNh1F/dVq4Z+2HLptPU6nBUSZYDhxU=
X-Google-Smtp-Source: AMrXdXuzsdx5c2Rd3dr+oNswI+O1MHTpCN63m+wDf6vyNwvl06EEo12IgYhP4zBp+0vf4ioPUg0CHA==
X-Received: by 2002:a05:6000:a0a:b0:2be:5d57:ca19 with SMTP id co10-20020a0560000a0a00b002be5d57ca19mr28252650wrb.58.1674915373006;
        Sat, 28 Jan 2023 06:16:13 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:7882:c567:a355:7df6? ([2a02:578:8593:1200:7882:c567:a355:7df6])
        by smtp.gmail.com with ESMTPSA id l15-20020a5d6d8f000000b002bfb37497a8sm7294625wrs.31.2023.01.28.06.16.12
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 06:16:12 -0800 (PST)
Message-ID: <98626198-8ec2-c2b5-e5c1-babde5b00d4a@tessares.net>
Date: Sat, 28 Jan 2023 15:16:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 24th of January 2022
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Tuesday, we had our 226th meeting with Mat, Ossama (Intel),
Christoph (Apple), Paolo, Davide (Red Hat), Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

13110670: [net] MAINTAINERS: Update MPTCP maintainer list and CREDITS:
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230120231121.36121-1-mathew.j.martineau@linux.intel.com/


    our repo (by: Mat Martineau):

13108923: [mptcp-net] MAINTAINERS: Update MPTCP maintainer list and CREDITS:
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230119224411.24410-1-mathew.j.martineau@linux.intel.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Jiapeng Chong, Matthieu Baerts, Paolo
Abeni):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
12321111: mptcp: Remove redundant assignment to remaining:
      - State: RFC
      - Series: mptcp: Remove redundant assignment to remaining
      - Submitter: Jiapeng Chong
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=500495&state=*&archive=both
      - Status: same as last week

13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
      - State: Changes requested
      - Series: BPF redundant scheduler, part 3
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
      - waiting for the end of the discussions with the sched API, see below

13100280: [mptcp-next,v2] mptcp: update userspace pm subflows info:
      - State: Needs ack
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/d262f6beb6899f0a79acbeb1d3c8c855e95e098a.1673599496.git.geliang.tang@suse.com/
      - Patch looks good
      - but do we need more before closing the ticket that is linked to
it? → yes

13104255: [mptcp-next,v2,01/13] mptcp: fix locking for setsockopt
corner-case
13104256: [mptcp-next,v2,02/13] mptcp: fix locking for in-kernel
listener creation.
13104257: [mptcp-next,v2,03/13] mptcp: refactor passive socket
initialization.
13104259: [mptcp-next,v2,04/13] mptcp: drop unneeded argument
13104260: [mptcp-next,v2,05/13] mptcp: drop legacy code.
13104258: [mptcp-next,v2,06/13] mptcp: avoid unneeded
__mptcp_nmpc_socket() usage
13104262: [mptcp-next,v2,07/13] mptcp: move fastopen subflow check
inside mptcp_sendmsg_fastopen()
13104261: [mptcp-next,v2,08/13] mptcp: move first subflow allocation at
mpc access time
13104263: [mptcp-next,v2,09/13] mptcp: do not keep around the first
subflow after disconnect.
13104264: [mptcp-next,v2,10/13] mptcp: fastclose msk when cleaning
unaccepted sockets
13104265: [mptcp-next,v2,11/13] mptcp: refactor mptcp_stream_accept()
13104266: [mptcp-next,v2,12/13] security, lsm: Introduce
security_mptcp_add_subflow()
13104267: [mptcp-next,v2,13/13] selinux: Implement mptcp_add_subflow hook:
      - State: Needs ack
      - Series: mptcp: refactor first subflow init
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=712638&state=*&archive=both



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 337):

/


    Bugs (opened, flagged as "bug" and assigned)

  329  PM: userspace: update `MPTCP_INFO` fields [bug] @geliangtang:
      - patches related to it above ↑

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni:
      - patches related to it above ↑


    Bugs (opened and flagged as "bug" and not assigned)

  336  Issues with BPF packet scheduler [bug]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: test 98 `fastclose test` is sometimes
failing [bug] [selftests]
  323  selftests: `mptcp_join`: test 111 `delete and re-add` is often
failing [bug] [selftests]
  318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
cookies [bug] [selftests]
  315  Issues with backup flow [bug]
  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]


    In Progress (opened, new feature and assigned)

  330  `MPTCP_INFO`: document and support `mptcpi_subflows` for the
server side [enhancement] @geliangtang
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
       - see patches above

   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

  307  TCP performance better than MPTCP [question] @matttbe


    Open questions (opened, questions and not assigned)

  326  Issue with streaming traffic with MPTCP upstream implementation
[question]


    For later (opened and not assigned assigned)

  337  in-kernel PM: listen socket: support "behind a NAT" use case
[enhancement]
  335  Server to Client subflows: option to allow joining the initial
address and port [enhancement]
  334  PM: in-kernel: send >1 ADD_ADDR before the establishment of a new
subflow [enhancement]
  333  New MIBs to help understanding issues when PM cannot create new
subflows [enhancement]
  332  scheduler: implement a "opportunistic retransmission" [enhancement]
  298  CG Memory accounting for passive MPTCP socket [enhancement]
  289  mptcp: audit comments for non inclusive language [enhancement]
  273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdrill]
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
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2023-01-17)

  338  ip mptcp monitor reports: [SF_CLOSED]  error=111



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.3):
https://github.com/multipath-tcp/mptcp_net-next/projects/18
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net: /

    - Fixes for net-next:

        - [a9d16f833b27] net: ethtool: fix up for "ethtool: Add and use
ethnl_update_bool." (Stephen Rothwell):
            - needed because we merge net and net-next
            - will be handled by net maintainers I suppose → done

    - Features for net-next:

        - [e9089565232a] mptcp: let the in-kernel PM use mixed IPv4 and
IPv6 addresses (Paolo Abeni)
        - [30f8449e58ca] mptcp: propagate sk_ipv6only to subflows
(Matthieu Baerts)
        - [a4c3c6dbe00b] selftests: mptcp: add test-cases for mixed
v4/v6 subflows (Paolo Abeni)
        - [12866df52ed3] mptcp: userspace pm: use a single point of exit
(Matthieu Baerts)
        - [4d82c9eba504] selftests: mptcp: userspace: print titles
(Matthieu Baerts)
        - [cc152f2f4ffe] selftests: mptcp: userspace: refactor asserts
(Matthieu Baerts)
        - [33592fb40b19] selftests: mptcp: userspace: print error
details if any (Matthieu Baerts)
        - [76718e8c2de3] selftests: mptcp: userspace: avoid read errors
(Matthieu Baerts):
            - Ready to be sent on Matth' side
            - will do it after the meeting / tomorrow → done

    - Features for net-next (next): /

    - Features for other trees:

        - [c3ce15b3aa65] mptcp: refactor push_pending logic (Geliang Tang)
        - [8d6766f1b536] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [13e776a27808] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [cef4ecf53c19] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [b17860674f24] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [27f395cf9107] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [764c4c2b9fff] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [b1f47d25972a] mptcp: add scheduler wrappers (Geliang Tang)
        - [c0b89792050c] mptcp: use get_send wrapper (Geliang Tang)
        - [36fd46ea8c76] mptcp: use get_retrans wrapper (Geliang Tang)
        - [cb147482ae0e] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [8508b5799a84] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [bd4b5e7a4dc1] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [929242e6f7d8] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [e1e1943a5048] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [37b92ce4f2ee] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [3e396fbf0144] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [7fe91a815e5c] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [a54aeb889e32] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [4e8166ffeda4] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [835704aa80f6] selftests/bpf: Add bpf_red test (Geliang Tang):
            - status same as last week: waiting for the end of the dev
around the scheduler



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - one thing from last week with tcp orphan:
            - doesn't see to be MPTCP related
            - Mat will look if it came back

        - Mat will have to stop the machine:
            - the info in our wiki should be enough
            - Christoph will continue to run it on his side, thanks!

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - Selftests are no longer going to be executed by Intel's kbuild
        - But they are still doing build validation:
            - when the export and export-net branches are modified
            - when new patches are sent to the mailing list (applied on
top of the export branch)
            - managed by a public repo:
                - https://github.com/intel/lkp-tests.git
                - Relevant file: repo/linux/mptcp

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - the bot email is still subscribed to the ML but no longer
needed (public inbox is used instead)
        - we could unsubscribe the bot if needed

    - CI (Matth):
        - /



mptcpd:
    - the repo will be "transferred" to the multipath-tcp org
    -
https://docs.github.com/en/repositories/creating-and-managing-repositories/transferring-a-repository
    - should be smooth
    - Matth will check what needs to be done from our side just after
the meeting → Done
    - v0.12 released (not announced yet)



genetlink refactor:
    - the stuff with the YAML files
    - we should do the refactoring in MPTCP too to use the new
infrastructure
    - TODO: create a new ticket for that → Matth, done: #340



MPTCP Scheduler API:
    - See:
https://lore.kernel.org/mptcp/dd4363e7-d057-97e8-0b5f-8570f39aa538@tessares.net/T/#u

    - From the discussions we had at the meeting:
        - we need a new callback each time a ACK is received:
            - there we can take decisions about the penalisation and more
            - penalisation: we should not reduce the cwnd but instead
tell the core to send less / stop sooner somehow: to be defined:
                - have an additional state per subflow to send less
                - if needed, additional hooking might be added, to be
discussed
        - currently, in the upstream kernel:
            - reinjection is limited to MPTCP level RTO
            - should be extended



Next meeting:
    - Next one on Tuesday, the 31st of January.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230131



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
