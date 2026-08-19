Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA536330B15
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138838; cv=none; b=loWEyxqLgP7gPdjUR7S8XElu3IbxhlxWXGCFK4mIFURaacS7QPLSNWDIVFOt3+WJcrcBOAsn0Wgq4BHrJw5HcnaDkJHyCSHtlyWJMrgCE0vvGMP1odW8BzjVV+oxrM54iDchvwvQl0Lm+qCdYw2XNtcvPcC5rZka33g2TmY+mMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138838; c=relaxed/simple;
	bh=iRSHK7x71+ierPBeY0QFvxAKbGr6DCITnhUFQM+C9m0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VwTimsk4lsoUz67j9a2TxJDcNpkDhIWI75EPkj8HBZAyYyfXJ8CxKvXfZp1ZMYx2vu0GQNWxy4j/NzRbtkhjpUyS8Y/LWlD35v7w3xqMnn+LwyyTE3WkcE3WK706r0SkC+oaJJ2NKPO6wDmYRzJgspn4+DYSiDcaFolVQgbPk2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVzN5DtZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVzN5DtZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439121F000E9;
	Wed, 19 Aug 2026 11:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138837;
	bh=o1xsvcu9WCcDz2hLNwphuV7pQCRYEuKur+eqoXgaWIM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NVzN5DtZJ/ifufv0tcjq0dU2Xrl0F1/0FTpOiQPteUX+2fGqUYmxOyk1dAATzSW/Q
	 1AOT4R3qVbuvqJsMC7jTYhOwQC7Jy0gHftXUgiTOj264iFZOMYUxt79ToGmPV4krAL
	 al8RCduLmGyWVLJk4IunVBE30ujwRuufI6Ap0l65GuE0BLvNjxLIbcVACSDkw/F6ct
	 f2KKjBH4J0Xd8bQg9xOqhjMQSRGgALJnuLEvNry54bz8+0E5iij4b6YOsvYBtM6DH1
	 z5X4iObqUwKUTOnOTbK5eS5+SuA+tbVG6yFrNF9ddOP2YEUEWy5Jx2HBziBROVYqUd
	 H/gB3Zd5zqfog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next RFC v5 1/3] mptcp: add MPFailFallback MIB
 counter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chenguang Zhao" <chenguang.zhao@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260819112112.1985121-2-chenguang.zhao@linux.dev>
References: <20260819112112.1985121-1-chenguang.zhao@linux.dev>
 <20260819112112.1985121-2-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:27:16 +0000
Message-Id: <20260819112717.439121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added MIB counter MPFailFallback is never actually inc=
remented, rendering the feature non-functional.
--

--- Patch [1]: [PATCH mptcp-next RFC v5 1/3] mptcp: add MPFailFallback MIB =
counter ---
commit 1a92bfe5b7b4b89111b623a355d85f37a5901375
Author: Chenguang Zhao <zhaochenguang@kylinos.cn>

mptcp: add MPFailFallback MIB counter
   =20
Track fallback triggered by MP_FAIL reception.

> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index 608cb568897cf..e1211ad621c9b 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -91,6 +91,7 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
>  	SNMP_MIB_ITEM("DssReset", MPTCP_MIB_DSSRESET),
>  	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
>  	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
> +	SNMP_MIB_ITEM("MPFailFallback", MPTCP_MIB_MPFAILFALLBACK),
>  	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
>  	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
>  	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 1ebdb55e95343..b006fc8cc848b 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -94,6 +94,7 @@ enum linux_mptcp_mib_field {
>  	MPTCP_MIB_DSSRESET,		/* MP_RST: bad data mapping */
>  	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
>  	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
> +	MPTCP_MIB_MPFAILFALLBACK,	/* Fallback after MP_FAIL received */

[Severity: Medium]
Is there missing instrumentation for this new counter?

The commit adds the MPTCP_MIB_MPFAILFALLBACK counter to mptcp_snmp_list and
linux_mptcp_mib_field, but there doesn't appear to be any code in this patch
that actually increments it. When an MP_FAIL reception triggers a fallback,
should there be a call to update this counter?

Without an increment, it seems the counter will perpetually remain at 0 and
won't accurately track the fallbacks.

>  	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
>  	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
>  	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constraints */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819112112.1985=
121-1-chenguang.zhao@linux.dev?part=3D1
