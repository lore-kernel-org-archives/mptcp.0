Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0A52E762E
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 08:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987963; cv=none; b=dbUR6s3AYEo6ZCx37H9gGdCsYgz8W+GDWrMDFHWbqM61KRGRphcjKaCMrHO7gcU2VfSoZp7UAYprp5edZApV5QFZSVW1u73jiLS7W4C5kcCry6VJn7gUSd9AeDyHoMtXm2Z2xxRDVMJuX7mCrRBkTu1o2LgRZJw4H7CWwjWrCk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987963; c=relaxed/simple;
	bh=c5CDr1zwRftXVgtz63NnXyhGlDJbrDh2NlxlBhDqKyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o3W1lJyKjPmaNS44uMAHTMLGRanX+RJLdeCsgothKlBHKIUc3sudfI9UZiGGeGa/IyNW6vS4iuZZ+Ze03sdFWzhzkpiY8+4rPxjVBHP8CoMd7UMBfoqxUKfSFg3CmTR0G8CPqRGj+v9SQb33rPtFIImvsljtzArXlvTK8dOzyBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bscD5bM3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bscD5bM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C512C4CEF0;
	Tue, 12 Aug 2025 08:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754987963;
	bh=c5CDr1zwRftXVgtz63NnXyhGlDJbrDh2NlxlBhDqKyw=;
	h=From:To:Cc:Subject:Date:From;
	b=bscD5bM3jOX9MCDeIZdOYC2eoze5H4I+5YRrBhFdydH8jUbJ+MbIj+jfZW29Jdx1s
	 EZb8CgeA10otqJLSe7LWu2vTe0Eo8j+gRx4DISpUcuB+E+4oxAaxDvrjaRxVSRuIMw
	 ft6PUL2TRC5zBp/oPT0YofxKpAEOorLVSSUb7zCP01zpMe5GEZWenphDzBtVv0Yk3A
	 Aj+Qi7U7CYq38NE/fLXpOqsiP+3qh1U1Qh7jZihg7tO2FOoipF1v0UJqa7VTmaNgYF
	 YwOYYFoLNUWVN59Ae59lHd6aYODBS5KgusABGKLlZYIEbmz3rOtOW+Gr4ML1JWBzHJ
	 QD8WUBgaOPnnw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/2] mptcp: improve ADD_ADDR timeout handling
Date: Tue, 12 Aug 2025 16:39:14 +0800
Message-ID: <cover.1754987655.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - rollback to v2, just use icsk->icsk_rto.

Depends on:
 - mptcp: disable add_addr retrans, v2

Based-on: <cover.1754534416.git.tanggeliang@kylinos.cn>

v3:
 - a new patch, remove duplicate sk_reset_timer call
 - use __tcp_set_rto() * 2 instead of icsk->icsk_rto
 - update selftests.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1754449947.git.tanggeliang@kylinos.cn/

v2:
 - do not rename add_addr_timeout
 - use icsk->icsk_rto instead of tp->srtt_us
 - increase the time after each retransmission
 - https://patchwork.kernel.org/project/mptcp/patch/40706ad511220729207ccd7cf48e320e4d0d7dea.1754028199.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1753777199.git.tanggeliang@kylinos.cn/

Geliang Tang (2):
  mptcp: make ADD_ADDR retransmission timeout adaptive
  selftests: mptcp: remove add_addr_timeout settings

 Documentation/networking/mptcp-sysctl.rst     |  4 +--
 net/mptcp/pm.c                                | 28 ++++++++++++++++---
 .../testing/selftests/net/mptcp/mptcp_join.sh |  3 --
 3 files changed, 26 insertions(+), 9 deletions(-)

-- 
2.48.1

