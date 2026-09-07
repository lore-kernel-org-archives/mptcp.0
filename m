Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2EC4C77D9
	for <mptcp@lists.linux.dev>; Mon,  7 Sep 2026 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791911; cv=none; b=P5+cPQhfG6DWUafrHYhqun3fOL1vP6/ZvqkAAXqMQikBs9lfloRZxgx++phFTFyhamJ51aVfpS3dN1szHPlejYTerBFslX/0/2eakmZyXfcKTdePAkIU0wAvVUp+h3U6bk4csKrNHY+j8cctpojpteeP1p+y24o2w5w3/ukzmuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791911; c=relaxed/simple;
	bh=3jyqEwEKVNF4J38MlcE3HzS4uFvYyFdN4CrTeecpBbA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJ2LG2JHegz3PNeLZnncOThmnYvnM7a/irZkzFxHH/7weSytdNNoxF/1I1WsuJXHPoyLa5tD5f8QHgIjpzVKPwVaeaOl9qKMVlVo1Rt5MC/Az8EPXSpztozrmM4wsa++6qdHG5sO4tcypVuUEWcvNO1Bq+Q6graTFysn82s5Mvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=K2WO96q3; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="K2WO96q3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=p2falglt4bgxnepquss77gknp4.protonmail; t=1788791897; x=1789051097;
	bh=3jyqEwEKVNF4J38MlcE3HzS4uFvYyFdN4CrTeecpBbA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=K2WO96q3ctYe5uVu6aUUYLaqEdL4eTThA542fnscduHk+8vBK1/7VnAhNvso2E7kX
	 dqwQmtAClwEPtd/r5p5LHWEAc9L/V5WrOj6ISu90Mqv4Q4w1e6mlC5lo37TRwLs7pi
	 5qwAZpGsvihMdd/8WhE27Vm6IN5Fxa96t0/4/QNfexIuEViktQJ+zpqeMgCSLWaiwo
	 NmgtaVvkn0GTyrJ7Z76oYNV++Y4vQGIvbKSFWTpKLaGKk0eqHvJt1wHjW0OjJ5ExIv
	 e4CtvH34kZ7WswhtHu8VJ8spMdM/c/NkhY5DvUkANzKE8aXUCnaX5Bo5ZZQszc3iUW
	 EKBLd/NxSeASQ==
Date: Mon, 07 Sep 2026 14:38:12 +0000
To: Paolo Abeni <pabeni@redhat.com>
From: quanyeyang <quanyeyang@proton.me>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, geliang@kernel.org, matttbe@kernel.org
Subject: Re: [PATCH mptcp-net v3 3/3] tcp: fix data-race in do_recvmmsg / mptcp_recvmsg
Message-ID: <kyD8pyPeuFAMSwx2Xib9rP3IJNRIwPnmHhA3gJro06kJTAPQ_5RVXucZrTglP3oSoltaLn9vhYO7G559fEg1sA2J8TDIiiVAkhtD3yGPLbM=@proton.me>
In-Reply-To: <14749060-d011-41e7-9a4b-754eb5bd9d5b@redhat.com>
References: <20260907-mptcp-snd-una-race-v3-0-65ba0d5f0221@proton.me> <20260907-mptcp-snd-una-race-v3-3-65ba0d5f0221@proton.me> <14749060-d011-41e7-9a4b-754eb5bd9d5b@redhat.com>
Feedback-ID: 206494642:user:proton
X-Pm-Message-ID: 663e4a0c9b4fc4142babd338f80aafd395e618d0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, September 7th, 2026 at AM 6:47, Paolo Abeni <pabeni@redhat.com> =
wrote:

> On 9/7/26 12:15 PM, Quanye Yang via B4 Relay wrote:
> > From: Quanye Yang <quanyeyang@proton.me>
> >
> > KCSAN reported a data race between do_recvmmsg() and
> > mptcp_recvmsg() on sk->sk_err.
> >
> > do_recvmmsg() calls sock_error() without holding the socket lock.
> > sock_error() atomically clears sk_err using xchg(), which can race
> > with the plain read in tcp_recv_should_stop(), even when its caller
> > holds the socket lock.
>=20
> It looks like the same data-race is present for plain TCP betweem i.e.
> multiple concurrent recvmmsg() reader? If so, I think this patch
> could/should go separately directly into the net tree.
>=20
> Also please include the full KCSAN splat.
>=20
> /P
>=20
>=20

Thanks for the feedback.

Patch 2/3 is independent from the other two patches and can be applied
on its own. Patch 1/3 can be dropped, and I will handle Patch 3/3
separately as a direct net submission.

Please let me know if you would still prefer a single-patch v4 for
Patch 2/3.

Thanks,
Quanye
