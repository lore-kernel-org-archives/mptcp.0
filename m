Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C210481FBA;
	Tue,  5 May 2026 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993306; cv=none; b=Jh+oVvQH6e0c7EQNkU1X1fx1wWMAqlVbf+AQkhH+Ob5X44JA5vAKJPl/J3+tWfQmqTEA4JFCbZjsEhlwL3USfph/EsmHJFdjMxavlGs//z3mKXt6dE95Ob6H98Qse6YaIAbcVAMp09HY/c+wnTLIVbQA/JX5RctQwlWjnWQMOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993306; c=relaxed/simple;
	bh=yvvq3YbFBLFXz+pdvskE+PM+OD43cVKZ0m8B3R0R+3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dgTpmDd7UmeGehRuZS6QIpD8Ixx4o3D7p/t02YH60AJO5SMmB3079UGy9Ibz2/fMooT36ezkDZJ98WcPNILixD9m5E6WsKSfj4YhyQky1VZlr5gG+Zbye4vEZVKeD1m+8J+ElDhHL7ZkVM7l+bahozfEYGmxjS7hCGZ9WEUdK1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwtywoXr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwtywoXr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8204C2BCB4;
	Tue,  5 May 2026 15:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777993305;
	bh=yvvq3YbFBLFXz+pdvskE+PM+OD43cVKZ0m8B3R0R+3E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uwtywoXrfGZh8VGX/4sufOQrFtWrjjWI97IP6OsTfNJox9RHbI1/avJNdDN/BeiOm
	 BAXWcIZgFtgaOtresj9B1nBxjmmJJlNYhEErSp0J5htCfGNIZen9iF7A000dSTONpR
	 L07QLz8ZdgZPrF9HAemkQf4F2+2ryW6ePRVyFiew7zFgn9PdMhJHIbUcz1DEWZpYhe
	 HxKbpILL98Xbs7hP+BKfCMVn6EeVNvOjgw8K2rCHZj5cZ+0EYqpY9nO59dYTAIA7Yv
	 NsXfvAqiAb5vIuOoDvPEqZe8VZPnKx/78EVuQ486cK0Q3kIObA0RikZPAVxEed+iRn
	 HMdYiXs1dWDzQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 May 2026 17:00:56 +0200
Subject: [PATCH net 08/11] mptcp: pm: ADD_ADDR rtx: return early if no
 retrans
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-8-fca8091060a4@kernel.org>
References: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-0-fca8091060a4@kernel.org>
In-Reply-To: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-0-fca8091060a4@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Christoph Paasch <cpaasch@openai.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yvvq3YbFBLFXz+pdvskE+PM+OD43cVKZ0m8B3R0R+3E=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ/sTmKX4oq5db7+iL42tWdPxs/v6oWTC6S1ci+cv73o
 71PLwp0dZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkfAPDP71Xk55k5HTa8kb8
 vxh0O3/PH/VEuevyvYyvLL/eyQ34oM3wv1x2+9ecyxkZrtKvLlcc5Pt+oaz04Vfb2fMNRT59fxG
 zihsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

No need to iterate over all subflows if there is no retransmission
needed.

Exit early in this case then.

Fixes: 30549eebc4d8 ("mptcp: make ADD_ADDR retransmission timeout adaptive")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8a5dba7fe66e..4a6e5ab30d80 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -308,6 +308,9 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	unsigned int max = 0, max_stale = 0;
 
+	if (!rto)
+		return 0;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct inet_connection_sock *icsk = inet_csk(ssk);

-- 
2.53.0

