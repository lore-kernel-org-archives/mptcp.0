Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE4C79C4
	for <mptcp@lists.linux.dev>; Sun, 28 Jan 2024 06:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706422621; cv=none; b=LLuR+YTdnSuQBC1MTLF/TOtG5ITJfGGSwnLd8ohhavbXJ22BX2O3Y/jYCtNqZM+NFJZGpC87I3v9Ozt36D5++9XBE9dsVdivr2vUuc1+wHXTF6t6AJ57aU1UrKgQzXczkUurm3KpUBjQrzYUIKRvNBTKoG7gDQfmMVyeAPP58So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706422621; c=relaxed/simple;
	bh=DHvj39LiEsJxGLeLX9iPKJtvtKLHEHZ9ALydrMAJneo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XO1ER/CFptmfABpi0B6cfXTIRc5xg+7yWkpG/3qPQeeKdF4LhlFhp4Zsk3aqGhGocLkxykbU3XjB4OIwKD41ktq7Cyu8XEa6nw/1E191NUsexHSV25PGEuPGZ9xPyH/FCEvCmm/GcTGXK4EjkaUev/TdJ6rFf8PrcMPv6VAV/yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULDXpwE4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULDXpwE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67CDC43390;
	Sun, 28 Jan 2024 06:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706422621;
	bh=DHvj39LiEsJxGLeLX9iPKJtvtKLHEHZ9ALydrMAJneo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ULDXpwE4CcOor/nLIAMNedkgT+3RxFanAZjVwtloBopvIvhYiViHuLaBoxi9MVs4e
	 4xkuwO3VVNbxPLtQaK4/7ZrX9Vb3XvAV8T063la5QitBOVAsEha7eSJqV8vPpmUgjk
	 bfCRlBzqtmFIZiOlSfcNzmQXJu76VBiIzvUk1bwAAW/Tqm1aENW3LviTv0e6X/EU9a
	 3yNrucGFQ8Ws5P4a2/o01f2FHhZxRNNYa3RY+QQoJP5GW0f2uIXVYoZZ7uPmG++N67
	 5HjzbQi1U6ZDL0MOi26CT2pE1RYkuSBYMTF7luwRPRlu98q/bEhPpKSu8AgJjL0fIB
	 6FflZo9zu2vfg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
Subject: [PATCH virtme-docker 1/3] change watchdog to device
Date: Sun, 28 Jan 2024 14:16:01 +0800
Message-Id: <6732dae64a26bbbbda3d35ff29b47803a86d3983.1706422466.git.geliang@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706422466.git.geliang@kernel.org>
References: <cover.1706422466.git.geliang@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch should be merged into virtme repo:

'''
architectures: use qemu -device option

Use qemu '-device' option instead of '-watchdog' to fix this error in
Ubuntu 23.04:

  qemu-system-x86_64: -watchdog: invalid option

         ret = Arch.qemuargs(is_native)

         # Add a watchdog.  This is useful for testing.
-        ret.extend(['-watchdog', 'i6300esb'])
+        ret.extend(['-device', 'i6300esb'])

         if is_native and os.access('/dev/kvm', os.R_OK):
             # If we're likely to use KVM, request a full-featured CPU.
'''

Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 Dockerfile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Dockerfile b/Dockerfile
index bf7f733..cf8c692 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -35,7 +35,8 @@ ARG VIRTME_GIT_SHA="a680c0861cf6f9dc6a8a821e9e58ae43c5e68435"
 RUN cd /opt && \
 	git clone "${VIRTME_GIT_URL}" && \
 	cd virtme && \
-		git checkout "${VIRTME_GIT_SHA}"
+		git checkout "${VIRTME_GIT_SHA}" && \
+		sed -i 's/-watchdog/-device/g' virtme/architectures.py
 
 # byobu (not to have a dep to iproute2)
 ARG BYOBU_URL="https://launchpad.net/byobu/trunk/5.133/+download/byobu_5.133.orig.tar.gz"
-- 
2.40.1

