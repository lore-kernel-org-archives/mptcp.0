Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1974029B78F
	for <mptcp@lists.linux.dev>; Thu,  2 Apr 2026 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775117332; cv=none; b=mmfFa48xE8kX/I+CNR2hivhSao1p7s8dpEBVP3uHAUMxdQzBlJyajH0EbwieRQ0lAGtiv1t5qxuBALcKAQ6ZWdLBLQOfEWTM2iyK+rKEI4JI1o3NuPtUP0wpcRKh+glvTf2xqia2Dl8fxLSnWiO/ZizNVYmforZ8UKFQhWZkzmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775117332; c=relaxed/simple;
	bh=vs6B+RHnPO28CNVgBjn9RMqHFcuTJBzMndgV7C6zGBg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rclyujYH5ej/Qi3yzxSSqTT5UGjcAeEkuww67YGgr0msWls8vuw4MVibB8GFn2qDua7+HxlE2fFXpKIuY+s/LzbTSsHsjdrIfTaOPfpit1JPWGoLrNDo2fFWEN/Cp3iIVlGJdtVULgtE4mE1FmhrB0CDRNbrbQpKKDjjkRBzfHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxLOphbN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxLOphbN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE57C19423;
	Thu,  2 Apr 2026 08:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775117331;
	bh=vs6B+RHnPO28CNVgBjn9RMqHFcuTJBzMndgV7C6zGBg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rxLOphbNgZKTrxaJw4xYEBwRXaWhYgDl1Lj69go/FVfVmoKPhIwHcQAoDZvEg3XCz
	 GO1K52PHBh9cNdRIZnv3ksSwozCTzWwHgErGFNz6aybvgq62ISQlsrJ9bZls4i4/li
	 KoOh+rusLipcjQMlyOAyqhLZ1y1YI0IU0V2RZc+qc+YvyHl3dZLJnMMI6LAaFuYz8s
	 6mobyXy80JmYViVU2PEgou14Qm+Rnp/vjULsUZKXlP3zhcwDKshLowLpmBounzmurl
	 glpeGQgafqu782gIXxdBqK02nkeT+aDHV1dXijRL2BanaAnr8RiWKDknSOMizWHANm
	 Ic342OSVrjtnQ==
Message-ID: <10262ffce0d3bcb6159ba1e8da54ab8a9a650188.camel@kernel.org>
Subject: Re: [RFC mptcp-next v11 05/15] mptcp: avoid sleeping in read_sock
 path under softirq
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Gang Yan <yangang@kylinos.cn>
Date: Thu, 02 Apr 2026 16:08:47 +0800
In-Reply-To: <7d09f88d-052c-4932-bb25-3831b32e0f94@redhat.com>
References: <cover.1773911536.git.tanggeliang@kylinos.cn>
	 <b7b6fd287877f7b2cb585c3b552ef0925da41858.1773911536.git.tanggeliang@kylinos.cn>
	 <7d09f88d-052c-4932-bb25-3831b32e0f94@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

Thanks for you help, I finally solved this deadlock issue as you
suggested.

On Wed, 2026-04-01 at 21:57 +0200, Paolo Abeni wrote:
> On 3/19/26 11:08 AM, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > When mptcp_read_sock() is called from softirq context via TLS
> > read_sock, lock_sock_fast() in mptcp_rcv_space_adjust() and
> > mptcp_cleanup_rbuf() may trigger might_sleep() warnings or
> > illegal sleeps, as softirq context cannot block.
> > 
> > Replace lock_sock_fast() with spin_trylock_bh() to make locking
> > non-blocking and context-safe. Skip operations if the lock cannot
> > be acquired.
> > 
> > Co-developed-by: Gang Yan <yangang@kylinos.cn>
> > Signed-off-by: Gang Yan <yangang@kylinos.cn>
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/protocol.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 5585f43cf879..e9e40dfab5ea 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -561,12 +561,11 @@ static void mptcp_send_ack(struct mptcp_sock
> > *msk)
> >  
> >  static void mptcp_subflow_cleanup_rbuf(struct sock *ssk, int
> > copied)
> >  {
> > -	bool slow;
> > -
> > -	slow = lock_sock_fast(ssk);
> > -	if (tcp_can_send_ack(ssk))
> > +	if (!spin_trylock_bh(&ssk->sk_lock.slock))
> > +		return;
> 
> I discussed this topic off-list with Geliang. Let me report the info
> here, too, for future memory.
> 
> This does not look like the correct solution: we risk not sending out
> the needed ack.
> 
> The exact, complete and decoded call trace leading to the problematic
> lock could be helpful.
> 
> I *guess* a better solution would be detecting the critical scenario
> from the mptcp/tls caller and in such a case queue the strp->work and

That's indeed the problem here.

/* Lower sock lock held */
void tls_strp_data_ready(struct tls_strparser *strp)
{
        struct tls_context *ctx = tls_get_ctx(strp->sk);

        /* This check is needed to synchronize with do_tls_strp_work.
         * do_tls_strp_work acquires a process lock (lock_sock) whereas
         * the lock held here is bh_lock_sock. The two locks can be
         * held by different threads at the same time, but bh_lock_sock
         * allows a thread in BH context to safely check if the process
         * lock is held. In this case, if the lock is held, queue work.
         */
        if (sock_owned_by_user_nocheck(strp->sk)) {
                queue_work(tls_strp_wq, &strp->work);
                return;
        }

        tls_strp_check_rcv(strp);
}

MPTCP should not only checks sock_owned_by_user_nocheck(sk) as TCP
does, but also needs to check whether the MPTCP data lock is held.

So I added a new .lock_is_held interface for struct tls_prot_ops in
v12. Also dropped this patch in v12.

Thanks,
-Geliang

> do
> not call into the tcp/mptcp code. The later strp worker invocation
> will
> happen from process context and could acquire the subflow lock
> without
> locking issues.
> 
> /P
