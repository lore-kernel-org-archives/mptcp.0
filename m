Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5382D7DDB;
	Sat,  7 Mar 2026 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772874084; cv=none; b=b0yK/Yoh0AgtfmWprE1hlzDGKi6HZeNMtYqrR+XqjCE4JZm+TmOQiQ3+ryhYaH/4pSEdRG8ArKx22nEF7zj5Hf7zWQ3MjNkj+YcZJVOTcShpmgzbmGR6fImlzyrutZDBFM8oerFAbdinPlk1Ngh9C0u6RofgKR5/mJ9FhPRAERs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772874084; c=relaxed/simple;
	bh=HcmWURFUVniNjlOMNWDM3XuhFZvHHR6RnWvZS7kjD5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cgC0XiE/KIS/sIom+nhQ9O67RTcPx0/BltWo+oliK10g/b+EmbTtUXOApmuMqXRrHi7lX6GRb6rF9X7hykWGg1BWvV3LGjalY26UCIP323ySlF8suClXMQAZPa/ej4xtHOmuHvdTliJJHFMbPhpZ+bBvKS9QqOUTOlnTlqAhUwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hA+HFpjo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hA+HFpjo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE6BC19422;
	Sat,  7 Mar 2026 09:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772874084;
	bh=HcmWURFUVniNjlOMNWDM3XuhFZvHHR6RnWvZS7kjD5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hA+HFpjozgXqTlDFB0SU/ogBf+NmAVfr8Cd/grcE/wxMp2i/Tr62Z9AxK1wOAcLkR
	 asV19eEDOIcIdV4fmUvFHZhSkygR6E/mBuD0ZWkX+TARAC0xfnygdvSO82yJuHBUmc
	 uqc/Fi+ihn4doL60XgJq0qXoR767rhw/wUG81QAH6g8/c7VZCYFRwRK/y2PssMB/Pd
	 rrY5xqnVOlW4egEBDYjFo6Yz+qIL0/T4GjiUVuj6QsvArog9MuxIImTasX/DGu0Kl+
	 Iobi7xCHzAav2fDVfrw9As91C4zs/bQmofRtnLXH+K/eV/0CpbMBfJyX0Ieg4aJTvu
	 JtxU+kcF3Amog==
From: Thomas Gleixner <tglx@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, Netdev <netdev@vger.kernel.org>,
 rcu@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>, Linux Kernel
 <linux-kernel@vger.kernel.org>, Shinichiro Kawasaki
 <shinichiro.kawasaki@wdc.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, "luto@kernel.org"
 <luto@kernel.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <MKoutny@suse.com>,
 Waiman Long
 <longman@redhat.com>, Marco Elver <elver@google.com>
Subject: Re: Stalls when starting a VSOCK listening socket: soft lockups,
 RCU stalls, timeout
In-Reply-To: <20260306152458.GT606826@noisy.programming.kicks-ass.net>
References: <863a5291-a636-47d0-891c-bb0524d2e134@kernel.org>
 <20260302114636.GL606826@noisy.programming.kicks-ass.net>
 <717310d8-6274-4b7f-8a19-561c45f5f565@kernel.org>
 <a2b573b4-af61-4b84-a7d1-012ed6bb23c9@kernel.org>
 <ba067933-bf3b-476d-a0bb-53eda56996ca@kernel.org> <87zf4m2qvo.ffs@tglx>
 <47cba228-bba7-4e58-a69d-ea41f8de6602@kernel.org> <87tsuu2i59.ffs@tglx>
 <7efde2b5-3b72-4858-9db0-22493d446301@kernel.org> <87qzpx2sck.ffs@tglx>
 <20260306152458.GT606826@noisy.programming.kicks-ass.net>
Date: Sat, 07 Mar 2026 10:01:20 +0100
Message-ID: <87ldg42eu7.ffs@tglx>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 06 2026 at 16:24, Peter Zijlstra wrote:
> On Fri, Mar 06, 2026 at 10:57:15AM +0100, Thomas Gleixner wrote:
>
>> I tried with tons of test cases which stress test mmcid with threads and
>> failed.
>
> Are some of those in tools/testing/selftests ?
>
> Anyway, I was going over that code, and I noticed that there seems to be
> inconsistent locking for mm_mm_cid::pcpu.
>
> There's a bunch of sites that state we need rq->lock for remote access;
> but then things like sched_mm_cid_fork() and sched_mm_cid_exit() seem to
> think that holding mm_cid->lock is sufficient.
>
> This doesn't make sense to me, but maybe I missed something.

fork() and exit() are fully serialized. There can't be a mode change
with remote access going on concurrently.

I gave up staring at it yesterday as my brain started to melt. Let me
try again.

Thanks,

        tglx
