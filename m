Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9C122098
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334993; cv=none; b=CDdxa7FvVl83VYv97mkXAm7ufiYRz+05gSZ9mYqw+m5xcGmLJveqGx5Vd4bRcYcVNJRPTBSvsLYBO1wEYGRyj1RO4PaA3n0O6M+BW+X7dltLE4JfW/+46mxwtFyyicvQ/SaekdqoGRQX1/z9cZc/8Fw53ukJfSrndCepevXxAbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334993; c=relaxed/simple;
	bh=iSf8O56WlSfF6At2xOHXGc+qEC/HTxSffJRvs3rJl70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WOb7maBrHA+T2T8oqXENYhqbyn8Jhoc/vMiFv579ebGm39k/uBKpfiem9umq7norEya2PZaxdpAMohOLW7ECRF7QjwwoZmQx/j5JfuRpGwT/J7lmQMJfrTkQSTPIzdKMmxRStZkX/kKQMO5W+DXTiTF4QUQnkzNyaD9DBNcbRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SU9DtflZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SU9DtflZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010CDC433C7;
	Mon, 19 Feb 2024 09:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708334993;
	bh=iSf8O56WlSfF6At2xOHXGc+qEC/HTxSffJRvs3rJl70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SU9DtflZAEFoD6UtU78YFbQ7SY+SxDw5+9x8ERmQ/UfNV7qdLyZYZzibK3Zt3sIvA
	 KC0FIXVrNuYUH/dWWNDx0EcmB4o3ewG4hWV9KuCT4jfhy7XzB8xyJEv/V9badxZmOq
	 lnKl0077S+21z0PDbbbooFmMMEvFXOMDRQdxEoULLKN2tATqTBt8VRqbmD5jgrDNAo
	 FDRHmUwsQqwGdmgo2/THpKdYCO+vodImba0X+0TZ3V8DU2sXqAl/qJdNJ7bMNGtFYm
	 /OA3LcM2CsyHwbxBNH6Dlcnnj0LlTbtpl7PyasT214saTBJWtIWyCIknOurJg1s6Ud
	 U0z9wsg36XlTQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/5] selftests: mptcp: add mptcp_lib_cleanup helper
Date: Mon, 19 Feb 2024 17:29:33 +0800
Message-Id: <476cd38ffa68c114d97b949e248a3fb1d29e58fa.1708334850.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708334850.git.tanggeliang@kylinos.cn>
References: <cover.1708334850.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper mptcp_lib_cleanup() in mptcp_lib.sh, it's
a public cleanup interface, being invoked in every cleanup() in all
scripts.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 1 +
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 4 ++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 1 +
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 1 +
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 1 +
 8 files changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 40fc04e8e592..bd6c8def8b5b 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -29,6 +29,7 @@ cleanup()
 	ip netns pids "${ns1}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
 
 	mptcp_lib_ns_exit 1
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 00527f4c3b98..5273650a78f2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -134,6 +134,7 @@ cleanup()
 	rm -f "$capout"
 
 	mptcp_lib_ns_exit
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7e354ff5d717..ceaaf155cc32 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -166,6 +166,7 @@ cleanup()
 	rm -f "$tmpfile"
 	rm -rf $evts_ns1 $evts_ns2
 	rm -f $check_output_err
+	mptcp_lib_cleanup
 	cleanup_partial
 }
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index bfc535594675..01b0e43eaa80 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -409,3 +409,7 @@ mptcp_lib_ns_exit() {
 		i=$((i + 1))
 	done
 }
+
+mptcp_lib_cleanup() {
+	echo "cleanup"
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 5d8881d11fb0..f82553c56512 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -74,6 +74,7 @@ cleanup()
 	mptcp_lib_ns_exit 3
 	rm -f "$cin" "$cout"
 	rm -f "$sin" "$sout"
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 2ea80f1b0aee..5da9ccafc47e 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -31,6 +31,7 @@ cleanup()
 {
 	rm -f $err
 	mptcp_lib_ns_exit 1
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index a45b6ad41aea..e9820aec7ffa 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -33,6 +33,7 @@ cleanup()
 	rm -f "$capout"
 
 	mptcp_lib_ns_exit 3
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 71caa6b449a8..dab9115738d7 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -119,6 +119,7 @@ cleanup()
 
 	rm -rf $file $client_evts $server_evts
 
+	mptcp_lib_cleanup
 	_printf "Done\n"
 }
 
-- 
2.40.1

