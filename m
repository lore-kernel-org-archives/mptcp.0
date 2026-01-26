Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C7F280CFC
	for <mptcp@lists.linux.dev>; Mon, 26 Jan 2026 19:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455495; cv=none; b=fHqV7hJA71ffzQglIwXS20ADHzs3KkjZMxk7oAHiChYT9zaUVqjclo/sfEDvtJd6pJpQdAS+lDyBFtrYZU28JUpOzumRDP/a/tLTFfl6+Q5rbexvX2b9tA+oCT7wFs0Us4stENeVwBGi73zOarTHCBf9zDRT2kNziWeKx9gEsF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455495; c=relaxed/simple;
	bh=QI7WRTwVSEM0XiF/j6mP2IUzraAerfechwCzPq+aXgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r4HEmZKESlO2b1OrTreRt074MKYra8A5oqIb+MsarNYz0TspQF3pvf/JIcH1OJxUEDF9Qx17p7lEijH2OoJ0yR/xaVGs45bSVRElbGWvQ44OOZqjMhfnmDg6ngavtiTceWBtX7HTUbor34XteDnJ9kD0a5FhZa6E0LG5gDverHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvhId2db; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvhId2db"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78B7C19422;
	Mon, 26 Jan 2026 19:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769455495;
	bh=QI7WRTwVSEM0XiF/j6mP2IUzraAerfechwCzPq+aXgE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lvhId2db9j/J82i6vWGmvNrjFPZ/MTAPbAgizg/zEMtqShiqoiaKppsYsxb1yGc3D
	 Jsb6nbZQ/LOWgPK6D1Zjb7cq+qTEhfRBtBOvAJqBTS53K1W0LL0L+avAZm3aANuTO3
	 zcy55/2b1pd3xnQY38bUNGJquQUqaChoULBukbKkEyzSRpoDC9hORI9kLOBZeLnadD
	 ecv6Zb6S69KFsXnTyYmFx9VUdVJJx0wr0JnVtl7L9jkisjgffejJ92aIxrvHS/dh7E
	 EuxvAwt7H/WfrCPxugYcTbAOwRFTERK8CaZzDxfN1LhVia5Db9LkrN4h3NNZlFuN7h
	 60ISZPWdjUPmA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Jan 2026 20:18:45 +0100
Subject: [PATCH mptcp-net v2 08/11] selftests: mptcp: join chk_stale_nr:
 avoid dup stats
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-mptcp-issue-603-v2-8-8393e7840b9e@kernel.org>
References: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
In-Reply-To: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1401; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QI7WRTwVSEM0XiF/j6mP2IUzraAerfechwCzPq+aXgE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLL99fO9Jm+oPL4Af+TZ89NuSV4/oqszNpE9umfj1Xc8
 bdiuJlg3lHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRs6KMDPs9gqsXfdt2uUNP
 sV5IYZFo2o6QTb/Te1aVXyr9djzw5leGX0wzfKboZl+8X3eze88qpw99a6QDZnt+qeiUPnGzSf2
 VIh8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

nstat outputs are already printed when calling 'fail_test', no need to
do it again.

While at it, no need to use the dump_stats variable, print the extra
stats directly. And use 'ip -n $ns' instead of 'ip netns exec $ns',
shorter and clearer.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4977e6ff17b4..a8b9782a85df 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1648,7 +1648,6 @@ chk_stale_nr()
 	local stale_min=$2
 	local stale_max=$3
 	local stale_delta=$4
-	local dump_stats
 	local stale_nr
 	local recover_nr
 
@@ -1664,16 +1663,11 @@ chk_stale_nr()
 		fail_test "got $stale_nr stale[s] $recover_nr recover[s], " \
 		     " expected stale in range [$stale_min..$stale_max]," \
 		     " stale-recover delta $stale_delta"
-		dump_stats=1
+		echo $ns stats
+		ip -n $ns -s link show
 	else
 		print_ok
 	fi
-
-	if [ "${dump_stats}" = 1 ]; then
-		echo $ns stats
-		ip netns exec $ns ip -s link show
-		ip netns exec $ns nstat -as | grep MPTcp
-	fi
 }
 
 chk_add_nr()

-- 
2.51.0

