Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD676BB45
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383689; cv=none; b=HE0yWUbjmPdcnGevwyhAK+UbkULq47NX4MXAXv96jITDEhH0gJaGuZgKc8CKogT+xHJtPTLBpNdLLmvi9dCsSZwMXhYzNekYgsvCUeRtccODeSJZZx530R86u/atnaqi23PbGGU/mvvyQ3FIMi/rHoWkjEC5GddPP6s0Q4LYxko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383689; c=relaxed/simple;
	bh=6YbAJlCHQOfZcK7+3cO8OMekllmZxZfLK1yn/+fI2hI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EygYU2iwjUO6VdwauLO+eTEaJsTO5u7qD1dRQumZAvvyP3BKYtDOJb+NLStDDIZcfM/RBE5VNIb8jcPcGVVGKHSWORGZTwNm10/K9sFJRxbS54Yp4wHqgJup289QaQMprsRsg5pGvN6RLuK4IF0Ma6hYQmxkbRhmBT5A7CA40rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goDnm2Xl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goDnm2Xl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC91C43394;
	Thu,  8 Feb 2024 09:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707383689;
	bh=6YbAJlCHQOfZcK7+3cO8OMekllmZxZfLK1yn/+fI2hI=;
	h=From:Date:Subject:To:Cc:From;
	b=goDnm2Xlzpu6mok7yQsJRyNKHVXW2TKf5cd1qOyUmQ2DO3tH7Py91q4e+Jn7wTC4C
	 jt4MhJeDp0f5+4D1WUU02w8/e7Ex1PgLK/cIG0TjOwfiYcHWOTfFv03WIJFnJ4lDKL
	 LZ0lvMoQ+UMnaHEcwHH0zJ7euRK+b4Hm7kDnsu9t7d0U5UY0GndJbvBpH10wOkEZcd
	 nyeR2wSZs0IT+/RpqyFoIzANetrgKKKBopCcLIWuTvSitROeIiiQCbozvr/x80L95p
	 J+OG+jVIIaYTffI644cMu8k2CB6H44o5pYs1VKuitBZkWDpMO43siayE+WkBnafTyE
	 RcJiqMjeM/rWw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 08 Feb 2024 10:14:42 +0100
Subject: [PATCH mptcp-net] selftests: mptcp: simult flows: re-adapt BW
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-selftests-mptcp-simult_flows_faster-v1-1-2859ca46e582@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIGbxGUC/yWNywrCMBAAf6Xs2YUYaxF/RaTEdFcX0jRk1weU/
 rtBj3OYmRWUqpDCuVuh0ktUltxgv+sgPkK+E8rUGLzzvfPuhEqJjdQU52KxoMr8TDZyWt46clC
 jii4cbv3AxzjRAK1UKrF8fpcL/LVMBtdt+wI+3hhJgAAAAA==
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1838; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6YbAJlCHQOfZcK7+3cO8OMekllmZxZfLK1yn/+fI2hI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlxJuGv1/UGbOU5cnRrQ0VTyOx9EHyOU+Upt6Q1
 9e8pVQV5LeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcSbhgAKCRD2t4JPQmmg
 c32aEACs2QzN5qkbJy9tEbwUSbFc+yvyqCjat0g1nr6UzjOEOYzc3/sQASLPD1QzvumJujEycrJ
 +yfUnV1DN2nRam6G4Nre7p7frqZ7lCFVhvJ/uWehKQ4Il747sS5doojd2ijAxYy3toMW+Kpc7ve
 2vdLA7+VvdA8sRnzAot0SyMGW4SctNZtfZRkm/AWnwVmOflSljw5KOnOOCbRarKkAJoGE8eD0eY
 k5fFmDwiy0m+oM3Q6k7bdki6Jhq5y6S6KNui72WmRnohcbK9Yn9JgNSTR1eonkW6qShKDhVmj/s
 X5bXA/07vWz6ubY8E8AonCNZhBmnZkv/PNl2v6hCudBXsK2xTiJ6U2VwVYC0otgcXMDjJBgVYoe
 9GBm8SPgfgrYuC+gvlJObTE/pAUOSXlh2b9RijulmKhQ7Qs39B+uj168TGu8XHWhvASVA4SLZBN
 JZaO1mWPbSv09qu9TNJEC2IH2U1twItUaEbk8NeB8R+gebSXzGyuo3zJwW7/sNGi8ykktwXgVWj
 lvB/DtDJwRC3a+hnt3xwXsjwaKaQwLVzbXOgdMAT6POaIUFhMRXp42CkhpqeDgIkqDnNkAqmqik
 mlTOb9dEksPIFYAe4ZaNmCcNBWxtsgOY0zrzXQqXi1dSS/nX5hbYR8nTZKZd4HHSWbNcaC2LYOv
 UxppxX2rljNlz5Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, the bandwidth in simult flows selftest has been reduced. The
idea was to improve the situation in slow environments. It helped in
some, but not in all of them. With a longer transfer, it is also
possible to get more instabilities along the way.

We can increase a bit the rate limit for the unbalanced bandwidth cases,
but limit the total of the two links to 20 Mbps, like the balanced
bandwidth cases. The same 3:1 ratio is still being used like before, not
to change the nature of the test.

Fixes: 5e2f3c65af47 ("selftests: mptcp: decrease BW in simult flows")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 0cc964e6f2c1..619be0e1acf5 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -287,9 +287,9 @@ run_test 10 10 0 0 "balanced bwidth"
 run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
 
 # we still need some additional infrastructure to pass the following test-cases
-run_test 10 3 0 0 "unbalanced bwidth"
-run_test 10 3 1 25 "unbalanced bwidth with unbalanced delay"
-run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
+run_test 15 5 0 0 "unbalanced bwidth"
+run_test 15 5 1 25 "unbalanced bwidth with unbalanced delay"
+run_test 15 5 25 1 "unbalanced bwidth with opposed, unbalanced delay"
 
 mptcp_lib_result_print_all_tap
 exit $ret

---
base-commit: c2469b38e369c3f2b9577beeb9470cc757abc1b9
change-id: 20240208-selftests-mptcp-simult_flows_faster-0a3b46f5cde6

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

