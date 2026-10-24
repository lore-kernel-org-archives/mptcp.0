Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859174;
	b=s3PQ7T3OXnpZ4HposLARwZp6N+3UM7w0tz80FYAzpkh7MGAJuYOQnNri1aKGd5Dyq6mC
	 TTa2BDS0LUcng2XCB/PoRHwDRwLdY3AqXjQJ3A00NsE/BwSGidZaRSJLOje67WtIP+FYM
	 HrjrIQcGNg4Pa6gnIaSjlDqbaRcDjaebw3FBfTHUu3w8d9FD6loUGDUMwkB+77vPvmFlr
	 c360Wlz3NyOmu4y7rpkf50d5tBVwT3ZJMLHQWHrpNrpXvIyL+lqzY9m5img+5rt23tnEn
	 L/nqzC4ZhwoowUWPEh+mkdgtANmzWroDwHu9M559OSmRAzV4DLlPX5+77OsdKeLVN3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859174;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lzz1YsW2a6XnYDT1uUA/zcXGXIMEREz6EfKQbXvgHgA=;
	b=mtEIr6cqMsW02pRqrSS2wMyUmcION1shVS1ViBQ1+3KkYggTICbo3mh+7wguwLm8Hw1f
	 3RcPzl/dpJcavNCrSH10bkwoD7a6Q+gaJwXgu3BKQK7O3Ib8eL+awIJzaiPO2zuBVZDdW
	 /aVNSQaHpTab0f6IiDmv8u1i0cy3YZQJHXCkfmwVJ8AimGQTjE3dsE9nLwA4cmDThE/xd
	 Pn/WYHQEomOndbZkztqOQWW+jF8e1v+HQla7Lx1x2GXHA2pjVLipjhJJaWjSYvA35vKYd
	 x1ZkRHA6uZoPGNMddC1JEMnh0rszEzfbku5EFqJu6OhbDOkL/DYFT3KAva1yF52mI8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fmNJ7Zas;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D072E606A329
	for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fmNJ7Zas
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CA51F01828;
	Sat, 24 Oct 2026 16:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792859173;
	bh=lzz1YsW2a6XnYDT1uUA/zcXGXIMEREz6EfKQbXvgHgA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fmNJ7ZasTez4nsPTLO48SMqFNtq+ERTcgEyiOXrsC9KPqbXE+HzMOoi09lRMtbOLM
	 BRcsLWTd7PaiOLr5duFwNi4d7v5DYHPFblxNlDc+0bCAaepuw8pbl70tn9kBw5AZaS
	 2S4Wlg2vJVlya8owvrrLQ/RHlvSniBNX2Djtc2ejnRRm/i4nEnVrZXf2wBke+movB6
	 ig5B0CL1YrnnSL72Q9ZPy7U7QxSIVSh/pW0U28p80cXbpIRiHVWzguvKuV9HSzJTTP
	 /rUUOCVAxcw0guTDyAlE1R+xuwU98sedx6sVnVyLzHyMRmkIug+6Xo5Y1NwewXxsAy
	 raWGzr8o1GJRg==
Subject: Re: [PATCH mptcp-next v15 09/11] mptcp: track app-limited state in
 mptcp_sendmsg
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, yangang@kylinos.cn, kuba@kernel.org
Date: Sat, 24 Oct 2026 16:26:13 +0000
Message-ID: <179285917304.3132.6958669428424790164@kernel.org>
In-Reply-To: =?utf-8?q?=3C38d46163209730399bc8927b0e37cdd79f9c4b70=2E1792718?=
 =?utf-8?q?041=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C38d46163209730399bc8927b0e37cdd79f9c4b70=2E17927180?=
 =?utf-8?q?41=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new early-return check in mptcp_rate_check_app_limited()
  (net/mptcp/protocol.c:2066-2067) is incomplete.
- [Low] The From/Signed-off-by addresses do not match in commit "mptcp:
  track app-limited state in mptcp_sendmsg".

--

mptcp: track app-limited state in mptcp_sendmsg

This commit adds mptcp_rate_check_app_limited(), which runs
tcp_rate_check_app_limited() on every subflow under the subflow socket
lock. It returns early when msk->write_seq != msk->snd_nxt. The helper is
called from mptcp_sendmsg_locked() so that subflow rate samples are marked
app-limited when the MPTCP connection is application-limited.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author address (geliang@kernel.org) and the
Signed-off-by address (tanggeliang@kylinos.cn) don't match. checkpatch
reports this as FROM_SIGN_OFF_MISMATCH.

Other patches in the same series sign off as geliang@kernel.org. Should the
Signed-off-by use the author address, or should the patch body carry a
From: line that matches the Signed-off-by?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 086de4f3100e0..7870b9be76c79 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2058,6 +2058,24 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
>  	}
>  }
>  
> +static void mptcp_rate_check_app_limited(struct sock *sk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> +
> +	if (msk->write_seq != msk->snd_nxt)
> +		return;

[Severity: Medium]
Is the sequence comparison alone enough to detect unsent data at the
MPTCP level?

During failover or stale-subflow recovery, __mptcp_retransmit_pending_data()
re-injects the rtx queue without moving snd_nxt back:

net/mptcp/protocol.c:__mptcp_retransmit_pending_data() {
    ...
	msk->recovery_snd_nxt = msk->snd_nxt;
	msk->recovery = true;
	mptcp_data_unlock(sk);

	msk->first_pending = rtx_head;
	msk->snd_burst = 0;
    ...
}

mptcp_update_post_push() only ever moves snd_nxt forward. So if the
application had already handed all its data down before recovery started,
write_seq == snd_nxt while mptcp_send_head(sk) still returns re-injected
data.

That backlog can last until the next sendmsg(). Some ways this happens:

  - mptcp_subflow_get_send() returns NULL because the best subflow is not
    sk_stream_memory_free()
  - __subflow_push_pending() bails out on a mptcp_sendmsg_frag() error
    without advancing first_pending
  - __subflow_push_pending() stops on !sk_stream_memory_free(ssk)

On the next sendmsg(), this guard passes and every subflow that looks idle
at the TCP level gets tp->app_limited set. Later in the same
mptcp_sendmsg_locked() call, __mptcp_push_pending() pushes the re-injected
data onto those subflows. Their delivery-rate samples are then flagged as
app-limited when they should not be.

With BBR, bbr_update_bw() skips app-limited samples that fall below the
current max_bw estimate:

	if (!rs->is_app_limited || bw >= bbr_max_bw(sk)) {

So the surviving subflow's bandwidth estimate cannot drop during the
failover. tcpi_delivery_rate_app_limited is also misreported.

mptcp_check_send_data_fin() asks the same "nothing left to push" question
and checks both conditions:

	if (!msk->snd_data_fin_enable || msk->snd_nxt + 1 != msk->write_seq ||
	    mptcp_send_head(sk))
		return;

Should this helper also return early when mptcp_send_head(sk) is
non-NULL?

This also affects the commit message, which says:

  The helper bails out early when MPTCP still has unsent data
  (msk->write_seq != msk->snd_nxt), because in that case the subflows may
  look idle only because mptcp_sendmsg_frag() has not pushed data down yet
  [ ... ] and marking them app-limited would be wrong.

If the check is extended, could the commit message be updated to match?

> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		bool slow;
> +
> +		slow = lock_sock_fast_nested(ssk);
> +		tcp_rate_check_app_limited(ssk);
> +		unlock_sock_fast(ssk, slow);
> +	}
> +}
> +
>  static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
> @@ -2086,6 +2104,9 @@ static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
>  
>  	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
>  
> +	/* is sending application-limited? */
> +	mptcp_rate_check_app_limited(sk);
> +
>  	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
>  		ret = sk_stream_wait_connect(sk, &timeo);
>  		if (ret)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792718041.git.tanggeliang%40kylinos.cn
