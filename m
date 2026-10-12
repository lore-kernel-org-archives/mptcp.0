Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BDD3F9263
	for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805310; cv=none; b=ezzi+stAjHm7IGurhAy180Cy99ZQH6PdYrMkJTEUzK1Cb9u4Q1evVI50T+WNgcGVLn6nrAcZIxS+gUU3qsJynlYldEDw5EJXSi6Oe4EuAUxEgvYsSJBFfZVTRL5VG3FjCmNshfZ+QHzIDqxY/g5i/NgPU4bTDDwbK1WK8nM3ytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805310; c=relaxed/simple;
	bh=oRAY0cXy3whsyraPG7ScjsgRxN/E3IoqG9YPP43j27Y=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uu05PTW0Q5Z7pK9S4fvuDwriCA3XT4KlPdIAaXqKo4LaWNQqyN3sMDzUInoXbwc9XPsQYPOiS2vcbX8b8iCLAnPyOFuzwkqZmfjtmu5p1Ot08/HdXc2ern8CFyunH4k/7hx6AupUCz6apHIyecqYa/EBd4sg34eE4dksdS1TShw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgP+CcrR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgP+CcrR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492E71F0089B;
	Mon, 12 Oct 2026 11:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791805309;
	bh=0dOAaGqZQfP22XYdlUF1636mWnPGBNXltM8Gk23thBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kgP+CcrRyIEEKjHfov/TnMuYPJKkVABnO66Cu26WtZhYyah7Ie8eebYpftWrKal4h
	 God8ySUAPzLN5GfgxFFsW1mHVGLtiykV52yiNSCyiUr9dIqHoyo5ZZHshxLm6JSX/C
	 42PId/7baeu4RewPO0XIFE6gSCdmNQL3G9OaO9fQNDIljTqCcpLj/tCwBCbEqHB1BM
	 XiGSjtimPIcOeiOU2qCxTNj8E/8NGG2PbrPDPnwq0LNHDW/X+RhyDl13ytA0QIUhy8
	 JdATQNunuTBgL+AibzFk/h6P24q9ltkkKlhQzMaB6qKXCdVXiwhNXSIq1xk5P1GmTR
	 +MkfnVW2p+0Bg==
Message-ID: <sashiko-outbox-168024@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net] mptcp: reset MP_JOIN subflows on missing or
 invalid DSS options
Reply-To: sashiko-reviews@lists.linux.dev
To: "T S Rameshkumar" <rameshsv06@gmail.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20261012112625.578911-1-rameshkumar.t@phytecembedded.in>
References: <20261012112625.578911-1-rameshkumar.t@phytecembedded.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 11:41:48 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mptcp: DoS and skipped stats via mptcp_subflow_fail() on MP_JOIN
--

commit 7946d5d8343cbb66aa7761dd1659532067edd960
Author: T S Rameshkumar <rameshsv06@gmail.com>

mptcp: reset MP_JOIN subflows on missing or invalid DSS options

This commit enforces RFC 8684 section 3.7 by explicitly resetting
additional MP_JOIN subflows that encounter missing or invalid DSS
mappings. It prevents these subflows from incorrectly falling back
to regular TCP when fallback is already allowed on the connection.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/544

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 2c72cb50fbf36..421832874cc62 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1446,7 +1446,7 @@ static bool subflow_check_data_avail(struct sock *s=
sk)
>  	return false;
> =20
>  fallback:
> -	if (!__mptcp_check_fallback(msk)) {
> +	if (subflow->mp_join || ssk !=3D READ_ONCE(msk->first)) {
>  		/* RFC 8684 section 3.7. */
>  		if (status =3D=3D MAPPING_BAD_CSUM &&
>  		    (subflow->mp_join || subflow->valid_csum_seen)) {
>  			subflow->send_mp_fail =3D 1;
> =20
>  			if (!mptcp_subflow_fail(msk, ssk)) {

[Severity: High]
Is it possible to trigger the WARN_ON_ONCE() in mptcp_subflow_fail() when
receiving a bad checksum on an MP_JOIN subflow?

In mptcp_subflow_fail(), we have:

net/mptcp/subflow.c:mptcp_subflow_fail() {
	...
	if (!msk->allow_infinite_fallback) {
		spin_unlock_bh(&msk->fallback_lock);
		return false;
	}
	...
	if (WARN_ON_ONCE(ssk !=3D READ_ONCE(msk->first)))
		return false;
	...
}

Could a remote packet with an invalid checksum on a newly established MP_JO=
IN
subflow hit this warning before allow_infinite_fallback is set to false?

Looking at mptcp_finish_join() in net/mptcp/protocol.c:

	} else {
		/* defer the graft to the msk lock holder */
		set_bit(MPTCP_WORK_RTX, &msk->flags);
		if (list_empty(&subflow->node))
			list_add_tail(&subflow->node, &msk->join_list);
	}

If the user holds the socket lock (for example, during recvmsg()), the subf=
low
graft is deferred and msk->allow_infinite_fallback may still be true. During
this window, would a bad checksum packet processed in softirq bypass the ea=
rly
return in mptcp_subflow_fail(), hit the WARN_ON_ONCE() for the MP_JOIN subf=
low,
and potentially cause a kernel panic?

>  				subflow->reset_transient =3D 0;
>  				subflow->reset_reason =3D MPTCP_RST_EMIDDLEBOX;
>  				goto reset;

[Severity: High]
If mptcp_subflow_fail() returns false and we branch to the reset label here,
doesn't this bypass the MPTCP_MIB_DSSRESET counter increment intended by th=
is
patch?

If msk->allow_infinite_fallback is false, mptcp_subflow_fail() will immedia=
tely
return false for an MP_JOIN subflow. Does the resulting goto reset unintent=
ionally
skip over the new MPTCP_INC_STATS(..., MPTCP_MIB_DSSRESET) below?

>  			}
>  			WRITE_ONCE(subflow->data_avail, true);
>  			return true;
>  		}
> =20
> +		subflow->reset_transient =3D 0;
> +		subflow->reset_reason =3D status =3D=3D MAPPING_NODSS ?
> +					MPTCP_RST_EMIDDLEBOX :
> +					MPTCP_RST_EMPTCP;
> +		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSRESET);
> +		goto reset;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012112625.5789=
11-1-rameshkumar.t@phytecembedded.in?part=3D1
