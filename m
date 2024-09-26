Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6245A4D8CB;
	Thu, 26 Sep 2024 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727356206; cv=none; b=W72ZjhMs+aMrXTbHeXBvnvZ+m0MQ9HW1EOzA6sLfUveKRfxvPZrIEOR9wAAS55Vu1jyFKL2O/cJZOqNg3pHefBB38i/HiKZ4G2quXA3t2MfvpmTHSvH8vgoY4IU1OC20sbHNwSsxDyB5T6S8aKwv0KpqWtcI+s4uTWg1U689GZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727356206; c=relaxed/simple;
	bh=SHX+7v7SktiuB0uZn4VwUt3KDDPOqnx7xJ+2a231HrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YRkpvza5ZUiHirx0Cp/TD3swr7ttN0dPwbDEzEEsIP3Pat4pL8zwFH7YvDmlcMrAGvVVa30/d+Egi5mV8ILxGOuweHE3xL85/9UdtuQ+Jtq5xH5VQu6i1z+FWV+nkeRZi8G4r4QDWPVpPCXCJWIXsaRAZVWG1IHQs8MsSZ3oLIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnmiKbqo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnmiKbqo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D747C4CEC5;
	Thu, 26 Sep 2024 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727356206;
	bh=SHX+7v7SktiuB0uZn4VwUt3KDDPOqnx7xJ+2a231HrE=;
	h=From:Date:Subject:To:Cc:From;
	b=TnmiKbqol6VurRRhqBcAjWIBvTWt6ZNxVT3alq7PbuoGXRUU4KuguWPnlVWvFQMIS
	 1JwSnRKd2KL3q9SbuQym5uAbquMmoP8U2pbdf0XE7Rx+uBxm0ukmLZPY/uaqYWeW5L
	 pmxtpglb3OnK5i7BEb4JNX0umjGzpw0Ro7T5kaYBzMxS59GC5zKQImOU1i/fzB/A4f
	 0mlnXEMO5y6MM5cR6PSi7F0hfWwfwCtmdgsXtFIRXNs6eQgpEvfyx8/hpyuoPCJCCM
	 k8NyGhYXol4hXZ5QjQWZWwccjUz8B6NLkzmjMXB8zIL77/dsOM8jAALU8AK0qR0dNt
	 xzoVV64U+r3lQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 26 Sep 2024 15:09:58 +0200
Subject: [PATCH doc] docs: gcov: fix link to LCOV website
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-doc-fix-lcov-link-v1-1-46f250cb7173@kernel.org>
X-B4-Tracking: v=1; b=H4sIACVd9WYC/x2MWwqAIBAArxL73YLZg+oq0YfpVkuhoSBBdPeWP
 gdm5oFEkSnBWDwQKXPi4AWqsgC7G78RshMGrXSjBt2hCxZXvvG0IePJ/kC1rLY1fW2qhUC6K5I
 I/3MC0WF+3w/xeP+baAAAAA==
X-Change-ID: 20240926-doc-fix-lcov-link-0bfc5a83a1be
To: mptcp@lists.linux.dev, Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=SHX+7v7SktiuB0uZn4VwUt3KDDPOqnx7xJ+2a231HrE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm9V0re4YpjGSaLmMu4AWrXLyEuvOotm10oCt+G
 sxsMZe7gPOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZvVdKwAKCRD2t4JPQmmg
 c23KD/9GnTA3ewEKkTex4xhVP1CtknQt+d+7SSULMx1k2Y2XJSqrOJqRkOY5xE2DkmgAMwgGIVX
 2uMv/ZoSSChZTmZSqSMtoDC2ZrrrywGbxHIMLnI0AyiX1I+VzhCyDpI6nvFVkZhzDlUfPlHOe9+
 5an0T+cnwhRxDtPXS4NtGqLoMpwa/J2H3O7OQCjrR8/n+kciNpOrM9C6u3riERt4ZIZ8VO2d9yB
 +UdpaBRzQ3K6dZSX0u4mT87eLSABfjJ66qKx5Vm8EmClIT/LiBnNn3YYw7FuW7s+40U6C37pKsl
 F3ZfzA38dVPqJz9JP0/zVxMd3GRLap4FO8648O0kO3DxfchrlkjrdgYmMR91jZ8iTzNx6tYgOuu
 +gEE0VM0YTfgfJas7ou4+IAWwJz4ts//hsAQI7VWAh4Oghy/7mX5lLL1Cp/APa2NXDhaQKl1zKb
 IlBfn4/TeDQ7SdJtIVvv+oj7JLEx93jqneRvs2L5iEYv3eiAoQRM+rP8CbcSRYmkgTMVywmTXJ4
 5c5TXdq7hT2qtqj52ZkDjvzf3/CU/m/u9/fmZSzoBJJXXe1CvBqQUkJO1aYcG0E8Ni5fVlGX9nM
 h+3nnfhuuJFrPsQaoBk/2K2OMXpqY8TtqtrRyoytatTWUGiOe+fwU7zGb1ACYuGTFlFzh3WAI7T
 q+ggk4ozbw3mLMg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The previous website hosted on SourceForge is no longer available since
January 2024 according to archive.org [1].

It looks like the website has been officially moved to GitHub in June
2022 [2]. Best to redirect readers to the new location then.

Link: https://web.archive.org/web/20240105235756/https://ltp.sourceforge.net/coverage/lcov.php [1]
Link: https://github.com/linux-test-project/lcov/commit/6da8399c7a7a [2]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/dev-tools/gcov.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/gcov.rst b/Documentation/dev-tools/gcov.rst
index 5fce2b06f22954c3ac6e7d7118064f015624c4a9..53a85ffebcea9fc99484296c5193df7ab5ec4e3e 100644
--- a/Documentation/dev-tools/gcov.rst
+++ b/Documentation/dev-tools/gcov.rst
@@ -23,7 +23,7 @@ Possible uses:
   associated code is never run?)
 
 .. _gcov: https://gcc.gnu.org/onlinedocs/gcc/Gcov.html
-.. _lcov: http://ltp.sourceforge.net/coverage/lcov.php
+.. _lcov: https://github.com/linux-test-project/lcov
 
 
 Preparation

---
base-commit: 052f172ef127e3b76f31e11f71e957e552cdb94d
change-id: 20240926-doc-fix-lcov-link-0bfc5a83a1be

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

