Received: from mta1.migadu.com (out-54.mta1.migadu.com [95.215.58.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A66B444706
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611597; cv=none; b=QaTrwkE4B/T7hjhwafyzvtcfvbtnpJMIS7q6gXD/mYEZuDZ3kr5pQxqmYF8ThSsrpbtWyCG9YLb3hDwCC6WHqAIyTOdM0OV4koIJiqRxUwyUTAmrGgLiHNalV2322hN6c+FnE0hUBpI/CBZx56URAQGiDWAhzCwPNZb6/hGhhlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611597; c=relaxed/simple;
	bh=hG4pUdWhtROAMwC1od4LU9pTb79XD6nACi/4QO1q0FM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=HGaJ3loEpsQEPeAXM//qnO+DOivyHwsmC3ifW/Xelo4ytUJgmP8HCXx19jnYW7i64mXxQw+xixH83xmkD7mdZBavnEPffIbq/hID1QSizpjsQ1gW2DYoJhKcPmA2f7LytM/sCitRIjai/hFJlFDTMf6OXbLewha112mWO73aVKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JuZIvylu; arc=none smtp.client-ip=95.215.58.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JuZIvylu"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=hG4pUdWhtROAMwC1od4LU9pTb79XD6nACi/4QO1q0FM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786611591; v=1; x=1787216391;
 b=JuZIvyluCroKEPO69pZET5ISDaQv6wC0dlyXWlo/0zD2FLR66oFrDPJA9jPAZLrbqzzpTb56
 sWHoqYQE6zQAnhm7uCU6MhmUACaJqaSpOHK0CDlhG2QXcPY0dFtpUHMkNUwlMreGs+/f9WAU/un
 2tZmXK4sMMsEQGrZ5qRXaETE=
X-Envelope-To: mptcp@lists.linux.dev
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by mta12.migadu.com with ESMTPS id 8f21aac798889bf4;
	Thu, 13 Aug 2026 08:59:50 +0000
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 08:59:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <9db96388a1c72d264d0576e0a58f4944560e93a7@linux.dev>
TLS-Required: No
Subject: Re: CI failures on nipa
To: "Paolo Abeni" <pabeni@redhat.com>, "Matthieu Baerts (NGI0)"
 <matttbe@kernel.org>
Cc: "MPTCP Linux" <mptcp@lists.linux.dev>
In-Reply-To: <02830f64-bb5f-41fc-8211-5f7aa36b828e@redhat.com>
References: <02830f64-bb5f-41fc-8211-5f7aa36b828e@redhat.com>

August 13, 2026 at 3:57 PM, "Paolo Abeni" <pabeni@redhat.com mailto:paben=
i@redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote=
:


>=20
>=20Hi,
>=20
>=20I'm looking at this one:
>=20
>=20https://netdev-ctrl.bots.linux.dev/logs/vmksft/mptcp/results/776501/6=
-mptcp-connect-sh/
>=20
>=20the output is strange:
>=20
>=20https://netdev-ctrl.bots.linux.dev/logview.html?f=3D/logs/vmksft/mptc=
p/results/776501/6-mptcp-connect-sh/stdout#L114
>=20
>=20the first nstat dump includes apparently the counters from all the
> previous runs, which is unexpected: the nstat_init/nstat_get/pr_nstat
> dance should allow showing the data from current run only right?
>=20
>=20Also I think mptcp_lib_wait_timeout completes too late (after ~60 sec=
s),
> when the listener already bailed out due to accept timeout (after ~30
> secs), so it does not show any info on the listener side. I fear it may
> also race with the actuall `timeout` command completion showing socket
> states after the user-space program completion.
>=20
>=20Judging on the final status, I *think*/*guess* the (re)connect is
> hanged, possibly due to bad remote address?!? It could be useful to
> print out on stderr the reconnect destination address.

Hi Paolo,

That reminds me of an issue when I was reading mptcp_connect.c a long
time ago:

At the end of 'sock_connect_mptcp()', it calls 'freeaddrinfo(addr)',
the 'peer' pointer (which points into 'addr') remains. Later, the main lo=
op
uses this peer pointer for reconnection attempts. If the memory has been =
freed
and reused, the address data could be overwritten, resulting in an invali=
d
remote address.

That might cause the hangs or failures you are seeing, right?

Thanks
Gang

>=20
>=20/P
>
