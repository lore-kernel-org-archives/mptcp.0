Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C680DF72
	for <mptcp@lists.linux.dev>; Tue,  5 Sep 2023 21:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D08C433C9;
	Tue,  5 Sep 2023 21:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693950215;
	bh=y6yALPGpEvG7wU5Khxy7hXj/PWpx5/BglwYARbcwzv4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=VqB5GisU9YYlaFNgpfGML5LmY8YXJTvpMDOyM4Mnx5+S/6y2XrqBHPQ2CTcefaks9
	 wBxRLxCkLq6L4M2/kgwT/w4kHdaXvA+Cv0zV5ESGRg98fkEiL4nVPxoaytyNWrjrjz
	 f7xvhI7whzoGI76l4MVgwZbyD0YY6ZvKQ6DXOmEYMb+QiVV+jYMsb+WJw6J666C4yn
	 aX+ds1CVjvmUBH1vrtLXaiajeO+Lb1U4bMprb0yTJwKczYB33k00iNEXp2yBI4m0oi
	 WPos8XelGc7CbdE3X6M0uiu831Lwv/XtWWhhD9EH5uZfbxDasSJcsCCiPLN7N0e6Cu
	 Tggb5GKxfiQhg==
Date: Tue, 5 Sep 2023 14:43:31 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2] mptcp: add a new sysctl for make after
 break timeout
In-Reply-To: <dfadc0c4a9bf4649c01e09d675f4de59eb409f5d.1693841118.git.pabeni@redhat.com>
Message-ID: <6598f7cf-3d75-3d99-2458-6c0bc8f08a51@kernel.org>
References: <dfadc0c4a9bf4649c01e09d675f4de59eb409f5d.1693841118.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 4 Sep 2023, Paolo Abeni wrote:

> The MPTCP protocol allows sockets with no alive subflows to stay
> in ESTABLISHED status for and user-defined timeout, to allow for
> later subflows creation.
>
> Currently such timeout is constant - TCP_TIMEWAIT_LEN. Let the
> user-space configure them via a newly added sysctl, to better cope
> with busy servers and simplify (make them faster) the relevant
> pktdrill tests.
>
> Note that the new know does not apply to orphaned MPTCP socket
> waiting for the data_fin handshake completion: they always wait
> TCP_TIMEWAIT_LEN.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
> - add the doc for the new knob (Matttbe)
> - fix a couple of bad/strange indentation (Matttbe)
> ---
> Documentation/networking/mptcp-sysctl.rst | 11 +++++++++++
> net/mptcp/ctrl.c                          | 16 ++++++++++++++++
> net/mptcp/protocol.c                      |  5 +++--
> net/mptcp/protocol.h                      |  1 +
> 4 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
> index 15f1919d640c..f569129ea881 100644
> --- a/Documentation/networking/mptcp-sysctl.rst
> +++ b/Documentation/networking/mptcp-sysctl.rst
> @@ -25,6 +25,17 @@ add_addr_timeout - INTEGER (seconds)
>
> 	Default: 120
>
> +close_timeout - INTEGER (seconds)
> +	Set the make-after-break timeout: in absence of any close or
> +        shutdown syscall, MPTCP sockets will maintain the status
> +        unchanged for such time, after the last subflow removal, before
> +        moving to TCP_CLOSE.
> +
> +	The default value matches TCP_TIMEWAIT_LEN. This is a per-namespace
> +	sysctl.
> +
> +	Default: 60
> +
> checksum_enabled - BOOLEAN
> 	Control whether DSS checksum can be enabled.
>
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index c46c22a84d23..36e389326073 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -27,6 +27,7 @@ struct mptcp_pernet {
> #endif
>
> 	unsigned int add_addr_timeout;
> +	unsigned int close_timeout;
> 	unsigned int stale_loss_cnt;
> 	u8 mptcp_enabled;
> 	u8 checksum_enabled;
> @@ -65,6 +66,13 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net)
> 	return mptcp_get_pernet(net)->stale_loss_cnt;
> }
>
> +unsigned int mptcp_close_timeout(const struct sock *sk)
> +{
> +	if (sock_flag(sk, SOCK_DEAD))
> +		return TCP_TIMEWAIT_LEN;
> +	return mptcp_get_pernet(sock_net(sk))->close_timeout;
> +}
> +
> int mptcp_get_pm_type(const struct net *net)
> {
> 	return mptcp_get_pernet(net)->pm_type;
> @@ -79,6 +87,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
> {
> 	pernet->mptcp_enabled = 1;
> 	pernet->add_addr_timeout = TCP_RTO_MAX;
> +	pernet->close_timeout = TCP_TIMEWAIT_LEN;
> 	pernet->checksum_enabled = 0;
> 	pernet->allow_join_initial_addr_port = 1;
> 	pernet->stale_loss_cnt = 4;
> @@ -141,6 +150,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
> 		.mode = 0644,
> 		.proc_handler = proc_dostring,
> 	},
> +	{
> +		.procname = "close_timeout",
> +		.maxlen = sizeof(unsigned int),
> +		.mode = 0644,
> +		.proc_handler = proc_dointvec_jiffies,
> +	},
> 	{}
> };
>
> @@ -163,6 +178,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
> 	table[4].data = &pernet->stale_loss_cnt;
> 	table[5].data = &pernet->pm_type;
> 	table[6].data = &pernet->scheduler;
> +	table[7].data = &pernet->close_timeout;
>
> 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
> 	if (!hdr)
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 80d06cab8bc7..735ff5cda940 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2501,7 +2501,7 @@ static bool mptcp_close_tout_expired(const struct sock *sk)
> 		return false;
>
> 	return time_after32(tcp_jiffies32,
> -		  inet_csk(sk)->icsk_mtup.probe_timestamp + TCP_TIMEWAIT_LEN);
> +		  inet_csk(sk)->icsk_mtup.probe_timestamp + mptcp_close_timeout(sk));

There's some logic to also fix up in __mptcp_close_ssk()'s SOCK_DEAD code 
path, one lingering instance of TCP_TIMEWAIT_LEN there to switch to 
mptcp_close_timeout().

- Mat

> }
>
> static void mptcp_check_fastclose(struct mptcp_sock *msk)
> @@ -2643,7 +2643,8 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
> 	if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
> 		return;
>
> -	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies + TCP_TIMEWAIT_LEN;
> +	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
> +			mptcp_close_timeout(sk);
>
> 	/* the close timeout takes precedence on the fail one, and here at least one of
> 	 * them is active
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 392c2f247034..1cade49205bd 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -624,6 +624,7 @@ unsigned int mptcp_get_add_addr_timeout(const struct net *net);
> int mptcp_is_checksum_enabled(const struct net *net);
> int mptcp_allow_join_id0(const struct net *net);
> unsigned int mptcp_stale_loss_cnt(const struct net *net);
> +unsigned int mptcp_close_timeout(const struct sock *sk);
> int mptcp_get_pm_type(const struct net *net);
> const char *mptcp_get_scheduler(const struct net *net);
> void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
> -- 
> 2.41.0
>
>
>
