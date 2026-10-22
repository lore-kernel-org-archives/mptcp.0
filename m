Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661043;
	b=VtN7V41yX+70Iio7VFJ730x80W4DzxMBJbod/sBVvskRMO1cAhZVuOkWu2DWS1wi5j8d
	 L20OhkSeFKb7uwB2Qk5Q7W6vTkdO9Czi+CVjdL+xXapuslEFYE4uFlIxHyzjugM1XzIZX
	 TcNFK20Dq+nBgZ9SfAh7LAf5k3MFaI+8ATiPt3qBKrhl/WiJksDQyywVrHHhVVZIg00A3
	 bONn1zwwYeL5A5bJ2mZAYkmd+SaHZ1whvA7fJCqUwSXDButFwYBJaBKb3I0gV2lgo4GtX
	 UNf82hvLaoP80MvSL0S/Ma+zprlb41XvVu07byPPhxItl1RncK2DNgUjMlNcIbtojhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661043;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2Fsr6DM5h3U4on4rsZBv7Nd7bHK7zC6wiz9FJRst9rs=;
	b=JQONCYT/xU/Yh75KuIkf2lCitFloj+KNDCE4FKHuO5z4wnxrRnLJ+Xy85fQAvEvw6Z3y
	 czlsIjEaWSHtsLpEAW9KVu22dGm4GYJv0OLXbgqV3Sg2Sp9jPQcKvNIcsldLFTwLnLvyZ
	 PDo2meWzMwXYmZ8qAzSZv1YnQbPOGV0jSa3A7XJ6KMSM9Pp/xaDGpHbYKHWF1PY+w9lCN
	 +62jhUjpZSjXnCXyrS+oOL2UezOpQsX3hqyHa17QZg1d+rQd5wKZXdW+XXf1/mmhJc0OM
	 bk1nWt+uRUvsU/xh9t9z/aPEvTD6YQ2T9WabnKq+pH9uV4skKVGzCAek6ZXZBkmiLdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BgWc1U9k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F08606A319
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BgWc1U9k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BF11F000C1;
	Thu, 22 Oct 2026 09:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792661042;
	bh=2Fsr6DM5h3U4on4rsZBv7Nd7bHK7zC6wiz9FJRst9rs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BgWc1U9klhYIrX/xCyQVB+n5K6C1iaeYxuQy8mExMKFCPPkTTjhydGW0LcWu71iC1
	 alhDwUALGb/AFt36r+7RRF+z1JWOsQo0vZ7UOiC1A0VDftdHV1LWw+DxYTwB+Xqjdy
	 aSrbR+bDSmeVzxKWuwbQig4GWqfdo6dx/d6A5KIuKUbW/Y9zwTVAefySQghhXJN+/c
	 2J5Tkql5ljQEpvhtuUxvTzM54G7/NBjU8+LSUZqPkOWTQHywSwOC0mSRjpEnQommJX
	 YdfXcViKqKaeVwZXBxKLfrkTgMGNeBMdjTjmYZkvYK4kYcvPAYgS777jv3b55eE701
	 2EI1bQUICyF9A==
Message-ID: <sashiko-outbox-181256@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net] mptcp: pm: kernel: c-flag: mark as used only
 when it is
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261022-mptcp-pm-cflag-clear-when-used-v1-1-516c09b4ee65@kernel.org>
References: <20261022-mptcp-pm-cflag-clear-when-used-v1-1-516c09b4ee65@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 09:24:02 +0000
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
- [Critical] mptcp: infinite loop in fill_local_addresses_vec_c_flag() on s=
kipped endpoint
--

commit 13a1b915ae070fcc7bed06cf022912abbebad663
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: pm: kernel: c-flag: mark as used only when it is

This commit moves the clearing of local->addr.id in msk->pm.id_avail_bitmap
in fill_local_addresses_vec_c_flag() until after checking that the address
families match and the local endpoint is not msk->mpc_endpoint_id.

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index d3014bf57bf3c..3e473a81389d3 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -582,14 +582,14 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *=
msk,
>  		if (!select_local_address(pernet, msk, local))
>  			break;
> =20
> -		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
> -
>  		if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
>  			continue;
> =20
>  		if (local->addr.id =3D=3D msk->mpc_endpoint_id)
>  			continue;
> =20
> +		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);

[Severity: Critical]
Could moving __clear_bit() after the continue statements cause an infinite
loop in fill_local_addresses_vec_c_flag()?

In net/mptcp/pm_kernel.c, select_local_address() always scans
pernet->endp_list from the head and returns the first subflow endpoint whose
ID is still set in msk->pm.id_avail_bitmap:

net/mptcp/pm_kernel.c:select_local_address() {
	...
	list_for_each_entry_rcu(entry, &pernet->endp_list, list) {
		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
			continue;

		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
			continue;

		new_local->addr =3D entry->addr;
		new_local->flags =3D entry->flags;
		new_local->ifindex =3D entry->ifindex;
		found =3D true;
		break;
	}
	...
}

When __mptcp_pm_kernel_worker() -> mptcp_pm_nl_add_addr_received() ->
fill_local_addresses_vec() -> fill_local_addresses_vec_c_flag() runs and the
selected endpoint either fails mptcp_pm_addr_families_match() or matches
msk->mpc_endpoint_id, the loop takes a continue branch without clearing
local->addr.id in msk->pm.id_avail_bitmap or incrementing
msk->pm.local_addr_used.

On the next iteration of while (msk->pm.local_addr_used < endp_subflow_max),
wouldn't select_local_address() return the exact same endpoint again and lo=
op
indefinitely?

> +
>  		msk->pm.local_addr_used++;
>  		msk->pm.extra_subflows++;
>  		i++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-mptcp-pm-c=
flag-clear-when-used-v1-1-516c09b4ee65@kernel.org?part=3D1
