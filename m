Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723565;
	b=rVJgKrrHji2C7hjXHe/Oo1K1Md2rVz8pjJ0WmWxdVqKYcuK4EES/8u0IAxz/8z9V++I2
	 trfhkU9QCEfShgM24uQhmw0INw+CbXRgJHbikGoG5rnZk3JvQ8pVOuccHbCk42BpNkAvk
	 viM3lViIdQnnRMChnix3RcG/X27O1jV3K2tm/n4T2MMwHvKaBhCDHupmsCYnrpZvbe7CL
	 lv5HiErxIaoBUHL1WKCEUFP7J43l6pn5O0zPn/oXcrmPYw/hSh9zMqd+gLk4yqaWmfXNM
	 x78SV4oJXIFQrHPQV8axpHCbe4CeRssNP7pvUQyCAw1K8yj8hOVSqGMMkjtoaM46n+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723565;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=j4l3RHtnutiuu4WYYcb84aTh1xNKki2Jy4sxU1o8nIU=;
	b=B31rzFFInwZCXums0Nh3kDG8dv8WbgiVxncHFJBP2L9Nt/HjcC01QLWncuSnVmyqlw6n
	 I8na3D57LSD9h1gM7oNvOWuJ00Y4SMGKnyk3yYW4Js9Zj39rNj5h7/z7Ksr1NSMxGPdKh
	 YQksAPnT4jL1fXsYlYvkDqUaORTMGLlJI8y61jMHQgOkUZjjoEiTlPtCeon/ssVHE2N2F
	 m9YoWj0fHsR3t3ISx/fTHdxP9LCzT5FuNvYu4ASqI7++V26OPPoezvGWIQ2pMXMfgEqqy
	 YHOubpNG7f9p0N3AB7rbk+XK+Kkrhvp5n3av8ZmJpWmlMSYApP9aziXI/yUiEnWEHBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VbDWDfs9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A98606A331
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VbDWDfs9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A261F00A02;
	Tue,  3 Nov 2026 16:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723565;
	bh=j4l3RHtnutiuu4WYYcb84aTh1xNKki2Jy4sxU1o8nIU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VbDWDfs9c+5YUGiLHJgpnTiPibHyi8pMPS04yftwfQbJ2fTkrYvQp/EqFZVpVRYmL
	 aEb3jXK3e/XIyZtzi6c8lcD4jqupsEBnNkMY07E8zKxQSTcXLIa0QuWM87AF8sqVDU
	 QCv2uB3KrMKFXEtMk8NdpM2l1Xk1Z5ai1RCYG4UjC/BFRZlTugCQKZzJTBT2s7SfNe
	 tAhlfmJ24vwcYGP/iowUcytLyqvmzM4keByezhYRS/1UfmdSrhHcv4EFK2fcoAafRE
	 XLOeZYO504tHxDGL9T59+haj7YpcX7BNbmjaszycZu3evXYCj+rq4HL618+0F8PApQ
	 npmnyGOowSbew==
Subject: Re: [PATCH mptcp-next v4 3/5] mptcp: add sendmsg_locked to proto_ops
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Tue, 03 Nov 2026 16:32:44 +0000
Message-ID: <179372356452.488855.7654784964456927094@kernel.org>
In-Reply-To: <82703a59b6e23ff521082b1cfaa36b1ffb1e36a1.1793588257.git.tanggeliang@kylinos.cn>
References: <82703a59b6e23ff521082b1cfaa36b1ffb1e36a1.1793588257.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit's author identity (Geliang Tang <geliang@kernel.org>)
  does not match its only Signed-off-by (Geliang Tang…

--

mptcp: add sendmsg_locked to proto_ops

This commit splits mptcp_sendmsg() into mptcp_sendmsg_locked(), which
expects the caller to already hold the msk socket lock, and a small
wrapper that takes the lock around it. It also adds an msk_owned_by_me()
assertion and sets .sendmsg_locked in both mptcp_stream_ops and
mptcp_v6_stream_ops, as groundwork for kTLS and sockmap support.

> Author: Geliang Tang <geliang@kernel.org>
> ...
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author address and the only Signed-off-by
address are different. The author is geliang@kernel.org and the
sign-off uses tanggeliang@kylinos.cn.

checkpatch reports this as FROM_SIGN_OFF_MISMATCH.

The first patch in the series, "mptcp: update mptcp_check_readable",
signs off with the geliang@kernel.org address, so the addresses also
differ across the series.

Could a Signed-off-by with the author address be added, or the From:
line changed to match the sign-off?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793588257.git.tanggeliang%40kylinos.cn
