Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3105C1C26
	for <mptcp@lists.linux.dev>; Fri,  2 Dec 2022 22:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670021805; x=1701557805;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gFSBK75c46y49EuAlzSjoG1KjEf7rjDzSQSiymirmC8=;
  b=hCpnxWCNDVAxZplZFk5VQGQCzG8Fcparv+Jz7gF3exmIjRQzZIhTgNJu
   tCa2JJ9QRIAsPRGs72FOfodC4bcKC0VcUakBNB8GmmUbdexAT6Hfs9/u7
   oDwKBejoRxsJSWHCyQ/sikRHbVYoZp+r4FXKj4WDdeuDNwFxZYpJpUqyk
   gd4ZkAkJpJh9AAbfdXPHdKDk/zGlhaI9iRzD5QKVw4s5lsklJxy0lkWpz
   AoRfI07Lexs+FRVLIaJCJLe0NPiLZPiAPDUr/ccKE14NV+cFdyXdDfK7A
   k/Qfirvd1xSkpmWVnaLQ8QDp4CC/p6nlk17EImNlY+Dxpvvzw7ON3ka1Q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="317207899"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="317207899"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 14:56:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="677760536"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="677760536"
Received: from zamamohx-mobl.amr.corp.intel.com ([10.209.22.121])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 14:56:44 -0800
Date: Fri, 2 Dec 2022 14:56:44 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2 3/3] mptcp: use proper req destructor for
 IPv6
In-Reply-To: <20221130094448.4119946-4-matthieu.baerts@tessares.net>
Message-ID: <92f1e33f-3867-e467-a2f0-f0574529c758@linux.intel.com>
References: <20221130094448.4119946-1-matthieu.baerts@tessares.net> <20221130094448.4119946-4-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 30 Nov 2022, Matthieu Baerts wrote:

> Before, only the destructor from TCP request sock in IPv4 was called
> even if the subflow was in v4.

Did you intend "even if the subflow was IPv6." ?

Other than that, the series looks good to me. Fine if you fix the above 
when applying.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

>
> It is important to use the right destructor to avoid memory leaks with
> some advanced IPv6 features, e.g. when the request socks contain
> specific IPv6 options.
>
> Fixes: 79c0949e9a09 ("mptcp: Add key generation and token tree")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> net/mptcp/subflow.c | 19 ++++++++++++++++---
> 1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 30524dd7d0ec..613f515fedf0 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -45,7 +45,6 @@ static void subflow_req_destructor(struct request_sock *req)
> 		sock_put((struct sock *)subflow_req->msk);
>
> 	mptcp_token_destroy_request(req);
> -	tcp_request_sock_ops.destructor(req);
> }
>
> static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
> @@ -550,6 +549,12 @@ static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
> 	return 0;
> }
>
> +static void subflow_v4_req_destructor(struct request_sock *req)
> +{
> +	subflow_req_destructor(req);
> +	tcp_request_sock_ops.destructor(req);
> +}
> +
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> static struct request_sock_ops mptcp_subflow_v6_request_sock_ops __ro_after_init;
> static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops __ro_after_init;
> @@ -581,6 +586,12 @@ static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
> 	tcp_listendrop(sk);
> 	return 0; /* don't send reset */
> }
> +
> +static void subflow_v6_req_destructor(struct request_sock *req)
> +{
> +	subflow_req_destructor(req);
> +	tcp6_request_sock_ops.destructor(req);
> +}
> #endif
>
> struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
> @@ -1929,8 +1940,6 @@ static int subflow_ops_init(struct request_sock_ops *subflow_ops)
> 	if (!subflow_ops->slab)
> 		return -ENOMEM;
>
> -	subflow_ops->destructor = subflow_req_destructor;
> -
> 	return 0;
> }
>
> @@ -1938,6 +1947,8 @@ void __init mptcp_subflow_init(void)
> {
> 	mptcp_subflow_v4_request_sock_ops = tcp_request_sock_ops;
> 	mptcp_subflow_v4_request_sock_ops.slab_name = "request_sock_subflow_v4";
> +	mptcp_subflow_v4_request_sock_ops.destructor = subflow_v4_req_destructor;
> +
> 	if (subflow_ops_init(&mptcp_subflow_v4_request_sock_ops) != 0)
> 		panic("MPTCP: failed to init subflow v4 request sock ops\n");
>
> @@ -1963,6 +1974,8 @@ void __init mptcp_subflow_init(void)
>
> 	mptcp_subflow_v6_request_sock_ops = tcp6_request_sock_ops;
> 	mptcp_subflow_v6_request_sock_ops.slab_name = "request_sock_subflow_v6";
> +	mptcp_subflow_v6_request_sock_ops.destructor = subflow_v6_req_destructor;
> +
> 	if (subflow_ops_init(&mptcp_subflow_v6_request_sock_ops) != 0)
> 		panic("MPTCP: failed to init subflow v6 request sock ops\n");
>
> -- 
> 2.37.2
>
>
>

--
Mat Martineau
Intel
