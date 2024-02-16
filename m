Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A7C130AC0
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708114882; cv=none; b=HxOq7BAmEpXZVGqmcujzJUijfB5iZUJga88sWYdfBkfb99FkkTNIMauVYzBd5FIGczAVjUpyhqjWRRzS193CVrz36HxFasLCH/sCVWe076aySGMqf6FgjRVzv2wQLKVjm26cRnrMsjQSXdPQ7MFKlxLGjTceD68vwmWa+Bc7ukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708114882; c=relaxed/simple;
	bh=TbFM+IsEaAL+4lQx4m2hX1dLLNdWNMa0rPFFnttcqEQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Pfong3qvTZT23YbtLuJwqChsIjbe9YKU3yv+XWGht6DX806OS2ZqBnA05bW2CEuHAFqtF2QP6oWvVR2HhLCeRpgXbvBlzd/yRQxE7OjrreP0AFXkGJOk97UobbKeBiTcdSKAtHXnGvVkH974oMCWzaLXHP1C9l0qVETsUZGUtrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0CB2aZk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0CB2aZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B471DC433C7;
	Fri, 16 Feb 2024 20:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708114881;
	bh=TbFM+IsEaAL+4lQx4m2hX1dLLNdWNMa0rPFFnttcqEQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=H0CB2aZkX5D2hCWC0r+1r7wmqfrXytZztMP7XOFvLgdxmCsyt5AhEH3PnZlJwiLnN
	 /rjyFbYHCzfefUf2ytKeRWKPri64lkGJxuvlS1WSulhmmhrq+UR560ltcbDePBABFX
	 60eXmgdCBZ99T/XDhMQFV+/51bWqO0zD2lGI/3Atsk0lYu5x0RTWtN2xfQ3HSIH47R
	 zvyMi1RxTymNvsjF2YFr/7eR8WZ9Su1PyErjj7ngo0t3YqU/7jA/axp6IvWfZjdAQW
	 N/eUoPiaY5mew0kXd7qy0Rp3XhpgdML7Z7ORP1+oSPHQKUYmOvCrAYduMbY7okL1n/
	 3uggeoW/rkyZg==
Date: Fri, 16 Feb 2024 12:21:20 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next] Squash to "DO-NOT-MERGE: mptcp: improve code
 coverage for CI"
In-Reply-To: <20240216-mptcp-warn-bogus-pr-warn-v1-1-6388bf96adf9@kernel.org>
Message-ID: <5a19039b-9281-eaa3-f546-e189b2d6022a@kernel.org>
References: <20240216-mptcp-warn-bogus-pr-warn-v1-1-6388bf96adf9@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 16 Feb 2024, Matthieu Baerts (NGI0) wrote:

> As discussed on [1], an additional check is done to catch local software
> bug.
>
> This patch is supposed to land only in our tree, for both 'export' and
> 'export-net' branches, because the warning could be triggered by bugged/
> malicious peer. We want it in our tree for our CI to detect internal
> bugs.
>
> Link: https://lore.kernel.org/all/20240215-mptcp-fix-bogus-pr-warn-v1-1-d14c10312820@kernel.org/ [1]
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Looks good to squash. Would be good to keep some of the above info in the 
post-squash commit message for context (especially the lore link).

One other thing, I noticed that this is mentioned in the "DO-NOT-MERGE: 
mptcp: improve code coverage for CI" commit message:

"""
     mptcp: use kmalloc on kasan build

       Helps detection UaF, which apparently kasan misses with kmem_cache
       allocator.

       We also need to always set the SOCK_RCU_FREE flag, to preserved the
       current code leveraging SLAB_TYPESAFE_BY_RCU. This latter change will
       make unreachable some existing errors path, but I don't see other
       options.

"""

But it looks like the code for that disappeared between 
export/20230405T131056 and export/20230405T132954 (also missing on 
export-net). I didn't find mention of this in the mailing list. A topgit 
glitch?


- Mat

> ---
> net/mptcp/options.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 27ca42c77b02..5926955625cf 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -982,7 +982,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
> 		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
>
> 	if (unlikely(!READ_ONCE(msk->pm.server_side)))
> -		pr_warn_once("bogus mpc option on established client sk");
> +		/* DO-NOT-MERGE: use WARN i/o pr_warn: only for MPTCP export */
> +		WARN_ONCE(1, "bogus mpc option on established client sk");
>
> set_fully_established:
> 	mptcp_data_lock((struct sock *)msk);
>
> ---
> base-commit: 65bda47e218b37c3dc919d3ccbd19dfad87a99e5
> change-id: 20240216-mptcp-warn-bogus-pr-warn-6dcc88038246
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
