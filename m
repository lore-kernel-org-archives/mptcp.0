Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6394814D2B5
	for <mptcp@lists.linux.dev>; Fri, 30 Aug 2024 06:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000941; cv=none; b=pQgl6i/zrrleDCv0hepa6gcNs5IOU3QSO59unkIpreNPAj/YUTvLDNQz2yS7reGTZYlAR9AeZlSV1vrNHjbHDwgFGW+JHoe81IEE7ogFQszrHwBLwmxgX83Qc66qsPQjTq5487Gansq9NSmvY81ZZvu0ORMUHCEsLQ3MQlOEEnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000941; c=relaxed/simple;
	bh=vTfiggft06llAFuz4f3D8JufNjpczNfklpupNrDDF5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IU1mlmd5B1Q4YRm1i9/ASNZ1LBuWLlyAJ/vfOnB5T8lS3JUUGo0UyMLXk8zexA8A2oUB5v67drjuKvoBxA65ZOYZG8vdCW087bzk3S04J/KeB6yhTI9VA6stqZ4ysoJAPXl8mytkmkY2/IaWlDj0yW+282/eVGIAwByhrYUgdYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T20Bdf6u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T20Bdf6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB370C4CEC4;
	Fri, 30 Aug 2024 06:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725000941;
	bh=vTfiggft06llAFuz4f3D8JufNjpczNfklpupNrDDF5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T20Bdf6uN0PhEvt3ZxBpmfGCR4NWQSlc+th8cKW37ujBj32IPCCxel63+l0089XVj
	 yttnzET9hHFXBDy98auiE5pD79u2T1wBY/W/b8Xivmx2vjwg89hwMuog6+FpDpYeJ5
	 2klM6L1izuZZeoOoOCKDVRsJ77DeWEbkZqwWG0bh3c5Fg3imD0DCTIh2o0jGbFvNDi
	 11mOh+TEGJnuxYmniVW3AVCXEIcxsrm3PkhRx+uCTEs23RAaHZQ0iIf3ojlX6zWrXU
	 78PgdvCO4pN2IVTyoqjIrycut0haUaX4MYJwYPtC1Rx3UM4Fde3N+ld61O0vYDZDAK
	 WIv5pqpgLmYhw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 1/4] Squash to "selftests/bpf: Add mptcp subflow example"
Date: Fri, 30 Aug 2024 14:55:30 +0800
Message-ID: <06de9b47ddc1e46527f42111a29b97ca01452ba4.1725000687.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725000687.git.tanggeliang@kylinos.cn>
References: <cover.1725000687.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

For easier verification of cc, set cc of the second subflow as "reno",
instead of the first one.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
index bc572e1d6df8..2e28f4a215b5 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
@@ -52,7 +52,7 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
 	err = bpf_setsockopt(skops, SOL_SOCKET, SO_MARK, &mark, sizeof(mark));
 	if (err < 0)
 		return 1;
-	if (mark == 1)
+	if (mark == 2)
 		err = bpf_setsockopt(skops, SOL_TCP, TCP_CONGESTION, cc, TCP_CA_NAME_MAX);
 
 	return 1;
-- 
2.43.0

