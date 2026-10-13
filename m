Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9924718C3
	for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791860223; cv=none; b=MDj7mxIHKpzwRqcA4azPsCPB01qGnnNs7hzFNkJKthDJIl2uC/d8Tn1N/27vChK86jY0exuobyz9DnN/coNfVtjAmXH3ct8QT1Ot1cSheaRqqc+t8GAbl71ylNTOXUACJy+JrvNB1kRq6HnPaXuN5K5Z7xTbAChpsKwXwi2BGy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791860223; c=relaxed/simple;
	bh=8klJFQEfncyrGZSb2BvhykrVOlGtsm7cwOip8GeuFek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aAtnz5ixBjQnkh+8kS6xTcgDQ6fs4xu0MPZLZGgh1xRV4wcGCFF1adjO6au2CXqy7xzcNVKvIUaOJ3iygicFujme0XoxLMZwfB5cDuV9Y6O3o7DalFgFC/seX8iM5TdX5iPD6MbUMWPAusIQzgE73kTwn2RsfkB7zLAEasbxjkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crMjrgAQ; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crMjrgAQ"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-354ba08cfd1so4347511eec.1
        for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 19:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791860220; x=1792465020; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ys87AntN7Uw3Q0+x31QQlxYQ6DKsyy+3bMbSvQ61N9U=;
        b=crMjrgAQjm8OIy05CgPdGtXRjHv4q55WNAtObOGgneN7t3x05Hq8vr81G2Bk1nYhj2
         dBf3Q5ei9sdNmkLjdZyPsaBLrFLdUbt7l3kYkTka0vhtFCM6jpPahsA8kE86ASNcUV+u
         arZxo89V2uKbjJ1uMhuckByiomGnM75rFsbSiexB6QevB8PW9n01UWe768OHr9usdu95
         jRDVxaEbP0cTNWXdLerpo9qa933vQstVkN6VajxfobMIgx+tUHrzVZ2mwliU9ohbl/7k
         BgNsXRmJABcaEkVaWuYXfn1NBfGtTxWJ+uHFfZtPUXEDtwMQp3OBR1Q4i/GIo7Vdlgwq
         OXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791860220; x=1792465020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ys87AntN7Uw3Q0+x31QQlxYQ6DKsyy+3bMbSvQ61N9U=;
        b=guIq+ep3EHy/eYGWj500wM8W5o7aps2fEpgvI5bqAFDFXwnIrbfe+DeerthehxjHe6
         lb/WgT8/vr4ZMfcKk0PJUwtCHBQIgKX6tSNOCvZcoyhoI6oz+WzjB8W2CmYygq8o0EoA
         8N0GwVkfSxPZ0lHCC8vqDxEfgyjmgp8G0TNQ80r90wJhzCUQ0bxhvovQ/zgkQOFxfEVC
         HNpFEWszF52S4ij6E0WcjEsVsndWgW9i5UCVfdLjWHYUiU3KBHzykS6EQ/+/2alPhtmh
         XNITrmiTRKfY6abwCMuHVsaEGFmDtjIUxHke7+EGcNojIb2BllYsTl02Q+UOJRMFNAtg
         tn/A==
X-Gm-Message-State: AFq9FYKA+pHHfkmOyULi+sKPFYMZspkTS/AQlkkF4ERd+M5Cv/X1uPSN
	4W+AfjvZ1BEvva5FiVmJ1RJLrRizV3rx0NTH63d374MWh49zTbsr3/urWa+WSw==
X-Gm-Gg: AYBFou3/hnNIot55lN/M0447dj3XpM7O9B+wyS40DSKzb8oBS11ji2GAV507FhpyDDo
	oUAfpyG0MQQ4JiZQxD/BxeqoLhCaLnT/UCZR6KkXOs+C74V0Z1YG9jHg51tYCGRSx44AgtTe+Ja
	Z+0wuFmlmZ90Fuzt2kgqh0rP1rvCGon4FSzA3Ay6P0DvukP9AGNhwq07EO52+2AilLXW8qX6+hH
	B2pi5A6cXSmLd1H+ttngNDGlcBy3AGLzv/Osi7wlNI+qhCJ9royArC/Yfx/X8fMImvIUinmTKLl
	JRqnlBtPeUt9oGuHswPrVincX4A3f6lwJaxg/aWwiN5xIKBR2FVRlTxY19XdwgvA/Q7WebLPE+H
	Mn93oGnNjcigz5d3om/eIZt5OmCV4m2c6iNNXA38mCHr3P7mwO49JXZYiKON5wKpjsKNAgTy6Vw
	pQqYSrNj5EijQVGZ3L8gIGaRYGSWV8o8LKoCEKtvZtdn+JhxYmks9gCcROJ/HNH9ThSExrlUHtv
	lXCBm4ttO7q9Im0MOdfTjj2DE1p+1iqShZEO78zJmjdl4A1obxLpq5XIZQgKrRb5qElTFRtm+iq
	LSg8KH2m9C5/zV3SVDvCQJXfJtfdlKhNTHCUAfWMnnY=
X-Received: by 2002:a05:693c:88dc:20b0:35b:c1d2:eac1 with SMTP id 5a478bee46e88-35bc1d2f514mr3167921eec.39.1791860219857;
        Mon, 12 Oct 2026 19:56:59 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2954bsm39890217eec.26.2026.10.12.19.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 19:56:59 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [RFC PATCH mptcp-next v2 1/3] selftests: mptcp: connect: retry write() on EAGAIN
Date: Tue, 13 Oct 2026 02:56:51 +0000
Message-Id: <20261013025653.523755-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261013025653.523755-1-anilkaushikwireless@gmail.com>
References: <20261013025653.523755-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mptcp_connect treats any write() error as fatal. But write() can fail
with EAGAIN even after poll() said the socket was writable: the MPTCP
send buffer shrinks when a subflow is closed.

The tool then exits and the transfer fails on both sides. Instead, go
back to poll() and wait for more space.

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 178d98d91fea..5bcebc721864 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -711,6 +711,14 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 
 				bw = do_rnd_write(peerfd, winfo->buf + winfo->off, winfo->len);
 				if (bw < 0) {
+					/* POLLOUT does not guarantee the next write
+					 * will not block: the MPTCP send buffer can
+					 * shrink in between, e.g. when a subflow is
+					 * closed. Wait for more space.
+					 */
+					if (errno == EAGAIN)
+						continue;
+
 					/* expected reset, continue to read */
 					if (cfg_rcv_trunc &&
 					    (errno == ECONNRESET ||
-- 
2.25.1

