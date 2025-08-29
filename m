Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9429E43164
	for <mptcp@lists.linux.dev>; Fri, 29 Aug 2025 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499634; cv=none; b=Mcf3fyfzlyIpCM9IIYdK48Nbn6W+K9LW2IQpHeke/5IvLIO4IJ8JjcT7JZ1Atz63Ui9oeGyYTlq0QTNq88mS/9iciHudqx7T7AiruAKj57RdafIQWO72XUP8NuT/Naw6wv7Q2EiXhAOxdDTauo7EnTa/AJLApk8fjT8kzJij8WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499634; c=relaxed/simple;
	bh=NQSPI+JMUx4nEmpPGbd1iV8SHl5xpcAQusfRy1b79+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PrpUNTPPcHjO5/xVWHmJvT+gURUh33BUZhE5a9xNy5WMDdxLekZdOhq93a9HF/kgf8GamgX8e6xLMmjdpbkANliWAiOX5jydP7ImLtho/vAaTJdFb6Je4BN53rhzu2Hc6CyWoUTNg/B4ji1v7ZXuHAZ1j3+HYC0Z5pr/ozQWOqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RI4FCjFV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RI4FCjFV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05919C4CEF7;
	Fri, 29 Aug 2025 20:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756499634;
	bh=NQSPI+JMUx4nEmpPGbd1iV8SHl5xpcAQusfRy1b79+g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RI4FCjFVciiVHgS3KmzvBTw6dNBUQ5uBQy/mhqA41ZX0hxa2i2B0oECHtE9LL4q9e
	 s5wV9KgOIiJoCOPycuHKPAcrnpbBgV24DSdXrinfCZpoMQpeTOU5rlj53zUCRJOJNs
	 BIXF7oJr+Wl4gMrEs46aRjlSNsmssfeMmVdSvCFXSfDwLsasGc2xqhBhFiXzSF2U8e
	 KZoMuxdP9DsTlZQbne9IDJeoh9AdH9jncdm21HKeLqdjH2sJabVXGzO+1hxeq+LK6l
	 Cl7IsvGTgjqhGLWg6fL2eamDYf7VizI2+xZUVR8ao2XCTbHdSec+ZkMRvWLiaLxXZc
	 x2Z/Tn9ovKBMQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 Aug 2025 22:33:37 +0200
Subject: [PATCH mptcp-net 5/7] doc: mptcp: net.mptcp.pm_type is deprecated
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-mptcp-pm-user-c-flag-v1-5-78b25dda7708@kernel.org>
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
In-Reply-To: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NQSPI+JMUx4nEmpPGbd1iV8SHl5xpcAQusfRy1b79+g=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI28a2OY+hL2VLnlq+T3u8pn+O7Ji1lS8HF6u9JRwWC9
 61/mZHYUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMBFxCYZ/Zm4aUk99z8zJkA18
 d2HizJVZi+4tMqhQ8b544+/83T+Y+BgZzv3/bdleYLCj62lS2e/bbmEbnJ+0LdH697R5ivozzsf
 mnAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The net.mptcp.pm_type sysctl knob has been deprecated in v6.15,
net.mptcp.path_manager should be used instead.

Adapt the section about path managers to suggest using the new sysctl
knob instead of the deprecated one.

Fixes: 595c26d122d1 ("mptcp: sysctl: set path manager by name")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/mptcp.rst b/Documentation/networking/mptcp.rst
index 17f2bab611644727e19c3969fa08fa974c702d92..2e31038d6462051387be9bd8808a23230db08315 100644
--- a/Documentation/networking/mptcp.rst
+++ b/Documentation/networking/mptcp.rst
@@ -60,10 +60,10 @@ address announcements. Typically, it is the client side that initiates subflows,
 and the server side that announces additional addresses via the ``ADD_ADDR`` and
 ``REMOVE_ADDR`` options.
 
-Path managers are controlled by the ``net.mptcp.pm_type`` sysctl knob -- see
-mptcp-sysctl.rst. There are two types: the in-kernel one (type ``0``) where the
-same rules are applied for all the connections (see: ``ip mptcp``) ; and the
-userspace one (type ``1``), controlled by a userspace daemon (i.e. `mptcpd
+Path managers are controlled by the ``net.mptcp.path_manager`` sysctl knob --
+see mptcp-sysctl.rst. There are two types: the in-kernel one (``kernel``) where
+the same rules are applied for all the connections (see: ``ip mptcp``) ; and the
+userspace one (``userspace``), controlled by a userspace daemon (i.e. `mptcpd
 <https://mptcpd.mptcp.dev/>`_) where different rules can be applied for each
 connection. The path managers can be controlled via a Netlink API; see
 netlink_spec/mptcp_pm.rst.

-- 
2.50.1

