Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733FB53398
	for <mptcp@lists.linux.dev>; Fri,  9 Feb 2024 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499751; cv=none; b=OjBZkBRG/Yc6KLXI+oTue1BuJVpQgacsVW4dcYhuxMBTihse3XPG/DideDMxMySf2R8V7TQdD9SQSyviFxj7wuEcykBrr+YOYTLDNBgr0t2fJxm2HmYj/UIPjFGPLpwbnfzAJ5lQEUkPVm3XfCqpLhun1Z+YU2K4tQWZOZ2wf7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499751; c=relaxed/simple;
	bh=jt6BRU6kB+BNM6U9SsE6L+qv0YlY3DHoLO63SZYWVLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AQyspBuo5lIBEYQ24PjWCIYsfC8PkzK0quBbZhQZklKx5liXu2lPLoa548ZZ+Y5ZzDMjd8DeqeejA+pYFbAfNhCfTDyq2+C8KG6+rntMA45wjRCJMZzMHjxVxQqNM0dhnadR3ScKiPeGyTdyOEdNxoWcaxDvmUYn+N1facE1S4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahEErO+f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahEErO+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80390C433C7;
	Fri,  9 Feb 2024 17:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707499751;
	bh=jt6BRU6kB+BNM6U9SsE6L+qv0YlY3DHoLO63SZYWVLg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ahEErO+fVBFfuro496l8v3lrQ+ZMhgtJFeHxvRazZhYErpdcN57ykA7NIwu9XBvuz
	 D/ni6k5+88002aVkv1UsV+Apbh9Ne1I4wj9FcGfOIFEMuyLYslkWBpx0khB+jyKDX1
	 jFEpQaQtYJjqhwrp6Vg+61Nbjw+5c0c6BuW11lAUpEs5k75yX2AX1aAD8AoIQZgNF2
	 Tn+Kpoo5WtILU+IVVxdWE44bKWSZp1udZ+TdFAcEQW+DpAmqzNbynYrPSop0j72+Vm
	 qsgAsHWz83E5r4iz5+u2Yuc76Njq/pWErFwhDSpEqRiqIINGuC5e6+/whT+7yypGli
	 gzCwBaoNnZ7qw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 09 Feb 2024 18:28:41 +0100
Subject: [PATCH mptcp-net 3/5] selftests: mptcp: diag: unique 'in use'
 subtest names
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-selftests-mptcp-uniq-title-v1-3-e4fb3a3b5f66@kernel.org>
References: <20240209-selftests-mptcp-uniq-title-v1-0-e4fb3a3b5f66@kernel.org>
In-Reply-To: <20240209-selftests-mptcp-uniq-title-v1-0-e4fb3a3b5f66@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2606; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jt6BRU6kB+BNM6U9SsE6L+qv0YlY3DHoLO63SZYWVLg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlxmDjIMtipQQYht1fWZZ8FzooUygS4NbC/lSBE
 P/tqnnu9hyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcZg4wAKCRD2t4JPQmmg
 c2WYD/oCrzeAQWODlHTLyyFwrAgg9UV2yZbia9JJglQzK4o+nVINf0ykLn5XklziWKoqW9noM5E
 ho5nj9E5F93zLB3XilJzhvp2e5dGT4j9UwLizLu1aOlt4wzmN3uxyoJzgTo4BOygW7UE7gwbBsV
 XcN63qzDlFeHRZuH/InvCflPEs4XjZELqZx5gmrIsWnmsE5F4gQQ7faD5jsSE0PLLWkCm0dqbKC
 2SL77knGQT0TLjO2I1TuEd4871+gjqGMOIr2yaa1zyBxXMZstvVUyjhidVq/qToCVULE5Htoa/i
 Nfmp1478s5Y2Dp2A4Bh3c8BUPMFJ5Dl2OVwXuSY2zceL+a3/6w1SNxt1aRdeWpX+rewPjkNHAcE
 +OHnVks++rQ5lr4F1BxePHASzigYd+titufIF0lvC1S4YL+p7hYRoscsf4lGf0TWgABeYs1CkSb
 1FDABFCn1lOCQOb/EY/t4wm1xuH/cBAk2MZXkVMDALRP6rxDcJLYhFIDODGtE85u3AL2S8ulD+d
 /u0blT2V6j3pCLtLGaGAJBQ678JCvb9gGJ7yxlyAwjrSYBjFmwh3Ld2qUZGqUlUelNZ94sJ4J3K
 M4dn/4fdrkCOl1p2/0fGndNNkPXpCRpoQikTGzBfa3sZ1WUAB/kq5BPpa2ZNpGBypkFMb/IDzXg
 J+mtAXx9swkYCAw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is important to have a unique (sub)test name in TAP, because some CI
environments drop tests with duplicated name.

Some 'in use' subtests from the diag selftest had the same names, e.g.:

    chk 0 msk in use after flush

Now the previous value is taken, to have different names, e.g.:

    chk 2->0 msk in use after flush

While at it, avoid repeating the full message, declare it once in the
helper.

Fixes: ce9902573652 ("selftests: mptcp: diag: format subtests results in TAP")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 04fcb8a077c9..7e7e40601c6b 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -166,9 +166,13 @@ chk_msk_listen()
 chk_msk_inuse()
 {
 	local expected=$1
-	local msg="$2"
+	local msg="....chk ${2:-${expected}} msk in use"
 	local listen_nr
 
+	if [ "${expected}" -eq 0 ]; then
+		msg="${msg} after flush"
+	fi
+
 	listen_nr=$(ss -N "${ns}" -Ml | grep -c LISTEN)
 	expected=$((expected + listen_nr))
 
@@ -179,7 +183,7 @@ chk_msk_inuse()
 		sleep 0.1
 	done
 
-	__chk_nr get_msk_inuse $expected "$msg" 0
+	__chk_nr get_msk_inuse $expected "${msg}" 0
 }
 
 # $1: cestab nr
@@ -227,11 +231,11 @@ wait_connected $ns 10000
 chk_msk_nr 2 "after MPC handshake "
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
-chk_msk_inuse 2 "....chk 2 msk in use"
+chk_msk_inuse 2
 chk_msk_cestab 2
 flush_pids
 
-chk_msk_inuse 0 "....chk 0 msk in use after flush"
+chk_msk_inuse 0 "2->0"
 chk_msk_cestab 0
 
 echo "a" | \
@@ -247,11 +251,11 @@ echo "b" | \
 				127.0.0.1 >/dev/null &
 wait_connected $ns 10001
 chk_msk_fallback_nr 1 "check fallback"
-chk_msk_inuse 1 "....chk 1 msk in use"
+chk_msk_inuse 1
 chk_msk_cestab 1
 flush_pids
 
-chk_msk_inuse 0 "....chk 0 msk in use after flush"
+chk_msk_inuse 0 "1->0"
 chk_msk_cestab 0
 
 NR_CLIENTS=100
@@ -273,11 +277,11 @@ for I in `seq 1 $NR_CLIENTS`; do
 done
 
 wait_msk_nr $((NR_CLIENTS*2)) "many msk socket present"
-chk_msk_inuse $((NR_CLIENTS*2)) "....chk many msk in use"
+chk_msk_inuse $((NR_CLIENTS*2)) "many"
 chk_msk_cestab $((NR_CLIENTS*2))
 flush_pids
 
-chk_msk_inuse 0 "....chk 0 msk in use after flush"
+chk_msk_inuse 0 "many->0"
 chk_msk_cestab 0
 
 mptcp_lib_result_print_all_tap

-- 
2.43.0

