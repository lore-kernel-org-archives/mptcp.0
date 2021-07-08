Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0AC72
	for <mptcp@lists.linux.dev>; Thu,  8 Jul 2021 16:21:22 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id o5so10648866ejy.7
        for <mptcp@lists.linux.dev>; Thu, 08 Jul 2021 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=UxfJurgl/k9jrqKtYPiPBdBiX4pQtxt5GQmXurg914o=;
        b=yhwBz7el44oFwGkEhJYj4xGM6KV19tmhLeZbe8ILbxBvhyckHU+m1ccXpr5gDjkfJE
         8pcaUwfEFQalu9snWVpGJvc7JEMhjjmBnDBEH85TrYIhE+ieLWxITaj4ikfcLQTVQYHH
         yr/ZZVb7GZkMigmBXV+ZZqX/r6aBalswE3AbiAzGqhyQzBt0ohUyMAWlPz3wmQPk+OZF
         ehkSL30hQMxvbB0KUUnfpy348+ApRBwmW0SmboBwa78RSkAH2J4prrEnaoVyYdIHGcEA
         AokOOI4N2ZiVnQ16xH9NTO8S+WK+1aFUTr54pFcosW5vMPTwfAuk97qasMjRGjqnKmNm
         P0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=UxfJurgl/k9jrqKtYPiPBdBiX4pQtxt5GQmXurg914o=;
        b=Gped3krpmU6h5AmfkIocszyutaEfT4Efi71HSpHWI+XBXRh4UFKCcc6nXuY6Kfm+dA
         k23n6PVnhq6LRGovJifXypnoPmV9DFcrwZrvg7Z/640WhEnu6fJUCxj0JNuJiVIVzZIk
         ehcuXxNfb0Rlq9cQmUkzoAZfYKLjSC1FzyIeVeJ1MEXrB71v7Ru/HhhSnwU2D1055m0v
         hm05ME2HO/oIEVQ/E3L/lDotGYG463WbdJbOaR0oesYMZccY5zaxZ1eDpzbEUh5zlXSe
         ITM/EX+WYOtr1r0X+KgK7FW7K/8Uo6esCcw62RLeBZS1geq+MdGsyDAUoyN4qeBZFpnP
         MXsg==
X-Gm-Message-State: AOAM530M37hnyuqFC1rojXZn9HEz77RgSfkI9eENFfPnNBDVWLAcqCig
	pcv55OvF/dGp79nWWBRrAF+yzIiQBFlrrA==
X-Google-Smtp-Source: ABdhPJzoo2j1RSUdu97qp/zeQI2WBevqyrvQ7LWPWJoLI5984+74nHrfk7Xb8KhlF7zk5A798qcJsQ==
X-Received: by 2002:a17:907:2d9f:: with SMTP id gt31mr24065628ejc.423.1625761280385;
        Thu, 08 Jul 2021 09:21:20 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8488:2489:149b:33a4])
        by smtp.gmail.com with ESMTPSA id c6sm1496674ede.17.2021.07.08.09.21.19
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 09:21:20 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 8th of July 2021
Message-ID: <2303cc24-457e-42cf-7600-0ed9e56209a0@tessares.net>
Date: Thu, 8 Jul 2021 18:21:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
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

Today, we just had our 156th meeting with Mat and Ossama (Intel),
Florian, Paolo, Davide, Poorva (RedHat), Geliang (Xiaomi) and myself
(Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3

    netdev (if mptcp ML is in cc) (by: Paolo Abeni, Yangbo Lu):

12351833  [net] tcp: consistently disable header prediction for mptcp

12351509  [net-next,v5,08/11] net: sock: extend SO_TIMESTAMPING for PHC
binding


    our repo (by: Paolo Abeni):

12348239  [v2,mptcp-net] mptcp: properly account bulk freed memory



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*

    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Jiapeng Chong, Matthieu Baerts, Paolo
Abeni, Yonglong Li):

12279739: RFC: [RFC,3/4] mptcp: move the whole rx path under msk socket
lock protection:
    - WIP

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
    - Can be taken by someone else?

12347221: Changes Requested: [v3,mptcp-next,1/8] mptcp: MP_FAIL
suboption sending
12347223: Changes Requested: [v3,mptcp-next,2/8] mptcp: MP_FAIL
suboption receiving
12347225: Changes Requested: [v3,mptcp-next,3/8] mptcp: send out MP_FAIL
when data checksum fail
12347227: Changes Requested: [v3,mptcp-next,4/8] mptcp: add the mibs for
MP_FAIL
12347229: Changes Requested: [v3,mptcp-next,5/8] selftests: mptcp: add
MP_FAIL mibs check
12347231: Changes Requested: [v3,mptcp-next,6/8] mptcp: infinite mapping
sending
12347233: Changes Requested: [v3,mptcp-next,7/8] mptcp: infinite mapping
receiving
12347235: Changes Requested: [v3,mptcp-next,8/8] mptcp: add a mib for
the infinite mapping sending:
12351927: Changes Requested: [mptcp-next] Squash to "mptcp: send out
MP_FAIL when data checksum fail":
    - Mat did a review of the v3, asking for some modifications
    - v4 expected including the Squash-to patch

12348297: Needs ACK: [mptcp-next,1/7] mptcp: more accurate timeout
12348299: Needs ACK: [mptcp-next,2/7] mptcp: less aggressive
retransmission stragegy
12348291: Needs ACK: [mptcp-next,3/7] mptcp: handle pending data on
closed subflow
12348293: Needs ACK: [mptcp-next,4/7] mptcp: faster active backup recovery
12348301: Needs ACK: [mptcp-next,5/7] mptcp: add mibs for stale subflows
processing
12348295: Needs ACK: [mptcp-next,6/7] mptcp: backup flag from incoming
MPJ ack option
12348305: Needs ACK: [mptcp-next,7/7] selftests: mptcp: add testcase for
active-back:
    - To be reviewed

12363073: New: [v8,1/4] mptcp: make MPTCP_ADD_ADDR_SIGNAL and
MPTCP_ADD_ADDR_ECHO separate
12363059: New: [v8,2/4] mptcp: fix ADD_ADDR and RM_ADDR maybe flush
addr_signal each other
12363061: New: [v8,3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR option
according pm.add_signal
12363063: New: [v8,4/4] mptcp: remove MPTCP_ADD_ADDR_IPV6 and
MPTCP_ADD_ADDR_PORT:
    - To be reviewed
    - Geliang will look at this patch set next week.



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 213)

  215  TCP Urgent pointer and MPTCP [enhancement]:
      - at least to make sure we don't have issue:
          - if from userspace we request it
          - if we receive one from the other side
          - Maybe something to check with packetdrill
      - URG point is "deprecated": probably we don't need to support it
but best to make sure we don't have issue
      - (probably more "urgent" stuff to do with packetdrill)


    Bugs (opened, flagged as "bug" and assigned)

  191  Could you please let me know how to use "ip mptcp end points
backup"? [bug] [question] @matttbe:
      - TODO: Matth: check what still need to be done there after having
applied Paolo's series


    Bugs (opened and flagged as "bug" and not assigned)

  203  PM: server: accept subflows [bug]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]
  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug]
   65  clearing properly the status in listen() [bug]


    In Progress (opened and assigned)

  206  MPTCP-level retransmission strategy is probably too aggressive.
[enhancement] @pabeni
  194  Round-robin packet scheduler support [enhancement] @geliangtang

  193  Fullmesh path manager support [enhancement] @geliangtang
        - patches are nearly ready.
        - will send out next week

  189  Wireshark / TCPDump doesn't understand option subtype 8
(MP_TCPRST) [enhancement] @dcaratti
  186  Add netlink command support [enhancement] @mjmartineau
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti
   52  MP_FAIL support [enhancement] @geliangtang


    Recently closed (since last week)

  211  mptcp connection stalls when mptcp retransmission are disabled
[bug] @pabeni



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.14):
https://github.com/multipath-tcp/mptcp_net-next/projects/9
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
    - TODO: Matth: new project for 5.15 + update changelog, etc.



Patches to send to netdev:
    - net:
        - "Fix some mptcp syncookie process bugs" series?:
            - Last version has not been reviewed by Mat
            - But it can be sent to -net
        - @paolo: can we send "mptcp: properly account bulk freed
memory" that has been applied yesterday?:
            - yes we can!

    - net-next:
        - / → net-next is closed



Extra tests:
    - news about Syzkaller? (Mat):
        - didn't find anything related to MPTCP


    - news about interop with mptcp.org? (Mat):
        - /
        - Mat would like to check interop with big/little endian
        - 2 new comments on
https://github.com/multipath-tcp/mptcp/issues/427
        - Matth: TODO: create tickets from there


    - news about Intel's kbuild? (Mat):
        - still running without MPTCP issue


    - packetdrill (Davide):
        - Davide is looking at MP_PRIO
        - Poorva is looking at testing more setsockopt, will share that
later
        - could be nice to cover the disconnect and listen part:
            - issue 65: clearing properly the status in listen()


    - Patchew (Davide):
        - Accounts will be fixed/added soon


    - CI (Matth):
        - some selftests are often failing:
            - selftest_diag: not all the time
            - selftest_mptcp_join: always with debug
            - selftest_simult_flows: always with debug
        - @Mat: check if all tests are executed on kbuild
        - TODO: Matth: report this on Github to track the issues:
            - always the same error?
            - timing issue?



Next meeting:
    - On Thursday, the 15th of July.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210715



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
