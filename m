Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795725842;
	b=UjGsNMmq+7hblVR91cjsyOO6qqPGziA0rxtCBI5hePV3gsiCSaVQcYNRLzRdkm11j1iz
	 thrrpdQnpKEPb40ePZ71qDyhcPqPCqZI3fc+M4m3Yn0PWdMfx21z3yPAiQGYy59+n2nfs
	 8xa5v9NaEchUtrUzBQMRCBlhYCV9Qr2KdT6JrRBlR+STRwXcfOItxC1OQMnFNVg/D/SHu
	 N3NP2De9IaiOGWWN1wjCHsKvVL7IR1r4/SkOqzXPFSTZtf1etfe0f+4JD0ejh4ue8EDYU
	 RvNEHZv/HwxVnfycB5QvRYpQXjTK4Gc+G/fY2S8a5DTSdgLRf8UuoerawsiszWR+iyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795725842;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SoiBuQSyttmWSlIw9JClVAIxG5bImuatlUysRrjJYFw=;
	b=BcERT0TIixFLLRK+h1uXuG+yFa7S02GeVEA5kKHtIv8XdNvLgLCWmV3f6AFNRsdDDSs9
	 Emnv0era43YOTIQtxH2YZiDjdkICaT3JwTLZVXjIFfzF2WPNc3J2i9UoC8W89RyUUWUKn
	 o+WTaGXB4o19N46o9qpE2+hL9xXUYs5hVFKuCapnZsWtbz8sAYCblSA30w8fqqCnAKf+t
	 LdgKNOnND+aiCDoPRRwCpV7hhab5yaOUq9CakGJf3B5MefVUwHJQ5yHQbqzQnwDC4JUZl
	 e0zg9g0QmFJaeAcZdfsqi9Q8WQSiU+B64AChkQmzENNWxmwdEW5M76ke2mXdlo2OFrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EHnDqGYz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913C1606A6AA
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 20:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EHnDqGYz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AD51F000C1;
	Thu, 26 Nov 2026 20:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795725842;
	bh=SoiBuQSyttmWSlIw9JClVAIxG5bImuatlUysRrjJYFw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EHnDqGYz2k2jOhzbyrAT96wq2YsnHHq7G1TbHbWy1ltpHku+fKrebKBq+0G4Tcou3
	 jFwODVL2FEGewAoBdAxxQMv6n7Jux2tTv19rsnCP6XtSnyF3etouD++yaLizY9OWvm
	 KGX60S5YFETVHsaIK9atiQvdJiQY50Au5BJ8EWBAdoBPkqjQzSjnXy9ky7owIoazpo
	 xfd2nwnDkRRlp1EH9a+Rubljm+n6tI5DdkcYA1YQ0U5OD+WgRmVVw3K9ha7iaawGTG
	 HbW/pfMhY5MKsL5ZvcmN6nIa7l4B8wRyKMEsD+LrcMsYPIuIY4j9Ap/w7mEabdqu1r
	 JI8zoy20IxT1w==
Subject: Re: [PATCH mptcp-next v9 2/7] mptcp: remove redundant orig_offset in
 carve_data_frag
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 20:44:01 +0000
Message-ID: <179572584149.3133.16595001385232000510@kernel.org>
In-Reply-To: <ba564038b16dc170e4605bd733a988808a86037c.1795591278.git.tanggeliang@kylinos.cn>
References: <ba564038b16dc170e4605bd733a988808a86037c.1795591278.git.tanggeliang@kylinos.cn>
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

- [Low] The authorship and sign-off identities don't match.

--

mptcp: remove redundant orig_offset in carve_data_frag

This commit removes the orig_offset parameter from
mptcp_carve_data_frag() in net/mptcp/protocol.c. The function now reads
pfrag->offset itself, and the only caller, mptcp_sendmsg(), is updated
to match.

> Author: Geliang Tang <geliang@kernel.org>
> ...
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author address and the Signed-off-by address
are different. No Signed-off-by line uses geliang@kernel.org.

checkpatch reports this as FROM_SIGN_OFF_MISMATCH:

scripts/checkpatch.pl:
    "From:/Signed-off-by: email address mismatch: $sob_msg\n");

.mailmap maps tanggeliang@kylinos.cn to geliang@kernel.org, but
checkpatch does not read .mailmap, so the warning still fires. The
other six patches in the series have the same mismatch.

Could this be resent with an in-body "From: Geliang Tang
<tanggeliang@kylinos.cn>" line, or with a Signed-off-by that uses the
geliang@kernel.org address?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795591278.git.tanggeliang%40kylinos.cn
