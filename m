Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6451D7B
	for <mptcp@lists.linux.dev>; Tue, 25 Oct 2022 00:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666657644; x=1698193644;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=waFq0kfS/W2yK9hJAuGroWFVx6x0czdv3sru/rmNXI8=;
  b=DGqmyZmJ2ZWi92k4OrO6AUsYz3cL2Q8NqtYs5/zkCWq+NOT17XSuOfQC
   tWESRNIVhF7jCQjcUN1HxfsYPySzb3fslJPPKup5q2za1ErTwmgecnm11
   g/x9mFhy/mDPzLDpFzIetjBy7OW461iE8fU7R08f0z6cygppMxHvs1Ihr
   /jUBwS1+EfR5kz+G+s86RZUT3wYxlxPLktOvkMdxOa+JESDsRJXYIxUT8
   HPsXaKxi8Jj71gENhi0OuTW3ZBPdeXJHsUg9+tGEa7bYayYPMN3AfIlsS
   dUyDymu0YZib3NVMMGA81wu91c07f+kTJQt/2vwj8lW8WDRsoNbeqp3IV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="294955120"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="294955120"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:27:24 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="664724733"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="664724733"
Received: from mlotfi-mobl.amr.corp.intel.com ([10.212.254.208])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:27:23 -0700
Date: Mon, 24 Oct 2022 17:27:22 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2] mptcp: get sk from msk directly
In-Reply-To: <20221023124831.8959-1-geliang.tang@suse.com>
Message-ID: <14d6e808-4ff2-ef6a-3262-d43a885e34c4@linux.intel.com>
References: <20221023124831.8959-1-geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

,On Sun, 23 Oct 2022, Geliang Tang wrote:

> Use '(struct sock *)msk' to get 'sk' from 'msk' in a more direct way
> instead of using '&msk->sk.icsk_inet.sk' in mptcp_nl_cmd_sf_create()
> and mptcp_nl_cmd_sf_destroy().
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Hi Geliang -

This is a good cleanup, thanks. We use the struct sock * cast almost 
everywhere. Can you extend this patch to also change the similar 
statements in sockopt.c and protocol.c?

(I think the assignment in mptcp_retransmit_timer() should stay unchanged)


- Mat



> ---
> v2:
> - fix the "uninitialized use occurs" error reported by kernel test robot
> <lkp@intel.com>
> ---
> net/mptcp/pm_userspace.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 9e82250cbb70..5cb65f0928f4 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -291,7 +291,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
> 		goto create_err;
> 	}
>
> -	sk = &msk->sk.icsk_inet.sk;
> +	sk = (struct sock *)msk;
> 	lock_sock(sk);
>
> 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
> @@ -403,7 +403,7 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
> 		goto destroy_err;
> 	}
>
> -	sk = &msk->sk.icsk_inet.sk;
> +	sk = (struct sock *)msk;
> 	lock_sock(sk);
> 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
> 	if (ssk) {
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
