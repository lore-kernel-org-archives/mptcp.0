Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CCF484237
	for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789408099; cv=none; b=NwEuu5KdBHqTTB13eXeBkzx9c3rx80ccgtowa92F8lv1RjNwRnNjTzDdmCGmcO7dRgvI7+PP9HG698k+NvMNPEf21POoIumRR/aGh6j/4io7AlJrvm6f4DSeGZJy8wZDAogJzqjzgry2hB3mKoiRMlDT5p5eSIfJt4PF8k6aKqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789408099; c=relaxed/simple;
	bh=AZMGzyvufrHCSWqCmxZbRtabT+G07PL+5bKRQRKV7bU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Eq97/SV4lR65ADN+acBhVH2dOu79LY7BcBTS5kRr85m9i28sQUfwz1ja9ym5r3IOSJRUoP9UEE7fOwDXzQybtrvfEEY7yuN2MpoB4yTAJ9Cej1IgSaeXoAubmhVEPaIPfC5Gc5FC+SzT217YEEB2FnSEiS59nV6/nT6G4/Ffn9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7EmWUOm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7EmWUOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2911D1F000FF;
	Mon, 14 Sep 2026 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789408097;
	bh=MsGsU8hIbe5aGNrb5gTk5f6+ExL9Y32IZAjFYLe+YfE=;
	h=From:Date:Subject:To:Cc;
	b=O7EmWUOmqhHpv5VdokY4ZNztcGJg5I9IowaLfUdXDa/8Xkl4dt17P1eASJNsIQO6r
	 hQM5+jPP1gir/AjUagiZ/JSy9eJRO+9AIGbt7a1G8bbfF9z4W5zLmbaxk1Vx3IF60I
	 HcqvEkgOjyF1lr4TGrj9gNFEWsbVCYjGIHzkekHyh7BHOYhPCm8V8wxjsaNUzTV2Sz
	 +5qzxfipnn/KRvt0UMO9Uh+wSdi0eFK8Ki02eQ+9qMEW4VvG3yZ30cXkOnqcZ48vsQ
	 ZvFAAcyaSEN1s9XGqS0yaQxTFC8rQx23rDhq6VyyyFQRruQ4p+uQX2pdtPmhy62536
	 VMh0CBSB/zn5g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 14 Sep 2026 19:48:09 +0200
Subject: [PATCH mptcp-next] selftests: mptcp: join: capture on client side
 for test 020
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-mptcp-sft-join-cap-ns2-v1-1-2f48e4c5f9eb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QqDMAwAf0XyvECtUnC/MvYQu7hFWCxNNwTx3
 +3m43HcbWCchQ2uzQaZv2KyaIX20kB8kT4Z5VEZvPPBDW2P71RiQpsKzosoRkqo5pHCSP0QHJP
 voMYp8yTrf3yDs1FeC9xPZ59x5lh+Z9j3A9wmf/iGAAAA
X-Change-ID: 20260914-mptcp-sft-join-cap-ns2-a6ba4960ea23
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1553; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=AZMGzyvufrHCSWqCmxZbRtabT+G07PL+5bKRQRKV7bU=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGqoM2Cjb2lc/SytOewGVZlxi8doVicObNvn8pfPADg/NCaH3
 oh1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmqoM2AACgkQfCLwwvNHCpegeQD/S2ON
 6z0g2JdNRHugXvjYJMvaCYjwWh+Z4xdH9w9dJMcBAPs0Lf7LNy9eud3M4FXhyltu7HJjZGGlwku
 BlzKSnWAP
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The test "signal address, TCP-only listener on client" is a bit
particular: a TCP-only listening socket is created on the client side,
and the kernel will try to connect to this local IP.

To be able to understand what's going on in case of issues, it is
helpful to have a capture on the client side as well for this particular
test. This avoids some confusions.

Note that the 2nd tcpdump process will have its standard output
redirected to the same file after having truncated it. That's fine for
this test, this output file is not very important, no need to have an
exception there.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b16e24418e73..690188b01a29 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2413,7 +2413,10 @@ signal_address_tests()
 		extra_bind=$!
 		mptcp_lib_wait_local_port_listen "$ns2" "$port"
 
+		# there will be traffic on the client side only: MPJ to loopback
+		cond_start_capture ${ns2}
 		run_tests $ns1 $ns2 10.0.1.1
+		cond_stop_capture
 		join_synack_no_mpjoin=1 join_syn_tx=1 \
 			chk_join_nr 0 0 0
 

---
base-commit: 060af37701a3aca2c02cb5e874d740be6acbf1a2
change-id: 20260914-mptcp-sft-join-cap-ns2-a6ba4960ea23

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

