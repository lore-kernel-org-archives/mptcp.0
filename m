Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F0D29CA
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 20:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644525754; x=1676061754;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6Hmk+wteA/u8nX/seHyBarhAhiRilZWV/OVqBt6bUag=;
  b=aqkc4miAQxRad7hQLlheRon3/KlNl2bMPxp/ulRuLDXSZz+FaFSJJLx0
   JNd6L4SZ7bHybXoIyem95IfZV+MqkIFAWQbKDHnCB5TNQX41LbYU6KVXZ
   1iSDztrFePcJZfL8BPB0pMhn7PW495s85ui9cz8FJvUY0HatUAzbc6QKP
   e4olSdiIIdgE7AB1vHiXFHm/lRp0U42Dr68jMlAA5kfVhkPzbR9SK8kX4
   GBszs270jBY9GCgSZdopvZjgzN6O33+z0ZVcFMc8gn5hC6r7hduE1NjDv
   fHnlai9BnF2esW+yxoLtdBpeQtIXzfel6IxopRuYJ2zIQNyMs7h5SHpBx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="310326932"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="310326932"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 12:42:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="500533958"
Received: from dbosneag-mobl1.amr.corp.intel.com ([10.212.211.192])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 12:42:34 -0800
Date: Thu, 10 Feb 2022 12:42:33 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: subflow: get_af_ops should return
 const
In-Reply-To: <20220210145534.32660-1-fw@strlen.de>
Message-ID: <132d4b6b-c891-704f-f954-918648976a9@linux.intel.com>
References: <20220210145534.32660-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 10 Feb 2022, Florian Westphal wrote:

> Thre returned structure is read-only.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> Could be squashed with 'mptcp: mark ops structures as ro_after_init'.
>

Yeah, I agree that it would be good to squash with the other 
ro_after_init changes. Patch looks fine.

-Mat

> net/mptcp/subflow.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 5bd49a350750..e727d838da0e 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -787,7 +787,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> 	return child;
> }
>
> -static struct inet_connection_sock_af_ops subflow_specific;
> +static struct inet_connection_sock_af_ops subflow_specific __ro_after_init;
> static struct proto tcp_prot_override;
>
> enum mapping_status {
> @@ -1313,7 +1313,7 @@ static void subflow_write_space(struct sock *ssk)
> 	mptcp_write_space(sk);
> }
>
> -static struct inet_connection_sock_af_ops *
> +static const struct inet_connection_sock_af_ops *
> subflow_default_af_ops(struct sock *sk)
> {
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> @@ -1328,7 +1328,7 @@ void mptcpv6_handle_mapped(struct sock *sk, bool mapped)
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> 	struct inet_connection_sock *icsk = inet_csk(sk);
> -	struct inet_connection_sock_af_ops *target;
> +	const struct inet_connection_sock_af_ops *target;
>
> 	target = mapped ? &subflow_v6m_specific : subflow_default_af_ops(sk);
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
