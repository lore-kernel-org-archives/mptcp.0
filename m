Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086881E4BE
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 08:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785055441; cv=none; b=UsrlXD3zRpS6BD7q9yTN9/yxZaqxs/RGWnGIoCbJ1vuLQPeRXoK8MP2HVC/f3vH1VSiP7oYVOiJp/FDKFWCPdUI6+BvThH7m64TpQ7BZL5QF5k/tGjsjy3i5f3uRQDXDjEe2MzgQvIDyuxvlw1/iMLzOMpM2s+jXF8Z4An3N318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785055441; c=relaxed/simple;
	bh=xtBl/Tz95UY7/F+kbIkRydgKZlWruc4owZAlKkZxKEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOIvff4hBdUsTujaKwsfNsO435LZEtVlAm/t8WJp+Hf5VX0f3+UIWPekDdRiXfWW30MgO/ctH9RRa71WfgLQaorFICSihLhjDGFP3KIm/FUDAVdb5Yirw2NFSdCX+Z1kr3m4Vqot/DzeVS7j99jmjnal3J0BgwZRpLwy5utAag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfbQ9dhq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfbQ9dhq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB861F000E9;
	Sun, 26 Jul 2026 08:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785055439;
	bh=rviDDAAHmbq+15ZqCWX3teAW6mgeVDyJ7c1+uJ1fwqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WfbQ9dhqqhZKrnBUgiHgNVoSY+b4TJExhNo2fs25NABpxJtVHGb7qrTYcV4eY7TU+
	 SZGoPYWHG/9nqOb14+OFkbExDQ4z1FotLoN/92qpFZk0fVQolvi5PnmAGX4OV4PB3I
	 wEfma9vavNZ7TtpSmQWbI4LVasCwnlCoXyrI1OX+TpLJQM4ZZ8OqAxZI7n7pfrDuNd
	 ozxP83nVBk2LbqW6OCD4Aczw+oSU5U63q8nAO0OKHwbL478apXGz1+wIvMXwnAck86
	 /nGlQjH9UkvuYeAnCf5TeNvhtKjSEyoputyMroiA8+8cKmZJhAzzcRvhkJW40Y+7+n
	 jg2/inNkVGmmQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/5] mptcp: bump setsockopt_seq for subflow-only socket options
Date: Sun, 26 Jul 2026 16:43:42 +0800
Message-ID: <7a5c6644d90bab98caebc4b6058eade77b893e4e.1785054808.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785054808.git.tanggeliang@kylinos.cn>
References: <cover.1785054808.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

mptcp_setsockopt_sol_socket()'s SO_REUSEPORT/SO_REUSEADDR/SO_BINDTODEVICE
/SO_BINDTOIFINDEX case applies the option to the nmpc subflow and copies
the result back onto msk, then early-returns without calling
sockopt_seq_inc(msk).

That leaves msk->setsockopt_seq unchanged, so any subflow created later
(e.g. via MP_JOIN) inherits the master socket's seq at creation time, and
mptcp_sockopt_sync_locked() sees 'seq matches' and skips
sync_socket_options() entirely. As a result, the new subflow's sk_reuse
/sk_reuseport/sk_bound_dev_if stay at the listener's default of 0 even
though the nmpc subflow (and msk) have the right value.

Bump the seq on this path so secondary subflows trigger the sync on join.
The actual field propagation lives in sync_socket_options(); this commit
only flips the trigger.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index dc1ef52c2200..37e65923f544 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -326,6 +326,8 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 				sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
 			else if (optname == SO_BINDTOIFINDEX)
 				sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
+
+			sockopt_seq_inc(msk);
 		}
 		release_sock(sk);
 		return ret;
-- 
2.53.0

