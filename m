Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5001A23A6
	for <mptcp@lists.linux.dev>; Sun, 23 Aug 2026 01:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787448265; cv=none; b=K1HtAZQySF68w6Be3sohNqfWRXU0uEs8TYKMQECVyOTQ/QM0j/o39ShyueYVTCdY1onTfNozYTUAVWvLCzFe/vIUFSVatlGMUN5QcSLkIirkL6OCv0TIiWEI+Pvuty1a8H/skSznO/PAFhyOh43lq2XAVAks3gy/MFlaQNGS4js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787448265; c=relaxed/simple;
	bh=KgNDkZSJl8Pz6oyGClhSrhjqu8Fgh5A31G2USalB6Zg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EMMu2WzOwBH9DGHzg582jK8YMq2Z+cj9cAPfRh6Rf1zACoPx9cDT3k1nwj8QZ2HCYnCAi9uMINV6h1w9NUp6xEabYOfvcACc41qxmvCDEy5URjrLWx1ymqXH3KN1jHAxQL+jm1WDYi6ZuyqfdPsR8A1WptxNm2GzyA7V+gJ3Y/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcoKhTkI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcoKhTkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5E21F000E9;
	Sun, 23 Aug 2026 01:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787448263;
	bh=KMTKrbeGBFiykdPtuAA/h20dE09hJpnyabG9uGrcLG4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lcoKhTkIOtd5op/oZRdbpgIZUAEYprnGfbOrJZ9fDadZIcj0413IqIousBzS/3KOI
	 GPm0IDXwXtUxebvPmtzvi7vWte1nC2s+6d+G5a2eRKDrj6W75Bqrqkzno7lD8ITxQ7
	 GKo1Ck+fl0/PEbtw7absxq4s35cB/mmh+1y/il/tf8UtCVisFhsU7FsT4v0KTqJnJt
	 ERCeOUEwdxhDVmLTjlKfzqOymCvrig2gSXPrGH34U4EwkAwAU6drPCwAyRH8lYQtz2
	 PmfTce783dFpBij446fcOAgDydAnA5UMImtDdO7hu6XXfO7zQHhlzQgfnz/MP1irgu
	 8XqQ4Rb/C1muQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v6 3/7] mptcp: remove CB offset field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <95f5d91022661e9783da7a08c369659b3a14f802.1787446274.git.tanggeliang@kylinos.cn>
References: <cover.1787446274.git.tanggeliang@kylinos.cn>
 <95f5d91022661e9783da7a08c369659b3a14f802.1787446274.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 01:24:23 +0000
Message-Id: <20260823012423.7F5E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect initialization of `subflow->map_subflow_seq` in `mptcp_p=
ropagate_state` completely breaks data reception when falling back to TCP.
--

--- Patch [3]: [PATCH mptcp-next v6 3/7] mptcp: remove CB offset field ---
commit 8a2d837eb49f2826870e0f275e0beb7da32784d7
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: remove CB offset field

This commit replaces the SKB CB offset field with a new socket-level
copied_seq field to track bytes already consumed. Sequence number tracking
is updated to synchronize with IASN, and MPTCP sequence space is initialized
to 0 in fallback mode.

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index ed3a48cf9c973..6bffa02c69626 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -520,6 +522,13 @@ static void mptcp_propagate_state(struct sock *sk, s=
truct sock *ssk,
>  		WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
>  		WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
>  		subflow_set_remote_key(msk, subflow, mp_opt);
> +	} else {
> +		/* Fallback: initialize sequence space to 0 (no remote key) */
> +		subflow->map_seq =3D 0;
> +		/* ensure mptcp_subflow_get_map_offset() returns 0 */
> +		subflow->map_subflow_seq =3D subflow->ssn_offset +
> +					   tcp_sk(ssk)->copied_seq;

[Severity: High]
Does this code incorrectly initialize map_subflow_seq during TCP fallback?

The comment says this should ensure mptcp_subflow_get_map_offset() returns
0, but the offset and copied_seq are added rather than subtracted.

Because mptcp_subflow_get_map_offset() evaluates
copied_seq - ssn_offset - map_subflow_seq, adding the terms here causes the
offset to evaluate to -2 * ISN.

When falling back to standard TCP, this miscalculation will cause incoming
packets to fail sequence bounds checks against msk->ack_seq, resulting in
data reception failures as packets are either dropped or permanently stuck
in the out-of-order queue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787446274.gi=
t.tanggeliang@kylinos.cn?part=3D3
