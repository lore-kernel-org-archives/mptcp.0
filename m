Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8207543F4B7
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791462576; cv=none; b=p/Tjw5g+yDNBxWni9Ra6fuigSwjIaEs8yxiQ8xRrIWrq/r2RSVH33P9UZbv9eUObeSljD+NVbrtuPRjIDsiVr3TRWHxWAzYaXY81J+p15mxCG8AvfciyEUacqmmZpKiYQFDS4pvRxO+iO10KEfJLEe2RW8dyhacrMgyCOqt7ESc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791462576; c=relaxed/simple;
	bh=hBAjCUReGBt+UVjUNstITJHUNW9hlC3ileYjy5Bx140=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=p4Wp6YI7NL3l3mU/ZSjd5C00LxzlIL9OLvMbQQzTRTqk/y10LkzmEmqjonH1WHvGV1D7fpWMyfv+AO+1qiFa9quVZ77g/rhpPjxWdtjjtacc6EOk/k46zFPnwZ9Mwg17sldyyznEuy62Ul7Ezx63zRpXO11fWHEN3D45A8kAOrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsBlOwhm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsBlOwhm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A151F000FF;
	Thu,  8 Oct 2026 12:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791462575;
	bh=8kp+PuvXSyKDOUV3BYHR2x53BRRGlsXKwF2bqzPqXTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AsBlOwhm6+PmNLVwMr16mNK0U0rGlqV+QqQ32wdGdEkj+dTzTEDWFEwjyKVcsDm8z
	 IPWVVFTHn1xxTRMUsltyD0wpy9WNU6F9Ot9WTRr4/jeXKXv9rR/nW3HT+mYJhQVci5
	 3qTv18w58R5lEk9tQOpkKrAkETL7OYo08TmY3028XPt23aoT3haFCDR8gJX3p5ubIf
	 e67uwkema44x7CkOWRG2ycrpK9WJmAYXRHSy+8QMVBwulch/obfHmhfND/oDysyHZ9
	 UoCN0QObMLhm8q9MBx3UGQPC3c0YL0A1q+5gqyy0GWTdnnzbCF+pAYZjcXlH8rmRM4
	 nzFAdxBHTlLjA==
Message-ID: <sashiko-outbox-164143@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] mptcp: push queued data on passive TFO subflows
 becoming established
Reply-To: sashiko-reviews@lists.linux.dev
To: "T S Rameshkumar" <rameshsv06@gmail.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20261008121602.206507-1-rameshkumar.t@phytecembedded.in>
References: <20261008121602.206507-1-rameshkumar.t@phytecembedded.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 12:29:34 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net/mptcp: data race in subflow bitfields causes list corruption
--

commit 91c44c97db7bbddaa206314ca428111bec1fb73f
Author: T S Rameshkumar <rameshsv06@gmail.com>

mptcp: push queued data on passive TFO subflows becoming established
   =20
With TCP Fast Open on an MPTCP listener, passive subflows that receive
data during SYN_RECV queue it into the msk write queue. This patch flushes
the queued bytes when the MPC third ACK arrives by checking if the subflow
was doing passive TFO.

Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=3DX3=
qf6QycjfKBw+8snPg@mail.gmail.com/

> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1042,6 +1042,15 @@ static bool check_fully_established(struct mptcp_s=
ock *msk, struct sock *ssk,
> =20
>  	mptcp_data_lock((struct sock *)msk);
>  	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
> +	/* Passive TFO: the application may have written data while the
> +	 * subflow was still in SYN_RECV; __mptcp_subflow_active() refused
> +	 * it then and nothing else spools the msk write queue when the
> +	 * MPC third ack (no DSS) arrives. Push it now.
> +	 */
> +	if (subflow->is_mptfo) {
> +		subflow->is_mptfo =3D 0;

[Severity: High]
Could this bitfield modification race with mptcp_close_ssk() and corrupt
the conn_list linked list?

In check_fully_established(), the new modification to subflow->is_mptfo is
protected by mptcp_data_lock(msk) and lock_sock(ssk).

However, there are asynchronous paths (like mptcp_pm_nl_rm_subflow_received=
()
or mptcp_worker()) that call mptcp_close_ssk(). That function modifies the
subflow->close_event_done bitfield while holding only lock_sock(msk).

In struct mptcp_subflow_context, these two bitfields share the same memory
word:

        valid_csum_seen : 1,        /* at least one csum validated */
        is_mptfo : 1,               /* subflow is doing TFO */
        close_event_done : 1,       /* has done the post-closed part */
        mpc_drop : 1,               /* the MPC option has been dropped */

Since the lock_sock(msk) mutex does not overlap with the locks held in this
code block, concurrent execution could result in a read-modify-write data
race.=20

If the close_event_done =3D true update is overwritten by is_mptfo =3D 0,
mptcp_close_ssk() could be re-executed on the same subflow later. This
would result in a double list_del(&subflow->node) inside __mptcp_close_ssk(=
),
corrupting the conn_list.

Is there a safe way to update is_mptfo without introducing a read-modify-wr=
ite
race on the shared bitfield word?

> +		__mptcp_check_push((struct sock *)msk, ssk);
> +	}
>  	mptcp_data_unlock((struct sock *)msk);
> =20
>  check_notify:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008121602.2065=
07-1-rameshkumar.t@phytecembedded.in?part=3D1
