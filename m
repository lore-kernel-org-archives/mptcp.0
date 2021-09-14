Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A33FD0
	for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 07:11:33 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id jg16so26641224ejc.1
        for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 00:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=J4rMyb9569gr8+2QYfdi2V2lvc9FbJvMhcWxFH4K64E=;
        b=PYQFTqre1M9q0PU7ib8uEv+ipnfpAwM2wnQl5wCMfrepRz5evRk3bav5eDQ56DNU49
         VfXnpr68Fuq0bsbRk3wQLhvbtV3n539Icl9CVAr5mpbp2UMe/j/BqSoyAWcD4ovxnyPT
         T8PwHeaCuemWm9i7QGfjE30xaej+6RrkocThe5P5+tSgLK3+FZNaoIk+ZEq+aYYtfiln
         HzOfgizido+rm2FSfnmxVXfVFUqWbbu7A6GHcN8XBlA++zw6caYmiuzPxZeVR4q4rBdK
         T9zhSmQ/C+tKuNwFXTuo9cO/oopF3xVVcd/OasmwUkhcqvvD7C76m26KnTA6EjsDKXk5
         ra7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=J4rMyb9569gr8+2QYfdi2V2lvc9FbJvMhcWxFH4K64E=;
        b=YrGfnIzXU7pXmRI+7LeiITnE/Jf1YbilEgd3CR+eN1CeXoG8nk8ut/znCLjtcyz7wo
         JzLd5RQGlJM1RAilDMj9j4OBlleiguwMZ7IKP5ck2IdJWAPcaOkrWfR3S72RQyr5fC78
         1AZovO9/511azKYx8uJsJ+bg2ETrmfveEukSfy2VVqunIL6F29mL+XdF+ZpoZsf8QNnu
         SI7gDAazjgNvSr498T3DGFWshkfjb3p7DkMFL1orQ7Oesjll5MTQ0S+nScyKBsGE4ZW3
         M6Z8Bd1GZ0xvcAJ9Ll8xIhF5LOWLWiz3AyeXR8qTG31drV4MUfqja8tU1LIpnAGS2sDa
         QOPw==
X-Gm-Message-State: AOAM531oY+Eu3Ib46OOs0wXXUHGLg52LYSI8mrujB9mywaFJyjpQNe/Q
	NuQWJCw3MyowWuScz3r+4Oj1H5hysp2KE83k
X-Google-Smtp-Source: ABdhPJw5lbN51iCNiZQJvZO5ZSL7d6IlH9Qkr5Y5pgTCOMiuwBhrOm2oi/IjAT5/VLMIlxu3tVwQLg==
X-Received: by 2002:a17:906:3c56:: with SMTP id i22mr17421480ejg.287.1631603490793;
        Tue, 14 Sep 2021 00:11:30 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:ebf0:ffa:92c5:dacd])
        by smtp.gmail.com with ESMTPSA id z3sm4114258eju.34.2021.09.14.00.11.30
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:11:30 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 9th of September 2021
Message-ID: <862b1b66-7307-b0de-ca0b-f61434b12873@tessares.net>
Date: Tue, 14 Sep 2021 09:11:29 +0200
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

Last Thursday, we had our 164th meeting with Mat, Ossama (Intel),
Christoph (Apple), Florian, Paolo, Davide, Poorva (Red Hat), Geliang
(Xiaomi) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3



    netdev (if mptcp ML is in cc) (by: Mat Martineau ):

12472319  [net] mptcp: Only send extra TCP acks in eligible socket states


    our repo (by: Geliang Tang, Paolo Abeni):

12474537  [mptcp-next] mptcp: use lockdep_assert_held_once() instead of
open-co...

12471957  [v2,mptcp-next,4/4] tcp: remove sk_{tr}x_skb_cache
12471955  [v2,mptcp-next,3/4] Partially revert "tcp: factor out
tcp_build_frag(...
12471953  [v2,mptcp-next,2/4] mptcp: stop relaying on tcp_tx_skb_cache.
12471951  [v2,mptcp-next,1/4] tcp: expose the tcp_mark_push() and
skb_entail() ...

12471083  [v2,mptcp-next] mptcp: use OPTIONS_MPTCP_MPC



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Florian Westphal, Geliang Tang, Jiapeng Chong,
Matthieu Baerts, Paolo Abeni):

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

12476737: Queued: [mptcp-next] Squash-to: "mptcp: stop relying on
tcp_tx_skb_cache":
    - TODO: Matth: To apply

12476757: Needs ACK: [RFC] selftests: mptcp: tune timeout and delay for
simult_flows cases:
    - v2 needed for this one

12476961: Queued: [mptcp-next,v2,1/2] mptcp: remove tx_pending_data
12476963: Queued: [mptcp-next,v2,2/2] mptcp: re-arm retransmit timer if
data is pending:
    - Series: Fix mptcp connection hangs after link failover
    - TODO: Matth: To apply → Done

12478263: RFC: [RFC,mptcp-next,1/4] mptcp: add a new sysctl scheduler
12478265: RFC: [RFC,mptcp-next,2/4] mptcp: add struct mptcp_sched_ops
12478267: RFC: [RFC,mptcp-next,3/4] mptcp: round-robin packet scheduler
support
12478269: RFC: [RFC,mptcp-next,4/4] selftests: mptcp: add round-robin
testcase:
    - round-robin packet scheduler support
    - a few minors comments
    - but the main question is to know if it makes sense introduce such
packet scheduler
    - round-robin packet scheduler was there in mptcp.org mostly to
validate we could add new packet schedulers as a modules
    - If we want to allow packet schedulers to be implemented in eBPF,
we will need the structure that is in place
    - But maybe we don't want to maintain a RR packet scheduler (and
answer questions about it)

12482695: New: [mptcp-next] chtls: rename skb_entail() to
chtls_skb_entail():
    - there is a new naming conflict introduced by "mptcp: just another
xmit path refactor"
    - Reported by Intel's kbuild bot
    - should be placed in the right order

12482965: New: [mptcp-next,v2,1/9] mptcp: add noncontiguous flag
12482967: New: [mptcp-next,v2,2/9] mptcp: add MPTCP_INFINITE_DONE flag
12482969: New: [mptcp-next,v2,3/9] mptcp: add MAPPING_INFINITE mapping
status
12482971: New: [mptcp-next,v2,4/9] mptcp: add start_seq in the msk
12482973: New: [mptcp-next,v2,5/9] mptcp: infinite mapping sending
12482975: New: [mptcp-next,v2,6/9] mptcp: infinite mapping receiving
12482977: New: [mptcp-next,v2,7/9] mptcp: add a mib for the infinite
mapping sending
12482979: New: [mptcp-next,v2,8/9] selftests: mptcp: add infinite map
mibs check
12482981: New: [mptcp-next,v2,9/9] DO-NOT-MERGE: mptcp: mp_fail test:
    - Series: The infinite mapping support
    - Mat will have a look at the v2
    - Paolo will also check:
        - to trigger the infinite mapping in the self-tests: replace
TCP options with NOPs, more details will be sent on the ML
    - Mat had a question about the fallback after an infinite mapping:
        -
https://lore.kernel.org/mptcp/71790a1-de87-bd6e-dcec-96214b895d42@linux.intel.com/
        - in mptcp.org, there is a fallback
    - The last patch should not be sent to netdev
    - Would be really good to have a packetdrill test as we have more
control, we can simulate a checksum issue
    - We can also alter the data to break the MPTCP Checksum
    - (TC can also recompute TCP Checksum)



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 229)

  230  selftests: mptcp_connect: poll timed_out [bug] [selftests]:
      - Reproduced only by the public CI with a debug config
      - Maybe fixed with Florian's patches:
          - Series: Fix mptcp connection hangs after link failover


    Bugs (opened, flagged as "bug" and assigned)

  226  selftests: `mptcp_join.sh -l`: copyfd_io_poll: poll timed out
error [bug] [selftests] @fw-strlen:
      - Should be fixed with "Fix mptcp connection hangs after link
failover" series


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

  216  The infinite mapping support [enhancement] @geliangtang:
      - See patches above

  194  Round-robin packet scheduler support [enhancement] @geliangtang:
      - See patches above

  186  Add netlink command support [enhancement] @mjmartineau
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


    Recently closed (since last week)

None.



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.14):
https://github.com/multipath-tcp/mptcp_net-next/projects/10
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
    - TODO: Matth: Update it



Patches to send to netdev:
    - net:
        - /

    - net-next:
        - net-next is closed!



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - no news good news

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - A new issue has been reported
        - Not a lot of builds because the export branch is not modified
often these days (net-next is closed)
        - There are issues to build the latest export branch but maybe
due to something else upstream:
            - Mat will have a look and we might include another patch
for the moment to have the build succeeding.

    - packetdrill (Davide):
        - PR from Poorva has been accepted: mptcp: Validating
sockopt(TCP_INQ) and sockopt(IP_TOS) \o/

    - Patchew (Davide):
        - Davide is going to deploy a new importer on a VM
        - We can start sending patches to the official GH.
        - The importer node applies patches then send the tag
        - David will create a dedicated GH account for this user and
send info to Matth

    - CI (Matth):
        - sparse has been update to the latest version and now found new
issues:
            - net/mptcp/pm_netlink.c:622:23: warning: context imbalance
in ''mptcp_pm_nl_add_addr_received'' - unexpected unlock
            - Maybe not an issue (false positive)



Next meeting:
    - On Thursday, the 16th of September.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210916



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
