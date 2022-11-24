Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F112F26
	for <mptcp@lists.linux.dev>; Thu, 24 Nov 2022 17:49:03 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id v1so3423012wrt.11
        for <mptcp@lists.linux.dev>; Thu, 24 Nov 2022 09:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wB/aUGZEhzuNro7+fP3LxfPtWKL/bWj7g+t0uV1lN1Y=;
        b=GlidopxsPtposdlh74vkszlS5ZANFciJgzMtmDAv7jOgokIeEP4gyL1nZps8//U5JF
         oae7WTdVCxfI6+YD+kfSgiU4OwJQMrXjmzbRUZtLOOM/iZoV1elnGwPQQGa5QemNSO8I
         6bhgxj2qQPt106tmLQIBxzRC3AV49DsqKb8XYEoVYoyWmEAB1DGkz2ruP0LxdBY6juN8
         NTXlMEcuRoaaCKLOhXmG3s7p68bLsBs4qySJgbOQMDiUzPCzahcFE9ZP63NJDxT9fI9c
         IslovtUqvD1OBxBVrXm8htQEtOqShnNl6F1B+O/k+KoYIIVWa8doBhSO53ZKF8FjKppt
         LsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wB/aUGZEhzuNro7+fP3LxfPtWKL/bWj7g+t0uV1lN1Y=;
        b=BKvbOlHg4hKYNaPdM7FfbUfPq9uyY013Yx2pJF1nVV7r7BRsDSbjTgK5hDy3em+HjO
         KMaHS01EcxcyVawRXp7XgcidW8A0uV324H+6Hy3a4+c/Mq4l/V9uM5QvOjUva6xvBm/3
         N5PFEQlddYw0l6K4o6QXWxPVaXbyxtI8sdZyb1ea13UyLkBXc4xkOgRGKk1FclzD/xgt
         0OLJLGMYE6wNzvCVNPw9+biM0AaTuG5j1MVnFGAvbi3zoXaERw4YEBYl2RCWSdBCuO5x
         6aLGRN7p67e3iH5C8YKxxqxmMU6hVUMg++SiWBmjOjhaa79dRhbp//fwJE4UlGaLtSgs
         uy2A==
X-Gm-Message-State: ANoB5pm2mWht/c0xIANZyfHLMZPfaxGhXZ6btye8EVMwaJPh7JD6gewR
	+NZCxflvPmd7WDpekYa8CYjGOdtCPss7FQ==
X-Google-Smtp-Source: AA0mqf7Eu5ga45oLeCD3AsZMa7xcovyGmeWEbeGauM0ex9r4D0/96a6ZZvYQeDM8WwS1cm0YWCZUfQ==
X-Received: by 2002:adf:d0ca:0:b0:236:8ead:4871 with SMTP id z10-20020adfd0ca000000b002368ead4871mr21092671wrh.498.1669312141182;
        Thu, 24 Nov 2022 09:49:01 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:e809:e459:4aec:7414? ([2a02:578:8593:1200:e809:e459:4aec:7414])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b003a2f2bb72d5sm8017981wmo.45.2022.11.24.09.49.00
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 09:49:00 -0800 (PST)
Message-ID: <0aa6c8e0-2915-69c6-d850-69b54c54dbed@tessares.net>
Date: Thu, 24 Nov 2022 18:49:00 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 24th of November 2022
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Happy Thanksgiving!

Today, we just had our 218th meeting with Paolo (Redhat), Benjamin and
myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Kuniyuki Iwashima, Mat Martineau):

13044249: [net,1/3] selftests: mptcp: gives slow test-case more time
13044250: [net,2/3] selftests: mptcp: run mptcp_sockopt from a new netns
13044251: [net,3/3] selftests: mptcp: fix mibit vs mbit mix up:
      - Series: mptcp: selftests: Fix timeouts and test isolation
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=695716&state=*&archive=both

13048608: [v2,net-next] net: Return errno in sk->sk_prot->get_port().:
      - Submitter: Kuniyuki Iwashima
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221118182506.6226-1-kuniyu@amazon.com/

13048615: [net-next,1/2] mptcp: deduplicate error paths on endpoint creation
13048616: [net-next,2/2] mptcp: more detailed error reporting on
endpoint creation:
      - Series: mptcp: More specific netlink command errors
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=697048&state=*&archive=both


    our repo (by: Geliang Tang, Menglong Dong, Paolo Abeni):

13039804: [mptcp-next,v19,2/9] mptcp: drop last_snd and
MPTCP_RESET_SCHEDULER
13039805: [mptcp-next,v19,3/9] mptcp: add sched_data_set_contexts helper
13039806: [mptcp-next,v19,4/9] Squash to "mptcp: add struct mptcp_sched_ops"
13039807: [mptcp-next,v19,5/9] Squash to "bpf: Add bpf_mptcp_sched_ops"
13039808: [mptcp-next,v19,6/9] Squash to "bpf: Add
bpf_mptcp_sched_kfunc_set"
13039809: [mptcp-next,v19,7/9] Squash to "selftests/bpf: Add bpf_first
scheduler"
13039810: [mptcp-next,v19,8/9] Squash to "selftests/bpf: Add bpf_bkup
scheduler"
13039811: [mptcp-next,v19,9/9] Squash to "selftests/bpf: Add bpf_rr
scheduler":
      - Series: BPF redundant scheduler, part 1
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=694383&state=*&archive=both

13040964: [mptcp-next] Squash to "mptcp: refactor push_pending logic" v19:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221112003133.27153-1-geliang.tang@suse.com/

13044027: [mptcp-next,1/2] mptcp: consolidate initial ack seq generation
13044028: [mptcp-next,2/2] Squash-to "mptcp: implement delayed seq
generation for passive fastopen":
      - Series: mptcp: more fastopen follow-up
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=695647&state=*&archive=both

13046149: [mptcp-next,v5,1/4] mptcp: add pm listener events
13046150: [mptcp-next,v5,2/4] selftests: mptcp: enhance userspace pm tests
13046151: [mptcp-next,v5,3/4] selftests: mptcp: listener test for
userspace PM
13046152: [mptcp-next,v5,4/4] selftests: mptcp: listener test for
in-kernel PM:
      - Series: add pm listener events
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=696257&state=*&archive=both
      - Paolo commented on that one: follow-up needed for Geliang

13048843: [mptcp-next] Squash to "mptcp: add sched_data_set_contexts
helper":
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221118221251.4330-1-geliang.tang@suse.com/

13050327: [mptcp-net,v2] mptcp: don't orphan ssk in mptcp_close():
      - Submitter: Menglong Dong
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221121034140.548112-1-imagedong@tencent.com/

13053506: [mptcp-net] mptcp: fix sleep in atomic at close time:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/feee93bcba06bf05a9308188f91007e7f6cbe5f4.1669201422.git.pabeni@redhat.com/
      - linked to issue #316



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Benjamin Hesmans, Geliang Tang, Jiapeng Chong,
Matthieu Baerts, Menglong Dong, Paolo Abeni, Wei Yongjun):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
12321111: mptcp: Remove redundant assignment to remaining:
      - Status is the same as last week

12970164: [RFC,mptcp-next,05/10] mptcp: delay mptcp data_ack calculation
12970163: [RFC,mptcp-next,06/10] mptcp: allow delayed data_ack calculation
12970165: [RFC,mptcp-next,07/10] mptcp: TFO receive: bypass mapping check
12970166: [RFC,mptcp-next,08/10] mptcp: allow data that can not be
DATA_ACKed
12970167: [RFC,mptcp-next,09/10] mptcp: force data_ready
12970168: [RFC,mptcp-next,10/10] mptcp: test TFO:
      - can be archived

13007315: [RFC] selftests: mptcp: set test-case parameters consistently:
      - State: RFC
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/2abed554f2050c7626dede74c92a181506a92682.1665779933.git.pabeni@redhat.com/
      - Can be archived

13045005: [mptcp-next,v20,1/7] mptcp: add scheduler wrappers
13045006: [mptcp-next,v20,2/7] mptcp: use get_send wrapper
13045007: [mptcp-next,v20,3/7] mptcp: use get_retrans wrapper
13045008: [mptcp-next,v20,4/7] mptcp: delay updating first_pending
13045009: [mptcp-next,v20,5/7] mptcp: delay updating already_sent
13045010: [mptcp-next,v20,6/7] selftests/bpf: Add bpf_red scheduler
13045011: [mptcp-next,v20,7/7] selftests/bpf: Add bpf_red test:
      - State: Changes requested
      - Series: BPF redundant scheduler, part 2
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=695953&state=*&archive=both
      - Mat commented on this series

13047668: [mptcp-next] Squash to "mptcp: delay updating first_pending" v20:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221118022150.30520-1-geliang.tang@suse.com/
      - linked to the previous series ↑

13047855: [mptcp-net] mptcp: netlink: fix some error return code:
      - State: New
      - Submitter: Wei Yongjun
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221118083541.123585-1-weiyongjun@huaweicloud.com/
      - To be reviewed

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
      - looks OK
      - Paolo would like to take some times looking at it: maybe we can
avoid a new STATUS bit:
          - this is adding quite a bit of complexity "just for the
stats", maybe a better way?
          - Matth will wait a bit before applying it




Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 315):

  317  TFO: IPv6: the generated cookie is not the expected one [bug]
@matttbe:
      - see new comments on the issue
      - remaining questions:
          - do we need the same slab for v4 and v6 or better with two
different ones
          - (I guess it is not linked with ↑ but we should still allow a
mix of subflows in v4 and v6 for the same MPTCP connection)
          - still not sure we are really fixing something important there:
              - maybe issues with cookies in v6?
              - maybe a memleak in v6?


    Bugs (opened, flagged as "bug" and assigned)

  317  TFO: IPv6: the generated cookie is not the expected one [bug]
@matttbe:
      - see above


    Bugs (opened and flagged as "bug" and not assigned)

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
       - See patches above

   74  BPF: path manager [enhancement] @geliangtang

   59  (MP)TFO support [enhancement] @dmytroshytyi:
       - Packetdrill tests being added


    Assigned Questions (opened, questions and assigned)

  307  TCP performance better than MPTCP [question] @matttbe:
      - waiting for feedback (somehow linked to #315)


    Open questions (opened, questions and not assigned)

/

    For later (opened and not assigned assigned)

  298  CG Memory accounting for passive MPTCP socket [enhancement]
  289  mptcp: audit comments for non inclusive language [enhancement]
  273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdrill]

  269  Allow having a mix of v4/v6 subflows for the same socket
[enhancement]:
      - we should not forget about this one: quite important for some UC

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

  316  TFO: stall CPU if SYN is reset  [bug] @pabeni
  313  Add netlink events for listening socket create/close
[enhancement] @geliangtang



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.2):
https://github.com/multipath-tcp/mptcp_net-next/projects/17
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [31de1f8653b0] mptcp: don't orphan ssk in mptcp_close()
(Menglong Dong)
        - [4d14796b503a] mptcp: fix sleep in atomic at close time (Paolo
Abeni):
            - can be sent: TODO Matth

    - Fixes for net-next:
        (IPv6 issue has been fixed with another patch than the one
previously in our tree ; the new patch has already been merged in net-next)

    - Features for net-next:

        - [328183ee7bcb] selftests: mptcp: run mptcp_inq from a clean
netns (Matthieu Baerts)
        - [792d810919d1] selftests: mptcp: removed defined but unused
vars (Matthieu Baerts)
        - [84ea3ad1f3c2] selftests: mptcp: uniform 'rndh' variable
(Matthieu Baerts)
        - [34a761de4869] selftests: mptcp: clearly declare global ns
vars (Matthieu Baerts)
        - [dfce1a51b673] selftests: mptcp: declare var as local
(Matthieu Baerts)
        - [82412ac63fd3] mptcp: add pm listener events (Geliang Tang)
        - [add6819bf7a9] selftests: mptcp: enhance userspace pm tests
(Geliang Tang)
        - [692f9c62ab71] selftests: mptcp: listener test for userspace
PM (Geliang Tang)
        - [c14602d46f4a] selftests: mptcp: listener test for in-kernel
PM (Geliang Tang):
            - can be sent after TFO

    - Features for net-next (next):

        - [fc5afafb90d6] mptcp: add MSG_FASTOPEN sendmsg flag support
(Dmytro Shytyi)
        - [8d9ea2f45f08] mptcp: track accurately the incoming MPC
suboption type (Paolo Abeni)
        - [d9e90f9ea21e] mptcp: consolidate initial ack seq generation
(Paolo Abeni)
        - [b69af54bbeee] mptcp: implement delayed seq generation for
passive fastopen (Dmytro Shytyi)
        - [04d12d53478c] mptcp: add subflow_v(4,6)_send_synack() (Dmytro
Shytyi)
        - [9fa1c743f3d6] mptcp: add TCP_FASTOPEN sock option (Dmytro Shytyi)
        - [fd9889427e16] selftests: mptcp: mptfo Initiator/Listener
(Dmytro Shytyi):
            - can be sent tomorrow: TODO Matt

    - Features for other trees:

        - [a53db1f67c56] mptcp: refactor push_pending logic (Geliang Tang)
        - [553ee45b1936] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [ab6336db0bba] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [26ef66228e4c] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [8f6c9d08794e] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [44d93cfa1a59] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [2d34bcf5dbc2] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [2b5bab1cb8ba] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [2e28cfa1ad54] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [2f4b025acced] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [09e80541ea28] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [1ff81f9f0c43] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [53c9b2ba3753] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [759a1aa275bf] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [f01167c88194] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [7f33ecbb1dae] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - there are still patches in preparation, this can wait (to
avoid an API change just in case)




Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - /

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - /

    - packetdrill (Davide):
        - new packetdrill tests for TFO in progress

    - Patchew (Davide):
        - /

    - CI (Matth):
        - greener \o/ (but still some issues):
            - some issues with MPTCP connect (syncookies in IPv6)
            - some issues with mptcp_join: errors are not reported → for
Geliang, see message from Paolo on the ML



Other topics:
    - fosdem 2023:
        - there is a kernel dev room
        - anybody to present there?
        - People from Tessares will be there



Next meeting:
    - Next one on Thursday, the 1st of December.
    - 16:00 UTC (8am PST, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20221201



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
