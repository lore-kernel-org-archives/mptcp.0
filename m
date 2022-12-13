Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA76323B
	for <mptcp@lists.linux.dev>; Tue, 13 Dec 2022 23:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670972721; x=1702508721;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bQBA5OrD4c8dIASnVDHYpx0zLUvZBWt6svnv5k0Epcs=;
  b=bOko3jRCRaAluSFIbFitmAfMAAKHvdT9Ze5hgH4DVDv5Qjyhe7PqbZ3Z
   KdsEm3fB8zlFikTZdVHIsEcaws0KpkEXlbV10STJjUwOxorlVtIa1Cs5X
   RXZs8feEE1CkJA6wqjiDEdciipc1bwuxP5OZJ6PnA+lfL4vmBKm7Uu5wA
   OTIbp0o3uOXXIJUuuNih2MbfhlS7Gd5B7bHBVVPi0keOX5+2Gfbe722e7
   24lO94BADdMXw+f5PVhDAUgJf4JQFelX2OU+Yo739EIvLvolruw11/0q0
   zTw6OLFcw5tDgmGiYIput2aXE3SCUvXlGF3fYYug22YBPaEbMEZ0gBjfb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="305898493"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="305898493"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 15:05:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="737539839"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="737539839"
Received: from ticela-or-060.amr.corp.intel.com ([10.209.103.237])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 15:05:19 -0800
Date: Tue, 13 Dec 2022 15:05:19 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: use msk_owned_by_me helper
In-Reply-To: <20221209045925.20408-1-geliang.tang@suse.com>
Message-ID: <2dc358ae-97c2-09c9-4881-bd5ae3f9ee83@linux.intel.com>
References: <20221209045925.20408-1-geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 9 Dec 2022, Geliang Tang wrote:

> The helper msk_owned_by_me() is defined in protocol.h, so use it instead
> of sock_owned_by_me().
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Thanks Geliang, looks good:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> net/mptcp/protocol.c | 9 ++++-----
> net/mptcp/sockopt.c  | 2 +-
> 2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6d03bdcda33e..c8d5fa039b71 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -923,9 +923,8 @@ static void mptcp_check_for_eof(struct mptcp_sock *msk)
> static struct sock *mptcp_subflow_recv_lookup(const struct mptcp_sock *msk)
> {
> 	struct mptcp_subflow_context *subflow;
> -	struct sock *sk = (struct sock *)msk;
>
> -	sock_owned_by_me(sk);
> +	msk_owned_by_me(msk);
>
> 	mptcp_for_each_subflow(msk, subflow) {
> 		if (READ_ONCE(subflow->data_avail))
> @@ -1408,7 +1407,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> 	u64 linger_time;
> 	long tout = 0;
>
> -	sock_owned_by_me(sk);
> +	msk_owned_by_me(msk);
>
> 	if (__mptcp_check_fallback(msk)) {
> 		if (!msk->first)
> @@ -1896,7 +1895,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
> 	u32 time, advmss = 1;
> 	u64 rtt_us, mstamp;
>
> -	sock_owned_by_me(sk);
> +	msk_owned_by_me(msk);
>
> 	if (copied <= 0)
> 		return;
> @@ -2223,7 +2222,7 @@ static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
> 	struct mptcp_subflow_context *subflow;
> 	int min_stale_count = INT_MAX;
>
> -	sock_owned_by_me((const struct sock *)msk);
> +	msk_owned_by_me(msk);
>
> 	if (__mptcp_check_fallback(msk))
> 		return NULL;
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index d4b1e6ec1b36..582ed93bcc8a 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -18,7 +18,7 @@
>
> static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
> {
> -	sock_owned_by_me((const struct sock *)msk);
> +	msk_owned_by_me(msk);
>
> 	if (likely(!__mptcp_check_fallback(msk)))
> 		return NULL;
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
