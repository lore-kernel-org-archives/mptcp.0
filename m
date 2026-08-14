Received: from mta0.migadu.com (out-17.mta0.migadu.com [91.218.175.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FCF371876
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689757; cv=none; b=R30CH/GInY3ZFzQBTmrx2Xfa1BcGucxSfymUW7h+feBY+Zakc+Ot6Xl4WYrD/aflB1GoBQE4YVEvWk1NPwjQZvzLHX+cuZKm9ppOKseuUv8frJi3TEfiLmwre5DYvTGllr+9kVDZkG7V9ARAJFGCzpxWYm5gPQm1XKiH7FBIg/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689757; c=relaxed/simple;
	bh=SCj06J3uOO7JeE34tEXaUsyaeWO4fRWXz4FKjUFKy48=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=o8LNFXniPERmTsd3DaPovauMCwMyQVwuEG6aVHmcks5eV/d06I2pi5/2EUC0BCaUFyBJzd591tdSSlk4do3QX43QWW9XfknleQAoHGDklSjM1mLhJ3FDZ70Yu+gMAgs1SyoJaxMBVj2mXUEOgmtonqVKHLNa6ugLxK36a6lV38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JXD0t0fB; arc=none smtp.client-ip=91.218.175.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JXD0t0fB"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=SCj06J3uOO7JeE34tEXaUsyaeWO4fRWXz4FKjUFKy48=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786689753; v=1; x=1787294553;
 b=JXD0t0fBMYcWatncTEXw5ZCQABPLWeIGyb/XGuQaIoaXfj5EXmWuVdhld8vo4zJHsmL+oMzq
 sFNnjD9B12b/iLOoe8XEGlg3xLoiA4C1I27GgVzZoSn8IEAkcerMT9UZ7ogj03ooRkNH/4d58Pn
 Ap0JSt49+KBAMyXhRVNr9b3Q=
X-Envelope-To: mptcp@lists.linux.dev
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by mta12.migadu.com with ESMTPS id 566e816a639feb79;
	Fri, 14 Aug 2026 06:42:33 +0000
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 14 Aug 2026 06:42:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <0ce89b909d078e40f8f560255ad44ae8e2cfff00@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-net] selftests: mptcp: fix an UAF in
 mptcp_connect.c
To: mptcp@lists.linux.dev
Cc: "Gang Yan" <yangang@kylinos.cn>
In-Reply-To: <20260814050625.80231-1-gang.yan@linux.dev>
References: <20260814050625.80231-1-gang.yan@linux.dev>

August 14, 2026 at 1:06 PM, "Gang Yan" <gang.yan@linux.dev mailto:gang.ya=
n@linux.dev?to=3D%22Gang%20Yan%22%20%3Cgang.yan%40linux.dev%3E > wrote:


>=20
>=20From: Gang Yan <yangang@kylinos.cn>
>=20
>=20At the end of 'sock_connect_mptcp()', it calls 'freeaddrinfo(addr)',
> the 'peer' pointer (which points into 'addr') remains. Later, the main
> loop uses this peer pointer for reconnection attempts. If the memory ha=
s
> been freed and reused, the address data could be overwritten, resulting
> in an invalid remote address.
>=20
>=20This patch removes the '**peer' out-parameter entirely and adds a
> sock_reconnect() helper that resolves the address and connects in a
> self-contained scope, so no pointer to freed memory escapes.
> Also prints the reconnect destination address on stderr as suggested by
> Paolo.
>=20

Hi=20Matt,

Sorry for this, after reviewing sashiko's comment, I think this modificat=
ion
below should be better:

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
index ea4cb6c1bd5e..c81ec4400bef 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -421,7 +421,8 @@ static int sock_connect_mptcp(const char * const remo=
teaddr,
                sock =3D -1;
        }
=20
-=20      freeaddrinfo(addr);
+       if (sock =3D=3D -1)
+               freeaddrinfo(addr);
        if (sock !=3D -1)
                SOCK_TEST_TCPULP(sock, proto);
        return sock;
@@ -1424,6 +1425,7 @@ int main_loop(void)
        }
=20
=20out:
+       freeaddrinfo(peer);
        if (cfg_input)
                close(fd_in);

If you think it's OK, I can send v2 immediately.

Thanks
Gang
