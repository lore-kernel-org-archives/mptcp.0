Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E909A38
	for <mptcp@lists.linux.dev>; Thu,  1 Sep 2022 14:40:47 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id u9so35181140ejy.5
        for <mptcp@lists.linux.dev>; Thu, 01 Sep 2022 07:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=OPetxa9TOIY0Sn8AIzZ0VqpkBysxtusjpqMFB0luLeY=;
        b=JTdZ9WsoDEdVc45dJVelNhO+z3ScHz529OCbqe0Bajg2wwCw7ulOYGii+bLkx7TDDQ
         frbVJDnmz/zqd7oRrxSc0SLe/mQ4P2+anUV15uE4L0Rw98rWTQtyK34O1zjEPIwK3wnL
         +lsvR5ziaDhyfjKQROze6cDIUZR6Bu+GA+KvfMp0CDIGzZCA0RGtfWyahUcAEBlfky1R
         8ag2rLb4J+m13IOoWqyEWqOOd+gJhECEAMdiQnw+klxm6W7P1/MP0IFImizaz2GvdB53
         +lYEBTJxrmVda5ihqiIt9QuYrs+KOlkOrjAFrbfFS7km8/pU91/cj2qk5wPcX1DvoN6D
         AQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=OPetxa9TOIY0Sn8AIzZ0VqpkBysxtusjpqMFB0luLeY=;
        b=mzQ8z5xV8zLQTj+ubC41z0n7xweoInXSs2XWGyGZZFhkc4rHkxFj57qkjNAQiANAN/
         bTxHItHLda7jiP7hQmhGERJRuuXliTCGGgntgLhjWIjWYz8wcHBdg/Em8rh0H+T2Lr2Z
         FJEfeoPY3bPelD+IzxAyud0UmKo1YQxeRjZR6hIeQRldEusMGGjDBVi5IAHhfRmPBmkV
         pZd8CTSWRBlL0F9hheCv8f27p/BnSr99uAzSP3t75aZJ5sCDemMmBcRMcrEQ1rE2DDeO
         bbErfI2D8FG+j7FAMZYj4xdVlocZ7o/GjVbGs2/GCdI/osyUsAyAnwzcAPJQ2fHe7OUW
         Ir6w==
X-Gm-Message-State: ACgBeo0uQ4mWU3OebiVzvDxPJ9nbjd6PKI7xCJ+eFIBwzm25SChgcxA7
	+TkuLA64sjLQGHizeNQLN8+kLCjqLum1PA==
X-Google-Smtp-Source: AA6agR5l+NRNzcekD1AoyiL98b04li1u0Xnw3yLnr0MpX14rtUhdWHfLZXNrjvjxCZtZ05+rjgezBA==
X-Received: by 2002:a17:906:d54e:b0:73d:dcb2:39ac with SMTP id cr14-20020a170906d54e00b0073ddcb239acmr21571598ejc.520.1662043244965;
        Thu, 01 Sep 2022 07:40:44 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6af0:84ce:9f4e:2025? ([2a02:578:8593:1200:6af0:84ce:9f4e:2025])
        by smtp.gmail.com with ESMTPSA id ez20-20020a056402451400b00446ad774ea0sm1453782edb.7.2022.09.01.07.40.44
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 07:40:44 -0700 (PDT)
Message-ID: <5c4d1628-f6f8-7984-f978-deb07cb4eb88@tessares.net>
Date: Thu, 1 Sep 2022 16:40:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 25th of August 2022
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 206th meeting with Paolo, Davide (Redhat), and
myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: /):

/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Dmytro SHYTYI, Florian Westphal, Geliang Tang, Jakub
Kicinski, Jason Wang, Jiapeng Chong, Matthieu Baerts, Paolo Abeni):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
12321111: mptcp: Remove redundant assignment to remaining:
      - State: RFC

12901431: [mptcp-next,v10,1/5] Squash to "mptcp: add get_subflow wrappers"
12901432: [mptcp-next,v10,2/5] mptcp: redundant subflows push pending
12901433: [mptcp-next,v10,3/5] mptcp: redundant subflows retrans support
12901434: [mptcp-next,v10,4/5] selftests/bpf: Add bpf_red scheduler
12901435: [mptcp-next,v10,5/5] selftests/bpf: Add bpf_red test:
      - State: Changes requested
      - Series: BPF redundant scheduler
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=655328&state=*&archive=both
      - Same as last week

12922458: mptcp: Fix comment typo:
      - State: Changes requested
      - Series: mptcp: Fix comment typo
      - Submitter: Jason Wang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=661054&state=*&archive=both
      - Same as last week

12933347: [RFC,mptcp-next,v4] mptcp: Fast Open Mechanism:
      - State: RFC
      - Submitter: Dmytro SHYTYI
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220801024656.397714-1-dmytro@shytyi.net/
      - Same as last week

12947468: [RFC] net: tcp: prevent transition to FIN_WAIT2 when mptcp has
unacked data_fin:
      - State: Change Requested
      - Submitter: Florian Westphal
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220818162123.30198-1-fw@strlen.de/
      - Discussions are ongoing:
          - are we going to delay the transition to FIN_WAIT2 (→
timewait) for too many sockets
          - it looks like only a small part would be delayed, so should
be OK
          - Paolo will check that

12952040: [mptcp-next] mptcp: add do_check_data_fin to replace copied:
      - State: Queued
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/95f0f96d90264cc6411b024753fe8430f6998e4f.1661258990.git.geliang.tang@suse.com/
      - Looks good, can be applied → Done

12953299: [mptcp-next,1/2] Squash-to: "mptcp: move msk input path under
full msk socket lock"
12953300: [mptcp-next,2/2] mptcp: never re-inject data on a single subflow:
      - State: Rejected? yes
      - Series: mptcp: rx path refactor follow-ups
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=670614&state=*&archive=both
      - These two patches show some issues:
          - more refactoring seems to be needed and it seems complex
          - probably best to address the original bug with the smaller
patch (see below)
      - Solution:
          - we don't apply these two patches
          - we revert the 4 patches from our tree

12954112: [net-next] genetlink: start to validate reserved header bytes:
      - State: Handled elsewhere
      - Submitter: Jakub Kicinski
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220825001830.1911524-1-kuba@kernel.org/
      - Looks OK

12954562: [mptcp-net] mptcp: fix fwd memory accounting on coalesce:
      - State: New
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/e07e982885b904607d42e1e45840c4eb3c124d4b.1661426770.git.pabeni@redhat.com/
      - We avoid the issue by calling kfree_skb_partial() later which
modifies counters (in an atomic way)
      - TODO Matth: apply → done




Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 294)

  295  mptcpize, rsyncd & connection tear down (hangs)? [bug]:
      - TODO: Matth: check to reproduce the issue → Paolo was faster


New:
    - To open: use IP_TTL socktopt (+v6 version):
        - best to do it on all subflows by default
        - if needed, a BPF program could change the TTL value per subflow
    - TODO Matth: open → done



    Bugs (opened, flagged as "bug" and assigned)

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug] @fw-strlen:
      - See patch above


    Bugs (opened and flagged as "bug" and not assigned)

  295  mptcpize, rsyncd & connection tear down (hangs)? [bug]
  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]
  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]


    In Progress (opened, new feature and assigned)

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

  293  fail to create a subflow when a listen socket is closed [question]:
      - another solution is not to close the listening socket
      - why closing the socket?:
          - save resources?
          - Best to ask
      - maybe we can have an MPTCP specific sockopt to 0 the backlog (or
another possibility to do it?)
      - one problem we can have if we want to close the listening socket:
          - we could not accept new subflows sent to the initial IP if
we have to close then re-open
      - → TODO: Matth: update ticket → done


    For later (opened and not assigned assigned)

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

  285  PM: in-kernel: support for MPC prio exchange  [enhancement] @pabeni



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.1):
https://github.com/multipath-tcp/mptcp_net-next/projects/16
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - Fixes for other trees:

        - [42f81832db6b] module: kunit: Load .kunit_test_suites section
when CONFIG_KUNIT=m (David Gow):
            - in another tree
            - TODO: Matth: check if it is applied in Linus' tree → yes it is

    - Fixes for -net: /

    - Fixes for net-next: /

    - Features for net-next:

        - [94b4b697c713] mptcp: add mptcp_for_each_subflow_safe helper
(Matthieu Baerts):
            - can be sent → TODO

        - [2690e8cca6bb] mptcp: move RCVPRUNE event later (Paolo Abeni)
        - [dd77c4b18f06] mptcp: more accurate receive buffer updates
(Paolo Abeni)
        - [0f0ab98e16a4] mptcp: move msk input path under full msk
socket lock (Paolo Abeni)
        - [f481943b88c8] mptcp: use common helper for rmem memory
accounting (Paolo Abeni):
            - TODO: Matth: Remove → Done

        - [1b447c139aa8] selftests: mptcp: move prefix tests of
addr_nr_ns2 together (Geliang Tang)
        - [2bfaf90f9579] mptcp: allow privileged operations from user
namespaces (Thomas Haller)
        - [42bea5699c66] mptcp: account memory allocation in
mptcp_nl_cmd_add_addr() to user (Thomas Haller):
            - these 3 can be sent as well → TODO


    - Features for net-next (next): /


    - Features for other trees:

        - [ab8b0fa282e9] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [117b8c62a6fe] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [0e478a4eea7e] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [45003f8025a5] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [460624a0ad0c] mptcp: add get_subflow wrappers (Geliang Tang)
        - [9e85cdd959a3] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [c275dd7cd866] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [0cce4245b5d0] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [ff705ffb482b] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [1a5782501bf9] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [98e864cbbfe4] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [9b05565b7417] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [924b7ce05c79] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [13bf0dc9c9bd] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - some patches are pending in review, we can wait


Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - /

    - news about interop with mptcp.org/other stacks? (Christoph):
        - Christoph is doing some modifications to ease the transition
from mptcp.org to upstream (MPTCP_INFO support)

    - news about Intel's kbuild? (Mat):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - new code has changed quite a lot, we need to re-do the
modifications we did
        - TODO: Matth: find the name of the other project to apply
patches from a mailing list in Git → I didn't find it but probably best
to use Patchwork for that (we want to send results there anyway):
           https://github.com/kuba-moo/nipa/blob/master/pw_poller.py

    - CI (Matth):
        - /



mptcpd 0.11:
    - New release:
        - https://github.com/intel/mptcpd/releases/tag/v0.11
        - Support for the user space MPTCP path management generic
netlink API in the upstream Linux 5.19 kernel was implemented
        - Propagate the "server side" flag to new_connection and
connection_established plugin operations
        - Support a new fullmesh address flag in the mptcpd
configuration file and command line addr-flags configuration option for
the in-kernel path manager
        - Allow the mptcpd network monitor unit test to pass if it
detects an active interface without any IPv4 or v6 addresses
        - Fix memory leaks that occurred when parsing the addr-flags and
notify-flags entries in the mptcpd configuration file
        - Fix a use-after-free memory error in the mptcpd load-plugins
configuration code
        - Improved the underlying mptcpd ID manager hash algorithm by
replacing the existing trivial hash with the MurmurHash3 algorithm.

    - Matth will check to update it in Debian / Ubuntu

    - (and ask to have the 0.10 available in Ubuntu 22.04 and maybe the
0.11 in the backports)



Next meeting:
    - Next one on Thursday, the 1st of September.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220901



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
