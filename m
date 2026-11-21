Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256437;
	b=C+d83uYl7ZZ2MYULYT3KKxWOTiuxzTk7Y6ss40HwWiobE1COPx2T47unOx8tsET3g6jK
	 f0YeC9wrxfw+E2BWMeZlySLN7TBnzz81Er/64XK6G4iOsEVWdkW1WE77Ko73O9OkdxgHI
	 FcHMv0lrDIwYAC1KtHYVNc1xGKipJCsyouVdExgKWev52IPWwBawJ9kqb/fPpBbo/YCOl
	 qZrgLvUSOiFfXg0NbqpHFa2+p85piWKkwTFH0/T9UyYCxqpVVNof4sHGh09FSY7ARbdH0
	 eKts86MihYHonhYV2Wnw8n+X1ulM6ySvzVXyMaA4y0lB+HZYoCmVOSwfmpj22W8lRBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256437;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tVeF7jKPg/zF0vL1znZd6v5OvyMBqjDE0accizJ9i0w=;
	b=cQU4adSnz+8PLhjDhl79/MM8hnvVdCFdIhl1S5LtezE+/7hQ4lgc5DEN5QaIMhHXDdgM
	 WHPq6dLutDNM/F/VGt8KnU588esf3djFBcq5nifPxt2fLg2U0gEkpFdCKk23KlsHH6VJM
	 S4zIJmE/hZeh3yxlAWwdGHARgxwRAFMfWxc3lX3BNXCALwmkcEYNAHCSzf+dTUTIK5m5T
	 M1DDs2MEqjuycxdWhjv3reIrTbWQ/1jkaFxKKxWHwN5B+os+MBd+c+IEtU9L5usK4EFTM
	 qnsIwquHVKPMPpy8zuEuM/7wn4XZ5RpNhDlD4C+2OfREK+Cqwaef9arU1RvdGPBawzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wjp84Haa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27762606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wjp84Haa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A501F000C4;
	Sat, 21 Nov 2026 10:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795256436;
	bh=tVeF7jKPg/zF0vL1znZd6v5OvyMBqjDE0accizJ9i0w=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Wjp84HaaYGe3xdu5ExMvGjI3qhLqeqm6xoBOmbLfVRZT+Q/04yQSh9D2ZQoEDJOv/
	 aaf2jp9CWzv9sOhK4XKj2dd8STdGH3wRf9C0ucFU1wsz3Ny+pafomVkfZNbyvEuMi2
	 3KrRGffgvNeRH+nOL946H3cHlFQE3S/K8O6xJZ5dZO5TFpgatfjc9Qbgiqu0726JD/
	 RP/3J0vDDZvaQaAzEsvFh3dMqNaD+rG8yqWv7xCFkaurBXkivSthmYVMS9zGA6dFUu
	 R/IvzhFzgvNIY2Ltwcm10ZX0UBn27eIkEodHRoDVA/87X2eq6IJmIjWDdJEmzPnf/h
	 DoOZE0JFGUJew==
Message-ID: <sashiko-outbox-226934@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC mptcp-next mptcp-net v2 62/62] mptcp: reset when the
 DSS disappears after a DATA_ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-62-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
 <20261121-mptcp-cmason-fixes-v2-62-00327fd1de1f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 10:20:36 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] mptcp: fallback after dss_confirmed in mptcp_dss_corruption()
  on partial map
- [Low] mptcp: missing MAPPING_INFINITE in show_mapping_status() trace
  macro
--

commit 066a0ac232910122a63844ec66369cf60e694e69
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: reset when the DSS disappears after a DATA_ACK

This commit tracks whether a DATA_ACK has acknowledged sent data on a
subflow (dss_confirmed) and resets the subflow instead of falling back to
TCP when a subsequent segment arrives without a DSS option or with an
invalid mapping.

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 7dbad6debdf07..e66d8416fe797 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1072,7 +1072,8 @@ enum mapping_status {
>  	MAPPING_DATA_FIN,
>  	MAPPING_DUMMY,
>  	MAPPING_BAD_CSUM,
> -	MAPPING_NODSS
> +	MAPPING_NODSS,
> +	MAPPING_INFINITE
>  };
> =20
>  static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
> @@ -1242,7 +1243,7 @@ static enum mapping_status get_mapping_status(struc=
t sock *ssk,
>  	if (data_len =3D=3D 0) {
>  		pr_debug("infinite mapping received\n");
>  		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
> -		return MAPPING_INVALID;
> +		return MAPPING_INFINITE;
>  	}

[Severity: Low]
Should show_mapping_status() in include/trace/events/mptcp.h also be
updated for MAPPING_INFINITE (along with MAPPING_BAD_CSUM and
MAPPING_NODSS) so trace_subflow_check_data_avail() does not print raw
numeric values?

> =20
>  	if (mpext->data_fin =3D=3D 1) {
> @@ -1453,6 +1454,22 @@ static void subflow_update_dsn_base(struct mptcp_s=
ubflow_context *subflow)
>  		subflow->dsn_end =3D end;
>  }
> =20
> +/* RFC 8684, 3.7: no fallback once a DATA_ACK acked our data, except MP_=
FAIL */
> +static bool subflow_nodss_is_fatal(struct mptcp_sock *msk,
> +				   const struct mptcp_subflow_context *subflow)
> +{
> +	bool fatal;
> +
> +	if (!subflow->dss_confirmed)
> +		return false;
> +
> +	/* before a fallback, only an MP_FAIL clears allow_subflows */
> +	spin_lock_bh(&msk->fallback_lock);
> +	fatal =3D msk->allow_subflows;
> +	spin_unlock_bh(&msk->fallback_lock);
> +	return fatal;
> +}
> +
>  static bool subflow_check_data_avail(struct sock *ssk)
>  {
>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> @@ -1473,7 +1490,9 @@ static bool subflow_check_data_avail(struct sock *s=
sk)
>  		status =3D get_mapping_status(ssk, msk);
>  		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue=
));
>  		if (unlikely(status =3D=3D MAPPING_INVALID || status =3D=3D MAPPING_DU=
MMY ||
> -			     status =3D=3D MAPPING_BAD_CSUM || status =3D=3D MAPPING_NODSS))
> +			     status =3D=3D MAPPING_BAD_CSUM ||
> +			     status =3D=3D MAPPING_NODSS ||
> +			     status =3D=3D MAPPING_INFINITE))
>  			goto fallback;
> =20
>  		if (status !=3D MAPPING_OK)
> @@ -1523,7 +1542,9 @@ static bool subflow_check_data_avail(struct sock *s=
sk)
>  			return true;
>  		}
> =20
> -		if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
> +		if (((status =3D=3D MAPPING_NODSS || status =3D=3D MAPPING_INVALID) &&
> +		     subflow_nodss_is_fatal(msk, subflow)) ||
> +		    !mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {

[Severity: Medium]
Can an incoming skb that starts within the current mapping but extends
beyond subflow->map_data_len (for instance, after middlebox coalescing or
resegmentation across a mapping boundary) still trigger a fallback to TCP
after subflow->dss_confirmed is set?

validate_mapping() in get_mapping_status() only checks that the starting
SSN of the skb lies within [subflow->map_subflow_seq,
subflow->map_subflow_seq + subflow->map_data_len), so get_mapping_status()
returns MAPPING_OK and bypasses subflow_nodss_is_fatal() here.  When
__mptcp_move_skbs_from_subflow() then sees map_remaining < len, it calls
mptcp_dss_corruption(), which invokes mptcp_try_fallback() without
checking whether subflow->dss_confirmed is set:

net/mptcp/protocol.c:mptcp_dss_corruption() {
	if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSCORRUPTIONFALLBACK)) {
		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
		mptcp_subflow_reset(ssk);
	}
}

As a result, the receiver still performs a one-sided fallback to TCP after
a DATA_ACK has confirmed bidirectional MPTCP options instead of resetting
the subflow.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-mptcp-cmas=
on-fixes-v2-0-00327fd1de1f@kernel.org?part=3D62
