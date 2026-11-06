Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994799;
	b=IAW6yV4duHjVu8vw+C66YpPLPmMs96ah55I5LwiAEKUDjBob7sWf6O7zPrrN63w/VgRQ
	 MhVENFVzgxC0hIRH9lc5ig6gj3lvdn05dnfZ6f5QPr2mmYomVQMK2qXCfOX7WItX3TazJ
	 Rg/BrczTh+Q6z0nHTbQ28OeY0GnPeZSp2OKzRaNT0TxffMgRgKj3ljdjXYlpOBdJ0F0vT
	 4vh/zusucRDm8tgZBKfuVYkXfh4iI2QGGDA9PlK9qTOSW8Zjtt4fGrJUydniEwWXM8syi
	 iZS9D35v0I6ABE4lcfoolPNdy34pVOy6PdnXjd5lX5allrzQFeSVoHgITvnZtc9NEAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994799;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BnGa5cBVkYEM7YekUmBy3rHRj16j5PpMfPO9h+w82kU=;
	b=nEI/AZ5xMxdSzJ3pxiZoyRhTj5yzSfABgHXj00f+djOq9shQf1gEMJ74WOUkZS0JyFmo
	 VH4QM2V04wZhzMX6jrJi25sn16eFi6YtWI6ynUUaGJCFhXV8qCMCFGFxLZcy4CN34NrTq
	 pGNdMVkcBisfHBd5kHbcu3yMD83SRjkDkCwJBqPiC8++UqXX4/iB9sF5pjNSEBzGBKSiB
	 oqcKItlPAQHBWOhu7pr2JdZz2T/V8bQU+b+plZRo+T9whO6swhX4N7AzShfD+IWCzjqPr
	 sRJ7XiFDV9SAwpr+saPv5v2HxqT88v6Cdo5YwL0xxvMeOcsJB/Mhv3oTG7yqjQvep9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sp+QrPvW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FA3606A32E
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sp+QrPvW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6356B1F0089F;
	Fri,  6 Nov 2026 19:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793994798;
	bh=BnGa5cBVkYEM7YekUmBy3rHRj16j5PpMfPO9h+w82kU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Sp+QrPvW3qCTQH/jQ6lt0SNZrWtdW8cqjUK2W+PyWc37NUTL98Q23oX3wU80e7eZQ
	 9Z7tszfnNEv4LMDFcByr/IlpjOD/2/AvHUTJhm+XXdKElGSMgUbl9PIhJp+2EZ+ed/
	 XI0k07U2/3OnvASg/iQ8bn3ZwJdyBDt3ait1hgxQuzsWRKA4EELmXNdPBGsBHpxXkc
	 5n/6vsK0l2bMlW+sxxTb78u7E5PyfS1SGjb0jnhdtLE+OhAuhJLuC4g5NCGujkD6HB
	 oQBaPaWLmYTlkCcrPu1Ttlm6xGraYRQ04FEeUbLbBbClrllrXral6eAqjrL4oEUJl6
	 nubfFJz1DiIrw==
Subject: Re: [PATCH mptcp-net v6 2/7] mptcp: fix TFO SIOCINQ overflow in
 mptcp_inq_hint
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Fri, 06 Nov 2026 19:53:17 +0000
Message-ID: <179399479791.488855.16706068166152583136@kernel.org>
In-Reply-To: <be320c98076afd0dc17be24a8ad89b6ca9a59a09.1793860134.git.tanggeliang@kylinos.cn>
References: <be320c98076afd0dc17be24a8ad89b6ca9a59a09.1793860134.git.tanggeliang@kylinos.cn>
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

- [Low] The author and the Signed-off-by line on commit "mptcp: fix TFO
  SIOCINQ overflow in mptcp_inq_hint" use different email addresses.

--

mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint

This commit changes mptcp_inq_hint() to compute the available bytes with
mptcp_data_avail() instead of ack_seq minus the head skb's map_seq. On
passive TFO connections, the old calculation could return INT_MAX until
the TFO skb was fully consumed. The EOF hint of returning 1 is kept.

> Fixes: f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the Signed-off-by address doesn't match the author
address. The author is:

  Geliang Tang <geliang@kernel.org>

and the only sign-off is:

  Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

checkpatch reports this as FROM_SIGN_OFF_MISMATCH.

The previous patch in the series, "mptcp: update mptcp_check_readable",
is signed off with geliang@kernel.org. Could the sign-off here be changed
to match the author address, or could a matching Signed-off-by be added,
before this is applied?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793860134.git.tanggeliang%40kylinos.cn
