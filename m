Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FBE10785
	for <mptcp@lists.linux.dev>; Thu,  5 Jan 2023 20:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672950401; x=1704486401;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IpodKiGodZYdzkYzPa+eM2hg8Z9LUQzK7QLyUXw7ofQ=;
  b=TfvODfwMF7ATh+lHt43QU1+wLtuzP9cZ+nq43pqR5J0cSRwQ/nMyUcOe
   3z2fkGLPHAf7f2AN3znVk7Y/hOEs0kTnSPxo3Bfn4Zrg2vpmcnyjBXTpC
   v0DJbNzcSkeW9OmPhOTWtqdIlJZzXxO1mFRz6dtbYjgQhR7PNnJnp1b3H
   TA0FM8ai/Mldd/iZG6GtV+gCwMcQhZcf9eosadDUlSpOiLYxuTYSvgESY
   /jlQ27Jh+iRQymRCl93qqi2qawtyNQhk5SzqB6tLNZ2S/pLVXMbT1J2eC
   IciQ4V4Z7ngZd32eJlactNpjK43sq88O/4S4p80HttUUgQ/zieDk433pA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="302684067"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="302684067"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 12:26:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="798039412"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="798039412"
Received: from bkrishn1-mobl.amr.corp.intel.com ([10.251.16.148])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 12:26:39 -0800
Date: Thu, 5 Jan 2023 12:26:29 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Shigeru Yoshida <syoshida@redhat.com>
cc: matthieu.baerts@tessares.net, davem@davemloft.net, edumazet@google.com, 
    kuba@kernel.org, pabeni@redhat.com, dmytro@shytyi.net, 
    netdev@vger.kernel.org, mptcp@lists.linux.dev, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mptcp: Fix deadlock in mptcp_sendmsg()
In-Reply-To: <20230105201205.1087439-1-syoshida@redhat.com>
Message-ID: <548fc9cf-b674-f37e-8ff7-9abae0bf15a8@linux.intel.com>
References: <20230105201205.1087439-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 6 Jan 2023, Shigeru Yoshida wrote:

> __mptcp_close_ssk() can be called from mptcp_sendmsg() with subflow
> socket locked.  This can cause a deadlock as below:
>
> mptcp_sendmsg()
>  mptcp_sendmsg_fastopen() --> lock ssk
>    tcp_sendmsg_fastopen()
>       __inet_stream_connect()
>          mptcp_disconnect()
>             mptcp_destroy_common()
>                __mptcp_close_ssk() --> lock ssk again
>
> This patch fixes the issue by skipping locking for subflow socket
> which is already locked.
>

Hi Shigeru -

I believe this has already been fixed by:

7d803344fdc3 ("mptcp: fix deadlock in fastopen error path")

It is in the net repo:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git

...but hasn't been merged to net-next or Linus' tree yet. Jakub said to 
expect a net PR today, which should get the fix both upstream and in to 
net-next.

Thanks,

Mat

> Fixes: d98a82a6afc7 ("mptcp: handle defer connect in mptcp_sendmsg")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
> net/mptcp/protocol.c | 15 +++++++++------
> net/mptcp/protocol.h |  4 ++--
> 2 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f6f93957275b..979265f66082 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1672,9 +1672,9 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msgh
> 	lock_sock(ssk);
> 	msg->msg_flags |= MSG_DONTWAIT;
> 	msk->connect_flags = O_NONBLOCK;
> -	msk->is_sendmsg = 1;
> +	msk->sendmsg_locked_sk = ssk;
> 	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
> -	msk->is_sendmsg = 0;
> +	msk->sendmsg_locked_sk = NULL;
> 	msg->msg_flags = saved_flags;
> 	release_sock(ssk);
>
> @@ -2319,7 +2319,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 	if (dispose_it)
> 		list_del(&subflow->node);
>
> -	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
> +	if (msk->sendmsg_locked_sk != ssk)
> +		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
>
> 	if (flags & MPTCP_CF_FASTCLOSE) {
> 		/* be sure to force the tcp_disconnect() path,
> @@ -2335,7 +2336,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 		tcp_disconnect(ssk, 0);
> 		msk->subflow->state = SS_UNCONNECTED;
> 		mptcp_subflow_ctx_reset(subflow);
> -		release_sock(ssk);
> +		if (msk->sendmsg_locked_sk != ssk)
> +			release_sock(ssk);
>
> 		goto out;
> 	}
> @@ -2362,7 +2364,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 		/* close acquired an extra ref */
> 		__sock_put(ssk);
> 	}
> -	release_sock(ssk);
> +	if (msk->sendmsg_locked_sk != ssk)
> +		release_sock(ssk);
>
> 	sock_put(ssk);
>
> @@ -3532,7 +3535,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
> 	/* if reaching here via the fastopen/sendmsg path, the caller already
> 	 * acquired the subflow socket lock, too.
> 	 */
> -	if (msk->is_sendmsg)
> +	if (msk->sendmsg_locked_sk)
> 		err = __inet_stream_connect(ssock, uaddr, addr_len, msk->connect_flags, 1);
> 	else
> 		err = inet_stream_connect(ssock, uaddr, addr_len, msk->connect_flags);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 955fb3d88eb3..43afc399e16b 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -294,8 +294,7 @@ struct mptcp_sock {
> 	u8		mpc_endpoint_id;
> 	u8		recvmsg_inq:1,
> 			cork:1,
> -			nodelay:1,
> -			is_sendmsg:1;
> +			nodelay:1;
> 	int		connect_flags;
> 	struct work_struct work;
> 	struct sk_buff  *ooo_last_skb;
> @@ -318,6 +317,7 @@ struct mptcp_sock {
> 	u32 setsockopt_seq;
> 	char		ca_name[TCP_CA_NAME_MAX];
> 	struct mptcp_sock	*dl_next;
> +	struct sock	*sendmsg_locked_sk;
> };
>
> #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
> -- 
> 2.39.0
>
>

--
Mat Martineau
Intel
