Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E0201256
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361651; cv=none; b=dEEKkiBDWUikCSIRO+v8I0/57AxgVn1A0eqMhdNpeZbKTIBZbe3TQtlA414dkDZjv8jItNLzkpf14OwyqTwXiHjWktdvvyPth8swXSeEjMTZGdERSNSaSxfFniF+WggufV8rpepwLm/gkLRiGhXnEFloOgPPvr1bakLEy6ihymQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361651; c=relaxed/simple;
	bh=ENIWuUnFtlglcI85cbMSDTbDgJd1qyTkhEqXWDmg9ws=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LcE5b5TrFo1ZdHJiM0c/iARTXhDfAFRboDk9XK7ePODP90xSsdLW7834W1tOZMjPzSrWuxFhzhHwfx/HlQNpeesfoZo0BCzyxZBf5Nhy3x802ov2wUDmC3Ot+9j7o1p1mXrZbZmSaQuzh1c/tEXCj0cJz0iz7JktTQfcrnPm2MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwqHY0Pt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwqHY0Pt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA08FC4CED3;
	Wed,  8 Jan 2025 18:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736361649;
	bh=ENIWuUnFtlglcI85cbMSDTbDgJd1qyTkhEqXWDmg9ws=;
	h=From:Subject:Date:To:Cc:From;
	b=ZwqHY0Pt70kh4VvXbkbAWtbOtQZq/lDnYf1MLrqd4LDqKXKLK74gcRq3XXbqGItPv
	 fp8ec7/gx3CF0WF016kHEaB44PXAWZHIoqIR3kQbaCAHjPh0hQtFzLvFQ3yiz6pK4j
	 ZwSiDk3OF05P2FoIKciKgV0vm4dNtAcdIHwc6MFNVgz2KqY5uW6D0ECZi/Bfvps7jJ
	 6fJGlxl6EU3NsRYvx1PJHNVY+m+t2+W4dg2oox0QYtVt/v02gY1Iik8m9XUV2B1dCh
	 TJEKcG2bWvezxwA8odIvo87zgAratGVGr4+dFe7qFj5DdDvuMj+n8Di4ctaPUMV0Lh
	 XLcR82kTr1TMg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/5] selftests: mptcp: more info in case of
 errors
Date: Wed, 08 Jan 2025 19:40:36 +0100
Message-Id: <20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKTGfmcC/yXMwQqDMAyA4VeRnBeolTLZq4wdNEtnwMbSFBHEd
 1/Zjv/h+08wLsIGj+6EwruYbNqiv3VAy6QfRnm3Bu98cL0b0dZYMeVKGWlTxSRGKCkXdEQhDPd
 pnKOH5nPhKMfv/YS/UD4qvK7rC1CIGWZ3AAAA
X-Change-ID: 20250108-slft-mptcp-conn-misc-impr-0cc5537a8bf2
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ENIWuUnFtlglcI85cbMSDTbDgJd1qyTkhEqXWDmg9ws=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfsawSd6SydonceN/G4HyNPS5rKJPi6USvguNR
 Oo9tEH44sGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ37GsAAKCRD2t4JPQmmg
 c5vlD/0UTnXzgs8a56kyzPEH61FCgrLd+crAYIiZJlrZtZ/J42+doYUm3ln1+tXTJ30m07i6zo0
 flMydBADJWB03ZMMiZO9Rl2uSP1uuGBQMH1VKLbx69yUh/kDHkKy9Y2F3Er/lWduPRSErpb+9vN
 GB3EVyX/lGiK4avkwEjH4wbnKFYMSFDnZ275RBWFAnxXI0RmoWM1QFimiRlm0aZ91a2d2ZfLZqf
 ACzpixMJ8fIQS6Gcb7y/4FkkgnzWtH4ri5BhtDhBjwBzIbjQqFlAted41Pn+P12ZfeJ+Y9ptjB8
 d+uDm8WZGBkcx/34w3SUBo5jiy5+eX30PbPu/Mtvm+8wLSgTOXfHeelDUXDcr4ssxCGQrMvcC9h
 pyN8w3aidX44VEtKitU9DjASmuZg/PsRxu1obrCk7F3uaBr4OfnCva739qznOvBGetWytBdxBMi
 UOb9r0TKWlb+iVKFl6HNyO6YSEnBxfZwXp0DEMiw/sgrsmzsdAD06sT9BcLl49K9VPY23sTg3T+
 m6yzGRK4HTCjpTOxS83zI1+BzUv+maSNuWr13KdCGZnpmJPU/I8kH+fgnIcFEkI2CIXR8sdfwtA
 1KUMSB0f7ZmMMvWnU9g3KCKxHnZZ1LXs7A2MkjjhoZHOikgXxwfcHGAe3p+xmJ8XPwXKHX27/CU
 UYn9/EKh8bmBGSg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are just a bunch of small improvements:

- MIB and 'ss -Me' in simult_flows.sh
- move common code to lib.sh
- use 'ss' with '-m'
- remove unused variable
- show only the size instead of size + filename

Nothing exiting, but the 3rd one can help investigating some issues like
https://github.com/multipath-tcp/mptcp_net-next/issues/499

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (5):
      selftests: mptcp: simult_flows: unify errors msgs
      selftests: mptcp: move stats info in case of errors to lib.sh
      selftests: mptcp: add -m with ss in case of errors
      selftests: mptcp: connect: remove unused variable
      selftests: mptcp: connect: better display the files size

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 13 ++++---------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  9 ++-------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 21 +++++++++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  6 +-----
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 21 ++++++++++++++-------
 5 files changed, 42 insertions(+), 28 deletions(-)
---
base-commit: f289bc80702ce603593169e80f339e9ffc48cafc
change-id: 20250108-slft-mptcp-conn-misc-impr-0cc5537a8bf2

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

