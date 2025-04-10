Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CBE1F0E3C
	for <mptcp@lists.linux.dev>; Thu, 10 Apr 2025 04:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744258469; cv=none; b=pwu5AzxmNxYT6/XLikUSiCTxrHeCd0SklNAnaHBDPRkiuM7laVZ7Gawu7S/WcADJjVaBMobHqDa92+bRyfiwQ+fLPqmKdV4WeyYAvgHRlBZR8EHmtrKASLuqyvBXQGybXnI2/ERLMF/HXtoU3X/oHHPMFh8c0Kypjb2+3SgfJ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744258469; c=relaxed/simple;
	bh=+qNf8XcOvY3Sn3oxscu1fCd23gNousCLDuW8B/eYBKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dnhzAc4EmNaH69OqQXNfWqFJR8WuzVU9sYorrG42RvnXG0LGy4+c+anq7iz/FTM2kV5tX20/a/RzO8cHvsye8dWyBKShMvS/+KlBqkW8r5Ea97AAMlbu5FGPO93syoNl+sI08JjuJhiXsowh1RVj5HHHXphazwo704MiePifIQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfRQcLXM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfRQcLXM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05A8C4CEDD;
	Thu, 10 Apr 2025 04:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744258468;
	bh=+qNf8XcOvY3Sn3oxscu1fCd23gNousCLDuW8B/eYBKo=;
	h=From:To:Cc:Subject:Date:From;
	b=OfRQcLXMX0hmZ5xkM+U5CrUZ3SiDgEXtvZ3/TL1H1OFBT2BlJ0DneAJcsZ8+/dQIT
	 1PWsjB/C3M9jR/1l+SXOmPR9Ox/QqeER7cEgxgTapMTTdxBYpumOSwu09P3qELBR5F
	 NOtqJFyyZN8g1xfIYeda89d0+lUF2hfOnJ1sEgNvJJ7hjNsWFBhGf3gYQzN9jbClZw
	 aGgKHTnXrnjBSgSkB48Or3ZsWtN4rjAaGaXH4hwBRJrhXmJo8uAGF09Efo1hnYnsco
	 tOaCR+sIwwKHJaGqnajsg0IutG38WWxQ3xwYoZT8niB2H3HIdfFZAWQRQnkm0wA2jZ
	 Zq197CH5P6QIg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/2] only remove entry from local_addr_list when sending a REMOVE_ADDR
Date: Thu, 10 Apr 2025 00:14:19 -0400
Message-ID: <cover.1744257362.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - squash patch 1 into patch 2 as Mat suggested.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403

Geliang Tang (2):
  mptcp: pm: userspace: drop delete_local_addr helper
  selftests: mptcp: send REMOVE_ADDR after subflow is deleted

 net/mptcp/pm_userspace.c                      | 37 +++----------------
 .../testing/selftests/net/mptcp/mptcp_join.sh |  4 +-
 .../selftests/net/mptcp/userspace_pm.sh       |  6 +++
 3 files changed, 14 insertions(+), 33 deletions(-)

-- 
2.43.0

