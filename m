Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873F440DFC5
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776846536; cv=none; b=kw/L7QmZ/LmbvgSYMMNyHOomnvMvszx4U/uBFMx7A9YWN8YbXsaQaV/nms3psNlRnuo1COkreUVL8dx2iG47bXBRQeY4rwoQebThxKiYZop9s9jQJ0ysWOiBsGsRU2YxjcBuEtXx+pZ9ugzH05fhDvRy1AGT61+uF25cCKbL/vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776846536; c=relaxed/simple;
	bh=m3YCAxs2lIsSA48OKwHAbFjJJWktYst2l9z2uQCstSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5RV/V1PDwmfnYEt6bkXcZ5gTIUxJ6O46dU3U4LDsX8PO2LQdVIfficEpfTAKWH8OYl9u/bgCLK/2nRlfTc4OgCGa9rNb+50oIVSoXhxZ8RhtoFwxgPguts5dyuE6R0nXVeSdqcy2z1wZYrzOSIEI8p9ajmcW0EFI5oloSJtt94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J86HtPRM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J86HtPRM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776846533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhPOS+Cf0WY5K+zwOdszmaYSZLkIw6zQCGMKwzRtdkU=;
	b=J86HtPRMkdduSXj81ReudAvIRHVaCc4DcZ3H3+lVkcqQ4OtfEbvsLwtZKEKrfFx5qpjGFq
	Udh7wlZnoclGLYnvLyzJNB6MCoXVwOBxyMhgueRAJWLt3sBMlJjiTAH0VVNmWF4ikc8mCD
	/AKh9K9IBCwSXGuJ3KOPbZy2hEzTUBg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-K-lGQd2JOUq9zyc--K3tfA-1; Wed, 22 Apr 2026 04:28:52 -0400
X-MC-Unique: K-lGQd2JOUq9zyc--K3tfA-1
X-Mimecast-MFC-AGG-ID: K-lGQd2JOUq9zyc--K3tfA_1776846531
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43fe791a398so4219233f8f.0
        for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 01:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776846531; x=1777451331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhPOS+Cf0WY5K+zwOdszmaYSZLkIw6zQCGMKwzRtdkU=;
        b=fQ81W27pdfUk3HcO+Bm4Fwiev5JwD+8yvQXQZzl5ncn9f7AF4tVHO7GT4nfYsPkUjj
         5YdllsaakSldnc2dU/qs0+wIrMkfugsaHNdz8YwrBgqaHCfjhwIscYYS/6974+ul1sAO
         IJMLoyVhrMYd9wTH5BR74hXMOJR6blCmPOOO+s70ttkn9CsEefw/trp2Q46LCvThhexE
         xFjR3DC0MRPzY1vC8tIgLuVEM57QK6VUh8eR0+koSulAGlIqxIgKN0wNvouUAedgFNQU
         lEvxc9oDyOXms2vhojDkKhyBLBv8djs/w6gh1cRiMGowkUXggnNcmxDNpySb1d8BSp91
         KKLw==
X-Forwarded-Encrypted: i=1; AFNElJ9fIT9sEwc87IeYnii5RfOBxqoTU/E73VZ0NIkAbFT+mU69dURoB65PySXVhgT1RpfcNzITFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YytFBngQxsC9NwGgi7udbto3JaZ/xBhcMbDAxb0drO601Ey8zWG
	mJ+j+E9Y32kG4VEHREwwrT21R+DkXwX7BinH6AxMQQgkDcRlkGoXQRbOiZV9gJ2Yi762t4ck0x6
	F+OACLuMH7Laog+5hNnzGZaNLaRkg01+po5YWbaGQ0PI50PYI5l0Ca8Df
X-Gm-Gg: AeBDiev2IsvMZtcvYeLgpuNUg9SIlshKHhi+rxLyZnKcYS5umH+1vDypy3D1zQT38OX
	sDnO6I/ENGF8iwHewLTTOmsAGyuJFEQFLMh8xEmL4Ru1AV25IGMDnJppFciMrcNDHfPI64k7Wz5
	eFWsepl6+6hJrq19rW+JHEu0j/NJ7maLZsIWQm+rmNXICiUr9w5t2oDktegCs7yyDBiz2idjrKZ
	n//gWdbyw1nPfJ4+Dr0V6Kcv5L4mt8HL8eWJ27+8vfuHj4pPHPsQjObFN1YHP3SvETVwqBpysAq
	yshNULhCGaHeI8qfKAOsnOJfiJsBjcyCrLBhauTdCcK035u4lYALwACfw3t7/Gs08r0oJICnL/C
	91SdJ+/VjjRDDPzG4yvUP8xPYJ+7ZE1wl4tpgEjpLxDPL1J4zVzP6mxPTvBc/DlHJdwM=
X-Received: by 2002:adf:f144:0:b0:43d:7946:baee with SMTP id ffacd0b85a97d-43fe3e0db1fmr22762418f8f.23.1776846530882;
        Wed, 22 Apr 2026 01:28:50 -0700 (PDT)
X-Received: by 2002:adf:f144:0:b0:43d:7946:baee with SMTP id ffacd0b85a97d-43fe3e0db1fmr22762374f8f.23.1776846530271;
        Wed, 22 Apr 2026 01:28:50 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1365sm46442243f8f.7.2026.04.22.01.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 01:28:49 -0700 (PDT)
Message-ID: <c730724c-6bc4-4b24-ac45-50ae1662ef97@redhat.com>
Date: Wed, 22 Apr 2026 10:28:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 2/3] mptcp: support MSG_ERRQUEUE on the
 parent socket
To: David Carlier <devnexen@gmail.com>, mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <20260421223338.52743-1-devnexen@gmail.com>
 <20260421223338.52743-3-devnexen@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260421223338.52743-3-devnexen@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: llimschGYTZ80OJTSWJGsnIRTWdznFM-kt--c-8msYE_1776846531
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/26 12:33 AM, David Carlier wrote:
> Handle MSG_ERRQUEUE on the MPTCP socket by selecting a subflow with
> pending errqueue data, moving one error skb to the parent socket, and
> consuming it through the parent socket ABI.
> 
> This surfaces subflow errqueue activity through poll(), keeps the
> userspace ABI tied to the socket being used, and restores the skb to
> the subflow errqueue if requeueing to the parent fails under rmem
> pressure.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> Assisted-by: Codex:gpt-5
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  net/mptcp/protocol.c | 123 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 103 insertions(+), 20 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6b486fc94c16..87871216bab2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -818,28 +818,29 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
>  static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
>  {
>  	int ssk_state;
> -	int err;
> +	int err = 0;
> +	bool has_errqueue;

Reverse christmas tree above.

> +
> +	has_errqueue = !skb_queue_empty_lockless(&ssk->sk_error_queue);
>  
> -	/* only propagate errors on fallen-back sockets or
> -	 * on MPC connect
> +	/* Only fallback sockets and the MPC connect path inherit TCP's sk_err
> +	 * semantics; consume ssk->sk_err only on those paths so steady-state
> +	 * MPTCP doesn't silently drop TCP's one-shot errors.
>  	 */
> -	if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))
> -		return false;
> +	if (sk->sk_state == TCP_SYN_SENT ||
> +	    __mptcp_check_fallback(mptcp_sk(sk))) {
> +		err = sock_error(ssk);
> +		if (err) {
> +			ssk_state = inet_sk_state_load(ssk);
> +			if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
> +				mptcp_set_state(sk, ssk_state);
> +			WRITE_ONCE(sk->sk_err, -err);
> +		}
> +	}
>  
> -	err = sock_error(ssk);
> -	if (!err)
> +	if (!err && !has_errqueue)
>  		return false;
>  
> -	/* We need to propagate only transition to CLOSE state.
> -	 * Orphaned socket will see such state change via
> -	 * subflow_sched_work_if_closed() and that path will properly
> -	 * destroy the msk as needed.
> -	 */
> -	ssk_state = inet_sk_state_load(ssk);
> -	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
> -		mptcp_set_state(sk, ssk_state);
> -	WRITE_ONCE(sk->sk_err, -err);

Avoid reordering the code: it makes the patch more complex and hard to
read. Keep the existing path as-is and add the needed handling under the
existing:

	if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))

condition. If needed use goto/label to consolidate the return path.

More important: am not sure propagating subflow errors to the main
socket is the right thing. A fatal error on a subflow does not affect
the mptcp unless there is a single active subflow. Application will
start receiving unexpected errors when the transfer is working just fine.

 -
>  	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
>  	smp_wmb();
>  	sk_error_report(sk);
> @@ -2286,6 +2287,68 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
>  	return 0;
>  }
>  
> +static struct sock *mptcp_pick_errqueue_subflow(struct sock *sk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *ssk = NULL;
> +
> +	lock_sock(sk);
> +	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
> +		struct sock *subflow_sk = mptcp_subflow_tcp_sock(subflow);
> +
> +		if (skb_queue_empty_lockless(&subflow_sk->sk_error_queue))
> +			continue;
> +
> +		if (!refcount_inc_not_zero(&subflow_sk->sk_refcnt))
> +			continue;
> +
> +		ssk = subflow_sk;
> +		break;
> +	}
> +	release_sock(sk);
> +
> +	return ssk;
> +}
> +
> +static bool mptcp_has_error_queue(const struct sock *sk)
> +{
> +	return !skb_queue_empty_lockless(&sk->sk_error_queue);
> +}
> +
> +static int mptcp_recv_error(struct sock *sk, struct msghdr *msg, int len)
> +{
> +	struct sk_buff *skb;
> +	struct sock *ssk;
> +	int ret, ret2;
> +
> +	if (READ_ONCE(sk->sk_err) || mptcp_has_error_queue(sk))
> +		return inet_recv_error(sk, msg, len);
> +
> +	ssk = mptcp_pick_errqueue_subflow(sk);
> +	if (!ssk)
> +		return -EAGAIN;
> +
> +	skb = sock_dequeue_err_skb(ssk);
> +	if (!skb)
> +		goto put_ssk;
> +
> +	ret = sock_queue_err_skb(sk, skb);
> +	if (ret) {
> +		ret2 = sock_queue_err_skb(ssk, skb);
> +		sock_put(ssk);
> +		if (ret2)
> +			kfree_skb(skb);
> +		return ret;
> +	}
> +
> +	sock_put(ssk);
> +	return inet_recv_error(sk, msg, len);
> +
> +put_ssk:
> +	sock_put(ssk);
> +	return -EAGAIN;
> +}
> +
>  static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  			 int flags)
>  {
> @@ -2295,9 +2358,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  	int target;
>  	long timeo;
>  
> -	/* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */
>  	if (unlikely(flags & MSG_ERRQUEUE))
> -		return inet_recv_error(sk, msg, len);
> +		return mptcp_recv_error(sk, msg, len);
>  
>  	lock_sock(sk);
>  	if (unlikely(sk->sk_state == TCP_LISTEN)) {
> @@ -4296,6 +4358,26 @@ static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
>  	return 0;
>  }
>  
> +static bool mptcp_subflow_has_error(struct sock *sk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	bool has_error = false;
> +
> +	mptcp_data_lock(sk);
> +	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +		if (READ_ONCE(ssk->sk_err) ||
> +		    !skb_queue_empty_lockless(&ssk->sk_error_queue)) {
> +			has_error = true;
> +			break;
> +		}
> +	}
> +	mptcp_data_unlock(sk);

The data lock is not enough to protect the subflows list, and
unconditionally acquiring it in the poll callback is an no go (will
impact performances negatively).

_If_ error propagation makes sense, you should probably try to move the
err skb from the subflow error queue into the msk one at
sk_error_queue() time.

/P

