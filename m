Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E5C4C63
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 03:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545821; cv=none; b=jJj46WrMrgxwwf70RGKB9eHPgWk0fDwTQ5zKm0r37DrK3pmiX+vzOnMDEA6v47ECwIgywii6oXcgPXNB9zZMkT8ByZ85jeMVygSho0Sonj09FfGUrsCJj7wx/vXs2HIbAMghbs3QxApE8WKCkqlkzzFqbip9Xht/SKkkXrpYVMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545821; c=relaxed/simple;
	bh=CwXYlt+e9JK74dXoup53E3Zxv1gHVbpxgbKN8VD07fk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VDnh0bUTcD3YCLJkxE3Ek1j8WE0ZOl089NYkQJKcJm567ACUtZ1KSuazK5ysNBzT+wPUC2s1EN9AxUTczAZT7dqrxBR/joUY26yVHB1fUgAwMaAGKUOROzZSpr1G5a2bwbJUGOGa3LLsIKrhL95wTpMcJynaLhqxfmi14N3ttXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLd51vre; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLd51vre"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B143C433C7;
	Mon,  8 Apr 2024 03:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712545820;
	bh=CwXYlt+e9JK74dXoup53E3Zxv1gHVbpxgbKN8VD07fk=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=XLd51vreEu1bf9RP0Q77ntLZtX8bd33jzMLBUzZS7oA9isdsKsJwwR5/25ZY7Fo8w
	 o1lpdcfix1Lxyypyf3tjhcNMbsONvW0iRyGHopLStAe2W9XvjYCMvFIq43kPOpazRi
	 YUFIo2iTHvbbMvY96hkKdk28g2dSlscPOztSyabsxuFL/UG2yY+Xn4wTH4P95WaRG3
	 8ltY4kZad465VZ3zHwWF4gUa41/3oDXZM6aBRl+k2Oy7nyqja9gs4kEh7TzKWfIijI
	 UdluFw3rCdfp8QHAeW2BIkSsec2iQYmSORluSiTeH/JzUiw8Vq76G6fMGeffd3olwQ
	 q55GjFHHJlrrw==
Message-ID: <fb0c45182eaab1fd92f1302113d0298bc16d20f6.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v6 4/9] selftests/bpf: Add MPTCP_SCHED_TEST
 macro
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 08 Apr 2024 11:10:15 +0800
In-Reply-To: <5a8d79cb-5dfc-45d8-b708-7d4c798408c7@kernel.org>
References: <cover.1712235379.git.tanggeliang@kylinos.cn>
	 <ae75e2c884eb6a1742af12aaeae9015bb0b4d90c.1712235380.git.tanggeliang@kylinos.cn>
	 <5a8d79cb-5dfc-45d8-b708-7d4c798408c7@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matt,

On Thu, 2024-04-04 at 19:52 +0200, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 04/04/2024 15:03, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >=20
> > This patch defines MPTCP_SCHED_TEST macro, a template for all
> > scheduler
> > tests. Every scheduler is identified by argument name, and use
> > sysctl
> > to set net.mptcp.scheduler as "bpf_name" to use this sched. Add two
> > veth net devices to simulate the multiple addresses case. Use 'ip
> > mptcp
> > endpoint' command to add the new endpoint ADDR2 to PM netlink.
> > Arguments
> > addr1/add2 means whether the data has been sent on the first/second
> > subflow
> > or not. Send data and check bytes_sent of 'ss' output after it
> > using
> > send_data_and_verify().
>=20
> Should we not squash this in "selftests/bpf: Add bpf scheduler test"
> as
> well? We already have a lot of different commits.
>=20
> >=20
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > =C2=A0.../testing/selftests/bpf/prog_tests/mptcp.c=C2=A0 | 30
> > +++++++++++++++++++
> > =C2=A01 file changed, 30 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > index ffcd5ebe38b9..8a6b09a97698 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > @@ -498,6 +498,36 @@ static void test_default(void)
> > =C2=A0	cleanup_netns(nstoken);
> > =C2=A0}
> > =C2=A0
> > +#define MPTCP_SCHED_TEST(name, addr1, addr2)			\
> > +static void test_##name(void)					\
> > +{								\
> > +	struct mptcp_bpf_##name *skel;				\
> > +	struct nstoken *nstoken;				\
> > +	struct bpf_link *link;					\
> > +	struct bpf_map *map;					\
> > +								\
> > +	skel =3D mptcp_bpf_##name##__open_and_load();		\
> > +	if (!ASSERT_OK_PTR(skel, "open_and_load " #name))	\
> > +		return;				=09
> > 	\
> > +								\
> > +	map =3D bpf_object__find_map_by_name(skel->obj, #name);	\
> > +	link =3D
> > bpf_map__attach_struct_ops(map);			\
> > +	if (!ASSERT_OK_PTR(link, "attach_struct_ops " #name))	\
> > +		goto skel_destroy;				\
> > +								\
> > +	nstoken =3D sched_init("subflow", "bpf_" #name);		\
> > +	if (!ASSERT_OK_PTR(nstoken, "sched_init " #name))	\
> > +		goto link_destroy;				\
> > +								\
> > +	send_data_and_verify(#name, atoi(#addr1), atoi(#addr2));\
>=20
> Can you not use the values of addr1 and addr2 directly as number
> instead
> of string + atoi()?
>=20
> > +								\
> > +	cleanup_netns(nstoken);			=09
> > 	\
> > +link_destroy:							\
> > +	bpf_link__destroy(link);				\
> > +skel_destroy:							\
> > +	mptcp_bpf_##name##__destroy(skel);			\
> > +}
>=20
> I don't mind having functions defined in macros, but I think we
> should
> try to reduce their size to the minimum (if possible) because they
> are
> hard to read and debug in case of error.
>=20
> Here, do you think we could have a smaller macro passing the name as
> a
> string (for the error messages) and the different functions pointers
> you
> need to a new helper? (+ using generic skel structure?)

Thanks for your review, it's very useful. v7 is sent, address all your
comments except this one. I didn't got it, please give me more details
about this.

-Geliang

>=20
> Maybe it will not work or will not be easier to read, but worth a try
> I
> think. If it is not possible, please explain why.
>=20
>=20
> > +
> > =C2=A0static void test_first(void)
> > =C2=A0{
> > =C2=A0	struct mptcp_bpf_first *first_skel;
>=20
> Cheers,
> Matt

