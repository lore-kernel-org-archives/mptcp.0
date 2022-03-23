Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6711391
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 10:22:47 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1nWxt6-0000CG-Qm; Wed, 23 Mar 2022 11:06:44 +0100
Date: Wed, 23 Mar 2022 11:06:44 +0100
From: Florian Westphal <fw@strlen.de>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: add pm_nl_get_pernet helper
Message-ID: <20220323100644.GH24574@breakpoint.cc>
References: <44d42216864c1ec295ddf7098327fe5603dfc448.1648029714.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44d42216864c1ec295ddf7098327fe5603dfc448.1648029714.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Geliang Tang <geliang.tang@suse.com> wrote:
> This patch added a new helper pm_nl_get_pernet(). Ues it instead of
> using pm_nl_pernet_id directly.

If you're already touching this, then ...

> +static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
> +{
> +	return net_generic(net, pm_nl_pernet_id);
> +}
> +

It would make sense to add a second helper that returns pm_nl_pernet
struct given 'struct mptcp_sock *'.

>  static bool addresses_equal(const struct mptcp_addr_info *a,
>  			    const struct mptcp_addr_info *b, bool use_port)
>  {
> @@ -208,7 +213,7 @@ unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk)
>  {
>  	const struct pm_nl_pernet *pernet;
>  
> -	pernet = net_generic(sock_net((const struct sock *)msk), pm_nl_pernet_id);
> +	pernet = pm_nl_get_pernet(sock_net((const struct sock *)msk));

This would avoid all these cast.

Something like

> +	pernet = pm_nl_get_pernet_from_msk(msk);

... or similar.
