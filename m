Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F9E5F
	for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 22:22:20 +0000 (UTC)
IronPort-SDR: CJaF+cCOAqFtVEFs1Y1jysqpHhkSxv+WSSR0x7emaeNURsfU1FrZre6hRDOPvm6J54MKRH95cH
 iEHkFCaGK21g==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="187043589"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="187043589"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 15:22:20 -0700
IronPort-SDR: 7vVobwix5KleXbtx48/1qGo1Z3b02jE/k9P5KWvhxrPSqlp8mrEiNrXA5sATnwvQ24b9wto/JB
 M4kxXL3XRVZg==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="607500483"
Received: from shahinam-mobl2.amr.corp.intel.com ([10.252.128.161])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 15:22:20 -0700
Date: Mon, 22 Mar 2021 15:22:19 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.01.org, mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next 1/6] mptcp: add a new sysctl
 checksum_enabled
In-Reply-To: <e56c579836e40e330bfd24a191fd0c313a9e4634.1616412490.git.geliangtang@gmail.com>
Message-ID: <a5f8a6d0-e4bf-e769-7649-43d1f324b2d6@linux.intel.com>
References: <cover.1616412490.git.geliangtang@gmail.com> <e56c579836e40e330bfd24a191fd0c313a9e4634.1616412490.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Mon, 22 Mar 2021, Geliang Tang wrote:

> This patch added a new sysctl, named checksum_enabled, to control
> whether DSS checksum can be enabled.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> Documentation/networking/mptcp-sysctl.rst |  8 ++++++++
> net/mptcp/ctrl.c                          | 14 ++++++++++++++
> net/mptcp/protocol.h                      |  1 +
> 3 files changed, 23 insertions(+)
>
> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
> index 6af0196c4297..1128e09d6c4d 100644
> --- a/Documentation/networking/mptcp-sysctl.rst
> +++ b/Documentation/networking/mptcp-sysctl.rst
> @@ -24,3 +24,11 @@ add_addr_timeout - INTEGER (seconds)
> 	sysctl.
>
> 	Default: 120
> +
> +checksum_enabled - INTEGER
> +	Control whether DSS checksum can be enabled.
> +
> +	DSS checksum can be enabled if the value is nonzero. This is a
> +	per-namespace sysctl.
> +
> +	Default: 1

In my opinion, this should default to 0 for compatibility with previous 
upstream kernel versions and because it sounds like checksums aren't used 
as much in practice. But I'm not totally committed to that - what do those 
of you with more MPTCP deployment experience think?

Mat


> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 96ba616f59bf..115cebc8c02a 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -19,6 +19,7 @@ struct mptcp_pernet {
>
> 	int mptcp_enabled;
> 	unsigned int add_addr_timeout;
> +	int checksum_enabled;
> };
>
> static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
> @@ -36,6 +37,11 @@ unsigned int mptcp_get_add_addr_timeout(struct net *net)
> 	return mptcp_get_pernet(net)->add_addr_timeout;
> }
>
> +int mptcp_is_checksum_enabled(struct net *net)
> +{
> +	return mptcp_get_pernet(net)->checksum_enabled;
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
> +		.procname = "checksum_enabled",
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
> +	pernet->checksum_enabled = 1;
> }
>
> static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
> @@ -75,6 +88,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
>
> 	table[0].data = &pernet->mptcp_enabled;
> 	table[1].data = &pernet->add_addr_timeout;
> +	table[2].data = &pernet->checksum_enabled;
>
> 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
> 	if (!hdr)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 14f0114be17a..fd36239d8905 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -519,6 +519,7 @@ static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *su
>
> int mptcp_is_enabled(struct net *net);
> unsigned int mptcp_get_add_addr_timeout(struct net *net);
> +int mptcp_is_checksum_enabled(struct net *net);
> void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
> 				     struct mptcp_options_received *mp_opt);
> bool mptcp_subflow_data_available(struct sock *sk);
> -- 
> 2.30.2

--
Mat Martineau
Intel
