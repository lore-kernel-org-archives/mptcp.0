Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28D72C11DE
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145126; cv=none; b=qD/mJOqBq668ElTo/r9d7nqUfG/1C8EqpT4VIPv6A96TbzstVbtgU1f0GbiZr2sQuY5Cm/QWRhsMuAYifU/V1PZ1ma/VOv0Y6+UzqKyBxmr1D9HqgOo8pWojfB0Rs5DVQKnBHda7z29Uvsi7d6vAeid4ma4bHXRmGWAy8BbI9XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145126; c=relaxed/simple;
	bh=Uh1KipazODjV+MaDfAyuoI06IB+jH34D9p5G0+QoRMg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Px4ga9Wt/cA6DyShznujArwT1GhKeZqMNKyC90dfexhoIPxqU9tX0ISUej93BBfRj6/x5nPLR4MwQwM2RSjzJB1BbFlrQJ61iDJYMLOgHZrp4BvTMmHWo3ydyfXaI3k3uH1vrz5RnPwvGxzCbjGdWNWMawaiCH/eM/WTOKhK+BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVyJo5CD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVyJo5CD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0201F000E9;
	Wed, 19 Aug 2026 13:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787145125;
	bh=pfQyE9cDVaPb346FSVRuHUl8YKCnuwkh8JuCpFBu4FY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eVyJo5CDxfcESs+WblUzYCGwdAjiOyHmyH5AhOaQkDpJkUQZ50SV2oQuLd76fZsxZ
	 Utledhnpg427np5JnMClcR7Rn9//jv6yiXdDDJm8mgr3TDVdbiPQZ7P/x9lsG65Yk1
	 6S+FMirou9whoOa81mR8OIBi4Dsx+8ERqOnB1tLtSzxaTEPLcmRQxrmRVf8mqy6KXe
	 MUu1bBjSqq3omGMQfdfNVS3JayXXWfuasS5L23uPMbFVmPhOVwtSg0LgntUIeGiP+S
	 gLQB6j/lAwe4i6DDR5KqCX81oy+CZWWz+1uBgn5jHz9VxTEa5KzrYd67J9eeCPE8FA
	 F9nN0K2c08X2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v3 5/5] Squash to "mptcp: pm: init and
 release mptcp_pm_ops"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gang Yan" <gang.yan@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260819125629.49823-6-gang.yan@linux.dev>
References: <20260819125629.49823-1-gang.yan@linux.dev>
 <20260819125629.49823-6-gang.yan@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 13:12:04 +0000
Message-Id: <20260819131205.3A0201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] msk->pm.ops is accessed concurrently without the socket lock o=
r RCU protection during MP_JOIN processing, which can race with mptcp_disco=
nnect() leading to a NULL pointer dereference or execution of freed module =
code.
--

--- Patch [5]: [PATCH mptcp-next v3 5/5] Squash to "mptcp: pm: init and rel=
ease mptcp_pm_ops" ---
commit f7c7fb9e99182263f4dea26b6331ed438faaf974
Author: Gang Yan <yangang@kylinos.cn>

Squash to "mptcp: pm: init and release mptcp_pm_ops"

This commit introduces the mptcp_pm_ops lifetime handling on sockets
(mptcp_pm_ops_init/release taking a module reference), and would then
be the first one whose per-net path managers can be unloaded while a
pernet still stores them.

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 69a38cb48977a..64244a1a01bca 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -1155,13 +1155,11 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
>  	spin_unlock_bh(&msk->pm.lock);
>  }
> =20
> -static void mptcp_pm_ops_init(struct mptcp_sock *msk, const char *pm_nam=
e)
> +static void mptcp_pm_ops_init(struct mptcp_sock *msk,
> +			      struct mptcp_pm_ops *pm_ops)
>  {

[Severity: Critical]
Since this series introduces mptcp_pm_ops lifetime handling and module
references, is there a race condition with concurrent MP_JOIN requests?

When an incoming MP_JOIN request is processed in softirq context,
subflow_token_join_request() gets the socket via mptcp_token_get_sock(),
which doesn't hold lock_sock() or RCU. It then calls:

net/mptcp/pm.c:mptcp_pm_get_local_id() {
    ...
    return msk->pm.ops->get_local_id(msk, &skc_local);
}

Concurrently, if a local user closes the socket and triggers
mptcp_disconnect(msk), it calls mptcp_pm_ops_release() which clears the ops
and drops the module reference:

net/mptcp/pm.c:mptcp_pm_ops_release() {
    ...
    msk->pm.ops =3D NULL;
    ...
    bpf_module_put(pm_ops, pm_ops->owner);
}

Could this lead to a NULL pointer dereference or executing freed module code
if subflow_token_join_request() executes concurrently with a socket
disconnect?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819125629.4982=
3-1-gang.yan@linux.dev?part=3D5
