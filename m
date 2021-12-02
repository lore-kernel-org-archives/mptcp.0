Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B751729CA
	for <mptcp@lists.linux.dev>; Thu,  2 Dec 2021 15:11:03 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id l16so60291456wrp.11
        for <mptcp@lists.linux.dev>; Thu, 02 Dec 2021 07:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from:to
         :subject:content-transfer-encoding;
        bh=9LKkusYe1uEmEJu+DBkeLAZ6ezHWApH0n3sFPRQTqWA=;
        b=Cxihv1OvVEZJghqCtMoTDXdgkXk6Ram4fGyU786gfkvHJbp93FBxBXNJHo+zESz3Bb
         lhENzW/6GmgcQ3kHAEMwPZFdRcLslyq6GkGfAIS+PCkIHxzRFyVyFw3z1V2V/z9ORN1x
         wdv/A4Kv4lvrwTjMCyk2JMWQ2ND75WHOa51pPgxLCqXf1SP9dmbR5BNAvvPHIcPizv81
         oboVx6dNIsehI5P8uadr9lPvDa72Mx8Hy3KTJZ20LDjYb6oFsuKUXCJ1siFxZbt5MAeN
         2xAfKY6/EQoUTsAZOVNnA4iq2x05rnarFq8vOSaSFYHqV0gez9QKfDSHLa7MJSDawyLX
         lrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:subject:content-transfer-encoding;
        bh=9LKkusYe1uEmEJu+DBkeLAZ6ezHWApH0n3sFPRQTqWA=;
        b=DD7nVahJbbImwVuG2LiKedbd57M2bIKu1piA6mGoffDu1IneMU8+wFdSszDq0zS15m
         hxa+RHK37EMyzlLpfnJNXTC7zorIMN11MQd+N3KSrrfn+Cs0S6ypW+zt8C9eQnNNso+N
         wultOYRjUIeJCHDGSqzknD+g+TRB6bo0nV+PFxRouqjDj8ZgSLwlrssNd+Gr4NGx+Cc2
         4HxpSUJBPoMgC5DrdM7CdgfKBPvlRgB0wXTi6UAY0H+NKu4AAQs1gdKgKmk9eI+gPCTd
         dqZf4o54awqDmami4BJGJTTiOCs/aC3nBoy6RSOgec8g8cWSXGdLC5UGoNbkxYC8v9ho
         /TpQ==
X-Gm-Message-State: AOAM5306dX/gZkcGg5zM93m4QnihkSiEV+zcEVADCVGlHuS5dAOKm2au
	UdzW5S+Ot9Yx22VjD1SCTvkWm7ipZc8VfI8u
X-Google-Smtp-Source: ABdhPJyhBZSWAjIwS9LU+eutiUN3nDxrD8B8OxcFjfCzqQc04JIPRddW6MkpipetTafe+om9WEeQug==
X-Received: by 2002:adf:f947:: with SMTP id q7mr15167131wrr.260.1638457861399;
        Thu, 02 Dec 2021 07:11:01 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id u2sm73747wrs.17.2021.12.02.07.11.00
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 07:11:00 -0800 (PST)
Message-ID: <dc47c674-5dc9-21e2-f2d8-c78e45cd08c6@tessares.net>
Date: Thu, 2 Dec 2021 16:11:00 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 25th of November 2021
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last week, we had our 174th meeting with Paolo, Davide (Red Hat), Giray
(Parkyeri) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau, Paolo Abeni):

12629555  [net-next,4/4] selftests: mptcp: add tproxy test case
12629553  [net-next,3/4] mptcp: sockopt: add SOL_IP freebind &
transparent opti...
12629551  [net-next,2/4] mptcp: Support for IP_TOS for MPTCP setsockopt()
12629549  [net-next,1/4] ipv4: Exposing __ip_sock_set_tos() in ip.h

12629027  [net,2/2] mptcp: use delegate action to schedule 3rd ack retrans
12629029  [net,1/2] mptcp: fix delack timer

12614499  [iproute2] mptcp: fix JSON output when dumping endpoints by id


    our repo (by: Davide Caratti, Florian Westphal, Matthieu Baerts,
Paolo Abeni):

12632127  [v2,mptcp-next,2/2] selftests: mptcp: check IP_TOS in/out are
the same
12632125  [v2,mptcp-next,1/2] mptcp: getsockopt: add support for IP_TOS

12629273  [mptcp-next] Squash to "mptcp: add TCP_INQ cmsg support"

12627073  [mptcp-next,v2] mptcp: allow changing the "backup" bit by
endpoint id

12622407  [mptcp-next,v3,4/4] selftests: mptcp: add inq test case
12622405  [mptcp-next,v3,3/4] mptcp: add SIOCINQ, OUTQ and OUTQNSD ioctls
12622401  [mptcp-next,v3,2/4] selftests: mptcp: add TCP_INQ support
12622403  [mptcp-next,v3,1/4] mptcp: add TCP_INQ cmsg support

12615459  [v2,mptcp-next,7/7] mptcp: add disconnect selftests
12615457  [v2,mptcp-next,6/7] mptcp: implement support for user-space
disconnect
12615455  [v2,mptcp-next,5/7] mptcp: cleanup accept and poll
12615453  [v2,mptcp-next,4/7] mptcp: full disconnect implementation
12615451  [v2,mptcp-next,3/7] mptcp: implement fastclose xmit path
12615449  [v2,mptcp-next,2/7] mptcp: never allow the PM to close a
listener sub...
12615445  [v2,mptcp-next,1/7] mptcp: keep snd_una updated for fallback
socket



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Davide Caratti):

/

    our repo (by: Dmytro Shytyi, Geliang Tang, Jiapeng Chong, Kishen
Maloor, Mat Martineau, Matthieu Baerts, Maxim Galaganov, Paolo Abeni):

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

12540931: Changes Requested: [RFC,1/4] mptcp: pm_netlink: Add
MPTCP_PM_CMD_ANNOUNCE
12540933: Changes Requested: [RFC,2/4] mptcp: selftests:
MPTCP_PM_CMD_ANNOUNCE
12540935: Changes Requested: [RFC,3/4] mptcp: pm_netlink: Add
MPTCP_PM_CMD_REMOVE
12540937: Changes Requested: [RFC,4/4] mptcp: selftests:
MPTCP_PM_CMD_REMOVE:
    - WIP

12576993: Changes Requested: [net-next,v1] net: mptcp, Fast Open Mechanism:
    - WIP

12591671: Changes Requested: [mptcp-next,v8,8/8] selftests: mptcp: add
mp_fail testcases
12592523: Changes Requested: [mptcp-next] Squash to "selftests: mptcp:
add mp_fail testcases":
    - WIP

12625823: Needs ACK: [mptcp-next,1/6] mptcp: Remove redundant
assignments in path manager init
12625831: Needs ACK: [mptcp-next,2/6] mptcp: Add a member to
mptcp_pm_data to track kernel vs userspace mode
12625825: Needs ACK: [mptcp-next,3/6] mptcp: Bypass kernel PM when
userspace PM is enabled
12625827: Needs ACK: [mptcp-next,4/6] mptcp: Make kernel path manager
check for userspace-managed sockets
12625829: Needs ACK: [mptcp-next,5/6] mptcp: Add a per-namespace sysctl
to set the default path manager type
12625833: Needs ACK: [mptcp-next,6/6] selftests: mptcp: Add tests for
userspace PM type:
    - Series: "mptcp: Add userspace PM mode to bypass kernel PM"
    - Waiting for review

12633295: New: [mptcp-next,1/2] mptcp: send MP_FAIL with MP_RST
12633297: New: [mptcp-next,2/2] mptcp: print out reset_reason of MP_RST:
    - Waiting for review

12633517: Changes Requested: [mptcp-next,1/3] tcp: expose
__tcp_sock_set_cork and __tcp_sock_set_nodelay
12633585: Changes Requested: [mptcp-next,2/3] mptcp: expose
mptcp_check_and_set_pending
12633583: Changes Requested: [mptcp-next,3/3] mptcp: support TCP_CORK
and TCP_NODELAY:
    - "Blocked" waiting to have some tests:
        - Maxime sent a PR for Packetdrill
        - Waiting for reviews
        - Preliminary view: maybe we don't need multiple subflows, we
can simplify this

12637145: New: [mptcp-next,v2,1/4] mptcp: clean-up MPJ option writing.
12637151: New: [mptcp-next,v2,2/4] mptcp: keep track of used local endpoint
12637147: New: [mptcp-next,v2,3/4] mptcp: do not block subflows creation
on errors
12637153: New: [mptcp-next,v2,4/4] selftests: mptcp: add tests for
subflow creation failure:
    - series: "mptcp: improve subflow creation on errors"
    - one of the problem addressed here is to try establishing other
subflows if the connection cannot be established:
        - here we catch error and we tell the PM to check establishing
other subflows
        - an open question raised was to open subflows simultaneously
        - some biggish modifications are needed to have this
        - on the other hand, we should always tell the PM in case of
error to properly react in case of errors
    - one opened question: if the SYN+MPC is dropped, how long will we
take to try opening another subflows?:
        - it looks like it will be 1 sec by default (SYN retransmit for
plain TCP)
        - Paolo will look at that
    - But we can work incrementally and continue with the series as it is.



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 241)

  242  Unexpected subflow management behaviour, following endpoint add
after subflow failure [bug]:
      - in theory, everything is fixed with Paolo's patches
      - Waiting from Phil's feedback to know if everything is OK
      - looks like a bug but because the behaviour is modified and a new
feature is added (using the same endpoint in the same MPTCP connection),
easier to send everything to net-next
      - 'fullmesh' mode should benefit from the fix too.


    Bugs (opened, flagged as "bug" and assigned)

  239  [syzkaller] general protection fault in inet_csk_accept (called
by mptcp_accept) [bug] @pabeni


    Bugs (opened and flagged as "bug" and not assigned)

  242  Unexpected subflow management behaviour, following endpoint add
after subflow failure [bug]:
      - See above

  225  selftests: join: "remove subflows and signal" is unstable [bug]
[selftests]
  203  PM: server: accept subflows [bug]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]
   65  packetdrill/fixes: clearing properly the status in
listen()/disconnect [bug]


    In Progress (opened, new feature and assigned)

  235  PM: create new subflow after one got closed [enhancement] @pabeni
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @dcaratti
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

  237  can't create backup path  [enhancement] [documentation]:
      - Can be closed thanks to Paolo's patch for iproute2
      - TODO: close → Done

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
   18  allow 'force to MPTCP' mode: sysctl [enhancement]


    Recently closed (since last week)

  241  Force fallback to TCP [question] @matttbe
  224  support for `setsockopt(TCP_INQ)` [enhancement] @fw-strlen



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.17):
https://github.com/multipath-tcp/mptcp_net-next/projects/12
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - net:
        - /

    - net-next:
        - iproute2: mptcp: add support for fullmesh flag:
            - Paolo will send them
        - the rest can wait for next week:
            - Matt can send them if Mat is not able to send them next week



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - /

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - /

    - packetdrill (Davide):
        - Working on improving socket matching:
            - already displaying a better message in case of error would
be a good improvement
        - linked to it, covering RM_ADDR

    - Patchew (Davide):
        - Trying to avoid Patchew to re-trigger the CI each time a git
"tag" (Reviewed-by, etc.)
        - Workaround is in place, we need to send a git "tag" to check
if it is OK

    - CI (Matth):
        - still working and finding issues (cf. ML)



Next meeting:
    - On Thursday, the 2nd of December.
    - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20211202



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
