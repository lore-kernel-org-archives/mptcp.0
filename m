Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793168994;
	b=xfhP/3UUkhOcm7L0ShehFnubo6ae7DZ6n6P73d7lWHeMDS1guOS6UCIHqfUxX+9TRoC9
	 ASIKTzOszE8IyHzeFMD4gN2dK+ojiGAxDscu2YRMCcRJxVM4VYhoCwwMDWQGMNP5+4Yr7
	 YmC5nlGzgd1U2n8Y4IPRP+jhsmE0jlfBea5fHejK6cEri3yZ7T2IfYXy/O00VBxcnMt4u
	 gblzZXAOpzL+Msjng8B8VD2Y1/WnMPM05BGyG9UupP+Cf0f98yfHE4lFhGJn/SeVZCoje
	 ydJbOjfp4XXKdjaOIfL2PKofx9ya92+DY1zJef9VowNr5fXdvEt7REDOcoqd3/THAsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793168994;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-ZohoMailClient;
	bh=iM2BcuKaypfr0SGFYjeLphHvAlkosqgZab9xX9k3YcE=;
	b=bIzwPkn30zjBzwNpbagrrT9/+UTyYf+GJfw39Zcz2FC4v6oo3P6hBvNup/bVBXNQvaqg
	 JLvG1CKcwf+iXjDK/Tpvv5glGkWRqxlZsJPY3o0U1Q/3SdX9UoNOHFnvVv4Qi7usWXHbx
	 cgZ98fEAthaM3vEUR9e8Pn+dDE+GGTp7VuGRWhQ+kJ6P7lVk7BsDpNtpfe0jzus422Bdd
	 2cWwChFfUQSRnjGEVfpba8McnCGprGwutmySqzA9i4ra1VlZDk2aJT16akyZvvmhqt7qC
	 65QhhrBAJ7G/RlBDw0U1r/KWJiIaWoYtuQMRD0tBI11/2eIwaBG14sLra1F1h9LbHgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.52
Received: from sender6-of-o52.zoho.com (sender6-of-o52.zoho.com [165.173.180.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76562606A31A
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 06:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76562606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1793168991; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BuWSEq3IZZrWZ84dabWmEwltaM0MkfjAF3YKKy1T5Q5n/xIfiVmPhSgvbj2VfgkfecQHRMhvm7D9PGaDeyyuI/8P+jBEnRTxERK3U5DMXxFOrOhLoqvOYdBPejmwj2ZFTQO7TrGezosy7bwKN0JzdQhEFyirz+X1cAVyh5uIj4Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793168991; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iM2BcuKaypfr0SGFYjeLphHvAlkosqgZab9xX9k3YcE=; 
	b=LLwemHuQmP3gG0OM4qZCyfIXIKbcGqG0ep72lWMICO9PKGGjStf4wZi9Q+7dEbKtq9aJlVOJY7EyuvH9VR/+zxXSVu+NvSOHFiS5/VV+QULwE34nCNrQNDdtxxWQom1ZPM04XE59h9nsq+Uz77WIZTujzZZ0FIciPy7y1iWPY0k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793168991;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=iM2BcuKaypfr0SGFYjeLphHvAlkosqgZab9xX9k3YcE=;
	b=XAeUb9b+UIRNHYPaC3r74EImHYLfGwJJMFlh8vhxz3fIfC3nJLBJI3h0otDLNhG/
	6AmbyGMsgIUJoIgjaLaDZU/A/Uhrd3/uN9lDf5kXvjsxvBLRDOTtjV7wTMEXj4+ihyt
	3+1tWwfGy1VInL4x+cSltLGu7Z12wZrd7stF4Pfc=
Received: by smtp.zohomail.com with SMTPS id 1793168990338205.2846219171696;
	Tue, 27 Oct 2026 23:29:50 -0700 (PDT)
Message-ID: <75e5b3edc4b32ad3307bf5e805b16ef39c0a2c99.camel@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next v4 0/4] mptcp: sched: penalise a slow subflow
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Abdul Wasey <w453y.me@gmail.com>
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>, Janak Patel
	 <janak@mpiric.us>, Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Date: Wed, 28 Oct 2026 11:59:34 +0530
In-Reply-To: <20261025192320.1831707-1-w453y.me@gmail.com>
References: 
	<20260911-mptcp_penalise_send_v2-v4-0-820f2be4a8fe@mpiricsoftware.com>
	 <20261025192320.1831707-1-w453y.me@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-ZohoMailClient: External

Hi Abdul,

On Sun, 2026-10-25 at 19:23 +0000, Abdul Wasey wrote:
> Hi Shardul,
>=20
> I tested v4 on top of the current export (77f43f9f7643). Patches 2 to
> 4
> needed a small context fix in protocol.h, because of the new
> close_event_done field.
>=20

Thank you for testing, and for the detailed numbers. The v5 I am about
to post is only a rebase on the current export (which takes care of
that context fix) and carries your Tested-by.

> Setup: two paths in netns, netem on both directions, one iperf3 MPTCP
> connection for 20 s, upload and download, BBR and CUBIC, tcp_rmem max
> 6 MB and 32 MB. 9 path pairs, for example 400M/10ms + 15M/120ms,
> 40M/10ms + 2M/250ms with 5% loss, 40M/5ms + 30M/35ms with 17 ms
> jitter.
> 3 runs each, 10 runs for the three noisiest pairs.
>=20
> I found no regression. Throughput is the same within noise in every
> case. The 400M + 15M pair with CUBIC and 6 MB looked worse at first,
> but
> it's bimodal (about 30 or 65-170 Mbit) with and without the series,
> and
> 10 runs each show no difference. There are two small changes, both
> with
> CUBIC. The jitter pair gets 66 Mbit in all 10 runs without the series
> and 64-65 in all 10 runs with it. Two 50M paths with 1% loss each go
> from 10 to 9 Mbit, and that's where the halving fires the most, about
> 140 times over the 3 runs in each direction.
>=20
> But it rarely fires. In most cases CwndPenalised stays at 0 or a few
> while PenalCandidate counts hundreds or thousands. To see why, I
> added
> two local counters, one after the cwnd-limited check on the fastest
> subflow and one after the receive window check. Download, 6 MB, 2
> runs:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 candidate=C2=A0 fastest cwnd-limited=
=C2=A0 wnd ok=C2=A0 penalised
> =C2=A0 starve=C2=A0 BBR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 75 / 13=
1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 / 2=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 / 0=C2=A0=C2=A0=C2=A0=C2=A0 0 / 0
> =C2=A0 hol=C2=A0=C2=A0=C2=A0=C2=A0 BBR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 27 / 46=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 /=
 4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 / 0=C2=A0=C2=A0=C2=A0=
=C2=A0 0 / 0
> =C2=A0 starve=C2=A0 CUBIC=C2=A0=C2=A0=C2=A0=C2=A0 147 / 251=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 87 / 241=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0 / 0=C2=A0=C2=A0=C2=A0=C2=A0 0 / 0
> =C2=A0 jitter=C2=A0 CUBIC=C2=A0=C2=A0 1668 / 1524=C2=A0=C2=A0=C2=A0=C2=A0=
 1668 / 1524=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26 / 24=C2=A0=C2=A0 16 / 13
>=20
> With BBR the fastest subflow is almost never cwnd-limited, since BBR
> paces and keeps cwnd around 2x BDP. So the series does nearly nothing
> for BBR. With a 6 MB buffer the receive window check from patch 3
> stops
> most of the rest. With 32 MB it fires more often, but still only on a
> small share of the candidates (starve with BBR: 341 cwnd-limited out
> of
> 1541, 1 penalised).
>=20
> Is that what you expect for BBR? If the cwnd-limited check is only
> there to know that the fastest path is saturated, something that also
> works for a pacing CC might be needed.
>=20

Yes, the cwnd-limited check is there so that we only penalise a slow
subflow when the fastest one is actually saturated. Your counters show
that this signal rarely holds with a pacing congestion control, so the
series does little there. I think my own runs for v4 used Reno, so I
had not seen this; thank you for measuring it. A saturation signal that
also works for pacing CCs looks like the right follow-up; I would
rather keep this series as the simple first form Matt asked for and
look at that separately.

> Selftests: mptcp_connect passes. simult_flows failed test 9
> ("unbalanced
> bwidth with opposed, unbalanced delay") in 1 out of 8 runs with the
> series, but also in 2 out of 8 without it on the same base, so that's
> not from your patches.
>=20
> Tested-by: Abdul Wasey <w453y.me@gmail.com>
>=20
> Thanks,
> Abdul Wasey


