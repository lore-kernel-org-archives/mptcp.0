Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904E918645
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHcHsSIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828B0C433C8;
	Mon, 13 Nov 2023 09:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699866959;
	bh=krllP80hqNtb+fUbFk4200Av78b11g92iyvTST30T+4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=kHcHsSIj5FJHnFdlMDCqQ2Q3GDKDYWF8XoEXZyqRpfYtXIqoURuprrTpa3YLxeRZ2
	 kr1E4qRM0DVTu0Kmk0GkQJRpOe+rt/6urixA3P9pkP9tkA/siVLNZv595GCUVvALF2
	 h739gcffI/t8Rj+8cskVlhJEfIKmxIvuNq6Q+vJ7VzZ0gzrn2I8qE0njtTa/Vp1Rl3
	 PJnq+o4RJztnzu02MMfr+BPuMXcJ/YYqy4Hp7wi7SlxkO+twc4X2+a8FL0KePzfC7x
	 q0+9xNmX70hO++6iCys3VsKANXM8H66pKqtQ4U3Jf8yLJUZ0NLVB5CjHtuvk+hHuVC
	 2+8iOw3buZ/Pg==
Message-ID: <14523a78-3f0f-46d3-b1b8-170a19acab23@kernel.org>
Date: Mon, 13 Nov 2023 10:15:55 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] selftests: mptcp: fix fastclose with csum
 failure
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <720d67a275179d96aba05cccd56a98f10da47aa1.1699647725.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
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
In-Reply-To: <720d67a275179d96aba05cccd56a98f10da47aa1.1699647725.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 10/11/2023 21:24, Paolo Abeni wrote:
> Running the mp_join selftest manually with the following command line:
> 
>   ./mptcp_join.sh -z -C
> 
> lead to some failures:
> 
>   002 fastclose server test
>   # ...
>   rtx                                 [fail] got 1 MP_RST[s] TX expected 0
>   # ...
>   rstrx                               [fail] got 1 MP_RST[s] RX expected 0
> 
> the problem is really in the wrong expectations for the RST checks
> implied by the csum validation. Note that the same check is repeated
> explicitly in the same test-case, with the correct expectation and
> pass successfully.

Good catch! LGTM:

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>

Note that I was a bit confused to see the CI complaining about this test
while not testing it with '-C':

> # 103 fastclose server test
> #       Info: Test file (size 1024 KB) for client
> #       Info: Test file (size 1024 KB) for server
> # copyfd_io_poll: poll timed out (events: POLLIN 1, POLLOUT 4)
> # [fail] client exit code 2, server 0
> # Server ns stats
> # TcpPassiveOpens                 1                  0.0
> # TcpEstabResets                  1                  0.0
> # TcpInSegs                       6                  0.0
> # TcpOutSegs                      7                  0.0
> # TcpOutRsts                      2                  0.0
> # TcpExtTCPPureAcks               2                  0.0
> # TcpExtTCPOrigDataSent           2                  0.0
> # TcpExtTCPDelivered              2                  0.0
> # MPTcpExtMPCapableSYNRX          1                  0.0
> # MPTcpExtMPCapableACKRX          1                  0.0
> # MPTcpExtMPFastcloseTx           1                  0.0
> # MPTcpExtMPRstTx                 1                  0.0
> # Client ns stats
> # TcpActiveOpens                  1                  0.0
> # TcpEstabResets                  1                  0.0
> # TcpInSegs                       7                  0.0
> # TcpOutSegs                      10                 0.0
> # TcpExtTCPPureAcks               2                  0.0
> # TcpExtTCPOrigDataSent           7                  0.0
> # TcpExtTCPDelivered              7                  0.0
> # MPTcpExtMPCapableSYNTX          1                  0.0
> # MPTcpExtMPCapableSYNACKRX       1                  0.0
> # 
> # netns ns1-654eb1d7-Nk17nk socket stat for 10102:
> # Netid State Recv-Q Send-Q Local Address:Port Peer Address:PortProcess
> # TcpPassiveOpens                 1                  0.0
> # TcpEstabResets                  1                  0.0
> # TcpInSegs                       6                  0.0
> # TcpOutSegs                      7                  0.0
> # TcpOutRsts                      2                  0.0
> # TcpExtTCPPureAcks               2                  0.0
> # TcpExtTCPOrigDataSent           2                  0.0
> # TcpExtTCPDelivered              2                  0.0
> # MPTcpExtMPCapableSYNRX          1                  0.0
> # MPTcpExtMPCapableACKRX          1                  0.0
> # MPTcpExtMPFastcloseTx           1                  0.0
> # MPTcpExtMPRstTx                 1                  0.0
> # 
> # netns ns2-654eb1d7-Nk17nk socket stat for 10102:
> # Netid State Recv-Q Send-Q Local Address:Port Peer Address:PortProcess
> # TcpActiveOpens                  1                  0.0
> # TcpEstabResets                  1                  0.0
> # TcpInSegs                       7                  0.0
> # TcpOutSegs                      10                 0.0
> # TcpExtTCPPureAcks               2                  0.0
> # TcpExtTCPOrigDataSent           7                  0.0
> # TcpExtTCPDelivered              7                  0.0
> # MPTcpExtMPCapableSYNTX          1                  0.0
> # MPTcpExtMPCapableSYNACKRX       1                  0.0
> #       syn                                 [ ok ]
> #       synack                              [ ok ]
> #       ack                                 [ ok ]
> #       ctx                                 [ ok ]
> #       fclzrx                              [fail] got 0 MP_FASTCLOSE[s] RX expected 1
> #       Info: invert,rx=0
> #       rtx                                 [ ok ]
> #       rstrx                               [fail] got 0 MP_RST[s] RX expected 1

See:
https://api.cirrus-ci.com/v1/artifact/task/5358215681015808/summary/summary.txt

But the error is different here because the client got an error (poll
timed out). It looks like it is similar to a known issue:

https://github.com/multipath-tcp/mptcp_net-next/issues/324

So all good, I can apply your patch!

Cheers,
Matt
