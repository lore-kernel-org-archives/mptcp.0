Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24B638239C
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 05:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792216425; cv=none; b=NnQUk7mlkN0AU7HxZehcm6nFbEwxh/3cF4tGDcHoNmB0AWyYUyIRcVwRkNZdZVRAiirW0d3w1Ij/jMO8wb0ecTTdYvn4Ze6n1MvQlYt29GKcPQY/ZT/FzjamYWA5C47gebygYTNBzEvP25RYRYbYGeswIho83ak8krcIkDSp5qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792216425; c=relaxed/simple;
	bh=fd3TeyB/cnzZ4/5LTJizqmamkKk2dbyGTto47FF2p0Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IQA4gBoDo/YrLUwRCif+2CW/pUz6oh/DDe+VuXdz6UrHDrUXmKhf77WKDh0FBF4mt/DoNwCjLibSXizk5cAhQVJgZDB2MdA5cIsuBuxlJ9PcEat/9h1vIl3PACci0LDk1+3EyOZv4LucsWHJmXNIAENDEc7GtdixoM/PGnsbKsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTZKEMrT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTZKEMrT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B701F000C4;
	Sat, 17 Oct 2026 05:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792216423;
	bh=NRCQ1AlD+miEAAKYQH/jbnAsO4KzL9qqzOXHTgGITWU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WTZKEMrTXRXwC+WoqrrfGPyJpWjvCg3YRTUWYb7Sx7UEGgNzp6el/5O59H4/i7BIo
	 I+i3m0YlcVQfX6D70VYpGHoYljLxPDde3U5yx2pdC+rbicsoIV+dTj6Ki1ydgbxMNp
	 uQJhDRQk6U3zO/zD//dTEjFtYGUv0ZVa3sFpQwA/sKDu8KaWmQKPaWydNeyFHDOljD
	 GKtbpCspVMlvtPbX363j2Rq4u8HI1WZwwN1BnmI07TDyuO4y1H7e/OvoCCTmZr7gvQ
	 J1ziboJ64avquoHRISE4zNl37hW/WMlRO5hqCdTrMnwc1pMfDw/gnaukWEMaA7O8JK
	 bwQ5EyajAEMlA==
Subject:
 Re: [PATCH mptcp-net v2] mptcp: disconnect: reset first subflow's local_id
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 17 Oct 2026 05:53:42 +0000
Message-ID: <179221642289.3135.11740381750915982127@kernel.org>
In-Reply-To:
 <20261015-mptcp-first-disco-id-reset-v2-1-49b71541b059@kernel.org>
References: <20261015-mptcp-first-disco-id-reset-v2-1-49b71541b059@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch fixes only one of the two paths that reset the first
  subflow and then reuse it, so its own bug class is still reachable.
- [Medium] mptcp_disconnect() now sets the first subflow's local_id back
  to 0, but leaves msk->mpc_endpoint_id unchanged.
- [Low] The Fixes: tag points at the wrong commit.

--

mptcp: disconnect: reset first subflow's local_id

This commit sets the first subflow's local_id back to 0 in
mptcp_disconnect(), after mptcp_destroy_common() runs. Without it, a
reconnect goes through subflow_chk_local_id(), and the kernel PM can give
the MPC subflow a non-zero ID. The patch also fixes a stale comment that
still refers to msk->subflow.

Link: https://lore.kernel.org/179198834484.434549.4616694240552704738@kernel.org

> Fixes: a7cfe7766370 ("mptcp: fix data races on local_id")

[Severity: Low]
Is this the right commit for the Fixes: tag?

Before a7cfe7766370, local_id_valid was inside struct_group(reset) in
struct mptcp_subflow_context. The memset in mptcp_subflow_ctx_reset()
already cleared it, and subflow_chk_local_id() did:

	if (likely(subflow->local_id_valid))
		return 0;

Otherwise it called mptcp_pm_get_local_id(). That is the same reconnect
flow described above. a7cfe7766370 only replaced the flag with a -1
sentinel in local_id, which means the same thing.

The behaviour seems to come from 4cf86ae84c71 ("mptcp: strict local
address ID selection"). That commit added subflow_chk_local_id() to the
rebuild_header path and put local_id_valid inside the reset group. Before
it, the memset left local_id at 0 and nothing looked it up again, so the
MPC subflow kept ID 0.

This patch does depend on the s16 local_id from a7cfe7766370. Even so,
should the tag point to 4cf86ae84c71 instead?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 60cbd91be6320..a165e6683e6b5 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3649,11 +3649,13 @@ static int mptcp_disconnect(struct sock *sk, int flags)

[ ... ]

>  	mptcp_do_fastclose(sk);
>  	mptcp_destroy_common(msk);
> +	if (msk->first)
> +		WRITE_ONCE(mptcp_subflow_ctx(msk->first)->local_id, 0);

[Severity: High]
Does this cover every path where the first subflow is reset and then
reused?

The error path in mptcp_connect() also resets the first subflow context:

net/mptcp/protocol.c:mptcp_connect() {
    ...
	if (unlikely(err)) {
		mptcp_token_destroy(msk);
		mptcp_set_state(sk, TCP_CLOSE);
		...
		mptcp_subflow_ctx_reset(mptcp_subflow_ctx(ssk));
		return err;
	}

	mptcp_copy_inaddrs(sk, ssk);
    ...
}

After this, local_id is -1 and msk->first stays allocated. When
sk->sk_prot->connect() returns a negative value, __inet_stream_connect()
just does "goto out" and never calls sk_prot->disconnect(). So
mptcp_disconnect() and this new restore are both skipped.

Take an unbound MPTCP socket where connect() fails synchronously. For
example, addr_len is shorter than sizeof(struct sockaddr_in), sin_family
is wrong, or ip_route_connect() returns -ENETUNREACH. A second connect()
then reuses msk->first through __mptcp_nmpc_sk() and goes through:

  tcp_v4_connect()
    tcp_connect()
      subflow_rebuild_header()
        subflow_chk_local_id()
          mptcp_pm_get_local_id()

mptcp_copy_inaddrs() only runs after a successful connect, so the msk
local address is still 0. It does not match the subflow's routed source
address, and mptcp_pm_get_local_id() skips the ID 0 shortcut. The kernel
PM can then return a matching endpoint ID, or create an implicit endpoint
with a non-zero ID. subflow_set_local_id() stores that ID on the MPC
subflow.

Would it be more robust to set local_id to 0 for msk->first when the MPC
connect starts, for example in mptcp_connect() before
ssk->sk_prot->connect()? That would cover both the disconnect path and
the connect error path, and could replace this disconnect-only hunk.

[Severity: Medium]
Should msk->mpc_endpoint_id also be reset here?

The kernel PM uses mpc_endpoint_id to decide which endpoint maps to ID 0.
The field is in struct mptcp_sock, outside pm->reset, so
mptcp_pm_data_reset() does not clear it. The only place that clears it is
the endpoint delete path.

On reconnect, mptcp_mpc_endpoint_setup() runs again, but it only writes
the field when the new MPC address matches an endpoint:

net/mptcp/pm_kernel.c:mptcp_mpc_endpoint_setup() {
    ...
	entry = __lookup_addr(pernet, &mpc_addr);
	if (entry) {
		__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
		msk->mpc_endpoint_id = entry->addr.id;
		...
	}
    ...
}

Suppose the first connection's MPC address matched endpoint E, and the
reconnect uses a source address that matches no endpoint. E then stays
mapped to ID 0. mptcp_pm_create_subflow_or_signal_addr() would announce
E's address, or open a subflow from it, with ID 0:

	/* Special case for ID0: set the correct ID */
	if (local.addr.id == msk->mpc_endpoint_id)
		local.addr.id = 0;

With this patch the MPC subflow also has local ID 0. The connection then
has two different local addresses that both use ID 0.

If E is deleted later, mptcp_nl_remove_subflow_and_signal_addr()
computes:

	list.ids[0] = mptcp_endp_get_local_id(msk, addr);

This returns 0. mptcp_pm_rm_addr_or_subflow() then closes every subflow
with local ID 0, which includes the unrelated MPC subflow. Before this
patch, the MPC subflow had a non-zero ID in this case and was not
affected.

Setting up endpoints and deleting them needs CAP_NET_ADMIN, but the
socket operations do not.

>  
>  	/* The first subflow is already in TCP_CLOSE status, the following
>  	 * can't overlap with a fallback anymore

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-mptcp-first-disco-id-reset-v2-1-49b71541b059%40kernel.org
