Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A34C3FC1
	for <mptcp@lists.linux.dev>; Thu,  2 Sep 2021 16:03:40 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id n27so5576423eja.5
        for <mptcp@lists.linux.dev>; Thu, 02 Sep 2021 09:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=AU4o6Rx3PJZtC6o3CEiQoEFe3L3RPLeCRhm5n7qp1H0=;
        b=UVDllJoluT9s/S6+fi5CrH59kxGMLisCROf35ANxAXCD3bOkm0oWGUozBpSwbbuGC3
         7vuI2KVaFVbvG26izL/6SLcHFYBpy0oX3TU/+LZhgW/HmonNCFteu9dvZcPTquJZiVjy
         QRN4QJl9aH1xS/fNQMsthr7tsu99Raq7j/q7MTxofcnwr3NVZZhqTCbhVq72qqoGcvz4
         1KaIY+vRmSBkUkjxfgNFSiPqHyQbTBvQa0ge/yUgi/ieMXSbAmmZ2euvQxmqraDqPO+a
         90p36ER+6EisW05uVWYE1Tp7Rt1g4JMRxeJKZQY8lp8+cA2JH4MBQLiq0+mP9F1lO5Tr
         KPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=AU4o6Rx3PJZtC6o3CEiQoEFe3L3RPLeCRhm5n7qp1H0=;
        b=H6uaoD+DWUxK6At4CdEaO7tCv3kGb0/sALDvQTSZ86v5AU1TuVDFrWIb4muiAtJ+sG
         eefZ74V761PHQsyLn3i51UrM9olQqCn9W3BBfQYDZ0z5LIibrBdFOguTOs4gwkb5Mt8V
         5lq06oIF9eT5Ti1rLAILuacwz3pYff9ietjX4I68d3YkEJrIM2Yu2b4n+7EzosXWfAa2
         A8ATPqVANS9rjF+i+Y9ensqkWgl/jZamdWKLQ8oWVx76VA6Zfq0tUreMJAA346WKxL0i
         zJaZBNo0ssW64cOasT0P90oJfgsbNJNzVK1c3NvYRB2mKM0GTvKptEuw5bvxjTUFxV0w
         ED6Q==
X-Gm-Message-State: AOAM530uf/ZMUL8lYkDPunFlN6k2eJS8Kq/RQTMcnqwpPXdi+Ay6FIYC
	rGzDA9JJ4qz6ZgHgsL1PvGX8jRGy7CbjvQ==
X-Google-Smtp-Source: ABdhPJw2gtJJ3rF6CLsV36sr4xjFwHXFBtc1BJAr1qwTztiV5dfhBrwfHDjNMTrKKr/lD4zXeAV+2Q==
X-Received: by 2002:a17:906:3e10:: with SMTP id k16mr4750724eji.116.1630598618639;
        Thu, 02 Sep 2021 09:03:38 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id cf11sm1477331edb.65.2021.09.02.09.03.38
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 09:03:38 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 2nd of September 2021
Message-ID: <a9db34b4-2eab-83cc-ee63-b344cbfc6c39@tessares.net>
Date: Thu, 2 Sep 2021 18:03:37 +0200
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

Today, we just had our 163rd meeting with Mat (Intel), Christoph
(Apple), Florian, Paolo, Davide, Poorva (RedHat), Geliang (Xiaomi) and
myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau, Wan Jiabing ):

12468181  [v3] mptcp: Fix duplicated argument in protocol.h

12469977  [net,v3,2/2] selftests: mptcp: clean tmp files in simult_flows
12469981  [net,v3,1/2] mptcp: fix possible divide by zero

12460895  [net-next,5/5] mptcp: make the locking tx schema more readable
12460893  [net-next,4/5] mptcp: optimize the input options processing
12460899  [net-next,3/5] mptcp: consolidate in_opt sub-options fields in
a bitm...
12460891  [net-next,2/5] mptcp: better binary layout for
mptcp_options_received
12460897  [net-next,1/5] mptcp: do not set unconditionally csum_reqd on
incomin...


    our repo (by: Florian Westphal, Mat Martineau, Matthieu Baerts,
Paolo Abeni):

12466695  [net-next] Squash-to: "mptcp: fix possible divide by zero"

12465011  [v2,mptcp-next] mptcp: do not shrink snd_nxt when recovering

12464899  [mptcp-next,2/2] Squash to "selftests: mptcp: add mptcp
getsockopt te...
12464901  [mptcp-next,1/2] Squash to "mptcp: add MPTCP_INFO getsockopt"

12458723  [mptcp-net] mptcp: Only send extra TCP acks in eligible socket
states



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Jiapeng Chong, Matthieu Baerts, Paolo
Abeni):

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

12471083: New: [v2,mptcp-next] mptcp: use OPTIONS_MPTCP_MPC:
    - Already reviewed by Paolo

12471789: New: [mptcp-next,1/4] tcp: expose the tcp_mark_push() and
skb_entail() helpers
12471791: New: [mptcp-next,2/4] mptcp: stop relaying on tcp_tx_skb_cache.
12471793: New: [mptcp-next,3/4] Partially revert "tcp: factor out
tcp_build_frag()"
12471795: New: [mptcp-next,4/4] tcp: remove sk_{tr}x_skb_cache:
    - mptcp: just another xmit path refactor
    - Eric Dumazet would like to remove sk_{tr}x_skb_cache
    - For that, we need to expose more code
    - There is a small bug (out of bound access mem) but the goal is to
have some feedback
    - A new version (or squash-to patch) is expected for ↑ → Done
    - Goal is to have review/feedback before sending that to Eric
    - We are not using this cache to reduce data access but just to get
an SKB from TCP stack. So removing it is good: less instructions.




Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 229)

/


    Bugs (opened, flagged as "bug" and assigned)

  226  selftests: `mptcp_join.sh -l`: copyfd_io_poll: poll timed out
error [bug] [selftests] @fw-strlen:
      - a patch has been share to drastically reduce the number of
issues but doesn't fully fix it
      - the remaining issues seem to be different
      - Florian is looking at them ↑


    Bugs (opened and flagged as "bug" and not assigned)

  225  selftests: join: "remove subflows and signal" is unstable [bug]
[selftests]
  203  PM: server: accept subflows [bug]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]

  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug]:
      - it doesn't seems to be really be a bug
      - we probably need to change some timeout around not to give false
positive with "slow" environments.

   65  packetdrill/fixes: clearing properly the status in
listen()/disconnect [bug]


    In Progress (opened, new feature and assigned)

  216  The infinite mapping support [enhancement] @geliangtang:
      - It looks more complex than expected. Geliang will send messages
if needed

  194  Round-robin packet scheduler support [enhancement] @geliangtang
  186  Add netlink command support [enhancement] @mjmartineau
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti


    For later (opened and not assigned)

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

  177  improve retransmit subflow selection [enhancement]:
      - Geliang would like to look at it
      - With the current code, it is likely that we never retransmit on
the same subflow so maybe we don't need to do more
      - So probably best to check first what is needed by doing some
experimentations before coding what is suggested.
      - (or look at having possibilities to customise the packet
scheduler, e.g. with BPF :) )

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

  229  [syzkaller] divide error in __tcp_select_window - path manager
[bug] @mjmartineau
  219  [syzkaller] divide error in tcp_write_xmit [bug] [syzkaller]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.14):
https://github.com/multipath-tcp/mptcp_net-next/projects/9
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
    - TODO: Matth: 5.15



Patches to send to netdev:
    - net:
        - mptcp: Only send extra TCP acks in eligible socket states:
            - Seems ready to be sent
            - Mat will have a look at it

    - net-next:
        - /



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - → no more "divide by zero" errors \o/

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - It is normal to see "[mptcp:export 1590/1600]" → high numbers
        - But Mat will check just in case

    - packetdrill (Davide):
        - Poorva's PR is almost ready \o/

    - Patchew (Davide):
        - Website is working
        - Container is ready monitoring new patches
        - Patches are applied on a fork for the moment and the website
is updated
        - Idea is to check if this part is working well before pushing
to the main repo
        - Hopefully creating a tag without branch is enough for GH Actions

    - CI (Matth):
        - enabled: HEADERS_INSTALL / UAPI_HEADER_TEST
        - linked to the issue reported by Intel's kbuild



Next meeting:
    - On Thursday, the 9th of September.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210909



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
