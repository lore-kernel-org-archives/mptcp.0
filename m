Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6D833F8C4
	for <mptcp@lists.linux.dev>; Fri, 12 Jun 2026 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289247; cv=pass; b=lSLw5MIWo7QQ4CkLVJdW0uYiWT3Di5pXjd4EaVXz9bXoQz2/zUv9qhI259MKNPRQlCSt4+/ERck6hCBLFfH5tZdtPGBdZn59z88zT7LnSS/HGwSt7Uw3t5P+rs9PQ7emo6/yu9I3N8wr0CK6dB6OWNPPbQI8PcN4Yr/NkowZJZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289247; c=relaxed/simple;
	bh=56G2Zfb0Ghw7z7N8z+5BeuihoQW7UTc+1qEqLKxgnfY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OT3ROttTUndMlEuK5DNoVFSnhdr5rxUhKRj7QuwpUYvTilJS1avDnXm+8h2cst+13xGxEMq8apAeNLnHQpWFWp+nyVcK4C47ttuo5jBDiZctT9wL1UtZ4YRMtDbKss8fcO4O0FqEuo123GHlrB66W/ScnpXkQ6WFfUjZ5wxVn3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=XMstYZ42 reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="XMstYZ42"
ARC-Seal: i=1; a=rsa-sha256; t=1781289242; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Sv0OLvRa6KXwoIdnWfjSSD6h/FcBxaByMKvRbUbHCFiM/DoXSja3Z0NKSyJ36DQm8ARRNVvKkaMZRWn4+s2CpiYAcSfVT8OG7NUemJLFPt/i8Mobx6oxRzd9f8teoDWlt5iZA+TGinAGcinYdsAlvR03cIkGJtgUv1RxPdgjxo4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781289242; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=56G2Zfb0Ghw7z7N8z+5BeuihoQW7UTc+1qEqLKxgnfY=; 
	b=YbgRvjeUhPJ69z437+C+W5oQsCWC6Ys2l4POxzheXzMrbELRdxNCeb6snhATsy0XUDF9/1AYkrMsqMjfa6xkSvebc6+HsShAjqmmT1h+K217RkRbyVn/kYFDGYn67LXeIijXJEidpmjvo8eVht2mjBS5lEt3ltsxERM8aOI2n1k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781289242;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=56G2Zfb0Ghw7z7N8z+5BeuihoQW7UTc+1qEqLKxgnfY=;
	b=XMstYZ42rgR+cJFckcM5CsrorVuAh+Gh3nuuBAVUXadn3w3oH3H8mCBtXVium8IL
	FnzeyW3b5RxHPEpHeIupVJZd3zKMfTiYThtzOFhvVac6x9Clns6+R7trBU/X52zrCa5
	3NSxwDhzcz1jTtQQoVdHCa9Aj2fNLr6gqPzbivB4=
Received: by mx.zohomail.com with SMTPS id 1781289240627551.0962121601511;
	Fri, 12 Jun 2026 11:34:00 -0700 (PDT)
Message-ID: <470388a78561b920c51697c162e3f7f210d9cc1e.camel@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-net v3] mptcp: fix divide-by-zero in
 __mptcp_push_pending close path
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: mptcp@lists.linux.dev, pabeni@redhat.com, matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, janak@mpiric.us, 
	kalpan.jani@mpiricsoftware.com
Date: Sat, 13 Jun 2026 00:03:49 +0530
In-Reply-To: <cd1fd42a-5a45-6d8c-051a-fc1be8e613c7@gmail.com>
References: <20260525194828.1137119-1-shardul.b@mpiricsoftware.com>
	 <cd1fd42a-5a45-6d8c-051a-fc1be8e613c7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ZohoMailClient: External

On Mon, 2026-05-25 at 21:19 +0000, MPTCP CI wrote:
> Hi Shardul,
>=20
> Thank you for your modifications, that's great!
>=20
> Our CI did some validations and here is its report:
>=20
> - KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
> - KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
> - KVM Validation: debug (except selftest_mptcp_join): Unstable: 1
> failed test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
> - KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
> - KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
> - KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
> - Task:
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/26417985120
>=20
> Initiator: Patchew Applier
> Commits:
> https://github.com/multipath-tcp/mptcp_net-next/commits/a19f79759720
> Patchwork:
> https://patchwork.kernel.org/project/mptcp/list/?series=3D1100586
>=20
>=20
> If there are some issues, you can reproduce them using the same
> environment as
> the one used by the CI thanks to a docker image, e.g.:
>=20
> =C2=A0=C2=A0=C2=A0 $ cd [kernel source code]
> =C2=A0=C2=A0=C2=A0 $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privi=
leged --rm
> -it \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --pull always mptcp/mptcp-upst=
ream-virtme-docker:latest \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 auto-normal
>=20
> For more details:
>=20
> =C2=A0=C2=A0=C2=A0 https://github.com/multipath-tcp/mptcp-upstream-virtme=
-docker
>=20
>=20
> Please note that despite all the efforts that have been already done
> to have a
> stable tests suite when executed on a public CI like here, it is
> possible some
> reported issues are not due to your modifications. Still, do not
> hesitate to
> help us improve that ;-)
>=20
> Cheers,
> MPTCP GH Action bot
> Bot operated by Matthieu Baerts (NGI0 Core)

Hi Paolo, Matt,

Gentle ping on v3. It refines the v2 check that tripped the
regressions, scoping it to just the divide-by-zero close-path case. CI
on v3 was green except for a single Unstable flag (packetdrill_dss on
the debug config) a flaky test unrelated to this change (it passed on
normal).

Does v3 look acceptable as-is, or is there anything else you'd like
adjusted?

Thanks,
Shardul
