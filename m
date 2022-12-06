Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBA627722
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 17:48:51 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id x22so7989862ejs.11
        for <mptcp@lists.linux.dev>; Tue, 06 Dec 2022 09:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFONgVBHkorEjshyYq46TbfR545CYTUfkubrdS+NmJo=;
        b=PUaQM0E9pqsI7wlHnlhxADi/VsHNhySNuIwT1WE35Mdd4Cxc5dUCyGlWVON3tWWEut
         DNDjwKghPoLnWdJGJ30fDJAqYB/HhajMT2UQZ/QJ+7IzTsV1Sn6xKby1v7z2oms+HAhV
         63X2z5QCBEV5fNutJSQ+1sevW1HwDgQe5pVWhzxfqavBBTWILwyuDYq56qMdc5FjJ/yM
         I7v44rLuKqrZZdK1ZyLcSA5TtdgHiSf4eqUyIFDHIo47s1KP0GPdLh4KFUnPp+WV8qFq
         o7n4o+ygOMYmDn1t6+nyTuidJWtub1Dt+5hKsg/RNcI8CUH5f4naRQqCoVxcFmb+UEx5
         HI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hFONgVBHkorEjshyYq46TbfR545CYTUfkubrdS+NmJo=;
        b=OkHshhutTktcYQvpSSJ71roTga8xj03xQnvTsGqGMwU5fk4FxDivBMWiK8MSNVLpb9
         xm46WpdUw3tiYcErtnv/NnZEmr0M4G0ceX+gl3mZRIG8fwdHbusX/WtfsA5S1aM9Iegq
         zPWe/fqnSYXgCGJF1ZfqoMzgK8egFYt/1386IrWRtPGbzfLoJc6HPqtmn+vNvHDRCOdt
         UfyX8DW8iSMrwj+6F5hFJsSXKct+/w1KGTeYRHBEGWDgYe9evGLDXszM7b/FQTn8HkBI
         e0Imv6wQQqDoWVJieUP09jKAwVjR8ibjQHHXQbq8P66wYJCOiY5sIVb8x6ojzmPHFAcj
         nCnw==
X-Gm-Message-State: ANoB5plSTHinUahe0ccGEHDHEvRMKDmlA9QqHhKKVIlHuf8favDNqqzb
	9qIts25xwccfwVLSIrbI7+fIlwqjQgGDoatY
X-Google-Smtp-Source: AA0mqf4bL/1delRtXIXpa+mcEY1HJgFWdq9Si3cxPEtNJeaP0/l8QKWXXcEgZXqiXNMJlMFGz/BbAA==
X-Received: by 2002:a17:906:4905:b0:7be:fb2c:c112 with SMTP id b5-20020a170906490500b007befb2cc112mr164181ejq.66.1670348929385;
        Tue, 06 Dec 2022 09:48:49 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id iy17-20020a170907819100b007c03fa39c33sm7544694ejc.71.2022.12.06.09.48.48
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 09:48:49 -0800 (PST)
Message-ID: <d8779974-e03d-3b43-b18e-8c99c8e83b7c@tessares.net>
Date: Tue, 6 Dec 2022 18:48:48 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 1st of December 2022
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last week, we had our 219th meeting with Mat, Ossama (Intel), Paolo
(Redhat), Dmytro () Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13056287: [net-next,1/8] mptcp: add MSG_FASTOPEN sendmsg flag support
13056288: [net-next,2/8] mptcp: track accurately the incoming MPC
suboption type
13056289: [net-next,3/8] mptcp: consolidate initial ack seq generation
13056290: [net-next,4/8] mptcp: implement delayed seq generation for
passive fastopen
13056291: [net-next,5/8] mptcp: add subflow_v(4,6)_send_synack()
13056292: [net-next,6/8] mptcp: add TCP_FASTOPEN sock option
13056293: [net-next,7/8] mptcp: add support for TCP_FASTOPEN_KEY sockopt
13056294: [net-next,8/8] selftests: mptcp: mptfo Initiator/Listener:
      - Series: mptcp: MSG_FASTOPEN and TFO listener side support
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=699323&state=*&archive=both

13057730: [net,1/2] mptcp: don't orphan ssk in mptcp_close()
13057731: [net,2/2] mptcp: fix sleep in atomic at close time:
      - Series: mptcp: More fixes for 6.1
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=699766&state=*&archive=both


    our repo (by: Geliang Tang, Matthieu Baerts, Wei Yongjun):

13047855: [mptcp-net] mptcp: netlink: fix some error return code:
      - Submitter: Wei Yongjun
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221118083541.123585-1-weiyongjun@huaweicloud.com/

13056034: [mptcp-next] mptcp: add support for TCP_FASTOPEN_KEY sockopt:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221125145257.123844-1-matthieu.baerts@tessares.net/

13056266: [mptcp-next] Squash to "mptcp: add subflow_v(4,6)_send_synack()":
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221125212028.702058-1-matthieu.baerts@tessares.net/

13056493: [mptcp-next,v3,1/4] selftests: mptcp: make evts global in
userspace_pm
13056494: [mptcp-next,v3,2/4] Squash to "selftests: mptcp: listener test
for userspace PM"
13056495: [mptcp-next,v3,3/4] selftests: mptcp: make evts global in
mptcp_join
13056496: [mptcp-next,v3,4/4] Squash to "selftests: mptcp: listener test
for in-kernel PM":
      - Series: cleanups for pm listener event tests
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=699400&state=*&archive=both

13057164: [mptcp-next] Squash to "selftests: mptcp: make evts global in
userspace_pm, v3":
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221128090048.15799-1-geliang.tang@suse.com/

13058633: [mptcp-next] Squash-to "bpf: Add bpf_mptcp_sched_ops":
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221129142010.2886747-1-matthieu.baerts@tessares.net/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13059923: [net-next,01/11] selftests: mptcp: run mptcp_inq from a clean
netns
13059924: [net-next,02/11] selftests: mptcp: removed defined but unused vars
13059926: [net-next,03/11] selftests: mptcp: uniform 'rndh' variable
13059925: [net-next,04/11] selftests: mptcp: clearly declare global ns vars
13059927: [net-next,05/11] selftests: mptcp: declare var as local
13059928: [net-next,06/11] mptcp: add pm listener events
13059929: [net-next,07/11] selftests: mptcp: enhance userspace pm tests
13059930: [net-next,08/11] selftests: mptcp: make evts global in
userspace_pm
13059931: [net-next,09/11] selftests: mptcp: listener test for userspace PM
13059932: [net-next,10/11] selftests: mptcp: make evts global in mptcp_join
13059933: [net-next,11/11] selftests: mptcp: listener test for in-kernel PM:
    - They have been accepted after the meeting

    our repo (by: Geliang Tang, Jiapeng Chong, Matthieu Baerts, Menglong
Dong):

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
      - Status is the same as last week

13051931: [mptcp-next,v7,1/4] mptcp: introduce 'sk' to replace
'sock->sk' in mptcp_listen()
13051932: [mptcp-next,v7,2/4] mptcp: add statistics for mptcp socket in use
13051933: [mptcp-next,v7,3/4] selftest: mptcp: exit from
copyfd_io_poll() when receive SIGUSR1
13051934: [mptcp-next,v7,4/4] selftest: mptcp: add test for mptcp socket
in use:
      - State: Under review
      - Series: mptcp: add statistics for mptcp socket in use
      - Submitter: Menglong Dong
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=697917&state=*&archive=both
      - can wait a bit longer, Paolo will review it

13057002: [mptcp-next,v21,1/7] mptcp: add scheduler wrappers
13057003: [mptcp-next,v21,2/7] mptcp: use get_send wrapper
13057004: [mptcp-next,v21,3/7] mptcp: use get_retrans wrapper
13057005: [mptcp-next,v21,4/7] mptcp: retrans for redundant sends
13057006: [mptcp-next,v21,5/7] mptcp: add mptcp_update_dfrags
13057007: [mptcp-next,v21,6/7] selftests/bpf: Add bpf_red scheduler
13057008: [mptcp-next,v21,7/7] selftests/bpf: Add bpf_red test:
      - State: Changes requested
      - Series: BPF redundant scheduler
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=699551&state=*&archive=both
      - still some tricky part to figure out with the subflow (defer
delegated send to the other subflows)
      - but progressing :+1:

13059640: [mptcp-net,v2,1/3] mptcp: remove MPTCP 'ifdef' in TCP SYN cookies
13059641: [mptcp-net,v2,2/3] mptcp: dedicated request sock for subflow in v6
13059642: [mptcp-net,v2,3/3] mptcp: use proper req destructor for IPv6:
      - State: New
      - Series: mptcp: fix request sock for subflow in v6
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=700384&state=*&archive=both



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 317):

  319  kmemleak: 6 new suspected memory leaks in -net [bug]:
      - Probably not due to MPTCP, the code didn't change around there
for a while
      - (but did it change recently on -net in the other functions?)
      - we can wait and see

  318  selftests: `mptcp_connect.sh` sometimes fails when validating
IPv6 and SYN cookies [bug] [selftests]:
      - probably not a recent regression
      - maybe fixed by "mptcp: fix request sock for subflow in v6"
series → no


    Bugs (opened, flagged as "bug" and assigned)

  317  TFO: IPv6: the generated cookie is not the expected one [bug]
@matttbe:
      - will be fixed with: "mptcp: fix request sock for subflow in v6"
series → done


    Bugs (opened and flagged as "bug" and not assigned)

  319  kmemleak: 6 new suspected memory leaks in -net [bug]:
      - see ↑

  318  selftests: `mptcp_connect.sh` sometimes fails when validating
IPv6 and SYN cookies [bug] [selftests]:
      - see ↑

  315  Issues with backup flow [bug]:
      - waiting for feedback

  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]


    In Progress (opened, new feature and assigned)

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
       - see patches above

   74  BPF: path manager [enhancement] @geliangtang

   59  (MP)TFO support [enhancement] @dmytroshytyi:
       - see packetdrill below


    Assigned Questions (opened, questions and assigned)

  307  TCP performance better than MPTCP [question] @matttbe


    Open questions (opened, questions and not assigned)

/

    For later (opened and not assigned assigned)

  298  CG Memory accounting for passive MPTCP socket [enhancement]
  289  mptcp: audit comments for non inclusive language [enhancement]
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
    - Current/Coming merge window (6.2):
https://github.com/multipath-tcp/mptcp_net-next/projects/17
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [66da639a6282] mptcp: netlink: fix some error return code (Wei
Yongjun):
            - can be sent or wait for more? (3 patches are pending):
                - yes, can wait

    - Fixes for net-next: /

    - Features for net-next:

        - [62c67095a15b] selftests: mptcp: run mptcp_inq from a clean
netns (Matthieu Baerts)
        - [fcbf5c8187f3] selftests: mptcp: removed defined but unused
vars (Matthieu Baerts)
        - [257ab57dc4de] selftests: mptcp: uniform 'rndh' variable
(Matthieu Baerts)
        - [aa9e52873afb] selftests: mptcp: clearly declare global ns
vars (Matthieu Baerts)
        - [bbbf0422a1e8] selftests: mptcp: declare var as local
(Matthieu Baerts)
        - [dd5997317bdc] mptcp: add pm listener events (Geliang Tang)
        - [41a49d239166] selftests: mptcp: enhance userspace pm tests
(Geliang Tang)
        - [20c89d1028d1] selftests: mptcp: make evts global in
userspace_pm (Geliang Tang)
        - [2a44e706e821] selftests: mptcp: listener test for userspace
PM (Geliang Tang)
        - [893647770867] selftests: mptcp: make evts global in
mptcp_join (Geliang Tang)
        - [fa3f80722495] selftests: mptcp: listener test for in-kernel
PM (Geliang Tang):
            - have been sent yesterday but not applied yet → done

    - Features for net-next (next): /

    - Features for other trees:

        - [e6b7ce88fb05] mptcp: refactor push_pending logic (Geliang Tang)
        - [3de81ba5fcdc] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [d0220e02059e] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [fb6f5754b7de] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [9018401066b4] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [d935abc16a47] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [fdd328f09d76] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [c4ae2720569b] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [baa31ce93f37] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [12eae2c25147] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [3d4794b8693f] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [4bae83919ff6] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [3441e8430643] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [9c4f74c03be5] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [a64c9e71ccf9] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [0fc3eb2f45ea] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - same as last week: can wait



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - some has been found by syzkaller and seems related to MPTCP
(from the close side)
        - it was validating MPTCP from Monday, including the fix from
Paolo around there
        - Mat will open a new issue → done

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - now re-building MPTCP
        - there is one intermittent failure, Mat will check:
            - Intermittent failure is the new CREATE_LISTENER test in
userspace_pm.sh
            - might be a timing issue

    - packetdrill (Davide):
        - 4 PR are pending in review:
            - https://github.com/multipath-tcp/packetdrill/pulls
            - one depends on kernel patches that have not been applied
yet → done
        - Dmytro will look to add a new TFO test where there is no TS in
SYN with TFO + cookie request

    - Patchew (Davide):
        - /

    - CI (Matth):
        - mptcp_join is taking ~half of the time: can run in //
        - Now each build runs 4 jobs:
            - with and without mptcp_join selftest (suggested by Paolo)
            - with and without debug kconfig
        - Hopefully, this should accelerate builds (a bit less than half
the time).
            clone:        4m
            preparation:  5m (ccache was up to date)
            ============= 9m (init)
            kunit:        2s
            diag:         50s
            connect:      11m
            join:         43m
            sockopt:      72s
            pm_netlink:   3m
            simult_flow:  95s
            userspace_pm: 101s
            connect mmap: 10m
            ============= 1h16 (selftests)
            add_addr:     1m
            dss:          44s
            fastclose:    31s
            fastopen:     55s
            mp_capable:   73s
            mp_join:      31s
            mp_prio:      15s
            mp_reset:     24s
            regressions:  23s
            sockopts:     25s
            syscalls:     64s
            ============= 7m25 (packetdrill)



- SELinux/LSM:
    - Broken SELinux/LSM labelling with MPTCP and accept(2)
    -
https://lore.kernel.org/mptcp/CAFqZXNs2LF-OoQBUiiSEyranJUXkPLcCfBkMkwFeM6qEwMKCTw@mail.gmail.com/T/
    - All the MPTCP subflows are created with security context related
to the kernel and not to the user having created the MPTCP sockets
    - Of course that's not good because some policies blocks socket
created with the kernel security context
    - the context should be replaced by the one of the MPTCP socket
    - unfortunately, we cannot do that with the current net core base
    - it would be certainly better to create an extension to do that
without having to adapt SELinux
    - TODO: Matth: create new issue on GitHub → done



Other topics:
    - TFO will be in 6.2 \o/



Next meeting:
    - Next one on Thursday, the 8th of December.
    - 16:00 UTC (8am PST, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20221208



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
