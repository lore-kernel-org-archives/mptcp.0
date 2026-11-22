Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795349254;
	b=2UU6AaBLRsYGf6UhNZExP5p1pv02bRSLLY8JlzZNwiNxwoVuyb2NI58LiI4pj6P2B98c
	 Nvr0p6gDbEP8cZW+6QPM8UjOiQhMrBPuIXnEshHmZJm4UF8nwU4K8d5SmqkWl+dgNDD2l
	 J8E8dnnTmvKyktI4Fx9dHqJ0jntpjCLxSQdX12aQdO3vyw9QgMthhfbqA39yr1IkGWhsh
	 ReHbyaOdTyTB9VP3fxBwpoqeKn5gzrvyKvxEEECSKQhk7Ug7IeeMDpYtKFnb5gaSnMB+B
	 z1zMLnVqih0P0ARe4JZsQMMJwzSFkwmT1O31mts2ivDunUGwhom9K+DDBP5Hk1AA71g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795349254;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Hxw1giaT6pw/VL4u/ym42vP1DTcIIfJ9q69LRz2vTmY=;
	b=EXaStk9iH7wJBjWl1F7KDl8hSoMRw+I6D19K4BVA/t3hfV5jwrrLeHaV/JKlzmDYuVag
	 FOJplg1rqIYgvC+MIveWBxNlro8NwI4VUirvKFthnp2HnEHtYwrL9CKxNhrC8ff8QWK5/
	 JlgNprJG1oUtpKxcwfGVDOoJNh1TDnv3/tvksVrt2GFs3rGAfF+QJ7m/z/uLwmOyRmg8T
	 Km2cOL9i/1N5sUxGvaPfQddjw+6vKnt30U69zgVE7C3N8X1uWbehEP3v03xKkn/4nxmDE
	 1UbVwC2IlHeNNsD9VimzGa/+YC+svXi4QxePIGArwrOt0mDQXrkquD+aD2QGSKHKYRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YNYi9uTg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7960A606A320
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YNYi9uTg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AE01F000C6
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 12:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795349254;
	bh=Hxw1giaT6pw/VL4u/ym42vP1DTcIIfJ9q69LRz2vTmY=;
	h=From:To:Subject:Date;
	b=YNYi9uTgiXsE3v2RiUS2JI612VWq9S8Kn+Sje0Gl7eqhzwT5UWasQeGnytzcUMet2
	 A2XZbB63Ao9t/AAUK/MuHCOBYgX1dP0ekewrdT9hT0PtodkIUrh6Ln7GmqmC69GsB0
	 VpS/xUxE5oZoba/5mSFYuAI99CD2c3AgIQugFbU4BjbKrBG/BzE3aE/CxuI7WToGFo
	 R8VItQWbnlDOKQF4Lq+wQ4/aWgcyYM9ey65bu76NoCZvHzW4IjGF5Wqd+OjzuZGXLW
	 GL3nOMKMXlhbaJYSXqbFv39IXacOishKVvS4LiYK4DEQ+Uk36pro3JniOJN3k9WEkv
	 zaFME4hemDAKg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 0/4] mptcp: fixes for SIOCINQ
Date: Sun, 22 Nov 2026 20:07:25 +0800
Message-ID: <cover.1795348666.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - patch 3: drop mptcp_data_fin_seq(), reuse mptcp_data_fin()
   - u64 return couldn't distinguish "no DATA_FIN" from "DATA_FIN at seq 0"
   - mptcp_inq_hint() checks rcv_data_fin/TCP_CLOSE/RCV_SHUTDOWN first

The goal of this series is to make MPTCP's SIOCINQ fully consistent with
TCP's: both report the number of readable data bytes, excluding the FIN
byte.

Patch 1 fixes mptcp_pending_data_fin() to use >= instead of == so that
DATA_FIN is processed when ack_seq advances past rcv_data_fin_seq due to
OFO queue processing.

Patch 2 adds missing smp_wmb/smp_rmb barriers for rcv_data_fin_seq on
weakly-ordered architectures.

Patch 3 fixes mptcp_inq_hint() INT_MAX overflow on passive TFO by using
mptcp_data_avail() instead of ack_seq minus map_seq, and reuses
mptcp_data_fin() to guard the FIN byte (+1).

Patch 4 adds mptcp_inq() that excludes the FIN byte, matching TCP's
tcp_inq() behavior, and switches SIOCINQ to it.

Geliang Tang (4):
  mptcp: handle ack_seq advancing past rcv_data_fin_seq
  mptcp: add missing memory barriers for rcv_data_fin_seq
  mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
  mptcp: add mptcp_inq() for SIOCINQ

 net/mptcp/options.c  |  1 +
 net/mptcp/protocol.c | 62 +++++++++++++++++++++++++++++---------------
 2 files changed, 42 insertions(+), 21 deletions(-)

-- 
2.55.0

