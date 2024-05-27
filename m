Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D226AFA
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807532; cv=none; b=HXvRF4jL243n8ibZV4FPeGxkUUQD/lnXVTWxXDDV4PzdYkNBYLwKkwDdLTk4MswBSYFRETfQ9/hFyAL2hZsM7oCbkcWq3kaVQJmUSwvzR1tTH7ZgdiQoSPUVvcuD9EKqHOi8rfUbMWLf/22dRdfOYVm5lLEw2vpHFt6qzo7KWAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807532; c=relaxed/simple;
	bh=v07HtAOFNZo3mgcCFp7Ei+IU6Ufyv1bihLw243ca9xI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fdWGBWFIxzUS8fy0xY/mIVls0AI3x6Rsv9kCs+LvUs+Rzrp6XYvmSguTy5G3OGhTqCjxyhEXBZ1lOhR0sxW8YMVLxZQw//VOvNol5yRuKF7BiISG+cB4OfecXCIBBEaVOt4rscpp0wF1sbvfOHWAn1vxnt6cANZwzWerYR4j5K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgLto0E2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgLto0E2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDD8C32781;
	Mon, 27 May 2024 10:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716807532;
	bh=v07HtAOFNZo3mgcCFp7Ei+IU6Ufyv1bihLw243ca9xI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FgLto0E2CccPSbkWTOLfYhXf5DgMHm+H3S/c4/Ful/XvLpKjNsweUm85aCFGaQdZo
	 6d24oUlUROfbdVXgPjf7AZSNKwoiBBPpasM5u0Abg2J8Gwl1MuGvJ1MK70XkOSgnjO
	 wmZMbEoU/VcSa5JzzPj8MQ9Ym/yxtlprA7RsZbCvCV10KU2B+AYoJChviesCFqbCxO
	 Miy9lmvm5mpYbcADWBcQTXkoxInNP5STWSCgcIzxoEtbnDdKTr1cQs6No4TBI7DzPe
	 lk9t8xtdW/ckNQTdQMgIAGk/yVb06mdsmTysn3SIVl8XZxL0vkM0wwZkLl1xXIE9+n
	 UwNX+N8HMGmIQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 May 2024 12:58:34 +0200
Subject: [PATCH mptcp-next v6 7/9] selftests: net: lib: remove 'ns' var in
 setup_ns
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-selftests-net-lib-fixes-v6-7-72411ff2460e@kernel.org>
References: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
In-Reply-To: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2565; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=c7+F646DzRoswLZI5eyfnXvpB8pRU/Lbp4+dhQyIdak=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVGdi+nN5qUhb8KGGmJF4ZMapJN+Q/yHUbYB7/
 ucpczstgO2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlRnYgAKCRD2t4JPQmmg
 c3MfEACNspABoIWNRkOqmZsj1ESh5MbUh1FtAjQ2+k6F46PKC4MI6o4f/+cMz9YlMOBtoDnC2ft
 jkV7XlnViNzV/f3CBWGgywHmD+7RTqjrwHRPmfCjdJS+Y9KZe3r27Q9LPCwPCsTSlZUf5p7HeBm
 KgmN+76Ow+SjAXyFqswuQrwkQbTURw/QyH0wY7kop1ttM/ImFbBNxvlcJ/AtrtjuaBvD7nhQHH5
 qRyYtHgujbaH0htmKuR6z0vJy+tGmSObaQby9Xq3LsGQF9eH7DEAKNftrAKwE2WKkgGWb5gA9YS
 CCPDN7lQJFF4scZOxu3vSicKupTGAwjQS9AqX/pw6/kiXF4KCSN2tXxBksCazbCdM9fcDAzyB6C
 ybXYQi4enb1bZ+kiJ1W0zstyH+vD0PLlejSpN0nzjhG2D2vQ8whSFrgL4gEJDFelaZlWAyApSpq
 /NOfmWBQF0LedGTbh8WrWx3RJvkLeEntv3nC/znxl5mAq6RkJaDbe/PBX24jwnu+LG5yTEWy3Sr
 ozzlFkCXLLoais27NWzFxq3me8uaZ7KSgrPssHHrHxeaLDesGhgIrUcsYM7wTmvkpc8z/0/3kDh
 jHQodn9oxtBuEUBL/gOae/LyQneEwmeiLkaYAEnwsYDdgvOG3b1waJHpwqt06bz0FAI6dvR3JqC
 cFVEug/yYUGJE1Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The helper setup_ns() doesn't work when a net namespace named "ns" is
passed to it.

For example, in net/mptcp/diag.sh, the name of the namespace is "ns". If
"setup_ns ns" is used in it, diag.sh fails with errors:

  Invalid netns name "./mptcp_connect"
  Cannot open network namespace "10000": No such file or directory
  Cannot open network namespace "10000": No such file or directory

That is because "ns" is also a local variable in setup_ns, and it will
not set the value for the global variable that has been giving in
argument. To solve this, we could rename the variable, but it sounds
better to drop it, as we can resolve the name using the variable passed
in argument instead.

The other local variables -- "ns_list" and "ns_name" -- are more
unlikely to conflict with existing global variables. They don't seem to
be currently used in other net selftests.

Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/lib.sh | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 114b927fee25..915f319bcc8b 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -167,26 +167,30 @@ cleanup_all_ns()
 # setup_ns local remote
 setup_ns()
 {
-	local ns=""
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
+		# avoid conflicts with local var: internal error
+		if [ "${ns_name}" = "ns_name" ]; then
+			echo "Failed to setup namespace '${ns_name}': invalid name"
+			cleanup_ns "${ns_list[@]}"
+			exit $ksft_fail
 		fi
 
-		if ! ip netns add "$ns"; then
+		# Some test may setup/remove same netns multi times
+		if [ -z "${!ns_name}" ]; then
+			eval "${ns_name}=${ns_name,,}-$(mktemp -u XXXXXX)"
+		else
+			cleanup_ns "${!ns_name}"
+		fi
+
+		if ! ip netns add "${!ns_name}"; then
 			echo "Failed to create namespace $ns_name"
 			cleanup_ns "${ns_list[@]}"
 			return $ksft_skip
 		fi
-		ip -n "$ns" link set lo up
-		ns_list+=("$ns")
+		ip -n "${!ns_name}" link set lo up
+		ns_list+=("${!ns_name}")
 	done
 	NS_LIST+=("${ns_list[@]}")
 }

-- 
2.43.0

