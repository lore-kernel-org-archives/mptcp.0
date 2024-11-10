Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F3DC8FF
	for <mptcp@lists.linux.dev>; Sun, 10 Nov 2024 04:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731213615; cv=none; b=HkBbQcx4yu+6EepQarLfakiOuxHUQd9zLJGdjNleslFV8YuLQxAHBZ75efRkwwsihj/laqxZy4Ml4dT9EEAbStYY/NT3PBiuAq0hQy+05MRBdfBHDccxTv6slDUsnaKNqF2xOFG7y2pXxYhpwgMsSAobPHgqhn82BjthTnuGR/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731213615; c=relaxed/simple;
	bh=RKyrqq8mTLqh+jzBx3eWMxsgshkKnhjL4XMDWe43RY0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YnNGhFFcGmPfnw40ApOHDViR8zOcFDVMCqdEThlzvhKT/SaJaGj7f8CYUCR4HPfpHQGGSm7FV4Bq9/vE3ZTkjg2QyLVhdq1/iZ/zUi6+hmw23NEsFmgXcoFk7zikBG/H1CXGj9Y2jDXojv+t5WeAgPCFlhjfe++DvMkRLt1y8gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCcGS0mE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCcGS0mE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08E6C4CECD;
	Sun, 10 Nov 2024 04:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731213614;
	bh=RKyrqq8mTLqh+jzBx3eWMxsgshkKnhjL4XMDWe43RY0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BCcGS0mElWTUJAmTQdHxRpu7ZiQsm2NB6Q6tN1fpUFTGBIlCTbUhP2R1ywhbomrtf
	 uXDywgsal4QxP2ydUWfsezfQ9OWyF/wTN68+kJyTdOun0iBQ/im5o2270WcXzzzQqb
	 O108MLvPTOLg4AvtvLFPqCd8WVS65zUQrQq6tTHX/3TsUTjbatXoqrLJtzTOTsjbNO
	 DO8Q64yjTI6f6QpjpTe99Utj+Mmaus+l6LSGKrbqOmZD4k6Kz/ZD2J0pSZRI+c+eNS
	 4u109iG+QgjJTTBq8rTJKek2gfLW5RY7Ym8qe1tIlaQIoyBILNtFAGQEAmUnWlrwyZ
	 BBJ1LVMFF4t1A==
Message-ID: <9b0873e4155a9ab1be213164897729cb9d53da02.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 6/9] mptcp: use mptcp_pm_local in
 pm_netlink only
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Sun, 10 Nov 2024 12:40:11 +0800
In-Reply-To: <b101754b454313dadde8c89634982f9052e0cfc7.1730961810.git.tanggeliang@kylinos.cn>
References: <cover.1730961809.git.tanggeliang@kylinos.cn>
	 <b101754b454313dadde8c89634982f9052e0cfc7.1730961810.git.tanggeliang@kylinos.cn>
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

As I mentioned in [1], I decided to deprecate this patch and keep the
code for struct mptcp_pm_local as it is.

I changed this patch as "Rejected" in patchwork. Other patches in this
set are still valid.

Thanks,
-Geliang

[1]
https://patchwork.kernel.org/project/mptcp/patch/5b8a8e318c9d661f495b6d0be2b7a776de7da7a1.1729588019.git.tanggeliang@kylinos.cn/

On Thu, 2024-11-07 at 14:45 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> struct mptcp_pm_local is used in pm_netlink to reduce memory usage,
> but
> it has less effect in pm_userspace because userspace pm doesn't use
> an
> array of struct mptcp_pm_addr_entry type.
> 
> So this patch moves struct mptcp_pm_local to pm_netlink and restores
> the
> use of mptcp_pm_addr_entry type parameters in
> __mptcp_subflow_connect().
> In this case, only one "struct mptcp_pm_addr_entry" is needed, that's
> not
> reserving too much memory.
> 
> This patch makes the path manager code simpler, and easier to
> implement
> the BPF path manager.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm_netlink.c   | 26 ++++++++++++++++++++++----
>  net/mptcp/pm_userspace.c |  7 +------
>  net/mptcp/protocol.h     |  8 +-------
>  net/mptcp/subflow.c      |  2 +-
>  4 files changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 8aba7670345d..00911fae5d88 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -40,6 +40,12 @@ struct pm_nl_pernet {
>  	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
>  };
>  
> +struct mptcp_pm_local {
> +	struct mptcp_addr_info	addr;
> +	u8			flags;
> +	int			ifindex;
> +};
> +
>  #define MPTCP_PM_ADDR_MAX	8
>  #define ADD_ADDR_RETRANS_MAX	3
>  
> @@ -638,8 +644,14 @@ static void
> mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>  			continue;
>  
>  		spin_unlock_bh(&msk->pm.lock);
> -		for (i = 0; i < nr; i++)
> -			__mptcp_subflow_connect(sk, &local,
> &addrs[i]);
> +		for (i = 0; i < nr; i++) {
> +			struct mptcp_pm_addr_entry entry = { 0 };
> +
> +			entry.addr = local.addr;
> +			entry.flags = local.flags;
> +			entry.ifindex = local.ifindex;
> +			__mptcp_subflow_connect(sk, &entry,
> &addrs[i]);
> +		}
>  		spin_lock_bh(&msk->pm.lock);
>  	}
>  	mptcp_pm_nl_check_work_pending(msk);
> @@ -755,9 +767,15 @@ static void mptcp_pm_nl_add_addr_received(struct
> mptcp_sock *msk)
>  		return;
>  
>  	spin_unlock_bh(&msk->pm.lock);
> -	for (i = 0; i < nr; i++)
> -		if (__mptcp_subflow_connect(sk, &locals[i], &remote)
> == 0)
> +	for (i = 0; i < nr; i++) {
> +		struct mptcp_pm_addr_entry entry = { 0 };
> +
> +		entry.addr = locals[i].addr;
> +		entry.flags = locals[i].flags;
> +		entry.ifindex = locals[i].ifindex;
> +		if (__mptcp_subflow_connect(sk, &entry, &remote) ==
> 0)
>  			sf_created = true;
> +	}
>  	spin_lock_bh(&msk->pm.lock);
>  
>  	if (sf_created) {
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index a98da9a44bfa..db09350b5022 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -368,7 +368,6 @@ int mptcp_pm_nl_subflow_create_doit(struct
> sk_buff *skb, struct genl_info *info)
>  	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
>  	struct mptcp_pm_addr_entry entry = { 0 };
>  	struct mptcp_addr_info addr_r;
> -	struct mptcp_pm_local local;
>  	struct mptcp_sock *msk;
>  	int err = -EINVAL;
>  	struct sock *sk;
> @@ -415,12 +414,8 @@ int mptcp_pm_nl_subflow_create_doit(struct
> sk_buff *skb, struct genl_info *info)
>  		goto create_err;
>  	}
>  
> -	local.addr = entry.addr;
> -	local.flags = entry.flags;
> -	local.ifindex = entry.ifindex;
> -
>  	lock_sock(sk);
> -	err = __mptcp_subflow_connect(sk, &local, &addr_r);
> +	err = __mptcp_subflow_connect(sk, &entry, &addr_r);
>  	release_sock(sk);
>  
>  	spin_lock_bh(&msk->pm.lock);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 19a811220621..775ac2fd6854 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -236,12 +236,6 @@ struct mptcp_pm_data {
>  	struct mptcp_rm_list rm_list_rx;
>  };
>  
> -struct mptcp_pm_local {
> -	struct mptcp_addr_info	addr;
> -	u8			flags;
> -	int			ifindex;
> -};
> -
>  struct mptcp_pm_addr_entry {
>  	struct list_head	list;
>  	struct mptcp_addr_info	addr;
> @@ -736,7 +730,7 @@ bool mptcp_addresses_equal(const struct
> mptcp_addr_info *a,
>  void mptcp_local_address(const struct sock_common *skc, struct
> mptcp_addr_info *addr);
>  
>  /* called with sk socket lock held */
> -int __mptcp_subflow_connect(struct sock *sk, const struct
> mptcp_pm_local *local,
> +int __mptcp_subflow_connect(struct sock *sk, const struct
> mptcp_pm_addr_entry *local,
>  			    const struct mptcp_addr_info *remote);
>  int mptcp_subflow_create_socket(struct sock *sk, unsigned short
> family,
>  				struct socket **new_sock);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 07352b15f145..2ae8f467abc1 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1586,7 +1586,7 @@ void mptcp_info2sockaddr(const struct
> mptcp_addr_info *info,
>  #endif
>  }
>  
> -int __mptcp_subflow_connect(struct sock *sk, const struct
> mptcp_pm_local *local,
> +int __mptcp_subflow_connect(struct sock *sk, const struct
> mptcp_pm_addr_entry *local,
>  			    const struct mptcp_addr_info *remote)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);

