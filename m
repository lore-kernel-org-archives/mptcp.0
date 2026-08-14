Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDEE347532
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786697702; cv=none; b=jaRZ2qYi1TzMBA5cdI7hF4LnOhzmdHrYDnDD1Lq8o0jJrSTfk/QF1+WAmVQdiIaddCxfVIcQQwMSouO6Kr16mQ3zyfXritUlHp8/Pl0qvygW552fTjweXF0vAJDNuGkCiLHUn7vi4wHyRkSkjA2yXOrDbzMjAkrjlxhfMPq99IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786697702; c=relaxed/simple;
	bh=kl5wNjNyBwNPQtVjeM9l7XEP7+45PPTDBiadfdCOIU0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=owDysNeNrH1k0sw3mXb8/0hAuV/vzlTqx/v7ug5N7rnNkL9dahz/y6/hXbcBM2f9uH5dexvz97f+b9Sq2T67hW9kpr8WhqkOIgcFHk4M0XSHFAHATn8ZctFSgVm4jaVjyTWADVpILq32mfDrefVT9ARmFRy87rOv1zGbIQ3oveE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHOZLGNd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHOZLGNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA881F000E9;
	Fri, 14 Aug 2026 08:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786697700;
	bh=kl5wNjNyBwNPQtVjeM9l7XEP7+45PPTDBiadfdCOIU0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=VHOZLGNdmmT1wVvXaDphr1XetJvKflrSfSLgkRI+HSClYG5qlAQ6YiMk3ujU0rRJm
	 BNfAfM/DpHIHoDIAJ7PrOHuBffDGctnlr/Dn3So1/8ybjUYl3hUsVxnUt6jOMER5mM
	 72eobs+7tGgIJnh9/lfoHabxZzDnw7u9bvyV+p/ncWjl5zRH8qnuHPrJdXHyzjL3/2
	 WjQngRbTT06K6xZoU0c9JqqxY1dP+wCTZhtFR4BSD/H9XJOU/iyVBoMqnjNiMcXzTz
	 Y6cOZrYn8xNimSGcGXri7meJGrDdXdzTf3/5FbdqPgcEibiFqb5PkR164eKeiAGxIH
	 ZDlN3sVTui0lg==
Date: Fri, 14 Aug 2026 10:54:55 +0200
From: Matthieu Baerts <matttbe@kernel.org>
To: gang.yan@linux.dev
Cc: mptcp@lists.linux.dev, Gang Yan <yangang@kylinos.cn>
Message-ID: <90d727ed-9c4c-4107-a283-1e9a0245d09b@kernel.org>
In-Reply-To: <0ce89b909d078e40f8f560255ad44ae8e2cfff00@linux.dev>
References: <20260814050625.80231-1-gang.yan@linux.dev> <0ce89b909d078e40f8f560255ad44ae8e2cfff00@linux.dev>
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
X-Correlation-ID: <90d727ed-9c4c-4107-a283-1e9a0245d09b@kernel.org>

14 Aug 2026 08:42:38 gang.yan@linux.dev:

> August 14, 2026 at 1:06 PM, "Gang Yan" <gang.yan@linux.dev mailto:gang.ya=
n@linux.dev?to=3D%22Gang%20Yan%22%20%3Cgang.yan%40linux.dev%3E > wrote:
>
>
>>
>> From: Gang Yan <yangang@kylinos.cn>
>>
>> At the end of 'sock_connect_mptcp()', it calls 'freeaddrinfo(addr)',
>> the 'peer' pointer (which points into 'addr') remains. Later, the main
>> loop uses this peer pointer for reconnection attempts. If the memory has
>> been freed and reused, the address data could be overwritten, resulting
>> in an invalid remote address.
>>
>> This patch removes the '**peer' out-parameter entirely and adds a
>> sock_reconnect() helper that resolves the address and connects in a
>> self-contained scope, so no pointer to freed memory escapes.
>> Also prints the reconnect destination address on stderr as suggested by
>> Paolo.
>>
>
> Hi Matt,
>
> Sorry for this, after reviewing sashiko's comment, I think this modificat=
ion
> below should be better:
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> index ea4cb6c1bd5e..c81ec4400bef 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -421,7 +421,8 @@ static int sock_connect_mptcp(const char * const remo=
teaddr,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sock =3D -1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 freeaddrinfo(addr);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sock =3D=3D -1)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 freeaddrinfo(addr);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sock !=3D -1)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 SOCK_TEST_TCPULP(sock, proto);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return sock;
> @@ -1424,6 +1425,7 @@ int main_loop(void)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> out:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 freeaddrinfo(peer);

This assumes peer =3D=3D addr. It is certainly the case but it looks wrong,
and I guess sashiko will complain like it did here.

We could add something on the commit message to say that it is always an IP=
 address that is given, but maybe we should also just
handle that correctly: either peer here is not a pointer, and the content
is copied, or you pass &addr to sock_connect_mptcp, and you do the free her=
e.

WDYT?

Cheers,
Matt

