Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794704605;
	b=3Up27P5lQhdBhbxjX8Ad4gLKd62GDubPDSTviGByDkZHLc+GqbsAPeMjT6Sj9bkgRcxM
	 n3PmXjdubGRS0tfzowuxMMwlz1WYLddvnwHr1uQ/4GSOS5oBeLnVQs2wKK4ToH4z1w8sp
	 M22RWRtgPjnrcep43GNkTnt6U/RfNfg5bSvx5G3HKig9FobOp2wblzbVSToJcvCxYJRe4
	 qq1zzJ6Ru6Ei7Av95+sTeKOw2lkvy0YD/gDBwBeH5icB4IZ8T66n5ReXQkPih5RDkVfs6
	 PnilNcPfsf6CCZUHWD8fX208MiFmCtMSbwJ6odXGzWi9ALkFXPtyHkDKqogJMKUMj0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794704605;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wfO+EDgz8lUn/GDSsqgEcipG8eZkqPmkWjD3YgU0vGY=;
	b=i/2r81/o9TrPwsRlSI6t1qV8jsxyecf/34XuEiX8jFwPwgBg9cQXn5IMV1Qph8gK8dwB
	 Ws5i8/x0u61GMEOYxJywvbsU8NdW87abQMH7bahmGBSXpTgxSTQ9h70A7EJNc7b6K5kHH
	 TJZhUe2RKXK5UXmXWMx2z6rqqn1aEt3Gt67jbsOr21oaHV/6Q/pPzk9A4CilJWdVStLf0
	 iq0vQCEH3XBNrmPfbRsxkK8qC/Zr0z39exDIvMeVcXLfljm9oON23gN4m4I6AtLgnfC6x
	 X/H1WBGQiCc8veR2d+KpPvMCEU/XHerwKhxbJXOLcvaFAJs6XscDRm1MWK8GGd7meTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vy88Xp3X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835B3606A323
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 01:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vy88Xp3X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361701F000C4;
	Sun, 15 Nov 2026 01:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794704605;
	bh=wfO+EDgz8lUn/GDSsqgEcipG8eZkqPmkWjD3YgU0vGY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Vy88Xp3XPrJp6QWILiCZ+aQM75kfCvdo8PxPQXblNvwt+NCnpSZi0rBjy//8VEyME
	 RRR0JLg16pc6S+F+JXMi2brUHWr4T4pauhQ4CmvCaFOStlSiPwDXya4s3M/SdGNMJ3
	 OtJdHFLBFWAkydicpXS9PYFC19pZVgMMkS0Y4sZ54TgxwKUu1UtKksdjhX4pYDrCTY
	 WdesRiStViJav/Zc+c3fPqSg8fS3lbghurMDmJrvyYjbqEE/MBy8m7AtJjIsMxHaNx
	 MMB9+lc5+7Im3OyaoTPzC41S89FDH6J0gfrXRmjQkM7NmEpm5OmcNumtWMDxieML0V
	 4rggqKui0jXGQ==
Subject: Re: [PATCH mptcp-next v26 2/8] selftests: mptcp: connect: check TFO
 SIOCINQ overflow
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sun, 15 Nov 2026 01:03:24 +0000
Message-ID: <179470460474.488855.12128765842803062752@kernel.org>
In-Reply-To: <4b9d85bac42429d8d566497d0f8f2c76ebb7e663.1794563432.git.tanggeliang@kylinos.cn>
References: <4b9d85bac42429d8d566497d0f8f2c76ebb7e663.1794563432.git.tanggeliang@kylinos.cn>
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

- [Low] The commit "selftests: mptcp: connect: check TFO SIOCINQ
  overflow" adds a regression test whose only job is to check the…

--

selftests: mptcp: connect: check TFO SIOCINQ overflow

This adds a check to mptcp_connect's server mode that runs when the MPTFO
socket option is enabled. After accepting a connection, main_loop_s()
waits for MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED and then fails the test if
SIOCINQ returns INT_MAX.

> It then checks if SIOCINQ
> returns INT_MAX, which would indicate the regression where mptcp_inq_hint()
> incorrectly returns INT_MAX for passive TFO connections.

[ ... ]

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This test exists to check the earlier patch in this series, "mptcp: fix
TFO SIOCINQ overflow in mptcp_inq_hint". That patch carries:

    Fixes: f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()")

so it is a stable candidate. This commit has no Fixes: tag and does not
name the fix commit. The message only describes "the regression where
mptcp_inq_hint() incorrectly returns INT_MAX".

Should this commit have the same Fixes: tag, or at least name the
mptcp_inq_hint() fix commit?

Without that, stable backporters who take the fix have nothing that
points them to this test. A tree that picks up only the test would fail
the -o MPTFO runs in run_tests_mptfo() in mptcp_connect.sh with "TFO
SIOCINQ overflow", and the log would not say which commit is missing.

No later patch in the series touches tools/testing/selftests/net/mptcp/,
so the series still lacks this link at the end.

The test logic itself looks right. Once the remote key arrives,
subflow_set_remote_key() sets msk->ack_seq to iasn before can_ack is set.
With map_seq set to -skb->len in the fastopen path, the old formula then
saturates to INT_MAX, so this check does catch the original bug.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794563432.git.tanggeliang%40kylinos.cn
