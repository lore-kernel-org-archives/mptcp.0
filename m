Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182E67F
	for <mptcp@lists.linux.dev>; Mon,  1 Aug 2022 16:24:31 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so7685978wmb.5
        for <mptcp@lists.linux.dev>; Mon, 01 Aug 2022 09:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=JegU4P81/gMlYj9ZvDT5FL0wjUTciPQ0ywbhMhxGqsQ=;
        b=o2n/VGRI7KWwSQWhAKqQV3yW4ciFS1Wdc8/7FhwaWlXprrTrCPyHVkNf+KzbZIUPJU
         ACXHtkamo5Z7OcMQuz0BPxQH18b/wKRN9YgxX397uyyuzTGyT3WyU2hDJfw+kTKY7soD
         HL+G/mZEiW5vc60fe/62YP9S/T5fzc1uAhr/6xky//pcWqjyvyh34jsymetuQB0fQRte
         NVp5Y+1hLuG1R5H4jGQ8oBrbwYP4fA2fBFCCtE2LsfTT3LMntj0gwLKnnWetCrDHrkf4
         vAcTecVPHNgNxoyI860cGXwR3xy16LZyHD2RtdhPDiIG47hVyp/vDNTQnw5wOIZxAkOb
         frjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=JegU4P81/gMlYj9ZvDT5FL0wjUTciPQ0ywbhMhxGqsQ=;
        b=zvHJ4qhQ8tJyrWNsLkB2CflMzV6tyz4VadDkYiHMCRB21lbSvg3rP7pOW5fa7cm8Cx
         VynumGLqgyc961ylw+yYlDm4OEGzeAgC5Sdo9B5pctZKgOn/HSB1fAMndgTRmrpt1EpB
         H+tdB6yCL3W/pjuLiBypsVkkReh4ydV0DxkKVOIJjrBvi/PcvU4E5jwfjxmBG1TViQSY
         xWlMIl8V0x6qCqgYfdOpdni9ejPAl+llGZALv1H8fNqSN8RuHprwGnEzSxlTEDazQqMM
         F1cVSlVqB8bp6Mj1M9XWlkNsnnEe639z3vElGgPiyyZAeFE2dkNbAwDH6Q95dcaGhvFu
         ZCjg==
X-Gm-Message-State: AJIora8f6X4sQYTFhKueCZ9sZplrKVyYwNBEOUdV0/Sue5lPeunrJ22d
	IV7fTmDhwJbMkQYjJ9Xj7XmhXaWx38UkD5Le
X-Google-Smtp-Source: AGRyM1vA5qtRr1bytbzFgobrIz2caoWWi+qUurMhNu6pYOKh28DrG4f0OXj6l5Hvu68Rnx8GmDU+oQ==
X-Received: by 2002:a05:600c:2652:b0:3a3:2a3e:a2de with SMTP id 18-20020a05600c265200b003a32a3ea2demr11833138wmy.174.1659371069855;
        Mon, 01 Aug 2022 09:24:29 -0700 (PDT)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id g18-20020adffc92000000b0021e43b4edf0sm12384452wrr.20.2022.08.01.09.24.29
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 09:24:29 -0700 (PDT)
Message-ID: <c1785ecc-d955-e6cf-0390-81b5fa761118@tessares.net>
Date: Mon, 1 Aug 2022 18:24:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 28th of July 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 203rd meeting with Mat, Ossama (Intel),
Dmytro (SFR), Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12928418: [net] mptcp: Do not return EINPROGRESS when subflow creation
succeeds:
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220725205231.87529-1-mathew.j.martineau@linux.intel.com/


    our repo (by: Mat Martineau, Paolo Abeni):

12919013: [mptcp-net] mptcp: move subflow cleanup in mptcp_destroy_common():
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/bcfa7cfc41ada0c8811794cb3c45cdeb1b34f303.1657883173.git.pabeni@redhat.com/

12919561: [mptcp-net] mptcp: Do not return EINPROGRESS when subflow
creation succeeds:
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220715181207.522021-1-mathew.j.martineau@linux.intel.com/

12928285: [mptcp-net] mptcp: do not queue data on closed subflows:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/937464128633daa18ebc093215ac04487f001b3f.1658769042.git.pabeni@redhat.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Dmytro SHYTYI, Geliang Tang, Jason Wang, Jiapeng
Chong, Jiri Olsa, Matthieu Baerts):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
12321111: mptcp: Remove redundant assignment to remaining
12858306: [RFC,mptcp-next,v3] mptcp: Fast Open Mechanism:
      - State: Changes requested
      - Submitter: Dmytro SHYTYI
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220522183921.103526-1-dmytro@shytyi.net/
      - Dmytro presented the progress he did:
          - the cookie request seems working as expected during the
first connection when looking at the traces
          - except the DATA_FIN which is duplicated: something not
investigated yet
          - following connections have now data in the SYN but MPTCP seq
num are wrong:
              - the validation has to be dropped for the client to
receive the data, not just the data from the SYN
              - (and probably it only works with one subflow)
          - Dmytro will send a new version with the modifications he
presented.
      - Follow-up can also be done on the Github ticket
      - Dmytro will share the slides there
      - https://github.com/multipath-tcp/mptcp_net-next/issues/59

12901431: [mptcp-next,v10,1/5] Squash to "mptcp: add get_subflow wrappers"
12901432: [mptcp-next,v10,2/5] mptcp: redundant subflows push pending
12901433: [mptcp-next,v10,3/5] mptcp: redundant subflows retrans support
12901434: [mptcp-next,v10,4/5] selftests/bpf: Add bpf_red scheduler
12901435: [mptcp-next,v10,5/5] selftests/bpf: Add bpf_red test:
      - State: Changes requested
      - Series: BPF redundant scheduler
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=655328&state=*&archive=both

12913752: [bpf-next] mptcp: Add struct mptcp_sock definition when
CONFIG_MPTCP is disabled:
      - State: Changes requested
      - Submitter: Jiri Olsa
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220711130731.3231188-1-jolsa@kernel.org/
      - Note sure if Jiri is going to change it.
      - *TODO* Matth: send email to Jiri → Done

12922458: mptcp: Fix comment typo:
      - State: Changes requested
      - Submitter: Jason Wang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220716044226.43587-1-wangborong@cdjrlc.com/
      - Note sure we will have a v2



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last meeting: 291)

None.


    Bugs (opened, flagged as "bug" and assigned)

  288  [syzkaller] memory leak in __netlink_create [bug] @mjmartineau:
      - still happening but not related to MPTCP
      - *Mat* will check if it has been reported by syzbot or someone
else on netdev → it has not been reported by syzbot

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug] @mjmartineau:
      - *Florian*: are you looking at it?
      - *Mat* will send a dedicated email to Florian


    Bugs (opened and flagged as "bug" and not assigned)

  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]
  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]


    In Progress (opened, new feature and assigned)

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
       - See patches above

   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

None.


    Open questions (opened, questions and not assigned)

None.


    For later (opened and not assigned assigned)

  289  mptcp: audit comments for non inclusive language [enhancement]
  273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdrill]
  269  Allow having a mix of v4/v6 subflows for the same socket
[enhancement]
  266  Packetdrill: add MP_FAIL coverage [packetdrill]
  236  Review supported sockopts list [enhancement]
  222  Netlink event API: add SUBFLOW_CREATED event [enhancement]
  215  TCP Urgent pointer and MPTCP [enhancement]
  213  add MPTCP man page [enhancement]
  208  better handing of ssk memory pressure in the TX path [enhancement]
  202  Add sendmsg support for ancillary data [enhancement]
  197  more mibs needed [enhancement]
  180  Get an update when MPTCP fall back to TCP [enhancement]
  177  improve retransmit subflow selection [enhancement]
  169  packetdrill: add coverage for ADD_ADDR and MP_JOIN on a different
port [enhancement] [packetdrill]
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
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since last week)

  280  support of ndiffport [question]:
      - Mat is looking at implementing that in mptcpd
      - For the kernel side, everything seems to be there to have this
working
      - For the mptcpd side, it depends on a PR adding MPTCP Upstream
Netlink commands support



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.20/6.0):
https://github.com/multipath-tcp/mptcp_net-next/projects/15
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [8274dcacc6a9] mptcp: move subflow cleanup in
mptcp_destroy_common() (Paolo Abeni)
        - [f9442c050d26] mptcp: do not queue data on closed subflows
(Paolo Abeni):
            - Probably too late for the next batch that is going to be
sent to Linus for the final 5.19 release
            - Mat will check with Paolo to know where/when to send them
→ done

    - Fixes for net-next: /

    - Features for net-next:

        - [2e1afc4408a3] mptcp: add mptcp_for_each_subflow_safe helper
(Matthieu Baerts):
            - depends on "mptcp: move subflow cleanup in
mptcp_destroy_common", can wait

    - Features for net-next (next): /

    - Features for other trees:

        - [4ba1a3ae3b82] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [278e27c00c52] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [b10ad34c536f] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [ccea340949e6] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [bfb156bf3360] mptcp: add get_subflow wrappers (Geliang Tang)
        - [342d78e6876d] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [4ddec94ad688] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang):
            - small adaptation has been done to sync with recent BPF
changes, see ML

        - [b406633da610] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [ecf0fd0de5c0] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [03a38a3ef1e9] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [af1174d91fa2] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [d1ee999c1748] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [bd653323c5bf] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [8f8e81bd0eb9] selftests/bpf: Add bpf_rr test (Geliang Tang)



Extra tests:
    - news about Syzkaller? (Mat):
        - nothing related to MPTCP

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - issues but not related to MPTCP (tools installed before but it
is back now)

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - Davide wanted to upgrade it but there are some issues with the
modifications we did
        - Maybe we need something else if we only need the importer bit?

    - CI (Matth):
        - some small modif in the image used by the CI and some devs,
nothing really important, see Git log



mptcpd:
    - Probably a new release in September supporting the new netlink
commands
    - Matth is looking at sending the v0.10 to Debian (and Ubuntu)



TCP authopt series: Looks like no MPTCP special case is needed, options
are not in allow list in mptcp_supported_sockopt():
    - Related: Are checks for TCP_MD5 in protocol.c/subflow.c now redundant?
    - It is similar to TCP_MD5 but different protocol
    - In the series sent on netdev, there is no special check not to
conflict with MPTCP
    - Now that we have a deny list for the setsockopt, we probably don't
need the check in protocol.c/subflow.c?
    - And it protects us from using TCP authopt in //.



bpf: net: Remove duplicated codes from bpf_setsockopt():
    - Martin from Facebook also suggested to do some changes related to
setsockopt functions, also used in MPTCP
    - https://lore.kernel.org/netdev/20220727060902.2370689-1-kafai@fb.com/



LPC:
    - remote participation possible?
    - to be discussed by email/IRC



Next meeting:
    - Next one on Thursday, the 4th of August.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220804



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
