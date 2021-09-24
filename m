Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FA472
	for <mptcp@lists.linux.dev>; Fri, 24 Sep 2021 18:51:43 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10117"; a="211384895"
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="211384895"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 11:51:42 -0700
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="551914561"
Received: from mmeylema-mobl2.amr.corp.intel.com ([10.212.170.226])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 11:51:42 -0700
Date: Fri, 24 Sep 2021 11:51:42 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-net] net: introduce and use
 lock_sock_fast_nested()
In-Reply-To: <46317e271da725006df9916b2b2c3d334d3616e1.1632490917.git.pabeni@redhat.com>
Message-ID: <6485e648-1038-736e-4da6-c513efb21ebf@linux.intel.com>
References: <46317e271da725006df9916b2b2c3d334d3616e1.1632490917.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 24 Sep 2021, Paolo Abeni wrote:

> Syzkaller reported a false positive deadlock involving
> the nl socket lock and the subflow socket lock:
>

...

>
> the problem originates from uncorrect lock annotation in the mptcp
> code and is only visible since commit 2dcb96bacce3 ("net: core: Correct
> the sock::sk_lock.owned lockdep annotations"), but is present since
> the port-based endpoint support initial implementation.
>
> This patch addresses the issue introducing a nested variant of
> lock_sock_fast() and using it in the relevant code path.
>
> Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
> Fixes: 2dcb96bacce3 ("net: core: Correct the sock::sk_lock.owned lockdep annotations")
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Reported-and-tested-by: syzbot+1dd53f7a89b299d59eaf@syzkaller.appspotmail.com
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
> - fix a typo into a comment (Mat)

Thanks for the v2 and the answers about inline functions vs. exported 
symbols.

Ok with me to merge in the export branch and/or upstream. I'm guessing you 
might want to send this one to netdev yourself?

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


- Mat


> ---
> include/net/sock.h   | 31 ++++++++++++++++++++++++++++++-
> net/core/sock.c      | 20 ++------------------
> net/mptcp/protocol.c |  2 +-
> 3 files changed, 33 insertions(+), 20 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index c005c3c750e8..dc3f8169312e 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1623,7 +1623,36 @@ void release_sock(struct sock *sk);
> 				SINGLE_DEPTH_NESTING)
> #define bh_unlock_sock(__sk)	spin_unlock(&((__sk)->sk_lock.slock))
>
> -bool lock_sock_fast(struct sock *sk) __acquires(&sk->sk_lock.slock);
> +bool __lock_sock_fast(struct sock *sk) __acquires(&sk->sk_lock.slock);
> +
> +/**
> + * lock_sock_fast - fast version of lock_sock
> + * @sk: socket
> + *
> + * This version should be used for very small section, where process wont block
> + * return false if fast path is taken:
> + *
> + *   sk_lock.slock locked, owned = 0, BH disabled
> + *
> + * return true if slow path is taken:
> + *
> + *   sk_lock.slock unlocked, owned = 1, BH enabled
> + */
> +static inline bool lock_sock_fast(struct sock *sk)
> +{
> +	/* The sk_lock has mutex_lock() semantics here. */
> +	mutex_acquire(&sk->sk_lock.dep_map, 0, 0, _RET_IP_);
> +
> +	return __lock_sock_fast(sk);
> +}
> +
> +/* fast socket lock variant for caller already holding a [different] socket lock */
> +static inline bool lock_sock_fast_nested(struct sock *sk)
> +{
> +	mutex_acquire(&sk->sk_lock.dep_map, SINGLE_DEPTH_NESTING, 0, _RET_IP_);
> +
> +	return __lock_sock_fast(sk);
> +}
>
> /**
>  * unlock_sock_fast - complement of lock_sock_fast
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 512e629f9780..7060d183216e 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3210,24 +3210,8 @@ void release_sock(struct sock *sk)
> }
> EXPORT_SYMBOL(release_sock);
>
> -/**
> - * lock_sock_fast - fast version of lock_sock
> - * @sk: socket
> - *
> - * This version should be used for very small section, where process wont block
> - * return false if fast path is taken:
> - *
> - *   sk_lock.slock locked, owned = 0, BH disabled
> - *
> - * return true if slow path is taken:
> - *
> - *   sk_lock.slock unlocked, owned = 1, BH enabled
> - */
> -bool lock_sock_fast(struct sock *sk) __acquires(&sk->sk_lock.slock)
> +bool __lock_sock_fast(struct sock *sk) __acquires(&sk->sk_lock.slock)
> {
> -	/* The sk_lock has mutex_lock() semantics here. */
> -	mutex_acquire(&sk->sk_lock.dep_map, 0, 0, _RET_IP_);
> -
> 	might_sleep();
> 	spin_lock_bh(&sk->sk_lock.slock);
>
> @@ -3256,7 +3240,7 @@ bool lock_sock_fast(struct sock *sk) __acquires(&sk->sk_lock.slock)
> 	spin_unlock_bh(&sk->sk_lock.slock);
> 	return true;
> }
> -EXPORT_SYMBOL(lock_sock_fast);
> +EXPORT_SYMBOL(__lock_sock_fast);
>
> int sock_gettstamp(struct socket *sock, void __user *userstamp,
> 		   bool timeval, bool time32)
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index dbcebf56798f..e5df0b5971c8 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2735,7 +2735,7 @@ static void mptcp_close(struct sock *sk, long timeout)
> 	inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32;
> 	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> -		bool slow = lock_sock_fast(ssk);
> +		bool slow = lock_sock_fast_nested(ssk);
>
> 		sock_orphan(ssk);
> 		unlock_sock_fast(ssk, slow);
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
