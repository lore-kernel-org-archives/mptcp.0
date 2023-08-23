Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B449C139
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 16:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EE1C433CB;
	Wed, 23 Aug 2023 16:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692809343;
	bh=l88ZzlAQGwqs2o7R6UpDEbnJ9JteXVIpF/LAQKWXEyg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=dEe9VQ2vSEeZRzSPqVc+K9LHOSvrt7LBcF7LJMmuB6bYmM0tsPDqCN576XvGOrTDD
	 +HBSuNKRYmlB+Eetph7ExVc5G+mb+EFkGseZx9rezGK3ESCxOjqCyX9b4T26MfdHoU
	 pVEZtq+yacaagxQgzubiusNgaedUBsAUEGc07yPZWhw+o3WNQSi3cfjLdrCUUE5G75
	 p7JL0foaZiujKEKN3xs/+NWo3U6F0qWwcnaWwwsZFrQwBBcPIGvh2UMYLJ2/Tn3WBS
	 iy6Wm9v0/JjEyWvUijZMkv0L3dQ1XKs44Eo7H7xd7iShbWicR0b4+wmXSOlz5Tgbf0
	 IGYceIRvo+3EQ==
Date: Wed, 23 Aug 2023 09:49:02 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: fix bogus receive window shrinkage with
 multiple subflows
In-Reply-To: <0c7094b27ef199973d1fb3a8c5b29ebe0b48a659.1692778671.git.pabeni@redhat.com>
Message-ID: <b091725f-e0e4-98ac-8efc-61bd335d564f@kernel.org>
References: <0c7094b27ef199973d1fb3a8c5b29ebe0b48a659.1692778671.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 23 Aug 2023, Paolo Abeni wrote:

> In case multiple subflows race to update the mptcp-level receive
> window, the subflow losing the race should use the window value
> provided by the "winning" subflow to update it's own tcp-level
> rcv_wnd.
>
> To such goal, the current code bogusly uses the mptcp-level rcv_wnd
> value as observed before the update attempt. On unluckly circumstances
> that may lead to TCP-level window shrinkage, and stall the other end.
>
> Address the issue feeding to the rcv wnd update the correct value.
>
> Fixes: f3589be0c420 ("mptcp: never shrink offered window")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/options.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>

Good catch, thanks Paolo!

Reviewed-by: Mat Martineau <martineau@kernel.org>


> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index c254accb14de..cd15ec73073e 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1269,12 +1269,13 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
>
> 			if (rcv_wnd == rcv_wnd_old)
> 				break;
> -			if (before64(rcv_wnd_new, rcv_wnd)) {
> +
> +			rcv_wnd_old = rcv_wnd;
> +			if (before64(rcv_wnd_new, rcv_wnd_old)) {
> 				MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDCONFLICTUPDATE);
> 				goto raise_win;
> 			}
> 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDCONFLICT);
> -			rcv_wnd_old = rcv_wnd;
> 		}
> 		return;
> 	}
> -- 
> 2.41.0
>
>
>
