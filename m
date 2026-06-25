Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE431332623
	for <mptcp@lists.linux.dev>; Thu, 25 Jun 2026 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369668; cv=pass; b=nCgFs0aWkme2CDFwjRHWcpioBpnAlL7i1EHykgrdGDiba2OJ493dfm7gHYtTcHBJMQpDd83sO5vb8oKwIMV/Z1ouDdK/3XlP1xilCjvdnrIx0z2qnjpmmUvETXsODIEk8H6MHw7s4rIxtYukCMCLIRt7UqeEr1CoF61x5ln33MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369668; c=relaxed/simple;
	bh=LtrTYX2fyn4Ng8CNTCLbh41vAXlxY2iVDU5x0ozRVtE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=YSi108fTtGdYiyFO3PhckhlXlvcKd+JSvfWfuRmpEfvg1irLDU9uIfO4h/Yr69tEsgFFKDF+966A14NvaH/tn4FHzhMc6HuzKI2EWgJgx7+ENPQLqYwPvWFwP8Gq0fnLSdBLL4v5gIQEgxVKLxOp40B62lx+3L2sUcr7mvpGJ28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=kSXIqkoS reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="kSXIqkoS"
ARC-Seal: i=1; a=rsa-sha256; t=1782369661; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gnKCRbXYnWNpzDoyGOb6TOkMZ2oRCBpsWBG4K8L2PR+pHW2NRwihsaE3nMw7UJyc9F9ix/jGZ+9nl9RahJ4PkEx79C3XAbGQYAMpcOffgzrtCeYLcW7d0jNfBrVaLMkkKc9RxL1lYpflTS6UugK2G1OLkeH+MXC2DlGtr8hLc10=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782369661; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wG5qUDiUHXZAD01GJ7nhrxZjMQ7KfmXdUQ/D88UDy5o=; 
	b=bQl1WuEMEY89Gztgo0pTce+wrnEA7irmzQjgIO4wOp1zLRIVujKhFFXxkCofvd1YXvSDhCl3VJzj48xZ74VOHktJWJcvUJ1JSAjhwGnHuheitK0FtM6LTNtLaMQkcYOm7Uj42owfzrKNlN9O6qPlXBpx86UF0rjg2tU295wpwX4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782369661;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wG5qUDiUHXZAD01GJ7nhrxZjMQ7KfmXdUQ/D88UDy5o=;
	b=kSXIqkoSboh/NGvGxRryvqWVvf1gYIiUK6PhTaOhcuipHZROmOsvsz39hUb3TkjZ
	fvuGDs8wPyha4lbyNu+1bmoEMRcQWOf441Pm/VXS55qBfzSo1HEWtc3Q/kLil5e8qw+
	WNKlhuHMINTLi5ibaDUbH8KNX0k+f4woAyDYNmeo=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1782369660839134.73248361679828; Wed, 24 Jun 2026 23:41:00 -0700 (PDT)
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1782369658679586.5934427031217; Wed, 24 Jun 2026 23:40:58 -0700 (PDT)
Date: Thu, 25 Jun 2026 12:10:58 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "mptcp" <mptcp@lists.linux.dev>
Cc: "matttbe" <matttbe@kernel.org>, "martineau" <martineau@kernel.org>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>,
	"shardulsb08" <shardulsb08@gmail.com>,
	"Kalpan Jani" <kalpan.jani@mpiricsoftware.com>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"syzkaller" <syzkaller@googlegroups.com>,
	"Akshit Patadiya" <akshit@mpiricsoftware.com>
Message-ID: <19efd82a727.5577df63663915.5557063534077196375@mpiricsoftware.com>
In-Reply-To: <20260601083010.924938-1-kalpan.jani@mpiricsoftware.com>
References: <20260601083010.924938-1-kalpan.jani@mpiricsoftware.com>
Subject: Re:[PATCH net v4] mptcp: fix stale skb->sk reference on subflow
 close
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

Hi Paolo, Matt,

Gentle ping on this patch.

https://lore.kernel.org/all/20260601083010.924938-1-kalpan.jani@mpiricsoftware.com/

I haven't seen any further feedback on v4, so I just wanted to bring it back to your attention in case it was missed.

Changes since v3:
- Rewrote the commit message: the old backlog traversal in mptcp_close_ssk() ran before __mptcp_close_ssk() took the ssk lock, holding neither the ssk lock nor mptcp_data_lock(). The race is a concurrent softirq RX path (subflow_data_ready() -> mptcp_data_ready() -> __mptcp_add_backlog(), under mptcp_data_lock()) adding to the backlog mid-traversal, not anything tied to a release_sock(ssk).
- Added the missing Fixes tag (ee458a3f314e).

The diff is otherwise unchanged from v3. I kept your Suggested-by, Paolo; happy to add an Acked-by too if you'd rather it be explicit.

Thanks for your time.

Cheers,
Kalpan Jani



From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: <mptcp@lists.linux.dev>
Cc: <matttbe@kernel.org>, <martineau@kernel.org>, <shardul.b@mpiricsoftware.com>, <janak@mpiric.us>, <kalpanjani009@gmail.com>, <shardulsb08@gmail.com>, "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>, "Paolo Abeni"<pabeni@redhat.com>, "syzkaller"<syzkaller@googlegroups.com>
Date: Mon, 01 Jun 2026 14:00:10 +0530
Subject: [PATCH net v4] mptcp: fix stale skb->sk reference on subflow close

 > The backlog list is updated by mptcp_data_ready() under
 > mptcp_data_lock(). The cleanup of backlog references to a closing
 > subflow, however, was performed in mptcp_close_ssk(), before
 > __mptcp_close_ssk() acquires the ssk lock, and while holding neither
 > the ssk lock nor mptcp_data_lock().
 > 
 > Because that traversal ran without mptcp_data_lock(), concurrent softirq
 > RX processing on another CPU (subflow_data_ready() -> mptcp_data_ready()
 > -> __mptcp_add_backlog(), under mptcp_data_lock()) could add a backlog
 > entry referencing the ssk while the cleanup loop was in progress. Such
 > an entry could be missed by the cleanup, or the concurrent list update
 > could corrupt the traversal, leaving skb->sk pointing at the ssk after
 > it is freed.
 > 
 > A later mptcp_backlog_purge() then dereferences the stale pointer,
 > triggering a warning in inet_sock_destruct() (ssk->sk_rmem_alloc != 0)
 > followed by a use-after-free in mptcp_backlog_purge().
 > 
 > Fix this by moving the backlog cleanup into __mptcp_close_ssk(), after
 > subflow->closing is set to 1 and while the ssk lock is still held,
 > serialized under mptcp_data_lock(). The cleanup runs only on the push
 > path (MPTCP_CF_PUSH), where backlog references accumulate; on other
 > teardown paths the caller already handles cleanup.
 > 
 > With subflow->closing set and mptcp_data_lock() held across the purge,
 > any concurrent mptcp_data_ready() either completes its enqueue before
 > the purge runs and is caught, or observes closing=1 and bails out. Once
 > mptcp_data_unlock() is reached, no new skb referencing the ssk can be
 > enqueued, so the cleanup is exhaustive.
 > 
 > Remove the unprotected traversal from mptcp_close_ssk() entirely.
 > 
 > Tested with the MPTCP kernel selftests on the patched kernel:
 > - tools/testing/selftests/net/mptcp/mptcp_join.sh: all tests pass
 > - tools/testing/selftests/net/mptcp/mptcp_connect.sh: 68/68 pass
 > 
 > Fixes: ee458a3f314e ("mptcp: introduce mptcp-level backlog")
 > Suggested-by: Paolo Abeni <pabeni@redhat.com>
 > Reported-by: syzkaller <syzkaller@googlegroups.com>
 > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/621
 > Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
 > ---
 >  net/mptcp/protocol.c | 34 ++++++++++++++++++++--------------
 >  1 file changed, 20 insertions(+), 14 deletions(-)
 > 
 > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
 > index 4546a8b09884..37efcea99dc1 100644
 > --- a/net/mptcp/protocol.c
 > +++ b/net/mptcp/protocol.c
 > @@ -2527,6 +2527,22 @@ static void __mptcp_subflow_disconnect(struct sock *ssk,
 >      }
 >  }
 >  
 > +static void mptcp_cleanup_ssk_backlog(struct sock *sk, struct sock *ssk)
 > +{
 > +    struct mptcp_sock *msk = mptcp_sk(sk);
 > +    struct sk_buff *skb;
 > +
 > +    mptcp_data_lock(sk);
 > +    list_for_each_entry(skb, &msk->backlog_list, list) {
 > +        if (skb->sk != ssk)
 > +            continue;
 > +
 > +        atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
 > +        skb->sk = NULL;
 > +    }
 > +    mptcp_data_unlock(sk);
 > +}
 > +
 >  /* subflow sockets can be either outgoing (connect) or incoming
 >   * (accept).
 >   *
 > @@ -2550,6 +2567,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 >      lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 >      subflow->closing = 1;
 >  
 > +    if (flags & MPTCP_CF_PUSH)
 > +        mptcp_cleanup_ssk_backlog(sk, ssk);
 > +
 >      /* Borrow the fwd allocated page left-over; fwd memory for the subflow
 >       * could be negative at this point, but will be reach zero soon - when
 >       * the data allocated using such fragment will be freed.
 > @@ -2641,9 +2661,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 >  void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 >               struct mptcp_subflow_context *subflow)
 >  {
 > -    struct mptcp_sock *msk = mptcp_sk(sk);
 > -    struct sk_buff *skb;
 > -
 >      /* The first subflow can already be closed or disconnected */
 >      if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
 >          return;
 > @@ -2653,17 +2670,6 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 >      if (sk->sk_state == TCP_ESTABLISHED)
 >          mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 >  
 > -    /* Remove any reference from the backlog to this ssk; backlog skbs consume
 > -     * space in the msk receive queue, no need to touch sk->sk_rmem_alloc
 > -     */
 > -    list_for_each_entry(skb, &msk->backlog_list, list) {
 > -        if (skb->sk != ssk)
 > -            continue;
 > -
 > -        atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
 > -        skb->sk = NULL;
 > -    }
 > -
 >      /* subflow aborted before reaching the fully_established status
 >       * attempt the creation of the next subflow
 >       */
 > -- 
 > 2.43.0
 > 
 > 


