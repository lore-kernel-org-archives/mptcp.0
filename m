Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E12F1FCD
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 17:07:39 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id e30so3823802eda.0
        for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=iXUm6UhsOfHi69QvG4si1VdgrxFymHvRt7N8C1Y87Q0=;
        b=T7C8qcXISFxemcRauixVUJ6R2DrckAqMLEUR20pGfB/oc66bX2vMlo5F1ptiOZ6kQ3
         XPPxA0FhtACEQPRCOG/PwA2xVsf6qMYS+Hlb4Zqs95cRQeVYwn2r5oYByLscFbzFotK9
         hYPT1ucNpxxzCeW6YJ3VABMMctw1ASJoePCZEuCVVGQRb30ktbyVrPj7r/W0MA46P8FK
         GgIMKQYCU/PHRYGXK5IF0OXv3tLYpb0QJyxDO/UAoqVFjWKfxnN6uvhbvS7XhH+X4xU6
         8sQMY1K+AvLUFSd2rsINRdrcq/WD4xO3SrI/tkT6yuViJAMQNlFVR6mBYdRurlbxeaW5
         W2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=iXUm6UhsOfHi69QvG4si1VdgrxFymHvRt7N8C1Y87Q0=;
        b=jdFkBEWxJqQ9I76ERib11AC3U4MiGYm1T96dX7kwgNCOGD5y9bi7R3WEBfGxs78I+2
         eMk2tfXskKJQp88Sm0+pfTyVhxe1VBhVU3BPfDsj4A7NuC2bYVgwXkNrhoOFEaTUyhvw
         wrPDzPNHPHXeUhu9zEORSIXn+TIc4a49g34qm9j21yekxR9vgRFMm4S9KAXZTrIVlYvr
         qq7jH8IGwVayKSYN40k9PnqXyUPY3n0RIJrwcfFF9J6rUZ4DNNec+zgRD4QIEDfHMEij
         9r0lUMBXRkm+j3hNorEnGLYlthUBgJoHWTWV7oMoYGYRwcWzZiCtGV87zvjVKOJVtXC9
         LqOQ==
X-Gm-Message-State: AOAM530VRO+FintcyZNEh2yVzRsKQYeaseVuWXijR+eQNh52qDLG3nF7
	/8+W8P2rzmfPo1YnE/dtCwx5OOyw4i9qWYP1
X-Google-Smtp-Source: ABdhPJxmumQQ8ZHhj6eSlKlynea0JDTw9IOd2r1ulAlPX4IJPQf48a+nBebyPbwRHM3jHdYodfmC5Q==
X-Received: by 2002:a05:6402:40c1:b0:423:f451:bb48 with SMTP id z1-20020a05640240c100b00423f451bb48mr551312edb.95.1650560856937;
        Thu, 21 Apr 2022 10:07:36 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:14b8:fcec:c1c2:2a35? ([2a02:578:8593:1200:14b8:fcec:c1c2:2a35])
        by smtp.gmail.com with ESMTPSA id k26-20020a17090666da00b006ef79b595e9sm5947879ejp.80.2022.04.21.10.07.35
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 10:07:36 -0700 (PDT)
Message-ID: <49bc6f26-660e-62bc-4cf8-fc4e686934e8@tessares.net>
Date: Thu, 21 Apr 2022 19:07:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 21st of April 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 192nd meeting with Mat, Ossama, Kishen (Intel)
Paolo (Red Hat), Geliang (SUSE) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Kishen Maloor, Matthieu Baerts):

12819762  [mptcp-next,v2,3/3] Squash-to: mptcp: netlink: allow
userspace-driven...
12819759  [mptcp-next,v2,2/3] Squash-to: mptcp: netlink: Add
MPTCP_PM_CMD_REMOVE
12819761  [mptcp-next,v2,1/3] Squash-to: mptcp: netlink: Add
MPTCP_PM_CMD_ANNOU...

12815186  [mptcp-next] Squash to "mptcp: netlink: allow userspace-driven
subflo...
12814778  [mptcp-next] Squash to "mptcp: handle local addrs announced by
usersp...

12814037  [mptcp-next,v10,14/14] selftests: mptcp: functional tests for
the use...
12814032  [mptcp-next,v10,13/14] selftests: mptcp: create listeners to
receive ...
12814033  [mptcp-next,v10,12/14] selftests: mptcp: capture netlink events
12814029  [mptcp-next,v10,11/14] selftests: mptcp: support
MPTCP_PM_CMD_SUBFLOW...
12814027  [mptcp-next,v10,10/14] selftests: mptcp: support
MPTCP_PM_CMD_SUBFLOW...
12814038  [mptcp-next,v10,09/14] mptcp: netlink: allow userspace-driven
subflow...
12814025  [mptcp-next,v10,08/14] selftests: mptcp: support
MPTCP_PM_CMD_REMOVE
12814035  [mptcp-next,v10,07/14] mptcp: netlink: Add MPTCP_PM_CMD_REMOVE
12814036  [mptcp-next,v10,06/14] selftests: mptcp: support
MPTCP_PM_CMD_ANNOUNCE
12814034  [mptcp-next,v10,05/14] mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE
12814031  [mptcp-next,v10,04/14] mptcp: netlink: split
mptcp_pm_parse_addr into...
12814028  [mptcp-next,v10,03/14] mptcp: read attributes of addr entries
managed...
12814030  [mptcp-next,v10,02/14] mptcp: handle local addrs announced by
userspa...
12814024  [mptcp-next,v10,01/14] mptcp: allow ADD_ADDR reissuance by
userspace ...



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Mat Martineau, Paolo Abeni):

12820879  [bpf-next,7/7] selftests: bpf: verify first of struct mptcp_sock
12820878  [bpf-next,6/7] selftests: bpf: verify ca_name of struct mptcp_sock
12820877  [bpf-next,5/7] selftests: bpf: verify token of struct mptcp_sock
12820875  [bpf-next,4/7] selftests: bpf: test bpf_skc_to_mptcp_sock
12820876  [bpf-next,3/7] selftests: bpf: add MPTCP test base
12820874  [bpf-next,2/7] bpf: add bpf_skc_to_mptcp_sock_proto
12820873  [bpf-next,1/7] bpf: expose is_mptcp flag to bpf_tcp_sock:
    - to BPF maintainer

12819235  [RFC,2/2] mptcp: never shrink offered window
12819237  [RFC,1/2] tcp: allow MPTCP to update the announced window:
    - to Eric


    our repo (by: Dmytro SHYTYI, Geliang Tang, Jiapeng Chong, Matthieu
Baerts, Paolo Abeni):

12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to
tcp.h/mptcp.h
12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in
reset packets
12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support
12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp
stack
12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes
socket with unread data
12321111: RFC: mptcp: Remove redundant assignment to remaining:
    - RFC

12714439: RFC: [net-next,v2] net: mptcp, Fast Open Mechanism:
    - @Dmytro: are you still working on it?

12821124: New: [mptcp-next,v13,1/9] mptcp: add struct mptcp_sched_ops
12821125: New: [mptcp-next,v13,2/9] mptcp: register default scheduler
12821126: New: [mptcp-next,v13,3/9] mptcp: add a new sysctl scheduler
12821127: New: [mptcp-next,v13,4/9] mptcp: add sched in mptcp_sock
12821129: New: [mptcp-next,v13,5/9] mptcp: add get_subflow wrapper
12821130: New: [mptcp-next,v13,6/9] mptcp: add bpf_mptcp_sched_ops
12821131: New: [mptcp-next,v13,7/9] mptcp: add call_me_again flag
12821132: New: [mptcp-next,v13,8/9] selftests: bpf: add bpf_first scheduler
12821133: New: [mptcp-next,v13,9/9] selftests: bpf: add bpf_first test:
    - series: BPF packet scheduler
    - Mat will have a look
    - our design is a bit different from what is done in mptcp.org:
        - Matth: TODO: check with Christoph why there 2 functions for
the schedulers in mptcp.org:
            - one to return the next segment to send (skb) (from
reinject or send queue) (+ set origin)
            - one to return the subflow (ssk) to send the selected skb

12821135: New: [mptcp-next,v7,1/3] mptcp: add bpf get_subflows helper
12821136: New: [mptcp-next,v7,2/3] selftests: bpf: add bpf_rr scheduler
12821137: New: [mptcp-next,v7,3/3] selftests: bpf: add bpf_rr test:
    - series: BPF round-robin scheduler

12821716: New: [v2,1/5] mptcp: really share subflow snd_wnd
12821717: New: [v2,2/5] mptcp: add mib for xmit window sharing
12821718: New: [v2,3/5] tcp: allow MPTCP to update the announced window.
12821719: New: [v2,4/5] mptcp: never shrink offered window
12821720: New: [v2,5/5] mptcp: add more offered MIBs counter.:
    - mptcp: improve mptcp-level window tracking
    - v2:
        - pass only the TCP header to tcp_options_write (Mat)
        - fix build issues on some 32 bit arches (intel bot)
    - Mat will have a look


Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 266)

  268  kmemleak: suspected mem leak in msr_build_context() [bug]
[selftests] @matttbe:
      - Matth has a patch and will send it just after the meeting
      - Sounds like a limitation (or a bug?) in kmemleak
      - Strange no other complains


    Bugs (opened, flagged as "bug" and assigned)

  268  kmemleak: suspected mem leak in msr_build_context() [bug]
[selftests] @matttbe:
      - see above

  264  selftests: diag: failing on the public CI with the new
debug.config [bug] [selftests] @matttbe
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug] @mjmartineau


    Bugs (opened and flagged as "bug" and not assigned)

  265  self-tests #94 && #95 failing [bug] [selftests]
  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]


    In Progress (opened, new feature and assigned)

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  216  The infinite mapping support: drop data [enhancement] @geliangtang

  186  Add netlink command support [enhancement] @kmaloor:
      - can be closed → done

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
       - See patches above

   74  BPF: path manager [enhancement] @geliangtang


    For later (opened and not assigned assigned)

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
   48  MP_FASTCLOSE support (send part remaining) [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since last week)

  267  Kmemleak report with mptcp_connect [bug] [selftests] @mjmartineau



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.18):
https://github.com/multipath-tcp/mptcp_net-next/projects/14
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Features for net-next (next):

        - [039dcb972d94] mptcp: don't send RST for single subflow
(Geliang Tang)
        - [cf0b368a0d51] mptcp: add the fallback check (Geliang Tang)
        - [4cff39b1e6af] mptcp: track and update contiguous data status
(Geliang Tang)
        - [77d801d22a03] mptcp: infinite mapping sending (Geliang Tang)
        - [bec5caf23678] mptcp: infinite mapping receiving (Geliang Tang)
        - [e453876eb534] mptcp: add mib for infinite map sending
(Geliang Tang)
        - [b514fbf81de9] mptcp: dump infinite_map field in
mptcp_dump_mpext (Geliang Tang)
        - [d2dcda917dc9] selftests: mptcp: add infinite map mibs check
(Geliang Tang)
        - [24ed5be36c51] selftests: mptcp: add infinite map testcase
(Geliang Tang):
            - can be sent

        - [2c2d2d31ff01] mptcp: use mptcp_stop_timer (Geliang Tang)
        - [6b19f09da643] mptcp: add data lock for sk timers (Geliang Tang)
        - [01f9ae067eb1] mptcp: add MP_FAIL response support (Geliang Tang)
        - [4a66bc0f32f8] mptcp: reset subflow when MP_FAIL doesn't
respond (Geliang Tang)
        - [15e8ee7b98fb] selftests: mptcp: check MP_FAIL response mibs
(Geliang Tang)
        - [67a459da80da] selftests: mptcp: print extra msg in
chk_csum_nr (Geliang Tang):
            - can be sent

        - [c851e4e180a1] selftests: mptcp: add MP_FAIL reset testcase
(Geliang Tang):
            - should NOT be sent

        - [7becbf502e83] mptcp: Remove redundant assignments in path
manager init (Mat Martineau)
        - [506f786671f0] mptcp: Add a member to mptcp_pm_data to track
kernel vs userspace mode (Mat Martineau)
        - [2a53be89f58f] mptcp: Bypass kernel PM when userspace PM is
enabled (Mat Martineau)
        - [c212e832c774] mptcp: Make kernel path manager check for
userspace-managed sockets (Mat Martineau)
        - [a252e5a28044] mptcp: Add a per-namespace sysctl to set the
default path manager type (Mat Martineau)
        - [c090acf32681] selftests: mptcp: Add tests for userspace PM
type (Mat Martineau):
            - can be sent

        - [f1e80d18f384] mptcp: bypass in-kernel PM restrictions for
non-kernel PMs (Kishen Maloor)
        - [d5cf2c5df46b] selftests: mptcp: ADD_ADDR echo test with
missing userspace daemon (Mat Martineau):
        - [a18617657619] mptcp: store remote id from MP_JOIN SYN/ACK in
local ctx (Kishen Maloor)
        - [8c17ae4989f3] mptcp: reflect remote port (not 0) in ANNOUNCED
events (Kishen Maloor)
        - [3bd2fb19e4ca] mptcp: establish subflows from either end of
connection (Kishen Maloor)
        - [ec71d440e1bf] mptcp: expose server_side attribute in MPTCP
netlink events (Kishen Maloor):
            - can be sent

        - [b75df29a7488] mptcp: allow ADD_ADDR reissuance by userspace
PMs (Kishen Maloor)
        - [5fbc7b3fd597] mptcp: handle local addrs announced by
userspace PMs (Kishen Maloor)
        - [1febef3db343] mptcp: read attributes of addr entries managed
by userspace PMs (Kishen Maloor)
        - [ceb3a12febc0] mptcp: netlink: split mptcp_pm_parse_addr into
two functions (Florian Westphal)
        - [88e497db8eee] mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE
(Kishen Maloor)
        - [06fd0da1832e] selftests: mptcp: support MPTCP_PM_CMD_ANNOUNCE
(Kishen Maloor)
        - [a9202f6e0f99] mptcp: netlink: Add MPTCP_PM_CMD_REMOVE (Kishen
Maloor)
        - [43be6f445956] selftests: mptcp: support MPTCP_PM_CMD_REMOVE
(Kishen Maloor)
        - [d48dc0680efc] mptcp: netlink: allow userspace-driven subflow
establishment (Florian Westphal)
        - [d42a119b7d1e] selftests: mptcp: support
MPTCP_PM_CMD_SUBFLOW_CREATE (Kishen Maloor)
        - [5f6966ec10da] selftests: mptcp: support
MPTCP_PM_CMD_SUBFLOW_DESTROY (Kishen Maloor)
        - [2193a86e28fc] selftests: mptcp: capture netlink events
(Kishen Maloor)
        - [2fdb1d5748f2] selftests: mptcp: create listeners to receive
MPJs (Kishen Maloor)
        - [9791ef4fac4c] selftests: mptcp: functional tests for the
userspace PM type (Kishen Maloor):
            - can be sent

    - Features for other trees:

        - [e40e5ba76120] bpf: expose is_mptcp flag to bpf_tcp_sock
(Nicolas Rybowski)
        - [15c1be07f81d] bpf: add bpf_skc_to_mptcp_sock_proto (Geliang Tang)
        - [9fd247d49de5] selftests: bpf: add MPTCP test base (Nicolas
Rybowski)
        - [7137f6d0857a] selftests: bpf: test bpf_skc_to_mptcp_sock
(Geliang Tang)
        - [e1aef51b9d54] selftests: bpf: verify token of struct
mptcp_sock (Geliang Tang)
        - [9a26a0bdf5d6] selftests: bpf: verify ca_name of struct
mptcp_sock (Geliang Tang)
        - [c60929d3baa4] selftests: bpf: verify first of struct
mptcp_sock (Geliang Tang):
            - pending on netdev



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - still very quiet inside and outside MPTCP
        - maybe normal? still strange
        - *Mat* will re-check the configs

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - also testing export-net
        - some sporadic failures
        - on the public CI, a few issues with selftest_diag

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - git: avoid 'unsafe repository' error
        - kmemleak: also decode stacktrace
        - Use KCSAN? But required GCC 11



Documentation (from last week):
    - update wiki page?
    - more info about mptcpd?
    - we can use mptcp.dev domain (own by Tessares)



Next meeting:
    - Next one on Thursday, the 28th of April.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220428



Feel free to comment on these points and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
