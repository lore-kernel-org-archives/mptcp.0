Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABC53C10B2;
	Tue, 15 Sep 2026 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474428; cv=none; b=ptCvdF1iQ1TQZS+aroqqquImwErlXeyIV5hRj5xLetBEhsc/dLFf99gDgwWDwgYK7p2Jg0AUNXtSyO9n8Z9Nxucien8gUIAWMFxjR2VbBMKH3zV6xL1JWfnWh2o7I18MHZzM6Xd0VAL61Zy+dm4BZOIqEBleo0x7+sdzbg8dE5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474428; c=relaxed/simple;
	bh=JcKoswAOhyuMNjq+mGSOFMd2o3VTqmC8wPMTfTEo83M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sAZ2UnrUyFEx6v0FeIukTfcBjlF//bE2R8MdRXlM8084wrJztT4B/od/hFFenmv+sOa2YSHHnQsQt2Xy71JoGSOpxRPWw71Ys26UGgCXFs8zUo4sFG87E4TTJuRn7UdMWcpRs5WbjzaN4gEbq1cAULN/Mwj97a5INVhI5Iz+9q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpyHmG7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpyHmG7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A161F000FF;
	Tue, 15 Sep 2026 12:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474426;
	bh=YzkYuMVzkpLRGXY8MKPQ97VDe6r+TzShk9f5fTc3tIE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cpyHmG7Uek337dIERN+s/TgP/ItZjRRX27WIafN+eVogPnvDaZ2levjx0+Ekstf9O
	 aKmmkikGqOS29yGlLv/jMPbQnWSovGv+5ZqP5ITCqBH7IkXD/jYKFw6CJ6+/9okD6W
	 zOeRvktNMCg4q+b+7YwOHfOExvHI2K82zpul6Qo5wdcpyQN85mi01riFEF0vrY1kVt
	 YkbBqGJMtRUWN/PD8o3h0zNBi0G+pOIfHJYYTHwLW50aAcUGnyQ4XZSTWr9Wk750D5
	 wMDD5wcPOzr5n8JPfqGEAX+cQy1x7ok55AUGkaWrL3AXiqXu1BjLYLyD+/jdF7Wtr3
	 5dih0xkSdft/w==
Content-Type: multipart/mixed; boundary="===============4719459423094257229=="
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <650558176bb55367e1b7c7cee7a4a5285aaa6adbadeaf3935337903efd2c6778@mail.kernel.org>
In-Reply-To: <87e00ef420af81974b590f9057cc08234324d45d.1789469930.git.tanggeliang@kylinos.cn>
References: <87e00ef420af81974b590f9057cc08234324d45d.1789469930.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: drop duplicate check_app_limited in tcp_bpf_push
From: bot+bpf-ci@kernel.org
To: geliang@kernel.org,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,edumazet@google.com,ncardwell@google.com,kuniyu@google.com,davem@davemloft.net,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,sd@queasysnail.net,dhowells@redhat.com,matttbe@kernel.org,martineau@kernel.org
Cc: tanggeliang@kylinos.cn,netdev@vger.kernel.org,bpf@vger.kernel.org,mptcp@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 12:13:45 +0000 (UTC)

--===============4719459423094257229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Before commit c5c37af6ecad9 ("tcp: Convert do_tcp_sendpages() to use
> MSG_SPLICE_PAGES"), do_tcp_sendpages() did not call
> tcp_rate_check_app_limited() internally, so callers needed an explicit
> tcp_rate_check_app_limited() to cover it. That commit replaced
> do_tcp_sendpages() with direct tcp_sendmsg_locked() calls, which always
> provide the check internally. The outer call became redundant but was
> left in place.
>
> The site changed here, tcp_bpf_push(), is a MSG_SPLICE_PAGES loop that
> holds the socket lock and only iterates when size > 0; tcp_sendmsg_locked()
> is invoked on every iteration with state identical to what the outer call
> sees, so dropping the outer call is safe and behavior-preserving.
>
> A potential benefit of this change is that it facilitates future reuse of
> tcp_bpf_push() for sockmap support in protocols beyond TCP, such as MPTCP.
> Since tcp_rate_check_app_limited() is TCP-specific while sendmsg_locked()
> is a generic interface in struct proto_ops, this change allows us to switch
> to different protocols via sk->sk_socket->ops->sendmsg_locked() without
> carrying protocol-specific assumptions.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

This isn't a bug, but the state-equivalence argument here looks right.
Would it be worth tightening "which always provide the check internally"
to something like "which performs the check on every path that queues
data"?

Looking at tcp_sendmsg_locked(), it reaches tcp_rate_check_app_limited()
only after the MSG_ZEROCOPY and MSG_FASTOPEN early returns:

net/ipv4/tcp.c:tcp_sendmsg_locked() {
    ...
		uarg = msg_zerocopy_realloc(...);
		if (!uarg) {
			err = -ENOBUFS;
			goto out_err;
		}
    ...
	err = tcp_sendmsg_fastopen(sk, msg, &copied_syn, size, uarg);
	if (err == -EINPROGRESS && copied_syn > 0)
		goto out;
	else if (err)
		goto out_err;
	}

	timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);

	tcp_rate_check_app_limited(sk);  /* is sending application-limited? */
    ...
}

Those branches are reachable from tcp_bpf_push(), since tcp_bpf_sendmsg()
forwards the user's flags almost verbatim and tcp_bpf_push() passes them
on as `msghdr.msg_flags = flags | MSG_SPLICE_PAGES`, so MSG_ZEROCOPY and
MSG_FASTOPEN both reach tcp_sendmsg_locked(). On those paths the old code
updated tp->app_limited and the new code does not. Every one of them
returns without queueing SPLICE_PAGES data, so there is no functional
consequence -- but "always" is doing load-bearing work in the
justification, and a narrower phrasing would match the code.

Also, is the "only iterates when size > 0" clause needed? The internal
check at net/ipv4/tcp.c:1190 is called unconditionally regardless of
size, so the size > 0 property is not what makes the removal safe.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34964239423
--===============4719459423094257229==--
