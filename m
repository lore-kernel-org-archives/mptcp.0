Received: from mta0.migadu.com (out-253.mta0.migadu.com [91.218.175.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89FE4307A0
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699246; cv=none; b=ndPWHtl241ayuFiES6PIORBA22TeHDDi+L1apbXlE2Fo89H25BZlCWr4hwdet9WPB/dDjAPJIc29wo+FuCR5uIgGFRECAvxQtb62boGk8ZoKmJXYvlaJI2WB7tSL6ANKQzNI1wjettU7Ahx0ZLRXzc6OO4CL1lUDW/QP6xV+DTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699246; c=relaxed/simple;
	bh=ZppP5N/ADTaijTfUkeSNUTGiE4aKH2ZiPCnR/9sOwQs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=oyoQ7Ln3yYkFjZxnQMJtpYker61OGFciZF9vknUcRzNpjZJmcdFx23Bd18R2Gj/TyRVGtFq6vh52bRLml06cv7a77WELirXFXlfiUSvt/3Lsw8YC2mIgQcA+qavFqs3ag8hjEkoXzghHIHHvsWTdSeMUjWvWuG2onsf6znha610=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HowRnv38; arc=none smtp.client-ip=91.218.175.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HowRnv38"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=ZppP5N/ADTaijTfUkeSNUTGiE4aKH2ZiPCnR/9sOwQs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786699242; v=1; x=1787304042;
 b=HowRnv38g2vuWkm7GcHlcCeiQijF/ohS5RUXA1Fewoj4wSR0rmNiJBU3KD0r2yxU6ZLgEtvC
 o3WzZNFkK76QFCBmHPJ8yaoCsEG2YeVj7LkAv3FNkErIAP9ykBsMjaoHtuoaNz9exxuIYKMwtsl
 /PK4gB7nuuiagkklpFl1Hwdc=
X-Envelope-To: mptcp@lists.linux.dev
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by mta12.migadu.com with ESMTPS id e9895be0d6c14b85;
	Fri, 14 Aug 2026 09:20:41 +0000
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 14 Aug 2026 09:20:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <42532178906ea8ce9bd4b8550144719356c69671@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-net] selftests: mptcp: fix an UAF in
 mptcp_connect.c
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "Gang Yan" <yangang@kylinos.cn>
In-Reply-To: <90d727ed-9c4c-4107-a283-1e9a0245d09b@kernel.org>
References: <20260814050625.80231-1-gang.yan@linux.dev>
 <0ce89b909d078e40f8f560255ad44ae8e2cfff00@linux.dev>
 <90d727ed-9c4c-4107-a283-1e9a0245d09b@kernel.org>

August 14, 2026 at 4:54 PM, "Matthieu Baerts" <matttbe@kernel.org mailto:=
matttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org=
%3E > wrote:



> >=20
>=20This assumes peer =3D=3D addr. It is certainly the case but it looks =
wrong,
> and I guess sashiko will complain like it did here.
>=20
>=20We could add something on the commit message to say that it is always=
 an IP address that is given, but maybe we should also just
> handle that correctly: either peer here is not a pointer, and the conte=
nt
> is copied,=20

I=20prefer this, because it is smaller, like:

'''
 static int sock_connect_mptcp(const char * const remoteaddr,
 			      const char * const port, int proto,
-			      struct addrinfo **peer,
+			      struct sockaddr_storage *peer, socklen_t *peer_len,
 			      int infd, struct wstate *winfo)
 {
 ...
-				*peer =3D a;
 				break;
...
-				*peer =3D a;
 				break;
...
+	if (sock !=3D -1) {
+		memcpy(peer, a->ai_addr, a->ai_addrlen);
+		*peer_len =3D a->ai_addrlen;
+	}
 	freeaddrinfo(addr);
...

-	struct addrinfo *peer =3D NULL;
+	struct sockaddr_storage peer;
+	socklen_t peer_len;
...
-	fd =3D sock_connect_mptcp(..., &peer, fd_in, &winfo);
+	fd =3D sock_connect_mptcp(..., &peer, &peer_len, fd_in, &winfo);
...
-	if (connect(fd, peer->ai_addr, peer->ai_addrlen))
+	if (connect(fd, (struct sockaddr *)&peer, peer_len))
'''

> or you pass &addr to sock_connect_mptcp, and you do the free here.

This needs a refactor of sock_connect_mptcp =E2=80=93 I used to do it tha=
t way. But I
worry that backporting could be tricky. If you're fine with it, I'm okay =
with this plan
as well.

WDYT?

Thanks
Gang
