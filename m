Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C83D23B61A
	for <mptcp@lists.linux.dev>; Thu,  9 Oct 2025 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031216; cv=none; b=r20V/g9ZeCt5J1c2iJeGebhU4jFJsxcqGlZ7FfP8WvKllEsu2tzqjpzOxXJuIN9NyyW0rHO2ShFhsbZvVjmdAa1e0WN/NRsEMElAle6lVOagOG3R4Cm1K+ktRP6BEL0ZE9vHEYlfZc6hwGEFGPJYKh7351WN5bgGiRhK8s79cqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031216; c=relaxed/simple;
	bh=AZY3T2vWI+gnOfoPK245lrwFKYlIErypav21nSBwNYw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gbASx6qXapnjAMGYzOnQ0QA6Mh9m3w+shJh88KaX+IZuThNhF2+tZ1j1coXsaUCU+3i56IUtVevOSZvcpfTKJ0D8Rs/CiTXCcUHvgLSENN/T4UiIO/kTaFgp1TZzye0GScyHnWbsIq4cJ3uwNgeftrDfAIz8tK3O8m7yvkg9CHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGbCzkWn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGbCzkWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CB8C4CEF8;
	Thu,  9 Oct 2025 17:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760031215;
	bh=AZY3T2vWI+gnOfoPK245lrwFKYlIErypav21nSBwNYw=;
	h=From:Subject:Date:To:Cc:From;
	b=EGbCzkWn7TfP/DkyGcG706w6YD+0TmSYtB84r3e/S7JgCRJ14jXGEK0zeJYtmwrPM
	 M4NPSnjdadBBQq2C44ZLXFFyTIEmoyUodem39N0lxgY0FtKIZ53rKfB0OEFyl3VP8i
	 ks5es5W3hBTpk+NkUPUGxEz5HgvwDBQ51SUU1zMGo8Uix40g4xFKlgEDuVXN5Dexqv
	 aWgjjs5Ne8Si6Nu1PNenYZY/ijVs4UsfKr6DwFXDbXx6CO5E98qDXaCktJgk14jU5A
	 nirmZl2cfaYj+A7ZcuZ5DH+5gArIIQIE0DlrAg6T4BNIh/80QIbbErfDs3gHvSAiud
	 TFr2ZqcdmsKZA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/2] selftests: mptcp: join: code dup + new
 'bind' tests
Date: Thu, 09 Oct 2025 19:33:23 +0200
Message-Id: <20251009-bind-extra-listen-v1-0-5ad2077d77a9@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOPx52gC/x3MQQqAIBBA0avErBswTYquEi0qpxqoSVQiiO6et
 PyL9x+IFJgidMUDgS6OfEqOqixg3kZZCdnlBq20rZRqcWJxSHcKI+4cEwk2xlgytra105CdD7T
 w/T97OHyaPUoGMLzvByLCk7BvAAAA
X-Change-ID: 20251008-bind-extra-listen-7335e35454d2
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=715; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=AZY3T2vWI+gnOfoPK245lrwFKYlIErypav21nSBwNYw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKef3zNsSWFqaTPL32Sqv/LBJHN8ze0b2RhiD8slyFvn
 hExV25aRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQWeDH84XgbPz3G5YFkoXnQ
 s6bMpo0HvaddEHmVcZe5ZuuVr0uK9Rn+J7p/nLkxz9h166Wgataz0yMzN5S42J09Uedo2Lz5bHs
 XOwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A clean-up patch, followed by a few new quick tests validating cases
where the listener 'bind()' to a specific IP address.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      selftests: mptcp: join: do_transfer: reduce code dup
      selftests: mptcp: join: validate extra bind cases

 tools/testing/selftests/net/mptcp/mptcp_connect.c |  10 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 166 ++++++++++++++++++++--
 2 files changed, 166 insertions(+), 10 deletions(-)
---
base-commit: 3afc295b5e6e698696cf1fd75db194db2c7f64cd
change-id: 20251008-bind-extra-listen-7335e35454d2

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

