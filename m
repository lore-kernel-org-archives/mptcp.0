Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF34182AA
	for <mptcp@lists.linux.dev>; Tue, 11 Jul 2023 09:43:12 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51e590a8ab5so2556924a12.2
        for <mptcp@lists.linux.dev>; Tue, 11 Jul 2023 02:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689068590; x=1691660590;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBsZ4K60d0XqobjNBJj49QJYNT+bGGaAF22bTYXNoFk=;
        b=0/skmTIYd5X4m/LlOPA3XSW22aNjhiOXoo63VE4TBgTYPnXpPfwVCgkr8ivknKWoUJ
         sOLDUcRzpkO2NKf40tUM9Vqj3XrAssCX5vNqcI/0JMMp6Ew6pyBCSLyNDO2tWWcHOcgG
         i3hj/CIfafqXU8Y7VCKjcUouSTeEDOVMIlsS6hzkmjMtAjt+VtvSfKgFJfTcZisT2sQQ
         F8rqd0mCEcN3PRmcVkl1UmV6WeVx+7hlJclBzEB/IjPV3XOHGH1dM1KvnNKHzqlAcjND
         pOpYX0sK0RgY3NXcAt2ZONDdO7tk/Uw/BJBTLtwCVEPc/RwQ6Rzqq9zJoMAkGmilzobL
         VzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689068590; x=1691660590;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rBsZ4K60d0XqobjNBJj49QJYNT+bGGaAF22bTYXNoFk=;
        b=ckuUyIMQxERvUetahudP5cxy039rZ/y0SK2aM0azzzpcMxVoKRvToN+H21DhNuhoBi
         W7iu2hG/75gNphW/upxMJAZnA12ddZFFZe0wE8BFgI1/9YSU2+YVB7r0kgRtbVONWkzH
         MC1g49QnfXYvHCAy6dDx9P2zXLBwJUuxpXalqVkRG5/Vool3MjVk6P1TgN+dTuH2gMkF
         bXZdSH1vbrMotDKHN02FKn9ixoJaFQiLqtHssJts2X34ajBgBFUgDh4UHCt/8zwyk8la
         p1EN0AJjLDoen7zJlIziIglsOJ8I+jmGGWiLRaZmmDVQybzaXnMnjjYJb+KH6WboWb2Z
         azlA==
X-Gm-Message-State: ABy/qLbOTL616ByoQXSS6K1zD2ncLIcf2d54OuUBX4teDaZFlPuJuQ/m
	Tl8/1CikEol6HV1CmGP1M/Ehig3yhqliK9mu6ng=
X-Google-Smtp-Source: APBJJlFN2RMJnUzJQ4+ODZdEGNK+QHYsgKFIegG0aKx3NOOGXKfSFwBwr+5XT0rGOGi1nKtkeejebA==
X-Received: by 2002:a17:907:124d:b0:991:d2a8:6588 with SMTP id wc13-20020a170907124d00b00991d2a86588mr15416358ejb.51.1689068590320;
        Tue, 11 Jul 2023 02:43:10 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:7fe7:f31d:3a5d:b710? ([2a02:578:8593:1200:7fe7:f31d:3a5d:b710])
        by smtp.gmail.com with ESMTPSA id y24-20020a170906471800b00992b71d8f19sm917879ejq.133.2023.07.11.02.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 02:43:10 -0700 (PDT)
Message-ID: <a70351da-2894-fb4b-7dd3-4b611a5534e3@tessares.net>
Date: Tue, 11 Jul 2023 11:43:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next 5/6] mptcp: sockopt: set val in a generic way
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
 <20230707-mptcp-unify-sockopt-issue-353-v1-5-693e15c06646@tessares.net>
 <04b15a240e3f84e7de1f4593f8b70b1b0a88ddd4.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <04b15a240e3f84e7de1f4593f8b70b1b0a88ddd4.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for the reviews!

On 10/07/2023 19:05, Paolo Abeni wrote:
> On Fri, 2023-07-07 at 18:00 +0200, Matthieu Baerts wrote:
>> Currently, to set socket option, we mostly deal with them case by case
>> by setting the right field in the socket structure and in fact, copying
>> what is done elsewhere in SOL_IP(V6). Supporting a new option is then
>> more complex and we can see some disparities on how things are done
>> between the different options.
>>
>> Instead, we can rely on ip(v6)_setsockopt() to set the different values.
>> By doing that, we uniform the way we deal with the different options and
>> we can also go through the BPF et Netlink hooks if needed. We can also
>> easily support new options later.

(...)

>> -static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
>> -				       sockptr_t optval, unsigned int optlen)
>> +static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
>> +				   int optname, sockptr_t optval,
>> +				   unsigned int optlen)
>>  {
>>  	struct mptcp_subflow_context *subflow;
>>  	struct sock *sk = (struct sock *)msk;
>> -	int err, val;
>> +	int err;
>>  
>> -	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
>> +	err = mptcp_setsockopt_msk(msk, level, optname, optval, optlen);
>>  
>>  	if (err != 0)
>>  		return err;
>>  
>>  	lock_sock(sk);
>>  	sockopt_seq_inc(msk);
>> -	val = inet_sk(sk)->tos;
>>  	mptcp_for_each_subflow(msk, subflow) {
>>  		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>>  
>> -		__ip_sock_set_tos(ssk, val);
>> +		tcp_setsockopt(ssk, level, optname, optval, optlen);
> 
> The above ignores the tcp_setsockopt() return value. What if the
> sockopt fails on a single subflow? e.g. the 2nd one?
> 
> Perhaps not possible with the currently supported sockopt, but if the
> goal is to extend the support in a generic way, we will likely hit
> that. Note that even saving and e.v. restoring the value on failure is
> prone to the same problem (restoring could fail, too).

That was somehow the behaviour we had before: we use setsockopt() on the
MPTCP sock and we stop if there is an error. If not, it means the
parameters are fine and we can propagate the value to all subflows.
Before, we were not looking for errors when setting the value on the
different subflows.

Now we use the "normal" flow to set this parameter on the different
subflows and if the corresponding sockopt has additional checks before
setting the value (or if some are added later and we missed that),
that's even better because we are no longer forcing the modification of
a parameter if it was not supposed to be done :)

I'm not a big fan of ignoring errors but as you said, we cannot return
all the different errors with the current API. Or we would need
something like:
  > ret = setsockopt(fd, SOL_MPTCP, MPTCP_SETSOCKOPT, {level=X, name=Y,
val=&Z, err=&E}, len);

But that's a different topic and a new API specific to MPTCP.

>>  	}
>>  	release_sock(sk);
>>  
>>  	return 0;
>>  }
>>  
>> -static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
>> -			       sockptr_t optval, unsigned int optlen)
>> -{
>> -	switch (optname) {
>> -	case IP_FREEBIND:
>> -	case IP_TRANSPARENT:
>> -		return mptcp_setsockopt_sol_ip_set_transparent(msk, optname, optval, optlen);
>> -	case IP_TOS:
>> -		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
>> -	}
>> -
>> -	return -EOPNOTSUPP;
>> -}
>> -
>>  static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int optname,
>>  					  sockptr_t optval, unsigned int optlen)
>>  {
>>  	struct sock *sk = (struct sock *)msk;
>>  	struct socket *sock;
>> +	struct sock *ssk;
>>  	int ret;
>>  
>> -	/* Limit to first subflow, before the connection establishment */
>> +	/* Limit to first subflow */
>>  	lock_sock(sk);
>> +	ssk = msk->first;
>> +	if (ssk) {
>> +		ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
>> +		goto unlock;
>> +	}
> 
> Why do you need the above chunk? This change the behavior of existing
> sockopt and possibly their return value in case of error?!?

I thought we could only call __mptcp_nmpc_socket() before the
establishment of the connection and I wanted to be able to call
setsockopt() on the first subflow even if it has been done after the
establishment of the connection. I'm maybe getting confused by the
modifications you did around __mptcp_nmpc_socket().

But now that I'm thinking about that, maybe it doesn't make sense what I
did: if we only want to act on the first subflow, it is certainly
because we want to do something before the establishment of the MPTCP
connection, no?

But then if the connection has been established before and if we return
before doing the call to tcp_setsockopt(), we might return a different
error with MPTCP than with TCP, no?

>> +
>>  	sock = __mptcp_nmpc_socket(msk);
>>  	if (IS_ERR(sock)) {
>>  		ret = PTR_ERR(sock);
>> @@ -801,6 +727,32 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
>>  	return ret;
>>  }
>>  
>> +static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
>> +			       sockptr_t optval, unsigned int optlen)
>> +{
>> +	switch (optname) {
>> +	case IP_FREEBIND:
>> +	case IP_TRANSPARENT:
>> +	case IP_TOS:
>> +		return mptcp_setsockopt_all_sf(msk, SOL_IP, optname, optval, optlen);
> 
> This changes the sockopt semantic a bit, applying the
> IP_FREEBIND/IP_TRANSPARENT to all the subflows, while before this
> change, only the MPC subflow was rightfull affected. Likely in practice
> there are no visible functional effect change, but it sounds confusing
> to me.

Good point. Indeed, if there is no first subflow created before the
establishment of the connection, we will now only set the transparent
and freebind bits on the MPTCP socket. They will be set when a new
subflow has been created in the "sync()" part (which is maybe fine?)

But we can call mptcp_setsockopt_first_sf_only() here if you prefer.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
