Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D20217723
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785424726; cv=none; b=iVdp0Yvx9BF4BYYeNlfqSqitAvSAWdS9EnBIr1kSRzeuDwh2ZDrDiUhcbgF7MJKePMCATSqymYEM3fhpiOyNtrwnE5Z2WE+bH8IRKT3cuyYWq6HBlJgq1t3Ilm7vgiMEVv/y5GSzYdRoBddueIAUzR6qlIxF+JfBLSEh5GNGIJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785424726; c=relaxed/simple;
	bh=h5azTfTdsQecE0ROVj7121HPNhwA9IB24RUVmg+kkZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vzmk+M1xYtitUhKoyeGJvNF4ywlcc723eCN32q3qQJyMa71WrBzWIk8ygDT11pjvMaPQtp+vBy/121RkJ6GPNYAAsTqQLAkZVFh/Ir3DM+9xnv5uHLQff/r8k5E9bYNHqYiKqqfndtQHOljed2rGyMUQDQpghm2WhZ9YGLuxgCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GU8PGYtv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GU8PGYtv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785424724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qabSmWZbh4+lyECTr/zxNFbn/7MHJscLfcfuYLLaRlQ=;
	b=GU8PGYtvddTCaG3/QQ3KVpJbBJJC7tRMdchWqN0lXkzI+Z0Lil6ynqVtJV0cUX6cIjWJn4
	yx3e6MvRDaDVZDCQJA40woJXOu/E5QCYQ6JtxlnsucGG65k2EWaW39ZtT04nEgI6K9hXz2
	HnSJvfZpdXUcsWJ0si0l/RWwH8psYC4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-uba-zcKBOwmnMvwk95DQxQ-1; Thu, 30 Jul 2026 11:18:42 -0400
X-MC-Unique: uba-zcKBOwmnMvwk95DQxQ-1
X-Mimecast-MFC-AGG-ID: uba-zcKBOwmnMvwk95DQxQ_1785424722
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f5a972b0eso2087639f8f.2
        for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 08:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785424722; x=1786029522;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qabSmWZbh4+lyECTr/zxNFbn/7MHJscLfcfuYLLaRlQ=;
        b=Vye/LQn3SkvDjkdqEIGNC9jNAYi+v6/fjvPKggtF7dCtpK4YVc+rHppB2qm3FNhYdq
         GUeBkAO061lRsCqwlc+pDwXWjiLu9v6CEuBTAKPRrficfXjexmQjPsRouPrcOJwILdC2
         lH+jc+lPnpwaO+NFkTi9CxPCHc7h92wzeHmDH1bRSkOUYa7nw/SpI7sjTbeBK5fUQc6M
         cR4abVjqLtUAFQaWFXh20JSHdYUlCJ1UISIlILwP+d3+9sN4S1wp4sNRrVHIkn/pp22w
         ZmcoL7lXfcu6biaHnSWUaEBePNdSxvI6jZvJ0cN1APWy0D+4PbT9+4AYMd+rcn/7MreY
         6X1Q==
X-Forwarded-Encrypted: i=1; AHgh+RrDhRW2rOhOap+Ex6tY41JUm0QyF+dm9hQnePTYjiF1IJoL4JjDN7qLHuUzTbKc7/YdcFf0Vw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEYE9lts47zM4gdNw5vIANTTXqJuv1iny5uRJAxcX2AJ6TjpGC
	eyEKys673gH0xhcc+n/x2EGXUVIY3t9CrMFpoEiORNHbfQJJYduPKl31LbdNR4iCxPT0dVatL4Y
	+OVIXG5On0t8v/jrCLFzHxdDlmj/uyuOcn+FuJK7aZp58KHUrkPweecsJabZuoOiq
X-Gm-Gg: AR+sD11KQWc6xncy4eL7KxEKZzDH9+AQqMlDp6CzKLzwRmCNAdrSdwoHO1R+elcrzXD
	GxkePfUJdc+hdDZlwvHst2NyEuIsAsMD3H1zinwBTB8OhV9nuSqIunwLhPqSS2Xr7VIrdBH4v1i
	4YVX2yYV8PTEMdmzSc2D8LZCBneYhXSJP/ziGynbI8Yhx/5wXcwI1Fx4WuuFMFucrQtUBgsWFJ6
	/hqTZHEW8/g1/WWk07tyIeibxn2VngOXdG/c//Q9BUZNr5FU9QgSabCuvgXuu6/y0XIX5dyFqg8
	gQX5UqDzRluH6eGKw57L+XMrG/WKIzUhd/9RSKD7d+sHU2hftj95KafXkg/5fEb/rVXpI8kJG1M
	OERIHK2/2ziTvWPwvIvvvxonI1I9nFXDSzPQNEbIRVkR8s7To/EKGm+zTv496Rwog0RmGPRQD1a
	X84g==
X-Received: by 2002:a5d:5f90:0:b0:47f:6fe0:294a with SMTP id ffacd0b85a97d-47fc81d06d2mr4190395f8f.23.1785424721719;
        Thu, 30 Jul 2026 08:18:41 -0700 (PDT)
X-Received: by 2002:a5d:5f90:0:b0:47f:6fe0:294a with SMTP id ffacd0b85a97d-47fc81d06d2mr4190339f8f.23.1785424721224;
        Thu, 30 Jul 2026 08:18:41 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc8941708sm7041020f8f.35.2026.07.30.08.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 08:18:40 -0700 (PDT)
Message-ID: <a1d3a399-afbc-4d61-80f9-9926f83da195@redhat.com>
Date: Thu, 30 Jul 2026 17:18:39 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 6/6] mptcp: defer sk_data_ready to the worker
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1785150300.git.tanggeliang@kylinos.cn>
 <5ab5630bc288d5af26ecacfcf29c7fe35f1fd670.1785150300.git.tanggeliang@kylinos.cn>
 <4fade36e-9dd5-4c53-8cb3-e07c66b387b5@redhat.com>
 <cf9d5167b823e22913da810fde35206c6d1e36e5.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <cf9d5167b823e22913da810fde35206c6d1e36e5.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tBQc0ythMG7o0E6IEffB0on3vhXpdCc6RRMJtK-Dm5k_1785424722
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/30/26 2:57 AM, Geliang Tang wrote:
> On Wed, 2026-07-29 at 10:55 +0200, Paolo Abeni wrote:
>> On 7/27/26 1:29 PM, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> When MPTCP carries TLS, the data path runs under mptcp_data_lock().
>>> Reaching sk->sk_data_ready(sk) synchronously ends up at
>>> tls_strp_check_rcv() -> mptcp_recv_skb() -> mptcp_move_skbs(),
>>> which
>>> calls mptcp_data_lock() on the same sk and recurses on
>>> sk_lock.slock.
>>
>> Is mptcp_move_skbs() really needed in mptcp_recv_skb()? Anyway it
>> looks 
>> like that is not the only constraint: AFAICS, before the
>> mptcp_recv_skb() 
>> calls, the TLS code would call __mptcp_read_sock() which in turns
>> calls  
>> mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf() that requires
>> holding 
>> the msk socket lock in process context, while the mptcp/TLS caller is
>> in 
>> BH scope.
>>
>>> Fix this by deferring sk->sk_data_ready(sk) to mptcp_worker() via a
>>> new MPTCP_WORK_DATA_READY bit, re-using the existing
>>> mptcp_schedule_work()/mptcp_cancel_work() infrastructure. The
>>> wakeup
>>> bit is consumed after the SOCK_DEAD && TCP_CLOSE destroy branch, so
>>> a
>>> socket that reaches the destroy path drops the pending wakeup
>>> rather
>>> than running it post-free.
>>
>> I think that unconditionally adding the work latency for non-TLS
>> application 
>> is a no-go.
>>
>> Instead I *think* that the constraints in __mptcp_read_sock() could
>> be relaxed
>> with something alike the following (completely untested):
> 
> Thank you for your patch. It is very useful, but when running TLS
> tests, it deadlocks with the mptcp_data_lock in mptcp_inq_hint(). 

This looks like an unrelated problem.

AFAICS tls calls tcp_in() under the sk socket lock, and the helper is
implemented accordingly (in fact is separated from tcp_inq_hint()). Even
the mptcp helper must use the same assumption. No need to call
additional locking, nor (AFAICS) ONCE annoation, as `ack_seq` and
`copied_seq` should be modified only under the msk socket lock.

> Currently, the implementation of mptcp_read_done() is as follows:
> 
> static void mptcp_read_done(struct sock *sk, size_t len)
> {
>         struct mptcp_sock *msk = mptcp_sk(sk);
>         struct sk_buff *skb;
>         size_t left;
>         u32 offset;
> 
>         msk_owned_by_me(msk);
> 
>         if (sk->sk_state == TCP_LISTEN)
>                 return;
> 
>         left = len;
>         while (left && (skb = mptcp_recv_skb(sk, &offset)) != NULL) {
>                 int used;
>                 
>                 used = min_t(size_t, skb->len - offset, left);
>                 msk->bytes_consumed += used;
>                 msk->copied_seq += used;
>                 left -= used;
>            
>                 if (skb->len > offset + used)
>                         break;
> 
>                 mptcp_eat_recv_skb(sk, skb);
>         }
>         
>         /* Clean up data we have read: This will do ACK frames. */
>         if (left != len) {
>                 msk->read_copied = len - left;

Possibly both here and in __mptcp_read_sock() should be:

		msk->read_copied += len - left

(note the '+=' operator instead of '=')

/P

