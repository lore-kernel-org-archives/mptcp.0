Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775354CCDDA
	for <mptcp@lists.linux.dev>; Tue,  1 Sep 2026 05:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788242115; cv=none; b=NhmNU0A+VzBRXw2mWnKdGl0vp9mYFgith7j3QyQ9PIMHIS4Rv8sENIiRqySXEvdnjSvS2KRuYq8pa/11MtUaP1K5MvuwxHWDBdRdjxFIvZn5F6DE6CuxUS0gaaMB/BclogUPnEu7xh/tBwS1/L2cyOhJIaW0eDNg0pmssBtuMNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788242115; c=relaxed/simple;
	bh=HfAay4Ieqe1BumcZqYRXx7Q4/APKydmJaTDR8eoHJRk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=eMmGTozrPOUrA6xPD7gbxhlBBfNgU6qpJ13XdJpjaXmGz9SGTp4TOTx0LcEozeXCq6uM0Ndosa2Zn5hYOKHKhFYKbUBQbRgWYhaYGrektTvPgKaewu7MySjka9mUd6KUOyjclIhRSCfwyx43O1xPE/DxW39cHp6BCQFQ7omBeg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgndKl/7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgndKl/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D831F000E9;
	Tue,  1 Sep 2026 05:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788242114;
	bh=HfAay4Ieqe1BumcZqYRXx7Q4/APKydmJaTDR8eoHJRk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=GgndKl/7PxwzCpzQGXlL2aH8A4aQEfzP6UyhQleKVLQSO//nb0jJOKgDwGW69543T
	 5Jnt1l8R8IN5cvQak/LeRIK+mvgD2OMPnhivzc6X9pYXoE6O+MoVqj/fYUR4PbaPzr
	 L/EzHvLGMZooVE4B7MwdKOXx1nj+EkscwCZOz7fm+Vu6FFhjb7i10ORDxtDI7g/rIJ
	 JDKz6fe8tkLIKwRM6IBtz/s66NBbEAmZRL2dMoJiTamajt9YHvw1j5Nqe9dptQUlQv
	 GIkDld9WtjXSdGuB/xEUY8m/pO/pTOHQg2QzH9c+00HkyqZhPZWjsxInQXQQTnrwOh
	 qX2QOYOVjAGnA==
Date: Tue, 1 Sep 2026 07:55:08 +0200
From: Matthieu Baerts <matttbe@kernel.org>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp <mptcp@lists.linux.dev>, martineau <martineau@kernel.org>,
	pabeni <pabeni@redhat.com>,
	"shardul.b" <shardul.b@mpiricsoftware.com>, janak <janak@mpiric.us>,
	kalpanjani009 <kalpanjani009@gmail.com>
Message-ID: <22e3fc57-a6e7-4a72-a6c1-1d6b3bc39f3d@kernel.org>
In-Reply-To: <1a05b681764.2d9af68b190464.2524660538561791488@mpiricsoftware.com>
References: <20260827041058.2833707-1-kalpan.jani@mpiricsoftware.com> <f0fabe59-0a2b-4df9-983d-446eab20104c@kernel.org> <1a05b681764.2d9af68b190464.2524660538561791488@mpiricsoftware.com>
Subject: Re: [PATCH net-next v2] mptcp: normalize seq numbers reported in
 mptcp_info
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <22e3fc57-a6e7-4a72-a6c1-1d6b3bc39f3d@kernel.org>

Hi Kalpan,

01 Sept 2026 07:19:21 Kalpan Jani <kalpan.jani@mpiricsoftware.com>:

> Hey Matt,
>
> Thanks for the suggestion. I dug into msk->first before reworking it.
>
> Turns out it's only ever set once (either connect side or accept side) and never reassigned to a different subflow after that, so at least we don't have to worry about picking up idsn from the wrong one later.
>
> But it does go NULL independent of whether other subflows are still around, and it's not even a rare thing. I added a debug print in __mptcp_close_ssk() and ran mptcp_join.sh, and it happens constantly with other subflows still in the list. I couldn't find anywhere that write_seq/snd_una/ack_seq get reset in that case either, so reading idsn/iasn straight off msk->first in mptcp_diag_fill_info() would need a NULL check, otherwise it'd crash pretty often during normal multi-subflow use.

Thank you for having checked.

Is it not only set to NULL when the whole msk is being destroyed? So
yes, it could be set to NULL first while closing all the subflows, but is it
an issue at that stage? Maybe you will need to add an extra check to
avoid a crash, but (I didn't check) maybe there are already protections
in place and it cannot race.

(Note: I'm not on my laptop, I didn't verify this)

Cheers,
Matt
