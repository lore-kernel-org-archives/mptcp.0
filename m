Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8494BEE5A
	for <mptcp@lists.linux.dev>; Mon, 21 Sep 2026 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010296; cv=none; b=tgt/TQJnNSRkJfGmQPy4VrnYeSP3qmEw7Zn/uKt6A/JQ2sqdVMxw7wf881TfZIWP8Fy+G424masWOcZmp6NN6THUX3nyaLv3oAvaAKZ2ZVqA8l0yn2jL0aBSv+hl9ICwYmNlICFfxGIScBQthSqeDEaGPVXvlflBZuoI6+hk4uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010296; c=relaxed/simple;
	bh=vPdjR6s9ouVrIEDOjOCLhqd1GJY7HCkg97BH22Ps4hI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=moijtiEs/OlK3rri2CsVFmcDutru2EI3aLE61zReqPnAVOEW7VAsZlTrJpn2lKcU79AtFpxGQqOxhIxHngMl8KuJPGGmVC9Jq3Vua7uey64vrTfAgfr0dIWZ3XE5cQLvt4OirpUseCmIa8tKW//v5r93f12IztPNmzWmA0lOg6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPPXNhMw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPPXNhMw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640601F000FF;
	Mon, 21 Sep 2026 17:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790010294;
	bh=tOsKAgmasTq7ps4jsWUkeD5zWiIL6gZFDvzfsYK4MqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GPPXNhMwIcOUqSVaxB538JH+ZX54cGM5uFBo8YvrQeBHZ1c1Q4oWvc/YJgCKDpnss
	 SyNhMQ6jjHDH5AK1NcVNU5s68DOe5ojSjO3DxPqic400RT5bKmyRgHxq1TEWp4UIA6
	 GOGbHoJf8mJa0Zw0bzmMzvGfN22DI2BEduG/HfqVl8k1yPXWHIQjWtlVumO5IjEEAK
	 Em9OOJ+xVjOLsmkN0jO0BloTG5aXTwIzz1iBpTlvyKFoYtqlY4EY+xFtyP7W7up7Wm
	 Wr6K+vebDWzv8+IyCsBw7BoPTu5VBhE0vcKI6Zc9OOAeckUdXBjd5hjOVBdKMNOiqU
	 No0U1J1A0wgYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net] mptcp: fix subflow bitfield misuse
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Abeni" <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <0342bcf7f4bc6c4598ecbe58cfd8ec75505c328e.1790009113.git.pabeni@redhat.com>
References: <0342bcf7f4bc6c4598ecbe58cfd8ec75505c328e.1790009113.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 17:04:53 +0000
Message-Id: <20260921170454.640601F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mptcp: resource leak due to uncleared close_event_done in reused s=
ubflow
--

commit 3af2e392c470dbc8520a6d4b6cca07a2f647ac5f
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: fix subflow bitfield misuse

This commit moves the close_event_done flag out of a bitfield in
mptcp_subflow_context to prevent concurrent access corruption. It also
removes a local_id check in mptcp_close_ssk, as the flag is no longer
cleared at disconnect time.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e89a69ab927c9..9b98f25690036 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2750,7 +2750,7 @@ void mptcp_close_ssk(struct sock *sk, struct sock *=
ssk,
>  		     struct mptcp_subflow_context *subflow)
>  {
>  	/* The first subflow can already be closed or disconnected */
> -	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
> +	if (subflow->close_event_done)
>  		return;

[Severity: High]
Does this early return cause a resource leak when a subflow is reused?

Since the patch moves close_event_done out of the reset struct_group, it is
no longer cleared by mptcp_subflow_ctx_reset() when a socket is disconnected
and reconnected. If the first subflow receives a closure event,
close_event_done becomes true.

When the reconnected subflow later terminates and calls mptcp_close_ssk(),
close_event_done is already true, which causes it to return early here. Cou=
ld
this bypass __mptcp_close_ssk() and permanently leak the subflow socket and
associated memory?

> =20
>  	subflow->close_event_done =3D true;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 0384d6a023f9d..9a294b29102ab 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
[ ... ]
> @@ -625,6 +624,9 @@ struct mptcp_subflow_context {
>  	int     cached_sndbuf;	    /* sndbuf size when last synced with the msk=
 sndbuf,
>  				     * protected by the msk socket lock
>  				     */
> +	bool	close_event_done;   /* netlink event generated,
> +				     * protected by msk socket lock
> +				     */
> =20
>  	struct	sock *tcp_sock;	    /* tcp sk backpointer */
>  	struct	sock *conn;	    /* parent mptcp_sock */

[Severity: High]
Should close_event_done still be cleared during a subflow disconnect?

By placing close_event_done outside of the struct_group(reset) boundary,
mptcp_subflow_ctx_reset() misses it during the memset operation. If this fl=
ag
remains set on a disconnected and reused subflow, subsequent netlink events
for closures might be dropped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0342bcf7f4bc6c4598e=
cbe58cfd8ec75505c328e.1790009113.git.pabeni@redhat.com?part=3D1
