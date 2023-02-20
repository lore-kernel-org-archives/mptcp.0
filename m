Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B28D7ED
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 16:43:40 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id x10so6183872edd.13
        for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 08:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+WmvHmcg+HxGncjqNfPp3ekJv0O0iaamf0jAbVN8GCU=;
        b=OtlzTyitlYzSL65jO+puTNqpIT3vaUQejhYhjHawaMiGRLKnL+acEAehCm+MGJCh5f
         Pti20XJtgAPQhmA4vjWWqWydAjA/l/wFxTva/3ptA7Xr3cDuoEVM6MXjd4OYV3GgCpMI
         8qAMoLfb4xYc3XE2pq4OTsd/Nqz8tRw9n9+3O8lmU7H4rQPnt6pXht4dpBy3z3YfTCm1
         7/MkYRbfViIlFpL4fF4q9xn32rvzFgjlfWXulo4fmk/LfZBbUspSPSvSLqZIz+w0bHsl
         umgvhCGmx1ChEl0xUWW4maO++uvLLbbHSmUW+ltbTMXpdVAWFaXUDVRxPNkCFYg6lGDw
         2fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+WmvHmcg+HxGncjqNfPp3ekJv0O0iaamf0jAbVN8GCU=;
        b=U6L5zWz351U6DIo2In3TxC7dyl1oGT73SpRGIpsFWZvTboggJrn8oHpDwzX+xqF8RR
         fxpm1gwKZisHP2QRc+29o9ZVF8+xgD2LKdPA6S9YyPCqw2308/1AHYYfmEe56qder9Io
         IIRFuyRmMkltr+meJMlTftoRlxVcq26H1FRQmDbBdSxI5jWy4GAPpBvpPis4rI/x9euo
         415Hgfk5QLEbBEz1Sn2WloFP1u4DrLPTf/GflSh53IN9HKVqocRptbVmffLypZ6MECf2
         VIN8eteli7eAXYvjFIl43+4hbRW7qmrZ+tZp1Q/hjijw28o2l1X9ROtEtVBOMH5xlqLS
         MsfA==
X-Gm-Message-State: AO0yUKV52gtfNfqa6N+WFIizU5+JRdkfMkuD0utSiUsf64VBNPSre740
	MbKw1nPyMVcte2M3sNt+GJ9TwA==
X-Google-Smtp-Source: AK7set/DBd9+V3UaOxTc6KjELFJYD0DkPA57NwS4FyZRapvTVu2u1EvG4jlJDWMcPd6HswlZR/w1ig==
X-Received: by 2002:a17:906:4e9a:b0:88d:697d:a3d2 with SMTP id v26-20020a1709064e9a00b0088d697da3d2mr9037683eju.54.1676911419087;
        Mon, 20 Feb 2023 08:43:39 -0800 (PST)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id jj1-20020a170907984100b008d606b1bbb1sm1205147ejc.9.2023.02.20.08.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 08:43:38 -0800 (PST)
Message-ID: <f2c3d45b-6bab-5747-98f2-b2cdfef5127d@tessares.net>
Date: Mon, 20 Feb 2023 17:43:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH mptcp-next] Squash-to: mptcp: refactor passive socket
 initialization
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <29f3677f2032145ac2b1c1a90ec96ef0d61e4269.1676889558.git.pabeni@redhat.com>
 <7a23540c-0c17-6a8a-7826-2cea1e7c2ebf@tessares.net>
 <ff85210e42fbacb69ae14d4ae972e8a95c098962.camel@redhat.com>
 <7f6f4cf7-b643-544c-1fab-a19a4d6ea75f@tessares.net>
In-Reply-To: <7f6f4cf7-b643-544c-1fab-a19a4d6ea75f@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/02/2023 17:26, Matthieu Baerts wrote:
> 
> 
> On 20/02/2023 17:09, Paolo Abeni wrote:
>> On Mon, 2023-02-20 at 16:01 +0100, Matthieu Baerts wrote:
>>> Hi Paolo,
>>>
>>> On 20/02/2023 15:27, Paolo Abeni wrote:
>>>> Since the squash-to commit, msk->first is set even for unaccepted
>>>> sockets: mptcp_mp_fail_no_response() can take action and reset
>>>> the subflow even when msk->first is still in the accept queue,
>>>> after that incoming reset already closed such socket.
>>>>
>>>> That in turn will end-up calling tcp_done() - via mptcp_subflow_reset()
>>>> - on already closed sockets, which is illegal.
>>>
>>> Should we not add a WARN_ON() there for our CI (and syzkaller) to catch
>>> that earlier?
>>
>> If you mean as a non upstreamable patch touching tcp_done(), that could
>> be useful.
> 
> Yes, a non upstreamable patch, similar to:
> 
>   mptcp: use kmalloc on kasan build
> 
>> I think it's better not touching the upstream code enforcing such
>> constraint (either tcp or mptcp one) because it should be an "obvious"
>> one.
> 
> Indeed but it is just to warn once before having real issues :)
> But it makes sense not to upstream this.

I just tried this patch on top of the export branch and I got a warning
with the 2nd test of "mptcp_join.sh" :-D

------------------- 8< -------------------
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 33f559f491c8..d21ec9bdd453 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4639,6 +4639,8 @@ void tcp_done(struct sock *sk)
         */
        req = rcu_dereference_protected(tcp_sk(sk)->fastopen_rsk, 1);

+       WARN_ON_ONCE(sk->sk_state == TCP_CLOSE);
+
        if (sk->sk_state == TCP_SYN_SENT || sk->sk_state == TCP_SYN_RECV)
                TCP_INC_STATS(sock_net(sk), TCP_MIB_ATTEMPTFAILS);


------------------- 8< -------------------

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
