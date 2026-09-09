Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C714757F73D
	for <mptcp@lists.linux.dev>; Wed,  9 Sep 2026 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963307; cv=none; b=rewKA859DRfrvkERYOudwlCR9RYfCvnUkD9PyImEmUo1HPBeCDjB32yPUmb0klpLO+kaKfx9F8m8cAWMGwMLUTpIchKkaFLBAQfQiF/Q7SynyruQ7DHUgSBadhAsCLOL75eFbVQNXG8NU4+ibfjIZo+RuYtw0t1MwCO2lr0u70k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963307; c=relaxed/simple;
	bh=SyH7bQOz04FodkQQTANTF2oZZhi5hGdrWhRy8qbAXE8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q2ym0Jhll9kfulRlr3SQLxs78/3HfNvSLRGdwUozJKPVqnyzWI5Xl6uv0/LjZAldYJ9k6HYoe4v7+5rOfhgCGECPehs9HYYzZbhIG8PDexhiLSporvolLFLmJir5NoTVrIEBNOoRUisVhwjeTfqFTe5OmaP7+BviRWwltfsaroA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVvS7FI1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVvS7FI1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840EE1F00A3D;
	Wed,  9 Sep 2026 14:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963305;
	bh=jNfYFc8k44s2zzCR+FaU9ay9RmzvPNSh0vdyx0/JWAM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EVvS7FI1ZuHjnAh7G6CgVqGZHvS4XTQCGeSJwj+YkDiORHzHcFOXIVI1YhqIQZ6LA
	 yd9XTYvuAWSSgS2FCOPYQsENXdy2JtAlrf+/2EXsIekftMoI99Q0RrEinBiZhaqIN3
	 TZsUaZylV5AAXemD8j/fUAdhaSqOVE5aDc9g78Sy7ZAoYEV5rlWoi/XNvrmykp+l7j
	 jcIAyeCAr54tn82CeJsF6S6DJcg1KjVfifpaBWKM1rvikd5adYQpOs2YNnyHar8mmR
	 +lKVeF2I/jSmoxqPzV8cjnVjJvF3DaKgne4hT4ViK4sJJaUvrnbAZ9yAfFG4efkT9f
	 IWGacNn4OJG/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 08/15] mptcp: pm: userspace: fix address ID
 overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-8-df1de70348b6@kernel.org>
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
 <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-8-df1de70348b6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:15:05 +0000
Message-Id: <20260909141505.840EE1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect ID collision check permanently breaks ID allocation if a=
n entry with ID 0 exists.
--

commit 0ac6c6a2ecc7912387ac1b8203c8c6f77120a794
Author: Qing Luo <luoqing@kylinos.cn>
mptcp: pm: userspace: fix address ID overflow

This commit fixes an address ID overflow in the userspace PM when all
IDs (1-255) are exhausted. By returning -ENOSPC when the next available ID
exceeds the maximum, it prevents ID 0 from being incorrectly allocated.
The ID allocation check is also moved before memory allocation to simplify
the error path.

> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index b94fbb483bf94..fab16d953dbfe 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -69,6 +69,19 @@ static int mptcp_userspace_pm_append_new_local_addr(st=
ruct mptcp_sock *msk,
>  	}
> =20
>  	if (!addr_match && !id_match) {

[Severity: High]
This isn't a bug introduced by this patch, but does the loop preceding this
block permanently break ID allocation if an entry with ID 0 exists?

If needs_id is true and no address match is found, entry->addr.id remains 0.
The check in the loop:

    id_match =3D (e->addr.id =3D=3D entry->addr.id);
    if (addr_match || id_match)
        break;

evaluates to true if an existing entry has ID 0. This breaks the loop early
and causes the function to return -EINVAL instead of allocating a new ID.

A privileged user (CAP_NET_ADMIN) can configure the userspace PM to create a
subflow using the initial connection address (omitting the ID or specifying
ID 0) via mptcp_pm_nl_subflow_create_doit(). This legitimately adds an entry
with ID 0 to the userspace_pm_local_addr_list. Later, when an event requires
a new implicit ID allocation (e.g., calling
mptcp_userspace_pm_get_local_id()), needs_id is true and entry->addr.id is
initially 0.

Could this incorrectly match the unassigned ID against the existing entry
with ID 0, permanently breaking MPTCP connection management for the socket?

> +		unsigned int id;
> +
> +		if (!entry->addr.id && needs_id) {
> +			id =3D find_next_zero_bit(id_bitmap,
> +						MPTCP_PM_MAX_ADDR_ID + 1, 1);
> +			if (id > MPTCP_PM_MAX_ADDR_ID) {
> +				ret =3D -ENOSPC;
> +				goto append_err;
> +			}
> +		} else {
> +			id =3D entry->addr.id;
> +		}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-net-mptcp-=
misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org?part=3D8
