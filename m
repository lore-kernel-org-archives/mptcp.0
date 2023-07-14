Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6217615AE2
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 23:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA23C433C8;
	Fri, 14 Jul 2023 23:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689376828;
	bh=rIVJq5zmgq54CjBq9MsxQoW6tEI1XaoSoNzW2Auv8Qs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ZdmBmKE68x6/rI25Myb5gsewScviVRjkzi1aPmM1/neHLvvGBFx/NyiNdpaclJXm9
	 m1KqznLVj5Ci2yzetDK/3w7Xf8mcl261YBKObUGOsy04ZR9Exkz+NeSQQWrRaryh5V
	 I93JvESq1cr5oDJ5atBNsSX7JGYgSCun/C55FnpOeSzK0JqN9gA1ultVKGnCEybdw3
	 jxXps5xqzhDDfkl5hWfhyLtMJ7XZr/qAycipDmu2ZEE2f/xNtVWhpS00TVBGT9Vmgc
	 utPk2gHBpQp15raOkpRg5qaHPgMXWZxRBDeNALqkde+TKsKozH2jU57/JgSxoU6kRL
	 9+guPQJxJsnDQ==
Date: Fri, 14 Jul 2023 16:20:27 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 00/13] mptcp: get rid of msk->subflow
In-Reply-To: <cover.1689334116.git.pabeni@redhat.com>
Message-ID: <1ae0acb6-70e3-a513-06cf-9fd017d02a8a@kernel.org>
References: <cover.1689334116.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 14 Jul 2023, Paolo Abeni wrote:

> The mptcp protocol maintains an additional struct socket per connection,
> mainly to be able to use easily tcp-level struct socket operations.
>
> That lead to several ill side effects, beyond the quite unfortunate/
> confusing field name
> - active and passive sockets behavior is incosistent, as only active
>  ones have not NULL msk->subflow, leading to different error handling
>  (and different error code returned to the user-space) in several
>  places.
> - active sockets uses an unneeded, larger amount of memory
> - passive sockets can't successfully go through accept()/disconnect()
>  accept()
>
> This series address all the above finally getting rid of the blamed
> field. The first patch is a minor clean-up, in the next 11 patches
> msk->subflow usage is sistematically removed from the mptcp protocol,
> replacing it with direct msk->first usage, eventually introducing new
> core helpers as needed.
>
> The final patch finally dispose the field, and it's the only patch in
> the series intened to produce functional changes.
>
> v1 -> v2:
> - dropped first patch (already applied)
> - a bunch of typos and comments, the only patches with code changes
>   are 7/13, 9/13, 13/13, see the individual changelog for the
>   details.
>

Thanks Paolo, v2 looks good to me.

For the "mptcp: *" patches:

Reviewed-by: Mat Martineau <martineau@kernel.org>

I'll ack the "net: *" patches separately.


- Mat


> Paolo Abeni (13):
>  mptcp: avoid unneeded mptcp_token_destroy() calls
>  mptcp: avoid additional __inet_stream_connect() call
>  mptcp: avoid subflow socket usage in mptcp_get_port()
>  net: factor out inet{,6}_bind_sk helpers
>  mptcp: mptcp: avoid additional indirection in mptcp_bind()
>  net: factor out __inet_listen_sk() helper
>  mptcp: avoid additional indirection in mptcp_listen()
>  mptcp: avoid additional indirection in mptcp_poll()
>  mptcp: avoid unneeded indirection in mptcp_stream_accept()
>  mptcp: avoid additional indirection in sockopt
>  mptcp: avoid ssock usage in mptcp_pm_nl_create_listen_socket()
>  mptcp: change the mpc check helper to return a sk
>  mptcp: get rid of msk->subflow
>
> include/net/inet_common.h |   2 +
> include/net/ipv6.h        |   1 +
> net/ipv4/af_inet.c        |  46 ++++++----
> net/ipv6/af_inet6.c       |  10 ++-
> net/mptcp/pm_netlink.c    |  30 ++++---
> net/mptcp/protocol.c      | 177 +++++++++++++++++++-------------------
> net/mptcp/protocol.h      |  15 ++--
> net/mptcp/sockopt.c       |  65 +++++++-------
> 8 files changed, 181 insertions(+), 165 deletions(-)
>
> -- 
> 2.41.0
>
>
>
