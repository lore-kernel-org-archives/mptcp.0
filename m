Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767072
	for <mptcp@lists.linux.dev>; Thu, 30 Sep 2021 16:48:19 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id x7so23604963edd.6
        for <mptcp@lists.linux.dev>; Thu, 30 Sep 2021 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=cIA2Yd5U8+crre7PuHhqSBv0Cr0aBT/JeNsodpjNrVc=;
        b=JCRAc5iNaM8Acf2GEXlZdGujufMy16b2nYXG0fIilYiT2/L0Kb0b3hm3PRm5bVRPXB
         OesX2W8msZiVNHDKMdgHmqpFvULN0LhbJ6uRFm52PwkS+DNdqdkOz9WL/sRMabgBA+Oe
         xEoCJfN3s1p7t+cr2XIsEa6HnSr0gTC8sgQSu+3TUiophDcx/xQbAOst3yOzkNoxZdmV
         JgzyzvlJYsaY5Ajb0Dv+s0bje1Welz0aumLfoNbw+qDbXQpB628qvWhFBMGsHuXFf5PU
         uy7isF8BEpL5xJ0NuDH2N66VqgnJ2hrYyQoS2nodWlEhmWbPWEFX/oz2wW4L1FcboTL1
         b5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=cIA2Yd5U8+crre7PuHhqSBv0Cr0aBT/JeNsodpjNrVc=;
        b=YyIT7M4IoZA+W9GHDDDqBaGSHRTKhVfh6G3LxTNCzuR94bnlL+4uXmYuX/1AZN7jBe
         pQHjJJ7/TtUQZ7H+2Ahj2r8qajmNZ1dotvbaPWYlGKLKBaX9Cu/vtv+9PjQxlRTzhdlF
         tYeFO1zKHg6XhRh4lo8wf8RrBbt78ZBuvrYVo/kAcZfkW1Q1hQcty7QWldUH6MLCN52U
         aTyyH+ufFbo1TuX8QhVG8qifPIBN997ciuk4SLI7vbOYK8R2nVhDtqdK1gxXKq8ADbp/
         l+p6QpF1ZoZ0gxs0FCwLQvlfFSlOvEjjsuIO68pOF1kwZaJNNm+o7YVHt9gVuIeZqaRI
         3L+Q==
X-Gm-Message-State: AOAM532yT/mDdmN1PQkiukt69vuc+0cCkEMnzFXtr9SKeLgtZnax1lyG
	hKeTYRsXRYQ9jyv1XJ1BJsVInjQbLLjisg==
X-Google-Smtp-Source: ABdhPJyRIa7+Fdp5GPZWd3CvwfYDV1lEMWgCfcvbjVyIDAUVaAze/wSx7kjx7AKvtpUE1zQwrIbONQ==
X-Received: by 2002:aa7:d0c5:: with SMTP id u5mr8211030edo.130.1633020495813;
        Thu, 30 Sep 2021 09:48:15 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.102.72.dyn.edpnet.net. [94.105.102.72])
        by smtp.gmail.com with ESMTPSA id t6sm1773250edr.87.2021.09.30.09.48.14
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 09:48:15 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 23rd of September 2021
Message-ID: <440b1c39-f411-4e5a-22a8-50c78c478c65@tessares.net>
Date: Thu, 30 Sep 2021 18:48:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
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

Last Thursday, we had our 166th meeting with Mat, Ossama (Intel),
Christoph (Apple), Florian, Paolo, Davide, Poorva (Red Hat), Geliang
(Xiaomi) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau, Paolo Abeni):

12510287  [net] mptcp: ensure tx skbs always have the MPTCP ext

12503109  [net-next,5/5] selftests: mptcp: add mptcp getsockopt test cases
12503111  [net-next,4/5] mptcp: add MPTCP_SUBFLOW_ADDRS getsockopt support
12503107  [net-next,3/5] mptcp: add MPTCP_TCPINFO getsockopt support
12503105  [net-next,2/5] mptcp: add MPTCP_INFO getsockopt
12503103  [net-next,1/5] mptcp: add new mptcp_fill_diag helper:
    - Series: mptcp: Add SOL_MPTCP getsockopt support

12511109  [net-next,4/4] tcp: remove sk_{tr}x_skb_cache
12511107  [net-next,3/4] tcp: make tcp_build_frag() static
12511105  [net-next,2/4] mptcp: stop relying on tcp_tx_skb_cache
12511101  [net-next,1/4] tcp: expose the tcp_mark_push() and
tcp_skb_entail() h...:
    - Series: net: remove sk skb caches
    - Accepted by Eric Dumazet
    - Applied by David Miller (including a cherry-pick of the dependence)


    our repo (by: Florian Westphal, Matthieu Baerts, Paolo Abeni):

12503675  [mptcp-next] Squash to "mptcp: don't return sockets in foreign
netns"

12499591  [mptcp-net] mptcp: always provide MPTCP skb ext for tx skb

12496107  mptcp: don't return sockets in foreign netns



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Davide Caratti, Geliang Tang, Jiapeng Chong, Matthieu
Baerts, Paolo Abeni, Tim Gardner):

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

12321111: Changes Requested: mptcp: Remove redundant assignment to
remaining:
    - TODO

12476757: Changes Requested: [RFC] selftests: mptcp: tune timeout and
delay for simult_flows cases:
    - WIP

12478263: RFC: [RFC,mptcp-next,1/4] mptcp: add a new sysctl scheduler
12478265: RFC: [RFC,mptcp-next,2/4] mptcp: add struct mptcp_sched_ops
12478267: RFC: [RFC,mptcp-next,3/4] mptcp: round-robin packet scheduler
support
12478269: RFC: [RFC,mptcp-next,4/4] selftests: mptcp: add round-robin
testcase:
    - Series: round-robin packet scheduler support
    - We don't really need the round-robin packet scheduler
    - The github issue 194 (Round-robin packet scheduler support) was
more to show that an extended packet scheduler is possible if we have a
BPF framework or similar
    - We can archive this series
    - And close #194, only keep #75 (BPF: packet scheduler) to avoid
confusions
    - TODO: Matth: do ↑ → Done

12503619: Changes Requested: [mptcp-next,v4,1/8] mptcp: track and update
contiguous data status
12503621: Changes Requested: [mptcp-next,v4,2/8] mptcp: add
last_fully_acked_dss_start_seq in the msk
12503623: Changes Requested: [mptcp-next,v4,3/8] mptcp: infinite mapping
sending
12503625: Changes Requested: [mptcp-next,v4,4/8] mptcp: add the fallback
check
12503627: Changes Requested: [mptcp-next,v4,5/8] mptcp: infinite mapping
receiving
12503629: Changes Requested: [mptcp-next,v4,6/8] mptcp: add mib for
infinite map sending
12503631: Changes Requested: [mptcp-next,v4,7/8] selftests: mptcp: add
infinite map mibs check
12503633: Changes Requested: [mptcp-next,v4,8/8] DO-NOT-MERGE: mptcp:
mp_fail test:
    - The infinite mapping support
    - Mat reviewed the v4
    - Still some opened questions to simplify some parts
    - fallback is tricky and we can also move in steps, e.g. kill the
connection for corner cases
    - Would be best to have some feedback from *Christoph* to know if it
is frequent to have to fallback in the middle of a connection:
        - if not, it seems fine to kill the path / connection and not
fallback
    - for 8/8 patch, it could be good to modify (corrupt) the packet
with netfilter (u32?) or tc to force a checksum issue:
        - Davide will check that and continue the discussion on IRC/ML

12505753: Changes Requested: [next] mptcp: Avoid NULL dereference in
mptcp_getsockopt_subflow_addrs():
    - See issue 231 below

12507727: Queued: [mptcp-next,v2,1/3] Squash-to: "tcp: expose the
tcp_mark_push() and skb_entail() helpers"
12507725: Queued: [mptcp-next,v2,2/3] Squash-to: "mptcp: stop relying on
tcp_tx_skb_cache"
12507729: Queued: [mptcp-next,v2,3/3] tcp: make tcp_build_frag() static:
    - already sent and applied upstream
    - TODO: Matth: make sure we don't have conflicts with net-next→ Done
    - Note: "mptcp: ensure tx skbs always have the MPTCP ext" is also
different.

12510723: Queued: [mptcp-net,v2] mptcp: allow changing the 'backup' bit
when no sockets are open:
    - Reviewed by Mat
    - TODO: Matth: apply it → Done

12512357: New: [mptcp-net] mptcp: fix possible stall on recvmsg():
    - TODO: add "Reported-by" → Done
    - syzbot said it is OK
    - This is OK for -net but a better solution seems to drop
MPTCP_DATA_READY flag but this was quite invasive.
    - Paolo did some modifications and this patch is now smaller and it
seems better
    - So if everything is OK with syzbot and others, we can drop this
patch (mptcp: fix possible stall on recvmsg()) and keep this new patch

12512437: New: [mptcp-net] net: introduce and use lock_sock_fast_nested():
    - fixing a false-positive report from syzbot
    - Suggested-by Thomas Gleixner
    - We are in the slow path, we don't really need the fast version but
we can also expose a new function as Paolo did



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 230)

  231  Static analysis - possible NULL dereference in
mptcp_get_sub_addrs() [bug] @mjmartineau:
      - linked to "mptcp: Avoid NULL dereference in
mptcp_getsockopt_subflow_addrs()"
      - but the patch is: if there is an issue, it doesn't really fix
the issue
      - so the question is: is it possible to have a connection in
TIME_WAIT at that time
      - But it seems we need to dig into the code
      - Maybe best to handle it if we are unsure or very little chance
to get it
      - Note: there is a setsockopt() that transforms v4 to v6 but
(hopefully) not supported with MPTCP sockets → IPV6_ADDRFORM


    Bugs (opened, flagged as "bug" and assigned)

  231  Static analysis - possible NULL dereference in
mptcp_get_sub_addrs() [bug] @mjmartineau:
      - ↑


    Bugs (opened and flagged as "bug" and not assigned)

  230  selftests: mptcp_connect: poll timed_out [bug] [selftests]
  225  selftests: join: "remove subflows and signal" is unstable [bug]
[selftests]
  203  PM: server: accept subflows [bug]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]
  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug]
   65  packetdrill/fixes: clearing properly the status in
listen()/disconnect [bug]


    In Progress (opened, new feature and assigned)

  216  The infinite mapping support [enhancement] @geliangtang
  194  Round-robin packet scheduler support [enhancement] @geliangtang

  186  Add netlink command support [enhancement] @mjmartineau:
      - API will be different but that's just about the index, the
semantic will stay the same
      - we don't have a binary compatibility but that seems OK

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti


    For later (opened and not assigned assigned)

  224  support for `setsockopt(TCP_INQ)` [enhancement]
  222  Netlink event API: add SUBFLOW_CREATED event [enhancement]
  220  support for setsockopt(SOL_IP) [enhancement]
  217  Support `IP_TRANSPARENT` [enhancement]
  215  TCP Urgent pointer and MPTCP [enhancement]
  213  add MPTCP man page [enhancement]
  210  Accept new subflows when the listening socket is closed or bind
to one IP? [enhancement]
  208  better handing of ssk memory pressure in the TX path [enhancement]
  202  Add sendmsg support for ancillary data [enhancement]
  197  more mibs needed [enhancement]
  180  Get an update when MPTCP fall back to TCP [enhancement]
  177  improve retransmit subflow selection [enhancement]
  171  iproute2: support removing ID 0 [enhancement] [iproute2]
  169  packetdrill: add coverage for ADD_ADDR and MP_JOIN on a different
port [enhancement] [packetdrill]
  163  allow ss dumping msk socket in TCP_LISTEN status [enhancement]
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
   75  BPF: packet scheduler [enhancement]
   74  BPF: path manager [enhancement]
   61  move msk clone after ctx creation [enhancement]
   59  TFO support [enhancement]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   48  MP_FASTCLOSE support (send part remaining) [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]
   18  allow 'force to MPTCP' mode: sysctl [enhancement]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.16):
https://github.com/multipath-tcp/mptcp_net-next/projects/11
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
    - TODO: changelog: Matth



Patches to send to netdev:
    - net:
        - We can send: " mptcp: don't return sockets in foreign netns" →
ready
        - "mptcp: allow changing the 'backup' bit when no sockets are
open" is queued but should be ready soon

    - net-next:
        - we can send all the patches in the current export branch that
have not been sent yet.
        - Mat will send them.



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - syzbot found a few issues
        - some issues were specific to -net and not present on net-next
        - but probably fine to focus on the export branch
        - changing kconfig might help finding other issues
        - maybe good to look at the kconfig used by syzbot

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - did get any news since last week, probably an issue on kbuild side
        - Mat will check that

    - packetdrill (Davide):
        - Davide merged an (old) PR to cover ADD_ADDR retransmission
        - there is a on-going PR about RM_ADDR covering
        - Poorva is looking at a DSS len issue with MPC+datalen+checksum:
            - Maybe an issue with packetdrill
            - the packet looks correct but packetdrill thinks it is an
invalid packet
        - In the same situation, the receiver key was not OK but it
looks impossible and the test needs to be re-validated with the latest
kernel
        - Could be good to check if syncookie is used or not. If it is
used, we might not cover this path properly
        - Davide and Poorva will follow-up on this

    - Patchew (Davide):
        - The new dedicated user now has write access
        - But we might need to patch patchew to change the author:
            - but it might not be necessary, as long as we can create a
tag and push it

    - CI (Matth):
        - /


Next meeting:
    - On Thursday, the 30th of September.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210930



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
