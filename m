Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1CC1E528
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 13:18:15 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-99bf9252eddso141279766b.3
        for <mptcp@lists.linux.dev>; Thu, 03 Aug 2023 06:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691068693; x=1691673493;
        h=content-transfer-encoding:in-reply-to:cc:autocrypt:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QTVkLA8BwRDThB98mYfjfLd3G4ZmZuPE/VhrdIyYwzI=;
        b=4/thlVMZ2JcOcTOOo/ROrsefJkweD6zhjT/67sqL0LN4gHl1gyS1hRKNGM0EZZzNSL
         q9loXVLAtUmoYkPDyFyzu4rMJHe+rQ/kMQI0vDK2ysKzKot//ILXluF6s7TGJ4ITJqWX
         sQuGNh9yDnugCZONGVwsUeQWZMV9HKWrk68p11XOaPng9OgC8aH6FO4fhuvDoij/APtJ
         ojfztFcL/Y/jljcNSHEqOD0V2zcGImYlQpZuWjxOFc8GPQx2U2IVZl3CSYrXcvGOsb8M
         nOExrWOB064Bzcbup3Ky0dFpu6OqqvT5i9+s0wXCX8dI5j1XSxpGh5OXVk0zcXT7OGd9
         cMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691068693; x=1691673493;
        h=content-transfer-encoding:in-reply-to:cc:autocrypt:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTVkLA8BwRDThB98mYfjfLd3G4ZmZuPE/VhrdIyYwzI=;
        b=I3PKFFyJbVxM7QH+IaIeFs2l0yY/sIheGp/aPohKPyW1jDt551ebbFWKS9DKTXGKgj
         2OHwMwHtAOfJvN7gFkM05RWbgYcwoj1vyGJW0tE19sa1ud12I9+aCk/8PZo//9SF9IOU
         jFiZtGQM3r2onTpQXDMa7UQ3LILLEJepeZSZixdiOx6BZAOOMVFCVvDPFrrTqtQeUDDZ
         rq7HXXrpCXwZ7w4tZMnl6o7QnIFJKvGHR/0lFunOK2xMQhi5W0jLCv2G64CrU/ofjVjA
         5kL00aeRvH7sHuDjIeFWSEUWs7JSzGh8s4Y7+EZV24JNhpcOI8RC7xSDGIlQUMzLSZ2t
         Q2LQ==
X-Gm-Message-State: ABy/qLYiR4TtVrDtjiKAcSrb/8lJBRyMaxzAU0z9ep1wM8bdUoT/tcDi
	gfPpskGaq48OgH4ghHGHEdB1JVxbaNqZrR3MbxU=
X-Google-Smtp-Source: APBJJlEIVK3Rg5DOo4UZ+iChL8SrAPNwsmjR9xSoZj4MfJeM0SDYeyuJN8q2drlRhEZeZCnWj7+tBQ==
X-Received: by 2002:a17:906:2002:b0:98e:933:2909 with SMTP id 2-20020a170906200200b0098e09332909mr7365436ejo.22.1691068693381;
        Thu, 03 Aug 2023 06:18:13 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ace8:eb44:12a0:888? ([2a02:578:8593:1200:ace8:eb44:12a0:888])
        by smtp.gmail.com with ESMTPSA id u7-20020a170906408700b009786ae9ed50sm10408017ejj.194.2023.08.03.06.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 06:18:12 -0700 (PDT)
Message-ID: <4eec4a85-c055-473f-918d-754c0ae21b45@tessares.net>
Date: Thu, 3 Aug 2023 15:18:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 1/4] bpf: Add update_socket_protocol hook
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
References: <cover.1691047403.git.geliang.tang@suse.com>
 <120b307aacd1791fac016d33e112069ffb7db21a.1691047403.git.geliang.tang@suse.com>
 <ZMujUofDnb8wMb36@kernel.org> <20230803130540.GA2792@bogon>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
In-Reply-To: <20230803130540.GA2792@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

(only with MPTCP list because there are too many people involved and
that's just a detail)

On 03/08/2023 15:05, Geliang Tang wrote:
> On Thu, Aug 03, 2023 at 02:53:38PM +0200, Simon Horman wrote:
>> On Thu, Aug 03, 2023 at 03:30:39PM +0800, Geliang Tang wrote:
>>> Add a hook named update_socket_protocol in __sys_socket(), for bpf
>>> progs to attach to and update socket protocol. One user case is to
>>> force legacy TCP apps to create and use MPTCP sockets instead of
>>> TCP ones.
>>>
>>> Define a mod_ret set named bpf_mptcp_fmodret_ids, add the hook
>>> update_socket_protocol into this set, and register it in
>>> bpf_mptcp_kfunc_init().
>>>
>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>
>> ...
>>
>>> diff --git a/net/socket.c b/net/socket.c
>>> index 2b0e54b2405c..586a437d7a5e 100644
>>> --- a/net/socket.c
>>> +++ b/net/socket.c
>>> @@ -1644,11 +1644,36 @@ struct file *__sys_socket_file(int family, int type, int protocol)
>>>  	return sock_alloc_file(sock, flags, NULL);
>>>  }
>>>  
>>> +/**
>>
>> Hi Geliang Tang,
>>
>> nit: The format of the text below is not in kernel doc format,
>>      so it is probably better if the comment begins with '/*'
>>      rather than '/**'.
> 
> I do use '/*' here first, but got a checkpatch.pl warning:
> 
>   ./scripts/checkpatch.pl v8-0001-bpf-Add-update_socket_protocol-hook.patch 
>   WARNING: networking block comments don't use an empty /* line, use /* Comment...
>   #63: FILE: net/socket.c:1648:
>   +/*
>   + *	A hook for bpf progs to attach to and update socket protocol.
> 
>   total: 0 errors, 1 warnings, 0 checks, 59 lines checked
> 
> And I found that other comments in net/socket.c all begins with '/**'.
> So I use '/**' here too.

From what I understand, when using a comment block starting with "/**",
it is to insert kernel doc format (similar to doxygen if you know about
it) where you can generally see the description of a function with
parameters starting with "@", etc. e.g. what is done above
"sock_recvmsg()" in "net/socket.c".

But I see indeed there are many other "random" comments starting with
"/**" but I guess that's because "net/socket.c" is very old, when
checkpatch.pl didn't exist.

I think the best is follow the "new" style, e.g. what is done above
"skb_is_swtx_tstamp()" in "net/socket.c", starting on the first line and
without tabulations after the "*", e.g.

  /* A hook for bpf progs to attach to and update socket protocol.
   *
   * A static noinline (...)
   * (...)
   */

WDYT?
Would it fix 'checkpatch.pl' warnings?

(if you send a new version, please add the Closes tag in this patch as
well if you don't mind. You can also keep my Reviewed-by and Acked-by
tags if you want but then put your Signed-off-by tag at the end: the
last tag should be a Signed-off-by tag of the person sending the
patches, you in this case :) )

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
