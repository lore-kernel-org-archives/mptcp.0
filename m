Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47CC388363
	for <mptcp@lists.linux.dev>; Tue,  7 Jul 2026 06:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404917; cv=pass; b=pKysupUIao4sd72YWlTf5J73YnA932GDbq0OBvCaVk4ZSzdPMz8SlcSXHtoqD5An7fG1o7YfpWTaS9qFTJs8Rc9p//0T/4S+BPQ2R7uX5J5On44x6qQVcCfAOIMEiyxbBO4efJZsE4GIyahhFHzF/BOrDonyKM60aqGYvg7t0xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404917; c=relaxed/simple;
	bh=A7YChuRnddChVsyQcSt92yGsL8YCZPDyLhU9vkMNV5A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=L7HomGog92MBaXnfjjTTH1UaUMYgybH9YFjMhr6zXzxPOBG671Duwq4Wdcm58qEt6B4XfZWxQIHanAeDE0YG4w5GRayzcgIA/4o9O+QnCIDovXm7TLp13+qeIiujPeZzT4Z95FF+HvxSuNiAN/Jh/LbjNo2ptMCqcbO4A9uqsQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=jDe5ECKy reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="jDe5ECKy"
ARC-Seal: i=1; a=rsa-sha256; t=1783404908; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NGU4f16zbUcddBScMhbvEQNKws8gF3izyxuYXH39RgPqVfud2YRx+/RGlsnGgp6xKhUFdR5u9r5pe8lJXdE4aebILD4h+qTtP+u6ky7VQxwvekvlUKEap6IIyRzi8ucstzxewcH/IZ54sj17YOiUX6WaNWIbXkHHGYgzQSgEzAs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783404908; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Z5XO66aoIyVYYOHT4n8CckiRVd4dt9rwEtVIvpxKYH0=; 
	b=ZUZDjczVKhgu8XqzRn7/K8hwlVza3bsjqdNRVUcoYTs8TKbF2qU9OM/qjFhedy8Y/WoN0zqLu1M49l0trkQ9uIT9/7H10qyqwmGM9KyW7c4juR2Io+1rF9RlJZ6AMi0MAVUyDOBVuqbSF5wFXCf+ZYc2cjomNBo+/H2nelNkwgs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783404908;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Z5XO66aoIyVYYOHT4n8CckiRVd4dt9rwEtVIvpxKYH0=;
	b=jDe5ECKy4ke3tZUWTHgB2/jFWwa5FECUFQktsNohQYc6Dn845kRfE0Bi8ogUGVbc
	327nxpjp5Z6uUG9owc0Ct3C2OkByNQjoLoTC+1MuHIam1yx9tlWhFG+9ny2LOvPR7PI
	W7OPUiPY92vGnRZgvNFx175XWIY8qZQ/inkGqZeY=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 17834049085581005.5122858869875; Mon, 6 Jul 2026 23:15:08 -0700 (PDT)
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1783404907099246.12881585719197; Mon, 6 Jul 2026 23:15:07 -0700 (PDT)
Date: Tue, 07 Jul 2026 11:45:07 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>, "martineau" <martineau@kernel.org>,
	"pabeni" <pabeni@redhat.com>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>,
	"shardulsb08" <shardulsb08@gmail.com>
Message-ID: <19f3b374a41.2132097d1809464.3759794617307044756@mpiricsoftware.com>
In-Reply-To: <6d0b954c-4028-4c1e-bf02-5bf5f43f58af@kernel.org>
References: <20260529064355.922763-1-kalpan.jani@mpiricsoftware.com>
 <0f13954f-3bfa-4630-af9f-6f1f4b138a13@kernel.org>
 <19e72995d6d.89137929840232.7611532549298755137@mpiricsoftware.com>
 <bca2ad2f-1f45-45e7-a8bd-7a08dd7100c2@kernel.org>
 <19e830d30d7.701114c6187254.5018026155515510877@mpiricsoftware.com> <6d0b954c-4028-4c1e-bf02-5bf5f43f58af@kernel.org>
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

Thank you for the clear question =E2=80=94 here is my honest assessment.

The blocking point for a packetdrill test of this specific bug is
that the trigger sequence requires the kernel PM worker to run
between a "del id 0" and a second signal endpoint add, and
packetdrill's shell-escape timing is coarser than what reliably
controls that window.

More specifically, the reproducer needs:

1. A fully-established MPTCP connection.
2. A second subflow via MP_JOIN (to keep the connection alive
   across the id 0 removal) =E2=80=94 this part packetdrill handles well,
   as shown in mp_join_server.pkt.
3. An ADD_ADDR for the id-0 address already in flight with the
   echo withheld =E2=80=94 also doable: just don't send the echo packet.
4. `ip mptcp endpoint delete id 0 <addr>` via a shell escape =E2=80=94
   packetdrill supports this.
5. `ip mptcp endpoint add <addr> flags signal` to force PM
   reselection =E2=80=94 also a shell escape.

The difficulty is between steps 3 and 4: the ADD_ADDR for id 0
only gets sent after mptcp_mpc_endpoint_setup() has accounted the
MPC endpoint and the PM worker has run. In the mptcp_join.sh
reproducer this is handled by waiting for the second join
(wait_mpj) and checking the add_addr_signal counter before
proceeding. In packetdrill, the closest control is expecting the
`> add_address address_id=3D0 ...` line before issuing the shell
escape =E2=80=94 and that does work in principle.

Where it gets fragile: after the del+re-add, the PM reselects id 0
and the WARN fires inside the add_addr_doit netlink handler, which
is synchronous with the shell-escape command. Packetdrill would
then need to expect a second `> add_address address_id=3D0 ...` line
that a fixed kernel would *not* send (since mptcp_pm_announced_alloc
returns false silently). That asymmetry =E2=80=94 expecting a packet that
a fixed kernel suppresses =E2=80=94 means the test structure naturally
inverts: you'd write it to expect *no* retransmission after the
del+re-add, which is harder to express cleanly than "this packet
must appear". The mptcp_join.sh counter check (`add_addr_signal`
going from 2 to 1 after the del) is a more direct assertion.

That said, I think a packetdrill test *is* achievable if it's
structured around the ADD_ADDR retransmit that fires on an unfixed
kernel after the del+re-add: on an unfixed kernel the stale entry
triggers a second `> add_address address_id=3D0` packet; a fixed
kernel does not send it. So the test would:

  - inject the MP_JOIN to create the second subflow;
  - see `> add_address address_id=3D0` (the first, legitimate one);
  - not send the echo;
  - issue `ip mptcp endpoint delete id 0 $OPT_LOCAL_IP` as a
    shell escape;
  - issue `ip mptcp endpoint add $OPT_LOCAL_IP flags signal`;
  - add a ~`*` line that expects *no* spurious second
    add_address =E2=80=94 which is the opposite of what unfixed kernels
    produce.

The main uncertainty is whether packetdrill's `*` (any-packet)
handling can cleanly express "this packet must NOT appear within
N ms", or whether we'd need a short timeout + close to flush the
pipe. That's the part I haven't mastered yet in packetdrill.

If you can point me at an existing test that uses a negative
packet assertion (or a timeout to prove absence), I can turn the
mptcp_join.sh reproducer into a packetdrill test for the next
version. Otherwise I'll send the mptcp_join.sh subtest as patch 2
of v6 (with the `addr` fix in patch 1), and follow up with a
packetdrill test separately once I understand that idiom better.

Cheers,
Kalpan Jani


From: Matthieu Baerts <matttbe@kernel.org>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>
Cc: "mptcp"<mptcp@lists.linux.dev>, "martineau"<martineau@kernel.org>, "pab=
eni"<pabeni@redhat.com>, "shardul.b"<shardul.b@mpiricsoftware.com>, "janak"=
<janak@mpiric.us>, "kalpanjani009"<kalpanjani009@gmail.com>, "shardulsb08"<=
shardulsb08@gmail.com>
Date: Mon, 06 Jul 2026 22:16:55 +0530
Subject: Re: [PATCH net v2] mptcp: pm: drop pending ADD_ADDR when removing =
id 0 endpoint

 > Hi Kalpan,
 >=20
 > Sorry for the delay.
 >=20
 > On 01/06/2026 13:59, Kalpan Jani wrote:
 > >> do you mind sharing what you have so far. Maybe someone else can help
 > >> you to reproduce the issue.
 > >=20
 > > Attached is the WIP packetdrill test (server side, based on the existi=
ng
 > > add_addr/mp_join server tests, with an extra MP_JOIN subflow). I have =
not
 > > been able to reproduce the WARN with it yet, so please treat it as a
 > > work-in-progress rather than a finished test -- the status and the ope=
n
 > > question are written at the top of the file.
 > >=20
 > > The trigger is "ip mptcp endpoint delete id 0 <saddr>", which is the o=
nly
 > > op that reaches mptcp_nl_remove_id_zero_address(). (flush is not usabl=
e: it
 > > goes through mptcp_pm_flush_addrs_and_subflows(), which already calls
 > > mptcp_pm_announced_remove(), so that path was never buggy.)
 > >=20
 > > Where I am stuck is getting ADD_ADDR(id 0) announced in the first plac=
e.
 > > The signal endpoint on the MPC address has its id bit cleared by
 > > mptcp_mpc_endpoint_setup(), so it is not announced on connect. "delete=
 id 0"
 > > frees the bit again, but I could not confirm that the PM worker re-run=
s and
 > > announces id 0 on an otherwise idle connection. Without that announcem=
ent no
 > > pending anno_list entry is created, so the second "delete id 0" has no=
thing
 > > stale to leave behind and the WARN does not trigger.
 > >=20
 > > So my question: what is the minimal way to get the id-0 address actual=
ly
 > > announced via packetdrill? Does this need the MP_JOIN subflow and/or a=
 data
 > > exchange to wake the PM worker between the operations, or is there a s=
impler
 > > approach I am missing?
 >=20
 > With the in-kernel PM, I think you need to:
 >=20
 > - create a subflow using a second local IP address (maybe optional): use
 >   multi-ep.sh (or add an IP address and inject a SYN+MPJ)
 >=20
 > - remove the endpoint linked to the initial subflow: ip mptcp endp del
 >=20
 > - re-create the same endpoint: ip mptcp endp add (or adapt multi-ep.sh
 >   to avoid the flush)
 >=20
 > That's what the mptcp_join.sh's "delete re-add signal" subtest does if I
 > remember well.
 >=20
 > >> I will wait for this test before applying the v3.
 > >=20
 > > Understood, I will keep working on it. One thing I wanted to ask direc=
tly:
 > > is a deterministic packetdrill test a hard requirement for applying v3=
, or
 > > could the fix go in on the reasoning + the syzbot report alone? The ch=
ange
 > > only makes the id-0 removal path symmetric with the non-zero id path (=
tear
 > > down the pending ADD_ADDR and decrement add_addr_signaled), so it is f=
airly
 > > contained and independent of whether I can script a reliable trigger.
 >=20
 > Having a reproducer (packetdrill, selftests, syzbot repro) are not just
 > added to avoid having the same issue later on, but it also helps the
 > reviewers to understand what is being fixed. Here, we don't have a
 > syzbot reproducer, so I think it is even more important to prove that
 > something is being fixed here: maybe syzbot found another path, and
 > having such test here would really help for later to exercise one "known
 > path".
 >=20
 > > (Note: the anno-list helpers were renamed in current export, so v3 no =
longer
 > > applies as-is; I can send a trivially rebased v4 that swaps
 > > mptcp_remove_anno_list_by_saddr() for mptcp_pm_announced_remove() if u=
seful.)
 > I see that you sent a v5 for this. I guess you did the rebase, and you
 > added a reproducer in the selftest. It should be enough for now. But
 > here, I would like to get your feedback if you don't mind: now that you
 > have a clearer view on what needed to be tested, do you think there
 > was/is a blocking point to get such validation in packetdrill? I do
 > think Packetdrill tests are often better in terms of maintenance,
 > clarity, and execution time to reproduce exactly what is needed (not
 > just with MPTCP), so I think it is important to make sure this tool is
 > still adapted, and understood by multiple people.
 >=20
 > Cheers,
 > Matt
 > --=20
 > Sponsored by the NGI0 Core fund.
 >=20
 >=20


