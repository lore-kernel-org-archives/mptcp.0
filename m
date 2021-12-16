Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B554D173
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 17:05:55 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id x15so90325084edv.1
        for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 09:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=yTfeXUfh37X/l9wsKF0swWShr3zmsIEmzJdec67YPXw=;
        b=gL4WV9XKfVW2gMCxUcRb5b9erG2KKjfHA3sk7Uka0+yO+PBm98EsKw33YD/Z2FmP6C
         VDN+jcpP/+7qVBiRAhqhbij4aRsK68YbX+ShDX5quciJ2v6GNOYhCMxzAGVNflmecoWx
         O8qw0qeQ3yXsbwlGzTMzmCUQx+PSFVsRq6qQsMni2kgYlxc7ch4Bv++iYnvEvkKUAdwp
         XScJJ0Z2CmGmUpadMEL/AxiB3pyHD0kCY35WMIxLcZGXB2XbCyKj+uw1D+dtoEHUPn1j
         9gsba8Lf1XY9GWDXVU0VebpcC+loCj2oxFh1V18XCX522/sbLKo7VUXvkihlneqCBwLK
         By7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=yTfeXUfh37X/l9wsKF0swWShr3zmsIEmzJdec67YPXw=;
        b=zOyygouE+LGGpGTlB2kpfu3otEJBBD4jFDzT2kaqAQhwc6O1MQ7V6WJJX9wOBPCMaE
         AVABsGo5FnKHJkULtStCsR7GDaCA7zq3qfL2xePrQLYSHcKgjQ8pBUy+VSMCbP1oHYqT
         elsgcYYucNbIr2h8xeGsQRng527REgki+DA6Bg7azMJ1Y8VGdL2lB8FpHjyE5uVyqQ02
         y31EvxJI3alVYvWXgfZtf9RFLj9KS3Ohl+MXbADkXAL7C6RNXCAUm/1zW9vn6PTm6td7
         R15VvSfqeUraJK2jPJGnEi5J47nbxlwBHu6IBBN3l9asORO6b9DdN8+wZiSaakvsrHCE
         pa3w==
X-Gm-Message-State: AOAM531Yh20AQTQYMaxK+dlCtH7n5fEsLGvYPo4Iti9DAbinx32kMfTd
	eEL7gN5UHiupKrG4Fr4GA32PMPCC7YW48Q==
X-Google-Smtp-Source: ABdhPJwExbzbzhljArRtEuzAPIZVOfwIhgJIkIjvMi8tdq+2qpjDXKA0oQ7QpZA4ECXAVJhZCZ7w7g==
X-Received: by 2002:a05:6402:2792:: with SMTP id b18mr21066138ede.329.1639674353558;
        Thu, 16 Dec 2021 09:05:53 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id mq7sm201349ejc.172.2021.12.16.09.05.53
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 09:05:53 -0800 (PST)
Message-ID: <a3b3916c-2a87-aa07-50d9-ab5b34266a1a@tessares.net>
Date: Thu, 16 Dec 2021 18:05:52 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 16th of December 2021
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we just had our 177th meeting with Mat, Ossama, Kishen
(Intel), Paolo, Davide, Florian (Red Hat), Poorva (?) and myself
(Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12676919  [net,4/4] mptcp: add missing documented NL params
12676921  [net,3/4] mptcp: fix deadlock in __mptcp_push_pending()
12676917  [net,2/4] mptcp: clear 'kern' flag from fallback sockets
12676915  [net,1/4] mptcp: remove tcp ulp setsockopt support

12668763  selftests: mptcp: remove duplicate include in mptcp_inq.c

12671829  [net] mptcp: never allow the PM to close a listener subflow


    our repo (by: Jεan Sacren, Mat Martineau, Paolo Abeni):

12679757  [mptcp-next,v4,6/6] selftests: mptcp: Add tests for userspace
PM type
12679755  [mptcp-next,v4,5/6] mptcp: Add a per-namespace sysctl to set
the defa...
12679747  [mptcp-next,v4,4/6] mptcp: Make kernel path manager check for
userspa...
12679745  [mptcp-next,v4,3/6] mptcp: Bypass kernel PM when userspace PM
is enab...
12679753  [mptcp-next,v4,2/6] mptcp: Add a member to mptcp_pm_data to
track ker...
12679751  [mptcp-next,v4,1/6] mptcp: Remove redundant assignments in
path manag...

12678585  [v6,mptcp-next] mptcp: avoid atomic bit manipulation when possible

12676447  [v6,mptcp-next,6/7] mptcp: cleanup MPJ subflow list handling
12676451  [v6,mptcp-next,5/7] selftests: mptcp: add tests for subflow
creation ...
12676445  [v6,mptcp-next,4/7] mptcp: do not block subflows creation on
errors
12676443  [v6,mptcp-next,3/7] mptcp: keep track of local endpoint still
availab...
12676439  [v6,mptcp-next,2/7] mptcp: clean-up MPJ option writing.
12676441  [v6,mptcp-next,1/7] mptcp: fix per socket endpoint accounting.

12671319  [v2,net-next] net: mptcp: clean up harmless false expressions



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Davide Caratti):

12655357: Awaiting Upstream: [iproute2-next] mptcp: add support for
changing the backup flag:
    - Sent to netdev today


    our repo (by: Davide Caratti, Dmytro Shytyi, Geliang Tang, Jiapeng
Chong, Kishen Maloor, Matthieu Baerts, Paolo Abeni):

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
    - WIP

12540931: Changes Requested: [RFC,1/4] mptcp: pm_netlink: Add
MPTCP_PM_CMD_ANNOUNCE
12540933: Changes Requested: [RFC,2/4] mptcp: selftests:
MPTCP_PM_CMD_ANNOUNCE
12540935: Changes Requested: [RFC,3/4] mptcp: pm_netlink: Add
MPTCP_PM_CMD_REMOVE
12540937: Changes Requested: [RFC,4/4] mptcp: selftests:
MPTCP_PM_CMD_REMOVE:
    - Mostly done, should be sent soon

12576993: Changes Requested: [net-next,v1] net: mptcp, Fast Open Mechanism:
    - WIP

12657649: Changes Requested: [mptcp-next,v6,1/2] Squash to "mptcp:
implement fastclose xmit path"
12657651: Changes Requested: [mptcp-next,v6,2/2] mptcp: print out reset
infos of MP_RST:
    - TODO: Matth: start a thread / share patches

12657653: Changes Requested: [mptcp-next,v4] selftests: mptcp: add
mp_fail testcases:
    - depends on the previous
    - but also some modifications that are needed
    - it seems Geliang needs help on that
    - Discussions will continue on the ML

12674087: New: [RFC] mptcp: strict local address ID selection.:
    - mainly to demonstrate what would be the impact of such change
    - to have discussions around that
    - we need to update selftests
    - But seems useful because "dummy endpoint allocation" in the code
is not very nice and might be a source of issues later
    - Waiting for reviews
    - Mat will have a look

12678143: New: [v3,mptcp-next] selftests: mptcp: more stable join
tests-cases.:
    - with the patch, one subtest was failing but after a recent rebase,
it is no longer the case
    - @Mat: may you confirm that on your side too please?
    - depending on the host/vm, we can see issues or not → we need to
improve the stability
    - regarding failure with MP_PRIO tests, it might be becase we only
look on one side
    - Seems this patch can be applied → TODO: Matth → Done

12681411: New: [mptcp-next] Squash-to: "mptcp: cleanup MPJ subflow list
handling":
    - maybe linked to issue /250, see below



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 248)

  251   The best way to analyse MPTCPv1 performance?   [QUESTION]
[question]:
      - It is possible Wireshark doesn't properly detect the relative
MPTCP stream with multiple subflows
      - On Wireshark, there is no support to track a whole MPTCP stream
and like TCP display all data in order linked to that → not related to
this ticket but it might be a nice new feature.

  250  [syzkaller] Use-after-free in subflow_state_change [bug] [syzkaller]:
      - UaF happens because some subflows are not orphaned at close time
      - This could happens before Paolo's series changing MPJ list
      - But a squash-to patch is still needed, see above
      - But this is for net-next, not applicable for -net
      - We probably needs to cook a patch for -net: flush the join list


    Bugs (opened, flagged as "bug" and assigned)

  245  Packetdrill: Injected ADD_ADDR echo doesn't have the right info
[bug] [packetdrill] @dcaratti:
      - it seems the issue is not linked to inbound ADD_ADDR but at
different places
      - So Davide is trying to fix all of them while at it.


    Bugs (opened and flagged as "bug" and not assigned)

  250  [syzkaller] Use-after-free in subflow_state_change [bug] [syzkaller]:
      - See above

  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]

  225  selftests: join: "remove subflows and signal" is unstable [bug]
[selftests]:
      - Maybe fixed with Paolo's patch increasing the stability

  203  PM: server: accept subflows [bug]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]


    In Progress (opened, new feature and assigned)

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @dcaratti

  216  The infinite mapping support [enhancement] @geliangtang:
      - see patches above

  186  Add netlink command support [enhancement] @mjmartineau:
      - see patches above

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti:
      - Can be closed

   75  BPF: packet scheduler [enhancement] @geliangtang
   74  BPF: path manager [enhancement] @geliangtang


    For later (opened and not assigned assigned)

  251   The best way to analyse MPTCPv1 performance?   [QUESTION] [question]
  246  Netlink PM events: add one attribute about the connection type
(connect/accept) [enhancement]
  236  Review supported sockopts list [enhancement]
  222  Netlink event API: add SUBFLOW_CREATED event [enhancement]
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
   59  (MP)TFO support [enhancement]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   48  MP_FASTCLOSE support (send part remaining) [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since last week)

  249  Compilation problem with a 4.14.y kernel [question]
  247  see mptcp options when running iperf locally [question]
  242  Unexpected subflow management behaviour, following endpoint add
after subflow failure [bug] @pabeni
  235  PM: create new subflow after one got closed [enhancement] @pabeni
   65  packetdrill/fixes: clearing properly the status in
listen()/disconnect [bug]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.17):
https://github.com/multipath-tcp/mptcp_net-next/projects/12
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - net:
        - /

    - net-next:
        - HOL blocking
        - maybe new patches but they are fresh
        - we will probably have a rc8:
            - rc8 for the 2nd of Jan, release on the 9th
            - no rush then



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - Issue 250 has been detected, nothing else

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - seems to be passing!

    - packetdrill (Davide):
        - See above

    - Patchew (Davide):
        - Had to be restarted this week caused by (?)
        - But working again now \o/

    - CI (Matth):
        - KFENCE is now in used for 'non-debug' modes



Next meeting:
    - /!\ We *skip* the two next ones: 23/12 and 30/12
    - /!\ Next one on *Wednesday* as the 6/1 is a day off in some
countries (hint: where pineapple is forbidden)
    - Next one on Wednesday, the 5th of January.
    - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220105



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
