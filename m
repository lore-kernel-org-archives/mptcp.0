Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299C2331EC7;
	Mon, 14 Sep 2026 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373236; cv=none; b=tqPps2Iv/4qUonVt+sDIc9FOHoCD7YMcv01PTKLF1ypfq23Usl0N4zxY1SCzXFqiqnRy9EWBy2LtnKFowBT5toh/v+mG7rz8yxSpy/gWo6vO7WWgadQmEasQdHGATrkPHdMh5BzT42GbVF4mPqh7W4VfgkHI+Ynszc7o0SNRZ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373236; c=relaxed/simple;
	bh=gLguI1Dvj1p9Hs1Gtajg0sdQbCBo0v751JRhitynJ/0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iNToaLbPcdJQlqn9a3cLbsbKlwDQ5orKd8K15lQg9/gacU1AEsy0Hpo+DkKVdLVSeYLq+TgFMZlavDEYcMkoCqzAPUuUBUO6TmhsK1/7lfKV7fiQA1WxJQ4k9OMiB8HuhEiWlU3x4pCiUx+GvAhhRRQIKNjcuQHkuWHNPSqgpBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUlLGMdJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUlLGMdJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805B51F000FF;
	Mon, 14 Sep 2026 08:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789373234;
	bh=bUESejhHEH3ffsQbUQdnbBFslDvX6q6Ex6c04pHGd1I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XUlLGMdJqf8ThjYG5If3HiL3sunkq4qlh2J7gR0dY7dh8rfPxdOGWWnbIJinsy7NU
	 IAMHyYW/Ff5If7Mbp7E3sC6AD6vggyIYVRh3PMQaLGM4Rsw2AH40pepP3Bq1hHG+tU
	 uVSV6Yvg6YI8SaBJa+lL5kqiE149fCR7gAWPgYYtpj71WZzqUYMoijkFcl8Gr/nQ8A
	 sIpPyzTEVOxtoPf4/gqJ+Aatct0Y/yA/e8TGLOenckNSL0yXcsP5AhTk44WRBT3l9c
	 PDdEC5d/LNXifsmIOz+r8lLn7vj7pxhHddmFs21V7TxReqwLo1e7Ptk7wXnefhzjNP
	 78TIXM6Sni8cQ==
Content-Type: multipart/mixed; boundary="===============8455009711460534272=="
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <f960ceb7616cb646c818809a3b5f7890d5c63573c6175f3b92f2fa19bfe54a2e@mail.kernel.org>
In-Reply-To: <d98eef55bd417f7166a30a9998a3b34e7f0b229d.1789368148.git.tanggeliang@kylinos.cn>
References: <d98eef55bd417f7166a30a9998a3b34e7f0b229d.1789368148.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH net 2/2] tls: drop duplicate check_app_limited in tls_push_sg
From: bot+bpf-ci@kernel.org
To: geliang@kernel.org,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,edumazet@google.com,ncardwell@google.com,kuniyu@google.com,davem@davemloft.net,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,sd@queasysnail.net,dhowells@redhat.com,matttbe@kernel.org,martineau@kernel.org
Cc: tanggeliang@kylinos.cn,netdev@vger.kernel.org,bpf@vger.kernel.org,mptcp@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 08:07:13 +0000 (UTC)

--===============8455009711460534272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> When the sendpage->MSG_SPLICE_PAGES migration series replaced
> do_tcp_sendpages() with direct tcp_sendmsg_locked() calls, callers that
> had used do_tcp_sendpages() kept an explicit tcp_rate_check_app_limited(sk)
> that was originally needed to cover do_tcp_sendpages() (which did not call
> tcp_rate_check_app_limited()). After the inlining, tcp_sendmsg_locked()
> always provides the check, and the outer call became redundant.
>
> Fixes: e117dcfd646e ("tls: Inline do_tcp_sendpages()")

Does the Fixes: tag identify the correct commit? The changelog states the
outer call "was originally needed to cover do_tcp_sendpages() (which did
not call tcp_rate_check_app_limited())" and that it "became redundant"
only "after the inlining". But e117dcfd646e did not introduce the
redundancy.

At e117dcfd646e's parent, do_tcp_sendpages() was already a thin wrapper
that funnels into tcp_sendmsg_locked():

  ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
                           size_t size, int flags)
  {
          struct bio_vec bvec;
          struct msghdr msg = { .msg_flags = flags | MSG_SPLICE_PAGES, };
          bvec_set_page(&bvec, page, size, offset);
          iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
          if (flags & MSG_SENDPAGE_NOTLAST)
                  msg.msg_flags |= MSG_MORE;
          return tcp_sendmsg_locked(sk, &msg, size);
  }

The conversion that made this true - and therefore the commit that made
the tls_push_sg() call redundant - is c5c37af6ecad9 ("tcp: Convert
do_tcp_sendpages() to use MSG_SPLICE_PAGES"), three commits earlier in
the same series. Before c5c37af6ecad9, do_tcp_sendpages() open-coded the
send loop and indeed had no rate check, and tcp_sendmsg_locked() already
carried tcp_rate_check_app_limited() at that point. e117dcfd646e only
replaced the wrapper call with its body; it left the
tcp_rate_check_app_limited(sk) line untouched as diff context.

If a Fixes: tag is kept, should it be:

  Fixes: c5c37af6ecad9 ("tcp: Convert do_tcp_sendpages() to use MSG_SPLICE_PAGES")

Both commits landed in the same merge window, so the practical backport
range is unchanged.


> so dropping the outer call is safe and behavior-preserving.
>
> A potential benefit of this change is that it facilitates future reuse of
> tls_push_sg() for KTLS support in protocols beyond TCP, such as MPTCP.
>
> Fixes: e117dcfd646e ("tls: Inline do_tcp_sendpages()")

Should this patch carry a Fixes: tag? The changelog describes the change
as "safe and behavior-preserving" and motivates it as cleanup plus
preparation for future MPTCP reuse. No user-visible bug, regression, crash
or misbehaviour is described or fixed: the removed
tcp_rate_check_app_limited(sk) is duplicated by the identical call inside
tcp_sendmsg_locked(), so tp->app_limited ends up with the same value
either way.

A Fixes: tag on a no-op cleanup mainly serves to draw the patch into
automated stable selection (AUTOSEL) for no benefit. Either drop the tag,
or state concretely what observable behaviour was wrong before so the tag
is justified.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34817950722
--===============8455009711460534272==--
