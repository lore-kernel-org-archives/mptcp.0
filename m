Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599689;
	b=nm+1aj4HiiE/qh9l0ulERR4dlMSoYkaP5XALc4kvszcEqjUp/4Pxbfs1DNhGeS+ul1y3
	 Cd26yriYnkP1ycttQaw9/OIRcJR2SP2Tq+7pQW4DFyYxy0tAvplk0en2WjhSqEAF9jHwE
	 rzKuxRPD42dk/g2dTZwTBECoIcG0DxUlRX3wkYD6pz3hWqWh041gH4A8gXhuEYa8t3Kmy
	 zWtYwKNdGkk2lNJvJBZB/1c007zCjQ4HjfvLFfHode7HyaSnfC7wqlw2PsFOSA3e3Ztfm
	 8wSMTR4FDVGzcXA3WX/MFL8RmkUqw5lH2t6oj4faAZnQJq7EJ8ojt8xXyvPZIttQ2ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599689;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dOQQHZT5y9iZOXtyva7qJi/mlZZok7kK1SJ1l4LJY1U=;
	b=3NDz7Dg/sTgLxtSB/QOGepv/fgYb7SfpbKdTwmMgRhzRcXPHu5FFHYiqCstL0UO1dp0E
	 dAtGMqITQxJA8ru7EKts81iVEpYE+ELGWC9fQPwaMkJUqi6DxPMxcCTNdRmXgzMx/QwDO
	 WnCbeeokFaTeHhHQRCgw6gyMVcn9nv6M0F8DQVt0W2Yv/Thz2QdcdthcxCk4GAtANYSTa
	 ellRpDVwkEsS33oA32+L8D0xWKHDWD52GFY+9uOw0jQf+uCvE3oJl7bRT5DTeU6pl1lbF
	 dESTnWInVlYtGVrQIM94gZcngx0Yey2o8jQ9ZStzn/CaDcWgYYOfzXYvOi2eZ2GhwwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYDvRXfA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834E0606D0E0
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYDvRXfA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24E51F000C8;
	Fri, 13 Nov 2026 19:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599689;
	bh=dOQQHZT5y9iZOXtyva7qJi/mlZZok7kK1SJ1l4LJY1U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KYDvRXfAcCUhWnPPr/Z9fvct6lpoZECCSrWxB41WxfddB14YSg61tBFuH4FopRWbj
	 bNH/9hATaeo2gHB0UOzEuRvrgVBxE0BQcasKEbZ++43ApSbLYBsJR0LjFSftQ1lnAb
	 no457kJUp4xKGO8C0D92ahXytvpYGm+DFW4y2UhxxdsO0nXs0DyBKr/wFM8wLUMudf
	 m6pnXRTE3yRcgmTpeElDR+GyrzUOqPfAVSdtk2RASh5EnARVgy3zOUfRE/3VX2ZfdN
	 GueMfwbFbcSz07dg0AY7QLyggTeB9jIdCPl7tx+vIXqSZ5UBlrlI5m8C6naUVUxHTj
	 3iXCHAoO7/MxA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:54:01 +0100
Subject: [PATCH mptcp-net 23/34] mptcp: use sk instead of casting msk in
 check_fully_established()
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-23-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BIchpMSFFRoVXDHhNN+GHJA5kr5JKEzhPgY9OxUNiJA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Zz166vxCoO7T9ifOmrMXBgnrVnjoL/C4+unEs4ena
 uer36s36ShlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiIJxMjw0cWtYURPy5ufr9S
 uvDMV/Xi2qXW6+zeP0llsj53Kbfg0lOG/yVfj5mvfiJwglW5JKDZIfOaDu+vtK0HumJ7zzr9npT
 ygR8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The MPTCP socket is cast to a struct sock in check_fully_established(),
to take its data lock. The next commits need it more, to push the
pending data.

Add a local 'sk' variable instead of casting msk each time: no
functional change.

The 'Fixes' tag here below is the same as the one from the next
commits: this patch is needed to fix the issues introduced by this
commit ID.

Fixes: 36b122baf6a8 ("mptcp: add subflow_v(4,6)_send_synack()")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 6790c9e15521..a74520f6b069 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -982,6 +982,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 				    struct sk_buff *skb,
 				    struct mptcp_options_received *mp_opt)
 {
+	struct sock *sk = (struct sock *)msk;
+
 	/* here we can process OoO, in-window pkts, only in-sequence 4th ack
 	 * will make the subflow fully established
 	 */
@@ -1044,9 +1046,9 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	if (mp_opt->deny_join_id0)
 		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
 
-	mptcp_data_lock((struct sock *)msk);
+	mptcp_data_lock(sk);
 	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
-	mptcp_data_unlock((struct sock *)msk);
+	mptcp_data_unlock(sk);
 
 check_notify:
 	/* if the subflow is not already linked into the conn_list, we can't

-- 
2.55.0

