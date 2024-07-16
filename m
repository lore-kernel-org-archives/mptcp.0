Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C60187F
	for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 05:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721108917; cv=none; b=H2VC52kEFcR4YbxrwsTdsi9PftRDTRRfRwHUELo748bDKU4bH8Qsc6xfkJtxKcfubK+/lH6vQauh4XN78WIbhkEfyABaqFGAUEU0aknqxzAZujjH74YmiUphbJl11Hej1iZx40VEknyQqOrPZXOd2eetQdAB3D/wLhQ3tZVnTSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721108917; c=relaxed/simple;
	bh=ngg59AvLLo+ZHNmP8D6RRtpUqJ08NCi2VKpkinU2tys=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fTrsYALZwBZrd5n+U68bPnY1UpyVtvuOZTzSbYXdBm89PYCQNEPkcY8wUDjVnuIBy6s/5I9HI8BBWzjbWZtcA5mQyHfD1THg1bPYwfs2iD2a37w2wrVxzT4DvvCb6XHoxjnSPeNivDjWeAj0xbGmBI8/frXIg5BJNODOy3GVhPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7WpLtml; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7WpLtml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45CBC116B1;
	Tue, 16 Jul 2024 05:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721108916;
	bh=ngg59AvLLo+ZHNmP8D6RRtpUqJ08NCi2VKpkinU2tys=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=C7WpLtmlz81GcI61GgQa1JtpQYsg93Uus3UnJWeC1GoOIIsjiQcGq3kWoZLlBpYdQ
	 8NvxlEcgKjCYZlSb+OYKUP5NFswivqkUdpcFC8yhswPTVaNDfYBd24Qp52ruZODvX1
	 BdE1+koEAFvIEdKU4GKDTMDjpmjYT4+GJgkJKAsa698GT/NmlqF1qNHxwLcR3MBUx9
	 zeY7EV2TUq3+Wpb3cTvHZu3m3xM8eXQ1mONkWkrfvT7rSe97OgWKwN9CeGihTKF065
	 G9xEIkGUOTAg2Q3jpIWQQhS7d66c6b7dqRCnGFeGMJCuqkG/kb9fusSOmDsQowEgp4
	 i90+1oSTOQVnw==
Date: Mon, 15 Jul 2024 22:48:36 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 4/6] mptcp: pm: fix backup support in signal
 endpoints
In-Reply-To: <20240711-mptcp-backup-mpj-v1-4-d45506182a9e@kernel.org>
Message-ID: <3b39df84-53c6-3d78-ccb1-6737955d29bf@kernel.org>
References: <20240711-mptcp-backup-mpj-v1-0-d45506182a9e@kernel.org> <20240711-mptcp-backup-mpj-v1-4-d45506182a9e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 11 Jul 2024, Matthieu Baerts (NGI0) wrote:

> There was a support for signal endpoints, but only when the endpoint's
> flag was changed during a connection. If an endpoint with the signal and
> backup was already present, the MP_JOIN reply was not containing the
> backup flag as expected.
>
> That's confusing to have this inconsistent behaviour. On the other hand,
> the infrastructure to set the backup flag in the SYN + ACK + MP_JOIN was
> already there, it was just never set before. Now when requesting the
> local ID from the path-manager, the backup status is also requested.
>
> Note that when the userspace PM is used, the backup flag can be set if
> the local address was already used before with a backup flag, e.g. if
> the address was announced with the 'backup' flag, or a subflow was
> created with the 'backup' flag.
>
> The MPTCP Join selftest has been modified to validate this case: the
> test "single address, backup", is now validating the MPJ with a backup
> flag. The previous version has been kept, but renamed to "single
> address, switch to backup" to avoid confusions. The test "single address
> with port, backup" is also now validating the MPJ with a backup flag,
> which makes more sense.
>
> Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/507
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/pm.c                                  |  9 ++++++---
> net/mptcp/pm_netlink.c                          |  4 +++-
> net/mptcp/pm_userspace.c                        |  6 ++++--
> net/mptcp/protocol.h                            |  9 ++++++---
> net/mptcp/subflow.c                             |  7 +++++--
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 19 ++++++++++++++++---
> 6 files changed, 40 insertions(+), 14 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 55406720c607..98b0b31e3b8d 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -405,7 +405,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
> 	return ret;
> }
>
> -int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
> +int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc,
> +			  bool *backup)
> {
> 	struct mptcp_addr_info skc_local;
> 	struct mptcp_addr_info msk_local;
> @@ -413,6 +414,8 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
> 	if (WARN_ON_ONCE(!msk))
> 		return -1;
>
> +	*backup = false;

This will modify *backup on some error paths (but not the one that 
returned -1 above). While the code that calls this function will ignore 
that variable if this function returns an error anyway, I think it's worth 
it to only set *backup on success within this function, just before the 
'return 0'.

> +
> 	/* The 0 ID mapping is defined by the first subflow, copied into the msk
> 	 * addr
> 	 */
> @@ -422,8 +425,8 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
> 		return 0;
>
> 	if (mptcp_pm_is_userspace(msk))
> -		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
> -	return mptcp_pm_nl_get_local_id(msk, &skc_local);
> +		return mptcp_userspace_pm_get_local_id(msk, &skc_local, backup);
> +	return mptcp_pm_nl_get_local_id(msk, &skc_local, backup);
> }
>
> int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 7635fac91539..44bfab351693 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1064,7 +1064,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> 	return err;
> }
>
> -int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
> +int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc,
> +			     bool *backup)
> {
> 	struct mptcp_pm_addr_entry *entry;
> 	struct pm_nl_pernet *pernet;
> @@ -1076,6 +1077,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
> 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
> 		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
> 			ret = entry->addr.id;
> +			*backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> 			break;
> 		}
> 	}
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index f0a4590506c6..adc015af168e 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -137,7 +137,7 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
> }
>
> int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
> -				    struct mptcp_addr_info *skc)
> +				    struct mptcp_addr_info *skc, bool *backup)
> {
> 	struct mptcp_pm_addr_entry *entry = NULL, *e, new_entry;
> 	__be16 msk_sport =  ((struct inet_sock *)
> @@ -151,8 +151,10 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
> 		}
> 	}
> 	spin_unlock_bh(&msk->pm.lock);
> -	if (entry)
> +	if (entry) {
> +		*backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> 		return entry->addr.id;
> +	}
>

*backup is left unchanged on the !entry code path, which could leave it 
uninitialized.

- Mat

> 	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
> 	new_entry.addr = *skc;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 6b6b76152db5..cee0a8098b41 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1111,9 +1111,12 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
> 			      bool *drop_other_suboptions);
> bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
> 			     struct mptcp_rm_list *rm_list);
> -int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
> -int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
> -int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
> +int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc,
> +			  bool *backup);
> +int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc,
> +			     bool *backup);
> +int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc,
> +				    bool *backup);
> int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb);
> int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
> 			  struct netlink_callback *cb);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index a3778aee4e77..955fb9aa2ce5 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -87,6 +87,7 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
> 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
> 	struct mptcp_sock *msk;
> 	int local_id;
> +	bool backup;
>
> 	msk = mptcp_token_get_sock(sock_net(req_to_sk(req)), subflow_req->token);
> 	if (!msk) {
> @@ -94,12 +95,13 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
> 		return NULL;
> 	}
>
> -	local_id = mptcp_pm_get_local_id(msk, (struct sock_common *)req);
> +	local_id = mptcp_pm_get_local_id(msk, (struct sock_common *)req, &backup);
> 	if (local_id < 0) {
> 		sock_put((struct sock *)msk);
> 		return NULL;
> 	}
> 	subflow_req->local_id = local_id;
> +	subflow_req->request_bkup = backup;
>
> 	return msk;
> }
> @@ -604,12 +606,13 @@ static int subflow_chk_local_id(struct sock *sk)
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> +	bool backup;
> 	int err;
>
> 	if (likely(subflow->local_id >= 0))
> 		return 0;
>
> -	err = mptcp_pm_get_local_id(msk, (struct sock_common *)sk);
> +	err = mptcp_pm_get_local_id(msk, (struct sock_common *)sk, &backup);
> 	if (err < 0)
> 		return err;
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 55d84a1bde15..167914df05fa 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2617,6 +2617,19 @@ backup_tests()
>
> 	# single address, backup
> 	if reset "single address, backup" &&
> +	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
> +		pm_nl_set_limits $ns2 1 1
> +		sflags=nobackup speed=slow \
> +			run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr 1 1 1
> +		chk_add_nr 1 1
> +		chk_prio_nr 1 0
> +	fi
> +
> +	# single address, switch to backup
> +	if reset "single address, switch to backup" &&
> 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
> 		pm_nl_set_limits $ns1 0 1
> 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> @@ -2632,13 +2645,13 @@ backup_tests()
> 	if reset "single address with port, backup" &&
> 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
> 		pm_nl_set_limits $ns1 0 1
> -		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup port 10100
> 		pm_nl_set_limits $ns2 1 1
> -		sflags=backup speed=slow \
> +		sflags=nobackup speed=slow \
> 			run_tests $ns1 $ns2 10.0.1.1
> 		chk_join_nr 1 1 1
> 		chk_add_nr 1 1
> -		chk_prio_nr 1 1
> +		chk_prio_nr 1 0
> 	fi
>
> 	if reset "mpc backup" &&
>
> -- 
> 2.45.2
>
>
>
