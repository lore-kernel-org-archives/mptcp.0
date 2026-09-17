Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3757D519930
	for <mptcp@lists.linux.dev>; Thu, 17 Sep 2026 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650830; cv=none; b=qqaPYzvz4RijJ1OsBorBYCcxBWiRFEYlfT2mm4LKTKmpZkFDaKDrJJQbxNcZ38s3vfnYScKbuXZLKYid4CUHMjVn+xJH6XnkKWna9Q2j4U8dMGPdovQfOgCPQPXpteLosuL9OEckTJlmuU4Z6w8oonuZOAymx+mf+Sj2C8YwCc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650830; c=relaxed/simple;
	bh=PQH22Io9GFvhRgo1tnhuZTJKWDaHrc5HilSz4VvpvPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tyJZsEFTPN+fWLXBBOQL4zOwSMtqf2je3AFPLip5Cd1T/NXHE+7HA3ox3yCIEEtnJG3JAN7rgXidhRJgR+a1WkWXJkpjrjbFA6a8LaCNG45sP7naSdBErsmEhsNlAN5yxDHbBRND6De9h4Ki0dvG0cTD9jEJvSYVPgCmNw1ZcQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkhC3p0o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkhC3p0o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B61D1F00898;
	Thu, 17 Sep 2026 13:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789650828;
	bh=PSq36IBPDkJHOXuYKAT/6jwtbFI4fRdaDLKx815qMBA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hkhC3p0objmwP0TG83+IoSJN/3sMfwgSqe92Ua8OvB0eEqbGyt96iLY1HhBi+08Ct
	 Jw3hCl2JcT5K15jMe6mNix93le6+zFLfbHqI0r3F4XwN7lC1j9K1EokKLPs7U7gdSm
	 QEIMAs33cBAmHvIs9j5SPsdZB/g01V4EL4XE83HH5rIocl+xaWCtyW6ieD6xtYk64E
	 keqspsi90Wwcwz5ogfns3GrMx+T5TOgyY1AxKG6FGhHL2LZ7udeIKLpKFK7Ouoecm8
	 gvfNnoMQU4Prnk+e2OvkhvJNnbXss2JQC6PqhXFoKF00BMiOPnWaJus53nLGGzLXMo
	 jhSSgEGVsv1YA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 17 Sep 2026 15:13:14 +0200
Subject: [PATCH mptcp-next 2/2] mptcp: fix bad accounting in
 __mptcp_subflow_push_pending()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-mptcp-fixes-7-3-rc4-v2-v1-2-1553391e7815@kernel.org>
References: <20260917-mptcp-fixes-7-3-rc4-v2-v1-0-1553391e7815@kernel.org>
In-Reply-To: <20260917-mptcp-fixes-7-3-rc4-v2-v1-0-1553391e7815@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=855; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=x9OBdAz5XjJ0gnu99WbTrETuTMZukPmhJ9IVUZjyhfk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJWP+9cZ16ckLBY5ILIvabUnfqX2QL/3WHZIH8nUkKfZ
 QrLx7V+HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPZ+ovhfwF3lsXSkg9bizvs
 fZRk/Xf9u7aJ9ffH5uI5OxzaJ9XavWL4K84uv3ezRvOLiClqkz9x3OIP+yoe0yiZUvT1v7fdGvk
 qFgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

If __subflow_push_pending() errors out we should avoid updating the
copied byte counters, to avoid mismatch push call later on.

Fixes: 0fa1b3783a17 ("mptcp: use get_send wrapper")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 01e37bfe4b7d..09779428e9ea 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1891,7 +1891,8 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			ret = __subflow_push_pending(sk, ssk, &info);
 			if (ret <= 0)
 				keep_pushing = false;
-			copied += ret;
+			else
+				copied += ret;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {

-- 
2.55.0

