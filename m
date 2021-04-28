Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B4B71
	for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 09:52:54 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lbggV-0003Tx-R9; Wed, 28 Apr 2021 11:40:43 +0200
Date: Wed, 28 Apr 2021 11:40:43 +0200
From: Florian Westphal <fw@strlen.de>
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v2 mptcp-next 1/4] mptcp: add sysctl
 allow_join_initial_addr_port
Message-ID: <20210428094043.GC975@breakpoint.cc>
References: <cover.1619592361.git.geliangtang@gmail.com>
 <51758a7f629764dc91186acbf09665992e5b8e69.1619592361.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51758a7f629764dc91186acbf09665992e5b8e69.1619592361.git.geliangtang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Geliang Tang <geliangtang@gmail.com> wrote:
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 96ba616f59bf..3b963a25d5a8 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -19,6 +19,7 @@ struct mptcp_pernet {
>  
>  	int mptcp_enabled;
>  	unsigned int add_addr_timeout;
> +	int allow_join_initial_addr_port;

u8 allow_join_initial_addr_port;

>  static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
> @@ -36,6 +37,11 @@ unsigned int mptcp_get_add_addr_timeout(struct net *net)
>  	return mptcp_get_pernet(net)->add_addr_timeout;
>  }
>  
> +int mptcp_is_allow_join_id0(struct net *net)
> +{
> +	return mptcp_get_pernet(net)->allow_join_initial_addr_port;
> +}
> +
>  static struct ctl_table mptcp_sysctl_table[] = {
>  	{
>  		.procname = "enabled",
> @@ -52,6 +58,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
>  		.mode = 0644,
>  		.proc_handler = proc_dointvec_jiffies,
>  	},
> +	{
> +		.procname = "allow_join_initial_addr_port",
> +		.maxlen = sizeof(int),

sizeof(u8),

> +		.mode = 0644,
> +		.proc_handler = proc_dointvec,

.proc_handler   = proc_dou8vec_minmax,
.extra1         = SYSCTL_ZERO,
.extra2         = SYSCTL_ONE
