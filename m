Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F202C81
	for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 17:13:27 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id ec8so1011445edb.6
        for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 10:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=+LVu2A9/eKA8Qpfg8Gn3Zs37n4mcB4rY+OzOxA6L/Mc=;
        b=jLVtPgIjc0OCnIFmTJ/0wEgdLVLwXYjQ6CFSOzwIyrjJamAXFV+gGkOyT4Ny3OilvM
         rKAdWbLi6sJPEJsd3xTdHd3yStiuIqS6E6bWJkE5ZWTaIkrApFzPEubcW6oXQjZlMJxB
         m0cJxBYr+1maxiUO9aj9BaqMDqQY/foJGE9uA47ds+QIXB4t0SYynQbLJeU8qXCB8ie8
         7iixEGuNlWMcd0TQsHLo83le+v5vWm1cJsuLcSWPNmAyLeFomhRLl0j21IA7gDZg5qj9
         4a3RbVJpLPPtK3nnOLmX0UgL89hi9rsNcTcA0VPDvsZQ8NUr5neO0uEeXy/EOHcUL1xa
         MMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=+LVu2A9/eKA8Qpfg8Gn3Zs37n4mcB4rY+OzOxA6L/Mc=;
        b=EbkdgC8NhvbpsBScLbSph1wz5dFQdLDfFdaVYtr7focOJyo7WeAQpbiCn7KEl682ea
         YSuElFk4Nmm+6f73IcEXyuy67wc7DbeHJ0Jc+2TuqiTVVHR/pQacroO9FZNaQBRqauUN
         aRBI2wLZBbI0FvpNcCnMBaq/yHrh0Oeo0VAX4XjWlPeHbi0xa5b4U8raGSKpQ+Vja07+
         6G89/WeAPmZDvUhhNPMbYtg7nV2ZIz2MR3BdhyK27mYcAYIFU+K3O+NNjQdpBYPkgAtN
         jXggeJEEo4YnbyzFy9yKI9lYkvKBXon0rHLQ7pvsoBqsLoYDqqs/ZT3UzIM9B9deh+kn
         VqGQ==
X-Gm-Message-State: AOAM5327UQwxF/Yyo+vQE7CirYDPu014W/Nx4x5OaVl5wMGwgFgrsRls
	Q8rLYuQlUI4C3POSRwuO2HvyZQhqoGGidUufbzk=
X-Google-Smtp-Source: ABdhPJzpg5C4yOLx1r5UkyVE4fo6PWDoCMXqAwZeDawu3T44KTf8R0jh5V/dgYtQxQX2HhtaPcajvw==
X-Received: by 2002:a50:da45:: with SMTP id a5mr9470885edk.306.1634836405165;
        Thu, 21 Oct 2021 10:13:25 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id bm1sm2786205ejb.38.2021.10.21.10.13.24
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 10:13:24 -0700 (PDT)
Message-ID: <f570fae3-6475-3160-bca3-b384d3ec5361@tessares.net>
Date: Thu, 21 Oct 2021 19:13:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 21st of October 2021
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we just had our 170th meeting with Mat, Ossama (Intel), Florian,
Paolo, Davide, Poorva (Red Hat), Geliang (Suse), Giray (Parkyeri) and
myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Davide Caratti, Mat Martineau,
Paolo Abeni):

12562951  [net-next,3/3] mptcp: Make mptcp_pm_nl_mp_prio_send_ack() static
12562949  [net-next,2/3] mptcp: increase default max additional subflows
to 2
12562953  [net-next,1/3] mptcp: Avoid NULL dereference in
mptcp_getsockopt_subf...

12552925  [iproute2-next] mptcp: cleanup include section.

12528673  [iproute2] mptcp: unbreak JSON endpoint list


    our repo (by: Geliang Tang, Mat Martineau, Paolo Abeni):

12574455  [mptcp-next] selftests: mptcp: fix proto type in link_failure
tests

12566087  [mptcp-next] mptcp: drop unused sk in mptcp_push_release

12562403  [mptcp-next,v2,3/3] mptcp: allocate fwd memory separatelly on
the rx ...
12562401  [mptcp-next,v2,2/3] net: introduce sk_forward_alloc_get()
12562399  [mptcp-next,v2,1/3] tcp: define macros for a couple reclaim
thresholds

12562333  [RFC,v2] selftests: mptcp: more stable simult_flows tests

12540797  [mptcp-next] mptcp: Make mptcp_pm_nl_mp_prio_send_ack() static



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Davide Caratti, Geliang Tang, Jiapeng Chong, Kishen
Maloor, Mat Martineau, Matthieu Baerts, Paolo Abeni, Poorva Sonparote):

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
    - TODO (anyone?)

12476757: RFC: [RFC] selftests: mptcp: tune timeout and delay for
simult_flows cases:
    - TODO: Superseded → Done

12540789: Changes Requested: [RFC,1/6] mptcp: Add a member to
mptcp_pm_data to track kernel vs userspace mode
12540781: Changes Requested: [RFC,2/6] mptcp: Bypass kernel PM when
userspace PM is enabled
12540783: Changes Requested: [RFC,3/6] mptcp: Make kernel path manager
check for userspace-managed sockets
12540791: Changes Requested: [RFC,4/6] mptcp: Add a per-namespace sysctl
to set the default path manager type
12540787: Changes Requested: [RFC,5/6] DO-NOT-MERGE: debug: mptcp: Warn
on use of in-kernel PM functions
12540779: Changes Requested: [RFC,6/6] DO-NOT-MERGE: debug: mptcp: Warn
on unexpected events when userspace PM is active
12540931: Changes Requested: [RFC,1/4] mptcp: pm_netlink: Add
MPTCP_PM_CMD_ANNOUNCE
12540933: Changes Requested: [RFC,2/4] mptcp: selftests:
MPTCP_PM_CMD_ANNOUNCE
12540935: Changes Requested: [RFC,3/4] mptcp: pm_netlink: Add
MPTCP_PM_CMD_REMOVE
12540937: Changes Requested: [RFC,4/4] mptcp: selftests:
MPTCP_PM_CMD_REMOVE:
    - Series: mptcp: Add userspace PM mode to bypass kernel PM
    - Series: mptcp: Update netlink interface for userspace PM
    - Mat, Kishen and Ossama are working on validating that

12566305: Changes Requested: [mptcp-next,v7,1/8] mptcp: don't send RST
for single subflow
12566307: Changes Requested: [mptcp-next,v7,2/8] mptcp: add the fallback
check
12566309: Changes Requested: [mptcp-next,v7,3/8] mptcp: track and update
contiguous data status
12566311: Changes Requested: [mptcp-next,v7,4/8] mptcp: infinite mapping
sending
12566313: Changes Requested: [mptcp-next,v7,5/8] mptcp: infinite mapping
receiving
12566315: Changes Requested: [mptcp-next,v7,6/8] mptcp: add mib for
infinite map sending
12566317: Changes Requested: [mptcp-next,v7,7/8] selftests: mptcp: add
infinite map mibs check
12566319: Changes Requested: [mptcp-next,v7,8/8] DO-NOT-MERGE: mptcp:
mp_fail test:
12573975: New: [mptcp-next] Squash to "mptcp: infinite mapping receiving":
    - Series: The infinite mapping support
    - One last remaining change: have an alternative not to include
patch 8/8 in the export branch:
        - Commands provided by Davide and adapted by Matth
        - Geliang will include that in a new patch

12573275: New: [RFC] Support for SOL_IP for MPTCP setsockopt:
    - some missing features mentioned there but WIP
    - Poorva will send a new version with that
    - for new subflows created after that, we use info from msk → no new
fields added

12575349: New: [mptcp-net] mptcp: fix corrupt receiver key in MPC + data
+ checksum:
    - a new version is needed to fix an issue reported by the CI
    - increase the mptcp_out_options struct size?
      → it should not be increased the size of the whole structure as it
is in an union




Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 235)

  236  Review supported sockopts list [enhancement]:
      - related to last week's discussion


    Bugs (opened, flagged as "bug" and assigned)

  234  error in packetdrill when outbound packet contains mpc+datalen
[bug] [packetdrill] @dcaratti:
      -  packetdrill does not support MPC+DATA+checksum at all.
      - Davide is working on extending the current code to support it
      - Was not supported by MPTCPv0, that's why it is not in our
packetdrill version

  233  Receiver key overwritten in a packet with mpc+data [bug] @dcaratti:
      - mptcp: fix corrupt receiver key in MPC + data + checksum


    Bugs (opened and flagged as "bug" and not assigned)

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
      - See above

  186  Add netlink command support [enhancement] @mjmartineau:
      - See above

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti
   75  BPF: packet scheduler [enhancement] @geliangtang
   74  BPF: path manager [enhancement] @geliangtang


    For later (opened and not assigned assigned)

  236  Review supported sockopts list [enhancement]
  235  PM: create new subflow after one got closed [enhancement]
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

  231  Static analysis - possible NULL dereference in
mptcp_get_sub_addrs() [bug] @mjmartineau



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.16):
https://github.com/multipath-tcp/mptcp_net-next/projects/11
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Stable versions:
    - patch "[PATCH] mptcp: fix possible stall on recvmsg()" failed to
apply to 5.10-stable tree
    - https://lore.kernel.org/stable/16345565528128@kroah.com/
    - It is possible we cannot hit the issue because some sockopts have
not been implemented, etc.
    - Maybe we don't need it?
    - Mat will check how bad is the conflict first



Patches to send to netdev:
    - net:
        - selftests: mptcp: fix proto type in link_failure tests

    - net-next:
        - fwd mem allocation:
            - could be good to send that, especially because there are
other upstream changes (TCP)

        - mptcp: drop unused sk in mptcp_push_release:
            - no need to wait for this one, can be sent

        - selftests: mptcp: more stable simult_flows tests:
            - maybe best to wait
            - Paolo is experimenting other modifications fixing HoL
blocking issues (inspired by BLEST) but some adaptations are needed,
e.g. we cannot assume the packet size, the fragmentation is done after
in upstream implementation



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - didn't find anything related to MPTCP
        - Mat also checked on -net, didn't find anything there too
        - might be good to look at other kconfig
        - sometimes there are some stalls, not detected as linked to
MPTCP but it was with MPTCP instrumentations/sockets

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - looks good but at the end of the weeks, it takes a few days to
test all new modifications of the export branch

    - packetdrill (Davide):
        - Davide is working on #234 and Poorva on SOL_IP

    - Patchew (Davide):
        - It looks like patchew re-applies a patch when someone send a
"tag" (Acked-by, etc.) as a reply
        - not clear why it re-pushes it (probably to have a commit that
can be applied directly on the final branch) or if there is an option to
disable that
        - Davide will look at that
        - If too complexes to disable, a workaround could be to disable
notification (minimum)

    - CI (Matth):
        - for patches shared on a ML:
            - nothing is done if it cannot applies on top of the export bran
            - an email notification is sent if the patch can be applied
on top of export branch and the build fails
            - successful builds are reported on patchwork
            - tests results are reported on patchwork and IRC (#mptcp-ci)
            - not reported on Patchew, not to duplicate info → devs
should look at Patchwork. Reviewers can use Patchew to easily see diff
between v1 and v2

        - Patchwork example:
https://patchwork.kernel.org/project/mptcp/patch/2e9a15d32cd39483dd1e18174d6c73b33e0566b5.1634531093.git.geliang.tang@suse.com/

        - Should we change something? (notif?) → seems OK for now
        - Ideas?:
            - checkpatch (+ codespell) → most interesting for the moment
            - regressions tests (perf/syzrepro)
            - stabilise selftests :)



CLSF2021:
    - Geliang was not able to talk at the conference because it has been
delayed due to COVID
    - Hopefully it will happen at some points (one month or two?)



Next meeting:
    - On Thursday, the 28th of October.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20211028



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
