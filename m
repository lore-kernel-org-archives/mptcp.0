Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26DC84FB0
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563645; cv=none; b=TTjy7cNWKgTwH60h1+zvuKTVE0DgeaGQsdx0u2DcAH10nOQ4wuL+X/exhtWqWUTIy6UAUnjVgEQ+0CZ8YCQtCeMWr5FodkO+3Gb3ZgGhDuZX6vp6de59UpciIl1lbzNCSgvbI04pvR1dBjzcs0E/Mq8NCX966ZCeqHKp5iZV65c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563645; c=relaxed/simple;
	bh=0MEfHChxbCcyUZsx5zYSOR7hH45OfjbGLiKMN++S5SM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RQWHuPyuQ9jUGn8Jhcn3Rd2IRxIPLvTWyJNh5vmAeo6E/URO4s+S9bWdiDNJu0XafVEhx5845jcn4oExaMI84BBDgmUZ9gCjkfC6UGzULHCPTfElszHCQk5YpTZLL+8unjCBjY0+B+iZQesdRSbHrh+JavpIQKYUy7xWsTHkZvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkF5s66u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkF5s66u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2900C2BBFC;
	Fri, 24 May 2024 15:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716563645;
	bh=0MEfHChxbCcyUZsx5zYSOR7hH45OfjbGLiKMN++S5SM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TkF5s66uMMmGKZBYmZAz0jcakosXKU2yzcqSCTyjBg7WI5V3oPCz/l9Fv+/BMn0lL
	 NPM4n+XsYLdOLVtchKg0Vt5FCVzuoN3nZbQzsDQXGESNpaayhSkIdq85k9XSZOO5bN
	 vZaok9uaUR6DCzHIrxES5y/pKZ5oLJB9WvMfNaXThTURIOmUkIRrHSUk6/mM6ietXN
	 oSJvLEYBOHSYZ9UtY1ijOEJ+oqUPQeKcPhhGH1rOvW2z38h21E4Wh35lNStjZfmAAX
	 z+Bp9LpBq6YXyY+0927qeTz0H/8DHKYUGjej7hSjua41eXt2R+/98r8/X8fHoBK0sH
	 KyAs4YUknQtFg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 24 May 2024 17:13:30 +0200
Subject: [PATCH mptcp-next v5 7/9] selftests: net: lib: rename ns in
 setup_ns
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-selftests-net-lib-fixes-v5-7-b9e0968571a3@kernel.org>
References: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
In-Reply-To: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2382; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=S3ZPa6Pod63Zqt9gRWBkNXadIWY+bR7OrSPgRZI65T0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmUK6zgPIPtE+YpSnYbj7lEM0y1AuvR7gmUFY5e
 sY44RlFzm2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlCuswAKCRD2t4JPQmmg
 cxuSEADbSGJyy+61gJiEKi2Tb4ywUTPPA/a9amDQz4BccXU9MnhAdmd+gn9INW2Tz+eay0tvQla
 7luEf/17VuZtujNAeNKVbDF+GXdIOqX5qz6sOU9ep7RrrVtrkbXYQFFx7ljR1J0KaRMT+ZTseMK
 szWT9LfnKyTln/l9S+BgLgtRi8FzwGCJwq0uoNl9HlFUikFJgAskViUCZHvVzkgQjTK9WGGXqPs
 bZLiD2KW0hsZbNu1qtePWIinMLUN0OEeDf0g/mBFufT6pkcfUPvACm+3H8qjtfQ52xO5xjG8Gsn
 sn6E6VsDPt1vtW+e6UyfKVJZHV0VSFMW9VWH0eHTaiusnapMi6wy+5388IMUfjkkIS9gjoZLpVI
 4pJlOaVcPmiPPQzZtMJ5eRuJ7HORg9nmUo1D2CzxYDCPeOYjN6/v05kvVbNxdivAptwaqbd/q53
 cnZ7xc4y4qiYJPM+MErpt9ED7lI+NK62t2t3tXyUUYQhYQY7VA5iJbrL9SGXK71BScq+dJ70rTh
 M1RnKO4uztlOLNRqFC8rXjXk+EG5NcV4dR+3ir0SXj0vuQLFSNzBjqB4l8srJ68cfzZ5idbQI7V
 uLj4nm9dy6VPe6xlKwO+veexS+LkHON/3pQrVsJKr8EPPk56d+qftj0VAxa67gLyPQTcLgQYZcG
 ZGgA81wHyHKbdxA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The helpers setup_ns() doesn't work when a net namespace named "ns" is
passed to them.

For example, in net/mptcp/diag.sh, the name of the namespace is "ns".
If "setup_ns ns" is used in it, diag.sh fails with errors:

  Invalid netns name "./mptcp_connect"
  Cannot open network namespace "10000": No such file or directory
  Cannot open network namespace "10000": No such file or directory

That is because "ns" is also a local variable in setup_ns, and it will
not set the value for the global variable that has been giving in
argument. To solve this, this patch renames the local variable "ns" as
"_ns", which is more unlikely to conflict with existing variables. "_ns"
name appears to be unused in the net selftests.

Also a check has been added to setup_ns: if "_ns" is passed, setup_ns()
helper will exit with an error.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/lib.sh | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 114b927fee25..b883289ec4a1 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -167,26 +167,32 @@ cleanup_all_ns()
 # setup_ns local remote
 setup_ns()
 {
-	local ns=""
+	local _ns=""
 	local ns_name=""
 	local ns_list=()
 	for ns_name in "$@"; do
-		# Some test may setup/remove same netns multi times
-		if [ -z "${!ns_name}" ]; then
-			ns="${ns_name,,}-$(mktemp -u XXXXXX)"
-			eval "${ns_name}=${ns}"
-		else
-			ns="${!ns_name}"
-			cleanup_ns "$ns"
+		if [ "${ns_name}" = "_ns" ]; then
+			echo "Failed to setup namespace '${ns_name}': invalid name"
+			cleanup_ns "${ns_list[@]}"
+			exit $ksft_fail
 		fi
 
-		if ! ip netns add "$ns"; then
+		# Some test may setup/remove same netns multi times
+		if [ -z "${!ns_name}" ]; then
+			_ns="${ns_name,,}-$(mktemp -u XXXXXX)"
+			eval "${ns_name}=${_ns}"
+		else
+			_ns="${!ns_name}"
+			cleanup_ns "${_ns}"
+		fi
+
+		if ! ip netns add "${_ns}"; then
 			echo "Failed to create namespace $ns_name"
 			cleanup_ns "${ns_list[@]}"
 			return $ksft_skip
 		fi
-		ip -n "$ns" link set lo up
-		ns_list+=("$ns")
+		ip -n "${_ns}" link set lo up
+		ns_list+=("${_ns}")
 	done
 	NS_LIST+=("${ns_list[@]}")
 }

-- 
2.43.0

