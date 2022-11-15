Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A67E24F29
	for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 17:42:41 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id v1so25511127wrt.11
        for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 09:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCpp4cpMoEOj3WFQTwfvzTQT4zwuPcnQpMW0glXlzKE=;
        b=GQM4fzk3RbZGx5J2TrnZ+/e66ghxu2tJIr35lufmlBAQ+5AEwQViwn4NVfxoU6rvaV
         YHFLrrcdub5xALi0GHtpUe8n5zcd8lk/rzZojx+qh4TNlErElgdqid/1Zls+kaInte3N
         hErMa+PgCy5TvybKOAj8fsn7MylThRDvyZ/hOyE7pptr0g+wrbbsgfVGyqQ00yKDq4KS
         6GiDDq06F0uCpDK20Jk6ujSlJgZgHzDBNH6LUwfTfzRq2A6KlzmXNUpsEgPFrf9Y4lcN
         xFmyY0AQwxYMC8Aknp8tytVIqxJ3nyGJuAekTShijWQR3RsxmY4kb/YQ9EoZOZIDixYe
         hmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eCpp4cpMoEOj3WFQTwfvzTQT4zwuPcnQpMW0glXlzKE=;
        b=4sJX06pBSD95FndVy3WA08LHAwrFzCE7JDF1aNq+t0rJJ4wd6b0OkcXGeaeIEJrt3m
         WXas4l2MhiLZLGTJ4E+4fhU/vqPJE8c1kAh3gKTUqIzot6gbcjiyM81teU5IwgGEQH5V
         KgsHb2U40PjFgOkdk+26OQE4hEcSaMWWJUkl8V8Ywc2KF+jYB/BvkoF14qZpn+LcX0ey
         o65eZRvsQHGSFCfk0UDYDevPNmpoZoib5ZGj00+vIhLwlBEkWQMMksWCOSrWfqKtRdXV
         vdqBKrhmJHLcMuxpL9dOPKAayFSAWPg+0b7u/BMXvMVjSBwlDo/xkK7/WuLcQrQyWnzR
         uU+A==
X-Gm-Message-State: ANoB5plFBTyKGxXHPhIxt3iJnoLfvsOAzUcYRD5tU6ZkT5eo4g7P9MXC
	MdFqqbaf0z7mXCTOI+UC22nmOnnVbiS8uQ==
X-Google-Smtp-Source: AA0mqf5cTVYdDTzOGcF8+jGBesvWhFQeZm/rcxjqews/JfVmq9oowCqAoUqyIlLVOMwKMfMeYXzgsA==
X-Received: by 2002:adf:a283:0:b0:236:4b06:bbb1 with SMTP id s3-20020adfa283000000b002364b06bbb1mr11396752wra.303.1668534158877;
        Tue, 15 Nov 2022 09:42:38 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:765b:95ed:f124:a78a? ([2a02:578:8593:1200:765b:95ed:f124:a78a])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c1c0700b003cf71b1f66csm17961386wms.0.2022.11.15.09.42.38
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 09:42:38 -0800 (PST)
Message-ID: <1938ef74-4f38-e1a7-c27e-bc47398a997d@tessares.net>
Date: Tue, 15 Nov 2022 18:42:37 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 10th of November 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 216th meeting with Mat, Ossama (Intel), Paolo,
Davide (Redhat), Dmytro () and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Mat Martineau):

13015971: [mptcp-next] selftests: mptcp: use max_time instead of time:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221022133528.31996-1-geliang.tang@suse.com/

13027471: [mptcp-next] mptcp: Fix grammar in a comment:
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221101205538.13892-1-mathew.j.martineau@linux.intel.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Benjamin Hesmans, Dmytro Shytyi, Geliang Tang, Jiapeng
Chong, Matthieu Baerts, Menglong Dong, Paolo Abeni):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
12321111: mptcp: Remove redundant assignment to remaining
12970164: [RFC,mptcp-next,05/10] mptcp: delay mptcp data_ack calculation
12970163: [RFC,mptcp-next,06/10] mptcp: allow delayed data_ack calculation
12970165: [RFC,mptcp-next,07/10] mptcp: TFO receive: bypass mapping check
12970166: [RFC,mptcp-next,08/10] mptcp: allow data that can not be
DATA_ACKed
12970167: [RFC,mptcp-next,09/10] mptcp: force data_ready
12970168: [RFC,mptcp-next,10/10] mptcp: test TFO
13007315: [RFC] selftests: mptcp: set test-case parameters consistently:
      - Status: same as last week

13012120: [mptcp-net,1/4] selftests: mptcp: run mptcp_sockopt from a new
netns
13012121: [mptcp-next,2/4] selftests: mptcp: run mptcp_inq from a clean
netns
13012122: [mptcp-next,3/4] selftests: mptcp: removed defined but unused vars
13012123: [mptcp-next,4/4] selftests: mptcp: uniform 'rndh' variable:
      - State: Queued
      - Series: mptcp: run mptcp_sockopt from a new netns + cleanup
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=686816&state=*&archive=both
      - status is the same as last week: 5th patch needed

13020452: [mptcp-next,v2,2/2] mptcp: add pm listener events:
      - State: Changes requested
      - Series: add pm listener events
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=688998&state=*&archive=both
      - status is the same as last week
      - linked to ↓

13031672: [mptcp-net,v3] mptcp: use entry->lsk directly:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221104115354.3413-1-geliang.tang@suse.com/
      - seems not OK according to the CI
      - not a fix, more a cleanup
      - Mat gave some ideas to improve that

13020538: [mptcp-next] selftests: mptcp: update userspace pm tests:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221026124114.24816-1-geliang.tang@suse.com/
      - linked to ↑
      - more coverage needed
      - status is the same as last week

13029900: [mptcp-next,v6,1/4] mptcp: introduce 'sk' to replace
'sock->sk' in mptcp_listen()
13029901: [mptcp-next,v6,2/4] mptcp: add statistics for mptcp socket in use
13029902: [mptcp-next,v6,3/4] selftest: mptcp: exit from
copyfd_io_poll() when receive SIGUSR1
13029903: [mptcp-next,v6,4/4] selftest: mptcp: add test for mptcp socket
in use:
      - State: Changes requested
      - Series: mptcp: add statistics for mptcp socket in use
      - Submitter: Menglong Dong
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=691610&state=*&archive=both
      - status is the same as last week: v7 expected

13032474: [mptcp-next,1/2] mptcp: deduplicate error paths on endpoint
creation
13032475: [mptcp-next,2/2] mptcp: more detailed error reporting on
endpoint creation:
      - State: Queued
      - Series: [mptcp-next,1/2] mptcp: deduplicate error paths on
endpoint creation
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=692242&state=*&archive=both
      - to be applied → Done

13033434: [RFC,mptcp-next,v15,1/5] mptcp: introduce MSG_FASTOPEN flag
13033432: [RFC,mptcp-next,v15,2/5] mptcp: implement delayed seq
generation for passive fastopen
13033433: [RFC,mptcp-next,v15,3/5] mptcp: add subflow_v(4,6)_send_synack()
13033431: [RFC,mptcp-next,v15,4/5] mptcp: add TCP_FASTOPEN sock option
13033435: [RFC,mptcp-next,v15,5/5] selftests: mptcp: mptfo
Initiator/Listener:
      - State: Queued
      - Series: mptcp: Fast Open Mechanism
      - Submitter: Dmytro Shytyi
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=692491&state=*&archive=both
      - to be applied → Done
      -    with the patches below

13037633: [mptcp-next,1.5/5] mptcp: track accuratelly the incoming MPC
suboption type.:
      - State: Queued
      - Series: [net-next] Squash-to: "mptcp: implement delayed seq
generation for passive fastopen"
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=693684&state=*&archive=both
13037631: [net-next] Squash-to: "mptcp: implement delayed seq generation
for passive fastopen":
      - State: Queued
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/0c2a587290902feb0c3c0a2f5c7f04e788d63751.1667993471.git.pabeni@redhat.com/
13037632: [net-next] Squash-to: "selftests: mptcp: mptfo
Initiator/Listener":
      - State: Queued
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/41b40e837c47147ce713ae0d35a916471d36f82d.1667993466.git.pabeni@redhat.com/
      - to be applied → Done
      - more squash-to patch to come
      - will be applied in net-next-next: because we know more squash-to
patches are coming, we might want to insert other patches before and
send them to netdev ML before this WIP series
      - it doesn't mean we don't want them in the "current" net-next
      - there is a PR in packetdrill → @Matth: to reply

13036032: [mptcp-next,v18,01/15] mptcp: refactor push_pending logic
13036033: [mptcp-next,v18,02/15] mptcp: drop last_snd and
MPTCP_RESET_SCHEDULER
13036034: [mptcp-next,v18,03/15] mptcp: add sched_data_set_contexts helper
13036035: [mptcp-next,v18,04/15] Squash to "mptcp: add struct
mptcp_sched_ops"
13036036: [mptcp-next,v18,05/15] Squash to "bpf: Add bpf_mptcp_sched_ops"
13036037: [mptcp-next,v18,06/15] Squash to "bpf: Add
bpf_mptcp_sched_kfunc_set"
13036038: [mptcp-next,v18,07/15] Squash to "selftests/bpf: Add bpf_first
scheduler"
13036039: [mptcp-next,v18,08/15] Squash to "selftests/bpf: Add bpf_bkup
scheduler"
13036040: [mptcp-next,v18,09/15] Squash to "selftests/bpf: Add bpf_rr
scheduler"
13036041: [mptcp-next,v18,10/15] mptcp: use get_send wrapper
13036042: [mptcp-next,v18,11/15] mptcp: use get_retrans wrapper
13036043: [mptcp-next,v18,12/15] mptcp: delay updating first_pending
13036044: [mptcp-next,v18,13/15] mptcp: delay updating already_sent
13036045: [mptcp-next,v18,14/15] selftests/bpf: Add bpf_red scheduler
13036046: [mptcp-next,v18,15/15] selftests/bpf: Add bpf_red test:
      - State: Changes requested
      - Series: BPF redundant scheduler
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=693135&state=*&archive=both
      - Mat will have a look at the v18
      - It would be good to have them in the tree, maybe only in the BPF
part (other trees)



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 314):
        /



    Bugs (opened, flagged as "bug" and assigned)

None.


    Bugs (opened and flagged as "bug" and not assigned)

  310  selftests: `simult_flows`: transfer slower than expected! [bug]
[selftests]:
      - Matt just sent a patch to fix that → Done

  299  several kernel warnings about mptcp [bug]:
      - Close it next week if there is no more activity → done

  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]


    In Progress (opened, new feature and assigned)

  313  Add netlink events for listening socket create/close
[enhancement] @geliangtang:
      - See patches above

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
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

  307  TCP performance better than MPTCP [question] @matttbe:
      - new comment saying there is nothing else to share so far


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

  312  packetdrill: `add_addr` test is regularly failing: packets
arriving before the expected time [bug] [packetdrill] @matttbe
  294  Clear way for userspace to know if the connection fell back to
TCP [enhancement] @matttbe



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.2):
https://github.com/multipath-tcp/mptcp_net-next/projects/17
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [972cb23d653b] selftests: mptcp: gives slow test-case more
time (Paolo Abeni):
            - we can wait to send some that are pending in review (or to
be applied)

    - Fixes for net-next: /


    - Features for net-next:

        - [7fb65df750bb] mptcp: use msk instead of mptcp_sk (Geliang Tang)
        - [ad6d5b2d4858] mptcp: change 'first' as a parameter (Geliang Tang)
        - [d8a3e68f9783] mptcp: get sk from msk directly (Geliang Tang)
        - [56a5bfd9959b] selftests: mptcp: use max_time instead of time
(Geliang Tang)
        - [7a0933a810f0] mptcp: Fix grammar in a comment (Mat Martineau):
            - can be sent → done
            - more small ones are coming but some depends on patches
that will be queued for -net so maybe best to already send what we have
(rc4)

    - Features for net-next (next): /

    - Features for other trees:

        - [87266874feeb] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [a82a5b44ee54] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [3e3b02adaf30] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [04cc73b9944a] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [1a9ea9d1fc67] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [8b0a07a93bce] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [c10eaf99cb1c] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [fae398a8318f] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [6ced674a077a] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [f365b251791e] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [951f10167164] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [f7d7c0b916b8] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [e011ce479adf] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - status is the same as last week: we wait



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - anything MPTCP related

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - some problems but probably not related to MPTCP: last
selftests status cannot be seen
        - the last selftests were passing

    - packetdrill (Davide):
        - There is a bug in Packetdrill when using big endian:
            - Davide is looking at that
        - One PR related to TFO:
            - Matth will look at that

    - Patchew (Davide):
        - /

    - CI (Matth):
        - seems more stable
        - less global timeout issues
        - one issue today with (again) ADD_ADDR:
            -
https://api.cirrus-ci.com/v1/artifact/task/6238594078605312/summary/summary.txt



MPTCP in Net package in Go:
    - https://github.com/golang/go/issues/56539
    - the community suggested the idea to use MPTCP by default if
available when asking to create 'tcp' sockets
    - note that there might be an impact also on the server side to
create MPTCP sockets: more locks, etc.:
        - Paolo did some tests a while ago and the impact is not really big
        - but he didn't re-do these tests recently
    - would be really good to have more users, more coverage, etc. (but
more reported bugs? :) )



mptcpd:
    - a new release for mptcpd is expected soon
    - it would be good to "move" mptcpd under "multipath-tcp":
        - https://github.com/multipath-tcp/mptcpd
        - probably good to do that when the 1.0 will be released
        - Matth can do the sync manually if needed
        - Also possible to create a 0.x and just after a 1.0 when we
switched to multipath-tcp organisation



MPTCP on Fediverse/Mastodon:
    - Follow us on: https://social.kernel.org/mptcp



Next meeting:
    - Next one on Thursday, the 17th of November.
    - 16:00 UTC (8am PST, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20221117



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
