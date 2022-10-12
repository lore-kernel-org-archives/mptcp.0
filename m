Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A4817CB
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 09:38:43 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id l22so23667315edj.5
        for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 02:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JkWNe4Xt2GJmbHQAqUdhW/xAnUTczyJbuF4AO1I5/YA=;
        b=qiHoEGhHGNVw472QEnWHJ5nZSMifubzlJCVxkImZRUBu+wUa17vBWcBJTqcmlL7F8K
         Y932MIAtsy/6+B0IyWc85is7vNfct2u4z4i2rxuC3m/JyptRdT2Lps2uKd8g0hMs0Fl7
         ppAcZtQWojf2eS5zHpYfwpHc6DDqBaR0xGtQNJJqUfRKxh/qDhXr7LFYVq/f73aoiPJc
         gkR7Z8PmTxFCwUEyMi0JdCKL+pRZMF71WZTgMbcYATrU3mwyHjjvf8pY39CFY0Zo116Q
         psHtLIQrgjA60nL6stHkfXweTE8ugRDgxbZvByc5rNA0Zdfg+Ac51JgZ8Vh7lCrzM8gX
         +i7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JkWNe4Xt2GJmbHQAqUdhW/xAnUTczyJbuF4AO1I5/YA=;
        b=BAtgDYE+dBgjnTTS0zV7AnOltrYYKoyVG9qe+cMu/reZuuba6j3kWWGxkvaoAtffGA
         D+G7dy6N2TmnRCvL4uYiRetNb3d1aUw1Ghk8uPfwCB6bO6Du+XD/NofiRAyBDnsh4RLA
         4vRMwHCce5MNU/IaP6yPThwAo7rpcxYrAQZakYaKOmtCwhHMBqM4DuyiSR6duaKx2OhW
         rYI+S2aw7lNq+zzjFMZurZoCBfoxN/twgOdIKRLJcitOsXybreIUuEAvaU/3s86kA//9
         zVmRWlKyuEATw1+wrgNYI8WOuCsZCRTbW2lbOegRHhN0TiswT6GUCKpuW0roHFZFysOe
         PGtQ==
X-Gm-Message-State: ACrzQf2/VdWPaJz0fk08NYMf3oVaI7lTBpyytOoCwtnj5CN75LJFAZvR
	mqoUbcY+GUqXx7+FksjONXvI6ytgLeooYQ==
X-Google-Smtp-Source: AMsMyM6s3m8j7tXamYZP+Tjv/i3xyNcUUtHggGR56j8rncDkqzmPQBAxu2mGaueEhO7TO6/nKkt1jQ==
X-Received: by 2002:a05:6402:448c:b0:457:52eb:b57e with SMTP id er12-20020a056402448c00b0045752ebb57emr26750018edb.178.1665567522195;
        Wed, 12 Oct 2022 02:38:42 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f07e:bd7a:c3d9:59e6? ([2a02:578:8593:1200:f07e:bd7a:c3d9:59e6])
        by smtp.gmail.com with ESMTPSA id cy3-20020a0564021c8300b00458cc5f802asm10830456edb.73.2022.10.12.02.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 02:38:41 -0700 (PDT)
Message-ID: <cda1ff18-db08-712c-fecf-82a613809ff0@tessares.net>
Date: Wed, 12 Oct 2022 11:38:40 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-net v2] mptcp: fix abba deadlock on fastopen
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <c23778554e349d0a85a34aba14affdac9f5164c5.1665510026.git.pabeni@redhat.com>
 <bbd50fc8-150c-84db-5287-71911a91e9c7@tessares.net>
 <0c51594362f1e64b9b2a45d10536051abf1e0470.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <0c51594362f1e64b9b2a45d10536051abf1e0470.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/10/2022 11:10, Paolo Abeni wrote:
> On Wed, 2022-10-12 at 10:22 +0200, Matthieu Baerts wrote:
>> Thank you for having caught the issue and already provided the patch!
>>
>> On 11/10/2022 19:40, Paolo Abeni wrote:
>>> Our CI reported lockdep splat in the fastopen code:
>>
>> (...)
>>
>>> commit ("mptcp: factor out mptcp_connect()") will need some
>>> mangling on top of this one.
>>>
>>> A possible alternative would be targeting even the above to -net.
>>>
>>> Not strictly required, but it will also make more striaght-forward/
>>> legit the __inet_stream_connect() invocation here.
>>
>> Indeed, we can. We would need more work around that anyway, no? (see my
>> comment below)
>>
>>> ---
>>>  net/mptcp/protocol.c | 43 ++++++++++++++++++++++++++++++-------------
>>>  1 file changed, 30 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index f599ad44ed24..21f5676a60e8 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -1673,6 +1673,31 @@ static void mptcp_set_nospace(struct sock *sk)
>>>  	set_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags);
>>>  }
>>>  
>>> +static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msghdr *msg,
>>> +				  size_t len, int *copied_syn)
>>> +{
>>> +	unsigned int saved_flags = msg->msg_flags;
>>> +	int ret;
>>> +
>>> +	lock_sock(ssk);
>>> +	msg->msg_flags |= MSG_DONTWAIT;
>>> +	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
>>
>> Would it not be cleaner (and easier to maintain?) if a new parameter is
>> added to tcp_sendmsg_fastopen() to force passing the O_NONBLOCK flag to
>> __inet_stream_connect? Not to modify msg->msg_flags to have the
>> behaviour we want.
> 
> Uhmmm... cleaner only for this call-site. It could be confusing adding
> another parameter for blocking where there is already msg_flags for
> that. And I'm personally against adding to many arguments to a single
> function...

OK.
I was suggesting that because tcp_sendmsg_fastopen() is only called once.
I guess tcp_sendmsg_fastopen() will not be modified in a way that will
break MPTCP support because we force MSG_DONTWAIT, so fine for me.

>>> +	msg->msg_flags = saved_flags;
>>> +	release_sock(ssk);
>>> +
>>> +	/* do the blocking bits of inet_stream_connect outside the ssk socket lock*/
>>
>> (I thought checkpatch.pl was complaining when there was no space before
>> '*/' but it doesn't, all good :) )
>>
>>> +	if (ret == -EINPROGRESS && !(msg->msg_flags & MSG_DONTWAIT)) {
>>> +		ret = __inet_stream_connect(sk->sk_socket, msg->msg_name,
>>> +					    msg->msg_namelen, msg->msg_flags, 1);
>>
>> Without the commit ("mptcp: factor out mptcp_connect()"), would we need
>> to call the -net version of mptcp_stream_connect() but without the lock?
> 
> Not strictly needed. I test this patch on export/net. Possibly cleaner.

OK, thank you!

>>> +
>>> +		/* On connect hard error fastopen no bytes actually sent. */
>>> +		if (ret && ret != -EINPROGRESS && ret != -ERESTARTSYS && ret != -EINTR)
>>
>> The two last ones are there in case the "actual connect()" got
>> interrupted, right?
> 
> Yes. Plain TCP consider copied_syn == 0 in that case. I did not find
> any existing helper to match such condition. Perhapas a longer comment
> may help.

Thank you for the explanation.
Yes, maybe a longer comment but only if you have to send a v3.

>>> +			*copied_syn = 0;
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>  static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>>>  {
>>>  	struct mptcp_sock *msk = mptcp_sk(sk);
>>> @@ -1692,24 +1717,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>>>  	lock_sock(sk);
>>>  
>>>  	ssock = __mptcp_nmpc_socket(msk);
>>> -	if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect)) {
>>> -		struct sock *ssk = ssock->sk;
>>> +	if (unlikely(ssock && (inet_sk(ssock->sk)->defer_connect ||
>>> +			       msg->msg_flags & MSG_FASTOPEN))) {
>>
>> Just above in this mptcp_sendmsg() function, we mention we don't support
>> MSG_FASTOPEN yet. maybe we don't need to add this additional check now?
> 
> Thanks for catching it. This is a stray change from a previous
> revision.
> 
> 
> I can send a v2 addressing the above and cleaning up comments, but
> AFAICS there is still pending the main question about including "mptcp:
> factor out mptcp_connect()" in -net. Currently I think that could be
> the better option.

It is fine for me to have the refactoring ("mptcp: factor out
mptcp_connect()") sent to net. I can move it.

Do you think we need to modify the commit message? e.g. "Note that the
fastopen call-path invokes mptcp_connect()" → only with MSG_FASTOPEN,
not in -net.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
