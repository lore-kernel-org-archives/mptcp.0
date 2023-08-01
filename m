Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6698123BC4
	for <mptcp@lists.linux.dev>; Tue,  1 Aug 2023 14:16:27 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-991c786369cso822784966b.1
        for <mptcp@lists.linux.dev>; Tue, 01 Aug 2023 07:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690899386; x=1691504186;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2QCJyHeH1UEr/rhrxpMLNVa98yIhKWeGXaXfC/7A1gI=;
        b=gajeIOsQdYlFMLUjVUMpZApsY3s6v7n3QN7CPb579zbsGp3ca9hlUS09pG1yuHcavV
         OXx57jR65NOSRwli45B8K7Q1Fwwynz4XTztDRrwD1UtbQbLDokDEN9Xj+2u1Wx2TEMCC
         kIFjjp29NRLduYIii+Mo7InS3Zip15RSAkO3kjplY9iWyLarrqLslU7gb2cSPBGBeW5C
         dIZHv+vrl2fbr3ZYXDQRQ02XZma2RDn2Wa/89lOQ2jUVhf+9aWAkaMejPQ/lmGaWY9Nv
         1Qf37Kf4oTxCUCTqqffzCgvTlw3L1htNtsfY4k6zVnMGksIF9GSIqXR5BHUVpLru/LLL
         F+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690899386; x=1691504186;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2QCJyHeH1UEr/rhrxpMLNVa98yIhKWeGXaXfC/7A1gI=;
        b=EHN2KiutaQx8dibf3t7qDm9ZOWc+JFLd90opWbD+ZsL7dE9TDjRellarvsWWabMUTz
         ymiOx5JengqbrCNOGlHzP+Voq2wZk3BGBdVBu4zSnRw1S86ma8K95wfaqRWcr9IEaOjz
         cxUy/M+CUbMq1dJSdkPM9LLq9hDJTrhbjt+pctBUDlg2LTfUJ049l6K/Tbzsy3OnC42x
         1RMkdynbYvK7YZ7Z3M1LE7bR23HkLht/DT22sKNVr88KOaZHZthWA5PjDOlOKkNpAPKg
         TLfEXBGEPPhxY+hOOHwTpRNbkD8Li7CFgIwhG4fQdP/spoWctNSNUTEOW0CcbED8nfE0
         fErA==
X-Gm-Message-State: ABy/qLa7rMVvlt0+1bhevRfI+7RiTuYZgpNaXvwMaeNBF1dj93WOLMLT
	/2KzDYbjzCAhrapj6bNMeM7xX6Dbw3WKUAGvheeTOcTz
X-Google-Smtp-Source: APBJJlH3VXkPiIhAHABG7uBJ09LqP/SFzRf2zin5bfhema6jhPMXo89uT7O3ufC8mtbN7GnxtFj2eA==
X-Received: by 2002:a17:907:7743:b0:99b:65fa:e309 with SMTP id kx3-20020a170907774300b0099b65fae309mr2490728ejc.74.1690899386017;
        Tue, 01 Aug 2023 07:16:26 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:2cb4:ff10:2449:c7aa? ([2a02:578:8593:1200:2cb4:ff10:2449:c7aa])
        by smtp.gmail.com with ESMTPSA id lf6-20020a170906ae4600b0099b6becb107sm7783649ejb.95.2023.08.01.07.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 07:16:25 -0700 (PDT)
Message-ID: <4eae89cf-c671-45cf-90fd-967a0650e1e5@tessares.net>
Date: Tue, 1 Aug 2023 16:16:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: fix disconnect vs accept race
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <68f1f65f9b5542fd200f995844f7ed71bdfbfc30.1690840586.git.pabeni@redhat.com>
 <2894c643-f883-4f18-9e4e-36c4566c5cab@tessares.net>
 <15dbcb31932f489673dfc6f9d2c97ce2bf497ffd.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <15dbcb31932f489673dfc6f9d2c97ce2bf497ffd.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 01/08/2023 15:59, Paolo Abeni wrote:
> On Tue, 2023-08-01 at 12:34 +0200, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 01/08/2023 00:25, Paolo Abeni wrote:
>>> Despite commit 0ad529d9fd2b ("mptcp: fix possible divide by zero in
>>> recvmsg()"), the mptcp protocol is still prone to a race between
>>> disconnect() (or shutdown) and accept.
>>>
>>> The root cause is that the mentioned commit checks the msk-level
>>> flag, but mptcp_stream_accept() does acquire the msk-level lock,
>>> as it can rely directly on the first subflow lock.
>>>
>>> As reported by Christoph than can lead to a race where an msk
>>> socket is accepted after that mptcp_subflow_queue_clean() releases
>>> the listener socket lock and just before it takes destructive
>>> actions leading to the following splat:
>>
>> (...)
>>
>>> Address the issue by temporary removing the pending request socket
>>> from the accept queue, so that racing accept() can't touch them.
>>>
>>> After depleting the msk - the ssk still exists, as plain TCP sockets,
>>> re-insert them into the accept queue, so that later inet_csk_listen_stop()
>>> will complete the tcp socket disposal.
>>
>> Thank you for working on this fix and sharing this patch!
>>
>> I just have one question at the end of your patch:
>>
>>> Fixes: 2a6a870e44dd ("mptcp: stops worker on unaccepted sockets at listener close")
>>> Reported-by: Christoph Paasch <cpaasch@apple.com>
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/423
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> Note: as a net-next follow-up it would be nice to support mptcp socket
>>> migration, basically duplicating part of the inet_csk_listen_stop() logic
>>
>> (As you know, I'm always worry when you talk about duplicating code :) )
> 
> I know ;)
> 
> Probably I should had written something alike "implement quite similar
> code to" ... which is actually more accurate.

Good, sounds better :-)

>>> @@ -1859,6 +1852,13 @@ void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_s
>>>  
>>>  	/* we are still under the listener msk socket lock */
>>>  	lock_sock_nested(listener_ssk, SINGLE_DEPTH_NESTING);
>>> +
>>> +	/* restore the listener queue, to let the TCP code clean it up */
>>> +	spin_lock_bh(&queue->rskq_lock);
>>> +	WARN_ON_ONCE(queue->rskq_accept_head);
>>
>> What prevent the accept queue to be modified between the moment it has
>> been "nullified" (at the beginning of this function) and here (at the end)?
>>
>> I see that both the locks for the queue and the socket have been
>> released and re-held in between: could this accept queue be modified in
>> between if we are unlucky?
>>
>> I'm sure I'm missing something :)
> 
> The tcp listener socket is unhashed before starting
> mptcp_subflow_queue_clean() by tcp_set_state(TCP_CLOSE). Later lookup
> can't find the listener socket at all - so not even attach more req
> sockets there.
> 
> Put in another way, if the stack is able to reach the tcp listener
> socket here, both mptcp and plain tcp could leak incoming request
> socket at destroy time (because new req could be appended after
> flushing the queue).

Thank you for the explanations! All safe then, it looks good to me:

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Does it mean we could even drop the locks around the modification of the
queue? (But better to keep them)

> The WARN_ON_ONCE() should be really over-defensive.

Yes but it still makes sense, no problem to keep it!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
