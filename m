Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794739990;
	b=cm3mvThEP3RMkKYQl9G3Uw8YnxD3l0qV1A278YgKJwa2SdYvEPcjSJS0QnCrzOmM/fYn
	 xZM0/0mG/za2lzOdjetT5YGhgw99Swvpk5VVvmCdgNrWG3uZYhFJbA3S5QAJ3BvICjYBi
	 CBCvK0EpYo3ztFzQC7GY8N1JX8pa2hgVyJz65DyFDzGm0nTzcQv46Op6iyCHai/sQe/8F
	 Yr8Gs1/wHxj3s2VIh+hcHCYnjWOYo+f2tf1SJ5IZbDFg3EpC48W8pVaPEG0SJF06/EQxh
	 juiR67C6dIEuLxcaEqokxyEYY1VcKs59ThbqcxvrgCdYFCLJrYKNeGaNVrBjnlLausQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794739990;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/DxnfivjUPxtJqkhydBJQveX/aLHb0PnVkdLh3Vpcbo=;
	b=gnk8GybhfUpfzD34NPPDI9cZ2djGSIBtD/OFSE8S2dtqQxD8Z1BHda4l4DOHUP3ET2OM
	 S38+BBQAn46dMw9L80hGW2YrY93sECH5lwJe8FwgvZeEgONO0RVgYi0UlAm1DzGM1Zyjw
	 HsQxQb2e35QGO3M8gkzDQ07KFskOajnIUQQMkXZ4N7wBOa2yljNnjnG6IdTB5DQLqIosQ
	 FVAneA+QisT/dhbL8J1j/e6jqw839FHuRmzHUA2GftSvGp+Wt6DMErsHgRj1CHPKZ+3bB
	 OEZ/Aj5J6+PMRKuZ3atLC2XaOJ3BynT7qqvcYOoXZji+bC50nA9V2eP6opig5/BV/mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXJxVeTs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC97606A31A
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXJxVeTs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183541F000CC;
	Sun, 15 Nov 2026 10:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794739990;
	bh=/DxnfivjUPxtJqkhydBJQveX/aLHb0PnVkdLh3Vpcbo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DXJxVeTsjCm/AgvRrVT82PtRPoPaDoKS5KFiRyC5+CjpyEu65/t0Cwe0+M3H54Bw4
	 MF0yHsD4jwEEDPlVRisvbBQN6ZkGsE5+pX9FF8dyiHFsziKmPzCX23ZYiZEWMyoGan
	 ZKniYPl4ra0tjBXiLtc1xGaGzrUnQht4qlqspXnYZhK19BB+0Haj9A1pJ4YbuI9Ne0
	 jVR0JYmyTiBDSpOuNP/q+wPzH6eXk1IXe97eD7Cf3Vj83WvXv465ngUM+d+ywvBw0x
	 hIJhl5wtqVg75RvMYmYj4vRaYaOzZq/qo/OpqKbSNp9mSLlsRzPlmyCaFN4wHpNXSZ
	 TpRQOvqh7QgQA==
Subject: Re: [PATCH mptcp-net 20/34] mptcp: stop resending data to a peer that
 fell back
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc:
 mptcp@lists.linux.dev, mason@kernel.org, pabeni@redhat.com, kuba@kernel.org
Date: Sun, 15 Nov 2026 10:53:09 +0000
Message-ID: <179473998963.488855.838731666551688528@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-20-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-20-9205b77e9a2f@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In mptcp_incoming_options() (net/mptcp/options.c:1274-1278), the
  patch changes what clears subflow->old_data_pending.
- [Low] The new reset in mptcp_sendmsg_frag() (net/mptcp/protocol.c:1547)
  increments MPTCP_MIB_FALLBACKFAILED.
- [Low] The new mptcp_subflow_reset() in mptcp_sendmsg_frag() can run
  while mptcp_incoming_options() is still processing an incoming segment…

--

mptcp: stop resending data to a peer that fell back

This patch resets an MPTCP subflow when mptcp_sendmsg_frag() is about to
queue more old data and only bare TCP ACKs have acknowledged the old data
queued so far. It also lets any MPTCP option, not only a DSS, clear
old_data_pending, as long as it is not an infinite mapping. It also skips
a zero window probe while the subflow's TCP retransmit queue holds data.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 682a7b93d9627..6790c9e15521e 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1271,6 +1271,12 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
>  		return sk->sk_state != TCP_CLOSE;
>  
> +	/* MPTCP opt acking the old data, not an infinite map: no fallback */
> +	if (unlikely(subflow->old_data_pending) && mp_opt.suboptions &&
> +	    !(mp_opt.use_map && !mp_opt.data_len) &&
> +	    !before(TCP_SKB_CB(skb)->ack_seq, subflow->old_data_end))
> +		subflow->old_data_pending = 0;
> +

[Severity: Low]
Before this patch, only a DSS that acked old_data_end could clear
old_data_pending. Now any MPTCP suboption that acks it can, except an
infinite mapping. The field comment in struct mptcp_subflow_context was
updated, but the comment where the bit is set still says that only a DSS
clears it:

net/mptcp/protocol.c:mptcp_sendmsg_frag() {
    ...
	/* old data mapped again: no fallback until acked with a DSS */
	if (unlikely(before64(data_seq, msk->snd_nxt))) {
		mptcp_subflow_ctx(ssk)->old_data_end = tcp_sk(ssk)->write_seq;
		mptcp_subflow_ctx(ssk)->old_data_pending = 1;
	}
    ...
}

Should this comment be updated too? It is still the same at the end of
the series.

Two other places read the bit. Both were added by "mptcp: do not fallback
while old data is in flight". The first is the fallback refusal in
mptcp_try_fallback():

	if (subflow->old_data_pending && !__mptcp_check_fallback(msk))
		return false;

The second is the infinite map deferral in mptcp_sendmsg_frag():

	if (mptcp_subflow_ctx(ssk)->send_infinite_map &&
	    !mptcp_subflow_ctx(ssk)->old_data_pending)
		mptcp_update_infinite_map(msk, ssk, mpext);

A non-DSS option such as ADD_ADDR, RM_ADDR, MP_PRIO or MP_FAIL now
releases both of them.

The relaxation itself looks fine. After a fallback,
mptcp_established_options() sends no MPTCP options other than an infinite
map, so such an option shows that the peer was still in MPTCP mode.
However, the commit message only presents the change as part of the new
reset test.

Could the commit message also mention that these two paths are affected?

[ ... ]

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7329deb43c622..388e77da8f16c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -1527,11 +1528,29 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,

[ ... ]

>  		zero_window_probe = true;
>  		data_seq = snd_una - 1;
>  		copy = 1;
>  	}
>  
> +	/* old data acked without MPTCP opts: the peer may have fallen back */
> +	if (unlikely(before64(data_seq, msk->snd_nxt) &&
> +		     subflow->old_data_pending &&
> +		     !before(tcp_sk(ssk)->snd_una, subflow->old_data_end))) {
> +		tcp_remove_empty_skb(ssk);
> +		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);

[Severity: Low]
This isn't a bug, but net/mptcp/mib.h documents this counter as:

	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */

Every other increment site comes after a failed mptcp_try_fallback()
call. This one makes no fallback attempt and resets the subflow based on
subflow-local state.

The commit message explains the choice ("the peer has likely fallen back,
but this side cannot"). In this state, the old_data_pending guard would
indeed refuse mptcp_try_fallback().

Would it be worth broadening the mib.h comment to cover this reset as
well? The wording was already a bit off after the previous commit, since
mptcp_try_fallback() can now also refuse because of the subflow-level
old_data_pending and map_old flags.

> +		subflow->reset_transient = 0;
> +		subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
> +		mptcp_subflow_reset(ssk);
> +		return -EAGAIN;
> +	}

[Severity: Low]
Can this reset run while mptcp_incoming_options() is still processing a
segment on the same subflow? ack_update_msk() pushes on the same ssk
while it handles incoming options:

tcp_data_queue()
  mptcp_incoming_options()
    ack_update_msk()
      __mptcp_check_push()          /* msk->wnd_end after snd_nxt */
        __mptcp_subflow_push_pending(sk, ssk, false)
          __subflow_push_pending()
            mptcp_sendmsg_frag()
              mptcp_subflow_reset(ssk)
                tcp_done(ssk)

The reset condition can hold here if data_seq is below msk->snd_nxt, for
example after __mptcp_retransmit_pending_data() rewinds first_pending. It
also requires that the current segment did not clear old_data_pending.
That happens in two cases:

- its DSS is an infinite mapping that acks past old_data_end
- it is a reordered DSS segment with ack_seq below old_data_end, after an
  earlier ACK without options already moved snd_una past old_data_end

tcp_ack() treats the second case as an old ack, so tcp_data_queue() still
runs.

On return, mptcp_incoming_options() does not re-check sk_state:

	if (mp_opt.use_ack && ack_update_msk(msk, sk, skb, &mp_opt))
		subflow->dss_confirmed = 1; /* MPTCP opts pass both ways */
	rwin_update(msk, sk, skb);

It goes on to skb_ext_add() and returns true. tcp_data_queue() then
queues the segment on a TCP_CLOSE subflow whose sk_receive_queue was just
purged. If the segment carries an in-sequence FIN, tcp_fin() would reach
its "Impossible, sk->sk_state=7" pr_err.

This seems to contradict the comment earlier in mptcp_incoming_options():

	/* The subflow can be in close state only if check_fully_established()
	 * just sent a reset. If so, tell the caller to ignore the current packet.
	 */

The effects look mostly benign. There is no deadlock, since
subflow->resetting is set, and infinite mapping data is not delivered.

A narrower version of this already existed through
mptcp_update_infinite_map()->mptcp_try_fallback()->mptcp_subflow_reset(),
but this patch adds a new trigger.

Should mptcp_incoming_options() check sk->sk_state after ack_update_msk(),
the way the check_fully_established() path does?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f%40kernel.org
