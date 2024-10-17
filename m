Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2055412E7F
	for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 01:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729128512; cv=none; b=p6EjguN1Fq1DbHisUgNC+Nt4OBl15qF8W23vG551VvDXIc/yaFJJlP+DtXb4f0sJTWT/ytEm/QSoUWweaIf2Flt/8w9a/wr+q7CNI4T3noChW9w+c79ziHpb93tFOb1ayKtQpJ9ayuLPWTop7yQlbMMjuzpXdlZmsod4N/dsJY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729128512; c=relaxed/simple;
	bh=3Zh+2hfOGQff2DZiht440kPPdXTdL3or+ipwYHwKLrA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d1yTUIoJ4LvgiEg1GWNdwvx9OybBWHl+VOy1/zX4dtwt0NpA6Zgj3ROTnBHV5bHK5XKPbhnowfFsIcMCwop1/YnIItig7zzk7ZZf1mWOuXj/Q94tKVr/zmttePu6AKXfdE+5Uc4g27HK8QVhdG8cj+4dS3r9QiqBPhlF7o7rjCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aS059l90; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aS059l90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B941DC4CEC5;
	Thu, 17 Oct 2024 01:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729128511;
	bh=3Zh+2hfOGQff2DZiht440kPPdXTdL3or+ipwYHwKLrA=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=aS059l90MQI83HABO8+ADa4DX1JUSMBnDhZssuM4gUmzE3WfCSAKB/vqbh8TKCCU2
	 iku6WKcNX+oLdvtGe636MfO6ozn84beRTifLwHBEaHxh4uKei2JH7aJXYLACD8qhM+
	 e4DN4oROFmG/GP6gqBKcr4+xr71FWea4raiumRSBpy3GGkz9J4NDGlDKlkwAno9Uqj
	 AY+S6CvrPdyZhmzA5PBRRrhC2qN75pnOyH2HoKfOsfG0HXelnpngf+rHWiIHQd+Mfp
	 1NzxxTmqAhqwfqQn8q5CUDVgOIVG0xZRDiRNek+YUETqtnucfOesoL1iaMt9L27gl3
	 kr6LqOdbNJuHw==
Message-ID: <0f2bb0288b7ec128c80c45dd4ae16c8b8b1236d3.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 1/2] mptcp: init: protect sched with
 rcu_read_lock
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Thu, 17 Oct 2024 09:28:27 +0800
In-Reply-To: <20241016-mptcp-sched-find-rcu-v1-1-5e9af4fbce11@kernel.org>
References: <20241016-mptcp-sched-find-rcu-v1-0-5e9af4fbce11@kernel.org>
	 <20241016-mptcp-sched-find-rcu-v1-1-5e9af4fbce11@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this fix.

On Wed, 2024-10-16 at 21:05 +0200, Matthieu Baerts (NGI0) wrote:
> Enabling CONFIG_PROVE_RCU_LIST with its dependence CONFIG_RCU_EXPERT
> creates this splat when an MPTCP socket is created:
> 
>   =============================
>   WARNING: suspicious RCU usage
>   6.12.0-rc2+ #11 Not tainted
>   -----------------------------
>   net/mptcp/sched.c:44 RCU-list traversed in non-reader section!!
> 
>   other info that might help us debug this:
> 
>   rcu_scheduler_active = 2, debug_locks = 1
>   no locks held by mptcp_connect/176.
> 
>   stack backtrace:
>   CPU: 0 UID: 0 PID: 176 Comm: mptcp_connect Not tainted 6.12.0-rc2+
> #11
>   Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
>   Call Trace:
>    <TASK>
>    dump_stack_lvl (lib/dump_stack.c:123)
>    lockdep_rcu_suspicious (kernel/locking/lockdep.c:6822)
>    mptcp_sched_find (net/mptcp/sched.c:44 (discriminator 7))
>    mptcp_init_sock (net/mptcp/protocol.c:2867 (discriminator 1))
>    ? sock_init_data_uid (arch/x86/include/asm/atomic.h:28)
>    inet_create.part.0.constprop.0 (net/ipv4/af_inet.c:386)
>    ? __sock_create (include/linux/rcupdate.h:347 (discriminator 1))
>    __sock_create (net/socket.c:1576)
>    __sys_socket (net/socket.c:1671)
>    ? __pfx___sys_socket (net/socket.c:1712)
>    ? do_user_addr_fault (arch/x86/mm/fault.c:1419 (discriminator 1))
>    __x64_sys_socket (net/socket.c:1728)
>    do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1))
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> 
> That's because when the socket is initialised, rcu_read_lock() is not
> used despite the explicit comment written above the declaration of
> mptcp_sched_find() in sched.c. Adding the missing lock/unlock avoids
> the
> warning.
> 
> Fixes: 1730b2b2c5a5 ("mptcp: add sched in mptcp_sock")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/523
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Geliang Tang <geliang@kernel.org>

Good catch!

Some code in tcp_ca_dst_init() uses rcu_read_lock() too:

        rcu_read_lock();
        ca = tcp_ca_find_key(ca_key);
        if (likely(ca && bpf_try_module_get(ca, ca->owner))) {
                bpf_module_put(...);
                icsk->icsk_ca_dst_locked = tcp_ca_dst_locked(dst);
                icsk->icsk_ca_ops = ca;
        }
        rcu_read_unlock();

I will also sync this part of the changes to BPF path manager code
which is under review.

-Geliang

> ---
>  net/mptcp/protocol.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index
> e420ce9bbfb6e0527ed3ce8cbe2a0990c6366d12..21bc3586c33e16471056fedf49e
> e044ba27731d9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2864,8 +2864,10 @@ static int mptcp_init_sock(struct sock *sk)
>   if (unlikely(!net->mib.mptcp_statistics) && !mptcp_mib_alloc(net))
>   return -ENOMEM;
>  
> + rcu_read_lock();
>   ret = mptcp_init_sched(mptcp_sk(sk),
>          mptcp_sched_find(mptcp_get_scheduler(net)));
> + rcu_read_unlock();
>   if (ret)
>   return ret;
>  
> 

