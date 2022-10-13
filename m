Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9784429
	for <mptcp@lists.linux.dev>; Thu, 13 Oct 2022 21:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665697996; x=1697233996;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=N+U4NbTOeGkgzTCy+QoasZqPKmGQLQZ4/XM3CvIhT7M=;
  b=lZTyJV3Mwb7NFZ55fCTns3/nCLxsPbnnX+MDu4Q7DI/bvowprZaEf2OZ
   2n1Dsd++TrnuTAMfTzrfBLIH+hkrSDPuisc2x31/R/+YIvFWMoyGiyzlt
   SdBJeVEy5blDCaJdCbGdl6yod82Jtme43hbwZ4cpco+N/FyW7sUPISqTi
   CoTW4PqcKiXk9hi3jWw5QJ3Ow4LryhtCUdAdfNTHnlBg2+uNXtakNQQK0
   cpJVfLrjiNM9ydj1Ed83ba2lqyO+B3/GRaLNjRfQ4u+UmTn575vBVXo5q
   dE7Ll16V6EeR3PhWIq6a+jphLosKUcFlzCnHv1001RTVskF2y1tDrWsju
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="331724306"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="331724306"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 14:53:15 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="629704226"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="629704226"
Received: from pateldee-mobl5.amr.corp.intel.com ([10.209.118.62])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 14:53:15 -0700
Date: Thu, 13 Oct 2022 14:53:14 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v3] mptcp: fix abba deadlock on fastopen
In-Reply-To: <7c61250080c052b9dfb42a023c85dc36d4450daf.1665584136.git.pabeni@redhat.com>
Message-ID: <66083822-e88d-19f7-7348-fc1cf66ea2fd@linux.intel.com>
References: <7c61250080c052b9dfb42a023c85dc36d4450daf.1665584136.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 12 Oct 2022, Paolo Abeni wrote:

> Our CI reported lockdep splat in the fastopen code:
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.0.0.mptcp_f5e8bfe9878d+ #1558 Not tainted
> ------------------------------------------------------
> packetdrill/1071 is trying to acquire lock:
> ffff8881bd198140 (sk_lock-AF_INET){+.+.}-{0:0}, at: inet_wait_for_connect+0x19c/0x310
>
> but task is already holding lock:
> ffff8881b8346540 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg+0xfdf/0x1740
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (k-sk_lock-AF_INET){+.+.}-{0:0}:
>        __lock_acquire+0xb6d/0x1860
>        lock_acquire+0x1d8/0x620
>        lock_sock_nested+0x37/0xd0
>        inet_stream_connect+0x3f/0xa0
>        mptcp_connect+0x411/0x800
>        __inet_stream_connect+0x3ab/0x800
>        mptcp_stream_connect+0xac/0x110
>        __sys_connect+0x101/0x130
>        __x64_sys_connect+0x6e/0xb0
>        do_syscall_64+0x59/0x90
>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> -> #0 (sk_lock-AF_INET){+.+.}-{0:0}:
>        check_prev_add+0x15e/0x2110
>        validate_chain+0xace/0xdf0
>        __lock_acquire+0xb6d/0x1860
>        lock_acquire+0x1d8/0x620
>        lock_sock_nested+0x37/0xd0
>        inet_wait_for_connect+0x19c/0x310
>        __inet_stream_connect+0x26c/0x800
>        tcp_sendmsg_fastopen+0x341/0x650
>        mptcp_sendmsg+0x109d/0x1740
>        sock_sendmsg+0xe1/0x120
>        __sys_sendto+0x1c7/0x2a0
>        __x64_sys_sendto+0xdc/0x1b0
>        do_syscall_64+0x59/0x90
>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(k-sk_lock-AF_INET);
>                                lock(sk_lock-AF_INET);
>                                lock(k-sk_lock-AF_INET);
>   lock(sk_lock-AF_INET);
>
>  *** DEADLOCK ***
>
> 1 lock held by packetdrill/1071:
>  #0: ffff8881b8346540 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg+0xfdf/0x1740
> ======================================================
>
> The problem is caused by the blocking inet_wait_for_connect() releasing
> and re-acquiring the msk socket lock while the subflow socket lock is
> still held and the MPTCP socket requires that the msk socket lock must
> be acquired before the subflow socket lock.
>
> Address the issue always invoking tcp_sendmsg_fastopen() in an
> unblocking manner, and later eventually complete the blocking
> __inet_stream_connect() as needed.
>
> Fixes: d98a82a6afc7 ("mptcp: handle defer connect in mptcp_sendmsg")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
> - dropped FASTOPEN_CONNECT chunk (Matttbe)
> - comments fixlet (Matttbe)
> - rebased on top of (""mptcp: factor out mptcp_connect()")
>

I don't know if Matthieu would like additional changes, but with the 
suggested change to https://github.com/multipath-tcp/packetdrill/pull/97 
this v3 patch is testing fine for me:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> v1 -> v2:
> - really invoke fastopen in unblocking manner
> - clear copied_syn on completion errors
> ---
> net/mptcp/protocol.c | 49 ++++++++++++++++++++++++++++++--------------
> 1 file changed, 34 insertions(+), 15 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1cdf9cd1a3cc..82d899233df4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1673,6 +1673,37 @@ static void mptcp_set_nospace(struct sock *sk)
> 	set_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags);
> }
>
> +static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msghdr *msg,
> +				  size_t len, int *copied_syn)
> +{
> +	unsigned int saved_flags = msg->msg_flags;
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	int ret;
> +
> +	lock_sock(ssk);
> +	msg->msg_flags |= MSG_DONTWAIT;
> +	msk->connect_flags = O_NONBLOCK;
> +	msk->is_sendmsg = 1;
> +	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
> +	msk->is_sendmsg = 0;
> +	msg->msg_flags = saved_flags;
> +	release_sock(ssk);
> +
> +	/* do the blocking bits of inet_stream_connect outside the ssk socket lock */
> +	if (ret == -EINPROGRESS && !(msg->msg_flags & MSG_DONTWAIT)) {
> +		ret = __inet_stream_connect(sk->sk_socket, msg->msg_name,
> +					    msg->msg_namelen, msg->msg_flags, 1);
> +
> +		/* Keep the same behaviout of plain TCP: zero the copied bytes in
> +		 * case of any error, except timeout or signal
> +		 */
> +		if (ret && ret != -EINPROGRESS && ret != -ERESTARTSYS && ret != -EINTR)
> +			*copied_syn = 0;
> +	}
> +
> +	return ret;
> +}
> +
> static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> @@ -1693,26 +1724,14 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>
> 	ssock = __mptcp_nmpc_socket(msk);
> 	if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect)) {
> -		struct sock *ssk = ssock->sk;
> 		int copied_syn = 0;
>
> -		lock_sock(ssk);
> -
> -		msk->connect_flags = (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
> -		msk->is_sendmsg = 1;
> -		ret = tcp_sendmsg_fastopen(ssk, msg, &copied_syn, len, NULL);
> -		msk->is_sendmsg = 0;
> +		ret = mptcp_sendmsg_fastopen(sk, ssock->sk, msg, len, &copied_syn);
> 		copied += copied_syn;
> -		if (ret == -EINPROGRESS && copied_syn > 0) {
> -			/* reflect the new state on the MPTCP socket */
> -			inet_sk_state_store(sk, inet_sk_state_load(ssk));
> -			release_sock(ssk);
> +		if (ret == -EINPROGRESS && copied_syn > 0)
> 			goto out;
> -		} else if (ret) {
> -			release_sock(ssk);
> +		else if (ret)
> 			goto do_error;
> -		}
> -		release_sock(ssk);
> 	}
>
> 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
> -- 
> 2.37.3
>
>
>

--
Mat Martineau
Intel
