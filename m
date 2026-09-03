Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FAD48F852
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435489; cv=none; b=RHeZdThpD4B8ldFrG9BeRao0TwVluQp6HJsmJnB0CM1ObxUDsvBukjNilXLg+LU3PKWC1xWQ0q0IgGilMntgztBBNJZZkkYE5C5ID0TGkaQayqyt91Kkkff0Cm/nk/19S5UYKG63gA1m+fagtVz3V/hVtdIfD/VskhMZpAgYkIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435489; c=relaxed/simple;
	bh=4+IrYNHu7t+mNvz2XORSuOBOu49nU/Pz6EjE58p2XjE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HAML1W88n5z2OrOjNwOvlMeLY4C7ZL+gTfqsbPd/IjxbXkBADkff4PiNYJy/P2G2Achhp6/7zNKmkuTXFVzEIb8ei23OlMEbCs1fgz100qlNRf7QHPdorIAPshg7eQo1n3OcN3ypqT11dAuUzj2O9jxug/Q1qAcsXGUzgrB/zjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PF3l82dn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PF3l82dn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968991F00A3A;
	Thu,  3 Sep 2026 11:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788435480;
	bh=aDEYdF7PRAh2N00qIUfbUDj5IVDOvtxXWsgGyjYNP80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PF3l82dnJZ2+ab5fIn8ULxNwipjnPCElr5iZrMIkrx2JbjmZlKhYJJO4biNkMPOEQ
	 wXoDrhDVAcRXrpRCB+T5A/F6/8Oywyi/Tz31w6SGkTgwK1SzxO6rPh7NMPhRk2D7U9
	 +2b7nVnR/mk71ir4N9KJ4yE/gzTMcaGnWIvwkeKsfI58Nq5+ZA+mh/z1aVvwzRx32t
	 BypyzGulKu2sLwr+t45vEGbZxwJv/YtxsvMbB6S0CUVa4VUPtn8/u+Hy0G49wkdzRX
	 oMGzSa3T07UJD2F97LS9gGGnCkqeK6bMGPcHJJvJXna2so4QhhXvT2YDzuCHdudhib
	 4vyyE6+uvOFew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next 3/3] mptcp: options: reset parsing in case of
 invalidity
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260903-mptcp-mib-inval-opt-v1-3-84a553c552b6@kernel.org>
References: <20260903-mptcp-mib-inval-opt-v1-0-84a553c552b6@kernel.org>
 <20260903-mptcp-mib-inval-opt-v1-3-84a553c552b6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 11:38:00 +0000
Message-Id: <20260903113800.968991F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `break` statement inside `mptcp_get_options` incorrectly exits=
 the `switch` statement instead of the `while` loop, causing `length` and `=
ptr` to become desynchronized, leading to an infinite loop, out-of-bounds r=
eads, and MPTCP option smuggling.
--

commit 60e4bc5aa7cfc08049c3062323eeae263a824439
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: options: reset parsing in case of invalidity

When an invalid option is detected, it is safer to drop any previously
parsed MPTCP options. This ensures a fallback to TCP or a subflow reject
instead of just ignoring the currently parsed option.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index aaaabcab0f8f9..b6d2e39f8464a 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
[ ... ]
> @@ -461,9 +456,12 @@ void mptcp_get_options(const struct sock *sk, const =
struct sk_buff *skb,
>  				return;
>  			if (opsize > length)
>  				return;	/* don't parse partial options */
> -			if (opcode =3D=3D TCPOPT_MPTCP)
> -				mptcp_parse_option(sk, skb, ptr, opsize,
> -						   mp_opt);
> +			if (opcode =3D=3D TCPOPT_MPTCP &&
> +			    !mptcp_parse_option(sk, skb, ptr, opsize, mp_opt)) {
> +				/* invalid option, drop previously parsed opt */
> +				*(u32 *)&mp_opt->status =3D 0;
> +				break;

[Severity: High]
Does this break statement exit the switch rather than the while loop?

If this only exits the switch block, it will skip the pointer and length
updates that occur at the end of the default case:

    ptr +=3D opsize - 2;
    length -=3D opsize;

Since length is not decremented when breaking here, the while (length > 0)
loop will continue indefinitely. The ptr keeps advancing by 2 bytes on each
subsequent iteration from reading opcode and opsize. Could this lead to an
infinite loop and out-of-bounds reads into the TCP payload?

Additionally, could this allow an attacker to smuggle MPTCP options by
placing them in the TCP payload after an invalid option that triggers this
break? Because length is never updated, the parser might treat the TCP payl=
oad
as an extension of the TCP options, bypassing inspection that only checks t=
he
TCP header.

> +			}
>  			ptr +=3D opsize - 2;
>  			length -=3D opsize;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-mptcp-mib-=
inval-opt-v1-0-84a553c552b6@kernel.org?part=3D3
