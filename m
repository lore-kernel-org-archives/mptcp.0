Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D3422523
	for <mptcp@lists.linux.dev>; Thu, 24 Sep 2026 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243781; cv=pass; b=QuPryFwCsBJv9OeG5ThNHc1QZKkxES1gFdxAJ8X1T/0OwObOTzQ7ds+38x+/dV49hWuHqdGVO5oPWEDEKc9Nfu8cLrWe/RYhBe5FijdN394dip8zHa/yzBwRWtD9imr4lzXUYIuNb0DRw03tB/6AAJaKnraShb62nFeReNpjaTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243781; c=relaxed/simple;
	bh=LBZZcNSVeHHRIpD1xuzWESX6CCgFGvOZ+4ZFnY2ewKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBckpy8lzVA8lyWisj8Pk+iTqjRIJf+niqj4KxoH265Jaqz4wC4uR5CT6OwRksHJTwEkMdiNbP8JJ3UTK7RI7GvLHj8QqUZMjShrLD2O6EhT3Lu8ScCS5TzHFN4M9ySaOB0GsQgngy8F+b9WfITWaH9ARbM3Wnx32/6ponSQNo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OgL5agPA; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OgL5agPA"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-5309a20a55bso16794251cf.1
        for <mptcp@lists.linux.dev>; Thu, 24 Sep 2026 02:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790243763; cv=none;
        d=google.com; s=arc-20260327;
        b=CortUc2VVtMEmwVBlLVhVs+K6dmT4oHEzwN+UFG/uhCye3V3OchiZVStYz4rX1xkKh
         xDnvFfXR9/1B5wM79OmtuG0T/5C0qg0X6qWkKXTYY+TC4yDA3kvixlW9oQd+4+Ioec/8
         9I7VD4J75NJMttF+1Q39lYEFyksbcb4z+wKatdLKoJqp+49HTwCNNkt9scWcTSj3pT//
         OZUdFVaCUxtWdvRRTnZe1PO/ODfQZhFnow9zCTSBoIGb0S//iIGITrIPA8lX+q40jF5b
         1r1rntP04k2RD200ucP+k15xZQdyb+Vb3Tqcr61ZA0iS06YKmxMKK9jkp+BnZnQvziTO
         byvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rM8Pnb3OaTJqlPgDl5Nu230H8PB3TRPyBVd+A2AcpH4=;
        fh=KoCzKEHuUNMs/ag7UyM994VOSzmDAtO6/sDJXYMDXiQ=;
        b=d/m4+aeffj98dql4Tjv/Sh2gMLE5tso/bG4d4316FldVJWsVVzva19gBc8T9NKtuuB
         9Y1OhuxN9Kq4qR2ZCcRXvJDRXJ0SPRqORvT2ulnfb0mk1Eqo8ZvSUWViBDUt2bRs97gY
         nrjX+mYjdPzLgzMvqdRzvESlpKAu4epxGaxFu7xJVG3Zi+3FIT8s9jHuJZ/k+4uB9KN0
         Rq2ytqB3V5/BT+ADiJ42B4h1HkQE1pnSUrriYWYok5apGpgL956wqbgbiutJVuwRcNag
         /g9i2lECc3N1At81YYgz9X4Y6bi4+HTd2owYZWETx80kXuIFp2kT0XqBW2FSEgojuaZp
         hQXw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790243763; x=1790848563; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rM8Pnb3OaTJqlPgDl5Nu230H8PB3TRPyBVd+A2AcpH4=;
        b=OgL5agPA/cljhVm3iK5e0X42C2kc1/FzMA0VTmtK6bfIN2RYmmBsIjDOGtvmIk0SXh
         /ElUHoiL/N4coYUXCEF5JUKUFEFa3oekD494JHM1vKKrLcHsQnevrpMX7SjgAdx4VtO5
         85tydmrVZjKwU/vssSr0rXGtpdPqkws3sqPVnp5uIpSXeKwviVi4XOMc2Tx/TUpR6GrK
         ridLlf8tEY3EPFaDBUWHdkFcVFU36pxLTwRoDyMrPcS3+I22hAGHgVAglSrpP8olE1g/
         vjM4KsoNPbGduQUISK4geM/HVFDOQkN1+YzYiJ12eRTnh/ecnFv4aKTFw5wqerzsvX6T
         YNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790243763; x=1790848563;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rM8Pnb3OaTJqlPgDl5Nu230H8PB3TRPyBVd+A2AcpH4=;
        b=zqFEalzqc7ziNI5XTYA5PT/rYF+IEGOlUpeC2BS6mxIVVEslxJO1SOarxUDg5Mhv0V
         m2+/inGVYAvYh3E1u9BcJuCjRu01QwWz9197u3jrtzP+6eGmg5dqSE/D/fKGPeAM7mtv
         7YsiufNXqOsjkIpqnx6FMbQjSODih3SQ76zk4u/SpE4br51uLFdlkz8uaCiQsoJlguWE
         BhMiAriVnFdagB9iuKHHFYEgjdVUP7rAzKnD+D3ZcXaojrve6/cy6l9mqDjLKKzWwm96
         pgov+NLNdc9+conVppgMzLv6YyxRXgccnMXY00nBjMrBdHkwgkI/Y2SAY5FG6OicPnkj
         4CPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxInRKosTV2XHCoiKnOIJWneyVHJepyq0sL/CRQf6jml6Lq+NiEg8bPbRp22RFJYPlawyUAPQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nNy2SWuvS5sEms9HvVGgw//itSXheI8tBIux5FlXToDjDB80pL
	uE4C797f2H37IUAKtSGT8goluWKAX+ltFzQmBRA41hzTdTNr+0oL9K12WCFMeVp0koLMR7Llb5e
	kfo6VRKp92QFFzsUa4tEolUN1CUq+m0UwEfX3OPbW
X-Gm-Gg: AYBFou0bV7pQMtFo9hGtIhRf4XPb1VVloOmh+IYUs5lYVQfVpCPQo6zQCuiP3qo4LYA
	NMP+Qh30eLyuh9HRlxO/bVIQV44pql82SjF74DbPrynBu+D8Pcur3aoaB2DxX6s97oXEzoQTqyn
	KvEK+5B3DlDxPkrLx/o7BfG3UBpivM6Mt+Nru1cBJMEuJfEyvDO8AMMGcAzEEeRK9f6DqozL7W7
	3NDHvvmUJYMF6En+lLnZW8+G1IzQiQlmhack2khQuCAnnkg9u75RQUO/lrGI8SoBbkp8Wd823mb
	WI4bxX1zhOZVEFCj6B2VX/hZWtMM8h8gQcCzeaiGFpKq96JKM7zWuoaq2t/i0GxX4vnUJCKJpII
	BMx2It2N2oTCKRlkPBnGtFnkI1X6gULFNTvOsz0rhNwvoHrBJImiQhittx04TmqKOuAO2
X-Received: by 2002:a05:622a:5a0f:b0:532:8f15:2744 with SMTP id
 d75a77b69052e-532fea4d150mr14339051cf.20.1790243762050; Thu, 24 Sep 2026
 02:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260924080219.1036588-1-caixinchen1@huawei.com>
 <CANn89iJVGmYwQerOixGurH6vw-GtvSAQq6u6zSNZoyZrcEx6Jw@mail.gmail.com> <d8c12b4e-4ff2-4c62-a40d-d67bb4680a0d@huawei.com>
In-Reply-To: <d8c12b4e-4ff2-4c62-a40d-d67bb4680a0d@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Sep 2026 11:55:50 +0200
X-Gm-Features: AclHuK_LOWvzBhJczhAfbtW30YiVgV1gD1vN5_bi3qPOiAKB6UaaHqyDAfOb9kg
Message-ID: <CANn89iLA55e6evpx__7AUQF45uYAbUHxRtz4rVT=vsKpqBRWkA@mail.gmail.com>
Subject: Re: [PATCH RFC -next 0/5] net: charge socket memory budget to memcg upfront
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, kuniyu@google.com, 
	pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org, 
	horms@kernel.org, ncardwell@google.com, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 11:25=E2=80=AFAM Cai Xinchen <caixinchen1@huawei.co=
m> wrote:
>
> Hi,
>
> Thank you for the review.
>
> We found that sk_forward_alloc is a plain int updated by a non-atomic
> RMW (sk_forward_alloc_add(), where even the read side is not
> READ_ONCE), and its writers span three unrelated lock domains:
>
>    - socket lock, process context: SO_RESERVE_MEM and TX grants
>       (__sk_mem_schedule(), sk_forced_mem_schedule());
>
>    - receive-queue lock, softirq: UDP RX charges and the
>       udp_rmem_release() fold;
>
>    - no lock at all: sk_mem_charge()/sk_mem_uncharge() from
>       skb_set_owner_r() and skb destructors, and the sk_mem_reclaim()
>       fold itself.
>
> Any cross-domain pair loses an update.  A lost charge is still
> returned in full by the matching skb free, so it resurfaces as a
> phantom surplus in sk_forward_alloc, and the next fold hands it back
> to the memcg via __sk_mem_reduce_allocated() ->
> mem_cgroup_sk_uncharge() - an uncharge with no matching charge.
>
> We first tried to fix it with locks, and hit three walls:
>
>    - the socket lock cannot be used: its holders free skbs (e.g.
>       tcp_recvmsg()), and the destructor's sk_mem_uncharge() would
>       need to re-acquire it - recursion.  That is why these helpers
>       are lockless in the first place;
>
>    - a new per-socket spinlock serializes the RMWs but not the bug:
>       __sk_mem_schedule() publishes the grant before the memcg charge,
>       and the charge may sleep (GFP_KERNEL, memcg reclaim/OOM), so no
>       spinlock can cover both steps; a fold in that window can still
>       refund pages whose charge afterwards fails;
>
>    - such a lock would also sit on the per-packet charge/uncharge
>       paths, exactly the hot path the cacheline layout around
>       sk_forward_alloc was tuned to keep cheap.
>
> Are there any good solutions to solve this problem?

Perfect, you now gave us what we need.

UDP is broken, it should be easy to fix without breaking TCP.

I am surprised your LLM went to a completelly broken path.

sk_forward_alloc is never supposed to be updated locklessly across
multiple lock domains:

- For TCP, sk_forward_alloc is strictly serialized by the socket lock
  (lock_sock / bh_lock_sock). TCP does not use sock_rfree() as an skb
  destructor (sk_mem_uncharge() is called under the socket lock in
  tcp_eat_recv_skb() and sk_wmem_free_skb(), while TX destructors
  sock_wfree() / tcp_wfree() only touch sk_wmem_alloc).

- For UDP, sk_forward_alloc is serialized by sk->sk_receive_queue.lock
  (in __udp_enqueue_schedule_skb() and udp_rmem_release()).

Your reproducer and analysis point to two specific places that violate
these locking rules:

1. SO_RESERVE_MEM on UDP sockets:
   SO_RESERVE_MEM (commit 2bb2f5fb21b0, "net: add new socket option
   SO_RESERVE_MEM") was designed for TCP, where sk_forward_alloc is
   protected by lock_sock(sk) and sk_mem_reclaim() checks
   sk_unused_reserved_mem(sk).

   However, sock_reserve_memory() only checks sk_has_account(sk), which
   also matches UDP. UDP does not support SO_RESERVE_MEM:
   udp_rmem_release() does not check sk_unused_reserved_mem(sk) (so the
   first recv() reclaims the reserved pages from sk_forward_alloc), and
   setsockopt(SO_RESERVE_MEM) only holds lock_sock(sk) instead of
   sk->sk_receive_queue.lock, racing with __udp_enqueue_schedule_skb()
   and udp_rmem_release().

   We can fix this directly in sock_reserve_memory():
diff --git a/net/core/sock.c b/net/core/sock.c
index 1d5927cd49a1..763c2017d9ef 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1034,7 +1034,7 @@ static int sock_reserve_memory(struct sock *sk, int b=
ytes)
  bool charged;
  int pages;

- if (!mem_cgroup_sk_enabled(sk) || !sk_has_account(sk))
+ if (!mem_cgroup_sk_enabled(sk) || !sk_is_tcp(sk))
  return -EOPNOTSUPP;

2. BPF sockmap (net/core/skmsg.c):
   As you noted in the reproducer comments, sk_psock_skb_ingress() and
   sk_psock_skb_ingress_self() call sk_rmem_schedule() and
   skb_set_owner_r() (which installs sock_rfree() as skb->destructor)
   from sk_psock_backlog() or after dropping sk_receive_queue.lock in
   udp_read_skb(). Calling skb_set_owner_r() / sock_rfree() without the
   socket lock (or sk_receive_queue.lock for UDP) on protocols with
   sk_has_account(sk) is a bug in net/core/skmsg.c and should be fixed
   there.
