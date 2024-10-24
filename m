Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD3015573D
	for <mptcp@lists.linux.dev>; Thu, 24 Oct 2024 02:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729738348; cv=none; b=dVayc8eJLu0jQnrC4eEMvYAzE+kiVABrLZH+PIun/evGEQ4o4nWGeBY3nqvYl8SAiLb3Nl9h1jWqNcZcKPa2JuIw8spJESkERoBVMDQ46rtb+NWFCRq1MQfkLmzc759yvx5lDdiBUn2aiwu3dm1FN4W6qAXN86O3WvSLHmjEcXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729738348; c=relaxed/simple;
	bh=ZFdrVsL8umsdV0iGAlIwwRUV6UdTeEK30f96VIb1cjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oe5E+hy32FBh9ET6h+8knHNEsP/9RrEV35YuUMUmIzPVL5eXOWIlixtm6E0Et13RbnOAXrbwYZPuXFN4A8INRbH/4MhRNIMEuswksfeokysvst18j5YhnsjkZ1/ow8hpFbcSgwK1XDlrLCiP+RP1+XlPk6I3LqftwGGhRQ4t9L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQneeMBK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQneeMBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2386C4CEC6;
	Thu, 24 Oct 2024 02:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729738346;
	bh=ZFdrVsL8umsdV0iGAlIwwRUV6UdTeEK30f96VIb1cjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vQneeMBK+pq76njv3R7c/6sM4SFHoS9P5G3feGvRHHXO3lGEJr7TT8UQrtv1YGx0h
	 AENDB6pvHPqD3QqvC1FyPrqoGw1wV1771LUVoiya+GE+wdoCj++II8u6GzlWuyC+Mq
	 xhgxwoq2ztBwdaWzuURvyxWgp2bqHEBUfj27wMFrnHvebYG6LhCxilXnhX6GSR376h
	 0S7J1woSBzvEssVYhfofBYgvJNDZEMGGgdJEtrNA0PGMWxCF+IgQDfBwwfWvr+XwpX
	 ymEeUUW0j0oH1UgHA5q2Mtwqyk6+2LNt30vNCJD2wb/d/rRW0xwBmIR5lMKoqZTq5o
	 ZXdfkUx3F7s3w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Thu, 24 Oct 2024 10:52:15 +0800
Message-ID: <33db1c594a6549fa12d151305349774ef6dd7efd.1729738008.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729738008.git.tanggeliang@kylinos.cn>
References: <cover.1729738008.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Move sk_stream_memory_free check before "send_info[backup].subflow
= subflow".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 6242430d0330..f0c9f5984736 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -87,8 +87,7 @@ static int bpf_burst_get_send(struct mptcp_sock *msk)
 		bool backup = subflow->backup || subflow->request_bkup;
 
 		ssk = mptcp_subflow_tcp_sock(subflow);
-		if (!mptcp_subflow_active(subflow) ||
-		    !sk_stream_memory_free(ssk))
+		if (!mptcp_subflow_active(subflow))
 			continue;
 
 		nr_active += !backup;
@@ -103,6 +102,8 @@ static int bpf_burst_get_send(struct mptcp_sock *msk)
 
 		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
+			if (!sk_stream_memory_free(ssk))
+				continue;
 			send_info[backup].subflow = subflow;
 			send_info[backup].linger_time = linger_time;
 		}
-- 
2.45.2

