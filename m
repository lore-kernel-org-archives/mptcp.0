Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C5926AFA
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807531; cv=none; b=tAQte5sxAS4xiDnkTXa1UaGSPPO5UZlpmTiTqKobrWlZC/0BQVxNv5a8tZPIfTu10/9ZbXwLGwRtsuyntqf9um/qNPOiFC7+4jFB5lxXkn6B/Xna9uIG43+NyO9w5Si42PxGTIL/X+jkefRSlR7nRgUTUIJKI6FOq01yR8XaROo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807531; c=relaxed/simple;
	bh=9VuYqdICtJfu90SkZyo3iZFyC6Rb4UbZ4hQh9WQWxBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=REa/0KblzQ4NgYjc8sSW9rBnav7Xz1+O/Ov7ROOAguhsx2i4+n0hAdoRY0ZeSRON8zw7/H+MNMoQ7/uKxVKPmZjGiyPAhDXbbDN5OQvLx6Iwy8yQVZZq7v/ry0EHbOeZX2h56Cf5R4/QpgQaOsLzaJEBi0D7ESbL1TYAU+OgUW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2grnv18; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2grnv18"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5134CC2BBFC;
	Mon, 27 May 2024 10:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716807531;
	bh=9VuYqdICtJfu90SkZyo3iZFyC6Rb4UbZ4hQh9WQWxBQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H2grnv18ZjoIGcpzad9qPi7JZHqopLFVj5vCZa7f+QFHs6E9yRcOYlO/SyHyzrxwE
	 uGK1CJPaOx1QyExddfQcLoRGSGss7Sr5it8eoArPgrq1+JSX4imZNWgP6TPMfhC6ZY
	 4WoNVrRETg31Dz6EiaQpQUCwYc2Ve8u7Wmc89ylN3NDGyNenfIE4bLSfWojVI2+YsL
	 qIyXAU3USbxQJAMhJjhrHxWp1W5Qx77LxTmni9IR14gxfd5M1UzzRVN8J07+j3bTDD
	 epEms3Vx9+i6AYVqLVZSb0jRnZfZxjh5uQASPs2TSSdZU7R/kyPcfTVMDgHuIS/kEy
	 N3wj5p7xbwkEw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 May 2024 12:58:33 +0200
Subject: [PATCH mptcp-next v6 6/9] selftests: net: lib: do not set ns var
 as readonly
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-selftests-net-lib-fixes-v6-6-72411ff2460e@kernel.org>
References: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
In-Reply-To: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9VuYqdICtJfu90SkZyo3iZFyC6Rb4UbZ4hQh9WQWxBQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVGdiIKPDZBEoiap+q0MXzI7/Cd/1ofUd3riZX
 5ZvBfi9HSiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlRnYgAKCRD2t4JPQmmg
 c+4vD/0SprY2rR9hjVNQtyamnFG0GUrzpEg2Nrz1JwPmnuARc/ed9ukwToKPOgnskxmLpIdo1ge
 yqCcYOy5085Wp15uxsKXX/YDZtAJYDhqJTpTpAdixuMhloKMYlBath+RREG5CzeUm3RHXRf/yk2
 I3pZLsNZ8k4MF8xj8qY/FWRrPKm2aiHQJYOxqh8ErwavG49ZrZ/XnJrYrWNFkwy1kTWmUs3Uj6J
 t56GC8xQvBYqw2HNWphUCunc88ixeBUeSORuZkInjlxZI1e3A3jdYx1I+KCfVRuPaGNogsF7oBf
 eeHUQ06/ONgtj/yXklLwjlsQi0PjyHVY7RCLDa5L0nvRTH5L+fDEujBGfHv/Vl8tTW43WF6Iypq
 XvH2pIk0Eo71tpqobEDjKF8jlY2TMM0Qhjf8mWbi7tecWQHwnIzTrtilSkfUPKbEtGNIlzlTjkg
 neT9NLE2YDwHDSL6IwtZaMV4ywYmwSRzMjfMeOrTsh3poG6/0qf01XlHUSFdX0bILGhy6k/ky4e
 qb7sXTEr6yk7nT/TsGc0oSXSVuCcZrkF5KV1VUT2nr2qJHM8HPOY9LLs0uoh9CAieAYYyoPHG7T
 enzhpkrz8HvoeqxUlThG3aNFh0k7K7O+w2CCtwsFtyXx38Y+s1HjOrTd2zMy13RupPovF1JwKj3
 dCe65Rccxb8v4Sg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It sounds good to mark the global netns variable as 'readonly', but Bash
doesn't allow the creation of local variable with the same name.

Because it looks like 'readonly' is mainly used here to check if a netns
with that name has already been set, it sounds fine to check if the
variable with this name has already been set instead. By doing that, we
avoid having to modify helpers from MPTCP selftests using the same
variable name as the one used to store the created netns name.

While at it, also avoid an unnecessary call to 'eval' to set a local
variable.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/lib.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index c7a8cfb477cc..114b927fee25 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -172,11 +172,11 @@ setup_ns()
 	local ns_list=()
 	for ns_name in "$@"; do
 		# Some test may setup/remove same netns multi times
-		if unset ${ns_name} 2> /dev/null; then
+		if [ -z "${!ns_name}" ]; then
 			ns="${ns_name,,}-$(mktemp -u XXXXXX)"
-			eval readonly ${ns_name}="$ns"
+			eval "${ns_name}=${ns}"
 		else
-			eval ns='$'${ns_name}
+			ns="${!ns_name}"
 			cleanup_ns "$ns"
 		fi
 

-- 
2.43.0

