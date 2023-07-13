Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B8F9D7
	for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 09:00:45 +0000 (UTC)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b703d7ed3aso6059451fa.1
        for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689238843; x=1691830843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZEpa7vBfvxZIPKRIlgvO6R4l6/9DSlxGWqgVYLKXJr4=;
        b=2bSjsZ9tb5KXOgjN21ULQqgT6tBxe+oGj/q61tFy5WDxvxRX6wa5j314pkoTGF/wxD
         8MveQPuSZ6vBOGuf8WP+GJ7KkihBeGfMjP4WV55dq3q5/E2Ts3kPzAI5CMgAophF183Z
         AN1AJ8aAHNejDTog7NIP0m3QQIZ4/A0LsjMy7LuRm7l7cJWkc/i7FVdZ47SkSr3sqsCG
         GK9C2nk3Ee6pA6c3RKg7PzJUNH/znK4NfAnkfkyiMjfC4DG0lBu1tTIYhimsMXs0P6VF
         EpcMjmlWhzHgmG3MJZfFMMYr0LjMziAlj69hd/prddTZgQpuea6xYIkBVHiVdKLhlx4b
         76Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689238843; x=1691830843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEpa7vBfvxZIPKRIlgvO6R4l6/9DSlxGWqgVYLKXJr4=;
        b=Gyrc+ULC6X3MRJ6QNKksI+G6ibE6d0LhgetMHrOJUubDHY0H064rWpzYykC8/3pYeo
         G05W1P+IHPmEtGxiftGKG33hMA4F030Unl8IH12C/QZjDHSSFkd6hB1aU/+AvGNpyHZh
         23er2mehWsdEBa9ZGPNi+zj1+7It88IoHYWnn8cQu2WQ+BXdgGctyhBYJfiD3DNN58DG
         n8H3kkkXBh4Buh1ZApFWPheu0OZ/J/CeX34ktYazjn5QFeH9XtWZQKjonaFlAi2AveqE
         R5TvVNW1n23Uyz0DUckqli1VjTO0cvKVDzvYNRhEM/jU9uN+UZebQQTvNBugKXvVILMa
         egIA==
X-Gm-Message-State: ABy/qLY16Pj5ZDbocYcBxdsSrPm6y+DtnN024ssdzPcFLaAb3J79Uq5g
	aolUrnXnuDiRdqPZ7YuChRZy7Q==
X-Google-Smtp-Source: APBJJlHtrqWDcqZbVRBpIkz+4lwGbjdFjoow/JShJoP3CRJEBR1L6ShWZa+FqWBxkPWTk0yv2COdIg==
X-Received: by 2002:a2e:7a0d:0:b0:2b6:fa3e:f2fa with SMTP id v13-20020a2e7a0d000000b002b6fa3ef2famr797631ljc.32.1689238843508;
        Thu, 13 Jul 2023 02:00:43 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c2e6:680:ced7:5e59? ([2a02:578:8593:1200:c2e6:680:ced7:5e59])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bc8d1000000b003fa968e9c27sm17757570wml.9.2023.07.13.02.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 02:00:43 -0700 (PDT)
Message-ID: <968e1118-6b2a-41fd-ce78-2f1cb7427840@tessares.net>
Date: Thu, 13 Jul 2023 11:00:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next 03/14] mptcp: avoid additional
 __inet_stream_connect() call
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <cover.1688993569.git.pabeni@redhat.com>
 <3f427fdc84212cde2d5ad09a46925a43a4a0fae7.1688993569.git.pabeni@redhat.com>
 <6f46d6b1-2aa9-e56f-f473-0300c08e2788@kernel.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <6f46d6b1-2aa9-e56f-f473-0300c08e2788@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo, Mat,

Thank you for the series and the reviews!

On 12/07/2023 23:49, Mat Martineau wrote:
> On Mon, 10 Jul 2023, Paolo Abeni wrote:
> 
>> The mptcp protocol maintains an additional socket just to easily
>> invoke a few stream operations on the first subflow. One of them is
>> __inet_stream_connect().

(...)

>> @@ -3653,21 +3655,37 @@ static int mptcp_connect(struct sock *sk,
>> struct sockaddr *uaddr, int addr_len)
>>     /* if reaching here via the fastopen/sendmsg path, the caller already
>>      * acquired the subflow socket lock, too.
>>      */
>> -    if (msk->fastopening)
>> -        err = __inet_stream_connect(ssock, uaddr, addr_len,
>> O_NONBLOCK, 1);
>> -    else
>> -        err = inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK);
>> -    inet_sk(sk)->defer_connect = inet_sk(ssock->sk)->defer_connect;
>> +    if (!msk->fastopening)
>> +        lock_sock(ssk);
>> +
>> +    if (ssk->sk_state != TCP_CLOSE)
>> +        goto out;
>> +
>> +    if (BPF_CGROUP_PRE_CONNECT_ENABLED(ssk)) {
>> +        err = ssk->sk_prot->pre_connect(ssk, uaddr, addr_len);
>> +        if (err)
>> +            goto out;
>> +    }
>> +
>> +    err = ssk->sk_prot->connect(ssk, uaddr, addr_len);
>> +    if (err < 0)
>> +        goto out;
>> +
>> +    inet_sk(sk)->defer_connect = inet_sk(ssk)->defer_connect;
> 
> The above code doesn't do everything __inet_stream_connect() does. Is
> that code omitted here because the caller of this function handles the
> timeouts and msk-level socket states already?

Is it not possible to extract the code we need from
__inet_stream_connect() to a new function in af_inet.c? Then we can call
this new function from __inet_stream_connect() and here.

I'm always a bit worry when we duplicate code from upper layers because
we could miss future modifications done in the original code (we had
that a few times with the fork and it is hard to track and maintain). I
would say that the minimum is at least to add a comment stating this
code is a duplication from somewhere else, just in case to make it clear
where we need to look at in case of issues there.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
