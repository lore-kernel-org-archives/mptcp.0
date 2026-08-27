Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A904457C6
	for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787829327; cv=none; b=B1zNUzg6ccx5kYICd1gw1f+JXkabnUAJwt0BW9s2RycgzmmgiLbCNGNjp51wr1gB+jl48cXx/Qo+HwQLXhzqsdEH7gY92VSx61NE8tb1vyTsYJaVbtg3n902BOJYfRGMkW+PWaCgVbhuQ7EddO8YMvkueyYG29N8p4GEie3PHz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787829327; c=relaxed/simple;
	bh=5BEQYEa1UrFHpAkntLIPuWKmiKHBoVJRepDajrR7sCI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s2EPho+UpVhi5zmOvdKWfRLlZuiegaHZkmudenJiYE84oCTf42VGIvL0zcDG7TA8SsD+hfthkQxxY8RxwWbjzjeQlRHz0tHdHATjeC4wnmbIPBw4lI1ZuYmqDmV68tVt53as2hKYbNaQIulaY30a8GILMjzogZZLYRd7pa/GBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OI2yzX1v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OI2yzX1v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDE61F000E9;
	Thu, 27 Aug 2026 11:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787829323;
	bh=avT9xjAMoqvdMGpRulo9KSDftakrDXsS/7mTiGf/cuY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OI2yzX1vHiw1I9b2FNOFA6/gzscJFHKRONDIj+RVZXSN3JNg33bFrK/E6c95gF96M
	 159vye91yEp7O88d0/u/HwZAf3ucLPQYwgyUnR+50aAvkVmGrIyeOQtmDe3vkrD7Ec
	 gOSQEAfU1t9vcfcpBuK2IdpPdwVtFLBnLWj8QkQ/cvyuX/+VWw7zQ3KsDrulMLd+jp
	 LruCgOjIiFk5ZWftWPcofiw6aKe97rRkai+inU0NJlAnAqe6wBiMOHSk4m5F/aX7+v
	 2yu9jP4wLOcsgA1Z90+ceWGnY938KBqAjWfEXQgy2TwbkucAXql4O/kcOAOdAF7Iy+
	 x45lUzwermRoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v9 01/11] mptcp: use atomic64_t for
 locklessly accessed u64 fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <dc178617946d445a9ec95a3f0a92d1a66a78d9f0.1787827525.git.tanggeliang@kylinos.cn>
References: <cover.1787827525.git.tanggeliang@kylinos.cn>
 <dc178617946d445a9ec95a3f0a92d1a66a78d9f0.1787827525.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 11:15:23 +0000
Message-Id: <20260827111523.6FDE61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch misses converting the `rcv_data_fin_seq` field to `atomi=
c64_t`.
--

commit 964553db62216cd000671e7e1848df8e7c8c6a5d
Author: Geliang Tang <geliang@kernel.org>
Date:   Thu Aug 27 10:57:25 2026 +0000

    mptcp: use atomic64_t for locklessly accessed u64 fields
   =20
    This commit converts several u64 fields in struct mptcp_sock to atomic6=
4_t
    to prevent torn reads and writes on 32-bit architectures. It also caches
    the read values in local variables to avoid inconsistent repeated reads.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index f87707110c752..b33bf445c0ba5 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
[ ... ]
> @@ -1169,7 +1170,8 @@ bool mptcp_update_rcv_data_fin(struct mptcp_sock *m=
sk, u64 data_fin_seq, bool us
>  		return false;
> =20
>  	WRITE_ONCE(msk->rcv_data_fin_seq,
> -		   mptcp_expand_seq(READ_ONCE(msk->ack_seq), data_fin_seq, use_64bit));
> +		   mptcp_expand_seq(atomic64_read(&msk->ack_seq),
> +				    data_fin_seq, use_64bit));

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for
msk->rcv_data_fin_seq to suffer from a torn write here?

In mptcp_update_rcv_data_fin(), msk->rcv_data_fin_seq is written locklessly.
On 32-bit architectures, this WRITE_ONCE() compiles to two 32-bit stores.

If a remote peer sends DATA_FIN packets with different sequence numbers on =
two
subflows simultaneously, the two softirqs could concurrently write to
msk->rcv_data_fin_seq, interleaving their 32-bit stores and corrupting the
64-bit sequence number.

>  	WRITE_ONCE(msk->rcv_data_fin, 1);
> =20
>  	return true;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f22d64ab1c53b..26b49480941c6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -569,7 +571,7 @@ static bool mptcp_pending_data_fin(struct sock *sk, u=
64 *seq)
>  	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
>  		u64 rcv_data_fin_seq =3D READ_ONCE(msk->rcv_data_fin_seq);
> =20
> -		if (READ_ONCE(msk->ack_seq) =3D=3D rcv_data_fin_seq) {
> +		if (atomic64_read(&msk->ack_seq) =3D=3D rcv_data_fin_seq) {
>  			if (seq)
>  				*seq =3D rcv_data_fin_seq;

[Severity: High]
This is a pre-existing issue, but does this lockless read in
mptcp_pending_data_fin() risk reading a torn value?

If msk->rcv_data_fin_seq is corrupted due to the torn write described above,
the MPTCP connection would never match the corrupted sequence number here a=
nd
might fail to close, resulting in a connection hang and resource leak.

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 3d250e8204d52..29405d045291d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
[ ... ]
> @@ -288,15 +288,15 @@ struct mptcp_sock {
>  						 * lockless access read
>  						 */
>  	u64		remote_key;		/* same as above */
> -	u64		write_seq;
> +	atomic64_t	write_seq;
>  	u64		bytes_sent;
> -	u64		snd_nxt;
> -	u64		bytes_received;
> -	u64		ack_seq;
> +	atomic64_t	snd_nxt;
> +	atomic64_t	bytes_received;
> +	atomic64_t	ack_seq;
>  	atomic64_t	rcv_wnd_sent;
>  	u64		rcv_data_fin_seq;
>  	u64		bytes_retrans;
> -	u64		bytes_consumed;
> +	atomic64_t	bytes_consumed;

[Severity: High]
This isn't a bug introduced by this patch, but shouldn't rcv_data_fin_seq
also be converted to atomic64_t here in struct mptcp_sock?

Since the explicit goal of this patch is to convert all locklessly accessed
u64 fields to atomic64_t to fix torn accesses on 32-bit architectures,
missing this field leaves the vulnerability unpatched.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787827525.gi=
t.tanggeliang@kylinos.cn?part=3D1
