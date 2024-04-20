Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90A1257B
	for <mptcp@lists.linux.dev>; Sat, 20 Apr 2024 00:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713572307; cv=none; b=afjuutgWXAHJxSc726qMX3aFvWYo4GcYWbfBzv4LQCWpS7ro5rRS4gS4cOVc/7o3binRlZejfNmsbUnKsNOL6CUGRSNmUGtEoVgwCEN6SPL7CB3pqj73qTTdQMMB7LOU8o4spqyIf2On94IJg5Zga60/TN3znzXyB8EMk3+MDkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713572307; c=relaxed/simple;
	bh=bDtFl1HS94ytCpteOa3+pTW/2HYAhQFrTXH/nFPFf7c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P9erkzTO1+niId28NDxZpMrVN0nHoj73QUeZkxPcL92BGShqzoqBmAqzu51yWiOcRtCfMZ6Je1An5qRBRn5YLFZ6uNXIIBBA+zJadOA5uaPVISrP8/70mLXo/p8VrfI9/ABsLop7Tq1pWxsM/t0Z1w24edIwpP2kOsEKd50smR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/cv2E/f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/cv2E/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29256C072AA;
	Sat, 20 Apr 2024 00:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713572306;
	bh=bDtFl1HS94ytCpteOa3+pTW/2HYAhQFrTXH/nFPFf7c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=S/cv2E/fLwn2goAiX3HksN7kW67nharmYyxeR5Eof1Gry9Mfit9pncatXyl8wUvHy
	 34VJwtgmjcC/cqSjLaQ+fZngXS0VHJAwtuN5AxizkEnbX/q0knytFOx71JoqmtJzhQ
	 Sy7cqVK2W1edId64Feq/7TX0+zEZaxK7TTN/T6iyBvuFijAKWRAG+l1bodbVXj/TQg
	 9cMt3LWY0XnepySBkrejQJTaFDe/YINzOzh38Vv97FqmxHB93G6cuDXzgiNgw3rH4p
	 6P4pnDqBTJJuqmpr4c+IWQC64YysL/cF+adAukBdgavlvryKfw3TDbccmAYRVa4bZH
	 uKfzVnbHyVoTA==
Message-ID: <db02b2fd3c44e050aa9bc20537f108c3b9e07c9b.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v9 0/8] refactor mptcp bpf tests
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Sat, 20 Apr 2024 08:18:22 +0800
In-Reply-To: <10659d84-5d60-4a0f-84d9-859ad39a23f5@kernel.org>
References: <cover.1713321357.git.tanggeliang@kylinos.cn>
	 <10659d84-5d60-4a0f-84d9-859ad39a23f5@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBGWKTg4BEAC/Subk93zbjSYPahLCGMgjylhY/s/R2ebALGJFp13MPZ9qWlbVC8O+XlU/4reZtYKQ715MWe5CwJGPyTACILENuXY0FyVyjp/jl2u6XYnpuhw1ugHMLNJ5vbuwkc1I29nNe8wwjyafN5RQV0AXhKdvofSIryqm0GIHIH/+4bTSh5aB6mvsrjUusB5MnNYU4oDv2L8MBJStqPAQRLlP9BWcKKA7T9SrlgAr0VsFLIOkKOQPVTCnYxn7gfKogH52nkPAFqNofVB6AVWBpr0RTY7OnXRBMInMHcjVG4I/NFn8Cc7oaGaWHqX/yHAufJKUsldieQVFd7C/SI8jCUXdkZxR0Tkp0EUzkRc/TS1VwWHav0x3oLSy/LGHfRaIC/MqdGVqgCnm6wapUt7f/JHloyIyKJBGBuHCLMpN6n/kNkSCzyZKV7h6Vw1OL518p0U3Optyakoh95KiJsKzcd3At/eftQGlNn5WDflHV1+oMdW2sRgfVDPrYeEcYI5IkTc3LRO6ucpVCm9/+poZSHSXMI/oJ6iXMJE8k3/aQz+EEjvc2z0p9aASJPzx0XTTC4lciTvGj62z62rGUlmEIvU23wWH37K2EBNoq+4Y0AZsSvMzM+CcTo25hgPaju1/A8ErZsLhP7IyFT17ARj/Et0G46JRsbdlVJ/PvX+XIOc2mpqx/QARAQABtCVHZWxpYW5nIFRhbmcgPGdlbGlhbmcudGFuZ0BsaW51eC5kZXY+iQJUBBMBCgA+FiEEZiKd+VhdGdcosBcafnvtNTGKqCkFAmWKTg4CGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQfnvtNTGKqCmS+A/9Fec0xGLcrHlpCooiCnNH0RsXOVPsXRp2xQiaOV4vMsvhG5AHaQLb3v0cUr5JpfzMzNpEkaBQ/Y8Oj5hFOORhTyCZD8tY1aROs8WvbxqvbGXHnyVwqy7Ad
	WelP+0lC0DZW0kPQLeel8XvLnm9Wm3syZgRGxiM/J7PqVcjujUb6SlwfcE3b2opvsHW9AkBNK7v8wGIcmBA3pS1O0/anP/xD5s5L7LIMADVB9MqQdeLdFU+FFdafmKSmcP9A2qKHAvPBUuQo3xoBOZR3DMqXIPkNCBfQGkAx5tm1XYli1u3r5tp5QCRbY5LSkntMNJJh0eWLU8I+zF6NWhqNhHYRD3zc1tiXlG5E0obpX02Dy25SE2zB3abCRdAK30nCI4lMyMCcyaeFqvf6uhiugLiuEPRRRdJDWICOLw6KOFmxWmue1F71k08nj5PQMWQUX3X2K6jiOuoodYwnie/9NsH3DBHIVzVPWASFd6JkZ21i9Ng4ie+iQAveRTCeCCF6VRORJR0R8d7mI9+1eqhNeKzs21gQPVf/KBEIpwPFDjOdTwS/AEQQyhB+5ALeYpNgfKl2p30C20VRfJGBaTc4ReUXh9xbUx5OliV69iq9nIVIyculTUsbrZX81Gz6UlbuSzWc4JclWtXf8/QcOK31wputde7Fl1BTSR4eWJcbE5Iz2yzgQu0IUdlbGlhbmcgVGFuZyA8Z2VsaWFuZ0BrZXJuZWwub3JnPokCVAQTAQoAPhYhBGYinflYXRnXKLAXGn577TUxiqgpBQJlqclXAhsDBQkSzAMABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH577TUxiqgpaGkP/3+VDnbu3HhZvQJYw9a5Ob/+z7WfX4lCMjUvVz6AAiM2atDyyUoDIv0fkDDUKvqoU9BLU93oiPjVzaR48a1/LZ+RBE2mzPhZF201267XLMFBylb4dyQZxqbAsEhVc9VdjXd4pHYiRTSAUqKqyamh/geIIpJz/cCcDLvX4sM/Zjwt/iQdvCJ2eBzunMfouzryFwLGcOXzxOwZRMOBgVuXrjGVB52kYu1+K90DtclewEgvzWmS9d057CJztJZMXzvHfFAQMgJC7DX4pa
	Yt49pNvhcqLKMGNLPsX06OR4G+4ai0JTTzIlwVJXuo+uZRFQyuOaSmlSjEsiQ/WsGdhILldV35RiFKe/ojQNd4B4zREBe3xT+Sf5keyAmO/TG14tIOCoGJarkGImGgYltTTTM6rIk/wwo9FWshgKAmQyEEiSzHTSnXcGbalD3Do89YRmdG+5eP7HQfsG+VWdn8IH6qgIvSt8GOw6RfSP7omMXvXji1VrbWG4LOFYcsKTN+dGDhl8LmU0y44HejkCzYj/b28MvNTiRVfucrmZMGgI8L5A4ZwQ3Inv7jY13GZSvTb7PQIbqMcb1P3SqWJFodSwBg9oSw21b+T3aYG3z3MRCDXDlZAJONELx32rPMdBva8k+8L+K8gc7uNVH4jkMPkP9jPnVPx+2P2cKc7LXXedb/qQ3MuQINBGWKTg4BEADJxiOtR4SC7EHrUDVkp/pJCQC2wxNVEiJOas/q7H62BTSjXnXDc8yamb+HDO+Sncg9SrSRaXIh+bw9G3rvOiC2aQKB6EyIWKMcuDlD7GbkLJGRoPCA5nSfHSzht2PdNvbDizODhtBy8BOQA6Vb21XOb1k/hfD8Wy6OnvkA4Er61cf66BzXeTEFrvAIW+eUeoYTBAeOOc2m4Y0J28lXhoQftpNGV5DxH9HSQilQZxEyWkNj8oomVJ6Db7gSHre0odlt5ZdB7eCJik12aPIdK5W97adXrUDAclipsyYmZoC1oRkfUrHZ3aYVgabfC+EfoHnC3KhvekmEfxAPHydGcp80iqQJPjqneDJBOrk6Y51HDMNKg4HJfPV0kujgbF3Oie2MVTuJawiidafsAjP4r7oZTkP0N+jqRmf/wkPe4xkGQRu+L2GTknKtzLAOMAPSh38JqlReQ59G4JpCqLPr00sA9YN+XP+9vOHT9s4iOu2RKy2v4eVOAfEFLXq2JejUQfXZtzSrS/31ThMbfUmZsRi8CY3HRBAENX224Wcn6IsXj3K6lfYxImRKWGa
	/4KviLias917DT/pjLw/hE8CYubEDpm6cYpHdeAEmsrt/9dMe6flzcNQZlCBgl9zuErP8Cwq8YNO4jN78vRlLLZ5sqgDTWtGWygi/SUj8AUQHyF677QARAQABiQI7BBgBCgAmFiEEZiKd+VhdGdcosBcafnvtNTGKqCkFAmWKTg4CGwwFCRLMAwAACgkQfnvtNTGKqCkpsw/2MuS0PVhl2iXs+MleEhnN1KjeSYaw+nLbRwd2SdXoVXBquPP9Bgb92T2XilcWObNwfVtD2eDz8eKf3e9aaWIzZRQ3E5BxiQSHXl6bDDNaWJB6I8dd5TW+QnBPLzvqxgLIoYn+2FQ0AtL0wpMOdcFg3Av8MEmMJk6s/AHkL8HselA3+4h8mgoK7yMSh601WGrQAFkrWabtynWxHrq4xGfyIPpq56e5ZFPEPd4Ou8wsagn+XEdjDof/QSSjJiIaenCdDiUYrx1jltLmSlN4gRxnlCBp6JYr/7GlJ9Gf26wk25pb9RD6xgMemYQHFgkUsqDulxoBit8g9e0Jlo0gwxvWWSKBJ83f22kKiMdtWIieq94KN8kqErjSXcpI8Etu8EZsuF7LArAPch/5yjltOR5NgbcZ1UBPIPzyPgcAmZlAQgpy5c2UBMmPzxco/A/JVp4pKX8elTc0pS8W7ne8mrFtG7JL0VQfdwNNn2R45VRf3Ag+0pLSLS7WOVQcB8UjwxqDC2t3tJymKmFUfIq8N1DsNrHkBxjs9m3r82qt64u5rBUH3GIO0MGxaI033P+Pq3BXyi1Ur7p0ufsjEj7QCbEAnCPBTSfFEQIBW4YLVPk76tBXdh9HsCwwsrGC2XBmi8ymA05tMAFVq7a2W+TO0tfEdfAX7IENcV87h2yAFBZkaA==
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

On Fri, 2024-04-19 at 11:58 +0200, Matthieu Baerts wrote:
> Hi Geliang, Mat,
>=20
> On 17/04/2024 04:38, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >=20
> > v9:
> > =C2=A0- extract a new helper test_bpf_sched() from MPTCP_SCHED_TEST() t=
o
> > make
> > =C2=A0=C2=A0 the macro simpler as Mat suggested. (thanks)
> > =C2=A0- squash MPTCP_SCHED_TEST() into "selftests/bpf: Add bpf_first
> > =C2=A0=C2=A0 scheduler & test", not "selftests/bpf: Add bpf scheduler t=
est"
> > to
> > =C2=A0=C2=A0 avoid a build error "test_bpf_sched is not used".
> Thank you for the v9, and the review!
>=20
> @Geliang: there were a lot of Git (TopGit) manipulations here, please
> check that the result is the expected one.

Thank you for applying these patches. I know there must be many
conflicts inside. Thank you for updating my email address too. All
patches merged well and all tests passed.

>=20
>=20
> New patch for t/upstream:
>=20
> - d0432b7d2bb0: selftests/bpf: Add RUN_MPTCP_TEST macro

Please insert this commit "selftests/bpf: Add RUN_MPTCP_TEST macro"
before "mptcp: add sched_data helpers" so that it can be upstreamed
in advance with "setsockopt per subflow: BPF" series being reviewed,
without waiting for BPF scheduler APIs to be updated. WDYT?

Regards,
-Geliang

> - 9791281821ba: conflict in t/selftests-bpf-Add-bpf-scheduler-test
> - 92efb2a19752: conflict in t/selftests-bpf-add-bpf_first-test
> - 78858b124aee: conflict in t/selftests-bpf-Add-bpf_bkup-test
> - e25a04564f65: conflict in t/selftests-bpf-Add-bpf_rr-test
> - d474c99c9c56: conflict in t/selftests-bpf-Add-bpf_red-test
> - 0091786b07e3: conflict in t/selftests-bpf-Add-bpf_burst-test
> - Results: eb9a8fbc1cd3..6ad6176a437b (export)
>=20
>=20
> Squash-to patches:
>=20
> - da0ce2d96df7: "squashed" "1 verify" (with conflicts) in
> "selftests/bpf: Add bpf scheduler test"
>=20
> - d08d36c72f3e: "squashed" "2 time" in "selftests/bpf: Add bpf
> scheduler
> test"
> - f9800e6dbb07: conflict in t/selftests-bpf-add-bpf_first-test
>=20
> - d910fb60db22: "squashed" (with conflicts) in "selftests/bpf: Add
> bpf_first test"
> - 6723021b9a04: "squashed" "2 strlen" in "selftests/bpf: Add
> bpf_first test"
> - 1bcf273624e6: "squashed" "3 err msg" in "selftests/bpf: Add
> bpf_first
> test"
> - 20df6c66a4bf: conflict in t/selftests-bpf-Add-bpf_bkup-test
>=20
> - 6f9d19a73d33: "squashed" (with conflicts) in "selftests/bpf: Add
> bpf_bkup test"
> - 9c86e3027008: conflict in t/selftests-bpf-Add-bpf_rr-test
>=20
> - 2bbbcc6cc7c1: "squashed" (with conflicts) in "selftests/bpf: Add
> bpf_rr test"
> - 3bdb5c116569: conflict in t/selftests-bpf-Add-bpf_red-test
>=20
> - 9eb2410e20b4: "squashed" (with conflicts) in "selftests/bpf: Add
> bpf_red test"
> - 55e93f797697: conflict in t/selftests-bpf-Add-bpf_burst-test
>=20
> - 9004d2b898a4: "squashed" (with conflicts) in "selftests/bpf: Add
> bpf_burst test"
> - Results: 6ad6176a437b..665448084780 (export)
>=20
>=20
> Squash "sched & test":
>=20
> - 57731e73cc97: tg:squash: bpf_first sched & test
> - 45b46aeeb072: tg:msg: update after squash
>=20
> - a5a572331f7c: tg:squash: bpf_bkup sched & test
> - d89c4282bf53: tg:msg: update after squash
>=20
> - 44155448f992: tg:squash: bpf_rr sched & test
> - 702454c6ba93: tg:msg: update after squash
>=20
> - 71681fc66d24: tg:squash: bpf_red sched & test
> - a15a6438bcbd: tg:msg: update after squash
>=20
> - 297175c89808: tg:squash: bpf_burst sched & test
> - c4624cdf779e: tg:msg: update after squash
> - Results: 665448084780..c23ad453d8cc (export)
>=20
>=20
> While at it, I also updated your email address:
> - dbec7401465d: tg:msg: update Geliang's email address
> - facd3cec3d0a: tg:msg: update Geliang's email address
> - 59127f756c66: tg:msg: update Geliang's email address
> - c20d79792bb2: tg:msg: update Geliang's email address
> - 5f3d6b7755a2: tg:msg: update Geliang's email address
> - 05efce6832cb: tg:msg: update Geliang's email address
> - becd15a77346: tg:msg: update Geliang's email address
> - e2b1e31d7720: tg:msg: update Geliang's email address
> - a3bcc475f994: tg:msg: update Geliang's email address
> - 699e0dbd591c: tg:msg: update Geliang's email address
> - 2d5b66a3675f: tg:msg: update Geliang's email address
> - 1df821d94ac8: tg:msg: update Geliang's email address
> - 7a0adfdb70d0: tg:msg: update Geliang's email address
> - cce49572147a: tg:msg: update Geliang's email address
> - fff8347933fd: tg:msg: update Geliang's email address
> - 6118caa31040: tg:msg: update Geliang's email address
> - 6603ca35adf6: tg:msg: remove my SoB
> - Results: c23ad453d8cc..f0f388aa6196 (export)
>=20
> Cheers,
> Matt

