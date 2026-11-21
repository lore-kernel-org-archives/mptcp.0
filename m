Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795257109;
	b=GIipTpl74PIJn3TnMM64ELqgk3Ie9hujmctybI9GjRuc7zTMaDVRYCG3uQv4JtRhpm95
	 E5hhciHCyn0wZd72pgpLJwUxVFI3SXSO+lmXWIw0xC40g9f1QsOfQ3RyTSKMWAdFchUs2
	 RenRIbw8BhXBS8u3Mm3rjdCIf671r5/oVvscsvKp/yQrt0ObezHebAJzo6Nh6uHg18tcC
	 P0Pb9je6DX6RFR1Kvdoo6EuXa260gtFYa/Ndlls7vGST5KIVGGr7h3WeJXZx/kd9nrucR
	 4aoaQi5TwbNyL3XWS/PeSsA3BMjN9SzONorXtgN/fT/snLFECwmirP7Z5tgvhJAO3hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795257109;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=loFReA9yLU5MKYRiU82CbMbYhhm+3USrrI83s7eYNcI=;
	b=QLCaiVn2Zu0wxCNLcefsZeKz+be5kZrhkjJQkDvPggM43nULvdWHue/lrhsRUo1VygUT
	 Lw0tWjR+cTFR/8Nfj7dU8U4I/RWq/4iZORN5eubOoH6KA+FbAKa8fmLhSirvOCbWE02Nk
	 8vhChleSgSEWMfVWd8iviRwAuz+qVOKG7VLktGht93CqiNhWi2wiRlkvB9Mhtpho4GHVQ
	 YBLHvAPoX0izAQeXUTD0gtjITOtXlmwxB6Bd2IQi+dkKoCAhquZAgRZOnlldhgTpprzro
	 BCKwQGoIk83J1//K8u2WjMYj6oSrj/4utlBYvezRIcDOHlgVO67CTyV/VbrnZUmyRdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nUi2uq97;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13C3606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nUi2uq97
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795891F000C4;
	Sat, 21 Nov 2026 10:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795257109;
	bh=loFReA9yLU5MKYRiU82CbMbYhhm+3USrrI83s7eYNcI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=nUi2uq97HPyC/5G2pHTTAh4+y+ASLy5eCaKd3cv1ZtPExbiI+5+ONu3a9HVzbhrgF
	 H7QRL/B/LbzCK5pVvTOqPETtCqmTXMU1H9XlmXmBRCoh5QKETn2MyDEotVXBgVfeS4
	 kK1/h1Zfo0nw1bgdruiiIAs2s5cIg6pLZFUEloihB1VecdWArPaUVNClPMrZPWgJVF
	 279piZjL1sMQIJbetu755ZYCHYifQI6LvzO+XfTXCwQPjH7TZ74EfqYD5N8CbOaGwV
	 PhPyPyCPREqTLGZeZWMfY+ASMrjaX/bkVLqsL4DNJdmGeFfKOUuB9qxG2XHNeNJL7h
	 6el+wEm7dnkSA==
Message-ID: <sashiko-outbox-226943@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v2 51/62] mptcp: keep the first byte after a
 simult connect
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-51-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
 <20261121-mptcp-cmason-fixes-v2-51-00327fd1de1f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 10:31:49 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mptcp: mptcp_syn_options() sets ssn_offset on MP_JOIN simult
  connect
--

commit f7213d49d43afa61976fc0d20b767c461864c635
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: keep the first byte after a simult connect

This commit sets subflow->ssn_offset when sending a SYN-ACK in
TCP_SYN_RECV during a simultaneous connect and only updates it from
packets with TCPHDR_SYN in subflow_finish_connect().

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 05b9c66aaed63..41eb39968a9a6 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -474,6 +474,11 @@ bool mptcp_syn_options(struct sock *sk, const struct=
 sk_buff *skb,
>  	 * in mptcp_established_options_mp()
>  	 */
>  	subflow->snd_isn =3D TCP_SKB_CB(skb)->end_seq;
> +
> +	/* simult connect: the peer's SYN-ACK will not set ssn_offset */
> +	if (unlikely(sk->sk_state =3D=3D TCP_SYN_RECV))
> +		subflow->ssn_offset =3D tcp_sk(sk)->rcv_nxt - 1;
> +
>  	if (subflow->request_mptcp) {
>  		if (unlikely(subflow_simultaneous_connect(sk))) {
>  			WARN_ON_ONCE(!mptcp_try_fallback(sk, MPTCP_MIB_SIMULTCONNFALLBACK));

[Severity: Medium]
Should setting subflow->ssn_offset here be restricted to the
subflow->request_mptcp simultaneous connect branch?

If an active MP_JOIN subflow (subflow->request_join =3D=3D 1,
subflow->remote_key_valid =3D=3D 1, subflow->mp_join =3D=3D 0) receives a
crossed SYN in TCP_SYN_SENT, tcp_rcv_synsent_state_process() moves it to
TCP_SYN_RECV and calls tcp_send_synack() -> mptcp_syn_options(), which
now initializes subflow->ssn_offset to the peer's ISN.

When the third ACK arrives with seq =3D=3D subflow->ssn_offset + 1,
tcp_rcv_state_process() transitions the subflow to TCP_ESTABLISHED
before subflow_finish_connect() runs and calls tcp_data_queue() ->
mptcp_incoming_options() -> check_fully_established():

net/mptcp/options.c:check_fully_established() {
	if (TCP_SKB_CB(skb)->seq !=3D subflow->ssn_offset + 1) {
		...
	}

	if (subflow->remote_key_valid &&
	    (((mp_opt->suboptions & OPTION_MPTCP_DSS) && mp_opt->use_ack) ||
	     ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) &&
	      (!mp_opt->echo || subflow->mp_join)))) {
		goto set_fully_established;
	}

	if (!(mp_opt->suboptions & OPTIONS_MPTCP_MPC)) {
		if (subflow->mp_join)
			goto reset;
		subflow->mp_capable =3D 0;
		if (!mptcp_try_fallback(ssk, MPTCP_MIB_MPCAPABLEDATAFALLBACK)) {
    ...
}

Because TCP_SKB_CB(skb)->seq =3D=3D subflow->ssn_offset + 1 now matches
while subflow->mp_join is 0 and subflow->remote_key_valid is 1, a plain
ACK calls mptcp_try_fallback() on the parent connection instead of
resetting the subflow, while an ACK carrying a DSS ACK with data jumps
to set_fully_established without MP_JOIN authentication and triggers the
WARN_ON_ONCE() in subflow_data_ready().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-mptcp-cmas=
on-fixes-v2-0-00327fd1de1f@kernel.org?part=3D51
