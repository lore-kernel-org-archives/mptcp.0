Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77EA28E8
	for <mptcp@lists.linux.dev>; Tue, 23 Apr 2024 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713841206; cv=none; b=I3+BoHCgavAPHk/MrwQmsED57zQkUAhaCVufLsgiR53fDqTBWIltL1PP+DdU6Gtf8I0OmiqvzU9KP7/PJsngUh7MUV56IHcO9KxTZrgN137XE8eu2cemAfqIiQMDSBTfT3cC4qT3hsmlA5jFAwBTPPMTQ3KNmgNpS3DV3LwwaI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713841206; c=relaxed/simple;
	bh=xee/ns/lUO3jUtGwI5Spjg+dbj0fBnpkLjLWIhxb8yM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KBUmeDe+SF0JGpDa23Og76sVOAotsVXo0WJ8vNNORaqSEawwk1Z2VX1wkH9IB6n0oTKDhJF8JtzBAoKQMcA3/y3zXjx2+ie8+M8Xano4zWF5szMqIWNqfYZlJVQH3Z9HRfbrn9gopCdgjGDrnO8+GtCIIcq2j96yHMrd6HbzzPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gArFRQm6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gArFRQm6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80287C113CC;
	Tue, 23 Apr 2024 03:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713841206;
	bh=xee/ns/lUO3jUtGwI5Spjg+dbj0fBnpkLjLWIhxb8yM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gArFRQm6OufqqO6KmqiooFxrADzTp/DDDXeVh1ihS4uU6u75sUFwRUgGVK5cQkYdK
	 17NNolMqPO2MxuELnourh/HHXdBM88n5obcI3xGxIFNzLcCov1cwQta4Bra86A0h6y
	 fBYGcdFyeK/tqJGXehYvwgYjwfRA6yd7dJHs4xObiik8eXXDON3ByzbMRpccx+tbUr
	 c53gCwdG1t6cK8y6llGEP8lGUWo0wuzvSWzbmxA5Rob8OyHz9RitWsDyKVvV+dTKHI
	 KUnj7neEo97zoNBVwalV5L41VrodmiYr6Sn/2R+/uFL/vy0OGDS6ysp0KkX6KZwQVL
	 bbUvCk56OrVRw==
Message-ID: <3823fe6ceb475a32b6394a935fd3032da481234b.camel@kernel.org>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Support nonblock for
 send_recv_data
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Tue, 23 Apr 2024 10:58:53 +0800
In-Reply-To: <8a0b7902-4b75-47cc-a22b-d3b97ecac22d@kernel.org>
References: <cover.1712729342.git.tanggeliang@kylinos.cn>
	 <9cd358958245f8ec87c4f553779aa4243f967a2f.1712729342.git.tanggeliang@kylinos.cn>
	 <12aab271-da72-49b4-ac91-2091b6889856@linux.dev>
	 <bec7ade6bfc99f6340fa231cf68f0f4459625dbe.camel@kernel.org>
	 <9475c2259b3d32774bc1488dd0d6004f7ddfbf13.camel@kernel.org>
	 <52673f90-84c6-4e3d-9967-a3d0a7335c46@kernel.org>
	 <7732f129e5c1c2ff128878be9b865115e1319b85.camel@kernel.org>
	 <0017e477-3fcd-45de-917b-b58b3781ca9b@kernel.org>
	 <d0032920b64e075c5247b431ae48acc47232bff3.camel@kernel.org>
	 <8a0b7902-4b75-47cc-a22b-d3b97ecac22d@kernel.org>
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

On Mon, 2024-04-22 at 12:39 +0200, Matthieu Baerts wrote:
> On 22/04/2024 12:34, Geliang Tang wrote:
> > On Mon, 2024-04-22 at 12:31 +0200, Matthieu Baerts wrote:
> > > On 22/04/2024 12:04, Geliang Tang wrote:> On Mon, 2024-04-22 at
> > > 11:45
> > > +0200, Matthieu Baerts wrote:
> > >=20
> > > (...)
> > >=20
> > > > > I might be wrong, but with MPTCP schedulers, it is different:
> > > > > with
> > > > > non-blocking IO, EAGAIN can be seen, and this case needs to
> > > > > be
> > > > > handled.
> > > > > Actively waiting by retrying directly in the loop in case of
> > > > > EAGAIN
> > > > > is
> > > > > not recommended, but probably OK for the tests (still, might
> > > > > be
> > > > > good
> > > > > to
> > > > > add a comment to recommend polling instead). So here as well,
> > > > > such
> > > > > modifications can stay in our tree for the moment.
> > > > >=20
> > > > > Also, what is not clear to me is where we set the socket as
> > > > > the
> > > > > non-blocking one. Is it only done for MPTCP servers/clients?
> > > >=20
> > > > I didn't set the socket as non-block in the end.
> > > >=20
> > > > EAGAIN will be got no matter non-block flag is set or not.
> > >=20
> > > That's strange, no? When the userspace sends data with a blocking
> > > IO
> > > socket, it should not get EAGAIN, no?
> > >=20
> > > > In old version like "[mptcp-next,v7,0/5] setsockopt per
> > > > subflow:
> > > > BPF":
> > > >=20
> > > > https://patchwork.kernel.org/project/mptcp/cover/cover.1712571740.g=
it.tanggeliang@kylinos.cn/
> > > >=20
> > > > "set_nonblock" is added in patch 2, and invoked in
> > > > run_subflow() in
> > > > patch 3.
> > >=20
> > > I see, but the commit message of patch 2 doesn't explain why
> > > set_nonblock() is needed for MPTCP. I see it is used in patch 3,
> > > but
> > > is
> > > it really necessary? Maybe it was added for other reasons, that
> > > are
> > > no
> > > longer valid today?
> > >=20
> > > > > > I added a issue #487 to trace this issue.
> > >=20
> > > Please also note that we didn't have this issue for a while. When
> > > we
> > > had
> > > it, it is when KVM was not supported on the CI:
> > >=20
> > > =C2=A0$ /opt/virtme/virtme-run (...)
> > > =C2=A0Could not access KVM kernel module: No such file or directory
> > > =C2=A0qemu-system-x86_64: failed to initialize kvm: No such file or
> > > directory
> > > =C2=A0qemu-system-x86_64: falling back to tcg
> > >=20
> > >=20
> > > Maybe we had this issue because the VM was abnormally too slow,
> > > and
> > > we
> > > reached the 3 seconds timeout described by Martin in a previous
> > > message?
> > > If this is due to the "abnormally slow setup", maybe we don't
> > > need to
> > > do
> > > anything?
> > >=20
> > > In other words, can you (easily) reproduce the issue on your
> > > side?
> > > With
> > > or without KVM support?
> >=20
> > It's easy to reproduce by increasing total_bytes:
> Even without "set_nonblock()"? With what is in our tree, we don't do
> that.

Yes, without "set_nonblock". Without making any modifications, it can
be reproduced in our tree. Increasing totol_bytes can make reproduction
easier.

>=20
> As I mentioned above, if 'send()' stops before the end with -1 and
> errno
> set to EAGAIN while the socket is supposed to wait for the transfer
> to
> be over (blocking IO), I guess there is a bug somewhere, but not in
> the
> tests, no?

Yes, I think it's a bug in kernel space in wait_for_memory in
mptcp_sendmsg().

Thanks,
-Geliang=20

>=20
> Cheers,
> Matt

