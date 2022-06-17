Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032714C84
	for <mptcp@lists.linux.dev>; Fri, 17 Jun 2022 21:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655502846; x=1687038846;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yau7XiqXNkSSCdfmuVx6izZOsE9eTfMfwVYPQ3RQVYU=;
  b=BoIJl/MVPdRgLKdDgBWQTeCPEyYtHA8yspp8f9+juueN+7o+fsImHuqg
   o4rkbGKX8LUVz52gDl9eRcYJ/0u6GfEPZVDzku9HJB4k3OkrKmHlKhqWq
   +Nh+ingwdMegYMRV0HLPlyIPcLJOAYj4w1B3IrWNHYoJGLWWHEdhZtz7n
   XDSRM4+7gqiAicWd2uKSp7ISeZnqngXA6WeKwEO/pkUsX57TM72THCj0W
   dkmYJ/3cdTGevKX5SZI2/0DwwXUy40Xm/mOiZGSJExmNoRUSloXoaY6H5
   LkXBaddk26Iknevlvh5uMsgrvVfHstHJlB6afndnicT7t45h6T/3W6zS2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278366704"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278366704"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 14:54:05 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="536966831"
Received: from theiders-mobl.amr.corp.intel.com ([10.209.81.3])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 14:54:05 -0700
Date: Fri, 17 Jun 2022 14:54:04 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/2] mptcp: never fetch fwd memory from the
 subflow
In-Reply-To: <8a8f923a2d66057e4025892a4e83fc81fc7461f6.1655385956.git.pabeni@redhat.com>
Message-ID: <b24bcaf9-1312-5173-8693-11c077bf6785@linux.intel.com>
References: <8a8f923a2d66057e4025892a4e83fc81fc7461f6.1655385956.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 16 Jun 2022, Paolo Abeni wrote:

> The memory accounting is broken in such exceptional code
> path, and after commit 4890b686f408 ("net: keep sk->sk_forward_alloc
> as small as possible") we can't find much help there.
>
> Drop the broken code.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> This is possibly for net, but makes sense only on top of recent
> net-next patches, so whatever ;)

Let's go with net-next.

> ---
> net/mptcp/protocol.c | 11 +++--------
> 1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 35e3060233c9..390ac5d95664 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -328,15 +328,10 @@ static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
>
> 	amt = sk_mem_pages(size);
> 	amount = amt << PAGE_SHIFT;
> -	msk->rmem_fwd_alloc += amount;
> -	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV)) {
> -		if (ssk->sk_forward_alloc < amount) {
> -			msk->rmem_fwd_alloc -= amount;
> -			return false;
> -		}
> +	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV))
> +		return false;

Like Eric did in 7c80b038d23e, does it makes sense to try to raise the 
allocation only by the amount of incremental memory requested (size - 
msk->rmem_forward_alloc) rather than the full amount from the 'size' arg?

>
> -		ssk->sk_forward_alloc -= amount;
> -	}
> +	msk->rmem_fwd_alloc += amount;
> 	return true;
> }

--
Mat Martineau
Intel
