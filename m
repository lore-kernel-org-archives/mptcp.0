Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593144;
	b=x+ozO4zjar1zEpGJZ1X4qw54CyrNy0CiKXj8tz8wtBgp2ia9NtiRSF6542KZHXesBPix
	 qjLF18mvsOjtD+ZSwwYGuGWW1MOV/vAaZW8SV8VuBmMeDiv5l2e8gYZJrXDc5QcwxRtQN
	 EfEnmHV8XH88SCY6pVkciHrFVdKMXm+QWyG6wDlWn3dTaVdiTBP/Sug//oZIh5u7ZRTic
	 Nv1LgWJZ79dbfOA8JaoKMmWY+tRe/k8UMHTqHOn9+YKJtMWDwIFBFK3xO03sGVsbTgal0
	 hAWXmoXKvat5oNVfqEesc3ufDQwBBLp8zWogokct++p4CDG3aYavMks05k9HT6HhfhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593144;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Xb9O22UuqC/WH/4N7PGtSFu13F6HMUaYYsSB+K7ZQ7A=;
	b=o6xm3pDty3YQ3PU+ez7iVIUZ8Rkwy7C+b7SwpUSQoPaaulDpVd0BEA/06fQTSTGENP4T
	 wxCj6QXdLmq1qXtRTV4cV75UHqYlDQcWjfusjv/TfeTgCcM9yJV8iIXFSXLQU4E4Eq9te
	 fDL8jvQC8nzIOZuxXpfhZp3fwIzTcUvY8v2n0L9zJnPJv6WXTtRb37exeODuUO7SAn8iB
	 1vH0tpJbmWFZwXIb7R5gzt6npoIkOXmxYD3HPjqG3RxR+bST5t9E5zjBFbFEV3QTHn2UD
	 EdAd3EdZkEKH20fWeSbNB//xwxabMw1/jp8PnBWDBlMRWv1BkVC6wczvb5j3Xo9mcfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XI7+cgKT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4AD606A31E
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XI7+cgKT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06C81F000CF;
	Wed, 25 Nov 2026 07:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795593143;
	bh=Xb9O22UuqC/WH/4N7PGtSFu13F6HMUaYYsSB+K7ZQ7A=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XI7+cgKTd6tFUeuPSAIYJjYtTQ9reF9Xq6eMe2CdBDEXxd1/2xCNgq5aJlU6ZqVzz
	 EmxQlFMdEdSB85GLglLzv/kZSsmR8tsByuRWNOp7ZSA9H2iuniMGNcV27JVdFDgE9O
	 KNWWraLk8bBYcveMqTvWbqkwFlajF4IONtU5Ig+T3rq6r+lP+VKvuVD9oYXkM0lHu/
	 LbTz0ikwMLuyA245PeU8R/fHJG4+fyhi9EmaXoL0LywEHjKVFqYuowfFUyS9WlWKjP
	 Dg2+bJj8JlNRJKp9A1YNSN0YoxWRDmCzyOw0LyOeGhBnhigvsCXyLTYObLRekHVoLf
	 vbOGTMrnbDXKA==
Message-ID: <sashiko-outbox-232845@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v9 3/7] mptcp: add MSG_ZEROCOPY support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <fef46d879cfe64c34ee1d792a5fd5713981f9ea4.1795591278.git.tanggeliang@kylinos.cn>
References: <cover.1795591278.git.tanggeliang@kylinos.cn>
 <fef46d879cfe64c34ee1d792a5fd5713981f9ea4.1795591278.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 07:52:22 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] mptcp: corrupted copy length and wmem accounting in
  mptcp_sendmsg_frag()
- [Medium] mptcp: missing zerocopy downgrade on fastopen in
  mptcp_sendmsg()
- [Low] mptcp: dead !ubuf check before net_zcopy_get() in
  mptcp_sendmsg_zerocopy_iter()
--

commit 5139e983df0c81d1f761fa0ac9e35eeb08cfa459
Author: Geliang Tang <geliang@kernel.org>

mptcp: add MSG_ZEROCOPY support

This commit adds MSG_ZEROCOPY support for MPTCP sockets by pinning user
pages into mptcp_data_frag structures and tracking completion across
both the MPTCP retransmission queue and subflow skbs via ubuf_info_msgzc.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 504d0b196d84b..6bd10a4e1e938 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -1531,7 +1552,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, stru=
ct sock *ssk,
> =20
>  	/* like TCP, allow some progress up to tcp_wmem[0] */
>  	avail =3D tcp_wmem_schedule(ssk, copy);
> -	if (avail <=3D 0) {
> +	if (!dfrag->ubuf && avail <=3D 0) {
>  		tcp_remove_empty_skb(ssk);
>  		return -ENOMEM;
>  	}
> @@ -1542,13 +1563,19 @@ static int mptcp_sendmsg_frag(struct sock *sk, st=
ruct sock *ssk,
>  	} else {
>  		get_page(dfrag->page);
>  		skb_fill_page_desc(skb, i, dfrag->page, offset, copy);
> +
> +		if (dfrag->ubuf && !skb_zcopy(skb)) {
> +			skb_zcopy_set(skb, dfrag->ubuf, NULL);
> +			skb_shinfo(skb)->flags |=3D SKBFL_PURE_ZEROCOPY;
> +		}
>  	}
> =20
>  	skb->len +=3D copy;
>  	skb->data_len +=3D copy;
>  	skb->truesize +=3D copy;
>  	sk_wmem_queued_add(ssk, copy);
> -	sk_mem_charge(ssk, copy);
> +	if (!skb_zcopy_pure(skb))
> +		sk_mem_charge(ssk, copy);
>  	WRITE_ONCE(tp->write_seq, tp->write_seq + copy);
>  	TCP_SKB_CB(skb)->end_seq +=3D copy;
>  	tcp_skb_pcount_set(skb, 0);

[Severity: High]
Should tcp_wmem_schedule(ssk, copy) and copy =3D avail be skipped entirely
when dfrag->ubuf is non-NULL, matching tcp_sendmsg_locked()?

Right now tcp_wmem_schedule(ssk, copy) and copy =3D avail still run for
zerocopy dfrags while only the avail <=3D 0 error return and
sk_mem_charge(ssk, copy) are skipped.  When tcp_wmem_schedule() succeeds,
it raises ssk->sk_forward_alloc without a matching sk_mem_charge() or
payload uncharge in tcp_wmem_free_skb().  When ssk hits write memory
pressure and tcp_wmem_schedule() returns avail =3D=3D 0 (or avail < 0 if
ssk->sk_forward_alloc is negative), copy is overwritten with 0 (or wraps
to a large size_t), leaving an empty 0-length skb on ssk->sk_write_queue
that stalls tcp_write_xmit() or corrupting the skb lengths and sequence
numbers.

[ ... ]

> @@ -2048,27 +2076,113 @@ static void mptcp_rps_record_subflows(const stru=
ct mptcp_sock *msk)
>  	}
>  }
> =20
> +static ssize_t mptcp_sendmsg_zerocopy_iter(struct sock *sk, struct msghd=
r *msg,
> +					   struct ubuf_info *ubuf,
> +					   u32 copy_limit)
> +{
[ ... ]
> +	dfrag =3D kzalloc_obj(*dfrag, GFP_KERNEL_ACCOUNT);
> +	if (!dfrag) {
> +		iov_iter_revert(&msg->msg_iter, pg_len);
> +		put_page(pages[0]);
> +		return -ENOMEM;
> +	}
> +
> +	if (!ubuf && !sk_wmem_schedule(sk, pg_len + sizeof(*dfrag))) {
> +		kfree(dfrag);
> +		iov_iter_revert(&msg->msg_iter, pg_len);
> +		put_page(pages[0]);
> +		return -EAGAIN;
> +	}
> +
> +	dfrag->data_len =3D pg_len;
> +	dfrag->data_seq =3D msk->write_seq;
> +	dfrag->offset =3D pg_off;
> +	dfrag->page =3D pages[0];
> +	dfrag->ubuf =3D ubuf;
> +	dfrag->overhead =3D sizeof(struct mptcp_data_frag);
> +
> +	/* one ref for the dfrag; released in dfrag_clear */
> +	net_zcopy_get(ubuf);

[Severity: Low]
Is the !ubuf check in mptcp_sendmsg_zerocopy_iter() dead code?
mptcp_sendmsg() only calls this helper when zc is true (so ubuf is
non-NULL), and net_zcopy_get(ubuf) unconditionally dereferences ubuf a
few lines below.

> +
> +	WRITE_ONCE(msk->write_seq, msk->write_seq + pg_len);
> +	sk_wmem_queued_add(sk, PAGE_SIZE + dfrag->overhead);
> +
> +	list_add_tail(&dfrag->list, &msk->rtx_queue);
> +	if (!msk->first_pending)
> +		msk->first_pending =3D dfrag;
> +
> +	return pg_len;
> +}
> +
>  static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	struct ubuf_info *ubuf =3D NULL;
>  	struct page_frag *pfrag;
>  	size_t copied =3D 0;
> +	bool zc =3D false;
>  	int ret =3D 0;
>  	long timeo;
> =20
>  	/* silently ignore everything else */
>  	msg->msg_flags &=3D MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
> -			  MSG_FASTOPEN | MSG_EOR;
> +			  MSG_FASTOPEN | MSG_EOR | MSG_ZEROCOPY;
> =20
>  	lock_sock(sk);
> =20
>  	mptcp_rps_record_subflows(msk);
> =20
> +	if (!sock_flag(sk, SOCK_ZEROCOPY))
> +		msg->msg_flags &=3D ~MSG_ZEROCOPY;
> +
> +	if ((msg->msg_flags & MSG_ZEROCOPY) && len) {
> +		ubuf =3D msg_zerocopy_realloc(sk, len, NULL, false);
> +		if (!ubuf) {
> +			ret =3D -ENOBUFS;
> +			goto do_error;
> +		}
> +		zc =3D true;
> +	}
> +
>  	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
>  		     msg->msg_flags & MSG_FASTOPEN)) {
>  		int copied_syn =3D 0;
> =20
> -		ret =3D mptcp_sendmsg_fastopen(sk, msg, len, &copied_syn);
> +		ret =3D mptcp_sendmsg_fastopen(sk, msg, len, &copied_syn, ubuf);

[Severity: Medium]
Does the fastopen path miss downgrading ubuf and zc to regular copy?

The commit message notes that MSG_ZEROCOPY silently downgrades to regular
copy when MSG_FASTOPEN is set, and tcp_send_syn_data() copies the SYN
payload into a kernel page_frag via copy_page_from_iter() before calling
skb_zcopy_set(syn_data, fo->uarg, NULL).  However, msg_zerocopy_realloc()
initializes uarg_to_msgzc(ubuf)->zerocopy =3D 1 and mptcp_sendmsg() sets
zc =3D true before entering the DEFER_CONNECT / MSG_FASTOPEN branch.
Without clearing uarg_to_msgzc(ubuf)->zerocopy =3D 0 and zc =3D false here,
completion notifications for the copied SYN data will omit
SO_EE_CODE_ZEROCOPY_COPIED, and any remaining bytes after
mptcp_sendmsg_fastopen() will still take the mptcp_sendmsg_zerocopy_iter()
path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795591278.gi=
t.tanggeliang@kylinos.cn?part=3D3
