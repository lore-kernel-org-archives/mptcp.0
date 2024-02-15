Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D9F1369A5
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019461; cv=none; b=VhTsRhxyu5OafqeAgHBKl9jCmSKoyNcPwOsjwhwMx2ghkpq1w0Htc+d+LjCclwbdE4oqlD9wm7dUdo3izN3hbx5ZpM6aSFRES0AbQGvRfU71ZrIlsXPfidxciXBog2BdpchD43DQcI3FANsnptWLSRa1g3HqCDmfFxVH5MagTDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019461; c=relaxed/simple;
	bh=+ILYD7qfGXPZ0Zy4uFyxwh3ermkUCm3451X/ZKY8tv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cis3Nx4q5PfvRT355UgYeCQRIfV5bM7i32xuQpMVuRdC6aIU4V4fQguHUmmsfsQ/MzwP4eEgDYCV8Z7FpiSZPbKcDsgF9x7dph2r/CXujNXmejf0RC1Oc8SXTqJ214ORqfhqeaZ/xO0SUZGSG1YgzBIh/SjuQIpstqkBjZWnqs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSwJEA7a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSwJEA7a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADCBC43390;
	Thu, 15 Feb 2024 17:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708019460;
	bh=+ILYD7qfGXPZ0Zy4uFyxwh3ermkUCm3451X/ZKY8tv0=;
	h=From:To:Cc:Subject:Date:From;
	b=cSwJEA7ayhEX8ZafeJrVDCG9WBNLlB5pxCiDhAeXEjiy/BHzhcvC3Fkc6YisH7EKq
	 33boI4hEgy5VaBhRres7nMA3powW3NV1Wi/wy6QUQnS+0LVfrbvD0fUwW9LFvVypmU
	 Cr/kmh9siBd9P2bW7YGZqoQLgu6CQnWLiey1oPWvIXsJdjRmnKbbVtEiDc3nPG5ymf
	 /mqxZAMRVaf5z0L/RmA4uzl0vYWsh7v4ZaeQSX/kldDq+ys/HzGZysV0gTq5iiiyrH
	 DlpI8RInJaO1cUWXhk4YoRFJ8tyoP0KxT8bZMdI5IT5iyzaWGokjgOWo3q05zUKfQV
	 MitU9WqpThvyA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next] gh: fix summary title's level
Date: Thu, 15 Feb 2024 18:50:44 +0100
Message-ID: <20240215175043.3707650-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1939; i=matttbe@kernel.org; h=from:subject; bh=+ILYD7qfGXPZ0Zy4uFyxwh3ermkUCm3451X/ZKY8tv0=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlzk7z+19CJnn8AnO+O5P9bj2/Iau/evS0upWuw HkpgY/VCCuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc5O8wAKCRD2t4JPQmmg cxTvD/oCMq1JDm31eNWLm9du7XbbHtBE9wGLD4fy4pE5KcvzwsYxndNkBCWPFs4HQTHtjf4PWeY YNWJlI7raP7MG6iRaaxUMWGMadRPA+fCNPzHqFZTo8zKcVT6KjabN4OpNC6fIFQgYi2ku3vC+g4 Hj0aZ39/DPnc/aAiM9++yZkr3LgQba7tMuowP9h3YkNnpt9DmJKsso2SYCiv9PGdUgwlFyNlxIQ SubZYch+MWUDkqOy1US3TLIn7ywV/xIp9XJvSs8V1qHZ3Qwr5SmoqU2GELVQ32aYCWu1vtEbrhD 7IrfAKKnhyyWIh4w0RHpwfE8pHXGaW5a1LyTCws3MgEv4RG6G44mMCAKD4X2iDYKU3yIbEKyYSG 7szQc/ukQN498t8kW7o8fv1OK79Vzo7P6PFx08J6ncrZgEe7aJx/U/48W5r+namT6uUZv8NhvWr PVBcYBzLhjIqK+KXHf7Xg6LxXaKpqhGwnR1WgTFbeD/qi6duxc15DZ5D0yRfpiwfKN8wDdiWJ4m UST8od/hRxoyqX4E/ZXAqXMvJQqYtGypq2YyHAB3fJCCJCtieOOIMmKO1GMRDaEXwOGaEdm8bhZ byqF+xG70Xl20NMS4ozZ5pkG1ToBZRruCFjJUMDmX2SmYNW6R3z+xRc9PLV3B9N8CdhZQ+FPGtk e3p3dmdgsODwY5Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Even if the doc suggests to use the 3rd level, it looks like other
Actions use the 2nd level.

Do the same on our side not to have our summary included under another
one.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---

Notes:
    Sorry for the noise: I usually don't send patches for modifications
    touching the CI files -- mainly because it is quite specific, and our
    team is too small to have multiple people working on that, and reviewing
    these modifications too -- but here we wanted to validate Patchew after
    having applied a hot patch with Davide: the goal is not to re-apply
    patches when tags -- Reviewed-by, etc. -- are shared on the ML, not to
    waste CI resources.

 .github/workflows/checkpatch.yml | 2 +-
 .github/workflows/tests.yml      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/checkpatch.yml b/.github/workflows/checkpatch.yml
index df31d122d674..f70de5d1bfda 100644
--- a/.github/workflows/checkpatch.yml
+++ b/.github/workflows/checkpatch.yml
@@ -45,7 +45,7 @@ jobs:
         if: always()
         run: |
           if [ -s "${{ env.DETAILS }}" ]; then
-            echo '### Results' >> $GITHUB_STEP_SUMMARY
+            echo '## Results' >> $GITHUB_STEP_SUMMARY
             cat "${{ env.DETAILS }}" >> $GITHUB_STEP_SUMMARY
           fi
 
diff --git a/.github/workflows/tests.yml b/.github/workflows/tests.yml
index e12bba92b4ee..4a406ec5f687 100644
--- a/.github/workflows/tests.yml
+++ b/.github/workflows/tests.yml
@@ -72,7 +72,7 @@ jobs:
         if: always()
         run: |
           if [ -s "conclusion.txt" ]; then
-            echo '### Conclusion' >> $GITHUB_STEP_SUMMARY
+            echo '## Conclusion' >> $GITHUB_STEP_SUMMARY
             cat "conclusion.txt" >> $GITHUB_STEP_SUMMARY
           fi
 

base-commit: 52e05de42e1094a943053af93ea08c51a44091f7
-- 
2.43.0

