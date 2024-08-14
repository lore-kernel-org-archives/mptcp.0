Received: from mail.tradeharmony.pl (mail.tradeharmony.pl [5.196.29.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7D77F11
	for <mptcp@lists.linux.dev>; Wed, 14 Aug 2024 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.196.29.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622442; cv=none; b=O+8QJdbIt+9MVuhjCUh3x809ZHKUhZQIhZjgxDYEG9ai87ti2QH9jgAaMBNfraijLujO34PYoIBFp2T/E7ikS0UYcJnXpTEqakFStoCXN9pVTkXFx88cSRIi7Yaytwyq+sCfIysP7VcPKdYf7TUiHXvng0MCuarz6pmD2ir/stc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622442; c=relaxed/simple;
	bh=siHX5jVClg4W32F/NjlCmIL8w17yqZEkZP0Dfrdd7Ok=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=u7Ws5V4NueK+22BpVGP+dQt69aU8cVlc1d2txaxDr8YvfL4nYt/hy2mBzGqMmy51j78TnXNdnzKhBjBch0NpqZHYh/wpfNeahMHjet0qKn/KKXMQ6r8rO/6RwSEUXeQlv+oRjxl9PmB8+evPvWXs+Ttz2lxKUgWLElMFUt5+1hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tradeharmony.pl; spf=pass smtp.mailfrom=tradeharmony.pl; dkim=pass (2048-bit key) header.d=tradeharmony.pl header.i=@tradeharmony.pl header.b=OucIOyW1; arc=none smtp.client-ip=5.196.29.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tradeharmony.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tradeharmony.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tradeharmony.pl header.i=@tradeharmony.pl header.b="OucIOyW1"
Received: by mail.tradeharmony.pl (Postfix, from userid 1002)
	id 7C203229E8; Wed, 14 Aug 2024 10:00:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tradeharmony.pl;
	s=mail; t=1723622431;
	bh=siHX5jVClg4W32F/NjlCmIL8w17yqZEkZP0Dfrdd7Ok=;
	h=Date:From:To:Subject:From;
	b=OucIOyW1ElMpgt0rbIxJ+m+WRrX4ekAy2D1CR5ELYsfv5iQk/8XU+wHI7f/3vrUth
	 GXNna8D5vlfnBupZt1wvGgUbGOsDfMLQ/XHIOPtYiKxzXaGVVd6zfp4iGV50OmaIMo
	 MQOImfm9YBunUYaH90XodcCYmp3BTNrFAxAnCVAKY0wfT/RmNWIMoMVoPACd+lHQgH
	 Ws+nc1LzgRhdN7bxqMDv2T3Xh6gvjWWGkRFlaBuaaeergPZ51oZisRBkNw1uefIlBC
	 s28h6KoJ4Dw3G8tdkNraEpimUa9+0FijHhaQAmSeAUQOFxh5G4W64kYCS7Rnmt8Khu
	 IQf0DXdfiitng==
Received: by mail.tradeharmony.pl for <mptcp@lists.linux.dev>; Wed, 14 Aug 2024 08:00:23 GMT
Message-ID: <20240814084500-0.1.82.2suc3.0.k93r6e9cq5@tradeharmony.pl>
Date: Wed, 14 Aug 2024 08:00:23 GMT
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
