Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339181;
	b=ycjV/3RdyJRl9l3AzrCJ//oNgo3wRqwttVwsFZNdvuzDskpDSWp9Q/ipUM5chxFs6VNE
	 HACsLYiaLpnjAwRWadOe5shHDq1zIZkUOoaGPhTKHzwcobyh8VZla464gf3uJuITn7bLn
	 P0yIMRept7xgRQCzPdu21M2pvpbCUVEg+DIr/9wSRwqf/1BdMA3wnD78bC3ggr70CRpZi
	 qn30URuUt51KKgaWoJGIoG2MsZuHlAeppvj2pMHE6cpQC+sdZerzF2vjKaLWk+xNA+OdI
	 Mx4TZ2hll/NMMbGxB5kC+WkJHEclrgGyDZG7Pd+JQbGYhZStCncv/C8qFqQpTkX/9kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339181;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=w0UcxuDxa4YCB07DqKpaFij1q5Ua5NH3Zl17UtPxT5Q=;
	b=d8578W6U/03NuI7kyBKoTOaRxrAxL9eBl5ZMgofLHnyI6GBAkp2hWnRUoUwXNLALKBOD
	 xkASMkLPldtoYISLsXpn4NhnHEMNCNWIfTwHZkZrsznigSMRIulfSnhNgLCsvSlBbXc/X
	 bL/24gQ+It8HmpYMKd34k6rZiwE6Ixg2v5HF75cTEturSwrJ21g6YNPJpiY0tMFuUM4Xz
	 mSR2pRdtle3ufK/0gLlQeUHibvMVaSi0/K76zGfcOENn8vQi44mUkbFBv/sFmwCeN++FA
	 fzV15FJ0EtlSsT2QxWW9yo4D+NO4TObjL9arYdmDJoPdgWRIE1dcqMXqyBTLy88p2AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lDSh6Exy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97287606A320;
	Tue, 10 Nov 2026 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lDSh6Exy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65141F0089F;
	Tue, 10 Nov 2026 19:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794339181;
	bh=w0UcxuDxa4YCB07DqKpaFij1q5Ua5NH3Zl17UtPxT5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lDSh6Exy+QGJ6ov9BW6FMhxWUW7x0yX4itHc2WbUaCddaXajiAB2y41YjRN51+PfX
	 wiXh0Han2PCPBFCTeNUMFsfqKyma1xAmjw41p7fZWVLASmsXxSdvEccQkem8o6jHdl
	 v+TwrWjXIazjrbK7IeoGhcYMn6STbUqcKSiaR7du0SUExznJhJxSlhHoJENfNicN0R
	 nY/yXxe9QvfZZaVncLSs4ZQ6gXqqmJPu+9qjU8QLj3cj0G1sTT6Bs/kHgb4J2GXV+j
	 cB7KuLmoDjrj9MtVOo+OtrYqxRTglSOgSaIkVTKyXGT27qFViFQFghdF5HBhZkWvTG
	 ghF/Lvu7pGDPA==
Date: Tue, 10 Nov 2026 11:33:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>, MPTCP Linux
 <mptcp@lists.linux.dev>
Subject: Re: [PATCH net] mptcp: reject DATA_ACKs against a reversed send
 interval
Message-ID: <20261110113300.620d900d@kernel.org>
In-Reply-To: <aaf8b538-7897-40ae-ba2c-7eede4bef819@kernel.org>
References: <20261104130747.1045741-1-edumazet@kernel.org>
	<aaf8b538-7897-40ae-ba2c-7eede4bef819@kernel.org>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2026 20:10:37 +0100 Matthieu Baerts wrote:
> @Net Maintainers: this patch can be applied to the net tree directly,
> thank you! (Or did I miss my review window?)

Next time just look at patchwork state instead of asking.
