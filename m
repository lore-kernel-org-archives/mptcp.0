Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BFC411FA7
	for <mptcp@lists.linux.dev>; Sun, 18 Oct 2026 04:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792298706; cv=none; b=dZezElZfOZwARJsOELUk0SoXaRw9WXBqOoIXQvwcMpo6dnSg/a+4RYvVEnHsI4szCta+H2dwMSDx7yHlzwsiz5ITxncWTcsKvGUq48pVh0F2N6FAPR+ecdtyYcgoSNkBoQdpOeH4LukeGeCAeSEu6YjAF+P6TBY7JKTFYcudqnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792298706; c=relaxed/simple;
	bh=kaCm08PMOaD0bQ3/gPbyU1c2xDWc+FwbUt+NWsLJy2I=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=lLsWrWXB8leXGM5ThPMFJetbx18bRvMfdGEFvz5d7FU36lAMyIaA/52so8PP04lEJm0eeNXVLGkP6DCVeJuPw/mCpQMNCzyTVosEdrqvHIt3T2YJkMOtM3ejDgNCDrBBMyvmHfnPGIMI17q9Yy+5BHA9sxq3WSpcouOSfakjDEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=de0solHR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="de0solHR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572EB1F000C6;
	Sun, 18 Oct 2026 04:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792298704;
	bh=mlA578b+4Mfl1P1fkhQ9LwNcEns3V22wvDTOohbV77I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=de0solHR03TlILYfDfYHt+tIGhtXlJJN05DY6hRVeG3LYEFogwlDPoIXYPd5VQ3Tj
	 ZVxniE4aIL3y1mYStYy3X63UgpRaZ39+r1ysxKDx0ICZdhbVUyrtO3AaNTx4qh+6AD
	 TCFITm9eeneM6DMVuEA0gpt01odq6F3eYSS1IhoyTvLfDUH+V6PCHUthyUGrIAPmg4
	 1NTM3M1GjFQvbhqHThTk0Oof4KtopHoOEmMCjuMkOWZWgFnLI9xLwZM3i3SgqlsTKb
	 yz4tjvMMU4z7nUpYU3GZPF4kfvLlZ3oxBSlVHIK9iNIsCIU9ca7fTapOo9aUsxpDxA
	 WAodgEv5ey3MA==
Message-ID: <sashiko-outbox-175939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v6 4/6] mptcp: pm: in-kernel: retry subflows
 closed after an error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anil Kaushik" <anilkaushikwireless@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261018041748.1655711-5-anilkaushikwireless@gmail.com>
References: <20261018041748.1655711-1-anilkaushikwireless@gmail.com>
 <20261018041748.1655711-5-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 04:45:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] mptcp: pm: TOCTOU race on sk_state in mptcp_pm_rm_addr_or_subflo=
w()
- [Medium] mptcp: pm: in-kernel: missing subflow->resetting check in mptcp_=
pm_kernel_retry_check()
--

commit 8d1998d3ad0845aa492d3b66abe99c472d868e05
Author: Anil Kaushik <anilkaushikwireless@gmail.com>

mptcp: pm: in-kernel: retry subflows closed after an error

This commit teaches the in-kernel path manager to re-create established
subflows initiated by this peer when TCP closes them after an error, while
avoiding retries when the peer sent an non-transient MP_RST, when the
subflow was aborted locally, or when its address was removed.

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index d7c5b50b34cc9..54d94bc729630 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c

[ ... ]

> @@ -762,6 +782,24 @@ static void mptcp_pm_add_addr_send_ack(struct mptcp_=
sock *msk)
>  	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
>  }
> =20
> +/* A subflow closed by TCP but not collected yet must not be re-created =
with
> + * a removed address, see mptcp_pm_kernel_retry_check().
> + */
> +static void mptcp_pm_rm_no_retry(struct mptcp_subflow_context *subflow,
> +				 enum linux_mptcp_mib_field rm_type, u8 rm_id)
> +{
> +	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +	u8 id;
> +
> +	if (rm_type =3D=3D MPTCP_MIB_RMADDR)
> +		id =3D READ_ONCE(subflow->remote_id);
> +	else
> +		id =3D subflow_get_local_id(subflow);
> +
> +	if (id =3D=3D rm_id && inet_sk_state_load(ssk) =3D=3D TCP_CLOSE)
> +		subflow->no_retry =3D 1;
> +}
> +
>  static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
>  					const struct mptcp_rm_list *rm_list,
>  					enum linux_mptcp_mib_field rm_type)
> @@ -794,6 +832,7 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_=
sock *msk,
>  			int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
>  			u8 id =3D subflow_get_local_id(subflow);
> =20
> +			mptcp_pm_rm_no_retry(subflow, rm_type, rm_id);
>  			if ((1 << inet_sk_state_load(ssk)) &
>  			    (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING | TCPF_CLOSE))
>  				continue;

[Severity: Medium]
Can a subflow whose address is being removed still be retried if its
subflow socket transitions to TCP_CLOSE concurrently?

mptcp_pm_rm_addr_or_subflow() runs under the msk socket lock and
msk->pm.lock without holding the subflow socket lock (ssk), and reads
ssk->sk_state twice without synchronization.

If ssk is not yet in TCP_CLOSE when mptcp_pm_rm_no_retry() checks
inet_sk_state_load(ssk) =3D=3D TCP_CLOSE, subflow->no_retry stays 0. If a
concurrent TCP timer or softirq (e.g., tcp_write_err() or tcp_reset()
under bh_lock_sock(ssk)) moves ssk to TCP_CLOSE before the second
inet_sk_state_load(ssk) in mptcp_pm_rm_addr_or_subflow(), or if ssk was
in TCP_FIN_WAIT1, TCP_FIN_WAIT2, or TCP_CLOSING and later closes with an
error, the loop takes the continue branch without calling
mptcp_close_ssk().

When __mptcp_close_subflow() later processes ssk, both
subflow->close_event_done and subflow->no_retry are 0, so
mptcp_pm_kernel_retry_check() will re-create the subflow using the
removed address. Would setting subflow->no_retry =3D 1 whenever id =3D=3D r=
m_id
(regardless of whether ssk has already reached TCP_CLOSE) avoid this race?

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 0379e1495cf4d..e88c236b62e9f 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1610,6 +1610,106 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_=
sock *msk)
>  	return true;
>  }
> =20
> +/* Called with the msk socket lock held, before the subflow is closed */
> +bool mptcp_pm_kernel_retry_check(struct mptcp_sock *msk,
> +				 const struct mptcp_subflow_context *subflow,
> +				 struct mptcp_pm_retry *retry)
> +{

[ ... ]

> +	/* The peer asked not to use this path again (MP_RST without the T
> +	 * flag), the subflow has been aborted locally, or it hit an MPTCP
> +	 * protocol error.
> +	 */
> +	if ((subflow->reset_seen && !subflow->reset_transient) ||
> +	    err =3D=3D ECONNABORTED || err =3D=3D EBADMSG)
> +		return false;

[Severity: Medium]
Should this check also reject subflows where subflow->resetting is set?

When a subflow is locally aborted due to an MPTCP protocol error via
mptcp_subflow_reset() (for example from mptcp_mp_fail_no_response(),
mptcp_update_infinite_map(), or mptcp_dss_corruption()), it sets
subflow->resetting =3D 1 and calls tcp_done(ssk) without setting
ssk->sk_err:

net/mptcp/subflow.c:mptcp_subflow_reset() {
	...
	subflow->resetting =3D 1;

	/* No need to delay the actual close for to-be discarded data. */
	__skb_queue_purge(&ssk->sk_receive_queue);
	mptcp_send_active_reset_reason(ssk);
	tcp_done(ssk);
	...
}

If IP_RECVERR or IPV6_RECVERR was enabled on the socket, an earlier
non-fatal ICMP error on the established subflow leaves a non-zero
ssk->sk_err (such as EHOSTUNREACH or EPROTO) untouched because
__mptcp_subflow_error_report() skips sock_error(ssk) on established
non-fallback sockets:

net/mptcp/protocol.c:__mptcp_subflow_error_report() {
	...
	if (sk->sk_state !=3D TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)=
))
		goto out;

	err =3D sock_error(ssk);
	...
}

If mptcp_subflow_reset() later closes that subflow,
mptcp_pm_kernel_retry_check() will see the stale ssk->sk_err (which is
neither ECONNABORTED nor EBADMSG) and re-create a subflow that was reset
locally for an MPTCP protocol error.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018041748.1655=
711-1-anilkaushikwireless@gmail.com?part=3D4
