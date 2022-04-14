Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E217A
	for <mptcp@lists.linux.dev>; Thu, 14 Apr 2022 14:30:14 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id z99so6604104ede.5
        for <mptcp@lists.linux.dev>; Thu, 14 Apr 2022 07:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=9bW27BQDBsoWTg9D3xIG2U6kwtk+tXp3k/ewCYn/CD4=;
        b=wn1pYLSYBrPRYWGEPY7In0u2Su2DnAvNDl/uYoP/7qn8uYgHnsz55db8rkPcATef/J
         tIdQYkv+fCc/Y2HXqx2+jCUb8ETOVtuSAo+gmsBeaYitmhJo6w7bxxPRmIDU7BHtQw/1
         lMCtuydiyk1vQmlh46w4ddMC/sW8Fjbq87v4qWnDL64ylKypMTOv4l5MaBX0QkOq3iDF
         wAtLIKK62exdmVvVdI6aw9d+YHOMnPlvQgTKTOtQy7YCjisVUvQvkYOEzgXSUeqexTQ2
         054HPPrtSdm97B7hnhB+MyW1t9upXPa8P8mgG2nyHUEV1ufSlHlvLsXZ0BvEyVZDjuZd
         H5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=9bW27BQDBsoWTg9D3xIG2U6kwtk+tXp3k/ewCYn/CD4=;
        b=wPtEoCgCSKexAI4w2NJhGhyRh32DXeoHHs2DxCw1IGmTfzRluFnXvUcpbBX7+RTfo+
         EMDhevS0AtTYFTrNpJENMaByNpGzxmJoOfsI4ViY7SZY2x6ownPn6rhmFud9mC96Csmh
         u4s7Nzgntz4r/CPmG6Z/ETNcyem1KKkfZekHcEETYu+VDYhcgGokI1l5OEP8qofMFBiI
         P3036kGgk5hPTpWK4UZtyhfdnNkkPhMuYoHZwuTyF/PjNk0EC57/V4MbgF63r3acf5rO
         NpWdcdsLML1wJVOoN7/a3OiICWrV4wsbAqMkyxYUM3Apmt4FBgKBaA8jcN7YwqJU8ner
         73VA==
X-Gm-Message-State: AOAM5328MI8JHWQbRCFl67SbF8r0DKicJayO8taO9dEdFIszQI54PqGn
	SXEvyO02+3VfAut0HJdPZrhYydDDOQgcBA==
X-Google-Smtp-Source: ABdhPJxgW/vzih9bhZAfISqnIc1wZzvwmtwECATBHcvWswFt8KxUfFSVHDJq365lv9XqFHQDT5bh4A==
X-Received: by 2002:a05:6402:358c:b0:41d:18ff:be23 with SMTP id y12-20020a056402358c00b0041d18ffbe23mr3233544edc.39.1649946612614;
        Thu, 14 Apr 2022 07:30:12 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e750:f6d9:29a4:eb34? ([2a02:578:8593:1200:e750:f6d9:29a4:eb34])
        by smtp.gmail.com with ESMTPSA id eg12-20020a056402288c00b0041fb0f2e155sm1098137edb.20.2022.04.14.07.30.10
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 07:30:10 -0700 (PDT)
Message-ID: <bfcfaac0-c5e5-02d0-2770-80c5e5424e36@tessares.net>
Date: Thu, 14 Apr 2022 16:30:09 +0200
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
Subject: [Weekly meetings] MoM - 7th of April 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 191st meeting with Mat, Ossama, Kishen (Intel)
Davide (Red Hat), Geliang (SUSE), Giray (Parkyeri) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Kishen Maloor, Mat Martineau):

12798636  [mptcp-next,2/2] selftests: mptcp: ADD_ADDR echo test with
missing us...
12798635  [mptcp-next,1/2] Squash-to: selftests: mptcp: Add tests for
userspace...

12798442  [mptcp-next,2/2] selftests: mptcp: add MP_FAIL reset testcase
12798441  [mptcp-next,1/2] Squash to "selftests: mptcp: add the MP_FAIL
testcas...

12794386  [mptcp-next,v9,6/6] mptcp: expose server_side attribute in
MPTCP netl...
12794385  [mptcp-next,v9,5/6] mptcp: establish subflows from either end
of conn...
12794384  [mptcp-next,v9,4/6] mptcp: reflect remote port (not 0) in
ANNOUNCED e...
12794383  [mptcp-next,v9,3/6] mptcp: store remote id from MP_JOIN
SYN/ACK in lo...
12794382  [mptcp-next,v9,2/6] mptcp: bypass in-kernel PM restrictions
for non-k...
12794381  [mptcp-next,v9,1/6] Squash-to: mptcp: Bypass kernel PM when
userspace...



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

12804347: New: [mptcp-next,v7,01/14] mptcp: allow ADD_ADDR reissuance by
userspace PMs
12804349: New: [mptcp-next,v7,02/14] mptcp: handle local addrs announced
by userspace PMs
12804348: New: [mptcp-next,v7,03/14] mptcp: read attributes of addr
entries managed by userspace PMs
12804354: New: [mptcp-next,v7,04/14] mptcp: netlink: split
mptcp_pm_parse_addr into two functions
12804350: New: [mptcp-next,v7,05/14] mptcp: netlink: Add
MPTCP_PM_CMD_ANNOUNCE
12804352: New: [mptcp-next,v7,06/14] selftests: mptcp: support
MPTCP_PM_CMD_ANNOUNCE
12804353: New: [mptcp-next,v7,07/14] mptcp: netlink: Add MPTCP_PM_CMD_REMOVE
12804351: New: [mptcp-next,v7,08/14] selftests: mptcp: support
MPTCP_PM_CMD_REMOVE
12804359: New: [mptcp-next,v7,09/14] mptcp: netlink: allow
userspace-driven subflow establishment
12804360: New: [mptcp-next,v7,10/14] selftests: mptcp: support
MPTCP_PM_CMD_SUBFLOW_CREATE
12804355: New: [mptcp-next,v7,11/14] selftests: mptcp: support
MPTCP_PM_CMD_SUBFLOW_DESTROY
12804356: New: [mptcp-next,v7,12/14] selftests: mptcp: capture netlink
events
12804358: New: [mptcp-next,v7,13/14] selftests: mptcp: create listeners
to receive MPJs
12804357: New: [mptcp-next,v7,14/14] selftests: mptcp: functional tests
for the userspace PM type:
    - The CI reported issues when building because some patches
introduce features that are not used yet:
        - Mat will check what kind of validation is done when patches
are sent to netdev ML
        - Idea is to avoid adding "#if 0"
    - v5: Primary change over v4 is the reliance on userspace managed
listener sockets for receiving MPJ requests. + Addressed CI reported issues.
    - @Paolo: do you plan to look at the new version? (no hurry ;-) ) → Done

12804418: New: [mptcp-next,v10,1/8] mptcp: add struct mptcp_sched_ops
12804419: New: [mptcp-next,v10,2/8] mptcp: register default scheduler
12804420: New: [mptcp-next,v10,3/8] mptcp: add a new sysctl scheduler
12804421: New: [mptcp-next,v10,4/8] mptcp: add sched in mptcp_sock
12804422: New: [mptcp-next,v10,5/8] mptcp: add get_subflow wrapper
12804423: New: [mptcp-next,v10,6/8] mptcp: add bpf_mptcp_sched_ops
12804424: New: [mptcp-next,v10,7/8] selftests: bpf: add bpf_first scheduler
12804425: New: [mptcp-next,v10,8/8] selftests: bpf: add bpf_first test:
    - series: BPF packet scheduler
    - v10: shared recently, waiting for review
    - it looks like an additional hook will be needed for the reinjection
     → from there, it is also possible to call the same function but
with a different parameter

12804427: New: [mptcp-next,v3,1/4] mptcp: add last_snd write access
12804428: New: [mptcp-next,v3,2/4] mptcp: add bpf get_subflows helper
12804429: New: [mptcp-next,v3,3/4] selftests: bpf: add bpf_rr scheduler
12804430: New: [mptcp-next,v3,4/4] selftests: bpf: add bpf_rr test:
    - series: BPF round-robin scheduler
    - v3: shared recently, waiting for review



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 266)

/


    Bugs (opened, flagged as "bug" and assigned)

  264  selftests: diag: failing on the public CI with the new
debug.config [bug] [selftests] @matttbe
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug] @mjmartineau:
      - Mat started to work on that
      - it looks like the bug that has to be fixed here is only when the
last ACK has been lost
      - in this case the TCP ACK is retransmitted but without the DATA_FIN
      - a hook is missing here because it is needed to know which seq to
put in this DATA_FIN
      - it looks like something similar to what is done for MD5 will be
necessary.


    Bugs (opened and flagged as "bug" and not assigned)

  265  self-tests #94 && #95 failing [bug] [selftests]
  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]


    In Progress (opened, new feature and assigned)

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva

  216  The infinite mapping support: drop data [enhancement] @geliangtang

  186  Add netlink command support [enhancement] @kmaloor:
      - see patches above

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
       - see patches above

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
  246  Netlink PM events: add one attribute about the connection type
(connect/accept) [enhancement] @kmaloor
  163  allow ss dumping msk socket in TCP_LISTEN status [enhancement]
@fw-strlen



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.18):
https://github.com/multipath-tcp/mptcp_net-next/projects/14
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees:

        - [b10a9d608d66] perf tools: Stop depending on .git files for
building PERF-VERSION-FILE (John Garry)
        → needed for our tests

    - Fixes for -net:

        /

    - Features for net-next:
        - (just re-opened)

        - [9ef391c10aa2] mptcp: optimize release_cb for the common case
(Paolo Abeni)
        - [d94011c04239] mptcp: reset the packet scheduler on incoming
MP_PRIO (Paolo Abeni)
        - [e68c8de71f3d] mptcp: reset the packet scheduler on PRIO
change (Paolo Abeni):
            - should be ready to be sent

        - [59f8a4c19eaf] mptcp: add pm_nl_pernet helpers (Geliang Tang):
            - should be ready to be sent

        - [db8e0fe64270] mptcp: diag: switch to context structure
(Florian Westphal)
        - [1d13243586c8] mptcp: remove locking in mptcp_diag_fill_info
(Florian Westphal)
        - [8ecafd5282bb] mptcp: listen diag dump support (Florian Westphal)
        - [9549bbe0e7c5] selftests/mptcp: add diag listen tests (Florian
Westphal):
            - should be ready to be sent


    - Features for net-next (next):

        - [49e1d720cf9b] mptcp: don't send RST for single subflow
(Geliang Tang)
        - [edb412fa06f2] mptcp: add the fallback check (Geliang Tang)
        - [190ee66aea36] mptcp: track and update contiguous data status
(Geliang Tang)
        - [5c57db242d38] mptcp: infinite mapping sending (Geliang Tang)
        - [5b457a2352ee] mptcp: infinite mapping receiving (Geliang Tang)
        - [1c02dc7d5f56] mptcp: add mib for infinite map sending
(Geliang Tang)
        - [a794546392b4] mptcp: dump infinite_map field in
mptcp_dump_mpext (Geliang Tang)
        - [714de4663c1e] selftests: mptcp: add infinite map mibs check
(Geliang Tang)
        - [4df3f2bf7f16] selftests: mptcp: add infinite map testcase
(Geliang Tang)
        - [8520841d688c] mptcp: use mptcp_stop_timer (Geliang Tang)
        - [b525113b117d] mptcp: add data lock for sk timers (Geliang Tang)
        - [83bc5a9c03a1] mptcp: add MP_FAIL response support (Geliang Tang)
        - [7b018c87849a] mptcp: reset subflow when MP_FAIL doesn't
respond (Geliang Tang)
        - [4290672895ad] selftests: mptcp: check MP_FAIL response mibs
(Geliang Tang)
        - [23b3ec49da2e] selftests: mptcp: print extra msg in
chk_csum_nr (Geliang Tang):
            - should be ready to be sent

        - [09111a7b0d5c] selftests: mptcp: add MP_FAIL reset testcase
(Geliang Tang):
            - should not be sent now, see issue #216

        - [d861be179883] mptcp: Remove redundant assignments in path
manager init (Mat Martineau)
        - [506c899cf98f] mptcp: Add a member to mptcp_pm_data to track
kernel vs userspace mode (Mat Martineau)
        - [76f92b530486] mptcp: Bypass kernel PM when userspace PM is
enabled (Mat Martineau)
        - [96877f49e1cb] mptcp: Make kernel path manager check for
userspace-managed sockets (Mat Martineau)
        - [790633a009f7] mptcp: Add a per-namespace sysctl to set the
default path manager type (Mat Martineau)
        - [5bbe11f3898c] selftests: mptcp: Add tests for userspace PM
type (Mat Martineau)
        - [15ae863bfd5f] mptcp: bypass in-kernel PM restrictions for
non-kernel PMs (Kishen Maloor)
        - [6abe4bf556c6] selftests: mptcp: ADD_ADDR echo test with
missing userspace daemon (Mat Martineau)
        - [126b2cf115a7] mptcp: store remote id from MP_JOIN SYN/ACK in
local ctx (Kishen Maloor)
        - [b6925cbc2b85] mptcp: reflect remote port (not 0) in ANNOUNCED
events (Kishen Maloor)
        - [7f070a4c8231] mptcp: establish subflows from either end of
connection (Kishen Maloor)
        - [07a19f32b997] mptcp: expose server_side attribute in MPTCP
netlink events (Kishen Maloor):
            - should be ready to be sent
            - but can also wait one more week with all the other patches
to send


    - Features for other trees:

        - [6882309100fb] bpf: expose is_mptcp flag to bpf_tcp_sock
(Nicolas Rybowski)
        - [ab8ede2ea0e0] bpf: add bpf_skc_to_mptcp_sock_proto (Geliang Tang)
        - [b7c917206877] selftests: bpf: add MPTCP test base (Nicolas
Rybowski)
        - [50c21414bc45] selftests: bpf: test bpf_skc_to_mptcp_sock
(Geliang Tang)
        - [702470d95ff8] selftests: bpf: verify token of struct
mptcp_sock (Geliang Tang)
        - [9e3a90336df9] selftests: bpf: verify ca_name of struct
mptcp_sock (Geliang Tang)
        - [a37a7265d1eb] selftests: bpf: verify first of struct
mptcp_sock (Geliang Tang):
            - should be ready to be sent
            - there is still Nicolas email address that is returning an
error for the moment: maybe best to create a redirection to Matth's
address → TODO Matth → Done



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - issue with Syzkaller update but fixed now (reinstalled)
        - didn't find anything new (and not so much other stuff, maybe
config issue?)
        - syzkaller coverage:
            - Christoph originally added more coverage around the
Netlink PM interface
            - but the interface has been updated and will change again
with the new userspace PM
            - Mat will look at improving the coverage

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - keep running but not validating the export-net branch
        - config for export-net has been merged but Mat will check why
it is not working as expected.
        - A single failure with simult_flows.sh, doesn't appear significant

            - unbalanced bwidth with unbalanced delay
  transfer slower than expected! runtime 4091 ms, expected 4005 ms max
4005        [ fail ]


    - packetdrill (Davide):
        - Davide is looking at the recently reverter PR (MP_PRIO):
            - MPJ is not emitted with IPv6
            - Davide is checking if it is a routing issue or something else

    - Patchew (Davide):
        - small outage recently but working again now

    - CI (Matth):
        - some timeout with Kishen's patches: maybe because of the time?
Maybe more activity on the CI servers at that time?:
            - it seems the last one was due to an issue with the
selftests with a debug kconfig:
                https://cirrus-ci.com/task/6028932108517376?logs=test#L8496



mptcpd:
    - 0.9 version now in Debian \o/:
        - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1005012
        - https://packages.debian.org/sid/mptcpd
        - https://tracker.debian.org/pkg/mptcpd
    - Soon in Ubuntu: → Done
        - https://bugs.launchpad.net/ubuntu/+bug/1968075
        - https://launchpad.net/ubuntu/+source/mptcpd (you can subscribe
to bug reports and questions)



ELL and MPTCPD on Fedora 36:
    - Mat had issues building them on Fedora 36:
        - ell has an issue with OpenSSL 3:
            - only in maintainer mode with the selftests
            - there is a fix for that but not working on Fedora 36
        - for MPTCPD: a fix in the header needed:
            - https://github.com/intel/mptcpd/pull/226



Next meeting:
    - Next one on Thursday, the 14th of April.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220414



Feel free to comment on these points and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
