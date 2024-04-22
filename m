Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42A481C6
	for <mptcp@lists.linux.dev>; Mon, 22 Apr 2024 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713768631; cv=none; b=Cy1mSi2LfjiCl7ql1cVwuu1Oqj87hdhImAX4DXGGES8C7ta6sn1d20kcWVa8z3VBFgFTP2F8hE9h92L7pC0KF6qD4w5SEfM6sAD+RT5VmPncDHlLJGE0Meh3KLGSLrxo6ZlKdzuSJKFIrhtdgPcYGx1y66948ifTOftKzlDMHVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713768631; c=relaxed/simple;
	bh=niMcFupcFVaQSC9U8OI4dXgX/sV0N2nzgTSBGCDHrco=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iA60Kt8rSG4sVY7WIvxOhIHiRAuZ0WZG6vX4jKTvSqjNH7GykeuaIsiXqVSdwSsGEQ9AC0aY7SQ+KthvoLm3EmeGWwvsS+fSTPNGi2sXqnEoO6QoDtLc+1fwEd99B0t3bE8JCRhG/PujSOvmZRmJwZ5UHr6SjAKHxA3e+sOA70w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpghLfa/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpghLfa/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E104C113CC;
	Mon, 22 Apr 2024 06:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713768631;
	bh=niMcFupcFVaQSC9U8OI4dXgX/sV0N2nzgTSBGCDHrco=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MpghLfa/kIOkMmQHjbDJQksRrOXvovhWjy9yV47MaG1sWYfa8nbiiNEr0gy1UWNNk
	 mR5AYRoJPPETUblYVvtzjYhiRAP6TMR7VfFIa5z6nb6g7bCBpuTZYr/G62Dq24Xkba
	 VOaGogXKEBD24hvx3kOYI7emiIBCHsHhQDZGGQEybLyb2WI0vv41me1KRDTo/47Iaq
	 q4FfpjSS8OWrS0S7UtCd4yj+EKTWY/mpANmZfMV+3HOIUV8/pOMgGlPyWahtBgKIWC
	 GqMjwGJoPu4aiHXiWvsQfLk8IMMApoFWYiz145Ubs1VyE2QqfSnKOtAIGCeDbJeeAH
	 SdL42n01AJs5w==
Message-ID: <9475c2259b3d32774bc1488dd0d6004f7ddfbf13.camel@kernel.org>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Support nonblock for
 send_recv_data
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Mon, 22 Apr 2024 14:50:24 +0800
In-Reply-To: <bec7ade6bfc99f6340fa231cf68f0f4459625dbe.camel@kernel.org>
References: <cover.1712729342.git.tanggeliang@kylinos.cn>
	 <9cd358958245f8ec87c4f553779aa4243f967a2f.1712729342.git.tanggeliang@kylinos.cn>
	 <12aab271-da72-49b4-ac91-2091b6889856@linux.dev>
	 <bec7ade6bfc99f6340fa231cf68f0f4459625dbe.camel@kernel.org>
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

On Thu, 2024-04-11 at 14:52 +0800, Geliang Tang wrote:
> mptcp-only
>=20
> Hi Matt & Mat,
>=20
> On Wed, 2024-04-10 at 14:34 -0700, Martin KaFai Lau wrote:
> > On 4/9/24 11:13 PM, Geliang Tang wrote:
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > >=20
> > > Some tests, such as the MPTCP bpf tests, require send_recv_data
> > > helper
> > > to run in nonblock mode.
> > >=20
> > > This patch adds nonblock support for send_recv_data(). Check if
> > > it
> > > is
> > > currently in nonblock mode, and if so, ignore EWOULDBLOCK to
> > > continue
> > > sending and receiving.
> > >=20
> > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > ---
> > > =C2=A0 tools/testing/selftests/bpf/network_helpers.c | 9 ++++++++-
> > > =C2=A0 1 file changed, 8 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/tools/testing/selftests/bpf/network_helpers.c
> > > b/tools/testing/selftests/bpf/network_helpers.c
> > > index 137cd18ef3f2..ca16ef2b648e 100644
> > > --- a/tools/testing/selftests/bpf/network_helpers.c
> > > +++ b/tools/testing/selftests/bpf/network_helpers.c
> > > @@ -555,6 +555,7 @@ struct send_recv_arg {
> > > =C2=A0 static void *send_recv_server(void *arg)
> > > =C2=A0 {
> > > =C2=A0=C2=A0	struct send_recv_arg *a =3D (struct send_recv_arg *)arg;
> > > +	int flags =3D fcntl(a->fd, F_GETFL);
> > > =C2=A0=C2=A0	ssize_t nr_sent =3D 0, bytes =3D 0;
> > > =C2=A0=C2=A0	char batch[1500];
> > > =C2=A0=C2=A0	int err =3D 0, fd;
> > > @@ -578,6 +579,8 @@ static void *send_recv_server(void *arg)
> > > =C2=A0=C2=A0		if (nr_sent =3D=3D -1 && errno =3D=3D EINTR)
> > > =C2=A0=C2=A0			continue;
> > > =C2=A0=C2=A0		if (nr_sent =3D=3D -1) {
> > > +			if (flags & O_NONBLOCK && errno =3D=3D
> > > EWOULDBLOCK)
> >=20
> > I still don't see why it needs to be a non blocking IO. mptcp
> > should
> > work
> > with blocking IO also, no? Does it really need non blocking IO to
> > make
> > mptcp test work? I would rather stay with blocking IO in selftest
> > as
> > much as
> > possible for simplicity reason.
>=20
> I need some help here.
>=20
> This issue is reported by Matt in "CI: MPTCP BPF tests are now
> validated", and my fixes ([1] and this patch) aren't accepted by
> Martin. Is it normal to get EAGAINs in this case? Please give some
> suggestions.

It fails in mptcp_sendmsg()

1898 wait_for_memory:
1899                 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
1900                 __mptcp_push_pending(sk, msg->msg_flags);
1901                 ret =3D sk_stream_wait_memory(sk, &timeo);
1902                 if (ret)
1903                         goto do_error;
1904         }

sk_stream_wait_memory() fails in the case, and
tcp_rtx_and_write_queues_empty(sk) is true.

I added a issue #487 to trace this issue.

Thanks,
-Geliang

>=20
> [1]
> https://patchwork.kernel.org/project/mptcp/patch/311e074a3ca0465bdc5e4c22=
83e334bae5ccd306.1711296000.git.tanggeliang@kylinos.cn/
>=20
> Thanks,
> -Geliang
>=20
> >=20
> > I am afraid the root cause of the EAGAIN thread has not been
> > figured
> > out yet:
> > https://lore.kernel.org/all/b3943f9a8bf595212b00e96ba850bf32893312cc.ca=
mel@kernel.org/
> >=20
> > Lets drop patch 3 until it is understood why mptcp needs EAGAIN or
> > non-blocking IO.
> > It feels like there is some flakiness and it should be understood
> > and
> > avoided.
> >=20
> > Other than the comment in patch 2, the first two patches lgtm.
> > Please
> > respin with
> > the first two patches.
> >=20
> > > +				continue;
> > > =C2=A0=C2=A0			err =3D -errno;
> > > =C2=A0=C2=A0			break;
> > > =C2=A0=C2=A0		}
> > > @@ -599,6 +602,7 @@ static void *send_recv_server(void *arg)
> > > =C2=A0=20
> > > =C2=A0 int send_recv_data(int lfd, int fd, uint32_t total_bytes)
> > > =C2=A0 {
> > > +	int flags =3D fcntl(lfd, F_GETFL);
> > > =C2=A0=C2=A0	ssize_t nr_recv =3D 0, bytes =3D 0;
> > > =C2=A0=C2=A0	struct send_recv_arg arg =3D {
> > > =C2=A0=C2=A0		.fd	=3D lfd,
> > > @@ -622,8 +626,11 @@ int send_recv_data(int lfd, int fd, uint32_t
> > > total_bytes)
> > > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIN(total_bytes -=
 bytes,
> > > sizeof(batch)), 0);
> > > =C2=A0=C2=A0		if (nr_recv =3D=3D -1 && errno =3D=3D EINTR)
> > > =C2=A0=C2=A0			continue;
> > > -		if (nr_recv =3D=3D -1)
> > > +		if (nr_recv =3D=3D -1) {
> > > +			if (flags & O_NONBLOCK && errno =3D=3D
> > > EWOULDBLOCK)
> > > +				continue;
> > > =C2=A0=C2=A0			break;
> > > +		}
> > > =C2=A0=C2=A0		bytes +=3D nr_recv;
> > > =C2=A0=C2=A0	}
> > > =C2=A0=20
> >=20
> >=20
>=20

