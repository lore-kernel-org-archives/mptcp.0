Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A8A84FB0
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563644; cv=none; b=guqt2RcKpqfIVbeZL4l4tkywf/xh6ThpWH8ndi5O+fnuorqw4MBzbreO9WWjxv5o5qdDAREFsOGB/piiCoDjKK1c8Y/AJESSBFdf4QH7kA7SeXBTHBwainKpif8Ou4bdCigfMLfbq4hdEJYNy4Zf5AJ6/GI3phHL7UB6k5eYC4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563644; c=relaxed/simple;
	bh=9VuYqdICtJfu90SkZyo3iZFyC6Rb4UbZ4hQh9WQWxBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SkNPRSqjQHFQ9d9gerAPZAh61dqci/Y3FiSNjmHPh7xth52iSNvRcn9q6sD+ZHVyVK0w5WKPicw1MT6Q9smfMYFn0wTh8xaPyQNaRqWfUcmj0T/oeGea6K/+3srnvhtq1rrUWAjbaGqst445YHgLVmZ/EO1P/m7HyKkGkaoOkE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aW7itrCt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aW7itrCt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCFFC32782;
	Fri, 24 May 2024 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716563644;
	bh=9VuYqdICtJfu90SkZyo3iZFyC6Rb4UbZ4hQh9WQWxBQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aW7itrCtOAn/U09v4aV3ccDAHngs3S4bNe655b3gX6QyivF4iGcCMxSW1XLUbnIZ9
	 61J6nURReBv6UWzjfa4KXiIF9lPp1JGO7lgViE+6U7tZZMwdPCoKkcDLMmitq07OEw
	 95nHlU/NTKFjacWZgbwdjwAIG6GYrmQjBJ10F2oHOTjKdi+jSTojs2xlAFyAMregtM
	 BuoXdZOrIB3r4iabk2/N48MJfNbdQ6UKfOa+j63zNAPlPMb7UYxPOnfTSBZDesm36T
	 2ZXQ3VuvedLsjLF50xTdBKPn+XX3xQigJBHVD/putHDm5mZAt2SltXfh74Z98qzbHw
	 44P1r4zmo1wuQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 24 May 2024 17:13:29 +0200
Subject: [PATCH mptcp-next v5 6/9] selftests: net: lib: do not set ns var
 as readonly
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-selftests-net-lib-fixes-v5-6-b9e0968571a3@kernel.org>
References: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
In-Reply-To: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9VuYqdICtJfu90SkZyo3iZFyC6Rb4UbZ4hQh9WQWxBQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmUK6zMvF3L+Rz5MDYxHwabpkJsXMGMCICVzebW
 XY9y7KOt/SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlCuswAKCRD2t4JPQmmg
 c4isEACk9u79jjVIIWFaOIIOiKTq5k1UKOB8Bvj5ess0dMyjZ7WhhClsH8dduUpkztMV71ivad3
 mvUGBtXnWOaVstT+nGz0gvlLUu0p6FTJH7sAY4Y9RW7ssmQbsNAzyLGaguIiNE/grk/l1uXHmxn
 veS01desg9Z8je/Qi4sHGZP67Y1jCs17H7sfFDe66N1VZI4cLHESayn0nJkHfylqVZzwmwddQyn
 hoyrhVRlJ6D0AkwuLIJrSK5aE5+b7BhD+ipaMeq3xFiOQbXn/5jcPtY8HUW9C44N4YpG+15aZwL
 gxWK6x6XQihfJPmQ16583oDaWltwfQZGBV5YaIigXuPguyZ48L7VVOR6x2ww0+mv6UqvwAe4e/C
 ycTIZTfdGbxQr5cw6wghDtulrKCSx7fgefedL1OMNPjNnv1Y4hTNfikfFQBrTvvSxmlMkbItMa+
 u8qENtI/JIOfJnDqT1zlCgZpZBNMuVRLQyEpSFfFsBQjaFET/U7tMmG3yVntlX3Rb/OdWh6cKSJ
 YX+VjLPN0kJ8bew9MtyGzx9EtqhvkWkcobVJh9oUACKGg/4q5ZmovBd8hS7Ysg80luZ96Dykrsk
 9p3j0+BSux9omjiVeVQCH78lt5bfEsXoiTuJki51uxQ77sINBaSViFyZeH3oiM6q5C12/nqNQDK
 R9oHoJ7jkIlg/aA==
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

