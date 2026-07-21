Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040801E0E14
	for <mptcp@lists.linux.dev>; Tue, 21 Jul 2026 02:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784602174; cv=none; b=rl5T1KmDFy/l9eEtFMTFEmyiWAHE5aborxZtGyo/V5CDtyjVhcgZlU8yf9GG6g0XxyzCuhTrZJmbEXfUZXvOsnkrdbDNl1tD+rrGDccVqJ4dNeTVF7NCpobLXcDZ0mFSxCMosT0cF2i7B7tVIFgW5yj+Fx7qRTj/pCn8p6yoEoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784602174; c=relaxed/simple;
	bh=m4ksK9zxSlp7J+mRxbPkEYb+cx6tEJBazpyEM7KT62s=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=B5wfdIfJ+F5ihvdcw7gNOdagzJwZyUQ76rWLe/V8cEgN942swrZ4I0NENMGkOtwHWVlOhpH2OzVKPLpeAYTbEL7T0FDBdBvzte/s36zxcA1OMmZVyw2jbegJbUZ8q3O/MqbITPoWmrnr7/9XdRBUEtx245dfLDCJ5FZL8aMM/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S9Vga66H; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S9Vga66H"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784602170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlFT490BzJWVBKvKf1xCUOH6eWOWHbnFj9C9hkYfuJ8=;
	b=S9Vga66HtAziUTA1eWi7m0tQvoEC/1k7DqSh/HjSVPcwEdD4YMkHCRb/tdbcfOnLcDmZzN
	Ly5Q9PTKwvBXZ/p4FErnO7xtv6bV9Db2ODwkA3NxHPGtlvTvsmKzqDuc5Ba7GsFUkyX2g7
	LdKi8SRDqfTgdNz8Iw/oajiuas6Duuc=
Date: Tue, 21 Jul 2026 02:49:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <960e57f4f9a7a3c73ac7f1216ff38c77b0d38ea1@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-net v2] mptcp: pm: fix data race in add_addr timer
 callback
To: "luoqing" <l1138897701@163.com>, mptcp@lists.linux.dev
In-Reply-To: <20260717064028.767876-1-l1138897701@163.com>
References: <20260717064028.767876-1-l1138897701@163.com>
X-Migadu-Flow: FLOW_OUT

July 17, 2026 at 2:40 PM, "luoqing" <l1138897701@163.com mailto:l11388977=
01@163.com?to=3D%22luoqing%22%20%3Cl1138897701%40163.com%3E > wrote:


>=20
>=20From: luoqing <luoqing@kylinos.cn>
>=20
>=20The timer callback reads entry->retrans_times outside pm.lock to deci=
de
> whether to call mptcp_pm_subflow_established(). Since
> mptcp_pm_announced_del_timer() can concurrently set retrans_times =3D
> ADD_ADDR_RETRANS_MAX under pm.lock, a race condition exists.
>=20
>=20Use a local 'completed' flag set inside pm.lock only when the timer
> callback itself increments retrans_times to ADD_ADDR_RETRANS_MAX. This
> ensures that mptcp_pm_subflow_established() is only called when the
> retransmission naturally exhausts.
>=20
>=20Signed-off-by: luoqing <luoqing@kylinos.cn>
> ---
>  net/mptcp/pm.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>=20
>=20diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 6afd39aea110..ed39a1241ffd 100644
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
>=20@@ -399,27 +401,32 @@ static void mptcp_pm_add_addr_timer(struct time=
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
> - timeout <<=3D entry->retrans_times;
> - else
> + if (retrans_times < ADD_ADDR_RETRANS_MAX)
> + timeout <<=3D retrans_times;
> + else {
>  timeout =3D 0;
> + completed =3D true;
> + }
Hi,=20

'checkpatch'=20has reported a 'checks' for this:

'''
CHECK: braces {} should be used on all arms of this statement
#60: FILE: net/mptcp/pm.c:420:
'''

But I think a v3 is not necessary for such a minor change. The patch
itself looks good to me=EF=BC=81

It's okay to wait for other reviewers' feedback.

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
