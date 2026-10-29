Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259517;
	b=V283v7DYpctqA2Vyll03XkVUFM/+S1t8gXKumNCDVdAIv8udyMGToKrFVXeGVbQsSaJU
	 +YIA/HQEAF0v/OTOSMEctybyxGBFz/WxggOQ2X1giEJYMYzn0SXB43kg1xGtV6eE9NY6t
	 JoZJm4RMwZlLWyL1ZXg3TDmP22iebBiF8OO5e2nHJAf1MCo4fxE5Eub6vEiUBFQtG14UG
	 ksICQuNntnLjy72BedHf6EXzxIOGzLCXqlvFbhnzt3HcTMb1lUPAzS1HP4a/jZsi1eC3i
	 YKXMHg1QZ2qwTkTC+YhiE0Ispjq94NouqEXQIr3tKzX6mBYWa8ne+MT07q8e3mvS2rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259517;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OvSV2HMWa/s1IrAeK2YVLhcVAMU9pwUspa1vCLLae3c=;
	b=eI+YB1DOsW8e1/GcBTjVvxhZigihCv7WxIWHTHff3xi/20qnrwO4eaQ8suWaU/9ayXSx
	 LpcCFw4TimQA9iCP0S7MdBZ0HgDBKnFGoV6yWbj/S/dL+xe6r/ZS46b7B5z6xXHHoJBOR
	 gBzhDh1emVaLnPPBlOFFgnyZdZQNGPRTP9K/iD+vIJO1afvHRxaJwh3AGA/oFjEQay/sO
	 RIa8P24Yr0bdCCWS381JFTXKIeiiIgn6eG4IX9jSKzEU+TMSQHBibWW6VCUQBb28p203o
	 SXK8vYIHmzo6cWR8OGO7spmWKvZKdiUKWOqoptYGiwgg4vqV8UpAt3sxIHEkc1au8yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEM5klJE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B303606A31E
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEM5klJE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2108C1F031E6;
	Thu, 29 Oct 2026 07:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793259516;
	bh=OvSV2HMWa/s1IrAeK2YVLhcVAMU9pwUspa1vCLLae3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aEM5klJEijcrWpPzJgWmzO+j2PuLoiIFsaTvpTXSDRhSGwchIydOFLMf5Pw7CVFDs
	 OQq/5wH7fCS2Q3g1IHPN1eTZvrHsIkDCKAJV/UHoHnFgj/uadJpboFubTgd/0ZGpYK
	 mgRQXWGfkIQjVFRdgu9A0g1puZswYVaUVUiscw99pZmn8aC5YIgQQ5t7yZjR94G9/W
	 Th0X/Fg+9T2moZUa3mp/ykpfrRiSMIsmc5s5xdJm6atwPLpVeNCFNuo9fitZMrAAWb
	 ctScFVB6NAQ3SsBtrvnUvyVavmnZFpon7McPoZiO4MtPd+KyjFPnsP4p762CW6Zc63
	 x6dL8z6q2hMRg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 5/5] selftests: mptcp: sockopt: check app_limited
Date: Thu, 29 Oct 2026 15:38:17 +0800
Message-ID: <785e65bbb01dbf31ef2832d7a36c159027d6f22c.1793258749.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793258749.git.tanggeliang@kylinos.cn>
References: <cover.1793258749.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

After a small data exchange, assert tcpi_delivery_rate_app_limited == 1.

rate_app_limited starts at 1 (tcp_init_sock) and is cleared only by
non-app-limited rate samples. The preceding commit makes
mptcp_rate_check_app_limited() set tp->app_limited on subflows when
MPTCP has no pending data, marking outgoing skbs as app-limited so rate
samples don't clear rate_app_limited.

This guards against regressions in subflow app-limited accounting.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b8158a1198eb..f7a45b93cbe0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -635,6 +635,11 @@ static void connect_one_server(int fd, int pipefd)
 	do_getsockopts(&s, fd, total, total);
 
 	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+
+	/* app-limited accounting requires a recent kernel */
+	if (expect_all_features())
+		assert(s.tcp_info.tcpi_delivery_rate_app_limited == 1);
+
 	close(fd);
 }
 
-- 
2.55.0

