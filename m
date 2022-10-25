Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398282F2F
	for <mptcp@lists.linux.dev>; Tue, 25 Oct 2022 22:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666736878; x=1698272878;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Za+EMEEJz12vXKyujeBnWhYKvVjWCPAjyRdgsqPAlHI=;
  b=P7xxnXrArvXpJl+ue2ilOhojDlHss1mlynIII1UnIza44oMl2FEXQi6c
   qW8pbqnI1IHfZIxn+TQ7id8EUDklGfY9rdw9L/EdWZCIJH+3XCW0xE1PQ
   2lnZ2zcM00TxQ8JBONvi3vKgIbVn3hleekCKg1TtRVfQ0OQh67WiAm6bj
   1vMpstgNEniuPeALbNpT7hOPbmAu1ud++1//4wh3iD7yoDNfU3bugU77r
   0jKwM9mKl+okR+Zu4Ix+wig3KnlpVV6Eq4VeLbruFIpNvWcGpuJuowESs
   +XIlVWgl++QO7Ao5IgQ32MEUkIf+pjxrkI7HCSMqRmxDTD/oFFMIeaARV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="369873098"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="369873098"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 15:27:57 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="737007827"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="737007827"
Received: from knnguyen-mobl1.amr.corp.intel.com ([10.209.107.240])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 15:27:57 -0700
Date: Tue, 25 Oct 2022 15:27:56 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3] mptcp: get sk from msk directly
In-Reply-To: <20221025032610.17496-1-geliang.tang@suse.com>
Message-ID: <ace99bdd-e8e6-a5a7-a76c-3d66076ebdc9@linux.intel.com>
References: <20221025032610.17496-1-geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 25 Oct 2022, Geliang Tang wrote:

> Use '(struct sock *)msk' to get 'sk' from 'msk' in a more direct way
> instead of using '&msk->sk.icsk_inet.sk'.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v3:
> - change protocol.c and sockopt.c too.
>
> v2:
> - fix the "uninitialized use occurs" error reported by kernel test robot
> <lkp@intel.com>

v3 looks good to me, thanks Geliang:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> net/mptcp/pm_userspace.c | 4 ++--
> net/mptcp/protocol.c     | 4 ++--
> net/mptcp/sockopt.c      | 4 ++--
> 3 files changed, 6 insertions(+), 6 deletions(-)
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
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ddeb8b36a677..dceeaaf3bab4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2440,7 +2440,7 @@ static bool mptcp_check_close_timeout(const struct sock *sk)
> static void mptcp_check_fastclose(struct mptcp_sock *msk)
> {
> 	struct mptcp_subflow_context *subflow, *tmp;
> -	struct sock *sk = &msk->sk.icsk_inet.sk;
> +	struct sock *sk = (struct sock *)msk;
>
> 	if (likely(!READ_ONCE(msk->rcv_fastclose)))
> 		return;
> @@ -2602,7 +2602,7 @@ static void mptcp_do_fastclose(struct sock *sk)
> static void mptcp_worker(struct work_struct *work)
> {
> 	struct mptcp_sock *msk = container_of(work, struct mptcp_sock, work);
> -	struct sock *sk = &msk->sk.icsk_inet.sk;
> +	struct sock *sk = (struct sock *)msk;
> 	unsigned long fail_tout;
> 	int state;
>
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index f85e9bbfe86f..f62f6483ef77 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -987,7 +987,7 @@ static int mptcp_getsockopt_tcpinfo(struct mptcp_sock *msk, char __user *optval,
> 				    int __user *optlen)
> {
> 	struct mptcp_subflow_context *subflow;
> -	struct sock *sk = &msk->sk.icsk_inet.sk;
> +	struct sock *sk = (struct sock *)msk;
> 	unsigned int sfcount = 0, copied = 0;
> 	struct mptcp_subflow_data sfd;
> 	char __user *infoptr;
> @@ -1078,8 +1078,8 @@ static void mptcp_get_sub_addrs(const struct sock *sk, struct mptcp_subflow_addr
> static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *optval,
> 					  int __user *optlen)
> {
> -	struct sock *sk = &msk->sk.icsk_inet.sk;
> 	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> 	unsigned int sfcount = 0, copied = 0;
> 	struct mptcp_subflow_data sfd;
> 	char __user *addrptr;
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
