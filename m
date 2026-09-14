Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023BA420897
	for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377953; cv=none; b=fqV/KkbmZR/HVIMhbt2k9nQ/Cd+qxv4XJ10BHZ3xAQVuYwd2kS7K1OsWmm9QlDxy6yjyaSn7SsD/tgGhiDTEwAIvKscpOC3HhQHlsP54c2cVKwsq8LxSy09Xg9GUAJLeC5TuNCNrTmvzC2Os0cDYBDyGrth0HSgc8M/gR/+JXEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377953; c=relaxed/simple;
	bh=ZfGWL9RawUfWxw1HmaVV5Hb4qmIdwLZOh97HZseGwgk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M1vo1lsxbMP4h5fZx8IZdt6EoNkNpZ19kmje9aFnQ4ToTTD0qzT7wTs2erFSP/BJkuUg9+OGDVjNx9cqAMU19XZEEZc9R5e8eIbEFiZEHkvsvBqksYTXiJqEBH7qpbN5mSmHeAHMyf387qL8PQYn04Lnv5r60wAltC0YR/r4Bqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7xzVsOm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7xzVsOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7351F00893;
	Mon, 14 Sep 2026 09:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789377948;
	bh=AarTSvwcZTsT2AM+kTJys2beRJRyphy6lqXIn3St84o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q7xzVsOmPWC566JIycHF+esdMc5yYNT/VTxlVrBWfdnjsuOJQIYZlML2QWLeb0hfe
	 qxQCOWE3TfAMKcIPwSLv2J8oOx+ipJfaDbLBRhlCaCc1BrUu+8qUxnz63KnUKEjmtM
	 evnRy95/rSytq7oxdHpn7uCp697stDzfotP6n1xvS8ya4wC2V4civ/sJc2b6R9fjEf
	 COxTq/+UIbLAUelOmL3jMCfyRa9VI7L55VlC1sdxWUSuR88Ht1rwCR0kX6PoxEB+Yd
	 ioHrBUHJ48kFjeUw9bkgX3FPwCn2he678WedfFGQRO8kSbPNPdQdBx78a91iXJXHD0
	 qKcIaJs5KXd0g==
Message-ID: <2156e03fc3837c6f8f2ea6e64915ead77f5ba98c.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 06/16] mptcp: implement
 psock_update_sk_prot for sockmap
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, kernel test robot
 <lkp@intel.com>,  Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 14 Sep 2026 17:25:44 +0800
In-Reply-To: <0a4bbaf9-7cc0-4ec8-b630-261a0b324e86@kernel.org>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
	 <39ae7a2bebed6f38d02356c7e288a21a70bdd07f.1789294365.git.tanggeliang@kylinos.cn>
	 <0a4bbaf9-7cc0-4ec8-b630-261a0b324e86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sun, 2026-09-13 at 20:22 +0200, Matthieu Baerts wrote:
> On 13/09/2026 12:14, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch adds basic MPTCP support for BPF sockmap by implementing
> > the
> > psock_update_sk_prot callback (mptcp_bpf_update_proto). This allows
> > MPTCP
> > sockets to be added to sockmap and enables the sk_skb
> > stream_verdict
> > redirect path via the read_skb callback. Separate protocol
> > structures are
> > maintained for IPv4/IPv6 and BASE/TX/RX/TXRX configurations,
> > mirroring
> > tcp_bpf_update_proto(). The IPv6 variant is lazily rebuilt via
> > mptcp_bpf_check_v6_needs_rebuild() when the underlying protocol ops
> > change.
> > 
> > MPTCP delegates to the original protocol operations so that MPTCP-
> > specific
> > logic (multi-path scheduling in sendmsg, ordered reassembly in
> > recvmsg) is
> > preserved. recvmsg is overridden in all BPF configurations with
> > mptcp_bpf_recvmsg, which checks the psock ingress queue first and
> > falls
> > back to mptcp_recvmsg via the shared __tcp_bpf_recvmsg() helper.
> > sendmsg
> > is overridden in the TX/TXRX configurations with mptcp_bpf_sendmsg,
> > which
> > processes sk_msg redirect before delegating to mptcp_sendmsg via
> > __tcp_bpf_sendmsg().
> > 
> > Export mptcp_sendmsg, mptcp_recvmsg and mptcp_prot from protocol.c
> > so they
> > can be referenced by bpf.c.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202512261144.DxrvwMS3-lkp@intel.com/
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/521
> > Cc: Cong Wang <xiyou.wangcong@gmail.com>
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  include/net/tcp.h    |   5 ++
> >  net/ipv4/tcp_bpf.c   |  29 +++++++---
> 
> Probably best to separate this change from the rest: TCP/BPF on one
> side, then MPTCP/BPF (and eventually MPTCP only before, just to do
> the
> exports.)

I agree, and will update it in the next version.

Thanks,
-Geliang

> 
> >  net/mptcp/bpf.c      | 129
> > +++++++++++++++++++++++++++++++++++++++++++
> >  net/mptcp/protocol.c |  10 ++--
> >  net/mptcp/protocol.h |  18 ++++++
> 
> Cheers,
> Matt
