Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD7370
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 15:41:04 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id nb6so4580653ejc.10
        for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=PImJSNCKzpKIKxPxAEm6Q88uod6VograymthqeAN6Tc=;
        b=OTDz5XLgF6g28pZGshLyiJOXX9KbBqQN5UF2CMiBKPGyvYLUJx5LRT2+/DQ9QPlvNu
         qLmY19KP50557Fx3nHSyZZV4aMe8TwI5p9HQsUDrt/VcM1XhZNYqWM9t6GWKCxjjQRtb
         So2FB7wdNlMsLOfSiNczzOf6Ye6fT24flA6dUpl3SN3/UMQ4oLZqeAUuI7l69NrXkLxx
         TK6AV/o+d1MrYMi70B5eoLhVE/YZ1wm/erWS7FrZld4+b+q9Eab6uCHgvFhpLbQ3h3gg
         tbn5zx2xqgXm4b27vRwqWbQrb38T1bYwxBkj7rL9sJWGTRYarMS8EH7PWUFtYdtLOGGw
         /KHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=PImJSNCKzpKIKxPxAEm6Q88uod6VograymthqeAN6Tc=;
        b=KAh5ok+hZQ2fSDfRum6gQbFyKLb3Ak0CEUV51hcqsfhehaRVnXXv6j8mks8RNjjmIl
         xLq7NacHW0rVIYyl0Q6AmVMhmSFb0TK1k+r3v1IZzytWsh34mtwJHYcQHGZmjl7NlC7q
         8880Q7Gio7ZObhajbXM+ttfYZlqZ90gfx+gdOPdZhWkQU3Ilhjh6giCRxMnD1LLHQQop
         YUZV1qA8U/dG3XL+kxznMSDoTjQ5kPk3uB/LR85SBpXcRWd48TnqX2pzNpfmxPUIesg2
         bYEE6JEvBfn1z2CeZ19HWnkiOIih0KItugdIq1rJAY3Oj2BJDW90v3RmFyMIe656QWjI
         n32Q==
X-Gm-Message-State: AOAM5312G1BcIyl9CKMV5yIbQAL+SfPATyGcrRYisdMYoVSHpj22j7o0
	khSVHg6AyiXoaO+miJq/8gVHYJunvp++0hRT
X-Google-Smtp-Source: ABdhPJysGb1uOoOMt7sey/TodqQHd8ZIjBDHVTYgc2YimF9BCLBmLBIv5XSYtN4/H4IJfAsGuowDgw==
X-Received: by 2002:a17:906:dc43:: with SMTP id yz3mr120743ejb.323.1623858062815;
        Wed, 16 Jun 2021 08:41:02 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([72.11.157.83])
        by smtp.gmail.com with ESMTPSA id s5sm2145796edi.93.2021.06.16.08.41.02
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 08:41:02 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 10th of June 2021
Message-ID: <dedc7d0f-9e12-1883-588d-5c2930b2f3f6@tessares.net>
Date: Wed, 16 Jun 2021 17:41:01 +0200
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

Last Thursday, we had our 152nd meeting with Mat and Ossama (Intel),
Paolo and Davide (RedHat) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12298393  [net-next,7/7] selftests: mptcp_connect: add SO_TIMESTAMPNS
cmsg supp...
12298389  [net-next,6/7] mptcp: receive path cmsg support
12298387  [net-next,5/7] tcp: export timestamp helpers for mptcp
12298391  [net-next,4/7] mptcp: setsockopt: handle SOL_SOCKET in one
place only
12298379  [net-next,3/7] mptcp: sockopt: propagate timestamp request to
subflows
12298385  [net-next,2/7] sock: expose so_timestamping options for mptcp
12298383  [net-next,1/7] sock: expose so_timestamp options for mptcp


    our repo (by: Matthieu Baerts, Paolo Abeni):

12303619  Squash-to: "mptcp: wake-up readers only for in sequence data"

12301287  [mptcp-next] selftests: mptcp: display proper reason to abort
tests

12297483  [v3,mptcp-net] mptcp: fix soft lookup in subflow_error_report().

12297413  [v2,mptcp-next] mptcp: add MIB counter for invalid mapping

12297389  [v2,mptcp-net] selftests: mptcp: enable syncookie only in
absence of ...

12296967  [v2,mptcp-net] mptcp: do not warn on bad input from the network

12284907  [mptcp-next,2/2] mptcp: drop rendundant test in
move_skbs_to_msk()
12284905  [mptcp-next,1/2] mptcp: don't clear MPTCP_DATA_READY in
sk_wait_event...

12284819  [mptcp-net] mptcp: wake-up readers only for in sequence data.

12284731  [v2,mptcp-next] mptcp: use fast lock for subflows when possible.

12282235  [mptcp-net] mptcp: try harder to borrow memory from subflow
under pre...

12282131  [v3,mptcp-next] mptcp: drop tx skb cache



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Jianguo Wu, Matthieu Baerts, Paolo
Abeni, Yonglong Li):

12278269: Queued: [v8,mptcp-next,1/4] mptcp: add sysctl
allow_join_initial_addr_port
12278271: Queued: [v8,mptcp-next,2/4] mptcp: add allow_join_id0 in
mptcp_out_options
12278273: Queued: [v8,mptcp-next,3/4] mptcp: add deny_join_id0 in
mptcp_options_received
12278275: Queued: [v8,mptcp-next,4/4] selftests: mptcp: add
deny_join_id0 testcases:
    - Can be applied with Mat's RvB tag and Paolo's ACK → Done

12279739: RFC: [RFC,3/4] mptcp: move the whole rx path under msk socket
lock protection
12279741: RFC: [RFC,4/4] mptcp: cleanup mem accounting:
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
socket with unread data:
    - WIP

12282229: Changes Requested: [RESEND,mptcp-next,1/3] mptcp: MP_FAIL
suboption sending
12282231: Changes Requested: [RESEND,mptcp-next,2/3] mptcp: MP_FAIL
suboption receiving
12282233: Changes Requested: [RESEND,mptcp-next,3/3] mptcp: send out
MP_FAIL when data checksum fail:
    - WIP

12300177: Changes Requested: [mptcp-next] mptcp: refine mptcp_cleanup_rbuf:
    - Reviewed by Mat
    - Paolo is preparing a v2 → Done

12309071: New: mptcp: use icsk_rto of first subflow as ADD_ADDR timeout
value:
    - Can we change how a sysctl is used?
    - Mat will have a look at it → Done

12311571: New: [v2] selftests: mptcp: turn rp_filter off on each NIC:
    - v1 Reviewed by Mat
    - v2 addressing comments from Mat → Done

12312365: New: [1/4] mptcp: fix ADD_ADDR and RM_ADDR maybe flush
addr_signal each other
12312369: New: [2/4] mptcp: make MPTCP_ADD_ADDR_SIGNAL and
MPTCP_ADD_ADDR_ECHO separate
12312371: New: [3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR option
according pm.add_signal
12312373: New: [4/4] mptcp: remove MPTCP_ADD_ADDR_IPV6 and
MPTCP_ADD_ADDR_PORT:
    - series: "mptcp: fix conflicts when using pm.add_signal in
ADD_ADDR/echo and RM_ADDR process"
    - Paolo started to look at it
    → Changes Requested → Done

12312415: New: [mptcp-next] Squash to "mptcp: add deny_join_id0 in
mptcp_options_received":
    - Addressing one comment from Paolo
    - linked to the "MP_CAPABLE C flag" series
    - Can be applied → Done

12312439: Changes Requested: [v2,1/4] mptcp: fix warning in
__skb_flow_dissect() when do syn cookie for subflow join
12312441: Changes Requested: [v2,2/4] mptcp: remove redundant req
destruct in subflow_check_req()
12312443: Changes Requested: [v2,3/4] mptcp: fix syncookie process if
mptcp can not_accept new subflow
12312445: Changes Requested: [v2,4/4] mptcp: avoid processing packet if
a subflow reset:
    - Series: "Fix some mptcp syncookie process bugs"
    - Paolo already looked at it



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 199)

  202  Add sendmsg support for ancillary data [enhancement]:
      - linked to cmsg
      - received part already implemented by Florian
      - Not sure if there is a need for the sending
      - or maybe some specific MPTCP ancillary data to share with the
socket?

  200  fallback rx path is broken [bug]:
      - Paolo already looked at explicitly disable TCP header prediction
for fallback socket:
          - there might be a limited perf impact
          - hopefully, not a big issue as it is only for the fallback
traffic
      - other options require a modification of the TCP stack → we will
see that later if needed


    Bugs (opened, flagged as "bug" and assigned)

  196  warn_bad_map on 5.12.0 [bug] @pabeni:
      - TODO: can be closed → Done

  191  Could you please let me know how to use "ip mptcp end points
backup"? [bug] [question] @matttbe:
      - TODO: Matth: create a new ticket for the server side issue
("signal backup" flag not taken into account) → Done
      - Check the kind of traffic on the "backup" flow: reinjection? →
linked to #177


    Bugs (opened and flagged as "bug" and not assigned)

  200  fallback rx path is broken [bug]:
      - TODO: assign Paolo → Done

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]
  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug]
  120  [interop] netnext is dropping packets, causing MPTCP-level
retransmissions on mptcp.org [bug]
   65  clearing properly the status in listen() [bug]
   56  msk connection state set without msk lock [bug]


    In Progress (opened and assigned)

  194  Round-robin packet scheduler support [enhancement] @geliangtang
  193  Fullmesh path manager support [enhancement] @geliangtang:
      - *Geliang* : are working on both 193 and 194?
      - *Mat* will contact Geliang to check that

  189  Wireshark / TCPDump doesn't understand option subtype 8
(MP_TCPRST) [enhancement] @dcaratti:
      - Waiting for review on TCPDump side

  186  Add netlink command support [enhancement] @mjmartineau
  183  MP_CAPABLE 'C' flag is ignored [enhancement] @geliangtang:
      - Can be closed soon → Done

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti

   52  MP_FAIL support [enhancement] @geliangtang:
       - patches have been shared


    Recently closed (since last week)

  201  Recent regression: selftests: connect: read: Resource temporarily
unavailable [bug] @pabeni
  199  deadlock in subflow_error_report() [bug] @pabeni
  198  selftests: connect: "poll timed out" (POLLERR/POLLNVAL) with
syncookies [bug]
  188  Netlink events for MP_TCPRST [enhancement] @dcaratti
  187  add recvmsg support for ancillary data [enhancement] @fw-strlen
  107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]




What about MPTCP connections without subflows:
    - the PM can still create/accept new connections later
    - the socket is in Established mode
    - if the subflow got reset
    - Timeout?
    - Can be seen if there is a bug in the implementation
    - (MP)TCP keep alive?
    - Maybe best to keep the responsibility to the PM:
        - in kernel: no timeout or a fixed one for all connections of the NS
        - if a netlink listener PM: he is in charge of that
        - still the userspace could set 'MPTCP keep alive'
    - We need to handle server and client cases
    - TODO: Matth: copy info in the existing (?) ticket about that →
Done: issues/128



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.14):
https://github.com/multipath-tcp/mptcp_net-next/projects/9
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - net:
        - a few patches for -net (5) from Paolo
        - Mat is going to send them

    - net-next:
        - checksum support series:
            - but ideally we need interop tests
            - ideally if there is no conflicts with -net
            - maybe a fix needed in the Doc:
                - what is said: "only used if enabled in the sysctl"
                - in fact: "only requested if this sysctl is needed"
                → can be imposed by one of the two peers
        - 5 patches from Paolo → can be sent before the checksum series
if needed
        - Mat will look at that



Extra tests:
    - news about Syzkaller? (Christoph):
        - Mat setup a new (more powerful) server validating the export
branch
        - Nothing related to MPTCP so far!

    - news about interop with mptcp.org? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - one failure last WE but already fixed by Paolo!

    - packetdrill (Davide):
        - /

    - CI (Matth):
        - /



Patchew:
    - https://patchew.org/MPTCP/ online, db created
    - users permissions to be checked
    - an additional account for Matthieu needed (if it makes sense)
    - Davide will try 'patchew-cli' with a single .mbox, then deploy an
importer container
    - then new patches should be published on GitHub (new tag)
    - then CI will start the tests (easy)
    - but we still need to look at publishing the results (todo)



IRC:
    - cloak?:
        - instead of 'matttbe@<IP>' → 'matttbe@mptcp/xxxx'
        - continue the discussion on IRC if interested

    - still OK with a separated channel for #mptcp-ci? Or only build
results there but not what is linked to GH issues?:
        - continue the discussion on IRC

    - Matrix (via element.io) is a good solution to be connected all the
time without having to put in place a Bouncer:
        - There is an article in fedoramagazine on how to use it



Next meeting:
    - On Thursday, the 17th of June.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210617



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
