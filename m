Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582F377EB0
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 07:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780039122; cv=pass; b=Un7Qw/HS/VvV69p53KSzTkByWrmWPYR0+Bta0Q8i9kXR3FFkG+Pdj+RSpkEVW+R49vD7+lVlfyAoD71Vvl8b/BSMm0ZonUkXDEX15IiGPZ4XxZYW8iI3Lhz49K9oDAmtawyrcyJ5zPL0Zo7Sb+y/20IAkZgNfPk2pqbhs0z0HEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780039122; c=relaxed/simple;
	bh=stRBunXVUuS2fiHGPSWYRYzVsmpnwQL+MyP5V3anBcw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=eAciUNinj8VzSj5Q5SwL7JBMld2+aokld3++xOHLyihdD3mAnMnydDR/9BbGoig195+PqQ78Cbr5Crt1ML7md/QeW/kLO30o7R9ia/AC3lUYFW3zhOsBGBVa2WWU5UjBA+OOcpP1lEWYQ52xTeDlS86EvMd/yKXHhlgkb2YmX7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=c4zqE0yU reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="c4zqE0yU"
ARC-Seal: i=1; a=rsa-sha256; t=1780039115; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lvWPPTV95Acrmago/UZwBQKzBTrU8qxVeXe9Ghrg++pJuUbzT6ljOWFOm8I1/0YyxT+ymhHPLQC9Hdmyr+LNI5w7r8sj2lqSn/nnoYKHHryjtlN35nm9DOJgkhp3R2XMs7jCl9MWMy9MPp1kwMAWQ6d2Z7Mt+8fkAkuQS8X4ntA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780039115; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VsO4SFNR5XYcb/bPKAaWdaNj1pWFV5YRFbsclxB1pHc=; 
	b=FNa3yVOtc1FuiKz4TSv8w35wJWuGmHQ1Ec69Lfg7OTcAtStpbElmsJzH22h5wwasHPMG6E9wVHoDDxGeh46MYUFTjtd/jjfiDx9tob71krAI3V26484iEIZT4cBcklGFvcnOQNwTs4Q+V5+7t70/m/CoWH2mTGFbD9yKJhy25H8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780039115;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=VsO4SFNR5XYcb/bPKAaWdaNj1pWFV5YRFbsclxB1pHc=;
	b=c4zqE0yUb0aBdglOi+pWa6+3zQ19ijh4I4td8GuVzZy05+J42ku291yZ1QOrJJvk
	UavPvnBolofgqG7hZpgLJCB4Utsw81oJKlQAw+IBxvzNUciwfpiVYQgP8mth3gHQ33W
	oEH8fd561Rc/o6WnOPYZ+6KAWSeIzfNVo9Dh/uM8=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1780039114189246.88161816937145; Fri, 29 May 2026 00:18:34 -0700 (PDT)
Date: Fri, 29 May 2026 12:48:34 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>, "martineau" <martineau@kernel.org>,
	"pabeni" <pabeni@redhat.com>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>,
	"shardulsb08" <shardulsb08@gmail.com>, "syzbot+55c2a5c871441261ed14"
 <syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com>
Message-ID: <19e72995d6d.89137929840232.7611532549298755137@mpiricsoftware.com>
In-Reply-To: <0f13954f-3bfa-4630-af9f-6f1f4b138a13@kernel.org>
References: <20260529064355.922763-1-kalpan.jani@mpiricsoftware.com> <0f13954f-3bfa-4630-af9f-6f1f4b138a13@kernel.org>
Subject: Re: [PATCH net v2] mptcp: pm: drop pending ADD_ADDR when removing
 id 0 endpoint
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Matt,

> Did it work with packetdrill?

I worked on a packetdrill test based on add_addr4_server.pkt with the
MP_JOIN extra subflow and the delete/re-add sequence. The environment
is working (add_addr4_server.pkt passes cleanly), but I was not able
to reliably trigger the WARN through packetdrill within the test
timeframe.

The difficulty is that the id 0 ADD_ADDR is only sent when the
endpoint is re-added after the connection is established AND after
mptcp_nl_remove_id_zero_address() has run to restore the
id_avail_bitmap bit via __mark_subflow_endp_available(). Getting
packetdrill to control this timing precisely =E2=80=94 while also keeping
conn_list non-empty so mptcp_nl_remove_id_zero_address() actually
processes the msk =E2=80=94 proved tricky.

syzbot is reproducing the bug reliably on current upstream (3 crashes
between 2026/05/19 and 2026/05/22 on kernels including cca95436be15).
The syzbot reproducer is the most reliable pre-fix evidence available.

I will continue working on the packetdrill test and send it as a
follow-up once I have a clean before/after result. For v3 I have
addressed your comment shortening request.

Thanks,
Kalpan Jani


From: Matthieu Baerts <matttbe@kernel.org>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>
Cc: <mptcp@lists.linux.dev>, <martineau@kernel.org>, <pabeni@redhat.com>, <=
shardul.b@mpiricsoftware.com>, <janak@mpiric.us>, <kalpanjani009@gmail.com>=
, <shardulsb08@gmail.com>, <syzbot+55c2a5c871441261ed14@syzkaller.appspotma=
il.com>
Date: Fri, 29 May 2026 12:25:09 +0530
Subject: Re: [PATCH net v2] mptcp: pm: drop pending ADD_ADDR when removing =
id 0 endpoint

 > Hi Kalpan,
 >=20
 > Thank you for the v2.
 >=20
 > 29 May 2026 16:44:12 Kalpan Jani <kalpan.jani@mpiricsoftware.com>:
 >=20
 > > syzkaller hit the WARN_ON_ONCE() in mptcp_pm_alloc_anno_list() with
 > > the in-kernel path manager.
 > >
 > > When a signal endpoint is removed, the pending ADD_ADDR has to be
 > > cancelled: its retransmit timer stopped and the anno_list entry
 > > unlinked and freed. For a non-zero id endpoint this is done via
 > > mptcp_nl_remove_subflow_and_signal_addr() ->
 > > mptcp_pm_remove_anno_addr() -> mptcp_remove_anno_list_by_saddr().
 > >
 > > The id 0 removal path, mptcp_nl_remove_id_zero_address(), does not do
 > > this: it only queues a RM_ADDR and marks the id available again, but
 > > leaves any pending anno_list entry and its armed retransmit timer
 > > alive.
 > >
 > > So when the id 0 endpoint is removed and re-added while its previously
 > > sent ADD_ADDR is still awaiting the echo, the stale entry survives.
 > > The kernel PM reselects id 0, reaches mptcp_pm_alloc_anno_list() a
 > > second time, finds the stale entry and hits the WARN.
 > >
 > > Make the id 0 removal path symmetric with the non-zero one: drop the
 > > pending ADD_ADDR before queuing the RM_ADDR, and decrement
 > > add_addr_signaled if the address had been announced. This closes the
 > > race at its source, so the WARN_ON_ONCE() stays a valid assertion.
 > >
 > > Fixes: 740d798e8767 ("mptcp: remove id 0 address")
 > > Reported-by: syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com
 > > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/620
 > > Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
 > > ---
 > >
 > > v1 -> v2:
 > > - Do not drop the WARN_ON_ONCE(); it is a valid assertion.
 > >    (Matthieu Baerts)
 > > - Fix mptcp_nl_remove_id_zero_address() to tear down the pending
 > >    ADD_ADDR entry: call mptcp_remove_anno_list_by_saddr() and
 > >    decrement add_addr_signaled, mirroring the non-zero id path.
 > >    (Matthieu Baerts)
 > >  =20
 > > net/mptcp/pm_kernel.c | 10 ++++++++++
 > > 1 file changed, 10 insertions(+)
 > >
 > > diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
 > > index fc818b63752e..ed0ad1c1b140 100644
 > > --- a/net/mptcp/pm_kernel.c
 > > +++ b/net/mptcp/pm_kernel.c
 > > @@ -1126,6 +1126,7 @@ static int mptcp_nl_remove_id_zero_address(struc=
t net *net,
 > >     while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D =
NULL) {
 > >         struct sock *sk =3D (struct sock *)msk;
 > >         struct mptcp_addr_info msk_local;
 > > +       bool announced;
 > >
 > >         if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
 > >             goto next;
 > > @@ -1135,7 +1136,16 @@ static int mptcp_nl_remove_id_zero_address(stru=
ct net *net,
 > >             goto next;
 > >
 > >         lock_sock(sk);
 > > +       /* Drop a possibly pending ADD_ADDR for this address: stop its
 > > +        * retransmit timer and unlink the anno_list entry, so a later
 > > +        * re-add cannot find a stale entry and hit the WARN_ON_ONCE()
 > > +        * in mptcp_pm_alloc_anno_list(). Mirrors the non-zero id path
 > > +        * in mptcp_pm_remove_anno_addr().
 > > +        */
 >=20
 > I'm not sure such a long comment in the code is that useful, and it
 > might: it can quickly become outdated when other parts are modified.
 > Limit it to the first line, the rest can be seen in the commit message.
 >=20
 > > +       announced =3D mptcp_remove_anno_list_by_saddr(msk, &msk_local)=
;
 > >         spin_lock_bh(&msk->pm.lock);
 > > +       if (announced)
 > > +           msk->pm.add_addr_signaled--;
 >=20
 > It would be good to check this counter on the test/reproducer you will
 > provide. Did it work with packetdrill?
 >=20
 > Cheers,
 > Matt
 >=20
 > >         mptcp_pm_remove_addr(msk, &list);
 > >         mptcp_pm_rm_subflow(msk, &list);
 > >         __mark_subflow_endp_available(msk, 0);
 > > --
 > > 2.43.0
 >=20
 >=20

