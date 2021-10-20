Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1092C85
	for <mptcp@lists.linux.dev>; Wed, 20 Oct 2021 16:50:39 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id i20so27670949edj.10
        for <mptcp@lists.linux.dev>; Wed, 20 Oct 2021 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=bxbLI+6vVRNP44rCZuBZs1g3lFZuvUSJItjqTMtR/u0=;
        b=v4nguTfqT7KKsXP/aXidCep9Tx75eFAK4lCJpXYcv65yxTdFAzwgT9jjMq+HpO4Y0+
         Uxu4eVy0vhltpa+zSlE5g3GDmgq1/+Ui4tT/5hS2ByMuWzrFaJPo1RkbBQgqeaTRqF6g
         oNt6xdbW71sq1xFf9HO9CJUVps5HlfDSh/TNs0SI9CsWSVvmC6MnhBtlsUE4a+fmyDK0
         D421i47caiAKlYYaywXU2NkpaSkuRvfx+RDUxR+T8lKJlCJcHBNLn3Dk/I2bh2ddaI4O
         fif1/kpkSp6nsLRc6WjzG7hl4XHc08+ndiR+Xh2/dSgQtQjavgUoxg2v6+0wneoGmlhc
         dJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=bxbLI+6vVRNP44rCZuBZs1g3lFZuvUSJItjqTMtR/u0=;
        b=BCtSfaK2WpK3U5MspOLV/V0B89ZGe/1zKJmcAgze3q+bB4dhGG6urcmCR4sJ0bxKRE
         fF2xACEFzErNnL8n/NQuiUgeKyNxAj61jbW2UhMcuTdbOW7DpomrunRmvJxsxsi2XRJs
         M5O/frJ3pmuYgBgyq6EDD7W4xujq6VdzOch3cj8Hy6PDp4r2XS01i0A30vo/SEddNtYE
         +NXmPvWG2KHjbylROCxLpiKueC2F7YgbCIZf/w+cyhNHY8kSy3G9YZkLe+u+QyYlXdPU
         UJCkBIq3WIvqYiWFpbi+/5BxqCLjAv2otFRcuc7qYk6tumtCAdQISij7XO9s7BqYztRX
         Spng==
X-Gm-Message-State: AOAM5326N1xXDoK3CqudfRX/ZACZFw0pSZ2WY8+YaQGY9EUKPGx8tm5M
	GHzQZU74GYlFk4sRT8gAwHcfFi2hMX5GaM5Y92o=
X-Google-Smtp-Source: ABdhPJxx2BCOZgfk2m/MHjSg5r1duU6dcDKZUVWhVH18BH9FdyDwdL9vUPdRkjN+O6gAJPqrBcMhdQ==
X-Received: by 2002:a17:906:f41:: with SMTP id h1mr539523ejj.255.1634748636546;
        Wed, 20 Oct 2021 09:50:36 -0700 (PDT)
Received: from ?IPV6:2a02:578:85b0:e00:7ea4:e5fb:35b8:79? ([2a02:578:85b0:e00:7ea4:e5fb:35b8:79])
        by smtp.gmail.com with ESMTPSA id og39sm1296456ejc.93.2021.10.20.09.50.35
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 09:50:36 -0700 (PDT)
Message-ID: <09ce06d8-11c4-ca60-af4e-b589a9c8f3da@tessares.net>
Date: Wed, 20 Oct 2021 18:50:35 +0200
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
Subject: [Weekly meetings] MoM - 14th of October 2021
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 169th meeting with Mat, Ossama, Kishen
(Intel), Florian, Paolo (Red Hat), Geliang (Xiaomi), Giray
Pultar (Parkyeri) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12543655  [net] mptcp: fix possible stall on recvmsg()


    our repo (by: Mat Martineau, Paolo Abeni):

12551151  [mptcp-next] mptcp: Avoid NULL dereference in
mptcp_getsockopt_subflo...
12545855  [mptcp-next] mptcp: increase default max additional subflows to 2



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Davide Caratti, Paolo Abeni):

12552925  [iproute2-next] mptcp: cleanup include section.
12528673  [iproute2] mptcp: unbreak JSON endpoint list


    our repo (by: Geliang Tang, Jiapeng Chong, Kishen Maloor, Mat
Martineau, Matthieu Baerts, Paolo Abeni):

12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to
tcp.h/mptcp.h
12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in
reset packets:
    - WIP

12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support
    - WIP

12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp
stack
12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes
socket with unread data
    - WIP

12321111: Changes Requested: mptcp: Remove redundant assignment to remaining
    - TODO (anyone?)

12476757: RFC: [RFC] selftests: mptcp: tune timeout and delay for
simult_flows cases
    - WIP

12524801: Changes Requested: [mptcp-next,v6,1/9] mptcp: don't send RST
for single subflow
12524803: Changes Requested: [mptcp-next,v6,2/9] mptcp: add the fallback
check
12524805: Changes Requested: [mptcp-next,v6,3/9] mptcp: track and update
contiguous data status
12524807: Changes Requested: [mptcp-next,v6,4/9] mptcp: add
last_ack_dss_start in the msk
12524809: Changes Requested: [mptcp-next,v6,5/9] mptcp: infinite mapping
sending
12524811: Changes Requested: [mptcp-next,v6,6/9] mptcp: infinite mapping
receiving
12524813: Changes Requested: [mptcp-next,v6,7/9] mptcp: add mib for
infinite map sending
12524815: Changes Requested: [mptcp-next,v6,8/9] selftests: mptcp: add
infinite map mibs check
12524817: Changes Requested: [mptcp-next,v6,9/9] DO-NOT-MERGE: mptcp:
mp_fail test:
    - Series: infinite mapping support

12537245: RFC: [RFC] mptcp: allocate fwd memory separatelly on the rx
and tx path:
    - WIP

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
on unexpected events when userspace PM is active:
12540931: Changes Requested: [RFC,1/4] mptcp: pm_netlink: Add
MPTCP_PM_CMD_ANNOUNCE
12540933: Changes Requested: [RFC,2/4] mptcp: selftests:
MPTCP_PM_CMD_ANNOUNCE
12540935: Changes Requested: [RFC,3/4] mptcp: pm_netlink: Add
MPTCP_PM_CMD_REMOVE
12540937: Changes Requested: [RFC,4/4] mptcp: selftests:
MPTCP_PM_CMD_REMOVE:
    - New version in progress merging series from Mat, Kishen and Florian
    - Looking at testing stuff with selftests
    - Reviewed Paolo's comments, all OK, working on things, will submit
the updated series once its done.
    - Making good progress

12540797: Queued: [mptcp-next] mptcp: Make
mptcp_pm_nl_mp_prio_send_ack() static:
    - TODO: Matth: to apply → done



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+no%3Alabel

https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+no%3Aproject


    Recently opened (latest from last week: 234)

  235  PM: create new subflow after one got closed [enhancement]:
      - to create new subflow if possible (limit was reached at some
point, now we have some "free" space)
      - or the subflow got closed because of a timeout (NAT expiration?)


    Bugs (opened, flagged as "bug" and assigned)

  233  Receiver key overwritten in a packet with mpc+data [bug] @spoorva:
      - RC6 is going to be released on Sunday
      - the bug is in -net so it could be good to have a fix before the
final release
      - @Poorva: do you need some help on that?


    Bugs (opened and flagged as "bug" and not assigned)

  234  error in packetdrill when outbound packet contains mpc+datalen
[bug] [packetdrill]
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
      - See ↑

  186  Add netlink command support [enhancement] @mjmartineau:
      - See ↑

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang
   74  BPF: path manager [enhancement] @geliangtang:
       - Assigned to Geliang


    For later (opened and not assigned assigned)

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



Important features to implement:
    - support more sockopts
    - seems a big limitation for existing applications built on top of TCP
    - we should probably review the list and:
        - prioritise what needs to be implemented first
        - maybe change some sockopt from one category to another one,
e.g. "ignored", "blacklisted", etc.
    - → https://github.com/multipath-tcp/mptcp_net-next/issues/236



Patches to send to netdev:
    - net:
        - "mptcp: Avoid NULL dereference in
mptcp_getsockopt_subflow_addrs()"

    - net-next:
        - "mptcp: increase default max additional subflows to 2"



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - nothing new related to MPTCP
        - One hit in TCP but it seems to be a regular TCP connection

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - working again and didn't report any failure with MPTCP

    - packetdrill (Davide):
        - just one fix with the tolerance used in ADD_ADDR tests

    - Patchew (Davide):
        - /

    - CI (Matth):
        - Now filtered out patchew-related events on IRC
        - Starting to send email notifications (WIP) for patches sent on
the ML, applied by patchew and for those the CI started some tests with.



Geliang will talk about MPTCP and our community at CLSF2021:
    - Conference: CLSF2021 (China Linux Storage, Memory Management and
File System Workshop)
    - hopefully new contributors!
    - Geliang will switch position (joining SUSE, congratulations!) and
continue to work on MPTCP \o/



Next meeting:
    - On Thursday, the 20th of October.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20211020



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
