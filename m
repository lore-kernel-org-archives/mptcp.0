Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8534A8A0A;
	Fri,  4 Sep 2026 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531099; cv=none; b=BY6fx4pD9Rp/4Jx1QWbMt355DIen5lCqwGplr1kwiHh679HEaj1m70EYWXRr5hqDB47WcwBn0I+DMfnLD/hxgkJQ6wPqLZLLScQh8qzraPlgBxHsAGt1ytEsMk14qIi/JcsL70rD55C3xm5YOuM30eMFi9w+EHGRrMfvSqQzcGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531099; c=relaxed/simple;
	bh=EjvvAC6GoSzTYe4KPH+/+kfr2lMH9lVjOc2pZV7hbWw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fEdN6n41qhlJceOp6vi6uf6c9LIOFwwJnsTme4NEVmaK2XZbd5TqQYV8eIjKdJx2tI8JavFm4ELQqujfh02zvYTBupIvCnG8kTlkSbVN7uXMclwRtek3lukAXotn4clkcTDpEX5YhiI19G5Xe/4F4bvF/J8WVd9rv/tICUXH/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxkfEx/C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxkfEx/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8534F1F00A3D;
	Fri,  4 Sep 2026 14:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788531097;
	bh=4xoc1oqfn6j23KLF3fZUzmO5W1BKMY/VdA7ifESRe6g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TxkfEx/C7sJoVJwVI9vCUzpT/f++SLGcbaObnZJH/lnFOUFRQlPyRIfM08ALXyyYY
	 XV0QY15zxUltcsR2FQ0gugyoItPk1L6nRRFmamFbipiw6/nfIGsvOigYXdtcLp/0ot
	 y2aVnk5di7T0rWTZrJ71zCJiHPJ4Vviu+KMu5zZAl37TV6/9R3HxAHzzwmBMGgklCr
	 417lw5JkmMHIEKzo8U1Xe+XTzHyiHb5U5wLyuJztKJED4F+HtcVe5v5ida2mk1qnn1
	 o7kftTBPQBIQEo46gmjzDaRY5tPJ7/CpQFlrytumtVhUjVC5Vp5UHw72rRVhNuFbQN
	 +unAxSqO3lPKg==
Message-ID: <f2349f1472b8064a9a480c19574f0d5d9efc607c.camel@kernel.org>
Subject: Re: [PATCH] bpf, sockmap: Fix self-redirect copied_seq
 double-counting
From: Geliang Tang <geliang@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, Jakub Sitnicki
 <jakub@cloudflare.com>,  John Fastabend <john.fastabend@gmail.com>,
 mptcp@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski	 <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman	 <horms@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Geliang Tang	 <tanggeliang@kylinos.cn>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Date: Fri, 04 Sep 2026 22:11:31 +0800
In-Reply-To: <8d1e416d-202f-4fcb-85f6-aa380645216f@linux.dev>
References: 
	<b840c35fdfdf36e9fddedfa645b12699bc51aa34.1787968065.git.tanggeliang@kylinos.cn>
	 <87wlt52od6.fsf@cloudflare.com>
	 <8d1e416d-202f-4fcb-85f6-aa380645216f@linux.dev>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub, Jiayuan,

On Tue, 2026-09-01 at 21:00 +0800, Jiayuan Chen wrote:
> 
> on 9/1/26 7:38 PM, Jakub Sitnicki wrote:
> > On Sat, Aug 29, 2026 at 10:00 AM +08, Geliang Tang wrote:
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > 
> > > When a BPF stream_verdict program redirects an skb back to the
> > > same
> > > socket (self-redirect with BPF_F_INGRESS),
> > > sk_psock_verdict_apply()
> > > calls tcp_eat_skb() which advances tcp_sk->copied_seq. However,
> > > the
> > > skb is then delivered to the socket's psock ingress queue and
> > > later
> > > read by tcp_bpf_recvmsg_parser(), which also advances copied_seq
> > > via
> 
> Hi Geliang,
> 
> tcp_eat_skb() will test 'skb_bpf_strparser(skb)' then skip the 
> calculation of copied_seq.
> 
> 
> 
> > > the copied_from_self accounting path. This double-counting causes
> > > copied_seq to advance by 2x the actual data length, triggering:
> > > 
> > >    TCP recvmsg seq # bug 2: copied BF2E806, seq BF2E7FD, \
> > > 			   rcvnxt BF2E806, fl 0
> > >    WARNING: net/ipv4/tcp.c:2745 at
> > > tcp_recvmsg_locked+0x72b/0x2640
> > >    Call Trace:
> > >     tcp_recvmsg+0x10a/0x500
> > >     sock_recvmsg+0x168/0x1d0
> > >     __sys_recvfrom+0x19a/0x2a0
> > >     __x64_sys_recvfrom+0xe4/0x1f0
> > >     do_syscall_64+0xf7/0x530
> > >     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > 
> > >    cleanup rbuf bug: copied BF2E806 seq BF2E806 rcvnxt BF2E806
> > >    WARNING: net/ipv4/tcp.c:1609 at tcp_cleanup_rbuf+0xf2/0x1c0
> > >    Call Trace:
> > >     tcp_recvmsg_locked+0x8d1/0x2640
> > >     tcp_recvmsg+0x10a/0x500
> > >     sock_recvmsg+0x168/0x1d0
> > >     __sys_recvfrom+0x19a/0x2a0
> > >     __x64_sys_recvfrom+0xe4/0x1f0
> > >     do_syscall_64+0xf7/0x530
> > >     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > 
> > > Fix this by checking if the redirect destination is the same
> > > socket.
> > > For self-redirect (dst == psock->sk), skip tcp_eat_skb() since
> > > the
> > > copied_seq will be advanced when the data is actually read from
> > > the
> > > ingress queue. For cross-socket redirects, tcp_eat_skb() is still
> > > needed to account for data leaving the source socket.
> > > 
> > > Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling
> > > copied_seq")
> > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > ---
> > > Hi,
> > > 
> > > I encountered this while adding MPTCP BPF sockmap support. The
> > > existing
> > > TCP sockmap selftests don't cover self-redirect, but the MPTCP
> > > tests do,
> > > exposing this latent issue.
> > > 
> > > With this fix, both TCP and MPTCP tests pass, validating self-
> > > redirect
> > > functionality.
> > > ---
> > >   net/core/skmsg.c | 8 ++++++--
> > >   1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > > index 2521b643fa05..5fa7b9639eef 100644
> > > --- a/net/core/skmsg.c
> > > +++ b/net/core/skmsg.c
> > > @@ -1039,10 +1039,14 @@ static int sk_psock_verdict_apply(struct
> > > sk_psock *psock, struct sk_buff *skb,
> > >   				goto out_free;
> > >   		}
> > >   		break;
> > > -	case __SK_REDIRECT:
> > > -		tcp_eat_skb(psock->sk, skb);
> > > +	case __SK_REDIRECT: {
> > > +		struct sock *dst = skb_bpf_redirect_fetch(skb);
> > > +
> > > +		if (dst != psock->sk)
> > > +			tcp_eat_skb(psock->sk, skb);
> > >   		err = sk_psock_skb_redirect(psock, skb);
> > >   		break;
> > > +	}
> > >   	case __SK_DROP:
> > >   	default:
> > >   out_free:
> > Isn't the source of problem on the read-side
> > (tcp_bpf_recvmsg_parser)?
> 
> 
> Right, I think I already fixed the parser side.
> 
> 
> > We should be advancing copied_seq only for skbs that we received
> > from
> > the tcp stack. That's why we have the copied_from_self detection in
> > tcp_bpf_recvmsg_parser.
> > 
> > I think the problem is that we set msg->sk when we call
> > sk_psock_skb_ingress_self from sk_psock_skb_ingress, so on
> > SK_REDIRECT
> > path, not the SK_PASS path.
> 
> 
> I sucessfully use this selftest to reproduce the splat:
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c 
> b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 1fef6ec2ba7a..58a90f2e3602 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -1173,6 +1173,15 @@ static void test_sockmap_copied_seq(bool strp)
>          if (!ASSERT_OK(err, "bpf_map_update_elem(p1)"))
>                  goto end;
> 
> +       /* self redirect: data sent by c1 is redirected back to p1
> itself */
> +       sent = xsend(c1, buf, sizeof(buf), 0);
> +       if (!ASSERT_EQ(sent, sizeof(buf), "xsend(c1), self"))
> +               goto end;
> +
> +       recvd = recv_timeout(p1, rcv, sizeof(buf), MSG_DONTWAIT, 1);
> +       if (!ASSERT_EQ(recvd, sent, "recv_timeout(p1), self"))
> +               goto end;
> +
>          /* just trigger sockamp: data sent by c0 will be received by
> p1 */
>          sent = xsend(c0, buf, sizeof(buf), 0);
>          if (!ASSERT_EQ(sent, sizeof(buf), "xsend(c0), bpf"))
> @@ -1364,6 +1373,8 @@ static void
> test_sockmap_no_verdict_fionread(void)
> 
>   void test_sockmap_basic(void)
>   {
> +       test_sockmap_copied_seq(false);
> +       return;
>          if (test__start_subtest("sockmap create_update_free"))
> test_sockmap_create_update_free(BPF_MAP_TYPE_SOCKMAP);
>          if (test__start_subtest("sockhash create_update_free"))
> 
> 
> 
> 
> > REDIRECT-to-self should really be a PASS, see [1]. My suggestion -
> > fixup
> > the verdict:
> > 
> >          if (verdict == __SK_REDIRECT && skb->sk == psock->sk)
> >                  verdict = __SK_PASS;
> 
> 
> Agree. It's simple and clear.
> 
> 
> +        if (verdict == __SK_REDIRECT && skb_bpf_ingress(skb) &&
> 
> +            skb_bpf_redirect_fetch(skb) == psock->sk)
> +                verdict = __SK_PASS;

Thank you for your suggestions. I will add both of your Suggested-by
tags in v2.

Sorry for the late reply. After applying this patch, some of my other
tests didn't pass. I spent a few days debugging and found that it was
an issue with the MPTCP implementation itself - specifically,
mptcp_read_skb(). It has now been resolved.

I've basically completed the MPTCP sockmap support on my side. I'll
send it out to the BPF mailing list for review when it's ready.

Thanks,
-Geliang

> 
>          switch (verdict) {
> 
> 
> > Then we can remove the sk_psock_skb_ingress_self call from
> > sk_psock_skb_ingress, and kill take_ref param in
> > sk_psock_skb_ingress_enqueue.
> > 
> > John, Jiayuan, thoughts?
> > 
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2443ca66676d50a4eb3305c236bccd84a9828ce2
