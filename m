Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007647;
	b=l9xxpny74nye7vnsNIFMMqZyd7VwuOQjJG5EcS9PId8O9P51PPj4WhStoEC2IDcMZfUp
	 nbNNc/pQeg8YV29/lq+dN8AlsWypNfP5Fh4nNqQHFcZ0aTsjwjSdBwOt8l/eJLj6hGf2+
	 Z5KwHC8feuBksUShBEhrTR8dKKojQp9W+DAG9v8RfMj2fdNRfNtfpCxb27aNZJFz9H7Jc
	 J5XX92EAmfczophk9zqeQCSx4tn1tnFZbshaa1b1SS/wIfwhvOvEsFpxNPM/iRR6G3GLv
	 IQozJAwcAuhrddfFDZTtX91pxA3+TuPandgECzePGWCZmJxz9EaGELmQwqZGnh2tdOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007647;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rDNC8CNbm8Zg/1g/G4cdC0Lh+zR4gF4DiNorLsKDSRk=;
	b=VtsbjoAa9zUhfG+ekoqiTeKt93NBLzrbVRSuIuSRS4MpxMLgiKPTw0oidzLSqUASnq1s
	 NVFE5L7NjA0lMJ/W170DHL9VeMNfHb8dG7XRakNL36/sFCu2bgs/OtECqsdFGacr4foBu
	 B6r47AePRcJVQzIf1aqq0azrCQVFz3HDnK3GZAhst+kR2IGL+47GAAEkp87TOuoFgzEYq
	 n1Z+zRIC8OhmGWNHDjkx5NLM9kJ0/9IjPPyikBBVsdQFdxjc9gTZo5lCnG4M/fpzhY2ej
	 sS1TqIbrPZaf0hwdSh7q23Abjbcs9rNfZAqz/FJs7pzHpZd9SXws+wddwFWUGOekaIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXoNdzPv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210C3606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXoNdzPv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B811F01829;
	Mon, 26 Oct 2026 09:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007646;
	bh=rDNC8CNbm8Zg/1g/G4cdC0Lh+zR4gF4DiNorLsKDSRk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YXoNdzPv9UoFixw4YlHxerL4i7NDXdBtnIy8ZaqzI4J2qy2YPW9YNyizffsa7srpz
	 xn/hv1M4A6SkxOACF/R0uGz4YMXj6kJEyD9mHqVHO3rfeSOSglcWDCG9PEWF+ljgmX
	 GNEKe/kDaGREdJhXgTX2wtQJqSm7YOnHopC2j/CYbtCGFJmFYBt//uAd2BP5TB9nIB
	 xYogAxkvX6Tj+BhPHSt2/lgtv1t8IfW35gE9CWNHzUG7Ado4QolEGWNA1fsdtkswnZ
	 PntbASCSGqjc9JlXA9velMnN1hWZLklck+L+Rx3mmXDaBle2lla8MzlhJrFMiUkfhJ
	 /UbVlpluN5InA==
Message-ID: <sashiko-outbox-184821@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next 2/6] mptcp: prevent dummy DATA_FIN on RST in
 fallback mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <827c399d23b97b70e59e123d32c7b4b74d3f3987.1792999988.git.tanggeliang@kylinos.cn>
References: <cover.1792999988.git.tanggeliang@kylinos.cn>
 <827c399d23b97b70e59e123d32c7b4b74d3f3987.1792999988.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:40:46 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mptcp: subflow_is_done() checks sk_err after sock_error() clears=
 it
--

commit f3589041bbf58620527475a4a2caf2b983e29587
Author: Geliang Tang <geliang@kernel.org>

mptcp: prevent dummy DATA_FIN on RST in fallback mode

This commit checks sk->sk_err in subflow_is_done() to prevent creating a
dummy DATA_FIN when a fallback subflow is aborted with a TCP RST.

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 78e886b202585..a53c83644a40b 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1327,6 +1327,9 @@ static void mptcp_subflow_discard_data(struct sock =
*ssk, struct sk_buff *skb,
> =20
>  static bool subflow_is_done(const struct sock *sk)
>  {
> +	if (READ_ONCE(sk->sk_err))
> +		return false;

[Severity: Medium]
Can sk->sk_err already be cleared to 0 before subflow_sched_work_if_closed()
checks subflow_is_done()?

When a fallback subflow receives a TCP RST in softirq, tcp_reset() ->
tcp_done_with_error() sets sk->sk_err and invokes subflow_state_change():

net/mptcp/subflow.c:subflow_state_change() {
	if (mptcp_subflow_data_available(sk))
		mptcp_data_ready(parent, sk);
	else if (unlikely(READ_ONCE(sk->sk_err)))
		subflow_error_report(sk);

	subflow_sched_work_if_closed(mptcp_sk(parent), sk);
}

When the parent MPTCP socket is not owned by userspace
(!sock_owned_by_user(parent)), both subflow_error_report() (via
__mptcp_error_report()) and mptcp_data_ready() (via move_skbs_to_msk() after
draining the subflow receive queue) immediately call
__mptcp_subflow_error_report(parent, ssk):

net/mptcp/protocol.c:__mptcp_subflow_error_report() {
	if (sk->sk_state !=3D TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)=
))
		goto out;

	err =3D sock_error(ssk);
	if (!err)
		goto out;
}

Because sock_error(ssk) executes xchg(&ssk->sk_err, 0), ssk->sk_err is
atomically reset to 0 while propagating the error to parent->sk_err.

When subflow_state_change() subsequently calls
subflow_sched_work_if_closed(mptcp_sk(parent), sk), won't subflow_is_done(s=
sk)
observe READ_ONCE(sk->sk_err) =3D=3D 0, return true because RCV_SHUTDOWN and
TCP_CLOSE are set, and still generate the dummy DATA_FIN via
mptcp_update_rcv_data_fin()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792999988.gi=
t.tanggeliang@kylinos.cn?part=3D2
