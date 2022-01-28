Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCCA2C9D
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 02:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643335749; x=1674871749;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fLQjTX9SadfmnM6BWrYoq78HYFeK+NOO1ZK2CyzGR94=;
  b=lrIthlrOpVl6Obydy7YYjIp89lhQ/1B4eUMeJkqTBO9VMC6PKlcuijsc
   UtC5a857sSDvnrPuK2dJ/yY/iR9+7EEoVQNwLq0saTbIvnHFhN4Iu/vhr
   25KKB1AMMEHrh3Ep0SefdfYyYtZpHUbfCM/fASR6dajbD6Ua9EGCInSYa
   4veVQ6Tbd+PJJTi4+daVu4ijBLFpqRCtBCYH7LhoqQOPe8uh+RJ7pXvjz
   yx0e7yzCkYd8iAvDWjROhXJCq+jWi/qOUXYOpD9flSzzbZhqc0Y2+tTRj
   v3tXjnoxgeI03mcgdZY22OOOXL55+bPxIJ2gNHhFOdDdfx8DVLHeXxuix
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227691897"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="227691897"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 18:09:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="478114484"
Received: from mmambros-mobl1.amr.corp.intel.com ([10.209.64.126])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 18:09:07 -0800
Date: Thu, 27 Jan 2022 18:09:07 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v3] mptcp: netlink: process IPv6 addrs in
 creating listening sockets
In-Reply-To: <20220128003746.2732527-1-kishen.maloor@intel.com>
Message-ID: <ba1702d-2951-132b-7fda-4ed1045dcd@linux.intel.com>
References: <20220128003746.2732527-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 27 Jan 2022, Kishen Maloor wrote:

> This change updates mptcp_pm_nl_create_listen_socket() to create
> listening sockets bound to IPv6 addresses (where IPv6 is supported).
>
> Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
> net/mptcp/pm_netlink.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>

Looks good for the export branch:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 5eac5bde5b49..93800f32fcb6 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -925,6 +925,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
> static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> 					    struct mptcp_pm_addr_entry *entry)
> {
> +	int addrlen = sizeof(struct sockaddr_in);
> 	struct sockaddr_storage addr;
> 	struct mptcp_sock *msk;
> 	struct socket *ssock;
> @@ -949,8 +950,11 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> 	}
>
> 	mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
> -	err = kernel_bind(ssock, (struct sockaddr *)&addr,
> -			  sizeof(struct sockaddr_in));
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	if (entry->addr.family == AF_INET6)
> +		addrlen = sizeof(struct sockaddr_in6);
> +#endif
> +	err = kernel_bind(ssock, (struct sockaddr *)&addr, addrlen);
> 	if (err) {
> 		pr_warn("kernel_bind error, err=%d", err);
> 		goto out;
>
> base-commit: 05854a699d27b11d8fb3217ec2e0dbf28ecb58e8
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
