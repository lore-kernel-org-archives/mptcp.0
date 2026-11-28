Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795864823;
	b=S4e5t79bq9WGPB09+kCte56kyJr43ycgyUAqI6gcNX1fjh/624kWi5CIlsfgz12ar5+m
	 U8jxzOBT/vy/UCdylVftHMUzzsiQnMIsoDkrujr00zHhlPLPadPn1aaZB9DWUAKA+T0xI
	 EkSoDrF2l7IvmwrmZLuYOEu3wTW+ocjMk/J7V1wLkDfBT2GOgfIgrd0U+czWhG7USLPly
	 Lr3eAq4V8N8Ag2vtwRwuNCCcHPKxWigTp3lkREld2mk1fBwDu9w7FUpV4fPEdqkCfCs38
	 ku2XkBc7eZFBctYesJFyg44CaasGMEDu/N9Ant4mGpiTpw5yqFLB73sJ9S/85vLvQLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795864823;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jI7PJyjB2Kukv2xfKTyd8H3/t9Z5JAE1JHL7X0K7tA4=;
	b=plubPJj+a/tjVQ1SKmnXCHk7EcjB0ydGh7o+sqcV8PPH0SMwMG8yGinGJg2zcILFaJee
	 9008oFLB9BCW22iJWGnE5sh4YtIVk6PNTirj5eg94ZOcGOsKILOSrQ2aKo6lWen8AgqQM
	 WWUzn4sciMj5GI4TTnitXOccM7Oja5A1ze/3G8N+DZqlcTPWjv9LfhHIq0mdibFbWjZY3
	 HAKWriwq3A230R5f/pp+t4sz8LnvPLIyA69hs8NNZ1i+Ec2GTQ4o11xRZD1t/rV62PWlb
	 IMQTe4mNvsEZFPAbupyyGNtDkTWRaNEsjEjWKLXxoEjtA7+lkGW/OE4wqfq7L/s8Hkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6JXp2sa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A68606A31C
	for <mptcp@lists.linux.dev>; Sat, 28 Nov 2026 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6JXp2sa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3627D1F00893;
	Sat, 28 Nov 2026 11:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795864823;
	bh=jI7PJyjB2Kukv2xfKTyd8H3/t9Z5JAE1JHL7X0K7tA4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=c6JXp2saJ1Mca3l9+ZMRUyjxn3wLaUphgZROSrRVVs/vXTlaWPG/LKAdEA6st0DRu
	 t/rAA6Zm/4Bz1LDNlfvnUUkAoBak2G8yFoXM8+5Y1V/Dpxfff0ImFhdTvkUr7puSrd
	 P3eE5RR32gfPNuxRSKrh1N1cwv0Ixz9Rbyggc4RKXkKL2CA6/+KYJxb7wYkH43ZhRm
	 t2Io0QpisyETBfZYf65d9szhjzbnhZyVYOkV6XfqTzF93kmACzN96j3kKfqTxrjsKW
	 ftIuWNo+tlLcufjl+dWPK/dXq7nFakbJDrNddFCAQ0pr2aQiVtG8Yk9AZkL6H3j/33
	 l9nwuqbJZMC/A==
Message-ID: <sashiko-outbox-238656@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v4 2/4] mptcp: use SOCK_DONE in mptcp_inq_hint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <a9eb2043cc9dec009979c30c940f940f2cba2953.1795863454.git.tanggeliang@kylinos.cn>
References: <cover.1795863454.git.tanggeliang@kylinos.cn>
 <a9eb2043cc9dec009979c30c940f940f2cba2953.1795863454.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 11:20:22 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] mptcp: inaccurate SOCK_DONE setters and behavior description in
  commit message
--

commit 29686dc34959b6d287ae3e6764bcdbaa2489bcad
Author: Geliang Tang <geliang@kernel.org>

mptcp: use SOCK_DONE in mptcp_inq_hint

This commit switches mptcp_inq_hint() from checking TCP_CLOSE and
RCV_SHUTDOWN to checking SOCK_DONE when the receive queue is empty.

> mptcp_inq_hint() checks sk_state =3D=3D TCP_CLOSE and RCV_SHUTDOWN to
> decide whether to return a non-zero hint when the receive queue is
> empty. This is redundant: SOCK_DONE is the canonical indicator that
> no more data will arrive, and it is set in all the relevant paths -
> __mptcp_data_fin_incoming(), __mptcp_subflow_error_report(), and
> __mptcp_close().

[Severity: Low]
Is the commit message accurate about where SOCK_DONE is set and how this
changes mptcp_inq_hint()?

There is no __mptcp_data_fin_incoming() function; incoming DATA_FIN (or
fallback TCP FIN) sets SOCK_DONE in mptcp_check_data_fin().  Also,
__mptcp_close() sets sk->sk_shutdown to SHUTDOWN_MASK and orphans the
socket, but does not set SOCK_DONE.

Because SOCK_DONE is only set when a peer DATA_FIN or fallback FIN is
received, this is not just removing a redundant check: on an empty receive
queue after a local shutdown(SHUT_RD), on a closed or unconnected socket,
or after an abortive MP_FASTCLOSE or fallback reset without a prior FIN,
mptcp_inq_hint() now returns 0 instead of 1 (matching tcp_inq_hint()).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795863454.gi=
t.tanggeliang@kylinos.cn?part=3D2
