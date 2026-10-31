Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793446230;
	b=CtSFyiaMqYMrnLaq45fCH5/SdgY/ceX9NRBT30B7ZVn1MW6ANrgS8G8h9k6FBsl3YFXn
	 9vj+2xwG7UxqZyoP1nuUnpju0VRP+2MwlyfxLP7FFHH/NRkuufRAVfQn2FLj9qAIyABhr
	 y91WYMqiDH9EUdCsUbOZekDs8TDDvU8knkVEplDraoJ3XCoEbjO1l5eq1SagbPetY9SPt
	 ZZDtVRgOwRdnUpm3vW+Xu3VhLdctOCWyjQIYqkH1cANIdcxdWPp1sZMuvwPbkUetFyVE2
	 E7sQNfFuUTijZNy1ZLQm1mX97XMoKJYMywJr1kPMJzky0DTSyLKArRZGt3kbrr5A3kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793446230;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gZ8iy+R9iWm9apzFfEYBU+GCrTiCUQRYb54uqJCK9vI=;
	b=Ex1CTjNsdpw8AFOp8/4LT+oCQr+7HAGjCO2Nd0Q7/+b0iL9F5p0Lu+H2tauagDwoL9qp
	 SV5s3Dyaw/5LaYdxdDJlkZ0EO0nvR8FNNH6q3OS+j7BUlnMuQiyEAG0RRmlM4zlpEdQ0Z
	 TcoVD8le3NFyFpHpB6uDJ69vH8Z6+Mby49xmq7G1vVDDXB/PhdOYxe3hN5eFqs7VboxFQ
	 M11k6vNR2/gVztsoqkbEt3J+zU/SIbTMeSPbabjUnOqyyhPjcrduV3QwOnB12+1Q0oV/5
	 L9L4dxc3pdJNLqiT+nMdImnseufJG798PCijgg78Js/P8Ddeh7cPaRthdyDY6lKPqSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XoLeGS4p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4199606A31F
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XoLeGS4p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C06F1F000C1;
	Sat, 31 Oct 2026 11:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793446229;
	bh=gZ8iy+R9iWm9apzFfEYBU+GCrTiCUQRYb54uqJCK9vI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XoLeGS4ptU+8LQOIYBFDrAW8HFf567AsbcXf1hh3O8q4mXKg2Ja3iPYGDcWKmm1N2
	 R48B+SDbqjSd/EVZ0g+Xf9cRMPMcW8p5GWUsnN4d4gg3ZFAUIZJsoL6bS+AsFtoeQK
	 OfMXmn9qrxtDyAKDvQn7NLW0dhxftCARQZ4FGID5TAYGW9dGLidXtSdBt4bKMFNmGs
	 wQf9rIRQv6Ujx+O2ogvB+18EkRzTb2/qA2Ny8wLi77RHO3wCorokI3A7JxVFd5YLs7
	 HMbV2R5vUGFsie9o+/deoU6vy6HPcEmjhRXlsOkm3QpU2S3y5Kc/OR2lY/+PHkMSGE
	 fqk/sRhRV43MA==
Subject:
 Re: [PATCH mptcp-net v4 4/8] mptcp: pm: userspace: allow announcing ID0 addr
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 31 Oct 2026 11:30:29 +0000
Message-ID: <179344622902.3128.7343113608839302009@kernel.org>
In-Reply-To:
 <20261029-mptcp-pm-userspace-id0-case-v4-4-555066fa4292@kernel.org>
References:
 <20261029-mptcp-pm-userspace-id0-case-v4-4-555066fa4292@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says an ANNOUNCE with ID 0 and a non-
  matching address 'will be returned' an error by…
- [Medium] On the active side, mptcp_connect() calls
  mptcp_token_new_connect() (protocol.c), which adds the msk to the…
- [Low] At this commit, MPTCP_PM_CMD_ANNOUNCE with ID 0 for the initial
  address succeeds.

--

mptcp: pm: userspace: allow announcing ID0 addr

This commit removes the explicit rejection of address ID 0 in
mptcp_pm_nl_announce_doit(), so a userspace PM can re-announce the
initial address with ID 0. To catch an ID 0 used with a different
address, it relies on mptcp_userspace_pm_append_new_local_addr()
returning an error.

Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.4.1-13 [1]

> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 74969b86fb812..66dbf67fd6d80 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -239,12 +239,6 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
>  	if (err < 0)
>  		goto announce_err;
>  
> -	if (addr_val.addr.id == 0) {
> -		NL_SET_ERR_MSG_ATTR(info->extack, addr, "invalid addr id");
> -		err = -EINVAL;
> -		goto announce_err;
> -	}
> -

[Severity: Medium]

The commit message says:

  If the ID is set to 0, but the address doesn't match with the existing
  one, an error will be returned by
  mptcp_userspace_pm_append_new_local_addr().

Is that still true when the ID0 entry is missing from
userspace_pm_local_addr_list but the initial subflow is still alive?

Here needs_id is false and the list has no ID0 entry. So
mptcp_userspace_pm_append_new_local_addr() sets neither addr_match nor
id_match, and it takes this branch:

		} else {
			id = entry->addr.id;
		}
		...
		e->addr.id = id;
		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);

That adds a different address B with ID 0. mptcp_pm_nl_announce_doit()
then calls mptcp_pm_announced_alloc() and mptcp_pm_announce_addr(). The
result is ADD_ADDR id 0 for B while the initial subflow still uses ID 0
on address A, and no RM_ADDR is sent first.

The entry can go missing in at least two ways. The first is when
mptcp_pm_userspace_created() fails to allocate it. sock_kmalloc() also
fails when optmem_max is exceeded:

	entry = sock_kmalloc((struct sock *)msk, sizeof(*entry), GFP_ATOMIC);
	/* Fine not to handle the ID0 case in memory pressure */
	if (!entry)
		return;

The second is a failed MPTCP_PM_CMD_SUBFLOW_CREATE from the initial
address A with port 0 and id 0. That request matches the ID0 entry. If
__mptcp_subflow_connect() then fails (for example -ENETUNREACH or a bind
error), the error path in mptcp_pm_nl_subflow_create_doit() runs:

	if (err) {
		...
		mptcp_userspace_pm_delete_local_addr(msk, &entry);
		...
	}

That lookup is by address, so it frees the existing ID0 entry. A
SUBFLOW_DESTROY of a secondary subflow from A can delete it the same way,
through the port-0 wildcard match in mptcp_userspace_pm_lookup_addr().

Before this patch, the addr_val.addr.id == 0 check rejected these
requests no matter what the list held. The later patches in the series
don't seem to change these paths.

[Severity: Medium]

Can this also leave two ID 0 entries in the list on the active side?

mptcp_connect()->mptcp_token_new_connect() adds the msk to the token hash
at connect() time. From that point mptcp_userspace_pm_get_sock() can find
it, and the token can be read through MPTCP_INFO or mptcp_diag. The ID0
entry is only added later, when the SYN-ACK is processed:

mptcp_finish_connect()
  mptcp_pm_new_connection()
    mptcp_pm_userspace_created()

During that window userspace_pm_local_addr_list is empty. An ANNOUNCE
with ID 0 for any address B gets through
mptcp_userspace_pm_append_new_local_addr() and stays in the list.

When the connection is established, mptcp_pm_userspace_created() appends
the real initial address A with ID 0. It does not check for an existing
ID 0 entry:

	spin_lock_bh(&msk->pm.lock);
	list_add_tail_rcu(&entry->list, &msk->pm.userspace_pm_local_addr_list);

The list then holds two different addresses with ID 0.
mptcp_userspace_pm_lookup_addr_by_id(0) would return B.

Before this patch, ANNOUNCE with id 0 was always rejected. The same
request through SUBFLOW_CREATE cleans up after itself: there,
__mptcp_subflow_connect() returns -ENOTCONN and the error path deletes
the entry. This state can still be reached at the end of the series.

[Severity: Low]

With this patch alone, an ANNOUNCE with ID 0 for the initial address goes
through mptcp_pm_announced_alloc(). That allocates an anno entry, arms
the ADD_ADDR retransmission timer and increments add_addr_signaled. A
REMOVE with id 0 still takes the shortcut in mptcp_pm_nl_remove_doit():

	if (id_val == 0) {
		err = mptcp_userspace_pm_remove_id_zero_address(msk);
		goto out;
	}

mptcp_userspace_pm_remove_id_zero_address() only calls
mptcp_pm_remove_addr(). It never calls mptcp_pm_announced_remove() or
changes add_addr_signaled, and it returns -EINVAL if no subflow has
local_id 0.

Could mptcp_pm_add_addr_timer() then resend ADD_ADDR id 0 after RM_ADDR
id 0 has been sent, with add_addr_signaled drifting as well?

The later patch "mptcp: pm: userspace: no ID0 exception for RM_ADDR"
seems to fix this. It removes the shortcut, so id 0 goes through
mptcp_userspace_pm_remove_addr_entry(), which calls
mptcp_pm_announced_remove() and adjusts add_addr_signaled. Only the state
between the two patches is affected, or a backport that takes this patch
without the next one.

Would it make sense to put the RM_ADDR patch before this one in the
series?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292%40kernel.org
