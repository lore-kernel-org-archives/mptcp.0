Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF8270
	for <mptcp@lists.linux.dev>; Wed,  4 Aug 2021 18:14:18 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id zb12so241853ejb.5
        for <mptcp@lists.linux.dev>; Wed, 04 Aug 2021 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=xogFsU6jajzaeEysDdWJa/rgBNJV3RTWcZE+nwg/Xyk=;
        b=rUdTpDSOkgIbIcrhYNmivB0aQznT9NqR44D6lqYt9WrvXsICMnO4DpIHt1EV3KnhG4
         tJxYm6KOQNp9gmXWdCg+CqzTWCEOHKM5RQqy//jONtsnb5LoKlItcBSR+cdHaFKmow9B
         FkblVlTR+z7kplgdT8PEgPRuViH3lbHynt3YOQNQHgIyJgcc1urG6hoUa77A1y1lksJb
         H5qa4S9DZGnkQNQp6cqS/84d2XT5JKk8IKmabjUzwe/ckAMWYytECWdWjkqJg4oFOUE9
         A0UP6Khhcgr3rcrHkkITfqoRCTNwDT65g7MPNUqtOmBhRx1tmwR3vy11PXKWbDK5bD+f
         3pAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=xogFsU6jajzaeEysDdWJa/rgBNJV3RTWcZE+nwg/Xyk=;
        b=n9N2lkK24gUh2h6zWiZeg372A0PH+QrVWwop36pTVcHlJ2ibI1yASDDPL3QXNbubl7
         fZm0eQwiDi7322Sq/iUrGIZG1BAuE+QOrBfGreZgcIEocYiRT9CMD9j4YyGmxGYrPTM0
         DSJicy/0pAlw0XJrCNcyQB78Ra1lIUAVY08qxMd+9/2lSOZfU1YCj47AeE/I2Eh1JEKq
         EOW0jLzFrdMpCFKDD6LmT19sXnbOretn1jxeYwDizaJZM4Y5U+x9aCRaEFE/lb/ywKVf
         9LT2zaLgE9fNcM8AXCsv15/3ti6Lz9wpwbXoMDBW5O/LLsIVTpV2QqczPGpx+9RcKWSg
         UuHw==
X-Gm-Message-State: AOAM532GU25pUdPhO3Z+WYyp4z+iuBP+hhQBvTRCtlxTNgLPs83l0owr
	8pOpXswM4ORGvEHrzrbaF0gsdHCHS1t4VFGQ
X-Google-Smtp-Source: ABdhPJytdCF/r5in+MoJAcr2sIqDxkB8r7Va8AZPR9DeiTJ20vNAxxmOMc2t0pw4hBH+kIk4Yalr7Q==
X-Received: by 2002:a17:906:c2d7:: with SMTP id ch23mr479262ejb.298.1628100856554;
        Wed, 04 Aug 2021 11:14:16 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.102.61.dyn.edpnet.net. [94.105.102.61])
        by smtp.gmail.com with ESMTPSA id q11sm895817ejb.10.2021.08.04.11.14.16
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 11:14:16 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 29th of July 2021
Message-ID: <73c74533-debd-ba3b-004e-bb4b82f8078c@tessares.net>
Date: Wed, 4 Aug 2021 20:14:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we just had our 159th meeting with Mat and Ossama
(Intel), Christoph (Apple), Florian, Paolo, Davide and Poorva (RedHat),
Geliang (Xiaomi) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Paolo Abeni):

12390355  [mptcp-next] Squash to "selftests: mptcp: add testcase for
active-bac...

12381341  [v9,mptcp-next,6/6] selftests: mptcp: add_addr and echo race test
12381339  [v9,mptcp-next,5/6] mptcp: remove MPTCP_ADD_ADDR_IPV6 and
MPTCP_ADD_A...
12381337  [v9,mptcp-next,4/6] mptcp: build ADD_ADDR/echo-ADD_ADDR option
accord...
12381335  [v9,mptcp-next,3/6] mptcp: fix ADD_ADDR and RM_ADDR maybe
flush addr_...
12381333  [v9,mptcp-next,2/6] mptcp: make MPTCP_ADD_ADDR_SIGNAL and
MPTCP_ADD_A...
12381331  [v9,mptcp-next,1/6] mptcp: move drop_other_suboptions check
under pm ...

12376299  [mptcp-next] Squash-to: "mptcp: faster active backup recovery"

12375127  [v2,mptcp-next,8/8] selftests: mptcp: add testcase for
active-back
12375125  [v2,mptcp-next,7/8] mptcp: backup flag from incoming MPJ ack
option
12375121  [v2,mptcp-next,6/8] mptcp: add mibs for stale subflows processing
12375123  [v2,mptcp-next,5/8] mptcp: faster active backup recovery
12375119  [v2,mptcp-next,4/8] mptcp: cleanup sysctl data and helpers
12375117  [v2,mptcp-next,3/8] mptcp: handle pending data on closed subflow
12375115  [v2,mptcp-next,2/8] mptcp: less aggressive retransmission
stragegy
12375113  [v2,mptcp-next,1/8] mptcp: more accurate timeout

12367219  [mptcp-next] mptcp: drop unuse rcu in mptcp_pm_addr_entry

12399121  [v3,mptcp-next,3/3] mptcp: shrink mptcp_out_options struct
12399119  [v3,mptcp-next,2/3] mptcp: optimize out option generation
12399117  [v3,mptcp-next,1/3] Squash-to: "mptcp: move
drop_other_suboptions che...
12398149  [v2,mptcp-next] Squash to "Squash-to: mptcp: build
ADD_ADDR/echo-ADD_...
12396139  [mptcp-next] Squash-to: "mptcp: build ADD_ADDR/echo-ADD_ADDR
option a...



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Florian Westphal, Geliang Tang, Jiapeng Chong,
Matthieu Baerts, Paolo Abeni):

12279739: RFC: [RFC,3/4] mptcp: move the whole rx path under msk socket
lock protection:
    - WIP

12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to
tcp.h/mptcp.h
12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in
reset packets:
    - WIP

12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
    - WIP

12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp
stack
12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes
socket with unread data::
    - WIP

12321111: Changes Requested: mptcp: Remove redundant assignment to
remaining:
    - TODO

12394261: RFC: [RFC] mptcp: add MPTCP_INFO getsockopt:
    - Florian sent an email: better to reply on the ML for the technical
details
    - Question: how to test it?:
        - Maybe easier to create a new selftest, dedicated to getsockopt()
        - No need to use packetdrill as it is currently not possible to
read from info returned from this getsockopt() and it will be enough
with  the kselftest.

12407883: New: [v7,mptcp-next,1/6] mptcp: drop flags and ifindex arguments
12407885: New: [v7,mptcp-next,2/6] mptcp: remote addresses fullmesh
12407887: New: [v7,mptcp-next,3/6] mptcp: local addresses fullmesh
12407889: New: [v7,mptcp-next,4/6] selftests: mptcp: set and print the
fullmesh flag
12407891: New: [v7,mptcp-next,5/6] selftests: mptcp: add fullmesh testcases
12407893: New: [v7,mptcp-next,6/6] selftests: mptcp: delete uncontinuous
removing ids:
12408461: New: [v4,mptcp-next] Squash to "mptcp: drop flags and ifindex
arguments"
    - (for the last patch: should be v1, not v4)
    - a small modification compared to v6
    - the squash-to patch addresses Paolo's comment

12408113: New: [v7,mptcp-next,1/5] mptcp: MP_FAIL suboption sending
12408115: New: [v7,mptcp-next,2/5] mptcp: MP_FAIL suboption receiving
12408117: New: [v7,mptcp-next,3/5] mptcp: send out MP_FAIL when data
checksum fails
12408119: New: [v7,mptcp-next,4/5] mptcp: add the mibs for MP_FAIL
12408121: New: [v7,mptcp-next,5/5] selftests: mptcp: add MP_FAIL mibs check:
    - New version addressing Mat's comments.
    - Mat will have a look.



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 216)
  218  Add support for MPTCP_INFO, similar to TCP_INFO [enhancement]:
      - See above for the discussion

  217  Support IP_TRANSPARENT [enhancement]:
      - new feature request


    Bugs (opened, flagged as "bug" and assigned):
        - \o/


    Bugs (opened and flagged as "bug" and not assigned)

  203  PM: server: accept subflows [bug]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]
  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug]
   65  packetdrill/fixes: clearing properly the status in
listen()/disconnect [bug]


    In Progress (opened and assigned)

  218  Add support for MPTCP_INFO, similar to TCP_INFO [enhancement]
@fw-strlen
  216  The infinite mapping support [enhancement] @geliangtang

  206  MPTCP-level retransmission strategy is probably too aggressive.
[enhancement] @pabeni:
      - Can be closed, thx to the work linked to the backup/scheduler
      - TODO: Matth → Done

  194  Round-robin packet scheduler support [enhancement] @geliangtang

  193  Fullmesh path manager support [enhancement] @geliangtang:
      - in progress, see above

  186  Add netlink command support [enhancement] @mjmartineau
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti

   52  MP_FAIL support [enhancement] @geliangtang:
      - in progress, see above


    Recently closed (since last week)

  15  reduce mptcp_out_option struct size [enhancement]:
      - Still some work that can be done for the receive path
      - less 'urgent'/'important' than the send path
      - This can be done in ticket 42
      - TODO: Matth: check if ticket 42 needs more details → done
      - TODO: make sure we cannot close ticket 42 of course

  207  better subflow closing/cleanup [enhancement]
  191  Could you please let me know how to use "ip mptcp end points
backup"? [bug] [question]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.15):
https://github.com/multipath-tcp/mptcp_net-next/projects/10
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - net:
        - one patch to send:
            - Mat will look at that

    - net-next:
        - 2 series are ready:
            - Paolo's series (backup / scheduler):
                → maybe best to wait, see issues/219
            - Yonglong & Geliang's series (ADD_ADDR/RM_ADDR refactor)



Netlink API: the events sent by the PM:
    - For the moment, there is no event when a subflow has been created,
only when it has been established (or closed)
    - If we have this situation:
        - the userspace PM creates a subflow -- when the command will be
available, see #186 -- without specifying the src port/address.
        - the subflow is never established, e.g. SYN are dropped
        - the userspace is not able to destroy the subflow -- again,
when the command will be available -- because the userspace doesn't have
the 5-tuples.
        - the userspace will see SUBFLOW_CLOSED events for unknown subflow
    - Solution: have a SUBFLOW_CREATED event.



Extra tests:
    - news about Syzkaller? (Mat & Christoph):
        - One new issue: [syzkaller] divide error in tcp_write_xmit
        - https://github.com/multipath-tcp/mptcp_net-next/issues/219
        - Maybe best to wait before sending Paolo's series (backup /
scheduler) → Done

    - news about interop with mptcp.org? (Christoph):
        - iOS15 seems to interop well with v5.10!
        - mptcp_v0.96 has been pushed by Christoph:
            - ease the interop tests, e.g. to look at
https://github.com/multipath-tcp/mptcp/issues/427

    - news about Intel's kbuild? (Mat):
        - some other issues but MPTCP tests are passing

    - packetdrill (Davide):
        - 2 tests are failing due to recent modifications in the kernel:
            - Paolo sent a PR
            - Seems good for Davide
            - But do we need to drop them for the "injected" packet?:
                - Yes otherwise we have an internal packetdrill issue
                - But indeed, might be better to keep a test to make
sure we don't have regressions with earlier version.
        - Davide and Poorva are looking at testing more getsockopt():
            - IP_TOS → we want it to work like with TCP
            - Poorva is looking at a fix for the kernel. Already got
some feedback and advices from Paolo.
            - TODO: Davide: create a new ticket about IP_TOS → Done

    - Patchew:
        - Davide really has an issue with his account
        - Once it is fixed, new accounts will be created for us.

    - CI (Matth):
        - TODO: detail errors reported by public CI



Next meeting:
    - On Thursday, the 5th of August.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210805



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
