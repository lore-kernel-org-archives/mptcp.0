Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942B70
	for <mptcp@lists.linux.dev>; Fri,  4 Jun 2021 09:03:45 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id g18so8277005edq.8
        for <mptcp@lists.linux.dev>; Fri, 04 Jun 2021 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=QJKKixqccCtdIjry/MEeEjahqFApvyCpXJ07csb9Lxs=;
        b=E2rKAkgoKDzqW5G3DLUPS2SC8A4QLyuwYC2t+6HQ05cU/OPKjSV410QRpHfQfpUeKV
         EGffVmVH+0IbA6iacU0AwIw+8RWqQ5hE2WfjdRv576XLiJztOhelarmAdyjMX8WqafdN
         1yE7gP7cmq7b3fhUGx8wlzeFhx2YzFhe8OA8pXYtvcrJLNZbp3MJF6PSfGOOYz3YWR2C
         e10UkLLs2eTWLzCOJJdVmANFAnWSborSDMQPcL+9f1SjAPNJkYwly2FfRINb9Zi0OSnO
         /ZEFcW+Qre+bd68KpdG+pCp8iqjmiJ068mOCpq0CREDmPfcyqHwOhnfVD8J+7HpEpR5F
         UJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=QJKKixqccCtdIjry/MEeEjahqFApvyCpXJ07csb9Lxs=;
        b=aMZfC//yM3d/hSpPo6mom0cFZ7U5nHZ6CaXAajnT5pywNl4Z9g//BCKadl/tzkM1Eg
         3faWXJp/jNeUkgnh9dP/ezaWGnhAHnCUm+/OXTUfB1T109cPcFG8A+S/iM9VQpdPDcnc
         aJg2uCYFXJmuXmO01+Y63l6XbV2zU0iIEXuXYVTQg5Lh3UAxTze7dyXd4aRSWhdXIaYF
         4netuX//o9zWRfIDPx0Z72LwYr/cBxDSVZFGFkond40zTu0fYtfEimaJT/crLYpkgReu
         0rvji69zGdfBViDJgeLIZKbeO+l/cnkBDSmnE/aP7XZ85xLvQOfMkD7iMQICl31BlpyK
         N+jQ==
X-Gm-Message-State: AOAM5328iUCK7DKKE4RMPFNYbQpLanTS00hxEzTSkKfFSEP6xcepPRSI
	8B21q6LfjL/K4+IBq3UL9iV5DUv7WMl6L9oR
X-Google-Smtp-Source: ABdhPJwPLvgxo5p/69aSsdJiGqabFvP0SsPcWmcf/To/NNIqQeLBLS+7Y5KlDsjvMx8mdpsEhaZcxg==
X-Received: by 2002:aa7:d801:: with SMTP id v1mr3619692edq.349.1622797423507;
        Fri, 04 Jun 2021 02:03:43 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:c047:d46c:d45:3868])
        by smtp.gmail.com with ESMTPSA id d17sm2502036ejp.90.2021.06.04.02.03.42
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 02:03:43 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 27th of May 2021
Message-ID: <4167b09d-be89-ad5c-c4ed-f273a2b6a8ba@tessares.net>
Date: Fri, 4 Jun 2021 11:03:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hello everyone,

Last week, we had our 150th meeting with Mat (Intel), Florian, Paolo and
Davide (RedHat), Geliang (Xiaomi) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3

    netdev (if mptcp ML is in cc) (Mat (sent to the old ML :) )):

  - [net,1/4] mptcp: avoid OOB access in setsockopt()
    https://git.kernel.org/netdev/net/c/20b5759f21cf
  - [net,2/4] mptcp: drop unconditional pr_warn on bad opt
    https://git.kernel.org/netdev/net/c/3812ce895047
  - [net,3/4] mptcp: avoid error message on infinite mapping
    https://git.kernel.org/netdev/net/c/3ed0a585bfad
  - [net,4/4] mptcp: validate 'id' when stopping the ADD_ADDR retransmit
timer
    https://git.kernel.org/netdev/net/c/d58300c3185b


    our repo (by: Davide Caratti, Paolo Abeni):

12270705  [v3,mptcp-net,3/3] mptcp: update selftest for fallback due to OoO
12270707  [v3,mptcp-net,2/3] mptcp: do not reset MP_CAPABLE subflow on
mapping ...
12270709  [v3,mptcp-net,1/3] mptcp: always parse mptcp options for MPC
reqsk

12270323  [mptcp-net] Squash-to: "mptcp: fix sk_forward_memory
corruption under...

12265279  [net] mptcp: validate 'id' when stopping the ADD_ADDR
retransmit timer

12265221  [mptcp-net] mptcp: avoid error message on infinite mapping
12265219  [mptcp-net] mptcp: drop unconditional pr_warn on bad opt



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*

    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

12263877: Awaiting Upstream: [mptcp-next] Squash to "mptcp: generate the
data checksum":
    - TODO: Matth: to apply → Done

12278269: Needs ACK: [v8,mptcp-next,1/4] mptcp: add sysctl
allow_join_initial_addr_port
12278271: Needs ACK: [v8,mptcp-next,2/4] mptcp: add allow_join_id0 in
mptcp_out_options
12278273: Needs ACK: [v8,mptcp-next,3/4] mptcp: add deny_join_id0 in
mptcp_options_received
12278275: Needs ACK: [v8,mptcp-next,4/4] selftests: mptcp: add
deny_join_id0 testcases:
    - Paolo will have a look (linked to last week's discussion)

12279735: Changes Requested: [RFC,1/4] mptcp: wake-up readers only for
in sequence data.
12279737: Changes Requested: [RFC,2/4] mptcp: don't clear
MPTCP_DATA_READY in sk_wait_event()
12279739: Changes Requested: [RFC,3/4] mptcp: move the whole rx path
under msk socket lock protection
12279741: Changes Requested: [RFC,4/4] mptcp: cleanup mem accounting.:
    - clean-up a lot of code and remove a lot of complexity linked to
implementation choices
    - it can have some perf impact

    - Paolo started some tests:
        - the clean-up doesn't have a big impact but depending  on the
technique used by the userspace, the modification can be visible
(degradation, around 10/15%)
        - impact seems to be due to synchronisation
        - impact can be more if more sync is needed

    - maybe focus the clean-up only in receive path with SKB (...)

    - problem for the moment:
        - we book memory in advance (maybe too much in some scenarios
("scenarii"): mem presure earlier, etc.)
        - to avoid acquiring multiple time the MPTCP spinlock
        - cleaning up that would avoiding issues like recent ones that
are difficult to debug and fix
        - it looks like it's worth continuing looking at that but maybe
not like with the current version of these RFC patches

12282131: New: [v3,mptcp-next] mptcp: drop tx skb cache:
    - Can be applied
    - Improve perf
    - Matth: To apply

12282133: Queued: [mptcp-net] mptcp: let warn_bad_map report relevant
values:
    - Can be applied
    - Matth: To apply

12282211: Changes Requested: [mptcp-net] tcp: ensure that backlog
coalescing don't break MPTCP DSS:
    - Can be dropped
    - Coalescing is done only if options are already the same → no
corruption

12282215: Changes Requested: [mptcp-next] mptcp: use fast lock for
subflows when possible.:
    - a few more fast lock are possible
    - Paolo will send them in a v2

12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to
tcp.h/mptcp.h
12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in
reset packets:
    - Resent to have them on patchwork.kernel.org
    - WIP

12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
    - Resent to have them on patchwork.kernel.org
    - WIP

12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp
stack
12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes
socket with unread data:
    - Resent to have them on patchwork.kernel.org
    - WIP

12282229: Changes Requested: [RESEND,mptcp-next,1/3] mptcp: MP_FAIL
suboption sending
12282231: Changes Requested: [RESEND,mptcp-next,2/3] mptcp: MP_FAIL
suboption receiving
12282233: Changes Requested: [RESEND,mptcp-next,3/3] mptcp: send out
MP_FAIL when data checksum fail:
    - Resent to have them on patchwork.kernel.org
    - Geliang is working on a v2

12282235: Queued: [mptcp-net] mptcp: try harder to borrow memory from
subflow under pressure:
    - Can be applied
    - Matth: To apply




Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 195)

  196  warn_bad_map on 5.12.0 [bug] @pabeni:
      - Patches already sent:
          - mptcp: let warn_bad_map report relevant values
          - tcp: ensure that backlog coalescing don't break MPTCP DSS →
but not needed

      - the report contains interesting info about fallback and
retransmissions:
          - interesting to look at that:
              - seems that more work on retransmissions is needed
(retransmission is too much and too often)
              - we pick "randomly" a subflow to get the RTT but that's
not ideal if you have different networks
          - the number of fallback is quite important but maybe due to
the setup/experimentations (e.g. MPTCP used with many random servers on
the Internet)


    Bugs (opened, flagged as "bug" and assigned)

  196  warn_bad_map on 5.12.0 [bug] @pabeni:
      - see above

  191  Could you please let me know how to use "ip mptcp end points
backup"? [bug] [question] @matttbe:
      - is it maybe due to the fact that backup flag was not taking into
account?
      → Matth: TODO check → Done


    Bugs (opened and flagged as "bug" and not assigned)

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]
  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug]
  120  [interop] netnext is dropping packets, causing MPTCP-level
retransmissions on mptcp.org [bug]
  107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
   65  clearing properly the status in listen() [bug]
   56  msk connection state set without msk lock [bug]


    In Progress (opened and assigned)

  194  Round-robin packet scheduler support [enhancement] @geliangtang
  193  Fullmesh path manager support [enhancement] @geliangtang

  189  Wireshark / TCPDump doesn't understand option subtype 8
(MP_TCPRST) [enhancement] @dcaratti:
      - merged in Wireshark
      - pending in TCPDump

  188  Netlink events for MP_TCPRST [enhancement] @dcaratti
  187  add recvmsg support for ancillary data [enhancement] @fw-strlen
  186  Add netlink command support [enhancement] @mjmartineau

  183  MP_CAPABLE 'C' flag is ignored [enhancement] @geliangtang:
      - see patches above

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti
   96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
   52  MP_FAIL support [enhancement] @geliangtang


    Recently closed (since last week)

  195  WARNING in sk_stream_kill_queues and inet_sock_destruct [bug]
@pabeni
  192  selftests: connect: "poll timed out" issue [bug] @pabeni
  176  BPF selftest got "fallback to TCP" error [bug] @geliangtang



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.14):
https://github.com/multipath-tcp/mptcp_net-next/projects/9
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - net:
        - a couple are queued for the export branch
        - the 3 last ones:
            - mptcp: always parse mptcp options for MPC reqsk
            - mptcp: do not reset MP_CAPABLE subflow on mapping errors
            - conflicts with: mptcp: add sk parameter for mptcp_get_options
            - hopefully the sync with net-next will be done soon

    - net-next:
        - net-next seems open
        - best to send what we can, backlog is big :)



Extra tests:
    - news about Syzkaller? (Christoph):
        - Mat is running a (much smaller) instance but nothing to report

    - news about interop with mptcp.org? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - running and hasn't report any failure

    - packetdrill (Davide):
        - /

    - CI (Matth):
        - /



Patchew:
    - Davide will check with Paolo Bonzini



IRC:
    - Freenode is dying:
        - warning: channels will be hijacked if they contain "libera" in
the topic
        - https://blog.bofh.it/debian/id_461
        - CentOS has moved
        - Ubuntu has moved
        - FOSDEM has moved
        - Fedora has moved
        - NetworkManager has moved
        - Many many more have moved:
          https://github.com/siraben/freenode-exodus
        - Operators proving more and more untrustworthy:
            - https://www.devever.net/~hl/freenode_abuse
            - https://www.devever.net/~hl/freenode_abuse2
    - Switch from freenode to ??? libera.chat? OFTC?
    - Or something else? Matrix? (Element) (there are bridges with IRC)
    - keep #MPTCPUpstream or:
        - #mptcp → anything about mptcp
        - #mptcp-ci → only for the bots
        - #mptcp-dev → restricted? no: public discussions

    - → decision: move to libera on #mptcp and #mptcp-ci.

    - we will see later if we need more channels (or less)
    - TODO: Matth: register mptcp project → in progress
    - TODO: Matth: change topic in freenode to point to the wiki, IRC
section (NOT mention libera) → Done



busy polling on a single NAPI instance:
    - By Paolo
    - for later discussion



Patchwork:
    - ozlabs in read-only: request sent

    - remove ozlabs ML: Mat is going to create a ticket

    - missing patches (RFC/changes requested) have been re-sent

    - New status:
        - New (same):
            → Waiting for reviews from anybody
        - Under review (same):
            → In review or waiting for precisions
        - Accepted (same):
            → Applied in our tree
        - Rejected (same):
            → We don't want that
        - RFC (same):
            → RFC, more to park this for later
        - Not applicable (same):
            → To be rebased
        - Changes requested (same):
            → We need a new version
        - Awaiting Upstream (*CHANGED*):
            → A patch that is not for our tree, e.g. for iproute2
            before, with patchwork.ozlabs.org, was "Waiting to be
applied in our tree"
        - Superseded (same):
            → Replaced by a new version
        - Deferred (same):
            → Handled by others, typically netdev maintainers (best to
check the exact status elsewhere)
        - Mainlined (*NEW*):
            → Handled by others and applied in another tree (if we don't
forget to change the status)
        - Queued (*NEW*):
            → Waiting to be applied in our tree
        - Needs ACK (same):
            → Waiting for reviews a "long time" (at least since the last
weekly meeting) or for someone specific

    - Wiki has been updated:
        - https://github.com/multipath-tcp/mptcp_net-next/wiki/Patchwork
        -
https://github.com/multipath-tcp/mptcp_net-next/wiki/Patch-prefixes



Next meeting:
    - On Thursday, the 4rd of June.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210603



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you ~~on Thursday~~ yesterday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
