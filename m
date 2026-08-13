Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4648D476061
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625640; cv=none; b=K45Bjboknoc6tcSZxxZt4EljKPYfbpQuXht5721KdTEE4WqBm8b0nsA7GIfzYv6hcuEir/Du2vZ7CN5+QzvXmANcIdtdCq4+G1OgA+oK27RFL/9aQcK181opsquNyXxw3QonHMX7vAU2OKAc25z3uuJwfdAf2PK2DWr9btbc3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625640; c=relaxed/simple;
	bh=jh8g8kjohBT/B2S6tR9L3l4R9s2A5/Lx1j7uPYx2s6A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hlYbGbOcS9aum7/H2vDONp5qapKvKDbfh3SFbdFybXJAq9E+pNNKmeiQAxvUH75qIpjP6/UK/exVQv443jdg93cCQ/rJejr4yNJO9cPhlDcUZDXEBuGB8/i4/DR4UOCGyMuSZDH09H2DjkteNXJzStlJJ4cc8YuiriE82+HX0C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2RGSBiN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2RGSBiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCD51F000E9;
	Thu, 13 Aug 2026 12:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786625639;
	bh=kDYyxwvrEtDiBPGbMB2thu/PqJVeDGDUkj7P8xZY+lk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F2RGSBiNSoRmop8e+gzAUPjNjiAgDgRhVHohVw7SiKSTfnt9WUdS4bC9W6ZNH4vZ9
	 NnyweG4TJgPE1T/rwwDLW+Ag7ctXVuofcIZq1ZE87v4w/c1cmXkNLnKfmUvj+Dj4Jk
	 l9RU59kMXsOdKyIrNIbw1BXvmXXbkS14zcolbiXV3oQ8lxl9jv+7bUqRX7ksTcP+qG
	 eT4jSnPKXhYIwxp+G1ZVcQf+pw0HnkeTWj/g6ZMmiGSWyP63lTsyI+/ffzyVjqDCxg
	 0epXLmQnAA1cwWm3CZydazGMOT0aJuPyN7fHCNvKVB+PnpRQe8LcZ23U5yddMfXvq7
	 tdudYcS0WMw1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next] mptcp: fix add_addr_accepted accounting on
 subflow close
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akshit Patadiya" <akshit@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260813123754.4095492-1-akshit@mpiricsoftware.com>
References: <20260813123754.4095492-1-akshit@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 12:53:58 +0000
Message-Id: <20260813125358.CBCD51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent overwrite of msk->pm.rm_list_rx while iterating over it=
 in mptcp_pm_rm_addr_or_subflow.
--

--- Patch [1]: [PATCH mptcp-next] mptcp: fix add_addr_accepted accounting o=
n subflow close ---
commit 66a438e0ebd8ec5a7b6eb2a506d61f6a2a2d2cc5
Author: Akshit Patadiya <akshit@mpiricsoftware.com>

mptcp: fix add_addr_accepted accounting on subflow close

This commit modifies how MPTCP tracks accepted remote addresses by using a
bitmap instead of relying on a live subflow to signal removal. It releases
accepted-address slots as soon as the subflow is closed.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/498

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index ba7c6f80a183c..b6edb9df3216c 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c

[ ... ]

> @@ -807,7 +808,6 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_=
sock *msk,
>  				 i, rm_id, id, remote_id, msk->mpc_endpoint_id);
>  			spin_unlock_bh(&msk->pm.lock);
>  			mptcp_subflow_shutdown(sk, ssk, how);
> -			removed |=3D subflow->request_join;
> =20
>  			/* the following takes care of updating the subflows counter */
>  			mptcp_close_ssk(sk, ssk, subflow);

[Severity: High]
This isn't a bug introduced by this patch, but could this unlock/lock seque=
nce
lead to a race condition with the outer loop?

In mptcp_pm_rm_addr_or_subflow(), the outer loop iterates over rm_list:

	for (i =3D 0; i < rm_list->nr; i++) {
		u8 rm_id =3D rm_list->ids[i];

If rm_list points to &msk->pm.rm_list_rx, and the PM lock is dropped here
in the inner loop, could a concurrent softirq processing a new RM_ADDR
overwrite the list while the lock is temporarily released?

This might corrupt the ongoing iteration of the outer loop once the lock is
reacquired and the next item in rm_list->nr and rm_list->ids is evaluated.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813123754.4095=
492-1-akshit@mpiricsoftware.com?part=3D1
