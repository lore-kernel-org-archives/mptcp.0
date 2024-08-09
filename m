Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA1C1DFF5
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207086; cv=none; b=FDjsk3ULixxzSTjo2bMcybSRz44kLJ8uc+FMFY6uQvjo249qKq40kDpV7kkZfxnZcy16t8XXBtgGeMfAWMzGlI2EPCsKVYoOP4m6TZFfK+UVStTFbyPt4YVakpubJDGX81aSKxjTLUGofoG9yrgGVZrKopq1bz71qIGXZOIDrlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207086; c=relaxed/simple;
	bh=wIOiFg8BmC5bNKfY7OrATgmbrxlQMpRLLp4QjsGPk44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c2BNYqFV/1/EwHOZ/uQkDmBcHX5b/nJSX8E9JU4rkFWLSPqaY1v/U/4HnmBrc4xPE0mAL9ZiAtUg7VlGjXqgl7zm0/WrEmFbCsf2NJlOIIAF2wsnngxnT181ba6oUn0NPrsRoHF99WxryCU7m024lvEsq2grfqFrVXT/3tbB04Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUS3RZTI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUS3RZTI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40597C4AF0F;
	Fri,  9 Aug 2024 12:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723207086;
	bh=wIOiFg8BmC5bNKfY7OrATgmbrxlQMpRLLp4QjsGPk44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TUS3RZTI0JC3dQFdU5IIa0KTnIsETmPrb3zLsQHVODsLWa21FpkaJZvJ85IOSv8xw
	 R4rM8jmGM041+fxapDQBT2iclHjYWji/z8RjAuiiuO7+1XBGiAlv8nxnnCW1+Sdo6o
	 8GNXmMFWQdNJ7Z5KrrO12Pbak+zEYt0vceLQDd/639xTBAX1P5Xv76QWtWwQR7EgHB
	 Qm9fUZjd2D+XMJEMU0x9WhFCo1u1e3XUf8bKuEtUaQnaKuH6reCfrDWjlZ8QQ5LALL
	 GydSU0dzS8ZgMPdxQ4B85LEdu4ZxGpbd/fibsQ2uT2O3QJaX61XhC9RvOLIsKix7cq
	 J2QpVVgJ/EyJA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 09 Aug 2024 14:37:50 +0200
Subject: [PATCH mptcp-net v7 2/3] selftests: mptcp: join: cannot rm sf if
 closed
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mptcp-pm-avail-v7-2-3d0916ba39b4@kernel.org>
References: <20240809-mptcp-pm-avail-v7-0-3d0916ba39b4@kernel.org>
In-Reply-To: <20240809-mptcp-pm-avail-v7-0-3d0916ba39b4@kernel.org>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3317; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wIOiFg8BmC5bNKfY7OrATgmbrxlQMpRLLp4QjsGPk44=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtg2q1Sehvai+p8aJDEkecmK8eEoV7Ndrooh73
 A5L3+vpQn6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrYNqgAKCRD2t4JPQmmg
 c8NqD/4zG2KEg/YKeHman+SF2Nfx0nRe02Ot9Ds85z5FaDLzMrDhDHpvZTVvyrpvUEbLBgQ1sDS
 lk6sWdR7pmYWtfWtou+fl3YtD1JAnH27JxO3JMfidifV3TLDXKLLUA0ZZ8ekBPbIbu+zVAeEraw
 1SxWnSK08K+P34fRMevbf40d9soEggTCtMvu2N4THeCNvEVhN8D64GkL/UW8vCTONq0Ujx6TWTM
 mhTX5KZgm1/ABkFuC5S6j5A62m4glP8g/OMpyaHC+ytVPjUnP/Kk9L2/+n7PgHeXGDyQagdjWJa
 hlNcTsDg0E7LQsS9GwQ3b2tyFn37s4r1Ov91dWioC6soKx2lux+HkM8tswKoZdaAZgFbSNguYzM
 FlGPgw/QBY0hD+SuwohIOJFRubGsbc0IiJFaILzGt56tjIJr4nJZ5wZjGuEc5c/mO7MgV36hha3
 dtqrlEnWW3PKt97/n8cGE/e7lzcI+T39v8tSi5ULzkVt+exKUX5nQZ7Iq98hrDMLip1SeYItak8
 TI04WpP4leluBm2SHwTQUyLln2IxPvhXBU10mltMen4CpPSnce7ndICeiQclptyUFZ1SQ/M0Nyy
 pHRxZeqbLfpHWo3YakeBBoxZwkJuJow71Rx31TgRcWNlg51V4gJHItlBWBViaKzkWIcobFoj9E0
 KqHWNdrVx5KG7EA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Thanks to the previous commit, the MPTCP subflows are now closed on both
directions even when only the MPTCP path-manager of one peer asks for
their closure.

In the two tests modified here -- "userspace pm add & remove address"
and "userspace pm create destroy subflow" -- one peer is controlled by
the userspace PM, and the other one by the in-kernel PM. When the
userspace PM sends a RM_ADDR notification, the in-kernel PM will
automatically react by closing all subflows using this address. Now,
thanks to the previous commit, the subflows are properly closed on both
directions, the userspace PM can then no longer closes the same
subflows if they are already closed. Before, it was OK to do that,
because the subflows were still half-opened, still OK to send a RM_ADDR.

In other words, thanks to the previous commit closing the subflows, an
error will be returned to the userspace if it tries to close a subflow
that has already been closed. So no need to run this command, which mean
that the linked counters will then not be incremented.

These tests are then no longer sending both a RM_ADDR, then closing the
linked subflow just after. The test with the userspace PM on the server
side is now removing one subflow linked to one address, then sending
a RM_ADDR for another address. The test with the userspace PM on the
client side is now only removing the subflow that was previously
created.

Fixes: 4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - v7:
    - clarify behaviour without the previous patch. (Mat)
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ea954ba85969..4129952fd9ec 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3408,14 +3408,12 @@ userspace_tests()
 			"signal"
 		userspace_pm_chk_get_addr "${ns1}" "10" "id 10 flags signal 10.0.2.1"
 		userspace_pm_chk_get_addr "${ns1}" "20" "id 20 flags signal 10.0.3.1"
-		userspace_pm_rm_addr $ns1 10
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns1}" \
-			"id 20 flags signal 10.0.3.1" "after rm_addr 10"
+			"id 20 flags signal 10.0.3.1" "after rm_sf 10"
 		userspace_pm_rm_addr $ns1 20
-		userspace_pm_rm_sf $ns1 10.0.3.1 $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns1}" "" "after rm_addr 20"
-		chk_rm_nr 2 2 invert
+		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
@@ -3439,12 +3437,11 @@ userspace_tests()
 			"id 20 flags subflow 10.0.3.2" \
 			"subflow"
 		userspace_pm_chk_get_addr "${ns2}" "20" "id 20 flags subflow 10.0.3.2"
-		userspace_pm_rm_addr $ns2 20
 		userspace_pm_rm_sf $ns2 10.0.3.2 $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns2}" \
 			"" \
-			"after rm_addr 20"
-		chk_rm_nr 1 1
+			"after rm_sf 20"
+		chk_rm_nr 0 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids

-- 
2.45.2

