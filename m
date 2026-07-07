Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7732A41A780
	for <mptcp@lists.linux.dev>; Tue,  7 Jul 2026 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431344; cv=pass; b=NTfyQ9gHCfMpQWXsROFvHukCO+8KgStYDpD5CJ+22BXBFbsn2M5z+6tPfYnn2j8V4CJTgiSYLPxPmjsmRSqZRys4Y16nHQGqye2dspcZs2OdVaIjsdsPAoKmnVYx1d1cFvhQjimgg1jWlpEwK+IXr9CgwkCDfynzbTCOU5kAhTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431344; c=relaxed/simple;
	bh=3ehNZp3ug7Rc+cv9/icg/F4gQW8zHkXFtDuaeubWZGw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Q2qO7+/ubmPqndY+Cj2Kki/4ZHMBdSMFaVfZI7DyePXKKtCGegnyJAhXVNwi8M9KbL41GWDRxCx1KXXxXfITcVdbT96r7gJqAxdDCHfRWIfCBOw6qiRJkKhcCrffwn8Z0TXPfzQgL2gv3/fQ5SYmCAcw/JOjK79xmb6BzGBAsX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=QSE5Ih5k reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="QSE5Ih5k"
ARC-Seal: i=1; a=rsa-sha256; t=1783431334; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V1FB2fo3cY1Kz/N2HqBnyz80vgE1fHdGkKAB5jlfVDla1CcoqzBLmyuqkDBv4YHoDBuouxh3pl4Ih20qfic6vfuKJoHzwf5X48f71yZ///LZ0fLuLtG2cqewCfeGK/F9tLS67ZJZfhUtuXZlznPkKsR7TBLpmwx6QTv4oJJsDpg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783431334; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nLp6uxGXXi8cnir5SRm5fnO0eWV6eAcDv80+OjM9plQ=; 
	b=EoxGVaYTvH2veFpJUp7fZOg7nvLppnxHqMklTU6qOQF4AuMTO+GRXMqQvJp5Qo+VGBgjOZbnyhLYTpumsi27j0vBPX+03hB29+NWxfECkzT2/8BoUPZAdD6tdqZ2Qy116HonhnkrN0y0nMx1gQZJ7xC2i9u1y0Vg+jlo1kcHVWw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783431334;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nLp6uxGXXi8cnir5SRm5fnO0eWV6eAcDv80+OjM9plQ=;
	b=QSE5Ih5ksWusH0+3TRmXVfMU0GT7kC6RIgaXxl3oL+2auAbP5JUgQe4/jLBEerBa
	h/OKeCGhEvtc26MfEU57gbitPhYOqw5Cosw/cj0ogY0woCr61KnwhEIjG6Rhkas/K7c
	1l0xImqzxoefR1wbW0tgNUJHigS2f2Q5CbiGWMKk=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1783431334213856.3403413551929; Tue, 7 Jul 2026 06:35:34 -0700 (PDT)
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1783431333139473.6732305580689; Tue, 7 Jul 2026 06:35:33 -0700 (PDT)
Date: Tue, 07 Jul 2026 19:05:33 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>, "martineau" <martineau@kernel.org>,
	"pabeni" <pabeni@redhat.com>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>,
	"shardulsb08" <shardulsb08@gmail.com>
Message-ID: <19f3cca8500.ef8eb681856418.2642565239132356618@mpiricsoftware.com>
In-Reply-To: <ad9044cd-ff6d-4a88-ba3f-fbba7d40b092@kernel.org>
References: <20260529064355.922763-1-kalpan.jani@mpiricsoftware.com>
 <0f13954f-3bfa-4630-af9f-6f1f4b138a13@kernel.org>
 <19e72995d6d.89137929840232.7611532549298755137@mpiricsoftware.com>
 <bca2ad2f-1f45-45e7-a8bd-7a08dd7100c2@kernel.org>
 <19e830d30d7.701114c6187254.5018026155515510877@mpiricsoftware.com>
 <6d0b954c-4028-4c1e-bf02-5bf5f43f58af@kernel.org>
 <19f3b374a41.2132097d1809464.3759794617307044756@mpiricsoftware.com> <ad9044cd-ff6d-4a88-ba3f-fbba7d40b092@kernel.org>
Subject: Re: [PATCH net v2] mptcp: pm: drop pending ADD_ADDR when removing
 id 0 endpoint
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Matt,
Thank you for pointing me to add_addr_retry_errors.pkt =E2=80=94 that makes=
 the idiom clear. Inject a data packet after the del+re-add sequence and ex=
pect a plain DSS ACK back with no add_address option piggybacked. On an unf=
ixed kernel the stale entry causes a spurious ADD_ADDR(id=3D0) retransmit t=
o appear on that ACK, which packetdrill catches as an unexpected option.
I will write the packetdrill test using that pattern and send v6 with:

Patch 1: kernel fix (also correcting the addr argument =E2=80=94 the &anno_=
addr copy in v5 is fragile for with-port endpoints)
Patch 2: packetdrill regression test in gtests/net/mptcp/regressions/

Also noted on the NetDev slides =E2=80=94 reading those before drafting the=
 test.

Cheers,
Kalpan Jani




From: Matthieu Baerts <matttbe@kernel.org>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>
Cc: "mptcp"<mptcp@lists.linux.dev>, "martineau"<martineau@kernel.org>, "pab=
eni"<pabeni@redhat.com>, "shardul.b"<shardul.b@mpiricsoftware.com>, "janak"=
<janak@mpiric.us>, "kalpanjani009"<kalpanjani009@gmail.com>, "shardulsb08"<=
shardulsb08@gmail.com>
Date: Tue, 07 Jul 2026 16:57:06 +0530
Subject: Re: [PATCH net v2] mptcp: pm: drop pending ADD_ADDR when removing =
id 0 endpoint

 > Hi Kalpan,
 >=20
 > Thank you for your reply.
 >=20
 > On 07/07/2026 08:15, Kalpan Jani wrote:
 > > Hi Matt,
 > >=20
 > > Thank you for the clear question =E2=80=94 here is my honest assessmen=
t.
 > >=20
 > > The blocking point for a packetdrill test of this specific bug is
 > > that the trigger sequence requires the kernel PM worker to run
 > > between a "del id 0" and a second signal endpoint add, and
 > > packetdrill's shell-escape timing is coarser than what reliably
 > > controls that window.
 > >=20
 > > More specifically, the reproducer needs:
 > >=20
 > > 1. A fully-established MPTCP connection.
 > > 2. A second subflow via MP_JOIN (to keep the connection alive
 > >    across the id 0 removal) =E2=80=94 this part packetdrill handles we=
ll,
 > >    as shown in mp_join_server.pkt.
 > > 3. An ADD_ADDR for the id-0 address already in flight with the
 > >    echo withheld =E2=80=94 also doable: just don't send the echo packe=
t.
 > > 4. `ip mptcp endpoint delete id 0 <addr>` via a shell escape =E2=80=94
 > >    packetdrill supports this.
 > > 5. `ip mptcp endpoint add <addr> flags signal` to force PM
 > >    reselection =E2=80=94 also a shell escape.
 > >=20
 > > The difficulty is between steps 3 and 4: the ADD_ADDR for id 0
 > > only gets sent after mptcp_mpc_endpoint_setup() has accounted the
 > > MPC endpoint and the PM worker has run. In the mptcp_join.sh
 > > reproducer this is handled by waiting for the second join
 > > (wait_mpj) and checking the add_addr_signal counter before
 > > proceeding. In packetdrill, the closest control is expecting the
 > > `> add_address address_id=3D0 ...` line before issuing the shell
 > > escape =E2=80=94 and that does work in principle.
 >=20
 > Note that if needed (but I don't think it is if I understood correctly),
 > you can always call commands or scripts in Packetdrill, e.g. to wait for
 > an internal state to change.
 >=20
 > > Where it gets fragile: after the del+re-add, the PM reselects id 0
 > > and the WARN fires inside the add_addr_doit netlink handler, which
 > > is synchronous with the shell-escape command. Packetdrill would
 > > then need to expect a second `> add_address address_id=3D0 ...` line
 > > that a fixed kernel would *not* send (since mptcp_pm_announced_alloc
 > > returns false silently). That asymmetry =E2=80=94 expecting a packet t=
hat
 > > a fixed kernel suppresses =E2=80=94 means the test structure naturally
 > > inverts: you'd write it to expect *no* retransmission after the
 > > del+re-add, which is harder to express cleanly than "this packet
 > > must appear". The mptcp_join.sh counter check (`add_addr_signal`
 > > going from 2 to 1 after the del) is a more direct assertion.
 >=20
 > You can also check ss' status. But here, you can also simply inject
 > another packet after a small delay, and expect an ACK without ADD_ADDR
 > to be sent instead.
 >=20
 > > That said, I think a packetdrill test *is* achievable if it's
 > > structured around the ADD_ADDR retransmit that fires on an unfixed
 > > kernel after the del+re-add: on an unfixed kernel the stale entry
 > > triggers a second `> add_address address_id=3D0` packet; a fixed
 > > kernel does not send it. So the test would:
 > >=20
 > >   - inject the MP_JOIN to create the second subflow;
 > >   - see `> add_address address_id=3D0` (the first, legitimate one);
 > >   - not send the echo;
 > >   - issue `ip mptcp endpoint delete id 0 $OPT_LOCAL_IP` as a
 > >     shell escape;
 > >   - issue `ip mptcp endpoint add $OPT_LOCAL_IP flags signal`;
 > >   - add a ~`*` line that expects *no* spurious second
 > >     add_address =E2=80=94 which is the opposite of what unfixed kernel=
s
 > >     produce.
 > >=20
 > > The main uncertainty is whether packetdrill's `*` (any-packet)
 > > handling can cleanly express "this packet must NOT appear within
 > > N ms", or whether we'd need a short timeout + close to flush the
 > > pipe. That's the part I haven't mastered yet in packetdrill.
 > >=20
 > > If you can point me at an existing test that uses a negative
 > > packet assertion (or a timeout to prove absence), I can turn the
 > > mptcp_join.sh reproducer into a packetdrill test for the next
 > > version. Otherwise I'll send the mptcp_join.sh subtest as patch 2
 > > of v6 (with the `addr` fix in patch 1), and follow up with a
 > > packetdrill test separately once I understand that idiom better.
 >=20
 > I think the easiest is to inject a packet after the timeout to force the
 > kernel to react, e.g. sending a DATA_FIN, data, an out of window packet,
 > etc. Then see that the reaction is the expected one, not a wrong
 > retransmission. I just noticed that's what is done in
 > add_addr_retry_errors.pkt, lines 32-38.
 >=20
 > In general, about Packetdrill, I recommend this presentation:
 >=20
 >=20
 > https://netdevconf.info/0x19/sessions/tutorial/tutorial-using-packetdril=
l-to-write-automated-tests-for-the-linux-networking-stack.html
 >=20
 > e.g. on page 15, there are some explanations about timing:
 >=20
 >=20
 > https://netdevconf.info/0x19/docs/netdev-0x19-paper23-talk-slides/packet=
drill%20-%20NetDev%202025-03-10.pdf
 >=20
 > Back to the series you sent: we could say that the mptcp_join.sh
 > reproducer is enough, but I think it would be useful for you -- and to
 > avoid a new "speed=3Dslow" subtest: mptcp_join.sh's execution is already
 > long enough -- to try a bit more with Packetdrill if that's OK. WDYT?
 >=20
 > Cheers,
 > Matt
 > --=20
 > Sponsored by the NGI0 Core fund.
 >=20
 >=20


