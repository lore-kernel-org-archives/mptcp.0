Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5234519441
	for <mptcp@lists.linux.dev>; Tue, 10 Oct 2023 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4S/+Fo2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6E1C433C7;
	Tue, 10 Oct 2023 12:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696942150;
	bh=XBBfUW/SVpUppenEkZ/gYftoOYPvXJgJoeQwgghtOao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u4S/+Fo2oOPge7PaXND/JNDT3YdESnOBCspS+8mqVpv8W33MKhNCLzKuo43iyVkVc
	 JzTI92U6q+IRO2k3CFeSw6Ly41omZ3u8F+f9FJcXAFVr+/LffGxr035PcAwdAWqtZr
	 NIeQa9U66hN9A9TcW6wgk9fg6GTZ7roDZuHFHEu7FKW9nuhQWeNCOOLznuM7mHy6yR
	 ijXxKJPHnlp5OE0Y3/K5J9Ut5wpWnTslgVIua+RuX9Kzd5YYvFYx77FGHLmZ3sFi5P
	 aHQ6s//pU+2BwdBcqRafPSVHRjLrT9sIjwJloFXi/m5GbHLp+vEH8lc81BZJmEMOoW
	 uNtJddgkGiB6A==
Message-ID: <3158efd3-ba52-4b84-9d3a-4fea9ca3bc93@kernel.org>
Date: Tue, 10 Oct 2023 14:49:08 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v12 1/5] mptcp: avoid resetting when another
 subflow available
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1696831239.git.geliang.tang@suse.com>
 <2b69fa22510db02a12eb101c3e8173dda76f8133.1696831239.git.geliang.tang@suse.com>
 <76f31a37-16b4-4e3a-8b00-fdb2c1eabfb4@kernel.org>
 <20231010061320.GB6593@localhost.localdomain>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
In-Reply-To: <20231010061320.GB6593@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 10/10/2023 08:13, Geliang Tang wrote:
> On Mon, Oct 09, 2023 at 06:13:19PM +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 09/10/2023 08:02, Geliang Tang wrote:
>>> When closing the msk->first socket in __mptcp_close_ssk(), if there's
>>> another subflow available, it's better to avoid resetting it.
>>>
>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>> ---
>>>  net/mptcp/protocol.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 30e0c29ae0a4..6346a164ed66 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -2396,7 +2396,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>>>  		goto out_release;
>>>  	}
>>>  
>>> -	dispose_it = msk->free_first || ssk != msk->first;
>>> +	dispose_it = msk->free_first || ssk != msk->first || !list_is_singular(&msk->conn_list);
>>>  	if (dispose_it)
>>>  		list_del(&subflow->node);
>>>  
>>> @@ -2446,7 +2446,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>>>  
>>>  	sock_put(ssk);
>>>  
>>> -	if (ssk == msk->first)
>>> +	if (ssk == msk->first && list_is_singular(&msk->conn_list))
>>>  		WRITE_ONCE(msk->first, NULL);
>>
>> I don't think we should 'dispose it' nor set 'msk->first' to NULL but
> 
> That's what this patch dose. Dispose it, not set msk->first to NULL.

Sorry, I meant: we should not 'dispose it' and we should not set
'msk->first' to NULL if we are not closing the whole MPTCP connection.

>> instead, we should not call tcp_disconnect() directly: if the connection
> 
> But this patch lacks the code to handle:
> 
> 	ssk == msk->first && !list_is_singular(&msk->conn_list)
> 
> Is my understanding correct?
> 
> How about dropping list_is_singular() in the next block, something like:
> 
>          * For established sockets, allow an additional timeout before closing,
>          * as the protocol can still create more subflows.
>          */
> -       if (list_is_singular(&msk->conn_list) && msk->first &&
> -           inet_sk_state_load(msk->first) == TCP_CLOSE) {
> +       if (msk->first && inet_sk_state_load(msk->first) == TCP_CLOSE) {
>                 if (sk->sk_state != TCP_ESTABLISHED ||
>                     msk->in_accept_queue || sock_flag(sk, SOCK_DEAD)) {
>                         inet_sk_state_store(sk, TCP_CLOSE);

I cannot tell like that, but what is important first is not to call
'tcp_disconnect()' on a non already closed socket. So we need something
else before the 'disconnect()'.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
