Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3947A14B970
	for <mptcp@lists.linux.dev>; Thu, 15 Aug 2024 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754768; cv=none; b=Xt+OUGTK/MmTj6eew5dVkgBgaIIcY4f4a3id5D0cx/Mj8bAxOmIZzYVRvGL78a3NWoIaAH/6LNNFAEwEq1SwHlRw2L+PkGn3wrygvl4YmVpppgvNcegBYzok606+faEEDMUAuZPntgK/V4zFXoGtfZXhaI6TNxp+/AjZxUBfUfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754768; c=relaxed/simple;
	bh=kDArB3xUDpdDvMhQFCV+agltE+x1zALvRqZVBQrb00c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b22an8wKlFARefoBoL6YMlNC2VHEfb+AKBaUpBAM3CK/h0FXiuS6htj2nXIenfEK9QeqpZ6ers3tqVXuGZmJ4sj7CndNGYaa/7Fwd5Mzkd4LdO9Mt6qLKwNVJSFmlJMp795WWcaf7DVYaQfVLsdm5Sb7d2esRm76kWRmYLwwHzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIKne4ad; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIKne4ad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC1AC4AF09;
	Thu, 15 Aug 2024 20:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723754767;
	bh=kDArB3xUDpdDvMhQFCV+agltE+x1zALvRqZVBQrb00c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IIKne4ad5r2Wg8LHZYXsAPbH/3NR5prVma9+7TQ6dT7rXFF7gYdkNPmb76h4PMjd/
	 79/v10J3BgF+J1DMQPW2iz5VSAPtMrysLjFhjEb2ipOKHikEz2cNbxfZyDNDeNIWzS
	 fDqtYG7eGpPvGAKkm6v1zoyLDQDvSFICc7MrFqOg+daYqOir7Set7jU/t6SdOsevP6
	 17+G9udw7QdNepJepNtT5pEkAgRGEsj97NbV4ppUH74fkXvfJcd2qNQ/0jUbF9Uo2u
	 /hkmzMBjPSl8/GnIgOgEkmMCsYcwBWlGADFIenLTFIem5D2UdoFhYJ3vCYXmnvio1M
	 rcMFaifBJnggw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Aug 2024 22:45:45 +0200
Subject: [PATCH mptcp-net 04/10] mptcp: pm: do not remove already closed
 subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-mptcp-dup-close-evt-v1-4-5a551d3a66cc@kernel.org>
References: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
In-Reply-To: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=967; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=kDArB3xUDpdDvMhQFCV+agltE+x1zALvRqZVBQrb00c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvmkJDmp6hdEEp3JlMa73FcNlEvGLiEQyBk3ox
 kClcTAGJr2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr5pCQAKCRD2t4JPQmmg
 c87kEAC0xMdkKMs/+CRzMJTqjCxEsX+NPMgc21uZFEP1Dv5IO4ujI9gXV4rG0WLftaMCTKm/3i4
 VIoV+IZj9nqK6YCklUYwffd8jS+9nm29FzmA47YoLwgduNCg7GyGSYvgjJROsmL5WmiHA7MD6kK
 7mvmi6TpyW3RZl1L587J9b2JQhTiI2lqwjeaYXMZZ1NBhNOLWPaxStD4vcGjrKaML3HFQFCVWIY
 xkRFqz7fD3+an9eGbEEnlOr56qM0v2BamIR8MPKWIZcf7VJZ5WbLakCvMwG1zhnqCcrDFlGasDP
 nSLiA6Nz+J7PiYWC+mMbn74QI/UzzgvjepeWEqis3AkaQZzMNXt1QuelMX1qLlkf78qLYcJRXgD
 znBFMbWbZJLVsuILlw8vpoqTata+v2aEJky5lsUC1LFMCYhnv/v5qneOXC+yCp77W0h45Z5Htgm
 jR5TdEpneD9s/z9qh7Msj1DpIUM27yzhC78ix9Oza1mU0YMzU3FDX7+he5rzkF5z87EcvYY0ZqS
 iZ6gfOA00grtWJUHUamwR/JuOSMP1M2d95NWOHFb7Fw21Bs9KBsMIDnL7IJMBsyEdMHleRfNBGU
 kE47YRZXaGi3PdFdltrnPcYc7i+/gfFlQ+46ptMFFCdV410LUcJGTEKXlg6Cb+YfShlW2N6BBQb
 2perkiAlQw7H/qg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is possible to have in the list already closed subflows, e.g. the
initial subflow has been already closed, but still in the list. No need
to try to close it again, and increments the related counters again.

Fixes: 0ee4261a3681 ("mptcp: implement mptcp_pm_remove_subflow")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b2d950e4d7a3..7ca9dbbd5f14 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -842,6 +842,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
 			u8 id = subflow_get_local_id(subflow);
 
+			if (inet_sk_state_load(ssk) == TCP_CLOSE)
+				continue;
 			if (rm_type == MPTCP_MIB_RMADDR && remote_id != rm_id)
 				continue;
 			if (rm_type == MPTCP_MIB_RMSUBFLOW && id != rm_id)

-- 
2.45.2

