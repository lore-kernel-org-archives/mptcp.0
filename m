Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B66326B2D3
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115857; cv=pass; b=GGBg71+xiGP+ozZB/3kakkXCAIZh6jP0ku63584Gff+mAnFOCjnd0dNn5x3P1vZ/E2oaGONdN7VFdwjBjFlauFapRFKHyNbmoz7Lx7cftRurJybLPTUYLMttw6SSd2cOe5lkQdAkKhAMaPnVp/d4wuhdMhJM87bH6skxmZCkHig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115857; c=relaxed/simple;
	bh=WdhBgFeigE+yD3yXVEdTFHkGfEAIUBIvbl1XB/WzN8M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tyfnEjSgzh22SpEhrHecPY/QTMRhjslUGGhFotOcYWo4wGE8//eBWe1+XFOFx65pv6v7P12PtURkA6ObnKCOzuE0SzCHSUtVHIEAnsXV3N2zwnseordBBC1t5XmrtmNpbnsEa9bKUvLiyAVSvXkOnJQLvYYXZ6cCAeRhfZ5JS6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=uuSzctq1 reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="uuSzctq1"
ARC-Seal: i=1; a=rsa-sha256; t=1786115853; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VrMz0j052XG2zRAr4jFzjfy/ke7yr9+jTOTJFaIPkUolCFQyl3p4pTDWRGQjPWyAjobRYuK5G6cYs1PeB4gsy5+bazmCEZfnBCY9C6YvcotHaLGSeuCj5HodOqK94VHBb3AmO6L5OWbcAxZG7x/o1ky1QyDBJMMi7+YM2MKnej4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786115853; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WdhBgFeigE+yD3yXVEdTFHkGfEAIUBIvbl1XB/WzN8M=; 
	b=lKzS3W6KmB5CFVi+vdCinW13rr9zVyiY1CkUmCIG58Nd0KswMa8YpOX6NloralNrQOv2lMkq5dj1rIyg6rMtNFGI6zWbeWRBDGFCUidmVBp3CulPD6Wo3nU1fsRux8kEuVfFb2c9gOQSTp8NXUzjtcOPeC9i5Mced5h0HRLoeFw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786115853;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=WdhBgFeigE+yD3yXVEdTFHkGfEAIUBIvbl1XB/WzN8M=;
	b=uuSzctq146V9UpJZKbwHEIMrwzATrzEbrcoLjBWtg6gfiAB8gct+zZOq4ROq4QPt
	1BhjkI9Bcd0KbMqKDOcPc2vXCohVrEJ8cjU6F3B6BxTTVnQmyuTyPD2b5pEdpfJAln4
	YGuLoaL34/ZFRs0LOSP2MKYaRdSNhbmZudHeR8sc=
Received: by mx.zohomail.com with SMTPS id 178611585140778.71476786624612;
	Fri, 7 Aug 2026 08:17:31 -0700 (PDT)
Message-ID: <745def4591c1b3b35ace0719159fe2c6cbbab467.camel@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next 0/3] mptcp: sched: penalise a slow subflow
 (#345, first cut for your lab)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Date: Fri, 07 Aug 2026 20:47:21 +0530
In-Reply-To: <1a0d5c3b-05ef-4dbf-bb34-3141ad3d6f58@kernel.org>
References: 
	<20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
	 <1a0d5c3b-05ef-4dbf-bb34-3141ad3d6f58@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ZohoMailClient: External

Hi Matt,

On Wed, 2026-07-29 at 13:48 +0200, Matthieu Baerts wrote:
> Hi Shardul,
>=20
> On 26/07/2026 07:55, Shardul Bankar wrote:
> >=20
> >=20
> > - 2/3 is a guard that is in neither the fork nor what I described.
> > Without it,
> > =C2=A0 1/3 regresses badly (about 2x slower in my runs) when the
> > connection is
> > =C2=A0 receive-window-limited. In that case the fastest path is capped
> > by the same
> > =C2=A0 shared window, so it cannot absorb what the slow path gives up,
> > and halving
> > =C2=A0 just sheds the slow path's throughput. 2/3 skips the penalty
> > while the
> > =C2=A0 application has queued past the send-window edge (write_seq >
> > wnd_end), which
> > =C2=A0 is the sign that the receiver, not our congestion window, is the
> > bottleneck.
> > =C2=A0 I kept it a separate patch so you can test 1/3 on its own, or
> > drop or retune
> > =C2=A0 2/3 independently. The exact condition is the piece I would most
> > value your
> > =C2=A0 lab checking.
>=20
> It feels to me that you require this because patch 1/3 doesn't check
> if
> the MPTCP connection was "send-buffer-limited", no? But you are doing
> something very similar, no? Without testing, it feels like this is
> required not to limit the penalisation to when it is really needed.
>=20

Patch 1 does gate on load, with tcp_is_cwnd_limited(); though that is
not the send-buffer-limited check. The send-buffer-limited check never
fires at scheduler time in this tree, as the msk buffer has just
drained into the subflows. Patch 2 guards the receive-window-limited
case, where patch 1 without it can regress the transfer about 2x in my
tests. I have kept it as the explicit guard and am still characterizing
when patch 1 alone would suffice. Would you prefer we drop it?

> >=20
> >=20
> > I drove those regimes with a small simult_flows variant (receive-
> > window-
> > limited, send-buffer-limited, and autotuned cases). It is a helper,
> > not
> > selftest quality, so I did not fold it into the series; it is on a
> > branch of
> > my tree, in case it saves your lab time or you spot a case I
> > missed:
> >=20
> > https://github.com/shardulsdk-mpiric/linux/blob/6926c4b7f583/tools/test=
ing/selftests/net/mptcp/mptcp_sched_penalise.sh
> >=20
> > Run it on a baseline and a patched kernel and compare (prefix with
> > MPTCP_LIB_IP_MPTCP=3D1 if pm_nl_ctl does not work in your setup):
> >=20
> > =C2=A0 SCENARIO=3Dsuite=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > ./mptcp_sched_penalise.sh
> > =C2=A0 SCENARIO=3Dunbounded=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > ./mptcp_sched_penalise.sh
> > =C2=A0 SCENARIO=3Drwnd=C2=A0=C2=A0=C2=A0 RCVBUF=3D262144=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > ./mptcp_sched_penalise.sh
> > =C2=A0 SCENARIO=3Dsndbuf=C2=A0 SNDBUF=3D65536=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > ./mptcp_sched_penalise.sh
> > =C2=A0 SCENARIO=3Dboth=C2=A0=C2=A0=C2=A0 RCVBUF=3D262144 SNDBUF=3D65536
> > ./mptcp_sched_penalise.sh
>=20
> Sounds good! Did you check with a fixed sndbuf higher than the rcv
> one?
>=20

Yes (SNDBUF 256K, RCVBUF 128K). The guard correctly suppresses the
penalty there: the receiver is genuinely at a zero window (receive-
window-limited, not congestion-limited), and it is not slower than
baseline.

> Also, be careful that with netem, the limits you give to run_test()
> can
> influence a lot the bufferbloat. Did you monitor the RTTs during
> these
> transfers?
>=20

I do now. The harness samples the subflows' srtt, and it confirms your
point: the netem queue length drives it (srtt max is about 40 ms with
the fast path alone, rising to several seconds on a bufferbloated
path).

> On the other hand, it would be good to validate this with one path
> having bufferbloat. These patches should also help to improve the
> situation. (And issue #332 should help even more)
>=20

I added a bufferbloated-slow-path case, but it was too noisy to draw a
firm conclusion: the completion times swung widely, and the same swing
was on the baseline kernel, so my setup is not measuring the effect
cleanly. I would build a more controlled bufferbloat case (a moderate,
stable queue, and a latency metric rather than completion time). I
agree #332 is likely the bigger lever there.

> > For the rwnd/sndbuf/both scenarios the simult_flows pass/fail bound
> > is not
> > meaningful (it assumes both paths are fully used): read the printed
> > runtime
> > and out-of-order counts, not OK/FAIL. The "both" case also
> > occasionally fails
> > to bring up the second subflow with the very small SO_SNDBUF; just
> > rerun it if
> > you see a single-subflow run.
>=20
> I see, yes. I think what is important here for #345, is that when the
> transfer is buffer limited, the slow subflow impact should be
> reduced.
> At least not to cause the transfer to be worse than without this slow
> subflow.
>=20

Using that as the bar: when send-buffer-limited, the penalised two-path
transfer beats the fast path alone (about 11.3 s against 14.4 s), with
roughly 15 to 20% less out-of-order data, so the slow subflow helps.
When it is bufferbloated, it comes out about even with the fast path
alone.


I have all of these changes ready in my tree. I would rather settle
whether patch 2 stays (above) and the counters question on 3/3 before I
post v2, but I am glad to send v2 now if you would prefer to look at
the code directly.

Thanks,
Shardul
