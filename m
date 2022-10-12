Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023E117CB
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 10:18:04 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id q9so32449748ejd.0
        for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 03:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l4wme6iV6mR3qOXodkht+T8lJu+N7cP90xkVt8WxygA=;
        b=wKUAy6asOEYG9Dsl+MRCfXlNWpPqq7KExebtlQZSEeoJdSj0ldnAyfK3EUk1cAH110
         tbg9ebD18iKFAVD6HRlkE8uepEFEKPrZuYMlUlp0FNOedld6FaAEvZ9QOjYceaFzBiYg
         brbhxt8XXHn5ACrQxrR02K3F+rTi+W7clcjm9sc73PBLmOoaYMGUrfuPbHhx8vIJjC0s
         /Qv6NuoqpREljs0oTaTjEvvUwPW4WFnzvpdnJUUhfUH+RiosZ4u5QAIaXBWZTBfr7LWM
         oepeYiKhRcgfHmH1vqZLGQRdD5maCIZC4lksqj5OXpqq5nHaUU7VVAiwt35zBLC5k4Ij
         CozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4wme6iV6mR3qOXodkht+T8lJu+N7cP90xkVt8WxygA=;
        b=t7ww4D9WOUEvUBp78KikbL0fSTFaj4hY5uD8FzfIguYhU6IY+swufNUaQaFhvkRFPC
         gwjHWq0ck7gSmhbGmy8rGJiEg05YPAJczOsgRIDmJOoOwvp+E3OAclpDCvQA5hkUnMPn
         M6m7qfkb+3VAOVMQu/5Wp2nP9TQa7nqfHzM+RRMRTTDbk4dplX4/erOvArU7boeKuq0U
         XGwz8J+YsBmZiyf1EYEidEHqzsUxKjtoLfA2YgfnSa5dKp/YN8p5fp0H6nXDwcgRDu1H
         LVtx6GDfMFMl3SCuIM4ruu+e/j+9SaOEUL1/z4/YWV805vn5s00f+z5E/Pe57BIKe6jb
         oRBA==
X-Gm-Message-State: ACrzQf3htCrI3oAaH6RU7fMDC+pqawQL+KP6F8Slwuvmz+h0t+TVx8LS
	ANzlI5tcagvtFeWGbUpPCJYJ18ed/Pp2Cg==
X-Google-Smtp-Source: AMsMyM6ma9RlhT0EdcZEH6c0MaapVTq4ddr4bdb6UZ692zqQntHDo8O5xojBghNw2YE4vZwlF9/KEA==
X-Received: by 2002:a17:907:1dc7:b0:78d:c153:d64a with SMTP id og7-20020a1709071dc700b0078dc153d64amr9612361ejc.429.1665569882940;
        Wed, 12 Oct 2022 03:18:02 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f07e:bd7a:c3d9:59e6? ([2a02:578:8593:1200:f07e:bd7a:c3d9:59e6])
        by smtp.gmail.com with ESMTPSA id la5-20020a170907780500b0073dd7e586f9sm977754ejc.193.2022.10.12.03.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 03:18:02 -0700 (PDT)
Message-ID: <256494fa-c7b1-f631-133a-8d29f29a325d@tessares.net>
Date: Wed, 12 Oct 2022 12:18:01 +0200
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
 <cda1ff18-db08-712c-fecf-82a613809ff0@tessares.net>
 <75fbbda1c891d1471cfc0ab47bd169a7b4e77b02.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <75fbbda1c891d1471cfc0ab47bd169a7b4e77b02.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/10/2022 12:06, Paolo Abeni wrote:
> On Wed, 2022-10-12 at 11:38 +0200, Matthieu Baerts wrote:
>> On 12/10/2022 11:10, Paolo Abeni wrote:
>>> On Wed, 2022-10-12 at 10:22 +0200, Matthieu Baerts wrote:
>>>> On 11/10/2022 19:40, Paolo Abeni wrote:

(...)

>>>>> @@ -1692,24 +1717,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>>>>>  	lock_sock(sk);
>>>>>  
>>>>>  	ssock = __mptcp_nmpc_socket(msk);
>>>>> -	if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect)) {
>>>>> -		struct sock *ssk = ssock->sk;
>>>>> +	if (unlikely(ssock && (inet_sk(ssock->sk)->defer_connect ||
>>>>> +			       msg->msg_flags & MSG_FASTOPEN))) {
>>>>
>>>> Just above in this mptcp_sendmsg() function, we mention we don't support
>>>> MSG_FASTOPEN yet. maybe we don't need to add this additional check now?
>>>
>>> Thanks for catching it. This is a stray change from a previous
>>> revision.
>>>
>>>
>>> I can send a v2 addressing the above and cleaning up comments, but
>>> AFAICS there is still pending the main question about including "mptcp:
>>> factor out mptcp_connect()" in -net. Currently I think that could be
>>> the better option.
>>
>> It is fine for me to have the refactoring ("mptcp: factor out
>> mptcp_connect()") sent to net. I can move it.
>>
>> Do you think we need to modify the commit message? e.g. "Note that the
>> fastopen call-path invokes mptcp_connect()" → only with MSG_FASTOPEN,
>> not in -net.
> 
> I think "mptcp: factor out mptcp_connect()" will require quite a bit of
> mangling to be move to -net, I'll send a -net version  together with v3
> of this patch.

Do you mean that we need to modify it not to do some actions in -net?
Because for the moment, -net and net-next are similar, it should be easy
to switch from net-next to -net, no?

But yes, please send them together with v3, that will ease the validation :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
