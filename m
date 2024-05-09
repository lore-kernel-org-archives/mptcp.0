Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C110814AD1B
	for <mptcp@lists.linux.dev>; Thu,  9 May 2024 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715250528; cv=none; b=A2vqfacSGr0WVrqNiGsqqhNEP/Oc356ePbk9gK/bQlwr+UrGDbqGtLrFyC333VxccqwuLiodahIT0RZfDH20fwKBcCsJrw7ku9637yMuDn5kU0K0ebBCGRMP2SDaRZVdqt5A2TjlXIJhTFx++0tY+h3/HIF062WV9rhO0fe552Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715250528; c=relaxed/simple;
	bh=XAEj2pNGEZPblYux2usNjDsB7Gr23CQ2aX1qajdei50=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=JWpftzhcoKNF+3Udno/Sj2N4blHshFmufEuK+hZCfwHbL/thUqFSE778deYQzmElaoZNnf4bHWyUvij9Rh40MhMz8rM/6vXxWwe/O1qoFhhA5gg9zWdE8Un9cjltGV12l8rR3ZA7F6ZpKdhW9NRsDekcSo6KlF6XbgspcLQRN04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ukm20gDp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ukm20gDp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF71FC116B1;
	Thu,  9 May 2024 10:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715250528;
	bh=XAEj2pNGEZPblYux2usNjDsB7Gr23CQ2aX1qajdei50=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=Ukm20gDpCNbdOAyLiuAvtKzeyBJaOE1xZP4BbJU0oaEom/pvinsgWp7nXKIcDsR7z
	 guFkembafJ1pURA5gIE73vi10EJoouOhJe7WwI/tc9vMvJK4bRlntY1gFlTTUWMFmf
	 o2nks6qA4PPXFu5Z+aFPFDjP9iLUoSTQ5vXLj+jShvAn1rbG35a7MWlnK9aeRkpbnp
	 BeBLSLu6+1533JyMEPDfqkX+9ddMrHTiVDDRyrQsxATHWsCGfpChiy2yfIbkWeiw4B
	 AU+f4+UMEeYPwugDHu35x7NYfZkzoe6XANt+E/95NM0NMYWn/aE1OOqvK+76352gLT
	 80A8F+nPYJW9w==
Message-ID: <0d2f4dd2-2619-4c42-8765-f8c0a0b1871c@kernel.org>
Date: Thu, 9 May 2024 12:28:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 2/2] mptcp: fix full TCP keep-alive support
To: Paolo Abeni <pabeni@redhat.com>
References: <20240508-mptcp-tcp-keepalive-sockopts-v1-0-fdf7e03e14c4@kernel.org>
 <20240508-mptcp-tcp-keepalive-sockopts-v1-2-fdf7e03e14c4@kernel.org>
 <dbaa4e59f1dbdbcf77634349ee968b4199b786f7.camel@redhat.com>
Content-Language: en-GB
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
Cc: mptcp@lists.linux.dev
In-Reply-To: <dbaa4e59f1dbdbcf77634349ee968b4199b786f7.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

Thank you for the review!

On 08/05/2024 17:44, Paolo Abeni wrote:
> On Wed, 2024-05-08 at 11:44 +0200, Matthieu Baerts (NGI0) wrote:
>> SO_KEEPALIVE support has been added a while ago, as part of a series
>> "adding SOL_SOCKET" support. To have a full control of this keep-alive
>> feature, it is important to also support TCP_KEEP* socket options at the
>> SOL_TCP level.
>>
>> Supporting them on the setsockopt() part is easy, it is just a matter of
>> remembering each value in the MPTCP sock structure, and calling
>> tcp_sock_set_keep*() helpers on each subflow. If the value is not
>> modified (0), calling these helpers will not do anything. For the
>> getsockopt() part, the corresponding value from the MPTCP sock structure
>> or the default one is simply returned.
>>
>> It looks important for kernels supporting SO_KEEPALIVE, to also support
>> TCP_KEEP* options as well: some apps seem to (wrongly) consider that if
>> the former is supported, the latter ones will be supported as well. But
>> also, not having this simple and isolated change is preventing MPTCP
>> support in some apps, and libraries like GoLang [1]. This is why this
>> patch is seen as a fix.
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/383
>> Fixes: 1b3e7ede1365 ("mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY")
>> Link: https://github.com/golang/go/issues/56539 [1]
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  net/mptcp/protocol.h |  3 +++
>>  net/mptcp/sockopt.c  | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 60 insertions(+)
>>
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index c09357e04f23..8c7ab1d50c75 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -309,6 +309,9 @@ struct mptcp_sock {
>>  			in_accept_queue:1,
>>  			free_first:1,
>>  			rcvspace_init:1;
>> +	u8		keepalive_cnt;
>> +	unsigned int	keepalive_idle;
>> +	unsigned int	keepalive_intvl;
> 
> It's a bit a pity we have to duplicate such values in all the subflows
> _and_ in the msk...

Yes, I agree, but I don't see how else we could do that :-/

(Or relying on what has been set in the first subflow? But that's not
what we are currently doing, and should be part of a separated
refactoring I think, see below.)

>>  	u32		notsent_lowat;
>>  	struct work_struct work;
>>  	struct sk_buff  *ooo_last_skb;
>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>> index d9f0d36e24ad..794d8b63024a 100644
>> --- a/net/mptcp/sockopt.c
>> +++ b/net/mptcp/sockopt.c
>> @@ -622,6 +622,30 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
>>  	return ret;
>>  }
>>  
>> +static int __mptcp_setsockopt_set_val(struct mptcp_sock *msk, int max,
>> +				      int (*set_val)(struct sock *, int),
>> +				      unsigned int *msk_val, int val)
>> +{
>> +	struct mptcp_subflow_context *subflow;
>> +	int ret = 0;
>> +
>> +	if (val < 1 || val > max)
>> +		return -EINVAL;
> 
> I think it would be better just skip this check, to avoid copying more
> logic from TCP, and do the store and sockopt_seq_inc() only when the
> operation is successful on all the subflows.

Good idea!

>> +	*msk_val = val;
>> +	sockopt_seq_inc(msk);
>> +
>> +	mptcp_for_each_subflow(msk, subflow) {
>> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>> +
>> +		lock_sock(ssk);
>> +		ret |= set_val(ssk, val);
> 
> the above produces 'reasonable' return code only if all 'set_val' calls
> will return the same error code.
> 
> That expectation should be respected by the existing code, but what
> about keeping the first error code only? e.g:
> 
> 	int err, ret;
> 	// ...
> 
> 		ret = set_val(ssk, val);
> 		err = err ?: ret;
> 
> 	// ...
> 	return err;

Yes, sounds cleaner and similar to what we did with TCP_CONGESTION, thanks!

>> +		release_sock(ssk);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>  static int __mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, int val)
>>  {
>>  	struct mptcp_subflow_context *subflow;
>> @@ -818,6 +842,22 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>>  	case TCP_NODELAY:
>>  		ret = __mptcp_setsockopt_sol_tcp_nodelay(msk, val);
>>  		break;
>> +	case TCP_KEEPIDLE:
>> +		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPIDLE,
>> +						 &tcp_sock_set_keepidle_locked,
>> +						 &msk->keepalive_idle, val);
>> +		break;
>> +	case TCP_KEEPINTVL:
>> +		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPINTVL,
>> +						 &tcp_sock_set_keepintvl,
>> +						 &msk->keepalive_intvl, val);
>> +		break;
>> +	case TCP_KEEPCNT:
>> +		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPCNT,
>> +						 &tcp_sock_set_keepcnt,
>> +						 (unsigned int *)&msk->keepalive_cnt,
> 
> keepalive_cnt is 'u8' so the above will be technically a buffer
> overflow ;) If we keep 'keepalive_cnt' in msk, it has to become
> an 'unsigned int'

Argh, good catch! I checked the limits (1 < val < MAX_TCP_KEEPCNT), and
I missed the overflowing later, sorry :-/
Easier to store the original value, as an 'int' then.

> 
>> +						 val);
>> +		break;
>>  	default:
>>  		ret = -ENOPROTOOPT;
>>  	}
>> @@ -1332,6 +1372,8 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
>>  static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>>  				    char __user *optval, int __user *optlen)
>>  {
>> +	struct sock *sk = (void *)msk;
>> +
>>  	switch (optname) {
>>  	case TCP_ULP:
>>  	case TCP_CONGESTION:
>> @@ -1352,6 +1394,18 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>>  		return mptcp_put_int_option(msk, optval, optlen, msk->nodelay);
>>  	case TCP_NOTSENT_LOWAT:
>>  		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
>> +	case TCP_KEEPIDLE:
>> +		return mptcp_put_int_option(msk, optval, optlen,
>> +					    msk->keepalive_idle ? :
>> +					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_time) / HZ);
> 
> If we force the first subflow to be present/allocated at setsockopt
> time, then here we could:
> 
> 	case TCP_KEEPIDLE:
> 	case TCP_KEEPIDLE:
> 	case TCP_KEEPCNT:
> 		return do_tcp_getsockopt(msk->first, SOL_TCP,
> optname, 
> 					USER_SOCKPTR(optval),
> 					USER_SOCKPTR(optlen));

I initially did that -- by calling mptcp_getsockopt_first_sf_only() --
like it is done for TCP_FASTOPEN*, etc.

But then I changed that because TCP_FASTOPEN* and similar only make
sense on the first subflow, while the other ones in the list (TCP_INQ,
TCP_CORK, etc.) are set on all subflows. So I thought not to make an
exception here. (Also, socket options could be modified per subflow with
BPF, best not to have exceptions here).

But I still think it would make sense to do that if we also do the same
with the other socket options: I do think the way we handle the socket
options should be simplified, e.g. what I proposed a while ago, and I
failed to update so far:

  https://patchwork.kernel.org/project/mptcp/list/?series=763505&state=7

We could rely on the first subflow for the get as you suggested, but
also use {ip,ipv6,tcp,sock}_[gs]etsockopt(), instead of setting
variables manually. And maybe refactoring the 'sync' to "duplicate"
options set on the first subflow, and not to have to store TCP specific
options that have been set.

Would it be OK to look at that later, and keep this way here?

>> +	case TCP_KEEPINTVL:
>> +		return mptcp_put_int_option(msk, optval, optlen,
>> +					    msk->keepalive_intvl ? :
>> +					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_intvl) / HZ);
>> +	case TCP_KEEPCNT:
>> +		return mptcp_put_int_option(msk, optval, optlen,
>> +					    msk->keepalive_cnt ? :
>> +					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_probes));
>>  	}
>>  	return -EOPNOTSUPP;
>>  }
>> @@ -1467,6 +1521,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
>>  		tcp_set_congestion_control(ssk, msk->ca_name, false, true);
>>  	__tcp_sock_set_cork(ssk, !!msk->cork);
>>  	__tcp_sock_set_nodelay(ssk, !!msk->nodelay);
>> +	tcp_sock_set_keepidle_locked(ssk, msk->keepalive_idle);
>> +	tcp_sock_set_keepintvl(ssk, msk->keepalive_intvl);
>> +	tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
>>  
>>  	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
>>  	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
>>
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

