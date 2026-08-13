Received: from mta0.migadu.com (out-87.mta0.migadu.com [91.218.175.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D211321F2D
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 01:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786584624; cv=none; b=ZOhacpEHJ03Av6MIipsQhA0O7+AXyOoIVULNJNqMNyc6+xQYI39X+PuJns8pwt3CiQ6AiZZ7VEhcyzHSHtm0WiKSHGyADMcfTqJX7ppqM1Z4wyjHMFyiasRCu90tgFozMzFeYO6ATD45Ij9rIEbVnWDZrc82N9Ve2V1DEsGBqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786584624; c=relaxed/simple;
	bh=yPsIrS66rVzwaPzrANnI/SAyS6c/o8cnS5525QfKbvw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=X+QGyQ5XqyOaW8pZdyimTO5P2Xeg86tma4abSwcCArSRCY84yFLDEyC8/l9EmJcdA0nDVpFcw3u2zscUtErHmhI6lKGOG2ElLQuKzsfm+K8vEM/a3MBWhEAB4a4abFJGIwe6GTV56NFg9B60kLJWAjYek8BSZfemsheblkqC+NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YusbEm/A; arc=none smtp.client-ip=91.218.175.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YusbEm/A"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=yPsIrS66rVzwaPzrANnI/SAyS6c/o8cnS5525QfKbvw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786584619; v=1; x=1787189419;
 b=YusbEm/A6h+hmW/+9r26uxzxKpkiPHk+0uYfUCS5nH1bWm2tuojMboE8OqpLnEhFT5J5GpBQ
 zXHGXJexwTaXGbn3BCe3y4Ge+NtXwAhs7692Ykrf6xUToHo02QphhdfSaTJYxySL3SjRSGLH4Kb
 Ljg/0KGEfJRgHz/XJP/jgYEI=
X-Envelope-To: mptcp@lists.linux.dev
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by mta12.migadu.com with ESMTPS id fc314fd4071e681f;
	Thu, 13 Aug 2026 01:30:09 +0000
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 01:30:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <42782d2aaa30cf1328bfea950c5f430eb9c98bd3@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next 0/2] mptcp: MIB counter for invalid option
To: "Matthieu Baerts" <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: "Gang Yan" <yangang@kylinos.cn>
In-Reply-To: <d5ac123f-51f0-45c1-856c-c4693fc17a33@kernel.org>
References: <20260812100550.148670-1-gang.yan@linux.dev>
 <d5ac123f-51f0-45c1-856c-c4693fc17a33@kernel.org>

August 12, 2026 at 11:03 PM, "Matthieu Baerts" <matttbe@kernel.org mailto=
:matttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.or=
g%3E > wrote:


>=20
>=20Hi Gang,
>=20
>=20On 12/08/2026 12:05, Gang Yan wrote:
>=20
>=20>=20
>=20> From: Gang Yan <yangang@kylinos.cn>
> >=20=20
>=20>  This series is designed for [1].
> >=20=20
>=20>  Patch 1 passes the 'net' to options parser, I used to use
> >  dev_net(skb->dev) for MIB counters, but the AI reported it is not
> >  suitable for this. This patch has no functional change.
> >=20=20
>=20>  Patch 2 adds the InvalidOptionRx counter, and increments it when
> >  receive the invalid options.
> >=20=20
>=20>  The packetdill testcase is submitted, and can be reviewed in [2].
> >=20=20
>=20>  [1] https://github.com/multipath-tcp/mptcp_net-next/issues/628
> >=20

Hi=20Matt

> Thank you for the patches. Please next time add a comment on the GitHub
> ticket: I already have the patches ready, but I had to wait (for
> administration purposes) before sending them:
>=20

Sorry=20for that, no offense intended. And thanks for the review and for
the process reminder.

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20commit 8173df5a467cac6ed421bb832ac3ee675b490fa6 (b4/mptcp-mib-inval-o=
pt)
> Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Date: Fri Jul 31 14:10:38 2026 +0200
>=20
>=20 mptcp: options: reset parsing in case of invalidity
>=20
>=20 When an invalid option is detected -- any unexpected suboptions
>  combinations or use of invalid sizes -- the current behaviour is to
>  ignore the currently parsed option.
>=20
>=20 Receiving such invalid options is suspicious: either this is coming =
from
>  a buggy host, or an attacker. In this case, it seems safer to drop any
>  previously parsed MPTCP option from such packet.
>=20
>=20 Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>=20
>=20commit be5492962195d2988a9c508bc8ce4d3f55ac1da7
> Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Date: Wed Jul 29 20:01:45 2026 +0200
>=20
>=20 mptcp: options: track invalid ones
>=20
>=20 Any unexpected suboptions combinations or use of invalid sizes are
>  suspicious: either it is coming from a buggy host, or an attacker.
>=20
>=20 Better to track that with a new MIB counter.
>=20
>=20 Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>=20
>=20commit 684c6244b5b76d30aaf30d62597247485b89cdb3
> Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Date: Mon Aug 3 20:24:02 2026 +0200
>=20
>=20 mptcp: options: use a dedicated bit for csum reqd
>=20
>=20 Instead of mixing that with suboptions: that's the only non-suboptio=
ns
>  that is present in the 'suboptions' field.
>=20
>=20 This even cause a workaround with OPTIONS_MPTCP_DSS to exclude this
>  non-suboptions when checking which other ones are set.
>=20
>=20 Move it to a dedicated free bit, and adapt the corresponding code.
>=20
>=20 This is clearer like that.
>=20
>=20 Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>=20
>=20=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20In your version, I see that you increment the counter even when the
> suboption is not invalid, e.g. the version or the hmac is not supported=
.
> I don't think we should do that.
>=20
>=20If that's OK for you, I can add a co-dev by on my patches.

Thank you, that=E2=80=99s fine with me


Thanks
Gang

>=20
>=20Cheers,
> Matt
> --=20
>=20Sponsored by the NGI0 Core fund.
>
