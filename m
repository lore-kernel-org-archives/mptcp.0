Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA0F3D45FE
	for <mptcp@lists.linux.dev>; Sun, 20 Sep 2026 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789885748; cv=none; b=qj/8r2/d3l+Bw++O/cTVix9YjmjMq5wyCYvzDtEJNu+qBU3vuITscOjjTYD1TKCe6MdF7Pnr1s0S+B8Mgl1+lXGoT7qtWH3UEnTJiXgP/AIon+OnOfM4uPUHB9XMZZQUFYvnIphAfSaYM/iPWnOp0MlYzyeTp1MIrNtiwpzs9Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789885748; c=relaxed/simple;
	bh=4/jtPHCZHyVSfIwUWmxPsqMcBinJzwyy1yOg7ergpB4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GGd3oGiy99KK1hdPQv3nX/DaoP9uQVHcfTTIvTOcuu2d7dY9W5jjYP1HLxH4gqaI0QSF0i7TCx+GFcIq8jzXoBiCcCc2QKzyPyzfWy8AkDH6yRfIJHx9kNqO9ya3K3gt1fI8t7dvHbcYETVam6hdA7kEwK4HSNPekER1jfthHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUFnhea8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUFnhea8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C3B1F000FF;
	Sun, 20 Sep 2026 06:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789885747;
	bh=XZQVgV7G4cs538b30n9W2qqR3XfB237DH3rsa/dqrek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HUFnhea8oQgGNfjBYJiu/IK9u2zM1ZUXexd7K9bVUynmBC+DBS0lStaW/BnyeeyqE
	 COv8lJakLKwEvOYs+8K5KR4SfOiEOHjPTSvxlhITZZOZTcJ8hY60UuXE/eC4hgGeKC
	 aFY99n+3CyDxg2Feag/Vn4GhC1qiTQgdsWk4dQsRAAC0OnrJrZqAHwpxGGSKW69th6
	 O4g4lFl2t9yZeD6FiIJhCj7uqwOhWbCgoLF0WcvO0Sf7SLShGdQrqiarLwchltQnTg
	 pr7lg7K6FlJndPJ5xezdo2NFLloNFebi5z0D5bdFMf+9GM//8R2qvhJygyo4MpBrWt
	 7jDWbQJ0jzfEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] mptcp: do not use Fast Open on MP_JOIN subflows
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yilin Zhang" <yilinzhang@moonshot.ai>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260920061904.3575780-1-yilinzhang@moonshot.ai>
References: <20260903094010.4066892-1-yilinzhang@moonshot.ai>
 <20260920061904.3575780-1-yilinzhang@moonshot.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 06:29:06 +0000
Message-Id: <20260920062907.21C3B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mptcp: disabled TCP timestamps on MP_JOIN with TFO due to wrong =
logic order
--

commit 7c8131d455e6d16e5fa896b1f57ebf371c13798d
Author: Yilin Zhang <yilinzhang@moonshot.ai>

mptcp: do not use Fast Open on MP_JOIN subflows

This commit disables TCP Fast Open on MP_JOIN subflows, as data on a subflow
requires a completed HMAC exchange. It updates the SYN processing path to
fallback to a regular handshake and strips the TFO cookie from MP_JOIN
SYN/ACKs.

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f0a6725d2c376..7bf94aea5f681 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -348,6 +348,10 @@ static void subflow_prep_synack(const struct sock *s=
k, struct request_sock *req,
>  	if (foc && foc->len > -1)
>  		ireq->tstamp_ok =3D 0;
> =20
> +	/* MP_JOIN cannot use TFO, do not send a cookie in the SYN/ACK */
> +	if (foc && mptcp_subflow_rsk(req)->mp_join)
> +		foc->len =3D -1;
> +
[Severity: Medium]
Does this logic order introduce a regression that unnecessarily disables
TCP timestamps on MP_JOIN subflows?

When a client initiates an MP_JOIN connection with a TCP Fast Open cookie
request, the original code in subflow_prep_synack() evaluates
foc && foc->len > -1 and sets ireq->tstamp_ok =3D 0.

Right after that, the newly added patch logic checks mp_join and sets
foc->len =3D -1 to reject TFO.

Because the timestamp check happens before the cookie is disabled, the SYN/=
ACK
is sent without both the TFO cookie and the TCP timestamp. Any remote client
can trigger this by simply adding a TFO option to their MP_JOIN SYN packet.

Could reversing the order of these checks preserve TCP timestamps by causing
the timestamp condition to evaluate to false when foc->len is updated to -1?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920061904.3575=
780-1-yilinzhang@moonshot.ai?part=3D1
