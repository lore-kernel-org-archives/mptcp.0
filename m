Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4081443DEAC
	for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377905; cv=none; b=S2MyYpEov6AVQxGN2TSqEHZDER1+qgza5ASAUXJGpe6WmYxrdxqfaJTI2rjq1c4GTXUyU9aRQrqTouF/FB/8s82L+oERjhdgr+CMwGdPqM0YbcB3shTZDMgHJuIxPeEMULtA+MTWhQU/gpvYhJohK9lfDKcTUS0+zRQ/qwGWJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377905; c=relaxed/simple;
	bh=TCdShcALVSGlSWsoAgypkwanaY+LaCKMe0ZJtWsdRtY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f5z+6yZhW1nctCZwJ4u3pUtEYBBMS40gFzDkzH1JpqnnU43F+Sb0Juc9n0ay+Bo4oIp+PXVVpaE+bi9jWklKAHGCMZ0fsndR37davdFRDYG6HU6J2fsGZHGNCtOj0obDE9jg9kNuk35LlMja6NuBcopKIZyLgFBitYOqcHD5vVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtCWvyvq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtCWvyvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C699E1F00893;
	Mon, 14 Sep 2026 09:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789377903;
	bh=HBvZlcKyO9AswgGROdfYso37QBJuuEVFgxRvIKa+drg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AtCWvyvqO4np3gNBwIVfyUcZyacfdO5uIFAu4cO59oYIuLyLOs/8Maod/W4tt9zDN
	 HxfenYkjmJQVyJD5Xz84cvr0ViBjlEPSJV8q9K/30Dc3soCLR+nXHMg2mcbLXSC3SJ
	 T8mUwmHSRaklEOU1HrIaBQgezTOux1suqYy5Jlp9QlD4EG8tHID4zusijdy8J6W6FA
	 n8hEYMdo4g82AtuCG+g+Ckkb5//aWCZcR+5QG6QIQGQkJI2z8u1v3jaTf0QWBBqs6j
	 cx8k2n4ttT5/oqV2PwyauCDlThQXrG6Ag7kKY4Qn5Kp7D0cAqbaiPYt00+bjwXGiYE
	 rP25+Lypzsurg==
Message-ID: <aee787ffef5dc72674010d3d16987c3fd37306db.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 05/16] bpf: drop duplicate
 check_app_limited in tcp_bpf_push
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 14 Sep 2026 17:24:55 +0800
In-Reply-To: <3b241101-f090-4228-aa8c-b25f61c4aa40@kernel.org>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
	 <aff272cebafec60a4d2080ab1626946870d1262b.1789294365.git.tanggeliang@kylinos.cn>
	 <3b241101-f090-4228-aa8c-b25f61c4aa40@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

Thanks for the review.

On Sun, 2026-09-13 at 20:18 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for sharing this!
> 
> On 13/09/2026 12:14, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > When the sendpage->MSG_SPLICE_PAGES migration series replaced
> > do_tcp_sendpages() with direct tcp_sendmsg_locked() calls, callers
> > that had used do_tcp_sendpages() kept an explicit
> > tcp_rate_check_app_limited(sk) that was originally needed to cover
> > do_tcp_sendpages() (which did not call tcp_rate_check_app_limited()
> > itself). After the inlining, tcp_sendmsg_locked() always provides
> > the check, and the outer call became redundant.
> > 
> > The site changed here, tcp_bpf_push(), is a MSG_SPLICE_PAGES loop
> > that holds the socket lock and only iterates when size > 0;
> > tcp_sendmsg_locked() is invoked on every iteration with state
> > identical to what the outer call sees, so dropping the outer call
> > is safe and behavior-preserving.
> If it is not related to MPTCP, could you please send this patch to
> netdev/bpf directly?
> 
> Also, should this be seen as a fix? From what I understand, some
> behaviours have changed, and it is only recently that this call is no
> longer needed.

I just sent this patch to netdev/bpf, along with another TLS one.

Thanks,
-Geliang

> 
> Cheers,
> Matt
