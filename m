Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482331;
	b=CXFy/ooJtfgHY0TNFJRnNuyLyCiKZ2lDicYbrE3OkM+zWtIrQ/ac/w71VQCiM9Uehqya
	 lb5FqOfNr9MgLtBeUWkiBjY/ufvSu0nvpqYqIIgAPclQLDR4k7m640QH6gK2yDh7KdBd/
	 5Prnco+CFkB1YoMbO6fJTVSmPTnt2pFTsrmvZ13Kmyo95Fi3LQyjyKJIFZpeJmMowKtER
	 8ssINmJk1r1ah3MErvQKrxAQ4amWlOqUpRARTl4eeyWh2it+4oFFXm0etO0VwteQJdnXl
	 CJZlk0eX320vlTkjnTlyOqoVCxjdl1/lBKLxizEvbxSrN9dUBjzbUKhIp45KaQw2CVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482331;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=8RpeiboGQNacPtPiG3iW2EcvywiIZJwxKeXwV+ruIVw=;
	b=GkwP6LaLVaEsaeqJ3v5rRnKZRYIBEDeTKGMZppmLK+OGXTFVP65bku3WF97ZDZpHPDfG
	 RrpT7ULwZhWXIXBTb2jdiiNYzCXvdM502tEmAu9E+xBxvqZXgVQhAFEWjtGtlDjY0K8uv
	 R++Tt4FP0UEXJ++iaSl0Wwt1L2OHzZH7mVHoRQB9MO2ETaTqeTaxauMOBPAozy4HQcPPh
	 UYcZp6TnwFyJ/LpVqiL26ivNk+1pc2n03QqRePCrKdQYXastAsBs9cgEbyNpA05rwf78h
	 cOH75MGSkiNfWwJHK+WUCvce7pZucw0H2qHb1Fp9sdZRKolhQix2xcKP3IqhEp5HRqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akH3Somj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6110606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 01:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akH3Somj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AAA1F000D4;
	Tue, 24 Nov 2026 01:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795482330;
	bh=8RpeiboGQNacPtPiG3iW2EcvywiIZJwxKeXwV+ruIVw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=akH3Somj3AG+PSpnu+IcrQO8slFJQmhgIq+EB4OPNbK929PIVvKtKcYv8uzvpj0aE
	 XHZnnfBCP3kQXZ4AwGQRIwDZjNoMxkC7Ly5zmAyLBSiqZ3CbDT7eeW14Y2pBtZjhJB
	 nQgSzG4FpW5skrl4qs0adn9tbqe9cBZZHtCzNnZNxvzOLTaGNj3pqnvAKYukPZ6LgO
	 OvPTN6R3O4sTyIN7tkCajXItEc4PxZ9T19jBPJ+eQNUVgjLMPXX01irmThKHf0lWZI
	 7y3+5TbSey7juRKIhu/Wb59b3j7cXKxw/LK/BlIcluULEF3MOe/T464rS3OKm/liZb
	 sfWkVWdavBOqg==
Subject: Re: [PATCH mptcp-net v2 4/4] mptcp: add mptcp_inq() for SIOCINQ
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 24 Nov 2026 01:05:29 +0000
Message-ID: <179548232967.3133.6523672027761488381@kernel.org>
In-Reply-To: <66c8d6fa77da5d076888ad6199f1699bf513fa28.1795348666.git.tanggeliang@kylinos.cn>
References: <66c8d6fa77da5d076888ad6199f1699bf513fa28.1795348666.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The From:/Signed-off-by email addresses do not match.
- [Low] No in-tree selftest covers the behaviour this patch changes.

--

mptcp: add mptcp_inq() for SIOCINQ

This commit adds mptcp_inq(). It reports the readable bytes at the MPTCP
level as bytes_received - bytes_consumed and does not count the DATA_FIN
byte. SIOCINQ now uses mptcp_inq() instead of mptcp_inq_hint(), so
FIONREAD matches tcp_ioctl() when DATA_FIN is pending.

>     Co-developed-by: Zqiang <qiang.zhang@linux.dev>
>     Signed-off-by: Zqiang <qiang.zhang@linux.dev>
>     Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author address and the author's Signed-off-by
address are different:

Author: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

checkpatch doesn't read .mailmap, so this patch triggers its
FROM_SIGN_OFF_MISMATCH warning.

Could the author and the sign-off use the same address?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7ef37f978f5b1..d9144fffe0163 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4153,7 +4168,7 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
>  		lock_sock(sk);
>  		if (mptcp_move_skbs(sk))
>  			mptcp_cleanup_rbuf(msk, 0);
> -		*karg = mptcp_inq_hint(sk);
> +		*karg = mptcp_inq(sk);

[Severity: Low]
This isn't a bug, but does any selftest cover the FIONREAD change made
here?

The MPTCP selftests call FIONREAD in only one place. It is in
process_one_client() in tools/testing/selftests/net/mptcp/mptcp_inq.c,
inside the polling loop that runs before the peer shuts down:

		ret = ioctl(fd, FIONREAD, &queued);
		...
		if (queued > expect_len)

No DATA_FIN has arrived at that point, so mptcp_inq_hint() and
mptcp_inq() return the same value.

After the "shut"/"closed" exchange, one data byte and the DATA_FIN are
pending. That is the only state where this patch changes the result. The
test only checks the TCP_CM_INQ cmsg there:

	iov.iov_len = 1;
	ret = recvmsg(fd, &msg, 0);
	...
	/* tcp_inq should be 1 due to received fin. */
	assert(tcp_inq == 1);

The cmsg value still comes from mptcp_inq_hint() in mptcp_recvmsg(),
which this patch doesn't change. So the selftest passes with both the old
N+1 result and the new N result.

Would it make sense to add a FIONREAD check that expects 1 just before
that recvmsg() call in process_one_client()? The old code would return 2
there.

>  		release_sock(sk);
>  		break;
>  	case SIOCOUTQ:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795348666.git.tanggeliang%40kylinos.cn
