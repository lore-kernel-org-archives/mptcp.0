Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311027;
	b=yCvigl8Fu2GlpuyejQamxqAveJ951dQ/H7PJflIbZ2Lx6drqzIYrsbeCHaDNYCdu0leC
	 GepLYYkmnPtZXtPDUiE25Pr4rWYP/f0pF528sOMgPEqongFij+/iShZbG9Bes1tEnwLns
	 6lkRW/9qECMg8sHMhEu3xShuPhKRN4OxmVtRDW1mD8A5FXMmEuyv1kZOFEelaJ1Ogz5+q
	 xvLCXTyuR+TBGNyWmwTEUL135MAZF9tPwUR3JQqYOtiR1YfHMPuXIsekeAYdPj/a96fEE
	 +ku6wnnOq7dRhl+p9b3c27QNfhBoZtfNXTw9cKOMHFqPA695L33cV/JTmzRkT5wk03Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311027;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WMyvqPrLdQNt9shdCLKO7ZbHDXMCTSBowgKi9sHY/f4=;
	b=k/BZG6UTRNlmCNflmK7WT1XCKcUJ4u8vfvwgPhaenNg9BxVf7MrE/ldYRTIPdxyevG9V
	 CNc34YMQZSIHs1x0imMGH56l/MkOj6iv0f1XnkdXVK6C951ZtiiGvdXK23dGzcK7q86i9
	 ILyqUskl8dNZo7lzTNMZNoc3N/gz57hkMIv7pdF+g9VcuWqbWP68O1dLil6GwC2KstiWR
	 11efQ1ppNaizSW1VtvM1/CFePAyp0+F26nCucCYi3kKoMzcauIvZps5wicTvASMHkD5c+
	 iOwQALtpAMzSH14Tuk29+na46agP6CTNJyvaUP5HQ5lHn8T3JRTTj7uHnJMPTWJrUIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMXiajxt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3915B606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 21:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMXiajxt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F591F01816;
	Thu, 29 Oct 2026 21:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793311026;
	bh=WMyvqPrLdQNt9shdCLKO7ZbHDXMCTSBowgKi9sHY/f4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=cMXiajxtfcBkOgGIidfCIA/swQhl2i9bjXk79ej7eflXUq+ynmfx1XZZ011RG4oml
	 PVKoxrlT00PeW3W126O+Evze4xWIU4fbrX4TgdpFPBUkltpXNxZKyO+bEQVKf8snV0
	 OmYYSW9QQaumny+QFOgbFEgM24fzK73oxQeTaCmg9UDwaXzwbANM/esdlnvpLC7N3f
	 W9Y/6ZtkGoQqhCMeWYvNED7JrjYbyGIGqjt6EJLAAwzlm1YBC3WwgEUV5I8qYPJvbR
	 S+RdCvqB3nauIcEAan+eeSIpVUM14s6UXEmah8IAG4mGwLTn7HqFVRKm4rUEn4oBtE
	 F32eTB9RcY31A==
Message-ID: <sashiko-outbox-190026@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v4 1/8] mptcp: pm: userspace: properly handle
 the ID0 case
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261029-mptcp-pm-userspace-id0-case-v4-1-555066fa4292@kernel.org>
References: <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
 <20261029-mptcp-pm-userspace-id0-case-v4-1-555066fa4292@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 21:57:06 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mptcp: pm: userspace: ID 0 entry breaks mptcp_pm_userspace_get_loc=
al_id()
--

commit 626a00aaeaa0d778f8ba3b1e9d1ca84367bbdac3
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: pm: userspace: properly handle the ID0 case

This commit adds the initial subflow's local address (with ID 0 and port 0)
to the userspace path manager's local address list when a connection is
created so that ID 0 can be handled uniformly with other local addresses.

> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index f723a134356f3..45faee894ac3d 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -707,6 +707,26 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_=
pm_addr_entry *addr,
>  	return ret;
>  }
> =20
> +/* Add the initial local address (ID0) to the local list: easier that wa=
y */
> +void mptcp_pm_userspace_created(struct mptcp_sock *msk, const struct soc=
k *ssk)
> +{
> +	struct mptcp_pm_addr_entry *entry;
> +
> +	entry =3D sock_kmalloc((struct sock *)msk, sizeof(*entry), GFP_ATOMIC);
> +	/* Fine not to handle the ID0 case in memory pressure */
> +	if (!entry)
> +		return;
> +
> +	memset(entry, 0, sizeof(*entry));
> +	mptcp_local_address((struct sock_common *)ssk, &entry->addr);
> +	entry->addr.port =3D 0; /* msk port */
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	list_add_tail_rcu(&entry->list, &msk->pm.userspace_pm_local_addr_list);
> +	/* The initial address ID doesn't increment local_addr_used */
> +	spin_unlock_bh(&msk->pm.lock);
> +}

[Severity: High]
Does adding an entry with entry->addr.id =3D=3D 0 to
msk->pm.userspace_pm_local_addr_list cause a regression in
mptcp_pm_userspace_get_local_id() when allocating a local ID for a new,
unannounced address?

When mptcp_pm_get_local_id() -> mptcp_pm_userspace_get_local_id() is called
for a subflow whose local IP address differs from the initial subflow's IP
address and is not yet in userspace_pm_local_addr_list, skc->addr.id is 0 a=
nd
it calls mptcp_userspace_pm_append_new_local_addr(msk, skc, true):

net/mptcp/pm_userspace.c:mptcp_pm_userspace_get_local_id() {
	...
	if (skc->addr.port =3D=3D msk_sport)
		skc->addr.port =3D 0;

	return mptcp_userspace_pm_append_new_local_addr(msk, skc, true);
}

Inside mptcp_userspace_pm_append_new_local_addr(), the loop iterates over
userspace_pm_local_addr_list and encounters the initial ID 0 entry added by
mptcp_pm_userspace_created():

net/mptcp/pm_userspace.c:mptcp_userspace_pm_append_new_local_addr() {
	...
	mptcp_for_each_userspace_pm_addr(msk, e) {
		addr_match =3D mptcp_addresses_equal(&e->addr, &entry->addr, true);
		if (addr_match && entry->addr.id =3D=3D 0 && needs_id)
			entry->addr.id =3D e->addr.id;
		id_match =3D (e->addr.id =3D=3D entry->addr.id);
		if (addr_match || id_match)
			break;
		__set_bit(e->addr.id, id_bitmap);
	}

	if (!addr_match && !id_match) {
		...
	} else if (addr_match && id_match) {
		ret =3D entry->addr.id;
	}

append_err:
	spin_unlock_bh(&msk->pm.lock);
	return ret;
}

Because the new address does not match the initial subflow's address,
addr_match is false and entry->addr.id remains 0. However, e->addr.id is
also 0 on the initial entry, so id_match becomes true and the loop breaks
with addr_match =3D=3D false and id_match =3D=3D true, causing the function=
 to
return -EINVAL instead of assigning a new ID from id_bitmap.

Although the v2 changelog notes mention handling needs_id where the address=
es
do not match but the IDs (0) do, that check does not appear to be present in
this commit or later in the series.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-mptcp-pm-u=
serspace-id0-case-v4-0-555066fa4292@kernel.org?part=3D1
