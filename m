Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7F44C68
	for <mptcp@lists.linux.dev>; Thu,  6 Jun 2024 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717701285; cv=none; b=NS7kQ6mDVtLuHfcSjHvdrZwGTqHe0cD+USHA9WUbHMMJm01RxP4A7/GrdGlXfOc8CQe2mtk3HGPRZo5+4Q2urVK5PzFhjSFENNbf/Q1NwT9rgT8r4x8BkeSsB7AmjicmzPAzujbSFbcVSri1SDPNQnS8hpr+hjKQsZ6NKKhjZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717701285; c=relaxed/simple;
	bh=5ndmfjv3Z6VUytV9KtPzgwMlSELqeWLzfPKgRJpxyEY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ejwrb7s4bh4+SUcu9AFQ05xZvC5UmcMP63Q/n3BCtJViXJr+go6u4BGi0sCUzLa1Ga4cMOZEycIPq7BYMWGsDlKhr8xxvCwrwXrjUhidZC3c4kk2ghblmNAOikT+Q7UxbN0kpNXkbjWL7gcOYfTUmFbu05Qkt31Rl6xNrMVqmPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcwADqj7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcwADqj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A343C2BD10;
	Thu,  6 Jun 2024 19:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717701285;
	bh=5ndmfjv3Z6VUytV9KtPzgwMlSELqeWLzfPKgRJpxyEY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=AcwADqj7CDDkeZfwCPLtGqtiNsNA1QsKaFoMPFggjXk30cNNuP6wUcwziNopLCt60
	 CmlzxlHW6H05XVms9KqmitZQatiCuUdgnsc/P6sVdEGnyYgCiJLEZcPhbZsw6yPCBb
	 DuG8mb0DP+uQ5NgEZv6Bf+wiB3qQJ0ZgpX1BNCQfzHCWOqKv/IFb+sS37amJW9DQNi
	 jt+3ndTJVWXhpj3RZERVdRbzQxkxNQVOwdmO5GVC4qdCj13dCe/Oji3sj9ldnzKf+a
	 oY0csE92lN147jOXta1Fnji+XugRN2qMprcjSzerFQL5WFfn8+StmcxbYbb4SK66aU
	 H0RSGxtPJDpLA==
Date: Thu, 6 Jun 2024 12:14:44 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-iproute 3/4] mptcp: warn if 'signal' and 'subflow'
 flags are set
In-Reply-To: <20240605-mptcp-user-feedback-v1-3-d2dc3b399643@kernel.org>
Message-ID: <72cb6b39-7de9-b339-12fa-e7a7546e8a60@kernel.org>
References: <20240605-mptcp-user-feedback-v1-0-d2dc3b399643@kernel.org> <20240605-mptcp-user-feedback-v1-3-d2dc3b399643@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 5 Jun 2024, Matthieu Baerts (NGI0) wrote:

> Setting both the 'signal' and 'subflow' flags is very likely a mistake
> from the user, and would bring unexpected behaviours as mentioned in
> some bug reports on the MPTCP project.
>
> It is then important to guide the users by printing a warning on stderr.
> Users can ignore this message if they have an atypical environment where
> the initiator of a connection might accept the creation of additional
> subflows from the other peer.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> ip/ipmptcp.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> index 9847f95b..0f09cf75 100644
> --- a/ip/ipmptcp.c
> +++ b/ip/ipmptcp.c
> @@ -179,6 +179,15 @@ static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n, int cmd)
> 	if (adding && port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
> 		invarg("flags must have signal when using port", "port");
>
> +	if (adding && (flags & MPTCP_PM_ADDR_FLAG_SIGNAL) &&
> +	              (flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
> +		fprintf(stderr,
> +		    "Warning: Setting both the 'signal' and 'subflow' flags is usually a mistake:\n"
> +		    "         'signal' is used to announce additional addresses, typically for the\n"
> +		    "         server side, while 'subflow' is used to create new paths, typically\n"
> +		    "         for the client side. It is not typical to both initiate, and accept\n"
> +		    "         new connections with the same peer. Continuing as requested.\n");
> +

Hi Matthieu -

For this patch and the next one, I think it would be better to update the 
man page with information about typical usage rather than printing this 
error message. Seems like the ip tool doesn't have other informational 
run-time messages like this (especially ones this long), and there's no 
'-q' flag to silence them for non-typical cases.

- Mat

> 	if (setting && id_set && port)
> 		invarg("port can't be used with id", "port");
>
>
> -- 
> 2.43.0
>
>
>
