Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED1C3ACA50;
	Thu,  5 Mar 2026 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727408; cv=none; b=mi6X+YuShstigWkfQj1Gq40tAQjKy/6LDji0mQ5Cde/6yikbyOBWD1aTqNts7uFlU9h8OCitgHmKWSVTgSpFL/HzKgsW3dSacxMSoqSThNNPxl3dtpNb6pHBHF0WqEN5ddXQ0KkaXy2pc+lccq9CYStAE7n1BqYSJv/GmcV5xbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727408; c=relaxed/simple;
	bh=tYWAoI05j+Zw9plPeywTp7SD38iDFKoJN5mm6OLALGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lf34R9BzPm4FHdFHq5SqO92wvsqG7M/lVrMm5XOleys2HSaMt+zWUJYPrtnEdTvUlbpT9H0SrFBc7PbFMZRXdZZIbvFX4h4mPtMgg/ZqAPR964gMQQneqJXk1r8n1hDwiOvjI2wnYDeXFiWWucnN/ljTqvCvcswfG4GTrulzyag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUxpHcxi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUxpHcxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C6FC2BCB8;
	Thu,  5 Mar 2026 16:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772727407;
	bh=tYWAoI05j+Zw9plPeywTp7SD38iDFKoJN5mm6OLALGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qUxpHcxiwuU1FjD2FXdRDAjZTZjaYHF88cK0F5UhX3xZwuf63NxjXxDB8vKxq7BHc
	 J2Chs1Yspuu0jJ2scThI3oU82p81H1OUyJs1rqbHH1PhfShQs29ErDwkow8ugZYLBD
	 5Z5nDIsSoFLwZP5f9CL+aKgckGOt+PRHSMdtAyF5uyGZ7afiV+Ecs5akWwCKn/2Qvm
	 a79hbm5iKNL0g5Wvi84Ij2zlMfClG51rwp6mxnnvLhPPjMHWFwuBQGXUCn6TgPJltu
	 +a+L4w0OZt8rsQDE2UuXIClWXyBY2kwHTAU0RG3orJINfW2x9UeZwjaWVUNY5dHSOn
	 Wy80FaOdiAnvw==
From: Thomas Gleixner <tglx@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, Netdev
 <netdev@vger.kernel.org>, rcu@vger.kernel.org, MPTCP Linux
 <mptcp@lists.linux.dev>, Linux Kernel <linux-kernel@vger.kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 "luto@kernel.org" <luto@kernel.org>, Michal =?utf-8?Q?Koutn=C3=BD?=
 <MKoutny@suse.com>,
 Waiman Long <longman@redhat.com>
Subject: Re: Stalls when starting a VSOCK listening socket: soft lockups,
 RCU stalls, timeout
In-Reply-To: <ba067933-bf3b-476d-a0bb-53eda56996ca@kernel.org>
References: <b24ffcb3-09d5-4e48-9070-0b69bc654281@kernel.org>
 <7f3e74d7-67dc-48d7-99d2-0b87f671651b@kernel.org>
 <863a5291-a636-47d0-891c-bb0524d2e134@kernel.org>
 <20260302114636.GL606826@noisy.programming.kicks-ass.net>
 <717310d8-6274-4b7f-8a19-561c45f5f565@kernel.org>
 <a2b573b4-af61-4b84-a7d1-012ed6bb23c9@kernel.org>
 <ba067933-bf3b-476d-a0bb-53eda56996ca@kernel.org>
Date: Thu, 05 Mar 2026 17:16:43 +0100
Message-ID: <87zf4m2qvo.ffs@tglx>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05 2026 at 13:20, Jiri Slaby wrote:
> On 05. 03. 26, 12:53, Jiri Slaby wrote:
>> owner_cpu is 1, owner is:
>> PID: 7508=C2=A0=C2=A0=C2=A0=C2=A0 TASK: ffff8cc4038b8000=C2=A0 CPU: 1=C2=
=A0=C2=A0=C2=A0 COMMAND: "compile"
>>=20
>> But as you can see above, CPU1 is occupied with a different task:
>> crash> bt -sxc 1
>> PID: 7680=C2=A0=C2=A0=C2=A0=C2=A0 TASK: ffff8cc4038525c0=C2=A0 CPU: 1=C2=
=A0=C2=A0=C2=A0 COMMAND: "asm"
>>=20
>> spinning in mm_get_cid() as I wrote. See the objdump of mm_get_cid below.
>
> You might be interested in mm_cid dumps:
>
> =3D=3D=3D=3D=3D=3D PID 7508 (sleeping, holding the rq lock) =3D=3D=3D=3D=
=3D=3D
>
> crash> task -R mm_cid -x 7508
> PID: 7508     TASK: ffff8cc4038b8000  CPU: 1    COMMAND: "compile"
>    mm_cid =3D {
>      active =3D 0x1,
>      cid =3D 0x40000003

CID 3 owned by CPU 1

>    },
>
> crash> p ((struct task_struct *)(0xffff8cc4038b8000))->mm->mm_cid|head -4
> $6 =3D {
>    pcpu =3D 0x66222619df40,
>    mode =3D 1073741824,

mode =3D per CPU mode

>    max_cids =3D 4,
>
>
> =3D=3D=3D=3D=3D=3D PID 7680 (spinning in mm_get_cid()) =3D=3D=3D=3D=3D=3D
>
> crash> task -R mm_cid -x 7680
> PID: 7680     TASK: ffff8cc4038525c0  CPU: 1    COMMAND: "asm"
>    mm_cid =3D {
>      active =3D 0x1,
>      cid =3D 0x80000000

CID is unset

>    },
>
> crash> p ((struct task_struct *)(0xffff8cc4038b8000))->mm->mm_cid|head -4
> $8 =3D {
>    pcpu =3D 0x66222619df40,
>    mode =3D 1073741824,

That's per CPU mode too

>    max_cids =3D 4,
>
>
> =3D=3D=3D=3D=3D=3D per-cpu for CPU1 =3D=3D=3D=3D=3D=3D
>
> crash> struct mm_cid_pcpu -x fffff2e9bfc89f40
> struct mm_cid_pcpu {
>    cid =3D 0x40000003

That's the one owned by CPU 1

> }
>
> Dump of any other's mm_cids needed?

It would be helpful to see the content of all PCPU CIDs and
tsk::mm_cid::* for all tasks which belong to that process.

Thanks,

        tglx
