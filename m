Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793786950;
	b=1bZ8xVnn81ev5KKoPZ7jT8S3b+ffDOMDhb1xDycvEzRQ+1w9AXI9cfZv5umOzu37hmGf
	 449CIjLRD3cuQEWaEVa7vFZd1iGhzMkHMpSORyiB18vUG2crhWpBZsUWCRprCcEClXycL
	 SOD6XRa0hVv0Hl1vx+ECJIzGUDR7FGXoQg4MgO7qBseK+Gzw+lszjI5m25Uu9SrRewW+w
	 96tS482yeKFOgg/MhelzjEZCKx3VnFF5/Skw7mVg0FJGRR+4TXhRt45YSOd6lg+5QrWox
	 1KQQqT+nci9pcl0yLypr4n+ZOAVm7xw71zik3Si71IUNGHcfxDo4VH7IXVH0V33uXlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786950;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-ZohoMailClient;
	bh=7M2awz5bxi+ND42rLaoMSCegd95IJwki7qYpjmXF4C8=;
	b=2OkyYusK1bqkG2io5OMlxg5HNR548YXJxeopfM2V3rqkCmNOz9FZ0vTtwMTf7QItZEi0
	 y+EXxFyi7FJYnC+FrDLq3jMWN+rD0F33u9dplSlS7p8hQPdIRsjhEUaS63vgvDab6VAse
	 Izf1yXzcMrPPzrBReEFSX1gNb30Y2HhNun8+RUyVn0P8M0np5QmzscMNTtAsieKoLldlI
	 jnqriJkz6URaRhEQN+ZHd2mok1LohN6CTcpaVptu+WccPA40+0Lkg8rk15OhKcgAKlzjo
	 esGtQODbYFU6oXmF+RdrySI0PBVxUb5Ffnp7EVwLNXJ5wQFaa+ouePUCgnI4FWOBOfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.52
Received: from sender6-of-o52.zoho.com (sender6-of-o52.zoho.com [165.173.180.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC578606A31B
	for <mptcp@lists.linux.dev>; Wed,  4 Nov 2026 10:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC578606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1793786945; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mdb8yoCbvdkIXgZMWISmWEkLk3Q7tdcJPxuZTCwD2m4dSsS8fWsbP1t1NF8NmiioeM/M2nCUTpVJK89bY+mZG4HLQJMeLhGdckaGcC7nMURW4sLHidVDw3Z2+em5akyMyR4375R9q0meDvX+Smyv3GtI2p/uFmzOA9oHaWt0Fao=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793786945; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7M2awz5bxi+ND42rLaoMSCegd95IJwki7qYpjmXF4C8=; 
	b=CkZwyyYuVGc0wws5Eb+uYChy0J8f4tNz47MDEX8K4df6KTGhd4C1+S16JbfxlT7crBM1I+at5OL55mKpl5MuEuC5CkdAqTON23c8PX/Ieo1ZLR2OOFWfn1SN2ScmD0QE0SyZAXDJeHGqt8L0FLKXQFN2NN4BV3oLm8NIzBbdDlY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: a=rsa-sha256; b=k9vvZ0B5TBuRgaWeoj2S3wGpUZzzXUZA4dVtYAB1q+DgwVNxngvgJL66cQlwcnQP7DAEcWVJiQF1POgG9MHypsiScFZI37z8+CEj4JlVDgbq80IHrnJdajUJcrtRVqa/grlpzKjF4r1NulCHjv6ANpyN/2G7mkBZr1Mym4qFGiM=; c=relaxed/relaxed; s=mpiric; d=mpiricsoftware.com; v=1; bh=7M2awz5bxi+ND42rLaoMSCegd95IJwki7qYpjmXF4C8=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793786943266781.1426524156063;
	Wed, 4 Nov 2026 02:09:03 -0800 (PST)
Message-ID: <81edb1804fcc5a5ebc1432e73740546fcb4af431.camel@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next v5 0/4] mptcp: sched: penalise a slow subflow
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Janak Patel <janak@mpiric.us>, Kalpan Jani
	 <kalpan.jani@mpiricsoftware.com>, Abdul Wasey <w453y.me@gmail.com>
Date: Wed, 04 Nov 2026 15:38:52 +0530
In-Reply-To: <7da5435c-bddf-4134-8fa7-1df661fa1046@kernel.org>
References: 
	<20261028-mptcp_penalise_send_v2-v5-0-32fb379ce117@mpiricsoftware.com>
	 <7da5435c-bddf-4134-8fa7-1df661fa1046@kernel.org>
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

On Mon, 2026-11-02 at 19:37 +0100, Matthieu Baerts wrote:
> Hi Shardul,
>=20
> On 28/10/2026 12:15, Shardul Bankar wrote:
> > A subflow that is slow relative to the others can soak up
> > connection
> > resources and cause head-of-line blocking of the aggregate stream.
> > This
> > series lets the packet scheduler send less than such a subflow's
> > congestion window by halving it, and leaves the congestion control
> > to
> > raise it again. It implements issue #345 [1]. This is a
> > deliberately
> > simple first form.
> >=20
> > - Patch 1: a prerequisite fix. The scheduler truncates the pacing
> > rate to a
> > =C2=A0 u32, which skews subflow selection on fast paths (Fixes).
> > - Patch 2: penalise a slow subflow by halving its cwnd, triggered
> > on its
> > =C2=A0 pacing rate and gated on the fast path being cwnd-limited.
> > - Patch 3: skip the penalty when the transfer is receive-window-
> > limited,
> > =C2=A0 where it would otherwise slow the transfer.
> > - Patch 4: MPTcpExt counters and a dedicated mptcp_subflow_penalise
> > =C2=A0 tracepoint for observability.
> >=20
> > Validation, baseline versus this series (test helper, its
> > run_matrix.sh
> > base-vs-patch driver, and run steps are in [2]):
> > - No regression in the mptcp selftests.
> > - No regression versus baseline across the buffer-limited transfers
> > =C2=A0 (send-buffer, receive-window, both, sndbuf>rcvbuf): the two-path
> > completion
> > =C2=A0 time with the penalty enabled matches the unpatched kernel. Wher=
e
> > the
> > =C2=A0 slow subflow is beneficial (send-buffer-limited), the two-path
> > transfer
> > =C2=A0 stays faster than the fast path alone.
> > - Patch 3's gate keeps the penalty from firing when receive-window-
> > limited,
> > =C2=A0 where halving cwnd would slow the transfer.
> > - With a bufferbloated slow path, the penalty roughly halves the
> > slow path's
> > =C2=A0 queueing latency (subflow srtt), with the transfer time
> > unchanged. It does
> > =C2=A0 not reduce the aggregate out-of-order volume or move data off th=
e
> > slow
> > =C2=A0 path; that is the role of issue #332 [3], and the two are
> > complementary.
> > - The conditions above do not catch one case: with the buffers left
> > to
> > =C2=A0 autotuning and a subflow that is slow because of latency rather
> > than limited
> > =C2=A0 bandwidth, penalising it costs throughput, and the cost grows as
> > the added
> > =C2=A0 delay grows.
> >=20
> > Used LLM for design, review, coding assistance.
> >=20
> > [1] https://github.com/multipath-tcp/mptcp_net-next/issues/345
> > [2]
> > https://github.com/shardulsdk-mpiric/linux/blob/e0f78406d921/tools/test=
ing/selftests/net/mptcp/mptcp_sched_penalise.sh
> > =C2=A0=C2=A0=C2=A0 (run_matrix.sh + runs.conf are alongside it in the s=
ame
> > directory)
> > [3] https://github.com/multipath-tcp/mptcp_net-next/issues/332
> >=20
> > Changes in v5:
> > - Rebased on the current export; no code change.
> > - Dropped the Assisted-by tags, which the kernel docs no longer
> > describe;
> > =C2=A0 tool use is noted in this cover letter instead.
> > - Collected Abdul Wasey's Tested-by, thanks:
> > =C2=A0
> > https://lore.kernel.org/all/20261025192320.1831707-1-w453y.me@gmail.com=
/
> > - Link to v4:
> > https://patch.msgid.link/20260911-mptcp_penalise_send_v2-v4-0-820f2be4a=
8fe@mpiricsoftware.com
>=20
> Thank you for the new version!
>=20
> I just noticed that Abdul's v2 series that I recently sent [1] didn't
> get reviewed by Clashiko because it doesn't support dependences yet
> (Sashiko does) [2]. Just to avoid both working on the same thing: are
> you already working on a new version addressing / rejecting the last
> review comments sent here? No rush at all, but if you didn't start
> yet,
> and you prefer me to look at it, I can try to do that this week. I
> would
> then send a version including your patches with fixes (if I can) and
> the
> ones I recently sent. Otherwise, there is no urgency, and I can wait.
>=20

Hi Matt,

Thank you for the offer. I have not started on a new version yet, so
please go ahead and include my patches in your series, with the fixes
you think are needed. Feel free to reach out if I can help with
anything.

Cheers,
Shardul

> [1]
> https://lore.kernel.org/20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f684=
1@kernel.org
> [2]
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261031-mptcp-sched-=
opp-retrans-v2-0-e9c4a30f6841@kernel.org
>=20
> Cheers,
> Matt

