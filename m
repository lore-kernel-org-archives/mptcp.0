Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6245020E3
	for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712714361; cv=none; b=VGazxwaDsU9DTvCKmVraV9LWsf3+aKqAGgqPPeh/o/tTQkocJWlQebDsJOdtKZbiclcQv5WHE9koTzaMEtXt90VMlQHj7W9pH1B+Ihzkbg9BK4VCE/Z8U+EU9MM8r868HZH5r45ZUNGTpYtGgaAk39E9W+hc+rT+3eNrpHywu8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712714361; c=relaxed/simple;
	bh=6rjf+lY6QR3o/V0lKevqy1Qhv/RnGAwZxMUUYlIhdqM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kAPZhU3f2ESKj6//DUSCKP7IhUYUQ7s1nim/VJx8vdJtWdZ5QjM76l5B3YllTA87MHpzL13iBOVcI5MqjOI//hn7QKcwYnx/5OzKu99xtRBN0PdlOXVEU9p91PV/tuzILn1WmnNrCsMYKb/AFr9r2uMDT2TaaVDLKtgjVI40m/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJ6awFxZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJ6awFxZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117AFC433F1;
	Wed, 10 Apr 2024 01:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712714360;
	bh=6rjf+lY6QR3o/V0lKevqy1Qhv/RnGAwZxMUUYlIhdqM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=BJ6awFxZNsrK5dAkJ6e+JavAjHvX3XP8/RqlFY+8zneHBXPGm26uze2noMUmUV49o
	 f5J/nGlDbegD9hXOk8y9pLn03yXfEJlm9bLzAaKxqmW8l281gvqPqP4TWHKgCLVwcD
	 7Hnb85VCmwaa+bVaBLqmt9vEZau5GIxtqg5pw0OG717OV5CtR6M5MXCw073XB1uHz2
	 nZ1cLrzDMsA4clHqxi2D4TD6p1X50ZxaOaSjnZuol5nZOIyrJhGAwC73ijOY5TASMp
	 JKULeVqGI+rKpqci/+mtlgStRJfO+u8Y13S9VSWsT8nawvMOgAbEpY71JZ/vOJNQdP
	 qDFJGhK6DJkWA==
Message-ID: <440ce520b97c9a33449a3a57901c14542bdcfc87.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v7 2/9] Squash to "selftests/bpf: Add bpf
 scheduler test" 1 verify
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 10 Apr 2024 09:59:14 +0800
In-Reply-To: <604bdd6d-3385-45f2-8729-a1633e699af7@kernel.org>
References: <cover.1712544986.git.tanggeliang@kylinos.cn>
	 <05269e97e219cc51b59173f05ab3a3b622a3ca1a.1712544986.git.tanggeliang@kylinos.cn>
	 <6ced2a3c-42da-4728-a36f-5cedf459dff0@kernel.org>
	 <a7ad092db6bdc19ecc7fb911db4bed7101bf39f7.camel@kernel.org>
	 <604bdd6d-3385-45f2-8729-a1633e699af7@kernel.org>
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

On Tue, 2024-04-09 at 17:20 +0200, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 09/04/2024 14:42, Geliang Tang wrote:
> > Hi Matt,
> >=20
> > On Mon, 2024-04-08 at 21:58 +0200, Matthieu Baerts wrote:
> > > > Hi Geliang,
> > > >=20
> > > > On 08/04/2024 05:01, Geliang Tang wrote:
> > > > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > > >=20
> > > > > > Add send_data_and_verify helper to avoid duplicated code.
> > > > > >=20
> > > > > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > > > > ---
> > > > > > =C2=A0.../testing/selftests/bpf/prog_tests/mptcp.c=C2=A0 | 40
> > > > > > ++++++++++++++-----
> > > > > > =C2=A01 file changed, 30 insertions(+), 10 deletions(-)
> > > > > >=20
> > > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > > > > > b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > > > > > index c29c81239603..5080e680fbe0 100644
> > > > > > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > > > > > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > > > > > @@ -457,23 +457,44 @@ static int has_bytes_sent(char *addr)
> > > > > > =C2=A0 return system(cmd);
> > > > > > =C2=A0}
> > > > > > =C2=A0
> > > > > > -static void test_default(void)
> > > > > > +static void send_data_and_verify(char *sched, char *addr1,
> > > > > > char
> > > > > > *addr2)
> > > > > > =C2=A0{
> > > > > > =C2=A0 int server_fd, client_fd;
> > > > > > - struct nstoken *nstoken;
> > > > > > =C2=A0
> > > > > > - nstoken =3D sched_init("subflow", "default");
> > > > > > - if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
> > > > > > - goto fail;
> > > > > > =C2=A0 server_fd =3D start_mptcp_server(AF_INET, ADDR_1, PORT_1=
,
> > > > > > 0);
> > > > > > + if (CHECK(server_fd < 0, sched, "start_mptcp_server:
> > > > > > %d\n",
> > > > > > errno))
> > > > > > + return;
> > > > > > +
> > > > > > =C2=A0 client_fd =3D connect_to_fd(server_fd, 0);
> > > > > > + if (CHECK(client_fd < 0, sched, "connect_to_fd: %d\n",
> > > > > > errno))
> > > > > > + goto close_server;
> > > > > > =C2=A0
> > > > > > - send_data(server_fd, client_fd, "default");
> > > > > > - ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent
> > > > > > addr_1");
> > > > > > - ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent
> > > > > > addr_2");
> > > > > > + send_data(server_fd, client_fd, sched);
> > > > > > +
> > > > > > + if (!strcmp(addr1, "WITH_DATA"))
> > > >=20
> > > > Out of curiosity, why did you use strings? Why not using
> > > > booleans?
> > > > (or a
> > > > bitmask)
> > > >=20
> >=20
> > Since arguments addr1 and addr2 of macro MPTCP_SCHED_TEST are
> > strings:
>=20
> They are strings because you asked the preprocessor to convert them
> as
> string ...
>=20
> > #define MPTCP_SCHED_TEST(sched, addr1, addr2)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
> > static void test_##sched(void)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
> > {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
> > ...
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 send_data_and_verify(#sched,=
 #addr1, #addr2);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
>=20
> ... here, by using "#addr1" and "#addr2".
>=20
> Why not simply removing the "#" not to do any conversion?
>=20
> e.g.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D 8<
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> #include <stdio.h>
> #include <stdbool.h>
>=20
> static void send_data_and_verify(char *sched, bool addr1, bool addr2)
> {
> 	printf("%s: %d %d\n", sched, addr1, addr2);
> }
>=20
> #define MPTCP_SCHED_TEST(sched, addr1, addr2)		\
> static void test_##sched(void)				\
> {							\
> 	send_data_and_verify(#sched, addr1, addr2);	\
> }
>=20
> #define WITH_DATA true
> MPTCP_SCHED_TEST(first, WITH_DATA, !WITH_DATA);
>=20
> int main()
> {
> 	test_first();
> }
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D 8<
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> This prints 'first: 1 0', what you want, no?

Thank you for providing such a detailed example. I have updated it to
v8.

-Geliang

>=20
> Cheers,
> Matt

