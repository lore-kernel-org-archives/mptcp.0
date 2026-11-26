Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711845;
	b=CBjB/uiLd09Sy32HMUAmzO3lzkh37E4mdHnFkeHBvUT4YKNrw93gkILacRZDnX6dk36/
	 FI/PPtjf8ilPyOGaZRD7jgnC4oTk/NQsP4mlyWxRm5acyDpCE2sB3zVtPXjFU4bDLFzFL
	 WYYFXj7PfE7sB5/R0NRJaYFzr+38a5aUysVpQMAlJ+tnHH7OEcwp075SS+Q9WT1C6wZqi
	 gzKJ4Ua4vCsqoXmQaXJr3hKStgKvhCsRmZhs2nEIJN3sdxObwHNzwqLBmmCwbG5XhXRJM
	 3qG15X1GA4gVZqD3vYV2d3mPr4ALfsBTGSR7PNjfJk/c+4I92Y83Xm9p2FbGScc2Pfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711845;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:References:From:Cc:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=W9nAynEzQufitJjFrV2piTFuL135Pqrqr5oFKSxRaUE=;
	b=r6ulyhdydPGTZe/WOy4S0Ws8iyuF/lW7MHivCMAU4JFzIh5bXYa/I8f7skXk8zPH3UXG
	 eFyZfBw4NP+jceIBEOWTiZ7eNKrwGO66YmkkIg9ZLHMSG3buTqRqNeEY8lFYhotNICc9m
	 apdG6OYps8Tmr7vpa58KoNjNFO4T78tK49u5Ct28qQ5xbvWxwzlsI25uuy64SNaqP9NvN
	 zR/67yoPd0ziWuZa5qXrIYBIBhMX0JyEtyoRHJeEPZkjnDnt4c5JFhMPAEbsuB0rHDVdD
	 XbNUVp0bcP5a+v2XCBbcZMdHhEUYBPYTinZS7OWpgHKlK+P3eq0ZyUd+ollHTTWOi6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bT0hqT0w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B61606A31C;
	Thu, 26 Nov 2026 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bT0hqT0w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3121F000CF;
	Thu, 26 Nov 2026 16:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795711844;
	bh=W9nAynEzQufitJjFrV2piTFuL135Pqrqr5oFKSxRaUE=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=bT0hqT0w+b6Pds+TGUBUbPfuefqjHUO57AbDWTJ7WWfVVm9iX9tEWJLn5Tk3UUmGq
	 yIRhupF6A3AP2p0iv5x3pDW65Z6tr6OwmdsSbLtbMKUEXflTRN03wTuyhHjlnbubFT
	 BJxV7w+EXkdMFIp9IETHcgvRsDnuUdn4D2eCSCQmW2RQbwW+ZmdLBLR9Db+5xD6j7u
	 lAlJNRLOPOB1gyJadQkgsO3KNe6xitkc96+K/EevrdSQXmbY0LP8kEBCdGHqDY/hC+
	 +5VHBccFTDxOlvvDOG03CFR98qIAtp+hmyZFO4VBNVI25vHlV47l06JGpMPQ2JHe0Q
	 v+ND6wXxVT+yw==
Message-ID: <a4fe18ce-e8d1-4b54-abee-2dd181be2dbf@kernel.org>
Date: Thu, 26 Nov 2026 17:50:42 +0100
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
Subject: Re: [PATCH mptcp-net v3 12/50] mptcp: no sf left: process pending
 DATA_FIN
Content-Language: fr
To: sashiko-reviews@lists.linux.dev
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
 <20261124-mptcp-cmason-fixes-v3-12-416c0920c73f@kernel.org>
 <sashiko-outbox-232136@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
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
In-Reply-To: <sashiko-outbox-232136@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 24/11/2026 23:33, sashiko-bot@kernel.org wrote:
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index bcdad00d35732..b57d0f82b416e 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c

(...)

>> @@ -2819,9 +2831,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>>  			mptcp_schedule_work(sk);
>>  		} else if (sk->sk_state != TCP_ESTABLISHED ||
>>  			   msk->in_accept_queue) {
>> -			/* After the close, an MP_FASTCLOSE would be ignored */
>> -			mptcp_check_fastclose(msk);
>> -
>> +			mptcp_check_rcv_close(sk);
>>  			mptcp_set_state(sk, TCP_CLOSE);
>>  			WRITE_ONCE(sk->sk_shutdown,
>>  				   sk->sk_shutdown | SEND_SHUTDOWN);
> 
> [Severity: Medium]
> Should mptcp_check_rcv_close(sk) run before the
> sk->sk_state != TCP_ESTABLISHED check?
In ESTABLISHED, the DATA_FIN is processed when the backlog is spooled at
the release of the socket: the reader gets the data, then EOF, and the
close timeout closes the socket, as before. So no need to change if I'm
not mistaken. I can clarify the commit message.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

