Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02BB431E73
	for <mptcp@lists.linux.dev>; Mon, 10 Aug 2026 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386399; cv=none; b=qwyEICairD9zsyt01LH0wcol8z9+8RsVSwV5gW9y3YBv8/p9+7AVXmCPp7l5pSRfK8p6rw1EgWSKxKsdMCJSIVRDhwvWqOYOJWml0ODzzjTbroxryA/ilGhmPkoJLwAOuC3yL2zo6sgFCl/4xbEehCflPA8+C4/l+jd0SUM3tYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386399; c=relaxed/simple;
	bh=+gvuKVo2PAgdZNIxtIXqNQEe2imo8jDX/IRrkv7yQYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQrDROb+N627fV1qDpYu5B0F82k0dY96VjIqqBS1qPFT7zSvOsgk8R5MdVYK95pVSlGE6Yn7itmL/V/lAKYJ77a/fbpVhoVQNCHeDcJvgzKKU6GI9MP5h1emJKGaVkSMQt2uyy9hLc+7Ou4q/qn3dFxAfMhpnq0NnPtJ8X6EeJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWMPosDS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWMPosDS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243AA1F000E9;
	Mon, 10 Aug 2026 18:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786386397;
	bh=0wP74IlmN7bEwG2Wm/PaL6JBgMz5DPAUIh422il7wYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AWMPosDSnEsGhX2EmuYyWpDa/KhcIprKtno7Wjz0a8a6wsPXZiScVEg15uuhbakNs
	 K/RG1xq8SY44o2ryUiduvaIw0/KQis0xQfrGY8zWD/CwJeQpylqM8tLbcHz/6NRxuD
	 7jspBUnqaltXPiJuf9fIo1ptRQy6PLnBJlpGcF50lURvJ8NbpoL6u5BDH4jaqHdOb4
	 xKLrAgwgRAfytFNRx+UQaPCE9efHX/l8c/26qKPSCEEwypF7tZfZZswj9neCm3IUej
	 GDEe9WevSvjotWF+j+IiwrzxmS2mYHKCyN6jgLMXdXAc6Nt6exl5c3cwJwJvgeaF26
	 1z0hqzUFED/Uw==
Message-ID: <b2828798-945d-4dbf-80c3-3d77a293a5e2@kernel.org>
Date: Mon, 10 Aug 2026 20:26:35 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 1/3] mptcp: fallback to TCP on MP_FAIL with a
 single subflow
Content-Language: fr
To: Chenguang Zhao <chenguang.zhao@linux.dev>, mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260715061830.1057851-1-chenguang.zhao@linux.dev>
 <20260715061830.1057851-2-chenguang.zhao@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260715061830.1057851-2-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Chenguang,

On 15/07/2026 08:18, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> When a valid MP_FAIL is received and infinite fallback is still allowed
> (single contiguous subflow), RFC8684 §3.7 requires leaving MPTCP mode.
> The stack only cleared allow_subflows and deferred the real fallback to
> the later infinite-map transmit path. Before any data is sent, a peer
> could still complete the 4th ACK as MPTCP and keep using MPTCP options.
> 
> Fall back immediately after sending the MP_FAIL response, and teach
> mptcp_is_fully_established() to reject joins after fallback or when
> subflows are disallowed. If the out-of-order queue is non-empty, reset
> the subflow instead of leaving a half-fallback state.
> 
> Fixes: 1e39e5a32ad7 ("mptcp: infinite mapping sending")

Thank you for this fix. However, it is a bit big, and it might be
difficult to backport.

> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  net/mptcp/pm.c       | 51 +++++++++++++++++++++++++++++++++++++++++++-
>  net/mptcp/protocol.c |  7 +++++-
>  net/mptcp/protocol.h | 18 ++++++++++------
>  3 files changed, 67 insertions(+), 9 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 6afd39aea110..c1f5c3ced4ee 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -870,7 +870,15 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>  
>  	pr_debug("fail_seq=%llu\n", fail_seq);
>  
> -	/* After accepting the fail, we can't create any other subflows */
> +	/* MP_FAIL on a single contiguous subflow: fall back to TCP.
> +	 * allow_infinite_fallback is cleared once other subflows join or
> +	 * non-contiguous data is retransmitted; in that case ignore MP_FAIL
> +	 * here (the peer should reset the failing subflow instead).
> +	 *
> +	 * Send the MP_FAIL (+ DSS) response before setting FALLBACK_DONE,
> +	 * otherwise mptcp_established_options() would drop all MPTCP options
> +	 * on this ACK. InfiniteMapTx is accounted later when the map is sent.
> +	 */
>  	spin_lock_bh(&msk->fallback_lock);
>  	if (!msk->allow_infinite_fallback) {
>  		spin_unlock_bh(&msk->fallback_lock);
> @@ -882,9 +890,50 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>  	if (!subflow->fail_tout) {
>  		pr_debug("send MP_FAIL response and infinite map\n");
>  
> +		/* Infinite mapping requires contiguous data. With OoO still
> +		 * queued, do not leave allow_subflows=false without
> +		 * FALLBACK_DONE; tear the subflow down instead (RFC8684 §3.7).
> +		 */

Maybe enough to just say:

 /* RFC8684 §3.7: Infinite mapping requires contiguous data */
> +		if (!RB_EMPTY_ROOT(&msk->out_of_order_queue)) {
> +			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_FALLBACKFAILED);
> +			subflow->send_mp_fail = 1;

I didn't check the reason, by why do you need to set this before the reset?

> +			mptcp_subflow_reset(sk);
> +			return;
> +		}

This could maybe go in a dedicated commit? Easier to explain and
backport, no? Also, it is different from "fallback to TCP on MP_FAIL
with a single subflow".

Also, out_of_order_queue() is checked in mptcp_try_fallback(), maybe
this part is not needed? I guess it is still needed because we don't
want to send an MP_FAIL here. But do we want to send an MP_FAIL also in
case of fallback with a single subflow?
Note: maybe we do, I didn't check the RFC about this specific case, but
if it is not clear about that, maybe easier to check for fallback before
sending the MP_FAIL → in theory, we shouldn't get an MP_FAIL with a
single subflow, except with checksum IIRC, so let's use the simplest
path for this unlikely case. WDYT?

>  		subflow->send_mp_fail = 1;
>  		subflow->send_infinite_map = 1;
>  		tcp_send_ack(sk);
> +
> +		/* RFC8684 §3.7: after accepting MP_FAIL with a single
> +		 * subflow, leave MPTCP mode and never revert. No dedicated
> +		 * fallback MIB yet; InfiniteMapTx is counted when the map
> +		 * is transmitted. Handle pending DATA_FIN like
> +		 * mptcp_try_fallback().
> +		 */

Maybe just:

  /* RFC8684 §3.7: fallback with a single subflow */


> +		spin_lock_bh(&msk->fallback_lock);
> +		if (__mptcp_check_fallback(msk)) {
> +			spin_unlock_bh(&msk->fallback_lock);
> +			return;
> +		}
> +		if (!msk->allow_infinite_fallback) {
> +			spin_unlock_bh(&msk->fallback_lock);
> +			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_FALLBACKFAILED);
> +			mptcp_subflow_reset(sk);
> +			return;
> +		}
> +		set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
> +		spin_unlock_bh(&msk->fallback_lock);
> +
> +		if (READ_ONCE(msk->snd_data_fin_enable) &&
> +		    !(sk->sk_shutdown & SEND_SHUTDOWN)) {
> +			gfp_t saved_allocation = sk->sk_allocation;
> +
> +			sk->sk_allocation = GFP_ATOMIC;
> +			sk->sk_shutdown |= SEND_SHUTDOWN;
> +			tcp_shutdown(sk, SEND_SHUTDOWN);
> +			sk->sk_allocation = saved_allocation;
> +		}

Quite a bit of duplicated code. I think it would be better to introduce
patch 3 first, with the following tag, then use mptcp_try_fallback() here:

  Fixes: c65c2e3bae69 ("mptcp: track fallbacks accurately via mibs")

(or use another MIB counter, and change it in -next? I don't think
that's better)

WDYT?

>  	} else {
>  		pr_debug("MP_FAIL response received\n");
>  		WRITE_ONCE(subflow->fail_tout, 0);
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index cb9515f505aa..5b9522caaf43 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1299,7 +1299,12 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
>  	mpext->infinite_map = 1;
>  	mpext->data_len = 0;
>  
> -	if (!mptcp_try_fallback(ssk, MPTCP_MIB_INFINITEMAPTX)) {
> +	/* Fallback may already have been completed on MP_FAIL reception;
> +	 * still account for the infinite mapping being transmitted.
> +	 */
> +	if (__mptcp_check_fallback(msk)) {
> +		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
> +	} else if (!mptcp_try_fallback(ssk, MPTCP_MIB_INFINITEMAPTX)) {
>  		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
>  		mptcp_subflow_reset(ssk);
>  		return;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 4a2d40cd7b13..03f0b33694d7 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -369,7 +369,7 @@ struct mptcp_sock {
>  
>  	spinlock_t	fallback_lock;	/* protects fallback,
>  					 * allow_infinite_fallback and
> -					 * allow_join
> +					 * allow_subflows

Probably best to fix that only on -next: this will cause issues during
the backport, just to fix a comment introduced by another commit.

>  					 */
>  
>  	struct list_head backlog_list;	/* protected by the data lock */
> @@ -947,12 +947,6 @@ static inline void mptcp_start_tout_timer(struct sock *sk)
>  	mptcp_reset_tout_timer(mptcp_sk(sk), 0);
>  }
>  
> -static inline bool mptcp_is_fully_established(struct sock *sk)
> -{
> -	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
> -	       READ_ONCE(mptcp_sk(sk)->fully_established);
> -}
> -
>  static inline u64 mptcp_stamp(void)
>  {
>  	return div_u64(tcp_clock_ns(), NSEC_PER_USEC);
> @@ -1290,6 +1284,16 @@ static inline bool mptcp_check_fallback(const struct sock *sk)
>  	return __mptcp_check_fallback(msk);
>  }
>  
> +static inline bool mptcp_is_fully_established(struct sock *sk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +
> +	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
> +	       READ_ONCE(msk->fully_established) &&
> +	       !__mptcp_check_fallback(msk) &&
> +	       msk->allow_subflows;
> +}

I wonder if this modification shouldn't be split to a dedicated commit:
that part is important to avoid the kernel to "ignore" the MP_FAIL
received before being fully established.

Also, when thinking about that (but not checking the code), is the
modification you did above to fallback directly when an MP_FAIL is
received not enough?

Or maybe only __mptcp_check_fallback() should be added, and no need to
look at allow_subflows? (then patch 2/3 is not needed).

WDYT?

>  static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
>  {
>  	struct sock *ssk = READ_ONCE(msk->first);

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

