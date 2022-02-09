Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156A62C9C
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 23:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644448734; x=1675984734;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Az15SslFV3K79OjzSUWbl6lGd7V6n1Rqjz++ZmZqnqQ=;
  b=aEd4VvRovvN1t2pIy74BXNqIvag+f4UyFfy/Qhdjw4EEnR3oVfXKIwzA
   xMGKnMeb5W+cW09j2sUvg+fgCshKbPM4u47gz6w10+5zYy5FpkOKoEs2B
   WUewRW3hhX5YgvfJzFRa5RVkbZrpCYDGxox3jkxrdlhXNhLbXJS8+NtbA
   Qmk1W6xdebeJy5h7xO5h7LWMb02oXncPniikZ1ejaerFFg8z/pYi6mdKI
   lE59mkIl/gfbGCw7BNNM5avXswNipjWQWxEpn26YaYmgNPauLzSA+mXcO
   iC5Fl1sRPPx8m1+7agkIXLGQ7KqRajwZRn5hcK2UrJ2+YIcKFHdJOUcKF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="273911449"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="273911449"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 15:18:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="701453281"
Received: from halucas-mobl3.amr.corp.intel.com ([10.212.241.159])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 15:18:53 -0800
Date: Wed, 9 Feb 2022 15:18:53 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: mark ops structures as ro_after_init
In-Reply-To: <20220209102933.20873-1-fw@strlen.de>
Message-ID: <e978ec2-dd24-8bc1-f3e9-d6d8e74aa5ad@linux.intel.com>
References: <20220209102933.20873-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 9 Feb 2022, Florian Westphal wrote:

> These structures are initialised from the init hooks, so we can't make
> them 'const'.  But no writes occur afterwards, so we can use ro_after_init.
>
> Also, remove bogus EXPORT_SYMBOL, the only access comes from ip
> stack, not from kernel modules.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> net/mptcp/subflow.c | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)

Looks good to me, thanks Florian.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index d4b4d285ffc1..289df4fd0a73 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -482,8 +482,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
> }
>
> struct request_sock_ops mptcp_subflow_request_sock_ops;
> -EXPORT_SYMBOL_GPL(mptcp_subflow_request_sock_ops);
> -static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops;
> +static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops __ro_after_init;
>
> static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
> {
> @@ -504,9 +503,9 @@ static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
> }
>
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops;
> -static struct inet_connection_sock_af_ops subflow_v6_specific;
> -static struct inet_connection_sock_af_ops subflow_v6m_specific;
> +static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops __ro_after_init;
> +static struct inet_connection_sock_af_ops subflow_v6_specific __ro_after_init;
> +static struct inet_connection_sock_af_ops subflow_v6m_specific __ro_after_init;
> static struct proto tcpv6_prot_override;
>
> static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
