Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498147E
	for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 16:06:26 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id p9so34510232ejd.6
        for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 08:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=Q0tXQhazOloY7c+ozCWij/PskoDMDKBe4QtOhvqg/GA=;
        b=TkMI7zKjXEG3ZqGP3bQkQEZHQQbHusAESzHBg3zH4KfCHbQzyqO3KEfQjcjc/EfqGo
         TwTrezlLB7d2Ob0Ss9qBRpzWViu9x1qmAg5bZKSJe6RCTx3+/iZFk9bsXTAkSVHMfQfI
         yeUs5+N8LaAFYhfEJSDFlzi1GIJ6a6luyi1gAkd1FGt8rVU4JBFf4Y+ZLf4xEUPWRkpx
         ZgvylAzzJSBisR5VCM15AMczcV0BWKv4KcYjPbIfTOV+vSfGi50M/0AZ9KLIVfBmiuOc
         6Fi7dbt0Y04gGe8E7et4BEHUlyMngsmDcPem9yL9oxVcNkAw34yVeM3sRi5LtxtUm4kv
         YYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=Q0tXQhazOloY7c+ozCWij/PskoDMDKBe4QtOhvqg/GA=;
        b=bXqWm4PnANK9SGz+BpZeOZDOG04elRmnZ+0+EPjR+TKTaxufd6RopAsslQ2k1FS4N3
         JydxXWVEAmKPkYQqja1eIXj6/xWCTkfLPxGG3b/S1zRIIfHuHMiRjKbxhLWiFleXn8a1
         5eiAkff31PNX8TlrAZgxqzlu9feQTFoBXMPInf5emplk9q7tAdGs4W0wBxd99q2PBxSQ
         IwSK6827vl4kUSjHTQztUU3FrjNv7wK/E9mc7NwtSzH9Sg4gzM9InieYc7rP3qjZLaS6
         bUDxZPy2XsjOFIkMQ/lJGnbB7Qjwd6xCqHwPId88lvkMzSh07O1x7Obq+41huMf0rkus
         kXww==
X-Gm-Message-State: AOAM5329pDl7sxk7NNHmBDHTp5Pr0nurl0U5oDWqFzIj9FBVirjKFfaB
	T0Q5ID0eUsHyYEcGAzhqj2WbQXe3X9zKoA==
X-Google-Smtp-Source: ABdhPJwEtF6DxidHsNLFV6xQcKt/DkXhCd7/knLZEFYVLw32aJSXvSQ8G1q78CeQAi0t6e0Bw8Hnkg==
X-Received: by 2002:a17:906:350d:b0:6b9:5871:8f34 with SMTP id r13-20020a170906350d00b006b958718f34mr16072119eja.493.1645459583927;
        Mon, 21 Feb 2022 08:06:23 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id z13sm2669937ejb.131.2022.02.21.08.06.23
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 08:06:23 -0800 (PST)
Message-ID: <f3257718-f00f-ee7d-23a9-6d8d782bed74@tessares.net>
Date: Mon, 21 Feb 2022 17:06:23 +0100
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
Subject: [Weekly meetings] MoM - 17th of February 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 184th meeting with Mat, Ossama, Kishen (Intel)
Florian, Paolo (Red Hat), Giray (Parkyeri) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

12747855  [net-next,8/8] mptcp: don't save tcp data_ready and write
space callb...
12747852  [net-next,7/8] mptcp: mark ops structures as ro_after_init
12747854  [net-next,6/8] mptcp: constify a bunch of of helpers
12747853  [net-next,5/8] mptcp: drop port parameter of
mptcp_pm_add_addr_signal
12747848  [net-next,4/8] mptcp: drop unneeded type casts for hmac
12747850  [net-next,3/8] mptcp: drop unused sk in mptcp_get_options
12747849  [net-next,2/8] mptcp: mptcp_parse_option is no longer exported
12747847  [net-next,1/8] mptcp: add SNDTIMEO setsockopt support


    our repo (by: Florian Westphal, Geliang Tang, Matthieu Baerts, Paolo
Abeni):

12745744  [v4,mptcp-next,1/3] Squash-to: "mptcp: constify a bunch of
helpers"

12744981  [mptcp-next,2/2] mptcp: add tracepoint in mptcp_sendmsg_frag
12744980  [mptcp-next,1/2] mptcp: dump infinite_map field in
mptcp_dump_mpext

12744619  [mptcp-next,v2] selftests: mptcp: add csum mib check for
mptcp_connect

12742037  [mptcp-next] mptcp: subflow: get_af_ops should return const

12742030  [v2,mptcp-next] mptcp: don't save tcp data_ready and write
space call...

12740916  [mptcp-next,6/9] selftests: mptcp: join: check for tools only
if need...
12740915  [mptcp-next,5/9] selftests: mptcp: join: create tmp files only
if nee...
12740914  [mptcp-next,4/9] selftests: mptcp: join: remove unused vars
12740913  [mptcp-next,2/9] selftests: mptcp: join: exit after usage()
12740912  [mptcp-next,1/9] selftests: mptcp: join: allow running -cCi



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Mat Martineau):

12734767  [iproute2-next] mptcp: add the fullmesh flag setting support:
    - Mark as Changes
requested:https://patchwork.kernel.org/project/netdevbpf/patch/49c0f49f6aabf0f55a16034b79d30fbceb1bc997.1643945076.git.geliang.tang@suse.com/
    - Maybe in a week or two it could be resent including a reply to
Stephen's question?

12745977  FAILED: patch "[PATCH] selftests: mptcp: add missing join
check" fail...:
    - conflicts in the backports, probably we don't need it,
    - was a small improvement in the selftests


    our repo (by: Dmytro SHYTYI, Florian Westphal, Geliang Tang, Jiapeng
Chong, Kishen Maloor, Mat Martineau, Matthieu Baerts, Paolo Abeni):

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

12733808: Needs ACK: [mptcp-next,v4,01/13] mptcp: allow ADD_ADDR
reissuance by userspace PMs
12733811: Needs ACK: [mptcp-next,v4,02/13] mptcp: handle local addrs
announced by userspace PMs
12733810: Needs ACK: [mptcp-next,v4,03/13] mptcp: read attributes of
addr entries managed by userspace PMs
12733817: Needs ACK: [mptcp-next,v4,04/13] mptcp: netlink: split
mptcp_pm_parse_addr into two functions
12733812: Needs ACK: [mptcp-next,v4,05/13] mptcp: netlink: Add
MPTCP_PM_CMD_ANNOUNCE
12733813: Needs ACK: [mptcp-next,v4,06/13] mptcp: selftests: support
MPTCP_PM_CMD_ANNOUNCE
12733814: Needs ACK: [mptcp-next,v4,07/13] mptcp: netlink: Add
MPTCP_PM_CMD_REMOVE
12733815: Needs ACK: [mptcp-next,v4,08/13] mptcp: selftests: support
MPTCP_PM_CMD_REMOVE
12733821: Needs ACK: [mptcp-next,v4,09/13] mptcp: netlink: allow
userspace-driven subflow establishment
12733816: Needs ACK: [mptcp-next,v4,10/13] mptcp: selftests: support
MPTCP_PM_CMD_SUBFLOW_CREATE
12733818: Needs ACK: [mptcp-next,v4,11/13] mptcp: selftests: support
MPTCP_PM_CMD_SUBFLOW_DESTROY
12733819: Needs ACK: [mptcp-next,v4,12/13] mptcp: selftests: capture
netlink events
12733820: Needs ACK: [mptcp-next,v4,13/13] selftests: mptcp: functional
tests for the userspace PM type
12733865: Needs ACK: [mptcp-next,v5,1/8] mptcp: bypass in-kernel PM
restrictions for non-kernel PMs
12733864: Needs ACK: [mptcp-next,v5,2/8] mptcp: store remote id from
MP_JOIN SYN/ACK in local ctx
12733867: Needs ACK: [mptcp-next,v5,3/8] mptcp: reflect remote port (not
0) in ANNOUNCED events
12733866: Needs ACK: [mptcp-next,v5,4/8] mptcp: establish subflows from
either end of connection
12733868: Needs ACK: [mptcp-next,v5,5/8] mptcp: netlink: store per
namespace list of refcounted listen socks
12733869: Needs ACK: [mptcp-next,v5,6/8] mptcp: netlink: store lsk ref
in mptcp_pm_addr_entry
12733870: Needs ACK: [mptcp-next,v5,7/8] mptcp: attempt to add listening
sockets for announced addrs
12733871: Needs ACK: [mptcp-next,v5,8/8] mptcp: expose server_side
attribute in MPTCP netlink events:
    - blocked by "mptcp: replace per-addr listener sockets" series, see
below.

12740917: Under Review: [mptcp-next,3/9] selftests: mptcp: join: option
to execute specific tests
12740920: Under Review: [mptcp-next,7/9] selftests: mptcp: join: clarify
local/global vars
12740918: Under Review: [mptcp-next,8/9] selftests: mptcp: join: avoid
backquotes
12740919: Under Review: [mptcp-next,9/9] selftests: mptcp: join: make it
shellcheck compliant:
    - v2 coming soon

12741730: Under Review: [mptcp-next] Squash to "bpf: add
'bpf_mptcp_sock' structure and helper":
    - addressing comments sent by BPF maintainers 1.5y ago
    - one remaining questions about how to test that: see the ML
    - in our repo, there is a "scripts" branch with other BPF tests.
    - there is one question for Geliang, see ML

12744166: New: [mptcp-net] mptcp: Correctly set DATA_FIN timeout when
number of retransmits is large:
    - Linked to https://github.com/multipath-tcp/mptcp_net-next/issues/259
    - Paolo will ACK it


12745745: New: [v4,mptcp-next,2/3] mptcp: more careful RM_ADDR generation
12745746: New: [v4,mptcp-next,3/3] mptcp: strict local address ID
selection.:
    - it was not enough
    - Paolo is trying to address a new race condition on a v5
    - How to handle endpoint clash?:
        - with the current PM, subflows can be attached to no endpoints
        - Paolo is looking at a solution but that will be for another
patchset

12746917: Under Review: [mptcp-next,v3,1/7] mptcp: add the mibs for
MP_FASTCLOSE
12746918: Under Review: [mptcp-next,v3,2/7] selftests: mptcp: add the
MP_FASTCLOSE mibs check
12746919: Under Review: [mptcp-next,v3,3/7] mptcp: add the mibs for MP_RST
12746920: Under Review: [mptcp-next,v3,4/7] selftests: mptcp: add the
MP_RST mibs check
12746921: Under Review: [mptcp-next,v3,5/7] selftests: mptcp: add
extra_args in do_transfer
12746922: Under Review: [mptcp-next,v3,6/7] selftests: mptcp: add
fastclose testcases
12746923: Under Review: [mptcp-next,v3,7/7] selftests: mptcp: fastclose
check in mptcp_connect:
12747675: Under Review: [mptcp-next,v3] Squash to "selftests: mptcp: add
the MP_RST mibs check v3"
    - series: "add fastclose testcases"
    - Mat is having intermittent failures with it

12746933: Queued: [mptcp-next,v8,1/5] Squash to "mptcp: infinite mapping
receiving"
12746934: Queued: [mptcp-next,v8,2/5] Squash to "selftests: mptcp: add
infinite map mibs check"
12746935: Queued: [mptcp-next,v8,3/5] selftests: mptcp: add more
arguments for chk_join_nr
12746936: Queued: [mptcp-next,v8,4/5] selftests: mptcp: reuse linkfail
to make given size files
12746937: Queued: [mptcp-next,v8,5/5] selftests: mptcp: add the MP_FAIL
testcases
12747238: Queued: [mptcp-next] Squash to "selftests: mptcp: add more
arguments for chk_join_nr v8"
12747681: Queued: [mptcp-next] Squash to "selftests: mptcp: reuse
linkfail to make given size files v8":
    - patches looks good but depends on "add fastclose testcases"
    - Still after that, what to do with the packet that has been
detected as "corrupted"?:
        - For the moment, it is not dropped
        - not easy to drop it from there?
        - maybe OK for the moment not to drop it (middlebox has modified
the data without recomputing MPTCP checksum)
    - We can also fail the connection if the fallback is difficult/costly:

https://lore.kernel.org/mptcp/DEA13B0F-B535-42A3-95C6-595859A1CD55@apple.com/

12747869: Queued: [mptcp-next] selftests: mptcp: update output info of
chk_rm_nr:
12749240: New: [mptcp-next] Squash to "selftests: mptcp: update output
info of chk_rm_nr"
    - to be applied
    - TODO: Matth

12749844: New: [RFC,mptcp-next,v2,1/6] mptcp: add MP_FAIL echo support
12749845: New: [RFC,mptcp-next,v2,2/6] mptcp: add mibs for MP_FAIL echo
12749846: New: [RFC,mptcp-next,v2,3/6] selftests: mptcp: add MP_FAIL
echo mibs check
12749847: New: [RFC,mptcp-next,v2,4/6] mptcp: add a new sysctl
mp_fail_timeout
12749848: New: [RFC,mptcp-next,v2,5/6] mptcp: add MP_FAIL retrans support
12749849: New: [RFC,mptcp-next,v2,6/6] selftests: mptcp: MP_FAIL timeout
testcases TODO:
    - we probably don't need to retransmit MP_FAIL:
        - if the subflow is down, a RST will be sent
        - there are other cases but should be handled by the TCP stack
        - maybe a reset can be sent if the other peer is not responding?
    - Mat will look at the v2 to see if we need this

12750267: New: [mptcp-next,v2,1/5] mptcp: check netns in mptcp_token_exists
12750266: New: [mptcp-next,v2,2/5] mptcp: prefer ip address in syn skb
instead of listen sk bound address
12750268: New: [mptcp-next,v2,3/5] tcp: add mptcp join demultiplex hooks
12750269: New: [mptcp-next,v2,4/5] mptcp: handle join requests via
pernet listen socket
12750270: New: [mptcp-next,v2,5/5] mptcp: remove per-address listening
sockets:
    - series: mptcp: replace per-addr listener sockets
    - there was a suggestion from Mat to change the hook but it would
impact all TCP packets
    - if the mptcp lookup is done via TCP lookup and in case of
retransmitted SYN packets, we can end up creating two listening sockets:
        - probably needed to do a lookup on the established sockets in
MPTCP side
        - similar to what TCP is doing
        - or only looking at MPJ
    - Paolo is also looking at the v2



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 259)

  261  MP_FAIL echo and retrans @geliangtang:
      - just to split from #216

  260  selftests: mptcp_connect: `Unexpected revents:
POLLERR/POLLNVAL(19)` [bug] [selftests]:
      - caused by the way we send data in the tx queue
      - but not working in case of fallback:
          - mptcp write queue can be empty in this case while the
subflow write queue might not be
          - a RST can then be sent in this case while it should not be
      - Paolo started to look at that → TODO assign Paolo → Done


    Bugs (opened, flagged as "bug" and assigned)

  259  [syzkaller] UBSAN: shift-out-of-bounds in net/mptcp/protocol.c
[bug] [syzkaller] @mjmartineau:
      - Mat sent a patch to fix that

  203  PM: server: accept subflows [bug] @kmaloor:
      - See patches above


    Bugs (opened and flagged as "bug" and not assigned)

  260  selftests: mptcp_connect: `Unexpected revents:
POLLERR/POLLNVAL(19)` [bug] [selftests]:
      - See above

  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]

  225  selftests: join: "remove subflows and signal" is unstable [bug]
[selftests]:
      - TODO: assign Paolo (Patches have been shared) → Done

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]


    In Progress (opened, new feature and assigned)

  261  MP_FAIL echo and retrans @geliangtang

  246  Netlink PM events: add one attribute about the connection type
(connect/accept) [enhancement] @kmaloor:
      - see patches above

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva

  216  The infinite mapping support [enhancement] @geliangtang:
      - see patches above

  186  Add netlink command support [enhancement] @kmaloor:
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

  255  selftests: connect: checksum failed [bug]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.18):
https://github.com/multipath-tcp/mptcp_net-next/projects/13
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for -net:

        - [3dbd5c179fa0] selftests: mptcp: fix diag instability (Paolo
Abeni)
        - [ec621fe172ae] selftests: mptcp: improve 'fair usage on close'
stability (Paolo Abeni)

        - [cb3236ecdf7f] mptcp: fix race in overlapping signal events
(Paolo Abeni)
        - [474d31e3d81f] mptcp: fix race in incoming ADD_ADDR option
processing (Paolo Abeni)
        - [f9ce14971cd2] mptcp: add mibs counter for ignored incoming
options (Paolo Abeni)
        - [0d1f61719931] selftests: mptcp: more robust signal race test
(Paolo Abeni)
        - [a92e1a369e45] selftests: mptcp: be more conservative with
cookie MPJ limits (Paolo Abeni):
            - Can be sent if OK for Paolo (they were there for a bit of
time, no?)
            - done


    - Features for net-next:

        - [429bf36964d0] mptcp: don't send RST for single subflow
(Geliang Tang)
        - [cd6666c269d0] mptcp: add the fallback check (Geliang Tang)
        - [6e55eab8f3d3] mptcp: track and update contiguous data status
(Geliang Tang)
        - [b7e4a045ffc8] mptcp: infinite mapping sending (Geliang Tang)
        - [493aa74fb68f] mptcp: infinite mapping receiving (Geliang Tang)
        - [b528f747e6c4] mptcp: add mib for infinite map sending
(Geliang Tang)
        - [30c0a1531b73] selftests: mptcp: add invert check in
check_transfer (Geliang Tang)
        - [356e82032720] selftests: mptcp: add infinite map mibs check
(Geliang Tang)
        - [b24f53b1a13b] mptcp: dump infinite_map field in
mptcp_dump_mpext (Geliang Tang)
        - [a9a29c18809a] mptcp: add tracepoint in mptcp_sendmsg_frag
(Geliang Tang):
            - there are still patches in review

        - [2629cc3c0852] mptcp: Remove redundant assignments in path
manager init (Mat Martineau)
        - [370962de763b] mptcp: Add a member to mptcp_pm_data to track
kernel vs userspace mode (Mat Martineau)
        - [1fca36bb7979] mptcp: Bypass kernel PM when userspace PM is
enabled (Mat Martineau)
        - [fcc6b60e20d2] mptcp: Make kernel path manager check for
userspace-managed sockets (Mat Martineau)
        - [80c9b3c332fe] mptcp: Add a per-namespace sysctl to set the
default path manager type (Mat Martineau)
        - [48f601994100] selftests: mptcp: Add tests for userspace PM
type (Mat Martineau):
            - waiting for Kishen's series

        - [21903400971e] selftests: mptcp: increase timeout to 20
minutes (Matthieu Baerts)
        - [e1ee16f04114] selftests: mptcp: adjust output alignment for
more tests (Geliang Tang)
        - [59557c6d51ce] selftests: mptcp: simplify
pm_nl_change_endpoint (Geliang Tang)
        - [df7f6e4b1fdd] mptcp: use MPTCP_SUBFLOW_NODATA (Geliang Tang):
            - there was a conflict, can probably wait

        - [c338c9a447dd] selftests: mptcp: join: allow running -cCi
(Matthieu Baerts):
            - a squash-to patch is in preparation

        - [0f3c2e1995fc] selftests: mptcp: join: exit after usage()
(Matthieu Baerts)
        - [ad3e4b73997b] selftests: mptcp: join: remove unused vars
(Matthieu Baerts)
        - [d987af7c6901] selftests: mptcp: join: create tmp files only
if needed (Matthieu Baerts)
        - [cabe8362605f] selftests: mptcp: join: check for tools only if
needed (Matthieu Baerts)
        - [cba0352f2a2b] selftests: mptcp: add csum mib check for
mptcp_connect (Geliang Tang)




Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - nothing new related to MPTCP \o/

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - there is something wrong but probably due to kbuild's infra

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - the 'git SHA' has been added in the 'summary.txt' file



Next meeting:
    - Next one on Thursday, the 24th of February.
    - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220224



Feel free to comment on these points and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
