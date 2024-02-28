Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D76442C
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 07:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106431; cv=none; b=FD/w9qt2Vj2tcf9dKLPqiCoHRtcchYricsexZ8zgltW0RxKbFaoNHLo83dXxgNZjAj0cVGJvGi1hvl/lW8039VA0Q7Kt+JvEiFpbPQ4w9iNDqiJJTRHeyXMEKKlBXhMikYcUeLmxMawzfr5QhJJACCqOVaokchM8XsFr2AtehdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106431; c=relaxed/simple;
	bh=YpgN4cyB3rf2dHDRhVLPua+vLXk4G1Kv+rB7xfH4fk4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qoehQ1Cr+2SFlpwAGHFh7JhvlH0Im6TUEsYyam9fNIseipqkYWxfNXvpT8z0N2GKbv76D5knGXfQ68NStABkUF5hEgCmi/exy4eyQ8os1N/RCuNE45cw8QtulGeO2uj8sMSuLDNN3/rNzrxjujmBKEjXSNv9Z686045QywjKl1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/w7V5MR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/w7V5MR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2951C433F1;
	Wed, 28 Feb 2024 07:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709106431;
	bh=YpgN4cyB3rf2dHDRhVLPua+vLXk4G1Kv+rB7xfH4fk4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=q/w7V5MRepNnDgzvT2eDfpcG5Mzzk688ZEe+7ZEFiW52dPaJEzSYGapL2ZYBPSbvT
	 FX8wVtLO7dWavd1cX5VQR/5A6JwMoGnCeBQJR6UOOrEuzAXB3rvvsFHyKiqQqsVdJ0
	 02VqNOtISvP5HdcT8yQJRmkdB6dJCaff9W29gB4/wpC47A8ZqQKpv/Xt7u62pbgDy+
	 OmdUVkr96zU0e8ZG+LjKkKELIsxmUIQSF31LN7GTXBOil3gyEHEX7K5w5aMiBowEaj
	 XAgGxGB3PRhxsZCe/xFvPpCMKjxK4i0N12tYYJ6dv9F+oGMN9ZI/v+7a5HjWFjv0Y/
	 OZ7AVPEMkRliQ==
Message-ID: <76f882651bb1bc5ec079a27cc2107b5a98f1f126.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 01/12] selftests: mptcp: capitalize
 ok/fail/skip
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 28 Feb 2024 15:47:06 +0800
In-Reply-To: <4225dca0-b0a6-43e6-ae14-e3cb1c47563b@kernel.org>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
	 <52d42e66e9e5f1dd34220e38ca763ab41ba22f15.1708939962.git.tanggeliang@kylinos.cn>
	 <4225dca0-b0a6-43e6-ae14-e3cb1c47563b@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matt,

On Mon, 2024-02-26 at 13:40 +0100, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 26/02/2024 10:43, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >=20
> > Most scripts print uppercase [ OK ], [FAIL] and [SKIP] as test
> > results,
> > but lowercase ones are used in diag.sh, mptcp_join.sh and
> > simult_flows.sh.
> > To maintain consistency with other scripts, this patch capitalizes
> > these
> > lowercase [ ok ], [ fail ] and [ skip ]:
> >=20
> > =C2=A0=C2=A0=C2=A0 [ ok ]=C2=A0=C2=A0 -> [ OK ]=C2=A0=C2=A0=C2=A0	in di=
ag.sh, mptcp_join.sh
> > =C2=A0=C2=A0=C2=A0 [ fail ] -> [FAIL]		in diag.sh, mptcp_join.sh,
> > simult_flows.sh
> > =C2=A0=C2=A0=C2=A0 [ skip ] -> [SKIP]		in diag.sh, mptcp_join.sh
>=20
> I think this could be squashed with patch 4/12: OK the behaviour is
> changed, but that's still the same info being printed. This can be
> justified with a simple "we uniform how the results are presented
> with
> colours".
>=20
> If you change that, I think it would be better to add new helpers to
> print OK/FAIL/SKIP string from one place, like it is done in
> mptcp_join.sh. So if needed, we can easily change how the results are
> presented later instead of having to change it in different places.
>=20
> We could even have these helpers in the lib:
>=20
>=20
> =C2=A0mptcp_lib_print_success()
> =C2=A0{
> 	mptcp_lib_print_ok "[ OK ]${1:+ ${*}}"
> =C2=A0}
>=20
> =C2=A0mptcp_lib_print_fail()
> =C2=A0{
> 	mptcp_lib_print_err "[FAIL]${1:+ ${*}}"
> =C2=A0}
>=20
> =C2=A0mptcp_lib_print_skip()
> =C2=A0{
> 	mptcp_lib_print_warn "[SKIP]${1:+ ${*}}"
> =C2=A0}
>=20
> WDYT?

I agree, added mptcp_lib_pr_ok(), mptcp_lib_pr_fail() and
mptcp_lib_pr_skip() in v6.

>=20
> (...)
> Cheers,
> Matt

