Received: from mta1.migadu.com (out-88.mta1.migadu.com [95.215.58.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CFD43787E
	for <mptcp@lists.linux.dev>; Thu, 20 Aug 2026 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225999; cv=none; b=fxKkH5WBahxVSG+R7cVOrvRsOfwJevqDw77Pox2DFFxRoluoFWGW88cWaiPQCT/3DovUlC8Jk6DWHRAzGzaRs1TJkm0B9l1mfWfrSdHZejm5g+MWOeJe2csVX0in8H//rgQ5dZRJTQaP/eLqCDaMJ5XjXZlSRVVP7RQiMbT8TXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225999; c=relaxed/simple;
	bh=XgUM9o6Zq/LLT0rX37Kyg9hustz2xfaBZlUhnCnsET4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=HFFNh3Ep8gZEOnyE/mv3EB4o8YVKBgEh2S9Umjzmtx+HhFNmG4/kczz80wAWNC9yvid/sNO0Dntv4B4BdnpTTgcFLsaevSmSxycFTaOJICkAcPosevmVOYq3ZnVi/zHOZ4oneuXKSJJ4Ph/YVHTZ/V9WtgaTiRMNeWUv9p3cqwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XyJwAB2K; arc=none smtp.client-ip=95.215.58.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XyJwAB2K"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=XgUM9o6Zq/LLT0rX37Kyg9hustz2xfaBZlUhnCnsET4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787225995; v=1; x=1787830795;
 b=XyJwAB2K+Xx6pwWin+5JkbhB+QM6s5Pfl6qNW3WpTWkpjUOELnljtez3UUK3RjxdeLWF2Tc6
 myBOzpBWQsU5T4YJYWCn3hwYS98z0NrQbGjDWltaRnVRNh5lkhn2dpBBmASwYznaYkZZKKmpdoY
 OweEQ0AQYLYUnQtQbo6wjo0w=
X-Envelope-To: mptcp@lists.linux.dev
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by smtp.migadu.com with ESMTPS id b83911d820b83453;
	Thu, 20 Aug 2026 11:39:55 +0000
X-Mizu-Trace-ID: b83911d820b83453
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 11:39:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <c3edfdc0f060d384da46ca4ee20696118bd4a6f4@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next v3 5/5] Squash to "mptcp: pm: init and release
 mptcp_pm_ops"
To: "Matthieu Baerts" <matttbe@kernel.org>, sashiko-reviews@lists.linux.dev
Cc: mptcp@lists.linux.dev
In-Reply-To: <1e62d538-721f-486b-bb91-64864b3c5c8d@kernel.org>
References: <20260819125629.49823-1-gang.yan@linux.dev>
 <20260819125629.49823-6-gang.yan@linux.dev>
 <20260819131205.3A0201F000E9@smtp.kernel.org>
 <7b85c6e1e4e270bd368fb7dc6d24279c1c20c3b2@linux.dev>
 <f9fe2eb6-e9ef-42d0-8a24-8f5c550f0c78@kernel.org>
 <74e63e9935103e9fab16ea81e0ea7480f9c7d736@linux.dev>
 <1e62d538-721f-486b-bb91-64864b3c5c8d@kernel.org>

August 20, 2026 at 7:06 PM, "Matthieu Baerts" <matttbe@kernel.org mailto:=
matttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org=
%3E > wrote:


>=20
>=20On 20/08/2026 12:16, gang.yan@linux.dev wrote:
>=20
>=20>=20
>=20> August 20, 2026 at 5:07 PM, "Matthieu Baerts" <matttbe@kernel.org m=
ailto:matttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kern=
el.org%3E > wrote:
> >=20=20
>=20>=20
>=20> >=20
>=20> > Can you first check if this can happen? I thought that
> > >  mptcp_destroy_common would first close all subflows, remove the to=
ken,
> > >  then release everything linked to the PM =E2=86=92 so the PM will =
no longer be
> > >  called at that point for this msk, right? (I didn't check)
> > >=20
>=20>=20=20
>=20>  Hi Matt,
> >=20=20
>=20>  Thans for looking at this and kindly remind.
> >  Yes, I just checked the order you described is right, but I thought =
it
> >  could happen in such order:
> >=20=20
>=20>  CPU A (softirq) CPU B(disconnect)
> >  ->subflow_token_join_request=20
>=20>  ->mptcp_token_get_sock()
> >  ->mptcp_destroy_common()
> >  ->pm_ops_release
> >  ->mptcp_pm_get_local_id():
> >  msk->pm.ops->get_local_id() <- NULL deref
> >=20
>=20Ah yes, indeed, subflow_token_join_request doesn't hold the msk lock.
>=20
>=20>=20
>=20> WDYT? And, I think the window seems too narrow, we may not see it i=
n practice,
> >  maybe a NULL check is enough?
> >=20
>=20Would it be safe to have a NULL check? Could you have something like =
this?
>=20
>=20CPU A CPU B
> -> if (ops)
>  -> mptcp_destroy_common()
>  -> pm_ops_release()
> -> msk->pm.ops->get_local_id()
>=20
>=20The BPF module might have been unloaded.
Hi Matt

Yes, sorry for the silly mistake.

I=E2=80=99ll check if RCU can help us address this problem, and update th=
e patch.

Thanks
Gang

>=20
>=20(Again, I didn't check in details, only looking at your reply.)
>=20
>=20Cheers,
> Matt
> --=20
>=20Sponsored by the NGI0 Core fund.
>
