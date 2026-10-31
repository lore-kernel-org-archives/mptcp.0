Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793446229;
	b=AOgO6RBjmtb2kBSM440Ki2Nu/IMEoJJ0PwoWwXjvy0SNhxH8aurQ2mRUaP1p1Oux9OK6
	 VV3Id6vqw4WrZ3jyRH8LoblMvHCKjX8kHIlKMcKOtHl516N+RizJWA2dw0LVQ4RD+5V0f
	 CFcUnwgafbJQ88xJa3rGVtltoFWCnSgwMOTfqg+tYtFQZiZKWC+9ULyDjzzUp2NtAC4Ac
	 3afDCMWxaONv8+Y1AoC8992iBdDa9vjH23ohxRc8FKz5Jn3JmFnZhC4Z/hWfppNWBmhEJ
	 a+muV70YiA2luLlzlLjt97YKL5ysA/9F9UMLBGcn+yWl3tf9Yf0/K25C6gPCg9k7FGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793446229;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zROdvEZZHE2V0uz6KiPzw1+EaM3aePBftOpG6rkasv0=;
	b=NkqOOm2iBJKDQPuYDSeszkIvUMVON+siX8IbOvCyzxflU2JS1NkGRemwr8UzypnD+zt4
	 Nmmb0UY9cxmO3nfebbUaOunK3IVkuShCqG93new1Ib0ytO6crPdMEqLZQn/Fj1mg6US5d
	 7nJ1YbjifSZB6cFvOgMSRKlePzlD4y2vbMTGyfp7eZsfEbgjpzBVX942PeCZR/LGBA7p+
	 sY8nSf/9d/1sLVbMK8iSH0NxgcRa/gFDjJNiQ/AlwXUevNpl9TYIZXPOXuKxCy4+Znurl
	 +n2cPo5ktimZHCo8fAhEO9p0fBv0BySoCblO3faiezPJc5GI+DBYcQ1RC1HPsar2WBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K5jhsfbZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3342B606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K5jhsfbZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A739A1F0093A;
	Sat, 31 Oct 2026 11:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793446228;
	bh=zROdvEZZHE2V0uz6KiPzw1+EaM3aePBftOpG6rkasv0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K5jhsfbZwbKVzMvkEk9rjokfDEIv4GtzWGaBLiMPfuHSB4r8S/y88ubHMe8bLItE3
	 sUROmhXMUc/tyRaKTIfczATppDdyjZR5ODjhvUM3lohUlSvnBqyc/cAMH+gyqPAtA/
	 JSAqkUO3i1e3H90qPpEp5PdjQ/Rx6XuTt/cVaay5xKVPYfhxZTWCy3CXEyzCn/QPI2
	 uZc1vUT/DsbrB0KmJs1H0r/uadJJv9QWDlZKwdhOLn6UQHBxylIlR+SvQwIww22vCL
	 8yjW7hc35dCEPOHWGjvs+nL7rD3R0Yy0nSZL0N2DOPi9j0Lcrw0XCuhpPud9HIQ87e
	 Z1SjJNYw6go4A==
Subject: Re: [PATCH mptcp-net v4 3/8] mptcp: pm: userspace: ID0 is not part of
 local_addr_used
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 31 Oct 2026 11:30:28 +0000
Message-ID: <179344622821.3128.15562504925652529284@kernel.org>
In-Reply-To:
 <20261029-mptcp-pm-userspace-id0-case-v4-3-555066fa4292@kernel.org>
References:
 <20261029-mptcp-pm-userspace-id0-case-v4-3-555066fa4292@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Automatic local-ID allocation always fails while the initial
  ID0 entry is in the list.
- [Medium] If __mptcp_subflow_connect() fails,
  mptcp_pm_nl_subflow_create_doit() calls…

Pre-existing issues:
- [Medium] mptcp_pm_nl_remove_doit() (non-zero ID path; after "mptcp: pm:
  userspace: no ID0 exception for RM_ADDR", all IDs) unlinks the entry…

--

mptcp: pm: userspace: ID0 is not part of local_addr_used

This commit stops the userspace PM's local_addr_used counter from
counting the initial ID0 entry, matching the in-kernel PM. A new
is_init_id0() helper skips the counter update both when a local address
entry is appended and when it is deleted.

> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 68a02b15a4c53..74969b86fb812 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c

[ ... ]

> @@ -99,7 +104,9 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>
>  		e->addr.id = id;
>  		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
> -		msk->pm.local_addr_used++;
> +		/* Just to avoid this counter not to decrease when deleted */
> +		if (!is_init_id0(e))
> +			msk->pm.local_addr_used++;

[Severity: Medium]
This isn't a bug introduced by this patch, but is this increment ever
balanced when the address is removed with MPTCP_PM_CMD_REMOVE?

mptcp_pm_nl_remove_doit() unlinks and frees the entry and never touches
local_addr_used:

net/mptcp/pm_userspace.c:mptcp_pm_nl_remove_doit() {
    ...
	list_del_rcu(&match->list);
	spin_unlock_bh(&msk->pm.lock);

	mptcp_userspace_pm_remove_addr_entry(msk, match);

	release_sock(sk);

	kfree_rcu_mightsleep(match);
    ...
}

After an ANNOUNCE with id X and then a REMOVE with id X, would the counter
stay one too high for the rest of the connection? Once the entry is gone,
a later SUBFLOW_DESTROY can't balance it either. With "mptcp: pm:
userspace: no ID0 exception for RM_ADDR" later in the series, every ID
goes through this same path.

mptcp_diag_fill_info() in net/mptcp/sockopt.c reports the stale value to
userspace as mptcpi_local_addr_used.

>  		ret = e->addr.id;
>  	} else if (addr_match && id_match) {
>  		ret = entry->addr.id;

[Severity: Medium]
mptcp_pm_userspace_created() now adds the ID0 entry to
userspace_pm_local_addr_list for every userspace PM connection. Can the
automatic ID allocation in this function still succeed with that entry in
the list?

When the lookup misses, mptcp_pm_userspace_get_local_id() calls this
function with needs_id = true and skc->addr.id = 0. In the loop:

	mptcp_for_each_userspace_pm_addr(msk, e) {
		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
		if (addr_match && entry->addr.id == 0 && needs_id)
			entry->addr.id = e->addr.id;
		id_match = (e->addr.id == entry->addr.id);
		if (addr_match || id_match)
			break;
		__set_bit(e->addr.id, id_bitmap);
	}

When e is the ID0 entry, addr_match is false but id_match is true
(0 == 0), so the loop breaks. Neither branch below runs. The function
returns -EINVAL and never reaches find_next_zero_bit().

Would subflow_token_join_request() then reject every incoming MP_JOIN to
a local address that is neither the initial address nor already in the
list, with MPTCP_MIB_MPJOINNOIDFOUND, even when non-zero IDs are free?
subflow_chk_local_id() looks like it could hit the same failure.

Before this series the list started empty, so this only happened if the
daemon had explicitly created an id 0 entry. Nothing later in the series
appears to change mptcp_userspace_pm_append_new_local_addr() or
mptcp_pm_userspace_get_local_id().

> @@ -125,12 +132,15 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
>  	if (!entry)
>  		return -EINVAL;
>
> +	/* The initial address ID doesn't increment local_addr_used */
> +	if (!is_init_id0(entry))
> +		msk->pm.local_addr_used--;
> +
>  	/* TODO: a refcount is needed because the entry can
>  	 * be used multiple times (e.g. fullmesh mode).
>  	 */
>  	list_del_rcu(&entry->list);
>  	sock_kfree_s(sk, entry, sizeof(*entry));

[Severity: Medium]
This skips the counter decrement for the ID0 entry. Can the ID0 entry
itself still be freed here while the initial subflow is alive?

mptcp_pm_nl_subflow_create_doit() calls this function on any connect
failure:

	err = __mptcp_subflow_connect(sk, &local, &addr_r);
	release_sock(sk);

	if (err) {
		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);

		spin_lock_bh(&msk->pm.lock);
		mptcp_userspace_pm_delete_local_addr(msk, &entry);
		spin_unlock_bh(&msk->pm.lock);
	}

Take a SUBFLOW_CREATE from the initial local address with port 0 and id 0
(or no local id). mptcp_userspace_pm_append_new_local_addr() matches the
ID0 entry from mptcp_pm_userspace_created() and takes the
addr_match && id_match branch, so it allocates nothing.

If __mptcp_subflow_connect() then fails synchronously, the ID0 entry is
unlinked and freed: mptcp_userspace_pm_lookup_addr() returns it. Such
failures include -ENOTCONN from the "sent the request too early" check, a
bind error, or a connect error.

At the end of the series, mptcp_pm_nl_remove_doit() for id 0 depends on
mptcp_userspace_pm_lookup_addr_by_id(). Would RM_ADDR for ID0 then fail
with "address with id 0 not found"?

The ID0 reservation would also be lost, so another address could take
id 0. Backup flags set on the initial address would no longer be stored.

Before this series, the same error path already freed announced entries
that it had only matched. The ID0 case comes from earlier patches in this
series.

Should this path only delete the entry when the append call actually
allocated it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292%40kernel.org
