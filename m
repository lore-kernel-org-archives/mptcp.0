Received: from mail.tradeharmony.pl (mail.tradeharmony.pl [5.196.29.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7923B15A86A
	for <mptcp@lists.linux.dev>; Wed, 28 Aug 2024 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.196.29.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724832827; cv=none; b=bb8PwVosA4Z0v5PlF1fBIemMzqbrbN6InU1YlxNNAWXa2yYr1BpAOzPU9SoMwP1b0IBlIZ3Wcuvo+WSoFkxCzTUZXVQmR9vde1acskAywl4K6VbqZIUYHZ2yQV1xbjczT9/cbF/zxx9arflgS28CqoqL2mhkygf+jfxttMtcuHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724832827; c=relaxed/simple;
	bh=siHX5jVClg4W32F/NjlCmIL8w17yqZEkZP0Dfrdd7Ok=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=iG2qsTKIR973vd0fgre55jUyriGrYEHmKGXybHxrhIyWGlYf0Lo3/YKhgM9EQwPXW1EG1koQ4PZvV+sx91YmVRIaEDasEPzV6tL2q0W4d8zKqRbfSLmOj2/tM7KykpSSPjyiVVu1KPNtEIUmh632tJjrQNfibuE++/s94KWqYJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tradeharmony.pl; spf=pass smtp.mailfrom=tradeharmony.pl; dkim=pass (2048-bit key) header.d=tradeharmony.pl header.i=@tradeharmony.pl header.b=l1olsatH; arc=none smtp.client-ip=5.196.29.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tradeharmony.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tradeharmony.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tradeharmony.pl header.i=@tradeharmony.pl header.b="l1olsatH"
Received: by mail.tradeharmony.pl (Postfix, from userid 1002)
	id CA6DD26D2D; Wed, 28 Aug 2024 10:11:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tradeharmony.pl;
	s=mail; t=1724832673;
	bh=siHX5jVClg4W32F/NjlCmIL8w17yqZEkZP0Dfrdd7Ok=;
	h=Date:From:To:Subject:From;
	b=l1olsatHnUpLSOJrfnZWTo5Ota8mpcq+O+/FMemAtESzzQPpICWjpSM4Oqjekwvbe
	 ft5btUaYt/xYLmpr1zFbitEb2EgceEzvv4O2KGIgZ4Z+wqViSxLCPmEkElOQ+6M/WG
	 lz6yVmwvQpC82krjGcif2/ajaTb65wkOFo0Fcrj15y97YJCKzaeabAN2BumFlvsioG
	 6p46XBe86Q5TUlYnqJ6K6hMkpa5zsB/qIiZfytflM0KQynYmfE0Lm3R47kIEXsItXv
	 fSV3rNGW+qkpFGhemxK5l4gULVDJbaIoYAe0OZFngDP00dt1ybRQ8ebir2kIgB9Ef3
	 FPUO7ZjydbPyg==
Received: by mail.tradeharmony.pl for <mptcp@lists.linux.dev>; Wed, 28 Aug 2024 08:10:43 GMT
Message-ID: <20240828084500-0.1.8b.2y0jd.0.0g9gbl6qi6@tradeharmony.pl>
Date: Wed, 28 Aug 2024 08:10:43 GMT
From: "Karol Michun" <karol.michun@tradeharmony.pl>
To: <mptcp@lists.linux.dev>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d_?=
X-Mailer: mail.tradeharmony.pl
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam
Karol Michun
