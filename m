Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3610EADB
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 03:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728531113; cv=none; b=RZ0bVIQ8r/O1Lsk9L77ZZKRjWg54rSTB41Xv6T/J9OfcdU3pi//cR/5y1ONPkYpsh58cvBNJqaqWENSF6ykH/Ktz5PsEyCGmE5lXyQBxNMuKlMH12QTmBzxUuVI+0bYCx2TOZ40qSKXgAsx6kkq50bYeKrdMmmKgWrgP7GfDLp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728531113; c=relaxed/simple;
	bh=IRlhyE1zEnipePdX6hcTEi47yCdPBPJSIP/xAB0LpAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AvtuV42zOGbZ5kBzGeN90YcAPN4ULPo6dK4n6Mj6vZcAVkTvZ8DywnYxf69Ltt1A0sIYP7tupTcIJqExTJKALLLoSi3VqjR35Ciz3jv8cDlSRbLa8hZ3AjRqLC5aSBydtpDdJtBf6+doXIExRgUe1nzZ6LkXwRBtsGQ37MiEcis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G69plsaf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G69plsaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B6BC4CEC6;
	Thu, 10 Oct 2024 03:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728531113;
	bh=IRlhyE1zEnipePdX6hcTEi47yCdPBPJSIP/xAB0LpAY=;
	h=From:To:Cc:Subject:Date:From;
	b=G69plsafcNvyxU/fhN6QcUSrdsLf4eYeKwh7u/o8jQcRrN4jnZskgHzN8D/mwYJvj
	 +WC15+0HqMvbLSDAHFn1Vrj7aqnd7pap0Dtg+tsJkHU6ysYB6nFFFiHLIB0IdXibg/
	 +Gr1BlM+h12U56CrIMKk2KYDgZGcvdEM90Beq6LJXsFpiL6ldJiZWdC1w9C1g1H+Qw
	 X4+owxbcfjsEse6BE1me3oUdzI293y92bkQLYsElIIRAi145oJoiXPCDgo+DzzK/i4
	 f9xlhVgducl05xLEF6rQN4EeZb9Tz7YCjlIYnItneydto0PeYH5YNwO9yVgKo6k7ux
	 JXDNPhQ8vo9nA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/1] add netns helpers
Date: Thu, 10 Oct 2024 11:31:44 +0800
Message-ID: <cover.1728530836.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The commit 1e115a58be0ff ("selftests/bpf: netns_new() and netns_free()
helpers.") now in bpf-next makes v2 of this set useless. v3 only uses
these new helpers in mptcp selftests and drops other patches.

v2:
https://patchwork.kernel.org/project/mptcp/cover/cover.1715821541.git.tanggeliang@kylinos.cn/

Geliang Tang (1):
  selftests/bpf: Use make/remove netns helpers in mptcp

 tools/testing/selftests/bpf/prog_tests/mptcp.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

-- 
2.43.0

