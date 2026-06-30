Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612413EB10C
	for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813820; cv=none; b=uR3kGXpApLcMXhKoD9BWgnT9JC+xjmoSa6latybgaT/gDlFu6+w5FEjFH97MY+xek1CXLV7RX0l71ZseehYweuxjrrowq5Qy6HxWPpsaJvYFqo87iBcGlm+h6wb4lx7zWwyzIlToaSWsOpkGh2i+N/j38RTYVs0yd2GH0tpDyB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813820; c=relaxed/simple;
	bh=shx2ZsB7MWaf320RX5wPu/pqKEBTxibWTOoMH29Towg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=rgBaXhi37b3HDGgOKmXuioh+OGOrUOXdbovucUA/p362P0rVBSMndvJ1rcVVjSj83uejLC7mm+rV2xj2NY4Pd++6B6mPbQU/DhQVTDZr+K/q1KJMUmijLQSRFJ1K40PCZEke6TWGllVOAMFrRMYZVjXl/q0O45Oza1CW/NWZqHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE59Bzoc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE59Bzoc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B011F000E9;
	Tue, 30 Jun 2026 10:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782813819;
	bh=obl11VwKSNczYOuu7T1ZHZAnmuppJc3Zqlwh/j1vkzM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=NE59BzocapGsT5YW4O8PkVhcKiQ+6SnVxqq1tGDTjAFSNFHMUEzS1UJXjOMYVdO/W
	 icWLhXH88GW4hyCuymENj1kR90dVQzpsyWkA3eitfhgCXVNYuJLv+OxFKtxPjALqSy
	 V+ebMtuAyK1rO5BvscMqFalHkoh7N3+8q+B+qzE5vOobjg1nHXF1m4t2c4lY/pjD4O
	 R5DZDlX39PZTdpw/yu5l7W/axa59EoT8tAiz25L3pgHpXGP00DZdG6Cnge5+O9K3Bg
	 xBIej1hTsc45WXdgAJUpLqRuPotEhGgAYy0U8Ys0+PRkvX76+2z5P3ZNi8dM2u7iNd
	 XYsKx0zkXFdDA==
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH mptcp-net] mptcp: pm: fix potential NULL deref in
 mptcp_pm_ops_init
From: Matthieu Baerts <matttbe@kernel.org>
To: Gang Yan <gang.yan@linux.dev>
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, geliang@kernel.org, 
 Gang Yan <yangang@kylinos.cn>
In-Reply-To: <20260630074237.166076-1-gang.yan@linux.dev>
References: <20260630074237.166076-1-gang.yan@linux.dev>
Date: Tue, 30 Jun 2026 12:03:32 +0200
Message-Id: <178281381226.2443439.7039436641916395928.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1633; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=shx2ZsB7MWaf320RX5wPu/pqKEBTxibWTOoMH29Towg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKcp1SqRHs6mea5S+o17lvu9E9A1q795EmlFTn+C9Z1/
 RdSyXvbUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJHrJYwMZ1OPhfx4nKF2eOvh
 W5zcQpJdUisWr/x89bbahtYFOgrRbIwMe5lWcezwFDjhp/n2l96CiZ3f1c/nSNfGllosNb/Glur
 MBgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Hi Gang,

Thank you for looking at that.

> mptcp_pm_find will return NULL when the PM is not registered. In that
> case, mptcp_pm_ops_init will make it fallback to kernel_pm, and the
> pr_warn_once will dereferences pm_ops->name.
>
> This patch uses 'UNKNOWN' in pr_war_once to avoid this issue when the
> pm_ops is NULL.

Patches for 'net' (c.f. 'mptcp-net' prefix) should have a Fixes tag. But
this patch modifies code that is only in our tree (introduced by "mptcp:
pm: init and release mptcp_pm_ops"). Can you then send a Squash-to patch
instead, please?

> Signed-off-by: Gang Yan <yangang@kylinos.cn>

About your note, I think it is fine to handle the case when pm_ops is
NULL here, as this code will be used when the BPF PM will be fully
introduced.

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 9dc7b41fb562..0ba6dd25ba49 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -1142,7 +1142,7 @@ static void mptcp_pm_ops_init(struct mptcp_sock *msk,
>  {
>  	if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
>  		pr_warn_once("pm %s fails, fallback to default pm",
> -			     pm_ops->name);
> +			     pm_ops ? pm_ops->name : "UNKNOWN");

Instead of this, I think it would be better to pass the PM name to this
function, and call mptcp_pm_find() from here. By doing that, you can
print the original string passed in argument, and no need to have this
fallback to UNKNOWN.

While at it, a fix in mptcp_pm_ops_release() is also needed, to move the
pr_debug() before calling bpf_module_put().

Cheers,
Matt

-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>
