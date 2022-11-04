Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D717DAD56
	for <mptcp@lists.linux.dev>; Fri,  4 Nov 2022 22:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667600845; x=1699136845;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AYIk6KpQCjMTnl9RgDUccX97AdAtIX63Jdcyq8hfCoQ=;
  b=A+1yFntVsy6UJIbRIfrrDZzu62u8SfRBgpyTwbRoWvPqMiprLQ6p0saE
   Mk3N+SxJ4rrz0cJYA6flAhLWpqpfWq1h/B6vqEfZR7RY5mnMRMY+bWqgV
   pQGrIh33QrH7LLEEOjQF3iWxHcBEzvRrljo3KOeJn1geX5L4e626W89tS
   g3/Mia+dqXYC5ATH5cL5khgO1kmeNSZq4zR+5S1r3oF6yFn62+MHjyDpo
   Lt0r8sFo2aVxmDZySh4NTaKEYR681UaHPu/7jKJvR1Axi33HlBGSzr/0p
   fKy4rVLxMWkvjT0Zz12k4Tej8H2dbdyL1vS337FhVptCKRh1iFOzMvYHt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="308797197"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="308797197"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:27:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="666526341"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="666526341"
Received: from mvedaei-mobl2.amr.corp.intel.com ([10.212.176.106])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:27:22 -0700
Date: Fri, 4 Nov 2022 15:27:21 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/2] mptcp: deduplicate error paths on endpoint
 creation
In-Reply-To: <13fc62c6a047dbd043be5131567c0f3a6c46267e.1667586266.git.pabeni@redhat.com>
Message-ID: <65f6ecce-13df-6c2e-9533-4ab5d3e56e9b@linux.intel.com>
References: <13fc62c6a047dbd043be5131567c0f3a6c46267e.1667586266.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 4 Nov 2022, Paolo Abeni wrote:

> When endpoint creation fails, we need to free the newly allocated
> entry and eventually destroy the paired mptcp listener socket.
>
> Consolidate such action in a single point let all the errors path
> reach it.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thanks for the cleanup Paolo:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> net/mptcp/pm_netlink.c | 35 +++++++++++++----------------------
> 1 file changed, 13 insertions(+), 22 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 9813ed0fde9b..fdf2ee29f762 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1003,16 +1003,12 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> 		return err;
>
> 	msk = mptcp_sk(entry->lsk->sk);
> -	if (!msk) {
> -		err = -EINVAL;
> -		goto out;
> -	}
> +	if (!msk)
> +		return -EINVAL;
>
> 	ssock = __mptcp_nmpc_socket(msk);
> -	if (!ssock) {
> -		err = -EINVAL;
> -		goto out;
> -	}
> +	if (!ssock)
> +		return -EINVAL;
>
> 	mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> @@ -1022,20 +1018,16 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> 	err = kernel_bind(ssock, (struct sockaddr *)&addr, addrlen);
> 	if (err) {
> 		pr_warn("kernel_bind error, err=%d", err);
> -		goto out;
> +		return err;
> 	}
>
> 	err = kernel_listen(ssock, backlog);
> 	if (err) {
> 		pr_warn("kernel_listen error, err=%d", err);
> -		goto out;
> +		return err;
> 	}
>
> 	return 0;
> -
> -out:
> -	sock_release(entry->lsk);
> -	return err;
> }
>
> int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
> @@ -1327,7 +1319,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
> 		return -EINVAL;
> 	}
>
> -	entry = kmalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
> 	if (!entry) {
> 		GENL_SET_ERR_MSG(info, "can't allocate addr");
> 		return -ENOMEM;
> @@ -1338,22 +1330,21 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
> 		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
> 		if (ret) {
> 			GENL_SET_ERR_MSG(info, "create listen socket error");
> -			kfree(entry);
> -			return ret;
> +			goto out_free;
> 		}
> 	}
> 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
> 	if (ret < 0) {
> 		GENL_SET_ERR_MSG(info, "too many addresses or duplicate one");
> -		if (entry->lsk)
> -			sock_release(entry->lsk);
> -		kfree(entry);
> -		return ret;
> +		goto out_free;
> 	}
>
> 	mptcp_nl_add_subflow_or_signal_addr(sock_net(skb->sk));
> -
> 	return 0;
> +
> +out_free:
> +	__mptcp_pm_release_addr_entry(entry);
> +	return ret;
> }
>
> int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
> -- 
> 2.38.1
>
>
>

--
Mat Martineau
Intel
