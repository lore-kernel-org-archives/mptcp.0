Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC69218FC61
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 07:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064016; cv=none; b=gkG3iXUg8p5zdOTvV2p0gL2krWyZCaO3m8Kz/49AfEUsPcEkL+Poe78oRuwULwibmjxDsk58Le4Ym7/puM4XtnyRYJ1PGTzBMbI6MJXTaeesJ8O75+79upQJG2fYFlhwXk6dgdjNeY3naj5IUoM5gTPa8rqvLEtM9LteGWQOo0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064016; c=relaxed/simple;
	bh=wIhmKLx50uCzoCDPi/07gUtp3YgKrJHJXGI5pw0ZgRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsEV1AfZUonvvsywwy3YvEgJ6J+tZDYZOYSDvk4lL0GKVhpxOfCJbdPh93Bx8F+mHsoWUzYtieLmsVutEEYqkIkhYwndmPwZEumc0/qDDqPQc0I0388yzttaiIdwLR3etPNo6Ro83fpbq+X+4fUcjNbogVeA0aMWbY677CIxba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwS+Qbju; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwS+Qbju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50443C4CECE;
	Wed, 16 Oct 2024 07:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729064016;
	bh=wIhmKLx50uCzoCDPi/07gUtp3YgKrJHJXGI5pw0ZgRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EwS+QbjuNFiLAGqufs2YvzhYn8S1dEh1za4eIfLLLhqNrdXx+d+jtU+NXOCbCRnTF
	 N9hpeR1ltvIFOPu5e+e/OjIpv+7Dj/c3K3Ld0QUZHIeec6lebdoGbEO33kLZ1CDQ9L
	 Lu0z22YGSW1bd5dK13RmiGVVc00w+YO7SqDhz7UK4xJfYr8rByK8Ao6NBEIznNzpYf
	 FXRA8MHQ/5wWFLuN6u7c1yLWntROj7vwcKLusuzHhqFQcNU5RD5luB11BC/CaHe3V6
	 CF98UsswHlcyR22ZjIqi+wWhiWNR2+72SNiu6ElNt4Dw59169P6xGdFlwOKGiZLsli
	 curt1sPwg6EcA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 7/9] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Wed, 16 Oct 2024 15:33:14 +0800
Message-ID: <66bc528ea6e3a0857ed7cd764fb36ed2622641d3.1729063444.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729063444.git.tanggeliang@kylinos.cn>
References: <cover.1729063444.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update endpoint_init() in sched_init().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 0f92dfa95869..6c76f7aac035 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -585,7 +585,7 @@ static struct nstoken *sched_init(char *flags, char *sched)
 	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		return NULL;
 
-	if (endpoint_init("subflow") < 0)
+	if (endpoint_init("subflow", 2) < 0)
 		goto fail;
 
 	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
-- 
2.43.0

