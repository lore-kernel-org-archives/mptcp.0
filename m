Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21291A76BC
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736325820; cv=none; b=P1h50eu7MSahDRtMco/CW9iXN54yT9d0ERIVGJs37nmK+1rcaj/H6RWGub9zfqAwR4cfsPO/3HuPK/nZSbyQbeeFKLn2IXyBHwfnvgvyU0nzK9Ti7LPqRzckED2r6gvYYrxpFkp6yuBrPveD+Q18jYT4pK/S3wo+dA3LX4P7OjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736325820; c=relaxed/simple;
	bh=FfVUPLW1VtzXiBLa4SCGyK/NppljVo+ke5dC8hCj/gI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=md/dwgZtcfUZpqxgtCaEIv6JtK/AOTuKiRdooS7PQjTEl1oFFrXzojgiPDi+Jvy51oTLWY6Ci2YFoEt+trqcRmQGzry/ISTgU6scN75bKERbGpMqM4G1JzP9mYpKNwEhym93qSuxl3/iH0FiOnR1EIDYrBhgRN7smMNfBA3PK18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kd+ughSZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kd+ughSZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91548C4CEE1;
	Wed,  8 Jan 2025 08:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736325820;
	bh=FfVUPLW1VtzXiBLa4SCGyK/NppljVo+ke5dC8hCj/gI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=kd+ughSZj2wvC7S/RNa77BUttkYEtmS4JGboFgOXzbIgtiYezmDwvXIPpUBMJycel
	 j9yHRCe5dDNKvI7Uwons2LAgjc/TU4xxuQjd+Z3OMemazpGHj1rgEx53AOGiv9uC2i
	 OtemmvCHgrvzPHedsvcfaLPwGACC9INsPEWii9C8tKUX3dmxWzvQKi6I+/C5u/sGqr
	 LK1xBAs4gDSdveyLI/4SFmItnM1R5xa+Y9iptPQqhA9HAzwp9zY+5ZiF8jOGLtCDcP
	 ZuNHH0aMS2YpcaLlQdJyVsMqlD3DWW/1dWO31CppsS7rPxXRNdu120gqrmdh75wCH0
	 gDLiN4x8mb/vw==
Message-ID: <18a69eecc4c75fad71fafd1835dd997009a7bd9e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v4 3/5] bpf: Add mptcp_userspace_pm_addr
 bpf_iter
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 08 Jan 2025 16:43:37 +0800
In-Reply-To: <10551d58b505f20754a13302ce2340e220a3e7a5.1736325184.git.tanggeliang@kylinos.cn>
References: <cover.1736325184.git.tanggeliang@kylinos.cn>
	 <10551d58b505f20754a13302ce2340e220a3e7a5.1736325184.git.tanggeliang@kylinos.cn>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-01-08 at 16:38 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Just like the mptcp_subflow bpf_iter used to implement the MPTCP
> BPF packet scheduler, another bpf_iter is also needed, named
> mptcp_userspace_pm_addr, to traverse all address entries on
> userspace_pm_local_addr_list of an MPTCP socket for implementing
> the MPTCP BPF path manager.
> spin_is_locked
> In kernel space, we walk this list like this:
> 
> 	mptcp_for_each_userspace_pm_addr(msk, entry)
> 		kfunc(entry);
> 
> With the mptcp_userspace_pm_addr bpf_iter, bpf_for_each() can be
> used to do the same thing in BPF program:
> 
> 	bpf_for_each(mptcp_userspace_pm_addr, entry, msk)
> 		kfunc(entry);
> 
> This bpf_iter should be invoked under holding the msk pm lock, so
> use lockdep_assert_held() to assert the lock is holding.

Please update the line as:

use spin_is_locked() to check whether the lock is holding.

Thanks,
-Geliang

> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/bpf.c | 52
> +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 923895322b2c..c7f5d208f6cc 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -220,6 +220,15 @@ struct bpf_iter_mptcp_subflow_kern {
>  	struct list_head *pos;
>  } __aligned(8);
>  
> +struct bpf_iter_mptcp_userspace_pm_addr {
> +	__u64 __opaque[2];
> +} __aligned(8);
> +
> +struct bpf_iter_mptcp_userspace_pm_addr_kern {
> +	struct mptcp_sock *msk;
> +	struct list_head *pos;
> +} __aligned(8);
> +
>  __bpf_kfunc_start_defs();
>  
>  __bpf_kfunc static struct mptcp_subflow_context *
> @@ -273,6 +282,46 @@ bpf_iter_mptcp_subflow_destroy(struct
> bpf_iter_mptcp_subflow *it)
>  {
>  }
>  
> +__bpf_kfunc static int
> +bpf_iter_mptcp_userspace_pm_addr_new(struct
> bpf_iter_mptcp_userspace_pm_addr *it,
> +				     struct mptcp_sock *msk)
> +{
> +	struct bpf_iter_mptcp_userspace_pm_addr_kern *kit = (void
> *)it;
> +
> +	BUILD_BUG_ON(sizeof(struct
> bpf_iter_mptcp_userspace_pm_addr_kern) >
> +		     sizeof(struct
> bpf_iter_mptcp_userspace_pm_addr));
> +	BUILD_BUG_ON(__alignof__(struct
> bpf_iter_mptcp_userspace_pm_addr_kern) !=
> +		     __alignof__(struct
> bpf_iter_mptcp_userspace_pm_addr));
> +
> +	kit->msk = msk;
> +	if (!msk)
> +		return -EINVAL;
> +
> +	if (!spin_is_locked(&msk->pm.lock))
> +		return -EINVAL;
> +
> +	kit->pos = &msk->pm.userspace_pm_local_addr_list;
> +	return 0;
> +}
> +
> +__bpf_kfunc static struct mptcp_pm_addr_entry *
> +bpf_iter_mptcp_userspace_pm_addr_next(struct
> bpf_iter_mptcp_userspace_pm_addr *it)
> +{
> +	struct bpf_iter_mptcp_userspace_pm_addr_kern *kit = (void
> *)it;
> +
> +	if (!kit->msk || list_is_last(kit->pos,
> +				      &kit->msk-
> >pm.userspace_pm_local_addr_list))
> +		return NULL;
> +
> +	kit->pos = kit->pos->next;
> +	return list_entry(kit->pos, struct mptcp_pm_addr_entry,
> list);
> +}
> +
> +__bpf_kfunc static void
> +bpf_iter_mptcp_userspace_pm_addr_destroy(struct
> bpf_iter_mptcp_userspace_pm_addr *it)
> +{
> +}
> +
>  __bpf_kfunc static struct
>  mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk)
>  {
> @@ -310,6 +359,9 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx,
> KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW |
> KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT |
> KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_iter_mptcp_userspace_pm_addr_new, KF_ITER_NEW
> | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_iter_mptcp_userspace_pm_addr_next,
> KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_mptcp_userspace_pm_addr_destroy,
> KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
>  BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)

