Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF2036A
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 10:37:56 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id qn17so3709757ejb.0
        for <mptcp@lists.linux.dev>; Thu, 06 Oct 2022 03:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=M+H8wHUo+MsDwX1TvuF74AZcnAK2/4PJNBSwrmUNwWM=;
        b=Y65ZQpI27juAj2Le/6t/fHsYxTPUE5Zlx/qfutn0gDL4+sDa+1z5JZBznaWMpDNF2q
         hrdr92LnlSUcsxV37c2Cm/S3wlxLWBUvp6WFkQhqN0rqQnEGWoH9F4aRBckl8Ix2XbKl
         h88+KsTT2f6TnVxunZUroH7phhM3+xeAy35DnpcIMD4mWzgDci51QMuLh+3ykOUtRmpy
         Q42TPcGa8iPZMCon+rrIY9lx6I/T4OjiL25VjM7Bk/Clgw011gF/jTUo0W9oVBiIIZ47
         h3ooj474g9rkjIyUGILW7MchPnIKRAHeN9wDZg7UErcFMS7WhdcrHC8ahUKSZWIV5NZp
         OWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=M+H8wHUo+MsDwX1TvuF74AZcnAK2/4PJNBSwrmUNwWM=;
        b=OSUqemo0El8zpd+NZVxQNKTj2F4tmRM4+6GdqaeYk9url/VfJuk3lyH/PcgacQl4Uk
         WtT8JBOCN77aQS2QYY0oSfd6es2dqXuTc2NcfqAP/mz6vHNY2bXoBsNDc6JApQxtMvrC
         oQY7fzspQxJXwVb+wSlXj2rfBQquvkYlEw5AMjXgoMaFnhSYNXMDJjykbaQlyMEhXnTx
         VpBLTy60DqCnTHML29U60ynrzjHNR0k1BcVSdBDdmh1JOx02uMp+NSn7jOYPTK+NXsgm
         vN7nMa+3uc2GjFYUkIWt9PCP0z+lFNG1K42mn1B3kG5qMv17nTpoKYF9c03NMnrO9C6q
         t+Iw==
X-Gm-Message-State: ACrzQf0INkzwQcaimQlrElDKA5llcqDDpoAlQNINbrA/xl9GVnOWYYFt
	CNB3TP73MVU3ou6OwlADwvvX6afivCiTCg==
X-Google-Smtp-Source: AMsMyM4dDpmkf6wbFhpY3SDlATlkIAMdLuSBVJrnEbqtygXTxJUFMJ7sJs0CPxxG1OD5awgTNAy+ZQ==
X-Received: by 2002:a17:907:7805:b0:780:24fd:c4e8 with SMTP id la5-20020a170907780500b0078024fdc4e8mr3508302ejc.78.1665052674479;
        Thu, 06 Oct 2022 03:37:54 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:24b3:84f5:d75:6cfa? ([2a02:578:8593:1200:24b3:84f5:d75:6cfa])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709061f1700b00772061034dbsm10048960ejj.182.2022.10.06.03.37.53
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 03:37:53 -0700 (PDT)
Message-ID: <40bb574e-077d-9502-f47c-1b810a24f844@tessares.net>
Date: Thu, 6 Oct 2022 12:37:53 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 29th of September 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last week, we had our 211st meeting with Mat, Ossama (Intel), Dmytro
(SFR), Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12989597: [net-next,1/4] mptcp: add TCP_FASTOPEN_CONNECT socket option
12989598: [net-next,2/4] tcp: export tcp_sendmsg_fastopen
12989599: [net-next,3/4] mptcp: handle defer connect in mptcp_sendmsg
12989600: [net-next,4/4] mptcp: poll allow write call before actual connect:
      - Series: mptcp: MPTCP support for TCP_FASTOPEN_CONNECT
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=680769&state=*&archive=both

12991154: [net,1/2] mptcp: factor out __mptcp_close() without socket lock
12991155: [net,2/2] mptcp: fix unreleased socket in accept queue:
      - Series: mptcp: Properly clean up unaccepted subflows
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=681183&state=*&archive=both


    our repo (by: Benjamin Hesmans, Matthieu Baerts, Paolo Abeni):

12986520: [mptcp-next,v3,1/4] mptcp: add TCP_FASTOPEN_CONNECT socket option
12986521: [mptcp-next,v3,2/4] tcp: export tcp_sendmsg_fastopen
12986523: [mptcp-next,v3,3/4] mptcp: handle defer connect in mptcp_sendmsg
12986522: [mptcp-next,v3,4/4] mptcp: poll allow write call before actual
connect:
      - Series: mptcp: add support for TCP_FASTOPEN_CONNECT, sender side
only
      - Submitter: Benjamin Hesmans
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=679861&state=*&archive=both

12988700: [mptcp-next] Squash-to: "mptcp: use fastclose on more edge
scenarios":
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/0a7720e1aebc9ae8babf8b4881b7ad2acf672352.1664198754.git.pabeni@redhat.com/

12988992: [mptcp-next] mptcp: update misleading comments.:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/870262a8c7ca7eb682da90684f2ff193a818924b.1664205929.git.pabeni@redhat.com/

12990784: [mptcp-next,1/2] mptcp: sockopt: make 'tcp_fastopen_connect'
generic
12990785: [mptcp-next,2/2] mptcp: add TCP_FASTOPEN_NO_COOKIE support:
      - Series: mptcp: add TCP_FASTOPEN_NO_COOKIE support
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=681081&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Benjamin Hesmans, Dmytro Shytyi, Geliang Tang, Jason
Wang, Jiapeng Chong, Matthieu Baerts, Menglong Dong):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
12321111: mptcp: Remove redundant assignment to remaining
12922458: mptcp: Fix comment typo:
    - old patches: status is the same as last week

12970164: [RFC,mptcp-next,05/10] mptcp: delay mptcp data_ack calculation
12970163: [RFC,mptcp-next,06/10] mptcp: allow delayed data_ack calculation
12970165: [RFC,mptcp-next,07/10] mptcp: TFO receive: bypass mapping check
12970166: [RFC,mptcp-next,08/10] mptcp: allow data that can not be
DATA_ACKed
12970167: [RFC,mptcp-next,09/10] mptcp: force data_ready
12970168: [RFC,mptcp-next,10/10] mptcp: test TFO
    - old patches: status is the same as last week

12983634: [mptcp-next,v2,1/2] mptcp: introduce 'sk' to replace
'sock->sk' in mptcp_listen()
12983635: [mptcp-next,v2,2/2] mptcp: add statistics for mptcp socket in use:
      - State: Changes requested
      - Series: mptcp: add statistics for mptcp socket in use
      - Submitter: Menglong Dong
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=679017&state=*&archive=both
      - Status is the same as last week
      - TODO: Matth: check if they are not waiting for something from us
→ no, v3 has been sent (and v4 as well)

12991456: [RFC,mptcp-next,v12,1/7] mptcp: introduce MSG_FASTOPEN flag.
12991455: [RFC,mptcp-next,v12,2/7] mptcp: fix retrans., add mptfo vars
to msk
12991461: [RFC,mptcp-next,v12,3/7] mptcp: add subflow_v(4,6)_send_synack()
12991459: [RFC,mptcp-next,v12,6/7] mptcp: add TCP_FASTOPEN option
12991458: [RFC,mptcp-next,v12,7/7] selftests: mptfo initiator/listener:
      - State: Changes requested
      - Series: mptcp: Fast Open Mechanism
      - Submitter: Dmytro Shytyi
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=681241&state=*&archive=both
      - Progressing
      - Dmytro had some questions, he will send a v13 later
      - idea is still to focus on the sending part first (MSG_FASTOPEN)
using Paolo's suggestion (mptcp_connect() is probably needed)
      - testing should be done with packetdrill first for that kind of
feature (there are already some tests for MSG_FASTOPEN there)
      - then modifying mptcp_connect.{sh,c}

12991930: [mptcp-next] mptcp: sockopt: use new helper for TCP_DEFER_ACCEPT:
      - State: Queued
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220928091852.1933333-1-matthieu.baerts@tessares.net/
      - can be applied

12992024: [mptcp-next,1/4] mptcp: update __mptcp_push_pending
12992025: [mptcp-next,2/4] mptcp: add do_push_pending helper
12992026: [mptcp-next,3/4] mptcp: update __mptcp_subflow_push_pending
12992027: [mptcp-next,4/4] mptcp: simplify __mptcp_subflow_push_pending:
      - State: Changes requested
      - Series: refactor push pending
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=681407&state=*&archive=both
      - This is extracted from the BPF series, only focussing on this
difficult aspect
      - Geliang sent a v2 just before the meeting
      - Mat will look at the v2 after
      - Paolo also commented on the v1



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 302):

None.


    Bugs (opened, flagged as "bug" and assigned)

None.


    Bugs (opened and flagged as "bug" and not assigned)

  299  several kernel warnings about mptcp [bug]
  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]
  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]


    In Progress (opened, new feature and assigned)

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  294  Clear way for userspace to know if the connection fell back to
TCP [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
       - See patches above

   74  BPF: path manager [enhancement] @geliangtang

   59  (MP)TFO support [enhancement] @dmytroshytyi:
       - See patches above


    Assigned Questions (opened, questions and assigned)

None.


    Open questions (opened, questions and not assigned)

  300  Scheduler, pathmanager, congestion control [question]:
      - Can probably be closed → Done


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

  303  Avoid FastClose after `DATA_FIN` exchange [bug] @pabeni
  295  mptcpize, rsyncd & connection tear down (hangs)? [enhancement]
@pabeni



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.1):
https://github.com/multipath-tcp/mptcp_net-next/projects/16
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net: /

    - Fixes for net-next: /


    - Features for net-next:

        - [20af637811c9] mptcp: propagate fastclose error (Paolo Abeni)
        - [61fc1bc2edeb] mptcp: use fastclose on more edge scenarios
(Paolo Abeni)
        - [d1c02fee7732] selftests: mptcp: update and extend fastclose
test-cases (Paolo Abeni):
            - Paolo suggested not to send them at the beginning of the week
            - Maybe still OK now?
            - They are between a fix and a new feature so maybe good to
send them? → Done

        - [ee1e43f10dc5] mptcp: update misleading comments. (Paolo Abeni)
        - [a05c21ad4572] mptcp: sockopt: make 'tcp_fastopen_connect'
generic (Matthieu Baerts)
        - [de98c67ae3a9] mptcp: add TCP_FASTOPEN_NO_COOKIE support
(Matthieu Baerts):
            - these three patches are not complex, they could be sent
but priority is on the previous ones

    - Features for net-next (next): /

    - Features for other trees:

        - [cfd1606c81bb] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [a25f83c9fc64] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [20ceb3b4ab66] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [5ae800a391a5] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [34f834ab290b] mptcp: add get_subflow wrappers (Geliang Tang)
        - [45cff74bea7b] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [a8a97f83bb33] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [8997ceb90a40] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [2bc3e8772fa1] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [d13f2aac9dc4] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [38fe149fd5b0] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [2ba7fcbacd20] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [3a94946d3c6a] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [feb7b9aac06e] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - we can wait, same as last week



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - anything MPTCP related

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - seems stable

    - packetdrill (Davide):
        - there are a few Pull Request:
            - TFO CONNECT (get part) → Done
            - TFO NO_COOKIE → Done
            - Fix from issues reported by CI (time-wait) → Done
            - sync with upstream: --tolerance_percent option → TODO

    - Patchew (Davide):
        - When a Reviewed-by tag (or similar) is sent: the tag is
updated and CI jobs are restarted
        - @Davide: Can we ignore them?
        - Github: maybe we can deny re-tag from CI? TODO: Matth
            → yes we can but we need to promote the CI to "Maintain" role
            → and I don't know how patchew will behave if an error is
returned

    - CI (Matth):
        - Tessares CI:
            - issues with packetdrill: see PR → done
            - issues with mptcp_join.sh: quite rare
            - issues with simult_flows.sh: more frequent, only in a non
debug mode without the additional threshold



MPTCP_STATUS:
    - https://github.com/multipath-tcp/mptcp_net-next/issues/294
    - Clear way for userspace to know if the connection fell back to TCP
    - Not clear from the userspace to know if a fallback to TCP happened:
        - current:
            - MPTCP_INFO / MPTCP_TCPINFO / MPTCP_SUBFLOW_ADDRS return
EOPNOTSUPP after fallback
            - workaround: check for error: EOPNOTSUPP → not ideal I
suppose → agreed
        - solutions:
            - MPTCP_INFO:
                - returns 0 and set only "mptcpi_flags =
MPTCP_INFO_FLAG_FALLBACK" → 48 bytes
                - workaround: only allocate size of 12 bytes: enough to
read the flags
            - new socktopt (MPTCP_STATUS?)
                - returns: 0 (TCP) / 1 (MPTCP)
            - other ideas? Without sockopt?
        - decision:
            → seems OK to use MPTCP_INFO to send ~12/48 bytes to get
this info and not have a dedicated one



Netdev 0x16:
    - Lisbon Portugal on October 24th - 28th
    - https://www.netdevconf.org/0x16/
    - anybody planning to go there?
        → Seems not
        → for another time!



Next meeting:
    - Next one on Thursday, the 6th of October.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20221006



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
