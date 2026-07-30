Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E341DDA18
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 00:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373037; cv=none; b=Y7xGSvjRtTy0AL2cz+h9MPZQQC8sapeHFDZ0h6JXiweZLABRc2xmbvaGguQwthZxcGCjb6Y3TJsZ5fNPOGghyQjNjwNIfvnwzCJVepUhLu4zJR0n4pfAQpPJx/t4a3Rtkvf00CZtuB4ec6qtPIxjUu6Rztl0qaA/Q9Qh2YaamO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373037; c=relaxed/simple;
	bh=ZgdF7Xb3aObp4OtJOxcDnSzluQKcg1X0+eCEdbBrdyg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q6Nhl0xur1h3Iy7oAv2s2eHEhstPBE+jRW+z1n6K5LCh1bvfu6EM72pnQSI78JSZNx3ShrxyUtgGhaCvtbzD5oH/DoqGY//V0a+r9vUcOKW/xy6JWGRz/4V09Ij4c/REOybTlrLW/gmRLb1g1w3irxjOrwwOzCZkcW0hNcIBcWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAy5DfsG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAy5DfsG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676011F000E9;
	Thu, 30 Jul 2026 00:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373036;
	bh=jNnxZB+r1Lossh6Tf+VgZcc2qDGlgRTdCZ9NRWq8Byk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VAy5DfsGhk35UR+MiLzAnW8MI9pTJFHZd/3QK3rwgOwIdTbZxT20lLedtnbPPaWLM
	 ALpkNWLA3q3oI+ZW13hEbqFQyZQ2nOmjCHK8ubbP9vI3rf6MJFyjguhWEmBgyJ00o5
	 4rUOEHyXdAgGk38LkZHumIaIBh26DnGQHVuuC2g23YccYIx/QBhIcrBycFouwa+8qj
	 2kgZU9zAD09EVqeufsloP28l741MQMZWlh54sDel9fmqotNSh9dU3wKysDfPrfkseP
	 EGFnSSsz72p5gMq9Ul0bbNTmOC3YN7gjX0p8oaozLasZFI4+qLTCOAPpdQUXJNOaE9
	 cPB06wjgfHZcw==
Message-ID: <cf9d5167b823e22913da810fde35206c6d1e36e5.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 6/6] mptcp: defer sk_data_ready to the worker
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 30 Jul 2026 08:57:11 +0800
In-Reply-To: <4fade36e-9dd5-4c53-8cb3-e07c66b387b5@redhat.com>
References: <cover.1785150300.git.tanggeliang@kylinos.cn>
	 <5ab5630bc288d5af26ecacfcf29c7fe35f1fd670.1785150300.git.tanggeliang@kylinos.cn>
	 <4fade36e-9dd5-4c53-8cb3-e07c66b387b5@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

On Wed, 2026-07-29 at 10:55 +0200, Paolo Abeni wrote:
> On 7/27/26 1:29 PM, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > When MPTCP carries TLS, the data path runs under mptcp_data_lock().
> > Reaching sk->sk_data_ready(sk) synchronously ends up at
> > tls_strp_check_rcv() -> mptcp_recv_skb() -> mptcp_move_skbs(),
> > which
> > calls mptcp_data_lock() on the same sk and recurses on
> > sk_lock.slock.
> 
> Is mptcp_move_skbs() really needed in mptcp_recv_skb()? Anyway it
> looks 
> like that is not the only constraint: AFAICS, before the
> mptcp_recv_skb() 
> calls, the TLS code would call __mptcp_read_sock() which in turns
> calls  
> mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf() that requires
> holding 
> the msk socket lock in process context, while the mptcp/TLS caller is
> in 
> BH scope.
> 
> > Fix this by deferring sk->sk_data_ready(sk) to mptcp_worker() via a
> > new MPTCP_WORK_DATA_READY bit, re-using the existing
> > mptcp_schedule_work()/mptcp_cancel_work() infrastructure. The
> > wakeup
> > bit is consumed after the SOCK_DEAD && TCP_CLOSE destroy branch, so
> > a
> > socket that reaches the destroy path drops the pending wakeup
> > rather
> > than running it post-free.
> 
> I think that unconditionally adding the work latency for non-TLS
> application 
> is a no-go.
> 
> Instead I *think* that the constraints in __mptcp_read_sock() could
> be relaxed
> with something alike the following (completely untested):

Thank you for your patch. It is very useful, but when running TLS
tests, it deadlocks with the mptcp_data_lock in mptcp_inq_hint(). TLS
calls mptcp_inq(), and my implementation of mptcp_inq() is a wrapper
around mptcp_inq_hint():

static int mptcp_inq(struct sock *sk)
{
        int answ;

        if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV)) {
                answ = 0; 
        } else {
                answ = mptcp_inq_hint(sk);

                if (answ &&
                    (sk->sk_state == TCP_CLOSE ||
                     (sk->sk_shutdown & RCV_SHUTDOWN)))
                        answ--;
        }

        return answ;
}

To eliminate this deadlock, I had to remove the mptcp_data_lock() from
mptcp_inq_hint() and replace it with READ_ONCE(). I'm not sure if this
is problematic:

@@ static unsigned int mptcp_inq_hint(struct sock *sk)
    const struct mptcp_sock *msk = mptcp_sk(sk);
    u64 hint_val;
 
-   /* Avoid races vs ack_seq updates. */
-   mptcp_data_lock(sk);
-   hint_val = msk->ack_seq - msk->copied_seq;
-   mptcp_data_unlock(sk);
+   hint_val = READ_ONCE(msk->ack_seq) - READ_ONCE(msk->copied_seq);
    if (hint_val >= INT_MAX)
        return INT_MAX;


Additionally, mptcp_read_done() also needs similar modifications to
those made in __mptcp_read_sock():

@@ static void mptcp_read_done(struct sock *sk, size_t len)
                mptcp_eat_recv_skb(sk, skb);
        }

-   mptcp_rcv_space_adjust(msk, len - left);
-
    /* Clean up data we have read: This will do ACK frames. */
-   if (left != len)
-       mptcp_cleanup_rbuf(msk, len - left);
+   if (left != len) {
+       msk->read_copied = len - left;
+       set_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags);
+       mptcp_schedule_work(sk);
+   }
 }

Currently, the implementation of mptcp_read_done() is as follows:

static void mptcp_read_done(struct sock *sk, size_t len)
{
        struct mptcp_sock *msk = mptcp_sk(sk);
        struct sk_buff *skb;
        size_t left;
        u32 offset;

        msk_owned_by_me(msk);

        if (sk->sk_state == TCP_LISTEN)
                return;

        left = len;
        while (left && (skb = mptcp_recv_skb(sk, &offset)) != NULL) {
                int used;
                
                used = min_t(size_t, skb->len - offset, left);
                msk->bytes_consumed += used;
                msk->copied_seq += used;
                left -= used;
           
                if (skb->len > offset + used)
                        break;

                mptcp_eat_recv_skb(sk, skb);
        }
        
        /* Clean up data we have read: This will do ACK frames. */
        if (left != len) {
                msk->read_copied = len - left;
                set_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags);
                mptcp_schedule_work(sk);
        }
}


Another issue, unrelated to this patch, is that I have defined a
.read_done interface for TLS, with tcp_read_done() and
mptcp_read_done() corresponding to TCP and MPTCP, respectively. This
.read_done interface is very similar to .read_sock, and .read_sock is a
generic interface in struct proto_ops. I'm wondering whether we could
add a .read_done interface to struct proto_ops, so that in TLS we could
call the protocol-specific .read_done via sk->sk_socket->ops-
>read_done(). I'm not sure if this is a good idea or whether upstream
would accept it. I'd like to hear your opinion.

Thank you very much.
-Geliang

> ---
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ca644ec53eed..b09e267f5d46 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2986,6 +2986,15 @@ static void mptcp_do_fastclose(struct sock
> *sk)
>  	}
>  }
>  
> +static void mptcp_read_complete(struct sock *sk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +
> +	mptcp_cleanup_rbuf(msk, msk->read_copied);
> +	mptcp_rcv_space_adjust(msk, msk->read_copied);
> +	msk->read_copied = 0;
> +}
> +
>  static void mptcp_worker(struct work_struct *work)
>  {
>  	struct mptcp_sock *msk = container_of(work, struct
> mptcp_sock, work);
> @@ -3026,6 +3035,9 @@ static void mptcp_worker(struct work_struct
> *work)
>  	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
>  		__mptcp_retrans(sk);
>  
> +	if (test_and_clear_bit(MPTCP_WORK_READ_COMPLETE, &msk-
> >flags))
> +		__mptcp_read_complete(sk);
> +
>  	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk-
> >first)->fail_tout) : 0;
>  	if (fail_tout && time_after(jiffies, fail_tout))
>  		mptcp_mp_fail_no_response(msk);
> @@ -4381,9 +4393,6 @@ static struct sk_buff *mptcp_recv_skb(struct
> sock *sk, u32 *off)
>  	struct sk_buff *skb;
>  	u32 offset;
>  
> -	if (!list_empty(&msk->backlog_list))
> -		mptcp_move_skbs(sk);
> -
>  	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
>  		offset = MPTCP_SKB_CB(skb)->offset;
>  		if (offset < skb->len) {
> @@ -4395,10 +4404,7 @@ static struct sk_buff *mptcp_recv_skb(struct
> sock *sk, u32 *off)
>  	return NULL;
>  }
>  
> -/*
> - * Note:
> - *	- It is assumed that the socket was locked by the caller.
> - */
> +/* Can be invoked in BH scope */
>  static int __mptcp_read_sock(struct sock *sk, read_descriptor_t
> *desc,
>  			     sk_read_actor_t recv_actor, bool noack)
>  {
> @@ -4441,11 +4447,14 @@ static int __mptcp_read_sock(struct sock *sk,
> read_descriptor_t *desc,
>  	if (noack)
>  		goto out;
>  
> -	mptcp_rcv_space_adjust(msk, copied);
> -
> +	/* The backlog flushing is only needed when some data is
> actually
> +	 * moved and will take place in the workers's release
> callback.
> +	 */
>  	if (copied > 0) {
>  		mptcp_recv_skb(sk, &offset);
> -		mptcp_cleanup_rbuf(msk, copied);
> +		msk->read_copied = copied;
> +		set_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags);
> +		mptcp_schedule_work(sk);
>  	}
>  out:
>  	return copied;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 4a2d40cd7b13..89902a98d383 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -115,6 +115,7 @@
>  #define MPTCP_WORK_RTX		1
>  #define MPTCP_FALLBACK_DONE	2
>  #define MPTCP_WORK_CLOSE_SUBFLOW 3
> +#define MPTCP_WORK_READ_COMPLETE 4
>  
>  /* MPTCP socket release cb flags */
>  #define MPTCP_PUSH_PENDING	1
> @@ -305,6 +306,7 @@ struct mptcp_sock {
>  	u32		last_data_sent;
>  	u32		last_data_recv;
>  	u32		last_ack_recv;
> +	int		read_copied;
>  	unsigned long	timer_ival;
>  	u32		token;
>  	unsigned long	flags;
