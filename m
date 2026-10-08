Received: from mta1.migadu.com (out-14.mta1.migadu.com [95.215.58.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754DD4A3D42
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466817; cv=none; b=jHk0J8pvk/xNjGKcpTAGree1QX1vUo6ldtUPOTb47Um949Y4qtk6hwiqdPIsVw7lOc/zgOOpktRzLn65wWVvRdJujzJTv7QLwSM9XzKTzhcCUvuJ+bylsR0/Z1yfK1gxoMZ5RtGESWEzyliYMeLXqgwfmT0VHwsGX147M5nd56Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466817; c=relaxed/simple;
	bh=7pBdVdAGqS4OAWGGgFLj8yenQhQTqxWeKD0mfWQLhow=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=qpPm1h4AsryuyqqgamhpDZlphg1COJJuA75UXzTmF3YY3Q1KIPtNiQ9AbrECr5fFqbSydK2w+4DTST9mhaRX9d6roMYmQZa9491ndJgDmy7oV71caYz/OdE0Oe/um03n6lLJTkAbyHWVW6TrD70x1dz9eh/1Ro/vWq88krGmTaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rOpflvK6; arc=none smtp.client-ip=95.215.58.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rOpflvK6"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=7pBdVdAGqS4OAWGGgFLj8yenQhQTqxWeKD0mfWQLhow=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791466811; v=1; x=1792071611;
 b=rOpflvK6cI+2YFjUp5xWS4gIzTr4UIO7nTIr7GTMvHTC4BsHJPhGOTbyST6jrnhXXVoNY3gI
 SsrFVMhcCF1d+EBbKTlqkWKWm7IXlUbj6eiKFFvKK1jy8Mmox9CnsKNr1yMyGYWKv7BMVpLHugN
 Va4vft+IZ1JKorsuWTVCqZT8=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id eaab6a661fc0967a;
	Thu, 08 Oct 2026 13:40:08 +0000
X-Mizu-Trace-ID: eaab6a661fc0967a
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 08 Oct 2026 13:40:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: hangbin.liu@linux.dev
Message-ID: <a07411464cafcb016436eb3c17ffca73730d7fe1@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next] selftests: mptcp: use offset to match RM_ADDR
 message
To: "Matthieu Baerts" <matttbe@kernel.org>, "MPTCP Linux"
 <mptcp@lists.linux.dev>
Cc: "Florian Westphal" <fw@strlen.de>, "Hangbin Liu" <liuhangbin@kylinos.cn>
In-Reply-To: <b7438cbf-0674-4b8f-aa23-3ba5791cfe26@kernel.org>
References: <20261008-mptcp_rm_addr-v1-1-b4d35ac8afef@kylinos.cn>
 <b7438cbf-0674-4b8f-aa23-3ba5791cfe26@kernel.org>

Hi Matthieu,

October 8, 2026 at 7:46 PM, "Matthieu Baerts" <matttbe@kernel.org> wrote:
>=20
>=20Hi Hangbin,
>=20
>=20Thank you for the follow-up!
>=20
>=20On 08/10/2026 12:06, Hangbin Liu wrote:
>=20
>=20>=20
>=20> From: Hangbin Liu <liuhangbin@kylinos.cn>
> >=20=20
>=20>  nft cannot match RM_ADDR when it is the second MPTCP option,
> >=20
>=20Do you mind adding a short explanation why or just a ref to:
>=20
>=20 https://lore.kernel.org/a391d81c-0bce-41e6-886e-a558765c6891@kernel.=
org

OK, I will.

>=20
>=20Also, could you title this patch:
>=20
>=20 Squash to "selftests: mptcp: convert iptables to nftables for
>  mptcp_join.sh"
>=20
>=20And mention what should be added to the original commit message, plea=
se?

OK, no problem.

>=20
>=20>=20
>=20> so we rely on hard-coded offsets. A tcpdump capture of the RM_ADDR
> >  message looks like:
> >=20=20
>=20>  [TCP header: 20 bytes] [nop] [nop] [timestamp: 10 bytes] \
> >  [MPTCP DSS: 12 bytes] [MPTCP RM_ADDR: 4 bytes]
> >=20=20
>=20>  We verify: TCP Data Offset (TCP[12] =C3=97 8) equals 48 bytes (12 =
x 4),
> >  DSS length (TCP[33] x 8) is 12 bytes, and RM_ADDR subtype (TCP[46] =
=C3=97 8)
> >  is 4. This matches the old cBPF check, which calculated offsets star=
ting
> >  from the IP header:
> >=20=20
>=20>  (ip[32] & 0xf0) =3D=3D 0xc0 && ip[53] =3D=3D 0x0c && (ip[66] & 0xf=
0) =3D=3D 0x40
> >=20=20
>=20>  Also add MPTCP kind (30) checks for the DSS (TCP[32] x 8) and RM_A=
DDR
> >  (TCP[44] x 8) options.
> >=20
>=20Good idea.
>=20
>=20>=20
>=20> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> >  ---
> >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >=20=20
>=20>  diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/too=
ls/testing/selftests/net/mptcp/mptcp_join.sh
> >  index b16e24418e73..194b80277ae2 100755
> >  --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >  +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >  @@ -4375,7 +4375,12 @@ endpoint_tests()
> >  local nft=3D1
> >  ip netns exec "${ns2}" nft insert rule ip filter OUTPUT \
> >  ip saddr 10.0.1.2 meta l4proto tcp \
> >  - tcp option mptcp subtype remove-addr drop || nft=3D0
> >  + @th,96,4 =3D=3D 12 \
> >  + @th,256,8 =3D=3D 30 \
> >  + @th,264,8 =3D=3D 12 \
> >  + @th,352,8 =3D=3D 30 \
> >  + @th,368,4 =3D=3D 4 \
> >  + drop || nft=3D0
> >  local i
> >  for i in $(seq 3); do
> >  pm_nl_del_endpoint $ns2 1 10.0.1.2
> >  @@ -4454,7 +4459,12 @@ endpoint_tests()
> >  local nft=3D1
> >  ip netns exec "${ns1}" nft insert rule ip filter OUTPUT \
> >  ip saddr 10.0.1.1 meta l4proto tcp \
> >  - tcp option mptcp subtype remove-addr drop || nft=3D0
> >  + @th,96,4 =3D=3D 12 \
> >  + @th,256,8 =3D=3D 30 \
> >  + @th,264,8 =3D=3D 12 \
> >  + @th,352,8 =3D=3D 30 \
> >  + @th,368,4 =3D=3D 4 \
> >=20
>=20Do you mind just adding this sequence to a global variable (an array?=
),
> similar to what was done before with the cBPF filter, with a short
> comment, please?
>=20
>=20That would be easier to understand here, and to avoid duplicated code=
.

Yes, I will.

BTW, For mptcp_sockopt.sh,

    # just to debug: check we have multiple subflows connection requests
    add rule $table filter OUTPUT \
        tcp flags & (fin | syn | rst | ack) =3D=3D syn \
        meta mark $m accept

do you think if there is a need to add counter or remove this rule?

Thanks
Hangbin
