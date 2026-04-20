Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF1935C190
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776677508; cv=none; b=tdttrwW17/0xNRknd8SSWets3SYWNTwXzMknDH02O5PnWdSP5XP8SviO0tI/968hMWmZpwFl+0I4W5bCQzZAjUpEQFgRS1ZL8uZtq8CB4AA8FO1jU94OwwNoCxTRGw8zi8MoN2uPahTcKk98ZnW8Y/DEYihuWyaxfF3UTPNOxp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776677508; c=relaxed/simple;
	bh=vN4K572GEKAolvPSbrwEQ4fcA8oflsjqkuAbbYx16cs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=J9E8Mq5wdB2n8YJc8SPLjbhH7Fbt8fsCEwSVrvMkcYkwE9/wIMHbtROKcYzi8KQTkvMykAE3eZqWPtE2H/yxiOw1+lA5tJUDi58MtErdzMjxxoAy/Vq6/DdmyvfsmoPxP/1lpdPy+i1w6Ktom1656UWxz3oJKggn6h6DinSmlIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JYygtrjd; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JYygtrjd"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776677504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFfrssvnRUrsfrHGRjeL38nmcx5C2upnYt7VgscEp10=;
	b=JYygtrjdiOkVam3JTST8cJ5d3kkX/LEg9Ioei7WkV9xuh8b2j0sbVSfQLfvS4UIKmVgQtl
	DVPQ3iF8Abl0X+xgSN+Bylfeo9UdWcmUkiOfLcmgu7Zpn6WNzL8ZEn7p1LczTSB5o8LokU
	Nud+AxxQ+1jJWThj540VdetaFUuwFFg=
Date: Mon, 20 Apr 2026 09:31:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <7b58555aba7fc56f135ee198a592e4d72e01f849@linux.dev>
TLS-Required: No
Subject: Re: [RESEDN PATCH mptcp-net] mptcp: update window_clamp on subflows
 when SO_RCVBUF is set
To: mptcp@lists.linux.dev
In-Reply-To: <759c28ad07974bee4f83d69bd85ab5477690c0da@linux.dev>
References: <20260420085613.4650-1-gang.yan@linux.dev>
 <05de925c-b9e6-4e85-997c-e98fcadc5980@kernel.org>
 <759c28ad07974bee4f83d69bd85ab5477690c0da@linux.dev>
X-Migadu-Flow: FLOW_OUT

-------- Forwarded message -------

From: gang.yan@linux.dev mailto:gang.yan@linux.dev=20
To:=20"Matthieu Baerts" <matttbe@kernel.org mailto:matttbe@kernel.org?to=
=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3E >
Sent: April 20, 2026 at 5:30 PM
Subject: Re: [RESEDN PATCH mptcp-net] mptcp: update window_clamp on subfl=
ows when SO_RCVBUF is set

April 20, 2026 at 5:24 PM, "Matthieu Baerts" <matttbe@kernel.org mailto:m=
atttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%=
3E > wrote:



>=20
>=20Hi Gang,
>=20=20
>=20 On 20/04/2026 10:56, Gang Yan wrote:
>=20=20
>=20=20
>=20 From: Gang Yan <yangang@kylinos.cn>
>=20=20
>=20 Add __mptcp_subflow_set_rcvbuf() helper that calls the tcp_set_rcvbu=
f
>  to update window_clamp, in addition to writing sk_rcvbuf. Use it in
>  both mptcp_sol_socket_sync_intval() (setsockopt path) and
>  sync_socket_options() (new subflow creation path).
>=20=20
>=20 I didn't review the code yet, but just a note for next time: please
>  don't use the RESEND tag if you did a modification, even if it is only
>  in the commit message. Instead, increment the version and add a
>  changelog describing the modifications.
>=20
Thanks=20for the advice and reminder!

The reason I sent this patch with the RESEND tag is that I wanted to
trigger the CI checks, especially the AI reivew, to see if there are any
issues that need to be fixed. It seems my previous patch didn't properly
trigger those tests.

Thanks
Gang

>=20
>=20Cheers,
>  Matt
>  --=20
>=20 Sponsored by the NGI0 Core fund.
>
