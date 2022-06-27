Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977BA3229
	for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 22:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656369973; x=1687905973;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Bdruj3FjVaAqM7NxSrdujzwrrumTKjAZMcu571q3/hU=;
  b=SyIZzmMeiQBCAXUe4lgtxE974wCMGKCYvAJUKE8nTkTGVVNRhdbdxttX
   f//GUxP2nOa7BIGAi9TN7w+gr6gXdEkUFxXDPwXGxxrajShV6TSUU822W
   FGXkSwA/A8mnUDh8X3HnZStwKSESPD3SClQ8Hy45ym00aI6IrSd/6FANi
   FlslrHRZFnmbeIlcFlnifRF3dlebeNx8owjIBYpPMUehlVGcTgMfBfsBy
   LisZ/oS0St9bLafyoWb63O5c0UPXw+phFBKVTTnr1LX5vvHB7qgL7TH6F
   eu1TMrHD7RWUtie1FZXjEgaojfXVRKUHlxiJCTwCqtnWy8hAbcaPCbNbU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="279124684"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="279124684"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 15:46:12 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="766946024"
Received: from pwoolfor-mobl.amr.corp.intel.com ([10.209.18.80])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 15:46:12 -0700
Date: Mon, 27 Jun 2022 15:46:12 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH mptcp-net] mptcp: fix locking in
 mptcp_nl_cmd_sf_destroy()
In-Reply-To: <886e059dc9096dcc9e1daa1eb1a07ec34d72aa74.1656323519.git.pabeni@redhat.com>
Message-ID: <d8ed8625-2761-b74-793f-268f14a04727@linux.intel.com>
References: <886e059dc9096dcc9e1daa1eb1a07ec34d72aa74.1656323519.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 27 Jun 2022, Paolo Abeni wrote:

> The user-space PM subflow removal path uses a couple of helpers
> that must be called under the msk socket lock and the current
> code lacks such requirement.
>
> Change the existing lock scope so that the relevant code is under
> its protection.
>
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> It should close issues/287, let's see what the CI says

Thanks for tracking this down, Paolo. Patch looks good, tests are passing 
for me.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> net/mptcp/pm_userspace.c | 19 ++++++-------------
> 1 file changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 3d1d365e9c6f..33be79f0e9c2 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -307,15 +307,11 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
> 				      const struct mptcp_addr_info *local,
> 				      const struct mptcp_addr_info *remote)
> {
> -	struct sock *sk = &msk->sk.icsk_inet.sk;
> 	struct mptcp_subflow_context *subflow;
> -	struct sock *found = NULL;
>
> 	if (local->family != remote->family)
> 		return NULL;
>
> -	lock_sock(sk);
> -
> 	mptcp_for_each_subflow(msk, subflow) {
> 		const struct inet_sock *issk;
> 		struct sock *ssk;
> @@ -348,16 +344,11 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
> 		}
>
> 		if (issk->inet_sport == local->port &&
> -		    issk->inet_dport == remote->port) {
> -			found = ssk;
> -			goto found;
> -		}
> +		    issk->inet_dport == remote->port)
> +			return ssk;
> 	}
>
> -found:
> -	release_sock(sk);
> -
> -	return found;
> +	return NULL;
> }
>
> int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
> @@ -413,6 +404,7 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
> 	}
>
> 	sk = &msk->sk.icsk_inet.sk;
> +	lock_sock(sk);
> 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
> 	if (ssk) {
> 		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> @@ -424,8 +416,9 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
> 	} else {
> 		err = -ESRCH;
> 	}
> +	release_sock(sk);
>
> - destroy_err:
> +destroy_err:
> 	sock_put((struct sock *)msk);
> 	return err;
> }
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
