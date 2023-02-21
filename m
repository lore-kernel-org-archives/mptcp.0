Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2017B4C64
	for <mptcp@lists.linux.dev>; Tue, 21 Feb 2023 15:51:06 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id o14so3923431wms.1
        for <mptcp@lists.linux.dev>; Tue, 21 Feb 2023 07:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RsKHFM+hKHMFdspXbgtQiDb5JlHO9GzKDSbmhroKKyw=;
        b=idQVNI0qNZii5d3H3N2h4GegphTu0xfMhCCNOXC17VY0r/ZhvuMzRm5zcF5dQY6hal
         GIjU+TZEvpRcIoU8ltrG221sBOYz3FcWw4j3X004Wuj0Bew3YyD7lKR4+LzAuLYc7Mn5
         N+n0FBZxNUPhoj65Mxu/8iQ8LiiBgj+Ww5ROhMTR1HEqdTW9EOKOrj9fXnkwqMqBg8uB
         2DOGBGRLBujcs+1SRvtqzcuhauG3pFDTd9W7Yr9AgucurzNDc2dIgvmwL92oSLSrb5OO
         SLyQveIERz7eWTIPRx7MRFpwFBF5agaZH5hLMrueKc1twcdLtsLPKUZKr2GQ3Oon/EZf
         WV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RsKHFM+hKHMFdspXbgtQiDb5JlHO9GzKDSbmhroKKyw=;
        b=rIf61+ff/Q2XwaCzVsoyClqLhNkeY3CRJ85aXlRka+hmqY6QB8ejBr1y37g16TF6so
         hfDRa8GY0xWKpoA4RX/BenhbX4xx8qgR2XlUoxVejnHb4jI2Hq5rpkjN5Am6EQRMoxE8
         MMa+kvY9lBs3mnAhCp2zh7se21G289uvcECKs91aHYhWzAzDsvv6gwyoe5unbWiuTR3O
         /MzuwHYm2jL8YKYClMF7fdhrbohQH0zIm4XMsi+qoSA+L2jjm7mlu1ba1TuRbN8T6/yQ
         49SncoQ71aa2yMdw6hCarTHXOB29dG0H0+6T7Fy5CqCasxyB31oH73MRiiYzxtgoYLW8
         XWmg==
X-Gm-Message-State: AO0yUKX7sVgbjhrbwl+H2Gny37wDD2LDNAtxuk6b0R+BQOnUtzLx05dS
	78Az8CtLNXyd/p5Nk86Ni9db4g==
X-Google-Smtp-Source: AK7set8TC7OxEGT7DnXa2BgDxBUehL1ALZiLmhdgTnzCZ1rLWvX4wqCJMNPhrRNNnmpSdg/LkcnIHA==
X-Received: by 2002:a05:600c:1708:b0:3df:f71b:3f68 with SMTP id c8-20020a05600c170800b003dff71b3f68mr9267488wmn.39.1676994664878;
        Tue, 21 Feb 2023 07:51:04 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:50ef:91b7:fffc:fdae? ([2a02:578:8593:1200:50ef:91b7:fffc:fdae])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c3b1100b003e896d953a8sm120387wms.17.2023.02.21.07.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 07:51:04 -0800 (PST)
Message-ID: <03740b2e-f5ac-3b5d-8eb4-a2a0e3cadf9b@tessares.net>
Date: Tue, 21 Feb 2023 16:51:03 +0100
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
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <29f3677f2032145ac2b1c1a90ec96ef0d61e4269.1676889558.git.pabeni@redhat.com>
 <7a23540c-0c17-6a8a-7826-2cea1e7c2ebf@tessares.net>
 <ff85210e42fbacb69ae14d4ae972e8a95c098962.camel@redhat.com>
 <7f6f4cf7-b643-544c-1fab-a19a4d6ea75f@tessares.net>
 <f2c3d45b-6bab-5747-98f2-b2cdfef5127d@tessares.net>
 <8f8b4663ae3a35c5302a291538e7d36d6e1920ca.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <8f8b4663ae3a35c5302a291538e7d36d6e1920ca.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 21/02/2023 16:18, Paolo Abeni wrote:
> On Mon, 2023-02-20 at 17:43 +0100, Matthieu Baerts wrote:
>> On 20/02/2023 17:26, Matthieu Baerts wrote:
>>>
>>>
>>> On 20/02/2023 17:09, Paolo Abeni wrote:
>>>> On Mon, 2023-02-20 at 16:01 +0100, Matthieu Baerts wrote:
>>>>> Hi Paolo,
>>>>>
>>>>> On 20/02/2023 15:27, Paolo Abeni wrote:
>>>>>> Since the squash-to commit, msk->first is set even for unaccepted
>>>>>> sockets: mptcp_mp_fail_no_response() can take action and reset
>>>>>> the subflow even when msk->first is still in the accept queue,
>>>>>> after that incoming reset already closed such socket.
>>>>>>
>>>>>> That in turn will end-up calling tcp_done() - via mptcp_subflow_reset()
>>>>>> - on already closed sockets, which is illegal.
>>>>>
>>>>> Should we not add a WARN_ON() there for our CI (and syzkaller) to catch
>>>>> that earlier?
>>>>
>>>> If you mean as a non upstreamable patch touching tcp_done(), that could
>>>> be useful.
>>>
>>> Yes, a non upstreamable patch, similar to:
>>>
>>>   mptcp: use kmalloc on kasan build
>>>
>>>> I think it's better not touching the upstream code enforcing such
>>>> constraint (either tcp or mptcp one) because it should be an "obvious"
>>>> one.
>>>
>>> Indeed but it is just to warn once before having real issues :)
>>> But it makes sense not to upstream this.
>>
>> I just tried this patch on top of the export branch and I got a warning
>> with the 2nd test of "mptcp_join.sh" :-D
>>
>> ------------------- 8< -------------------
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index 33f559f491c8..d21ec9bdd453 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -4639,6 +4639,8 @@ void tcp_done(struct sock *sk)
>>          */
>>         req = rcu_dereference_protected(tcp_sk(sk)->fastopen_rsk, 1);
>>
>> +       WARN_ON_ONCE(sk->sk_state == TCP_CLOSE);
>> +
>>         if (sk->sk_state == TCP_SYN_SENT || sk->sk_state == TCP_SYN_RECV)
>>                 TCP_INC_STATS(sock_net(sk), TCP_MIB_ATTEMPTFAILS);
>>
>>
>> ------------------- 8< -------------------
> 
> Could you please share the (decoded) stack trace?

Thank you for your reply.

I was planning to look at but I didn't manage to before. I just filled
in a new ticket with the patch, the stack trace and a first quick analysis:

  https://github.com/multipath-tcp/mptcp_net-next/issues/362

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
