Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACF82F80
	for <mptcp@lists.linux.dev>; Tue, 27 Apr 2021 23:07:49 +0000 (UTC)
IronPort-SDR: xgwyWe2UTHWum5XqiyXxlw7aEeYVrRe2kn1KYjwiaiVKtwLaUOMGwoyqhE7cVFmPoPkm4yCq11
 y3a+hVFdHCGA==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="176092730"
X-IronPort-AV: E=Sophos;i="5.82,256,1613462400"; 
   d="scan'208";a="176092730"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 16:07:48 -0700
IronPort-SDR: K+haY/J+LwaJ6EpSQfMUVUr9pi1Vy3v7zkRg6eFZDHePnQqjZNvDg7EX+TE+XTsYSgrAypUzEB
 wr1WolsvyOQg==
X-IronPort-AV: E=Sophos;i="5.82,256,1613462400"; 
   d="scan'208";a="423256474"
Received: from wlhines-mobl.amr.corp.intel.com ([10.209.43.196])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 16:07:47 -0700
Date: Tue, 27 Apr 2021 16:07:46 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next 1/5] mptcp: add a new sysctl
 join_denied
In-Reply-To: <b1aefbc214bea1e5cef3dcf3c1c0b5caf502734e.1619517696.git.geliangtang@gmail.com>
Message-ID: <10c76c7e-453b-76d0-5b49-15f532e03f24@linux.intel.com>
References: <cover.1619517696.git.geliangtang@gmail.com> <b1aefbc214bea1e5cef3dcf3c1c0b5caf502734e.1619517696.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Tue, 27 Apr 2021, Geliang Tang wrote:

> This patch added a new sysctl, named join_denied, to control
> whether the joins can be denied.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> Documentation/networking/mptcp-sysctl.rst |  8 ++++++++
> net/mptcp/ctrl.c                          | 14 ++++++++++++++
> net/mptcp/protocol.h                      |  1 +
> 3 files changed, 23 insertions(+)
>
> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
> index 6af0196c4297..dbf4df3e6950 100644
> --- a/Documentation/networking/mptcp-sysctl.rst
> +++ b/Documentation/networking/mptcp-sysctl.rst
> @@ -24,3 +24,11 @@ add_addr_timeout - INTEGER (seconds)
> 	sysctl.
>
> 	Default: 120
> +
> +join_denied - INTEGER
> +	Control whether the joins can be denied.
> +
> +	The joins can be denied if the value is nonzero. This is a
> +	per-namespace sysctl.
> +
> +	Default: 0

It should be clear that this setting only affects incoming join requests 
for the local IP address and port used with the initial subflow. Maybe:

allow_join_initial_addr_port - INTEGER

Allow peers to send join requests to the IP address and port number used 
by the initial subflow if the value is nonzero. This controls a flag that 
is sent to the peer at connection time, and whether such join requests are 
accepted or denied.

Joins to addresses advertised with ADD_ADDR are not affected by this 
value.

This is a per-namespace sysctl.

Default: 1


My preference is to have the sysctl _enable_ these join requests, to 
reduce confusion from double-negatives. Open to discussion on that, of 
course.


> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 96ba616f59bf..4613bf42397d 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -19,6 +19,7 @@ struct mptcp_pernet {
>
> 	int mptcp_enabled;
> 	unsigned int add_addr_timeout;
> +	int join_denied;
> };
>
> static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
> @@ -36,6 +37,11 @@ unsigned int mptcp_get_add_addr_timeout(struct net *net)
> 	return mptcp_get_pernet(net)->add_addr_timeout;
> }
>
> +int mptcp_is_join_denied(struct net *net)
> +{
> +	return mptcp_get_pernet(net)->join_denied;
> +}
> +
> static struct ctl_table mptcp_sysctl_table[] = {
> 	{
> 		.procname = "enabled",
> @@ -52,6 +58,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
> 		.mode = 0644,
> 		.proc_handler = proc_dointvec_jiffies,
> 	},
> +	{
> +		.procname = "join_denied",
> +		.maxlen = sizeof(int),
> +		.mode = 0644,
> +		.proc_handler = proc_dointvec,
> +	},
> 	{}
> };
>
> @@ -59,6 +71,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
> {
> 	pernet->mptcp_enabled = 1;
> 	pernet->add_addr_timeout = TCP_RTO_MAX;
> +	pernet->join_denied = 0;
> }
>
> static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
> @@ -75,6 +88,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
>
> 	table[0].data = &pernet->mptcp_enabled;
> 	table[1].data = &pernet->add_addr_timeout;
> +	table[2].data = &pernet->join_denied;
>
> 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
> 	if (!hdr)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d230a75af631..a14c1ba85212 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -524,6 +524,7 @@ static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *su
>
> int mptcp_is_enabled(struct net *net);
> unsigned int mptcp_get_add_addr_timeout(struct net *net);
> +int mptcp_is_join_denied(struct net *net);
> void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
> 				     struct mptcp_options_received *mp_opt);
> bool mptcp_subflow_data_available(struct sock *sk);
> -- 
> 2.30.2
>
>
>

--
Mat Martineau
Intel
