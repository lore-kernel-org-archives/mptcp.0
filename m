Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722A648BD5E
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352683; cv=none; b=rYO/0zUJKhxBr3jOrh8GBEc7h2A8nj9EecQAzkwR4+OaJHnyivoNfjnU/bGLoi9JwLrwjmYfnsspaGv22kV6jISkc74sXvFj0auW4o4Kk6AignseCqkckD5TXQXx2VBV6p2FLlOsbnUPW1LdkPixNM74toozNvHYqUG+0Tf4HAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352683; c=relaxed/simple;
	bh=Ht4/CqyntQFVR9qZaR4A0exSG5+QhETliZ7me9RufMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NsRY6kb11LiFUmnKN7CH73m2RVblx+T2lTlP1evMA3tT6wqHCogMJj7EKgLuwXKqGZ35xuTSTK31vfR6u2hfJcH9j/IvfYlstcVM7oI/ZKDqX3kCAKlmZMkZw0uz6XWQzofIpvjfh6CusZs0WGCVDojwaxnqMtDMx4kwmKWo+uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILJoJY9d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILJoJY9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5674B1F000E9;
	Wed,  2 Sep 2026 12:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788352679;
	bh=hzFRw3+BiZqs/1HUEOcDwXSXAnXBvs/qRXeXNuLj6BY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ILJoJY9dlZHSxip+7y4j+qMacBgXWyu1poIR7Cj7XWMbnRQEVghlWbyg20pK6jeyT
	 Hd0BuGMRjGU+SkUh4oeHkVZIUl9cMLzXr2kiBdoAwlyvP2ErE4O/PgHcEt8bUmdxr9
	 kukYZlXraBI4CjxmUkNDiB0kCHfeVtKkhcMN0OsytfxlH00pYrGRxmj1he/m6RBEuE
	 SuY5/IAtJmeujVy35D5a6Eti4oy+xZs8f05tlpNMF/t7VjqIBJBR9uVp04RMJ2SUre
	 2S3saPGEV0eUWU5R2Q3yRE7ocytq5SW1bEhDe5AAtK4VkhSzWvYoM8hcQHnR07/+RK
	 4wrqMRvJOJ5dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tcp: fastopen: check rsk_drop_req() in
 tcp_fastopen_create_child()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yilin Zhang" <yilinzhang@moonshot.ai>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260902121247.3248539-1-yilinzhang@moonshot.ai>
References: <20260902121247.3248539-1-yilinzhang@moonshot.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 12:37:58 +0000
Message-Id: <20260902123759.5674B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Missing `bh_unlock_sock(child)` before `sock_put(child)` cause=
s a locked spinlock and preemption/softirq-disable leak.
- [High] Returning NULL from `tcp_fastopen_create_child()` fails to abort t=
he request, causing a rejected MPTCP MP_JOIN request to incorrectly fall ba=
ck to standard SYN processing, leading to a spurious SYN-ACK and resource w=
aste.
--

commit c3cab231705bf3a0b9db9f8531e40d30d546e830
Author: Yilin Zhang <yilinzhang@moonshot.ai>

tcp: fastopen: check rsk_drop_req() in tcp_fastopen_create_child()

This commit addresses a use-after-free vulnerability by checking
rsk_drop_req(req) in tcp_fastopen_create_child(). If an MPTCP MP_JOIN SYN
with a valid Fast Open cookie triggers the fatal fallback in
subflow_syn_recv_sock(), the request and child socket are now dropped.

> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 471c78be55137..b8b3abbee253d 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -337,6 +337,11 @@ static struct sock *tcp_fastopen_create_child(struct=
 sock *sk,
>  	if (!child)
>  		return NULL;
> =20
> +	if (own_req && rsk_drop_req(req)) {
> +		sock_put(child);

[Severity: Critical]
Does this code leak the socket lock?

When a child socket is created and returned by syn_recv_sock(), it is
returned with the socket spinlock held. If we call sock_put(child) here
without first calling bh_unlock_sock(child), does this leave the spinlock
locked and softirqs disabled, leading to a soft lockup?

> +		return NULL;

[Severity: High]
Does returning NULL here cause the dropped request to be incorrectly retain=
ed?

When NULL is returned, tcp_fastopen_create_child() signals a normal Fast Op=
en
failure rather than a hard drop. tcp_conn_request() will then assume Fast O=
pen
failed, proceed to the standard SYN processing path, link the dropped reque=
st
into the SYN queue, and send a SYN-ACK:

net/ipv4/tcp_input.c:tcp_conn_request() {
    ...
	} else {
		tcp_rsk(req)->tfo_listener =3D false;
		if (!want_cookie &&
		    unlikely(!inet_csk_reqsk_queue_hash_add(sk, req))) {
			reqsk_free(req);
			dst_release(dst);
			return 0;
		}
		af_ops->send_synack(sk, dst, &fl, req, &foc,
				    !want_cookie ? TCP_SYNACK_NORMAL :
						   TCP_SYNACK_COOKIE,
				    skb);
    ...
}

Should this path return an error pointer or use a drop mechanism to ensure =
the
request is completely aborted, rather than triggering the fallback path?

> +	}
> +
>  	spin_lock(&queue->fastopenq.lock);
>  	queue->fastopenq.qlen++;
>  	spin_unlock(&queue->fastopenq.lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902121247.3248=
539-1-yilinzhang@moonshot.ai?part=3D1
