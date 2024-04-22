Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB6213C3F4
	for <mptcp@lists.linux.dev>; Mon, 22 Apr 2024 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780279; cv=none; b=JUhZOs8mMTPwkpyoGG/FRiNf7DpB+XZRDtjk/omaP2snfp1A94BpzpPo1yUO884cwCNNSFALJTq+uICIgT28Zd3j8QPBuE6vEWFHuPePn3wkcEGfRiQFUKzn/l+/gC0BZZxp7iFiU8H0uqiVtJVmABU4trB5tP0mO0VF7h8Ce7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780279; c=relaxed/simple;
	bh=ZvE+Oa2DbnCu3E2+WkUCqFwkJ3nlY1Q4+r5RFGNBqGw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aAvJ8b6LcE6qkel71+ZBGB1ev3dMQKhg03WZ+kuRT4HQcltM1GIJac7Dby9LsSAJsCRYUDqerCZQf4Sn3vP6UTvrSqwkQBurJJmcRXDPIHSTcn8axdeOshiqCqdrBCwJS4VyMxf4owCtSIS6SnnJbpfpMKqSRXRhMic1mN2B0mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+Ma901q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+Ma901q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B37C113CC;
	Mon, 22 Apr 2024 10:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713780279;
	bh=ZvE+Oa2DbnCu3E2+WkUCqFwkJ3nlY1Q4+r5RFGNBqGw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=M+Ma901qS+LViEv2h1QsUPqv7ArFPRtYnSg19dl7p+1oT4X5qRtQY8Ai72WapNjuG
	 RYx/E8L14x73eqvaN/Xulj/wCtwGwcpYUQbjykX1VtTVniS/Sz1fwOCNrSlkvpFzhA
	 DSAZvhVvolm139mjup/UVW4kL1MCiwDmM3ZAc/XT62Y9W2OxRi03vP/NbMWC+hhAA8
	 52rUjhFZmpCDLEeJDkEaxKESOe7i83IfUKSQLd/200QUKkYum/oTYFPvrjfcXTYkB8
	 JTPppUlUm9HVMZFUlMHCGYEzaJ/tzsdtG0nb/fGe4cfJRSjtG05LLa3/BH6yXvCJMl
	 OO5ZXrqYNf/YA==
Message-ID: <7732f129e5c1c2ff128878be9b865115e1319b85.camel@kernel.org>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Support nonblock for
 send_recv_data
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Mon, 22 Apr 2024 18:04:32 +0800
In-Reply-To: <52673f90-84c6-4e3d-9967-a3d0a7335c46@kernel.org>
References: <cover.1712729342.git.tanggeliang@kylinos.cn>
	 <9cd358958245f8ec87c4f553779aa4243f967a2f.1712729342.git.tanggeliang@kylinos.cn>
	 <12aab271-da72-49b4-ac91-2091b6889856@linux.dev>
	 <bec7ade6bfc99f6340fa231cf68f0f4459625dbe.camel@kernel.org>
	 <9475c2259b3d32774bc1488dd0d6004f7ddfbf13.camel@kernel.org>
	 <52673f90-84c6-4e3d-9967-a3d0a7335c46@kernel.org>
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

On Mon, 2024-04-22 at 11:45 +0200, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 22/04/2024 08:50, Geliang Tang wrote:
> > On Thu, 2024-04-11 at 14:52 +0800, Geliang Tang wrote:
> > > mptcp-only
> > >=20
> > > Hi Matt & Mat,
> > >=20
> > > On Wed, 2024-04-10 at 14:34 -0700, Martin KaFai Lau wrote:
> > > > On 4/9/24 11:13 PM, Geliang Tang wrote:
> > > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > >=20
> > > > > Some tests, such as the MPTCP bpf tests, require
> > > > > send_recv_data
> > > > > helper
> > > > > to run in nonblock mode.
> > > > >=20
> > > > > This patch adds nonblock support for send_recv_data(). Check
> > > > > if
> > > > > it
> > > > > is
> > > > > currently in nonblock mode, and if so, ignore EWOULDBLOCK to
> > > > > continue
> > > > > sending and receiving.
> > > > >=20
> > > > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > > > ---
> > > > > =C2=A0 tools/testing/selftests/bpf/network_helpers.c | 9 ++++++++=
-
> > > > > =C2=A0 1 file changed, 8 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/tools/testing/selftests/bpf/network_helpers.c
> > > > > b/tools/testing/selftests/bpf/network_helpers.c
> > > > > index 137cd18ef3f2..ca16ef2b648e 100644
> > > > > --- a/tools/testing/selftests/bpf/network_helpers.c
> > > > > +++ b/tools/testing/selftests/bpf/network_helpers.c
> > > > > @@ -555,6 +555,7 @@ struct send_recv_arg {
> > > > > =C2=A0 static void *send_recv_server(void *arg)
> > > > > =C2=A0 {
> > > > > =C2=A0=C2=A0	struct send_recv_arg *a =3D (struct send_recv_arg
> > > > > *)arg;
> > > > > +	int flags =3D fcntl(a->fd, F_GETFL);
> > > > > =C2=A0=C2=A0	ssize_t nr_sent =3D 0, bytes =3D 0;
> > > > > =C2=A0=C2=A0	char batch[1500];
> > > > > =C2=A0=C2=A0	int err =3D 0, fd;
> > > > > @@ -578,6 +579,8 @@ static void *send_recv_server(void *arg)
> > > > > =C2=A0=C2=A0		if (nr_sent =3D=3D -1 && errno =3D=3D EINTR)
> > > > > =C2=A0=C2=A0			continue;
> > > > > =C2=A0=C2=A0		if (nr_sent =3D=3D -1) {
> > > > > +			if (flags & O_NONBLOCK && errno =3D=3D
> > > > > EWOULDBLOCK)
> > > >=20
> > > > I still don't see why it needs to be a non blocking IO. mptcp
> > > > should
> > > > work
> > > > with blocking IO also, no? Does it really need non blocking IO
> > > > to
> > > > make
> > > > mptcp test work? I would rather stay with blocking IO in
> > > > selftest
> > > > as
> > > > much as
> > > > possible for simplicity reason.
> > >=20
> > > I need some help here.
> > >=20
> > > This issue is reported by Matt in "CI: MPTCP BPF tests are now
> > > validated", and my fixes ([1] and this patch) aren't accepted by
> > > Martin. Is it normal to get EAGAINs in this case? Please give
> > > some
> > > suggestions.
>=20
> Thank you for the notification, I missed your previous question.
>=20
> Regarding Martin's comment about O_NONBLOCK, I understand that with
> the
> current BPF selftests -- so excluding the ones linked to the MPTCP
> schedulers -- it is not needed to support O_NONBLOCK.
>=20
> It looks like it is too early to do such modifications (patch 3), and
> probably better to do MPTCP specific modifications only in our tree
> for
> the moment. When upstreaming the new MPTCP BPF selftests, it will be
> clearer for BPF maintainers what are our requirements, and such
> modifications would make more sense, no?
>=20
> > It fails in mptcp_sendmsg()
> >=20
> > 1898 wait_for_memory:
> > 1899=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags)=
;
> > 1900=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __mptcp_push_pending(sk, msg->msg_flags);
> > 1901=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D sk_stream_wait_memory(sk, &timeo);
> > 1902=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > 1903=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto do_error;
> > 1904=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > sk_stream_wait_memory() fails in the case, and
> > tcp_rtx_and_write_queues_empty(sk) is true.
>=20
> My understanding is that with the current BPF selftests -- so
> excluding
> the ones linked to the MPTCP schedulers here as well -- it looks
> unlikely to have a EAGAIN errno, because only blocking IO is being
> used,
> right?
>=20
> I might be wrong, but with MPTCP schedulers, it is different: with
> non-blocking IO, EAGAIN can be seen, and this case needs to be
> handled.
> Actively waiting by retrying directly in the loop in case of EAGAIN
> is
> not recommended, but probably OK for the tests (still, might be good
> to
> add a comment to recommend polling instead). So here as well, such
> modifications can stay in our tree for the moment.
>=20
> Also, what is not clear to me is where we set the socket as the
> non-blocking one. Is it only done for MPTCP servers/clients?

I didn't set the socket as non-block in the end.

EAGAIN will be got no matter non-block flag is set or not.

In old version like "[mptcp-next,v7,0/5] setsockopt per subflow: BPF":

https://patchwork.kernel.org/project/mptcp/cover/cover.1712571740.git.tangg=
eliang@kylinos.cn/

"set_nonblock" is added in patch 2, and invoked in run_subflow() in
patch 3.

Thanks,
-Geliang

>=20
> > I added a issue #487 to trace this issue.
>=20
> Thanks!
>=20
> Cheers,
> Matt

