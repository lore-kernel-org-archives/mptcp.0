Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB18F63
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 16:08:57 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id fc4so12907393ejc.12
        for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 08:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BM+eL4nFcpEjh+xA2GtIaxfo0YqAfq74LGc+8R3mjx8=;
        b=tL05qQzjS4yIGzJeAlIPLk82d8G4cqhTWRntes09NrBCC/EhsYoUPTceZ4f75IM9K3
         pf+tlP17a2pcxn5tgmAhmeBW7r2yTRizTEXiOLslAfUqir5Fb64E8a5bJ9l2Mqbs76RZ
         2zXfikQ3UVMhaSWvS/zRwMoQ5L48NoJTnOkX98W1FpZVHKrXIHSlgdSqStWmI6O2pDeG
         n5RDukxBKdlzooi1utlnKo++vu7QBJSNU7scZZSyPYTjTWWHlww4nuvv3qXCz3uzg+WK
         HfHsoOpHc7ZJ3Oas5DxzTo1BrRZwAPjjSJDTcXEhjdxTXktrJMTTPiL70IKbrC4ugoRr
         hy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BM+eL4nFcpEjh+xA2GtIaxfo0YqAfq74LGc+8R3mjx8=;
        b=HZUy8XVgyqE0lKhCuoSBOKKGLtDMnAcYTNGzSy6ByKW62jq6VCOsXHwuJYQgZ33VjV
         Au22CQyRyJqYVteWN7bVC/MsleY8pz0frBQADG2zkmEQa9ZrzrTdP45IsbEVHXVtHx67
         v7pSPlwdbjdSxHjdU14ncH5OXsN+9oJXq6W8MJke4TIPyl5+xRtGzeA6KFEE7gvNu+hI
         IiQY7FaFOD8dIWBPxKJdsfO4zVaYlIDFfoNSbURLX5TIzrxXgDl+Qj1jmDwifrAyxCBz
         Ym4/qMUXH6qVpjzXsLHmnqvMouaucFcyRPUcjPGDNgU+8C1ii0Gi69GMDSQLKJSfghUm
         e6aA==
X-Gm-Message-State: AFqh2krLoEv0WTtH/IfGWvXHR4WIhihqTUq4hp1BFdEd2A2GFo/4JZVh
	nmfasm3LJJtKmhJ+9xNdm19ycSGSPtx0HvVeKbdopg==
X-Google-Smtp-Source: AMrXdXszDvfv9Zl4dlwyhYycUeyqqDljGuREJYHBXrY7MOvy9M39Pn7ZG2XXYW+wuWy0MXmrmxHugQ==
X-Received: by 2002:a17:906:6dcb:b0:7e7:4dd7:bbcc with SMTP id j11-20020a1709066dcb00b007e74dd7bbccmr8524406ejt.73.1671811736120;
        Fri, 23 Dec 2022 08:08:56 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id lb2-20020a170907784200b0084aade9d6b5sm314447ejc.17.2022.12.23.08.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 08:08:55 -0800 (PST)
Message-ID: <2deb7590-9c5e-0e7e-37ec-e447391f74bf@tessares.net>
Date: Fri, 23 Dec 2022 17:08:55 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mptcp-next 1/3] mptcp: explicitly specify sock family at
 subflow creation time
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1671799401.git.pabeni@redhat.com>
 <7d3aae6493caa1563d1aaadc79d299c01077f28a.1671799401.git.pabeni@redhat.com>
 <93c4e8a6-4797-9c10-5ae5-7499d6e2bed4@tessares.net>
 <a9cddc311804ebc183c0b1568c296b23932d7dd4.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <a9cddc311804ebc183c0b1568c296b23932d7dd4.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/12/2022 17:01, Paolo Abeni wrote:
> On Fri, 2022-12-23 at 15:35 +0100, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 23/12/2022 13:51, Paolo Abeni wrote:
>>> Let the caller specify the to-be-created subflow family. No
>>> functional change intended, will be leveraged by the next
>>> patch.
>>
>> (...)
>>
>>> @@ -1673,8 +1675,7 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
>>>  	if (unlikely(!sk->sk_socket))
>>>  		return -EINVAL;
>>>  
>>> -	err = sock_create_kern(net, sk->sk_family, SOCK_STREAM, IPPROTO_TCP,
>>> -			       &sf);
>>> +	err = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
>>
>> Mmh, I don't know if we can do that: it means we no longer inherit the
>> 'sk_family'. With the modification, it means if the initial socket is
>> created in v4 only (AF_INET), we will still be able to create subflows
>> in IPv6, right?
> 
> Yes. That was my understanding of issues/269 goal.

I didn't think about that when creating issue 269.

>> Somehow, I like the idea because with today's Internet, it is normal for
>> a client to have both IPv4 and IPv6 addresses. Then we avoid people
>> creating AF_INET sockets and complaining they cannot have additional
>> IPv6 subflows.
>>
>> But on the other hand, there is no more way to force having v4 only
>> subflows, no?
>> And I guess listening sockets will have to be created with AF_INET6 to
>> accept additional v6 subflows.
>>
>> WDYT?
> 
> I'm not sure I understand. Do you mean that we should allow mixed
> ipv4/ipv6 subflows only if mptcp family is ipv6? that is doable, I
> think, just slightly different from what is implemented here.

Maybe we don't need to change, we just need to decide which behaviour we
want.

Is it OK to have a mix of v4 and v6 subflows if the socket has been
created with AF_INET family? In this case, the family is just for the
initial subflow and not the next ones.

That's maybe fine but it might be strange that for the server side,
AF_INET6 is required to accept both IPv4 and IPv6 subflows.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
