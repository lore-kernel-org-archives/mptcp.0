Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6793EAC8D
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106651; cv=none; b=hBtTXQD98KTw9nrXkCxV428n5uLl7nUio6nKJxHLsdOvIm8jObXviVpgRj1XRBckJqWsP7+lPXhYUAROkPTcFA4+7/JTTtJZ2WF4D1LpKgiIfAOXclIR6VO2bl86xkir4nUXoK5eIyQcO9frRDyyO5VN3XZBauYgSVE0lClrUrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106651; c=relaxed/simple;
	bh=lNZ1tXevChR/fXraUXtc28rwdMRlzq9sUfmPJaVa48c=;
	h=MIME-Version:Content-Type:Subject:From:To:In-Reply-To:References:
	 Date:Message-Id; b=OLuJYWcInFkDI5FR6b/L/tCBtlxpb92LxyrEwm34caJR2NqXPTtET+raPoUN94n9fsvmP84rml8fL7Mb3AjiXn2W5pARsuYiuhXoJa4SGZBCSWXOvJb9HZV5GcWJb3spkRBeCtswZubnC+tpIvi2fuOYMRxFH3/93tSyaa24K3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fm3JMqPk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fm3JMqPk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF761F000E9
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 09:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784106650;
	bh=pu0QXfqek9Hm19ZwJI3isEn0oa7pVRi3TSqpIeFTS2s=;
	h=Subject:From:To:In-Reply-To:References:Date;
	b=Fm3JMqPkvLpcHfUN3gcS4ordYJv44G71pfNRScY4fIO+tifhiPc+Eqm3Jrx98yWJZ
	 Kf0gDOvuTYtGRrVU1V2ddC17PbjhPuSWZH+Bw79Yc/299CmCAvYPD3/CT5j9bPLfSF
	 m3wUwK70HrpF4DNr1/Sk998Z/9/ZZS8nEAXmYUV1DxaEESy2NEG51mmIrXjJ+x70E2
	 w/laq7j2tHc5d2aWzIXg3916U5+Lu1KTpqU3rAAmqSboXyRiH5FLqCl9uEu5izZRWz
	 3c+4QUC02bUDIJr8xqfTV0GWpLtXpmRpmZE3FTiIpDRqF5Zc1RfYOZMRZyhIkIY8Al
	 LppM5QGQOgxtw==
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mptcp: pm: Fix address ID overflow when all IDs are
 exhausted
From: Matthieu Baerts <matttbe@kernel.org>
To: mptcp@lists.linux.dev
In-Reply-To: <20260714080356.805839-1-l1138897701@163.com>
References: <20260714080356.805839-1-l1138897701@163.com>
Date: Wed, 15 Jul 2026 11:10:43 +0200
Message-Id: <178410664361.3802972.16804879942885801851.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3305; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lNZ1tXevChR/fXraUXtc28rwdMRlzq9sUfmPJaVa48c=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLC/WYee3qmktfPXXhTeQvbkQRp3p2dN3cvOb7wTaXHu
 cUiPKsXd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEyEzYDhf4o+v8XPMp0l59NC
 K+ONc32jxNXLVyVrMcxhnBglF7OAh+EXU03M1S/H5jrI+fRtC6vJ/bNf9NFkl3Urzt99+i1DeNI
 uRgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Hi,

Thank you for this patch. Here is a very quick review done in between
tasks.

(-people who were in Cc: no need to add them when sending only to the
MPTCP ML.)

Also, please use a prefix: mptcp-net for fixes, mptcp-next for features.

The CI reported a few issues at build time, please check that.

> When all MPTCP address IDs (1-255) are exhausted, find_next_zero_bit()
> returns MPTCP_PM_MAX_ADDR_ID + 1 (256). This value overflows when stored
> in the u8 field e->addr.id, resulting in ID 0 being stored.

Are you sure? With the in-kernel PM? Do you have a reproducer?

> ID 0 has special meaning in MPTCP (it's reserved for the initial connection),
> so this overflow can cause confusion and incorrect behavior, including
> unintentional ID 0 reuse or address conflicts.

A fix should have a Fixes tag, please add one.

Also, if you were assisted by a tool, please add the Assisted-by tag.

> Signed-off-by: luoqing <luoqing@kylinos.cn>

For "legal" reasons, you are supposed to put your full name. Having only
one "word" for your full name, without capital letters looks wrong, no?

>
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 331f6fa99014..1bd81c94b971 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -795,9 +795,14 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
>
>  	if (!entry->addr.id) {
>  find_next:
> -		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
> -						    MPTCP_PM_MAX_ADDR_ID + 1,
> -						    pernet->next_id);
> +		unsigned int id = find_next_zero_bit(pernet->id_bitmap,
> +						     MPTCP_PM_MAX_ADDR_ID + 1,
> +						     pernet->next_id);
> +		if (id > MPTCP_PM_MAX_ADDR_ID) {
> +			ret = -ENOSPC;
> +			goto out;
> +		}
> +		entry->addr.id = id;
>  		if (!entry->addr.id && pernet->next_id != 1) {

The overflow is a normal case: find_next_zero_bit() will find the next
zero bit from next_id. If there it didn't find any, this block here
restart find_next_zero_bit() but from the beginning.

>  			pernet->next_id = 1;
>  			goto find_next;
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index ad6ba658e5a5..0a1e835ae049 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -74,10 +74,17 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>  			goto append_err;
>  		}
>
> -		if (!e->addr.id && needs_id)
> -			e->addr.id = find_next_zero_bit(id_bitmap,

Do you need to change this line? In case of error, 'e' is dropped.

> -							MPTCP_PM_MAX_ADDR_ID + 1,
> -							1);
> +		if (!e->addr.id && needs_id) {
> +			unsigned int id = find_next_zero_bit(id_bitmap,
> +							     MPTCP_PM_MAX_ADDR_ID + 1,
> +							     1);
> +			if (id > MPTCP_PM_MAX_ADDR_ID) {
> +				sock_kfree_s(sk, e, sizeof(*e));
> +				ret = -ENOSPC;
> +				goto append_err;
> +			}
> +			e->addr.id = id;

I didn't check the code, but here, it looks like such check is needed.
But please, provide a test reproducing the issue, e.g. by adding a test
in userspace_pm.sh. (Be careful that such test should also run on older
kernels where the limits are lower, see what is done in pm_netlink.sh)

-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>
