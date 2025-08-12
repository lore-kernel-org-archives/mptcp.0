Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8DB27450
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986657; cv=none; b=OEdPyybSQz8MEjNcRba/zNtbuuOxj26WCt8EqVy8wZriZZ2aRtVYyYB8qYzGa6feBt1JCW3uCwv2ywuiQewGoJQ4uhFJjIuhzmk6qr0ZAXuga4qRgyX+Ilv3IOxTms7C48it9/hWMFTfqU/RlHCe88457d0F0oymrv4OJhz54BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986657; c=relaxed/simple;
	bh=HKyAP33UKW1qVWowU2/FdyTrO2t901A4bUW/9Czk6ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXybghbBEBZeJ3CmI3CUswaGZtqwjPQhLTeJa1QqCWPRXSJf0zrXhsRHQtenD5ODlf1rzZKTEIXbMaX9Tt7l/VKSfnxTPQ7PqesSpfzlwVXtUv8iRQpXiqdVJMEaHyODB/rHTMxYM4uOtJemk6L+lXKxyyeYk08YpMxXSbIONSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFUBkbdm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFUBkbdm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A84C4CEF4;
	Tue, 12 Aug 2025 08:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754986655;
	bh=HKyAP33UKW1qVWowU2/FdyTrO2t901A4bUW/9Czk6ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vFUBkbdmDvwV0i3vUyL7+LIeOszLatBRnvWO8uDH7pTqtSUA5jj3oMBNN7AHzW1l7
	 i8rzQ0repHPvnHhW4Sfl7SnDPMkMVza0NB/LwWMp/CSDKYiCuFCAQD7OARYC+P387k
	 76iFH9XNeXp2fT6Pl3xrCmPHBTjr4kpp0PpqCOszI159YIiLaIWDD/OL1RsTo3mcqa
	 NAQCrlm+6fGM4jnfXTG8f/P6XCsCxq1fcOOHHJJFqUd2RdBO9ajq1sOIGspcMZ55EF
	 Ayh2r+QtpkmDbFgWleAEhhsC0J6qnCN5SPw/1yAh4l3Bc4WnI+xI4kzzIg0eelxjr2
	 tk/F8nEGqRbww==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/6] mptcp: refactor IP socket option handling for first subflow
Date: Tue, 12 Aug 2025 16:17:18 +0800
Message-ID: <b9b01917accf9bb7555e41e786ee89216635ed14.1754986557.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754986557.git.tanggeliang@kylinos.cn>
References: <cover.1754986557.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Consolidate IP socket option logic with mptcp_setsockopt_first_sf_only()
- the common setsockopt handler for first subflow. This function applies
options (IP_TRANSPARENT, IP_BIND_ADDRESS_NO_PORT, IP_LOCAL_PORT_RANGE)
to the first subflow and synchronizes values to the MPTCP socket. Improves
code organization for future socket option implementations.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8017cbad0597..1ab3dbe5124e 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -703,8 +703,8 @@ static int __mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, int val)
 	return 0;
 }
 
-static int mptcp_setsockopt_sol_ip_set(struct mptcp_sock *msk, int optname,
-				       sockptr_t optval, unsigned int optlen)
+static int mptcp_setsockopt_sol_ip_first_sf_only(struct mptcp_sock *msk, int optname,
+						 sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct sock *ssk;
@@ -785,7 +785,7 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 	case IP_TRANSPARENT:
 	case IP_BIND_ADDRESS_NO_PORT:
 	case IP_LOCAL_PORT_RANGE:
-		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
+		return mptcp_setsockopt_first_sf_only(msk, SOL_IP, optname, optval, optlen);
 	case IP_TOS:
 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
 	}
@@ -826,6 +826,9 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level,
 	case SOL_SOCKET:
 		return mptcp_setsockopt_sol_socket_first_sf_only(msk, optname,
 								 optval, optlen);
+	case SOL_IP:
+		return mptcp_setsockopt_sol_ip_first_sf_only(msk, optname,
+							     optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
-- 
2.48.1

