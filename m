Received: from mta1.migadu.com (out-146.mta1.migadu.com [95.215.58.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923CC33F59E
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717240; cv=none; b=Y6fSPoU/vV/YdLMOtPcU6f+YTUMSmMuW3Bm+1Iki1TU5psytgwNf6PBHbyiW89S36k2nhrhFkWX5ABm/ml5w6rJvqKNMWHJ/5KBOOw4PbDJSw2e91tphaMXJ7BCMaWxpHF2UKNWrmX1gV578AWaBfWrBbPyVJ0sHU5kaGLID4Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717240; c=relaxed/simple;
	bh=2dKW6NoaYvtpqbH21ODCC5DhJ4G4DF2uLauXzTwYAp0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=f1KLeMFBzk+rKQ23u9aIOMpmo75uec9GejtWmHQk/nAsv4aFbi7YNxC415fwoxcdhvB0OeTY2PfjpqcOgx3g9NNM6sdCFoOwJtXHQweHvdmiNxrferOMFmGOd0jN1Fm8j0sxAb6Z97ovQ1go0liVrZeDKxEMiQsIFiWIWi6WWYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VmbXeSCi; arc=none smtp.client-ip=95.215.58.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VmbXeSCi"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=2dKW6NoaYvtpqbH21ODCC5DhJ4G4DF2uLauXzTwYAp0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786717212; v=1; x=1787322012;
 b=VmbXeSCiIIZtE10Kl9RrUXJ4ilZi0xh1WHNflfFVn1uWSTNRAR7NEjXZiMM2vQuMjmhQyqrm
 6yMY7a4khov0PFW8uDqN0NEgLCAPpAfHDgH2yUbjXSw3r2QIxKn/EOp0fNghyL8fJl/M1hs1sKy
 sX47zIY75BmWDHWD0ur93lEU=
X-Envelope-To: mptcp@lists.linux.dev
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by mta12.migadu.com with ESMTPS id b435a56344732745;
	Fri, 14 Aug 2026 14:20:12 +0000
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 14 Aug 2026 14:20:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <cbd1c616b7ade068ce1d432270f27ff18f86520c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-net] selftests: mptcp: fix an UAF in
 mptcp_connect.c
To: "Paolo Abeni" <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: "Gang Yan" <yangang@kylinos.cn>
In-Reply-To: <a4d66633-1340-4a56-9dd2-18cdeff7629e@redhat.com>
References: <20260814050625.80231-1-gang.yan@linux.dev>
 <0ce89b909d078e40f8f560255ad44ae8e2cfff00@linux.dev>
 <a4d66633-1340-4a56-9dd2-18cdeff7629e@redhat.com>

August 14, 2026 at 6:50 PM, "Paolo Abeni" <pabeni@redhat.com mailto:paben=
i@redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote=
:


>=20
>=20Hi,
>=20
>=20On 8/14/26 8:42 AM, gang.yan@linux.dev wrote:
>=20
>=20>=20
>=20> Sorry for this, after reviewing sashiko's comment, I think this mod=
ification
> >  below should be better:
> >=20=20
>=20>  diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/t=
ools/testing/selftests/net/mptcp/mptcp_connect.c
> >  index ea4cb6c1bd5e..c81ec4400bef 100644
> >  --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> >  +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> >  @@ -421,7 +421,8 @@ static int sock_connect_mptcp(const char * const=
 remoteaddr,
> >  sock =3D -1;
> >  }
> >=20=20
>=20>  - freeaddrinfo(addr);
> >  + if (sock =3D=3D -1)
> >  + freeaddrinfo(addr);
> >  if (sock !=3D -1)
> >  SOCK_TEST_TCPULP(sock, proto);
> >  return sock;
> >  @@ -1424,6 +1425,7 @@ int main_loop(void)
> >  }
> >=20=20
>=20>  out:
> >  + freeaddrinfo(peer);
> >  if (cfg_input)
> >  close(fd_in);
> >=20=20
>=20>  If you think it's OK, I can send v2 immediately.
> >=20
>=20I'm sorry for being in late.
>=20

Hi=20Paolo,

So nice to get your reply.

> This is in a better direction but still will be not fully correct:
> freeaddrinfo() must be called on the argument returned by getaddrinfo()
> - in this case: `addr`.
>=20
>=20Otherwise some addresses will not be freed.
>=20
>=20Since sock_connect_mptcp() is invoked only once per program execution=
,
> and not-freed memory will _not_ be leaked at process exit time, I think
> the easier solution is to remove the:
>=20
>=20 freeaddrinfo(addr);

Sounds great!

>=20
>=20statement, adding a comment alike:
>=20
>=20 /* All the allocated memory is released at exit() time, this
>  * is executed only once and ownership of a single address has
>  * to be transferred to the caller. Keep it simple and avoid
>  * later freeaddrinfo() entirely.
>  */

I've just send the v2 and using AI to simplify the comment =E2=80=94=E2=
=80=94 hope you
don=E2=80=99t mind.

Thanks
Gang

>  xgetaddrinfo(listenaddr, port, &hints, &addr);
>=20
>=20/P
>
