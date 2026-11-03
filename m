Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695972;
	b=slBhLaFfZdz3ozzxIkQpkxdsNMvCtAwSaU2czKrPDbBynb9AEy/SD3qNLHd/qUefsnHg
	 oNMQQVKfoZDuJatitU+DdgF+reU3M9YktbVd6dcCyy2VQfUo3gXGtedYU5+YLT07iJBn8
	 LbOf2wiWy+/48Rt6TkYJpMUJXozTSl/X6joEUOMsR9cP11j5V25xxKsuW+2hHaWA5VytV
	 dYypsmKC6WET/TGryR7YtHLIw2yXxO/qJuUfGnR4hMQn1xAfnRcRHn4Lm9iLEp/rRIrA5
	 5kGLAcWulRN8olF9L+XOIGr2Ikn8bzYDoBpW2+UGAm2oB5YERvt2phfLHp7mG+UM87Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lvLN24gtIiDD108HbQ1hU9mpKtt6mQ07/LEzVwndxzA=;
	b=ueh7rgwLwUHQ5vps3wPRnMIXYZHbbftPQTlsu3HTxMH2Ibl2elLDMEOZ2wbV9veWiw5q
	 vgPhGNN+IOo6035JF1Jdu3kr2xJsBhyIV+NFLuOFtB92Xp6xGlsLgP1dhgap26TmA0F9o
	 N7OjskOksJd35T8piCfSL+uOdL2l42PU7pjao2Qo4ctyNTrg1Rm9/Kj/VZ+Z/g3D3ZRLx
	 mrd13gHdnGkoGMgWRm8305GbjIsYzIBmy3IxUmyYXRaOxeUzU46Lz7crMC54/jU/VLK3D
	 af4x53joQ+mj3waYXd9ydRHTUOPhbpwWC/zOPQQr29FsjZkbmXlD+0JvSYTEzK/biKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hYZOyvwe;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B741E606A327
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 08:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B741E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hYZOyvwe
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1a2af4c8d00so5672986c88.0
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 00:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793695971; x=1794300771; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lvLN24gtIiDD108HbQ1hU9mpKtt6mQ07/LEzVwndxzA=;
        b=hYZOyvwe/OszIfGtr2qcAyigMLFdA7ZiZM0tYPUrBqII4G0viQJrsnKyDuElGHR//X
         FqM+ImVVRRl90xdPJHczUzUB5Gr+ZMGIy4zs5YDngODDfpS6i1TSt1rR4IQFI94S+rbS
         ApRygquADhQkxTWwRzLmDG5MGzTf41axYRTT6X29JtLiCo+TrClGA4C9iIMAFIaZLmIz
         4rhEUooBcnoayN4hEJ3l6OB+LacVAGJ+zBf0iOiM2sv2qlATl7+X/sSuefIJSwClUIIs
         gTiznilubLu8i3W2VV0hhgwzNU9lM2vG6mEbbGWUQe/tJYruVsbiDwLWybVEKlho2uYd
         lozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695971; x=1794300771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lvLN24gtIiDD108HbQ1hU9mpKtt6mQ07/LEzVwndxzA=;
        b=YdzxYbMAVINsfIbR6fAxgnx2eqxGSHUs8mh9m6HduDXYw7LRXMOZLnuTq6P/COYO2y
         UV3MxXY8+hjLieJ2EN8d4v0KKkXKS03dTaWawlD0JE0/ifxcu9eTzAtwd+OrIUfBo8By
         nGL559nXndNF1/rTHLuBP4F2GLeG2zcD01NqvaUvZu6szNd7hPwoHLplmUO9eWPANLZU
         oJa7zi0SIdVPCaR6Jm2fNuC/0oil2VYF15oJ8/XUvmYwAEXgFPOggDUj1ZWqx87TVXI3
         0Ml50L5v3M9q4laRj99UKJ01LEvO5QsUqFDDgC1I9PR7gWanO7isn7VgEY/Lo3sMRKwd
         E0+w==
X-Gm-Message-State: APuU4Z/LmEoAPmi/dnnAQzCb6F4UiebSdL4AC0srzGCUxoGgMV5Ba6oG
	+Tj6CwRKgaaqG8N8fM04ggH85bmyVJmrsaNWvw25+Chiv8uFOa9YGwQHAEcfwA==
X-Gm-Gg: AYBFou0Oh61PIlAIb7VycJTqAx8pqIHWZq+q2dntkFgbL8169CrnEBXMXYPXadNdBi1
	5cxb5np5W+lUyhcMSwOZow3ZhrmmacXMNlJ9E3HKoId+6XCCqOUhJhx02aIcQAn7eBO9set9c6Z
	viTWdVXE9EgL0PxhH0sYNHXV533vvYxaaB0KR0JwxX8GgLH4LKeVGLm0YMIbaSnNiWSZQX9HaC9
	QwU8/zeIfFRVdjjTmhohyNwkh7O+fsBQzfk+kn1/NsNs/h8tSnmoYoA+GV1Z5cBlfn+G1dO0z7T
	13f+ydyoOQr1GhSm/MpVDLtQB0rmBkwTOeF5vRIVTEuP1mdrXRkaHg+rsn7gbzW4vgqa9P21Msi
	PJRMxkXj9yZ0mhJlBixhqYGmcXrqkUTTs3AtEOetjmrnGhAGrcgHQUvwD2wVJHFaXDBckMm2O8Y
	ulRKLe/yizAkY8pdKFoC1enWIjmUu4YNrtv944C+JN9sntOrodby/cUxC4sbb8GKQKYeMiTjJeW
	JBIUIg1GFuSzrs/yUbo9uGDoQRtKNXKZ6OFZAhkR9hglhhlcB7a5GNRNwNbNkbZMmEo9OCEnDEM
	uTGDKHtTdawlcDWoT1rSmNHY5JEOCj0BuBbrh068Men9DHlrUqMAM2ydHw8UtdvDSImYCviGiCc
	9mR7VNwHorA7hNJHeNYqdZn4/HdvulZvBxLLIg+rEQkSZk6AfFWCilf07dfPBWRjqz/tRauTBwr
	o4J4YjJ9Ul6jFXClh6ZyI=
X-Received: by 2002:a05:7301:3d06:b0:358:eccb:af7c with SMTP id 5a478bee46e88-36a42404840mr28348368eec.33.1793695970615;
        Tue, 03 Nov 2026 00:52:50 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm53065635eec.25.2026.11.03.00.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:52:50 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v15 1/7] selftests: mptcp: connect: retry write() on EAGAIN
Date: Tue,  3 Nov 2026 08:52:38 +0000
Message-Id: <20261103085244.23064-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103085244.23064-1-anilkaushikwireless@gmail.com>
References: <20261103085244.23064-1-anilkaushikwireless@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mptcp_connect treats any write() error as fatal. But write() can fail
with EAGAIN even after poll() said the socket was writable: the MPTCP
send buffer shrinks when a subflow is closed.

The tool then exits and the transfer fails on both sides. Instead, go
back to poll() and wait for more space. If a poll timeout is set, still
fail after as many 1 ms retries as the timeout in ms: poll() does not
check every cause of EAGAIN.

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v13:
     - say how many retries are done with a poll timeout
    v6:
     - the comment says the limit only applies with a poll timeout (netdev
       Sashiko)
    v5:
     - no change
    v4:
     - count the EAGAIN retries, not ms (Sashiko)
     - no limit when there is no poll timeout, -t 0 (Sashiko)
    v3:
     - do not wait forever on EAGAIN (Sashiko)
     - wrap lines over 80 columns
    v2:
     - Fixes tag

 .../selftests/net/mptcp/mptcp_connect.c        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 178d98d91fea..49017d00ab69 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -638,6 +638,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 		.events = POLLIN | POLLOUT,
 	};
 	unsigned int total_wlen = 0, total_rlen = 0;
+	int eagain_cnt = 0;
 
 	set_nonblock(peerfd, true);
 
@@ -711,6 +712,22 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 
 				bw = do_rnd_write(peerfd, winfo->buf + winfo->off, winfo->len);
 				if (bw < 0) {
+					/* POLLOUT does not guarantee that
+					 * the next write will not block:
+					 * the MPTCP send buffer can shrink
+					 * in between, e.g. when a subflow
+					 * is closed. Wait for more space,
+					 * but not forever if a poll timeout
+					 * is set: poll() does not check
+					 * every cause of EAGAIN.
+					 */
+					if (errno == EAGAIN &&
+					    (poll_timeout < 0 ||
+					     ++eagain_cnt <= poll_timeout)) {
+						usleep(1000);
+						continue;
+					}
+
 					/* expected reset, continue to read */
 					if (cfg_rcv_trunc &&
 					    (errno == ECONNRESET ||
@@ -723,6 +740,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 					return 111;
 				}
 
+				eagain_cnt = 0;
 				winfo->off += bw;
 				winfo->len -= bw;
 				total_wlen += bw;
-- 
2.25.1

