Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2A37C929
	for <mptcp@lists.linux.dev>; Fri, 17 Jul 2026 04:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784262554; cv=none; b=frKpSjTFaN69Z01ULTqmPHh6FPSmgbpQL7Tx8gswZO/BzW74gH6a5cDOhyOCiubHQfRhQ6jr3b4d5NKOdIjy9efIWaXOSa6RYyeAe3JTTgNAaNYSL/9JfbqiEICQ8bOGOve2pYtDBd7JrXcyG7FZOx4Grq7J3/nXBWvsskfo2ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784262554; c=relaxed/simple;
	bh=Yk7P5CLJpmD+tktqd143LsZExhWR854MnFjsTY3nKXk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=sOIupYbGOsqvC+6pbBrth8jjc9Wg5cxedXY/hBBZwf6VIv0zBxD8CMTo8LerunKqlAWQK2YWGWkqgonGAdUMdYNyyUYG2IwAsbmYXF0PEd2/zwSO6kLbA4RR/macE1s5MAeXL73IttzNS1UxT8LLbGPhEW1XXSW/ip2dCnqY6A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FCvisuis; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FCvisuis"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784262551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pTUpRrrhfo8PM067cQugZZNcuL1AbvXr2cMDeVvXD8Q=;
	b=FCvisuisBicnuKZsBfu7fr7ceh+T1CPckXtK8OFH4TkWCSv4abEhWNuZkbi2l8tngn68sW
	2phpjOhRsMU1BOEFGQ6W3BIelCdyhU1NuwBXQWu07osai0VkS1ABV76uHgQjH9B5kgkSez
	Qe852JSVV34mNfsuwBI9oJg3ekeR8Dk=
Date: Fri, 17 Jul 2026 04:29:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <fb5a37e794fc4753e1ea17a69bfbc2797d99af9f@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] mptcp: pm: fix data race in add_addr timer callback
To: "luoqing" <l1138897701@163.com>, mptcp@lists.linux.dev
In-Reply-To: <20260715060550.655299-1-l1138897701@163.com>
References: <20260715060550.655299-1-l1138897701@163.com>
X-Migadu-Flow: FLOW_OUT

July 15, 2026 at 2:05 PM, "luoqing" <l1138897701@163.com mailto:l11388977=
01@163.com?to=3D%22luoqing%22%20%3Cl1138897701%40163.com%3E > wrote:

Hi luoqin,

Thanks for your patch.

>=20
>=20From: luoqing <luoqing@kylinos.cn>
>=20
>=20The timer callback reads entry->retrans_times outside pm.lock to deci=
de
> whether to call mptcp_pm_subflow_established(). Since
> mptcp_pm_announced_del_timer() can concurrently set retrans_times =3D
> ADD_ADDR_RETRANS_MAX under pm.lock, a race condition exists.
>=20

@Matt,@geliang.=20AFAIK, this could happen when ADD_ADDR is echoed by the=
 peer,
and at the same time the timer is woke up. 'mptcp_pm_add_addr_echoed' wil=
l call
'mptcp_pm_announced_del_timer' and set 'retrans_times' as 'ADD_ADDR_RETRA=
NS_MAX',
but the timer callback then reads entry->retrans_times outside of pm.lock=
.

> Use a local 'schedule_work' flag set inside pm.lock only when the timer
> callback itself increments retrans_times to ADD_ADDR_RETRANS_MAX. This
> ensures that mptcp_pm_subflow_established() is only called when the
> retransmission naturally exhausts.
>=20
>=20Additionally, use READ_ONCE/WRITE_ONCE for retrans_times and timer_do=
ne
> to prevent compiler optimizations.

@luo
'timer_done' is not fixed in your code, and 'schedule_work' is not seen
either, do you mean 'completed'?  Please make sure the commit message
matches the code.
>=20
>=20Signed-off-by: luoqing <luoqing@kylinos.cn>
> ---
>  net/mptcp/pm.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
>=20diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 6afd39aea110..4c039e7843d3 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -380,6 +380,8 @@ static void mptcp_pm_add_addr_timer(struct timer_li=
st *timer)
>  struct mptcp_sock *msk =3D entry->sock;
>  struct sock *sk =3D (struct sock *)msk;
>  unsigned int timeout =3D 0;
> + bool completed =3D false;
> + u8 retrans_times;
>=20=20
>=20 pr_debug("msk=3D%p\n", msk);
>=20=20
>=20@@ -399,27 +401,33 @@ static void mptcp_pm_add_addr_timer(struct time=
r_list *timer)
>=20=20
>=20 spin_lock_bh(&msk->pm.lock);
>=20=20
>=20+ retrans_times =3D READ_ONCE(entry->retrans_times);
> +
>  /* The cancel path (mptcp_pm_announced_del_timer()) can race with this
>  * callback. Once cancel updates retrans_times to MAX, suppress further
>  * retransmissions here. If this callback acquires pm.lock first, one
>  * final transmit attempt is still possible.
>  */

Maybe just drop the comments here, I don't think it is worth explaining
separately.

> - if (entry->retrans_times < ADD_ADDR_RETRANS_MAX &&
> + if (retrans_times < ADD_ADDR_RETRANS_MAX &&
>  !mptcp_pm_should_add_signal_addr(msk)) {
>  pr_debug("retransmit ADD_ADDR id=3D%d\n", entry->addr.id);
>  mptcp_pm_announce_addr(msk, &entry->addr, false);
>  mptcp_pm_add_addr_send_ack(msk);
> - entry->retrans_times++;
> + retrans_times++;
> + WRITE_ONCE(entry->retrans_times, retrans_times);
>  }
>=20=20
>=20- if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
> + if (retrans_times >=3D ADD_ADDR_RETRANS_MAX)
> + completed =3D true;
> +
> + if (retrans_times < ADD_ADDR_RETRANS_MAX)
>  timeout <<=3D entry->retrans_times;
>  else
>  timeout =3D 0;

These two if branch could be combined into one, like:

'''
if (retrans_times < ADD_ADDR_RETRANS_MAX)
        timeout <<=3D entry->retrans_times;
else {
        timeout =3D 0;
        completed =3D true;
}
'''
Note: this snippet is untested =E2=80=94 please double-check the coding s=
tyle
and make sure it compiles before submitting.

Thanks
Gang
>=20=20
>=20 spin_unlock_bh(&msk->pm.lock);
>=20=20
>=20- if (entry->retrans_times =3D=3D ADD_ADDR_RETRANS_MAX)
> + if (completed)
>  mptcp_pm_subflow_established(msk);
>=20=20
>=20 out:
> --=20
>=202.25.1
>
