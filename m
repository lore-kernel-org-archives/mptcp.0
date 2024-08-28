Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9301F5FF
	for <mptcp@lists.linux.dev>; Wed, 28 Aug 2024 02:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724813044; cv=none; b=VvZQDUUAX57/gIH8NlDiDIJPspMN1W72I1TI2Plx1BlkrtQUuFJzt/scS1uuOVeUnHH02Febb+REs6H9IiGrmFb7EmVhsvNfOoOo8Iy5GvEYiKmHNlhhBrOJs03AygxxXmqMqezgBrhvzizHvTLxFXqKh/ss5JDWoo1gYWHhiMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724813044; c=relaxed/simple;
	bh=s9EHVUxot+WRViRL0kk/bhKJHECbo/1TSXn9QwVW/8g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dqkuvdSvQMarAVw+f8Yhm1FxSwrG0gEPEQfYreTh4eEn6RLvQvaS741SIcGx+kwL9hv3hBSCabLKwm5TYJKfNo3JJ5fwmu80EetatvFFNkKKJmkirtxllxPssfIbS80J9KmAR19vXqcO/hSA87ERw4WwnPT1gWEYw1lkkE6b66E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FehWI4GW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FehWI4GW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6DAC32786;
	Wed, 28 Aug 2024 02:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724813044;
	bh=s9EHVUxot+WRViRL0kk/bhKJHECbo/1TSXn9QwVW/8g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FehWI4GWO2vnLp1XeQKD/qnj+qPoyO4Ej3JgCR+hJc/uva8K5gu7Dussl9B+rdI75
	 x24Ox8mDyih+hSiV7aWXpwZ4IFFAJ6gLp9J10wAM6f7RQhqCsoTY9TPzDzeVxWT07c
	 moyFNSWzAQrWN05pOLm3EYsII8tQRtY7HYTmfxWLyhJb4v66UnLiuaI7D/8/QRJjA9
	 8N+d+7UJSEu9soyJf2CjmT19Y/rPNs1eTiYFC3TbVt2ggw+Bkhwhr/UHmv1Pr+UPfG
	 7n7xqQM1CZk9/AMpsoGAAfxjq1JY+eecditGJiuba43FmoQDsO/9fz/L4CBN9GS+9v
	 9g1TiSoLKwMog==
Message-ID: <2a3a8b53865e3dc68e7aab28cca1b3433981d81a.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v4 3/3] Squash to "selftests/bpf: Add mptcp
 subflow subtest"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 28 Aug 2024 10:44:00 +0800
In-Reply-To: <17b3927e-0007-4e97-8c98-4c95068401b8@kernel.org>
References: <cover.1724415435.git.tanggeliang@kylinos.cn>
	 <ac6c7b2338205693434883a34256eddfd7605985.1724415435.git.tanggeliang@kylinos.cn>
	 <26a19624-f042-487f-8227-a992ab786696@kernel.org>
	 <363548497c01a3955412d32b281022104f993563.camel@kernel.org>
	 <17b3927e-0007-4e97-8c98-4c95068401b8@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Tue, 2024-08-27 at 11:08 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for your reply.
> 
> On 27/08/2024 10:49, Geliang Tang wrote:
> > Hi Matt,
> > 
> > Thanks for the review.
> > 
> > On Mon, 2024-08-26 at 18:54 +0200, Matthieu Baerts wrote:
> > > Hi Geliang,
> > > 
> > > On 23/08/2024 14:19, Geliang Tang wrote:
> > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > 
> > > > Drop ss_search() from run_subflow().
> > > > 
> > > > Now ss_search() are only used by bpf_sched tests. It will be
> > > > dropped
> > > > in next step.
> > > > 
> > > > Use the "cgroup/getsockopt" way to inspect the subflows.
> > > > 
> > > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > > ---
> > > >  .../testing/selftests/bpf/prog_tests/mptcp.c  | 57
> > > > ++++++++++++---
> > > > ----
> > > >  1 file changed, 35 insertions(+), 22 deletions(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > > > b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > > > index 73adc58cd776..ce464b1e0802 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > > > @@ -368,22 +368,13 @@ static int endpoint_init(char *flags)
> 
> (...)
> 
> > > > + len = sizeof(mark);
> > > > + err = getsockopt(client_fd, SOL_SOCKET, SO_MARK, &mark,
> > > > &len);
> > > > + if (!ASSERT_OK(err || mark != 2, "getsockopt(client_fd,
> > > > SO_MARK)"))
> > > 
> > > The mark should be 0 on the MPTCP socket, no?
> > 
> > optval is modified in _check_getsockopt_subflows_mark(), so the
> > mark is
> > 2 now.
> 
> Mmh, I missed that. I don't think a helper called 'check_xxx()'
> should
> modify anything.

We can rename _check_getsockopt_subflow_mark/_cc to
_getsockopt_subflow_mark/_cc to make their names match.

> 
> Would it not be better to have ...
> 
>   _check_getsockopt_subflows_mark()
> 
> ... making sure the first subflow has the mark 1, and the other one,
> the
> mark 2? (if we add items at the end of the list)

No, this is what v3 do. I think this v4 is much better than v3.

I didn't find a way to return a string type optval to getsockopt() in
v3, so I had to do the mark/cc checks in
_check_getsockopt_subflow_mark/_cc. I finally found a way to do this,
so I used it in v4.

It's strange that v3 sets mark/cc in the BPF program and checks mark/cc
in the BPF program too. 

v4 is much better, it sets mark/cc in the BPF program, use getsockopt()
to get mark/cc in user space in prog_tests/mptcp.c and do the checks in
user space too.

Thanks,
-Geliang

> 
> (...)
> 
> > > > + len = sizeof(cc);
> > > > + err = getsockopt(client_fd, SOL_TCP, TCP_CONGESTION, cc,
> > > > &len);
> > > > + ASSERT_OK(err || strcmp(cc, new), "getsockopt(client_fd,
> > > > TCP_CONGESTION)");
> > > 
> > > (See above)
> > > 
> > > But after your modification in patch 1/3, 'cc' should be equal to
> > > '/proc/sys/net/ipv4/tcp_congestion_control' (not 'new'). So you
> > > need
> > > to
> > > get the value of the default CC first, then compare it to 'cc'.
> > > It
> > > should be different from 'new' (except if 'new' == default cc
> > > from
> > > /proc, so maybe enough to compare that 'cc' is the same as the
> > > default one).
> > 
> > optval is modified in _check_getsockopt_subflow_cc(), so 'cc' is
> > equal
> > to 'new' now.
> 
> Same here:
> 
>   _check_getsockopt_subflow_cc()
> 
> ... can check that the subflow with the mark 2 has the congestion
> control algorithm is set to 'cc' (reno).
> 
> By doing that, you would have the BPF program setting the different
> socket options when the subflows are created, and later checking that
> they have been set properly when a 'getsockopt()' is called.
> The userspace here will check that the values for the MPTCP sockets
> have
> the default values as expected: the BPF program has only modified the
> subflow options, not the ones from the MPTCP socket.
> 
> Cheers,
> Matt

