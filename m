Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985524A3D;
	Thu, 16 Nov 2023 00:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUWJ3CqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D366BC433B6;
	Thu, 16 Nov 2023 00:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700094712;
	bh=5f40ZioG1ogz3Pf9ezONiK0STbvS2+za3qrEMD7o4QQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YUWJ3CqSzm2DeHmwnrVoVm/0y32aVeC71v4lVygLLtDvgStm4qvz010m1FyUoGera
	 JaR28YhYNaNXrUJtJVreGpH+VKY1jktT5mNE5kvJinP0ju2T4nt5t03RHdYaX2OVZk
	 3X0261qYfW5YiAGgQ9caRv1POW7B8IuoCImMa9yF4BFpjqeB/lgbqrgWDfXMrrnUCd
	 8qS0ns1DqI0cmWnbbY954TKEv48ei5OW/PeXhG7azoUpT9KQu+Cuc2X4jP0O47K7dR
	 tl77R8qCL5uuiaNZ9hqYeFn6m7eqdffOVwv5WCZYVFTgJ7VvC4qVtDJmZjtcSpY2ld
	 9C2JRlLaJI/qg==
From: Mat Martineau <martineau@kernel.org>
Date: Wed, 15 Nov 2023 16:31:34 -0800
Subject: [PATCH net-next v3 06/15] mptcp: userspace pm rename remove_err to
 out
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231115-send-net-next-2023107-v3-6-1ef58145a882@kernel.org>
References: <20231115-send-net-next-2023107-v3-0-1ef58145a882@kernel.org>
In-Reply-To: <20231115-send-net-next-2023107-v3-0-1ef58145a882@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.4

From: Geliang Tang <geliang.tang@suse.com>

The value of 'err' will not be only '-EINVAL', but can be '0' in some
cases.

So it's better to rename the label 'remove_err' to 'out' to avoid
confusions.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/pm_userspace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5c01b9bc619a..efecbe3cf415 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -276,12 +276,12 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		goto remove_err;
+		goto out;
 	}
 
 	if (id_val == 0) {
 		err = mptcp_userspace_pm_remove_id_zero_address(msk, info);
-		goto remove_err;
+		goto out;
 	}
 
 	lock_sock(sk);
@@ -296,7 +296,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock(sk);
-		goto remove_err;
+		goto out;
 	}
 
 	list_move(&match->list, &free_list);
@@ -310,7 +310,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	err = 0;
- remove_err:
+out:
 	sock_put(sk);
 	return err;
 }

-- 
2.41.0

