Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793454954;
	b=SyoXV5BzG259r4qKA8GHpQYWVf4FRzrwsQRRNOv0Kwlw3ExiqjXzZfeE51nCOmvs1L6x
	 6E4ewXCRNa5xydItCS2OTAKaL5S9H0lBvv72g1aU+GJQgaGFTJdZ/N4sBqPOunzWg1fna
	 ENuS7VWlS7pfO0rNkvh9kta5Hs+CgeNGSPMjS509lCfuazAmcwUQIYEPkGwbTkgMIuYqN
	 CX2+EcIS/3M+uPWKa8QBCY8wbciKFYuT1jR1JKKlqmcRbzWiI6QwvTEApkZkY4RCevHhg
	 OMN9/z5k/X4s+R/hM0Mi5kF+EFE3LDUni3YCmG8M1OnYorvTE2YqtPkd6Hioa/2NE7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793454954;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1kiiRS0mqqeJYT+tsAjLrRkFrwN8x5gWPH1O/kHpgoE=;
	b=o/L22xdAHOWDDYWfPtuddYTucRXWq6yTrf+sD7WX4z0mbOW+R4/oLN/ibJd8ZfavQmwM
	 i0zTN0kMzNNIJkcZRrcOfs0Tns/0K03pdyzTvZIjZZrr8SJDLT/8z5i2Uv4IoooVmBO4F
	 JIvZO0XALIWjUxyjMJobfPDqZQIm9btAbfC5U2mlN5KCXbLhdpd2aDMUxG/ULhG2HQLGj
	 xNpeMtFWR2XFQkHmcYnDfs4qkS6u3Lhvf6B48zMMmpLm98AlQ38lruVOWr1mOMeP3iU94
	 H81lsd1b6Vc3vkmHRyfW2EV18lu0665N4OclKPUX2kbPE+NTDwVZZ+GFnfcIS4lbCNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P70bBqy5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B46606A31D
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P70bBqy5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D291F00A1C;
	Sat, 31 Oct 2026 13:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793454953;
	bh=1kiiRS0mqqeJYT+tsAjLrRkFrwN8x5gWPH1O/kHpgoE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P70bBqy56ooxaxUk4E+hZCz2zBmZ83ECw/wnFuMDBJMfYIPR4G4GlyDr2if0HYc6O
	 U1vJ74uxQ+XKI5RDKenvtzARJd7RJO4gzzHeznr4CHkk65KhjZao5Nm/gmnWY4PFjf
	 4lcDgWEMZhvsRssOlzzctWgb0UXqwf7qtAQ+CGBjLKwNaYgmyw4NTssz+Gisd2LhOE
	 dyctN5gu6nLSSpWRA4zHNyEyeixBgwhsxkrdCb7F1DoPShM/3HKAvCIKnAEDBP0DDK
	 x60LZg/AOpdKi8pK6iRcWUGiVNnsw+sXSsIt33O7EAjk4yF2I1AtJqAJMkfV5JkFSy
	 mMlcXbt32F/nA==
Subject:
 Re: [PATCH mptcp-next v2 3/5] mptcp: subflow: split subflow_check_req()
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, pabeni@redhat.com, chenguang.zhao@linux.dev,
 gang.yan@linux.dev, kuba@kernel.org
Date: Sat, 31 Oct 2026 13:55:52 +0000
Message-ID: <179345495294.3128.5525116758225588765@kernel.org>
In-Reply-To: <20261030-mptcp-reset-mpj-early-v2-3-90f119392263@kernel.org>
References: <20261030-mptcp-reset-mpj-early-v2-3-90f119392263@kernel.org>
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

- [Medium] The commit message calls this a "pure refactoring ... no
  behavioural changes intended" and names the dropped sock_put() calls…

--

mptcp: subflow: split subflow_check_req()

This commit splits subflow_check_req() into separate MP_CAPABLE and
MP_JOIN helpers, and folds subflow_token_join_request() into the new
subflow_check_req_mp_join(). subflow_req->msk is now set before the early
checks, so the explicit sock_put() calls are dropped and the destructor
releases the msk reference.

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f9785e20e2097..be6c8ce48fcda 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> @@ -189,6 +151,112 @@ static int subflow_reset_req_endp(struct request_sock *req, struct sk_buff *skb)
>  	return -EPERM;
>  }
>  
> +static int subflow_check_req_mp_join(struct request_sock *req,
> +				     const struct sock *sk_listener,
> +				     struct sk_buff *skb,
> +				     struct mptcp_options_received *mp_opt)
> +{

[ ... ]

> +	if (subflow_use_different_sport(subflow_req->msk, sk_listener)) {
> +		pr_debug("syn inet_sport=%d %d\n",
> +			 ntohs(inet_sk(sk_listener)->inet_sport),
> +			 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
> +		if (!mptcp_pm_announced_has_ssk(subflow_req->msk, sk_listener)) {
> +			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
> +			subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
> +			return -EPERM;
> +		}
> +		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTSYNRX);
> +	}
> +
> +	local_id = mptcp_pm_get_local_id(subflow_req->msk,
> +					 (struct sock_common *)req);
> +	if (local_id < 0) {
> +		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPJOINNOIDFOUND);
> +		subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
> +		return -EPERM;
> +	}

[Severity: Medium]
The commit message says:

  This is a pure refactoring, to reduce subflow_check_req size, no
  behavioural changes intended. With one exception: it is no longer
  needed to call sock_put(msk) ...

The order of the MP_JOIN checks has changed, so is that still accurate?

Before this patch, subflow_token_join_request() called
mptcp_pm_get_local_id() and mptcp_pm_is_backup() first. The
subflow_use_different_sport() / mptcp_pm_announced_has_ssk() check only
ran later, in subflow_check_req(), after that helper returned.

Now the port check runs first, and mptcp_pm_get_local_id() is only called
if the port check passes.

When the lookup misses, mptcp_pm_get_local_id() is not a pure lookup:

net/mptcp/pm_kernel.c:mptcp_pm_kernel_get_local_id() {
    ...
	/* address not found, add to local list */
	entry = kmemdup(skc, sizeof(*skc), GFP_ATOMIC);
    ...
	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, false);
    ...
}

net/mptcp/pm_userspace.c:mptcp_pm_userspace_get_local_id() {
    ...
	return mptcp_userspace_pm_append_new_local_addr(msk, skc, true);
}

mptcp_token_get_sock() is netns-wide. So a MP_JOIN SYN with a valid
token can reach any MPTCP listener in the netns whose port differs from
the msk port. That is the path
subflow_check_req()->subflow_check_req_mp_join().

If that port is not announced:

- With an address that isn't a known endpoint, the old code created an
  implicit endpoint (kernel PM) or a userspace PM local address entry
  before sending the reset. The new code sends the reset without creating
  either one.

- If mptcp_pm_get_local_id() would also fail, the old code counted
  MPTCP_MIB_MPJOINNOIDFOUND and sent MPTCP_RST_EMPTCP. The new code
  counts MPTCP_MIB_MISMATCHPORTSYNRX and sends MPTCP_RST_EPROHIBIT.

If the port is different but announced, and mptcp_pm_get_local_id()
fails, the new code also counts MPTCP_MIB_JOINPORTSYNRX. The old code
did not count it.

This reordering is still present at the end of the series, in "mptcp:
pm: kernel: avoid mptcp_pm_is_userspace checks".

Should the original order be restored, with mptcp_pm_get_local_id() and
mptcp_pm_is_backup() before the port check? Or should the commit message
mention this change alongside the sock_put() one?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030-mptcp-reset-mpj-early-v2-0-90f119392263%40kernel.org
