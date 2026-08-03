Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03ABB672
	for <mptcp@lists.linux.dev>; Mon,  3 Aug 2026 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785732769; cv=pass; b=AEYCjmDy/2c7s4wpeD+fQY8zM0CHTAO+bNhhR6raTKDy2Ga8EP4esCBeGMJRK1uRRDZ3pl8N+TZThZkXyXxrobnrTl0IkJTQj9IvUU1Zb7V8er6Gqgt+gxp7GcOZ+ZO9Q8oMglq2YahkEsy7BqJZPlHgReAa1XcvaVYG9VQetMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785732769; c=relaxed/simple;
	bh=dqMOOVXGPzVrHheuaLsW8w9ROrLdthd0XiNvWPF4hqw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZZVaQc9bDU4H8M/ylsK7ptPA9qvAxcSs0PIrfT06SyG1fM7E6MJP/sLC51S7sD/jZOrPGTUjwmBkdu+awOOYNTep2IDmUFePlNTHRJe1DInZMbcl1ODNifza6h3CjNvqztLUNu55Tk8Q9niTIh3u6aVmgLJc35FgTeoe5v5xLwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=uch64Q2N reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="uch64Q2N"
ARC-Seal: i=1; a=rsa-sha256; t=1785732760; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nmBb57BrLJv9jQLv/BZlj0UWJkuBNHBRvdKFadddsbcBnW+PDFjBtGPoW58FzFK58lASFmCi/OcQrZbRQ3ah2Gv19I3E7StlnmJmcXrWKkjOIgvvcPtfMusQNGRlYfRIMrguunB3PaIdqxtyol9xiaQ3+6stEztZQQQP7J9967s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785732760; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=17nWk+lK7nQAgYw0fKTVhgP39Hl7aiSyZMbIjQaqxYA=; 
	b=fb7LePJI8ba8fQzwx45OjmeRB7rkVq4CZJrSs/Hqd+Tkp5RmXtTKmoE/U37Zl1TGDND2X5g41yzCoIANaki7DkPhPYZpwV1/JfhYF2Vu28WDmSXoUnX0Kkw1I+CvSaKP2BjaETEwNjdaBwHrektyaCtryOV8qGEjxBui/WSgchw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785732760;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=17nWk+lK7nQAgYw0fKTVhgP39Hl7aiSyZMbIjQaqxYA=;
	b=uch64Q2N5tuR84KuMkSPG1oY1M7gf9gfKONS/enZuUH9wRpg0q3+QpH6Jq2pfKUc
	uLU3MJSRmaEgabcO0k4URmKXY4wexqHS8APC+ozReRT+eeSBhk+4ncFq47rfq+sevre
	aE+3HEHlQEE+wHEAYJjyHowMwQlMPpm22zv144K8=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1785732760336260.12115474763186; Sun, 2 Aug 2026 21:52:40 -0700 (PDT)
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 178573275662225.409116388692837; Sun, 2 Aug 2026 21:52:36 -0700 (PDT)
Date: Mon, 03 Aug 2026 10:22:36 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "mptcp" <mptcp@lists.linux.dev>
Cc: "matttbe" <matttbe@kernel.org>, "martineau" <martineau@kernel.org>,
	"pabeni" <pabeni@redhat.com>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>,
	"Kalpan Jani" <kalpan.jani@mpiricsoftware.com>,
	"Lixiasong1" <lixiasong1@huawei.com>
Message-ID: <19fc5f77283.636e19ae49491.8985382660057875751@mpiricsoftware.com>
In-Reply-To: <20260617114508.253716-1-kalpan.jani@mpiricsoftware.com>
References: <20260617114508.253716-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next v3] mptcp: honour configured min/max RTO in
 retransmit paths
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi all,

Gentle ping on this v3, sent on 2026-06-17:-

  https://lore.kernel.org/all/20260617114508.253716-1-kalpan.jani@mpiricsoftware.com/

I didn't get any CI results or review comments on it, so I want to
make sure it didn't get lost somewhere. As far as I can tell it was
sent to the right list with the right prefix.

Happy to rebase and resend as v4 if that is easier, or to rework it
if this isn't the approach you'd like for issue #618.

Cheers,
Kalpan Jani


From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: <mptcp@lists.linux.dev>
Cc: <matttbe@kernel.org>, <martineau@kernel.org>, <pabeni@redhat.com>, <shardul.b@mpiricsoftware.com>, <janak@mpiric.us>, <kalpanjani009@gmail.com>, <akshit@mpiricsoftware.com>, "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>, "Li Xiasong"<lixiasong1@huawei.com>
Date: Wed, 17 Jun 2026 17:15:08 +0530
Subject: [PATCH mptcp-next v3] mptcp: honour configured min/max RTO in retransmit paths

 > On the TCP side, the min/max RTO can be configured via the route
 > rto_min option, the TCP_BPF_RTO_MIN and TCP_RTO_MIN_US socket options,
 > and the tcp_rto_min_us / tcp_rto_max_ms sysctls, in that order of
 > precedence. MPTCP did not honour any of these because its retransmit
 > logic still used the hard-coded TCP_RTO_MIN / TCP_RTO_MAX constants.
 > 
 > Replace the constants with the tcp_rto_min() / tcp_rto_max() helpers
 > in the three MPTCP-level retransmit paths:
 > 
 > - mptcp_set_datafin_timeout(): both the backoff cap computation and
 >   the resulting timer_ival now follow the configured values. rto_min
 >   can resolve to 0 (e.g. "ip route ... rto_min 0"), so floor it to 1
 >   before using it: this keeps the rto_max / rto_min division and the
 >   rto_min << retransmits shift well-defined. The max_t(..., 1) guard
 >   still covers the separate rto_min >= rto_max case that would
 >   otherwise feed ilog2(0).
 > 
 > - __mptcp_set_timeout(): the fallback when no subflow timeout is
 >   available now uses tcp_rto_min().
 > 
 > - __mptcp_init_sock(): MPTCP does not invoke tcp_init_sock() on the
 >   msk, so inet_csk(sk)->icsk_rto_min and icsk_rto_max remain zero by
 >   default. Seed them from the per-netns sysctls before using them.
 >   The initial timer_ival reads icsk_rto_min directly rather than
 >   going through tcp_rto_min(sk): at socket init time sk_dst_cache is
 >   not yet under RCU/lock protection, and the dst lookup inside
 >   tcp_rto_min() would otherwise trip lockdep_rcu_suspicious() via
 >   __sk_dst_get() (reported by the mptcp CI on v1).
 > 
 > The remaining uses of TCP_RTO_MAX in net/mptcp/ctrl.c (ADD_ADDR
 > default add_addr_timeout) and net/mptcp/subflow.c (mptcp_subflow_fail()
 > MP_FAIL timeout) are intentionally left unchanged: they use the
 > constant as a default duration, not as an RTO bound on a retransmit
 > timer.
 > 
 > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/618
 > Reported-by: Li Xiasong <lixiasong1@huawei.com>
 > Closes: https://lore.kernel.org/all/95552642-7b60-410b-9953-70e0b31a90e1@huawei.com/
 > Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
 > ---
 > Link to v1: https://lore.kernel.org/mptcp/20260610101123.765958-1-kalpan.jani@mpiricsoftware.com/
 > Link to v2: https://lore.kernel.org/mptcp/20260611064937.422416-1-kalpan.jani@mpiricsoftware.com/
 > 
 > Changes since v2:
 > - mptcp_set_datafin_timeout(): floor rto_min to >= 1 so that a route
 >   metric of rto_min 0 (tcp_rto_min() == 0) can no longer divide by
 >   zero before the max_t() clamp. Thanks to Li Xiasong for spotting it.
 > - __mptcp_init_sock(): order the local declarations longest-first
 >   (reverse christmas tree).
 > 
 > Changes since v1:
 > - __mptcp_init_sock(): seed icsk_rto_min / icsk_rto_max from the
 >   per-netns sysctls so the helpers return meaningful values on the
 >   msk (MPTCP does not call tcp_init_sock() on the msk).
 > - __mptcp_init_sock(): use icsk->icsk_rto_min directly for the initial
 >   timer_ival instead of tcp_rto_min(sk), to avoid a
 >   lockdep_rcu_suspicious() splat from __sk_dst_get() at socket init
 >   time. Reported by the mptcp CI on v1.
 > - mptcp_set_datafin_timeout(): add an ilog2(0) shift-safety guard for
 >   the rto_min >= rto_max corner case.
 > 
 >  net/mptcp/protocol.c | 23 +++++++++++++++++++----
 >  1 file changed, 19 insertions(+), 4 deletions(-)
 > 
 > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
 > index a4f7e99b30db..4c5a89bd4c1b 100644
 > --- a/net/mptcp/protocol.c
 > +++ b/net/mptcp/protocol.c
 > @@ -563,17 +563,26 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
 >  static void mptcp_set_datafin_timeout(struct sock *sk)
 >  {
 >      struct inet_connection_sock *icsk = inet_csk(sk);
 > +    u32 rto_min = tcp_rto_min(sk);
 > +    u32 rto_max = tcp_rto_max(sk);
 >      u32 retransmits;
 >  
 > +    /* A route metric can set rto_min to 0 ("ip route ... rto_min 0");
 > +     * floor it so the division below and the "rto_min << retransmits"
 > +     * shift stay well-defined.
 > +     */
 > +    if (!rto_min)
 > +        rto_min = 1;
 > +
 >      retransmits = min_t(u32, icsk->icsk_retransmits,
 > -                ilog2(TCP_RTO_MAX / TCP_RTO_MIN));
 > +                ilog2(max_t(u32, rto_max / rto_min, 1)));
 >  
 > -    mptcp_sk(sk)->timer_ival = TCP_RTO_MIN << retransmits;
 > +    mptcp_sk(sk)->timer_ival = rto_min << retransmits;
 >  }
 >  
 >  static void __mptcp_set_timeout(struct sock *sk, long tout)
 >  {
 > -    mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
 > +    mptcp_sk(sk)->timer_ival = tout > 0 ? tout : tcp_rto_min(sk);
 >  }
 >  
 >  static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subflow)
 > @@ -3149,7 +3158,9 @@ static void mptcp_worker(struct work_struct *work)
 >  
 >  static void __mptcp_init_sock(struct sock *sk)
 >  {
 > +    struct inet_connection_sock *icsk = inet_csk(sk);
 >      struct mptcp_sock *msk = mptcp_sk(sk);
 > +    struct net *net = sock_net(sk);
 >  
 >      INIT_LIST_HEAD(&msk->conn_list);
 >      INIT_LIST_HEAD(&msk->join_list);
 > @@ -3158,7 +3169,11 @@ static void __mptcp_init_sock(struct sock *sk)
 >      INIT_WORK(&msk->work, mptcp_worker);
 >      msk->out_of_order_queue = RB_ROOT;
 >      msk->first_pending = NULL;
 > -    msk->timer_ival = TCP_RTO_MIN;
 > +
 > +    /* msk does not go through tcp_init_sock(); seed RTO bounds. */
 > +    icsk->icsk_rto_min = usecs_to_jiffies(READ_ONCE(net->ipv4.sysctl_tcp_rto_min_us));
 > +    icsk->icsk_rto_max = msecs_to_jiffies(READ_ONCE(net->ipv4.sysctl_tcp_rto_max_ms));
 > +    msk->timer_ival = icsk->icsk_rto_min;
 >      msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 >      msk->backlog_len = 0;
 >      mptcp_init_rtt_est(msk);
 > -- 
 > 2.43.0
 > 
 > 


