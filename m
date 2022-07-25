Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F44A38
	for <mptcp@lists.linux.dev>; Mon, 25 Jul 2022 20:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658782372; x=1690318372;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9atPediR2v5ZzsP0UfVvwozP6XsnDD8apcII8A6aR5k=;
  b=jR+7xyK64EYmZXBvPL+7hCaajVvySDB2w3aDnSfagKqlwf3Ji0WBEVQF
   SdmqtZOR2O7P57FuOuCpMXWoGqpL+dF5xlvkPgETZ8vrEwItjIXKvj/RQ
   AcGNg+phstxik0QH3Gd/KiKNKJ+LcDWo+jZ3WE1I3Bvb84b3aFP/33oVF
   oxy9g7amLBqGn/fluvU5aQXid8eIbXgfJ3juNMV8Cgn9xk6qDs+PzajwM
   3yhveur9X3YoSiH/6seCXLhpZJ4cw0+bdCX3wXolb55SqoXJq6OVRbJqu
   F1TdRJ7YMAGKUODT72AIvnBIdG9cTCQEBtjnR0yDDt7ecutsoZnkEgFVW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="313548236"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="313548236"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 13:52:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="599741774"
Received: from jacobsd-mobl1.amr.corp.intel.com ([10.209.100.69])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 13:52:51 -0700
Date: Mon, 25 Jul 2022 13:52:50 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
cc: Paolo Abeni <pabeni@redhat.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-net] mptcp: Do not return EINPROGRESS when subflow
 creation succeeds
In-Reply-To: <20220715181207.522021-1-mathew.j.martineau@linux.intel.com>
Message-ID: <fd3161fb-c693-48ba-3972-f0fdfe9ef3@linux.intel.com>
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

Noting here for the lore.kernel.org records: Paolo acked this patch today 
on IRC (#mptcp / irc.libera.chat).

Given that ack, the simplicity of the change, and the timeline for this 
week's -net pull request, I'm sending this patch to netdev today.

Thanks,

Mat

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
