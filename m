Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793519365;
	b=sBxJOqMhjihPRftlloheva2E5eF/WsKpsnWc1PL7dlerJGh7nnYg1B2Cd1OYM8mls/ZE
	 hHtfHN+7VW76lVGu1GrsU1liQdfGTtf7WBnMjN5NhoOWbqrlbvPrF2PvYk0vYPbF77RPw
	 P57SC24p+zvsZTtS1Ox0I6hT2Z99ipcj1WVDApz2AEA96slZlr70cHo38PnlM8PeMODPr
	 oz/XhGFLDtXnbB2AdzwyCjtPf+KDiEeH0k8JE8jgt09KVUjODfdNcail1F+Y5Hu5P263Q
	 EQdMx3PN62Fp1ODgJmhL4tqbXJ6XZ2JWKxyqmNc21IL6rx/lQmV6YKMeA/6UKaIEGjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793519365;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p5eoRK9qJgCRLniTMYj/8m7YMgVvjMACyQbVRMePL6A=;
	b=hi2kDPXWohTwvOuIUKu/8+4nn2Thwcyu3cGLE4dETrrmoa345V786w4G6DHLmes0fBE6
	 ngAfZbP3vktUyP+pjHCxHR3YWQ0r54QT7pBGWtiM/3i3v3jlTQ5DHSXOnGHeAes7AE8lD
	 gi28vtJVQouB+v7VHH8NNpiqbrMEAQpZsb1osE0rzU3BWs/nbmF8g6lNvFt9pP8+5eL8T
	 789sjMDQoRtSy+qzBreVgXKQnIH6XZGQe/Ui/Z3+wfUwKmwDCHM44yOr6a7Pq9TVxxotl
	 1SCpby8iF4q3ZzpeLeG9V3IoHOyBIDL37UiQ+2T5RZdGPj/70XXiWJVSzFxfdxY+DNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtKl9ppF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07CE606A324
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtKl9ppF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39ABB1F000C1;
	Sun,  1 Nov 2026 07:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793519364;
	bh=p5eoRK9qJgCRLniTMYj/8m7YMgVvjMACyQbVRMePL6A=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UtKl9ppFBRefHt+iLtyd6/RgvsUGw5nnwgL9LdPJezERz+JvSQreZN38IB7kxsThH
	 FjEK3ablD06TZiFAzXreuXcH9BF7pf2IexiPH1MLRrmy11Vob3kppnpGwEViFEN+wC
	 Cv8/jo3Lko35DPVwULti5MFl7Y2OpBaVN85GQDL0nWZg5DU6qcaCh2Qh9RxnAGylHs
	 mzpGT/tIFqA3jZr4XrXaOjgTYAWd3zCL5YxJMj8bfZY7D94lkbAInQox/4eBBfm1AG
	 Sc7EWb6gUF4COptzhrrGyt3U67753c6JXJg+T3aRBqphlcPJGADhm26OMmV3z8/8ZW
	 8orFVJXEcznMw==
Message-ID: <sashiko-outbox-192315@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v14 4/6] mptcp: pm: in-kernel: retry subflows
 closed after an error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anil Kaushik" <anilkaushikwireless@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261101072051.3853492-5-anilkaushikwireless@gmail.com>
References: <20261101072051.3853492-1-anilkaushikwireless@gmail.com>
 <20261101072051.3853492-5-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 07:49:23 +0000
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
- [Medium] mptcp: pm: __mptcp_close_ssk() schedules new subflows on MPTCP_C=
F_RETRY
--

commit 8b4a965d9506046df65ec4c54a676dc6bc6eda03
Author: Anil Kaushik <anilkaushikwireless@gmail.com>

mptcp: pm: in-kernel: retry subflows closed after an error

This commit teaches the in-kernel path manager to re-create established
subflows that were closed after a path timeout while the MPTCP connection
remains established and at least one other subflow can still send data. It
also closes any pending re-created subflows if no other subflow can send da=
ta
anymore or if the MPTCP socket is shut down or closed.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..cb1350ba1a41a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -2695,6 +2700,26 @@ static void __mptcp_close_ssk(struct sock *sk, str=
uct sock *ssk,
>  	 * subflow close.
>  	 */
>  	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
> +
> +	/* a re-created subflow, see mptcp_close_retry_subflows(): the ssk lock
> +	 * defers the 4th ACK, so it cannot get fully established meanwhile
> +	 */
> +	if (flags & MPTCP_CF_RETRY) {
> +		if (READ_ONCE(subflow->fully_established)) {
> +			release_sock(ssk);
> +			return;
> +		}
> +
> +		/* like mptcp_close_ssk(): it can have joined already */
> +		if (sk->sk_state =3D=3D TCP_ESTABLISHED &&
> +		    !subflow->close_event_done) {
> +			subflow->close_event_done =3D true;
> +			mptcp_event(MPTCP_EVENT_SUB_CLOSED, msk, ssk,
> +				    GFP_KERNEL);
> +		}
> +		mptcp_pm_subflow_check_next(msk, subflow);
> +	}

[Severity: Medium]
When closing stale re-created subflows via mptcp_close_retry_subflows() ->
__mptcp_close_ssk() with MPTCP_CF_RETRY because no other subflow can send
data anymore, can calling mptcp_pm_subflow_check_next() schedule new subflow
creation and cancel the close_timeout timer?

In net/mptcp/pm.c, mptcp_pm_subflow_check_next() decrements extra_subflows
via __mptcp_pm_close_subflow() and then checks whether more work is pending:

	if (mptcp_is_fully_established(sk) &&
	    mptcp_pm_nl_check_work_pending(msk))
		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);

Consider a connection where limit_extra_subflows is 1 and two local subflow
endpoints (endpoint 1 and endpoint 2) are configured:

1. Subflow 1 (using endpoint 1) is established while endpoint 2 remains
   unused in id_avail_bitmap.
2. Subflow 1 times out while the initial subflow (msk->first) is still
   active, so __mptcp_close_subflow() re-creates Subflow 1 with
   subflow->retry =3D true and subflow->request_join =3D 1.
3. Before the re-created Subflow 1 becomes fully_established, msk->first
   also times out and enters TCP_CLOSE. Now no subflow can send data while
   sk->sk_state is still TCP_ESTABLISHED.
4. mptcp_worker() closes msk->first in __mptcp_close_subflow() and then sees
   mptcp_retry_subflows_stale(msk) is true, calling
   mptcp_close_retry_subflows(sk, true) -> __mptcp_close_ssk() with
   MPTCP_CF_RETRY.
5. __mptcp_close_ssk() calls mptcp_pm_subflow_check_next(), which decrements
   msk->pm.extra_subflows to 0 and schedules MPTCP_PM_SUBFLOW_ESTABLISHED
   because sk->sk_state is TCP_ESTABLISHED and endpoint 2 is available in
   id_avail_bitmap. __mptcp_close_ssk() then finishes closing the retry
   subflow and starts the close_timeout timer via mptcp_start_tout_timer(sk=
).
6. The scheduled PM work runs mptcp_pm_nl_subflow_established() ->
   mptcp_pm_create_subflow_or_signal_addr() -> __mptcp_subflow_connect() for
   endpoint 2. __mptcp_subflow_connect() creates a new subflow (with
   subflow->retry =3D=3D false) while no subflow can send data and calls
   mptcp_stop_tout_timer(sk), cancelling the close_timeout timer. Because
   this new subflow has subflow->retry =3D=3D false, mptcp_retry_subflows_s=
tale()
   will not close it if it hangs in TCP_SYN_SENT or waits for the 4th ACK.

Should the MPTCP_CF_RETRY path in __mptcp_close_ssk() only release the
subflow slot (or avoid scheduling MPTCP_PM_SUBFLOW_ESTABLISHED when no
subflow can send data) instead of calling mptcp_pm_subflow_check_next()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101072051.3853=
492-1-anilkaushikwireless@gmail.com?part=3D4
