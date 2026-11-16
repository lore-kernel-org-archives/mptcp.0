Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794800669;
	b=MXP/EatpPwyzGuOgwSYw/G9MDgHIA2BgplQzdZUNQIr7r4q3nr/RbMikEmHEwKTV4nZq
	 ZkVVAUMr+VpsdAYT0a70PnOCwVec9inayp45NZTulPGYNVRupDn6C3vIVAVtLVYlY6/c6
	 6TtjE++I9ACERB27VR/cnfutBqr2ssQsgW9Ag21r3HZNsCxBJI0s3fYtTupSz0OMmcDRU
	 VK/10hIpMqhyd3L5zQpvvNyx3WlnmREwrQPPZgR5WrDMJKshzzhH1T92krjbsHHRjdXK0
	 M9oijrIy67FCI/0lMeI6av2UtP48rCvSWfdhzOeVsG2PXsXmo1qIzfzC9F/nutlncqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794800669;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ykFSaTKhcufjuEXc/FIdRKy71inJr6qVh847+Nflxzo=;
	b=rXTq35kMzunCEWUcwjrHNKiumJ/XSKpScbDbSbxM36lQUWFLUPliRlvxt5m/VtiJvI9k
	 1+vp9yEZfMh8wx//bws6rNWg909ABSU2A0s/p3LIufnNNTtF+YIowVtTc9p67Bj6YSgDY
	 39Mh0RouC3m7hcjAVgUhcwmfgvMAL0HXWB/CO/LLR9DRtgeWr4qQY8Fb5X8eZ67lOyp4f
	 uxknexCXCiANA/aezYG6uJFRFexsdqbdRmSYUOiO0DpfDtguXC7nav0BspBbhZ2OLIKOc
	 7pS9yL5nLpFqg+3LiPxMs70UvbrW42rNL+SfPJX/WcfMrHrrWPx60i12o7sfepGJHtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FyAFRtJ2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8ED606A31C
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FyAFRtJ2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900121F000CF;
	Mon, 16 Nov 2026 03:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794800669;
	bh=ykFSaTKhcufjuEXc/FIdRKy71inJr6qVh847+Nflxzo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FyAFRtJ2g95cJSkHdxmDrjllSMzUy8/owYOMSRl5bPYX+Di2Q+jsyscuBRqUXhV8z
	 4QhaIBlpI15Ryqjd/pUB+rKswb0LUpk/Eb3Wfvre9b84xnduciKk9Wyb67Kksox22S
	 AdhUwR/kUSfi7Gs3Z6W7aF4JM+qvG16QCBff6X9ezvCoh1OjYICNOu8tLHLM6Ow9w1
	 /lct9via73yhfTxJvHQENv+eEVnX5opngpFU7WcHiNqRzuCTtq+phpD+gRWfojW7GU
	 ZfX1Ye6McpMtUB0stpz/chQeO+QSjNrseUMXXw+e1ZGpG8T9Pq0US6MuxdSxWIgybx
	 522qy5oWCF5Rw==
Subject:
 Re: [PATCH mptcp-next v27 8/8] mptcp: defer read_sock cleanup to mptcp_worker
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 16 Nov 2026 03:44:29 +0000
Message-ID: <179480066912.3133.3494569668430304143@kernel.org>
In-Reply-To: <452510b9a13bce34222d39b12b6ca78bfe211e36.1794663678.git.tanggeliang@kylinos.cn>
References: <452510b9a13bce34222d39b12b6ca78bfe211e36.1794663678.git.tanggeliang@kylinos.cn>
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

- [Low] The commit's author identity has no matching Signed-off-by.

--

mptcp: defer read_sock cleanup to mptcp_worker

This patch gets __mptcp_read_sock() ready to be called from BH context
for future MPTCP TLS support. When the caller does not own the socket
lock, mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf() are deferred to
mptcp_worker() through msk->read_copied and MPTCP_WORK_READ_COMPLETE.
The backlog flush in mptcp_recv_skb() now runs only when
sock_owned_by_user() is true.

> Author: Geliang Tang <geliang@kernel.org>

[ ... ]

>     Suggested-by: Paolo Abeni <pabeni@redhat.com>
>     Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author and sign-off emails don't match. The
author is Geliang Tang <geliang@kernel.org>, and the only
Signed-off-by is Geliang Tang <tanggeliang@kylinos.cn>.

checkpatch.pl reports this as a FROM_SIGN_OFF_MISMATCH warning
("From:/Signed-off-by: email address mismatch").

Could the author be changed to tanggeliang@kylinos.cn, or could a
Signed-off-by for geliang@kernel.org be added?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794663678.git.tanggeliang%40kylinos.cn
