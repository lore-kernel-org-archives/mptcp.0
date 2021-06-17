Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257A672
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 00:05:39 +0000 (UTC)
IronPort-SDR: G5KNDTeE/KUY5wEtufOaJIbXPuOmCk/ABg/LZL3EAz47lEXgKrmiV9kGgkspY0ObI3Qp0K9T2/
 X9pFKZOuN+hA==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="193397868"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="193397868"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 17:05:38 -0700
IronPort-SDR: pRqx1g9nZ3ilPsJxMAME4oOUTqsLVI2exDtbLbcWH5XL7DCvnSMXuUYUzZdzhZUaHjwBSMg9IT
 ZZlBpRzPdnPg==
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="450817638"
Received: from ndalili-mobl.amr.corp.intel.com ([10.209.105.124])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 17:05:38 -0700
Date: Wed, 16 Jun 2021 17:05:37 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-net] mptcp: fix bad handling of 32 bit ack
 wrap-around.
In-Reply-To: <140f8561f1ba22d171c1acc35812b571b63c8836.1623831447.git.pabeni@redhat.com>
Message-ID: <99e6884d-9611-ddec-96da-511bf665cf15@linux.intel.com>
References: <140f8561f1ba22d171c1acc35812b571b63c8836.1623831447.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 16 Jun 2021, Paolo Abeni wrote:

> When receiving 32 bits DSS ack from the peer, the MPTCP need
> to expand them to 64 bits value. The current code is buggy
> WRT detecting 32 bits ack wrap-around: when the wrap-around
> happens the current unsigned 32 bit ack value is lower than
> the previous one.
>
> Additionally check for possible reverse wrap and make the helper
> visible, so that we could re-use it for the next patch.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/204
> Fixes: cc9d25669866 ("mptcp: update per unacked sequence on pkt reception")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
> - fix comment typos
> - refactor to unify the code with the next patch.
>   [yep I did just the opposite of my own plan ;)]

Ok with me :)
Looks good and tests work.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> net/mptcp/options.c  | 29 +++++++++++++++--------------
> net/mptcp/protocol.h |  8 ++++++++
> 2 files changed, 23 insertions(+), 14 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index a05270996613..b5850afea343 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -942,19 +942,20 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
> 	return false;
> }
>
> -static u64 expand_ack(u64 old_ack, u64 cur_ack, bool use_64bit)
> +u64 __mptcp_expand_seq(u64 old_seq, u64 cur_seq)
> {
> -	u32 old_ack32, cur_ack32;
> -
> -	if (use_64bit)
> -		return cur_ack;
> -
> -	old_ack32 = (u32)old_ack;
> -	cur_ack32 = (u32)cur_ack;
> -	cur_ack = (old_ack & GENMASK_ULL(63, 32)) + cur_ack32;
> -	if (unlikely(before(cur_ack32, old_ack32)))
> -		return cur_ack + (1LL << 32);
> -	return cur_ack;
> +	u32 old_seq32, cur_seq32;
> +
> +	old_seq32 = (u32)old_seq;
> +	cur_seq32 = (u32)cur_seq;
> +	cur_seq = (old_seq & GENMASK_ULL(63, 32)) + cur_seq32;
> +	if (unlikely(cur_seq32 < old_seq32 && before(old_seq32, cur_seq32)))
> +		return cur_seq + (1LL << 32);
> +
> +	/* reverse wrap could happen, too */
> +	if (unlikely(cur_seq32 > old_seq32 && after(old_seq32, cur_seq32)))
> +		return cur_seq - (1LL << 32);
> +	return cur_seq;
> }
>
> static void ack_update_msk(struct mptcp_sock *msk,
> @@ -972,7 +973,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
> 	 * more dangerous than missing an ack
> 	 */
> 	old_snd_una = msk->snd_una;
> -	new_snd_una = expand_ack(old_snd_una, mp_opt->data_ack, mp_opt->ack64);
> +	new_snd_una = mptcp_expand_seq(old_snd_una, mp_opt->data_ack, mp_opt->ack64);
>
> 	/* ACK for data not even sent yet? Ignore. */
> 	if (after64(new_snd_una, snd_nxt))
> @@ -1009,7 +1010,7 @@ bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool us
> 		return false;
>
> 	WRITE_ONCE(msk->rcv_data_fin_seq,
> -		   expand_ack(READ_ONCE(msk->ack_seq), data_fin_seq, use_64bit));
> +		   mptcp_expand_seq(READ_ONCE(msk->ack_seq), data_fin_seq, use_64bit));
> 	WRITE_ONCE(msk->rcv_data_fin, 1);
>
> 	return true;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f4eaa5f57e3f..41f2957bf50c 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -615,6 +615,14 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
> int mptcp_getsockopt(struct sock *sk, int level, int optname,
> 		     char __user *optval, int __user *option);
>
> +u64 __mptcp_expand_seq(u64 old_seq, u64 cur_seq);
> +static inline u64 mptcp_expand_seq(u64 old_seq, u64 cur_seq, bool use_64bit)
> +{
> +	if (use_64bit)
> +		return cur_seq;
> +
> +	return __mptcp_expand_seq(old_seq, cur_seq);
> +}
> void __mptcp_check_push(struct sock *sk, struct sock *ssk);
> void __mptcp_data_acked(struct sock *sk);
> void __mptcp_error_report(struct sock *sk);
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
