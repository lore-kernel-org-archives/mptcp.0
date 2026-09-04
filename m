Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A856308F3C
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507728; cv=none; b=DL3klfOp6teCvXqEHaXsoKS8kgjnISfsv+k9PPGggvLQiqR0qxAhECKgY9Qn0XbV6EXTAwXPo4JudyGg0vH1iW1yg2tBPDN8whyyEfo5q2WM8TuaE6aH3NlA5Rnyd+Uyy3zUIULT0COINi7oEq43Ag3rtrVq71CDT0VWT/P9GG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507728; c=relaxed/simple;
	bh=a81HfWUxEza7yOLoyyewUI3JRrO1Hshc1E6T3dPP8E0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eyP8JP2GYgTyghp4top/pp3A9C4TPH+J9m4PXcXz+58NmmbX1MukT6+FojAD4oxppxQ2e+pKymOaj5NEQRqAA4VlVmC3xFhyKuT5G9kinuglf+YIh8pqf4q29UYnzBto7MfyfHOVcpbtQlbnIRALuVdvG8I7SDGwjpeQaNUkXK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GN82pQfi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GN82pQfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41951F00A3D;
	Fri,  4 Sep 2026 07:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788507727;
	bh=3ZDkzO1lwGOPF9PHrSqYBKWXq6pkOOc4iRUoBopAPWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GN82pQfiPqHlaHHu22L/oUWZqHbCbnYI6ikvxI142aW3CgBS22kN9/2CwsxuB12ln
	 kjGRRINTnacukefhFdcmuiWN65uc6cqHdyv1MujWuXLP7XmojHFleQFwWJPNb43i38
	 BFOoIK2cgk/R+Thghm5VTPOHyi+IM2iIme0DMFx6NmoWzNapGBkmOS5cAkIJkf7UWo
	 o2mbA2u+qHDFRd2AJbyztSCT+Jc26/zxdYw40lbHQOda/mO7cZ2Z2kD/06q8vcGRBL
	 tT7E3YZvfo0Bkh8M8QZC+HA8HwTzJ9pl0M00jC5NkfrP7aHKQ6ol75pmnx+iFWLHH/
	 wPwEBUU6GUGfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v3 2/2] selftests: mptcp: convert iptables to
 nftables for mptcp_join.sh
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hangbin Liu" <hangbin.liu@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260904-mptcp_nft-v3-2-4abedaf00bf9@kylinos.cn>
References: <20260904-mptcp_nft-v3-0-4abedaf00bf9@kylinos.cn>
 <20260904-mptcp_nft-v3-2-4abedaf00bf9@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 07:42:06 +0000
Message-Id: <20260904074206.C41951F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing 'add' keyword in nftables configuration script causes sy=
ntax error, silently skipping tests.
--

commit 45eaf6e2e654e036380de79d25fbc989c2055da7
Author: Hangbin Liu <liuhangbin@kylinos.cn>

selftests: mptcp: convert iptables to nftables for mptcp_join.sh

This commit replaces the iptables/ip6tables setup with nftables in the
mptcp_join.sh selftest. It introduces a new init_nftables function to setup
the nft tables using a heredoc rather than configuring them inline.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 18ce7136a2b0e..835cb92cab1a4 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

[ ... ]

> @@ -184,6 +147,28 @@ init_shapers()
>  	done
>  }
> =20
> +init_nftables()
> +{
> +	nft_handle=3D""
> +
> +	local netns table
> +	for netns in "$ns1" "$ns2"; do
> +		for table in ip ip6; do
> +			ip netns exec "$netns" nft -f - <<-EOF
> +				add table $table filter
> +				add chain $table filter INPUT \
> +					{ type filter hook input priority filter; policy accept; }
> +				add chain $table filter OUTPUT \
> +					{ type filter hook output priority filter; policy accept; }
> +
> +				table $table mangle
> +				chain $table mangle OUTPUT \
                                ^^^^

[Severity: Medium]
Are these table and chain declarations missing the "add" keyword?

The filter table rules above them use "add table" and "add chain", but the
mangle declarations omit "add". Does this syntax error cause the "nft -f -"
command to fail and abort the entire transaction, preventing the creation of
both the filter and mangle tables?

If the tables aren't created, subsequent "nft add rule" commands, like those
in setup_fail_rules() or reset_with_add_addr_timeout(), will fail. This
appears to cause the affected fault-injection and filtering tests to be
silently skipped rather than executed.

> +					{ type route hook output priority mangle; policy accept; }
> +			EOF
> +		done
> +	done
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-mptcp_nft-=
v3-0-4abedaf00bf9@kylinos.cn?part=3D2
