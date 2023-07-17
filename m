Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F4DBA24
	for <mptcp@lists.linux.dev>; Mon, 17 Jul 2023 13:47:19 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3fbf1b82de7so27912525e9.1
        for <mptcp@lists.linux.dev>; Mon, 17 Jul 2023 06:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689601637; x=1692193637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pk6zCCzPkzKMexYp+rv99iNvzmyUD2vrvAZ/n1uRCVQ=;
        b=oTANnLQTsqFhiYkMO4z2TD8lFQym3840CvyZE7X+2M63Xz2tgFWXAIAExQnQaqmnnt
         rHT5Som0H7PDoqYA7klJwZcBsvWrSEZUof2cXao/8C9WUATwvDBieu0A0xdGdRMEta4O
         oWKCb5+cxi1EeYjb0bMMylRi5TedhBbRRwHkfgXvAdivOUSOA9PzXdlJ9wmOm/zF03ay
         Aul6yaCBvnda/xTsKr0GTMw2SJdZb5pUU6jG64iBS9InDRBDF1b5ktiwXkCiHh43+ls0
         XzaKnxzipKPQQkPMotSeRfeFiXyjdQYVR8xVJRL/SykqajEO9FQUhi90X5Jb/6PYHDYN
         1LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689601637; x=1692193637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pk6zCCzPkzKMexYp+rv99iNvzmyUD2vrvAZ/n1uRCVQ=;
        b=ROM5WSBV1JlJCldIJu+jv3N8TounB7c2SkUaqJIE2TKdPCKcNLgNGVddhjVgtZMhSR
         S42NXK9KqQbWEQDV/rI5FWMtAE9Wmwue3f80/b1ZAC48wqAWHor6oRHpFxTiHpxfYuT7
         3yA/+qDAMaqyZ3ujQZoPvFdNqw3YmwMYjCQSEVYuuEDqmRZG4ImgVPzFCJflL5K5wJwq
         ySxaTjfaf8R7O8RuJBzo7yKdRbIjYwmwE9zppf1sf8zjhLub8nJJq454vTW/H+s55xUP
         zvPxr4NJx3XIwDE9M0Oc6sdaTi/v0ZVUuSmEM8iIJjtVfbMXC2JTw9eOnhMU+JKgsipA
         YFnQ==
X-Gm-Message-State: ABy/qLZTfEQRd2jADNulBw6ArK4KmhqE9VdmIbFBdom3zwpwFitTV41t
	wMB3vLJ+ltuv+HZxQmvi85HhH8CFZnMflzVCyi/DJg==
X-Google-Smtp-Source: APBJJlEHhpnulRqggB7yuutLWKe+1gfIRhGNGuBs/ELLytc4WDYC000mtTnrmqdRXSzz1RjmaxdnSA==
X-Received: by 2002:a05:600c:1d18:b0:3fa:94ea:583c with SMTP id l24-20020a05600c1d1800b003fa94ea583cmr8604400wms.8.1689601637542;
        Mon, 17 Jul 2023 06:47:17 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4482000000b003143867d2ebsm19279205wrq.63.2023.07.17.06.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 06:47:17 -0700 (PDT)
Message-ID: <c7a8c5bc-04ae-bb1d-9e60-7bc589cf7e59@tessares.net>
Date: Mon, 17 Jul 2023 15:47:16 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH mptcp-next 03/14] mptcp: avoid additional
 __inet_stream_connect() call
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1688993569.git.pabeni@redhat.com>
 <3f427fdc84212cde2d5ad09a46925a43a4a0fae7.1688993569.git.pabeni@redhat.com>
 <6f46d6b1-2aa9-e56f-f473-0300c08e2788@kernel.org>
 <968e1118-6b2a-41fd-ce78-2f1cb7427840@tessares.net>
 <e34d61ba3b9197eba4b7cd63e413f6f03b40aa79.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <e34d61ba3b9197eba4b7cd63e413f6f03b40aa79.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 14/07/2023 10:38, Paolo Abeni wrote:
> On Thu, 2023-07-13 at 11:00 +0200, Matthieu Baerts wrote:
>> Hi Paolo, Mat,
>>
>> Thank you for the series and the reviews!
>>
>> On 12/07/2023 23:49, Mat Martineau wrote:
>>> On Mon, 10 Jul 2023, Paolo Abeni wrote:
>>>
>>>> The mptcp protocol maintains an additional socket just to easily
>>>> invoke a few stream operations on the first subflow. One of them is
>>>> __inet_stream_connect().
>>
>> (...)
>>
>>>> @@ -3653,21 +3655,37 @@ static int mptcp_connect(struct sock *sk,
>>>> struct sockaddr *uaddr, int addr_len)
>>>>     /* if reaching here via the fastopen/sendmsg path, the caller already
>>>>      * acquired the subflow socket lock, too.
>>>>      */
>>>> -    if (msk->fastopening)
>>>> -        err = __inet_stream_connect(ssock, uaddr, addr_len,
>>>> O_NONBLOCK, 1);
>>>> -    else
>>>> -        err = inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK);
>>>> -    inet_sk(sk)->defer_connect = inet_sk(ssock->sk)->defer_connect;
>>>> +    if (!msk->fastopening)
>>>> +        lock_sock(ssk);
>>>> +
>>>> +    if (ssk->sk_state != TCP_CLOSE)
>>>> +        goto out;
>>>> +
>>>> +    if (BPF_CGROUP_PRE_CONNECT_ENABLED(ssk)) {
>>>> +        err = ssk->sk_prot->pre_connect(ssk, uaddr, addr_len);
>>>> +        if (err)
>>>> +            goto out;
>>>> +    }
>>>> +
>>>> +    err = ssk->sk_prot->connect(ssk, uaddr, addr_len);
>>>> +    if (err < 0)
>>>> +        goto out;
>>>> +
>>>> +    inet_sk(sk)->defer_connect = inet_sk(ssk)->defer_connect;
>>>
>>> The above code doesn't do everything __inet_stream_connect() does. Is
>>> that code omitted here because the caller of this function handles the
>>> timeouts and msk-level socket states already?
>>
>> Is it not possible to extract the code we need from
>> __inet_stream_connect() to a new function in af_inet.c? Then we can call
>> this new function from __inet_stream_connect() and here.
>>
>> I'm always a bit worry when we duplicate code from upper layers because
>> we could miss future modifications done in the original code (we had
>> that a few times with the fork and it is hard to track and maintain).
> 
> Well, that kind of problems becomes order of magnitude worse with out-
> of-tree code, because nobody is aware nor interested of such code
> needs.
> 
> Chances of issues here are really low:
> * mptcp code is in tree 
> * maintainers are aware ;)
> * bpf hooks should not change
> * [most important topic] the dup code is extremely simple and small
> 
> All in all, it looks reasonably safe to me.

Thank you for the explanations!

If you think this is safe for you, that's fine for me :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
