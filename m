Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3F82FB0
	for <mptcp@lists.linux.dev>; Tue, 17 Aug 2021 16:39:40 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="196402753"
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="196402753"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 09:39:39 -0700
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="676578372"
Received: from sreddy3-mobl.amr.corp.intel.com ([10.251.13.114])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 09:39:39 -0700
Date: Tue, 17 Aug 2021 09:39:38 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3] mptcp: full fully established support
 after ADD_ADDR
In-Reply-To: <20210817151838.3187999-1-matthieu.baerts@tessares.net>
Message-ID: <708f39c-6066-f93b-f151-f6ed8a2ba0cb@linux.intel.com>
References: <20210817151838.3187999-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 17 Aug 2021, Matthieu Baerts wrote:

> If directly after an MP_CAPABLE 3WHS, the client receives an ADD_ADDR
> with HMAC from the server, it is enough to switch to a "fully
> established" mode because it has received more MPTCP options.
>
> It was then OK to enable the "fully_established" flag on the MPTCP
> socket. Still, best to check if the ADD_ADDR looks valid by looking if
> it contains an HMAC (no 'echo' bit). If an ADD_ADDR echo is received
> while we are not in "fully established" mode, it is strange and then
> we should not switch to this mode now.
>
> But that is not enough. On one hand, the path-manager has be notified
> the state has changed. On the other hand, the "fully_established" flag
> on the subflow socket should be turned on as well not to re-send the
> MP_CAPABLE 3rd ACK content with the next ACK.
>
> Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>
> Notes:
>    - v2: reword the commit message not to mention "valid" content (Mat)
>    - v3: squash the two patches together and update the commit message (Mat)

Thanks for squashing! Still ok to tag:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


>
> net/mptcp/options.c | 10 +++-------
> 1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index d94ff50c29b3..bec3ed82e253 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -945,20 +945,16 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
> 		return subflow->mp_capable;
> 	}
>
> -	if (mp_opt->dss && mp_opt->use_ack) {
> +	if ((mp_opt->dss && mp_opt->use_ack) ||
> +	    (mp_opt->add_addr && !mp_opt->echo)) {
> 		/* subflows are fully established as soon as we get any
> -		 * additional ack.
> +		 * additional ack, including ADD_ADDR.
> 		 */
> 		subflow->fully_established = 1;
> 		WRITE_ONCE(msk->fully_established, true);
> 		goto fully_established;
> 	}
>
> -	if (mp_opt->add_addr) {
> -		WRITE_ONCE(msk->fully_established, true);
> -		return true;
> -	}
> -
> 	/* If the first established packet does not contain MP_CAPABLE + data
> 	 * then fallback to TCP. Fallback scenarios requires a reset for
> 	 * MP_JOIN subflows.
> -- 
> 2.32.0
>
>
>

--
Mat Martineau
Intel
