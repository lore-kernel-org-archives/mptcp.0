Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1266218B463
	for <mptcp@lists.linux.dev>; Tue,  7 Jan 2025 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269792; cv=none; b=Cn/vc8wJOvkyTZ1bqhDj5LuUu9WyMNtoeQRdcETLiHBVtrcYJF45AZE+ffW5F5fQOrxRoUOocKQ99oZL3tiKgyZ7tIiZrk0ffXXOEaVy/3pGubDaRdPePJMEGZ5JBULpQ3gr4TBVFBekEzSs5LWAhyTSKlP906GtL2xLNCXHVsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269792; c=relaxed/simple;
	bh=hpukQ86ZN8TF2Ut+z1mdvXgXzprL22bov1llOuA5sqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GRApJfau7B2fukqwndsf0AUNZiFRC/kHt+qzvNdkT/TUJtNm8xKWv0r7VXPj0cFidsNCJCTniuHC1wA+dtVj4BW2kDHK2MqV4Sg+TQSd+Q8d9OilS7XVZZZA0o2fH+ZRD6nFOF/fcy1hbgPtIY5s7OxT5JaVv0eXHMikcIkF29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9CSCpPo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9CSCpPo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF8EC4CED6;
	Tue,  7 Jan 2025 17:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736269791;
	bh=hpukQ86ZN8TF2Ut+z1mdvXgXzprL22bov1llOuA5sqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C9CSCpPoc9BfedTOOxRnnDtlFq6wh5oJWHC3Mvnctr/tHTtzWJTgZKcrm73jeymyx
	 MaRa0A6gcHilNWuQ2VXh3FjT6H9KoDMplqAvapcNwLeRo8xphPiusl74g6o0aesVmp
	 B1IJ4MkQxzI6rp7bw/w3vTk/xYbtw5lie3fyJNM8tDNabFPekQNzOHd92XUGJvKtr7
	 b5JIXizeqYngv1LN3GplCaSuwRBtN6jwfWsGnnN2+JYCTEPm5f2sGj4Po1MkcM6O2x
	 /QViMLi+5TO3igUY9hWlyU7M9wiiHeQ1uvRYp1j+JhlAAlbtvLFjiLrj+XyZydslRT
	 Li4x65HyXk06A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 07 Jan 2025 18:09:28 +0100
Subject: [PATCH mptcp-net 4/9] sctp: sysctl: cookie_hmac_alg: avoid using
 current->nsproxy
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-mptcp-sysfs-netns-v1-4-2fa7075d9970@kernel.org>
References: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
In-Reply-To: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1704; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hpukQ86ZN8TF2Ut+z1mdvXgXzprL22bov1llOuA5sqU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfV/a9O0L6RqkktWRSQ6A4abXceW99EFtN/VLh
 Xjxn0TvF6CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ31f2gAKCRD2t4JPQmmg
 c70PEACIEsdRxrPfei6FgjbrgDORVaiA4v9KReXttjAIP6hHmhcO73QIDW4QGdvH85JK3Z8Uv4P
 NIxLdID02H9oHkbA/n3bjwg+7vCBqYypCAwbt913BnTY8/EGJ0qNStTtyXC+/MhMSEkHb7tCa0L
 b8cjHdG7+DIxz/e98c60xgyAsInk+rnKN3fP1QWGPNndkuf8xOyfgS0fwJJvxXv/RjK2Y152G2h
 L/KDkuMp09qQDnGcXXBFB2uiNkuqRZu4StkNMHgUGaC1STTsUmLX/r2UF10pK/Jv3CqeTC8RbBN
 hHDoCA5CUZcXLVuXbZot/DIUI/nH6TiiDf70ev3TD7Fi1DYYFe8l5Uzp0HOm5mm9r/IBS3fCX/x
 TTDjongBoZKlvrzhMHsxVVo2gvx3cejS9kK/kiHmFtqUtTUqsdPKyNKIRVS7/M8eWcyKDDfI0jD
 Exe0K4JnKBLF+49b900IU/6fZ6VzbX0xSLQ21O6451ZdM5tLtlo5inaY8ZwtBYaMrc0sOo5KlQI
 OMv0v458h/iAaUKJuglwSnZjj04I6eif1t28qBzczb81VZcFjosMnZx64u+PamTgcTI475kEnVc
 T8jKBiLN/KI+73eFfqI0BaVhA29XyMbVjFOZuMtaRhVdbLJlQw9ALQQ4b74u04oULnXaxIisZMk
 3YzYqMiAjfGuK/A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As mentioned in a previous commit of this series, using the 'net'
structure via 'current' is not recommended for different reasons:

- Inconsistency: getting info from the reader's/writer's netns vs only
  from the opener's netns.

- current->nsproxy can be NULL in some cases, resulting in an 'Oops'
  (null-ptr-deref), e.g. when the current task is exiting, as spotted by
  syzbot [1] using acct(2).

The 'net' structure can be obtained from the table->data using
container_of().

Note that table->data could also be used directly, as this is the only
member needed from the 'net' structure, but that would increase the size
of this fix, to use '*data' everywhere 'net->sctp.sctp_hmac_alg' is
used.

Fixes: 3c68198e7511 ("sctp: Make hmac algorithm selection for cookie generation dynamic")
Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/sctp/sysctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index e5a5af343c4c98de1afb27359c104f5030583ac4..9848d19630a4f760238a3a2abd3ec823f012d34a 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -387,7 +387,8 @@ static struct ctl_table sctp_net_table[] = {
 static int proc_sctp_do_hmac_alg(const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net,
+				       sctp.sctp_hmac_alg);
 	struct ctl_table tbl;
 	bool changed = false;
 	char *none = "none";

-- 
2.47.1

