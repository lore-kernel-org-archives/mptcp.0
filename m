Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41D33B7B6E
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740239; cv=none; b=AyQpS8sWGc96Aa5TmkMvmtuG+q4FvCPjHslPcnYmwAEHs78kzpzhf4+7oAitY9rYpSKpLsVPyQ8Z6wUC0uBiNxm5Px/SU/bKzetC2i+FX8+f7yNx0uZ3FsgcxAnbnzbXlWjblJ+eSr+PFoc2fwcpVs0KtZc8a0eT6rw3FgPscyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740239; c=relaxed/simple;
	bh=8FMwsyGREtdCujqtLvtOacFcmrf27MQEJP9zGNCJBEY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SljrOk0IT4mpPXd88J+xUn8UFc6rg0feQJWnVwuSsV4uZPNXTDwmy27Z/roL+xoxJqp73yPbpRgfasrghDSvu9NWmGK3bt9QUFf3OWJUs0doU/+UFkT+c625xvqAO8dROvaZHE89eEOK9fcjWaMpb8RRy1bdgE2TnHCcGMdnY4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlsSdFyu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlsSdFyu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE861F000E9;
	Wed, 26 Aug 2026 10:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787740238;
	bh=KHif4THaGyULGplPXBdzfd8EMODq5wdv+VSdcH5bM88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZlsSdFyuYv5cX2D6MO+UJY4c3iMz3TugPn3cbgQUP7YOZ0lvYJYjFEdYrZr6ie2V7
	 fvC+hQqW12pUA4K2LXAnOBU2rNi+4FTwtZU3EUirKZGAmRMHe0UUCgWJ3opBETxSU5
	 Vkt1KlxA74KnXcuqdflhDtbIlF6HHcvbHlE+kIwSYW8LXouRX4a3kZJrh7Qkt7GKQf
	 m93o7gXLeeoEeBM41xQlzOFL7sQmvHdQPvN+NP0SHagEVhtYKkcsOmZh0TRlcR38cU
	 tkoBssBk6CPtLiACwReY6cvokW/s4MdLFeIMee5zk0CyM0ewcD5S5HK7ji2cwltRKF
	 mRlsD/XSZY+Vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net 2/2] Squash-to: "mptcp: do not reschedule the
 RTX timer for fallback sockets"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Abeni" <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <3d8a1534a8b0609c6ddcd593f4ed8957be019657.1787739122.git.pabeni@redhat.com>
References: <f1e8ffe44c3756195391a25ecf60e56e02e0f34f.1787739122.git.pabeni@redhat.com>
 <3d8a1534a8b0609c6ddcd593f4ed8957be019657.1787739122.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 10:30:37 +0000
Message-Id: <20260826103038.1CE861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Non-blocking MPTCP Fastopen bypasses `mptcp_connect`, leaving the =
socket permanently in `TCP_CLOSE` and failing to enable the RTX timer.
--

commit 4679eada053d3ad7385facbcb9d12c98ccd146f2
Author: Paolo Abeni <pabeni@redhat.com>
Subject: Squash-to: "mptcp: do not reschedule the RTX timer for fallback so=
ckets"

This commit replaces the MPTCP_RTX_DISABLED flag with MPTCP_RTX_ENABLED to
explicitly control the retransmit timer status across the socket lifecycle.
It sets the enabled flag during active connect and passive initialization.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2f17c5daa704e..a28a0506d28da 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4154,6 +4155,7 @@ static int mptcp_connect(struct sock *sk, struct so=
ckaddr_unsized *uaddr,
>  		return PTR_ERR(ssk);
> =20
>  	mptcp_set_state(sk, TCP_SYN_SENT);
> +	set_bit(MPTCP_RTX_ENABLED, &msk->flags);

[Severity: High]
Does this change leave the RTX timer disabled during non-blocking Fastopen
connections?

When a non-blocking TCP Fast Open connection is initiated on an MPTCP socket
(using MSG_FASTOPEN and MSG_DONTWAIT), mptcp_sendmsg_fastopen() skips the c=
all
to __inet_stream_connect(), which bypasses mptcp_connect() entirely:

net/mptcp/protocol.c:mptcp_sendmsg_fastopen() {
    ...
	if (ret =3D=3D -EINPROGRESS && !(msg->msg_flags & MSG_DONTWAIT)) {
		ret =3D __inet_stream_connect(sk->sk_socket, msg->msg_name,
					    msg->msg_namelen, msg->msg_flags, 1);
    ...
}

Because mptcp_connect() is bypassed, MPTCP_RTX_ENABLED is never set, and the
socket state remains TCP_CLOSE instead of TCP_SYN_SENT.

This causes __mptcp_sync_state() to skip transitioning the socket to
TCP_ESTABLISHED:

net/mptcp/subflow.c:__mptcp_sync_state() {
    ...
	if (sk->sk_state =3D=3D TCP_SYN_SENT) {
		/* subflow->idsn is always available is TCP_SYN_SENT state,
		 * even for the FASTOPEN scenarios
		 */
    ...
}

Will this cause non-blocking Fastopen connections to become permanently stu=
ck
in TCP_CLOSE without an active retransmit timer if packet loss occurs?

>  	subflow =3D mptcp_subflow_ctx(ssk);
>  #ifdef CONFIG_TCP_MD5SIG
>  	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f1e8ffe44c375619539=
1a25ecf60e56e02e0f34f.1787739122.git.pabeni@redhat.com?part=3D2
