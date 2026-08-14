Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2237F377AB6
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786700150; cv=none; b=tcdi6Ot3+AufqXA/6VMMGtOCAjGs6clK8O+jSvqYj1gS/xbsRFij6YOlrf/BquyUxrAdbbh1pmdwwrrneUsz+oOHNtfWywJSh9KtTzD1ulVAmIF6Q8K+4evSNDstspFIB58l2pi4Pwhf/OWoUvTAcZofec4D3BZB+OhqC+YtwqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786700150; c=relaxed/simple;
	bh=oVK3gBHodAwrzp6+29E23gGAeqReFZvU1EPKNMAMHSE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=BgXTVLfCvHZGbK/GBH0blkMyzgmpiQoACHqsjz0fDqy7DwmXM14y/l4Ei0tRuFgtO7B0HbRxdqXaKc1x8/nw7x/Mt2opXcOK5lfVeEDTukoHz+uFTYiqDtNPljfLA+GdFewFw+nq8dcDQhiAlxzrLdvND7avzspMkGu44LxWbpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2NM7Ki/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2NM7Ki/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA6E1F000E9;
	Fri, 14 Aug 2026 09:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786700146;
	bh=oVK3gBHodAwrzp6+29E23gGAeqReFZvU1EPKNMAMHSE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=h2NM7Ki/KID2ozwmL7EhHhCTJduXyFKsxUF8IbLiD60fXy//AEjomgtzkqFC/7MyD
	 1wIUbSAmuzbm57y4Nw08xfkLCjqhxbuCar+iKuLfBnx34ncxVASXqOan/yJkFXkQNV
	 nB6+SksUL0lvQBedacVi78R6ud0qxQU0+FvchGD5aZ/jiiQYryX+z2Cq/wC8yjEx7H
	 8INK6jo4ZqhTxok3rRpgKsVaK4gghdi0Ko47SZH5VuZDOACOWpxfznB7GX0teEsMf1
	 18vSTjfhlUlQKiOsoZjn95ws6NE132oTTIl1O+SBSNOK+VWnycg4bDuvGbAQm+7puW
	 7kPAPesYMiQOA==
Date: Fri, 14 Aug 2026 11:35:39 +0200
From: Matthieu Baerts <matttbe@kernel.org>
To: gang.yan@linux.dev
Cc: mptcp@lists.linux.dev, Gang Yan <yangang@kylinos.cn>
Message-ID: <4b101a1c-7d53-44a7-b2c8-9ec74d5e52a0@kernel.org>
In-Reply-To: <42532178906ea8ce9bd4b8550144719356c69671@linux.dev>
References: <20260814050625.80231-1-gang.yan@linux.dev> <0ce89b909d078e40f8f560255ad44ae8e2cfff00@linux.dev> <90d727ed-9c4c-4107-a283-1e9a0245d09b@kernel.org> <42532178906ea8ce9bd4b8550144719356c69671@linux.dev>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: fix an UAF in
 mptcp_connect.c
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <4b101a1c-7d53-44a7-b2c8-9ec74d5e52a0@kernel.org>

14 Aug 2026 11:20:47 gang.yan@linux.dev:

> August 14, 2026 at 4:54 PM, "Matthieu Baerts" <matttbe@kernel.org mailto:=
matttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3=
E > wrote:
>
>
>
>>>
>> This assumes peer =3D=3D addr. It is certainly the case but it looks wro=
ng,
>> and I guess sashiko will complain like it did here.
>>
>> We could add something on the commit message to say that it is always an=
 IP address that is given, but maybe we should also just
>> handle that correctly: either peer here is not a pointer, and the conten=
t
>> is copied,
>
> I prefer this, because it is smaller, like:
>
> '''
> static int sock_connect_mptcp(const char * const remoteaddr,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char * const port, int proto,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct addrinfo **peer,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct sockaddr_storage *peer, socklen_t *peer_len=
,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int infd, struct wstate *winfo)
> {
> ...
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 *peer =3D a;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 break;
> ...
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 *peer =3D a;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 break;
> ...
> +=C2=A0=C2=A0 if (sock !=3D -1) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(peer, a->ai_addr, a->ai_addr=
len);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *peer_len =3D a->ai_addrlen;
> +=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0 freeaddrinfo(addr);
> ...
>
> -=C2=A0=C2=A0 struct addrinfo *peer =3D NULL;
> +=C2=A0=C2=A0 struct sockaddr_storage peer;
> +=C2=A0=C2=A0 socklen_t peer_len;
> ...
> -=C2=A0=C2=A0 fd =3D sock_connect_mptcp(..., &peer, fd_in, &winfo);
> +=C2=A0=C2=A0 fd =3D sock_connect_mptcp(..., &peer, &peer_len, fd_in, &wi=
nfo);
> ...
> -=C2=A0=C2=A0 if (connect(fd, peer->ai_addr, peer->ai_addrlen))
> +=C2=A0=C2=A0 if (connect(fd, (struct sockaddr *)&peer, peer_len))
> '''

It looks OK but there are some modifications a bit everywhere.

>> or you pass &addr to sock_connect_mptcp, and you do the free here.
>
> This needs a refactor of sock_connect_mptcp =E2=80=93 I used to do it tha=
t way. But I
> worry that backporting could be tricky. If you're fine with it, I'm okay =
with this plan
> as well.

I didn't check in details, but it seems like it would be shorter: just need=
 to pass &addr to sock_connect_mptcp(... =E2=80=A2=E2=80=A2addr, ...) and u=
se *addr
instead of addr in two places + moving the declaration and free to the
parent function. No?

If I'm missing something, the copy is fine.

Cheers,
Matt
