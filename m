Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809744;
	b=oT8ZDofwHl8o5Q3IPMQd0DD1OLFf7oD8R2x7HLwH98HqGPbpHEh49aEwSqjBpEYnNimU
	 j6nyVV8Z9VZCa+VY+7MmkjNxk3AoTg1KrFHeoVjm1b/4+j2RvdbM6Eg3qXn2id8Jg9Gbg
	 3ntbLjXNpJtN2cJbba67RJbPweJHKTo4nLxae6Lybm2QsF7uDw9VvMFgRo7k7/yYgTQ2z
	 o08X9Nyfoe6z+iSaAdcmTuvrMXFhcEdakDQJqEoOE2k7gk6er0GZZkx19ids6K9PQCT6w
	 2lCf7D06cQzG7iSqFrtWe2Rnkt44QJ3yMkS8OFY+lProTVTeV6J8WXuJv7IKjWX441Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809744;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=cWsZxO416AkQX9NrlpNX4H5bmk2amRmpf+pNUdR8wio=;
	b=KfuliM32p7Re9dUlEXOImHLKrtq9/Jl0+HxuyP/vUpUeu2qAKWb0lMA/60ljYDSRI+kR
	 nuF2qdy8KrBSIHXqQEsZxFcM3qcbUjgR6u41Bve+vlR0eyUA9jFp5QRBFJeECx2R6opFh
	 kw1yvYtTpWZs1NPC9qOopXdQ/hlGCGR0R8jPUsqDwC1PlX/kWM4S1dyxtmH8C5V/61Hch
	 nV/gs7Btyh8NRHTCiVuZNJHI1sqjilG0C3tfxl+L6gAiigWI7YsIap7oT5yoxUzax/O+X
	 ET+hs/suhLzBJyVoZHiIGkAOfBLuMHW7RG4liaX3o+JvHaKGXIiUWCkWQRuBJ9FoycA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKHG7Ye4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0991E606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKHG7Ye4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5FC1F0089B;
	Fri, 27 Nov 2026 20:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809743;
	bh=cWsZxO416AkQX9NrlpNX4H5bmk2amRmpf+pNUdR8wio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bKHG7Ye4jDW/D3Tjg8ZTkE3XzXzA+R0M+ooZ2jZEJRqZMpkY/ZhzBa69ahbNmf3Qw
	 6GCDOKjyuBRbKUodBWPsIqlBxL3h34nvMO5rZV873pVvae2pz3Lzzruse7pqGA9vSn
	 Y/T3193TG9hDA5N0eEErlIwp8N5djOHTvBM82STvNUqyzFZ+IVNA6SWlgvhCFLwq8O
	 8igTpUkCSMdB2RCgovFIlUk2uHbtySmyZKt4xMSiL9lhviDmBHUQkNlzzKZ+0JhgH1
	 Peto8r1B3JUO7t1g5LT5EEaJiBUdLKx5U9DEwkbFdDn67ajLOYTOo0XBsa+Z16rY91
	 3RGuGvzwHZ3ew==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 27 Nov 2026 21:01:42 +0100
Subject: [PATCH mptcp-next mptcp-net v4 18/20] mptcp: trace: name all the
 mapping statuses
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-mptcp-cmason-fixes-v4-18-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1011; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=o1eHbnlIJRAr2NhgkHR7E8slRClnBYN7lIBNdfmM2RI=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGsJ4bejVciiU5zH+yt9aWO5JaNN2vNDF4KfeAXHB50hIvUNr
 Yh1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmsJ4bcACgkQfCLwwvNHCpdnygEAtFEs
 wk6iyNuVf4SiAsTDackPXw9ShRCiGNhipO1DcZkBAIxBMmi696Hq+BN1MrDhRVwtGg5Tyw/s4kU
 n1bIsTloE
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The subflow_check_data_avail tracepoint prints the status returned by
get_mapping_status() with its name, except for MAPPING_BAD_CSUM and
MAPPING_NODSS, added later: they were printed as numbers.

This has been found by an AI code review agent (Clashiko), while
reviewing a patch adding another status.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3: new, for an issue spotted by Clashiko
---
 include/trace/events/mptcp.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index bd2b4a8fc271..c181fdfcecf0 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -19,7 +19,9 @@
 		{ 1, "MAPPING_INVALID" },				\
 		{ 2, "MAPPING_EMPTY" },					\
 		{ 3, "MAPPING_DATA_FIN" },				\
-		{ 4, "MAPPING_DUMMY" })
+		{ 4, "MAPPING_DUMMY" },					\
+		{ 5, "MAPPING_BAD_CSUM" },				\
+		{ 6, "MAPPING_NODSS" })
 
 TRACE_EVENT(mptcp_subflow_get_send,
 

-- 
2.55.0

