Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792932617;
	b=UkyiEHegUVYV4Qeqnbo3JyD0LF9uKujCN+KKYxDemSTX7rp0LA7pxTPJ1gGVkbBQ7Eg9
	 fvUDX8pUu2f9nuvxmE6hPp2ibPTCUaKCRuFz+NtZK+pSQfluSOEy/gNs6mWV1vtSBZZ10
	 k4TlloGzgEyuK2erkGe4OB9LZrOwYMEE8JDuaVCijZWi12mabT9nzohfyZ57Q3BWR4OdY
	 wFsjhEA7GtRl6DUxu1F1iWU6QhxszJoINAjaok9jNuzUBNpjIsbOq+wxX/5H3emUcehw1
	 92LnABkMFjwI7stsq1vGJtKqjCFHpzDRXGuZSQ9G/CNbnLzm+necQEuj5pfc/Gey2vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792932617;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ucPUrtj4rhjkkb1q02oJOTxhMLbgAeAg2YgljwH7ZO0=;
	b=F9GutczEM7DG4LZRQZE2QJ7Qb/1KnpO5lvdN03qPX88MV7AI9J+T70zgckmC4p4OpPUX
	 O/trEJxKz0QCAS83wIzACis0diLeVi70Ld3pU2N/J1+sMPiW71/8SQvg6CjsFuljq5hWT
	 y7qVMav+W4Q8+f5UjB5T8YtBG9XOnm4YGIYGtYPiAs2obmNTEtDtOxwf29dx3uBXVVfM6
	 qHcq/BKLg8kBAh5wOAFw1VijkwYYHPR0CBD+yNzj2o0DufTX1uAjinhivh9pyt4jyMUmT
	 saH9JQP/WK6zXxEf7IWUS21jIIwoe4Jj4fFRUhOeiZ2HrV7GkIkf38ddhSn/7EKQ1rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=bo26s3obpjgxzcjor7jwnntu7a.protonmail2 header.b=dT9MMsSe;
	arc=none smtp.remote-ip=109.224.244.24
Received: from mail-24424.protonmail.ch (mail-24424.protonmail.ch [109.224.244.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7082C606A31A
	for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 12:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7082C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=bo26s3obpjgxzcjor7jwnntu7a.protonmail2 header.b=dT9MMsSe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=bo26s3obpjgxzcjor7jwnntu7a.protonmail2; t=1792932614;
	x=1793191814; bh=ucPUrtj4rhjkkb1q02oJOTxhMLbgAeAg2YgljwH7ZO0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dT9MMsSeN5YHm6lqD+pYBu1up3akJGIFMkHKmlHPJRm81jtd3+YlgxYBkvfBoncCJ
	 Af3a/2e9rwiIvqCz6y1/86rVDylxjD9Nj8QMYSjjbAoTPoeebdNlAIYkk42jx0XVeh
	 K5DtUBiicCzvQSMOkh6ZxqeRqA3rLfCrvyXWS0WPL22MiSikIUGMh/qZBBejTvvxLy
	 plG1hCHgniqqocEkqw6iwAvH9ojRlf6gqzGzSC2UfLyYDhbdjCXimE0r3YwfDo3zqU
	 wTzNghFflrgctyMc6gwv6GzTtaLerKLQQptbdDymshDVHavmLO7wTkr+LfvyDLW3CS
	 kU40OpYe9UtdA==
Date: Sun, 25 Oct 2026 12:50:10 +0000
To: netdev-bot+sashiko@kernel.org
From: quanyeyang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: sockopt: echo until EOF on partial reads
Message-ID: <1XrwbKHy7bqEAoICoQYwaNZzQ--JyQFbkUTMnIxpBYLCUAxob9CjFKXDAq_Sbl1OQ-MQPYb2LhNIU0Qr1h90ToNjyXrlJtqbP1wrPgzdeiU=@proton.me>
In-Reply-To: <179289965578.3132.14505074087260563831@kernel.org>
References: <20261023-fix-mptcp-issue-639-v2-1-14a3d3746d2d@proton.me> <179289965578.3132.14505074087260563831@kernel.org>
Feedback-ID: 206494642:user:proton
X-Pm-Message-ID: 9aaab04beb400342c298dad654a5e022e81724ff
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 23 Oct 2026, sashiko-bot wrote:
> [Medium] connect_one_server() passes chunk size to do_getsockopts()
> ...
> Should connect_one_server() pass total instead of ret to do_getsockopts()=
?

Yes. That is pre-existing in connect_one_server() and is not part of this
change. It is tracked as issue 638 and already sent separately:

  https://lore.kernel.org/all/20261015-fix-mptcp-issue-638-v1-1-5de999ad601=
c@proton.me/

This patch only updates process_one_client(), which already accumulates
nread/nwritten.

> [Low] process_one_client() passes size_t to PRIu64 in xerror()

Agreed on 32-bit. The existing sockopt checks already pass ssize_t the
same way. I can add the uint64_t casts in a follow-up if wanted.

Thanks,
Quanye
