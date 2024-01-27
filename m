Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5A22573
	for <mptcp@lists.linux.dev>; Sat, 27 Jan 2024 01:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706318309; cv=none; b=DtYyk800c8qrDsnVEo5qJSgVpXZTZUoOkhXidagW5WJD4P4IEH7sqqqwqqAbxmuz0nSJSeLeDxsJcYR2FKLcEV+lxdbz/YZ6lWUZjZNqY8M+WkdoN+lu//Rf2FDT6FgdXSdtgsruT857fZA8+IbjrFWjEd/STvY571iTqBACYRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706318309; c=relaxed/simple;
	bh=6JNuFBdQoPEfx3ctt8F8lDwRQKZSRCUg/EHwoXyMw6o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FLEhryCkpPFQqMksq1spyX4VvNibaNf8AbdeKTBf48Q14E+++WuuvsDeNOi7jATzxEHK8OR7gu18UPfT3smT1l600/vj+SmZ13ivbvCbhRQfP3zMDkCIJhYZqP2Xjx4PPbal+20jUW9VJXYIWJ9JVKouicLQSZxjo2+DlCJ5Who=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYzONBW6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYzONBW6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89249C433F1;
	Sat, 27 Jan 2024 01:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706318309;
	bh=6JNuFBdQoPEfx3ctt8F8lDwRQKZSRCUg/EHwoXyMw6o=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=cYzONBW6oUqtOgmnS2u76S2lDmcA26k4mNkzvxObQaUyfAFaEiO9JjyAy4T+5fAif
	 rLbXNrLcDQLWrxWgglvxQXUho5FsMOG1Xe4xuVHvYwYifC4cC9QsuKvIcf6lbAp0Uz
	 msXM4dhzRZiHA4qHFyiIXqaWI+04ECMdg299iVI72gUGauYuKsY/FLcA080bLWanCN
	 eSOqhb4mA65xzFnsdBHy9mD8nbOnlNcv/5H627aBWp1v/XQuYgDU9Z5AGtGRsHEBV3
	 BZdjsXlu6RyptD9iQAJ5oadle6fb1kejao47CFEZf1Pw7lyvytvgYkdaYzkKKaXvwP
	 DKuJuWWIiACqg==
Date: Fri, 26 Jan 2024 17:18:28 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: really cope with fastopen race.
In-Reply-To: <02fe7afaec6fac65fc2da5922efe25d6ebdebc88.1706132185.git.pabeni@redhat.com>
Message-ID: <89ef77af-b4b5-8674-52e0-92405a0c0ea9@kernel.org>
References: <02fe7afaec6fac65fc2da5922efe25d6ebdebc88.1706132185.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Wed, 24 Jan 2024, Paolo Abeni wrote:

> Fastopen and PM-trigger subflow shutdown can race, as reported by
> syzkaller.
>
> In my first attempt to close such race, I missed the fact that
> the subflow status can change again before the subflow_state_change
> callback is invoked.
>
> Address the issue additionally copying with all the states directly
> reachable from TCP_FIN_WAIT1.
>
> Fixes: 1e777f39b4d7 ("mptcp: add MSG_FASTOPEN sendmsg flag support")
> Fixes: 4fd19a307016 ("mptcp: fix inconsistent state on fastopen race")
> Reported-by: syzbot+c53d4d3ddb327e80bc51@syzkaller.appspotmail.com
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

I wasn't able to reproduce the CI failure, and the change looks good to 
me. We'll see if CI is happy when this is applied to export-net.

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> net/mptcp/protocol.h | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 4a32d3d11fb6..de04b97e8dd1 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1171,7 +1171,8 @@ static inline bool subflow_simultaneous_connect(struct sock *sk)
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>
> -	return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_FIN_WAIT1) &&
> +	return (1 << sk->sk_state) &
> +	       (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING) &&
> 	       is_active_ssk(subflow) &&
> 	       !subflow->conn_finished;
> }
> -- 
> 2.43.0
>
>
>
