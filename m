Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281802F21
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 17:57:44 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id a23so12376957eju.3
        for <mptcp@lists.linux.dev>; Thu, 03 Mar 2022 09:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=H0kzuliksup4K4IX74zO3wvcWtKbWbs1CqEHVmM0EBA=;
        b=hh6K1g6ruaro0ZgYYwtpvaKP/QmPAOzaZgtGYG058MTUoSIu08SxPfBTYQ6CObfByJ
         RP/Yoz9WgOgp2xgQFD0zsILSXIQKnVv2C09BfG3d5Y+JS219nvHgbohnqH0NetBgZ0kY
         7dzhQg6rKZVLH5yvGc7ygUPNshPZTxoyEHFTHKvpmHBdGDBIpbM11nzUMm42jUrIr7DN
         B4CeMf0RwnzobDy4Npygpp47/4hfzYMFsPfcLtTOTHDhPaoZOGQrdnFVD6qqUb9g9+aW
         lj4j3kk+SI2JqDdOjFU+knvObeuxIQXRJdDTbHKV8hi2KMZj6DKEtRRH8kwW3CviUyC3
         2yvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=H0kzuliksup4K4IX74zO3wvcWtKbWbs1CqEHVmM0EBA=;
        b=qBpDfUj3VCBOb+yLNDJi8cfRUcyq/AYFQSVwC7MtMaiDDWXHLOMvsm3C0ehm180IEr
         xrInNbZTG/NFrrfNLmV+fzrobg+VYSreyzhCCKaUfl+8ELx5XkLjyRDyE0c8goBd7d9b
         T71Mpo30SY7G9go2JOCgsIT04Rc4uKCkEI7MkljLb+zGDwBdHJKgAeE4nV1KWm+nq0ZZ
         zQF3pTEvxjuD9U1M3uypN2VqbYrq/W1ETzgIE3iQRLinMp80SJ0G/EFuVJNgybxu1GLD
         mprTnJyh2afg17BYWPnT6EGYaern3eANe4Adxi6YkgdukNA7BCjUsblxD/BgsNR30v/L
         h87Q==
X-Gm-Message-State: AOAM533+nVvzPQ2TXPXL45684ZrvcjiJmP6+7omkUOjyT3oCIrW3PXqE
	IeKT/oE/ipdLGawcGcu33fSuawk/SYRftBBD
X-Google-Smtp-Source: ABdhPJwcXKPHgJoCErA15zk+5XS52Pjo+B0rhYLcbX2i44Ca7yiB7HjDV+cR2RccJFUWiMfYe6gjPw==
X-Received: by 2002:a17:907:971c:b0:6d6:e503:131b with SMTP id jg28-20020a170907971c00b006d6e503131bmr11083149ejc.121.1646330262384;
        Thu, 03 Mar 2022 09:57:42 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:9692:b15:c6e7:1c2e? ([2a02:578:8593:1200:9692:b15:c6e7:1c2e])
        by smtp.gmail.com with ESMTPSA id k9-20020a1709063e0900b0069f263a80fesm946825eji.171.2022.03.03.09.57.41
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 09:57:42 -0800 (PST)
Message-ID: <d1bc3dec-e704-555c-3de3-614d4125c88a@tessares.net>
Date: Thu, 3 Mar 2022 18:57:41 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 3rd of March 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This Thursday, we had our 186th meeting with Mat, Ossama, Kishen (Intel)
Florian, Paolo, Davide (Red Hat), Geliang (Suse), Giray (Parkyeri) and
myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12759487  [net,3/3] mptcp: Correctly set DATA_FIN timeout when number of
retran...
12759486  [net,2/3] selftests: mptcp: do complete cleanup at exit
12759485  [net,1/3] mptcp: accurate SIOCOUTQ for fallback socket


    our repo (by: Geliang Tang, Matthieu Baerts, Yonglong Li):

12763419  [mptcp-next,v2,2/2] bpf: examples: fix libbpf 0.7 deprecated
warnings
12763418  [mptcp-next,v2,1/2] bpf: examples: static library link to libbpf

12759954  mptcp: send ADD_ADDR echo before create subflows

12759424  [mptcp-next] selftests: mptcp: drop msg argument of chk_csum_nr

12759309  [mptcp-next,v4,12/12] selftests: mptcp: join: make it
shellcheck comp...
12759308  [mptcp-next,v4,11/12] selftests: mptcp: join: avoid backquotes
12759305  [mptcp-next,v4,10/12] selftests: mptcp: join: clarify
local/global va...
12759304  [mptcp-next,v4,09/12] selftests: mptcp: join: helper to filter TCP
12759303  [mptcp-next,v4,08/12] selftests: mptcp: join: list failure at
the end
12759306  [mptcp-next,v4,07/12] selftests: mptcp: join: alt. to exec
specific t...
12759307  [mptcp-next,v4,06/12] selftests: mptcp: join: option to
execute speci...
12759301  [mptcp-next,v4,05/12] selftests: mptcp: join: reset failing links
12759300  [mptcp-next,v4,04/12] selftests: mptcp: join: define tests
groups once
12759299  [mptcp-next,v4,03/12] Squash to "selftests: mptcp: add
implicit endpo...
12759302  [mptcp-next,v4,02/12] Squash to "selftests: mptcp: join: allow
runnin...
12759298  [mptcp-next,v4,01/12] Squash to "selftests: mptcp: Add tests
for user...



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang):

12756495  [iproute2-next,v3,3/3] mptcp: add port support for setting flags
12756494  [iproute2-next,v3,2/3] mptcp: add fullmesh support for setting
flags
12756493  [iproute2-next,v3,1/3] mptcp: add fullmesh check for adding
address:
    - have been accepted 4 days ago


    our repo (by: Dmytro SHYTYI, Florian Westphal, Geliang Tang, Jiapeng
Chong, Kishen Maloor, Mat Martineau, Matthieu Baerts):

12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to
tcp.h/mptcp.h
12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in
reset packets
12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support
12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp
stack
12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes
socket with unread data
12321111: RFC: mptcp: Remove redundant assignment to remaining
12714439: RFC: [net-next,v2] net: mptcp, Fast Open Mechanism:
    - WIP

12733808: Changes Requested: [mptcp-next,v4,01/13] mptcp: allow ADD_ADDR
reissuance by userspace PMs
12733811: Changes Requested: [mptcp-next,v4,02/13] mptcp: handle local
addrs announced by userspace PMs
12733810: Changes Requested: [mptcp-next,v4,03/13] mptcp: read
attributes of addr entries managed by userspace PMs
12733817: Changes Requested: [mptcp-next,v4,04/13] mptcp: netlink: split
mptcp_pm_parse_addr into two functions
12733812: Changes Requested: [mptcp-next,v4,05/13] mptcp: netlink: Add
MPTCP_PM_CMD_ANNOUNCE
12733813: Changes Requested: [mptcp-next,v4,06/13] mptcp: selftests:
support MPTCP_PM_CMD_ANNOUNCE
12733814: Changes Requested: [mptcp-next,v4,07/13] mptcp: netlink: Add
MPTCP_PM_CMD_REMOVE
12733815: Changes Requested: [mptcp-next,v4,08/13] mptcp: selftests:
support MPTCP_PM_CMD_REMOVE
12733821: Changes Requested: [mptcp-next,v4,09/13] mptcp: netlink: allow
userspace-driven subflow establishment
12733816: Changes Requested: [mptcp-next,v4,10/13] mptcp: selftests:
support MPTCP_PM_CMD_SUBFLOW_CREATE
12733818: Changes Requested: [mptcp-next,v4,11/13] mptcp: selftests:
support MPTCP_PM_CMD_SUBFLOW_DESTROY
12733819: Changes Requested: [mptcp-next,v4,12/13] mptcp: selftests:
capture netlink events
12733820: Changes Requested: [mptcp-next,v4,13/13] selftests: mptcp:
functional tests for the userspace PM type
12733865: Changes Requested: [mptcp-next,v5,1/8] mptcp: bypass in-kernel
PM restrictions for non-kernel PMs
12733864: Changes Requested: [mptcp-next,v5,2/8] mptcp: store remote id
from MP_JOIN SYN/ACK in local ctx
12733867: Changes Requested: [mptcp-next,v5,3/8] mptcp: reflect remote
port (not 0) in ANNOUNCED events
12733866: Changes Requested: [mptcp-next,v5,4/8] mptcp: establish
subflows from either end of connection
12733868: Changes Requested: [mptcp-next,v5,5/8] mptcp: netlink: store
per namespace list of refcounted listen socks
12733869: Changes Requested: [mptcp-next,v5,6/8] mptcp: netlink: store
lsk ref in mptcp_pm_addr_entry
12733870: Changes Requested: [mptcp-next,v5,7/8] mptcp: attempt to add
listening sockets for announced addrs
12733871: Changes Requested: [mptcp-next,v5,8/8] mptcp: expose
server_side attribute in MPTCP netlink events:
    - depending on a series below to rework the MPTCP listening sockets
for MPJ

12758809: Needs ACK: [mptcp-next,1/4] mptcp: prefer ip address in syn
skb instead of listen sk bound address
12758808: Needs ACK: [mptcp-next,2/4] tcp: add mptcp join demultiplex hooks
12758810: Needs ACK: [mptcp-next,3/4] mptcp: handle join requests via
pernet listen socket
12758811: Needs ACK: [mptcp-next,4/4] mptcp: remove per-address
listening sockets:
12765701: New: [5/4] mptcp: handle join requests early
    - series: mptcp: replace per-addr listener sockets
    - does an extra MPTCP check for every SYN packet

    - patch 4/4 changes a bit the behaviour:
        - it might prevent establishing some MPJ if the system is not
properly configured
        - but it simplifies stuff:
            - a bunch of code from Kishen's series can be removed

            - because we no longer need to create listening sockets
    - patch 5/4:
        - more to show that there are solutions
        - more work is needed to go into that direction
        - but it will need refactoring on the TCP code (creating helpers
to re-use them with MPTCP)
        - (to handle re-using port, sockets in timewait, etc.)
    - Patch 1-4 can be added to the export branch but if we are not sure
we want to send them to netdev, that might add complexity elsewhere

    - see series below ↓

12759420: RFC: [RFC,mptcp-next,1/4] mptcp: Move some symbols to be
visible outside the MPTCP subsystem
12759421: RFC: [RFC,mptcp-next,2/4] tcp: Allow tcp_check_req() to return
more status values
12759422: RFC: [RFC,mptcp-next,3/4] tcp: Check for the presence of a
MP_JOIN option
12759423: RFC: [RFC,mptcp-next,4/4] tcp: Add TCP hooks for detecting
MP_JOIN on a regular TCP listener:
    - To be applied on top of Florian' series ↑, (patches 1-4)  doing
stuff differently

    - using TCP Option parsing paths:
        - more modifications in TCP code
        - doing the check later than what is done in Florian's series

    - Maybe good to document what is not OK / changing the current
behaviour to be able to compare/discuss

    - These two series are trying to improve the situation in these cases:
        - accepting MPJ on a different port
        - and/or accepting MPJ while the listening socket has been closed
        - but also "conflicts" that can happen: a TCP listening socket
is created before/after using the same port

    - Maybe best not to have a complex code for specific UCs (MPJ on a
different port). Maybe OK to change the behaviour later for these cases.
    - Maybe easier to explain: TCP sockets have the priority and that's it.

    - both solutions look good, doing stuff differently:
        - we want to agree on the direction we want to go: if we want
these RFC patches not to change the behaviour twice, best to take this
decision now
        - probably best to send a RFC or an email describing the idea to
Eric to explain the situation and see what is possible to change in TCP code


12767060: New: [mptcp-next,1/2] mptcp: add MP_FAIL response support
12767061: New: [mptcp-next,2/2] mptcp: reset the subflow when MP_FAIL is
lost:
    - series: "MP_FAIL echo and retrans"
    - replace the five RFC patches
    - to be reviewed


12767610: New: [RESEND,mptcp-next,v5,1/3] Squash to "bpf: add
'bpf_mptcp_sock' structure and helper"
12767611: New: [RESEND,mptcp-next,v5,2/3] bpf: implement bpf_mptcp_sock()
12767612: New: [RESEND,mptcp-next,v5,3/3] selftests: bpf: exercise
bpf_mptcp_sock():
    - "new bpf_mptcp_sock()"
    - Matt did a review and suggested some modifications, discussions
can continue on the ML




Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 263)

/

    Bugs (opened, flagged as "bug" and assigned)

  203  PM: server: accept subflows [bug] @kmaloor:
      - see patches above


    Bugs (opened and flagged as "bug" and not assigned)

  263  selftests: join: missing MP_JOINs but ADD_ADDR OK with `multiple
flows, signal, link failure` [bug] [selftests]:
      - seen only once on a public CI
      - we can probably close it
      - Matth → TODO: close → Done

  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]:
      - Davide saw the same issue when doing some tests on his side
      - always issues with packet that have to be retransmitted
      - a regression? even if it is one, maybe not an issue?
      - maybe best to instrument the code?
          - Davide can look at that while working in this area

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]


    In Progress (opened, new feature and assigned)

  261  MP_FAIL echo and retrans [enhancement] @geliangtang:
      - see patches above

  246  Netlink PM events: add one attribute about the connection type
(connect/accept) [enhancement] @kmaloor:
      - see patches above

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva

  216  The infinite mapping support [enhancement] @geliangtang
      - see patches above (but there is more than just these patches)

  186  Add netlink command support [enhancement] @kmaloor
      - see patches above

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   75  BPF: packet scheduler [enhancement] @geliangtang
   74  BPF: path manager [enhancement] @geliangtang


    For later (opened and not assigned assigned)

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

None.



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.18):
https://github.com/multipath-tcp/mptcp_net-next/projects/13
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches for netdev:

    - Fixes for -net:

        - [ddcd841b2334] mptcp: accurate SIOCOUTQ for fallback socket
(Paolo Abeni)
        - [2d60ccd4c482] selftests: mptcp: do complete cleanup at exit
(Paolo Abeni)
        - [a401c1649c07] mptcp: Correctly set DATA_FIN timeout when
number of retransmits is large (Mat Martineau)
        → all have been upstreamed (but -net needs to be sync with net-next)


    - Features for net-next:

        - [aafeb79857cd] selftests: mptcp: adjust output alignment for
more tests (Geliang Tang):
            - should be ready

        - [789d5a3bb5d0] mptcp: add the mibs for MP_FASTCLOSE (Geliang Tang)
        - [80872f78d73b] selftests: mptcp: add the MP_FASTCLOSE mibs
check (Geliang Tang):
            - should be ready

        - [bc9c5aef45b0] mptcp: add the mibs for MP_RST (Geliang Tang)
        - [d46a736fc166] selftests: mptcp: add the MP_RST mibs check
(Geliang Tang):
            - should be ready

        - [c905f71b1099] selftests: mptcp: add extra_args in do_transfer
(Geliang Tang)
        - [9741a627942b] selftests: mptcp: reuse linkfail to make given
size files (Geliang Tang)
        - [f73f0604f85b] selftests: mptcp: add fastclose testcase
(Geliang Tang):
            - should be ready

        - [63a2ca739872] mptcp: don't send RST for single subflow
(Geliang Tang)
        - [7b4e3bb5dfa2] mptcp: add the fallback check (Geliang Tang)
        - [d351ebf75c78] mptcp: track and update contiguous data status
(Geliang Tang)
        - [ba9c8aebaacc] mptcp: infinite mapping sending (Geliang Tang)
        - [e3f6b67e1f90] mptcp: infinite mapping receiving (Geliang Tang)
        - [215bb2821e92] mptcp: add mib for infinite map sending
(Geliang Tang)
        - [012789aea532] selftests: mptcp: add infinite map mibs check
(Geliang Tang)
        - [978ef2e7feae] selftests: mptcp: add invert check in
check_transfer (Geliang Tang)
        - [36dddd87dc97] selftests: mptcp: add more arguments for
chk_join_nr (Geliang Tang)
        - [5a4dccc21d93] selftests: mptcp: add the MP_FAIL testcases
(Geliang Tang):
            - some fixes needed for the fallback part

        - [5853d0bb6590] selftests: mptcp: update output info of
chk_rm_nr (Geliang Tang)
        - [dada8f9f8199] mptcp: dump infinite_map field in
mptcp_dump_mpext (Geliang Tang)
        - [4b03697a2597] mptcp: add tracepoint in mptcp_sendmsg_frag
(Geliang Tang):
            - depending on the above

        - [dbc1b65452a0] mptcp: Remove redundant assignments in path
manager init (Mat Martineau)
        - [0427a181de4e] mptcp: Add a member to mptcp_pm_data to track
kernel vs userspace mode (Mat Martineau)
        - [70108606adaf] mptcp: Bypass kernel PM when userspace PM is
enabled (Mat Martineau)
        - [d013cc2a4c76] mptcp: Make kernel path manager check for
userspace-managed sockets (Mat Martineau)
        - [979339c766f4] mptcp: Add a per-namespace sysctl to set the
default path manager type (Mat Martineau)
        - [5dd4b510dde6] selftests: mptcp: Add tests for userspace PM
type (Mat Martineau):
            - preferred to wait for PM improvements

        - [ee83db931185] mptcp: use MPTCP_SUBFLOW_NODATA (Geliang Tang):
            - should be ready

        - [7601d361bbf3] selftests: mptcp: join: allow running -cCi
(Matthieu Baerts):
            - should be ready

        - [227b6a6d75bb] selftests: mptcp: Rename wait function (Mat
Martineau):
            - should be ready

        - [8a35f9fbb77c] mptcp: more careful RM_ADDR generation (Paolo
Abeni)
        - [7e8d1c317217] mptcp: introduce implicit endpoints (Paolo Abeni)
        - [bb3fb75e1c2e] mptcp: strict local address ID selection (Paolo
Abeni)
        - [71f2a5287d45] selftests: mptcp: add implicit endpoint test
case (Paolo Abeni):
            - should be ready

        - [7f920d0b2da4] mptcp: add fullmesh flag check for adding
address (Geliang Tang):
            - should be ready

        - [9d743632fcdc] selftests: mptcp: drop msg argument of
chk_csum_nr (Geliang Tang)
        - [075bec1cf279] selftests: mptcp: join: define tests groups
once (Matthieu Baerts)
        - [58bb4f52d17f] selftests: mptcp: join: reset failing links
(Matthieu Baerts)
        - [511d14e3113c] selftests: mptcp: join: option to execute
specific tests (Matthieu Baerts)
        - [71dc6982cc20] selftests: mptcp: join: alt. to exec specific
tests (Matthieu Baerts)
        - [832ca66760a6] selftests: mptcp: join: list failure at the end
(Matthieu Baerts)
        - [4a735c5eb0f8] selftests: mptcp: join: helper to filter TCP
(Matthieu Baerts)
        - [3405d6276d1e] selftests: mptcp: join: clarify local/global
vars (Matthieu Baerts)
        - [4fca0d28c32e] selftests: mptcp: join: avoid backquotes
(Matthieu Baerts)
        - [595d070fb98c] selftests: mptcp: join: make it shellcheck
compliant (Matthieu Baerts):
            - should be ready

        - [7ebc86d1121b] mptcp: send ADD_ADDR echo before create
subflows (Yonglong Li)



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - /

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - issue on Intel's kbuild again but already fixed!

    - packetdrill (Davide):
        - Davide is modifying it to be able to accept MPJ without having
an ADD_ADDR
        - allowing MPTCP end-points

    - Patchew (Davide):
        - /

    - CI (Matth):
        - cirrus-ci has some issues for the moment: not building
        - packetdrill: the tolerance has been increased
        - preparing testing -net branch: with different versions of
packetdrill and other scripts
        - removed a workaround for kselftests headers, linked to
"selftests: mptcp: Add the uapi headers include variable" in linux-next
        - debug: now using 'debug.config' file:
            - support for KMemLeak
            - UBSAN now enabled
            - without SLUB_DEBUG: too heavy
            - config diff:

  -DEBUG_PAGEALLOC_ENABLE_DEFAULT n
   BUG_ON_DATA_CORRUPTION n -> y
   DEBUG_KMEMLEAK n -> y
   DEBUG_LIST n -> y
   DEBUG_LOCKDEP y -> n
   DEBUG_OBJECTS n -> y
   DEBUG_PAGEALLOC y -> n
   DEBUG_PER_CPU_MAPS n -> y
   DEBUG_SECTION_MISMATCH n -> y
   DEBUG_VIRTUAL n -> y
   DEBUG_VM n -> y
   DETECT_HUNG_TASK n -> y
   KASAN_INLINE n -> y
   KASAN_OUTLINE y -> n
   KASAN_VMALLOC n -> y
   PAGE_EXTENSION n -> y
   PAGE_OWNER n -> y
   PANIC_ON_OOPS n -> y
   PANIC_ON_OOPS_VALUE 0 -> 1
   PREEMPT y -> n
   PREEMPT_VOLUNTARY n -> y
   PRINTK_CALLER n -> y
   PTDUMP_DEBUGFS n -> y
   SCHED_STACK_END_CHECK n -> y
   SOFTLOCKUP_DETECTOR n -> y
   UBSAN n -> y
  +BOOTPARAM_HUNG_TASK_PANIC n
  +BOOTPARAM_HUNG_TASK_PANIC_VALUE 0
  +BOOTPARAM_SOFTLOCKUP_PANIC n
  +BOOTPARAM_SOFTLOCKUP_PANIC_VALUE 0
  +CC_HAS_UBSAN_BOUNDS y
  +CPUMASK_OFFSTACK n
  +DEBUG_KMEMLEAK_AUTO_SCAN y
  +DEBUG_KMEMLEAK_DEFAULT_OFF n
  +DEBUG_KMEMLEAK_MEM_POOL_SIZE 16000
  +DEBUG_KMEMLEAK_TEST n
  +DEBUG_KOBJECT_RELEASE n
  +DEBUG_OBJECTS_ENABLE_DEFAULT 1
  +DEBUG_OBJECTS_FREE y
  +DEBUG_OBJECTS_PERCPU_COUNTER y
  +DEBUG_OBJECTS_RCU_HEAD y
  +DEBUG_OBJECTS_SELFTEST n
  +DEBUG_OBJECTS_TIMERS y
  +DEBUG_OBJECTS_WORK y
  +DEBUG_VM_PGFLAGS y
  +DEBUG_VM_RB y
  +DEBUG_VM_VMACACHE y
  +DEFAULT_HUNG_TASK_TIMEOUT 120
  +LOCKUP_DETECTOR y
  +PTDUMP_CORE y
  +TEST_DEBUG_VIRTUAL n
  +TEST_UBSAN n
  +UBSAN_ALIGNMENT n
  +UBSAN_BOOL y
  +UBSAN_BOUNDS y
  +UBSAN_DIV_ZERO n
  +UBSAN_ENUM y
  +UBSAN_ONLY_BOUNDS y
  +UBSAN_SANITIZE_ALL y
  +UBSAN_SHIFT y
  +UBSAN_TRAP n
  +VMAP_STACK y


Modification of the TopGit tree:
    - suggestion:

        * export
        *   (...)
        *   MPTCP commits for net-next
        *   (...)
        |\
        | *   (...)
        | * MPTCP commits for -net
        | *   (...)
        * | top of net-next branch
        |\|
        | * top of -net branch
        | | (...)

    - is it OK for you Paolo with stgit?



Documentation:
    - Seems needed: https://blog.benjojo.co.uk/post/multipath-without-mptcp
    - maybe reworking the home wiki page?f
    - best to discuss about that next week



Next meeting:
    - Next one on Thursday, the 3rd of March.
    - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220303



Feel free to comment on these points and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
