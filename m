Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A891413C8FF
	for <mptcp@lists.linux.dev>; Sun,  3 Aug 2025 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754223235; cv=none; b=OiDzYOTYDO5vmaz6YQIbnScP0pRhEEzEWE2i2JNj8h+8OEFHpbzKBSaYdqBYtjKn+eLWEgNQgZ0rxhM7maujSJf+pdAE5W2NE8rdEXPEPn7zgIFQ4X9QBzQhioNbChLmh26EDzls1mL5zub1H7EXMJZD/zVLMcBeTyqWD6sjiPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754223235; c=relaxed/simple;
	bh=LpiI+GZNegbVR3JlI2m00qncyl4JyKZeylLqkjn3NNU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UYesYb08KWOMlovyuCtLlOxZI4adlktyHhMRgkZX0qKOAwswlzl3n2xQzDjFkNLAyCr3nrEgn7ikZj+Y4fKAnYWtU7wIJmO7GlSDjbQVNzUH31BsKEv5w2PggGzDm8xe5bWYwcqMEbDl6rLl04vd4oZditfmxnyS7mVQXFkYTTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdUvhBgc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdUvhBgc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCB4C4CEEB;
	Sun,  3 Aug 2025 12:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754223235;
	bh=LpiI+GZNegbVR3JlI2m00qncyl4JyKZeylLqkjn3NNU=;
	h=From:Subject:Date:To:Cc:From;
	b=WdUvhBgcir/fPAlkeKlkhScXUey8H3qziTUr/uF1PwJqfi24yR9Zfvf8FGg0w7bbm
	 nJJT2CBE6YVYAARs3w4sd4anPc1g0IFktVtYMX2U5WyS8xu71DWRToBr0NL5ai/RJi
	 y2oJ4ZwFmSt5Lyubpo85QtZsNeCvVokshidwe/sgF/V9H8bKjlGA1e0o4sLS1YHdAw
	 AFdbfz5rqQQEWMNUs2FqIr+PjGsnT6R86eOgGLCrBBdaUQFZXF6/Iicap+jH2zf1cZ
	 Kaxw4za7ZYWAjJq+lvDLbD0dV+C0zd4y23kiOXZJMknJKVEJeHpLM9NhVL9T448jik
	 aJ/EpxbpA8sZg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/2] selftests: mptcp: connect: fix C23 extension
 warning
Date: Sun, 03 Aug 2025 14:13:42 +0200
Message-Id: <20250803-sft-mptcp-warn-gcc-v1-0-6d87808721ea@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHZSj2gC/yWMQQqAIBBFrxKzbsBMK7pKtBCbahaZqFQQ3T2p5
 eO//26IFJgi9MUNgQ6OvLsMVVmAXY1bCHnKDFJILTpRY5wTbj5Zj6cJDhdrUXV5Ue2kG0mQjz7
 QzNcXHeB3HSUYn+cFJfuRNG8AAAA=
X-Change-ID: 20250803-sft-mptcp-warn-gcc-4808047d562e
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1327; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LpiI+GZNegbVR3JlI2m00qncyl4JyKZeylLqkjn3NNU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL6g+pLd+ZGMsQ7FC47GKgXIb/qTbpsM+uTM4fN1rY3e
 4rLZYR2lLIwiHExyIopski3RebPfF7FW+LlZwEzh5UJZAgDF6cATIQrjOF/8LXMCb89Yxwul5+T
 qws6VBK5wTPT2/a3x+3g/ijbCfw/GP5w5Zvec7/1q++dtOiSG1ukT8+9tNZF9eCee7WvIpyrJOX
 ZAQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

GCC was complaining about the new label:

  mptcp_connect.c:187:2: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
    187 |         int err = getaddrinfo(node, service, hints, res);
        |         ^

  mptcp_inq.c:79:2: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     79 |         int err = getaddrinfo(node, service, hints, res);
        |         ^

  mptcp_sockopt.c:166:2: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
    166 |         int err = getaddrinfo(node, service, hints, res);
        |         ^

Simply declare 'err' before the label to avoid this warning.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      selftests: mptcp: connect: fix C23 extension warning
      selftests: mptcp: sockopt: fix C23 extension warning

 tools/testing/selftests/net/mptcp/mptcp_connect.c | 5 +++--
 tools/testing/selftests/net/mptcp/mptcp_inq.c     | 5 +++--
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)
---
base-commit: 5c7ec796258e1599e2033ae0f40434b2ba6ca21c
change-id: 20250803-sft-mptcp-warn-gcc-4808047d562e

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

