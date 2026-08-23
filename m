Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD943769E6
	for <mptcp@lists.linux.dev>; Sun, 23 Aug 2026 01:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787447715; cv=none; b=WIyU6LcsbZM/4yg/aUhYFrpwfKJSCEeyOcFS2K0TxKBW1MxXayf3Sb1nCVZbV1Eq80Hka9/BA5gvIn+uH9qCLx/aEqtEq7KCmh2nmqdhWRiqSV1Yku21FRXJmhsNhZJKQs2miVJH0quLW0WXsC6pWsEqj+L/TawcdhqxWiTBQOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787447715; c=relaxed/simple;
	bh=RTU0Oxc6f932b6b0iyfPAACy/l2RKHGyIph30ngBrGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I6b7gVC/uUC26ZOUpR/MktV+W6VzAmUqZmU1FHwqknsYJEaFStTdzck1Y8VfXoFfgjDsyW2RSSIPXyNWc1UbZiBPIIcR4u/qu58dyVJbcTL8i+uY73CoDrHFb4eeJUjp8kMotJ1rwO0nub8Vs5TMxTTnWhSuoTc1qnVsAGpJtMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWbRpSoS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWbRpSoS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1BF1F000E9;
	Sun, 23 Aug 2026 01:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787447714;
	bh=UzhT3ziCY7duNDK8ZK+depiz6uWyppaC8hU3qxJYcX4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SWbRpSoSq7hvmRH5C0u8D/etqxOTVPzBfJjP8HP9xXuzp/aW+vkYCpbDvSbg8Z3WP
	 KCYE8nPEvsyPQDzY0XqFTuVD658OnSd41noWT7JYBSw5WJ4UEtcAPVS8EY1ARKDSt4
	 lt6CqCoXyg+y08nZCM39Zlt8cMYBdXJRFEoFKTb6BVLLXLAf4Bu6F2KOK5sABizz8B
	 +XVCWEHmDiZLdqD0J5P/Ym1axPuRxZ9Q842UMYbyivqdpQNTkgHEnWeDAWIStH0TbW
	 BGUpmjGQAHVy4jRGiYtmYUFyo+8rzsz1IOsGKbLqyGZyv5pMEnz+W1iRJ4jkVY6Jwd
	 +iK9DfclrzFcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v6 4/7] mptcp: sync mptcp skb cb layout with
 tcp one
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <a853bdf73cee05be30ba12f51cfaa3897d56930f.1787446274.git.tanggeliang@kylinos.cn>
References: <cover.1787446274.git.tanggeliang@kylinos.cn>
 <a853bdf73cee05be30ba12f51cfaa3897d56930f.1787446274.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 01:15:13 +0000
Message-Id: <20260823011513.CE1BF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Torn read/write of 64-bit `msk->ack_seq` on 32-bit architectures, =
leading to corrupted MPTCP Data ACKs.
--

--- Patch [4]: [PATCH mptcp-next v6 4/7] mptcp: sync mptcp skb cb layout wi=
th tcp one ---
commit d6240ab2e98090a0998cc27a5a2729d562ab8ffd
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: sync mptcp skb cb layout with tcp one

This commit limits the MPTCP-level sequence number to 32 bits after
validating against the receive window. This allows the MPTCP CB layout
to align with TCP-level fields inside the control buffer, and adds
build time checks to enforce this invariant.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0700cdab7f2ed..2e0e8e85b4d0f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -892,40 +899,40 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *ms=
k)
>  {
[ ... ]
> -		msk->bytes_received +=3D end_seq - msk->ack_seq;
> -		WRITE_ONCE(msk->ack_seq, end_seq);
> +		msk->bytes_received +=3D seq_delta;
> +		WRITE_ONCE(msk->ack_seq, msk->ack_seq + seq_delta);
>  		moved =3D true;
>  	}
>  	return moved;

[Severity: High]
This is a pre-existing issue, but can this lead to torn reads on 32-bit
architectures?

Because msk->ack_seq is a 64-bit value, updating it with WRITE_ONCE() in
process context here (and similarly in __mptcp_move_skb()) without holding
mptcp_data_lock(msk) might race with concurrent softirq readers.

If incoming subflow packets are processed on another CPU, they generate
TCP ACKs via:

tcp_transmit_skb()
  mptcp_established_options()
    ack_seq =3D READ_ONCE(msk->ack_seq);

Since this read only holds the subflow lock (bh_lock_sock(ssk)) and not the
parent MPTCP socket lock, a concurrent 64-bit WRITE_ONCE() on 32-bit systems
compiles into a non-atomic dual 32-bit memory access.

Could this torn read result in sending a corrupted MPTCP Data ACK to the
peer? If the sequence number jumps forward or backward unexpectedly, might
the peer incorrectly assume data was successfully received or have its
connection state disrupted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787446274.gi=
t.tanggeliang@kylinos.cn?part=3D4
