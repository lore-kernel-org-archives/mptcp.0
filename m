Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378AD129E93
	for <mptcp@lists.linux.dev>; Fri,  6 Sep 2024 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725642917; cv=none; b=WoktLmTAv0m80uSt5ePl3yxYqfqKREvJxCTn2sVFXzhFv9djzU4CBOmNLacwDltoeyOsq9CYq31C5gdtYYAaDb/CBiJ+f9zZ4gbB6xrE0lMf0vlb6hjqaC55axgtjYH54i5+3BZHEwlUHFHgfYWv1J+2VXNqTMMb+jOAwVhqCOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725642917; c=relaxed/simple;
	bh=5veUrZt4a8truXcimSm6Y9QmQ92Ra0EaYasr2Zmdcgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K3bmCnXpjibXVkEM8ylSp5eMXYCYCZN9Xm0VePO9HDl5u43mvC+kYiIxugpHVlz8BXJxjN1o/Y+wJzt0MuO3IF53+4QyoU94ozFis3+w5OIhslxH10eKkkG/FaZO5ubQ4+qHTBAW/xYR54Dovjms50MXHpspJWe8UVwTF8uQQHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSnS3L0C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSnS3L0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42030C4CEC7;
	Fri,  6 Sep 2024 17:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725642916;
	bh=5veUrZt4a8truXcimSm6Y9QmQ92Ra0EaYasr2Zmdcgc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RSnS3L0Cn23jUwPChzrsqQWqS8Rq09X2gZ6Dhm6oP3fqzrcJ0cu9Mq0aVJS/CFMT1
	 haNnnbpvWR8enijeTs6xdD8TtuFEXHieNEoSOvrj47jTw3ZjRj9hwXwTf2tqmWaqAt
	 zBLuJHhzeaxH1JqqGQyXmUk0mvaMTFLHjTwsDbxRnEQU0fccXwEM3r7iR+Dqqt4fj9
	 uTiIdGQPIdiz9ww8SYg5jcgxuVe96+bjcH1915Mbebr26ICK2l2Sn6zDiiejGeMnX4
	 pJCrj4n/cMnW4Ant/3OoeclVLKeYaqkVM09sIcumiP8ZxGfaj9kX36hqtYnXAMrLfL
	 NF6DL1jDHSDjw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 06 Sep 2024 19:15:07 +0200
Subject: [PATCH mptcp-next 1/2] selftests: mptcp: diag: remove trailing
 whitespace
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-selftests-mptcp-trailing-ws-v1-1-03421b02c48e@kernel.org>
References: <20240906-selftests-mptcp-trailing-ws-v1-0-03421b02c48e@kernel.org>
In-Reply-To: <20240906-selftests-mptcp-trailing-ws-v1-0-03421b02c48e@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5veUrZt4a8truXcimSm6Y9QmQ92Ra0EaYasr2Zmdcgc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2zii8VxC0Lg6zjqraiHshgJOyYZSQksWbLRgx
 nROMC6QMcyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZts4ogAKCRD2t4JPQmmg
 c3HwD/0U1XIFWFWx/WYK3nA1nBJy7RV9x/em02zLJd/Oe4iBOr50Mkt+Ww2/EahpmTHxDGEvBeP
 NdQyOuzg7IwbpRBk4RS2Q5exjjjP67j35BlR+LmgZt5y5HDu5xKV8xvoYi/ZtI6mpZfpM/++CKG
 Wyezshvd2oi7j0pju5x0d+yNmAgepd0f0+6SsbQVM/6Yx6x4ZLg4SSxqtfoSWULMUnepBJaTWor
 IC7ekLUdF3sde9+8IfYHo5JXwcFsFuP7e+HmZtOFmXyeoYWp2lkWqTij7sK3HtlCXFUhwtDRyQ8
 LIbqL7Ymf1p9YS5jtOQXDw0bsCuZllzoQJ7vdMk7qZIL2rAt9VPG0pd9oC4Eg2t5Agj/9Hdusq/
 yvqDeyj7Ml/1C6hTaayo5NWcvqLusRHT5mxwdjryQptJTNOu+fniguo+QbxHToeKeZlLkEVzAF6
 7R+29H7fOHpAgciwYanhokPn6Bw59yXiq1TPhgsa3DVIr6+fUvuGI9nlj6cRO134MqNWrEIQTPD
 3gtRbVBsT3KEqZSw4fZdCps58a6HLf0m/73f+RSw1FHbf2rwmWurmjWgxDnNX5WQF7dELY0B3SJ
 ZbmX2fix4JFAmPVBDZKYE8mVYp5ksRv8lBTETLzidk6joMj8p0FnVVu0C1Ffm2hZbAXtpJZ9bt1
 z/V8EK1M8rbaicw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It doesn't need to be there, and it can cause some issues with TAP
parsers expecting only one space around the directive delimiter (#).

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 776d43a6922d..2bd0c1eb70c5 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -284,7 +284,7 @@ echo "b" | \
 			./mptcp_connect -p 10000 -r 0 -t ${timeout_poll} -w 20 \
 				127.0.0.1 >/dev/null &
 wait_connected $ns 10000
-chk_msk_nr 2 "after MPC handshake "
+chk_msk_nr 2 "after MPC handshake"
 chk_last_time_info 10000
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"

-- 
2.45.2

