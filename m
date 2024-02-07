Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D710446C8
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329878; cv=none; b=YqxmLe83kZNSfgczOHXadCcO/TiCytpRBgMhPutEH6JpyOARYK5IfB/h11Yql6g+9dG8LAxOj0i3g5KvxoaJJzH31xZxiOIKjRetM+S97yOVoVtELO8AvMtRoz8AcE28HTPVtVyEJnVJYY+sPOeg1p8MLW/quOkXDzZCKAPjkuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329878; c=relaxed/simple;
	bh=2Vc3niTSsHEKY0zHjJKb4Kr+o+DXlwDcYE1IFy0IfQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rwpbT/DTyCVqKu0aDF58hN7cFMJTppRSkWhCImkrBUhZRP4hLcybnWI5R3WJenvaKrRTUfKuaGjRVGiWmlW4WRyNer1XBaenngIGZGlXVJv2/GE/cFMtS3OL4zdyms6WpZkQyC3FJ0S25oKGAY29ixPKstabWzqKDD5BQrYS4OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5fe5FgQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5fe5FgQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E772C43394;
	Wed,  7 Feb 2024 18:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707329878;
	bh=2Vc3niTSsHEKY0zHjJKb4Kr+o+DXlwDcYE1IFy0IfQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A5fe5FgQKh5cW4UM7I0pbeHgvEn33uHzzArEJGQ+f1psbxGrr1KFwzlJnik2ZrJrF
	 x5gcoAsmoXvwbek8IEloyv3C7GsLMekuNrsuAUkggTk+92uyevgCo/EBKIr+Z5jZoc
	 Kqjt9JJAqKoaWlv1rTP7ATV9H3p5ZNCW4AlcNJPXe6r3IzTHvcmO59f2Xqtc0EqYuJ
	 seqlaq03lmGauPIVomp9eGc/YfUQgsPZg51QM+ZdSH7kpDfSlxO+Gkuhwfa1EFWdru
	 59r+aE2YGCRkZC9k/+Q8ygmLRsv619HZf1aI2t49CWh7GDMAz9VTCIfbk3Ej7SJBNv
	 O78TFXERSQ5CQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 07 Feb 2024 19:17:49 +0100
Subject: [PATCH mptcp-next 1/3] selftests: mptcp: pm nl: also list skipped
 tests
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-selftests-mptcp-fix-5-15-v1-1-005b0cdb135a@kernel.org>
References: <20240207-selftests-mptcp-fix-5-15-v1-0-005b0cdb135a@kernel.org>
In-Reply-To: <20240207-selftests-mptcp-fix-5-15-v1-0-005b0cdb135a@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2Vc3niTSsHEKY0zHjJKb4Kr+o+DXlwDcYE1IFy0IfQI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlw8lTpU2D19+r2gWZ/Eb07nFp9PBtvagksfFsG
 vZX4xG1x+2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcPJUwAKCRD2t4JPQmmg
 c6d2EADbWkY4yMYsqZ1Clb92NWJvdGgAA4PnlaQF/WEtUwKifbvcwta06qCP8ALDSzJ4EsYaPQd
 bwHKcgYYMji61B4uHiqyYlEndtPrJTYixUux/7DyY0k+vhgbhrOYyWxbKXmmiP+a/WmTyZDxR9d
 c6NaB+tg3/2B7ZIHmv4RM4BNfyc6ACHgG12tMJoGdLWOLvdX8hGNkI/43MsCATlCCRLrWWsSMjJ
 AgdGPk9Ge4vLO/eG01T+0Ip6Ht0tLUSQIWInMHuW/zRXQmeXJpzkOwEaIcuO+ZeI2dzQZR+OBFW
 n2tcFfhvOL3jK4qDYu/4ciLiH3gGjI29M3xUw8NTCWCe9zzjz0Tbp0z4UxlucGnakNVxvFSkZ0K
 eEhmr6zxJYcZgRYvT4tKcmthY17IO6AlPD1FiiDw7wWiPb4diFQMOLrsmGUKpWEIOYhcREOBuc+
 PplazoLidfq3WJtP+sRw7d7q1FK7yYpM1IJS3CUxeaLZgVPy5A7s7Zo69Wo8nPpwgbWkC4Ki1zH
 J9iugBBJ6vX7YyFXZ3Dpq1uATxp0467E0g4uRE9abGtwfmn2fqbFdfzPyHHvnn350JFAdweqvT0
 v6HD8WvmFEhj9R7GUb9bMQuBDzfHfojgx/v9Z/aezr4pnwxgEeY2dZKxj5+SwpojZfyLABI/Cl+
 KJ6EtLTReHXHV6Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If the feature is not supported by older kernels, and instead of just
ignoring some tests, we should mark them as skipped, so we can still
track them.

Fixes: d85555ac11f9 ("selftests: mptcp: pm_netlink: format subtests results in TAP")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 8f4ff123a7eb..79e83a2c95de 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -194,6 +194,12 @@ subflow 10.0.1.1" "          (nofullmesh)"
 	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
 	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
 subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
+else
+	for st in fullmesh nofullmesh backup,fullmesh; do
+		st="          (${st})"
+		printf "%-50s%s\n" "${st}" "[SKIP]"
+		mptcp_lib_result_skip "${st}"
+	done
 fi
 
 mptcp_lib_result_print_all_tap

-- 
2.43.0

