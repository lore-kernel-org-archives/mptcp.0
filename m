Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE82FAE
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 12:20:16 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id gb17so2098663ejc.8
        for <mptcp@lists.linux.dev>; Wed, 26 May 2021 05:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1leUTg/T9i8ru0a705C3THKMR0rXlIGeJRi8bHJQeE4=;
        b=qLyQ+1zfX9rM4F2VWCcXiEEDy/rvmGapuOMYRV2R8dh1T2h+IMTmqSCDbuJl9Df5Py
         mNiLaOmzdwo3xt6Sq/fdZ75cqJkI+mukd8Y65UZPBTrQpRHY/MKbZGmS9d+YdWsyB1iL
         c4eXRyPcIZM0mN9rTj6a7UF5QKtrS3UmIcLSMBWv+Ko9a6EtQsFlhK/v14iG5JYhvopg
         MFy77RUhHgWJWxHr3ZvnWytiREZtJXEP7e2u42rcfQo78ntZD80xlEXuxODNoYgEekU+
         CCjjkjHnGRiIBDg44E3rPs65aopGya9W50gYOySynz6JI8d9TsVRSOKkOqPGdCjOdBqO
         ST9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1leUTg/T9i8ru0a705C3THKMR0rXlIGeJRi8bHJQeE4=;
        b=hIUbrSD2rbrHCGmiQc1aQIydAWSv6h1JA6jIp2o1Xl8PJ97minaP8yyBZdYPj5tdrj
         LTJuySEQ8EHwrEKjRHbUo2BXsCA2W2sOGylfLAPTc7bpuCMTUII8PgCkIaPu1AzOd9Ra
         tm98QD4iuy37BuMSJMiiKlZvgywnnd9nPEpZY28YRpjPrFeB37UQhF4P+WagutEaa/HY
         ImLQDpOq0OMJg6uzyoJ5yvI7YDKHOIvFefoaWwM+CvtYiNziPL8aEtw4YTcAC4YOd/xp
         LmKmVkh3CU09AsGjAFwFBkSg69nwE8jzrtaNC7U8j3hrbNveY5VQZg7o9qN+vMopU3ez
         FgFQ==
X-Gm-Message-State: AOAM530YBZhDF9qfGzxkLbJ9UU8e2TOFHwjFogzrVqOTNRz0bDntNFmi
	ynQRsGX5m3Gfl0/k2vpAoKyld4kerUHLJinT
X-Google-Smtp-Source: ABdhPJzsUATKChDHqMZajNIPQkQWIY8gIamvXRy2UxvVkzGBiDnO9vQ4posj2s67wZjFjKycZQvIdw==
X-Received: by 2002:a17:907:36c:: with SMTP id rs12mr1531779ejb.59.1622031614279;
        Wed, 26 May 2021 05:20:14 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:a52a:a612:5e57:78a])
        by smtp.gmail.com with ESMTPSA id f7sm10401568ejz.95.2021.05.26.05.20.13
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 05:20:13 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 20th of May 2021
Message-ID: <a2ee322e-3a55-f392-c697-d96d8054937d@tessares.net>
Date: Wed, 26 May 2021 14:20:13 +0200
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

Last Thursday, we had our 149th meeting with Mat and Ossama (Intel),
Florian, Paolo and Davide (RedHat) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:




Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.ozlabs.org/project/mptcp/list/?state=3
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (/):

/


    our repo (by: Florian Westphal, Paolo Abeni):

12258521  [mptcp-net] mptcp: fix sk_forward_memory corruption under
memory pres...:

12258519  [v3,mptcp-next,7/7] selftests: mptcp_connect: add
SO_TIMESTAMPNS cmsg...
12258517  [v3,mptcp-next,6/7] mptcp: receive path cmsg support
12258515  [v3,mptcp-next,5/7] tcp: export timestamp helpers for mptcp
12258513  [v3,mptcp-next,4/7] mptcp: setsockopt: handle SOL_SOCKET in
one place...
12258511  [v3,mptcp-next,3/7] mptcp: sockopt: propagate timestamp
request to su...
12258507  [v3,mptcp-next,2/7] sock: expose so_timestamping options for
mptcp
12258509  [v3,mptcp-next,1/7] sock: expose so_timestamp options for mptcp:
        - series: add cmsg support to receive path



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.ozlabs.org/project/mptcp/list/?state=*
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Davide Caratti, Geliang Tang, Paolo Abeni):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets:
    - WIP

1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support
    - WIP

1395128: RFC: [1/5] tcp: make two mptcp helpers available to tcp stack
1395133: RFC: [5/5] mptcp: send fastclose if userspace closes socket
with unread data:
    - WIP

1474821: Changes Requested: [mptcp-next,1/3] mptcp: MP_FAIL suboption
sending
1474822: Changes Requested: [mptcp-next,2/3] mptcp: MP_FAIL suboption
receiving
1474823: Changes Requested: [mptcp-next,3/3] mptcp: send out MP_FAIL
when data checksum fail:
    - Reviewed by Mat
    - v2 is expected

12258525: Changes Requested: [v6,mptcp-next,1/6] mptcp: add sysctl
allow_join_initial_addr_port
12258527: Changes Requested: [v6,mptcp-next,2/6] mptcp: add
allow_join_id0 in mptcp_out_options
12258529: Changes Requested: [v6,mptcp-next,3/6] mptcp: rename
mptcp_pm_add_entry to mptcp_pm_anno_entry
12258531: Changes Requested: [v6,mptcp-next,4/6] mptcp: add add_list in
mptcp_pm_data
12258533: Changes Requested: [v6,mptcp-next,5/6] mptcp: add
deny_join_id0 in mptcp_options_received
12258535: Changes Requested: [v6,mptcp-next,6/6] selftests: mptcp: add
deny_join_id0 testcases:
    - series: "add MP_CAPABLE 'C' flag"
    - still unsure about the complexity for the PM
    - C bit is an exception only for ID0 addresses
    - we then don't need to cache this info in all IP peers
    - How to deal with PM modifications? e.g. a new endpoint (new limits?)

    - PM:
        - reacts when the ADD_ADDR is received
        - or create sf for local endpoint to initial remote addr

        - we don't have a "fullmesh":
            - we establish from each local to the original remote
            - we establish from the original local to the announced one

            - if the limit, checked when ADD_ADDR are received or end
point is added, are OK:
                - changing these limits after have no effects for the
current connections
                - do we still respect the limits?

        - we cannot change this default behaviour (especially without
ways to get the previous behaviour back)

    - for the same configuration in iproute, we need to have the same
behaviour in the kernel.
    - fear: add complexity in the code, e.g. per socket allocation when
receiving ADD_ADDR
    - Mat will follow-up

12263877: New: [mptcp-next] Squash to "mptcp: generate the data checksum":
    - Needs review

12264457: Changes Requested: [mptcp-next] Squash to "mptcp: add
deny_join_id0 in mptcp_options_received":
    - linked to C-bit patch

12264459: New: [mptcp-next] Squash to "selftests: mptcp: add
deny_join_id0 testcases":
    - Needs review
    - linked to C-bit patch

12265219: Awaiting Upstream: [mptcp-net] mptcp: drop unconditional
pr_warn on bad opt:
    - TODO: Matth: to add in our tree → Done

12265221: Awaiting Upstream: [mptcp-net] mptcp: avoid error message on
infinite mapping:
    - TODO: Matth: to add in our tree → Done

12265279: Awaiting Upstream: [net] mptcp: validate 'id' when stopping
the ADD_ADDR retransmit timer:
    - TODO: Matth: to add in our tree → Done

12270323: New: [mptcp-net] Squash-to: "mptcp: fix sk_forward_memory
corruption under memory pressure":
    - Linked to 172 & 195
    - Matth: run tests → Done

12270709: New: [v3,mptcp-net,1/3] mptcp: always parse mptcp options for
MPC reqsk
12270707: New: [v3,mptcp-net,2/3] mptcp: do not reset MP_CAPABLE subflow
on mapping errors
12270705: New: [v3,mptcp-net,3/3] mptcp: update selftest for fallback
due to OoO:
    - Linked to 192
    - Matth: run tests → Done



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 191)

  195  WARNING in sk_stream_kill_queues and inet_sock_destruct [bug]:
      - 172 but same root cause
      - should be fixed with Squash-to: "mptcp: fix sk_forward_memory
corruption under memory pressure"

  194  Round-robin packet scheduler support [enhancement] @geliangtang:
      - Extending or replacing the default scheduler should be done with
BPF ideally, if possible (similar to what is done with TCP CC)
      - Implementing a Round-robin with BFP could be used as an example
      - We might want a more complex one in BPF (or re-implement the
default one or RTT based or BLEST, etc.) to see if we can really have
another packet scheduler

  193  Fullmesh path manager support [enhancement] @geliangtang:
      - could be good to do that with the default PM with netlink parameters
      - there is another ticket to implement commands for the Netlink PM
→ looks like a higher priority
      - Or is there a need to have it in BPF? (after the scheduler?)

  192  selftests: connect: "poll timed out" issue [bug]:
      - should be fixed with "mptcp: always parse mptcp options for MPC
reqsk" series


    Bugs (opened, flagged as "bug" and assigned)

  176  BPF selftest got "fallback to TCP" error [bug] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  195  WARNING in sk_stream_kill_queues and inet_sock_destruct [bug]:
      - TODO: Assign to Paolo → Done

  192  selftests: connect: "poll timed out" issue [bug]:
      - TODO: Assign to Paolo → Done

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
  191  Could you please let me know how to use "ip mptcp end points
backup"? [question] @matttbe
  189  Wireshark / TCPDump doesn't understand option subtype 8
(MP_TCPRST) [enhancement] @dcaratti
  188  Netlink events for MP_TCPRST [enhancement] @dcaratti
  187  add recvmsg support for ancillary data [enhancement] @fw-strlen
  186  Add netlink command support [enhancement] @mjmartineau
  183  MP_CAPABLE 'C' flag is ignored [enhancement] @geliangtang
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti
   96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
   52  MP_FAIL support [enhancement] @geliangtang


    Recently closed (since last week)

  172  WARNING in sk_stream_kill_queues [bug] @pabeni
  143  Packetdrill: ADD_ADDR for v6 only socket should only contain v6
addresses [enhancement] [packetdrill] @dcaratti



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.14):
https://github.com/multipath-tcp/mptcp_net-next/projects/9
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - net:
        - some are going to be applied soon
        - better to wait a bit before sending them
        - Mat can send them on Monday (if applied "today")

    - net-next:
        - /



busy polling on a single NAPI instance:
    - By Paolo
    - for later discussion



Extra tests:
    - news about Syzkaller? (Christoph):
        - /
        - Feel free to have other instances!

    - news about interop with mptcp.org? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - nothing new to report but still working good

    - packetdrill (Davide):
        - /

    - CI (Matth):
        - /


mptcpd:
    - binary to use MPTCP
    - doing 2 things:
        - Force apps to use MPTCP when creating a TCP socket
        - Transform a systemd .service file to use MPTCP.



Patchwork:
    - new location: https://patchwork.kernel.org/project/mptcp/list/?state=*
    - to add: bot to auto-superseded? → maybe not for Squash-to patch?
Or rare? → not for the moment
    - to add: link to archives? (lore) available for netdev → Mat can
ask → Done
    - to add: results from CI: similar to patchew if easy → Matth to
check later
    - to add: reviewers? We can only assign to Mat & Matt → Add Paolo:
pabeni on patchwork?
    - resend RFC patches → TODO Matth
    - Ozlab: read only → TODO Matth → request sent



Patchew:
    - /



IRC:
    - Freenode is dying:
        - https://blog.bofh.it/debian/id_461
        - CentOS has moved
        - Ubuntu has moved
        - FOSDEM has moved
        - ... has moved
    - Switch from freenode to ??? libera.chat?
    - Or something else? Matrix? (Element)
    - keep #MPTCPUpstream or:
        - #mptcp → anything about mptcp
        - #mptcp-ci → only for the bots
        - #mptcp-dev → restricted?



Next meeting:
    - On Thursday, the 27th of May.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210527



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
