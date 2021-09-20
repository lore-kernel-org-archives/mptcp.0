Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F6F3FC0
	for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 22:02:57 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="203393559"
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="203393559"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 15:02:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="473809703"
Received: from nkhakpas-mobl.amr.corp.intel.com ([10.212.134.160])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 15:02:52 -0700
Date: Mon, 20 Sep 2021 15:02:51 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/3] tcp: make tcp_build_frag() static
In-Reply-To: <1949660e9af338adc8913b7cdf8c632401d6d6e0.1632158356.git.pabeni@redhat.com>
Message-ID: <65edea-2573-d19f-8ab3-d0afe16b808a@linux.intel.com>
References: <cover.1632158356.git.pabeni@redhat.com> <1949660e9af338adc8913b7cdf8c632401d6d6e0.1632158356.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 20 Sep 2021, Paolo Abeni wrote:

> After the previous patch the mentioned helper is
> used only inside its compilation unit: let's make
> it static.
>
> RFC -> v1:
> - preserve the tcp_build_frag() helper (Eric)
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note:
> this should _replace_:
> """
> Partially revert "tcp: factor out tcp_build_frag()"
> """
>
> I did not opted for a squash to patch, as it would
> still require conflicts resolution after the previous
> squash-to patch. @matttbe: please let me know if you
> prefer otherwise.
> ---
> include/net/tcp.h | 2 --
> net/ipv4/tcp.c    | 5 ++---
> 2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 4a96f6e0f6f8..673c3b01e287 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -330,8 +330,6 @@ int tcp_sendpage(struct sock *sk, struct page *page, int offset, size_t size,
> 		 int flags);
> int tcp_sendpage_locked(struct sock *sk, struct page *page, int offset,
> 			size_t size, int flags);
> -struct sk_buff *tcp_build_frag(struct sock *sk, int size_goal, int flags,
> -			       struct page *page, int offset, size_t *size);
> ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
> 		 size_t size, int flags);
> int tcp_send_mss(struct sock *sk, int *size_goal, int flags);
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index c592454625e1..4ae43222d71f 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -963,8 +963,8 @@ void tcp_remove_empty_skb(struct sock *sk, struct sk_buff *skb)
> 	}
> }
>
> -struct sk_buff *tcp_build_frag(struct sock *sk, int size_goal, int flags,
> -			       struct page *page, int offset, size_t *size)
> +static struct sk_buff *tcp_build_frag(struct sock *sk, int size_goal, int flags,
> +				      struct page *page, int offset, size_t *size)
> {
> 	struct sk_buff *skb = tcp_write_queue_tail(sk);
> 	struct tcp_sock *tp = tcp_sk(sk);
> @@ -1064,7 +1064,6 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
> 		size_t copy = size;
>
> 		skb = tcp_build_frag(sk, size_goal, flags, page, offset, &copy);
> -		if (!skb)
> 			goto wait_for_space;

This looks like an accidental deletion. Do you want to repost or have 
Matthieu drop this hunk?

--
Mat Martineau
Intel
