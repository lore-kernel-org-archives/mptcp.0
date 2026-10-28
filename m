Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793168979;
	b=XBlDIrvC6oyOnQGGuM8arjo/QO9s1wFWxNg+YXZwRmwETPNeYJZDpHVZ3RfxY+jGYbfh
	 P8aL9RjbPALuOZDjWF55uLx+wW3rT12rGONJMmv5o71yIN79mwYu4D4pb6yOowm/LOWT0
	 RD9TgB1ELdFtKtPS1OAK9DQtopxkrb2Tp/9Ki4edsHIb2MTjpo1obRGFc6ljkykWdr27Q
	 zsk+IaqtuQL93EiFKD50uzeyUyjl9yJC9xAwBec5kOiAvm1C8fmccWM1hpveeY8NunIBF
	 9ppJegAi5tbAAiXtWI2+v2csXodG5N5vQ4fmgsJ7g7CbcRVQmUFejR5SpLFXx5FL4gw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793168979;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-ZohoMailClient;
	bh=q5RKwPySfLEY16tvH/kt6j1ARsuJUBofOEaeTQdSiAg=;
	b=ASN1cuLSVDx9mK9ULX60/PGq7lXcFTDtRd0rQ0/T+qMAQ48HerTxLHsuTg/dz+lVlX9G
	 VXbkhZGQzI3uhJgeB8AXL3480nJj+OuHRJtLmj1Dp4PJKPaxQPUjFn4Jujy+Uz8VMpUwK
	 Wq45XDlBavXAXOwPI9Ap5P8d6uW4r7phbknW9Id6hA77eXZEt6pd7qls0ep0VGt5i6rh1
	 Qzpb1sHCJlOgwkPw0CQEiGGrumhTO8AE6Qbzi0XyXg0HnrgoartVlLdsXpZPaWWHMjS1j
	 6ROwaeWPdmytOrBev5tm0pJezIickUMUg269i5bqGAR+Wae0ZamrETeB7EI2A5cGLog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC23B606A31D
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 06:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC23B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1793168967; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Da9kR8kroegGRDTrSA91ABoHtXEowL4ugUn8fzjPBRs067LVPBTWRIOtUMA6GH5up3rggJeee/YtUIwHHDLgWC4fQVGYNkRKBXz3M4+Xkkwfem06bm7daYpgx/2I5r9QQ4+ZiZxZi+VCfNqyPJkflChU4LXStKSE3TP0oTv7OUc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793168967; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q5RKwPySfLEY16tvH/kt6j1ARsuJUBofOEaeTQdSiAg=; 
	b=Kdkcgqjwx2Rg+eKuLqtf9rCF9g8tc9JqnQmji8L3zK8qSWlBYBzMcKjQrS5eHkuxEyi2lfxB4NAqHFjwenStWI8gwBVdpity3joyWdkVk0IkF74IEKzJFvRFX3e8QdOxszeBtOvr/nTwEj1nUm3uranYbeWbkzay7xdFvk9iHqQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793168967;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=q5RKwPySfLEY16tvH/kt6j1ARsuJUBofOEaeTQdSiAg=;
	b=YKZy88lmMotHUP7iRuOuTCPzX1yHe5nNSS+aeQAI9jnyCRzqY/BUu7DM1UB5+TP3
	9GFHhlIKXAaC9hC2xPqh/1SYmQJGRMscPUiHd+7M+3ip25iqWhvGOvRrTdKd0/I4kUP
	xKdUPCJMIBLHyIloT+6Ry8nfPJzI8vY8HllixT6w=
Received: by smtp.zohomail.com with SMTPS id 1793168963964275.9814121849146;
	Tue, 27 Oct 2026 23:29:23 -0700 (PDT)
Message-ID: <6ac6cd6f5c7d67c598ae34bbf3bcf6a0edd0e983.camel@mpiricsoftware.com>
Subject: Re: [RFC PATCH mptcp-next 0/1] mptcp: opportunistic reinjection on
 an idle subflow
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Matthieu Baerts <matttbe@kernel.org>, Abdul Wasey <w453y.me@gmail.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Gregory Detal
 <gregory.detal@gmail.com>, janak@mpiric.us, kalpan.jani@mpiricsoftware.com
Date: Wed, 28 Oct 2026 11:59:15 +0530
In-Reply-To: <6fbbeca8-836c-46cf-a8de-73ecd127b932@kernel.org>
References: <20261025134643.1537069-1-w453y.me@gmail.com>
	 <5e0ccd66-205f-4055-8ab3-4d300e83fd48@kernel.org>
	 <20261025155848.1745712-1-w453y.me@gmail.com>
	 <6fbbeca8-836c-46cf-a8de-73ecd127b932@kernel.org>
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

Hi Abdul, Matt,

On Mon, 2026-10-26 at 11:13 +0100, Matthieu Baerts wrote:
>=20
>=20
> > Moving it to the scheduler makes sense. The CI also caught it on
> > v1: the
> > BPF "first" test saw bytes on its second subflow because of the
> > reinjection.
> >=20
> > Gregory, are you still planning to continue the scheduler API
> > series? If
> > not, I can pick it up.
>=20
> For Gregory, I'm sure he is not planning to continue working on that.
>=20
> > Shardul, same if you already started on it.
> >=20

I have not started on it, so please go ahead. I am happy to review the
series as it comes.

Matt, sorry for going quiet on this after we discussed #332.

As you suggested, I am resending the penalize subflow series rebased on
the current export so that Clashiko can have a look.

Abdul, one point on the RFC that should still apply once it moves to
the scheduler, since you asked whether there is a better signal:

mptcp_oppr_blocked() treats an empty send queue (mptcp_send_head() =3D=3D
NULL) as "blocked". first_pending is NULL once everything the
application has written so far has been handed to a subflow, which
happens when the send buffer is full, but also when the application
simply has nothing more to write at that moment. In the second case
nothing is stalled, yet the data still held by the slower subflow gets
resent on the idle one at the next DATA_ACK. The commit message
describes the trigger as the receive window or the send buffer being
used up, and the window case is covered by the mptcp_wnd_end() check;
the send buffer case is not checked as such.

Requiring the msk send buffer to be (nearly) full on that branch, i.e.
sk_wmem_queued >=3D sk_sndbuf as __sk_stream_memory_free() tests, would
separate the two. Note that mptcp_stream_memory_free() alone would not
help here: it only counts the bytes not yet sent, which are zero in
exactly this case.

One more observation: #345 and this work both act on "this subflow is
slow", one by halving its cwnd and the other by copying its data
elsewhere. Once both are in the scheduler it may be worth looking at
how they interact, e.g. whether a subflow being penalised should also
be a source for reinjection. Happy to help with that part.

>=20
Thanks,
Shardul
