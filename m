Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F1A41
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016905; cv=none; b=Z00CUKfG8Hf2INFgS/G0K9R4K7MmeDzflYjFeNdGQtbXmqU5TRxJOrNpN1oFv2LJg0/b0je/5cIafiRx+aw5+KwCZARkGJOziYySKLqn/OOuX1IyywtWux/Tfnzrqif3mYGVm3q1HkZJ72NrmDD+NLpT25oX6bel/dJ4Z0W4Yjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016905; c=relaxed/simple;
	bh=qO/pcAGedrZ3bbijtKmMHciEXnoodnXrTN/a4wmXTbw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=OqffZE2Vwfoq182TlQHjC1BGVG0pvTrwtIg4m6Hvt/mkxCESg1ZoPBx+WxXVblrV3uKTNc+Wz27bggqd6+vx055HiTvGjpN3wkbl0T3V9F3U7HGSgvdumQKlGV8qiPLtCdxudhoXkTHhy3K80MEvTwi3dz99P89xe7MeU+Pincg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDtlvQwS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDtlvQwS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB72C433F1
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 17:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708016904;
	bh=qO/pcAGedrZ3bbijtKmMHciEXnoodnXrTN/a4wmXTbw=;
	h=Date:From:Subject:To:From;
	b=BDtlvQwS4ciJwylWp5Jm24a3STIfwhGco4FERKqPeBjwQxKpZWG5kCUJ51O+VoQhS
	 sRM8MfhVT4Ma+/HSdKCPGnhjEN7AyoOUasJXIY7U0mbDxjy5GGU57xeiekRtKUbRkH
	 VqKFG7bZegaKzC45u2Oed8AGuOvctQ1YXwboOQjSArhcNcMXnfHQSDq122kQBRqrLQ
	 M0froIxburb2cCSIW7KQScAI4UmtL1JzzngaHuBTuMaY9Oc5nfPHZoBEEnAIVeXADx
	 NjGiOIFJYZHlJ+3sqw7dPcfQYUeIPKrJ/O73RpSkOPB6HY5tFHopPLHQFnj/Os+m2B
	 pMkxjK8uPvYYQ==
Message-ID: <34bef42e-451c-4c98-b21f-cf5fc69fb1c1@kernel.org>
Date: Thu, 15 Feb 2024 18:08:22 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 14th of February 2024
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

This week, we had our 271st meeting with Mat (Cruise), Paolo, Davide
(Red Hat) and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Geliang Tang):

13549363: [bpf-next,v5,1/3] bpf, btf: Fix return value of
register_btf_id_dtor_kfuncs
13549364: [bpf-next,v5,2/3] bpf, btf: Add check_btf_kconfigs helper
13549365: [bpf-next,v5,3/3] bpf, btf: Check btf for register_bpf_struct_ops:
      - Series: bpf, btf: Add DEBUG_INFO_BTF checks for
__register_bpf_struct_ops
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=824190&state=*&archive=both

13550237: [net,1/7] mptcp: drop the push_pending field
13550238: [net,2/7] mptcp: fix rcv space initialization
13550239: [net,3/7] mptcp: fix more tx path fields initialization
13550240: [net,4/7] mptcp: corner case locking for rx path fields
initialization
13550241: [net,5/7] mptcp: check addrs list in userspace_pm_get_local_id
13550242: [net,6/7] mptcp: really cope with fastopen race
13550243: [net,7/7] MAINTAINERS: update Geliang's email address:
      - Series: mptcp: locking cleanup & misc. fixes
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=824412&state=*&archive=both


    our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

13540609: [mptcp-net,1/4] mptcp: add needs_id for userspace appending addr
13540610: [mptcp-net,2/4] mptcp: add needs_id for netlink appending addr:
      - Submitter: Geliang Tang

13548001: [mptcp-next,v3,1/2] mptcp: map v4 address to v6 when
destroying subflow
13548002: [mptcp-next,v3,2/2] selftests: mptcp: rm subflow with
v4/v4mapped addr:
      - Series: fixes for "map v4 address to v6"
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=823789&state=*&archive=both

13548910: [mptcp-next,1/3] selftests: mptcp: pm nl: also list skipped tests
13548911: [mptcp-next,2/3] selftests: mptcp: pm nl: avoid error msg on
older kernels
13548912: [mptcp-next,3/3] selftests: mptcp: diag: fix bash warnings on
older kernels:
      - Series: selftests: mptcp: fixes for issues seen on v5.15.x
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=824054&state=*&archive=both

13549503: [mptcp-net] selftests: mptcp: simult flows: re-adapt BW:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240208-selftests-mptcp-simult_flows_faster-v1-1-2859ca46e582@kernel.org/
      - maybe good to check if the estimations are OK:
          - e.g. maybe take into account the extra delay?
          - maybe a pending fix could improve the situation (missing event)
      - TODO: create a new issue to track that → Matth → done

13550460: [mptcp-net,v2,1/4] mptcp: fix lockless access in subflow ULP diag
13550463: [mptcp-net,v2,2/4] mptcp: fix data races on local_id
13550461: [mptcp-net,v2,3/4] mptcp: fix data races on remote_id
13550462: [mptcp-net,v2,4/4] mptcp: fix duplicate subflow creation:
      - Series: mptcp: fix duplicate subflow creation
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=824465&state=*&archive=both

13551665: [mptcp-net,1/5] selftests: mptcp: simult flows: fix some
subtest names
13551664: [mptcp-net,2/5] selftests: mptcp: userspace_pm: unique subtest
names
13551666: [mptcp-net,3/5] selftests: mptcp: diag: unique 'in use'
subtest names
13551667: [mptcp-net,4/5] selftests: mptcp: diag: unique 'cestab'
subtest names
13551668: [mptcp-net,5/5] selftests: mptcp: lib: catch duplicated
subtest entries:
      - Series: selftests: mptcp: unique subtest names
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=824748&state=*&archive=both

13552846: [virtme-docker,v5] tests: add bpftests support:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/c8d9aacfe97acd74c369496a573ea64070485382.1707729702.git.geliang@kernel.org/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts, Paolo Abeni):

13528961: [mptcp-stable] mptcp: introduce explicit flag for first
subflow disposal:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/a1503ab571c8c076de62b872437d220a2260d2a5.1706094997.git.pabeni@redhat.com/
      - The stable team maybe missed the patch? Maybe due to the tag?
      - Should it be recent? @Christoph
      - Or we wait one more week?

13552937: configs/debug: add NET debug config:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org/
      - Not directly related to MPTCP
      - for the CIs, from a discussion with Jakub

13555794: [v1,net-next] net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.:
      - Submitter: Kuniyuki Iwashima
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240213223135.85957-1-kuniyu@amazon.com/
      - Not directly related to MPTCP
      - Matth reviewed it: v2 needed


    our repo (by: Geliang Tang, Kuniyuki Iwashima, Matthieu Baerts,
Paolo Abeni):

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
      - Skip: status is the same

13294008: [iperf3] add MPTCPv1 support:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/
      - Skip: status is the same

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
      - Skip: status is the same

13545002: [mptcp-next] mptcp: add a sk_is_tcp check for sk_is_mptcp:
      - State: Under review
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/e97e306f73ff10b437eef979b7d5d82b822e2f52.1707113244.git.tanggeliang@kylinos.cn/
      - it looks like we don't want an extra check all the time
      - and renaming the helper might not help → many calls on TCP side
      - it looks like it would not be needed with the 'mptcp: check the
protocol with DEBUG_NET':
          - we would have a warning if we do a tcp_sk() on a non TCP
socket from MPTCP code only: enough.
      → looks like we don't need the patch at the end. Mat will send a
message on the ML + close the GH issue

13548358: [mptcp-next,v3,1/3] mptcp: token kunit: set protocol
13548359: [mptcp-next,v3,2/3] mptcp: check the protocol in tcp_sk() with
DEBUG_NET
13548360: [mptcp-next,v3,3/3] mptcp: check the protocol in mptcp_sk()
with DEBUG_NET:
      - State: Needs ack
      - Series: mptcp: check the protocol with DEBUG_NET
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=823928&state=*&archive=both

13548914: [mptcp-next] selftests: mptcp: stop forcing iptables-legacy:
      - State: New
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240207-selftests-mptcp-iptables-nft-v1-1-108de489316e@kernel.org/

13553401: [mptcp-next,v2,1/7] mptcp: push ad DSS boundaries
13553402: [mptcp-next,v2,2/7] mptcp: fix snd_wnd initialization for
passive socket
13553404: [mptcp-next,v2,3/7] mptcp: fix potential wake-up event loss
13553403: [mptcp-next,v2,4/7] mptcp: cleanup writer wake-up
13553405: [mptcp-next,v2,5/7] mptcp: avoid some duplicate code in socket
option handling
13553406: [mptcp-next,v2,6/7] mptcp: implement TCP_NOTSENT_LOWAT support.
13553407: [mptcp-next,v2,7/7] mptcp: cleanup SOL_TCP handling:
      - State: New
      - Series: mptcp: implement TCP_NOTSENT_LOWAT support
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=825251&state=*&archive=both
      - v2 addressing some comments from Mat
      - minor modifications
      - 3 first patches are for -net

13554435: [mptcp-net,1/5] selftests: mptcp: netlink: drop duplicate var ret
13554436: [mptcp-net,2/5] selftests: mptcp: simult flows: define missing
vars
13554437: [mptcp-net,3/5] selftests: mptcp: add ss mptcp support checks
13554438: [mptcp-net,4/5] selftests: mptcp: join: change
capture/checksum as bool
13554439: [mptcp-net,5/5] selftests: mptcp: diag: change timeout_poll to 30:
      - State: New
      - Series: add helpers and vars in mptcp_lib.sh, part 1
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=825429&state=*&archive=both
      - Matth is looking at that → Done

13556351: [mptcp-next,v12,01/15] mptcp: export mptcp_genl_family &
mptcp_nl_fill_addr
13556352: [mptcp-next,v12,02/15] mptcp: implement
mptcp_userspace_pm_dump_addr
13556353: [mptcp-next,v12,03/15] mptcp: add token for get-addr in yaml
13556354: [mptcp-next,v12,04/15] mptcp: dump addrs in userspace pm list
13556355: [mptcp-next,v12,05/15] mptcp: check userspace pm flags
13556356: [mptcp-next,v12,06/15] selftests: mptcp: add userspace pm
subflow flag
13556357: [mptcp-next,v12,07/15] selftests: mptcp: add token for dump_addr
13556358: [mptcp-next,v12,08/15] selftests: mptcp: add check_output helper
13556359: [mptcp-next,v12,09/15] selftests: mptcp: dump after creating
id 0 subflow
13556360: [mptcp-next,v12,10/15] selftests: mptcp: dump userspace addrs list
13556361: [mptcp-next,v12,11/15] mptcp: add
userspace_pm_lookup_addr_by_id helper
13556362: [mptcp-next,v12,12/15] mptcp: implement
mptcp_userspace_pm_get_addr
13556363: [mptcp-next,v12,13/15] mptcp: get addr in userspace pm list
13556364: [mptcp-next,v12,14/15] selftests: mptcp: add token for get_addr
13556365: [mptcp-next,v12,15/15] selftests: mptcp: userspace pm get addr
tests:
      - State: New
      - Series: dump for userspace pm
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=825972&state=*&archive=both
      - A rebase of the v11.



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 474):

None.


    Bugs (opened, flagged as "bug" and assigned)

  471  Crash in `netif_rx_internal` [bug] [wontfix] [selftests] @matttbe
  451  syzkaller: possible deadlock in` __dev_queue_xmit` [bug]
[syzkaller] @dcaratti
  449  `MPTcpExtMPCapableFallbackACK` - looks surprising [bug] @dcaratti
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  463  syzkaller: INFO: task hung in `lock_sock_nested` [bug] [syzkaller]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
  416  No new subflow when removing an endpoint and adding a new one [bug]
  336  Issues with BPF packet scheduler [bug] [sched] [bpf]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose
server test` are sometimes failing [bug] [selftests]
  318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
cookies [bug] [selftests]
  315  Issues with backup flow [bug]


    In Progress (opened, new feature and assigned)

  474  CI: GH Actions: use self-hosted runners [enhancement] [CI] @matttbe
  472  CI: switch to virtme-ng [enhancement] [CI] @matttbe
  464  `TCP_NOTSENT_LOWAT` socket-option support [enhancement] @pabeni
  453  sk_is_mptcp() only works with struct tcp_sock * [enhancement]
@geliangtang
  446  MPTCP Info counters: display "last time" actions info
[enhancement] @geliangtang
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


    For later (opened and not assigned assigned)

  473  CI: tracking: publish tests results to Kernel CI [enhancement] [CI]
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
  394  selftests: ability to track subtests [enhancement] [selftests]
  389  packetdrill: increase coverage for "early `close()`" cases
[enhancement] [packetdrill]
  383  TCP_KEEPIDLE, TCP_KEEPINTVL, TCP_KEEPCNT are not implemented in
mptcp_setsockopt_sol_tcp [enhancement]
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
  133  PM: Closing the MPTCP connection when last subflow is not the
initial one and its IP address is removed [enhancement]
  128  When the last subflow is closed without DATA_FIN and msk
Established, close msk (after a timeout) [enhancement]
   78  notify the application (userspace) when a subflow is
added/removed [enhancement]
   77  [gs]etsockopt: forward to new/existing SF [enhancement]
   76  [gs]etsockopt per subflow: BPF [enhancement] [bpf]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2024-02-07)

  435  in-kernel PM: fullmesh: too many paths are being created [bug]
@matttbe
  406  Compile and run mptcp bpf selftests in CI [enhancement]
[selftests] [bpf] [CI] @geliangtang:
      remaining task: integrate that in GitHub Action → Matth is working
on that.



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.9):
https://github.com/orgs/multipath-tcp/projects/7
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to netdev:

    - Fixes for other trees:

        - [4d980899ba3f] x86: Fixup from the removed INT3 if it is
unhandled (Masami Hiramatsu):
            - temp workaround for QEmu issue
              https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2051965

    - Fixes for -net:

        - [0e5cafadf1c7] mptcp: add needs_id for userspace appending
addr (Geliang Tang)
        - [f3b359cbcba7] mptcp: add needs_id for netlink appending addr
(Geliang Tang)

        - [f70b2669ea98] selftests: mptcp: simult flows: re-adapt BW
(Matthieu Baerts (NGI0)):
            - maybe best to wait a bit, see the comments above ↑

        - [a026abbb7b78] mptcp: fix lockless access in subflow ULP diag
(Paolo Abeni)
        - [955ccdbcdd81] mptcp: fix data races on local_id (Paolo Abeni)
        - [ae216d9c00d6] mptcp: fix data races on remote_id (Paolo Abeni)
        - [502a662578da] mptcp: fix duplicate subflow creation (Paolo Abeni)

        - [ca917054deec] selftests: mptcp: pm nl: also list skipped
tests (Matthieu Baerts (NGI0))
        - [682ac98be079] selftests: mptcp: pm nl: avoid error msg on
older kernels (Matthieu Baerts (NGI0))
        - [e2d0b6f94dd6] selftests: mptcp: diag: fix bash warnings on
older kernels (Matthieu Baerts (NGI0))

        - [5e25844ac2ae] selftests: mptcp: simult flows: fix some
subtest names (Matthieu Baerts (NGI0))
        - [f0e00dc641bf] selftests: mptcp: userspace_pm: unique subtest
names (Matthieu Baerts (NGI0))
        - [bd5124d4fd65] selftests: mptcp: diag: unique 'in use' subtest
names (Matthieu Baerts (NGI0))
        - [0c059b19b642] selftests: mptcp: diag: unique 'cestab' subtest
names (Matthieu Baerts (NGI0)):
            - it looks like we can send all of the ones above, except one
            - TODO: Matth: send them to netdev → in progress

        - [a19cd6766361] mptcp: map v4 address to v6 when destroying
subflow (Geliang Tang)
        - [260fcb6906cb] selftests: mptcp: rm subflow with v4/v4mapped
addr (Geliang Tang):
            - Have been applied today, maybe we can wait a bit

    - Fixes for net-next: /


    - Features for net-next:

        - [319ff71af424] selftests: mptcp: lib: catch duplicated subtest
entries (Matthieu Baerts (NGI0)):
            - depending on patches that are queued for -net: best to wait.

    - Features for net-next (next): /


    - Features for other trees:

        - [7a052d1ecd40] mptcp: add sched_data helpers (Geliang Tang)
        - [073fba29f933] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [ab7c9c754f9c] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [dee2aeb37f33] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [f589ea7324dc] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [fcc1e6dbfa2e] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [aee4cce52333] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [2f7f151a5d4d] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [2b9415a1e0e8] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [428b1a6af9fa] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [3484b436a72b] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [688a01f9fc5a] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [bc0b2ffd5320] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [0e4c78ce35c8] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [75803d2785aa] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [0c78171755d8] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - wait for the sched refactoring



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - PR for TCP_NOTSENT_LOWAT:
            - there are some bugs in packetdrill with the coalescing:
                - it ignores MPTCP options, aggregate packets that are
not continuous from MPTCP view, keeping the DSS option from the first packet
                - https://github.com/multipath-tcp/packetdrill/pull/132
                - one option: patch packetdrill to fix MPTCP DSS options
of the coalesced packet:
                    - we don't care about the data that are carried, so
we could aggregate non continuous packets from an MPTCP point of view
                    - but the code is quite "complex"
                    - TODO: Matth: create a new issue for that with ↑
                            → done

    - Patchew (Davide):
        - Prevent recreating series (git push -f) when a new tag like
Reviewed-by is shared on the ML?:
            - https://github.com/patchew-project/patchew/pull/143
            - but not tested
            - OK to ask Patchew devs to look at it? → seems ok, small
patch, we can validate the bypass, not the new option
        - Prevent CI modifications: am hook already there

    - CI (Matth):
        - Seems quite green, same flaky tests


GO:
    - What's blocking to have it enabled by default:
        - TCP_KEEPIDLE, TCP_KEEPINTVL, TCP_KEEPCNT
        - https://github.com/multipath-tcp/mptcp_net-next/issues/383
    - https://github.com/golang/go/issues/56539
    - https://go-review.googlesource.com/c/go/+/563575
    - Maybe as part of a fix? TODO: Matth: add this somewhere → done



MPTCP: bogus mpc option on established client sk:
    - can be seen when running the selftests (mptcp_join: no MPC reuse
with single endpoint):
        https://cirrus-ci.com/task/5883870294310912?logs=test#L6445
        (happening 586 times during when running all tests)
    - normal?

https://github.com/multipath-tcp/mptcp_net-next/blob/export/net/mptcp/options.c#L986
        not only in case of fallback to TCP?
    - Matth will investigate



LPC 2024:
    - in Vienna
    - 18-20th of September
    - https://lpc.events
    - might be more likely to have MPTCP contributors there
    - good to prebook?



Next meeting:
    - Next one on *Wednesday*, the 21st of February.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240221



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.
