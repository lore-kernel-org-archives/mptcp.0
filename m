Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1175353A91
	for <mptcp@lists.linux.dev>; Mon, 31 Aug 2026 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173588; cv=none; b=T3fkm6+Wsc+rDmKKFX70nkYfTVp0hHzRYYiFAU89mCAb3CSheNYvvxDOTuKAhR1ZXzfdviFg07TIUiA8HXLmhrmC9p86LCJG+YO9JpOJbB7xdY+QVSdILyO6tjXiNT9P4JAtEXp9SB47Z9NR6vLVIJui3wipOlfDnVou52yeFjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173588; c=relaxed/simple;
	bh=PKOePct3Pqs9muACJ2UpGyeK4K00eo777BaHkcGTGxk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AsJnQxE0mfTBifl31ozC0JDECseKoOqAMX21MdxhI2RVVmfSDss1bHzhsrX6PYK0iAlCA6yG7fJBneN9f2fbVwPS99Diz7H8aivP4/tJgUdiT5bozQ/ci+QPwUXcYjaGr0AooNAX0ujZBN7dmxaW6oJckxKhuqv/0cViOInUasY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBdlIy+3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBdlIy+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1459C1F000E9;
	Mon, 31 Aug 2026 10:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788173587;
	bh=dDDqfgUCEB0qEHgnZaAMQz4iY7yhQrbAl6DLxL7QZmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cBdlIy+3c/AInGdgqWdJYANaxTLXun2IQEGlOv2osrI+Ndx9X20zB6iutJ2Ux77va
	 zUpnL6lhHeJLrdJCPbiCn53gnpcFVl56fmBR3gZKFSjBo1DeU41LkkE4WDta7h1AP0
	 pkX0dCHm7lsv/JNyhhs7EgYO/qye+6DaZPhw+r+VAIL33DcGxUyEJtSLKVA3jhOVdV
	 mo5PSFXyreWk4gFpfJYYxEclqRtvTmmZLYkDDnocwig4TE6UQ/NV8oqr2NnYoesPUz
	 1zov1U9obVzJPBOL55VyaevbHn5YQ1/Zp1BA27bVUWMpZxKDzf5+2sef1iCQwVsRh4
	 9QRGpty9fdk+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v12 06/10] mptcp: align FIN handling with TCP
 via SOCK_DONE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <916f17d4a2b1e948fd89634e57552243564a0d59.1788171508.git.tanggeliang@kylinos.cn>
References: <cover.1788171508.git.tanggeliang@kylinos.cn>
 <916f17d4a2b1e948fd89634e57552243564a0d59.1788171508.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:53:06 +0000
Message-Id: <20260831105307.1459C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Memory barrier API violation: smp_mb__before_atomic() is used befo=
re a non-atomic bitwise operation, which fails to emit a hardware memory ba=
rrier on architectures like LoongArch, allowing store-store reordering and =
breaking synchronization.
--

commit ed77cdb78ed1ea97ec780c81ea48c8eba994517c
Author: Geliang Tang <geliang@kernel.org>
Subject: mptcp: align FIN handling with TCP via SOCK_DONE

This commit aligns MPTCP's FIN handling with TCP by using the SOCK_DONE fla=
g=20
to mark FIN reception alongside RCV_SHUTDOWN. It updates mptcp_inq_hint() a=
nd=20
mptcp_recvmsg() to check SOCK_DONE, ensuring the FIN handling only triggers=
=20
on a real DATA_FIN.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9bcca31501e7d..f970b92429726 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -736,6 +736,7 @@ static void mptcp_check_data_fin(struct sock *sk)
> =20
>  		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
>  		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
> +		sock_set_flag(sk, SOCK_DONE);

[Severity: High]
Does this memory barrier adequately protect the store to SOCK_DONE on weakly
ordered architectures?

According to the atomic operations documentation, smp_mb__before_atomic() m=
ust
only be used immediately before atomic RMW operations. Since sock_set_flag()
uses __set_bit() which is non-atomic, the barrier might not emit a hardware
memory barrier on architectures like LoongArch (where it is defined merely =
as
a compiler barrier).

If the CPU reorders the non-atomic stores, SOCK_DONE could become visible
before the ack_seq update in mptcp_check_data_fin(). A concurrent lockless
reader in mptcp_inq_hint() executing smp_rmb() might see the new SOCK_DONE
flag but read a stale ack_seq.

Could this cause hint_val to undercount by 1 byte and potentially hang
TLS/BPF consumers waiting for the final byte? Would it be safer to use
smp_wmb() or smp_mb() here to guarantee store-store ordering?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788171508.gi=
t.tanggeliang@kylinos.cn?part=3D6
