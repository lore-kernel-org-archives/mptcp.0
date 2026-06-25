Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0314E3815CA
	for <mptcp@lists.linux.dev>; Thu, 25 Jun 2026 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782387663; cv=none; b=GPVJ9OmA5bc8utzNuHvfTG45Fbfm+eaa0Pp7cdiQ2YysBMFemtVunX9ezHpAbBhbVjhtmlXdLF89mVr9MiFKjRouO11qqudhT8kmiU4bmZxm7Zbp2cRHdwqBLtuFfNayUDbzgnH2YAQcUeIbFQOvUBU+8TVjsqd0NuuLQaZaU0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782387663; c=relaxed/simple;
	bh=ZZiO+afdvZzxY0P/cJOEDl4wlyaYuPOD9uQwGaj6fLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OgKaG56C2hQQ5TVJAgg5Cz56ZdPxgSwbE38ugDiUhAtf4SR7UO5wrdSlGi+7EIiHMgwiVQ2GaVCwjQUPb92PO98L1rG/wwZw3+Avv5PjJK6dVJ4CmagwiVP+I3rnUcgLK5HoHKO2pPutCwkrTO44CRPeg7liaMno/AUVECBeXZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0nADGDls; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0nADGDls"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=k0oeC5pAOu2HtFl4AKz/+oLwq1YsbZKR5gYNQfg0SOw=;
	b=0nADGDlsIgN7GKQbFcilANaslZXOffUf9AKjOv9y9s1+Jq6pElRs5mtlNC4pXfp7OC9tyOGES
	ow6uPNBF1/6NYhxOUmdRVnKfzshotHHDzrTIEohFJScO5eGnO6eKAhJ27ZhuiGgA0+JvliYRvE0
	UmhhnwwG2yl13ws2BEhVcLE=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gmGr66FGrzpTQ8;
	Thu, 25 Jun 2026 19:32:38 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 43FF340538;
	Thu, 25 Jun 2026 19:40:56 +0800 (CST)
Received: from [10.174.178.79] (10.174.178.79) by
 kwepemj500018.china.huawei.com (7.202.194.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Jun 2026 19:40:55 +0800
Message-ID: <5ab3efab-1276-4268-98d0-a9f141e56f8c@huawei.com>
Date: Thu, 25 Jun 2026 19:40:54 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] mptcp: bpf: fix NULL derefs in
 bpf_mptcp_sock_from_subflow()
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
CC: <matttbe@kernel.org>, <martineau@kernel.org>, <pabeni@redhat.com>,
	<shardul.b@mpiricsoftware.com>, <janak@mpiric.us>, <kalpanjani009@gmail.com>,
	<shardulsb08@gmail.com>, zhangchangzhong <zhangchangzhong@huawei.com>,
	yuehaibing <yuehaibing@huawei.com>, "weiyongjun (A)"
	<weiyongjun1@huawei.com>, "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>
References: <20260612072643.2313900-1-kalpan.jani@mpiricsoftware.com>
From: Li Xiasong <lixiasong1@huawei.com>
In-Reply-To: <20260612072643.2313900-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj500018.china.huawei.com (7.202.194.48)

Hi Kalpan,

I noticed this patch has been on the list for a while, so I took a look
and have a couple of comments.

On 6/12/2026 3:26 PM, Kalpan Jani wrote:
> bpf_mptcp_sock_from_subflow() is reachable from tracing BPF programs via
> bpf_skc_to_mptcp_sock() on an arbitrary socket, without the socket lock
> held. It assumes sk_is_mptcp(sk) implies a valid subflow context whose
> ->conn points to a parent mptcp_sock. That invariant does not hold in
> two lifecycle windows:
> 

This helper can indeed be called without holding the subflow socket lock.

> - Fallback: subflow_ulp_fallback() clears icsk_ulp_data before clearing
>   tcp_sk(sk)->is_mptcp, so a concurrent reader can observe is_mptcp == 1
>   with a NULL context, dereferencing NULL via mptcp_subflow_ctx(sk)->conn.
> 
> - Init: subflow_ulp_init() sets is_mptcp = 1 while ctx->conn is still
>   NULL. As mptcp_sk() is a container_of() on a non-zero offset member,
>   mptcp_sk(NULL) yields a non-NULL bogus pointer that passes the verifier
>   NULL check (RET_PTR_TO_BTF_ID_OR_NULL); on CONFIG_DEBUG_NET the
>   mptcp_sk() WARN_ON dereferences it directly.
> 

These two NULL cases look real to me.

> Load the context once and reject a NULL context or NULL ->conn before
> casting.
> 
> Fixes: 3bc253c2e652 ("bpf: Add bpf_skc_to_mptcp_sock_proto")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/622

I don't think this fully closes #622.  That issue also mentions a stale
ctx->conn / UAF case during teardown, while this patch only addresses the
immediate NULL-deref cases.

> Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
> ---
>  net/mptcp/bpf.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 08bb037f0951..f40905fbe7d4 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -193,8 +193,13 @@ static struct bpf_struct_ops bpf_mptcp_sched_ops = {
>  
>  struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
>  {
> -	if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk))
> -		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
> +	struct mptcp_subflow_context *ctx;
> +
> +	if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk)) {
> +		ctx = mptcp_subflow_ctx(sk);
> +		if (ctx && ctx->conn)
> +			return mptcp_sk(ctx->conn);
> +	}
>  
>  	return NULL;
>  }

This still seems incomplete for the lockless access pattern used here.

icsk_ulp_data is an __rcu pointer, but mptcp_subflow_ctx() does a plain
forced dereference of it.  Since this helper can run without the socket
lock, this path should use rcu_dereference() or rcu_dereference_check()
when loading the subflow context.

ctx->conn is also checked and then read again:

	if (ctx && ctx->conn)
		return mptcp_sk(ctx->conn);

For a lockless access, it should be loaded once, for example with
READ_ONCE(). However, READ_ONCE(ctx->conn) would only avoid the double
load / NULL case. It would not provide a lifetime guarantee for the
returned parent mptcp_sock.

During teardown, subflow_ulp_release() drops the subflow-owned reference
to the parent mptcp socket with sock_put(sk), and ctx->conn is not
cleared.  I am not sure under what conditions the subflow context could
still be observable by BPF after that point, since this is called from
the subflow socket destruction path.  It would be helpful to clarify
whether such a window can actually be reached, and if so, what protects
the returned parent mptcp_sock.  If the window is real, clearing
ctx->conn before sock_put() and ensuring the parent mptcp_sock is
RCU-safe (or not returning it without an extra reference) might be
needed.

So the added NULL checks look like a useful improvement for the immediate
NULL-deref cases, but I am not sure they fully cover the lockless access
and lifetime aspects of this helper.  It would be good to clarify the
expected lifetime guarantee for the returned parent mptcp_sock, or extend
the fix so that this helper cannot return a parent socket whose
subflow-owned reference may already have been dropped.

Thanks,
Li Xiasong


