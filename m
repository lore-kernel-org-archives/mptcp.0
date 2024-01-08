Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B304654F
	for <mptcp@lists.linux.dev>; Mon,  8 Jan 2024 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rcG6HxXR"
Message-ID: <9754c6ba4f1ef8b1463d1a50ea3a8cb35f14248f.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704717511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/rCEaFjhhFarl+lLwhsgEWfj4Z3dWwxVSCMQC6dXYMw=;
	b=rcG6HxXRgNx1v9Y29GkJuhcDHdSOsTMbzOq9hyRHVVtjn3T0jwLjoc6F9NkcZkaR3zvuYd
	AmEZqZfMwdP3NAWamo5Jlibaf7s5OSRYjUYTPOP0xWwmqapu8fD1zX64XiBE3oHBFlAb+2
	bh69v+983yBZUf2Nv9k1Q1+gXORDZjc=
Subject: Re: [PATCH mptcp-next] bpf: Add mptcp_sched_ops CFI
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Geliang Tang <geliang.tang@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 08 Jan 2024 20:37:48 +0800
In-Reply-To: <c2889577-25a3-4721-a754-61d082474d36@kernel.org>
References: 
	<9e2fbdc6e5a9c59d4b8eded4bfb2ae71a768afad.1704530434.git.geliang.tang@linux.dev>
	 <c2889577-25a3-4721-a754-61d082474d36@kernel.org>
Autocrypt: addr=geliang.tang@linux.dev; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

Hi Matt,

On Mon, 2024-01-08 at 11:14 +0100, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 06/01/2024 09:40, Geliang Tang wrote:
> > '''
> > The cfi_stubs pointer is added in the commit 2cd3e3772e41
> > ("x86/cfi,bpf:
> > Fix bpf_struct_ops CFI"), this patch initializes it as dummy stubs
> > __bpf_mptcp_sched_ops.
> > '''
> >=20
> > Note:
> >=20
> > BPF tests on export branch fail with this error:
> >=20
> > =C2=A0BUG: kernel NULL pointer dereference, address: 0000000000000000
> > =C2=A0#PF: supervisor read access in kernel mode
> > =C2=A0#PF: error_code(0x0000) - not-present page
> > =C2=A0PGD 0 P4D 0
> > =C2=A0Oops: 0000 [#1] PREEMPT SMP PTI
> > =C2=A0CPU: 3 PID: 1512 Comm: test_progs Tainted: G=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 W IOE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > 6.7.0-rc5 #37
> > =C2=A0Hardware name: LENOVO 4180PG2/4180PG2, BIOS 83ET76WW (1.46 )
> > 07/05/2013
> > =C2=A0RIP: 0010:bpf_struct_ops_map_update_elem+0x4ee/0x610
> >=20
> > This patch fixes this error. It can be applied after the commit
> > "bpf: Add bpf_mptcp_sched_ops"
>=20
> Thank you for having checked and fixed that!
>=20
> Is it OK for you if I squash it in "bpf: Add bpf_mptcp_sched_ops"
> commit?

Yes, it's better to squash it. Please do this when merging it.

I'm not sure whether "get_subflow" should be initialized here too. If
it should be, I'll send another squash-to patch to fix this.

Thanks,
-Geliang

>=20
> Cheers,
> Matt

