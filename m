Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590A872
	for <mptcp@lists.linux.dev>; Fri, 13 Aug 2021 16:49:49 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id lo4so19286173ejb.7
        for <mptcp@lists.linux.dev>; Fri, 13 Aug 2021 09:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/rGL2APdf/tOtppruJhYpSafmXhxOpH4GhOI6aALHGE=;
        b=gJYh8nsMVz+6tJYTCdepVrR0OtbEpB+Ujj/kBrxCvEaM6QUfnch/AxZJknhRiD7pGb
         vMBfXA2BX1IwTr3g/HT4e1CY/EB1sFhsRFq0LDIa4lL6DB2KyGRfNCtXr/IxLrO3BevX
         GXcnFGFfSyPQALycMKUUWASi0lqgH9S7AxIoXC+FjLhzdF9+tPHrk9gL1fu5LoVPZWmz
         i3YmIGjCpEAFbWP9TpNw57T8iKiyfA3+M5e3G+UgNS48rV+5N4KbF8H6arglwrIWyiuc
         vI6YkzWosCgKOPgvPfv9Ef/GgqnoefY5+r3+q5umzJ9GD5Xz9rOMptYUf/imQ9ViY3fG
         sBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/rGL2APdf/tOtppruJhYpSafmXhxOpH4GhOI6aALHGE=;
        b=XOKWp3hgwdf8kXJSOMuMNFCoah1P0i7xxNDapIHoAKx1fz57hR2U8ZX4/QOK+/8heJ
         JjPikna+FvA75GHK2/l95nhZIweCPiWP2wEYHKeCqSvZNtE56fFHoPfKifbhL+Qp7Eqe
         /8xkpWQPe0UlsZ5NpTgTLs0nZpjOoXep+PDFLJSTS5zg6AEVmeEMrXCEC3Sm5copK3wV
         9fVbTrWcek+2ZwEfwHdTcRq/QE3whyB1ctauzz02GYsxLDbBM60jZgW9kIWrxkdTJGvE
         6MrTC3BzGtHkMo7RChZvw5PVz1YT2XqjBuFloGvRtKoXMwmEZPeG53lkkzQ3B7ANlRlo
         lBYw==
X-Gm-Message-State: AOAM530CMtjrrijRmE6DazGOSmAuC69b6+4Wz6TflOW+zVMp5pAL6zed
	yIhY36+zlCr4GC1lijoFHsPGhdEJQIxDCUgh
X-Google-Smtp-Source: ABdhPJwlsVYBc5oC/esNTvAvrzjZdbkb/hJQTNJ2phEIknVTWq8Y+uUkWE1g5zP2KruRgI4QZwlXZQ==
X-Received: by 2002:a17:906:49ce:: with SMTP id w14mr3397558ejv.273.1628873388159;
        Fri, 13 Aug 2021 09:49:48 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.156.139])
        by smtp.gmail.com with ESMTPSA id d23sm1155348edt.39.2021.08.13.09.49.47
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 09:49:47 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 12th of August 2021
Message-ID: <cb4c9dde-bac7-2c21-b6ec-f1710c8eeccc@tessares.net>
Date: Fri, 13 Aug 2021 18:49:47 +0200
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

Last Thursday, we had our 160th meeting with Mat and Ossama (Intel),
Christoph (Apple), Florian and Paolo (RedHat), Geliang (Xiaomi) and
myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Paolo Abeni):

12430619  [mptcp-next,2/2] Squash-to: "mptcp: move drop_other_suboptions
check ...
12430621  [mptcp-next,1/2] Squash-to: "selftests: mptcp: add testcase
for activ...



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Florian Westphal, Geliang Tang, Jiapeng Chong,
Matthieu Baerts, Paolo Abeni):

12279739: RFC: [RFC,3/4] mptcp: move the whole rx path under msk socket
lock protection:
    - can be archived → done

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

12321111: Changes Requested: mptcp: Remove redundant assignment to remaining
    - TODO

12431251: Changes Requested: [mptcp-next,1/5] mptcp: add new
mptcp_fill_diag helper
12431241: Changes Requested: [mptcp-next,2/5] mptcp: add MPTCP_INFO
getsockopt
12431243: Changes Requested: [mptcp-next,3/5] mptcp: add MPTCP_TCPINFO
getsockopt support
12431245: Changes Requested: [mptcp-next,4/5] mptcp: add
MPTCP_SUBFLOW_ADDRS getsockopt support
12431247: Changes Requested: [mptcp-next,5/5] selftests: mptcp: add
mptcp getsockopt test cases:
    - Reviewed by Paolo, small change required
    - Florian will send a v2

12432395: Changes Requested: [mptcp-next] mptcp: free entry when
release_work allocation fails:
    - Paolo provided a new version
    - Seems OK to continue with this new version
    - But in this v2, when closing a netns, we free the add_addr list
using the rcu worker → it could be done after the deletion of the netns
(pointer deref)
    - Paolo will send a proper patch later to fix that → Done

12432715: Changes Requested: [mptcp-next] mptcp: use unlikely for
non-DSS suboptions:
    - Paolo had some other modifications in the pipe but not ready nor
up to date
    - probably best to restart following the suggestions shared by Paolo
    - Paolo will not be able to look at that soon so if anybody else
(Geliang?) wants to do it, no problem.



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 223)

  225  selftests: join: "remove subflows and signal" is unstable [bug]
[selftests]:
      - When looking at issue 221, this new one appears
      - It was probably there for a bit of time but hidden by other
issues in the selftests (issue 221)
      - seems not to difficult to reproduce but not seen by Intel's kbuild.

  224  support for `setsockopt(TCP_INQ)` [enhancement]:
      - A new ticket, mainly for Poorva who identified this sockoption
was not supported.
      - Mainly to be able to create refs from packetdrill tests and open
discussions.


    Bugs (opened, flagged as "bug" and assigned)

  223  [syzkaller] Memory leak in mptcp_nl_cmd_add_addr [bug]
[syzkaller] @geliangtang:
      - see "mptcp: free entry when release_work allocation fails" patch

  221  selftests: join: "backup flow used, multi links fail" is unstable
[bug] [selftests] @pabeni:
      - Paolo saw one test can be unstable
      - TODO: open a new ticket for what Paolo saw → Done #226
      - Matth saw a regression in packetdrill tests
      - TODO: Matth: send the patch → Done


    Bugs (opened and flagged as "bug" and not assigned)

  225  selftests: join: "remove subflows and signal" is unstable [bug]
[selftests]

  219  [syzkaller] divide error in tcp_write_xmit [bug] [syzkaller]:
      - Mat is not able to reproduce it
      - Paolo has a small patch if we can reproduce it
      - Seems very rare, not blocking patches we have in the pipe

  203  PM: server: accept subflows [bug]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]
  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug]
   65  packetdrill/fixes: clearing properly the status in
listen()/disconnect [bug]


    In Progress (opened and assigned)

  218  Add support for MPTCP_INFO, similar to TCP_INFO [enhancement]
@fw-strlen:
      - See patches above

  216  The infinite mapping support [enhancement] @geliangtang
  194  Round-robin packet scheduler support [enhancement] @geliangtang
  186  Add netlink command support [enhancement] @mjmartineau
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti


    Recently closed (since last week)

None.



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.15):
https://github.com/multipath-tcp/mptcp_net-next/projects/10
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    → https://github.com/multipath-tcp/mptcp_net-next/commits/export
    - net:
        - /

    - net-next:
76d967bcd4f9 selftests: mptcp: add testcase for active-back
eb3583376af2 mptcp: backup flag from incoming MPJ ack option
797c671cafd4 mptcp: add mibs for stale subflows processing
fff1bbbdab6e mptcp: faster active backup recovery
ae0686bf3201 mptcp: cleanup sysctl data and helpers
b145e5af5b92 mptcp: handle pending data on closed subflow
2180213710b6 mptcp: less aggressive retransmission strategy
c3a3d67520e9 mptcp: more accurate timeout
+ fullmesh series

    - Mat will look at sending those


ADD_ADDR:
    - it proves that the server is OK because it includes both keys to
generate the HMAC → OK to go to fully_established



Extra tests:
    - news about Syzkaller? (Mat & Christoph):
        - Christoph is no longer able to get reproducers:
https://github.com/google/syzkaller/issues/2706
        - Mat has repro but syzkaller might not be up to date

    - news about interop with mptcp.org? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - seems running reliably again, not spotting any issue with MPTCP

    - packetdrill (Davide):
        - PR from Poorva is under review by Matth, changes have been
requested

    - Patchew (Davide):
        - /

    - CI (Matth):
        - /



Next meeting:
    - On Thursday, the 12th of August.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210812



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
