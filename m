Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB5025B09A
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791456598; cv=none; b=EG5Ca8xEb1LYg0H1xLqlup1egBoUrDAWRk4fARPWOseeRmag20zZi8wus2w97BNkYdAvQ0sJBbafVU8iw57CsbgUNkd4ocavLqnD/QSP4woDYOgz+R6aEBRy0CC7iZfb/LdxHhxTGMwmNUkD72r34tSERGcgXjozbeM1RRKu+MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791456598; c=relaxed/simple;
	bh=ZVqPaMj9OBKmp7Fn9d0f7hf6S0qpLN+SZH0ehciTrYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cenjHBFPVJm0vaQbxWbJfK4bUOlnYUNbpLCRXnkx9zV/WhxoO1SLJbCktJlXbj1r6zXFONSPvuFCbW4u61xySK7HDDQ9wQPZgtRPWRMcDMl5n6yUjmwB33lI5DJN9ViNcEvNoSmqroN8bvybpf874w5ptC5wd5eIXYIeHcDuFIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZBGu1sw; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZBGu1sw"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15354aa70e8so1219416c88.1
        for <mptcp@lists.linux.dev>; Thu, 08 Oct 2026 03:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456596; x=1792061396; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JcYKjibBDVYYKXsTs/kEMk8DPe0X6aXUqJTngq/c/Sk=;
        b=RZBGu1swhT5rYUKZSIIg8u7GXCQCwF+kCkqecLKGRB88yZDlORpWa69suYuW/OL4Q2
         0fSzai3khDBQ5afnPfzyIam1FhtisrpABf6sFiQuBu1f7r0vj1K16MqxEdmneR2rYZj0
         5fdrmJzE3t0w+h6N6zSOMGfyvLu5GPmvnytf+IUAyTkDEnRlNdKm1rjqYkv8Lks0dtXu
         VuscZwE/6/qdWSRwDpoxlF2FGvli0mgy8IHi2PuK1H80nEhI/6AoQGxKTbtaz3xB/JEX
         anpz1FvGEWMKnhXx51kxzdGxEbCj77lAf8ALyiuiyuWAP+q84FrYYWSkNmG5VbO9hGKQ
         LRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456596; x=1792061396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JcYKjibBDVYYKXsTs/kEMk8DPe0X6aXUqJTngq/c/Sk=;
        b=aarQjlfFp09R53m30kl5rrnJORE8r+K1ChXxs+CkmjPvrM0Cjkz1r+s0rIYumUKSwE
         +PR2vbd9BntteJEvwo3vMda03Q2MzvIc9bH8USnWP/62/AH+wMHzhXnmqYdl3su61uhx
         SROpF/xqHDAr+wiD72LXZRE1QjV7OWkrbQKkus1xA7mIKvtHy9l8v916IQdG5QpEijec
         48jBmyPS9iqTEEG7Odz1p6vUYYUmGUb4a1C4BIVW2D5DgbqmZ5NL+KyIBJ+QBH3rUjuw
         LS9D6ZMy9j7zsIo8zInd459mstuVPdnHFSNY21NjeDLne6+Y0WkRKfEqz3zhOqIXNwLe
         NWqQ==
X-Forwarded-Encrypted: i=1; AKwUvBxvoBJ6sObezRrF5IGfrYeuMTmn+wU6zNp9ZrPgDokQBTK97ov786aA9doU5gKkUKbMIrPxmw==@lists.linux.dev
X-Gm-Message-State: AFuF++nbFu2czh7KTC/HPRwvkhwR3dew4ozpss1wGcRFLO8VaIZhtBb9
	Rmv3oymgc6PShih1O/4OUzekG/BfpNj0kvaVB9YaSotRFdTrzhTXdwMDAFCY2SN3x9xppw==
X-Gm-Gg: AYBFou0NtFpMDxNFTk2sPbiCDjH8+I4lW+ZB4UyDj+p5/+1pyhSQj3ny39/WTvKhafl
	HBew78mq+s3SRl2VOib3PRNIiSnQ7K5UGtog3q0NH2Mst/3asg1o2MQbVNm76hI9MuaHdno0HEj
	MqE6SUMa0XvpQIo2TJKBZZOO7zYhzhm/bUpmaKvUq2/muMnmE0xW1nTVqjU9jY1ojkdCksPsB1g
	xgNKnPVkge0zDmLubsltzz4kgu1vH4C5bvHmcwTPKsJoKEWbwgmtmmUWVzkSY99e2IEiAa1qbSH
	/sh1SrgEhZqN79n9gX2u+O/tWS7teDTzP4EJ4197ssvzVo12F9+7Yp7R+qHYRCwHA+Q3SNu+8BL
	ufNMkgT3OwTXSYakbS8MDrWqhp+Eq+jQY6SkvLSinG9A+JbsJxqCuI7uWZDw8Z7f6Jz+M4krhy3
	mlmlqgb12GSdN8Zd52hPdWFoAtrgJEBuCBICWXfQkeHB9Ad18Mt/r2zz8CbKPkjT4uPCeotVfEu
	YeVF30Y
X-Received: by 2002:a05:7023:a8a:b0:14d:baf5:c40f with SMTP id a92af1059eb24-16205db7867mr7233939c88.14.1791456595585;
        Thu, 08 Oct 2026 03:49:55 -0700 (PDT)
Received: from ramesh.. ([124.123.89.203])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1616b01c2b4sm12797756c88.20.2026.10.08.03.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:49:55 -0700 (PDT)
From: T S Rameshkumar <rameshsv06@gmail.com>
X-Google-Original-From: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
To: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	petar.sakic@ink.fish,
	T S Rameshkumar <rameshkumar.t@phytecembedded.in>
Subject: [PATCH v3] mptcp: push queued data on passive TFO subflows becoming established
Date: Thu,  8 Oct 2026 16:18:40 +0530
Message-Id: <20261008104840.131986-1-rameshkumar.t@phytecembedded.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With TCP Fast Open on an MPTCP listener, if the server application
writes data while the passive subflow is still in SYN_RECV (after
consuming the client's SYN data but before the MP_CAPABLE third ACK
arrives), __mptcp_subflow_active() refuses transmission and the data
is queued into the msk write queue.

When the MPC third ACK arrives, the subflow transitions to
TCP_ESTABLISHED and is marked fully established in
check_fully_established(), but because the third ACK carries no
DSS data, the queued bytes remain stranded until the peer sends
more data.

Fix this in check_fully_established() by checking if the subflow
was doing passive TFO (subflow->is_mptfo). Under mptcp_data_lock(),
flush queued bytes via __mptcp_check_push() and clear is_mptfo.

Reported-by: Petar Sakic <petar.sakic@ink.fish>
Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com/
Fixes: fb7084501a61 ("mptcp: add support for TCP_FASTOPEN sockopt")
Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
---
v2 -> v3:
 - Move the push and is_mptfo reset directly into check_fully_established()
   under mptcp_data_lock(), avoiding any potential race in subflow_state_change()
   which could clear is_mptfo before check_fully_established() processes the 3rd ACK.
v1 -> v2:
 - Use __mptcp_check_push() under mptcp_data_lock() instead of mptcp_push_pending().

 net/mptcp/options.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ce0de02f5..b865ee6af 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1042,6 +1042,15 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 
 	mptcp_data_lock((struct sock *)msk);
 	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
+	/* Passive TFO: the application may have written data while the
+	 * subflow was still in SYN_RECV; __mptcp_subflow_active() refused
+	 * it then and nothing else spools the msk write queue when the
+	 * MPC third ack (no DSS) arrives. Push it now.
+	 */
+	if (subflow->is_mptfo) {
+		subflow->is_mptfo = 0;
+		__mptcp_check_push((struct sock *)msk, ssk);
+	}
 	mptcp_data_unlock((struct sock *)msk);
 
 check_notify:
-- 
2.34.1

