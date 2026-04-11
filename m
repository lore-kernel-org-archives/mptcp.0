Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6E52C235E
	for <mptcp@lists.linux.dev>; Sat, 11 Apr 2026 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775868001; cv=none; b=XpXEe27Dg1StnWInrwBQ/Ni5ELW7ToyVAneOQRcIB8gLiKtYEQ9e8I9WOZe/FYP0lfDhQjR/PiMr+d9hL4O52gDltpB42zaZCF/p4qo3MD7DwSgGrNyWaRTIp2CWheCavGJb60GKc2o/SH1pudxa5x24DK7pWM2HmytJWJgZRF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775868001; c=relaxed/simple;
	bh=9bovpwFaE/c/kUpyJtyXyVfP0AUceLsZ/oF1U0P0mSQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NqmTT1hOAjHSBZtc8XkEt9PH6nrKHXZUoJJY3QFIEk1ozmYcPUMOz8uXktq/mQLItwqftyAMpigY5OJiGo3zJ523a8QqYEXOQf75AJU4UWFx7+c07KBZ8aiUST8LFc89e3s9tg32ZVm1s9xcLq24dNJZMtS0XYhabTPX8fTOin8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlH937NO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlH937NO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4816C19421;
	Sat, 11 Apr 2026 00:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775868001;
	bh=9bovpwFaE/c/kUpyJtyXyVfP0AUceLsZ/oF1U0P0mSQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=jlH937NO+NDbJSlaM9RJKYcJCAXnovoMOpe2KG2S62ZwkOpT0WyGtbto9jrkzZveW
	 dcNORfH1UTYbweY9wAlj2QTf3qlwUTiwZ5LKLu+TQhk3a5nffY8qFPxrlCRTTmAIOM
	 +4T2RZwA14O4eFovwCUK3/ANwfeL7eHRtbMu8d0G+kXvlrKWdHK0vlmbxpDw8nrXF/
	 GRqWzUESSZyacKPESb/oWUHx2aQ3xNeCPO609RMJ/uoDJvVH6VFWm6LW7zmXH9J4jT
	 M3nbligMDzmKHXiMGGAOjO3nzrmhV0kz9HjvamHbuKp1Q2S5yV18rgqkOOrPuIzxrR
	 bloExDN+zcqxw==
Date: Fri, 10 Apr 2026 17:40:00 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>, 
    kernel test robot <lkp@intel.com>, Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH mptcp-next v3 1/2] mptcp: implement
 psock_update_sk_prot
In-Reply-To: <30cc0b1a7ecee5473df79e02fe4863154af0331a.1773826662.git.tanggeliang@kylinos.cn>
Message-ID: <d20a2b87-c4c4-983a-7f16-480f390d3586@kernel.org>
References: <cover.1773826662.git.tanggeliang@kylinos.cn> <30cc0b1a7ecee5473df79e02fe4863154af0331a.1773826662.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 18 Mar 2026, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Add MPTCP support for BPF sockmap by implementing psock_update_sk_prot
> callback. This allows MPTCP sockets to dynamically switch protocol
> handlers when attached to or detached from sockmap programs. Separate
> protocol structures are maintained for IPv4/IPv6 and TX/RX configurations.
>
> tcp_bpf_update_proto() in net/ipv4/tcp_bpf.c is a frame of reference for
> this patch.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512261144.DxrvwMS3-lkp@intel.com/
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/521
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> net/mptcp/protocol.c | 113 +++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 113 insertions(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b5676b37f8f4..7a485694323b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -11,6 +11,7 @@
> #include <linux/netdevice.h>
> #include <linux/sched/signal.h>
> #include <linux/atomic.h>
> +#include <linux/skmsg.h>
> #include <net/aligned_data.h>
> #include <net/rps.h>
> #include <net/sock.h>
> @@ -4020,6 +4021,106 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
> 	return 0;
> }
>
> +#ifdef CONFIG_BPF_SYSCALL
> +enum {
> +	MPTCP_BPF_IPV4,
> +	MPTCP_BPF_IPV6,
> +	MPTCP_BPF_NUM_PROTS,
> +};
> +
> +enum {
> +	MPTCP_BPF_BASE,
> +	MPTCP_BPF_TX,
> +	MPTCP_BPF_RX,
> +	MPTCP_BPF_TXRX,
> +	MPTCP_BPF_NUM_CFGS,
> +};
> +
> +static struct proto mptcp_bpf_prots[MPTCP_BPF_NUM_PROTS][MPTCP_BPF_NUM_CFGS];
> +
> +static void mptcp_bpf_rebuild_protos(struct proto prot[MPTCP_BPF_NUM_CFGS],
> +				     struct proto *base)
> +{
> +	prot[MPTCP_BPF_BASE]			= *base;
> +	prot[MPTCP_BPF_BASE].destroy		= sock_map_destroy;
> +	prot[MPTCP_BPF_BASE].close		= sock_map_close;
> +	prot[MPTCP_BPF_BASE].sock_is_readable	= sk_msg_is_readable;
> +
> +	prot[MPTCP_BPF_TX]			= prot[MPTCP_BPF_BASE];
> +	prot[MPTCP_BPF_RX]			= prot[MPTCP_BPF_BASE];
> +	prot[MPTCP_BPF_TXRX]			= prot[MPTCP_BPF_TX];

Hi Geliang -

Minor thing, can you change the last line to also assign from 
prot[MPTCP_BPF_BASE]? The tcp_bpf.c code does copy from TCP_BPF_TX but it 
has a different sendmsg member value.

Related question: why does TCP have separate sendmsg/recvmsg for BPF but 
MPTCP does not? The cover letter mentions "basic MPTCP BPF sockmap 
support", so it looks like not all sockmap functionality is implemented. 
Can you update the commit message and add some comment explaining what 
sockmap functionality is missing in MPTCP relative to TCP?


> +}
> +
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +static struct proto *mptcpv6_prot_saved __read_mostly;
> +static DEFINE_SPINLOCK(mptcpv6_prot_lock);
> +
> +static void mptcp_bpf_check_v6_needs_rebuild(struct proto *ops)
> +{
> +	/*
> +	 * Load with acquire semantics to ensure we see the latest protocol
> +	 * structure before checking for rebuild.
> +	 */
> +	if (unlikely(ops != smp_load_acquire(&mptcpv6_prot_saved))) {
> +		spin_lock_bh(&mptcpv6_prot_lock);
> +		if (likely(ops != mptcpv6_prot_saved)) {
> +			mptcp_bpf_rebuild_protos(mptcp_bpf_prots[MPTCP_BPF_IPV6],
> +						 ops);
> +			/* Ensure mptcpv6_prot_saved update is visible before
> +			 * releasing lock
> +			 */
> +			smp_store_release(&mptcpv6_prot_saved, ops);
> +		}
> +		spin_unlock_bh(&mptcpv6_prot_lock);
> +	}
> +}
> +
> +static int mptcp_bpf_assert_proto_ops(struct proto *ops)
> +{
> +	/* In order to avoid retpoline, we make assumptions when we call
> +	 * into ops if e.g. a psock is not present. Make sure they are
> +	 * indeed valid assumptions.
> +	 */
> +	return ops->recvmsg  == mptcp_recvmsg &&
> +	       ops->sendmsg  == mptcp_sendmsg ? 0 : -EOPNOTSUPP;

Please fix the extra space before each "==" as well.

> +}
> +#endif
> +
> +static int mptcp_bpf_update_proto(struct sock *sk,
> +				  struct sk_psock *psock,
> +				  bool restore)
> +{
> +	int family = sk->sk_family == AF_INET6 ? MPTCP_BPF_IPV6 :
> +						 MPTCP_BPF_IPV4;
> +	int config = psock->progs.msg_parser   ? MPTCP_BPF_TX   :
> +						 MPTCP_BPF_BASE;
> +
> +	if (psock->progs.stream_verdict || psock->progs.skb_verdict)
> +		config = (config == MPTCP_BPF_TX) ? MPTCP_BPF_TXRX :
> +						    MPTCP_BPF_RX;
> +
> +	if (restore) {
> +		WRITE_ONCE(sk->sk_write_space, psock->saved_write_space);
> +		/* Pairs with lockless read in sk_clone_lock() */
> +		sock_replace_proto(sk, psock->sk_proto);
> +		return 0;
> +	}
> +
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	if (sk->sk_family == AF_INET6) {
> +		if (mptcp_bpf_assert_proto_ops(psock->sk_proto))
> +			return -EINVAL;
> +
> +		mptcp_bpf_check_v6_needs_rebuild(psock->sk_proto);
> +	}
> +#endif
> +
> +	/* Pairs with lockless read in sk_clone_lock() */

I see where this was copied from the tcp code, but there is no lockless 
read in sk_clone_lock(). It's in sk_clone().

Thanks,
Mat


> +	sock_replace_proto(sk, &mptcp_bpf_prots[family][config]);
> +	return 0;
> +}
> +#endif
> +
> static struct proto mptcp_prot = {
> 	.name		= "MPTCP",
> 	.owner		= THIS_MODULE,
> @@ -4051,8 +4152,20 @@ static struct proto mptcp_prot = {
> 	.obj_size	= sizeof(struct mptcp_sock),
> 	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
> 	.no_autobind	= true,
> +#ifdef CONFIG_BPF_SYSCALL
> +	.psock_update_sk_prot	= mptcp_bpf_update_proto,
> +#endif
> };
>
> +#ifdef CONFIG_BPF_SYSCALL
> +static int __init mptcp_bpf_v4_build_proto(void)
> +{
> +	mptcp_bpf_rebuild_protos(mptcp_bpf_prots[MPTCP_BPF_IPV4], &mptcp_prot);
> +	return 0;
> +}
> +late_initcall(mptcp_bpf_v4_build_proto);
> +#endif
> +
> static int mptcp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
> -- 
> 2.51.0
>
>
>
