Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793446228;
	b=QyN7EApJDpTw7Hyv3aRl49YqjkEmTa8PgbCTHkZRRDLog6n+4FXiotNHtTeq/P6v9lK3
	 o8x2SwndCLEym7GiMb5BiZW6Oo/+s5baQMoxABr8//KgUus67dpnejZQkAuYrIaBVylkF
	 okNSgz5AIPy8hNJm+1yykJhdMxpUAF7moxnebow3ZaH2sxJ/3tKk62SyIQMD+7n4cPIGT
	 70o+ljRIqC950zt96QM3eOXvQTFEYqwTiMvswe9oYfEiCDz0JkQjcgvdOZ+rc5Xb1KGyg
	 CDJDg08EsZKimiygRgWk11XOWDyezXzMsMQTzj4Sr5NbvcjcNMrX/Fb8uw/KPVyP03w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793446228;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cW3gluZr/eVnlqD0L6fkkOIy3pYeQB9YmvHYaipzgSA=;
	b=E8E8ZFhrqDpvOOczeQrw9OdUadTJCVHI0U4AEvEPyc+wmy0+As1XIO3PyGZRuLqxDYQP
	 WYKft7tNNHxqrqEdnVj/QnYuDR165jGCE45mu8p4gM9mfV3+L7J407e40+LSljw8jkV/p
	 3NO0D/LT/y+7L/BmsBFFAnZVLyRMMfSC7EGyEXfouGt/1qn03cWcCl335QKw3mtHB87BD
	 Wp2wc29ht2SCqHU/3KJ2eEEWxLo1heDdLProq3Ty6eNQZblaQCG7LML1NkV3LAcrTHQ25
	 aga2MeMoVq2rj5vCZbVYHZCyVV1J6SyUJPGqeNLD0kgYNiT8QRZxTGLPKBjDDOOnxBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6B+Ucj1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD64606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6B+Ucj1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E12F1F000C1;
	Sat, 31 Oct 2026 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793446227;
	bh=cW3gluZr/eVnlqD0L6fkkOIy3pYeQB9YmvHYaipzgSA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T6B+Ucj1YkAiKoBsG6b+WBUG2m2sEuZbx8DB6XwjLCiOL9NbwED/bg44aSOKLWY1F
	 edgV7Pyvho2KK+iQhP7qUj5uqKS/Rf6evImSHlj6f5XQigKJy0lD1veZU0Ai/khieI
	 KzppiUunFxMMLCeiFv4JWJR91wuzlOpChERZAQUKDiDdWy5mUyAPAbLmKqdxR/XznU
	 DmhqzXyADXYnstpOBkcprQtbEI2Y9Sx5OGQhvaZAP8Buik8EyvImMDv5gA+wYCMeaz
	 vdP1ECCiGpNVc8Jg9Y+f4P7eovh4A7Tl97VPwYvdxeLOXMIURVt6hpk3iOM867u2dv
	 FefdXDD9IVfqw==
Subject: Re: [PATCH mptcp-net v4 1/8] mptcp: pm: userspace: properly handle
 the ID0 case
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 31 Oct 2026 11:30:26 +0000
Message-ID: <179344622665.3128.3956279829893544629@kernel.org>
In-Reply-To:
 <20261029-mptcp-pm-userspace-id0-case-v4-1-555066fa4292@kernel.org>
References:
 <20261029-mptcp-pm-userspace-id0-case-v4-1-555066fa4292@kernel.org>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] A userspace-PM connection can no longer get a new local address
  ID allocated automatically.
- [Medium] The ID0 entry is shared by the initial subflow and by any
  later subflow created from the initial IP with id 0.
- [Low] mptcp_pm_userspace_created() appends the ID0 entry without
  checking for an existing entry with the same address, and without…
- [Low] Rejected after validation (baseline false).
- [Low] Rejected after validation (baseline false).

--

mptcp: pm: userspace: properly handle the ID0 case

When a connection is created, this commit adds the initial local address
(ID0, msk port) to the userspace PM local address list. ID0 can then be
handled like any other entry instead of as a special case. Later patches
in the series remove the existing ID0 exceptions.

> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index f723a134356f3..45faee894ac3d 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -707,6 +707,26 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
>  	return ret;
>  }
>  
> +/* Add the initial local address (ID0) to the local list: easier that way */
> +void mptcp_pm_userspace_created(struct mptcp_sock *msk, const struct sock *ssk)
> +{
> +	struct mptcp_pm_addr_entry *entry;
> +
> +	entry = sock_kmalloc((struct sock *)msk, sizeof(*entry), GFP_ATOMIC);
> +	/* Fine not to handle the ID0 case in memory pressure */
> +	if (!entry)
> +		return;
> +
> +	memset(entry, 0, sizeof(*entry));
> +	mptcp_local_address((struct sock_common *)ssk, &entry->addr);
> +	entry->addr.port = 0; /* msk port */
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	list_add_tail_rcu(&entry->list, &msk->pm.userspace_pm_local_addr_list);

[Severity: High]
Now that this entry sits first in userspace_pm_local_addr_list, can the
kernel still allocate an implicit ID for a new local address?

For any address other than the initial one, mptcp_pm_get_local_id() calls
ops->get_local_id() with skc_local.addr.id = 0. Then
mptcp_pm_userspace_get_local_id() calls
mptcp_userspace_pm_append_new_local_addr(msk, skc, true). The first entry
that loop sees is this ID0 entry:

	mptcp_for_each_userspace_pm_addr(msk, e) {
		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
		...
		id_match = (e->addr.id == entry->addr.id);
		if (addr_match || id_match)
			break;
		__set_bit(e->addr.id, id_bitmap);
	}

addr_match is false, but id_match is (0 == 0), so the loop breaks. The
!addr_match && !id_match branch does not run, and neither does the
addr_match && id_match branch. The function returns -EINVAL and never
reaches find_next_zero_bit(..., 1).

Would subflow_token_join_request() then reject an incoming MP_JOIN to any
local address that is not the initial one and not already in the list,
and bump MPTCP_MIB_MPJOINNOIDFOUND?

The same seems to apply to outgoing subflows with an IPADDRANY local
address (local_id -1). They go through
subflow_chk_local_id()->mptcp_pm_get_local_id(), so they would fail in
subflow_rebuild_header() whenever routing picks a source other than the
initial address.

The v2 changelog says "Handle needs_id where the addrs don't match, but
the IDs (0) does". I couldn't find that handling in this commit, and the
append loop looks unchanged at the end of the series.

[Severity: Low]
Can a second entry for the initial address end up in the list? This
insertion doesn't look for an existing entry with the same address, and
doesn't check MPTCP_PM_DESTROYING.

The msk can be found by token before mptcp_pm_new_connection() runs:

- On the client, mptcp_connect() calls mptcp_token_new_connect() at
  connect() time. mptcp_pm_new_connection() only runs later, from
  mptcp_finish_connect() after the SYN-ACK.

- On the server, mptcp_sk_clone_init() calls mptcp_token_accept() shortly
  before subflow_syn_recv_sock() calls mptcp_pm_new_connection().

In that window, mptcp_userspace_pm_append_new_local_addr() would accept
MPTCP_PM_CMD_ANNOUNCE {initial addr, id X}, because the list is still
empty. This function would then add {initial addr, id 0} as well.

Lookups would return the first match (id X), and a later SUBFLOW_CREATE
{initial addr, id 0} would be rejected. Should the insertion check for a
matching entry under pm.lock?

> +	/* The initial address ID doesn't increment local_addr_used */

[Severity: Medium]
The initial subflow shares this entry with any later subflow created from
the initial IP with id 0. mptcp_userspace_pm_delete_local_addr() still
unlinks and frees whatever entry the lookup returns. Can the ID0 entry be
freed while the initial subflow is still using ID0?

The first case is mptcp_pm_nl_subflow_create_doit() with {initial addr,
port 0, id 0}. That matches the existing entry (addr_match && id_match),
so no new entry is created. If __mptcp_subflow_connect() then fails
synchronously (for example with -ENETUNREACH), the error path runs:

	if (err) {
		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);

		spin_lock_bh(&msk->pm.lock);
		mptcp_userspace_pm_delete_local_addr(msk, &entry);
		spin_unlock_bh(&msk->pm.lock);
	}

This frees the pre-existing ID0 entry, which this call never allocated.

The second case is mptcp_pm_nl_subflow_destroy_doit() on a secondary
subflow from the initial IP that uses an ephemeral port. The
port-agnostic lookup returns the ID0 entry, and it gets freed.

In this commit, mptcp_userspace_pm_delete_local_addr() also decrements
local_addr_used, which was never incremented for this entry. Later in the
series, "mptcp: pm: userspace: ID0 is not part of local_addr_used" fixes
that decrement, but not the free.

Later in the series, "mptcp: pm: userspace: no ID0 exception for
RM_ADDR" and "mptcp: pm: userspace: allow announcing ID0 addr" are
applied. After that, once the entry is gone:

- RM_ADDR id 0 fails with "address with id 0 not found".
- ANNOUNCE or SUBFLOW_CREATE with {other addr, id 0} is accepted, even
  though the initial address still owns ID0.

Doesn't that bring back what the commit message says it prevents: "no
other addresses and ports can get this special ID while the initial IP
address and port is used"?

> +	spin_unlock_bh(&msk->pm.lock);
> +}

[Severity: Low]
With the ID0 entry in the list, SUBFLOW_CREATE with id 0 from a
non-initial address now returns -EINVAL, because of the id-only match in
mptcp_userspace_pm_append_new_local_addr(). The commit message describes
this as intended.

At this commit, though, the "userspace pm create id 0 subflow" test in
tools/testing/selftests/net/mptcp/mptcp_join.sh still expects it to
succeed. Would that break bisection?

Later in the series, "selftests: mptcp: join: new ID0 subflow from the
right IP" updates the test to expect the failure and to use 10.0.1.2 for
the ID0 subflow.

[Severity: Low]
At this commit, the dump and GET output also include the new ID0 entry.
That breaks the exact-match expectations in the "add & remove address"
and "create destroy subflow" selftests.

RM_ADDR id 0 also still goes through
mptcp_userspace_pm_remove_id_zero_address(), which leaves this entry in
the list.

Both are addressed later in the series:

- "mptcp: pm: userspace: don't dump initial ID0" skips is_init_id0()
  entries in mptcp_userspace_pm_dump_addr().
- "mptcp: pm: userspace: no ID0 exception for RM_ADDR" removes
  mptcp_userspace_pm_remove_id_zero_address().

Could the series be reordered so that each step stays consistent for
bisection?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292%40kernel.org
