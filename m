Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1288871
	for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 09:43:13 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lbgiu-0003Ut-64; Wed, 28 Apr 2021 11:43:12 +0200
Date: Wed, 28 Apr 2021 11:43:12 +0200
From: Florian Westphal <fw@strlen.de>
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v2 mptcp-next 3/4] mptcp: add deny_join_id0 in
 mptcp_options_received
Message-ID: <20210428094312.GD975@breakpoint.cc>
References: <cover.1619592361.git.geliangtang@gmail.com>
 <51758a7f629764dc91186acbf09665992e5b8e69.1619592361.git.geliangtang@gmail.com>
 <65d1e4e729dfbeb5d0e51760affe2745e211cb50.1619592361.git.geliangtang@gmail.com>
 <c166cd5a8d0a2357650f0bb83f987deb4140ed23.1619592361.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c166cd5a8d0a2357650f0bb83f987deb4140ed23.1619592361.git.geliangtang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Geliang Tang <geliangtang@gmail.com> wrote:
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 9d00fa6d22e9..e3489766caf3 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -247,6 +247,15 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
>  	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, mptcp_sk(subflow->conn), sk, GFP_ATOMIC);
>  }
>  
> +void mptcp_pm_deny_join_id0_received(struct mptcp_sock *msk)
> +{
> +	struct mptcp_pm_data *pm = &msk->pm;
> +
> +	spin_lock_bh(&pm->lock);
> +	WRITE_ONCE(pm->deny_join_id0, true);
> +	spin_unlock_bh(&pm->lock);

Spinlock isn't needed.
