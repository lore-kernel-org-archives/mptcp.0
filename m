Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F143CB56B
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960178; cv=none; b=g4tHSU5tj5b6Yv48Eg7lCvdkASZPDQBSLF3fRmhXDVG+4ZA+bOdeZ67Ak8MEB22OdsgZOgsWrkuDUxCwLw7vwEqHVeE/xdZ6PJLoC9ERM7ckEfkgjz411luRMbynR1k5P8zbsUQV/Q/g6dBKiU3gYhdkmgSi/b9DHgsfhsUK6PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960178; c=relaxed/simple;
	bh=Ix2SgEARPQBEAdCdToVI4IDjp8QSucpIyOiSEGXbp5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qi/nDr6bbiyKVmIxunpygLyXwFwUk3YgMAKnvT125yqkc7Z5NncNRj11L6X7exbAjNisOOFiPoNCZvoh+Q5ggvx429HikEpzDDZKSR66uXEnACP0Nqa2tnnYUT60tM985yPRyTnOV8u1FYh9n5kroor5t+fBsMsOw6KaCp1zNb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l15aKQnW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l15aKQnW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4456A1F000E9;
	Mon, 17 Aug 2026 09:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786960177;
	bh=a2bv8mQc0pX/e6tC2s1i4kQh/q7goWXQ5gx6yhhKdIc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=l15aKQnWwynVG1G8mQ3SXFAMEvfV+iG5+hLlsMIuvb+GiCCYkMcIZEePcJO4EX2Cc
	 KaPRCP6JwBmWDXDWaxiwX7I5JUQyV5MZRsUBwXTRBG+syPrS5zvGdfi+ThOmG9VQzo
	 +AqjYSZ84OjPqQ0sBWwIeZzg/jMvnXlKJPt6ehU7737i0838iyKnzKmB0Z4Sw3neOF
	 9SQ1I1/H1Ltb7mGDC0395bunsw4Ema8ydShJMT/cObZ8lM6PgJE2x+Bx7dOrb1uZB/
	 sgsC6U5cwVVhD/YB82rJZUqbxcPVkAlaTVP/Ja9ywBDLFBGiQiXDtnJKeXr/eMSvxJ
	 yQYbn8Dq2/k7w==
Message-ID: <f5ba94b7-449f-45d1-b98e-c997faefa4ee@kernel.org>
Date: Mon, 17 Aug 2026 11:49:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next RFC 2/3] mptcp: reject MP_JOIN earlier
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chenguang Zhao <chenguang.zhao@linux.dev>, gang.yan@linux.dev
References: <20260814-mptcp-reset-mpj-early-v1-0-3ca3260f9474@kernel.org>
 <20260814-mptcp-reset-mpj-early-v1-2-3ca3260f9474@kernel.org>
 <e277308e-87b5-4c1c-b976-ff73cf4286a1@redhat.com>
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
In-Reply-To: <e277308e-87b5-4c1c-b976-ff73cf4286a1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for having looked at this!

On 17/08/2026 09:27, Paolo Abeni wrote:
> On 8/14/26 8:31 PM, Matthieu Baerts (NGI0) wrote:
>> @@ -91,12 +92,22 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
>>  	msk = mptcp_token_get_sock(sock_net(req_to_sk(req)), subflow_req->token);
>>  	if (!msk) {
>>  		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINNOTOKEN);
>> +		*reason = MPTCP_RST_EMPTCP;
>> +		return NULL;
>> +	}
>> +
>> +	/* Stop it early if the subflow cannot be accepted */
>> +	if (!mptcp_can_accept_new_subflow(msk)) {
> 
> Side note: the above is inherently racy, the consistency safeguard is
> given by the fallback check at finish_join time.

Just to be sure: even if it is racy, is it OK to use it here but
continuing having the safe check at finish_join time?

In other words, having such a comment is enough?

  /* Stop it early if the subflow cannot be accepted.
   * This check is inherently racy, the consistency safeguard is
   * given by the fallback check at finish_join time.
   */

> Minor nit: I'm not sure this check belongs here or in
> subflow_check_req(). The latter option would avoid the additional
> argument and possibly produce a smaller diff (and smaller code).

After re-looking at this code yesterday, I agree with you. Also, I think
subflow_token_join_request() should only return the msk, and not
changing anything else from subflow_req.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

