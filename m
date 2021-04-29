Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041B171
	for <mptcp@lists.linux.dev>; Thu, 29 Apr 2021 16:44:13 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id u21so100894192ejo.13
        for <mptcp@lists.linux.dev>; Thu, 29 Apr 2021 09:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=RADVr+zW1vHMQdrLzTfPCkeI95dKpc2Wp3U8KbO35h8=;
        b=k7SiagoARrhrt8iyjkiZ7WjCbMpMZBMR0YUc2ReNOsBwmwjiSd3xIGpLrMwzpLHnX9
         IKVjVA+NCoUCL49eQrnyTutUA/K8rxy4KVP0ycUUAIOHmj0j5DXXeSR5KNUE4cBFt6Gg
         0QWr2Lu56+ogo3vJ9KzxCo/sPKeO8w/2FghRDJsld/DPDUiRP+BG7JsgTBguPWC7IR9s
         7P/IJk1dz1ZTaZrNyoK6+P8OWstibzudNVlHKSnv0mklxFt2ywNY0NivaWlS45xlcotq
         WpkOgYmLLCbYB2Rq2jpTU33ZedYJ0mPjVU8jvBiShmYiRqwCQZ4M6LFPfthHns0mKM98
         Q4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=RADVr+zW1vHMQdrLzTfPCkeI95dKpc2Wp3U8KbO35h8=;
        b=bAqdmenvLrmxiY1vE9cyPzKGxOpIuyLgWYFvdZMZxQTkRsJr+fAPmar6KjAYx+syes
         WACNze53SbpIrBDN3KoCLvqdpEQK7bxLfgNrAglfXovTzRwhG5hueW40DZVUwNrBiabV
         1oeU1cc7OuQHO26Kj3pQe9ETiwd5zFTfw0PkZ4jv0Uaxz/PQH2/d7zcJtm2KaNFd6tMH
         zj1VL2l5FqwUg2r2aMuW0SbPqPHTVsfFBUIipUFfbb5GzRKHQk1ufaQTzmFw5KAhzC+s
         Khq5G6FJYGYOGhkOYxYzjFQ0BeDs7KyAU6pVh1XaV3C3UaN6EGNOj/Sx9sbB0065CLhT
         twBQ==
X-Gm-Message-State: AOAM532fmnoRdgLM1B7k25oteO3doK8zuyWtb4UrwxPvxWPAmT22/kWM
	M6sSorWf2dBmH1DurVff7dwZT9h2b1vDj/QTmTy8dg==
X-Google-Smtp-Source: ABdhPJyGjAsm5xI4KgBHnTAjQ8oig8sxkx2cJsCljoHFDXFJ2PvLiT0RcCy2Qhp+/b6Fpt+mSB5XYw==
X-Received: by 2002:a17:906:4ad0:: with SMTP id u16mr789534ejt.19.1619714651677;
        Thu, 29 Apr 2021 09:44:11 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:a1a8:783b:cdf:fe3f])
        by smtp.gmail.com with ESMTPSA id n12sm2704938edw.95.2021.04.29.09.44.10
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 09:44:11 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 29th of April 2021
Message-ID: <4f0bfd56-6f75-3791-420a-100c539e6a65@tessares.net>
Date: Thu, 29 Apr 2021 18:44:10 +0200
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

Today, we had our 146th meeting with Mat and Ossama (Intel), Christoph
(Apple), Florian and Davide (RedHat) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:


Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.ozlabs.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (Mat Martineau):

1469754  [net-next,5/5] selftests: mptcp: add a test case for MSG_PEEK
1469759  [net-next,4/5] mptcp: add MSG_PEEK support
1469755  [net-next,3/5] mptcp: ignore unsupported msg flags
1469758  [net-next,2/5] mptcp: implement MSG_TRUNC support
1469757  [net-next,1/5] mptcp: implement dummy MSG_ERRQUEUE support

1469694  [net] mptcp: Retransmit DATA_FIN


    our repo (by: Mat Martineau, Matthieu Baerts):

1471102  [mptcp-next] mptcp: restrict values of 'enabled' sysctl

1469444  [mptcp-next] Squash-to: mptcp: Retransmit DATA_FIN (again)



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.ozlabs.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Florian Westphal, Geliang Tang, Jianguo Wu, Matthieu
Baerts, Paolo Abeni):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets

1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support

1395128: RFC: [1/5] tcp: make two mptcp helpers available to tcp stack
1395133: RFC: [5/5] mptcp: send fastclose if userspace closes socket
with unread data

1450496: RFC: [RFC,2/2] mptcp: add MP_FAIL support

1469539: New: [iproute2] mptcp: make sure flag signal is set when add
addr with port:
    - Because it is for iproute2, we should ask the author if he wants
to send it directly
    - TODO: Matth: ask

1469627: New: [v4,mptcp-next,01/22] mptcp: add csum_enabled in mptcp_sock
1469641: New: [v4,mptcp-next,02/22] mptcp: generate the data checksum
1469642: New: [v4,mptcp-next,03/22] Squash-to: "mptcp: generate the data
checksum"
1469632: New: [v4,mptcp-next,04/22] mptcp: add csum_reqd in
mptcp_out_options
1469629: New: [v4,mptcp-next,05/22] mptcp: send out checksum for
MP_CAPABLE with data
1469631: New: [v4,mptcp-next,06/22] Squash-to: "mptcp: send out checksum
for MP_CAPABLE with data"
1469643: New: [v4,mptcp-next,07/22] mptcp: send out checksum for DSS
1469630: New: [v4,mptcp-next,08/22] Squash-to "mptcp: send out checksum
for DSS"
1469628: New: [v4,mptcp-next,09/22] mptcp: add sk parameter for
mptcp_parse_option
1469634: New: [v4,mptcp-next,10/22] mptcp: add csum_reqd in
mptcp_options_received
1469644: New: [v4,mptcp-next,11/22] mptcp: receive checksum for
MP_CAPABLE with data
1469633: New: [v4,mptcp-next,12/22] Squash-to: "mptcp: receive checksum
for MP_CAPABLE with data"
1469646: New: [v4,mptcp-next,13/22] mptcp: receive checksum for DSS
1469638: New: [v4,mptcp-next,14/22] Squash-to: "mptcp: receive checksum
for DSS"
1469639: New: [v4,mptcp-next,15/22] mptcp: validate the data checksum
1469645: New: [v4,mptcp-next,16/22] Squash-to: mptcp: validate the data
checksum
1469636: New: [v4,mptcp-next,17/22] mptcp: cleanup error path in
subflow_check_data_avail()
1469637: New: [v4,mptcp-next,18/22] mptcp: tune re-injections for csum
enabled mode.
1469635: New: [v4,mptcp-next,19/22] mptcp: add the mib for data checksum
1469648: New: [v4,mptcp-next,20/22] mptcp: add a new sysctl
checksum_enabled
1469647: New: [v4,mptcp-next,21/22] selftests: mptcp: enable checksum in
mptcp_connect.sh
1469640: New: [v4,mptcp-next,22/22] selftests: mptcp: enable checksum in
mptcp_join.sh:
    - Mat commented on patch 16/22
    - New status: Changes Requested

1471269: New: [v3,mptcp-next,1/4] mptcp: add sysctl
allow_join_initial_addr_port
1471270: New: [v3,mptcp-next,2/4] mptcp: add allow_join_id0 in
mptcp_out_options
1471271: New: [v3,mptcp-next,3/4] mptcp: add deny_join_id0 in
mptcp_options_received
1471272: New: [v3,mptcp-next,4/4] selftests: mptcp: add deny_join_id0
testcases
1471287: New: Squash to "mptcp: add sysctl allow_join_initial_addr_port":
    - v3 addresses Mat and Florian's comments

1471657: New: mptcp: fix close of larval mptcp sockets:
    - Reported-by tags? Geliang and Maxim (if OK for them)

1471752: New: [mptcp-next] mptcp: support SYSCTL only if enabled:
    - Reported by Intel's kbuild
    - The "issue" was already there but only visible with "mptcp:
restrict values of 'enabled' sysctl"



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 180)

  185  kernel warning when processes exit with unaccepted connections in
the backlog [bug] @fw-strlen:
      - Already a patch for that: mptcp: fix close of larval mptcp sockets

  183  MP_CAPABLE 'C' flag is ignored [enhancement] @geliangtang:
      - specific to MPTCPv1
      - (typically for the server) to notify the other end (client) that
it should not establish new subflows on this address (initial one)

  182  [syzkaller] KASAN: slab-out-of-bounds Write in
tcp_init_congestion_control [bug] [syzkaller]:
      - with the export branch from last week
      - Maybe introduced by the sockopt modifications?
      - TODO: Matth: update ticket info → done

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug] [enhancement]:
      - if we receive DATA_FIN again, we should send the ACK again


    Bugs (opened, flagged as "bug" and assigned)

  185  kernel warning when processes exit with unaccepted connections in
the backlog [bug] @fw-strlen:
      - see above

  178  Server hang when proxying over multiple subflows [bug] [v5.11]
[v5.12] @pabeni:
      - New repro from Maxim
      - It creates a KASAN splat only with the patch 0001-kasan.patch.txt
      - Paolo didn't have the opportunity to look at it

  176  BPF selftest got "fallback to TCP" error [bug] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  182  [syzkaller] KASAN: slab-out-of-bounds Write in
tcp_init_congestion_control [bug] [syzkaller]
      - see above

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug] [enhancement]
      - see above

  172  WARNING in sk_stream_kill_queues [bug]
  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug]
  120  [interop] netnext is dropping packets, causing MPTCP-level
retransmissions on mptcp.org [bug]
  107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
   65  clearing properly the status in listen() [bug]
   56  msk connection state set without msk lock [bug]


    In Progress (opened and assigned)

  183  MP_CAPABLE 'C' flag is ignored [enhancement] @geliangtang:
      - see above

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti
  143  Packetdrill: ADD_ADDR for v6 only socket should only contain v6
addresses [enhancement] [packetdrill] @dcaratti
  134  Checksum support [enhancement] @geliangtang
   96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
   53  MP_TCPRST support [enhancement] @fw-strlen
   52  MP_FAIL support [enhancement] @geliangtang


    Recently closed (since last week)

  184  Sending data over multiple subflow Kernel  -
5.10.0-051000-generic [question]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.13):
https://github.com/multipath-tcp/mptcp_net-next/projects/8
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
    - TODO: Matth → switch 5.14



Patches to send to netdev:
    - net:
        - /

    - net-next:
        - net-next seems closed (networking pull request has been sent)



Extra tests:
    - news about Syzkaller? (Christoph):
        - One new issue ↑
        - re-running on latest export branch

    - news about interop with mptcp.org? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - it has been updating reliably, not MPTCP issues to report
        - it has spotted a build issue, see "mptcp: support SYSCTL only
if enabled"

    - packetdrill (Davide):
        - New DATA_FIN retransmit tests:
https://github.com/multipath-tcp/packetdrill/pull/53#discussion_r621390012
            - last modif by Matth seems OK to Mat: can be merged
        - Davide continues working on supporting subflow endpoints

    - CI (Matth):
        - vmlinux has debug symbols:
            - not compressed: 125MB
            - compressed: 32MB (xz), 34MB (brotli), 36MB (zstd high),
40MB (zstd very fast)
            - taking space from cache.
            → Only saved in case of call trace
        - repro: ease usage for a local packetdrill repo (to check local
modifications) and make.cross from Intel's 0day



Patchew:
    - Request has been sent (by Davide)
    - 3 nodes are typically needed:
        - website: public database + dashboard:
            - managed by Patchew team

        - importer: monitor the ML, create a tag with patches in a Git
repo and populate the DB when there are some activities on patches:
            - needs to managed by us but in theory, we need to run a
daemon written by Patchew team
            - Davide will look at that

        - tester: monitor the DB, start tests and publish results:
            - unclear if we need that: in our case we already trigger a
build when a new tag is published
            - but we need to publish results
            - we could do that from a Github Action
            - can we have multiple push per patch?
            - from the tag/sha, can we easily find the corresponding
patch on patchew?



Extra programs launched by the CI:
    - Add a dedicated commit on the export branch with programs to avoid
regression
    - can include syzkaller repo
    - we have another repo for that:
https://github.com/multipath-tcp/mptcp-syzkaller-repro
    - but maybe better to include everything in the export branch



Netlink Commands:
    - nobody seems working on that
    - Mat will create a new issue (if there is no issue about that already)



Next meeting:
    - On Thursday, the 6th of May.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210506



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
