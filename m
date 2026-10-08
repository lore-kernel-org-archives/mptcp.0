Received: from mta0.migadu.com (out-82.mta0.migadu.com [91.218.175.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E01455181
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791465816; cv=none; b=b4pu6qbuGqeGbVTNyslbXcceM7TlTWFy35NhR85/WG3g5JL7h7DWdE0wHHzj/AkI80ruUqM5ax8k1Gr88+3bicH0MMsRyFk/LHwRqYoq85vSn0P41YUqJNrAvlSbdewq6o/zLMZPA/uo/nhQJOzJf3Ql4Q7LUhvILswRsPAdg1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791465816; c=relaxed/simple;
	bh=Y34YFW9x4uZSYEnv1SEjanHr1IyfqnyK9JkLu1JzNnk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=XVmVrllwg4QbGK11OwqXLXW3et9IVlW8VQLTL1t16zno45JWB1e9ygkQ9U9lYbzW4kxUMU1wCR6mV0p5PVkYAXtvJPS2ZrnNtij/hifKD3g9A07tlLkIyQB/j5p5A4fRxMpH45bmVQYB1H4nd/3uIYZ0wRJwRbZFOCwp65iB1eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BvbxQb8e; arc=none smtp.client-ip=91.218.175.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BvbxQb8e"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Y34YFW9x4uZSYEnv1SEjanHr1IyfqnyK9JkLu1JzNnk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791465812; v=1; x=1792070612;
 b=BvbxQb8eIp2zl4ZkIu+YCFeq/dWA4xOsMvcx1WC0cetHqKd6hbBWlfVSBtBhKbWFVAQ/0Kde
 c7lIQde/cicu1dIfZQRtNfPp8TURXJm2oQbGLhaq4D2mibe5YjxyIj08zbXFW+b2oUYjocXqtHO
 0SyXa+EVtUM1dsVrnAkKiOiY=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 5e462d5c02f33735;
	Thu, 08 Oct 2026 13:23:31 +0000
X-Mizu-Trace-ID: 5e462d5c02f33735
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 08 Oct 2026 13:23:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: hangbin.liu@linux.dev
Message-ID: <60baacac549304130a19242a34cc7f6c91ce7f4a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next] selftests: mptcp: verify nft JSON support
To: "Matthieu Baerts" <matttbe@kernel.org>, "MPTCP Linux"
 <mptcp@lists.linux.dev>
Cc: "Hangbin Liu" <liuhangbin@kylinos.cn>
In-Reply-To: <d78a6c82-1652-4aee-b2ed-72553b03725e@kernel.org>
References: <20261008-mptcp_nft_version-v1-1-efe5f200cb02@kylinos.cn>
 <00f4f36f-37ce-4845-a86a-ef190961b843@kernel.org>
 <d78a6c82-1652-4aee-b2ed-72553b03725e@kernel.org>

October 8, 2026 at 7:55 PM, "Matthieu Baerts" <matttbe@kernel.org> wrote:
>=20
>=20On 08/10/2026 13:09, Matthieu Baerts wrote:
>=20
>=20>=20
>=20> On 08/10/2026 12:00, Hangbin Liu wrote:
> >=20
>=20> >=20
>=20> > Use --version to check for nft presence, as older nft versions re=
ject -V.
> > >  Ensure the nft tool has JSON support, since we need JSON output fo=
r
> > >  parsing with jq.
> > >=20
>=20>  Thank you for the patch. But do you think it is really needed? 'nf=
t -V'
> >  as been introduced before MPTCP being upstream, and who is building =
nft
> >  without JSON support?
> >=20=20
>=20>  As an alternative, I can squash this in "selftests: mptcp: convert
> >  iptables to nftables for mptcp_sockopt.sh", just to silence Clashiko=
.
> >=20
>=20I just did that:
>=20
>=20New patches for t/upstream:
> - 7b299bd2ff08: "squashed" (with conflicts) in "selftests: mptcp:
> convert iptables to nftables for mptcp_sockopt.sh"
> - 585585efcf69: conflict in
> t/selftests-mptcp-convert-iptables-to-nftables-for-mptcp_join.sh
> - Results: 1b9bfe42c3a5..5b1d535dc33e (export)
>=20

Thanks=20for updating the previous patches and fixing the conflicts.

Regards
Hangbin
