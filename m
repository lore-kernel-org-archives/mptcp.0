Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397763;
	b=EGQFSTj5DL81gQJIBYG/Os+A9qRJ5Ve0j84w8zjjwn7oBEFNLHceYG9ju3FwpysgeJ8d
	 EtsCYdt4XdD7WALrxgSrzBz7GID2YUxi4hOxnpEkCYwNQIvsg6Vnc8fH54dBtq5AFEE49
	 H/tUT/ht1QAAr+b41kEph574DXeWbmBZnK7J29uE5JPkmng5jQ0ydYHHVqT9lniLP49y4
	 Sp37HUFW2tzYYTcy2HMg1RJc8aKiuzV3tKmMEXu1ZxKezAM6NaqS/qeO6oIzV3+hSjqmI
	 SCZk1n6c96rsfOMY4E2xX8N39j5IQ1/tyhROX3dbtcZr6jS+3TmTC0Q3PB93bXZ2unA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397763;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zchTmTieuRk2y4aBcUCZPCKEp0SGITFDhSUeTJB5Vu0=;
	b=cs+JtJ1N5t3jV3lPOCCwWQN9epDmRLFi1bRPDtLh7mxooBh8c3171b5E8YJwENleVHam
	 sgmzpBv/pWKYfhxNuI4N2ZpUtrPLOlHZD2H9BjRynfFl1G98DPJ2eKKOQS9cfqw7Sv0LJ
	 7tSSO+iIXiE4haFcW8SM9ASXJH+I2amlSbg66Lp6F2yqhtBtOFxk7mIDcddj/djrf5RbX
	 ySAVSRGdQcALBHzsQJw9TmRJ3GD9gglhCY9a/Sw+Pf+N8SklR3sjDevEkFVmNVkGmJQSq
	 dWkjVh5D3L2aJwkNOsYj5OrmynINaxEJanmYfFSIPhfTrEmKm0hq1BWVjiiy/uiZn3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HEAJRZLN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA43A606A323
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 22:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HEAJRZLN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6155F1F00A02;
	Fri, 30 Oct 2026 22:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793397762;
	bh=zchTmTieuRk2y4aBcUCZPCKEp0SGITFDhSUeTJB5Vu0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HEAJRZLNBSx+Yl13FPi+CwPtkGnwhiXRRpyXNLjdsrlN3FfKaOH5du1U3ABBjjJMf
	 CgugHXhiLJ2KTTufgqhj2NnTtfYpIS76TMWxBOZH/vW28dDRgGM7dtwz6bVmsEqd43
	 XyXiyS20z69fVIdCQ+U0MnZ8ZhQw5U69nCCWl4f+fQAlfrJocTnqZLlV9dRSX2SXqp
	 9BEIberBYqq9vmsDiFQ9rJSnfSHFLYepACWEDqTONwhfgzhJHl7PXufT1bjeuoGH5b
	 hZWVqiK6kGmWBo4n+zW5gZW0qK3Mp7pcj0gfAJOnvez+WsNKEDaHIxuBnPZwECMaLO
	 EliK8NHu5c9ag==
Subject: Re: [PATCH mptcp-next v2 3/5] mptcp: add sendmsg_locked to proto_ops
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Fri, 30 Oct 2026 22:02:41 +0000
Message-ID: <179339776193.3128.7015914410130623988@kernel.org>
In-Reply-To: =?utf-8?q?=3C481909c1d5f71b2cca9ab692f251a6213c7cebf7=2E1793258?=
 =?utf-8?q?749=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C481909c1d5f71b2cca9ab692f251a6213c7cebf7=2E17932587?=
 =?utf-8?q?49=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

- [Low] The commit author is 'Geliang Tang <geliang@kernel.org>', but the
  only Signed-off-by is 'Geliang Tang <tanggeliang@kylinos.cn>'.

--

mptcp: add sendmsg_locked to proto_ops

This commit splits mptcp_sendmsg() into two functions. The new
mptcp_sendmsg_locked() expects the caller to already hold the msk socket
lock, and mptcp_sendmsg() becomes a small wrapper that takes the lock and
calls it. The locked variant is added as .sendmsg_locked in both
mptcp_stream_ops and mptcp_v6_stream_ops, as groundwork for kTLS and
sockmap support.

> Author: Geliang Tang <geliang@kernel.org>
> [ ... ]
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the From: address (geliang@kernel.org) is not the
same as the only Signed-off-by: address (tanggeliang@kylinos.cn).

scripts/checkpatch.pl flags this as FROM_SIGN_OFF_MISMATCH:

    "From:/Signed-off-by: email address mismatch: $sob_msg\n"

checkpatch does not read .mailmap. .mailmap does map both addresses to
the same person, so authorship is still clear. Even so, the automated
checks in the netdev/MPTCP patch flow will report the warning.

Could the From: address be made to match the Signed-off-by:, or could a
Signed-off-by: with the geliang@kernel.org address be added? The other
Geliang-authored patches in this series appear to have the same mismatch.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793258749.git.tanggeliang%40kylinos.cn
