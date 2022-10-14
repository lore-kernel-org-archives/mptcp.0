Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE65220F8
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 13:18:45 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id k2so10455321ejr.2
        for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 06:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Z246k6B1AMtOetmkZYcH4TKXrylLCm3hheSc3I+wm8=;
        b=NTYHvybGwCvXpOWQQQthefAfRutU3Odm8qRXwWd499XXZWqRYGy3uGrubV1sv35Gjm
         tKLTSseF76SIGQRQzqytSBGkKxMMccS4r+naxW1yxnR4ivyT9xpjfjqS6tT+YIrQy4yo
         6pEkqc7ETuNUhbkWNmzzBG60Dtnplkqp9mqCRnc6Khhedjta/8rjgBh/Jpu/FuWYyOD1
         v0fokA7R2gXus4se6Y05cxG4gjErMtViWkl5yEIljt2THq3iO66j9iJ6VzZWNQ1S5JxY
         7Yg+N+AkndVaVCKIq1xaBxA8eGdz+1gQGVVWAauol2n7jg/nJn7/hLmOeEtL0utgjbwK
         YOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z246k6B1AMtOetmkZYcH4TKXrylLCm3hheSc3I+wm8=;
        b=k8K5dYz8QSOJe/kKfEXz9jqgLMycDDYc6KCYjUyjL8OIvDIT/scHKbmecXUqSJMem5
         OwVeEgMFvnB3uiR2CyKAndKP0r/SpqcC88Wg8RKaBRE30wYsAqaEthplVY2vrN1RzHoQ
         VfmYY/Oq7Hk3LUhqZY+7kMwxeu7wE1e72d8QRtHCQm7+Nr1XwbFK9iScDc5IYqYh17eN
         eO5kfwAXzFCQdGLi3ciYzOP6de9uqq0V7KKX3xmlBDSWDZzkPcbaxgvkUzXPXJys+kwL
         KMIavtNQFVWblutiEI6/uQac9C1GZq2HVhAvtwcYGF8Kt4xzpQ3u5WEs+I2a6g+gInDE
         a4qQ==
X-Gm-Message-State: ACrzQf3B+sIUQ2OlwDPWibSrncxociN+C+wFOsbocKyyDpfBQXZzLlnG
	llSUW/2H3vjjDbF6We8v6brVzw==
X-Google-Smtp-Source: AMsMyM4QNCwEwP0tehq7FvBlsPWI9D8+grSyBneztb/cea5BB1JKtNN6xWj+izgVYb3xn10RG4avkA==
X-Received: by 2002:a17:907:2e0d:b0:78e:1d21:8001 with SMTP id ig13-20020a1709072e0d00b0078e1d218001mr3482886ejc.246.1665753523615;
        Fri, 14 Oct 2022 06:18:43 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:39c6:43d:7d1c:5da5? ([2a02:578:8593:1200:39c6:43d:7d1c:5da5])
        by smtp.gmail.com with ESMTPSA id d9-20020a170906370900b0073022b796a7sm1540591ejc.93.2022.10.14.06.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 06:18:43 -0700 (PDT)
Message-ID: <bb01d3b7-6b0b-94c6-007d-96f9d49cef30@tessares.net>
Date: Fri, 14 Oct 2022 15:18:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-net v3] mptcp: fix abba deadlock on fastopen
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <7c61250080c052b9dfb42a023c85dc36d4450daf.1665584136.git.pabeni@redhat.com>
 <dee06f30-f5ea-deb3-9d40-b4f7a5d460df@tessares.net>
 <4ce32959a049f5fcb34e98dc761af5d022fd8607.camel@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <4ce32959a049f5fcb34e98dc761af5d022fd8607.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 13/10/2022 14:19, Paolo Abeni wrote:
> On Wed, 2022-10-12 at 17:39 +0200, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 12/10/2022 16:48, Paolo Abeni wrote:
>>> Our CI reported lockdep splat in the fastopen code:
>>
>> (...)
>>
>>> The problem is caused by the blocking inet_wait_for_connect() releasing
>>> and re-acquiring the msk socket lock while the subflow socket lock is
>>> still held and the MPTCP socket requires that the msk socket lock must
>>> be acquired before the subflow socket lock.
>>>
>>> Address the issue always invoking tcp_sendmsg_fastopen() in an
>>> unblocking manner, and later eventually complete the blocking
>>> __inet_stream_connect() as needed.
>>
>> Thank you for the v3!
>>
>> I just have one last question here below (+ 2 small comments but a v4 is
>> probably not needed):
>>
>> (...)
>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 1cdf9cd1a3cc..82d899233df4 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -1673,6 +1673,37 @@ static void mptcp_set_nospace(struct sock *sk)
>>>  	set_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags);
>>>  }
>>>  
>>> +static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msghdr *msg,
>>> +				  size_t len, int *copied_syn)
>>> +{
>>> +	unsigned int saved_flags = msg->msg_flags;
>>> +	struct mptcp_sock *msk = mptcp_sk(sk);
>>> +	int ret;
>>> +
>>> +	lock_sock(ssk);
>>> +	msg->msg_flags |= MSG_DONTWAIT;
>>> +	msk->connect_flags = O_NONBLOCK;
>>
>> Just to be sure I understand properly: here O_NONBLOCK is set but that
>> will only be used for the subflow and only if MSG_FASTOPEN is set (and
>> allowed), so not for TCP_FASTOPEN_CONNECT, right?
>>
>> But no need to reset them later, right?
>>
>> (I'm a bit confused by the fact we set msk->connect_flags in
>> mptcp_stream_connect() before calling __inet_stream_connect() and not
>> here below)
> 
> You are right, that is actually not obvious. The later
> __inet_stream_connect() call will not reach mptcp_stream_connect(),
> will perform only the inet_wait_for_connect() bits, so the
> connect_flags will be unused.

Thank you for the explanation, that's clearer now!

>>
>>> +	msk->is_sendmsg = 1;
>>> +	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
>>> +	msk->is_sendmsg = 0;
>>> +	msg->msg_flags = saved_flags;
>>> +	release_sock(ssk);
>>> +
>>> +	/* do the blocking bits of inet_stream_connect outside the ssk socket lock */
>>> +	if (ret == -EINPROGRESS && !(msg->msg_flags & MSG_DONTWAIT)) {
>>> +		ret = __inet_stream_connect(sk->sk_socket, msg->msg_name,
>>> +					    msg->msg_namelen, msg->msg_flags, 1);
>>> +
>>> +		/* Keep the same behaviout of plain TCP: zero the copied bytes in
>>
>> s/behaviout/behaviour/ but I can fix that when applying the patch, I
>> guess "checkpatch.pl --codespell" will remind me that.

(done)

>>> +		 * case of any error, except timeout or signal
>>> +		 */
>>> +		if (ret && ret != -EINPROGRESS && ret != -ERESTARTSYS && ret != -EINTR)
>>> +			*copied_syn = 0;
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>  static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>>>  {
>>>  	struct mptcp_sock *msk = mptcp_sk(sk);
>>> @@ -1693,26 +1724,14 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>>>  
>>>  	ssock = __mptcp_nmpc_socket(msk);
>>>  	if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect)) {
>>> -		struct sock *ssk = ssock->sk;
>>>  		int copied_syn = 0;
>>>  
>>> -		lock_sock(ssk);
>>> -
>>> -		msk->connect_flags = (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
>>> -		msk->is_sendmsg = 1;
>>> -		ret = tcp_sendmsg_fastopen(ssk, msg, &copied_syn, len, NULL);
>>> -		msk->is_sendmsg = 0;
>>> +		ret = mptcp_sendmsg_fastopen(sk, ssock->sk, msg, len, &copied_syn);
>>
>>
>> It might look a bit strange to add some code here and then move it to a
>> dedicated function in the following commit but I'm sure that will be
>> fine for other net maintainers! :-)
> 
> If you prefer I can rework the 'factor out' patch to make this change
> more straight-forward.

No, all good, it should not cause any issues.

The current v3 looks good to me as well so I just applied with Mat's RvB
tag:

New patches for t/upstream-net:
- db11c1e73050: mptcp: factor out mptcp_connect()
- 8f2675510042: mptcp: fix abba deadlock on fastopen
- Results: 1cb20c1f7d2a..971a69ed25f3 (export-net)

New patches for t/upstream:
- db11c1e73050: mptcp: factor out mptcp_connect()
- 8f2675510042: mptcp: fix abba deadlock on fastopen
- Results: 7769807fea85..cdd78b7e0a98 (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20221014T131605
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221014T131605

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
