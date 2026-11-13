Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599700;
	b=2+eyMIU5dgqhmswRBudg/XzNpKaRxbuWitcLVcT7uESfABFDWh0LlIvx5WmiCLbHH68P
	 rxmTe8pV9gcKBKZcma1iXRh0O2VGLZs6UqZr4tCgcc8Ub0gglpA5LllztlnkG80FWghD9
	 Wh74GHJNoNTqZonr9Zqf6YOZPh+LC/UKSfuaz6ap2pSfqQAZs626WJEQY7sTfB9COCGxi
	 qeXxO2FDaYbvatoAeNgw8MesUKL2JccnbANChnrHX+g+3mUjtG6vGqGvQ+F7jv2PPpdyZ
	 dz8FY/fNxDK/MzQcW4EChcQJIO4Y/4DflKc5VCklsHhSS9Va3Lbki/7H5Y72E41j2Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599700;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+YKFPhGuuIMzmC7OJ6WZULZD5l9ml7MWyBYCLPkG6sw=;
	b=nc4qmr23dL781nMnj8exsH2rPPHOWbJsfdX6JolvWak6KIQqR3FWldHV3sTNLEiSzacC
	 ao4kstUhyuOgOAN9oQDX2VJTGl1xBnG/hDtncVdOIocEiK2SNBYtv8tbg+b1I4hUxYDxW
	 1zCWF7zOKygqnb5ShG9r90NDEZEeaZn6efPh/yVVjujCVORkK+OgETeQJeUKxQEUO0As8
	 wFiS3JuftWfSz7umPaxoPnZNe9Byz4z/4N4QgCnpDOwU/re202nhEu9kF+cHXDMhdEvcb
	 7gUJEswAEZjpMg0qJlSJKF+EbNc7IAXzf08qdYTU3PVdXtZwEGA7ShIa7nQj7jNGtbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mJxil700;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC8606BCEF
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mJxil700
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235881F000C5;
	Fri, 13 Nov 2026 19:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599700;
	bh=+YKFPhGuuIMzmC7OJ6WZULZD5l9ml7MWyBYCLPkG6sw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mJxil700nab9oj2eghY1rMx7UTxfJeb6D6wH3jNoe6/iZ0xcL8VmggXIXQpQEspAb
	 TDzaEGlic1P9pA93nsNqTG4sdCmPi8FhLQWm4vqPftJjaeKA3H8grNc5Xg4BORTRQy
	 eqWVo8o9rN/OCP/9UxfJrOHL94Oz5v7RqauMqAH3WgaDubZGmSb/WWBYUBbGsJbpsU
	 MMkiNqGvnjEFDn0G4EW+B2vZwidWmDoQv3UiZ2yt3brtLdH4ZAcczcFsYkTZDaG5Tw
	 0cBkHwA9Uh6blhe21YXE7IOIYRLirhgbQxBiP1U21wmZgtU++PxCByHsfuCpdWffgW
	 tDrRbFEinI4kA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:54:10 +0100
Subject: [PATCH mptcp-net 32/34] mptcp: fix dummy mapping of overlapping
 segments
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-32-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3818; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0QRk4oktO2Az9k/hwN8yJquspyusBd9NOF1vxmLcViM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z70si93hs9BGyWPZzj0VbRIvImyfmDZ75v4OKHh4S
 nXZtt2mHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABfJY/jD/2f2wn+v1Bt0/rmr
 zDUzFn5wqz3p9UrHKuOos289Qw6WMPyzur7qkZzm5A0yNeXnxEW+b67T3lLXsHG7z/vW9nU7pDh
 YAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

An MPTCP socket that has fallen back to TCP can silently lose received
data if a segment partly overlaps data received earlier, and recv() then
blocks, returning neither later data nor end of file.

After a fallback, subflow_check_data_avail() makes up a dummy mapping
for the skb at the head of the subflow's receive queue, in which map_seq
and map_subflow_seq must describe the same byte. But since commit
2834f8edd74d ("mptcp: cleanup fallback dummy mapping generation"), it
computes map_seq from the first byte of the skb, while map_subflow_seq
is still computed from copied_seq, the next unread byte.
mptcp_subflow_get_mapped_dsn() then returns the data sequence number
(DSN) of the first byte of the skb, instead of the one of copied_seq.

These two bytes differ for a segment that starts before rcv_nxt and ends
after it, since TCP does not trim it. mptcp_init_skb() then gives the
new bytes of this skb a DSN that is too low, and __mptcp_move_skb()
skips some of them as old data, leaving a hole in the stream:

    bytes 0 to 999 are received, the skb holds bytes 900 to 1499
      byte 1000 gets the DSN of byte 900: too low by the 100 old bytes
        that is 100 below ack_seq, the next DSN that MPTCP expects
          __mptcp_move_skb() skips bytes 1000 to 1099 as old data
            ack_seq is the DSN of byte 1400, copied_seq is byte 1500
              later data starts at the DSN of byte 1500: out of order
                the TCP FIN becomes a dummy DATA_FIN after the last byte
                  ack_seq does not reach it, so there is no end of file

Fix this by computing map_subflow_seq from the first byte of the skb as
well: mptcp_subflow_get_mapped_dsn() then returns the DSN of copied_seq.

Chris Mason sent the same fix in private, and found this issue with the
help of an LLM. It has been reproduced in a VM, with the reproducer he
shared, and with a new Packetdrill test: after a fallback to TCP, a
segment overlapping data already received is injected. Without this
patch, the new bytes at the beginning of this segment were lost, and the
connection stalled, with no end of file:

  reader   30.64: conn 1 BREAK: at my offset 1000 the bytes claim offset 1100: A GAP OF 100 BYTES
  reader   30.64: READ-TOTAL conn 1 outcome iii-gap-or-repeat bytes 1400 of 2500 [...]
  [...] end: hang: no data and no end of file for 30 s

And with the Packetdrill test:

  dss_fallback_overlap_client.pkt:24: runtime error in read call: Expected result 2500 but got 1400 with errno 115 (Operation now in progress)

Fixes: 2834f8edd74d ("mptcp: cleanup fallback dummy mapping generation")
Link: https://lore.kernel.org/4c48d016490d43b6892c622cbae858b48f176cff.1794304840.git.tanggeliang@kylinos.cn [1]
Co-developed-by: Chris Mason <mason@kernel.org>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
[ Combine the commit messages of Geliang's [1] and Chris's versions.
  Commit message: how the issue was found, and its symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 543368cfc890..64e8f5c36415 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1526,7 +1526,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	skb = skb_peek(&ssk->sk_receive_queue);
 	subflow->map_valid = 1;
 	subflow->map_data_len = skb->len;
-	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
+	subflow->map_subflow_seq = TCP_SKB_CB(skb)->seq - subflow->ssn_offset;
 	subflow->map_seq = __mptcp_expand_seq(subflow->map_seq,
 					      subflow->iasn +
 					      TCP_SKB_CB(skb)->seq -

-- 
2.55.0

