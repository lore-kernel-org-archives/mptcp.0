Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614042;
	b=LBOQUqNDRdtp/n7ep0Q8yX7jxlAdhVdN5JM1Er/gDVcseFeFJVu6uGKO0If0I49+tsXC
	 85bysyvzwDxOmPVexQPbEAdglHwOXLgjWX4nbfvNepa4oSRtrEvfQEZs00eojbtL/ZU89
	 6yldm5HZZGQffqN27zHWqyO2U1Oiy6IMsBbJRXejBQAfaovzs8RG47lh/o/O65Yd9SQSp
	 8+dy649N6KlMbPJni9zwsBnt0VcqDPnqgPCh5JnINkekRZvedvJMrqnKZca1Ak4tE1FZZ
	 pVTifuNxSoZeSpUfIllxYiNxznUkZx7BuGWyPxLTFy6+jh8A19Uv++v/9tkEvsGbeOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614042;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=10RECR6ctILU5Yg9fB7NEdyhY8md2uJy1mBlwsAZsqs=;
	b=SHRl+nrNA32hS8PFwZ7Y6qCl7GR4BJroksG0zIJK0iqaGLXF62xZtKl3Vej7j+/l8F8v
	 SbxVARBmFXMXaDroww6EBt3KYW/S98rOhDnI0WWm/0yoJNaztKhWXQAtaYDnpySwWmXgy
	 SQlYPzPSrZ3zakO/mVqo/WVA77ompBR01WMtwFNt1WIpUVI2kjwuM0om4mYOarXIN9xkM
	 sVulC/YBuVOqAjMIwwP4FCJ1zwkdUzbQFeHQiPDmO0ymFQQVBX6x8EfoQEVCshGng004I
	 QIsOCgKWC1Vidk04cOJWpP00qGyoYl7Zqa4/vFfLLTu2N07qotAEm656Bxurl55s5uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hECVKfC5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC0E606A891
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 23:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hECVKfC5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B30C1F000C4;
	Fri, 13 Nov 2026 23:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794614042;
	bh=10RECR6ctILU5Yg9fB7NEdyhY8md2uJy1mBlwsAZsqs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hECVKfC5G0m8+D2pANATvJzAAKb14WyiT1K+OttoHcfV4aEkJP3X3xBVymqFErk7g
	 GUo69J2J0wRXWxibpupEI4aXidkyW/GB+beEkHLBo3Cenzx2eaTODM4f+AYwMAKHG8
	 8tz9CBb4gMSTM0EDMNMzRC3woRuszzg3KrsyBTsBNUJv0LXJFKb/eBlWhh2/U9XiEh
	 EhZD/z9wjvBMVa5YFsk3LC4am/bO0y9YOM8+jiXBj1SVGl6CKt2oR9cJPg1DhrL2DM
	 WBbDPFECPM0CWPFq61pOdy3RVntjzgNQQjZzz0fsKHH4bHShruRjucrd1iuXinshZ3
	 4++leW1XXSXGA==
Message-ID: <sashiko-outbox-213884@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net 25/34] mptcp: push queued data on passive TFO
 subflows falling back to TCP
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-25-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
 <20261113-mptcp-cmason-fixes-v1-25-9205b77e9a2f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 23:54:01 +0000
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
- [Medium] mptcp: incomplete fallback handling in
  check_fully_established()
--

commit 66148bc476eb2e96002647feaf23c977ed60ceb1
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: push queued data on passive TFO subflows falling back to TCP

This commit pushes pending data in check_fully_established() when a
passive TFO subflow falls back to plain TCP on the third ACK.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 3477a7ec5a051..c56ca5e4df14b 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1035,6 +1035,11 @@ static bool check_fully_established(struct mptcp_s=
ock *msk, struct sock *ssk,
>  			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
>  			goto reset;
>  		}
> +		if (tcp_sk(ssk)->syn_fastopen_child) {
> +			mptcp_data_lock(sk);
> +			__mptcp_check_push(sk, ssk);
> +			mptcp_data_unlock(sk);
> +		}
>  		return false;
>  	}

[Severity: Medium]
Should this fallback path also run for active-open subflows and clean up
msk->rtx_queue the same way mptcp_incoming_options() does?

net/mptcp/options.c:mptcp_incoming_options() {
	...
	if (__mptcp_check_fallback(msk)) {
		...
		mptcp_data_lock(subflow->conn);
		if (sk_stream_memory_free(sk))
			__mptcp_check_push(subflow->conn, sk);
		...
		__mptcp_snd_una_update(msk, READ_ONCE(msk->snd_nxt));

		__mptcp_data_acked(subflow->conn);
		mptcp_data_unlock(subflow->conn);
		return !mptcp_over_limit(subflow->conn, sk, skb);
	}
	...
}

Because check_fully_established() returns false, mptcp_incoming_options()
exits without running its fallback block on the packet that triggers the
fallback.

On a passive TFO subflow, __mptcp_check_push() spools pending dfrags to
ssk and advances msk->snd_nxt, but omitting __mptcp_snd_una_update() and
__mptcp_data_acked() leaves those dfrags in msk->rtx_queue until another
packet arrives, keeping the bytes charged to both sk->sk_wmem_queued and
ssk->sk_wmem_queued and double-counting SIOCOUTQ.

On an active-open subflow, msk->wnd_end is initialized from the unscaled
SYN-ACK window, so mptcp_sendmsg() can leave unsent data in msk->rtx_queue
beyond the initial flight.  If a middlebox strips MPTCP options after the
SYN-ACK and the peer sends a bare TCP ACK opening the scaled window,
gating __mptcp_check_push() on syn_fastopen_child skips pushing the
remaining data, and __mptcp_retrans() -> __mptcp_push_retrans() aborts on
__mptcp_check_fallback(msk) without setting MPTCP_PUSH_PENDING, stalling
the remaining data in msk->rtx_queue if the peer is waiting for it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-mptcp-cmas=
on-fixes-v1-0-9205b77e9a2f@kernel.org?part=3D25
