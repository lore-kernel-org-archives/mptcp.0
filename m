Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152E02580F2
	for <mptcp@lists.linux.dev>; Wed, 22 Jul 2026 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717285; cv=none; b=gc2/d3PrQvXS4d7qPdUB95VuSOgjMqmrGt6AZBHwMHi1UHo8WPoiUFHiIDub+MAUHubfocvH6Vje5l0Fkust1/m7wGqKsgPoXHEhyTtO5QSEvlImEK0JFe92V78wkMToN1EshXO2viEHrg2g/ms9vA9Jm+QiIt2IsNUiyFAhvmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717285; c=relaxed/simple;
	bh=dEa6esfGZuICFQAfJzhn72RramoNIhWSRzQkZpSDH/k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bs/pwJwc1k7WDA9PNv65OdlOEEX8qWno5NApCNefRK5mtFgk46ZrQ/p29HbVFQ0mfQadNJOiYgLnTtdi+dAQfM1rHPcYO22+m/tzSB3P+tInsMX9OIi16za3UG0pWqzuJm45iv7zCDFB++DGoXPMXeveaHyeEafUvVh9UsdQoc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETPYE7+C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETPYE7+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633211F000E9;
	Wed, 22 Jul 2026 10:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784717283;
	bh=CfZwiG575+aCCyxEBW+iMw/3ruzua+pGc7XkK1GEGow=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ETPYE7+CArn8AYFou9ViZYLnb4DkuTamgGMAYEQlCmN8wIBK9TLbYdwAHQtb5XIjH
	 MFlO/+iy7FV6DanJvdZiTl/V7l3MHSULtzQMfftLuJzdTlXMT1ZBaEFDIVjRikBOCW
	 5G9oSrOui0Lnsw8/mZV9w4tyXP1GVpCvoqfsMIkQVe5yosf8d9/0cmg89lPczetpOY
	 p+PM32CoJfjCzxcZlYJk3VKGdU4h05Rvk52ThfyGNxPevapwfQlWaHREz8GCw0jrJr
	 n2BLkCmyZ10YIB1EGnTe6RmaFKmEdNAmJm/C8PkXYEkHDeW1XNTBT0eYQphQujWAL8
	 MNUBt8NsE1/LQ==
Message-ID: <0ec3e0dcf31345a1356956c2b5082a6b56bf35d4.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 2/5] Squash to "bpf: Export mptcp packet
 scheduler helpers"
From: Geliang Tang <geliang@kernel.org>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
 kalpan.jani@mpiricsoftware.com, janak@mpiric.us, shardulsb08@gmail.com
Date: Wed, 22 Jul 2026 18:47:58 +0800
In-Reply-To: <2ec98c9e15ef4f96d01be048c59b160069cb3923.camel@mpiricsoftware.com>
References: 
	<20260703-mptcp_bpf_kfunc_fixes-v2-0-87ae3c64dc7e@mpiricsoftware.com>
		 <20260703-mptcp_bpf_kfunc_fixes-v2-2-87ae3c64dc7e@mpiricsoftware.com>
		 <0dc8e723ee2af76224d2fe23eca6c4891207fbe0.camel@kernel.org>
	 <2ec98c9e15ef4f96d01be048c59b160069cb3923.camel@mpiricsoftware.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shardul,

On Mon, 2026-07-06 at 16:33 +0530, Shardul Bankar wrote:
> Hi Geliang,
> 
> Thanks for taking a look.
> 
> On Mon, 2026-07-06 at 14:34 +0800, Geliang Tang wrote:
> > Hi Shardul,
> > 
> > Thanks for this v2. It's much better now.
> > 
> > On Fri, 2026-07-03 at 22:27 +0530, Shardul Bankar wrote:
> > > ...
> > > ...
> > 
> > Sashiko complained that the rcu lock is not held here [1]. It seems
> > we
> > can add the lock, something like:
> > 
> >     rcu_read_lock();
> >     subflow = mptcp_subflow_ctx(ssk);
> >     if (subflow && subflow->conn == (const struct sock *)msk)
> >             mptcp_pm_subflow_chk_stale(msk, ssk);
> >     rcu_read_unlock();
> > 
> > 
> > WDYT?
> > 
> > Thanks,
> > -Geliang
> > 
> > [1]
> > https://sashiko.dev/#/patchset/20260703-mptcp_bpf_kfunc_fixes-v2-0-87ae3c64dc7e@mpiricsoftware.com?part=2
> > 
> > 
> 
> I don't think we need the rcu_read_lock() here, and I think it would
> actually be unsafe.
> 
> The subflow context is freed with kfree_rcu(), but in this path the
> msk
> socket lock prevents that free, so rcu_read_lock() is not needed.
> get_retrans() runs with the msk lock held (msk_owned_by_me() in
> mptcp_sched_get_retrans()). A subflow is removed from msk->conn_list
> by
> __mptcp_close_ssk() under that same lock, and only then can it be
> torn
> down and its context freed, so it cannot be freed while get_retrans()
> is running. The in-kernel mptcp_subflow_get_retrans() relies on
> exactly
> this: it dereferences the subflow and calls
> mptcp_pm_subflow_chk_stale() under the msk lock, without
> rcu_read_lock().

If that is the case, would it be reasonable to add a
msk_owned_by_me(msk) check inside bpf_mptcp_pm_subflow_chk_stale()?

Thanks,
-Geliang

> 
> rcu_read_lock() would also not be the right call here:
> mptcp_pm_subflow_chk_stale() is not a pure reader (it updates
> subflow-
> > stale_count and can trigger a retransmit), so it needs the msk lock
> for serialization, which rcu_read_lock() would not provide. It is
> also
> KF_SLEEPABLE and can sleep (its stale path takes lock_sock_fast() and
> calls __mptcp_push_pending()), so it cannot run inside an RCU
> read-side critical section anyway.
> 
> So I'd prefer to keep the code as is. If it helps, I can add a short
> comment noting that the msk lock keeps the subflow context alive.
> Does
> this address the concern?
> 
> Thanks,
> Shardul
