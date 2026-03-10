Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F1144A725;
	Tue, 10 Mar 2026 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137037; cv=none; b=RzBaQlOdEkD/Lmw6kqdlfzESy5bvt0A6lnEJFF+WiQaJjnuQgBWgHx4fSJxdpIH40NDZZrmgEl1K4cUQWKqNklWbLsP/zvO15zftFqVfI3WpXj7UBesUsRI9x2+rVeChyzsTxz4+KaWUzHYu5bEpea7iJO8G4l1anSSAGomhnTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137037; c=relaxed/simple;
	bh=/u2WQp5fcyZioDQPVTsvawNu/rZDRBfSQ4FJERE46Es=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pp9ugbw31IDHQaWWYxt2gh2yPAQhcA9Q0KNjwW87qIQSDt5SlHbd3zWv58fODzfN9+ouQib34UQMvudzqeOrZXgOWTOhYa/dn0k5/nb2pPI/Ss+Ynwg8zXeGjtWj+aEIsR0NyrVe2XAq+jOKWiEcRiDWjNzxk5t/QFMKxyYJ30Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ps7jYfJl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ps7jYfJl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CC8C2BCB9;
	Tue, 10 Mar 2026 10:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773137037;
	bh=/u2WQp5fcyZioDQPVTsvawNu/rZDRBfSQ4FJERE46Es=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ps7jYfJlkO/135q6uJIpCJxv8N3QQmQQZYf8wqQ0nHQnGTWPOidr2ZoiCVPRdlXjq
	 HeiaG2cjDw2cOvwj3sMh6BXEEVSacKzshS2e78bko9EHKCN3cCiKFiJUpKkifGgA+r
	 qy4iFh+ssIkJyjTCkQY7wYUl3VJdGiHvY0PXSqReVlmmEbyESpIY2776zLCyIvE050
	 yb+pvEdZmZ4wGzHM5Vy+LgopgO8sS1TdW0ORurwHemCzQkTH1WiF2Df4lCM9t1YSCc
	 pXfryUmV6x0lw84L9A29rv6SCcE8QaqWoN2I8uymA91DAlxCY+t7fZQfObs7WHhn0o
	 XDVzFVlWaFr/w==
From: Thomas Gleixner <tglx@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, Netdev
 <netdev@vger.kernel.org>, rcu@vger.kernel.org, MPTCP Linux
 <mptcp@lists.linux.dev>, Linux Kernel <linux-kernel@vger.kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 luto@kernel.org, Michal =?utf-8?Q?Koutn=C3=BD?= <MKoutny@suse.com>, Waiman
 Long
 <longman@redhat.com>, Marco Elver <elver@google.com>
Subject: Re: Stalls when starting a VSOCK listening socket: soft lockups,
 RCU stalls, timeout
In-Reply-To: <76e2b909-98db-49de-a8eb-f6f0a192f630@kernel.org>
References: <863a5291-a636-47d0-891c-bb0524d2e134@kernel.org>
 <20260302114636.GL606826@noisy.programming.kicks-ass.net>
 <717310d8-6274-4b7f-8a19-561c45f5f565@kernel.org>
 <a2b573b4-af61-4b84-a7d1-012ed6bb23c9@kernel.org>
 <ba067933-bf3b-476d-a0bb-53eda56996ca@kernel.org> <87zf4m2qvo.ffs@tglx>
 <47cba228-bba7-4e58-a69d-ea41f8de6602@kernel.org> <87tsuu2i59.ffs@tglx>
 <7efde2b5-3b72-4858-9db0-22493d446301@kernel.org> <87qzpx2sck.ffs@tglx>
 <20260306152458.GT606826@noisy.programming.kicks-ass.net>
 <87ldg42eu7.ffs@tglx> <87h5qr2rzi.ffs@tglx> <87eclu3coa.ffs@tglx>
 <87v7f61cnl.ffs@tglx> <57c1e171-9520-4288-9e2d-10a72a499968@kernel.org>
 <87pl5ds88r.ffs@tglx> <0ae4d678-5676-4523-bae3-5ad73b526e27@kernel.org>
 <87eclsrtqg.ffs@tglx> <e846cb5f-65c4-4a9b-9f9b-593e4af526d8@kernel.org>
 <76e2b909-98db-49de-a8eb-f6f0a192f630@kernel.org>
Date: Tue, 10 Mar 2026 11:03:52 +0100
Message-ID: <878qc0rofr.ffs@tglx>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10 2026 at 10:00, Jiri Slaby wrote:
> On 10. 03. 26, 9:56, Jiri Slaby wrote:
>> Thomas,
>>=20
>> On 10. 03. 26, 9:09, Thomas Gleixner wrote:
>>> =C2=A0=C2=A0=C2=A0 2) task is not longer in the task list w/o going thr=
ough do_exit()
>>=20
>> After a quick look (I have to run now, so I could be completely wrong):=
=20
>> what about the task is not in the list *yet*. You use RCU ->=20
>> for_each_process_thread(), so there could be a race with attach_pid()=20
>> protected by tasklist_lock.
>
> Not attach_pid(), that's irrelevant here.
>
> But one line below in copy_process(): list_add_tail().

Yes. There is an issue. Peter and me just discovered that as well, but
in the case at hand it can't be the problem. The missing task is on the
CPU which means it must be visible in the thread list and task list.

Thanks,

        tglx
