Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415552;
	b=3rMR1eqK9/euveDy+3rWmN+gnTeWua63iVON2q51kIGJ2gLQLEvuLKKnWezCSFdpQOBw
	 1lm7wkD5wcmQqTBCpFNv86ZXovJ4DDQsJXplj/uZzdxPToNxoX46jkPkDbiHeKyfL2C0Q
	 pJIkYtpm8q5sBrvDo0vQThCvG7v9JWKFqWrJ/kDpO7cup03DQ7edcV39cH0wgo2Wr/zH2
	 sYH5Dou0t/DlZqSu9dPn2CBchI/C/3Xu+mWZAQy6GA9Q4uTj8ksxeY8CzHaKrOBql982E
	 /glWqIM0bCx6tnMef/W7GlAV9Q54W2wAFUbY33pDqv1b/kOZ18mJmPz8YK9JNOZ9bkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415552;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3FKFbn3YnyWJqZpGgqhhspAvdXeYjrMTCHEOYCtFm7o=;
	b=xAji4cRWYGhUavDO7SpAyUW0umNGSfPBAa4C6UCBE80hWN7UHxTovticfV9OHyXxIjjP
	 y+y0A2gV43dnvOOQnc7P97jChiPyk1ulby9nKP/kAY7bJD8W3tTRC8txKi3hQOPBBtn7v
	 xp+WXZCeqYFywDIjBK8q6FZVnqCRaxtw2cJ3hWNn80t/sNYimWz0IoBIISMZxR+q+ezfX
	 2L/V8Aa+QmsWmZbA/LOloAnhfWoI3ebW3REd/Bn6BPLEmRoqELl5A/QZsNPuPFMrLm8Vi
	 YRBkztBd++KEuRZPz/WbbxcJ1OTguTX774Dsqc0AExeX7TowVqvcfJhsHaKge86Q5Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsbeEgaM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04196606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsbeEgaM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F861F000D8;
	Mon, 23 Nov 2026 06:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415551;
	bh=3FKFbn3YnyWJqZpGgqhhspAvdXeYjrMTCHEOYCtFm7o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nsbeEgaMCRv35pmMd9VCaERnHmQE2r2URNaGIjyNaToedxqnJbtPlXJGlhtDSHRqs
	 KM5WHvSrgMlozvMClBqBGJN/dfGSWk4u9/I1cvgmD2aFGJ3idlcmo+/w0myRJ1WNgT
	 Bmk8WEcJwrS67jN/zd+wlq+MENh1LpBcRuWgY5eHaakxb6sKTgwy506YkSP9bdaS5a
	 UQQAYVB3tQN8SmzNxwZjwU0/ezioZL7zoRniDkSjnpFqAUCx6/JlxQY7g8ub6pnuTU
	 zASaZa6FZXBLwNlBstESH8M3/dh7WDIoZ/FAqqU6RuZ1dxS2efhWiSLXn0EroFgDzO
	 ZuX80Q0A3K99g==
Subject: Re: [PATCH mptcp-net v2 24/62] mptcp: process pending close events at
 accept()
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 06:32:31 +0000
Message-ID: <179541555125.3133.3545716635498279995@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-24-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-24-00327fd1de1f@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mptcp: dummy fallback DATA_FIN processed on reset in
  mptcp_stream_accept()

--

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4679,8 +4679,10 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
>  		 * deal with bad peers not doing a complete shutdown.
>  		 */
>  		if (unlikely(inet_sk_state_load(msk->first) == TCP_CLOSE)) {
> -			if (unlikely(list_is_singular(&msk->conn_list)))
> +			if (unlikely(list_is_singular(&msk->conn_list))) {
> +				mptcp_check_rcv_close(newsk);
>  				mptcp_set_state(newsk, TCP_CLOSE);
> +			}
>  			mptcp_close_ssk(newsk, msk->first,
>  					mptcp_subflow_ctx(msk->first));
>  		}
>

[Severity: Medium]
Could this new call change the result for a fallback socket that gets
a TCP RST before accept()?

If the passive msk falls back to TCP after the MP_CAPABLE handshake,
and the peer then resets msk->first without sending a FIN,
subflow_sched_work_if_closed() sees subflow_is_done() and emulates a
DATA_FIN by setting msk->rcv_data_fin. That happens even though
SOCK_DONE is not set on msk->first.

While the msk is still in the accept queue, sk->sk_socket is NULL.
subflow_error_report() therefore returns early, and the reset is never
propagated to newsk->sk_err.

mptcp_check_rcv_close(newsk) then calls mptcp_check_data_fin(), which
consumes the emulated DATA_FIN. SOCK_DONE is correctly left unset,
because msk->first has no SOCK_DONE. However, RCV_SHUTDOWN is still
set, and newsk moves from TCP_ESTABLISHED to TCP_CLOSE_WAIT.

mptcp_close_ssk() on msk->first then takes the !dispose_it branch in
__mptcp_close_ssk(). That branch jumps to out and skips
__mptcp_subflow_error_report(). newsk->sk_err stays at 0, so after the
queued data, recv() returns 0 (clean EOF) rather than -ECONNRESET.

With the follow-up "mptcp: report errors as TCP does when closing"
applied, mptcp_close_last_err() does pick up msk->first->sk_err. But
mptcp_reset_err() now sees TCP_CLOSE_WAIT and reports EPIPE instead of
ECONNRESET, while SOCK_DONE is still unset.

Should the emulated fallback DATA_FIN be ignored here when
msk->first was reset without a FIN? Or should the subflow error be
latched on newsk before mptcp_check_rcv_close() runs? I'm not sure
which one fits better with the rest of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f%40kernel.org
