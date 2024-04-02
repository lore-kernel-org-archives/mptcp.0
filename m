Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E7A5D749;
	Tue,  2 Apr 2024 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055199; cv=none; b=dptByFxVNxjaRArQBvT87lvXha3SQZuZPSz8GmPd+/CRfWp7mF+v8CRj9mj6Ed1v26Y8vIeI6T62fbx7xQutXY1q+aOKNb9mQfBl4oSR/rAYVcT4PUiUjpnOLbJppRVGIaT1UgJ6h8xVch3Ps1xA40VRrjaPC7zgp58rlRyNQBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055199; c=relaxed/simple;
	bh=1s3B+aMHGJOWQat6jjX9waA3HYmC1FreiYFvB3d5G5s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CmywwbT77CjIgh90y6eBokOHBj3XwIuYSnZJL1/kyoHx3kS7c206yR19g8daEHNVFb+ZV7Y34yJn5JUykWoqrARz6QUF75GyXlfx2Raz/WOT56jGj0KtraU8474ofTikXxI6eng115dCNqk9oVVeiSUfDHYEILb4s2vKCppttz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSJQJusg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSJQJusg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3C9C433F1;
	Tue,  2 Apr 2024 10:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712055199;
	bh=1s3B+aMHGJOWQat6jjX9waA3HYmC1FreiYFvB3d5G5s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eSJQJusg8epkJ3zJ49ebQxxQBwgOEmYp2WlbI/3FR94NYaS01QFEcAQVozyl/tIff
	 j+ntwHimmMPMV1YSKciNt73LR1AAG1EXZvpmEmJvmkIyviNUCyUQ7hvafgBLTvOWIm
	 +tBWfCmZY1GtZMh2E3tvphsVj0s7CO3z1H9qQ9Pwl1Oddut1Ja430pqZxSVufDs/Fh
	 F0PTi7pbYr0ftuIYEShV9av4rDGBo+8COlLE/sqe+g2/fEZM0gzxDzDVMN59KGRrP5
	 R49vO81HJu2M/zH642FcMM3z8d3O8/zX1HsTxO+j2ijs3ou9xgMWkFE3fjW947vVI4
	 s19F2JqIpNegg==
Message-ID: <b3943f9a8bf595212b00e96ba850bf32893312cc.camel@kernel.org>
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
Date: Tue, 02 Apr 2024 18:53:10 +0800
In-Reply-To: <4cb1511c-c623-497f-818e-a4d4614548ed@linux.dev>
References:
	 <78a17486bd12d7afb4cce565d58dac3f15e55c49.1711620349.git.tanggeliang@kylinos.cn>
	 <e6074193-7530-4c85-9429-9393e24c172d@linux.dev>
	 <59b0295363548c115b65b4555d0f7484738f5bda.camel@kernel.org>
	 <4cb1511c-c623-497f-818e-a4d4614548ed@linux.dev>
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

On Fri, 2024-03-29 at 10:27 -0700, Martin KaFai Lau wrote:
> > > > On 3/28/24 10:57 PM, Geliang Tang wrote:
> > > > > > > > Hi Martin,
> > > > > > > >=20
> > > > > > > > On Thu, 2024-03-28 at 09:55 -0700, Martin KaFai Lau
> > > > > > > > wrote:
> > > > > > > > > > > > On 3/28/24 3:23 AM, Geliang Tang wrote:
> > > > > > > > > > > > > > > > From: Geliang Tang
> > > > > > > > > > > > > > > > <tanggeliang@kylinos.cn>
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > bpf_tcp_ca tests may emit EAGAIN
> > > > > > > > > > > > > > > > sometimes. In that
> > > > > > > > > > > > > > > > case, tests
> > > > > > > > > > > > > > > > fail with
> > > > > > > > > > > > > > > > "bytes !=3D total_bytes" errors. Sending
> > > > > > > > > > > > > > > > should continue,
> > > > > > > > > > > > > > > > not
> > > > > > > > > > > > > > > > break
> > > > > > > > > > > > > > > > when
> > > > > > > > > > > > > > > > errno is EAGAIN. This patch can make
> > > > > > > > > > > > > > > > bpf_tcp_ca tests
> > > > > > > > > > > > > > > > stable.
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > Signed-off-by: Geliang Tang
> > > > > > > > > > > > > > > > <tanggeliang@kylinos.cn>
> > > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > > > =C2=A0=C2=A0
> > > > > > > > > > > > > > > > tools/testing/selftests/bpf/prog_tests/
> > > > > > > > > > > > > > > > bpf_tcp_ca.c
> > > > > > > > > > > > > > > > | 4 ++--
> > > > > > > > > > > > > > > > =C2=A0=C2=A0 1 file changed, 2 insertions(+=
), 2
> > > > > > > > > > > > > > > > deletions(-)
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > diff --git
> > > > > > > > > > > > > > > > a/tools/testing/selftests/bpf/prog_test
> > > > > > > > > > > > > > > > s/bpf_tcp_ca.c
> > > > > > > > > > > > > > > > b/tools/testing/selftests/bpf/prog_test
> > > > > > > > > > > > > > > > s/bpf_tcp_ca.c
> > > > > > > > > > > > > > > > index 077b107130f6..fbc219c2d53b 100644
> > > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > > > a/tools/testing/selftests/bpf/prog_test
> > > > > > > > > > > > > > > > s/bpf_tcp_ca.c
> > > > > > > > > > > > > > > > +++
> > > > > > > > > > > > > > > > b/tools/testing/selftests/bpf/prog_test
> > > > > > > > > > > > > > > > s/bpf_tcp_ca.c
> > > > > > > > > > > > > > > > @@ -56,7 +56,7 @@ static void
> > > > > > > > > > > > > > > > *server(void *arg)
> > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 while (bytes < total_byt=
es &&
> > > > > > > > > > > > > > > > !READ_ONCE(stop)) {
> > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 nr_sent =3D send(fd, &ba=
tch,
> > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 MIN(total_bytes - bytes,
> > > > > > > > > > > > > > > > sizeof(batch)), 0);
> > > > > > > > > > > > > > > > - if (nr_sent =3D=3D -1 && errno =3D=3D EIN=
TR)
> > > > > > > > > > > > > > > > + if (nr_sent =3D=3D -1 && (errno =3D=3D EI=
NTR
> > > > > > > > > > > > > > > > || errno =3D=3D
> > > > > > > > > > > > > > > > EAGAIN))
> > > > > > > > > > > >=20
> > > > > > > > > > > > This is a non blocking socket. EAGAIN is
> > > > > > > > > > > > hitting the
> > > > > > > > > > > > timeout
> > > > > > > > > > > > situation?
> > > > > > > > > > > >=20
> > > > > > > > > > > > The default timeout is 3s and it has not been
> > > > > > > > > > > > changed after
> > > > > > > > > > > > the
> > > > > > > > > > > > recent
> > > > > > > > > > > > connect_fd_to_fd and start_server
> > > > > > > > > > > > simplifications. I don't
> > > > > > > > > > > > find
> > > > > > > > > > > > bpf
> > > > > > > > > > > > CI failing
> > > > > > > > > > > > in this test in the last month also.
> > > > > > > > > > > >=20
> > > > > > > > > > > > I would prefer to fail after timeout instead of
> > > > > > > > > > > > keep
> > > > > > > > > > > > retrying. Do
> > > > > > > > > > > > you
> > > > > > > > > > > > really hit
> > > > > > > > > > > > that in your environment for this specific
> > > > > > > > > > > > bpf_tcp_ca test?
> > > > > > > > > > > > There
> > > > > > > > > > > > are
> > > > > > > > > > > > many tests
> > > > > > > > > > > > using this timeout value also.
> > > > > > > >=20
> > > > > > > > This is the 2nd patch of "refactor mptcp bpf tests"
> > > > > > > > series:
> > > > > > > >=20
> > > > > > > > https://patchwork.kernel.org/project/mptcp/cover/cover.1711=
688054.git.tanggeliang@kylinos.cn/
> > > > > > > > =C2=A0>
> > > > > > > > I didn't get the mentioned EAGAIN errors in bpf_tcp_ca
> > > > > > > > tests,
> > > > > > > > but
> > > > > > > > got
> > > > > > > > them in MPTCP BPF sched tests (see patch 1). MPTCP BPF
> > > > > > > > sched
> > > > > > > > tests
> > > > > > > > (not
> > > > > > > > upstream yet) use the same sending and receiving
> > > > > > > > functions as
> > > > > > > > bpf_tcp_ca tests (patch 15). So it makes sense to add
> > > > > > > > this fix
> > > > > > > > for
> > > > > > > > bpf_tcp_ca tests too.
> > > >=20
> > > > It sounds like the EAGAIN is specific to mptcp sched test and
> > > > is
> > > > not
> > > > due to a=20
> > > > timeout? Did you try to increase the timeout and see if it
> > > > resolves
> > > > the issue?
> > > >=20
> > > > afaik, there is no fix needed for the bpf_tcp_ca test. bpf CI
> > > > expects
> > > > the test=20
> > > > to finish. If the default 3s turns out to be too flaky for most
> > > > tests, it could=20
> > > > be increased instead of loop testing EAGAIN because the bpf CI
> > > > expects the test=20
> > > > to finish. However, so far I don't see this (i.e. 3s is too
> > > > short)
> > > > to
> > > > be the=20
> > > > case from looking at one month old data in bpf CI.

Thanks for your suggestions. I finally fixed this issue by explicitly
setting the server sockets with nonblock flags in MPTCP BPF tests. Then
EAGAIN will not appear in the tests anymore. The fix is here:

https://patchwork.kernel.org/project/mptcp/patch/f0b66813ae8274e5653988d80d=
16171508f05796.1712042049.git.tanggeliang@kylinos.cn/

That means this patch "selftests/bpf: Handle EAGAIN in bpf_tcp_ca" can
be dropped now.

> > > > > > > > And here's another reason. I want to move these
> > > > > > > > functions from
> > > > > > > > bpf_tcp_ca into network_helpers as public ones (patch
> > > > > > > > 4), which
> > > > > > > > can
> > > > > > > > be
> > > > > > > > used by both bpf_tcp_ca and MPTCP BPF sched tests. So
> > > > > > > > we must
> > > > > > > > add
> > > > > > > > this
> > > > > > > > fix to the public ones too.
> > > >=20
> > > > Lets understand why mptcp sched test hits EAGAIN first.

The patches "export send_byte and send_recv_data into network_helpers"
have been sent to bpf-next, please review them when you have time:

https://patchwork.kernel.org/project/netdevbpf/cover/cover.1712039441.git.t=
anggeliang@kylinos.cn/


> > > > > > > > Maybe the commit log of this patch needs to be updated.
> > > > > > > > Or I
> > > > > > > > should
> > > > > > > > send patches 2, 3 and 4 together to bpf-next?
> > > >=20
> > > > All selftests/bpf changes have to pass bpf CI. It is always a
> > > > good
> > > > idea to=20
> > > > target bpf-next to kick off the bpf CI to bar any surprise
> > > > later
> > > > when
> > > > it got=20
> > > > merged into bpf-next.
> > > >=20
> > > > Unrelated, since we are in the mptcp bpf test, one thing needs
> > > > to
> > > > fix
> > > > in=20
> > > > test_mptcpify(). The mptcpify test is upgrading a IPPROTO_TCP
> > > > socket
> > > > to=20
> > > > IPPROTO_MPTCP socket. This could break other tests when the
> > > > test_progs is run in=20
> > > > parallel (test_progs "-j" which fork() to run prog_tests/* in
> > > > parallel). It=20
> > > > could unexpectedly upgrade the tcp socket of another test. One
> > > > option
> > > > is to=20
> > > > limit the upgrade by checking the pid in the mptcpify.c bpf
> > > > prog.

I just sent a patch named "selftests/bpf: Add pid limit for mptcpify
prog" to fix this and added your "suggested-by" tag in it.

Thanks,
-Geliang

> > > >=20
> > > >=20

