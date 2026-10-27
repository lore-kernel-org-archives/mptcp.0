Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134542;
	b=URvhgAF43NGlwyiT2xMuvNlENbS64gBQeQiPZJTTvHQw3VkhoPxeF8cBySiH7GgUU5xd
	 +tP6WuShJwS6Pt9QCidHUZ67KYpdneCZKCuh+bGa+ZrI/9DlcpdM0D87R3IKnhT+TFtdl
	 m/3bXX288DQpMPfQp9j3hY7BE0oSfZTcMudixbEHgZBVof+rSzKPlxqBBG/ewd05nkhjr
	 CDqZbS4kg7Yd2mkUY89eZRw9bYDf3iAJyI94f/eWXSoqEvGdEWNQAaRRjtC5YnpqHxc8g
	 2OzMHjMFLNL7YNXE4k3wWPPdH4vwxI+tPalR7k7oihas0W/b0t6lz5UDcBMIVg75IAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134542;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gvNIgibGJc7rKV4XbF5XKyKq0LseK4s026fcuxk+iQc=;
	b=L2bKR1qWoZ9LlFhsQbTm4I7zCiYZd3+j+e967+rQ3smAAeNd4iOiXn2VezEVGx2Y7nmN
	 sS91DOiUvzFFm5THzOHbwpL/9WMCvEb0F5v6P176Ar5D1ugzdE43S3NiUNMNBqUCGyGZi
	 3ZIZlC+D/NVo/xp81OLzIQizfgV68/x8+GrApF8AnDcrCU50fqobY4tbJz+u7IFodyj9q
	 wS96e+keRToQjF/u3idEHebCq6aOUwT50bMsei/tVLOmDoo3XyEAorTY2hfpC7Qqwy9/M
	 DLiz3sstdgTNMhUoaB8tpbIe31NCs0Sq62onCIJomM8Tz12NIPk7NLhZF9R/MMrVivg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hz3Wxl84;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32643606A31A
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hz3Wxl84
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A471F01825;
	Tue, 27 Oct 2026 20:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793134541;
	bh=gvNIgibGJc7rKV4XbF5XKyKq0LseK4s026fcuxk+iQc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hz3Wxl84Y1UAU2q63kn+bimAsJX352erUPj9QLeKuPIFcfjeCrDbJceEjFtb5wzQ7
	 0DEW7yW19IIKYk/QuWXwSZ9hoXIMw13AZaODIsa8nn6jWN9gOse971FVB+77vLLs2R
	 1r42WZiV1k2PFCbeWpuPexrkKZVtjG5dgnt2Rggq9DIIIHrBhMC69ZPaHktSJf6Jju
	 AAaMFo9jNBDJH3ZHpU0Wl7arTVpo86EwUxPQ/4IUy+RDFiB5KcA208PJ0DLin+XtvV
	 ABOzpiTK/N4t28Wx3PmTsD9tKpCPeRVmIB91R8pZkeg41nDQOvwkYLSUPnHkf+2WCK
	 bOeUqn9S32X2A==
Subject: Re: [PATCH mptcp-next 2/6] mptcp: prevent dummy DATA_FIN on RST in
 fallback mode
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Tue, 27 Oct 2026 20:55:41 +0000
Message-ID: <179313454109.3132.7704558912692124192@kernel.org>
In-Reply-To: =?utf-8?q?=3C827c399d23b97b70e59e123d32c7b4b74d3f3987=2E1792999?=
 =?utf-8?q?988=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C827c399d23b97b70e59e123d32c7b4b74d3f3987=2E17929999?=
 =?utf-8?q?88=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix does not prevent the dummy DATA_FIN in the common RST
  case.
- [Medium] subflow_is_done() now returns false whenever ssk->sk_err is
  non-zero, even when the subflow got a clean FIN (TCP_CLOSE_WAIT /…
- [Low] The From: and Signed-off-by: email addresses do not match.

--

mptcp: prevent dummy DATA_FIN on RST in fallback mode

This patch adds an sk_err check to subflow_is_done(). The goal is that
subflow_sched_work_if_closed() no longer creates a dummy DATA_FIN when a
fallback subflow is closed by a TCP RST, because a RST is an abortive close
and not a clean FIN.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the Author address (geliang@kernel.org) doesn't match
the Signed-off-by address (tanggeliang@kylinos.cn). checkpatch.pl reports
this as a From:/Signed-off-by: email address mismatch.

Could the two addresses be made to match, or could a Signed-off-by for the
author address be added?

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 78e886b202585..a53c83644a40b 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1327,6 +1327,9 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
>  
>  static bool subflow_is_done(const struct sock *sk)
>  {
> +	if (READ_ONCE(sk->sk_err))
> +		return false;
> +

[Severity: High]
In the common RST case, is sk_err still set when the last
subflow_sched_work_if_closed() call runs?

sock_error() reads the error and clears it:

include/net/sock.h:sock_error() {
    ...
	err = xchg(&sk->sk_err, 0);
    ...
}

On a RST, tcp_done_with_error() sets ssk->sk_err. tcp_done() then moves the
subflow to TCP_CLOSE and calls subflow_state_change():

net/mptcp/subflow.c:subflow_state_change() {
    ...
	if (mptcp_subflow_data_available(sk))
		mptcp_data_ready(parent, sk);
	else if (unlikely(READ_ONCE(sk->sk_err)))
		subflow_error_report(sk);

	subflow_sched_work_if_closed(mptcp_sk(parent), sk);
}

If the rx queue is empty, mptcp_subflow_data_available() takes the no_data
path. That path calls subflow_sched_work_if_closed() once while sk_err is
still set, so the new check returns false there.

Next, subflow_error_report() runs. When msk->sk_socket is set and the msk
is not owned by user, the call chain is:

subflow_error_report()
  __mptcp_error_report()
    __mptcp_subflow_error_report()
      err = sock_error(ssk);          /* clears ssk->sk_err */
      mptcp_set_state(sk, ssk_state); /* msk -> TCP_CLOSE */

On a fallback msk this clears ssk->sk_err. The unconditional
subflow_sched_work_if_closed() call at the end of subflow_state_change()
then sees sk_err == 0 and sk_state == TCP_CLOSE. subflow_is_done() returns
true, and mptcp_update_rcv_data_fin() records the dummy DATA_FIN anyway.

When the rx queue is not empty, the result looks the same.
mptcp_data_ready()->move_skbs_to_msk() also clears the error:

	if (unlikely(READ_ONCE(ssk->sk_err)))
		__mptcp_subflow_error_report(sk, ssk);

Any later no_data->subflow_sched_work_if_closed() call then creates the
DATA_FIN.

The suppression seems to work only while the error is still pending. That
is the case when the msk is owned by user and the report is deferred via
MPTCP_ERROR_REPORT, or when msk->sk_socket is NULL. So whether a RST
produces a dummy DATA_FIN depends on msk lock ownership at the time the RST
arrives.

Would it be more reliable to record the abort in state that survives error
consumption, such as a subflow flag set at reset time, instead of relying
on sk_err?

[Severity: Medium]
Could this early return also suppress the legitimate dummy DATA_FIN after
a clean FIN, when an unrelated error is still pending on the subflow?

The new check returns false for any non-zero sk_err, even when RCV_SHUTDOWN
is set. Consider a fallback msk with IP_RECVERR set, which
mptcp_setsockopt_recverr() propagates to the subflows:

1. An ICMP error arrives on the established fallback subflow. tcp_v4_err()
   sets ssk->sk_err and calls subflow_error_report().

2. The msk is owned by user, so the report is deferred:

	if (!sock_owned_by_user(sk))
		__mptcp_error_report(sk);
	else
		__set_bit(MPTCP_ERROR_REPORT,  &mptcp_sk(sk)->cb_flags);

   The same happens if msk->sk_socket is NULL, because
   subflow_error_report() returns early. Either way ssk->sk_err stays set.

3. The peer's FIN arrives before release_sock(). The subflow moves to
   TCP_CLOSE_WAIT while the msk is still ESTABLISHED.
   subflow_sched_work_if_closed() passes the state and queue checks, but
   subflow_is_done() now returns false, so no dummy DATA_FIN is recorded.

4. Later, mptcp_release_cb() calls __mptcp_error_report(), which clears
   sk_err. Because ssk_state is TCP_CLOSE_WAIT, the msk state is left
   unchanged. Nothing calls subflow_sched_work_if_closed() again.

The worker doesn't seem to recover from this either, because
__mptcp_close_subflow() skips CLOSE_WAIT subflows on fallback sockets:

		if (ssk_state != TCP_CLOSE &&
		    (ssk_state != TCP_CLOSE_WAIT ||
		     inet_sk_state_load(sk) != TCP_ESTABLISHED ||
		     __mptcp_check_fallback(msk)))
			continue;

Would the msk then never get RCV_SHUTDOWN? That would leave recvmsg() and
poll() waiting for an EOF that has already arrived. Before this patch,
step 3 always recorded the dummy DATA_FIN.

>  	return sk->sk_shutdown & RCV_SHUTDOWN || sk->sk_state == TCP_CLOSE;
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792999988.git.tanggeliang%40kylinos.cn
