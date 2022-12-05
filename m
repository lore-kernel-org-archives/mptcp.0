Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EFD15C9E
	for <mptcp@lists.linux.dev>; Mon,  5 Dec 2022 21:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670277172; x=1701813172;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IxRNtJH7O81VFOpcSQsZBHpEaqtbgcRJXovp3ma3J+c=;
  b=EVYWWM3Q0eAYpWwiyUdA49WKjCWJy9nImnnTWWwoUvPjtbhJVcTfvvWw
   G1HdpmAuJQWw34ZtQ1AIB/4v5PCH28ZV46eWvarEkrZ53C7eay2XxjxAN
   GECUrgVc7RxY5QMeSsXgOvh3jsbVomMbsaLfh3eCpD40Te4cSl5zVhni/
   NKttO8GYTMj+kKGMy7lyX7JrmeZw8nXi0IdPnCUqeXKrW+PqE6gbBqBP2
   VF7ZIYlIIktnB+ve7eQzQDm3B16quPDv/zBWflKPuH8uM6blq20MCLJfD
   QgkcqC75Sp6MyVz/Q0wkk2Tq9X8d+QSUpRqefmOwVQatTDSTy39c/eXGP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="316497896"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="316497896"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 13:52:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="596347381"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="596347381"
Received: from psjohns1-mobl.amr.corp.intel.com ([10.209.67.116])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 13:52:39 -0800
Date: Mon, 5 Dec 2022 13:52:39 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v2 1/3] mptcp: remove MPTCP 'ifdef' in TCP SYN
 cookies
In-Reply-To: <20221130094448.4119946-2-matthieu.baerts@tessares.net>
Message-ID: <48d0aa62-276c-c23b-d49a-1d7e3a62fed5@linux.intel.com>
References: <20221130094448.4119946-1-matthieu.baerts@tessares.net> <20221130094448.4119946-2-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 30 Nov 2022, Matthieu Baerts wrote:

> To ease the maintenance, it is often recommended to avoid having #ifdef
> preprocessor conditions.
>
> Here the section related to CONFIG_MPTCP was quite short but the next
> commit needs to add more code around. It is then cleaner to move
> specific MPTCP code to functions located in net/mptcp directory.
>
> Now that mptcp_subflow_request_sock_ops structure can be static, it can
> also be marked as "read only after init".
>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Hi Matthieu -

I noticed today that there's no Fixes: tag for this commit, which the 
netdev CI will check for. Like you say in the commit message, this patch 
is a small bit of refactoring to prepare for the following patch(es) - 
should it share Fixes: tags with those or just let the git dependencies 
speak for themselves?

- Mat

> ---
>
> Notes:
>    v2:
>     - mark mptcp_subflow_request_sock_ops as static and __ro_after_init
>
> include/net/mptcp.h   | 12 ++++++++++--
> net/ipv4/syncookies.c |  7 +++----
> net/mptcp/subflow.c   | 12 +++++++++++-
> 3 files changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 412479ebf5ad..3c5c68618fcc 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -97,8 +97,6 @@ struct mptcp_out_options {
> };
>
> #ifdef CONFIG_MPTCP
> -extern struct request_sock_ops mptcp_subflow_request_sock_ops;
> -
> void mptcp_init(void);
>
> static inline bool sk_is_mptcp(const struct sock *sk)
> @@ -188,6 +186,9 @@ void mptcp_seq_show(struct seq_file *seq);
> int mptcp_subflow_init_cookie_req(struct request_sock *req,
> 				  const struct sock *sk_listener,
> 				  struct sk_buff *skb);
> +struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
> +					       struct sock *sk_listener,
> +					       bool attach_listener);
>
> __be32 mptcp_get_reset_option(const struct sk_buff *skb);
>
> @@ -274,6 +275,13 @@ static inline int mptcp_subflow_init_cookie_req(struct request_sock *req,
> 	return 0; /* TCP fallback */
> }
>
> +static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
> +							     struct sock *sk_listener,
> +							     bool attach_listener)
> +{
> +	return NULL;
> +}
> +
> static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
> #endif /* CONFIG_MPTCP */
>
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 942d2dfa1115..26fb97d1d4d9 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -288,12 +288,11 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
> 	struct tcp_request_sock *treq;
> 	struct request_sock *req;
>
> -#ifdef CONFIG_MPTCP
> 	if (sk_is_mptcp(sk))
> -		ops = &mptcp_subflow_request_sock_ops;
> -#endif
> +		req = mptcp_subflow_reqsk_alloc(ops, sk, false);
> +	else
> +		req = inet_reqsk_alloc(ops, sk, false);
>
> -	req = inet_reqsk_alloc(ops, sk, false);
> 	if (!req)
> 		return NULL;
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 2159b5f9988f..3f670f2d5c5c 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -529,7 +529,7 @@ static int subflow_v6_rebuild_header(struct sock *sk)
> }
> #endif
>
> -struct request_sock_ops mptcp_subflow_request_sock_ops;
> +static struct request_sock_ops mptcp_subflow_request_sock_ops __ro_after_init;
> static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops __ro_after_init;
>
> static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
> @@ -582,6 +582,16 @@ static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
> }
> #endif
>
> +struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
> +					       struct sock *sk_listener,
> +					       bool attach_listener)
> +{
> +	ops = &mptcp_subflow_request_sock_ops;
> +
> +	return inet_reqsk_alloc(ops, sk_listener, attach_listener);
> +}
> +EXPORT_SYMBOL(mptcp_subflow_reqsk_alloc);
> +
> /* validate hmac received in third ACK */
> static bool subflow_hmac_valid(const struct request_sock *req,
> 			       const struct mptcp_options_received *mp_opt)
> -- 
> 2.37.2
>
>
>

--
Mat Martineau
Intel
