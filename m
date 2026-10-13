Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96F73DEFF3
	for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884138; cv=none; b=p/p8fHxm/gtvLkUKXIxLOJyCIc3gj9LQ64SPrKc94VhELYLuNnhXoibEvaximOHKeOL9yWP4T/bPaD69ztGo8Z3205TMrAW2m/cUtI5pHZMFL4oaNw3q/9rUXUnUnDX5QkCxk8LC3Xpz8jTKsiWILRpm94MiucwUPibChfunjZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884138; c=relaxed/simple;
	bh=uLJ6BPXPCfGHApan3qQoluoOnw9ypsguc5L0VRuuLGo=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=mHHjMfdiOD0RqotO1dFdyRfQxB1zAfp+Q35VVHTmxV3anNaAh52JE97y0YvwSdQnSGVrCGglp9AbpRNZ/BvpPdc3a0hAyFFh5Z4KqiGeNuMTE+F3TvqsYCJk8K1QqWrUxvWOF/nEH16UoQgnFfk8NyhxcfIks8hpWhBZUZY2d5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZN9K53qO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZN9K53qO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473E91F000FF;
	Tue, 13 Oct 2026 09:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791884137;
	bh=TFf2DHDDnJmO+egLz/QJN1R2kuV6z1uu7j/xWF+3Hgc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ZN9K53qOj0OQT2knrBRCJDoHn0CXZWL8UgFkDCaAZ9ZZrCkZ2pidj5NIYA5o/OpR9
	 bEg7uqs5SfTYv8WVq/m/BZ7xskd1eCoA19vw/gnL8/TT7lDJgfiCka/+LNdzYsVLhi
	 w1Z6ny4TXDlbz/aHDYbiF7q3tXYxYZdanjUlxmdgygUZr22h7Af5ScFzQRICmnBIgg
	 LTQwjIy7LitBu5ig0TGmDfoKtBtaiMY13BUFQxrwCnSMmXcFogztNQ+3hQftJr0m8N
	 3EYzqmi4Ilnl3CTZrkC1OlQWqjMve41O4cYBXX0HbDWE+RY+iGlH+3aRn4GAiy2Fco
	 kyBoIvbJ0VBbQ==
Message-ID: <sashiko-outbox-169354@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next] mptcp: add MPTCP_MIB_RCVINVALIDOPT counter
 for invalid options
Reply-To: sashiko-reviews@lists.linux.dev
To: "T S Rameshkumar" <rameshsv06@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261013085604.115478-1-rameshkumar.t@phytecembedded.in>
References: <20261013085604.115478-1-rameshkumar.t@phytecembedded.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 09:35:36 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mptcp: missed MIB increment for backlog packets due to mptcp_skb=
_net()
--

commit 69466d93fa353450c6162f23ad6457846e513a9d
Author: T S Rameshkumar <rameshsv06@gmail.com>

mptcp: add MPTCP_MIB_RCVINVALIDOPT counter for invalid options

This commit introduces the MPTCP_MIB_RCVINVALIDOPT counter to track invalid
MPTCP options encountered during parsing. To perform the increment, it atte=
mpts
to resolve the net pointer from the socket buffer in mptcp_skb_net() by
checking skb->sk, skb->dev, and skb_dst.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/628

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index adbf8e0773dbb..a1af2acfa791b 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c

[ ... ]

> @@ -419,13 +422,28 @@ static void mptcp_parse_option(const struct sk_buff=
 *skb,
>  		break;
> =20
>  	default:
> +bad_opt:
> +		if (net)
> +			MPTCP_INC_STATS(net, MPTCP_MIB_RCVINVALIDOPT);
>  		break;
>  	}
>  }
> =20
> +static inline struct net *mptcp_skb_net(const struct sk_buff *skb)
> +{
> +	if (skb->sk)
> +		return sock_net(skb->sk);
> +	if (skb->dev)
> +		return dev_net_rcu(skb->dev);
> +	if (skb_dst(skb) && skb_dst_dev_rcu(skb))
> +		return skb_dst_dev_net_rcu(skb);
> +	return NULL;
> +}

[Severity: Medium]
For TCP packets processed from the socket backlog queue, is it possible for
mptcp_skb_net() to always return NULL?

When a packet is processed from the backlog (e.g. via tcp_v4_do_rcv()),
skb->dev is cleared unconditionally, skb_dst is dropped, and skb->sk is not
yet set for incoming packets.

Because all three pointers are NULL, the function will return NULL. This wi=
ll
cause the MIB increment at the bad_opt label to be silently skipped for any
malformed options present in backlog packets.

Since the callers of mptcp_get_options() generally have access to the relev=
ant
socket, could they pass the known net or sk directly instead of deriving it
from the skb?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013085604.1154=
78-1-rameshkumar.t@phytecembedded.in?part=3D1
