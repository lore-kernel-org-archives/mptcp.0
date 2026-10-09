Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F6C3438B9
	for <mptcp@lists.linux.dev>; Fri,  9 Oct 2026 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531074; cv=none; b=sDwFxhJuA40QDEAyKhv1oZ4MsnSUceY7vIEoVNtLPWe2Jrsxk3HujbetB8iWAwwBN+UmiI7+3qvQv5nD6v9NrqBocb/+Obt1J8TIDfQJlTG7EK8L73EP4QwFA548cxi3b3E+HXUS0UrzLb+Rvt4LN3vJa7SreC6k2PgA2ZHRlno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531074; c=relaxed/simple;
	bh=JqR2tyFi7T67Of9RjUuj7LYvawBZvvJ6OZhkReqqc3E=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Pzd3IT2b/X14xcp5agV464Ruh9L84JtCZ6r70FO/XkVuQG8o7LAZO6vcsp+wriKrktHXoaoW6mY+lJ5Jw6qJY9LBB1x8yGig1pKJMAw8bDzkdk2p8p9UaFtOzdbNikh9eMChLZfq6crcHNSOIZrzW3DOvZnsxTyMcu8jn3NXYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYBHOnxY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYBHOnxY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1FE1F000FF;
	Fri,  9 Oct 2026 07:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791531073;
	bh=JqR2tyFi7T67Of9RjUuj7LYvawBZvvJ6OZhkReqqc3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HYBHOnxYYFVku+n6KE3Y53WthtMrZXPJ+W7KaFW6JVobOLQNUlU/59OkykRdCPBrn
	 TiWYfdnkSVlnBs84R+lbtCuq4Q4a8qkPvOTdFBqJbOC4aWiUY6PE9v4DVGb6EvFSxt
	 IARQ0p4LU9jHPrPd24lYsl3XsgOwtjBZthn/91Kq81RnbNWbA5CEl9E5LsT7dj8Vye
	 mueXYbUIDzfKaK/Du1ULgEOujHbztltiZPbomWLhUuLxqJPx/QvXCG0iJmATkABpHo
	 OHX4EoG4bmShLDVzkzGoXJv7FagXYp2VY9WolFxgj5sHCx/x+0aAhdrJOwImrrEZ+t
	 +8+nvLxOkBMbw==
Message-ID: <sashiko-outbox-165003@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next] squash to "selftests: mptcp: convert
 iptables to nftables for mptcp_join.sh"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hangbin Liu" <hangbin.liu@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20261009-mptcp_rm_debug-v1-1-a7b4fdbe1b5f@kylinos.cn>
References: <20261009-mptcp_rm_debug-v1-1-a7b4fdbe1b5f@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 07:31:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests: mptcp: incorrect squash target in commit message
--

commit 95308d8ced7d193c5aadb0348b4665a25a875b28
Author: Hangbin Liu <liuhangbin@kylinos.cn>

squash to "selftests: mptcp: convert iptables to nftables for mptcp_join.sh"

This commit removes the syn mark rule from the output filter in the mptcp
selftests. It is intended to be squashed into a previous patch converting
iptables to nftables.

> squash to "selftests: mptcp: convert iptables to nftables for mptcp_join.=
sh"

[Severity: Low]
Is the commit title targeting the correct script for this squash? The title
explicitly states "mptcp_join.sh", but the diff exclusively modifies
"mptcp_sockopt.sh".

If this is squashed into the "mptcp_join.sh" commit, it might cause confusi=
on
about the patch's purpose or result in applying the squash to the wrong tar=
get
commit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-mptcp_rm_d=
ebug-v1-1-a7b4fdbe1b5f@kylinos.cn?part=3D1
