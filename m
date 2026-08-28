Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585023CB56D
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 06:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787898934; cv=none; b=kI7i5tDdh1y2b4URUyVqPQf4tKq9MBk+0Tjbj90KcGhcXJcaMyLBeITGXkjqKAKFWlarPShJUKpQg3w9JJSQ0IcmrErilEjHPANOiiOBo+p884/OQqi8OgpYGxqg0kSkFOXqPULB2wc4eDKcU17NmUE9FXWSfCazLguvWYXisMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787898934; c=relaxed/simple;
	bh=ZkqaU6xjYMnZhXnFuAmYd8Re5rQFMtuRWq9X6Kyik9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILBHO0HBnuBxBqzTCfWUaZtBTkIbxYtlhxIv7DGjEwprEfMtbvMJEEclhvHgccLNm9oXHnRxOmIduQaSVMx/ZbYFIA9CR3r0+rrg3OT0gwcgXH6DKGGlYI1yqg5qXpPR+2oicGw+VspOrUfy4itccK/tenM9i9NYV5py1UTNm0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bfx5HOQ8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfx5HOQ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787898932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wo3JmG3c3pYLBvFD0UAUF1R4n71rrMwTKBDqsXXXpWI=;
	b=bfx5HOQ8S9Jq2HLffj/UUBwuChJ77WX385pNtpO3JQgghURvquCrw7srB/J2k/ITS9Ungi
	mgMwazrSpouEB4dPFdgGPBlssEg19DwrnSiFc5NIx86VR9cpUsMr+CokFDECQwj8faa6eP
	CPgbn2+JwfzOuHuHC36QLmS3R/4k1u0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-GDPCIz9LMC2MTSMio6s7JA-1; Fri, 28 Aug 2026 02:35:28 -0400
X-MC-Unique: GDPCIz9LMC2MTSMio6s7JA-1
X-Mimecast-MFC-AGG-ID: GDPCIz9LMC2MTSMio6s7JA_1787898927
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f8398ed9fso364601f8f.0
        for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 23:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787898927; x=1788503727;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wo3JmG3c3pYLBvFD0UAUF1R4n71rrMwTKBDqsXXXpWI=;
        b=pOaFBeep2KO3MyPb0MoWpEHpYYh0f+q5mYsVJYqw6p4Ju2a2A7E4ig8h0kjKg2I75V
         Fw3gJFQIz2RVO8mXNxk3iieNQbjesB+JMcxkNFHjWVZtreBKIeC0iCHnPEiXIS//d3sb
         VS2M5CQReLuJI+naps9aFBPgmSYylxxby0PQi7ezQ6NiqsZTEqIiFqqjdykR68GtrDNO
         6Grb1rHzh8XU+xYxFu8KNjnDjV8Y2fnmOHqadMfdFkEYllL0bkI9TxgvEVWmRznDTsfL
         cGYa9Ex8IXmcljMN09fIVgcuccQOAfKAZbknBc6yIwCumgv/EQ+znKlSN4g/3PhrNP2j
         2BxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq7YDYaca9tOuc2D5vRBlhvSkTeUGMNQb3oLYmQdb2hqJHLgOjmgkb7zyp4+b+0zgSmIcp5jg==@lists.linux.dev
X-Gm-Message-State: AFuF++mejX6IGECFwMZHv9NBR1Wo3CX/+GZ3k3/AzeXav4ECuLfG0Djc
	e+gnx3T+lGCSW2oZ3HSi8AkZjP0ptPNwewys4foTLPhwx5BnRYDV/AExJ08K5fpAFhTc8nsQIEb
	cUq8P/QeKptucpTxIhMXHOUcclZP0vuS/svSypeRDAZ9L+tt+R9wOT7nl
X-Gm-Gg: AR+sD11EUZTZbHBXkkSXH1FTackHxgh+jvzFghnz1KaO9nTfgaJunybYLZSxJ9Yustb
	OaNQaT5kTsMYP2ar+3SJd9BD30VBlhPl/A2YufNsIncyUUdcL1aLc7rS4ZnznSgZmfqE7pGHieA
	eGZsd6o+gsaZzZ6Q/OIbhgUyjbjxtbiFFdAf//zXSA76SyBr73msY5Wcizt78xiJOyQ6CDyPWh0
	6Ei8VguzUniQZQZwgx25orzWDKYCI72vzblP5Js40eZO+GDXEDZJaMPlly9BueXCSQw0zyh6b/S
	B4Q3W5AUPS3bxeeFsC0T70ZA+RRjR7UHzJCm6Ec0cDiDZCfUTdIRw0OrdXteAsEZ6y0SrWjiQw5
	H2YpTWElYLRjVi6NhsVZZ3AXzOAXrauaA1ZhCi7ZJ3tSz7h9vQXpA1WDQfXmHKIAGLAfUQAY=
X-Received: by 2002:a05:600c:81ca:b0:49b:47b3:d6d with SMTP id 5b1f17b1804b1-49b91c3b7c4mr67057005e9.10.1787898927538;
        Thu, 27 Aug 2026 23:35:27 -0700 (PDT)
X-Received: by 2002:a05:600c:81ca:b0:49b:47b3:d6d with SMTP id 5b1f17b1804b1-49b91c3b7c4mr67056195e9.10.1787898927015;
        Thu, 27 Aug 2026 23:35:27 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c5790csm34858195e9.0.2026.08.27.23.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 23:35:26 -0700 (PDT)
Message-ID: <e0a35a2f-bb1c-44f6-877b-09230d40fdd4@redhat.com>
Date: Fri, 28 Aug 2026 08:35:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 01/14] mptcp: do not reschedule the RTX timer for
 fallback sockets
To: Jakub Kicinski <kuba@kernel.org>, matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-1-a92309d121ca@kernel.org>
 <20260827190723.3998185-1-kuba@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260827190723.3998185-1-kuba@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ssYzTSPwN1Gy5VqsuDLVpdMx2kLVl1dUg5g-EZvL19s_1787898927
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/26 9:07 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> mptcp: do not reschedule the RTX timer for fallback sockets
> 
> This replaces the TCP_CLOSE state test in mptcp_reset_rtx_timer() with a
> new MPTCP_RTX_DISABLED bit in msk->flags, set both on fallback in
> __mptcp_try_fallback() and on the transition to TCP_CLOSE in
> mptcp_set_state().
> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index b474d03620a75..23dde0b7144bb 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
> 
> [ ... ]
> 
>> @@ -1084,13 +1085,14 @@ static bool mptcp_rtx_timer_pending(struct sock *sk)
>>  
>>  static void mptcp_reset_rtx_timer(struct sock *sk)
>>  {
>> +	struct mptcp_sock *msk = mptcp_sk(sk);
>>  	unsigned long tout;
>>  
>> -	/* prevent rescheduling on close */
>> -	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
>> +	/* Prevent rescheduling on close and in case of fallback. */
>> +	if (test_bit(MPTCP_RTX_DISABLED, &msk->flags))
>>  		return;
> 
> [Severity: Medium]
> The new test depends on a flag that mptcp_disconnect() clears while the
> socket is still in TCP_CLOSE, and after mptcp_stop_rtx_timer() already ran.
> The order inside mptcp_disconnect() is:
> 
> 	mptcp_set_state(sk, TCP_CLOSE);    /* sets MPTCP_RTX_DISABLED */
> 	...
> 	mptcp_stop_rtx_timer(sk);          /* non-sync, timer_ival = 0 */
> 	...
> 	WRITE_ONCE(msk->flags, 0);         /* clears MPTCP_RTX_DISABLED */
> 	msk->cb_flags = 0;
> 
> Can the rtx timer be armed again after that point?
> 
> mptcp_stop_rtx_timer() uses sk_stop_timer() and therefore the non-sync
> timer_delete(), so an already-expired mptcp_retransmit_timer() can still be
> running on another CPU. It only takes bh_lock_sock(), and its
> __set_bit(MPTCP_RETRANSMIT, &msk->cb_flags) can land after the plain
> msk->cb_flags = 0 store above.
> 
> On the release_sock() that follows, mptcp_release_cb() calls
> __mptcp_retrans(sk) with no sk_state check, and that reaches
> __mptcp_clean_una():
> 
> out:
> 	if (snd_una == msk->snd_nxt && snd_una == msk->write_seq) {
> 		if (mptcp_rtx_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
> 			mptcp_stop_rtx_timer(sk);
> 	} else {
> 		mptcp_reset_rtx_timer(sk);
> 	}
> 
> mptcp_disconnect() does not reset snd_una/snd_nxt/write_seq, so for a socket
> disconnected with unacked data the else branch runs and arms the timer with
> timer_ival == 0 on a TCP_CLOSE socket whose timers were deliberately
> stopped. The previous inet_sk_state_load(sk) == TCP_CLOSE test returned
> early here.
> 
> When that immediately-expiring timer fires, mptcp_retransmit_timer() does
> test_and_set_bit(MPTCP_WORK_RTX, &msk->flags) and then calls
> mptcp_schedule_work(), which refuses to queue the worker for a closed
> socket without clearing the bit:
> 
> 	if (inet_sk_state_load(sk) == TCP_CLOSE)
> 		return false;
> 
> If the application then reuses the socket with a new connect(), does that
> leftover MPTCP_WORK_RTX bit keep mptcp_worker() from being scheduled on
> subsequent rtx expiries, until some other mptcp_schedule_work() caller lets
> the worker clear it?
> 
>>  
>> -	tout = mptcp_sk(sk)->timer_ival;
>> +	tout = msk->timer_ival;
>>  	sk_reset_timer(sk, &sk->mptcp_retransmit_timer, jiffies + tout);
>>  }
>>  
>> @@ -3324,6 +3326,9 @@ void mptcp_set_state(struct sock *sk, int state)
>>  		 * transition from TCP_SYN_RECV to TCP_CLOSE_WAIT.
>>  		 */
>>  		break;
>> +	case TCP_CLOSE:
>> +		set_bit(MPTCP_RTX_DISABLED, &mptcp_sk(sk)->flags);
>> +		fallthrough;
> 
> [Severity: High]
> This latches the bit on every transition to TCP_CLOSE, and there is no
> clear_bit(MPTCP_RTX_DISABLED) anywhere in the tree. The only site that
> resets the word is mptcp_disconnect():
> 
> 	WRITE_ONCE(msk->flags, 0);
> 
> Can this leave the bit set on a socket that afterwards carries a normal,
> non-fallback MPTCP connection?
> 
> First path, a failed connect() followed by a retry on the same fd. The
> error path of mptcp_connect() does:
> 
> 	if (unlikely(err)) {
> 		/* avoid leaving a dangling token in an unconnected socket */
> 		mptcp_token_destroy(msk);
> 		mptcp_set_state(sk, TCP_CLOSE);
> 		return err;
> 	}
> 
> For a negative return from sk->sk_prot->connect(), __inet_stream_connect()
> takes:
> 
> 		err = sk->sk_prot->connect(sk, uaddr, addr_len);
> 		if (err < 0)
> 			goto out;
> 
> so it never reaches the sock_error: label that calls ->disconnect(), and
> mptcp_disconnect() does not run. The socket stays SS_UNCONNECTED with
> sk_state TCP_CLOSE, which is exactly what __inet_stream_connect() requires
> to accept a second connect(), and __mptcp_nmpc_sk() also permits
> TCPF_CLOSE. The later mptcp_set_state(sk, TCP_SYN_SENT) and
> mptcp_set_state(sk, TCP_ESTABLISHED) do not clear the bit.
> 
> Second path, a failed listen() and inheritance by accepted sockets.
> mptcp_listen() unconditionally does:
> 
> 	err = __inet_listen_sk(ssk, backlog);
> 	release_sock(ssk);
> 	mptcp_set_state(sk, inet_sk_state_load(ssk));
> 
> which is TCP_CLOSE on failure, so the bit is latched on the listener; a
> later successful listen() only sets TCP_LISTEN. mptcp_sk_clone_init() then
> creates accepted sockets with sk_clone_lock(), which copies the whole
> struct mptcp_sock, msk->flags included, and __mptcp_init_sock() re-inits
> the lists, timers and allow_* fields but not msk->flags.
> 
> With the bit stuck, mptcp_reset_rtx_timer() is a permanent no-op.
> MPTCP_WORK_RTX and MPTCP_RETRANSMIT are set only by
> mptcp_retransmit_timer(), so does that mean __mptcp_retrans() can never run
> for such a socket, leaving data reinjected into msk->rtx_queue when a
> subflow stalls or dies unretransmitted, and DATA_FIN retransmission
> disabled, while the write side keeps its sndbuf pinned?
> 
> The previous guard read the live socket state, so it stopped applying on the
> next state transition. Would clearing the bit in __mptcp_init_sock(), and on
> the connect()/listen() retry paths, restore that property?
Both remarks here are a combo of pre-existing races and behaviour change
with this patch. Still I think they should be addresses within the same
scope. A new revision will be needed.

/P

