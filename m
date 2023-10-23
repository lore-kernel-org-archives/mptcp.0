Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77289219E2;
	Mon, 23 Oct 2023 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Do62zeQm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41FDC433BC;
	Mon, 23 Oct 2023 20:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698093935;
	bh=w1fB4DHVnccpvzxFWt0SdPjP8cvBQUJXUy4NYZuGi0w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Do62zeQmroTZ91ppg2Lki/Efs1Ru+VqT4G/fqxGibUw6zQpQwzAboC51DT/cp71ZU
	 b7ErTNX+DtssNYZUFGC5xvv3LXcbvnh/9L6xS+GbLxx1sCAn2JKx32E8cIghPoHCYD
	 1Nx60DzBtGEPn5D2j6ptJmaUrGQK4I88XRL6ag6p42bARW4gmObRH42+IyfSfw2gPV
	 6LXvLAA05vw1Psj1X3DeXQkvi3cvcuujv2deeLO5gTgJYBu56NhFZnkuzbHeRwkkwG
	 FM8DUmmemR40rfBAyfWuShdkPlzP3D7QhiznxA7A1vD6llQ+7XxDH3pJnvpg4cqmel
	 Zpfs7SyFBUHow==
From: Mat Martineau <martineau@kernel.org>
Date: Mon, 23 Oct 2023 13:44:41 -0700
Subject: [PATCH net-next 8/9] mptcp: ignore notsent_lowat setting at the
 subflow level
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-send-net-next-20231023-2-v1-8-9dc60939d371@kernel.org>
References: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
In-Reply-To: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.4

From: Paolo Abeni <pabeni@redhat.com>

Any latency related tuning taking action at the subflow level does
not really affect the user-space, as only the main MPTCP socket is
relevant.

Anyway any limiting setting may foul the MPTCP scheduler, not being
able to fully use the subflow-level cwin, leading to very poor b/w
usage.

Enforce notsent_lowat to be a no-op on every subflow.

Note that TCP_NOTSENT_LOWAT is currently not supported, and properly
dealing with that will require more invasive changes.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/sockopt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index abf0645cb65d..72858d7d8974 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1452,6 +1452,12 @@ void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
 
 	ssk->sk_rcvlowat = 0;
 
+	/* subflows must ignore any latency-related settings: will not affect
+	 * the user-space - only the msk is relevant - but will foul the
+	 * mptcp scheduler
+	 */
+	tcp_sk(ssk)->notsent_lowat = UINT_MAX;
+
 	if (READ_ONCE(subflow->setsockopt_seq) != msk->setsockopt_seq) {
 		sync_socket_options(msk, ssk);
 

-- 
2.41.0

