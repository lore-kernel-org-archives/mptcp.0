Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972A115A86D
	for <mptcp@lists.linux.dev>; Sat,  8 Aug 2026 04:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786164449; cv=none; b=hOMLUqgBnSVuNzHrFECcJJ6NZxppGmKvRmIZqsztwmcAqa3ItiQBB4fPmGaG7v4Rlb3YfmfYR8w+EtCe3a1amJJrVndWM4DNHABl+HZc05a7QC5AqTKCAccV0Y00rx4vwzdds0YB/ci3sDr8HcN/VEgcDhF/LeVqjLSyWHHhaYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786164449; c=relaxed/simple;
	bh=VFmCaXQccoEm3qgkdWTCPqQ426CqPxMs1TvLDzUoSDY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fOPOTewA2NtIhBlnxGJj9RDL67Sv0919vjrLKe6vqJcehJ4LafaxWwVTECAJyRSUotwGS+GajANK+BIIjegGeEU409vPpjlrjogzKbdMxH3/yfeVnwGX2sFqv9vX5iZBAGtxxjSh5HfCweXRIpkjaD0uptGFcY79daXAkxUvNIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czh4F8IR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czh4F8IR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631C01F000E9;
	Sat,  8 Aug 2026 04:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786164448;
	bh=RRYaYyBfPmY6xMU9qF5Gs18qUB5znI2fVKDjgWDROFI=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=czh4F8IRTOzjvglAhZooajPi0DsYulGC9DvNFdpihG1Vz5g1uLPaDmNAJELZ4Hmq2
	 m8ydrsezqsnvC9f/Nnk68ugP7Zy+fazmTVS9bjKwsunot58iDlToMnp0glYnH1Wo3d
	 DurUifTkFEHFVMoAIU5Js77DCuD4IwjcLRHS+WudM97NhEQtFRym4fbJjVNaK1oMKY
	 U6ptAf7GAbuYtlOhZNCq/BlNaCFSML3P7/JSwSS5IYKUfh5lxfpOlXeIvN28qaAA3F
	 mIhMAgqPuZKrOm5YvAw2JGwtFVDKV5jNgD9BRQ/Qe0NtlR8LCF88+lchaTVOpORGwg
	 3eur5Tt7jWxUw==
Message-ID: <5542732cf432dbe291a71a512d61a14c1b905fc1.camel@kernel.org>
Subject: Re: [PATCH next mptcp-next] mptcp: pm: userspace: make
 remove_addr_entry static
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Sat, 08 Aug 2026 12:47:24 +0800
In-Reply-To: <20260807-mptcp-pm-user-remove_addr_entry-v1-1-c080a8a30e40@kernel.org>
References: 
	<20260807-mptcp-pm-user-remove_addr_entry-v1-1-c080a8a30e40@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Fri, 2026-08-07 at 12:51 +0200, Matthieu Baerts (NGI0) wrote:
> Only used in pm_userspace.c.
> 
> While at it, use the mptcp_userspace_pm_ prefix, like most functions
> in
> this file: that makes it clear it is specific to this userspace PM.

Looks good!

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/pm_userspace.c | 7 ++++---
>  net/mptcp/protocol.h     | 2 --
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 8537fd75f73f..f723a134356f 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -291,8 +291,9 @@ static int
> mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
>  	return err;
>  }
>  
> -void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
> -				struct mptcp_pm_addr_entry *entry)
> +static void
> +mptcp_userspace_pm_remove_addr_entry(struct mptcp_sock *msk,
> +				     struct mptcp_pm_addr_entry
> *entry)
>  {
>  	struct mptcp_rm_list alist = { .nr = 0 };
>  	int anno_nr = 0;
> @@ -350,7 +351,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb,
> struct genl_info *info)
>  	list_del_rcu(&match->list);
>  	spin_unlock_bh(&msk->pm.lock);
>  
> -	mptcp_pm_remove_addr_entry(msk, match);
> +	mptcp_userspace_pm_remove_addr_entry(msk, match);
>  
>  	release_sock(sk);
>  
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 2f5b2f671c44..70200e75facf 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1149,8 +1149,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock
> *msk,
>  			   const struct mptcp_addr_info *addr,
>  			   bool echo);
>  int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct
> mptcp_rm_list *rm_list);
> -void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
> -				struct mptcp_pm_addr_entry *entry);
>  
>  /* the default path manager, used in mptcp_pm_unregister */
>  extern struct mptcp_pm_ops mptcp_pm_kernel;
> 
> ---
> base-commit: f393de6a43c333c11fbecdd76fa4fa3cc06aa834
> change-id: 20260807-mptcp-pm-user-remove_addr_entry-bcf1a456d0f8
> 
> Best regards,
> --  
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
