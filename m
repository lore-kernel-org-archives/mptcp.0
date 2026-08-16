Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159CF3BBFDD
	for <mptcp@lists.linux.dev>; Sun, 16 Aug 2026 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786896800; cv=none; b=lZvnn9+zt1DR/c8QNwDJQsf/otWlXPMZg2EvIjP+xzL3BuDd0/ZfnDXXh6gTiDxNNz9mLvONWXMANsxd/QAG/tDGEbIGD9S+jx6BGZyyjnZqUXyKAOmnihYFxZYaBeQm4x41QBybZyQg8jmmu4EK7rk15YppEW2ewEy5vJxD6Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786896800; c=relaxed/simple;
	bh=BP8Yv6Aq91krJEF2L+rJite63A2g99xfAyUlt7wvZhM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=n6EJgqKiffkAthcsrwRiqMtxE3jOUFlpGH5IXXL6qHjb0S/xf+EXn3+ShtQOg+4GbYA8DGNH77S+2buS42PW29R6QcFPhEA6n9jRW1fkQIgFJ2Y4fWSWYxXVib0XeVawILTWIYljWHdkA7PBzgZj/l/+g81mTZVL6alheJSO/8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyYqYZ6S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyYqYZ6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D501F000E9;
	Sun, 16 Aug 2026 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786896799;
	bh=cZVxSj1GpogDtipFjK8j1msanPORFnfR8t1+bjDl1ZE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=NyYqYZ6SCGKCNYkY/g9kbx5Qp6k89CN+kLm7p4xVKgDUmdS+HZBdzs3EGU4UX6cN6
	 gG970UIUtSDIZkBTHfwWJJBPAYbqdI0wDozCjQwMc5ITjzmXBdJac2zevZ6bY/mfqx
	 qx3NAmwIyXCr0Ql+apjEjoHguJ7CxR1mmul7qg6A7erPQafQR9Scj/i1NGtM/o95HX
	 oTm1ZwLlsfL29osJP/fEEZMc56JYhrajhYd4D05OQO8Mz/OH49lUF4AxZrGNf+73nb
	 xEatedgMqMgOn3mv8TIJtAULcsQHlrilIE6worCVcrmHh2G8mxnMhmGOBH5eaGduc2
	 Xc/gcnwpYMdDg==
Message-ID: <68ead427-6c15-49f3-8ed6-64383fdda680@kernel.org>
Date: Sun, 16 Aug 2026 18:13:16 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next RFC 2/3] mptcp: reject MP_JOIN earlier
Content-Language: fr
From: Matthieu Baerts <matttbe@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, Chenguang Zhao
 <chenguang.zhao@linux.dev>, gang.yan@linux.dev
References: <20260814-mptcp-reset-mpj-early-v1-0-3ca3260f9474@kernel.org>
 <20260814-mptcp-reset-mpj-early-v1-2-3ca3260f9474@kernel.org>
 <687bd2da-28b5-4753-b942-d18cb53d9239@kernel.org>
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
In-Reply-To: <687bd2da-28b5-4753-b942-d18cb53d9239@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/08/2026 18:12, Matthieu Baerts wrote:
> Hello,
> 
> On 14/08/2026 20:31, Matthieu Baerts (NGI0) wrote:
>> When a SYN + MP_JOIN is received, it is good to check directly if the
>> MP_JOIN is allowed, then checking that later at the establishment of the
>> new subflow.
>>
>> This avoids situations where the 3WHS is done, then the joined subflow
>> is rejected.
>>
>> This changes the behaviour, and the new behaviour is tracked with the
>> MPJoinDisallow MIB counter.
>>
>> TODO: adapt the selftests to be able to run on older kernels: if the new
>> counter is not available, increment syn_ack and syn_rej instead.
> 
> (...)
> 
>> @@ -217,17 +228,19 @@ static int subflow_check_req(struct request_sock *req,
>>  			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_TOKENFALLBACKINIT);
>>  
>>  	} else if (opt_mp_join && listener->request_mptcp) {
>> +		u8 reason;
>> +
>>  		subflow_req->ssn_offset = TCP_SKB_CB(skb)->seq;
>>  		subflow_req->mp_join = 1;
>>  		subflow_req->backup = mp_opt.backup;
>>  		subflow_req->remote_id = mp_opt.join_id;
>>  		subflow_req->token = mp_opt.token;
>>  		subflow_req->remote_nonce = mp_opt.nonce;
>> -		subflow_req->msk = subflow_token_join_request(req);
>> +		subflow_req->msk = subflow_token_join_request(req, &reason);
>>  
>>  		/* Can't fall back to TCP in this case. */
>>  		if (!subflow_req->msk) {
>> -			subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
>> +			subflow_add_reset_reason(skb, reason);
>>  			return -EPERM;
>>  		}
> 
> Note: the call to mptcp_can_accept_new_subflow() here below, when
> handling req->syncookies, is no longer needed as it is now done earlier
> for all cases, in subflow_token_join_request().
I meant to add the diff:

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 7552abf4c333..c629bcce6ecc 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -258,15 +258,8 @@ static int subflow_check_req(struct request_sock *req,
 
 		subflow_req_create_thmac(subflow_req);
 
-		if (unlikely(req->syncookie)) {
-			if (!mptcp_can_accept_new_subflow(subflow_req->msk)) {
-				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINREJECTED);
-				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
-				return -EPERM;
-			}
-
+		if (unlikely(req->syncookie))
 			subflow_init_req_cookie_join_save(subflow_req, skb);
-		}
 
 		pr_debug("token=%u, remote_nonce=%u msk=%p\n", subflow_req->token,
 			 subflow_req->remote_nonce, subflow_req->msk);


Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

