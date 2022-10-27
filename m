Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B209D520
	for <mptcp@lists.linux.dev>; Thu, 27 Oct 2022 19:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666900205; x=1698436205;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FTm3JAsxCSO3Hw7F+ykGJbCZlK7xV552xrrwTGiXB8Q=;
  b=gB5Y1XfHejdaXnsB3irH0vI05jvDScS54G4iPS98wLHDK7o+/KYis7sn
   OihipQCiNKSDQ2wbvhDiAIQbFT85SKnTpdRjnYtIfhMdbto/FKwKNMs15
   fK8uJmzmz+0s6fGubDKqW1jPi4Jb2O/twh3s35EMdD6Z4ZP+fvsWDMaK6
   NLpkJit6l3F7RsT7E4ekdmQlaWnEIQubzNibnYKx88qbEQo7V0Kp3PqMO
   DywTqcsrGy0EnyoDoIIaQ41QShqKfPKBlESDG7MbyLeWDqFsjSfMmjmsF
   dNCUZenRBs5bEkfLu4leXlBjGFtW2HVooABBzKG6uwE0NmFBgB2NMtU64
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="370392246"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="370392246"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 12:50:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="737825223"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="737825223"
Received: from wayzkhan-mobl.amr.corp.intel.com ([10.212.240.131])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 12:50:03 -0700
Date: Thu, 27 Oct 2022 12:50:03 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 1/2] mptcp: use entry->lsk directly
In-Reply-To: <6c8c57c5a419395f8f4a23aa8e3f76c830f0c12f.1666780919.git.geliang.tang@suse.com>
Message-ID: <673ea417-59a7-bc9f-9e09-d290417ceae9@linux.intel.com>
References: <cover.1666780919.git.geliang.tang@suse.com> <6c8c57c5a419395f8f4a23aa8e3f76c830f0c12f.1666780919.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 26 Oct 2022, Geliang Tang wrote:

> This patch drops msk and ssock in mptcp_pm_nl_create_listen_socket(),
> use entry->lsk directly instead of ssock.
>

Hi Geliang -

The change looks good, but the old code looks buggy. Seems like it would 
be trying to re-bind the nmpc socket each time a listener socket was 
created. Is this a fix for mptcp-net in your opinion?


Thanks,

Mat

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/pm_netlink.c | 18 ++----------------
> 1 file changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 9813ed0fde9b..52a5847b9d74 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -992,8 +992,6 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> {
> 	int addrlen = sizeof(struct sockaddr_in);
> 	struct sockaddr_storage addr;
> -	struct mptcp_sock *msk;
> -	struct socket *ssock;
> 	int backlog = 1024;
> 	int err;
>
> @@ -1002,30 +1000,18 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> 	if (err)
> 		return err;
>
> -	msk = mptcp_sk(entry->lsk->sk);
> -	if (!msk) {
> -		err = -EINVAL;
> -		goto out;
> -	}
> -
> -	ssock = __mptcp_nmpc_socket(msk);
> -	if (!ssock) {
> -		err = -EINVAL;
> -		goto out;
> -	}
> -
> 	mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> 	if (entry->addr.family == AF_INET6)
> 		addrlen = sizeof(struct sockaddr_in6);
> #endif
> -	err = kernel_bind(ssock, (struct sockaddr *)&addr, addrlen);
> +	err = kernel_bind(entry->lsk, (struct sockaddr *)&addr, addrlen);
> 	if (err) {
> 		pr_warn("kernel_bind error, err=%d", err);
> 		goto out;
> 	}
>
> -	err = kernel_listen(ssock, backlog);
> +	err = kernel_listen(entry->lsk, backlog);
> 	if (err) {
> 		pr_warn("kernel_listen error, err=%d", err);
> 		goto out;
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
