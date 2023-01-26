Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BB246A7
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 18:19:13 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso3774416wmn.5
        for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 10:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=En7BHDGyaCPA4SMSYvVbZVnvbuFqoHkPNjmd3Ui5juw=;
        b=lm279Yf1TcnwH0Uh6JKAKZ8B+B5wsq19M9qygyiY/BrpziuALiOEOQOlzvM1XNddXK
         /5im5IDzgZVjb8C8nZ0u6ZZ/YquGDmk4jFbHileHHIKwKh+OgnCAWqWDS8vEkI0SM1kV
         92A6bMncZHDjyhtimz5o0V4tBgF/hZcsb4HhwPnV8RnSKq9vo2OJ1Om7mVHHMTBEETIH
         MBZx2qgtsCiYa70BYiFtbvwNZWqGDFMKm1zSXPo6lAwdgRguwOL2yxcuu6FpZi348BjD
         N+AxuYWPpKQ5EWlRkqiKUs9wxuyT/s6x/lDHcKJJnjFhgF64dL/vFVB84dBmDhqQvWU+
         MkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=En7BHDGyaCPA4SMSYvVbZVnvbuFqoHkPNjmd3Ui5juw=;
        b=kocYt8APT1/LcNVhjfw/J3U7LV82yaRSxIzX4AvhgqL6CPP9+mZG+XLiPTpSCxkYCf
         X6ZYke7c5cHiGs3GFEzGSW6a0VnowOBGd96nY0twIVIgbQk4Q8owFi+/2osaJD1CCqnq
         IwsxYEdjQLGq/DNY1wtlN5TY7JorGzzn2xCD1+pVCtEMA7xzNOLzwwboUytked8Jt041
         HoK/Yp5p/Q4byKrBwzzjPixyxn6P4HAKcAeNyn5jDe0057kkFZmEXPkTOtc2CBhzktfd
         KRAB1pUbMwALzmC0dbNdc0oUJoQJHY2pi57hIImds7H59msIBv8WJY5R9h3PVg95+XJj
         XriA==
X-Gm-Message-State: AFqh2krqS15CmxcgkwmCr5p80rTPeXIW/cj8mWe0AK1vNMXquSys6aFk
	Vwfw2zo0avh0ZppTjK1o2IJGXCtznISuCVgB/L4=
X-Google-Smtp-Source: AMrXdXv6cdU6J9EQrPay+k24Cnxmss+DM1wubZAZfvucOXFRLhCQBeJxZS9TQpXahPURaFZx8SkIkA==
X-Received: by 2002:a05:600c:35c1:b0:3db:1424:e781 with SMTP id r1-20020a05600c35c100b003db1424e781mr31094199wmq.23.1674757151741;
        Thu, 26 Jan 2023 10:19:11 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:9734:4fc3:798b:7157? ([2a02:578:8593:1200:9734:4fc3:798b:7157])
        by smtp.gmail.com with ESMTPSA id a18-20020a05600c069200b003db305bece4sm2029296wmn.45.2023.01.26.10.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 10:19:11 -0800 (PST)
Message-ID: <ba768f87-7dc6-912f-1498-ae521828d87f@tessares.net>
Date: Thu, 26 Jan 2023 19:19:10 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH mptcp-next v2 08/13] mptcp: move first subflow allocation
 at mpc access time
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1673940640.git.pabeni@redhat.com>
 <badc4b131ab094bb806971a019807538abd6ccd5.1673940640.git.pabeni@redhat.com>
 <09a5cdbf-de41-ea88-6f93-f09709c09631@tessares.net>
 <fd340c53e129664b4041e2370dbcf07e4bfa8ce7.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <fd340c53e129664b4041e2370dbcf07e4bfa8ce7.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

Thank you for your reply!

On 26/01/2023 18:49, Paolo Abeni wrote:
> On Tue, 2023-01-24 at 17:31 +0100, Matthieu Baerts wrote:
>> On 17/01/2023 08:36, Paolo Abeni wrote:
>>
>>> @@ -116,6 +104,31 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
>>>  	return 0;
>>>  }
>>>  
>>> +/* Returns the first subflow socket if available and the MPC
>>> + * handshake is not started yet.
>>> + */
>>> +struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk)
>>> +{
>>> +	struct sock *sk = (struct sock *)msk;
>>> +	int ret;
>>> +
>>> +	if (!((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)))
>>> +		return ERR_PTR(-EINVAL);
>>> +
>>> +	if (!msk->subflow) {
>>> +		if (msk->first)
>>> +			return ERR_PTR(-EINVAL);
>>> +
>>> +		ret = __mptcp_socket_create(msk);
>>> +		if (ret)
>>> +			return ERR_PTR(ret);
>>> +
>>> +		mptcp_sockopt_sync(msk, msk->first);
>>
>> Do you think the function should be renamed? Maybe not but it looks
>> strange to me to create the socket and do the sync here with this name.
>> Maybe it is just me but with this name, I would expect it just to
>> returns the first subflow or NULL, but not create a socket if not, no?
>>
>> Mainly to make it clear a "[gs]etsockopt()" before the MPC will create a
>> new socket.
> 
> I don't have a good alternative name handy. You have good suggestions,
> they are more then welcome!

Indeed, not easy to find an alternative.

  __mptcp_initial_or_new_sf_socket_before_estab()

might be too long :þ

(but quite explicit :) )

> IMHO the function name is not bad: it does not imply allocation, nor
> lack of such thing.

You are right. If there is no better names, we can keep it like that.

If you want, I can add this line in the comment when applying the patch
(if there is no v3):

  Be careful that a new socket might be created if needed.

>>> @@ -1708,8 +1722,11 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>>>  	 * Since the defer_connect flag is cleared after the first succsful
>>>  	 * fastopen attempt, no need to check for additional subflow status.
>>>  	 */
>>> -	if (msg->msg_flags & MSG_FASTOPEN && !__mptcp_nmpc_socket(msk))
>>> -		return -EINVAL;
>>> +	if (msg->msg_flags & MSG_FASTOPEN) {
>>> +		ssock = __mptcp_nmpc_socket(msk);
>>> +		if (IS_ERR(ssock))
>>> +			return PTR_ERR(ssock);> +	}
>>
>> Here 'ssock' could be declared in this 'if' section: I guess it doesn't
>> really matter but out of curiosity, what's the code style to apply here?
>> Fine where it is or moved only where needed?
> 
> AFAIK there is no strict codying style rule (even if the preference
> should go for the smaller scope). I opted for this way just to reduce
> the number of added line - otherwise an additional empty line would
> have been mandatory.

Thank you for the explanation. OK to keep it like that!

>>> @@ -762,13 +762,15 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
>>>  {
>>>  	struct sock *sk = (struct sock *)msk;
>>>  	struct socket *sock;
>>> -	int ret = -EINVAL;
>>> +	int ret;
>>>  
>>>  	/* Limit to first subflow, before the connection establishment */
>>>  	lock_sock(sk);
>>>  	sock = __mptcp_nmpc_socket(msk);
>>> -	if (!sock)
>>> +	if (IS_ERR(sock)) {
>>> +		ret = PTR_ERR(sock);
>>>  		goto unlock;
>>> +	}
>>
>> Just to be sure: here and above the error with __mptcp_nmpc_socket()
>> should not happen most of the time: only when we reach some limits, e.g.
>> mem, etc., right?
>>
>> So it is fine to potentially return a different error than before (and
>> potentially different than what TCP what doing), is it correct?
> 
> Well the situation is a bit fuzzy. __mptcp_nmpc_socket() can now return
> an additional error code (ENOMEM) compared to the code prior to this
> patch. But plain tcp could already return such error for
> TCP_FASTOPEN_KEY. For the other sockopt addressed with
> mptcp_setsockopt_first_sf_only(), that will introduce a new possible
> error code. I think that is fine, the user-space application must not
> restrict the set of accepted error code for a given syscall.

OK so additional error codes should then be rare. Then it is fine. If
they get the ENOMEM now, they would have got it later. If they ignore
it, that's fine. If they consider it as a big issue resulting on not
doing the connect/bind/listen, that's fine as well.

Thank you for having looked!

>>>  	ret = tcp_setsockopt(sock->sk, level, optname, optval, optlen);
>>>  
>>> @@ -872,7 +874,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
>>>  	}
>>>  
>>>  	ssock = __mptcp_nmpc_socket(msk);
>>> -	if (!ssock)
>>> +	if (IS_ERR(ssock))
>>>  		goto out;
>>>  
>>>  	ret = tcp_getsockopt(ssock->sk, level, optname, optval, optlen);
>>
>> Why here you don't assign the error that is returned? (Maybe a comment
>> should be added?)
> 
> I guess it felt strange returning ENOMEM for a get operation. I can
> switch to full error reporting if you prefer.

Indeed, you are right.

Do you mind if I add this when applying the patch (if there is no v3):

  /* don't return err linked to the socket creation for a getsockopt */

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
