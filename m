Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EFD254863
	for <mptcp@lists.linux.dev>; Tue, 25 Mar 2025 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899000; cv=none; b=WvN9xOWop0PLbtA1cP68LNMg+VrPjVho8yLaDgiKTOB8fIlwCQgdkBy774a/9MPtB56F33Y5QTlV73QnI7Cvajle+5McA7zaB7fkEKdYskm+RSQq5koDvNNHjEYBnH1sGthzdiKnNGwRzwrOSy3aQ3Vd+yzumhPpFH5cyfsY/k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899000; c=relaxed/simple;
	bh=mUV8Moxz808qRjq3uSxYJUf9iwIIvHpEwI4Hu5B56ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUeSg94xLrD83/cAaxOW6j9gUo3E3aOZoYuwkoAY8P5ONH0P79WYdqY1dzYjNwenyHDOZaU25R30rCRQApSaiDX5zOEdREwGWW781kY0czVeknjuxlaUi5VD5NjJgesD0KZADiwqV1eu+r5FgAFn4k6NXHq80I6W2jdBjf0/qyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFry65qu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFry65qu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B256DC4CEED;
	Tue, 25 Mar 2025 10:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742898999;
	bh=mUV8Moxz808qRjq3uSxYJUf9iwIIvHpEwI4Hu5B56ks=;
	h=From:To:Cc:Subject:Date:From;
	b=AFry65qubgt6XG8s9+IkIVOmKEAW8i0QHSPIBnZT0nHhZrNyKkPclfb+Dx3zsZc2j
	 kjl+h5/lKvBtAokBSkBrpnzamZanXuyllHK0aikNbkLBKngtsASRTQaBEJ9DBT6JoI
	 ZZEkGML1FwrKeT7bdnv3yWdawsyMk6XwkRr6rJmh2veIkXGZAyZf+i8RRLdHyZI/oT
	 kX+yXdFkUpbNOulVDaqwAVnVmL7ncSNqEEvAQfaRawahjezJYM56qddv8K/rxXRYiX
	 SKMph/dAX9WFBsCEt/L9sFtcw+ws9uTAv8/DkiNR6GkDRcvRE2134+6MuhfprNgWya
	 utPe4FuRq3ukA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1] mptcp: fix cast type of is_fully_established
Date: Tue, 25 Mar 2025 18:36:34 +0800
Message-ID: <27b15c2de6fe36088ef95c4823d9e4a6d7bc9ec6.1742898970.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The parameter type of mptcp_is_fully_established() is 'struct sock *',
not 'void *', so this patch casts 'msk' as 'struct sock *' instead of
'void *' in mptcp_can_accept_new_subflow().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 409bd415ef1d..da452a1d5433 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -60,7 +60,7 @@ static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 
 static bool mptcp_can_accept_new_subflow(const struct mptcp_sock *msk)
 {
-	return mptcp_is_fully_established((void *)msk) &&
+	return mptcp_is_fully_established((struct sock *)msk) &&
 		((mptcp_pm_is_userspace(msk) &&
 		  mptcp_userspace_pm_active(msk)) ||
 		 READ_ONCE(msk->pm.accept_subflow));
-- 
2.43.0

