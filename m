Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426D540DFD2;
	Tue, 10 Mar 2026 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773150460; cv=none; b=dY77Sz8OwaSkqGLiWTn10XgYNwDnkZLN+ZhEzclNN6IiaHEgimpPKkP/fgRVpuCW5ZnUiee3ba7pXLWqg9FOVkEfuRsn5IbEtD8oPZsEsANfxKjJ61hDIq92YmP+chY3UqzWZy44ghhUuhykZ0x9gRbnt1zQT9wXESHOmv4xIAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773150460; c=relaxed/simple;
	bh=2+IBJ8l0YArk9c6MpfP8rThaUSBwcqM1jZp+Xt9Q7uQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eJQOMkKFK9rawd7kqqDGYo3NEF7T7/Yxadbf0+S+zkNk0D3RW1YOnZ11H2+6nH7iRCl4LLRdVMPwzxkJSuLoyJcNehil0faicn5J3jpaCymo1zbCRJzbZwezTIJhvr2QRaHbwFUiHFJ8c0So/FbOkCiCTOIUiFAChmXOLK/66OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8rkrF9/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8rkrF9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F03C19423;
	Tue, 10 Mar 2026 13:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773150459;
	bh=2+IBJ8l0YArk9c6MpfP8rThaUSBwcqM1jZp+Xt9Q7uQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=f8rkrF9/ZK/NwePW8e7bG5OrZ7E3hPqK4XLnXB+19kaG/qPwUE/jGeWJtrt9sXA+c
	 WRqkAfNhAaKHFwChsql8pCUYnojyznTHIwVrTTjSJzdwCR71LlodMbMhVGy4ao0A4S
	 kPSl3eEBZEIKXIK6k13Wokh86en03vtdxNU5oQhuo1YyBYSYWP7D/SY6AkAUUS8Z8T
	 mdn74yJTLwQYsJBN/XwYSuAZx9K2Z1ed26Yl9DQPdl5NAUAvNVbOiljQeHfT0T5G/s
	 p0VFQfDZpZ3vjXnMYqCcj2gZBcmbBxA4G+VYnmitBwSYv0i9EuSAGd8Gu/Q5Ee6PyQ
	 yfRy5/HywG+hQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Stefan Hajnoczi
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
In-Reply-To: <a5cabf68-df88-4a5e-8075-bb10debc44f7@kernel.org>
References: <87v7f61cnl.ffs@tglx>
 <57c1e171-9520-4288-9e2d-10a72a499968@kernel.org> <87pl5ds88r.ffs@tglx>
 <0ae4d678-5676-4523-bae3-5ad73b526e27@kernel.org> <87eclsrtqg.ffs@tglx>
 <e846cb5f-65c4-4a9b-9f9b-593e4af526d8@kernel.org>
 <76e2b909-98db-49de-a8eb-f6f0a192f630@kernel.org> <878qc0rofr.ffs@tglx>
 <874imorobw.ffs@tglx> <4cad1b9a-e157-427b-9896-cf54cf6fba36@kernel.org>
 <20260310115433.GV1282955@noisy.programming.kicks-ass.net>
 <87y0jzrhqn.ffs@tglx> <a5cabf68-df88-4a5e-8075-bb10debc44f7@kernel.org>
Date: Tue, 10 Mar 2026 14:47:35 +0100
Message-ID: <87v7f3re2w.ffs@tglx>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 10 2026 at 14:40, Matthieu Baerts wrote:
> On 10/03/2026 13:28, Thomas Gleixner wrote:
>
> (...)
>
>> I've updated the debug patch and removed the @users conditionals so it
>> keeps searching. So it should find that magic 73.
>
> It looks like it does, thank you! I just tried this new debug patch, and
> I managed to boot 100 times without issues, while before I was getting
> it after max 20 attempts. I left the test running to boot up to 1000
> times, just in case.

Now that I actually understood the problem, I was able to write a
reproducer which triggers the issue 100% reliable.

The debug patch does cure it and it does the right thing. I have a
better version of that in testing right now which avoid all that flaky
accounting and especially in the vfork() case the full tasklist walk.
I'll send out a complete patch series with changelogs etc. later.

Thanks a lot for your patience and invaluable help. Very appreciated!

        tglx
