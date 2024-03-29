Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8413D0A4;
	Fri, 29 Mar 2024 05:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711691837; cv=none; b=dGYxnGS4vSC70qo0DmrEKbak7DlkTsOAa1v+yHOV1DTbyObNRJpT8K54pHCghNpB34Nf4H1pDM4RhJpTUrkUzesLaRYn/8aol6tOcWDglenyWhWH+AIT4YbXVIUQe1igCcUYeM/YRDeGlwbLTXnl8nqFVVTAUvb2mSeueCngqv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711691837; c=relaxed/simple;
	bh=gt96OjUVe26n5I1bmnuCflpjqSWR8YPbwvJq/hkem74=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X+mBE8RHxp+kaz03u6rZBWbF1qqztIDTAeiLf8zMupGrEOJLK3Yvl3tUsWDDh9+FEfBdir/kAJb9qNjbtmQ7obJOb8aHGZIDW9hk45Cl4xB1/8W6XQ/vaf1U7/b/7OnZJZh4cVE9YKSC/mgjFypN+k64GtbrjGquWuUrX7Lnul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcvINx/Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcvINx/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9AFC433F1;
	Fri, 29 Mar 2024 05:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711691836;
	bh=gt96OjUVe26n5I1bmnuCflpjqSWR8YPbwvJq/hkem74=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tcvINx/Zxdifqz0QOubE8t/00keD7mQSSFeWlAKt/gPog6Y/Eqnm+JVm0nyVunPqe
	 3Qcslhe+Amr4W4678xX8QmGa44UdzMCXE6A1HbAdDaacReeiblEWLapX7hOTGGg8q0
	 HRCOpJ21r9FlJE4QiTMyojjCzJsNceE+Kw6q8bjmWr85qBOMMCSwrnd5ZJhl0EEdEf
	 umV9ehXVrNM1kN+R0OgKf04p7LUW8ABa5lgBhzwth0l7m5oo9ZQIo4FcNq5cqQk+6V
	 Va2oSJJ5WBFosSobjxaEKiLAKwsHg1+iQBszq8+JKyYLhOCbmS9mz+Fb+DVuzYoGFd
	 /D2grZkPWImAA==
Message-ID: <59b0295363548c115b65b4555d0f7484738f5bda.camel@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Handle EAGAIN in bpf_tcp_ca
From: Geliang Tang <geliang@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, mptcp@lists.linux.dev, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko
 <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>
Date: Fri, 29 Mar 2024 13:57:08 +0800
In-Reply-To: <e6074193-7530-4c85-9429-9393e24c172d@linux.dev>
References: 
	<78a17486bd12d7afb4cce565d58dac3f15e55c49.1711620349.git.tanggeliang@kylinos.cn>
	 <e6074193-7530-4c85-9429-9393e24c172d@linux.dev>
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

Hi Martin,

On Thu, 2024-03-28 at 09:55 -0700, Martin KaFai Lau wrote:
> On 3/28/24 3:23 AM, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >=20
> > bpf_tcp_ca tests may emit EAGAIN sometimes. In that case, tests
> > fail with
> > "bytes !=3D total_bytes" errors. Sending should continue, not break
> > when
> > errno is EAGAIN. This patch can make bpf_tcp_ca tests stable.
> >=20
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > =C2=A0 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 4 ++--
> > =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> > b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> > index 077b107130f6..fbc219c2d53b 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> > @@ -56,7 +56,7 @@ static void *server(void *arg)
> > =C2=A0=C2=A0	while (bytes < total_bytes && !READ_ONCE(stop)) {
> > =C2=A0=C2=A0		nr_sent =3D send(fd, &batch,
> > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIN(total_bytes - b=
ytes,
> > sizeof(batch)), 0);
> > -		if (nr_sent =3D=3D -1 && errno =3D=3D EINTR)
> > +		if (nr_sent =3D=3D -1 && (errno =3D=3D EINTR || errno =3D=3D
> > EAGAIN))
>=20
> This is a non blocking socket. EAGAIN is hitting the timeout
> situation?
>=20
> The default timeout is 3s and it has not been changed after the
> recent=20
> connect_fd_to_fd and start_server simplifications. I don't find bpf
> CI failing=20
> in this test in the last month also.
>=20
> I would prefer to fail after timeout instead of keep retrying. Do you
> really hit=20
> that in your environment for this specific bpf_tcp_ca test? There are
> many tests=20
> using this timeout value also.

This is the 2nd patch of "refactor mptcp bpf tests" series:

https://patchwork.kernel.org/project/mptcp/cover/cover.1711688054.git.tangg=
eliang@kylinos.cn/

I didn't get the mentioned EAGAIN errors in bpf_tcp_ca tests, but got
them in MPTCP BPF sched tests (see patch 1). MPTCP BPF sched tests (not
upstream yet) use the same sending and receiving functions as
bpf_tcp_ca tests (patch 15). So it makes sense to add this fix for
bpf_tcp_ca tests too.

And here's another reason. I want to move these functions from
bpf_tcp_ca into network_helpers as public ones (patch 4), which can be
used by both bpf_tcp_ca and MPTCP BPF sched tests. So we must add this
fix to the public ones too.

Maybe the commit log of this patch needs to be updated. Or I should
send patches 2, 3 and 4 together to bpf-next?

I'd like to hear your opinion.

Thanks,
-Geliang

