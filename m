Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732F7277CB6
	for <mptcp@lists.linux.dev>; Mon, 15 Sep 2025 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959888; cv=none; b=QIYvPipWYH8wAxqrRh/QlJFarrIo/6sx+s+qv8HAIrE2nXJZFYS9yEnWQlO6H56e44GYDOS6zNEAD+zZiMiEtCN+L5+IvItZ/iWk/F/kcF9mYMc49RrgMm/6rElbKjZJQCs3dr1wg/c9D4KTs27uSgHsbfVXDSu55WiA/jtVdkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959888; c=relaxed/simple;
	bh=Xww4xKGFM6LLqT4TGSyVLbCVr1UddT/Bg9IeTNjh7h0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AN1sjip9ktRvHLR+X0/YccmFlgmfmaIv7f11FdU8uHhEdxVLS9BkZL1az0rf5wmPVAGfCzoQyuoyB/t+AFNJVXJqQYC8dVAFGZ/j4sRnK5hCeLyt2/WkN9V6ehaeXbN8B+Hkvq3hz9iROO8tbGBbat7cmEZZ8Nm+579mp9WC8bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkGbiyHx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkGbiyHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9495AC4CEF1;
	Mon, 15 Sep 2025 18:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757959888;
	bh=Xww4xKGFM6LLqT4TGSyVLbCVr1UddT/Bg9IeTNjh7h0=;
	h=From:Subject:Date:To:Cc:From;
	b=tkGbiyHxbEIYPazam527D/7gWZI2HksU63hm1rPg6I8x7gAYsvTLdxfc8B1Ju7Sjf
	 LcTvWkbVOSPflfFTiG00DyOCTJ4j6F0O0bIiqFUXkfFJf1bMZU9bK9NpaRN1BbRFP1
	 tKtJIgjnWm+za7TIT8Yr883sv9JsVI+uW8Kf4PiOua6BzR+4dco6LasMV10ynBcMJe
	 z6Yu85HspR4Pfm9l+qhYD79nY9jEf9WKdrvilDoPqLlNbG+dUDIiClnFsS6Q2WbiN1
	 okn4vSB1AerbZk8R7oX8uY3RSSbfgv7/cvcbmk6Nyn0oKaoSsslI0LcA/+fijaciP9
	 0OV42eDzeoUVg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/2] mptcp: pm: in-kernel: usable client side
 with C-flag
Date: Mon, 15 Sep 2025 20:11:16 +0200
Message-Id: <20250915-pm-c-flag-client-default-v1-0-6bb241e4d991@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMRWyGgC/x3MTQrDIBBA4auEWXcgEZqfXqV0IeNMMmCMqAkFy
 d0rXX6L9ypkTsoZXl2FxJdmPULD8OiANhtWRnXNYHrz7JfBYNyRULxdkbxyKOhY7OkLyjiNbrY
 kjiZoeUws+v2v37DHQhEDF/jc9w81bux7dQAAAA==
X-Change-ID: 20250912-pm-c-flag-client-default-f676d8acfdc7
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Xww4xKGFM6LLqT4TGSyVLbCVr1UddT/Bg9IeTNjh7h0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJOhJ2J3qK1Os/ukZLe1pQzByzm60TN3rmav0eHcXZPy
 6vAjy9vd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEykvpnhr5jx7D3XzRXmHDJv
 nMlSccvpuNm7zKUbMzW772clpJ7afIaRYeGjTuPmjzGna3w7PVv7XZ403Yl5E15ZkZe5Y1bdijk
 VTAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When servers set the C-flag in their MP_CAPABLE to tell clients not to
create subflows to the initial address and port, clients will likely not
use their other endpoints. That's because the in-kernel path-manager
uses the 'subflow' endpoints to create subflows only to the initial
address and port.

The first patch fixes that, and the second one validates it.

More details: https://github.com/multipath-tcp/mptcp_net-next/issues/536

Please see the comment in the first patch, and don't hesitate to reply :)

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      mptcp: pm: in-kernel: usable client side with C-flag
      selftests: mptcp: join: validate C-flag + def limit

 net/mptcp/pm.c                                  |  9 ++++--
 net/mptcp/pm_kernel.c                           | 40 +++++++++++++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 +++++++
 3 files changed, 58 insertions(+), 2 deletions(-)
---
base-commit: 01d3ba86f43b6fe8e91cfd00ba178d6997095a04
change-id: 20250912-pm-c-flag-client-default-f676d8acfdc7

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

