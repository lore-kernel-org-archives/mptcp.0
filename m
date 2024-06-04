Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4607953BE
	for <mptcp@lists.linux.dev>; Tue,  4 Jun 2024 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517513; cv=none; b=U5GBmnDH4oWvsyMjxiccDgkRA//y/+4UO+k69BrLKIuaMvNWv8UrhI8ss+lYXoDwPalImnplstimj5Rgx/+7pGKysSwzxagje1v8qT/ef0QVstZSCiTShoDdnWn5Dz2deaQJGZ6utb75ya3JS3WskgdXFS9IQYyy+DdsJdWi9rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517513; c=relaxed/simple;
	bh=mw7uYUwtKG9pUh1hRVrCUrTHX1/OUrJr4Tr3I74h9yc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=KXyiSR+o+h/hhHWAPAMgIZv4un5voJrGaGSIZfQLSEEZuCer1ROQjBdy/1ZImicCEi+MbHVgPcsokV1KkKj3lrJIY7+3AwrQKyzbOxJWualvomrBJ2nUAkJta4av1Nxe3iY8S/vu4TCIJ36skTclSfmolOwy5FNS6Nk3ds58XXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQc223Z1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQc223Z1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A016C2BBFC
	for <mptcp@lists.linux.dev>; Tue,  4 Jun 2024 16:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717517512;
	bh=mw7uYUwtKG9pUh1hRVrCUrTHX1/OUrJr4Tr3I74h9yc=;
	h=Date:From:Subject:To:From;
	b=gQc223Z1Z1HHwpyJpHmLcn1CdLpT7VwNwShId7+uGIvCRTcNuSVOZWeWQ4Eg/CjtV
	 AHXOSDqvdxR0DVNF+rCSrUQKA9eM6kMgbxW80T4nPSTbWr7RHNWMdxqZZPO/JFyDhv
	 wlvCNDmarWAdoK7tlinGCEjDB0BUznbF94EUBPLaz8ykbHz5ACsIeDRnSBe568Dly4
	 MaUIR6S4WHGAqVCAeoi7w4xnNhmKzmw3c4w1NLzcVbYrSrrpJqCHj+nDL433jx9Rbl
	 Y29UEDufL3VOBb3+UydAELDzrlxS0EteG+uv/O5Etwmfwc6lK24cySrssMHk3rJ7j9
	 /VfnkdS8fZ3PQ==
Message-ID: <f966ef8b-8194-4267-915b-eed2137b9b02@kernel.org>
Date: Tue, 4 Jun 2024 18:11:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 28th of May 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last week, we had our new meeting with Mat (Cruise), Paolo, Davide
(Redhat), Christoph (Apple), Gregory (Tessares), and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:

    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13663515: [5.10.y] mptcp: ensure snd_nxt is properly initialized on connect:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240513151717.2733290-2-matttbe@kernel.org/

13673304: [net,1/4] selftests: mptcp: lib: support flaky subtests
13673305: [net,2/4] selftests: mptcp: simult flows: mark 'unbalanced'
tests as flaky
13673306: [net,3/4] selftests: mptcp: join: mark 'fastclose' tests as flaky
13673307: [net,4/4] selftests: mptcp: join: mark 'fail' tests as flaky:
      - Series: selftests: mptcp: mark unstable subtests as flaky
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=855743&state=*&archive=both


    our repo (by: Matthieu Baerts):

13670735: [mptcp-net,v3,1/4] selftests: mptcp: lib: support flaky subtests
13670736: [mptcp-net,v3,2/4] selftests: mptcp: simult flows: mark
'unbalanced' tests as flaky
13670737: [mptcp-net,v3,3/4] selftests: mptcp: join: mark 'fastclose'
tests as flaky
13670738: [mptcp-net,v3,4/4] selftests: mptcp: join: mark 'fail' tests
as flaky:
      - Series: selftests: mptcp: mark unstable subtests as flaky
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=855015&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang, John Hubbard,
Matthieu Baerts, Yunsheng Lin):

13659842: [bpf-next,v2,1/2] selftests/bpf: Add mptcp subflow example
13659843: [bpf-next,v2,2/2] selftests/bpf: Add mptcp subflow subtest:
      - Series: selftests/bpf: new MPTCP subflow subtest
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=851945&state=*&archive=both
      - Changed requested, but blocked by "add netns helpers": not
urgent, we will wait.

13676647: [net-next,v5,11/13] net: replace page_frag with page_frag_cache:
      - Mat reviewed the MPTCP part

13665604: [v2] checkpatch: skip warnings for symbol links:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/8e5cdb8e4eb6d964ec3ffe961ab8e65b8788584f.1715815795.git.tanggeliang@kylinos.cn/
      - probably best to resend it after the merge window.

13665648: [bpf-next,v2,1/8] selftests/bpf: Add unshare_netns helper
13665649: [bpf-next,v2,2/8] selftests/bpf: Use unshare_netns helper
13665650: [bpf-next,v2,3/8] selftests/bpf: Drop duplicate create_netns
13665651: [bpf-next,v2,4/8] selftests/bpf: Export create_netns helper
13665652: [bpf-next,v2,5/8] selftests/bpf: Use create_netns helper
13665653: [bpf-next,v2,6/8] selftests/bpf: Export cleanup_netns helper
13665654: [bpf-next,v2,7/8] selftests/bpf: Use cleanup_netns helper
13665655: [bpf-next,v2,8/8] selftests/bpf: Use netns helpers in lwt tests:
      - Series: add netns helpers
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=853539&state=*&archive=both
      - modifications needed from BPF maintainers. If it becomes too
complicated, we can check to send "selftests/bpf: new MPTCP subflow
subtest" first, but no urgency, we have a ~2 months

13675013: Patch "mptcp: implement TCP_NOTSENT_LOWAT support" has been
added to the 6.8-stable tree:
      - Series: Patch "mptcp: implement TCP_NOTSENT_LOWAT support" has
been added to the 6.8-stable tree
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=856110&state=*&archive=both
      - TODO: Matth: validate that: 6.8 is going to be EOL soon, we
don't want them to insert a broken feature → Done: it's OK
      - Otherwise, it looks OK

13675903: [v2] selftests/net: suppress clang's "variable-sized type not
at the end" warning:
      - Submitter: John Hubbard
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240527213641.299458-1-jhubbard@nvidia.com/
      - handled by others

13676260: [net-next,v2,1/3] doc: mptcp: add missing
'available_schedulers' entry
13676261: [net-next,v2,2/3] doc: mptcp: alphabetical order
13676262: [net-next,v2,3/3] doc: new 'mptcp' page in 'networking':
      - Series: doc: mptcp: new general doc and fixes
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=856409&state=*&archive=both
      - from -net to net-next


    our repo (by: Geliang Tang, Gregory Detal, Matthieu Baerts,
YonglongLi, Yunsheng Lin):

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
      - Status: same as last time

13305089: [mptcp-next,1/6] mptcp: sockopt: move tcp_inq code to a
dedicated function
13305091: [mptcp-next,2/6] mptcp: sockopt: update supported list
13305093: [mptcp-next,3/6] mptcp: sockopt: get val in a generic way
13305090: [mptcp-next,4/6] mptcp: sockopt: add missing getsockopt() options
13305094: [mptcp-next,5/6] mptcp: sockopt: set val in a generic way
13305092: [mptcp-next,6/6] mptcp: sockopt: support IP_TTL &
IPV6_UNICAST_HOPS:
      - State: Changes requested
      - Series: mptcp: sockopt: uniform code to get/set values
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=763505&state=*&archive=both
      - Status: same as last time

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
      - Status: same as last time

13656189: [mptcp-net,v2] mptcp: fix the default value of scaling_ratio:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn/
      - Status: same as last time
      - to be investigated

13665855: [mptcp-next,v3,1/2] Squash to "selftests/bpf: Add mptcp
subflow subtest"
13665856: [mptcp-next,v3,2/2] Squash to "selftests/bpf: Add bpf
scheduler test":
      - State: Awaiting upstream
      - Series: fixes for create_netns
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=853620&state=*&archive=both
      - Status: same as last time

13672978: mptcp: update add_addr_accepted and accept_add after subflow
added:
      - State: Changes requested
      - Series: mptcp: update add_addr_accepted and accept_add after
subflow added
      - Submitter: YonglongLi
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=855647&state=*&archive=both

13675031: [mptcp-next,v6,1/9] selftests: net: lib: set 'i' as local
13675032: [mptcp-next,v6,2/9] selftests: net: lib: support errexit with
busywait
13675033: [mptcp-next,v6,3/9] selftests: net: lib: avoid error removing
empty netns name
13675034: [mptcp-next,v6,4/9] selftests: net: lib: ignore possible error
13675035: [mptcp-next,v6,5/9] selftests: net: lib: remove ns from list
after clean-up
13675036: [mptcp-next,v6,6/9] selftests: net: lib: do not set ns var as
readonly
13675037: [mptcp-next,v6,7/9] selftests: net: lib: remove 'ns' var in
setup_ns
13675038: [mptcp-next,v6,8/9] selftests: mptcp: lib: use
setup/cleanup_ns helpers
13675039: [mptcp-next,v6,9/9] selftests: mptcp: lib: use
wait_local_port_listen helper:
      - State: New
      - Series: use helpers in lib.sh and net_helpers.sh
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=856116&state=*&archive=both
      - Updating a series started by Geliang

13675217: [mptcp-next,RFC,1/4] mptcp: add push sched callback
13675218: [mptcp-next,RFC,2/4] mptcp: use new push callback to schedule
chunks
13675219: [mptcp-next,RFC,3/4] mptcp: bpf: allow to write to
mptcp_sched_chunk
13675220: [mptcp-next,RFC,4/4] selftests/bpf: mptcp RR: send 1 MSS on
each subflow:
      - State: RFC
      - Series: mptcp: update scheduler API
      - Submitter: Gregory Detal
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=856158&state=*&archive=both
      - Current limitations of the sched API:
          - not flexible enough to be extended
          - some use cases might be hard to implement with the current API

      - 2 proposals:
          - the one linked to the series ↑:
              - extending the current API: new hook to stop pushing on
the same subflow
              - "simple" modification, perf impact is very low
              - but it might be more complex to use: first stop it, then
do another action linked to that

          - or a "more natural API":
              - similar to what was in mptcp.org; where to send the next
segment
              - But can hurt the perf, and maybe not (easily) possible
with BPF,
              - e.g. we receive an ACK from one subflow, we might need
to schedule to another subflow
              → To send data over another subflow, we need to lock the
MPTCP lock and subflow lock
              → Typically, when we receive an ACK from one subflow, we
can lock the current subflow, and the MPTCP one, that's OK. The NAPI
allows switching to another subflow doing that in the right sequence
              → If we want this 2nd proposals, we would need to change
the way the locks are handled: Paolo tried to simplify it, but it seems
difficult. It is not possible to do something like in mptcp.org
              → using a worker (or one per CPU?) could work, but will
impact the perf:
                  → Benchmark would be required, but we need virtual and
non-virtual HW: e.g. the way the SKB are allocated are completely
different, especially on the recv part.
              → using a "delegated" mechanism (certainly NAPI), might
help, but it looks like it is a big rework
              → Matth will help for the benchmarking
              → There are different aspects that are hard to predict,
e.g. contention, in case of latency, etc.

        - It would be good to check that, as it is better to break the
API as we can. Gregory will look at that.

        - note: the current Sched is a BLES like one, but not fully
implemented


13675549: [mptcp-next,v2] mptcp: increment RmAddr MIB counter once per
RM_ADDR:
      - State: Queued
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240527-mptcp-rmaddr-counter-once-v2-1-3e61360a90ac@kernel.org/
      - TODO: to be applied






Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 491):

  494  [syzkaller] WARNING in `__skb_flow_dissect` [bug] [syzkaller]
  493  [syzkaller] WARNING in `__mptcp_clean_una` [bug] [syzkaller]

  492  userspace pm: subflows counter: not updated when a subflows is
removed from the other end [bug]


    Bugs (opened, flagged as "bug" and assigned)

  487  BPF selftests fails with EAGAIN [bug] [selftests] [bpf] @geliangtang
     - to be investigated, can be reproduced without BPF sched

  477  Client: fallback to TCP after X MPC [bug] @matttbe
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  494  [syzkaller] WARNING in `__skb_flow_dissect` [bug] [syzkaller]
  493  [syzkaller] WARNING in `__mptcp_clean_una` [bug] [syzkaller]
  492  userspace pm: subflows counter: not updated when a subflows is
removed from the other end [bug]
  491  selftests: `mptcp_join`: tests `Infinite map` & `MP_FAIL MP_RST`
are unstable [bug] [selftests]
  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf]
  483  [6.1] selftests: `mptcp_connect.sh` failures with
`copyfd_io_poll: poll timed out` errors [bug] [selftests]
  476  packetdrill: coalescing feature doesn't take into account MPTCP
options [bug] [packetdrill]
  475  `simult_flows`: unbalanced bwidth tests are unstable [bug]
[selftests]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
  416  No new subflow when removing an endpoint and adding a new one [bug]
  336  Issues with BPF packet scheduler [bug] [sched] [bpf]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose
server test` are sometimes failing [bug] [selftests]
  315  Issues with backup flow [bug]


    In Progress (opened, new feature and assigned)

  480  MPTCP and KTLS support [enhancement] @geliangtang
  434  in-kernel PM: increase subflows limit [enhancement] [pm] @matttbe
  353  sockopt: uniform code to get/set values [enhancement] @matttbe
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang
   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Assigned Questions (opened, questions and assigned)

None.


    Open questions (opened, questions and not assigned)

  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned)

  489  IPv6 Rejoin Subflow
  481  remove refcount on TCP sockets for the timers [enhancement]
  469  CI: add code coverage support [enhancement] [CI]
  467  Scheduler: add redundant scheduler support in BPF [enhancement]
[sched]
  462  selftests: print (and set?) random seed [enhancement] [selftests]
  461  Protocol: extend Data-Level Length field [enhancement] [protocol]
  448  Allow sending ADD_ADDR IPv6 with port-number if TCP-timestamps
are enabled [enhancement]
  441  optimize established options generation [enhancement]
  440  in-kernel PM: re-establish subflows after "network" errors
[enhancement] [pm]
  426  selftests: validate listener sockets with multiple accepts
[enhancement] [selftests]
  397  Doc and guidance for users [enhancement] [documentation]
  396  ci: periodically run selftests from the export branch on stable
kernels [enhancement] [selftests]
  389  packetdrill: increase coverage for "early `close()`" cases
[enhancement] [packetdrill]
  350  scheduler: API changes (tasks) [enhancement] [sched]
  348  scheduler: frequently probe "stale" subflow with reinjected data
[enhancement] [sched]
  345  scheduler: "penalise" some subflows by sending less than their
cwnd [enhancement] [sched]
  344  scheduler: new callback to initiate optimisations [enhancement]
[sched]
  337  in-kernel PM: listen socket: support "behind a NAT" use case
[enhancement] [pm]
  335  Server to Client subflows: option to allow joining the initial
address and port [enhancement] [pm]
  334  PM: in-kernel: send >1 ADD_ADDR before the establishment of a new
subflow [enhancement] [pm]
  333  New MIBs to help understanding issues when PM cannot create new
subflows [enhancement] [pm]
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
   78  notify the application (userspace) when a subflow is
added/removed [enhancement]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2024-05-21)

  490  syzkaller: WARNING in `__inet_accept` [bug] [syzkaller]
[reproducer] [bisected] @pabeni


    Packetdrill PRs

145  4 days ago   matttbe   mptcp: fastopen: client no cook: uniform delays
144  4 days ago   matttbe   mptcp: dss: ssn spec serv: slow down connection
143  4 days ago   matttbe   mptcp: join: client: slow down connection:
    - avoiding the kernel to estimate RTTs that are too small. Small
RTTs means TCP retransmission that happen too soon. Davide will look at
them.

52   2 years ago  dcaratti  Add initial coverage for RM_ADDR



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.11):
https://github.com/orgs/multipath-tcp/projects/9
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for -net:

        - [b1b10b5aa11f] doc: mptcp: add missing 'available_schedulers'
entry (Matthieu Baerts (NGI0))
        - [847bef5b1d73] doc: mptcp: alphabetical order (Matthieu Baerts
(NGI0))
        - [c86fe75c381d] doc: new 'mptcp' page in 'networking' (Matthieu
Baerts (NGI0)):
            - sent to net-next instead

    - Fixes for net-next: /

    - Features for net-next:

        - [956fd1c0357b] mptcp: use mptcp_win_from_space helper (Geliang
Tang)
        - [04bb9a298762] mptcp: add mptcp_space_from_win helper (Geliang
Tang)
        - [43124b21c420] mptcp: refer to 'MPTCP' socket in comments
(Davide Caratti):
            - TODO: Matth: send that

    - Features for net-next (next): /

    - Features for other trees:

        - [5241db64b229] mptcp: add sched_data helpers (Geliang Tang)
        - [0780146a426b] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [e43cf5beaa57] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [63a09eae945d] selftests/bpf: Add mptcp subflow example
(Nicolas Rybowski)
        - [73dbcb149bca] selftests/bpf: Add mptcp pm_nl_ctl link
(Geliang Tang)
        - [f43122d29f1a] selftests/bpf: Add mptcp subflow subtest
(Geliang Tang)
        - [407e7b1359b1] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [6bd6d9beafe8] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [7a2eb8374816] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [bdf0108e2f38] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [fa6ff9007256] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [83f3584ef4c1] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [cd6fbbd7206f] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang):
            - status is the same: waiting for sched refactoring




Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - Packetdrill (Davide):
        - New PR to reduce unstable tests

    - Patchew (Davide):
        - Still OK

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - Still OK, hopefully soon less issues with packetdrill tests



Other topics:
    - Netdev Conf registration is open:
        - https://netdevconf.info/0x18/pages/registration.html
        - Early bird rate until 03-Jun-2024

    - LPC registration is open as well:
        - https://lpc.events/event/18/page/226-attend

    - 'ss' bug in Fedora 40:
        - there is a bug;
https://bugzilla.redhat.com/show_bug.cgi?id=2279920
        - there is a patch
        - but no activity
        - Matth: check with Davide what can be done: Done

    - MPTCP in systemd:
        - https://github.com/systemd/systemd/pull/32958
        - for the next next version even if it is just a whitelisting



Next meeting:
    - /!\ Next one back on Wednesday, the 5th of June.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240605



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.

