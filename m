Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995E95662
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 09:36:19 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so8121246e87.2
        for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686735377; x=1689327377;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jKBUbVhlobXjcyv2noRS8rCb2w4HoyMB/9hcOVnCD0=;
        b=XNIZ+nVTN87jB+LiiAs8FjMVTXXIwpAyPfStpsq8GS5PuId375pJu5kvaiPbRv/7K8
         133sQX7nIkPVxBYEUjrkqmHsskH+jKMAPMyrY9Y3j0UJA0E0+AQTfD90swn2QIF9n2l5
         ClAuCr9TI6RUPw6LS0i5NyWXXor0WcHhZ0HrncZG7ykMUK0ClMvgpE2uZa5G12ehlIno
         Xtcb0dFRGS8hAgyU93bmRKyUKbhKlsZtWvlRqUx533xwTUFzrpXrd727rPxj67OUMyiR
         ImUnw63pdQvHau6VNNRX13LMdPfQ59kTPBNR09vo3m413RMGf8bbFd6mxbrFYJEL7/UM
         jrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686735377; x=1689327377;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2jKBUbVhlobXjcyv2noRS8rCb2w4HoyMB/9hcOVnCD0=;
        b=WuiJufrwH9rCxGyK5FQzv0Mfij9DqigPBYz3LTC1GsUYHTziMY+YUKAVZ82apGlv1W
         QVQUoQSvkFCxm7Tu3ug8PrDC5eNZOXW4RTl9uhRaf7tb2ihi5+Vg2gAk7OohsLZDtkQ/
         ZDxJEvNg2o4W03l0uHF69BTUvhyuasW+IM5hceIbvEfkLcYqEAdTSC8WHvGSi1FYKIVq
         tO4WBOta4r0W1csquWfOFc8yAX0KP2rp4CxVSU6jIlyehsLe75rZguFG2N9F/lrdVNoZ
         LMf4ElDjxGMe6gED7RN3Ck274PKSsM6Wx0zlyAVikRGMQoXIWSnUvaEMYrRMFETTooc3
         kbQw==
X-Gm-Message-State: AC+VfDwxoEpTmCVLH+SoS6jCFb0eiCE7coz2OOLvnpo2WMfdhhysP6t+
	ntjZTSvlSaKW1VpPoYSO1BhQN9VsV1Pt9mLzoVa4xg==
X-Google-Smtp-Source: ACHHUZ5qRhPzvsFxKL/NJloSSIZzFMzsDfM8yTBec2y6Kk0x17XhfS6LuTaDKCN/YnBWGuyheaEx/A==
X-Received: by 2002:ac2:5054:0:b0:4f3:dd96:bf55 with SMTP id a20-20020ac25054000000b004f3dd96bf55mr7279765lfm.11.1686735376770;
        Wed, 14 Jun 2023 02:36:16 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f189:66db:5060:b402? ([2a02:578:8593:1200:f189:66db:5060:b402])
        by smtp.gmail.com with ESMTPSA id a11-20020a05600c224b00b003f8126bcf34sm12518127wmm.48.2023.06.14.02.36.16
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 02:36:16 -0700 (PDT)
Message-ID: <d64c8fe3-ccb8-4316-d76e-42e9888b662f@tessares.net>
Date: Wed, 14 Jun 2023 11:36:15 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 13th of June 2023
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Yesterday, we had our 245th meeting with Paolo, Davide (Red Hat), Mat
(Cruise) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13272329: [net-next,1/4] mptcp: export local_address
13272330: [net-next,2/4] mptcp: unify pm get_local_id interfaces
13272331: [net-next,3/4] mptcp: unify pm get_flags_and_ifindex_by_id
13272332: [net-next,4/4] mptcp: unify pm set_flags interfaces:
      - Series: mptcp: unify PM interfaces
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=755331&state=*&archive=both

13272580: [net,01/14] selftests: mptcp: lib: skip if missing symbol
13272581: [net,02/14] selftests: mptcp: connect: skip transp tests if
not supported
13272582: [net,03/14] selftests: mptcp: connect: skip disconnect tests
if not supported
13272583: [net,04/14] selftests: mptcp: connect: skip TFO tests if not
supported
13272584: [net,05/14] selftests: mptcp: diag: skip listen tests if not
supported
13272585: [net,06/14] selftests: mptcp: diag: skip inuse tests if not
supported
13272586: [net,07/14] selftests: mptcp: pm nl: remove hardcoded default
limits
13272587: [net,08/14] selftests: mptcp: pm nl: skip fullmesh flag checks
if not supported
13272588: [net,09/14] selftests: mptcp: sockopt: relax expected returned
size
13272589: [net,10/14] selftests: mptcp: sockopt: skip getsockopt checks
if not supported
13272590: [net,11/14] selftests: mptcp: sockopt: skip TCP_INQ checks if
not supported
13272591: [net,12/14] selftests: mptcp: userspace pm: skip if 'ip' tool
is unavailable
13272592: [net,13/14] selftests: mptcp: userspace pm: skip if not supported
13272593: [net,14/14] selftests: mptcp: userspace pm: skip PM listener
events tests if unavailable:
      - Series: selftests: mptcp: skip tests not supported by old
kernels (part 2)
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=755391&state=*&archive=both

13274989: [net,00/17] selftests: mptcp: skip tests not supported by old
kernels (part 3)
13274990: [net,01/17] selftests: mptcp: lib: skip if not below kernel
version
13274991: [net,02/17] selftests: mptcp: join: use 'iptables-legacy' if
available
13274992: [net,03/17] selftests: mptcp: join: helpers to skip tests
13274993: [net,04/17] selftests: mptcp: join: skip check if MIB counter
not supported
13274994: [net,05/17] selftests: mptcp: join: skip test if iptables/tc
cmds fail
13274995: [net,06/17] selftests: mptcp: join: support local endpoint
being tracked or not
13274996: [net,07/17] selftests: mptcp: join: skip Fastclose tests if
not supported
13274997: [net,08/17] selftests: mptcp: join: support RM_ADDR for used
endpoints or not
13274998: [net,09/17] selftests: mptcp: join: skip implicit tests if not
supported
13274999: [net,10/17] selftests: mptcp: join: skip backup if set flag on
ID not supported
13275000: [net,11/17] selftests: mptcp: join: skip fullmesh flag tests
if not supported
13275002: [net,12/17] selftests: mptcp: join: skip userspace PM tests if
not supported
13275001: [net,13/17] selftests: mptcp: join: skip fail tests if not
supported
13275003: [net,14/17] selftests: mptcp: join: skip MPC backups tests if
not supported
13275004: [net,15/17] selftests: mptcp: join: skip PM listener tests if
not supported
13275005: [net,16/17] selftests: mptcp: join: uniform listener tests
13275006: [net,17/17] selftests: mptcp: join: skip mixed tests if not
supported:
      - Series: [net,01/17] selftests: mptcp: lib: skip if not below
kernel version
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=756001&state=*&archive=both


    our repo (by: Matthieu Baerts, Paolo Abeni):

13262347: [mptcp-net,v3,01/32] selftests: mptcp: lib: skip if missing symbol
13262349: [mptcp-net,v3,02/32] selftests: mptcp: lib: skip if not below
kernel version
13262351: [mptcp-net,v3,03/32] selftests: mptcp: connect: skip transp
tests if not supported
13262350: [mptcp-net,v3,04/32] selftests: mptcp: connect: skip
disconnect tests if not supported
13262352: [mptcp-net,v3,05/32] selftests: mptcp: connect: skip TFO tests
if not supported
13262354: [mptcp-net,v3,06/32] selftests: mptcp: diag: skip listen tests
if not supported
13262353: [mptcp-net,v3,07/32] selftests: mptcp: diag: skip inuse tests
if not supported
13262355: [mptcp-net,v3,08/32] selftests: mptcp: pm nl: remove hardcoded
default limits
13262356: [mptcp-net,v3,09/32] selftests: mptcp: pm nl: skip fullmesh
flag checks if not supported
13262357: [mptcp-net,v3,10/32] selftests: mptcp: sockopt: relax expected
returned size
13262359: [mptcp-net,v3,11/32] selftests: mptcp: sockopt: skip
getsockopt checks if not supported
13262358: [mptcp-net,v3,12/32] selftests: mptcp: sockopt: skip TCP_INQ
checks if not supported
13262361: [mptcp-net,v3,13/32] selftests: mptcp: userspace pm: skip if
'ip' tool is unavailable
13262360: [mptcp-net,v3,14/32] selftests: mptcp: userspace pm: skip if
not supported
13262362: [mptcp-net,v3,15/32] selftests: mptcp: userspace pm: skip PM
listener events tests if unavailable
13262363: [mptcp-net,v3,16/32] selftests: mptcp: join: use
'iptables-legacy' if available
13262364: [mptcp-net,v3,17/32] selftests: mptcp: join: helpers to skip tests
13262366: [mptcp-net,v3,18/32] selftests: mptcp: join: skip check if MIB
counter not supported
13262365: [mptcp-net,v3,19/32] selftests: mptcp: join: skip test if
iptables/tc cmds fail
13262367: [mptcp-net,v3,20/32] selftests: mptcp: join: support local
endpoint being tracked or not
13262369: [mptcp-net,v3,21/32] selftests: mptcp: join: skip Fastclose
tests if not supported
13262368: [mptcp-net,v3,22/32] selftests: mptcp: join: support RM_ADDR
for used endpoints or not
13262370: [mptcp-net,v3,23/32] selftests: mptcp: join: skip implicit
tests if not supported
13262372: [mptcp-net,v3,24/32] selftests: mptcp: join: skip backup if
set flag on ID not supported
13262371: [mptcp-net,v3,25/32] selftests: mptcp: join: skip fullmesh
flag tests if not supported
13262373: [mptcp-net,v3,26/32] selftests: mptcp: join: skip userspace PM
tests if not supported
13262374: [mptcp-net,v3,27/32] selftests: mptcp: join: skip fail tests
if not supported
13262375: [mptcp-net,v3,28/32] selftests: mptcp: join: skip MPC backups
tests if not supported
13262376: [mptcp-net,v3,29/32] selftests: mptcp: join: skip PM listener
tests if not supported
13262378: [mptcp-net,v3,30/32] selftests: mptcp: join: uniform listener
tests
13262377: [mptcp-net,v3,31/32] selftests: mptcp: join: skip mixed tests
if not supported
13262379: [mptcp-net,v3,32/32] Squash to "selftests: mptcp: add
MPTCP_FULL_INFO testcase":
      - Series: selftests: mptcp: skip tests when features are not supported
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=752764&state=*&archive=both

13269383: [mptcp-next] Revert "Merge tag '9p-6.4-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs":
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230606-mptcp-revert-9p-features-v1-1-1d7ea4b3749d@tessares.net/

13270961: [mptcp-net,1/2] mptcp: fix possible list corruption on passive MPJ
13270963: [mptcp-next] mptcp: consolidate transition to TCP_CLOSE in
mptcp_do_fastclose():
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/ca4ee22bcb340d3c07778259ce6c08b4d39e89d0.1686155634.git.pabeni@redhat.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Breno Leitao):

13274116: [net-next,v7] net: ioctl: Use kernel memory on protocol ioctl
callbacks:
      - Submitter: Breno Leitao
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230609152800.830401-1-leitao@debian.org/


    our repo (by: Davide Caratti, Geliang Tang, Matthieu Baerts, Paolo
Abeni):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:

13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
      - State: Changes requested
      - Series: BPF redundant scheduler, part 3
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
      - status is the same as last week

13203764: [RFC,mptcp-net-next,1/5] tools: ynl: add uns-admin-perm to
genetlink legacy
13203766: [RFC,mptcp-net-next,2/5] tools: ynl: fix bug in case of
multiple nested attributes of the same type
13203767: [RFC,mptcp-net-next,3/5] Documentation: netlink: add a YAML
spec for mptcp
13203768: [RFC,mptcp-net-next,4/5] mptcp: uapi: add header files
generated from YAML spec
13203769: [RFC,mptcp-net-next,5/5] net/mptcp: use netlink policy
generated from YAML spec:
      - State: Changes requested
      - Series: YAML template for MPTCP netlink API
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=737723&state=*&archive=both
      - some modifications in the API first before switching to that,
see patch below

13270962: [mptcp-net,2/2] mptcp: fix potential msk leak:
      - State: New
      - Series: [mptcp-net,1/2] mptcp: fix possible list corruption on
passive MPJ
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=754974&state=*&archive=both
      - Superseded by "mptcp: consolidate fallback and non fallback
state machine"

13271622: [mptcp-next,v8,01/17] Squash to "mptcp: drop last_snd and
MPTCP_RESET_SCHEDULER"
13271623: [mptcp-next,v8,02/17] Squash to "mptcp: add struct
mptcp_sched_ops"
13271624: [mptcp-next,v8,03/17] Squash to "mptcp: add scheduler wrappers"
13271625: [mptcp-next,v8,04/17] mptcp: add last_snd in sched_data
13271626: [mptcp-next,v8,05/17] mptcp: add snd_burst in sched_data
13271627: [mptcp-next,v8,06/17] mptcp: register default scheduler
13271628: [mptcp-next,v8,07/17] Squash to "bpf: Add bpf_mptcp_sched_ops"
13271629: [mptcp-next,v8,08/17] Squash to "selftests/bpf: Add mptcp
sched structs"
13271630: [mptcp-next,v8,09/17] Squash to "selftests/bpf: Add bpf_rr
scheduler"
13271631: [mptcp-next,v8,10/17] mptcp: add two wrappers needed by bpf_burst
13271632: [mptcp-next,v8,11/17] bpf: Add bpf_burst write accesses
13271633: [mptcp-next,v8,12/17] bpf: Export more bpf_burst related functions
13271634: [mptcp-next,v8,13/17] selftests/bpf: Add bpf_burst scheduler
13271635: [mptcp-next,v8,14/17] selftests/bpf: Add bpf_burst test
13271636: [mptcp-next,v8,15/17] bpf: Add subflow bit flags write accesses
13271637: [mptcp-next,v8,16/17] selftests/bpf: Add bpf_stale scheduler
13271638: [mptcp-next,v8,17/17] selftests/bpf: Add bpf_stale test:
      - State: New
      - Series: BPF packet scheduler updates
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=755171&state=*&archive=both
      - Paolo had a first look, thanks!
      - Mat will look at that and also check at what could be upstreamed
(not related to BPF), thanks!

13277821: [mptcp-next] Squash to "BPF packet scheduler updates v8":
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/8193bd590a4d811054a36f50a2aad79a02e8c137.1686620367.git.geliang.tang@suse.com/
      - Depends on the previous series

13278791: [mptcp-next] mptcp: make the contexts array of sched_data
invisible in BPF:
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/c2bd83d119631caf435a7498104f075781ce4969.1686664380.git.geliang.tang@suse.com/
      - Depends on the previous series

13276229: [mptcp-next,v3] mptcp: convert netlink from small_ops to ops:
      - State: Changes requested
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/c840f47bde581fcf910f24df6d136293618ba1d6.1686564758.git.dcaratti@redhat.com/
      - some code duplication there but coming from the tool
auto-generating code

13276939: [mptcp-net] mptcp: consolidate fallback and non fallback state
machine:
      - State: New
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/f684967fa27c0d051ba3668c45f89ba1ba97a03d.1686584384.git.pabeni@redhat.com/
      - To be reviewed
      - addressing the same issue as "mptcp: fix potential msk leak"
patch but differently

13276938: [mptcp-next] mptcp: drop legacy code.:
      - State: New
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/3bac625cd995fdb3fc6786b599e3c413f00fc6f5.1686584494.git.pabeni@redhat.com/
      - linked to "mptcp: consolidate fallback and non fallback state
machine"
      - could go to net-next and update the commit message or just to
-net without "fixes"

13278013: [mptcp-next,v19,1/8] mptcp: pass addr to mptcp_pm_alloc_anno_list
13278014: [mptcp-next,v19,2/8] selftests: mptcp: test userspace pm out
of transfer
13278015: [mptcp-next,v19,3/8] selftests: mptcp: check subflow and addr
infos
13278016: [mptcp-next,v19,4/8] selftests: mptcp: set FAILING_LINKS in
run_tests
13278017: [mptcp-next,v19,5/8] selftests: mptcp: drop test_linkfail
parameter
13278018: [mptcp-next,v19,6/8] selftests: mptcp: drop addr_nr_ns1/2
parameters
13278019: [mptcp-next,v19,7/8] selftests: mptcp: drop sflags parameter
13278020: [mptcp-next,v19,8/8] selftests: mptcp: add pm_nl_set_endpoint
helper:
      - State: New
      - Series: update userspace pm mptcp_info fields part 2
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=756587&state=*&archive=both
      - To be reviewed: TODO Matth




Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 412):

  413  Question: Transport Converters for non-MPTCP end devices [question]:
      - Matth replied, not directly related to MPTCP, more around TCP

  412  shadowsocks-libev not working, need guidance for PM configuration:
      - TODO: reply to that one
      - a question


    Bugs (opened, flagged as "bug" and assigned)

  407  syzkaller: possible deadlock in `inet_sk_diag_fill` [bug]
[syzkaller] [reproducer] [bisected] @pabeni:
      - reopened by Christoph
      - there is a second issue
      - Paolo sent a tentative patch

  368  selftests: skip tests not being supported by older kernels [bug]
[selftests] @matttbe:
      - Matth will try a workaround to be able to track the different
subtests we have
      - We could do that for all the different selftests we have


    Bugs (opened and flagged as "bug" and not assigned)

  400  packetdrill: data are retransmited after the `close()` [bug]
[packetdrill]
  398  syzkaller: memory leak in `subflow_ulp_init` [bug] [syzkaller]
  391  PM: userspace: unable to create additional subflows with the
local addr ID 0 [bug]
  379  userspace pm: ability to send `RM_ADDR` for all local IDs used (0
included) [bug] [pm]
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched]
  336  Issues with BPF packet scheduler [bug]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: test 98 `fastclose test` is sometimes
failing [bug] [selftests]
  318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
cookies [bug] [selftests]
  315  Issues with backup flow [bug]
  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]


    In Progress (opened, new feature and assigned)

  403  userspace pm: local_addr_list: use a refcount per entry
[enhancement] [pm] @geliangtang
  353  sockopt: uniform code to get/set values [enhancement] @matttbe

  342  scheduler: area in the socket structures reserved for schedulers
[enhancement] [sched] @geliangtang
      - See patches above

  340  netlink: switch to YAML Netlink specs [enhancement] @dcaratti:
      - See patches above

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] [sched] @geliangtang
      - See patches above
      - Simone is also looking at that, checking what is missing to
implement "proper packet schedulers"

   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

  381  Why does total throughput increase when the delay on one of the
paths increases? [question] @matttbe


    Open questions (opened, questions and not assigned)

  413  Question: Transport Converters for non-MPTCP end devices [question]
  411  Problem with IPROTO [question]
  395  If MPTCP primary flow is over tun interface, no subflow gets
created [question]
  392  Problem attempting to use all my interfaces (subflows)  [question]


    For later (opened and not assigned assigned)

  412  shadowsocks-libev not working, need guidance for PM configuration
  406  Compile and run mptcp bpf selftests in CI [enhancement] [selftests]
  397  Doc and guidance for users [enhancement] [documentation]
  396  ci: periodically run selftests from the export branch on stable
kernels [enhancement] [selftests]
  394  selftests: ability to track subtests [enhancement] [selftests]
  389  packetdrill: increase coverage for "early `close()`" cases
[enhancement] [packetdrill]
  383  TCP_KEEPIDLE, TCP_KEEPINTVL, TCP_KEEPCNT are not implemented in
mptcp_setsockopt_sol_tcp [enhancement]
  350  scheduler: API changes (tasks) [enhancement] [sched]
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
  348  scheduler: frequently probe "stale" subflow with reinjected data
[enhancement] [sched]
  345  scheduler: "penalise" some subflows by sending less than their
cwnd [enhancement] [sched]
  344  scheduler: new callback to initiate optimisations [enhancement]
[sched]
  337  in-kernel PM: listen socket: support "behind a NAT" use case
[enhancement]
  335  Server to Client subflows: option to allow joining the initial
address and port [enhancement]
  334  PM: in-kernel: send >1 ADD_ADDR before the establishment of a new
subflow [enhancement]
  333  New MIBs to help understanding issues when PM cannot create new
subflows [enhancement]
  332  scheduler: implement a "opportunistic retransmission"
[enhancement] [sched]
  298  CG Memory accounting for passive MPTCP socket [enhancement]
  289  mptcp: audit comments for non inclusive language [enhancement]
  273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdrill]
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
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2023-06-06)

None.



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.5):
https://github.com/orgs/multipath-tcp/projects/3/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1



Patches to send to netdev:

    - Fixes for other trees:

        - [081d62d9ad26] Revert "Merge tag '9p-6.4-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs" (Matthieu Baerts)

    - Fixes for -net:

        - [5a2cddee53e2] mptcp: handle correctly disconnect() failures
(Paolo Abeni)
        - [613adcdd8833] mptcp: fix possible divide by zero in recvmsg()
(Paolo Abeni)
        - [bb90acff8cab] mptcp: fix possible list corruption on passive
MPJ (Paolo Abeni):
            - Can be sent
            - (but better to check with Christoph first to know if
syzkaller tested them and didn't find anything)
            - TODO: Matth

    - Fixes for net-next:

        - [2c80639d5966] selftests: mptcp: join: skip check if MIB
counter not supported (part 2) (Matthieu Baerts):
            - needs to wait for net to be merged in net-next

    - Features for net-next:

        - [4fe17da4fbf6] mptcp: move snd_una update earlier for fallback
socket (Paolo Abeni)
        - [cfd88ea5489a] mptcp: track some aggregate data counters
(Paolo Abeni):
            - still causing issue 407 (root cause older than this patch
but still needed to wait)
        - [ecb80db3315e] selftests: mptcp: explicitly tests aggregate
counters (Paolo Abeni)

        - [773b809726af] mptcp: add subflow unique id (Paolo Abeni)
        - [21448fb33f36] mptcp: introduce MPTCP_FULL_INFO getsockopt
(Paolo Abeni)
        - [02c4c1332c76] selftests: mptcp: add MPTCP_FULL_INFO testcase
(Paolo Abeni):
            - depends on patches in -net

        - [93fd9d83a562] mptcp: consolidate transition to TCP_CLOSE in
mptcp_do_fastclose() (Paolo Abeni):
            - ok but better to wait to have other patche

    - Features for net-next (next): /

    - Features for other trees:

        - [3076ac7845c2] security, lsm: Introduce
security_mptcp_add_subflow() (Paolo Abeni)
        - [7b91003d7e84] selinux: Implement mptcp_add_subflow hook
(Paolo Abeni):
            - in SELinux tree

        - [e96ba9c269be] mptcp: refactor push_pending logic (Geliang Tang)
        - [e4a3fa328411] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [dcb5ad455731] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [105f29b50618] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [bc7673462424] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [d8f9dc6d7efb] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [0b9fb0e6f233] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [78461f3ad089] mptcp: add scheduler wrappers (Geliang Tang)
        - [171e945952ca] mptcp: use get_send wrapper (Geliang Tang)
        - [51017efdc4c5] mptcp: use get_retrans wrapper (Geliang Tang)
        - [c7ed98063ccc] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [64b63736fe42] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [23b258d106b4] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [4b68197283f3] selftests/bpf: use random netns name for mptcp
(Geliang Tang)
        - [78b047e8cf36] selftests/bpf: add two mptcp netns helpers
(Geliang Tang)
        - [7c84131e51c4] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [85666fd7d8f7] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [603b2d67e138] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [ab22dba0287b] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [2941ac92cd4c] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [94e83c9690e9] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [b01864387357] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [b03edbe93c45] selftests/bpf: Add bpf_red test (Geliang Tang):
            - status: same as last week + there are some pending patches
related to that



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - working fine!
        - TODO Matth: manually apply "mptcp: drop legacy code." → Done

    - CI (Matth):
        - some issues with packetdrill: probably because it they are the
first tests, in debug mode, everything is slow: timeout. Another
workaround? Launch the whole add_addr series and ignore results?
        - issues with mptcp_join: already tracked on GH (issue with 33
remove addresses)



Scope-based Resource Management:
    - One big series from Peter Zijlstra
    - https://lore.kernel.org/lkml/20230612090713.652690195@infradead.org/
    - Might cause issues with the backports, etc.
    - to be monitored



Next meeting:
    - Next one on Tuesday, the 20th of June.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230620



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
