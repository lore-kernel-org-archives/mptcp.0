Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4D429CA
	for <mptcp@lists.linux.dev>; Mon,  7 Jun 2021 14:10:34 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id ba2so18811117edb.2
        for <mptcp@lists.linux.dev>; Mon, 07 Jun 2021 07:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=RQh6iNmaxC4vxn4of0nXOVxdSnnWMajeU+1C1gBzJOA=;
        b=Wm8Do4dI03Hm/vo8vaGXEgFj02y230coR3o9HrSCZZKR5fuE/+VCbGBO+8MSA2UOM0
         UXk+cFoiXo3uPBcxplfbrWsuab9fwASDhP+nszPnof3RhVq+9p5uhboZW6YshQMdOOf+
         1jyKsXXipoHVZYciML8tRDtytNJ+xSn0lEK1aNN2/4iOmbBiY0j5i4XbNXXtYlHM+0V7
         ZzkJd4g9MmN6RfQjoodTxTbkXFUOFU7FMR4a89osGLeepOyfXOMXQdA6k6vit0cmEA19
         vpz3CyDm3tGB2CoM6wgD6+MzZR7ScEcMf6iYEf9Ko/g1YQsSJ2zYz1LEb67JlpHlvUuZ
         h9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=RQh6iNmaxC4vxn4of0nXOVxdSnnWMajeU+1C1gBzJOA=;
        b=XEQ0vos3khpyUHz/AvLhd/uQ84cyb92Z39gcT+9lEc1QHRPWASJuZBWBd4zJhB6gT8
         97bUPmUpcC0pzj1wKHDhegcdAf4jwiT3ufOtWm+8ash0AdXJXsywXe46T+GA8yLDyzTo
         oI5qa6YyBOtQUiMCg5Cy4Hnf72Bf0zcRFJapxNzVoHmJs71Z07Uf8IqtlSxkEJ4KxmDm
         sJkUjtCbt8mCkv1zU3ofh1Ubu8MIlb/pT6K+tQwGaSvdVOa4PwtvNGSiCweXUDlfEWSe
         76SCS/gGikRiYbM472Nl6J7tRsc8vukUpmiHpqbfO+5sXCqQ7i1aJiALpMkkFEoHDlyi
         QPVg==
X-Gm-Message-State: AOAM531UFvwEq+10DPATivEn5p+p4ORerCJhCFB6+EM0xIldlOHTE9FT
	LqmefuF33dDatXNYAqiEB6NrvaA4X/KB3U2W
X-Google-Smtp-Source: ABdhPJzL43QDO4/hWZUpEsH3acYsjGFHhy2GOEITYn6zz/sfIC+0EeLYjWpPQyRWkKqPaTvJ6mPb9g==
X-Received: by 2002:a50:99d5:: with SMTP id n21mr20220331edb.223.1623075032210;
        Mon, 07 Jun 2021 07:10:32 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:b57e:3c04:9ae7:cda2])
        by smtp.gmail.com with ESMTPSA id y10sm6515115ejq.50.2021.06.07.07.10.31
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 07:10:31 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 3rd of June 2021
Message-ID: <a057fb05-a165-df7b-14fb-5b7498d20b54@tessares.net>
Date: Mon, 7 Jun 2021 16:10:31 +0200
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

Last Thursday, we had our 151st meeting with Mat and Ossama (Intel),
Paolo and Davide (RedHat) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Poorva:
    - New intern at RedHat from US West coast
    - She is going to work on MPTCP support for Packetdrill
    - Welcome!



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (Mat Martineau):

12285715  [net-next,7/7] mptcp: restrict values of 'enabled' sysctl
12285713  [net-next,6/7] mptcp: support SYSCTL only if enabled
12285711  [net-next,5/7] mptcp: make sure flag signal is set when add
addr with...
12285709  [net-next,4/7] mptcp: remove redundant initialization in
pm_nl_init_n...
12285707  [net-next,3/7] mptcp: generate subflow hmac after
mptcp_finish_join()
12285705  [net-next,2/7] mptcp: using TOKEN_MAX_RETRIES instead of magic
number
12285703  [net-next,1/7] mptcp: fix pr_debug in mptcp_token_new_connect

12285667  [net,4/4] mptcp: update selftest for fallback due to OoO
12285665  [net,3/4] mptcp: do not reset MP_CAPABLE subflow on mapping
errors
12285663  [net,2/4] mptcp: always parse mptcp options for MPC reqsk
12285661  [net,1/4] mptcp: fix sk_forward_memory corruption on
retransmission


    our repo (by: Geliang Tang):

12263877  [mptcp-next] Squash to "mptcp: generate the data checksum"



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

12278269: Needs ACK: [v8,mptcp-next,1/4] mptcp: add sysctl
allow_join_initial_addr_port
12278271: Needs ACK: [v8,mptcp-next,2/4] mptcp: add allow_join_id0 in
mptcp_out_options
12278273: Needs ACK: [v8,mptcp-next,3/4] mptcp: add deny_join_id0 in
mptcp_options_received
12278275: Needs ACK: [v8,mptcp-next,4/4] selftests: mptcp: add
deny_join_id0 testcases:
    - Paolo will have a look at it

12279739: Changes Requested: [RFC,3/4] mptcp: move the whole rx path
under msk socket lock protection
12279741: Changes Requested: [RFC,4/4] mptcp: cleanup mem accounting.:
    - these 2 patches can be archived
    - (see discussion from last week for intro)
    - quite a lot of complexity has been removed :)
    - but perf impact can be quite significant :(
    - still the clean-up seems needed for long-term maintainability
    - Paolo tried a variance but it was not a success → this RFC series
looks like the best option but perf impact
    - It doesn't seems like there are other solutions

    - 2 options now:
        - something similar to what we have: different lock for mem
accounting and tx path:
            → we keep the complexity not to keep the lock too often
        - what Paolo proposed to simplify how the locking is done:
            → is the perf impact too large?
            → is it fixing issues?:
                - no, perfing outlined an issue possibly related to
maybe #137. That is quite series and should likely addresses first
                - (not sending enough MPTCP ACK?)

    - Idea would be to:
        - we can apply them and see if that fixes bugs
        - but first a few items need to be addressed + re-measure perf
impact

12282131: Queued: [v3,mptcp-next] mptcp: drop tx skb cache:
    - TODO: Matth: to apply

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

12282235: Queued: [mptcp-net] mptcp: try harder to borrow memory from
subflow under pressure:
    - TODO: Matth: to apply → Done

12284731: Queued: [v2,mptcp-next] mptcp: use fast lock for subflows when
possible.:
    - TODO: Matth: to apply

12284819: Under Review: [mptcp-net] mptcp: wake-up readers only for in
sequence data.:
    - a proposition to change "mptcp_data_avail" but not for -net
    - a follow-up patch will be proposed for net-next only
    - TODO: Matth: to apply (but without some typos in the commit
message) → Done

12284905: Queued: [mptcp-next,1/2] mptcp: don't clear MPTCP_DATA_READY
in sk_wait_event()
12284907: Queued: [mptcp-next,2/2] mptcp: drop rendundant test in
move_skbs_to_msk():
    - TODO: Matth: to apply

12291967: Queued: [v2,mptcp-net] mptcp: fix soft lookup in
subflow_error_report().:
    - v3 is needed (v2 == v1) → Done

12296959: Changes Requested: [mptcp-net] selftests: mptcp: enable
syncookie only in absence of reorders:
    - TODO: switch to Superseded (new patch has just been shared) → Done

12296967: New: [v2,mptcp-net] mptcp: do not warn on bad input from the
network:
    - Can be reviewed → Done
    - We should not WARN() on bad input:
        - panic_on_warn
        - or DDOS

12297229: New: [mptcp-next] mptcp: add MIB counter for invalid mapping:
    - A v2 has already been shared!



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 196)

  199  deadlock in subflow_error_report() [bug] @pabeni:
      - seen when trying to repro issues/196
      - should be addressed by "mptcp: fix soft lookup in
subflow_error_report()." (waiting for v3)

  198  selftests: connect: "poll timed out" (POLLERR/POLLNVAL) with
syncookies [bug]:
      - With SYN Cookies, re-order can cause RST, that's normal
      - We should avoid using SYN Cookies with re-order
      - We were forcing tcp_syncookies=2 in the selftests in some netns
      - addressed with "selftests: mptcp: enable syncookie only in
absence of reorders"

  197  more mibs needed [enhancement]:
      - "Partially" addressed by "mptcp: add MIB counter for invalid
mapping"
      - but hard to cover everything
      - Still, we don't have indications about sent/received bytes for
MPTCP connections:
          - or track segments/DSS
          - the receiver part is a bit more tricky: we might not be
holding the MPTCP socket lock
          - tracking the received/transmitted bytes seems easier.


    Bugs (opened, flagged as "bug" and assigned)

  199  deadlock in subflow_error_report() [bug] @pabeni:
      - see above

  196  warn_bad_map on 5.12.0 [bug] @pabeni:
      - see above

  191  Could you please let me know how to use "ip mptcp end points
backup"? [bug] [question] @matttbe:
      - 5.12 kernel: 'subflow backup' was ignored:
          - backport to stable?
      - client with 5.13:
          - 'subflow backup' is taken into account → SYN+MP_JOIN+backup
          - but there is traffic on the backup link:
              - Maybe, we allow retransmissions (reinjections) on the
backup link
              - if the non backup link is lossy, we can have a lot of
reinjections, see another issue
            - bug here?
      - server with 5.13: 'signal backup' is not taken into account:
          - non supported here, similar to what was done in v5.13 for
the client?


    Bugs (opened and flagged as "bug" and not assigned)

  198  selftests: connect: "poll timed out" (POLLERR/POLLNVAL) with
syncookies [bug]:
      - TODO: can be assigned to Paolo → Closed

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]
  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug]
  120  [interop] netnext is dropping packets, causing MPTCP-level
retransmissions on mptcp.org [bug]

  107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]:
      - Can be closed once "mptcp: do not warn on bad input from the
network" has been applied
      - Paolo looked at all the WARN_ON* and all the others still make
sense (not reachable from a bad input packet)
      - TODO: Matth → Closed

   65  clearing properly the status in listen() [bug]
   56  msk connection state set without msk lock [bug]


    In Progress (opened and assigned)

  194  Round-robin packet scheduler support [enhancement] @geliangtang
  193  Fullmesh path manager support [enhancement] @geliangtang
  189  Wireshark / TCPDump doesn't understand option subtype 8
(MP_TCPRST) [enhancement] @dcaratti
  188  Netlink events for MP_TCPRST [enhancement] @dcaratti

  187  add recvmsg support for ancillary data [enhancement] @fw-strlen:
      - Can be closed?
      - do we need support for the send part? If yes, please fill in a
new issue

  186  Add netlink command support [enhancement] @mjmartineau
  183  MP_CAPABLE 'C' flag is ignored [enhancement] @geliangtang
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti
   52  MP_FAIL support [enhancement] @geliangtang


    Recently closed (since last week)

  192  selftests: connect: "poll timed out" issue [bug] @pabeni
   96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.14):
https://github.com/multipath-tcp/mptcp_net-next/projects/9
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - net:
        - nothing in the export branch but some patches are waiting to
be applied
        - we can wait until next week to send these new ones

    - net-next:
        - checksum:
            - best to wait for interop first
        - best to start with cmsg: → Done
            - if there is any conflicts



Extra tests:
    - news about Syzkaller? (Christoph):
        - Mat is looking at having a bigger VM to have tests running faster

    - news about interop with mptcp.org? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - No failure

    - packetdrill (Davide):
        - /

    - CI (Matth):
        - Some instabilities on Tessares server:
            - similar to what is reported to the public CIs
            - but more frequent these days
            - maybe tests are not "robust enough"?
            - something else has introduced more delay, etc.?



mptcpd:
    - RHEL reported the use of a forbidden function inet_ntoa
    - Davide will address this warning



Patchew:
    - Davide will ask



IRC:
    - OK to have all messages from the bot on #mptcp-ci? (not so many
people there)
    - Feel free to join this channel :-) (and feel free to mute it ;-) )
    - or other kind of notification? No



Next meeting:
    - On Thursday, the 10th of June.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210610



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
