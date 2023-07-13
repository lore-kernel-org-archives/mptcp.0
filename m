Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD22FB3
	for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 16:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACAFC433C7;
	Thu, 13 Jul 2023 16:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689266758;
	bh=L+JxKGWb2XDC3MX/ZPY3sFpAnmB7JGasnp9+q31Ep3I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=f8t/EmAOevpgqGXJgFwHVtqd5ImdH8ZpRpXi3aQOrRlq7gmsLfFZyafq81sai7JY6
	 0DSE6ApsnP/I3tYZYI/2hq4DruVffGqlM44K2+MLtXEnrpTOcWmM7VfNv1cdzuKrjI
	 ofEAjw8VUyQpipUKfMmznHghvXTZ6FwONwcT5743ZbSuIxBJmPhTQvQ2yZFBWAe3nM
	 DAD9jgsYxaOrsmfvKOjyP6kNHecwaccU+/+uFHADwQ1P+8Vo4yTJMPUMknpOZe9pNK
	 ygEocHmATdsAzQLC2S1kbnzIF9MUif5ksx0GwKlDgKBGkhHUpGwX0M6BD0qL6mm6zr
	 IM7hPzeaBHfqQ==
Date: Thu, 13 Jul 2023 09:45:57 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next 01/14] mptcp: more accurate NL event
 generation.
In-Reply-To: <2dff178d492953373f5d7215aea15676b0e6079c.1688993569.git.pabeni@redhat.com>
Message-ID: <6b0f2dde-2881-f72c-3012-bd6a267f1676@kernel.org>
References: <cover.1688993569.git.pabeni@redhat.com> <2dff178d492953373f5d7215aea15676b0e6079c.1688993569.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 10 Jul 2023, Paolo Abeni wrote:

> Currently the mptcp code generate a "new listener" event even
> if the actual listen() syscall fails. Address the issue moving
> the event generation call under the successful branch.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

> ---
> this could possibly go via -net, but is used by later patches and
> is not really critical IMHO.
> Eventually the additional tag would be:
> Fixes: f8c9dfbd875b ("mptcp: add pm listener events")

I replied deeper in the thread about applying this patch to -net, but I 
need to tag it too:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> net/mptcp/protocol.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 497bc17b5223..8b5c78f582f7 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3762,10 +3762,9 @@ static int mptcp_listen(struct socket *sock, int backlog)
> 	if (!err) {
> 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
> 		mptcp_copy_inaddrs(sk, ssock->sk);
> +		mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
> 	}
>
> -	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
> -
> unlock:
> 	release_sock(sk);
> 	return err;
> -- 
> 2.41.0
>
>
>
