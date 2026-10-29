Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309531;
	b=0sPtXZHZQYLFaSDruMHD0w/4joKbRKrZp0f+ZOTwSZfVEG/srq33qPs/Z3jcW4gRJ0CU
	 xLSmLndhi0yJFBl+HxQEm4E8NXATi/5BNjfOFhgAsNWLucwm22cEDwA0W/rXAoyha9u67
	 dbiXZNQesgIulFQZo3UMSpmYMlRNuqAE5yejH0W+aepB04tLaiWmLN9SRfgZqCR6ApXmO
	 rY342jgOEs6891bYxZ8SMfv/WcvdXct4BXifAHN1bQyz1JeWzWi+AZ6WT2qM3wBUDHcTd
	 QmRUQ+OQj0Xf2bTZ/HXUk+lminWcPOOMy192BKYB4vHtnyychGWJvpqpZAa5+INPCbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309531;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=J8OP1AgPoS4WTqXuXScJbnPXQz5Zf4VA39eDwTViHT4=;
	b=uXsWlxYzmWF0y4b/tcwoC0Ns0rDH0zCpu4uTYGOExBSRw0NvW49IAFz3jCqi5iA2gGae
	 XzrZxSfqdEYyj152SQiHnr1NOC37wYIIxG1MdUyHiklHHx2vLNbxAEXlkvmroef8cNaZ7
	 6eB18tQCi/2b0mtshlGlS4piP4TLlplTQhYjCZeB3DZJBAqP6rvEKIEH48EHrXU98o8gl
	 mSu4kK98I5UdD6J1nEFJYa31oQqUUSDVUa1isnlR0pUITjGgZXsBeHDh1jLCf1o2vslr1
	 UqF8j40BWr7ZhzZ4lpJNlbH3tFXh8CStC3shnl/GGjpc0dliyKMVRst/LMbtTT3k+YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XnwpR1VH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CD5606A322
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XnwpR1VH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4429B1F031E7;
	Thu, 29 Oct 2026 21:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793309530;
	bh=J8OP1AgPoS4WTqXuXScJbnPXQz5Zf4VA39eDwTViHT4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XnwpR1VHaX5qWzM5oDznGyuedlFlDiW6noR5JphTYYHdMD/ncO/vQAOPF0tREOoLB
	 3NylDYkokd9bLGbhPlN9fAXf+LJZxej50mh2UiXA4TWiqU/MSuBdc42aSU2G0ftLeL
	 8ktqptyKhMOqgquDs5YF+EoHXsPOEliHkMhgVaB1fpSCX0j6cKlVEhIjENgaGW703J
	 UsWFA053SADQfWy6I0F+jZjZ/0q+7Ggx67w9jyhOlRccty16e7HtauyhgUWsOUpX52
	 TdEVuMEGVOMPDWby3rTkGl+q0Wrk9WTCYxOzTjvuNVJMtkAkRDMrSxvEdW3u2YVW6m
	 XGEYiMZnpLmsQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 29 Oct 2026 22:31:53 +0100
Subject: [PATCH mptcp-net v4 8/8] mptcp: pm: restrict in-kernel worker
 actions to this PM
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-mptcp-pm-userspace-id0-case-v4-8-555066fa4292@kernel.org>
References: <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
In-Reply-To: <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=784; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3wbB6SYDfiS8i/VXCGY8UmLShVG2KSA0hX60WgoHtc8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIe7w5+auC7uZRhUpj7o7fVVZ17vPkPXL20z9/gQLqmZ
 4r4R2fujlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIl4NzMy9K6R3fP5T/68RqHA
 K4eezL+9suy/4cOdt3cp1nXMfNLy4TIjw5+PzpXCFc87T038NamXb3JUu5H0gp7M4u0xFw4lW67
 ezAoA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

No need to check them for the userspace PM.

Fixes: a49eb8ae95b8 ("mptcp: pm: worker: split in-kernel and common tasks")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3: use !mptcp_pm_is_userspace(), to handle WIP BPF MPTCP PM
---
 net/mptcp/pm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e9a538296200..e38fe835abc0 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1154,7 +1154,9 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
 		mptcp_pm_rm_addr_recv(msk);
 	}
-	__mptcp_pm_kernel_worker(msk);
+
+	if (!mptcp_pm_is_userspace(msk))
+		__mptcp_pm_kernel_worker(msk);
 
 	spin_unlock_bh(&msk->pm.lock);
 }

-- 
2.55.0

