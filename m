Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F41C7C
	for <mptcp@lists.linux.dev>; Sat,  2 Apr 2022 10:32:12 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id yy13so10688224ejb.2
        for <mptcp@lists.linux.dev>; Sat, 02 Apr 2022 03:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=zx6fTvi8jAJFEgRIGPzdViZz09uPDdTI7Ki/1MV9IWo=;
        b=Y7cQMltq2NPZnTa98cYPR2yvch3dw4Z3rE1kc0butq5m5gS0TMZZCVKgVR4/NZbfCS
         uywXGsJyAwpUQP9tKr8bvWEbU5cm3hL07+lR8HDnWW+wuK0TuZEuHyE0nUWlzxcS2i1w
         Vwa9WcAncrHU00GAgklc2sqkcDcOBULkru/SpRFvzBxpKPJSvnXBTcCCzDBN/V2R3IFh
         KhV9pi1tfZPSYQHiQrtElsvq+GBGloa1IcIlrCno00VToX28NkXmfvsAeRkrCsoLfuA8
         H+yN/Js0MfKSLFjpvxfyz437IeTdtjtYxDon+kMkQjs0vr/TsLWnXin/YAScVLJXtnm3
         KAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=zx6fTvi8jAJFEgRIGPzdViZz09uPDdTI7Ki/1MV9IWo=;
        b=IhC/OKw/zctpChhL7o++ulBR02rrBfbB9pxlmEWe+z+Q2Qkkl1I7vTSaLnnI8TfJ4Y
         j5W30zwCCPVnrS2Qj243zRuAJp/sWu68BsJL2OoC7mQrhQYijdA1zgMsd+/NvwJV+7LP
         7XhftGjW4b2Mur6qOs7stJik/XUypwXZBTuUoZg5QzHtbC2YcZM5betjdFTHvhrHRFc3
         6pHYLtT7XJcGp7GXOBLkNC4SErIGYdjJk+NSQLABuPciY8klFaVL/E7SbmtfZLAsaH/K
         qlApcBahaQSWSwxQfjwV/6fGjfUWMxQR7v4V2wq6iBgqXg/nYoqskCQa112qOvPa5Wlx
         3F2Q==
X-Gm-Message-State: AOAM530upkwyQD8jYnQZfnvDXS5CqZw/5GxhnJ8UgjPGmWI/qQMf4SqP
	hp5pU7w3pE4zb4n2glLaQWhwJf4cSQZPjA==
X-Google-Smtp-Source: ABdhPJy7aX2/6KpP7fS7VGKP7lN8Zb0IiD9FHJwdclBzjfdF54GUB5F18AuHglV7o0B1VLXFKh9R5A==
X-Received: by 2002:a17:907:3d91:b0:6df:a01c:f7cd with SMTP id he17-20020a1709073d9100b006dfa01cf7cdmr3278899ejc.255.1648895529931;
        Sat, 02 Apr 2022 03:32:09 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:9373:86b5:c614:c3cf? ([2a02:578:8593:1200:9373:86b5:c614:c3cf])
        by smtp.gmail.com with ESMTPSA id s7-20020a170906778700b006df7e0e140bsm1990531ejm.140.2022.04.02.03.32.08
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 03:32:09 -0700 (PDT)
Message-ID: <a625ada9-bb0f-4d27-8520-f888333a611b@tessares.net>
Date: Sat, 2 Apr 2022 12:32:08 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 31st of March 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 190th meeting with Mat, Ossama, Kishen (Intel)
Florian, Paolo, Davide (Red Hat), Geliang (SUSE), Giray (Parkyeri) and
myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Geliang Tang):

12790564  [bpf-next] bpf: Sync comments for bpf_get_stack


    our repo (by: Florian Westphal, Geliang Tang):


12794702  [mptcp-next,v3,4/4] selftests/mptcp: add diag listen tests
12794701  [mptcp-next,v3,3/4] mptcp: listen diag dump support
12794699  [mptcp-next,v3,2/4] mptcp: remove locking in mptcp_diag_fill_info
12794700  [mptcp-next,v3,1/4] mptcp: diag: switch to context structure

12796835  [mptcp-next,v2] Squash to "selftests: bpf: test
bpf_skc_to_mptcp_sock"
12796834  [mptcp-next] Squash to "selftests: bpf: add MPTCP test base"
12796073  [mptcp-next] Squash to "bpf: add bpf_skc_to_mptcp_sock_proto"
part 2
12795538  [mptcp-next] Squash to "bpf: add bpf_skc_to_mptcp_sock_proto"
12792435  [mptcp-next,v14,6/6] selftests: bpf: verify first of struct
mptcp_sock
12792434  [mptcp-next,v14,5/6] selftests: bpf: verify ca_name of struct
mptcp_s...
12792433  [mptcp-next,v14,4/6] selftests: bpf: verify token of struct
mptcp_sock
12792432  [mptcp-next,v14,3/6] selftests: bpf: test bpf_skc_to_mptcp_sock
12792431  [mptcp-next,v14,2/6] Squash to "selftests: bpf: add MPTCP test
base"
12792430  [mptcp-next,v14,1/6] bpf: add bpf_skc_to_mptcp_sock_proto

12789684  [mptcp-next,v2] mptcp: add pm_nl_pernet helpers



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Dmytro SHYTYI, Geliang Tang, Jiapeng Chong, Kishen
Maloor, Matthieu Baerts):

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

12794381: New: [mptcp-next,v9,1/6] Squash-to: mptcp: Bypass kernel PM
when userspace PM is enabled
12794382: New: [mptcp-next,v9,2/6] mptcp: bypass in-kernel PM
restrictions for non-kernel PMs
12794383: New: [mptcp-next,v9,3/6] mptcp: store remote id from MP_JOIN
SYN/ACK in local ctx
12794384: New: [mptcp-next,v9,4/6] mptcp: reflect remote port (not 0) in
ANNOUNCED events
12794385: New: [mptcp-next,v9,5/6] mptcp: establish subflows from either
end of connection
12794386: New: [mptcp-next,v9,6/6] mptcp: expose server_side attribute
in MPTCP netlink events
12794389: New: [mptcp-next,v6,01/14] mptcp: allow ADD_ADDR reissuance by
userspace PMs
12794390: New: [mptcp-next,v6,02/14] mptcp: handle local addrs announced
by userspace PMs
12794391: New: [mptcp-next,v6,03/14] mptcp: read attributes of addr
entries managed by userspace PMs
12794398: New: [mptcp-next,v6,04/14] mptcp: netlink: split
mptcp_pm_parse_addr into two functions
12794394: New: [mptcp-next,v6,05/14] mptcp: netlink: Add
MPTCP_PM_CMD_ANNOUNCE
12794396: New: [mptcp-next,v6,06/14] selftests: mptcp: support
MPTCP_PM_CMD_ANNOUNCE
12794393: New: [mptcp-next,v6,07/14] mptcp: netlink: Add MPTCP_PM_CMD_REMOVE
12794388: New: [mptcp-next,v6,08/14] selftests: mptcp: support
MPTCP_PM_CMD_REMOVE
12794399: New: [mptcp-next,v6,09/14] mptcp: netlink: allow
userspace-driven subflow establishment
12794401: New: [mptcp-next,v6,10/14] selftests: mptcp: support
MPTCP_PM_CMD_SUBFLOW_CREATE
12794392: New: [mptcp-next,v6,11/14] selftests: mptcp: support
MPTCP_PM_CMD_SUBFLOW_DESTROY
12794397: New: [mptcp-next,v6,12/14] selftests: mptcp: capture netlink
events
12794395: New: [mptcp-next,v6,13/14] selftests: mptcp: create listeners
to receive MPJs
12794400: New: [mptcp-next,v6,14/14] selftests: mptcp: functional tests
for the userspace PM type:
    - Paolo will look at the new version
    - Some small selftests changes are still required, Mat and Kishen
are working on that

12794498: Under Review: [mptcp-next,v8,1/8] mptcp: add struct
mptcp_sched_ops
12794499: Under Review: [mptcp-next,v8,2/8] mptcp: register default
scheduler
12794500: Under Review: [mptcp-next,v8,3/8] mptcp: add a new sysctl
scheduler
12794501: Under Review: [mptcp-next,v8,4/8] mptcp: add sched in mptcp_sock
12794502: Under Review: [mptcp-next,v8,5/8] mptcp: add get_subflow wrapper
12794503: Under Review: [mptcp-next,v8,6/8] mptcp: add bpf_mptcp_sched_ops
12794504: Under Review: [mptcp-next,v8,7/8] selftests: bpf: add
bpf_first scheduler
12794505: Under Review: [mptcp-next,v8,8/8] selftests: bpf: add
bpf_first test
12797117: New: [mptcp-next,v2] Squash to "selftests: bpf: add bpf_first
scheduler v8":
    - BPF packet scheduler
    - next steps: it seems the code can be extended to support RR packet
scheduler
    - probably some new bpf helpers needed rather than trying to write
values directly in MPTCP structure
    - maybe it is needed to write in BPF storage instead of writing
stuff like: "msk->last_sent"
    - TODO: Matth: check notes from 2020 when looking at that with
Nicolas → yes, BPF helpers + storage



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 265)

  266  Packetdrill: add MP_FAIL coverage [packetdrill]:
      - this needs DSS Checksum support in Packetdrill to be useful


    Bugs (opened, flagged as "bug" and assigned)

  264  selftests: diag: failing on the public CI with the new
debug.config [bug] [selftests] @matttbe
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug] @mjmartineau


    Bugs (opened and flagged as "bug" and not assigned)

  265  self-tests #94 && #95 failing [bug] [selftests]
  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]


    In Progress (opened, new feature and assigned)

  246  Netlink PM events: add one attribute about the connection type
(connect/accept) [enhancement] @kmaloor:
      - See patches above

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva

  216  The infinite mapping support: drop data [enhancement] @geliangtang:
      - See discussion below

  186  Add netlink command support [enhancement] @kmaloor:
      - See patches above

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

  261  MP_FAIL echo and retrans [enhancement] @geliangtang
  163  allow ss dumping msk socket in TCP_LISTEN status [enhancement]
@fw-strlen



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.18):
https://github.com/multipath-tcp/mptcp_net-next/projects/14 (New project)
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
    - ChangeLog has been updated:
https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog



Patches to send to netdev:

    - Fixes for -net:

        /


    - Features for net-next:

        - [a5a2351f4163] mptcp: optimize release_cb for the common case
(Paolo Abeni)
        - [7c251472af5f] mptcp: reset the packet scheduler on incoming
MP_PRIO (Paolo Abeni)
        - [3b211b7fb377] mptcp: reset the packet scheduler on PRIO
change (Paolo Abeni)

        - [94b181e39660] mptcp: add pm_nl_pernet helpers (Geliang Tang)

        - [eba1a0aa132d] mptcp: diag: switch to context structure
(Florian Westphal)
        - [49abd7c788a2] mptcp: remove locking in mptcp_diag_fill_info
(Florian Westphal)
        - [99d3d907f3b8] mptcp: listen diag dump support (Florian Westphal)
        - [2b1a98ab627c] selftests/mptcp: add diag listen tests (Florian
Westphal)


    - Features for net-next (next):

        - [e5dc2a30c104] mptcp: don't send RST for single subflow
(Geliang Tang)
        - [20aef78fbd45] mptcp: add the fallback check (Geliang Tang)
        - [4930e6c335cc] mptcp: track and update contiguous data status
(Geliang Tang)
        - [5dc09276d6f2] mptcp: infinite mapping sending (Geliang Tang)
        - [30f12d27f1d7] mptcp: infinite mapping receiving (Geliang Tang)
        - [1f6759c4ebc5] mptcp: add mib for infinite map sending
(Geliang Tang)
        - [0298d2c9cd30] mptcp: dump infinite_map field in
mptcp_dump_mpext (Geliang Tang)
        - [095775dc7109] selftests: mptcp: add infinite map mibs check
(Geliang Tang)
        - [04490e8ea516] selftests: mptcp: add the MP_FAIL testcases
(Geliang Tang)
        - [4e1d7ca4ac06] mptcp: use mptcp_stop_timer (Geliang Tang)
        - [1f6afa4c16c7] mptcp: add data lock for sk timers (Geliang Tang)
        - [6b17f502c206] mptcp: add MP_FAIL response support (Geliang Tang)
        - [cc3ba5566d40] mptcp: reset subflow when MP_FAIL doesn't
respond (Geliang Tang)
        - [cfc80e216d82] selftests: mptcp: check MP_FAIL response mibs
(Geliang Tang)
        - [e858fdc38852] selftests: mptcp: print extra msg in
chk_csum_nr (Geliang Tang):
            - Geliang noticed some issues with these patches (some parts
have been squashed)
            - Some commit logs became mismatched. Geliang will send a
mail to Matt to update them. → done

        - [658386d9356e] mptcp: Remove redundant assignments in path
manager init (Mat Martineau)
        - [74cd9a564822] mptcp: Add a member to mptcp_pm_data to track
kernel vs userspace mode (Mat Martineau)
        - [632b956bdf62] mptcp: Bypass kernel PM when userspace PM is
enabled (Mat Martineau)
        - [628181a97cdc] mptcp: Make kernel path manager check for
userspace-managed sockets (Mat Martineau)
        - [43309fb59e81] mptcp: Add a per-namespace sysctl to set the
default path manager type (Mat Martineau)
        - [6e575e76fc6c] selftests: mptcp: Add tests for userspace PM
type (Mat Martineau)


    - Features for other trees:

        - [e0c099f202b3] bpf: expose is_mptcp flag to bpf_tcp_sock
(Nicolas Rybowski)
        - [98d0b27d6170] bpf: add bpf_skc_to_mptcp_sock_proto (Geliang Tang)
        - [8be73e5acfb5] selftests: bpf: add MPTCP test base (Nicolas
Rybowski)
        - [47329d9a71ec] selftests: bpf: test bpf_skc_to_mptcp_sock
(Geliang Tang)
        - [25bdbbe949cc] selftests: bpf: verify token of struct
mptcp_sock (Geliang Tang)
        - [c5a5d44a6e68] selftests: bpf: verify ca_name of struct
mptcp_sock (Geliang Tang)
        - [6de91c265b8c] selftests: bpf: verify first of struct
mptcp_sock (Geliang Tang)



Infinite mapping and dropping data:
    -
https://lore.kernel.org/mptcp/5e9cc0c5-1514-a198-5191-a765a67b9de4@linux.intel.com/T/#u
    - When re-reading the RFC, we might not have to drop anything if
everything is contiguous
    - Christoph is not available this week but hopefully we will get a
reply soon
    - If needed, we can also use IETF MPTCP's ML, it should still be active



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - not finding bugs \o/

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - builds are completing and results look good

    - packetdrill (Davide):
        - one commit has been reverted because tests were not OK with IPv6

    - Patchew (Davide):
        - Fixes from Paolo Bonzini added to have Patchew back applying
patches

    - CI (Matth):
        - support for just released new kernel: to pick the right
packetdrill branch, etc.
        - there was a failure with net/mptcp/bpf.c:
            - can now be compiled: kconfig were missing
              (BPF_SYSCALL + BPF_JIT + MODULES)



Next meeting:
    - Next one on Thursday, the 7th of April.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220407



Feel free to comment on these points and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
