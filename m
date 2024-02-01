Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03D54A2A
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 01:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749623; cv=none; b=ca7u3/Hzp5nngLZ+3cKvFI8GIOo0O+a+vUebsjWM1qMeF1MkwTxI1HDYb2go/s63wkCGKINNjv1znFHGnEUFq1q+i9MSn6fC4Q6/RtvJqATnNY3cLMbJ21hHv6WUiOOAD61nre07zS0ezyOn3htj9WC6shaFjb5sSyjKvXk5+7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749623; c=relaxed/simple;
	bh=C6p4N3g9uMWAlaUtAwJ7jRlMORgSGBNiRFyjeWW4zqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fAtzf9+OJk08i+rr5Ui95tPqLuuV2tDQcLQK8GPAcV3NByYGoIexPKgSK898v74X9ZqaO+sWzYcWsVeOymtthidf+rfu+GN6Hw+6PIb/EWuLUCI44p9BTZXbg+h0g8eIqCvmndPs0bpT99Ez6e8rxRKPgHCUfcRc9eKhiEnEx30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKH+mret; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKH+mret"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EEFC433C7;
	Thu,  1 Feb 2024 01:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706749623;
	bh=C6p4N3g9uMWAlaUtAwJ7jRlMORgSGBNiRFyjeWW4zqU=;
	h=From:To:Cc:Subject:Date:From;
	b=hKH+mretLVXdeL/9ZQZwpRpJUqpnWGli4ruZrZLiG/RUHO6wfwVFxVwBRRaHS6KTY
	 jcT7ReFRThZsciqdksxQeFnDwfJT2VJW0efiCoB3d9v86fITngKgR1ocMMCiHjtiBw
	 7MWqEGpha/TPPs/q+cThCxlqU9ihNP3VSB+0sqA57GicXab/oe9cUS04e2GYI1Dd/G
	 5euJryz6es5OLG74my+pCjyiWRrRT+F/DyHeRIfPHG34enGtZogPZVnYIpiEA0trgh
	 Q7R9B/HFnTyoOhh8HzRdwjc6oX7kLJOV3kMUpOOLXv9+l+xdMDc2RcRjvn7KAzQknw
	 CoxG90aH4XJ9w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH mptcp-net] MAINTAINERS: update Geliang's email address
Date: Thu,  1 Feb 2024 09:06:58 +0800
Message-Id: <eb152068d96e0980d010272f5190da7807f35c13.1706749536.git.geliang@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update my email-address in MAINTAINERS and .mailmap entries to my
kernel.org account.

Suggested-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 .mailmap    | 9 +++++----
 MAINTAINERS | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/.mailmap b/.mailmap
index 04998f7bda81..327e7eddd146 100644
--- a/.mailmap
+++ b/.mailmap
@@ -191,10 +191,11 @@ Gao Xiang <xiang@kernel.org> <gaoxiang25@huawei.com>
 Gao Xiang <xiang@kernel.org> <hsiangkao@aol.com>
 Gao Xiang <xiang@kernel.org> <hsiangkao@linux.alibaba.com>
 Gao Xiang <xiang@kernel.org> <hsiangkao@redhat.com>
-Geliang Tang <geliang.tang@linux.dev> <geliang.tang@suse.com>
-Geliang Tang <geliang.tang@linux.dev> <geliangtang@xiaomi.com>
-Geliang Tang <geliang.tang@linux.dev> <geliangtang@gmail.com>
-Geliang Tang <geliang.tang@linux.dev> <geliangtang@163.com>
+Geliang Tang <geliang@kernel.org> <geliang.tang@linux.dev>
+Geliang Tang <geliang@kernel.org> <geliang.tang@suse.com>
+Geliang Tang <geliang@kernel.org> <geliangtang@xiaomi.com>
+Geliang Tang <geliang@kernel.org> <geliangtang@gmail.com>
+Geliang Tang <geliang@kernel.org> <geliangtang@163.com>
 Georgi Djakov <djakov@kernel.org> <georgi.djakov@linaro.org>
 Gerald Schaefer <gerald.schaefer@linux.ibm.com> <geraldsc@de.ibm.com>
 Gerald Schaefer <gerald.schaefer@linux.ibm.com> <gerald.schaefer@de.ibm.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 6b49df9d5eb4..61a07588edb9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15326,7 +15326,7 @@ K:	\bmdo_
 NETWORKING [MPTCP]
 M:	Matthieu Baerts <matttbe@kernel.org>
 M:	Mat Martineau <martineau@kernel.org>
-R:	Geliang Tang <geliang.tang@linux.dev>
+R:	Geliang Tang <geliang@kernel.org>
 L:	netdev@vger.kernel.org
 L:	mptcp@lists.linux.dev
 S:	Maintained
-- 
2.40.1

