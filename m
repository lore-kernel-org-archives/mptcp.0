Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097917;
	b=MxRNrTf5d/tB6J01d4mH3YXV6RCQa+9QI3ob8wWXBYQRjIpwcH5MzG8P9b3IauZhDt5S
	 Zsvck/Y6QpdEiCnKwPylPhkl9eb6A/3/4PJSKnnnZE4HBEfub0HrwbZkzZIkGsj+0i8LY
	 Mk/3vqxClhK5FLqAhA1FPllLMGunPLUve/L88xkMaJmt963QHP7uH6aYDDkJGE+ELrH2m
	 MxliC3gqB6lBF7u5VPS09qilVaUd2PfgO3fBREKVj21jB7ZXiynEWXrizURJm8Sfl4m5Q
	 FDLvsWzuLc07kH6tEvNdu7Kgv34RPxePT2pv6lPYxiFWwSWtXIgTAO+4h+Tx7YlXe3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097917;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=vtv1OzrhaHal7/oEeA55QBvV5cR5nnK9uv/WVL/r9cg=;
	b=xWN1pLrpGIOpfZQQ6Wr5KzR6PvtCAtW3QKzcdr5vqLNF0hO5Wpee374nAAxsk84mSfRn
	 rChutIa6VYQPQd+JbakFW2R6bO7KMzwFjXCTbHq1cE4/waJd3NRMDO7V1P+M0IDdM7AWs
	 ZLE+pBycCyf9C6c/WoJvfyhGsuRqcmU+kMs7tF2co5gBql7myvwRvHd8A4eJ1Fo/gkIwS
	 08tGF6yFcjwU4MNlsPSi6eqcfB/Lh4zmpzN0R1QIWXOYrWCA+ISwctKfblAUHLoPHsA2h
	 R57jBnhqpgRXcliBHEPIc96J7WRPy83zj51RPtYNi1jx4Uu3uDJGmi2dEJ9H+E5OHDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtWgHq5Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C8C606A31A
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtWgHq5Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDF81F01825;
	Tue, 27 Oct 2026 10:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793097916;
	bh=vtv1OzrhaHal7/oEeA55QBvV5cR5nnK9uv/WVL/r9cg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DtWgHq5QPwcecWCa7HM1s2Mfqid7D/N3cwEMj7+mhyBxuz31+zTK4jFKBAegVmEyS
	 x9qLHj0aD3X3MJGIdr6y61wjC1pb47NC/hs6Lk4M9lGzUR6Q5UYaJnnNRt4rVHH5fb
	 o0sqI/5SfNcRIaJoZakWopZfPc2HNpCNe/Mn5D5PausOujgL+oO0GKfkFqzCOWT/WA
	 Q/o0ehpkM7+I0x9hQYdgtzVlhYXS2W9GWFnSqhrvJ4oTrtPHHR/3JQjX4OEyn58bJ5
	 hAeYjSwAL63WTk2WubmQmJhYpR12BQ6pOFZZS8uhi1VVjqaK3Z1fM2hF95tMKa7405
	 31bPdd32V1Txw==
Message-ID: <ad0f8a94-09b8-46d4-b807-94f1f52f1d1d@kernel.org>
Date: Tue, 27 Oct 2026 11:45:13 +0100
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
Subject: Re: [RFC net-next v10] mptcp: normalize seq numbers reported in
 mptcp_info
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: martineau@kernel.org, pabeni@redhat.com
References: <20261027062750.2095515-1-kalpan.jani@mpiricsoftware.com>
 <20261027095410.3675317-1-kalpan.jani@mpiricsoftware.com>
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
In-Reply-To: <20261027095410.3675317-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kalpan,

Thank you for your reply.

On 27/10/2026 10:54, Kalpan Jani wrote:
> Hi Matt,
> 
> Thanks for reviewing the new version and for the suggestions.
> 
> I understand that v10 mixes two different approaches: normalizing the
> sequence values and hiding them from unprivileged diagnostic
> requests. I will separate these concerns rather than keep them
> bundled together.
> 
> I will first check whether the requester's CAP_NET_ADMIN status can
> be obtained reliably from the existing skb in
> inet_diag_handler_get_info(), so that we can avoid changing the
> idiag_get_info callback interface if possible. If that is not
> feasible, I will keep the generic callback change separate from the
> MPTCP-specific diagnostic change.
> 
> For MPTCP_SUBFLOW_ATTR_MAP_SEQ, I understand that the value should be
> zero for callers without CAP_NET_ADMIN. I will apply the same access-
> control policy consistently to the relevant MPTCP diagnostic fields.
> 
> I will also investigate whether the existing byte counters, such as
> bytes sent, received, and acknowledged, can provide the information
> needed for issue #445 without exposing the sequence counters. I will
> keep any required sequence-baseline fixes, including the two issues
> reported by Sashiko, separate from the diagnostic access-control
> change.

Just to be sure it is clear:

- If it is possible to use the bytes counters to provide the normalised
  seq counters, let's use them. If not, please say why before sending a
  new version, maybe we could add a similar counter instead of relying
  on the initial one.

- If that's not possible, set 0 for if no CAP_NET_ADMIN by looking at
  the skb (minimal changes only on MPTCP side).

- If that's not possible, add the net_admin parameter, and try to avoid
  setting "false" in inet_diag_handler_get_info → maybe we can check the
  capability linked to this skb? → to be tested of course

> I will update the patch series after checking these points and
> validating the changes.

Thank you for your patience!

Also, please reply to the right message with quote to add context,
otherwise it is hard to follow when switching between many series.

  https://subspace.kernel.org/etiquette.html

  https://docs.kernel.org/process/email-clients.html

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

