Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A237325228C
	for <mptcp@lists.linux.dev>; Fri, 21 Aug 2026 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787297394; cv=none; b=kyKISVV1qyFwqhwebh7iIwylR3ERIoeDmDQ4doc24sZg/YXUVwSy/kiwRsTosGLZdl1Yn+TCO4+JSML9v9c7AwIituDnsX4KbGFu8bPxKtUK29GhLXkTJVf7//ZvAEkH6sXjKWYPSBytSMAC5GqS0RYgn6prWgOLYNf9yMiZCvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787297394; c=relaxed/simple;
	bh=XwvT+MMklBMX0/A+hxvOCiLGbWRF1ruKJWhEKNUctMU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O1ztcxv4Ada6Hb/PEp4U2ih5PnovwSubtW3q/zxv7XXRcDEQ0BMCKiA5m6DZwJpxnPssLRaP5Kl3KlppAeIRTA4YcuwM4D1KcUllxNm6QnbI0vBJMEdOR+ITXuMoUc9ffLCjd3FiSShRHdFNO0CH9Ntu9FyUlNNftOohZyRKMWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuPD/Fxx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuPD/Fxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194491F000E9;
	Fri, 21 Aug 2026 07:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787297393;
	bh=FpKFOaXEKKEa0HfOM8adpRGrP3QvZLx/Hfao0jvvDh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MuPD/FxxWBJQR+G2gxfAGeeLIEJZgP/oKb9RY/zApeZvB6QKA3js9mVm8sV1apvvv
	 mYOHgx/JxEqP0ccQhxsGBmBo1etNuyPhmD98LAasWLTeqD0KT398YhNn6SLu375O4C
	 YzpdA6xCGn1wAfgpk9UvFEleHxaaZuwK3rS2A+m9N7K5YJtLhM5Z118UpPGXkLYa8m
	 y80535mnynKeM8cT1WEQmfL677ZGn4CttC6Cq4vJHeJOvwvpKPuI3GGRDzXRgEN+LW
	 zNDc08jCvE/vQJ9FdLojVlOPPyktaZKHu0q0EQknwS97w/gSrhNGh1A5aH+SAXBoa8
	 OtG5+OasYlA+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v4 3/7] mptcp: remove CB offset field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <45ccd44f150d170dc2d0e11ff5350659fdd926a0.1787295147.git.tanggeliang@kylinos.cn>
References: <cover.1787295147.git.tanggeliang@kylinos.cn>
 <45ccd44f150d170dc2d0e11ff5350659fdd926a0.1787295147.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 07:29:52 +0000
Message-Id: <20260821072953.194491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] MSG_PEEK uses a stale peek_seq after msk->copied_seq is resynced, =
causing it to skip newly received data and stall indefinitely.
- [High] In MPTCP active fallback scenarios, msk->copied_seq is never synch=
ronized to the IASN, causing recvmsg to silently skip all received data.
--

--- Patch [3]: [PATCH mptcp-next v4 3/7] mptcp: remove CB offset field ---
commit 05518f1ca85e68c8cc86ae9b67a0c4d849dfd066
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: remove CB offset field

This commit removes the CB offset field and introduces a new msk-level
copied_seq field to track bytes already consumed inside each skb.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7944ee0f93b13..d52b1773fbb6b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -2199,33 +2192,24 @@ static void mptcp_eat_recv_skb(struct sock *sk, s=
truct sk_buff *skb)
>  }
> =20
>  static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
> -				size_t len, int flags, int copied_total,
> +				size_t len, int flags, u64 *seq,
>  				struct scm_timestamping_internal *tss,
>  				int *cmsg_flags, struct sk_buff **last)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>  	struct sk_buff *skb, *tmp;
> -	int total_data_len =3D 0;
>  	int copied =3D 0;
> =20
>  	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
> -		u32 delta, offset =3D MPTCP_SKB_CB(skb)->offset;
> +		u64 offset =3D *seq - MPTCP_SKB_CB(skb)->map_seq;
>  		u32 data_len =3D skb->len - offset;
>  		u32 count;
>  		int err;
> =20
> -		if (flags & MSG_PEEK) {
> -			/* skip already peeked skbs */
> -			if (total_data_len + data_len <=3D copied_total) {
> -				total_data_len +=3D data_len;
> -				*last =3D skb;
> -				continue;
> -			}
> -
> -			/* skip the already peeked data in the current skb */
> -			delta =3D copied_total - total_data_len;
> -			offset +=3D delta;
> -			data_len -=3D delta;
> +		/* Skip the already peeked data. */
> +		if (offset >=3D skb->len) {
> +			*last =3D skb;
> +			continue;
> +		}

[Severity: High]
During an active connection fallback, could this offset calculation underfl=
ow?

If the server replies with a SYN-ACK lacking MPTCP options, msk->copied_seq
remains 0 because MPTCP_SYNC_SEQ is bypassed during fallback. When
__mptcp_recvmsg_mskq() processes the fallback SKBs, *seq is 0 but map_seq is
set to the initial ack sequence number.

Does this subtraction underflow to a large positive value, causing
offset >=3D skb->len to evaluate to true and silently skip all valid
payload data?

[ ... ]
> @@ -2449,6 +2430,11 @@ static int mptcp_recvmsg(struct sock *sk, struct m=
sghdr *msg, size_t len,
> =20
>  	len =3D min_t(size_t, len, INT_MAX);
>  	target =3D sock_rcvlowat(sk, flags & MSG_WAITALL, len);
> +	seq =3D &msk->copied_seq;
> +	if (flags & MSG_PEEK) {
> +		peek_seq =3D msk->copied_seq;
> +		seq =3D &peek_seq;
> +	}
> =20
>  	if (unlikely(msk->recvmsg_inq))
>  		cmsg_flags =3D MPTCP_CMSG_INQ;
> @@ -2458,7 +2444,7 @@ static int mptcp_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
>  		int err, bytes_read;
> =20
>  		bytes_read =3D __mptcp_recvmsg_mskq(sk, msg, len - copied, flags,
> -						  copied, &tss, &cmsg_flags,
> +						  seq, &tss, &cmsg_flags,
>  						  &last);
>  		if (unlikely(bytes_read < 0)) {
>  			if (!copied)
> @@ -2468,6 +2454,10 @@ static int mptcp_recvmsg(struct sock *sk, struct m=
sghdr *msg, size_t len,
> =20
>  		copied +=3D bytes_read;
> =20
> +		/* Recompute peek offset after eventual seq resync. */
> +		if (flags & MSG_PEEK)
> +			peek_seq =3D msk->copied_seq + copied;
> +
>  		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk))
>  			continue;

[Severity: High]
When MSG_PEEK is used, could peek_seq become stale if the backlog
synchronizes the sequence?

If mptcp_move_skbs() processes the backlog and adds the initial ack sequence
number to msk->copied_seq via MPTCP_SYNC_SEQ, the loop executes a continue.

Since peek_seq was updated before mptcp_move_skbs() was called, it lacks the
new offset. On the next iteration, will calling __mptcp_recvmsg_mskq() with
this stale *seq value cause the offset calculation to underflow, skipping
the newly received data and stalling the receiver indefinitely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787295147.gi=
t.tanggeliang@kylinos.cn?part=3D3
