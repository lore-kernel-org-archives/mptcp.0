Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470F05BFBC
	for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka3a9IoW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A518C433C7;
	Mon, 18 Dec 2023 17:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702920567;
	bh=MrULqJ1eYmSehfuJmK0xxIz6RHm00YXpYN4YomO7GCA=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=ka3a9IoWNXZShT60HQz5BvyVe1i52YAPcQmPp+zT2dDza6G/LU71tgvuX8DAjnYDQ
	 zLbmBDUpHkbqm/2kq8SoRbGF56FNuqWOiZzTBcLnKRWXjYe8k7L2crvfvZ7wrGe9GL
	 3uxs0bbGhpkJtvbKJTBcYRZSM6c/cCj178IU9DsD4qHJwidv/IWI1aGS10i4Lrdwy/
	 ehsX4JdthUCdTlmYSJZg3uUxHy4dqOLllF+clmpNnjEkL+EXTqlRy9k4iTSKJQfq5e
	 9AWTanonl+rOPhd7A1D7pHw6RG8wiKGS8yP31LxyMmRArrfSOzU2PI02eRL1KMuU5Y
	 5u2e5Xk1l1Gsg==
Message-ID: <2a3ded63-0abe-4f9e-a4d2-8d9342b25467@kernel.org>
Date: Mon, 18 Dec 2023 18:29:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 2/5] mptcp: move inet_sk_state_store under lock
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>
References: <cover.1702889134.git.geliang.tang@linux.dev>
 <84b7f01dcee92c4c1ae00523baa5f98f0cb64671.1702889134.git.geliang.tang@linux.dev>
 <4c1e2e407e2b6721b4ca0aad73746c8ea13f2753.camel@redhat.com>
Cc: Geliang Tang <geliang.tang@linux.dev>, mptcp@lists.linux.dev
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <4c1e2e407e2b6721b4ca0aad73746c8ea13f2753.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 18/12/2023 17:54, Paolo Abeni wrote:
> On Mon, 2023-12-18 at 16:47 +0800, Geliang Tang wrote:
>> This patch moves inet_sk_state_store() under the socket lock in
>> mptcp_pm_nl_create_listen_socket(). This is a pre-req patch for
>> using mptcp_set_state() instead of inet_sk_state_store().
>>
>> Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
>> ---
>>  net/mptcp/pm_netlink.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index bf4d96f6f99a..0e6da322c8f2 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -1030,9 +1030,10 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
>>  
>>  	lock_sock(newsk);
>>  	ssk = __mptcp_nmpc_sk(mptcp_sk(newsk));
>> -	release_sock(newsk);
>> -	if (IS_ERR(ssk))
>> +	if (IS_ERR(ssk)) {
>> +		release_sock(newsk);
>>  		return PTR_ERR(ssk);
>> +	}
>>  
>>  	mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
>>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>> @@ -1045,10 +1046,14 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
>>  	else if (ssk->sk_family == AF_INET6)
>>  		err = inet6_bind_sk(ssk, (struct sockaddr *)&addr, addrlen);
>>  #endif
>> -	if (err)
>> +	if (err) {
>> +		release_sock(newsk);
>>  		return err;
>> +	}
>>  
>>  	inet_sk_state_store(newsk, TCP_LISTEN);
> 
> If you move 'inet_sk_state_store(newsk, TCP_LISTEN);' just before the
> '__mptcp_nmpc_sk()' call, the overall patch should be significantly
> smaller.

Thank you for having looked!

That's what I had in mind, but I was not sure if there would be an issue
in case of error (and I didn't check), etc.

But if there is no issue, best to move it there indeed!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
