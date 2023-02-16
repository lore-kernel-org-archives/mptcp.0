Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1500747A
	for <mptcp@lists.linux.dev>; Thu, 16 Feb 2023 15:24:59 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id c1so4202704edt.4
        for <mptcp@lists.linux.dev>; Thu, 16 Feb 2023 07:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GToOCkXMer8tGrkmWBzlZefjYJCuqFBWPJXCuV8GbqA=;
        b=LBsqIr7eG4sGHEZy4E1VGAsoz1dnwUfsmKl9ewA5ibYe3U/u7BhD22NUNU2RAFHTKz
         iuzqZo9pgn7rBLnkOdnDMbu18wOpWBennf7JzX9nCsBgdTLDirS7hGCfDki+2tB4C72K
         BFVA768lVeprW9CerPI9RzZcsam9HvZNEvKQoAcOWk0B+U7JkFqCGik1St2Z+LAy7zFo
         CYeqwkrrxql1tR+A6mdt6zhaTPwFROihC162Fm15y/QEEBlMQzK23oSg87vGWrWWmnt8
         vmFJh7o8rfVPOVuF286E7yL8WQExVq2FnHweV2t27LhWf870TbnrijgLsDIWHLzqaaOH
         XsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GToOCkXMer8tGrkmWBzlZefjYJCuqFBWPJXCuV8GbqA=;
        b=1gwXLwW3P/HVXkjU1eQZQRmvJ4UBAqU5m+z53bksoU/w37Uo+/+PLNbeq2X5SGP2sy
         TzFIaP2X92cHVmQWMvULHVaezCeGG2raKADCmnDau4VbtdXdkw2M/5gC/jA3xA0bKtiN
         eBCn35SO1QjyuA9DszscNBbhyVLx9kQHqPh90YNkkZnqtEucusANGRrMvN5Ng11f27y6
         j+2SSejBL65kx/9ctgHr8gCRT+Gfb84WX7GL8+LJYsmvpJT9qZyWOp6e0zYo3xV6go5N
         VIhlrd8HMhGylEamQ0E397PKJaPF6DcrgU70S3oawIQei8nfPpflUYO3plkWvkjqE0x9
         l7aA==
X-Gm-Message-State: AO0yUKVOmDd4j20wtPwxahyxWZomipi/wV62PtgPi4g7UthVtZJrNStr
	c3+4wx+k83hCGS+BVpED3Df1uCmG7QcLY6DezNI=
X-Google-Smtp-Source: AK7set8qqM9xVUDZzhOvpdFfxqZaGahoz34ESyoAoyl8ftZmTKNLf+1XbgKLMH/jPGHiRLb90BoZiQ==
X-Received: by 2002:a05:6402:898:b0:474:a583:2e1a with SMTP id e24-20020a056402089800b00474a5832e1amr6567938edy.12.1676561097778;
        Thu, 16 Feb 2023 07:24:57 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:c722:dd65:d333:1f67? ([2a02:578:8593:1200:c722:dd65:d333:1f67])
        by smtp.gmail.com with ESMTPSA id y23-20020a50ce17000000b004acc1374849sm998323edi.82.2023.02.16.07.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 07:24:57 -0800 (PST)
Message-ID: <2701c08d-4499-0b77-0fca-73e191a4363a@tessares.net>
Date: Thu, 16 Feb 2023 16:24:56 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 mptcp-net 1/2] mptcp: use the workqueue to destroy
 unaccepted sockets.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <b5b35cfd2d10179fc81643e601e125aa881f7c79.1675968499.git.pabeni@redhat.com>
 <3e0bda7b-d05b-7e9c-4862-d93d120ac86c@tessares.net>
 <02bd5e032b3ab2afb290a75c649c4df119a73dbb.camel@redhat.com>
 <c9de6cd2-7e71-9f12-850f-241493139dc8@tessares.net>
 <b19d3f143c1125d68eb5d0753fb2e08c6dbf9fcf.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b19d3f143c1125d68eb5d0753fb2e08c6dbf9fcf.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2023 16:15, Paolo Abeni wrote:
> On Thu, 2023-02-16 at 16:07 +0100, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 16/02/2023 15:58, Paolo Abeni wrote:
>>> On Wed, 2023-02-15 at 18:53 +0100, Matthieu Baerts wrote:
>>>> Hi Paolo,
>>>>
>>>> On 09/02/2023 19:48, Paolo Abeni wrote:
>>>>> Christoph reported a UaF at token lookup time:
>>>>>
>>>>> BUG: KASAN: use-after-free in __token_bucket_busy+0x253/0x260
>>>>> Read of size 4 at addr ffff88810698d5b0 by task syz-executor653/3198
>>>>>
>>>>> CPU: 1 PID: 3198 Comm: syz-executor653 Not tainted 6.2.0-rc59af4eaa31c1f6c00c8f1e448ed99a45c66340dd5 #6
>>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>>>>> Call Trace:
>>>>>  <TASK>
>>>>>  dump_stack_lvl+0x6e/0x91
>>>>>  print_report+0x16a/0x46f
>>>>>  kasan_report+0xad/0x130
>>>>>  __token_bucket_busy+0x253/0x260
>>>>>  mptcp_token_new_connect+0x13d/0x490
>>>>>  mptcp_connect+0x4ed/0x860
>>>>>  __inet_stream_connect+0x80e/0xd90
>>>>>  tcp_sendmsg_fastopen+0x3ce/0x710
>>>>>  mptcp_sendmsg+0xff1/0x1a20
>>>>>  inet_sendmsg+0x11d/0x140
>>>>>  __sys_sendto+0x405/0x490
>>>>>  __x64_sys_sendto+0xdc/0x1b0
>>>>>  do_syscall_64+0x3b/0x90
>>>>>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>>>>
>>>>> We need to properly clean-up all the paired MPTCP-level
>>>>> resources and be sure to release the msk last, even when
>>>>> the unaccepted subflow is destroyed by the TCP internals
>>>>> via inet_child_forget().
>>>>>
>>>>> We can re-use the existing MPTCP_WORK_CLOSE_SUBFLOW infra,
>>>>> explicitly checking that for the critical scenario: the
>>>>> closed subflow is the MPC one, the msk is not accepted and
>>>>> eventually going through full cleanup.
>>>>>
>>>>> With such change, __mptcp_destroy_sock() is always called
>>>>> on msk sockets, even on accepted ones. We don't need anymore
>>>>> to transiently drop one sk reference at msk clone time.
>>>>
>>>> Thank you for the patch, I just have one question below if you don't mind :)
>>>>
>>>> (...)
>>>>
>>>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>>>> index 546df81c162f..d7588535bf6d 100644
>>>>> --- a/net/mptcp/protocol.c
>>>>> +++ b/net/mptcp/protocol.c
>>>>> @@ -2444,9 +2444,10 @@ static unsigned int mptcp_sync_mss(struct sock *sk, u32 pmtu)
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>> -static void __mptcp_close_subflow(struct mptcp_sock *msk)
>>>>> +static void __mptcp_close_subflow(struct sock *sk)
>>>>>  {
>>>>>  	struct mptcp_subflow_context *subflow, *tmp;
>>>>> +	struct mptcp_sock *msk = mptcp_sk(sk);
>>>>>  
>>>>>  	might_sleep();
>>>>>  
>>>>> @@ -2460,7 +2461,15 @@ static void __mptcp_close_subflow(struct mptcp_sock *msk)
>>>>>  		if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
>>>>>  			continue;
>>>>>  
>>>>> -		mptcp_close_ssk((struct sock *)msk, ssk, subflow);
>>>>> +		mptcp_close_ssk(sk, ssk, subflow);
>>>>> +	}
>>>>> +
>>>>> +	/* if the MPC subflow has been closed before the msk is accepted,
>>>>> +	 * msk will never be accept-ed, close it now
>>>>> +	 */
>>>>> +	if (!msk->first && msk->in_accept_queue) {
>>>>> +		sock_set_flag(sk, SOCK_DEAD);
>>>>> +		sk->sk_state = TCP_CLOSE;
>>>>
>>>> Would it make sense to call inet_sk_state_store() here, mainly for the
>>>> tracing?
>>>
>>> Right you are, this si the msk, it's state is read lockless by the
>>> subflows.
>>
>> Sorry, I'm not sure I understood your reply. Just to be sure, we should
>> then replace this single line:
>>
>>   sk->sk_state = TCP_CLOSE;
>>
>> by:
>>
>>   inet_sk_state_store(sk, TCP_CLOSE);
>>
>> and nothing else.
> 
> Exactly.
> 
> What I was trying to say above is that we need such change because the
> msk (== sk above) status is accessed (read) by the subflows without
> holding the msk socket lock (using inet_sk_state_load()). Hence  we
> must use inet_sk_state_store() to write it.

Ah yes indeed, sorry now I see what you meant :-)

I can apply them in a bit.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
