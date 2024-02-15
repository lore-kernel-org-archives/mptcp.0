Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561F613475C
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708039505; cv=none; b=f/7VMJ1tpwClBiiyUYBGggTJtOmGacicANmXjkUfZixO3JgP+V6iX5eXLWdN3JnHiyCKniTWkMcFmo/CmO++k9EhRu/X5Z4mMJH3ULVJ5Wqaj0vCBsm/NunH9PmoK7nyZEP4f6VvvNSqS2QkFtf+I5cEsQjn/bwYADpZrSNm5Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708039505; c=relaxed/simple;
	bh=WQ62xzS8+FzUvo6KTLdVINRqYDsjd7oDdmbN1AqEqkw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sZQOPdafvSJFl02XH5kCCEXQcDbPYEcRJzk3QoRy/C4fk3CTm0d9bxsVaHNlcA1NiHDb5DA2zAenC0jgPzBT8DCLDqMKvJPRiCQ/QYZxtWL+9vo1yV8Ui/OEPUI7ERNp9SUsKeS08SKrDKI/5/suEees76W7LCVO97LpVM443rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emIkb2RW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emIkb2RW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D8CC433C7;
	Thu, 15 Feb 2024 23:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708039504;
	bh=WQ62xzS8+FzUvo6KTLdVINRqYDsjd7oDdmbN1AqEqkw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=emIkb2RWpPHdTag30nxnBi3MTPBHOsjYtogEK35v332zoH4nbdw6AJFqOk+3LF16b
	 8oO9HEhqKFKzd95eL6jVQXGBZltTX0mEZrAIMIIdc7sCZ30xtyFtNu/0yQo+ZZIbhs
	 lZdIhsFPSsl7FoEBlAmXm8ev/OptfvvTFtAcCTwFdWrkfqEcf98RXII7XzILf1xSQr
	 CvzrIrx8Rt+BS3LK76/KtTUo1YhzzLauc69TcLfsgzgAC69GEMXrC9N+YwzP3Njd01
	 PvgSvYrIfiCvfea71GmmN7R49dJ5tH9du3tmyzNx611XVZWaN6DgRsg7y8V3bR185p
	 UtR7unOPIMYPQ==
Date: Thu, 15 Feb 2024 15:25:04 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: avoid printing warning once on client
 side
In-Reply-To: <20240215-mptcp-fix-bogus-pr-warn-v1-1-d14c10312820@kernel.org>
Message-ID: <9502e96c-8a72-a6d4-ca2d-1c75c536bfa3@kernel.org>
References: <20240215-mptcp-fix-bogus-pr-warn-v1-1-d14c10312820@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 15 Feb 2024, Matthieu Baerts (NGI0) wrote:

> After the 'Fixes' commit mentioned below, the client side might print
> the following warning once when a subflow is fully established at the
> reception of any valid additional ack:
>
>  MPTCP: bogus mpc option on established client sk
>
> That's a normal situation, and no warning should be printed for that. We
> can then skip the check when the label is used.
>
> Fixes: e4a0fa47e816 ("mptcp: corner case locking for rx path fields initialization")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Looks good to me:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> Notes:
> - Should we convert this pr_warn_once() to a WARN_ONCE()? Or just in
>   our tree? Or just in DEBUG mode?

I think it makes sense to keep this patch minimal for -net and stable 
(just moving the label).

Also given the consequences of panic_on_warn, would be better to make any 
changes to WARN_ONCE() in mptcp-next/net-next. I don't see extra 
complexity to modify this warning in our tree or debug mode as being worth 
it, do you think it would be valuable?

- Mat

> ---
> net/mptcp/options.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 23e317ffc901..27ca42c77b02 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -981,10 +981,10 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
> 	if (mp_opt->deny_join_id0)
> 		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
>
> -set_fully_established:
> 	if (unlikely(!READ_ONCE(msk->pm.server_side)))
> 		pr_warn_once("bogus mpc option on established client sk");
>
> +set_fully_established:
> 	mptcp_data_lock((struct sock *)msk);
> 	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
> 	mptcp_data_unlock((struct sock *)msk);
>
> ---
> base-commit: 52e05de42e1094a943053af93ea08c51a44091f7
> change-id: 20240215-mptcp-fix-bogus-pr-warn-497a3537984b
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
