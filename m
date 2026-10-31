Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793446228;
	b=h2aCmoRADwFQZaMZwyt9aeTK8h0FsOf3ivBNjf0CjhQRtg/NPOztjLHBLZ55HzFAAQwc
	 WwOuK5V6barUlZ0iGdWCK93d9N2NaxHzlhRgFzjRpPgbJsK4Q9MIfHf3Ak41le/Vrjezm
	 Z0s/CoYF2U20FrINHx+kPtYabZKaBtDCNWX3g15sdlKjBGN5BTH3YwDbRvbqsJS8vNOv+
	 fcFvXVB9AyRxBunOjRp5+MIf5sNZ33uzJ+IsP9+XLugWA7DTb1iLL+aLcx0qE4wdeOC2I
	 +UaWd+pMi5UC5A3ljgnO3d1xMQzkcLtpKVLdO1wRO2sRZ4XdAy7zbZgzW6PipJXgOOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793446228;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=nQMmvoLLLmVw1KUXKBPiqc73bpjCvibc3n52n/9jfQs=;
	b=1wtnSb7+o6rYzgjGtVjmvIiysFvQDCuoDIgHgPt0ihhlYCks6+/CFaSCNEdydGU3eEGt
	 oD7t4mQmo+eu1sF+7PWuXY/24m+lfsszUj/y/6t6QsEgm/5k/pvOTqE/zudUZ99Ph9Iiv
	 tIoPnVLyd4SPV0al7sp4u68mWWp52HZ5eqSJ/dgrVTzXSOVjWEg9dhdA4dUBmvn7uA1eL
	 TFMi9HWyxM3nVuLKUIaQp0R1kLP+veME8kPqkQsaMBqGb16mS4HbljPxYvyrDMQYwBj5b
	 1y4c6rHtBN97KFwUVBFA7Eb5ZlELJ8oqsULuI+rBXm2JnfyyIv+6N9XVaK4fwjxX3BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WCn46hKE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564DC606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WCn46hKE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71321F00919;
	Sat, 31 Oct 2026 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793446228;
	bh=nQMmvoLLLmVw1KUXKBPiqc73bpjCvibc3n52n/9jfQs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WCn46hKEzqw4L45gRt9pOPUGv4GKuEjqot9UN1AXC3EL6ln/tEMvoHcU69EO6vc6Q
	 oa2Ur4D2wXqgmFKVweYcI/Po3Hlfy9DsNYUhvg7i4JyNIBf1cgNtY56SiGmEGO5S6H
	 RPcJEzYTH42Yz7j8WeX0oLlmO4fzkItRObjLqKSkw8uX3t8xfTua1gD0y5krOVE59v
	 IxpLue22ym1xSllSj1a4QIEWx4+GNsCJs/ng3vL3azwhb7kf9xVJT+3Fhp6JGOBKDZ
	 fVSfHtbVqEbEo0WT3DjaMqH4tH8SM+ISRpVKx8u+D+f1S2vRI/tCP/26zYayUJg9+V
	 55m+Q2YNVwmLw==
Subject: Re: [PATCH mptcp-net v4 2/8] mptcp: pm: userspace: lookup: match port
 in priority
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 31 Oct 2026 11:30:27 +0000
Message-ID: <179344622743.3128.16751096031438735678@kernel.org>
In-Reply-To:
 <20261029-mptcp-pm-userspace-id0-case-v4-2-555066fa4292@kernel.org>
References:
 <20261029-mptcp-pm-userspace-id0-case-v4-2-555066fa4292@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Joins on a local address with a different port are now
  rejected.

--

mptcp: pm: userspace: lookup: match port in priority

This patch changes mptcp_userspace_pm_lookup_addr() so that, when the
address matches, an entry with the exact same port is returned first.
Otherwise it falls back to an entry where one of the two ports is 0. If
both ports are non-zero and different, the lookup now returns NULL. The
old lookup matched on the address alone.

> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 45faee894ac3d..68a02b15a4c53 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -31,13 +31,19 @@ static struct mptcp_pm_addr_entry *
>  mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk,
>  			       const struct mptcp_addr_info *addr)
>  {
> -	struct mptcp_pm_addr_entry *entry;
> +	struct mptcp_pm_addr_entry *entry, *wildcard = NULL;
>
>  	mptcp_for_each_userspace_pm_addr(msk, entry) {
> -		if (mptcp_addresses_equal(&entry->addr, addr, false))
> -			return entry;
> +		if (mptcp_addresses_equal(&entry->addr, addr, false)) {
> +			if (addr->port == entry->addr.port)
> +				return entry;
> +
> +			if (!wildcard && (!addr->port || !entry->addr.port))
> +				wildcard = entry;
> +		}
>  	}
> -	return NULL;
> +
> +	return wildcard;
>  }

[Severity: Medium]
With this change, can an incoming MP_JOIN to a local address with a
different port be rejected?

Take a userspace PM connection where the daemon announced B:X (id 5,
X != 0) on a non-initial address B. The peer then sends MP_JOIN to B:P,
where P is the msk port (listener on a wildcard address). Before this
patch, the lookup matched B:X on the address alone and the join got
id 5. Now both ports are non-zero and different, so the lookup returns
NULL.

On a lookup miss, mptcp_pm_userspace_get_local_id() falls back to
appending a new entry with needs_id set. The skc id is 0, because
mptcp_pm_get_local_id() sets it that way:

    if (skc->addr.port == msk_sport)
        skc->addr.port = 0;

    return mptcp_userspace_pm_append_new_local_addr(msk, skc, true);

The parent commit added an ID0 entry to every userspace PM connection
in mptcp_pm_userspace_created():

    memset(entry, 0, sizeof(*entry));
    mptcp_local_address((struct sock_common *)ssk, &entry->addr);
    entry->addr.port = 0; /* msk port */

In mptcp_userspace_pm_append_new_local_addr(), the loop reaches that
ID0 entry with addr_match false (different address). Since the
requested id is 0, id_match is true:

    id_match = (e->addr.id == entry->addr.id);
    if (addr_match || id_match)
        break;

Neither the "!addr_match && !id_match" branch nor the
"addr_match && id_match" branch applies after this, so the function
returns -EINVAL without allocating an ID.

subflow_token_join_request() then sees the negative id and drops the
join:

    local_id = mptcp_pm_get_local_id(msk, (struct sock_common *)req);
    if (local_id < 0) {
        SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPJOINNOIDFOUND);

Any subflow whose address only appears in entries with a different
non-zero port would take the same path. The underlying problem is that
the needs_id append matches id 0 against the ID0 entry. This patch is
what turns the former lookup hit into a miss.

No later patch in the series appears to change the append loop or the
lookup. Only the local_addr_used accounting around it changes. Could
the id 0 case be handled in the append loop, or could the lookup keep
an address-only fallback for this case?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292%40kernel.org
