Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795563041;
	b=O2aQLSdXpDoe4AQOeBKAVag23ivRhNuvIXacdw2LBiaxJfhguOcadoRgSGp2KJVe88zF
	 sPFYhcGHXlKeAw4jxklsHAZKy0x1zJ3yYvLtoBtGaaBoRj3PwMoB21IbeA2+GTUL2DGV8
	 dgY+rtVw/6xuvX89Z/ERzfoHIJz5+3y7Vt67m55m/FxFHhhNdQxqJ6QSxsOUjwAVKYxrM
	 LQX1KuN9ksLSTaug30RfsN4epqVHKVrjHeaHzRjLZL3YmewQKFnSO3w0kipg7tZMf5UeW
	 ib/XxBH+ubIwZu1IYT2cepfaJGKSC0icDkKZGV0esgIyWuDNKW6eI1QaHFyuLk2Dx2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563041;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MkJnxbPtVw6oVfVp+yrRRZJIwnijudGR3qmGBrICz4Y=;
	b=ZO+7Jt7aOjpJYn/qSrvv8gj9w12YaJhiTxdIiO+EnM8267r52Nq7gJTjqBQv2R04vhLB
	 hO2E1ET2NRNYcB1YJScwigRv9UA6FPtC93bVYgOcsiJBLbc5ftXLBqq6krxXrHgg4HNog
	 3czEw3MwREK8nquY2UgyhUso0NKEAunCyVQIXDKMLEOZRmDDs3vORTzXxFTkHB2EMV15O
	 JTeefV70GEnGLYPrPjtpQJAGcjQ5V1M/Jl9/vGJiKEcqhzRWu97v4M7R5VD+Ky3t5HV5W
	 N8cBfwOweuUTt4WTCVXIdqEzxulRVcyV+mGstDPZU+XE0+nILqyFPrW6GcaDdV2YnPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bD6/MP3/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CC7606A33D
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 23:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bD6/MP3/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0D61F000D4;
	Tue, 24 Nov 2026 23:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795563040;
	bh=MkJnxbPtVw6oVfVp+yrRRZJIwnijudGR3qmGBrICz4Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bD6/MP3/8exDHHjG/fNRHK91c2/fwRxd8SBooYsUswkz+ZYX+2QTBvGGOEA7e51u+
	 irKp4Zoa5NcmjCrTjEraNzdLMhRH4ciF/BnzIzk6TSnDAZWOZf5+dQCADILM8Qhb7K
	 expjAqWPRBaa5STIIKPKSqqM1Wu44TASDtq0ln/rYdrUqqoB2jlnVeGETZxIV9cirg
	 +oOe4X0yz7fMjF+K7IBKZxGTolZTBHK2lqjuHyRcIxmaOm95EhtZtbmxzMnGMLRBIK
	 mI+vwZZuoq6PwGQrazXsea9p6IvQ1/RRGyO1DZUti2D/kocPR3jSyjHe1ws9j28hJe
	 CmFrMqLpoDBsA==
Subject: Re: [PATCH mptcp-next v8 3/7] mptcp: remove redundant orig_offset in
 carve_data_frag
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 24 Nov 2026 23:30:40 +0000
Message-ID: <179556304002.3133.4016319210208098080@kernel.org>
In-Reply-To: <85aa8ebd8ee170cf2290d75b8e8c1ffc1f02f6a7.1795421388.git.tanggeliang@kylinos.cn>
References: <85aa8ebd8ee170cf2290d75b8e8c1ffc1f02f6a7.1795421388.git.tanggeliang@kylinos.cn>
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

- [Low] The author address does not match the sign-off address.

--

mptcp: remove redundant orig_offset in carve_data_frag

This commit removes the orig_offset parameter from
mptcp_carve_data_frag() in net/mptcp/protocol.c. The function now reads
pfrag->offset itself, and the single caller in mptcp_sendmsg() is
updated to match.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author and sign-off addresses don't match.
The commit author is:

  Author: Geliang Tang <geliang@kernel.org>

The only trailer is:

  Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

None of the Signed-off-by lines use the author address. checkpatch.pl
reports this as "From:/Signed-off-by: email address mismatch".

The other patches in the series (5677cf0e039b..c0158d2e0084) have the
same mismatch, so no later patch in the series fixes it.

Could a Signed-off-by be added for geliang@kernel.org? Alternatively,
the author could be set to the address that signed off.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795421388.git.tanggeliang%40kylinos.cn
