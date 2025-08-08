Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291B8156678
	for <mptcp@lists.linux.dev>; Fri,  8 Aug 2025 02:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754621124; cv=none; b=HKl0cuAMcXt5lD0aPH8LBJV4mINf/UJuAnHIfVP6DpEFkQklnYDnhSpJR0gdvKqx+b/feDkDjx23v6c2S0BKtrZQcYgKaQDzH3lAC9yfy64o3Bq3xMyI5T0hjM+KLHnnslLnR/gW+kSlMIiaPKFoX/SCGquWuEjaCM9PBs0PCXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754621124; c=relaxed/simple;
	bh=vhlpHiMy4/JuelGsLW79zrMMIqrA2KYoKVENZZXED24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2RcTx9K//sfmnZWPS2fh7ocj/7gW5I2IP7C7G2nCwIEsYf5M1KzoOp2DFkNOi4ePSRYNXt+v3Y54EoJduLDQJ1XsE3RqUwAdsVCHJoE3vlBu9y7tkwn4e0vWoDWUznmu0f9dVrfzlf8PKltfyVZCOA6BrY17O60lMiMwm6yfZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIIHgsty; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIIHgsty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C350DC4CEEB;
	Fri,  8 Aug 2025 02:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754621123;
	bh=vhlpHiMy4/JuelGsLW79zrMMIqrA2KYoKVENZZXED24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qIIHgstyFCWFXHKEw5nYmyZFeDpl6kYGpMLmlqVDRPYZ4GqnYHHpbKREv6VUSVLtF
	 d7Tdli8qS6l+19/W3SUkO5b/w7vposs6J4fw9qMbeaECVoALV43zdVovCFRITRYtXj
	 /Bi5TT+ah5J5Jsho5+JjqUAZCms05V9AD2htxZTl3QSi4HXVQkWGNsMquR0T/bcAYN
	 JWfFx1BNyaTFKW840mWHq2CxaLvN+KYNjddyeP5tiJbPODtrxdTz337lxJ2F8r4e5f
	 /E2UC3avwN2tYXEtXv6RTWrmmTNCfYvEv0/ETBkFW3/8iLdurkp+jp+hlinvpYDTfq
	 qoNjD7iHeD/mQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/8] selftests: mptcp: sockopt: add inq argument
Date: Fri,  8 Aug 2025 10:45:04 +0800
Message-ID: <2d6a5bd353dad4dc01ded98f9a55fcb89da5d1f0.1754620968.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754620968.git.tanggeliang@kylinos.cn>
References: <cover.1754620968.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Introduce -i option to enable TCP_INQ testing. This prepares for
consolidating TCP_INQ tests into a single binary by adding the necessary
command-line interface.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index d6c1d746f12e..9558c68a62e7 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -30,6 +30,7 @@
 static int pf = AF_INET;
 static int proto_tx = IPPROTO_MPTCP;
 static int proto_rx = IPPROTO_MPTCP;
+static bool inq;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -138,7 +139,7 @@ static void die_perror(const char *msg)
 
 static void die_usage(int r)
 {
-	fprintf(stderr, "Usage: mptcp_sockopt [-6] [ -t tcp|mptcp ] [ -r tcp|mptcp]\n");
+	fprintf(stderr, "Usage: mptcp_sockopt [-6] [ -t tcp|mptcp ] [ -r tcp|mptcp] [ -i]\n");
 	exit(r);
 }
 
@@ -277,7 +278,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "h6t:r:")) != -1) {
+	while ((c = getopt(argc, argv, "h6t:r:i")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -291,6 +292,9 @@ static void parse_opts(int argc, char **argv)
 		case 'r':
 			proto_rx = protostr_to_num(optarg);
 			break;
+		case 'i':
+			inq = true;
+			break;
 		default:
 			die_usage(1);
 			break;
-- 
2.48.1

