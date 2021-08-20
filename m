Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075E73FC2
	for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 16:28:14 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id q3so14809304edt.5
        for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 09:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=46PImERW+tbInIl0r96AJ4cb8tsRcZAZTdL7jcLUb68=;
        b=xSkHdhW5agJkzzH3qxDuIjsrJ9Y2Ma4FoAUcVKArSNX7SzcWbVAjYEUqJS5b97JLQc
         /F43AUbCjXnWqsAcF7POGwWNMsF2AvSCTheP+CoxyEA1wr6Z7ArAJ5dI5/LhvBg4P9Uf
         h85P+Zvh0LXweq0uJGO9nIoHIzilMFpufm/tmjy12r16u761fm3yuA2TGgeOW6mYcfxs
         DnObRxHbS/KYPUQJhfVu1vlURUszvuGDEyzWHI+jhaRCbX9tZ9f7O2zaa0webIDmdIBT
         Yfb1z2hV7hEjwjlRNGjsRbPLWk47xxOkFwlGcod+80C2ajwer7sGGDH/Ig0DyHQI8RpJ
         rAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=46PImERW+tbInIl0r96AJ4cb8tsRcZAZTdL7jcLUb68=;
        b=VfgLBKOPwfEs4GHS95SInkhKDpIhtzWLN6pvHiPyz/VLtLGWxQgbKFyVYglZ4cNXuY
         nman55RdOcWS3y22H+W2lHbCfZbvaN4OUvZ/r0mpplRG3xY9hUbh4KHMwQfyHTikpptc
         8Cmxe7ixYtiwDVWh0QkytAXjwa5vIYQI4DIjEa1tciBe+HWGhFEBc71GZ+rF3PCLgRm3
         3zthtls9716rLVgbzYG1ktxvVIefSIjO4i9WMO+wGAiHA8zQKMTeBJJwmwF0GJ5+pLIk
         yZSGqDiU8ml2GOxZwzZbl9TS4T/bm1pp6HIh8jDnzzahtlE2rLDNwGhKg40KU0PeomUV
         bECw==
X-Gm-Message-State: AOAM5324PJhWyNoWfkxopSyu8OfmhzCGV7xPmI/rfAnm8TdcLSk2TH+k
	G1KKqH7bfUTZK60OjTNu4JO4y1v2uIS6FA==
X-Google-Smtp-Source: ABdhPJxRad8AI++rZrl1O5UX+IrpRGJS4xDqFU0cPOvlb5tYU9csG47xk6urVDD0YWLYGXL8mAYq9Q==
X-Received: by 2002:aa7:d4d3:: with SMTP id t19mr22816252edr.131.1629476892884;
        Fri, 20 Aug 2021 09:28:12 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id p5sm663022eju.30.2021.08.20.09.28.12
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 09:28:12 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 19th of August 2021
Message-ID: <2031ff56-656e-8477-915f-768fa3e1d21d@tessares.net>
Date: Fri, 20 Aug 2021 18:28:12 +0200
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

Last Thursday, we had our 161st meeting with Mat and Ossama (Intel),
Christoph (Apple), Florian, Paolo, Davide, Poorva (RedHat) and myself
(Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12445553  [net,2/2] mptcp: full fully established support after ADD_ADDR
12445551  [net,1/2] mptcp: fix memory leak on address flush

12442185  [net-next,6/6] selftests: mptcp: delete uncontinuous removing ids
12442183  [net-next,5/6] selftests: mptcp: add fullmesh testcases
12442181  [net-next,4/6] selftests: mptcp: set and print the fullmesh flag
12442177  [net-next,3/6] mptcp: local addresses fullmesh
12442179  [net-next,2/6] mptcp: remote addresses fullmesh
12442175  [net-next,1/6] mptcp: drop flags and ifindex arguments

12436283  [net-next,8/8] selftests: mptcp: add testcase for active-back
12436279  [net-next,7/8] mptcp: backup flag from incoming MPJ ack option
12436277  [net-next,6/8] mptcp: add mibs for stale subflows processing
12436275  [net-next,5/8] mptcp: faster active backup recovery
12436269  [net-next,4/8] mptcp: cleanup sysctl data and helpers
12436281  [net-next,3/8] mptcp: handle pending data on closed subflow
12436273  [net-next,2/8] mptcp: less aggressive retransmission strategy
12436271  [net-next,1/8] mptcp: more accurate timeout


    our repo (by: Florian Westphal, Matthieu Baerts, Paolo Abeni):

12443883  [v3,mptcp-next,5/5] selftests: mptcp: add mptcp getsockopt
test cases
12443881  [v3,mptcp-next,4/5] mptcp: add MPTCP_SUBFLOW_ADDRS getsockopt
support
12443879  [v3,mptcp-next,3/5] mptcp: add MPTCP_TCPINFO getsockopt support
12443873  [v3,mptcp-next,2/5] mptcp: add MPTCP_INFO getsockopt
12443877  [v3,mptcp-next,1/5] mptcp: add new mptcp_fill_diag helper

12441621  [mptcp-net,v3] mptcp: full fully established support after
ADD_ADDR
12435627  [mptcp-net,v2] mptcp: fix memory leak on address flush



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Mat):

        /


    our repo (by: Florian Westphal, Jiapeng Chong, Matthieu Baerts,
Paolo Abeni):

12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to
tcp.h/mptcp.h:
12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in
reset packets:
    - WIP

12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
    - WIP

12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp
stack:
12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes
socket with unread data:
    - WIP

12321111: Changes Requested: mptcp: Remove redundant assignment to
remaining:
    - TODO

12443953: Changes Requested: [net-next,1/4] mptcp: do not set
unconditionally csum_reqd on incoming opt
12443957: Changes Requested: [net-next,2/4] mptcp: better binary layout
for mptcp_options_received
12443961: Changes Requested: [net-next,3/4] mptcp: consolidate in_opt
sub-options fields in a bitmask
12443959: Changes Requested: [net-next,4/4] mptcp: optimize the input
options processing.:
    - series: "mptcp: minor receive path optimization"
    - v2 is required (something else Paolo noticed on his side)

12447175: New: selftest: wait before trasnmitting first data chunk:
    - Waiting for review
    - Squash-to patch for MPTCP_INFO series
    - Tested by Matth


Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 225)

  226  selftests: `mptcp_join.sh -l`: copyfd_io_poll: poll timed out
error [bug] [selftests]:
    - we discussed about that last week: quite rare but seen by Paolo


    Bugs (opened, flagged as "bug" and assigned)

/


    Bugs (opened and flagged as "bug" and not assigned)

  226  selftests: `mptcp_join.sh -l`: copyfd_io_poll: poll timed out
error [bug] [selftests]
  225  selftests: join: "remove subflows and signal" is unstable [bug]
[selftests]
  219  [syzkaller] divide error in tcp_write_xmit [bug] [syzkaller]
  203  PM: server: accept subflows [bug]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]
  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug]
   65  packetdrill/fixes: clearing properly the status in
listen()/disconnect [bug]


    In Progress (opened and assigned)

  216  The infinite mapping support [enhancement] @geliangtang
  194  Round-robin packet scheduler support [enhancement] @geliangtang
  186  Add netlink command support [enhancement] @mjmartineau
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti


    Recently closed (since last week)

  223  [syzkaller] Memory leak in mptcp_nl_cmd_add_addr [bug]
[syzkaller] @geliangtang
  221  selftests: join: "backup flow used, multi links fail" is unstable
[bug] [selftests] @pabeni
  218  Add support for MPTCP_INFO, similar to TCP_INFO [enhancement]
@fw-strlen
  190  Wireshark doesn't understand MP_CAPABLE C flag [enhancement]
@RuiCunhaM:
      - From a new dev \o/
      - This person is also looking at adding MPTCP support in scapy:
          https://github.com/secdev/scapy/pull/3334



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
        - ADD_ADDR/RM_ADDR refactor:
            - seems OK

        - "optimize out option generation":
            - Paolo prefers to wait (linked to a new "divide by 0"
issue? → EDIT: Seems not)

        - MP_FAIL support:
            - seems OK

        - MPTCP_INFO support:
            - too fresh, better to wait a bit



Extra tests:
    - news about Syzkaller? (Mat & Christoph):
        - "divide error in __tcp_select_window" → info added in ticket
219 for the moment
        - reproducers are back on Christoph's side (config issue)

    - news about interop with mptcp.org? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - builds are still running, no error

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - New Accounts are working
        - Davide is testing on his side (importer)
        - Once ready, a VM will be setup to monitor the ML

    - CI (Matth):
        - Docker Autobuild policy has changed, we were relying on it to
accelerate the CI jobs
        - Now using Github Action to pre-build docker images when modified.



Next meeting:
    - On Thursday, the 26th of August.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210826



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
