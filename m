Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795423605;
	b=Wp0k0VImj/J+DaVY77MA2tzBkydtsB2VNo0mKVW9Bt0Ezws7HPjiBVjN8DcGhH0ADRSR
	 RvCCfVQIA6c9fu8GgmZg4a/0sTuAJg/YRzqRq3HwpQZRVDP65+fzAwwplaN8+QdZVKNST
	 Afv+K3JSH1xF1mLLkXXHyzBTMX0gKtojIwid3B0SFMR/+g9iqxqwGJ9vssXo0LxTe2ug7
	 MVauFLv6tp/uueChLKr5Ko711J+k+fMvdaJNsIF/7ZvrEWK43BmQqL+gQr///4X3srNTP
	 VjkJjMjFOHoJGYmjOCQLU4NBr7cfKR14NaGS26uValhVaQqk1+8PfvFjiqe6AM07yCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423605;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ubDtjEZ2KQBuK/eWXuSlRLImUDucHugez+BTOkcblEI=;
	b=vP9MKWRy1u0h2/pxg9zeaDqFuuAJEKCNzQ0AorYgSDqnUXP2ih7oNYeY3F3k7w6fF5rv
	 zAJXkgdBB4u8z90BjJ2TDHrET4EIDbaGvuUmaaIRqk+jFQU768De0B5C5anLkD76lS230
	 gE0bdAokDOD2u/fvnzVZtGlBrnpi7Xta2h/rIydp/WdbsfgUJbHLOfw64h0m+Ztot9fDK
	 +wKGojRcr7Gm+UqT/hgjWKT5qbXCaSJJsXVpPTmRv49/4Vvb2nlhYXS0ahwZfihQYv67U
	 Z0v8r9xU2MdPMTBa4tm8audNl8PPhlzq1QmigCUSo/Ied4qVytqykbYsLXT9O27mCLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gw1ns0qB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E51D606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gw1ns0qB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3853A1F000C0;
	Mon, 23 Nov 2026 08:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795423605;
	bh=ubDtjEZ2KQBuK/eWXuSlRLImUDucHugez+BTOkcblEI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Gw1ns0qBQ5LLpHvYVSU5cKOvgyNQc63rbMs/QIpDq39YLWwVkny2p+0tOK75hDAIC
	 vZIkIP11XthwWiPmwcGbZ6WIpKHnb4ZesvfAmeEOtVOCdHfxuXkcv01lkyglO7u4mr
	 cPGHgbFRvGQhKPN1bW/bjITLTRyvjmO0boE626oJG806WXpP8eAf3ooIu8EulbDV8/
	 lOT5gDOrKdrHU0Sc+oWiWh8TkjIdXkFANGMV/zwyYHI8txufeK+o6BTw4Ck35qfgFm
	 445YbWTAegS27waEVmRpB5GzF5zFiWTfUEQ0oVD5aV6gtwtGOoipt4rres/mEsQH6q
	 nVRQuYthkbujQ==
Message-ID: <sashiko-outbox-228911@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v8 4/7] mptcp: add MSG_ZEROCOPY support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <3f30ee2209176e73f716ad379bb6385145b05fa8.1795421388.git.tanggeliang@kylinos.cn>
References: <cover.1795421388.git.tanggeliang@kylinos.cn>
 <3f30ee2209176e73f716ad379bb6385145b05fa8.1795421388.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 08:46:44 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] mptcp: off-by-one U16_MAX check in
  mptcp_sendmsg_zerocopy_iter()
- [Medium] mptcp: unbalanced sk_wmem_schedule() in
  mptcp_sendmsg_zerocopy_iter()
- [Medium] mptcp: missing DEFER_CONNECT check for MSG_ZEROCOPY in
  mptcp_sendmsg()
- [Medium] mptcp: missing zerocopy notification on copy fallback in
  mptcp_sendmsg()
--

commit 6f18d9c0894cba580b4859b23fbe02de7c4fe368
Author: Geliang Tang <geliang@kernel.org>

mptcp: add MSG_ZEROCOPY support

This commit adds MSG_ZEROCOPY support to MPTCP sockets by pinning user pages
into mptcp_data_frag entries and tracking completion across both the MPTCP
retransmission queue and subflow skbs.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 84848cb0a5e9c..9cd3e12d5546c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1186,9 +1186,11 @@ static bool mptcp_frag_can_collapse_to(const struc=
t mptcp_sock *msk,
>  		df->data_seq + df->data_len =3D=3D msk->write_seq;
>  }
> =20
> -static void dfrag_uncharge(struct sock *sk, int len)
> +static void dfrag_uncharge(struct sock *sk, int len,
> +			   struct mptcp_data_frag *dfrag)
>  {
> -	sk_mem_uncharge(sk, len);
> +	if (!dfrag->ubuf)
> +		sk_mem_uncharge(sk, len);
>  	sk_wmem_queued_add(sk, -len);
>  }

[ ... ]

> @@ -2040,22 +2065,110 @@ static void mptcp_rps_record_subflows(const stru=
ct mptcp_sock *msk)
>  	}
>  }
> =20
> +static ssize_t mptcp_sendmsg_zerocopy_iter(struct sock *sk, struct msghd=
r *msg,
> +					   struct ubuf_info *ubuf,
> +					   u32 copy_limit)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	struct mptcp_data_frag *dfrag;
> +	struct page *pages[1] =3D {};
> +	size_t pg_off =3D 0;
> +	ssize_t pg_len;
> +
> +	pg_len =3D iov_iter_get_pages2(&msg->msg_iter, pages,
> +				     copy_limit, 1, &pg_off);
> +	if (pg_len < 0)
> +		return pg_len;
> +	/* pg_len =3D=3D 0 means the iterator is exhausted */
> +	if (pg_len =3D=3D 0)
> +		return -EFAULT;
> +
> +	if (pg_len > U16_MAX) {
> +		iov_iter_revert(&msg->msg_iter, pg_len - U16_MAX);
> +		pg_len =3D U16_MAX;
> +	}
> +
> +	if (pg_off > U16_MAX) {
> +		iov_iter_revert(&msg->msg_iter, pg_len);
> +		put_page(pages[0]);
> +		return -EFAULT;
> +	}
> +
> +	if (pg_off + pg_len > U16_MAX) {
> +		size_t len =3D U16_MAX - pg_off;
> +
> +		iov_iter_revert(&msg->msg_iter, pg_len - len);
> +		pg_len =3D len;
> +		if (WARN_ON_ONCE(!pg_len)) {
> +			put_page(pages[0]);
> +			return -EFAULT;
> +		}
> +	}

[Severity: High]
Does pg_off + pg_len > U16_MAX trigger WARN_ON_ONCE(!pg_len) and return
-EFAULT whenever pg_off reaches U16_MAX on a kernel with PAGE_SIZE >=3D 64 =
KiB?

On a 64 KiB page kernel, sending a 64 KiB page-aligned buffer caps the first
dfrag at U16_MAX (65535) bytes and leaves msg->msg_iter at page offset 65535
with 1 byte left.  On the next iteration, pg_off is U16_MAX, so pg_off >
U16_MAX is false and len =3D U16_MAX - pg_off is 0.

Since dfrag->offset and dfrag->data_len are u16 and partial-ACK advancement=
 in
__mptcp_clean_una() only adds delta < dfrag->data_len, capping pg_off + pg_=
len
at U16_MAX + 1 avoids overflowing either field while allowing the final byte
at offset 65535.

> +
> +	dfrag =3D kzalloc_obj(*dfrag, GFP_KERNEL_ACCOUNT);
> +	if (!dfrag) {
> +		iov_iter_revert(&msg->msg_iter, pg_len);
> +		put_page(pages[0]);
> +		return -ENOMEM;
> +	}
> +
> +	if (!sk_wmem_schedule(sk, pg_len + sizeof(*dfrag))) {
> +		kfree(dfrag);
> +		iov_iter_revert(&msg->msg_iter, pg_len);
> +		put_page(pages[0]);
> +		return -EAGAIN;
> +	}

[Severity: Medium]
Should mptcp_sendmsg_zerocopy_iter() skip sk_wmem_schedule() here, the same
way mptcp_sendmsg_frag() skips it for zerocopy dfrags?

Calling sk_wmem_schedule(sk, pg_len + sizeof(*dfrag)) raises
sk->sk_forward_alloc and charges protocol memory, but this path never deduc=
ts
it with sk_mem_charge() or sk_forward_alloc_add(), and dfrag_uncharge() ski=
ps
sk_mem_uncharge() when dfrag->ubuf is set.  The forward-allocated pages stay
pinned on sk until the socket closes, and zerocopy sends can fail with -EAG=
AIN
under socket memory pressure even though zerocopy pages bypass socket memory
accounting.

[ ... ]

> @@ -2062,15 +2175,27 @@ static int mptcp_sendmsg(struct sock *sk, struct =
msghdr *msg, size_t len)
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
> +	if (msg->msg_flags & MSG_FASTOPEN || !sock_flag(sk, SOCK_ZEROCOPY))
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

[Severity: Medium]
Does the MSG_ZEROCOPY downgrade check also need to test
inet_test_bit(DEFER_CONNECT, sk)?

When TCP_FASTOPEN_CONNECT sets DEFER_CONNECT and sendmsg() is called with
MSG_ZEROCOPY (without MSG_FASTOPEN), mptcp_sendmsg() allocates ubuf and then
enters mptcp_sendmsg_fastopen(), which passes NULL for uarg to
tcp_sendmsg_fastopen():

net/mptcp/protocol.c:mptcp_sendmsg_fastopen() {
    ...
	ret =3D tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
    ...
}

The SYN payload is copied without taking a reference on ubuf or clearing
ubuf->zerocopy, so when mptcp_sendmsg() jumps to out: and calls
net_zcopy_put(ubuf), it immediately queues a zerocopy completion notificati=
on
while the SYN data is still in flight.

[ ... ]

> @@ -2094,6 +2207,25 @@ static int mptcp_sendmsg(struct sock *sk, struct m=
sghdr *msg, size_t len)
>  		if (!copy_limit)
>  			goto wait_for_memory;
> =20
> +		if (zc) {
> +			ret =3D mptcp_sendmsg_zerocopy_iter(sk, msg, ubuf,
> +							  copy_limit);
> +			if (ret =3D=3D -EAGAIN || ret =3D=3D -ENOMEM)
> +				goto wait_for_memory;
> +			if (ret =3D=3D -EFAULT) {
> +				if (copied)
> +					goto do_error;
> +				net_zcopy_put_abort(ubuf, true);
> +				zc =3D false;
> +				ubuf =3D NULL;

[Severity: Medium]
Does calling net_zcopy_put_abort() before falling back to the regular copy
path suppress the required MSG_ZEROCOPY completion notification when the co=
py
succeeds?

net_zcopy_put_abort() decrements sk->sk_zckey and zeroes uarg->len, so when
the loop falls through to do_copy_data_nocache() and returns a positive byte
count, no SO_EE_ORIGIN_ZEROCOPY notification (with SO_EE_CODE_ZEROCOPY_COPI=
ED)
is queued on sk->sk_error_queue.  Applications waiting for a completion per
successful MSG_ZEROCOPY sendmsg() call will lose track of sk_zckey or hang =
on
MSG_ERRQUEUE.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795421388.gi=
t.tanggeliang@kylinos.cn?part=3D4
