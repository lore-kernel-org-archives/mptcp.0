Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793446231;
	b=qPrPwabtK6vqC0FI2HW8mNuRkQc0NRJLrkQEa4OwqGDCsXnJP0BaBgdmqHCeUJrMsc7s
	 FF/D8YMWozV7cb6+l9N2Nn9BFrQQYh9mzNiiMhIqsEkxXitCjBH8PVWuEADBGKM25bGbe
	 vLGg9ruzxobClsF5m8X/NiCiloHnlJkefcRjqzvhu4Q3X1AcomSyfghJWFG7PHVnFJAjE
	 9h2Zxc/41I1nZYTz1uBmmCZP1RGH6/luQEV/wUlgbcS2nFClpzS5uvZf2I18KJlEUqBrI
	 NXGc5px/feE5ds2wMDJvDSpUKmIfHJQHRjdsS1rUeDTK0dY5xjBpiiaRwcLvjVGOD0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793446231;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Rld+QvZumWnEDU6Fjd2wPMdSnC6Wk0IgLpjRxBl9O6E=;
	b=WSoe0v/qbaaHYK+v2pc0Lzsqt6W6iax9Z5i43ieT+ogqofIRnsmxlWOJvsZOkcHMBGo0
	 WknQG/QoxPxKrqAawfD7UBsJG+e6lFHD1q0gwDqEsol3cRNf9SdJ8YFyTxbAcaP7n4znI
	 O1np2OXfq7dze3rXh5imzpoZo+Q3dyqrcvij5i3GjPa6G/iR5l1OZW1z/cYQD/6HMhpxD
	 Jbf8SYQvWE4bhyX3b6CVVf3AJLBVd6a//oCyVfHh/zuia7TovLh8T2phRmZl7xNU3pB9U
	 x8OLEZWsJ2fJ3tHj8B+Cc8fWD2RaguCLXqkuPTUWBVUn3H1kMb5V0S9KlicMbwIxy8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oduv9jak;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC24B606A31C
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oduv9jak
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF531F000C1;
	Sat, 31 Oct 2026 11:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793446230;
	bh=Rld+QvZumWnEDU6Fjd2wPMdSnC6Wk0IgLpjRxBl9O6E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Oduv9jakE4/GVZYQXAJWSpCOSWmblHFvsY9jM2KeT8eqNd1s1VeJS2kRmtZu++1W0
	 wqHYQLQFUFvxIOaqPDqjcpEGxR6TxhpShTZ5/r/3k/H3tP70Mw/atmPwAErFAf8wi9
	 mQmOaE7haasr9ApiITLxPgHBvBp+9WNnjcIYqxjjiVkC74pESdgOH9Xoz0lq7zuP8c
	 8jVUUS3K5SAtR/zJn2R2N4r7fZyVbXSdeK8uiy3LAtlLPx4rzvZlPfOXFCnrCFdqgB
	 +fdAVN1i1jJVuRHONIxn8He13leT21ayKIFFxxHo7Bt6EVCKLgjLrQIGwijKpShqGx
	 cUEBMGbUZ64UQ==
Subject: Re: [PATCH mptcp-net v4 5/8] mptcp: pm: userspace: no ID0 exception
 for RM_ADDR
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 31 Oct 2026 11:30:29 +0000
Message-ID: <179344622975.3128.8754884157681375701@kernel.org>
In-Reply-To:
 <20261029-mptcp-pm-userspace-id0-case-v4-5-555066fa4292@kernel.org>
References:
 <20261029-mptcp-pm-userspace-id0-case-v4-5-555066fa4292@kernel.org>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch removes the `id_val == 0` special case in
  `mptcp_pm_nl_remove_doit()` (net/mptcp/pm_userspace.c).
- [Low] This patch carries `Fixes: 84c531f54ad9` (so stable tooling will
  select it), but it only works on top of commit "mptcp: pm: userspace:…

--

mptcp: pm: userspace: no ID0 exception for RM_ADDR

This commit removes the id 0 special case from mptcp_pm_nl_remove_doit().
That special case scanned the subflows for local_id 0 and sent RM_ADDR(0).
ID0 removal now uses the regular lookup in the userspace PM local address
list, which relies on an earlier patch in the series adding the ID0 entry
when the connection is created.

> After the first patch of this series, the initial ID0 address is present
> in the local addr list when the connection has been created.

[Severity: Low]
This patch has a Fixes: tag, so stable tooling may pick it up. It only
works on top of "mptcp: pm: userspace: properly handle the ID0 case".
Once the patch is in git history, will "the first patch of this series"
still point to that prerequisite?

Without the prerequisite, mptcp_pm_userspace_created() does not exist and
no ID0 entry is added to userspace_pm_local_addr_list. In that case
mptcp_pm_nl_remove_doit() would return -EINVAL for every REMOVE with
id 0. The patch only deletes code, so it would still apply cleanly on its
own.

Could the prerequisite be named by subject or commit id, or recorded as a
stable dependency?

> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 66dbf67fd6d80..0f6400bc3bf8e 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c

[ ... ]

> @@ -343,11 +312,6 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
>  
>  	sk = (struct sock *)msk;
>  
> -	if (id_val == 0) {
> -		err = mptcp_userspace_pm_remove_id_zero_address(msk);
> -		goto out;
> -	}
> -
>  	lock_sock(sk);
>  
>  	spin_lock_bh(&msk->pm.lock);

[Severity: Medium]
Without this fallback, REMOVE with id 0 only works if
mptcp_userspace_pm_lookup_addr_by_id(msk, 0) still finds the ID0 entry.
The removed mptcp_userspace_pm_remove_id_zero_address() did not use the
list. It sent RM_ADDR(0) whenever a subflow with local_id 0 existed.

Is the ID0 entry guaranteed to be present while the initial subflow is
alive? There seem to be three ways for it to go missing.

First, mptcp_pm_userspace_created() ignores allocation failure:

net/mptcp/pm_userspace.c:mptcp_pm_userspace_created() {
	entry = sock_kmalloc((struct sock *)msk, sizeof(*entry), GFP_ATOMIC);
	/* Fine not to handle the ID0 case in memory pressure */
	if (!entry)
		return;
	...
}

mptcp_pm_new_connection() still emits MPTCP_EVENT_CREATED in that case.
Is that comment still accurate after this patch?

Second, userspace can create a second subflow from the initial IP with
id 0 and no port, as the "userspace pm create id 0 subflow" selftest
does. mptcp_userspace_pm_append_new_local_addr() reuses the ID0 entry,
and the new subflow gets local_id 0 with an ephemeral port. A
SUBFLOW_DESTROY for that subflow then goes through:

mptcp_pm_nl_subflow_destroy_doit()
  mptcp_userspace_pm_delete_local_addr()
    mptcp_userspace_pm_lookup_addr()

In the lookup, the port 0 ID0 entry matches as the wildcard:

		if (!wildcard && (!addr->port || !entry->addr.port))
			wildcard = entry;

So the ID0 entry is freed even though the initial subflow still uses it.

Third, a SUBFLOW_CREATE with the initial IP, id 0 and port 0 also reuses
the ID0 entry. If __mptcp_subflow_connect() then fails, for example with
-ENOTCONN when the connection is not fully established yet,
mptcp_pm_nl_subflow_create_doit() rolls back with:

		mptcp_userspace_pm_delete_local_addr(msk, &entry);

This deletes the ID0 entry that it reused but did not create.

In each case, wouldn't the next REMOVE with id 0 fail with -EINVAL
("address with id 0 not found")? Before this patch, the same request
sent RM_ADDR(0). None of the later patches in the series seem to add a
fallback or protect the ID0 entry.

Would it make sense to keep a subflow scan fallback for id 0 when no
entry is found? Another option is to make the ID0 entry reliable: handle
the allocation failure, and do not delete the entry through the wildcard
or rollback paths while a local_id 0 subflow exists.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292%40kernel.org
