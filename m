Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10609F510
	for <mptcp@lists.linux.dev>; Sun, 22 Oct 2023 23:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYI19YVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F63CC433C7;
	Sun, 22 Oct 2023 23:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698018875;
	bh=p5dSTsav7qbiWjKs5hdZ4mLfkQke2+XlCpvd0WhCIfw=;
	h=From:To:Cc:Subject:Date:From;
	b=TYI19YVNVReNkI7h+5YmQm/8WCb8+9IHeWzKr9uA+nkwd2xFW1JLTSfrZ6vtjXYEA
	 ah7cfw1/3+GI95L1OV5KxwvJEkfRKF+j67y+OxTYld8gkrQFIq3rl3BV0accW/X+d5
	 aSJSNOxhEB6y83cXlkCzF9Cb8K7sMUcXMljC8V4/10y5rNuTAB9fiV1GB4tEZGHhd7
	 knAoU0ToISTGtFW/jM9+HwH4h64OHCTpwo7pRwXmeF3kFL6v9nKPUZ39DekF/kVRpj
	 /UEkL9ViydcKdTIsWSMkwIjZl1rwS5saFVMinIIBAiXS9awvwrQCBBMjF80Ho9bISu
	 P465X8QuhnmJw==
From: Matthieu Baerts <matttbe@kernel.org>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH] Squash to "selftests: mptcp: add evts_get_info helper"
Date: Mon, 23 Oct 2023 01:54:19 +0200
Message-Id: <20231022235419.3654113-1-matttbe@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1885; i=matttbe@kernel.org; h=from:subject; bh=p5dSTsav7qbiWjKs5hdZ4mLfkQke2+XlCpvd0WhCIfw=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlNbYr209miRYX+0c4+g1AJTj/RN4eGLeLQfmpR gumG3MsOkmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZTW2KwAKCRD2t4JPQmmg c4AAD/4qxT+SYj0IECNyOtKIWKBCkwBiVEuAr3dgKksUg2KWL/cZkvVWkXILW6AqHNXCB0J0KS9 IIMmsn13vvUN9QvLdczDlhXVBWAVGivm+5w/bZuaGo00k0ueQ22yhq4x206Uhe6S+eIZbHI4yng up4Z+b3h3+TthTg1ey2SCxNUeYXsggvkZaON6K7kOkIX7593YnQ9U/FezYN6pPCAS//zUQ3auwg QALnDWyety+fa5VG3wju/yaMv+1oLMBoJQ1+yw0+zxEDTFc3kqPGg/VnBBVSP5/u25ak26MdABZ mMRjIzo0eTuGFFxbGYz5V8zvGCZzDWoT7PzIQaDEF0Qc0vtXm3XC4auz+m8y4kMBHUZG3G43ECx EESc2tEgsYNs7FwDFDZ/GCi6xK1S1UEk7IaNOg1WQTY7potBYlO4GvaGhAxwnTdOxokuPmHplc9 IDH1QQ3ewDy4QIIQtJbQwbQ9DHgA+6k+knIAGA8z0PAAtaod+YlO8EoFbcDoz5zQ1Py+SP0W+9r HPgXjPJp9FuVDe1ktJYHrWQuz+89AQq4JGKbTjhQV3tpN4TTRNqvvfosr2Qf/CXY5RkNxANcVE+ LuanFe4eY/L4s9lGfLDP3NmQgVaqP2T9z0CTJ0U8VKVwOKpTbBLDkfGUO0dyVuACldgs+5SQTP+ YVWuLqnpirTDU+g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Fixed info and style issues reported by ShellCheck:

  In tools/testing/selftests/net/mptcp/mptcp_lib.sh line 213:
          grep "${2}" | sed -n 's/.*\('${1}':\)\([0-9a-f:.]*\).*$/\2/p;q'
                                       ^--^ SC2086 (info): Double quote to prevent globbing and word splitting.

  Did you mean:
          grep "${2}" | sed -n 's/.*\('"${1}"':\)\([0-9a-f:.]*\).*$/\2/p;q'

  In tools/testing/selftests/net/mptcp/mptcp_lib.sh line 218:
          cat "${2}" | mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
              ^----^ SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.

The first one is just to be on the safe side and the second one is just
a bit better but still, there were the only two issues reported by
ShellCheck: better to fix them to easily spot important issues.

Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---

Notes:
    to be squashed in "selftests: mptcp: add evts_get_info helper"

 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index def35395a254..56cbd57abbae 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -210,10 +210,10 @@ mptcp_lib_result_print_all_tap() {
 
 # get the value of keyword $1 in the line marked by keyword $2
 mptcp_lib_get_info_value() {
-	grep "${2}" | sed -n 's/.*\('${1}':\)\([0-9a-f:.]*\).*$/\2/p;q'
+	grep "${2}" | sed -n 's/.*\('"${1}"':\)\([0-9a-f:.]*\).*$/\2/p;q'
 }
 
 # $1: info name ; $2: evts_ns ; $3: event type
 mptcp_lib_evts_get_info() {
-	cat "${2}" | mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
+	mptcp_lib_get_info_value "${1}" "^type:${3:-1}," < "${2}"
 }
-- 
2.40.1

