Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C506179A0
	for <mptcp@lists.linux.dev>; Tue, 12 Sep 2023 15:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CE1C433C7;
	Tue, 12 Sep 2023 15:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694533928;
	bh=zL2eor7umb+6AK/A05ehZ6ZM7aqXEI+ls2UmbZn/6Uo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=R03QFJPTCFuVzO2ejEyGXGmwv+ytDRvAORmWJWWK1SQvE2f2i5VD4ek99/kYGHuPu
	 0Fz0jrxiuDZXrs8HMUD7UAoB3e/Ze8L/ivOdYqTuqexIAB2eF3OenpBJiYPGI9AuUI
	 o1hgE5qkAt30m9DYb/+OoO71tB5l74pIsSuFQmTJRQ/56ck3Bf+BLSwsItTHMx57nY
	 97Q/aVh3gBOk+20dlbDXclfnfPOfIbDDmTTRMhb5iH0w3GNNuPe+33All2W/Bdpt7g
	 TX2hXIq2z3j+gJy06ybWmJF5/Bt+crHi/g9WpAVNj4wh/Q7AgwPzQfsjjtl4TsNkmS
	 Vunr4NoKzGvmg==
Date: Tue, 12 Sep 2023 08:52:02 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3] mptcp: add a new sysctl for make after
 break timeout
In-Reply-To: <fe8c2c5502b7a924bdcba6621486e1e68861f9fd.1694426964.git.pabeni@redhat.com>
Message-ID: <c527c2f7-0f84-8cf3-799c-a18eef254f8c@kernel.org>
References: <fe8c2c5502b7a924bdcba6621486e1e68861f9fd.1694426964.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 11 Sep 2023, Paolo Abeni wrote:

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
> v2 -> v3:
> - fix doc intentation (Matttbe)
> - use mptcp_close_timeout() in __mptcp_close_ssk, too (Mat)

Hi Paolo -

Thanks, v3 LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>


>
> v1 -> v2:
> - add the doc for the new knob (Matttbe)
> - fix a couple of bad/strange indentation (Matttbe)
> ---
> Documentation/networking/mptcp-sysctl.rst | 11 +++++++++++
> net/mptcp/ctrl.c                          | 16 ++++++++++++++++
> net/mptcp/protocol.c                      |  6 +++---
> net/mptcp/protocol.h                      |  1 +
> 4 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
> index 15f1919d640c..69975ce25a02 100644
> --- a/Documentation/networking/mptcp-sysctl.rst
> +++ b/Documentation/networking/mptcp-sysctl.rst
> @@ -25,6 +25,17 @@ add_addr_timeout - INTEGER (seconds)
>
> 	Default: 120
>
> +close_timeout - INTEGER (seconds)
> +	Set the make-after-break timeout: in absence of any close or
> +	shutdown syscall, MPTCP sockets will maintain the status
> +	unchanged for such time, after the last subflow removal, before
> +	moving to TCP_CLOSE.
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
> index e72b518c5d02..13fe0748dde8 100644
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
> 	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
> 				     ARRAY_SIZE(mptcp_sysctl_table));
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3facdc006adc..1a0b463f8c97 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2377,8 +2377,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 	if (msk->in_accept_queue && msk->first == ssk &&
> 	    (sock_flag(sk, SOCK_DEAD) || sock_flag(ssk, SOCK_DEAD))) {
> 		/* ensure later check in mptcp_worker() will dispose the msk */
> -		mptcp_set_close_tout(sk, tcp_jiffies32 - (TCP_TIMEWAIT_LEN + 1));
> 		sock_set_flag(sk, SOCK_DEAD);
> +		mptcp_set_close_tout(sk, tcp_jiffies32 - (mptcp_close_timeout(sk) + 1));
> 		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
> 		mptcp_subflow_drop_ctx(ssk);
> 		goto out_release;
> @@ -2506,7 +2506,7 @@ static bool mptcp_close_tout_expired(const struct sock *sk)
> 		return false;
>
> 	return time_after32(tcp_jiffies32,
> -		  inet_csk(sk)->icsk_mtup.probe_timestamp + TCP_TIMEWAIT_LEN);
> +		  inet_csk(sk)->icsk_mtup.probe_timestamp + mptcp_close_timeout(sk));
> }
>
> static void mptcp_check_fastclose(struct mptcp_sock *msk)
> @@ -2649,7 +2649,7 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
> 		return;
>
> 	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
> -			TCP_TIMEWAIT_LEN;
> +			mptcp_close_timeout(sk);
>
> 	/* the close timeout takes precedence on the fail one, and here at least one of
> 	 * them is active
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index aebc0cc24dad..0147419065dc 100644
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
