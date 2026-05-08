Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EF541C31D
	for <mptcp@lists.linux.dev>; Fri,  8 May 2026 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262909; cv=none; b=m53uMJR9kQCwp70Dc2seOVGXCjAblHXz+v+siLLGTFO7aFwfvTwMLc/ILrI3TcO05DIMcWsxpUR4LdV/PLeaCAXqmfWqqFqA3IDtluaoYdWNiVeaHrb9RM6l5HGGM2GnQ5pRIBgCT0AirllvdedvVa/nyoBbPyFNGcQdbVhQb0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262909; c=relaxed/simple;
	bh=ue4UV25ZccJvapsHQgzT5B9K5fNDHowK7ECRVu4DZcA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AeNXFu51d/3ORNC9m+BrXaz0itWw/ZGDhJPeAsmGyEtsjxpddg6/tjEbMX1m1YDQu4fPng6wGy0MePKqW+X5wuUaWpzkWBO+kd/Vm/aH4IP4MJu0KPJAlnfzxR2PmnCO/1/ksbsw6mi9bVgqav1rrp6+S2+4CUBYsKOvOdEfZDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3V/kkCz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3V/kkCz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C82FC2BCC7;
	Fri,  8 May 2026 17:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262908;
	bh=ue4UV25ZccJvapsHQgzT5B9K5fNDHowK7ECRVu4DZcA=;
	h=From:Subject:Date:To:Cc:From;
	b=p3V/kkCz0tAKi49kMO4bRHBv3edjogIZ5m/DfONS3CUx8A8UhlQc3JVraV2ZhByS0
	 FBbfxnUSy6zOIIc49vdHJuyXmDe6hNk5TTqPjDfbnEWDGW91TVJeHiOGNH6G8ebVN1
	 B5omybcMeMX/bnq0a1vETl19euLIDQV6Ty4G2rcQPi6eyUh5N3X1mWx3bxDSl6vrVl
	 ZCQy99JATyYJzGtX3qPd098W7WzGDj8Q49ZOBPfrbYXE6riZMA7xHgZVnGpic4Tsdf
	 U/09Uua9Ckmx0dB+hHwoAM++X2kOcDAHtrzcNomE8XvkkgFwfVIxbsix0a/yHsstm9
	 +/4oqpdmtQ3FA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/3] selftests: mptcp: simult_flows: reduce
 bufferbloat
Date: Fri, 08 May 2026 19:54:54 +0200
Message-Id: <20260508-mptcp-sft-sflows-bufferbloat-v1-0-e9b0d25d9789@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMyw6CMBBFf4XM2ialqQ/8FcOClqmOwbbpDGpC+
 HeLLO7i5OacBRgLIcO1WaDgm5hSrNAeGvCPId5R0VgZjDYnfdQX9cris+IgdVP6sHJzCFjclAZ
 RtmuN8d3ZWo1QE7lgoO8/f4PdjCjQ7xfP7oletjys6w9Dm1QGiwAAAA==
X-Change-ID: 20260508-mptcp-sft-sflows-bufferbloat-49122c97440e
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=851; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ue4UV25ZccJvapsHQgzT5B9K5fNDHowK7ECRVu4DZcA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL/KVe6nV07416vSdfa5Iqanj+LD9tvXPLAZbHSrb9vt
 XbpyU492FHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjARLxFGhuVL2l8V/8pdcnT3
 kxNrNz265Wv6ZtZ0wUb902rl8+SXZM5iZPhY9UTEOdlxo5xyddD81b16kf5/pdTMf7eEPru5obz
 KjRUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Bufferbloat is baaaad, even in our selftests, let's kill it (or at least
reduce it). By doing that, the tests (seem to) have a more stable
transfer, and are then less unstable. But to be tested on CI sharing its
resources!

The last patch is for -next, safer.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      selftests: mptcp: simult_flows: disable GSO
      selftests: mptcp: simult_flows: adapt limits
      selftests: mptcp: simult_flows: disable 'flaky' mark

 tools/testing/selftests/net/mptcp/simult_flows.sh | 34 ++++++++++++-----------
 1 file changed, 18 insertions(+), 16 deletions(-)
---
base-commit: 1b5f90649a5adc94f765b5dee7fbfec433a5a797
change-id: 20260508-mptcp-sft-sflows-bufferbloat-49122c97440e

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

