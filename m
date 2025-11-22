Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A36986347
	for <mptcp@lists.linux.dev>; Sat, 22 Nov 2025 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763801145; cv=none; b=BUoGtwmurE4Bv/bO1DmNRLVPiNkEeKcpcDkBB8yaZF0bhnqeKX1AI2C60wV7ZZWtlLqwy8sbQ6BCfBzRndPaAUgp5VXf8Ko2+eoqiH5tSbyVTW9FYItXEdfTKKEVURa8RkABMoSdnhr0R+C8OmEvIDaf5Vaz9HIa02dqChN/+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763801145; c=relaxed/simple;
	bh=iAuiZkPh5nUT9dQExOk9+PVKGbGN0rR3KtfKCt+ygwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcbTmtoDGLISalSyuh48jTqWGteVTjWFIErzGO9yPpRMZHM/IIEixtYmWhF25wLcopMAm5YS5cNa6FOFMn+tKKRL5dnZp2sRto2Qo+R+UkCYqnofV7y8dkYtV4JrA0UnnHl6fIUU+CoixPGSxvgscRn1G2LBdJH4VYcHKOhAv38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QufltKgb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QufltKgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306EEC4CEFB;
	Sat, 22 Nov 2025 08:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763801145;
	bh=iAuiZkPh5nUT9dQExOk9+PVKGbGN0rR3KtfKCt+ygwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QufltKgbGVgW/LoO9/7SmCfu1NdZusqJxgAQuZtoHg/zU3phbnvp4+CP5uau58aVD
	 bA363FzYBKAM8nU7w2UFjO9wK+Nacdrkzjmd8nKmXuL5Dq5y0VMTNP1TcHS3s+MQcR
	 iVB6BDsa7u3IoIEo+RP6xnbE0ELD6z4/coPFWlhvIf6jBvBCLXanU2iQjCPK8UEKWR
	 CVdktXjSNiW0v2P8uzfrMUbo1SVBgRHizANLqedOlJuIayyNnHPMdWm4NRkC6b/oEU
	 LlOTO9YylMntlq95AYVH0/bICa2QFGzsGKImVnbaHqPnB29CPWuKjXNHSVpXhDh2kP
	 5pj0IHuy4JWtg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v3 8/8] selftests: mptcp: sockopt: cover MPTCP KTLS test cases
Date: Sat, 22 Nov 2025 16:45:27 +0800
Message-ID: <448d97973d16701ebcbfc86e05fa2d182d740aa9.1763800601.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763800601.git.tanggeliang@kylinos.cn>
References: <cover.1763800601.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now that MPTCP KTLS support is implemented, extend the existing TCP KTLS
test cases to cover MPTCP for both IPv4 and IPv6.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 6dcc0a100094..c1f99dd1532b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -375,7 +375,7 @@ do_tls_tests()
 	mptcp_lib_print_info "sockopt KTLS"
 
 	local args
-	for args in "-c -t tcp -r tcp" "-6 -c -t tcp -r tcp"; do
+	for args in "-c -t tcp -r tcp" "-6 -c -t tcp -r tcp" "-c" "-6 -c"; do
 		do_tls_test $args
 		lret=$?
 		if [ $lret -ne 0 ] ; then
-- 
2.51.0

