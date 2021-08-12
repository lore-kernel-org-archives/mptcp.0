Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D276D18
	for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 22:30:55 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="301048154"
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; 
   d="scan'208";a="301048154"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 15:30:54 -0700
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; 
   d="scan'208";a="571629321"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.20.135])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 15:30:54 -0700
Date: Thu, 12 Aug 2021 15:30:53 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: full fully established support after
 ADD_ADDR
In-Reply-To: <20210812162757.282366-1-matthieu.baerts@tessares.net>
Message-ID: <cb97b91e-99d-d7b-4338-a83ddba4e83b@linux.intel.com>
References: <20210812162757.282366-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 12 Aug 2021, Matthieu Baerts wrote:

> If directly after an MP_CAPABLE 3WHS, the client receives a valid
> ADD_ADDR from the server, it is enough to prove exchanged MPTCP options
> are valid. Indeed, the ADD_ADDR contains an HMAC generated using both
> the client and server keys.

The ADD_ADDR HMAC is validated after the call to 
check_fully_established(), so I'm not sure this condition is fully met 
with the patch as-is. Looks like an ADD_ADDR with a bad HMAC could change 
the fully_established flag when it shouldn't.

Mat

>
> It was then OK to enable the fully_established flag on the MPTCP socket.
>
> But that is not enough. On one hand, the path-manager has be notified
> the state has changed. On the other hand, the fully_established flag on
> the subflow socket should be turned on as well, not to re-send the
> MP_CAPABLE 3rd ACK content with the next ACK.
>
> Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>
> Notes:
>    Once applied, we can close issue 221. But this patch alone is not enough
>    to fix issue 221, hence no "Closes" tag.
>
>    Because the PM was not notified, I think it is best to send it to -net.
>    Before, I think we were overriding MPC ACK options when sending the echo
>    ADD_ADDR so the issue was not visible.
>
>    Here it is visible (and this is covered by out tests) since the
>    introduction of commit 32c3e4d50806 ("Squash-to: "mptcp: move
>    drop_other_suboptions check under pm lock"")
>
>    With this patch, the packetdrill tests are all OK!
>    (And the other selftests as well even if I still have other issues with
>     mptcp_join.sh but it doesn't seem related.)
>
> net/mptcp/options.c | 9 ++-------
> 1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index d94ff50c29b3..175563c95c0b 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -945,20 +945,15 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
> 		return subflow->mp_capable;
> 	}
>
> -	if (mp_opt->dss && mp_opt->use_ack) {
> +	if ((mp_opt->dss && mp_opt->use_ack) || mp_opt->add_addr) {
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
