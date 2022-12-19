Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE3410EF
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 20:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671482931; x=1703018931;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DGQDRUgrSwtvV+jdEtEqE1ophZ5C/2tMRIX8ibAaOQs=;
  b=feAN/+/rJOzCD2Yj5kvCF5vVzOV0943jdXgEsB5MmUERM6BzxUOB35Gn
   D01xCLTRjIxu29sE/QDLWkdYbxbPZ8LoTA4AYr7uH3AwQ+tAIDhXC88pi
   x4R4NqW/g6ao7/zd4AtBCdYntiXcHzBdcGukl6t94L1J/HL8RSSk8rr69
   7lpuPOdbANXvPquX7+1XIIBSF8HKtpgDriNy7wXJl3xJtneYTQZ5aZQLt
   pqOtrCPTZk3gcBRy/41/OO0txHiEUZZNebAlzaG72FaUXjS9m72A1pI5i
   EuZ8edO5AK8PSsliHZNqtM1HLTSMRmrQBTTKQeF3cznzbuHJqbE8FbdJC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="383790953"
X-IronPort-AV: E=Sophos;i="5.96,257,1665471600"; 
   d="scan'208";a="383790953"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 12:48:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="757777936"
X-IronPort-AV: E=Sophos;i="5.96,257,1665471600"; 
   d="scan'208";a="757777936"
Received: from wootaekl-mobl1.amr.corp.intel.com ([10.212.220.86])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 12:48:50 -0800
Date: Mon, 19 Dec 2022 12:48:49 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
    selinux@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH v2 1/2] security, lsm: Introduce
 security_mptcp_add_subflow()
In-Reply-To: <a902fa8f38238fca00094e067cbd147c472d108c.1671469167.git.pabeni@redhat.com>
Message-ID: <37412e5c-334f-91e3-807e-0c348791bebc@linux.intel.com>
References: <cover.1671469167.git.pabeni@redhat.com> <a902fa8f38238fca00094e067cbd147c472d108c.1671469167.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 19 Dec 2022, Paolo Abeni wrote:

> MPTCP can create subflows in kernel context, and later indirectly
> expose them to user-space, via the owning mptcp socket.
>
> As discussed in the reported link, the above causes unexpected failures
> for server, MPTCP-enabled applications.
>
> Let's introduce a new LSM hook to allow the security module to relabel
> the subflow according to the owing process.
>
> Note that the new hook requires both the mptcp socket and the new
> subflow. This could allow future extensions, e.g. explicitly validating
> the mptcp <-> subflow linkage.
>
> Link: https://lore.kernel.org/mptcp/CAHC9VhTNh-YwiyTds=P1e3rixEDqbRTFj22bpya=+qJqfcaMfg@mail.gmail.com/
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
> - fix build issue with !CONFIG_SECURITY_NETWORK
> ---
> include/linux/lsm_hook_defs.h | 1 +
> include/linux/lsm_hooks.h     | 9 +++++++++
> include/linux/security.h      | 6 ++++++
> net/mptcp/subflow.c           | 6 ++++++
> security/security.c           | 5 +++++
> 5 files changed, 27 insertions(+)
>

Hi Paolo -

Thanks for the patches, the MPTCP content looks good to me:

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index bd387d4b5a38..43b90784d914 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1680,6 +1680,10 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
>
> 	lock_sock(sf->sk);
>
> +	err = security_mptcp_add_subflow(sk, sf->sk);
> +	if (err)
> +		goto release_ssk;
> +
> 	/* the newly created socket has to be in the same cgroup as its parent */
> 	mptcp_attach_cgroup(sk, sf->sk);
>
> @@ -1692,6 +1696,8 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
> 	get_net_track(net, &sf->sk->ns_tracker, GFP_KERNEL);
> 	sock_inuse_add(net, 1);
> 	err = tcp_set_ulp(sf->sk, "mptcp");
> +
> +release_ssk:
> 	release_sock(sf->sk);
>
> 	if (err) {

--
Mat Martineau
Intel
