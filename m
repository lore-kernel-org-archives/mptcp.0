Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B0218FDAF
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469813; cv=none; b=AMrJGnJviDFxSnlIrkvfP3VCM3KRP79GG5zdhDpsFWfVP9i4lTIXyBQ+KMWp47Wn2i/w8IL5q0sEY+HuskoJxZpTz5j/7j5PlyHjsHipNwU3nzJbWOnzc5JPgcg71eEPutP8KX9gdsL9eFoMNpjtYSIhLzO+Uflfo2OXh7XyUvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469813; c=relaxed/simple;
	bh=hN3agyD3X5i/gzavJ94nZKXl6iKgXdKHAjxn48A3d+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twj69AOxxv4Hr/DJY84t7P40cKrxdEj02vX6+BIVHnXG5UrP1zTkcrkBaUMpY849VhwAiVJo/F4tf14Wv8G+72xExI2iexSPOJ9u1tbys1NgM/985+O+IcozBPpMx4AuCE5MnScEZwGxsftAPItalopKq1STAz4v5++nhs/l3xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8BgQlvJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8BgQlvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA542C4CECC;
	Wed,  9 Oct 2024 10:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728469812;
	bh=hN3agyD3X5i/gzavJ94nZKXl6iKgXdKHAjxn48A3d+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y8BgQlvJZao0bp5TtonVXvh6DQ/mxHtHGYA60Pl4u9dA91ETkfn+yKDUSdBvQL0a0
	 j02YOWPVivBYB9g1SH4comrWmolq4M88ZizyKnzwUdyePO27FF+q9t7IgicyJ1Wm+B
	 b3piJHqpQ0zZiWWpTd3DJ+3QBFCo3afL4bJWYnRitRuOyVIq/J/WZu48xEK+B5lLMi
	 LT8mWb9iQgo41bWbrgqDze26V6CFap+S7amWHZIAQxofvZ/qGsIWG8MD/wsrnV/v6K
	 9Rtaaoele7uZ6d4Am1uPzjpA0tl0dGKNIapIF3eiRafvFwPJrDmblLpsHsrhy4P8Ms
	 M2I806qVuwz4A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 09/10] mptcp: drop subflow contexts in mptcp_sched_data
Date: Wed,  9 Oct 2024 18:29:50 +0800
Message-ID: <31e4d5218060cc1c8adb3971e5e0f39d899ad56f.1728469555.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728469555.git.tanggeliang@kylinos.cn>
References: <cover.1728469555.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The mptcp_subflow bpf_iter is added now, it's better to use the helper
bpf_for_each(mptcp_subflow) to traverse all subflows on the conn_list of
an MPTCP socket and then call kfunc to modify the fields of each subflow
in the WIP MPTCP BPF packet scheduler examples, instead of converting them
to a fixed array. With this helper, we can get rid of this subflow array
"contexts" and the size of it "subflows" in struct mptcp_sched_data.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 814b5f2e3ed5..84d67947a517 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -104,8 +104,6 @@ struct mptcp_out_options {
 
 struct mptcp_sched_data {
 	bool	reinject;
-	u8	subflows;
-	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
 struct mptcp_sched_ops {
-- 
2.43.0

