Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842369;
	b=LJU6D36ZIZ9wTRyKAanWCPbud1ieIYtB+yygfEg3Khr5InR+hyxiUDlX4R3r8n5oU128
	 9K88zclvAdomXqZ36JZObGESExshF/GMJnexW8tpZubaztmyVzyIFXUvOEAJfEcp5/BfJ
	 DOctpLImbqzk3YWP57VyKQO3Sr7UV3AlW3cHN6LZqSyfjWKQZsK+mhSN7oEtE/EOOdSaR
	 aemefm5hvp/SPzBimKuMdNe+sY8yYP09JP2nA3dd2iPRzbQoj1K3Mmp9xdMZGqkYSbV5b
	 /Yr9ZssbpUY1e/kpLT4k8SgAEh1uloiYp9PBGbC6SUSV8ZdzdO2ExTe0Ng4C/ZxcBgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842369;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=SIwBaudVgGlYpeqMdPwXId0K0cfxPph4su7yoCN6QwQ=;
	b=SuHBuJ6nNfE37+LZXBfn3WdUX9RUtudWsQnXvGv571InKP+finlBq/6cght0ARQOC4FC
	 cOsOJWbosqJdBwc0dn1kz0+TV/saK1xxuhZOsxk2HJlGlPdSZOuRx2Vn1JRcc1HcUBrI5
	 xuoWIU/thsh/s0Ei5Xs5iC23qIif1RtU+yrO+0Jbv/PEkzgx6bqVN2y0lU8J/DbanWMsU
	 /lnGKDO7DIzv4Aszmz0gtCjwKWCrKaBn73Ef72rFl+cZ9FVQZn5DSuTscinHco2tLms+R
	 Kz5lx1VD1Saj0EF/CLYumf213Y7ehzyMvJ+2JGbOD9+jj//Fsx7C56wZ7CBC7qxoh/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PN2BKR2h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965BC606A31C
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PN2BKR2h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE3B1F00923;
	Mon, 16 Nov 2026 15:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794842369;
	bh=SIwBaudVgGlYpeqMdPwXId0K0cfxPph4su7yoCN6QwQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PN2BKR2hWMXCLcEfn/f0B6p7VX3oI6HTm1i0N4eU5nE8339UiQNkD611P/epRA5Cl
	 sJ395j8Tr3cLbv4+WKnYTiBMlWD7BBjP64z1FnumNw6jUx0DfeY/5BEIJZJSXB/e/5
	 roRlgF2lpWAmFLc0oG9s2T2F8UGtspBxO90V6sfnenZ8ZcD1/aRoWk9bpj1MlBqh5w
	 JWxPhTBPUPqg3cmbmxDEu1Md2ZHl+azhoukSo8JxZqbsHIBtK8EemwJckEem1yQWB5
	 UnBDmHNHqA9VnMUi4axKvh3nCNPf/xBDLcA5wqugN+SuIoelMjclqdHUdeIHWwd26Q
	 pwgMZjCgJuhEg==
Message-ID: <5c342fdd-1d70-4d9a-a2e1-c2995fe9253d@kernel.org>
Date: Mon, 16 Nov 2026 16:19:25 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC net-next v12] mptcp: normalize sequence numbers using socket
 address
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp <mptcp@lists.linux.dev>, "shardul.b"
 <shardul.b@mpiricsoftware.com>, janak <janak@mpiric.us>,
 kalpanjani009 <kalpanjani009@gmail.com>
References: <20261106111645.786225-1-kalpan.jani@mpiricsoftware.com>
 <1a1ce1e9b07.f015539104390.2600884748737974966@mpiricsoftware.com>
 <08451824-13d5-4e92-adb6-2ebd6c5cf053@kernel.org>
 <1a1cf8c61dd.83068f79144867.7028423115634706290@mpiricsoftware.com>
 <c923da02-1429-4aa9-a044-5440232a47e0@kernel.org>
 <1a1e4628081.655ae76e420453.2576402304811820615@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1a1e4628081.655ae76e420453.2576402304811820615@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

On 16/11/2026 13:43, Kalpan Jani wrote:
> For the latest v13, I have removed the address-based sequence-number
> normalization and zeroed `mptcpi_write_seq`, `mptcpi_snd_una`, and
> `mptcpi_rcv_nxt` directly in the MPTCP Netlink diagnostic callback.
> 
> This keeps the changes limited to the diagnostic path and leaves
> getsockopt() reporting unchanged.

Good idea.

> Currently, these fields are zeroed for all users, including those
> with CAP_NET_ADMIN.
> 
> Would you prefer this behavior for all users, or should we hide these
> fields only from users without CAP_NET_ADMIN?

Mmh, I think doing this only for users without CAP_NET_ADMIN would be
nice. *But*, I don't think the modifications in the other net subsystems
to get that would be accepted for -net, and maybe not even worth it as
an improvement for -next. So I would say: zero these fields for all
users in the MPTCP Netlink diagnostic callback.

You can prefix your next patch with 'mptcp-net', and with a Fixes tag
(maybe: ac3b45f60954 ("mptcp: add MPTCP socket diag interface")?).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund
