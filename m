Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809732;
	b=cZWvDfCp6X2W4UE/R0ijZzQkYpwM3m9ZZMKe+8n5tFUIDct9SnB9rbgXPUHwMQZEEkAg
	 CiuoU+fj84bcKSYKQ01/WIeOPbwDq5MkisGBLU+KIg1MjI1I5tXh5rfnssT1pm3Jkm/Xv
	 I1np75Zlo9HsXhnkzlRAFh0PYdtzngkl1DmTuwkiqQ3cwddizuSIuF5cybMo6z/sBa8xJ
	 JyUg28PfOxrpAxRTPUxidOQOcEVRWpZ2UwKFDM1nzhvz5JgTDiIynwdy6935Z+ErorC7J
	 rKrGgoL17aEe5csnHWb+NzyK/EpmQKS0yZfPkyhRahs1K1sGJwSfXBgwWQ8tm+tsrRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809732;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=jvbxt8ZbS8UT/m4/vcfMSPofPmWQvQrF0aT2q/P5pWY=;
	b=SWbVdZOth1nPiW5NIg9oq428pQUt4gaX6fIdhAFk5SfEW4FR2+A81cd8obJohGbmTx9E
	 Hiukum+ZDxCP+2CWlHe0taogmGhZzpS/fFLtnzlDAyVrl4PMOtyWTpO7CYOJs6eRot7oH
	 WaYoJ2CGA+o9F0xixRuKkq4oONqQSLf2gMua3mpHtms2re83qf/tXmxsq6+gXFRZHHi9E
	 OdNDIpa5GN/q6kaQwk2Zy98bA+1uc7ugB49uyKRXdwEZBzeObn5kWYSobfa+b+Zfz6ff2
	 8KEYxeiamKNvb0CS2ClDVOw8Ne9y5W00uPRZe9QD2O+xl/is5Pgp4t1itTOvXoJdDng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CSfHEXyk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB4B606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CSfHEXyk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5BF1F0089A;
	Fri, 27 Nov 2026 20:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809732;
	bh=jvbxt8ZbS8UT/m4/vcfMSPofPmWQvQrF0aT2q/P5pWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CSfHEXykf3P8gzQiutqB6VHs0LNwuTeaAVkZoF+gVFgECWGvdLG2U/CsfrriT6n30
	 XkNUfsn4tQoBNwmiBNUAXPpBq0gMWP1f2D6QOzoFUX8CV/wyfIECEwdiMlwyb6YH/2
	 3xzgXY8POrvZHnSAcs1qfgo8y6qqxwuFnhs0tja0YovIUnjK8YOrg3ZwJfQya9mPLL
	 NonwPrmtpKW8wf2ZZ+nBP5NiK2Ihah0d9AedC9Rj0Jlf2sDaYLfPJ4BaRU45Ae4CZo
	 8LzMil94S15DzDKKHkGtTy7XoI+Dncy6CtY4ZszZdoM5yfQ5q+IRAVoOYZ0hXBfWs1
	 AfmNaHmE6bA1A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 27 Nov 2026 21:01:33 +0100
Subject: [PATCH mptcp-net v4 09/20] selftests: mptcp: diag: wait longer
 before closing
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-mptcp-cmason-fixes-v4-9-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2505; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7eIB26lskClTS16idz8mOcTreJ4Y/sG9/BMVJeJNPJs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI5H641rCmcbsUr+Z7rf0pFzs2zDLFaiYJXGAUaE8oEl
 O93hNzuKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmMjjPYwMH4r+GEkEn84/GDNv
 hk9By8bJ5a86A1knCR16VFv4/+SUFkaGb3btl+4cXfl8ux6H3Fex6/VFOvy8X3yUu9aq/3tySlu
 FEwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 'many cestab' subtest can fail in slow environments, e.g. with a
debug kernel config:

  # 26 ....chk many cestab                               [FAIL] expected 200 found 190

For this part, 100 servers and 100 clients are started, each one
shutting down its side of the connection 20 seconds after having sent
its data. But starting them all can take longer: the first connections
can then be closing when the MPTCP CurrEstab counter is checked. This
counter no longer includes the connections that sent their DATA_FIN,
while the previous checks, about the number of MPTCP sockets, still
include them, until both sides have closed: these checks can then fail
too.

The fix used here is to wait until the end of the processes before
closing, instead of 20 seconds: they are stopped after the checks
anyway.

This failure has been observed in the MPTCP CI, and reproduced by
slowing down the start of the clients: the first connections were then
already closed when the last ones were established:

  # 24 many msk socket present                           [FAIL] timeout while expecting 200 max 168 last 0

Fixes: 81ab772819da ("selftests: mptcp: diag: check CURRESTAB counters")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v4: new, for a failure observed in the CI
---
 tools/testing/selftests/net/mptcp/diag.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 27cbda68144e..396d85395dde 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -406,8 +406,9 @@ for I in $(seq 1 $NR_CLIENTS); do
 	echo "a" | \
 		timeout ${timeout_test} \
 			ip netns exec $ns \
-				./mptcp_connect -p $((I+10001)) -l -w 20 \
-					-t ${timeout_poll} 0.0.0.0 >/dev/null &
+				./mptcp_connect -p $((I+10001)) -l \
+					-w ${timeout_test} -t ${timeout_poll} \
+					0.0.0.0 >/dev/null &
 done
 mptcp_lib_wait_local_port_listen $ns $((NR_CLIENTS + 10001))
 
@@ -415,8 +416,9 @@ for I in $(seq 1 $NR_CLIENTS); do
 	echo "b" | \
 		timeout ${timeout_test} \
 			ip netns exec $ns \
-				./mptcp_connect -p $((I+10001)) -w 20 \
-					-t ${timeout_poll} 127.0.0.1 >/dev/null &
+				./mptcp_connect -p $((I+10001)) \
+					-w ${timeout_test} -t ${timeout_poll} \
+					127.0.0.1 >/dev/null &
 done
 
 wait_msk_nr $((NR_CLIENTS*2)) "many msk socket present"

-- 
2.55.0

