Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9766D39F162
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 09:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740705; cv=none; b=rqHv1Vsy9zUES+t2lpJ1+d9k1Q75YjJsh7tqANMYl8fi7MJVYT68/l5V7Mfj+gLerMOQPYuwhUr7jyAfN7wA2apzY++Xz9BFCUMpZGNFR85imViPEzyUhkW+5ZKp9XHw1U76JcDx1Vf8iQnoJb6+/U5bH/7sUxTYE9DV63e0dK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740705; c=relaxed/simple;
	bh=EPjkWX1EXd2fy+8boGcD703o7+cpeX0Lh8A9cIBkJ+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aGcijpfkXeqMhRxiJvL++rjxlS1RGj7pykE0j9Iu89uRs6llrM/9VIMMNn+JOTynbNz6rFCMCWy/zubBCTtjQlYQAX7fA1HD1IcqORCQtd9oArdrhGlYOArxd0rd/d3H+3FXlAeAU/hXNIWqb96XV9/7gLRYOMurfwqm8Bo/3mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CF86yCXU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CF86yCXU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF71C4CEF7;
	Tue, 17 Mar 2026 09:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773740705;
	bh=EPjkWX1EXd2fy+8boGcD703o7+cpeX0Lh8A9cIBkJ+0=;
	h=From:To:Cc:Subject:Date:From;
	b=CF86yCXUCkq9L9I5UICyfhCRxTPF2ZUy9w6OvvyF3jbxofV85JTLIMQyAzuEj+VZp
	 RcGIcvPFZAmsf2lHAfGX5M8H8f856sE2Pc7Edo/xiy99Ryduy2javM9YtAHRWyt1Y8
	 4Vj6nvIUOE/4sljZMkyXakzgtq7WyWicM4Tpk6SyKdgLg8FYHVc+hKZQvJpHJd9YAi
	 nOf4VYacUSzuoBvhAcJn4qAkJ7CsIxsiDlhefulEp54T+pOV9+e2rfmV/DrQVLw1IX
	 DBDj41cMKmG/gZLXSuwIhKzh5oCj0eDSkq5cE5EcNUvCTvOPdsJpfQVeY0JT/pUWpb
	 N9as7LeCoWAYQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RESEND mptcp-next v2 0/2] add tcp_recv_should_stop helper
Date: Tue, 17 Mar 2026 17:44:53 +0800
Message-ID: <cover.1773740635.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

RESEND:
 - to trigger ai review.

Two cleanups for "implement read_sock" series.

v2:
 - v1 changed the original behavior when replacing tcp_recv_should_stop.
   This version preserves the behavior unchanged.
 - add a cleanup patch for read_sock into this set.

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1765607485.git.tanggeliang@kylinos.cn/

Gang Yan (1):
  mptcp: check desc->count in read_sock

Geliang Tang (1):
  tcp: add recv_should_stop helper

 include/net/tcp.h    |  9 +++++++++
 net/ipv4/tcp.c       | 10 ++--------
 net/mptcp/protocol.c | 12 ++++--------
 3 files changed, 15 insertions(+), 16 deletions(-)

-- 
2.53.0

