Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016659;
	b=mpauPVH0luFLPLClU/DxDr5Mgj1Hlnubn9cOVwqliqqZGvytsvYgaPJLhwWtmgSX6P+v
	 uCl5U+wsC6FhTQc3j++8OrH/B6m1Yz18Ckq5cr5MISbsv1cO045vOMfR35HHc2e8yZ1It
	 xupHBStRBXZLz3CCi6BecJRHtkRcWXeCvPFbpahBqoCQsMKpOeENReJav3bezCj1zz7Ji
	 bso1M9jgSFXnuIUJNgaIEy/zQQZv3AT9ouEEtdCqIP0nz7nX9jkF0GJQ/iFeRECXfLbDV
	 i0q17RHGwS/Gp6tCQ2M4/cqEqVHLQSl6Ml2Sppn+JIoSX2ZiwTENw+77RJdOiHwWQPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016659;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=FhLST4Hrlmn+TlCtFuMZlRPCmJA9n3qPtZHUlYuCjvhG4tysHvINsXdhPCyJzS0ZGmvV
	 D4TdVVLTqx4jQK1Uj30WhvR6bYkEMbmu8i3DUi3GbPHdrse9PE0cj76yYPMYFrf4K9WQG
	 Eh/sFS+ZZ3Y0UFIZMzuyBCShMXmQCONg9I0Qo+RWK+uMpwYmCDwIIktYJkYYfsPiSdlGt
	 W9numhckwgOPGsEGyJBNTMEYlvtldY+PWyOImCgbC3gKfGQJvME4JX1/5Tv1LQAqIjS7B
	 uKX/NG9BdqQXSynaj0pCwvXw1H4q+7dc/cwgS+BjBCC7jyWumisM/y9qtBfFsLkYvlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V3Yq/dV/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7697F606A31A;
	Mon, 26 Oct 2026 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3Yq/dV/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409461F01825;
	Mon, 26 Oct 2026 12:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793016658;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V3Yq/dV/VrWumaEcQB2E0A7LNiRKaNUb2/413wWsX00SFS/xjpODjeRgg2dMCdV9B
	 2tmAX4BSU+LGgH1qUZeUbo7baANPBn4ukPkC83PGRWkkjT9K0/j9C/wI5A4zLrXQxj
	 e0wPpMwh14nqt4XxPegoKfExqpjYeXQbGf/90Bb4HX5CSGiQd1YBR5ZkcuAxpxS14b
	 lDrYX7EFO9/rr7r3H55OrHQuyOiQt9oHJlcBAxknaLhc5nvoLD2UcBeiTyHowyjluD
	 nZBLQEbYluWntYd2i0/BuLTFJR1c+YYFAXuuUMU6fh698Kzi3Np4eyc9sCasjlb2b5
	 JlJQC0kAWer4g==
From: netdev-bot+sinfo@kernel.org
To: Cen Zhang <zzzccc427@gmail.com>
Cc: matttbe@kernel.org, martineau@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, geliang@kernel.org,
 horms@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH net] mptcp: protect listener backlog reads in diagnostics
Date: Mon, 26 Oct 2026 12:10:57 +0000
Message-ID: <179301665779.3327.2649719814082441558@kernel.org>
In-Reply-To: 
 <pm-mptcp-objects-candidate-0066-v3-73df72b7a543d4cada0e@gmail.com>
References: 
 <pm-mptcp-objects-candidate-0066-v3-73df72b7a543d4cada0e@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
