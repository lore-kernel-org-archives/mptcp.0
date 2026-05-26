Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CC735E1B8
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 06:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779775867; cv=none; b=Yv2BU8cEvNTew1WIndMF3FvPhB9Ap1JckWqsBqC8vLdme6cpSBVKCt7dEeaAgIP9aTdNHMRnLsPpg9u4s0o5lVV9lwGtkInfrUpPWnBYPQFjcE9NSFXihDATsAd1PDk7uVaLTgj98Ujvon2i0eH08mZiBRyjFXVwFPjmsmY49EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779775867; c=relaxed/simple;
	bh=xAXRGABw5N+mU4luxMwdqcFxxB5fUH9RMcWvSMhLrPo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FuKA0jcIcuARntKFzyqVaVzDNtkRpJwE3rFBQQHCces3lsHUrWDX01YikU58gmzfujDD8sEfrj2OFC0DcN05KSM44PIbNd69YGccJR2lOMQB1HxWx3Tm3qWntmkU07mr6YIU3uEM+WRckBGjyAnO4gO/uBatNZoFHELlrTNJH8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fauMwsvN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fauMwsvN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29491F000E9;
	Tue, 26 May 2026 06:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779775865;
	bh=CKdfZmIg1ElwDlP/Dex3ChlgH/h0TGMH/r4U6yfvMlw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fauMwsvNAh8Th24dgmTAbOFOQmtPuXnrjPz/sFVVh612wbDY8cKO72jQvdCcmvp3d
	 2pGGXXw5hXeAa7aEDwFvwnczJc/VCOBoyKSn2Ht6LY3tRRPP4tMpQkGdHKzM+NqH3F
	 mGChiI+NUrFOVknRnsTX08nlbbm5ccA9kUP8heM2GQM2jl4y1VyKz5V3tMaAcI45rG
	 OaY6sF5NwfTLX7eAooK9OwoHPG/FBHUDWJ5xq38raKKTv+XDID20TdOLbXohn2Ap8X
	 zx35i4MphZJU4cUR16PPGpfXT7iqabm5ZXhUm15zEXWmrsSPU22t+ScTD6jatsnEAR
	 aF7+AWykhPSBg==
Message-ID: <ed237923f5af60e22739deb2d2bc924f62c1ace9.camel@kernel.org>
Subject: Re: [PATCH v8 mptcp-next 3/9] mptcp: close TOCTOU race while
 computing rcv_wnd
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>, gang.yan@linux.dev
Date: Tue, 26 May 2026 14:10:58 +0800
In-Reply-To: <a8ae9961db6c482c439b6cc7e16514d908af61f2.1779485511.git.pabeni@redhat.com>
References: <cover.1779485511.git.pabeni@redhat.com>
	 <a8ae9961db6c482c439b6cc7e16514d908af61f2.1779485511.git.pabeni@redhat.com>
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

On Fri, 2026-05-22 at 23:43 +0200, Paolo Abeni wrote:
> The MPTCP output path access locklessly the MPTCP-level ack_seq
> in multiple times, using possibly different values for the data_ack
> in the DSS option and to compute the announced rcv wnd for the same
> packet.
> 
> Refactor the cote to avoid inconsistencies which may confuse the
> peer. Also ensure that the MPTCP level rcv wnd is updated only when
> the egress packet actually contains a DSS ack.
> 
> Fixes: fa3fe2b15031 ("mptcp: track window announced to peer")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/options.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 4cc583fdc7a9..4d72f286a485 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -570,7 +570,6 @@ static bool mptcp_established_options_dss(struct
> sock *sk, struct sk_buff *skb,
>  	struct mptcp_ext *mpext;
>  	unsigned int ack_size;
>  	bool ret = false;
> -	u64 ack_seq;
>  
>  	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
>  	mpext = skb ? mptcp_get_ext(skb) : NULL;
> @@ -601,14 +600,11 @@ static bool
> mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
>  		return ret;
>  	}
>  
> -	ack_seq = READ_ONCE(msk->ack_seq);
>  	if (READ_ONCE(msk->use_64bit_ack)) {
>  		ack_size = TCPOLEN_MPTCP_DSS_ACK64;
> -		opts->ext_copy.data_ack = ack_seq;
>  		opts->ext_copy.ack64 = 1;
>  	} else {
>  		ack_size = TCPOLEN_MPTCP_DSS_ACK32;
> -		opts->ext_copy.data_ack32 = (uint32_t)ack_seq;
>  		opts->ext_copy.ack64 = 0;
>  	}
>  	opts->ext_copy.use_ack = 1;
> @@ -1298,19 +1294,14 @@ bool mptcp_incoming_options(struct sock *sk,
> struct sk_buff *skb)
>  	return true;
>  }
>  
> -static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
> +static u64 mptcp_set_rwin(struct mptcp_sock *msk, struct tcp_sock
> *tp,
> +			  struct tcphdr *th, u64 ack_seq)
>  {
>  	const struct sock *ssk = (const struct sock *)tp;
> -	struct mptcp_subflow_context *subflow;
> -	u64 ack_seq, rcv_wnd_old, rcv_wnd_new;
> -	struct mptcp_sock *msk;
> +	u64 rcv_wnd_old, rcv_wnd_new;
>  	u32 new_win;
>  	u64 win;
>  
> -	subflow = mptcp_subflow_ctx(ssk);
> -	msk = mptcp_sk(subflow->conn);
> -
> -	ack_seq = READ_ONCE(msk->ack_seq);
>  	rcv_wnd_new = ack_seq + tp->rcv_wnd;
>  
>  	rcv_wnd_old = atomic64_read(&msk->rcv_wnd_sent);
> @@ -1363,7 +1354,7 @@ static void mptcp_set_rwin(struct tcp_sock *tp,
> struct tcphdr *th)
>  
>  update_wspace:
>  	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
> -	subflow->rcv_wnd_sent = rcv_wnd_new;
> +	return rcv_wnd_new;
>  }
>  
>  static void mptcp_track_rwin(struct tcp_sock *tp)
> @@ -1475,13 +1466,25 @@ void mptcp_write_options(struct tcphdr *th,
> __be32 *ptr, struct tcp_sock *tp,
>  		*ptr++ = mptcp_option(MPTCPOPT_DSS, len, 0, flags);
>  
>  		if (mpext->use_ack) {
> +			struct mptcp_sock *msk;
> +			u64 ack_seq;
> +
> +			/* DSS option is set only by
> mptcp_established_option,
> +			 * the caller is __tcp_transmit_skb() and
> ssk is always
> +			 * not NULL.
> +			 */
> +			subflow = mptcp_subflow_ctx(ssk);
> +			msk = mptcp_sk(subflow->conn);
> +			ack_seq = READ_ONCE(msk->ack_seq);
>  			if (mpext->ack64) {
> -				put_unaligned_be64(mpext->data_ack,
> ptr);
> +				put_unaligned_be64(ack_seq, ptr);
>  				ptr += 2;
>  			} else {
> -				put_unaligned_be32(mpext-
> >data_ack32, ptr);

This patch makes data_ack and data_ack32 in struct mptcp_ext no longer
used. Can they be removed from struct mptcp_ext, and update
mptcp_dump_mpext() in include/trace/events/mptcp.h accordingly?

Thanks,
-Geliang

> +				put_unaligned_be32(ack_seq, ptr);
>  				ptr += 1;
>  			}
> +			subflow->rcv_wnd_sent = mptcp_set_rwin(msk,
> tp, th,
> +							      
> ack_seq);
>  		}
>  
>  		if (mpext->use_map) {
> @@ -1709,9 +1712,6 @@ void mptcp_write_options(struct tcphdr *th,
> __be32 *ptr, struct tcp_sock *tp,
>  			i += 4;
>  		}
>  	}
> -
> -	if (tp)
> -		mptcp_set_rwin(tp, th);
>  }
>  
>  __be32 mptcp_get_reset_option(const struct sk_buff *skb)
