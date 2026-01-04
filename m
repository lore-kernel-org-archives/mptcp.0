Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB9A10785
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 03:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767497439; cv=none; b=RktgmC2Hr1vwfOHTl3nxg5q7+QR1A+v3UT0KPF+gBlPwCBTFN846QpDMDolUNT3MCnF427uEhFCGco5UkhQTI2YyIPkQjli77hNPNwCSkbV42bvwjEZ92qeq0ZRR0llKcz4CFIh1ZrIBwiZFfr/ythMFkIgbmkL8yKC1kkwOzrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767497439; c=relaxed/simple;
	bh=gbzhv4xmxkUX5AzIrCczY+cuOLJl+ommidtSiDR/UUQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZshJN5NIQVlbkiprSkhaHcbPcSqD7tZ2CcOk2SEApQVg+2yrK4MvcfkNf4oKCtkK3Jo5kWvwvL1Bd6erW3b8+7r40w6ztc8R47L2eETXqFQY/uKHbNgyyXWJJnCZLdR7Uq+CpnX6dL5V2o/c8coxqwmdypWp5mRKANqZbQqSfKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHBow9M5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHBow9M5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C89C4CEF7;
	Sun,  4 Jan 2026 03:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767497439;
	bh=gbzhv4xmxkUX5AzIrCczY+cuOLJl+ommidtSiDR/UUQ=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=sHBow9M5FZCZzl2SvS4weum98QJIf53qlcLNYJdpbNR+VT31FHn5HIOIon2JwNTbQ
	 3nI3Ar4uufKDlGltvUVMz9mftpHqu3iqlJCeNXaho9cYHODcXA8rlv97kdQwGNAivg
	 WqxNqjPdk1MUxFKAnZnJ/RkZY3bKZw6xJ2vbk6vZnGluelIw0DLLMrRb8tHfL2/+Jt
	 WodPJoAGXnq0YOIEXxoTWvqsoFtIETO0knujlEGN7EZyvYW+ANh3AYMGeSDjccS8H4
	 Ee6VRoD1TmrfAtXf/bTLo7YiPmiWbriPurCHtQ+Pn8A8MuIiIq0zpIv05NNvvu2Uy0
	 piWBcmQwsHYqQ==
Message-ID: <f142ce4aab700eff3bbbdebd6ee9d3b1fb370f7a.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 03/11] mptcp: only reset subflow errors when
 propagated
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Sun, 04 Jan 2026 11:30:30 +0800
In-Reply-To: <20251226-mptcp-issue-603-v1-3-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
	 <20251226-mptcp-issue-603-v1-3-bb30e331b839@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Fri, 2025-12-26 at 07:40 +0100, Matthieu Baerts (NGI0) wrote:
> Some subflow socket errors need to be reported to the MPTCP socket:
> the
> initial subflow connect (MP_CAPABLE), and the ones from the fallback
> sockets. The others are not propagated.
> 
> The issue is that sock_error() was used to retrieve the error, which
> was
> also resetting the sk_err field. Because of that, when notifying the
> userspace about subflow close events later on from the MPTCP worker,
> the
> ssk->sk_err field was always 0.
> 
> Now, the error (sk_err) is only reset when propagating it to the msk.
> 
> Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Note: I guess we could also duplicate the error in
> mptcp_subflow_context
> struct before scheduling the worker, and use this field in
> mptcp_event_put_token_and_ssk(), but I don't see why we should always
> reset ssk->sk_err in __mptcp_subflow_error_report() in all cases.
> ---
>  net/mptcp/protocol.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1d68648b5194..5d6c987089c6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -817,10 +817,9 @@ static bool __mptcp_ofo_queue(struct mptcp_sock
> *msk)
>  
>  static bool __mptcp_subflow_error_report(struct sock *sk, struct
> sock *ssk)
>  {
> -	int err = sock_error(ssk);
>  	int ssk_state;
>  
> -	if (!err)
> +	if (!READ_ONCE(ssk->sk_err))
>  		return false;

Your fix works. I'm wondering if swapping the order of 'if (sk-
>sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))'
and 'if (!err)' would be a bit simpler, i.e.:

int err = sock_error(ssk);
int ssk_state;

if (sk->sk_state != TCP_SYN_SENT &&
    !__mptcp_check_fallback(mptcp_sk(sk)))
        return false;

if (!err)
        return false;

WDYT?

Thanks,
-Geliang

>  
>  	/* only propagate errors on fallen-back sockets or
> @@ -837,7 +836,7 @@ static bool __mptcp_subflow_error_report(struct
> sock *sk, struct sock *ssk)
>  	ssk_state = inet_sk_state_load(ssk);
>  	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
>  		mptcp_set_state(sk, ssk_state);
> -	WRITE_ONCE(sk->sk_err, -err);
> +	WRITE_ONCE(sk->sk_err, -sock_error(ssk));
>  
>  	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
>  	smp_wmb();
