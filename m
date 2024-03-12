Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D39B641
	for <mptcp@lists.linux.dev>; Tue, 12 Mar 2024 02:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710210156; cv=none; b=OTNxWqwGXCFfQwmhhqaoQG9eJxLOEWDCLbC5KmmT2qc5U0iaFQdp7J/t6aPfqkJmP2nS5nKG0ZGcpZZld/um6o/ENkuRkB446ibNuAVNhJcWu1MeppqK3yfTWjfHyOqDJup046Rv8QopZ5P9up1GTArd+Xedte2JdnSFwHB3aig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710210156; c=relaxed/simple;
	bh=N+Bup79EpOvuk0i9HasTOHymnsj7+eBaio5GE0OfbnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ByEVXW6H1Rl+W5Yd0iR11kSWUhQUIEjMKtIDtUR16W+SHYYYnpRh2C8732lMrjBHxoOuXuZydOIRtjK4M7ZDwius4pJgKEFPiV3tyBeyl8cIY4dBOx4WE9u+11Ss7g/ZWbA0XWWsoKNT1HcmBTGQB8moe1sCmliNX57eaQN2Y1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfiT8P56; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfiT8P56"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66ED2C433C7;
	Tue, 12 Mar 2024 02:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710210155;
	bh=N+Bup79EpOvuk0i9HasTOHymnsj7+eBaio5GE0OfbnQ=;
	h=From:To:Cc:Subject:Date:From;
	b=kfiT8P56q3M3vtzJwKjmLlY0/smob7Fdb3ANlUZwSCbsCVfviBVN1Oso3FrlALCdD
	 BvLrDQyuasv0aZVwyfJReVKnfnUlaKkl6aRgxZVALkpEjl0gbptszKo28MLaEP4pDU
	 30FkdWkVkIA8QOMEAO3kXXpJOBYmCwpiPTAZk9m+43n5yQFQRz8MT4+lpgF/ShGMLV
	 M5bQLf2pFk0e/locLHmzoCT5xv02IyNt+uECRxzXExY+Zh6QyE/67PpjesZpmummcC
	 oqExU+HNzzpepT0TkRBq0NsFb97Vp9/F7b76g01uZ31Vihmyi66LDeTt566ZRl3gPM
	 57LJ7t0YblhnQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
Subject: [PATCH virtme-docker] docker: install iperf
Date: Tue, 12 Mar 2024 10:22:28 +0800
Message-Id: <27fc057073806f67eb30b20ad732a1d3ccaf05e1.1710210140.git.geliang@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Download, compile and install iperf in docker for the coming mptcp iperf
tests.

Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 Dockerfile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Dockerfile b/Dockerfile
index b75d4bb..b9bb539 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -88,6 +88,15 @@ RUN cd /opt && \
 		make -j"$(nproc)" -l"$(nproc)" && \
 		make install
 
+# iperf
+ARG IPERF_GIT_URL="https://github.com/geliangtang/iperf.git"
+RUN cd /opt && \
+	git clone "${IPERF_GIT_URL}" && \
+	cd iperf && \
+		./configure --prefix=/usr && \
+		make -j"$(nproc)" -l"$(nproc)" && \
+		make install
+
 # to quickly shutdown the VM and more
 RUN for i in /usr/lib/klibc/bin/*; do \
 	type "$(basename "${i}")" >/dev/null 2>&1 || ln -sv "${i}" /usr/sbin/; \
-- 
2.40.1

