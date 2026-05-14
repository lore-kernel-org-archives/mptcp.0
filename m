Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A223F3F4106
	for <mptcp@lists.linux.dev>; Thu, 14 May 2026 03:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778728103; cv=none; b=Z7xb0TuNJm+xS3R0V49dMCLvPJS8el2CR8IqkHa1kOZ70mlYCMkEtDMWTSlgXhz1PJv0RfYeY97Uz+Y5pdWwyjMcqEWBRfSpvAKDHQCvIGgCTm/VFhSYV7DCDTOf2Xc1wAwAzU4T9b68NKiUDb+PXA74ilDlin1+FTu6JiVijA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778728103; c=relaxed/simple;
	bh=9a/wlPXlUgog+YqEIKEgM5AXJ3lW3zKs6CAHJ5WYgMc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cXZM03lj67LFcY5pigO1UdE4AfIXwETa4vAwSwZBOBbYzQVwFnDWOxOd3o/fHwtcJEhf4U610k9WMkr7Xe+gpfWDGha6LxEx12bB1K+CR0bkhV9mQdShCbPH5i5Jveu0GmRPLyJAsqUQ+MAqezmE049KkYzYxFpf7Va8JG4CU1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXyflm0H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXyflm0H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5146CC19425;
	Thu, 14 May 2026 03:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778728103;
	bh=9a/wlPXlUgog+YqEIKEgM5AXJ3lW3zKs6CAHJ5WYgMc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cXyflm0Hy4z42ZWUye616/uBkuiP54FqggLnWMqQ3+EnIip1LJ23tQQN3XS23dwBA
	 IVZ3cMW4gFepy6RPNQObMEuAyAQ3OlCPifeUbJ2TtaXQc0cWP+2cX0PGDDGUtocTIj
	 I3kENJmPskChsvPioxpuj0EX9COpsoe4/YlieGf0Fp5wySYD+C33+BAMEFRHPFI20l
	 0Z4hdQ3xx4YgRZA6QOcmHQ2ShOOF0Gtuu2Uj/XtHEMdm1mfIf471u4wnZsNcwkPEPu
	 jowyp/VDNk8QmrvvA0ZkOUaSBkMtFTe75s3ttLCBU/ZtSWizxupmKfMTptfcp7bi0E
	 IiRRfrjn6FYRg==
Message-ID: <de6caab069a04d0c968a5f3a59c0c2753f4d9147.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/2] mptcp: pm: fix use-after-free in
 mptcp_userspace_pm_delete_local_addr
From: Geliang Tang <geliang@kernel.org>
To: Tao Cui <cuitao@kylinos.cn>, matttbe@kernel.org, martineau@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, mptcp@lists.linux.dev
Date: Thu, 14 May 2026 11:07:43 +0800
In-Reply-To: <20260509075629.217791-1-cuitao@kylinos.cn>
References: <20260509075629.217791-1-cuitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tao,

Thanks for this set. It looks like the cover letter of this set is
missing. You can use "--cover-letter" to create it:

	git format-patch -2 --cover-letter

sashiko adds some comments here, please address them in v2:

https://sashiko.dev/#/patchset/20260509075629.217791-2-cuitao@kylinos.cn

On Sat, 2026-05-09 at 15:56 +0800, Tao Cui wrote:
> mptcp_userspace_pm_delete_local_addr() calls list_del_rcu() followed
> immediately by sock_kfree_s(), which frees the entry synchronously
> without waiting for an RCU grace period.  A concurrent RCU read-side
> lookup (e.g. via mptcp_userspace_pm_get_local_id) could still be
> accessing the freed entry.
> 
> Fix it by replacing sock_kfree_s() with kfree_rcu_mightsleep() and
> adjusting sk_omem_alloc manually, matching the pattern already used
> in mptcp_pm_nl_remove_doit() in the same file.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  net/mptcp/pm_userspace.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 8cbc1920afb4..586e19e9b913 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -109,7 +109,11 @@ static int
> mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
>  	 * be used multiple times (e.g. fullmesh mode).
>  	 */
>  	list_del_rcu(&entry->list);
> -	sock_kfree_s(sk, entry, sizeof(*entry));
> +	kfree_rcu_mightsleep(entry);

mptcp_userspace_pm_delete_local_addr is invoked under the pm lock, so
using kfree_rcu_mightsleep is not a good idea.

Also, this mptcp_userspace_pm_delete_local_addr helper is removed in
the set [1] under review, so it's better to keep this sock_kfree_s
unchanged.

[1]
https://patchwork.kernel.org/project/mptcp/patch/e2c1bd781cdd4a7a0233305c0cc5cd12e36ec31c.1776466833.git.tanggeliang@kylinos.cn/

> +	/* Adjust sk_omem_alloc like sock_kfree_s() does, to match
> +	 * with allocation of this memory by sock_kmemdup()
> +	 */
> +	atomic_sub(sizeof(*entry), &sk->sk_omem_alloc);
>  	msk->pm.local_addr_used--;
>  	return 0;
>  }
