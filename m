Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9887492
	for <mptcp@lists.linux.dev>; Wed, 20 Jul 2022 23:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658360128; x=1689896128;
  h=date:from:to:subject:in-reply-to:message-id:references:
   mime-version;
  bh=T52RVJmv8umFwsl3qIA3POo23Ubhw1tP2UU9YK87vTk=;
  b=iMbnWVm2nG/qm+X06IkowqvvnatwbbChYoyD+4ftjLNtXjJ7o4K2EY1Z
   clbUAE9+5bNmD9JQcGHnPmLGBdPfEMDBkQNmoNeW5RaZCtxdEotsgCcqF
   i9mhzgt2G+BO/5GskWD1KqOSfMrhL9M50dSbWLbvTFk60Jk22DVuOJtkM
   vOA6kg/NIfCzE5yIgnFImUmvMDEyss6n+2aEsfgQ3CMcCz6eno2869XDY
   7Z7nTkHFF2+rZLSB5PbgIXhlZx1uyOe78Zv6+ZuV97NNj61CR3JD/Ie9T
   697RlIvIs+6zhZoVmRSIjQbh/XoxgH0DxiP3fBB2SO6BpvpCgdUkZguxB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="285672575"
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="285672575"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 16:35:28 -0700
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="687705011"
Received: from sherevia-mobl2.amr.corp.intel.com ([10.209.103.162])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 16:35:27 -0700
Date: Wed, 20 Jul 2022 16:35:27 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: Do not return EINPROGRESS when subflow
 creation succeeds
In-Reply-To: <20220715181207.522021-1-mathew.j.martineau@linux.intel.com>
Message-ID: <77555fae-dff8-14bd-8aa7-12cb57a4528a@linux.intel.com>
References: <20220715181207.522021-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 15 Jul 2022, Mat Martineau wrote:

> New subflows are created within the kernel using O_NONBLOCK, so
> EINPROGRESS is the expected return value from kernel_connect().
> __mptcp_subflow_connect() has the correct logic to consider EINPROGRESS
> to be a successful case, but it has also used that error code as its
> return value.
>
> Before v5.19 this was benign: all the callers ignored the return
> value. Starting in v5.19 there is a MPTCP_PM_CMD_SUBFLOW_CREATE generic
> netlink command that does use the return value, so the EINPROGRESS gets
> propagated to userspace.
>
> Make __mptcp_subflow_connect() always return 0 on success instead.
>
> Fixes: ec3edaa7ca6c ("mptcp: Add handling of outgoing MP_JOIN requests")
> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Paolo do you have a moment to look at this very short patch? Hoping to get 
it in to -net by early next week.

Thanks!

- Mat


> ---
> net/mptcp/subflow.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 63e8892ec807..af28f3b60389 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1533,7 +1533,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
> 	mptcp_sock_graft(ssk, sk->sk_socket);
> 	iput(SOCK_INODE(sf));
> 	WRITE_ONCE(msk->allow_infinite_fallback, false);
> -	return err;
> +	return 0;
>
> failed_unlink:
> 	list_del(&subflow->node);
> -- 
> 2.37.1
>
>

--
Mat Martineau
Intel
