Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF1F21019A
	for <mptcp@lists.linux.dev>; Fri, 21 Feb 2025 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150534; cv=none; b=hHagjLACxTR08um+9X68Sq7ipRskTYHx8YC0d1JAExudSPplTRBZ5o8aMDmPMnpVCJbykRA+ohzDc4tBbBkDA61bZ5Zh7v0qd2kJ23btFQMcyrxvY8lIMxunU3YQny/UZQnkHFWXbM8KkTUuv8bGnLs9zRIw1o3BE6zKQRetr38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150534; c=relaxed/simple;
	bh=MThlESMFiVJ8eLTIi5akvzkQe7dsqviahjzAW4oHnes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SYvI0HpEoBDUthT6EXUi64ddWffM4fv/FV1w9Zclq2T6av06TTeJE5aQ81LTMjyGkMZ1/sO9kKukqCejkLCpwTDokPWwUL/CCMtuPP6iqIJF10UkvrVpdf056/pzauFBXmVnC9SKfbAPmQPlAqB8uIAJgcXgywTLq+eF4rVu8fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reJqcMAE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reJqcMAE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C18DC4CEE4;
	Fri, 21 Feb 2025 15:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740150533;
	bh=MThlESMFiVJ8eLTIi5akvzkQe7dsqviahjzAW4oHnes=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=reJqcMAEUDaHDVUS2p4s4fv3L/a6fw/Q315jYjUkWMZschJpVQgxIi+2jUXHlIC3I
	 lguaqm5TvTNTU7xtkdZQ+0E97eIDBGIA3zrP+vUTBZqYiii5OIcBN7O8lXpUALgcyp
	 iroXX+B4ueXD+BB6010EjHpTbvMiJo8kAnoy/fqlq4iafshbOE1EK0rI1VRIl/DrJz
	 tbBeOoE/JBWXd63Am+OagJZhPueXXONLDOvHIkRXT5ntnJA8LYdN+kOBMl+KQYAMkV
	 tcDR4uGD9ooeZju7u1elQWPWDq03spD2L1QuHmYkWOrxTZvHGMt3ic9DH1R6mYc0lG
	 d+VpCWorHqhZA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Feb 2025 16:08:44 +0100
Subject: [PATCH mptcp-next 1/2] mptcp: sched: reduce size for unused data
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-mptcp-sched-data-ptr-v1-1-dbaec476fa6b@kernel.org>
References: <20250221-mptcp-sched-data-ptr-v1-0-dbaec476fa6b@kernel.org>
In-Reply-To: <20250221-mptcp-sched-data-ptr-v1-0-dbaec476fa6b@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2510; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MThlESMFiVJ8eLTIi5akvzkQe7dsqviahjzAW4oHnes=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnuJcDcRlKpkWhRNv+F7lor13Jb50iN1vPmySKI
 hvlgbhlJCmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7iXAwAKCRD2t4JPQmmg
 cwsuEADta2Z3wDoo/DxBVLNZfwG/L0Tdwl7ATMM4vta5MjNhI3q1ptdCWMkDd3x1HAPBKd3BPlv
 CKoggzUoKFafxoYwlsxvH38Q4Tf0OzjJHq5mOUoE1XvEw3iLjJ0dGbN49r/8UaEEnaeSsp5AkRK
 sacpoLDxu2o9LHp1tn9XfglO5JXEiJe+Hs7kfr8tTh96xHwIITYwU3P/NIxTlnd2a311lpVM5kL
 0IROhChZLsEavlhThbGOUIUeXUfZOX5KG1NjA66LZzJY33vn5UNKHUnPgxGA4JyVfypoyi2q18z
 qEAlyUWjbwZg0bq+7rqowgR0asQSHnYOFj9bh6VBiw8vh72boRThKgQZsRvOo9oOdPiPkHIZRw6
 I35WPVJ8Ul0lztPBmv17jf/H7ooK+oRuD7S0PSYqdNmPR8+ZpLWiCU4AbVt7OU9DFJObJUmd/ri
 12nqvAcJrMeZaqZGc+qNLiF6I4Zo6kzQej8snbWlHOonhcKC1085M22u4DAG3lEscJr06ONZkwI
 HmXMNokPfOJMstDCyKhBdvAAa/E6cBDyvdaC1YP0w4+c9eWnK4Rtd4K3up0VGHbG7/bajqsrXFA
 qk5306a4/Wuc+9LeIH6RmII8yaEbbodfMNmthXAjrfI1lCXoa8P7HRUBKmWE/z9Viz+DnF91IOT
 sOD8SfuI2bWbdiA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Thanks for the previous commit ("mptcp: sched: split get_subflow
interface into two"), the mptcp_sched_data structure is now currently
unused.

This structure has been added to allow future extensions that are not
ready yet. At the end, this structure will not even be used at all when
mptcp_subflow bpf_iter will be supported [1].

Here is a first step to save 64 bytes on the stack for each scheduling
operation. The structure is not removed yet not to break the WIP work on
these extensions, but will be done when [1] will be ready and applied.

Link: https://lore.kernel.org/6645ad6e-8874-44c5-8730-854c30673218@linux.dev [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sched.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 37d86aadaeaa523568a82ffb22254d1fb34a3d2d..c8e08f6c300d37584d3d89a01022b5677aa8b6bb 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -177,7 +177,7 @@ static void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
+	struct mptcp_sched_data *data = NULL;
 
 	msk_owned_by_me(msk);
 
@@ -198,15 +198,15 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	}
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
-		return mptcp_sched_default_get_send(msk, &data);
-	mptcp_sched_data_set_contexts(msk, &data);
-	return msk->sched->get_send(msk, &data);
+		return mptcp_sched_default_get_send(msk, data);
+	mptcp_sched_data_set_contexts(msk, data);
+	return msk->sched->get_send(msk, data);
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
+	struct mptcp_sched_data *data = NULL;
 
 	msk_owned_by_me(msk);
 
@@ -220,10 +220,10 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	}
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
-		return mptcp_sched_default_get_retrans(msk, &data);
+		return mptcp_sched_default_get_retrans(msk, data);
 
-	mptcp_sched_data_set_contexts(msk, &data);
+	mptcp_sched_data_set_contexts(msk, data);
 	if (msk->sched->get_retrans)
-		return msk->sched->get_retrans(msk, &data);
-	return msk->sched->get_send(msk, &data);
+		return msk->sched->get_retrans(msk, data);
+	return msk->sched->get_send(msk, data);
 }

-- 
2.47.1

