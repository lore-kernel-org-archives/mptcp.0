Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478799;
	b=opDSrp0WYP2uXkEzhTQAEpPRKvjQE36bKE/xKDWPzL2LLR87wH0Be0QPFO+Qy+/tcLzE
	 mO3PcjXU0n1bWFDtsiJrLkRXFGyrNJz6pAHlk8TrMF1FUcd4d59/t0xqEBmRhPA9l50XL
	 wJlu6NwEwvi3P2jQM7TGVNo48yLS9bmFQn+YvCcFPGhOKciCeUHblWtMbRB71yAqwm0/d
	 4u1OO32VpxVAIzbZJ57lff1cf4iBC6pJTT6/jElf/v5ZvVOOcuNN5ktm83j3txK3giI4d
	 0MJEldBOP0IY1EDQ6Ghed/qxI6jn5VcJnl5kAHHl4harnma9GCMoJlL0jx3yyoSdZPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478799;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=s8n/KF5kcOYwT1Paln3JHAxLdyCybqBrwFn4Q5kpNao=;
	b=IBGoCKLpFCU6tyJcS3W9Ko3r+Hcj7WdvkAcP86oknY+FoYAyLiDzM4rcSuHsutLle7DT
	 VuBT3ouWku0HZOeR9JnrF4l9k3+Upq0sM0dd0uc+GpB5RtQ3k9kQt+y6f81Y3EKHdjhyb
	 wv03dknXpfQT5YAq4SeQSCCpN+XnQyrXnj+fJIka1DtlRgfORsVWFfblZWczWesoRjG01
	 yX1gca6+Yidak2m9NhVe0uIMfWfRFf74SRDuyxj1xzcsju7Bry3J1hAPdydrN+2jDs8Pu
	 nuwhNoDgq3tvI1Ygeirf1DF6HO1YrXyZQP+ErEnqMmTO9OoJnni9gmdEDOA43+PBfxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TnOq91TO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914F606A321
	for <mptcp@lists.linux.dev>; Thu, 12 Nov 2026 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TnOq91TO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7601F00A05;
	Thu, 12 Nov 2026 10:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794478799;
	bh=s8n/KF5kcOYwT1Paln3JHAxLdyCybqBrwFn4Q5kpNao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TnOq91TO/z0OHjbh5eAOl3CcfPvfKW39ZNyIv69umi9k8wpijKflmVZEwYjHE2XNo
	 dDTUwVHesC5mHyT8zSwps6lkZfH9YsRpjLn4xbHNkuKLXOycEqmQVtxuNnf2E2zqZy
	 mbvgSn3cFVYQz4496PTh4Rmf16XgtR01gYypPsgxnxSODuJSnKzHcES5uBpvOXAqQN
	 T8qRcYEfUBTz7w5Z/iGj4JRBTfiZJRu72RvZpPThX1qdHtijihTjuGoqjg8rqfDThx
	 kTW4f+n7q2aJ8eKKqkeJcsRbknq6aB33ijzEkm+N9s5fFxo0orEzWlckidAEM94iNl
	 cmTSUpngKxRFw==
Message-ID: <08451824-13d5-4e92-adb6-2ebd6c5cf053@kernel.org>
Date: Thu, 12 Nov 2026 11:19:55 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC net-next v12] mptcp: normalize sequence numbers using socket
 address
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp <mptcp@lists.linux.dev>, "shardul.b"
 <shardul.b@mpiricsoftware.com>, janak <janak@mpiric.us>,
 kalpanjani009 <kalpanjani009@gmail.com>
References: <20261106111645.786225-1-kalpan.jani@mpiricsoftware.com>
 <1a1ce1e9b07.f015539104390.2600884748737974966@mpiricsoftware.com>
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
Organization: NGI0 Core
In-Reply-To: <1a1ce1e9b07.f015539104390.2600884748737974966@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

On 12/11/2026 05:57, Kalpan Jani wrote:
> Hi All,
> 
> I investigated the patch application failure locally.
> 
> The patch applies successfully to the intended base commit 27c69362083ec117ddb553c031e7f1e0e5d2105d.
> 
> I also tested both git apply --check and git apply --3way --check in a fresh detached worktree. Both tests passed, and all 12 files applied cleanly.
> Could you please check whether the CI environment has the expected base commit and the required Git blob objects available?

The base you mentions here is not in our tree:


https://github.com/multipath-tcp/mptcp_net-next/commit/27c69362083ec117ddb553c031e7f1e0e5d2105d

Also, it is not mentioned in the patch you sent. The CI cannot apply
this patch:


https://patchew.org/MPTCP/20261106111645.786225-1-kalpan.jani@mpiricsoftware.com/logs/git/

> The reported sha1 information is lacking or useless error may be related to the CI checkout or missing Git objects.

From what I see, the patch you sent is on top of the v11, instead of
replacing it.

Now, regarding the modifications -- even if it is hard to read -- the
offset using the msk address seems to be in place. Now that I'm thinking
about that, I'm afraid I might have given a bad direction: it is
probably not a good idea to give clues on the msk address while there
are many mechanisms in the kernel to hide that. Maybe we could take a
hash of this address? But that's costly: maybe we only want to do that
when coming from mptcp_diag_get_info? Also, we should probably have one
offset per direction (local/remote) not to be able to find out what's
the offset is when one direction is known. We could have a hash of the
msk address for one, and another hash coming from a XOR of the msk
address for example.

Any other ideas?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

