Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735797;
	b=yMLQ9bkT2rNCMTaW/JUAoa4ctXdFY4D9/QGAp+p3Drh6SXtevVYUZXOmWROYhj3HNybt
	 RBW9kI/XB1K4s+qmHHP9ypWraIFSnz949mpPp6Ab01014WhHUBU/SUW5XwGDjJ7aVRuhp
	 yQausA9bF9Ux0BacGOr6lZpi2aIUmvwq16sLuSzXFm2DFo9jL0MoqclUmfk1yyDvTdpWk
	 9oK8mfOhzy6IYeBDpIxyZwG/XQbAu8XplwI2a3n13RNDYYw7rZf7U9LwDMe8tnh5VhZ7C
	 igt490+ZFKrNPPHv+dclPIIkJ9gMAIu7zlcWoKA/+GNFvoo/WPJ2jSQdKz0mIddhg6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735797;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ji7hT5znZzhHtSQP2St7VLevtUOErPUrxvoKH7fKhbc=;
	b=oDXB0A4ssmPcK8xJusAsqN2krBZHvcP2nwg9HF/uTaR9pEbmh7AVP4s4sEioe9Zgwioy
	 3jzPzAYgJUB8zR4yjW7OVqM7O+QM0rmd9fg3PgMwGwKycuib8OpcQFxuksdCig9eLqrid
	 +KGsQWxnQK5ySNyccsCvwtSxCvXKRbAOlpuiQIILMb9r2kRAyTnJ+d6+0sMujysNE/DdV
	 FVub7OumNMcTJY1bs7SjqtELHZT37X9PuhKmMQrkfpaWI4laFIVxt9EJUNbEnY+m04dbF
	 rkTiPkEuLuNIzMefuXXchdxlmsRKHUzU7TtcqqYZSXZE1m77l7zb04i+1tGUrMFBBNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j2D/eG4R";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AC3606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 23:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2D/eG4R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300D71F00896;
	Thu, 26 Nov 2026 23:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735797;
	bh=ji7hT5znZzhHtSQP2St7VLevtUOErPUrxvoKH7fKhbc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j2D/eG4RIuitW4+dET+n6oHj+7ckLELKJub2Lnqwt+9EUA6LCzU8hbCF6S9uE+ZE0
	 T+0m3KggrpCW7yNr1i8fU0WtpJbO09VN8GbkD9ksCL532CLcUhRxuzZEUF9q6QodGU
	 Z/RJMu+JCZDr0xkewNGk/WzwdejmQOAleBEw0y1lMVNBj9DIfaJaWdDAtb8K8TjjKJ
	 FSQb+bwE7XbxCH15BHdobdMiCN5ctX7e4wZar136iL5LKx+QTyi+ukc440iaKNOEOw
	 rWakntnEcLOe3RIUeB0sg94LpFTRwmj8BLDIl5WxoQ1jfBH6GLnOI4zeti4OBxjlpj
	 6pyqSLBTVk5Fw==
Subject: Re: [PATCH mptcp-net v3 45/50] Squash to "bpf: Add mptcp packet
 scheduler struct_ops"
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 23:29:56 +0000
Message-ID: <179573579674.3133.17888225434751779864@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-45-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-45-416c0920c73f@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This squash moves undocumented changes to the core push loop into
  a commit whose message is only about BPF.

--

Squash to "bpf: Add mptcp packet scheduler struct_ops"

This squash fixes two infinite push loops that can happen when a BPF
scheduler picks no subflow, or keeps picking a subflow that cannot send.
In __mptcp_subflow_push_pending(), the loop now stops when no subflow is
scheduled. In __mptcp_push_pending(), push_count is now decremented after
any failure.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f361cd40a8e40..a3c2d8f93bd71 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1901,10 +1901,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>  
>  				ret = __subflow_push_pending(sk, ssk, &info);
>  				if (ret <= 0) {
> -					if (ret != -EAGAIN ||
> -					    (1 << ssk->sk_state) &
> -					     (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSE))
> -						push_count--;
> +					push_count--;
>  					continue;
>  				}
>  				copied = true;
> @@ -1961,6 +1958,9 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
>  				keep_pushing = false;
>  			else
>  				copied += ret;
> +		} else {
> +			/* a BPF scheduler might not pick any subflow */
> +			keep_pushing = false;
>  		}
>  
>  		mptcp_for_each_subflow(msk, subflow) {

[Severity: Low]
This isn't a bug, but after the squash, will the message of "bpf: Add
mptcp packet scheduler struct_ops" still match what that commit does?

Right now that commit only modifies net/mptcp/bpf.c. Its message covers
registering the bpf_struct_ops and allowing write access to the scheduled
flag through .btf_struct_access.

With this squash, it would also change the generic transmit path in
net/mptcp/protocol.c. All schedulers use that path, including the default
one:

  - __mptcp_push_pending() drops the -EAGAIN exception for FIN_WAIT1,
    FIN_WAIT2 and CLOSE. That exception came from commit 0fa1b3783a17
    ("mptcp: use get_send wrapper"). push_count is now always
    decremented.

  - __mptcp_subflow_push_pending() gets a new else branch that sets
    keep_pushing to false.

The code changes themselves look fine. The explanation of why both are
needed, and why the default scheduler is not affected, is only in this
squash message. Nothing asks for it to be carried over into the target
commit message. Later patches in the series do not seem to cover this
either.

Could this explanation be added to the target commit message? That way,
git blame and bisect users can find out why the -EAGAIN retry from
0fa1b3783a17 was dropped.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124-mptcp-cmason-fixes-v3-0-416c0920c73f%40kernel.org
