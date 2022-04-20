Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E36C184A
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 12:53:31 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id s18so3445792ejr.0
        for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject
         :content-language:to:content-transfer-encoding;
        bh=wy6SOUHWmwNkzUv+A/219FlzEpDfktxkm12xeut2Ay0=;
        b=umjLSkc+rPBQp/FDh4a4in2oWdnWI2R/fG5oBxtBL2DyM2ZxkpQtI7sQ6RndUekFec
         yJ2AAcKCi7mLSh0Od9HeHmxtUf909/9767SPOQjgWgE2G8W7XtGUp69D+j/QaLSpjMMF
         qLXMphbUmVF98iKX02OcpPtwf8t0+9+nBg6VdjNIEXL+3SuYO2utsf53CD+HZKDMS+Yu
         AN5+hs0a373q4dHBSB2Mae8VnVN1+AJkV8NlP0CpeLSkdOJGmQVYcNFjno3RdqCck8l3
         M11B3PhQUQHwip4NXd3X8tGT45ciISx1MtSbh0PDaEHKS3AJ+IAz0rDlwSJqzpbTG1qP
         H3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:content-transfer-encoding;
        bh=wy6SOUHWmwNkzUv+A/219FlzEpDfktxkm12xeut2Ay0=;
        b=amUB06mop9mPMawcwCdlnkjpG0yKGjbvY+bzkxiKAlqqd8Mkd+xkDChvjmapZOCGM5
         dyd8+8UyP030+in9yNOa21YTEtKLcD5OnE5FNkZuQYKAzF3FlgpGazgwXSHZoGSMlNss
         MLDk+F9lVkv8LBapvqA5xt1k4kV6G58zOKOx0Zyx4ZEnErjzRi0dzfahcTUuPcZuI8Gl
         jg7Zse7prAZRjXUUM5/9/nGzIoBd8MMoTfZl+Uv2+U2XDHU9ZfN+lK8Mv598DXRcUYSl
         I9BDVmG+euTnvzCAarWeWGmhXOUe2TAlgtMi29wE82Dhksb4qVu4V+ZezRpWbPeI16Zd
         Ei+Q==
X-Gm-Message-State: AOAM531e9vLPNahwIvsNxVNC0c6hOV6QcG8En97Bp8Nwn2PIxZP72hGF
	biJgwCg15bO0kw3G9AtwrRsD4T7JiKiwdw==
X-Google-Smtp-Source: ABdhPJy3NkUVbOmKDpGIhjbnmHKeFjFmkmeghthqzek2iV50WQOlT4If5ks9Ay+7MNwnhjUT9gNG7w==
X-Received: by 2002:a17:907:96a7:b0:6ef:f8db:218a with SMTP id hd39-20020a17090796a700b006eff8db218amr3674816ejc.532.1650459209718;
        Wed, 20 Apr 2022 05:53:29 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a8ef:af16:f14e:5d01? ([2a02:578:8593:1200:a8ef:af16:f14e:5d01])
        by smtp.gmail.com with ESMTPSA id r19-20020a17090638d300b006d6e4fc047bsm6791423ejd.11.2022.04.20.05.53.27
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 05:53:27 -0700 (PDT)
Message-ID: <a5da82d4-cde8-4878-502d-a8cd22b80f4e@tessares.net>
Date: Wed, 20 Apr 2022 14:53:26 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 14th of April 2022
Content-Language: en-GB
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


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12807145  [net-next,8/8] selftests/mptcp: add diag listen tests
12807146  [net-next,7/8] mptcp: listen diag dump support
12807141  [net-next,6/8] mptcp: remove locking in mptcp_diag_fill_info
12807140  [net-next,5/8] mptcp: diag: switch to context structure
12807144  [net-next,4/8] mptcp: add pm_nl_pernet helpers
12807143  [net-next,3/8] mptcp: reset the packet scheduler on PRIO change
12807142  [net-next,2/8] mptcp: reset the packet scheduler on incoming
MP_PRIO
12807139  [net-next,1/8] mptcp: optimize release_cb for the common case


    our repo (by: /):

/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Dmytro SHYTYI, Geliang Tang, Jiapeng Chong, Kishen
Maloor, Matthieu Baerts, Paolo Abeni):

12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to
tcp.h/mptcp.h
12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in
reset packets
12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support
12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp
stack
12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes
socket with unread data:
12321111: RFC: mptcp: Remove redundant assignment to remaining
12714439: RFC: [net-next,v2] net: mptcp, Fast Open Mechanism:
    - RFC

12806898: New: [mptcp-next,v11,1/8] mptcp: add struct mptcp_sched_ops
12806899: New: [mptcp-next,v11,2/8] mptcp: register default scheduler
12806900: New: [mptcp-next,v11,3/8] mptcp: add a new sysctl scheduler
12806901: New: [mptcp-next,v11,4/8] mptcp: add sched in mptcp_sock
12806902: New: [mptcp-next,v11,5/8] mptcp: add get_subflow wrapper
12806903: New: [mptcp-next,v11,6/8] mptcp: add bpf_mptcp_sched_ops
12806904: New: [mptcp-next,v11,7/8] selftests: bpf: add bpf_first scheduler
12806905: New: [mptcp-next,v11,8/8] selftests: bpf: add bpf_first test:
    - series: BPF packet scheduler

    - Main remaining question: how to send on multiple subflows (e.g.
supporting a "redundant"
packet scheduler):
        - currently, we can only return one ssk
        - it might be important to think about that now because once the
BPF "API" is in place, might be hard to change
        - if we want to support that now we could use a bitmap (not sure
how the BPF code would know which one is which) but is it possible to
add this later?
        - a simple way might be to return 2 things:
            - the ssk to which we want to send data
            - a boolean to say: call me again
            - but can we return 2 different params in BPF? → maybe with
a hook writing something somewhere (e.g. writing a value in one pointer
we got?)
        - probably best to ask on BPF mailing to see what they recommend:
            - what if we need to "change the API"?
            - which technique to use to avoid breaking stuff?
            → first we send patches to let access to the msk structure,
then we can start asking questions

    - Regarding this series: it might be better to have only one
function to send new data
and reinject old one

    - To be able to make useful BPF programs, it looks like it might be
needed to let access to ssk info (same as what Geliang did for the msk)

12807313: New: [mptcp-next,v9,01/14] mptcp: allow ADD_ADDR reissuance by
userspace PMs
12807317: New: [mptcp-next,v9,02/14] mptcp: handle local addrs announced
by userspace PMs
12807315: New: [mptcp-next,v9,03/14] mptcp: read attributes of addr
entries managed by userspace PMs
12807314: New: [mptcp-next,v9,04/14] mptcp: netlink: split
mptcp_pm_parse_addr into two function
12807320: New: [mptcp-next,v9,05/14] mptcp: netlink: Add
MPTCP_PM_CMD_ANNOUNCE
12807318: New: [mptcp-next,v9,06/14] selftests: mptcp: support
MPTCP_PM_CMD_ANNOUNCE
12807322: New: [mptcp-next,v9,07/14] mptcp: netlink: Add MPTCP_PM_CMD_REMOVE
12807319: New: [mptcp-next,v9,08/14] selftests: mptcp: support
MPTCP_PM_CMD_REMOVE
12807326: New: [mptcp-next,v9,09/14] mptcp: netlink: allow
userspace-driven subflow establishment
12807321: New: [mptcp-next,v9,10/14] selftests: mptcp: support
MPTCP_PM_CMD_SUBFLOW_CREATE
12807323: New: [mptcp-next,v9,11/14] selftests: mptcp: support
MPTCP_PM_CMD_SUBFLOW_DESTROY
12807324: New: [mptcp-next,v9,12/14] selftests: mptcp: capture netlink
events
12807327: New: [mptcp-next,v9,13/14] selftests: mptcp: create listeners
to receive MPJs
12807325: New: [mptcp-next,v9,14/14] selftests: mptcp: functional tests
for the userspace PM type:
    - Paolo did a review:
        - Kishen recently replied to his comments
        - Kishen is doing some modifications to address that

    - tests on the CI are no longer stuck when running the tests in
debug mode:
        - but still failing:
https://api.cirrus-ci.com/v1/artifact/task/6380633525059584/summary/summary.txt
        - when running in a loop, it is possible to repro the issue
        - maybe the order in which the tests are running?

    - we can probably apply the patches and fix that later:
        - TODO: to apply them → Done

12808972: New: [RFC,1/4] mptcp: really share subflow snd_wnd
12808973: New: [RFC,2/4] mptcp: add mib for xmit window sharing
12808974: New: [RFC,3/4] mptcp: never shrink offered window
12808975: New: [RFC,4/4] mptcp: add more offered MIBs counter.:
    - series: mptcp: improve mptcp-level window tracking
    - please ignore the RFC tag
    - the issue seems to be linked to the way the MPTCP congestion
window is used: the patches are supposed to address the issue but also
to be "more compliant" to MPTCP's RFC
    - seems to be reproduceable only at very high speed on some specific
HW (i40e NIC on 40Gbs link)

12812084: New: [mptcp-next,v5,1/4] mptcp: add last_snd write access
12812085: New: [mptcp-next,v5,2/4] mptcp: add bpf get_subflows helper
12812086: New: [mptcp-next,v5,3/4] selftests: bpf: add bpf_rr scheduler
12812087: New: [mptcp-next,v5,4/4] selftests: bpf: add bpf_rr test:
    - series: BPF round-robin scheduler
    - depending on another series, see above ↑
    - new version, to be reviewed



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 266)

None.


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

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  216  The infinite mapping support: drop data [enhancement] @geliangtang
  186  Add netlink command support [enhancement] @kmaloor
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   75  BPF: packet scheduler [enhancement] @geliangtang:
       - See above

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

None.



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.18):
https://github.com/multipath-tcp/mptcp_net-next/projects/14
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:


    - Fixes for other trees:


    - Fixes for -net:


    - Features for net-next:

/

    - Features for net-next (next):

        - [96bb8de34e68] mptcp: don't send RST for single subflow
(Geliang Tang)
        - [b0fee4bf7131] mptcp: add the fallback check (Geliang Tang)
        - [e7740f777df8] mptcp: track and update contiguous data status
(Geliang Tang)
        - [8c0b8f6578cd] mptcp: infinite mapping sending (Geliang Tang)
        - [4af2a31c3c8e] mptcp: infinite mapping receiving (Geliang Tang)
        - [099d510e794b] mptcp: add mib for infinite map sending
(Geliang Tang)
        - [505e8a5ff139] mptcp: dump infinite_map field in
mptcp_dump_mpext (Geliang Tang)
        - [1fd3014d9efb] selftests: mptcp: add infinite map mibs check
(Geliang Tang)
        - [e48e0c4c1939] selftests: mptcp: add infinite map testcase
(Geliang Tang):
            - can be sent

        - [c5096ab1d919] mptcp: use mptcp_stop_timer (Geliang Tang)
        - [f315308ad178] mptcp: add data lock for sk timers (Geliang Tang)
        - [e70969fc8cc3] mptcp: add MP_FAIL response support (Geliang Tang)
        - [ed767fc0fad3] mptcp: reset subflow when MP_FAIL doesn't
respond (Geliang Tang)
        - [315f625e53fd] selftests: mptcp: check MP_FAIL response mibs
(Geliang Tang)
        - [49950c03904c] selftests: mptcp: print extra msg in
chk_csum_nr (Geliang Tang):
            - can be sent

        - [a5fcac715a12] selftests: mptcp: add MP_FAIL reset testcase
(Geliang Tang):
            - see Issue #216

        - [65eb60b605cb] mptcp: Remove redundant assignments in path
manager init (Mat Martineau)
        - [674bb91ccc4a] mptcp: Add a member to mptcp_pm_data to track
kernel vs userspace mode (Mat Martineau)
        - [577162b584af] mptcp: Bypass kernel PM when userspace PM is
enabled (Mat Martineau)
        - [f48ca6aec255] mptcp: Make kernel path manager check for
userspace-managed sockets (Mat Martineau)
        - [04c7c426b657] mptcp: Add a per-namespace sysctl to set the
default path manager type (Mat Martineau)
        - [08103c5518bf] selftests: mptcp: Add tests for userspace PM
type (Mat Martineau):
            - can be sent

        - [3c51aa55bad6] mptcp: bypass in-kernel PM restrictions for
non-kernel PMs (Kishen Maloor)
        - [60b980da9a62] selftests: mptcp: ADD_ADDR echo test with
missing userspace daemon (Mat Martineau)
        - [e2e15ea66693] mptcp: store remote id from MP_JOIN SYN/ACK in
local ctx (Kishen Maloor)
        - [ea26e2db60aa] mptcp: reflect remote port (not 0) in ANNOUNCED
events (Kishen Maloor)
        - [e9053e6ff03b] mptcp: establish subflows from either end of
connection (Kishen Maloor)
        - [ccb11cd530d9] mptcp: expose server_side attribute in MPTCP
netlink events (Kishen Maloor):
            - can be sent

    - Features for other trees:

        - [cee544ae40b6] bpf: expose is_mptcp flag to bpf_tcp_sock
(Nicolas Rybowski)
        - [9e11b21df608] bpf: add bpf_skc_to_mptcp_sock_proto (Geliang Tang)
        - [de327e80eacb] selftests: bpf: add MPTCP test base (Nicolas
Rybowski)
        - [ffca5afd1bbd] selftests: bpf: test bpf_skc_to_mptcp_sock
(Geliang Tang)
        - [0b71193af119] selftests: bpf: verify token of struct
mptcp_sock (Geliang Tang)
        - [ed3b96afb787] selftests: bpf: verify ca_name of struct
mptcp_sock (Geliang Tang)
        - [92376bdabd76] selftests: bpf: verify first of struct
mptcp_sock (Geliang Tang)
            - can be sent
            - Nicolas' emails will be redirected to Matth



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - syzkaller (from Mat) has been updated last week:
            - still not finding a lot of stuff
            - has been running for a couple of days, still not a lot of
failure
            - nothing linked to MPTCP, a few about TCP, Mat will check that

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - one failure, shown last week

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - kmemleak:
https://api.cirrus-ci.com/v1/artifact/task/6391116198051840/kmemleak/kmemleak.txt
        - linked to this?
https://lore.kernel.org/all/94e48fcd-1dbd-ebd2-4c91-f39941735909@molgen.mpg.de/
        - TODO Matth: run decode_stack.sh + bisect → in progress



Documentation:
    - update wiki page?
    - more info about mptcpd?
    - to be discussed next time



Next meeting:
    - Next one on Thursday, the 21st of April.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220421



Feel free to comment on these points and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
