Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A36323CE
	for <mptcp@lists.linux.dev>; Fri, 25 Feb 2022 17:35:08 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id cm8so8422197edb.3
        for <mptcp@lists.linux.dev>; Fri, 25 Feb 2022 09:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=vnz+g1QY/+QBVkkXy3naFwEECU22ZJJ0Ub9PdWW5Gpk=;
        b=MJxvv/sTl20IDGcB6ScTYvWARsKVGb72yQxjQFh4KUFFVy8aXzTNdPNyLLn6XXmWY1
         mRqeT/Q8udR+Mto+UCF3QIQDt3nqxnq54CuVva3ogqETTJad89gzHKYPBNmfdiZkCJgG
         52xLg9WxSUn7+Wkb2T+KbKHoXZmcDFaSvOgfyxzH6yAiL44/89iD+swGj8u8JrhPhMdP
         J0Nl0INZL7ERV+PgfToYesmp6Qk3+ck7yG0kGrebtwF6yEAlMZlqVj3AeKYVq4HDo/80
         RBLOlBwvRpuKeI8ZJrLHPzghvNSYZZb9+W9jCba6IxXYQODqnJfgSLHAgaMi9iGxlAq6
         xhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=vnz+g1QY/+QBVkkXy3naFwEECU22ZJJ0Ub9PdWW5Gpk=;
        b=5z9YM9VVdxLf/qZlUWOuN2OvYiOARFikVuE7ibJi6xC468gT/1Ox73oNqGxo1XvwIl
         MRds42t3ajmerztphIKKvrRsIy1o2yeeGyP9nwYZ+fAEBbDHTQwtoPBg6hBCtQYhdr5V
         gnP3TS0EET/oCLFhOJOUB1lbg+2o5Vf5mT4MHQbbk/8HvtcJKHoO8nX/nr3I+oJqVdvZ
         2YG6+PJ+aFtZ+sGBUvBv4gNX8LKjzJB6pvl1eIfFgenufzqDGq9PA4Gg5Acebgf3qIZH
         ZnM0AapnIOqJKxmOp89FigXJ5SP8vtm/jbxKaphtah9OXsxTMmPFx9hLWlCcWxx1od1+
         jaDg==
X-Gm-Message-State: AOAM532euEypoZR2zvLeL99aRQzygrcuh3jmI8zxVAXpTRWKHNuGBoEV
	R6fFRmeoIRQiRvRtQYuDAQmfNly9gG7UcJ8e
X-Google-Smtp-Source: ABdhPJw5gDs9bwLFSIRh9GGnNKawC8lxn9SuQF3VAfk+1Z/v8KqPBUsktvHIfldMmpMji3BbBdQ/XA==
X-Received: by 2002:a05:6402:4491:b0:413:162a:fc85 with SMTP id er17-20020a056402449100b00413162afc85mr8155025edb.115.1645810506300;
        Fri, 25 Feb 2022 09:35:06 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:46bf:f117:2ce:9a9d? ([2a02:578:8593:1200:46bf:f117:2ce:9a9d])
        by smtp.gmail.com with ESMTPSA id g15-20020a170906198f00b006ce36c0c138sm1226406ejd.186.2022.02.25.09.35.05
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 09:35:05 -0800 (PST)
Message-ID: <fb6234cb-6ef4-9162-2e95-f2009f62291d@tessares.net>
Date: Fri, 25 Feb 2022 18:35:05 +0100
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
Subject: [Weekly meetings] MoM - 24th of February 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 185th meeting with Mat, Ossama, Kishen (Intel)
Florian, Paolo, Davide (Red Hat), Giray (Parkyeri) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12751967  [net,7/7] selftests: mptcp: be more conservative with cookie
MPJ limi...
12751966  [net,6/7] selftests: mptcp: more robust signal race test
12751968  [net,5/7] mptcp: add mibs counter for ignored incoming options
12751965  [net,4/7] mptcp: fix race in incoming ADD_ADDR option processing
12751964  [net,3/7] mptcp: fix race in overlapping signal events
12751962  [net,2/7] selftests: mptcp: improve 'fair usage on close'
stability
12751963  [net,1/7] selftests: mptcp: fix diag instability

12750893  [net-next,7/7] selftests: mptcp: add csum mib check for
mptcp_connect
12750890  [net-next,6/7] selftests: mptcp: join: check for tools only if
needed
12750894  [net-next,5/7] selftests: mptcp: join: create tmp files only
if needed
12750892  [net-next,4/7] selftests: mptcp: join: remove unused vars
12750889  [net-next,3/7] selftests: mptcp: join: exit after usage()
12750888  [net-next,2/7] selftests: mptcp: simplify pm_nl_change_endpoint
12750891  [net-next,1/7] selftests: mptcp: increase timeout to 20 minutes

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


    our repo (by: Geliang Tang, Mat Martineau, Paolo Abeni):

12757677  [mptcp-next] Squash to "selftests: mptcp: add the MP_FASTCLOSE
mibs c...

12753962  [mptcp-next] Squash-to: "mptcp: more careful RM_ADDR generation"

12753042  [mptcp-next] mptcp: add fullmesh flag check for adding address

12752510  [mptcp-next] Squash to "selftests: mptcp: add implicit
endpoint test ...

12752508  [RESEND,mptcp-next,v2,12/12] selftests: mptcp: update output
info of ...
12752507  [RESEND,mptcp-next,v2,11/12] selftests: mptcp: add the MP_FAIL
testca...
12752506  [RESEND,mptcp-next,v2,10/12] selftests: mptcp: add more
arguments for...
12752505  [RESEND,mptcp-next,v2,09/12] Squash to "selftests: mptcp: add
infinit...
12752504  [RESEND,mptcp-next,v2,08/12] Squash to "mptcp: infinite
mapping recei...
12752503  [RESEND,mptcp-next,v2,07/12] selftests: mptcp: add fastclose
testcase
12752502  [RESEND,mptcp-next,v2,06/12] selftests: mptcp: reuse linkfail
to make...
12752501  [RESEND,mptcp-next,v2,05/12] selftests: mptcp: add extra_args
in do_t...
12752500  [RESEND,mptcp-next,v2,04/12] selftests: mptcp: add the MP_RST
mibs ch...
12752499  [RESEND,mptcp-next,v2,03/12] mptcp: add the mibs for MP_RST
12752498  [RESEND,mptcp-next,v2,02/12] selftests: mptcp: add the
MP_FASTCLOSE m...
12752497  [RESEND,mptcp-next,v2,01/12] mptcp: add the mibs for MP_FASTCLOSE

12751985  [mptcp-next,3/3] selftests: mptcp: Rename wait function
12751984  [mptcp-next,2/3] Squash to "selftests: mptcp: more robust
signal race...
12751983  [mptcp-next,1/3] Squash to "selftests: mptcp: improve 'fair
usage on ...

12751592  [mptcp-net,2/2] selftests: mptcp: do complete cleanup at exit
12751593  [mptcp-net,1/2] mptcp: accurate SIOCOUTQ for fallback socket

12750679  [v5,mptcp-next,4/4] selftests: mptcp: add implicit endpoint
test case
12750680  [v5,mptcp-next,3/4] mptcp: strict local address ID selection.
12750678  [v5,mptcp-next,2/4] mptcp: introduce implicit endpoints
12750681  [v5,mptcp-next,1/4] mptcp: more careful RM_ADDR generation

12744166  [mptcp-net] mptcp: Correctly set DATA_FIN timeout when number
of retr...



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang):

12756495  [iproute2-next,v3,3/3] mptcp: add port support for setting flags
12756494  [iproute2-next,v3,2/3] mptcp: add fullmesh support for setting
flags
12756493  [iproute2-next,v3,1/3] mptcp: add fullmesh check for adding
address


    our repo (by: Dmytro SHYTYI, Florian Westphal, Geliang Tang, Jiapeng
Chong, Kishen Maloor, Matthieu Baerts):

12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to
tcp.h/mptcp.h
12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in
reset packets
12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support
12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp
stack
12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes
socket with unread data
12321111: RFC: mptcp: Remove redundant assignment to remaining:
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
    - Blocked: depending on "mptcp: replace per-addr listener sockets"

12746923: Rejected: [mptcp-next,v3,7/7] selftests: mptcp: fastclose
check in mptcp_connect:
    - was not needed

12749844: Needs ACK: [RFC,mptcp-next,v2,1/6] mptcp: add MP_FAIL echo support
12749845: Needs ACK: [RFC,mptcp-next,v2,2/6] mptcp: add mibs for MP_FAIL
echo
12749846: Needs ACK: [RFC,mptcp-next,v2,3/6] selftests: mptcp: add
MP_FAIL echo mibs check
12749847: Needs ACK: [RFC,mptcp-next,v2,4/6] mptcp: add a new sysctl
mp_fail_timeout
12749848: Needs ACK: [RFC,mptcp-next,v2,5/6] mptcp: add MP_FAIL retrans
support
12749849: Needs ACK: [RFC,mptcp-next,v2,6/6] selftests: mptcp: MP_FAIL
timeout testcases TODO:
    - "MP_FAIL echo and retrans"
    - Mat reviewed it, there a few questions for Geliang
    - Maybe not to complex (best-effort strategy)

12754573: Changes Requested: [RESEND,mptcp-next] bpf: examples: fix
libbpf 0.7 deprecated warnings:
    - Mat reviewed it: would be nice to also modify the Makefile to ease
stuff

12754661: Changes Requested: [mptcp-next,v4] Squash to "bpf: add
'bpf_mptcp_sock' structure and helper":
    - looks good, just a small build issue in some conditions

12756762: Under Review: [1/4] mptcp: prefer ip address in syn skb
instead of listen sk bound address
12756761: Under Review: [2/4] tcp: add mptcp join demultiplex hooks
12756763: Under Review: [3/4] mptcp: handle join requests via pernet
listen socket
12756764: Under Review: [4/4] mptcp: remove per-address listening sockets:
    - "mptcp: replace per-addr listener sockets"
    - v4 has just been sent:
        - add handler4/handler6 wrappers in patch two to avoid build
barf with CONFIG_IPV6=m.  No other changes.

    - how we can handle token lookup if there was already another
(plain) TCP socket listening on that port:
        - we need to avoid multiple hooks in TCP's fast paths
        - if the stack is already parsing all TCP options, it would be
hopefully acceptable to add one more conditions there for MPTCP:
            - but maybe other checks are needed in other places
            - Florian can have to look to change the priority (doing the
check before) to see the implication
            - Mat can also draft an RFC to show what he has in mind
        - maybe good to start with what is ready for the moment and
improve it later
        - maybe we don't want to change the behaviour again around that
and directly go to the behaviour proposed by Mat?

    - a few points to take into account:
        - announcing an IP doesn't imply a subflow will be created:
depend on the client but also the network (path can be blocked, etc.)
        - TCP should be prioritised, we don't really have the choice if
we don't want issues with TCP/net maintainers
        - maybe not a big issues to have conflicts for the moment:
            - MPTCP is used for specific deployments, maybe less risks
of conflicts there
        - this blocks the series adding PM Netlink commands, it might be
good to move on and exercise what is pending and have more feedback.


12758639: Changes Requested: [mptcp-next,v3,01/12] Squash to "selftests:
mptcp: Add tests for userspace PM type"
12758640: Changes Requested: [mptcp-next,v3,02/12] Squash to "selftests:
mptcp: join: allow running -cCi"
12758641: Changes Requested: [mptcp-next,v3,03/12] Squash to "selftests:
mptcp: add implicit endpoint test case"
12758643: Changes Requested: [mptcp-next,v3,04/12] selftests: mptcp:
join: define tests groups once
12758642: Changes Requested: [mptcp-next,v3,05/12] selftests: mptcp:
join: reset failing links
12758646: Changes Requested: [mptcp-next,v3,06/12] selftests: mptcp:
join: option to execute specific tests
12758650: Changes Requested: [mptcp-next,v3,07/12] selftests: mptcp:
join: alt. to exec specific tests
12758644: Changes Requested: [mptcp-next,v3,08/12] selftests: mptcp:
join: list failure at the end
12758645: Changes Requested: [mptcp-next,v3,09/12] selftests: mptcp:
join: clarify local/global vars
12758648: Changes Requested: [mptcp-next,v3,10/12] selftests: mptcp:
join: avoid backquotes
12758649: Changes Requested: [mptcp-next,v3,11/12] selftests: mptcp:
join: make it shellcheck compliant
12758647: Changes Requested: [mptcp-next,v3,12/12] selftests: mptcp:
join: helper to filter TCP:
    - v4 is in preparation:
        - fixing a typo but it also properly
        - adding better support for "implicit EP" tests (removing the
counter increment)

12758738: New: [mptcp-next] selftests: bpf: exercise bpf_mptcp_sock():
    - Needs review



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 261)

  263  selftests: join: missing MP_JOINs but ADD_ADDR OK with `multiple
flows, signal, link failure` [bug] [selftests]:
      - saw once in the CI
      - Matth was not able to reproduce it locally
      - Probably best to wait a few days/weeks to see if it can be
reproduced before closing it


    Bugs (opened, flagged as "bug" and assigned)

  261  MP_FAIL echo and retrans [bug] @geliangtang:
      - Linked to the RFC series from Geliang, see above

  203  PM: server: accept subflows [bug] @kmaloor:
      - linked to series from Kishen and Florian, see above


    Bugs (opened and flagged as "bug" and not assigned)

  263  selftests: join: missing MP_JOINs but ADD_ADDR OK with `multiple
flows, signal, link failure` [bug] [selftests]

  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]:
      - maybe OK to just increase the tolerances?
      - Matth will monitor that → Still happening but not on the public CI

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]


    In Progress (opened, new feature and assigned)

  246  Netlink PM events: add one attribute about the connection type
(connect/accept) [enhancement] @kmaloor:
      - See patches above

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva

  216  The infinite mapping support [enhancement] @geliangtang:
      - Not fully solved yet:
          - dropping data if an issue is detected
          - + packetdrill, etc.

  186  Add netlink command support [enhancement] @kmaloor
      - See patches above

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

  262  selftests: join: getting more RM_ADDR than expected [bug]
[selftests] @pabeni
  260  selftests: mptcp_connect: `Unexpected revents:
POLLERR/POLLNVAL(19)` [bug] [selftests] @pabeni
  259  [syzkaller] UBSAN: shift-out-of-bounds in net/mptcp/protocol.c
[bug] [syzkaller] @mjmartineau
  225  selftests: join: "remove subflows and signal" is unstable [bug]
[selftests] @pabeni



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.18):
https://github.com/multipath-tcp/mptcp_net-next/projects/13
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for -net:

        - [6000da9406c5] selftests: mptcp: fix diag instability (Paolo
Abeni)
        - [2599b8bc9814] selftests: mptcp: improve 'fair usage on close'
stability (Paolo Abeni)
        - [edebda196444] mptcp: fix race in overlapping signal events
(Paolo Abeni)
        - [32a0d4adab53] mptcp: fix race in incoming ADD_ADDR option
processing (Paolo Abeni)
        - [56ff444abc61] mptcp: add mibs counter for ignored incoming
options (Paolo Abeni)
        - [9396e8918709] selftests: mptcp: more robust signal race test
(Paolo Abeni)
        - [3c747a8f56ea] selftests: mptcp: be more conservative with
cookie MPJ limits (Paolo Abeni)
            - Already sent

        - [edb73f8dfc12] mptcp: accurate SIOCOUTQ for fallback socket
(Paolo Abeni)
        - [9568f41581ae] selftests: mptcp: do complete cleanup at exit
(Paolo Abeni)
        - [2b4647005d15] mptcp: Correctly set DATA_FIN timeout when
number of retransmits is large (Mat Martineau):
            - Can be sent


    - Features for net-next:

        - [227d1f2a7766] selftests: mptcp: adjust output alignment for
more tests (Geliang Tang)

        - [feba50b6abfe] mptcp: add the mibs for MP_FASTCLOSE (Geliang Tang)
        - [6021503fb953] selftests: mptcp: add the MP_FASTCLOSE mibs
check (Geliang Tang)
        - [d55e089003bd] mptcp: add the mibs for MP_RST (Geliang Tang)
        - [9732c322cae0] selftests: mptcp: add the MP_RST mibs check
(Geliang Tang)
        - [df6cc5082d68] selftests: mptcp: add extra_args in do_transfer
(Geliang Tang)
        - [b1be71e82406] selftests: mptcp: reuse linkfail to make given
size files (Geliang Tang)
        - [b3c917968002] selftests: mptcp: add fastclose testcase
(Geliang Tang):
            - too new

        - [0de32e9acf29] mptcp: don't send RST for single subflow
(Geliang Tang)
        - [40e2065f0a37] mptcp: add the fallback check (Geliang Tang)
        - [e1827068f242] mptcp: track and update contiguous data status
(Geliang Tang)
        - [d43835c0610b] mptcp: infinite mapping sending (Geliang Tang)
        - [225522b996d8] mptcp: infinite mapping receiving (Geliang Tang)
        - [17a31863cf2b] mptcp: add mib for infinite map sending
(Geliang Tang)
        - [287e831e4c4c] selftests: mptcp: add infinite map mibs check
(Geliang Tang)
        - [7fbac21d07dc] selftests: mptcp: add invert check in
check_transfer (Geliang Tang)
        - [d1a3f50bb469] selftests: mptcp: add more arguments for
chk_join_nr (Geliang Tang)
        - [f68ed9bd1c77] selftests: mptcp: add the MP_FAIL testcases
(Geliang Tang)
        - [cf68ab689476] selftests: mptcp: update output info of
chk_rm_nr (Geliang Tang)
        - [b1daad5d8c5d] mptcp: dump infinite_map field in
mptcp_dump_mpext (Geliang Tang)
        - [12113eaac33a] mptcp: add tracepoint in mptcp_sendmsg_frag
(Geliang Tang):
            - too new

        - [4bfd3df0042f] mptcp: Remove redundant assignments in path
manager init (Mat Martineau)
        - [a9a12f39de25] mptcp: Add a member to mptcp_pm_data to track
kernel vs userspace mode (Mat Martineau)
        - [578c8580b82f] mptcp: Bypass kernel PM when userspace PM is
enabled (Mat Martineau)
        - [42318e50eeb0] mptcp: Make kernel path manager check for
userspace-managed sockets (Mat Martineau)
        - [2587dd09d34e] mptcp: Add a per-namespace sysctl to set the
default path manager type (Mat Martineau)
        - [2671f22dc051] selftests: mptcp: Add tests for userspace PM
type (Mat Martineau):
            - can wait a bit more

        - [6ab7e72aa515] mptcp: use MPTCP_SUBFLOW_NODATA (Geliang Tang)
        - [fd5c55fe5ec9] selftests: mptcp: join: allow running -cCi
(Matthieu Baerts):
            - there is a Squash-to patch in review
        - [ff9acb80383f] selftests: mptcp: Rename wait function (Mat
Martineau)
           - Blocked on net/net-next sync

        - [5e8ef796dbb5] mptcp: more careful RM_ADDR generation (Paolo
Abeni)
        - [6735b7efe76d] mptcp: introduce implicit endpoints (Paolo Abeni)
        - [e4593d18f571] mptcp: strict local address ID selection (Paolo
Abeni)
        - [26aba7612cfc] selftests: mptcp: add implicit endpoint test
case (Paolo Abeni):
            - can be sent but with "selftests: mptcp: adjust output
alignment for more tests"
            - seems that some net/net-next sync issues exist here too

        - [fbace6e38b27] mptcp: add fullmesh flag check for adding
address (Geliang Tang)



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - Nothing new related to MPTCP \o/

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - Working again and tests are passing \o/

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - Migration has been done
        - It was turned off for a few days due to some issues:
            - some patches from other projects have been adding to MPTCP
projects
            - it should not happen again :)
        - The importer has been rewritten, splitting the daemon in two
different parts
        - The stack will need to be updated again with this new version

    - CI (Matth):
        - Green!
        - OK to send emails about the validation to the commit author
and the list?
        - (do you receive these emails? :) )
        - KBuild saw some compilation issues:
            - can we have the public CI checking that too?
            - TODO: Matth: check what has caused that.


Modification of the TopGit tree:

           export

             ^
             |

    kmalloc on ksan build

             ^
             |

    commits for net-next

             ^
             |

    merge net + net-next

             ^
            / \        export-net
               \      /
    net-next    \    kmalloc on ksan build
    (rebase      \  /
     daily)
                commits for -net (+ commits for the CI)

                   ^
                   |

                  net (rebase on upstream net-next sync,
                       as you suggest below)

    - Wait for net-next to be sync with -net
    - Patches for -net will only be marked as "merged" when the sync
with net-next is done → what we currently have.
    - TODO: check if the new MPTCP commits will still be listed "on top"
(not to have patches for -net after all the ones in net-next)
    - check if stgit is not having issues with that.


nftables 1.0.2:
    - https://lore.kernel.org/netdev/YhO5Pn+6+dgAgSd9@salvia/
    - with MPTCP support: thx Florian!
      tcpopt: add md5sig, fastopen and mptcp options
      tests: py: add test cases for md5sig, fastopen and mptcp mnemonics
      mptcp: add subtype matching



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
