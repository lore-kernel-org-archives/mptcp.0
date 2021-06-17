Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE8D72
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 16:48:54 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id my49so10883843ejc.7
        for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=nXi3uQD6D3057uJZgYBljFL5Oa3dYBK5/7jFebXws9w=;
        b=MUwo5UusGicEICMHA1XeL65i9mZdpe57KnOb3cvbDJcNzsRpfz4MUXsMuI27jXAJ6d
         7YOGlfEl7wliFEe1MGg7wmfOaVI3bu6EjptknG9yko4ei8hYc75I9B1KJbMbBow4FBF6
         4j/ZICj8tIB7wwb97EMa9nEuLzCWl1YB/GczW0BnOuLP1GPw2xmsj8CDBrApf3dKzs2W
         5C8P+a+BQ8wShAYXihADSSK+Ah4n9D9plMNwkpNOj4nyH3taFgLrXkyQEXq1fCv+vGxm
         1AhHc7isyediBDSPDJtSNZmmPJQTLwab6Iu3PuiOG5mNkp5sMPqMCNTanPhUTqeicJSs
         nZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=nXi3uQD6D3057uJZgYBljFL5Oa3dYBK5/7jFebXws9w=;
        b=nqeqdMj4R3oQLPDGlIVbPkC4hRA/dzBz88hT4FGeIiNguL5QEtrY1NkSONOwrB9tGW
         Z6N6EHKbx5tTFldmY6W6axjfjd09rKucUccEItkESVBKReVswEUjZ514ZSBrLbhdd+Li
         y9WHqqwhmct2+Y1KLwbhO0JlhWmwTNfPmRrDQteuOAf+3txI7ZFKEOGIVgl8g9yIivA8
         HdRQwsR+qDS4AoEPbHesftnUsdKapVYN8ySUKhntEJhGzBvhf+ikPbGIhI0GW+fqc/e/
         8FPoWWBvO3/43D/mnWczUO9t3ICCV7JRAQt2SZBg0OGGlMzRQT+HbMhIm4e6TC1ftv55
         66Sg==
X-Gm-Message-State: AOAM533chp5zw5gzKMiqYcOEwjN9IcXe3EB+JnOZaWFj72Bh8y4y4dbo
	BzRF2iQjwSGsAWL1+tD4HWYY/je/4wseKdcOZvU=
X-Google-Smtp-Source: ABdhPJwnFw9yhgDHePNImygwIPvQvbuypbtp4xzOgKodgQTzLljGDzrnLyinf0V92xsMFHTf/35MCw==
X-Received: by 2002:a17:906:82d6:: with SMTP id a22mr6215144ejy.227.1623948532492;
        Thu, 17 Jun 2021 09:48:52 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:7d63:1645:b739:5196])
        by smtp.gmail.com with ESMTPSA id f21sm4674257edr.45.2021.06.17.09.48.52
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 09:48:52 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 17th of June 2021
Message-ID: <4f24544d-d1f1-82f9-ce10-f5ea3806d137@tessares.net>
Date: Thu, 17 Jun 2021 18:48:51 +0200
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

Today, we just had our 153rd meeting with Mat and Ossama (Intel),
Paolo and Davide (RedHat), Geliang (Xiaomi) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau, Maxim Mikityanskiy):

12314227  [net,5/5] mptcp: fix soft lookup in subflow_error_report()
12314225  [net,4/5] selftests: mptcp: enable syncookie only in absence
of reord...
12314219  [net,3/5] mptcp: do not warn on bad input from the network
12314221  [net,2/5] mptcp: wake-up readers only for in sequence data
12314223  [net,1/5] mptcp: try harder to borrow memory from subflow
under press...

12313469  [net,v2,2/3] mptcp: Fix out of bounds when parsing TCP options


    our repo (by: Geliang Tang, Paolo Abeni, Yonglong Li):

12325209  [mptcp-next] Squash-to: "selftests: mptcp: turn rp_filter off
on each...

12324639  [v3,mptcp-next] mptcp: refine mptcp_cleanup_rbuf

12324483  [v2,mptcp-net] mptcp: fix 32 bit DSN expansion

12324481  [v2,mptcp-net] mptcp: fix bad handling of 32 bit ack wrap-around.

12312415  [mptcp-next] Squash to "mptcp: add deny_join_id0 in
mptcp_options_rec...

12311571  [v2] selftests: mptcp: turn rp_filter off on each NIC

12278275  [v8,mptcp-next,4/4] selftests: mptcp: add deny_join_id0 testcases
12278273  [v8,mptcp-next,3/4] mptcp: add deny_join_id0 in
mptcp_options_received
12278271  [v8,mptcp-next,2/4] mptcp: add allow_join_id0 in
mptcp_out_options
12278269  [v8,mptcp-next,1/4] mptcp: add sysctl
allow_join_initial_addr_port



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Y.b. Lu):

12320981: Changes Requested: [net-next,v3,07/10] net: sock: extend
SO_TIMESTAMPING for PHC binding:
    - Switched to Deferred status → we don't need to track it


    our repo (by: Jianguo Wu, Jiapeng Chong, Matthieu Baerts, Maxim
Mikityanskiy, Paolo Abeni, Y.b. Lu, Yonglong Li,):

12279739: RFC: [RFC,3/4] mptcp: move the whole rx path under msk socket
lock protection
12279741: RFC: [RFC,4/4] mptcp: cleanup mem accounting.:
    - WIP

12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to
tcp.h/mptcp.h
12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in
reset packets
    - WIP

12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support
12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp
stack
12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes
socket with unread data:
    - WIP

12282229: Changes Requested: [RESEND,mptcp-next,1/3] mptcp: MP_FAIL
suboption sending
12282231: Changes Requested: [RESEND,mptcp-next,2/3] mptcp: MP_FAIL
suboption receiving
12282233: Changes Requested: [RESEND,mptcp-next,3/3] mptcp: send out
MP_FAIL when data checksum fail:
    - WIP

12309071: Changes Requested: mptcp: use icsk_rto of first subflow as
ADD_ADDR timeout value:
    - Not sure what is the status: we suggest to archive it but a new
version can come (likely with a different commit title)

12316361: RFC: [RFC] tcp: consistently disable header prediction for mptcp:
    - Waiting for feedback from Florian

12321111: Changes Requested: mptcp: Remove redundant assignment to
remaining:
    - Mat did a review, v2 expected

12324763: Needs ACK: [v5,1/4] mptcp: fix warning in __skb_flow_dissect()
when do syn cookie for subflow join
12324761: Needs ACK: [v5,2/4] mptcp: remove redundant req destruct in
subflow_check_req()
12324765: Needs ACK: [v5,3/4] mptcp: fix syncookie process if mptcp can
not_accept new subflow
12324767: Needs ACK: [v5,4/4] mptcp: avoid processing packet if a
subflow reset:
    - Series: Fix some mptcp syncookie process bugs
    - Waiting for review
    - Mat & Paolo reviewed earlier versions
    - Mat will have a look
    - Selftests would be needed to avoid regressions (or packetdrill)

12325211: Changes Requested: [mptcp-net] mptcp: avoid race on msk state
changes:
    - reviewed by Mat
    - v2 in preparation

12327077: Changes Requested: [v3,1/4] mptcp: fix ADD_ADDR and RM_ADDR
maybe flush addr_signal each other
12327079: Changes Requested: [v3,2/4] mptcp: make MPTCP_ADD_ADDR_SIGNAL
and MPTCP_ADD_ADDR_ECHO separate
12327081: Changes Requested: [v3,3/4] mptcp: build
ADD_ADDR/echo-ADD_ADDR option according pm.add_signal
12327083: Changes Requested: [v3,4/4] mptcp: remove MPTCP_ADD_ADDR_IPV6
and MPTCP_ADD_ADDR_PORT:
    - Series: mptcp: fix conflicts when using pm.add_signal in
ADD_ADDR/echo and RM_ADDR process
    - Mat reviewed earlier versions
    - Geliang reviewed v3: v4 expected




Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 202)

  208  better handing of ssk memory pressure in the TX path [enhancement]:
      - Paolo found some issues while working on others
      - No reproducer but it looks like we could stall: not retry again
in some circumstances

  207  better subflow closing/cleanup [enhancement]:
      - related to issue 191

  206  MPTCP-level retransmission strategy is probably too aggressive.
[enhancement] @pabeni:
      - related to issue 191 and 171

  205  Checksum interop problem with mptcp_trunk:
      - It looks like an issue with 'mptcp_trunk'
      - MP_CAPABLE with checksum can be easily fixed
      - MP_CAPABLE with data seems broken
      - For the interop tests, we could force not to send data and move
on with the Checksum validation part
      - Mat is going to send the patch for MPC + checksum
      - And open a ticket for MPC + data

  203  PM: server: accept subflows [bug]:
      - related to issue 191
      - Maybe not a bug, Matt will have a look


    Bugs (opened, flagged as "bug" and assigned)

  200  fallback rx path is broken [bug] @pabeni:
      - there is a patch for this one:
           tcp: consistently disable header prediction for mptcp
      - Present since the beginning
        - Or at least since fallback change to "fake mapping" approach

  191  Could you please let me know how to use "ip mptcp end points
backup"? [bug] [question] @matttbe:
      - backup
      - NL: setting 'backup' doesn't set it in the egress direction:
          - but selftests will fail (no data will be sent over the
backup SF if non backup ones are still available even if no data are
transferred)
          - a way to work around this is to close subflows that looks
broken:
              - more aggressive way
              - e.g. we are in CC lost state and we have multiple subflows
              - we need to properly handle situations where there are
data in read/write queues of the subflows we want to close
              - reinjection needed but if we need to wait for a timer,
that can be long
              - Maybe moving all data from the subflow to the msk queues
(maybe that will move too much data and too much retransmissions but faster)
              - → Issue 207 needed
              - Matth: create a new issue: #209


    Bugs (opened and flagged as "bug" and not assigned)

  203  PM: server: accept subflows [bug]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]
  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug]
   65  clearing properly the status in listen() [bug]
   56  msk connection state set without msk lock [bug]


    In Progress (opened and assigned)

  206  MPTCP-level retransmission strategy is probably too aggressive.
[enhancement] @pabeni
  194  Round-robin packet scheduler support [enhancement] @geliangtang
  193  Fullmesh path manager support [enhancement] @geliangtang:
      - Geliang is still planning to work on those 193/194

  189  Wireshark / TCPDump doesn't understand option subtype 8
(MP_TCPRST) [enhancement] @dcaratti
  186  Add netlink command support [enhancement] @mjmartineau
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti
   52  MP_FAIL support [enhancement] @geliangtang


    Recently closed (since last week)

  204  wrong handling of 32bit ack wrap-around [bug] @pabeni
  196  warn_bad_map on 5.12.0 [bug] @pabeni
  183  MP_CAPABLE 'C' flag is ignored [enhancement] @geliangtang
  120  [interop] netnext is dropping packets, causing MPTCP-level
retransmissions on mptcp.org [bug]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.14):
https://github.com/multipath-tcp/mptcp_net-next/projects/9
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - net:
        - 2 linked to 32 bits DSN

    - net-next:
        - checksum series is next (even if it is a bit bigger than 15
patches)
        - a few others patches are ready too (c-flag, refactoring,
improvements, etc.)



Extra tests:
    - news about Syzkaller? (Christoph):
        - No issue related to MPTCP

    - news about interop with mptcp.org? (Christoph):
        - See issue #205

    - news about Intel's kbuild? (Mat):
        - /

    - packetdrill (Davide):
        - fixing long-standing bugs on "subflow" endpoints (created on
kernel under test)
        - PR has been sent for ↑ (ability to create any kind of endpoints)

    - CI (Matth):
        - /



Patchew:
    - Davide has no more rights to change anything
    - Davide contacted maintainers for that
    - An account will be created for Matth to let the CI publishing results



Accept new subflows when the listening socket is closed?:
    - for the moment, we don't accept new one even if the PM is
configured to accept more
    - except if the connection is done to a new endpoint with port →
inconsistency?
    - (few?) apps close the listening socket to accept only one
connection: exception?
    - apps bind on one specific IP: not OK to establish subflows to
another endpoint? exception?
    - Matth: document that → #210



Next meeting:
    - On Thursday, the 24th of June.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210624



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
