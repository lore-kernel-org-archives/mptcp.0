Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C00A6D28
	for <mptcp@lists.linux.dev>; Wed, 14 Apr 2021 15:51:59 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lWhnz-0005fh-Qq; Wed, 14 Apr 2021 17:51:51 +0200
Date: Wed, 14 Apr 2021 17:51:51 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: ignore unsupported msg flags
Message-ID: <20210414155151.GG14932@breakpoint.cc>
References: <fb3746774c97c3042beb7d76cf9f23e57d7f85e1.1618413785.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb3746774c97c3042beb7d76cf9f23e57d7f85e1.1618413785.git.pabeni@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> Currently mptcp_sendmsg()/mptcp_recvmsg() fail with EOPNOTSUPP
> if the user-space provides some unsupported flag. That is
> unexpected and may foul existing applications migrated to MPTCP,
> which expect a different behavior.
> 
> Change the mentioned function to silently ignore the unsupported
> flags.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/162
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2d895c3c8746..bdec946b9b04 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1585,8 +1585,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  	int ret = 0;
>  	long timeo;
>  
> -	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL))
> -		return -EOPNOTSUPP;
> +	/* ignore unsupported flags */
> +	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;

Ignoring MSG_MORE is fine, but DONTWAIT and NOSIGNAL?

I'd prefer hard errors for those until mptcp does the right thing for
them.
