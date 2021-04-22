Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3AF2F81
	for <mptcp@lists.linux.dev>; Thu, 22 Apr 2021 20:00:00 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id g5so63865748ejx.0
        for <mptcp@lists.linux.dev>; Thu, 22 Apr 2021 13:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=rhPURROPlw9CfliuJaUGaZ60LgBXJwm4tA5uTTtmkQ0=;
        b=n0rpDm6v8KIqTjO4CTDTh62xLfkP9EjM6KMSfwcDBQnt5X21glYTa24aTD/7JqgouO
         2xbrGl2T/vHRfMOYJDeInTNbYZYX98MRqyBuUAHiPwFjriQHpyzHOScR1CE/aO68JscB
         F37PfrFOjuMltGEbkgm02rlW5rNng+2xEg84vijdb/R+S0KTaEVBTUrh4kemDbnbBaoZ
         JI7Yb7lA4EbqfUULcSPWulYXGKbAE5pPPeuV028AjW9bj71slENei3R0rfFMIVgFrHrB
         kAxA3wteJLpVsDn/8j0ZObfE/VqLRdarabeGFWZDW3CaLMh2Z/wl9B17oETqWFuPkMxQ
         TQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=rhPURROPlw9CfliuJaUGaZ60LgBXJwm4tA5uTTtmkQ0=;
        b=gr+Gc5x7XSYmXDpHRlazjn8n9bmzaP9GXBDC/DqKnlKuLgh9/AE3f8CxoI2vqOl/Fu
         1m23sVhtiJ3JG1UUubk7yMCStY+2ASAffffAX1bdXjcm7KaW3oY7vslOplaS7tk0d9EZ
         iaULUzVkLmcIo84htyeyC7TZ1Cnv7E5l5cUTM1/T8dqz0kkOAQiVDQBYO1rX+yq09kHt
         8VfwTWOhc1U6dj7Ee51HaYSvwlFOwW6Yxzz0x8uAfqRXAlCUV/JM5XZK4gs6yy7zQmPn
         osK+fW9/Dam1hpqdlHQoQgqliOlK0mo+ffykiah6BB30Nru10H7Uy72/371CCibCD6HU
         78uw==
X-Gm-Message-State: AOAM530hU+UvlX7FJmzHijUEy42H8Rr/CrzqA6RhO5ctkn0sZXg2HDux
	1zKSuqz5XF87cVSM6HEXVOVrqhJDA/JVxg==
X-Google-Smtp-Source: ABdhPJxItCMvs0wy2rkG3l7kSTcO6A7ZkcwF5uourPFnKDI2VmLpr56GYjPU3Ba5YeDOSKksMaigFA==
X-Received: by 2002:a17:906:f1d0:: with SMTP id gx16mr391996ejb.340.1619121598647;
        Thu, 22 Apr 2021 12:59:58 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:12ce:5892:37b1:5a39])
        by smtp.gmail.com with ESMTPSA id f3sm2498577eje.45.2021.04.22.12.59.58
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 12:59:58 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 22nd of April 2021
Message-ID: <a016ea60-9237-ec17-4dc4-4b9338b489ca@tessares.net>
Date: Thu, 22 Apr 2021 21:59:57 +0200
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

Today, we had our 145th meeting with Mat and Ossama (Intel), Florian,
Paolo and Davide (RedHat), Geliang (Xiaomi) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:


Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.ozlabs.org/project/mptcp/list/?state=3

    netdev (if mptcp ML is in cc) (Florian Westphal, Mat Martineau):

1467410  [net-next,8/8] mptcp: use mptcp_for_each_subflow in mptcp_close
1467409  [net-next,7/8] mptcp: add tracepoint in subflow_check_data_avail
1467407  [net-next,6/8] mptcp: add tracepoint in ack_update_msk
1467408  [net-next,5/8] mptcp: add tracepoint in get_mapping_status
1467406  [net-next,4/8] mptcp: add tracepoint in mptcp_subflow_get_send
1467403  [net-next,3/8] mptcp: export mptcp_subflow_active
1467404  [net-next,2/8] mptcp: fix format specifiers for unsigned int
1467405  [net-next,1/8] kunit: mptcp: adhere to KUNIT formatting standard

1467074  [iproute2] mptcp: add support for event monitoring

1466813  [net-next,13/13] selftests: mptcp: add packet mark test case
1466812  [net-next,12/13] mptcp: sockopt: add TCP_CONGESTION and TCP_INFO
1466810  [net-next,11/13] mptcp: setsockopt: SO_DEBUG and no-op options
1466808  [net-next,10/13] mptcp: setsockopt: add SO_INCOMING_CPU
1466811  [net-next,09/13] mptcp: setsockopt: add SO_MARK support
1466807  [net-next,08/13] mptcp: setsockopt: support SO_LINGER
1466806  [net-next,07/13] mptcp: setsockopt: handle receive/send buffer
and de...
1466809  [net-next,06/13] mptcp: setsockopt: handle SO_KEEPALIVE and
SO_PRIORI...
1466805  [net-next,05/13] mptcp: tag sequence_seq with socket state
1466803  [net-next,04/13] mptcp: add skeleton to sync msk socket options
to su...
1466804  [net-next,03/13] mptcp: only admit explicitly supported sockopt
1466801  [net-next,02/13] mptcp: move sockopt function into a new file
1466800  [net-next,01/13] mptcp: revert "mptcp: forbit mcast-related
sockopt o...


    our repo (by: Jianguo Wu, Mat Martineau, Matthieu Baerts, Paolo
Abeni, Yonglong Li):

1469143  [v2,RESEND] mptcp: remove redundant initialization in
pm_nl_init_net()

1468922  [mptcp-next] Squash to: mptcp: Retransmit DATA_FIN
1468754  [mptcp-next,v2] mptcp: Retransmit DATA_FIN:
    - packetdrill test?
    - could be good to make sure we don't have regression
    - → should be enough to duplicate the last line of a test sending
the data_fin → check that at least 2 are sent
    - TIME_WAIT socket:
        - if the socket is in TIME_WAIT, we would never retransmit the
DATA_FIN ACK
        - TODO: add a Github issue to track that, *Paolo* will do that
        - TODO: *Matth* add Paolo's Acked-by → Done

1468637  [v2] mptcp: using TOKEN_MAX_RETRIES instead of magic number

1468278  mptcp: fix pr_debug in mptcp_token_new_connect

1468093  [mptcp-next,3/3] selftests: mptcp: avoid non-const global
variables
1468092  [mptcp-next,2/3] selftests: mptcp: same NS for Peek tests in IPv6
1468090  [mptcp-next,1/3] selftests: mptcp: use 2 different 'peek' modes

1467758  [v4,2/2] selftests: mptcp: add a test case for MSG_PEEK
1467757  [v4,1/2] mptcp: add MSG_PEEK support

1466711  [net-next,3/3] mptcp: ignore unsupported msg flags
1466708  [net-next,2/3] mptcp: implement MSG_TRUNC support
1466710  [net-next,1/3] mptcp: implement dummy MSG_ERRQUEUE support



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.ozlabs.org/project/mptcp/list/?state=*

    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Florian Westphal, Geliang Tang, Jianguo Wu, Paolo Abeni):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets:
    - WIP

1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support
    - WIP

1395128: RFC: [1/5] tcp: make two mptcp helpers available to tcp stack
1395133: RFC: [5/5] mptcp: send fastclose if userspace closes socket
with unread data
    - WIP

1450496: RFC: [RFC,2/2] mptcp: add MP_FAIL support
    - WIP

1468277: Rejected: mptcp: store remote token in mptcp sock

1468847: New: [v3,mptcp-next,01/21] mptcp: add csum_enabled in mptcp_sock
1468859: New: [v3,mptcp-next,02/21] mptcp: generate the data checksum
1468855: New: [v3,mptcp-next,03/21] Squash-to: "mptcp: generate the data
checksum"
1468844: New: [v3,mptcp-next,04/21] mptcp: add csum_reqd in
mptcp_out_options
1468840: New: [v3,mptcp-next,05/21] mptcp: send out checksum for
MP_CAPABLE with data
1468856: New: [v3,mptcp-next,06/21] Squash-to: "mptcp: send out checksum
for MP_CAPABLE with data"
1468842: New: [v3,mptcp-next,07/21] mptcp: send out checksum for DSS
1468860: New: [v3,mptcp-next,08/21] Squash-to "mptcp: send out checksum
for DSS"
1468841: New: [v3,mptcp-next,09/21] mptcp: add sk parameter for
mptcp_parse_option
1468853: New: [v3,mptcp-next,10/21] mptcp: add csum_reqd in
mptcp_options_received
1468843: New: [v3,mptcp-next,11/21] mptcp: receive checksum for
MP_CAPABLE with data
1468846: New: [v3,mptcp-next,12/21] Squash-to: "mptcp: receive checksum
for MP_CAPABLE with data"
1468857: New: [v3,mptcp-next,13/21] mptcp: receive checksum for DSS
1468850: New: [v3,mptcp-next,14/21] Squash-to: "mptcp: receive checksum
for DSS"
1468845: New: [v3,mptcp-next,15/21] mptcp: validate the data checksum
1468849: New: [v3,mptcp-next,16/21] Squash-to: mptcp: validate the data
checksum
1468858: New: [v3,mptcp-next,17/21] mptcp: tune re-injections for csum
enabled mode.
1468848: New: [v3,mptcp-next,18/21] mptcp: add the mib for data checksum
1468851: New: [v3,mptcp-next,19/21] mptcp: add a new sysctl
checksum_enabled
1468852: New: [v3,mptcp-next,20/21] selftests: mptcp: enable checksum in
mptcp_connect.sh
1468861: New: [v3,mptcp-next,21/21] selftests: mptcp: enable checksum in
mptcp_join.sh:
    - only the 'Squash-to' patches are new from v2

    - a few attention points, see the cover-letter:
        - the csum computation in the tx path is very suboptimal
(re-computations).
        - csum computation in the rx path for DSS with data fin set is
likely incorrect: len(DATA_FIN) = 1 but not affecting the data part of
the checksum

    - → proposition is to address the above with additional squash-to
patches to avoid complex/extra long review cycles.

    - Mat will have a look at it

    - Next steps would be to do a validation with mptcp.org kernel
(mptcp_trunk branch or the future mptcp_v0.96 one)


1469144: New: mptcp: create listening socket only if signal flag is set on:
    - seems OK but to be Acked



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 178)

  180  Get an update when MPTCP fall back to TCP [enhancement]:
      - another fd to spread the informations?
      - use the err queue?
          - so the userspace app would be able to request details from
the kernel
          - but it might break apps designed for TCP:
              - can we have a POLLERR event in normal conditions while
the connection continue?
              - or only change this behaviour if the userspace app asks
for it? setsockopt
      - CMSG would not wake up the userspace app:
          - seems not ideal
          - but it should happen after having exchanged msg so the
userspace app should have been waken up
          - in theory apps should ignore unknown CMSG
    - → TODO: *Matth:* copy this to the ticket → Done


    Bugs (opened, flagged as "bug" and assigned)

  178  Server hang when proxying over multiple subflows [bug] [v5.11]
[v5.12] @pabeni:
      - Paolo sent patches to try to detect when the corruption happens
      - *all*: Looking for help to find new ideas about how to debug
this. Any idea?
      - Maxim was able to help with many splats and debug info, thx!
      - Nobody else saw the issue in different setups
      - Maybe it could help to "simplify" the setup trying to find
what's cause issues

  176  BPF selftest got "fallback to TCP" and "Attempt to release TCP
socket in state 8" errors [bug] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  172  WARNING in sk_stream_kill_queues [bug]:
      - Matth's CI was able to get it a second time this week but not
anymore after
      - *Paolo* suggested to add DEBUG patches to try to get more
informations
      - TODO: *Matth:* try to reproduce it locally → Done

  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug]:
      - Often visible on the public CI

  120  [interop] netnext is dropping packets, causing MPTCP-level
retransmissions on mptcp.org [bug]
  107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
   65  clearing properly the status in listen() [bug]
   56  msk connection state set without msk lock [bug]


    In Progress (opened and assigned)

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

  162  sendmsg()/recvmsg() fail when an unknown MSG_* flag argument is
provided [bug] @pabeni
  146  DATA_FIN is not retransmitted on timeout [bug] @mjmartineau



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.13):
https://github.com/multipath-tcp/mptcp_net-next/projects/8
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - net:
        - Do all patches with a Fixes tag have to go to -net (or go
there at some points)?:
            - Here we have two minor fixes:
                - one using a macro instead of a magic number
                - one fixing stuff displayed in pr_debug()
            - → not urgent, can go to -net or net-next
            - but more urgent to send DATA_FIN retransmit
        - Mat will send the "DATA_FIN retransmit" patch

    - net-next:
        - Mat will send "MSG_PEEK support" and "ignore unsupported msg
flags" series



Extra tests:
    - news about Syzkaller? (Christoph):
        - *@Christoph:* may you check if there are any new ones please? :)

    - news about interop with mptcp.org? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - CI sending emails again, MPTCP tests are passing

    - packetdrill (Davide):
        - working on supporting subflow endpoints

    - CI (Matth):
        - Better IRC notification message including what was wrong with
emojis (❌/🔴/✅)
        - More details in the summary file
        - summary file in root dir → less clicks to get it
        - increase timeout to 45 minutes per job (required with the
public CI)
        - Pull docker images instead of building them to accelerate
'builds' and 'topgit sync' jobs
        - Improved manual mode

        - Should we save more stuff? e.g. vmlinux with the kvm tests?:
            - maybe vmlinux if not too big? Currently 125MB
            - but should be compress → vmlinuz
            - Matth: TODO check that
        - Maybe the pcap? But maybe too costly (size + CPU)

        - Could be nice to run 'checkpatch' but only on new patches



CI:
    - manual mode: (from the kernel space)
        $ docker pull mptcp/mptcp-upstream-virtme-docker:latest
        $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm
-it mptcp/mptcp-upstream-virtme-docker:latest <manual-normal |
manual-debug | auto-normal | auto-debug | auto-all>
    - TODO: Matth: put that in the wiki → Done



Patchew:
    - CI seems ready
    - *Davide* will setup a meeting next week



Selftests:
    - It can be quite slow (especially on a public CI)
    - Some tests are unstable
    - Some tests could be quicker
    - We could have more reliable tests and quicker ones if we don't
wait for a "random" time but for an action like we do in
mptcp_connect.sh → wait for an IP, not 'sleep 1'.



Meetings:
    - Should we consider different time slots for new contributors from
China?
    - It will always be late at night and soon in the morning for some
    - Maybe:
        - alternate: different hours per week

    - TODO: Matth: send an email to see if new contributors would like
to participate taking into consideration the possible language barriers

    - Email from last time:
https://lore.kernel.org/mptcp/bdbff332-4605-52bd-0aa3-f6f7dba0c9ff@tessares.net/



Next meeting:
    - On Thursday, the 29th of April.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210429



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
