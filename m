Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793517659;
	b=cah/z0Av6h4LVcVwdBtMgE5cfjT1+Lc0YAoM6gWkEhJvOlcLAjRCD51N1V3B6W9rFHSJ
	 jehuv/IxzWdZCW342hsmwRQo8qYBKPfBipr4gCiWuIVt0aEBhq/2K3N9ln26wLCZoEeda
	 7Et8NhVaDo9LsW+X8qrb18FRrrzvbVmwFIIaqFPpVkT04RIiZuOeQ/b8Jc68DaszPHWFG
	 x8Szfz8KB7lyneuzAva//8OCrsmvF3MCVKnb25VKEpa3p5kHS6bh2zucCWmsDAXh+GnLn
	 Z6FphzCpjacSWx2ATk1IMXfCovCCeWgrmPhuSG1WGgJPLiTcYFtX4dWdft2V8kcYMpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793517659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lvLN24gtIiDD108HbQ1hU9mpKtt6mQ07/LEzVwndxzA=;
	b=n+K3Bn93nRLpw3MBO7hqQsZHybMW2WL2og9IFA14gCqUCvHHSqUTUCNMCVa64HaFAV66
	 G+qr8vH8BzbadApRia/qx3EXNHTRdInXWdTAlN/GvJf1JJKa0Rpole5ewbu7Qzv0mzmCU
	 DqgbXExC8RkIK41OisJDwyqFZQxxmV9IdagOvtfarRSoSIQ4OoANuAERgg9314xPmmYVE
	 xDe/fGuw1uZ9SdIzWbcQr1S6Fx9LnNZQDCZAh0zN6wHM9ndUq364zBb271fxtAOqK9rZI
	 fzk6EUXqzF2wITf22n0+s/haMQs2kMzZ6t39oFdJdzzV3TNqLzbJiR4X1LfYo9U8OYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=deyrGIRt;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3E3606A325
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 07:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F3E3606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=deyrGIRt
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3514b90bb89so4008191eec.1
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 00:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793517658; x=1794122458; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lvLN24gtIiDD108HbQ1hU9mpKtt6mQ07/LEzVwndxzA=;
        b=deyrGIRtwoYHYvICC/6ZfjlvRi7JI9LQ3pUvZIeOoYdO57W+luFqGcqnRjLzx68jXY
         ucWpC+lQ9BEaSN0x47AbGZy6Uhl1lpUmV1l894/OzHNNV/dmIuvXSk0UpqOYvXjYhS8c
         Ypt3ELbEV62OJiej+h1vxi9OKsMGCpiKjGD0S49EXaAKyqT0/HcsA6tMTpovg0OZmYL8
         O+ETWM7jrWREo/Tbc+1Y/uLTD4hUAlohmGtYNSYvoXLYUgHO8I6UYftu9R6ayqcx/Yis
         ouU1gAlXsuU5IHaW5cfhaQk1cxPsnRz8kgTEVuO5oWFhTNkCUDF2vDZ/Hh/XhrgsGT4C
         eR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793517658; x=1794122458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lvLN24gtIiDD108HbQ1hU9mpKtt6mQ07/LEzVwndxzA=;
        b=jVde6GE8HDsfTNw0fJFmzVeQbC8wb3zebhRHTVmzflq2TlQw9JGMzc4TCcFL2uniSF
         c22thrKGDieAGOxyA5UV5sBoZreZuHref1EVBOTfT5tRgfZU7zaGAIr3f3wn+GVLPqfG
         1L/NmNtJLQBIUhSiDUqSfsWLdPIhCJ+EL/yOwf2Eqy++z9QFzrjO+663yLRUibpSkobz
         2kmhYk6QzUmxsAoVs44/U5oQjyzx4eyxKu6dofaV0ulI5YKtaadFuFQ4UlxKPKpqLjvn
         D/ycPKdM2j3Sbe0r6SfNP65iRF5QANt9csjifMRdGS+m/R3ZxlrtOvPM/KAMPl9fB4JX
         Mb8g==
X-Gm-Message-State: AFq9FYKLvHGnxZ5YkcDo3n5HaD6foEUsU9PFVqKIT21SHvMNk9dfg3XC
	EkHb4tDJqNzeb/Fcx5QErPL8iJcmGW/x3K9HD2sU3FXfKS9lOFAAoejB1r/mTQ==
X-Gm-Gg: AYBFou3MHZB0bK42qnT3V7EX/4e+TH3J4CyWYrYOOgYNuTcYjktJ8hmV4kDYWW6jAMm
	NUCowP31Wxxy9wa/VyTHsRBfU7NLgnV2Qls6fArdAQ6eAVKJV5jERiPsgw/HvJJRKMeWPtmpROt
	ijoOQ9X4ac0+oXYAxSUN3wk24O3vsL74oGs6FEOWExGIy/q0psbTZ3DCwKgUICJFThLf+quWDhf
	KcotpiiDPiNIpnzk3kTeN8uUZeYEYK0RJTNLn33E3uaizL6pT3H7xZQP2CgnPQnzx+xM+W880Xi
	yx/C7mmZVSSrEG7gRrpHLwaFs6lWCcJymSN9+Z2Sdits386Y43gsHm04usb8L7Yx7LDIlkLzuOB
	HJijAYlMK8SUlz1XFA/88cZ/j7ElNZif8SPov2gXfSdY2w51sU87RftEu9SUQJuBhZFRji/S+U5
	JGcx1PkQZHi38CIe5eRr2j3NHbSxAKiZJMAXwq+CYTLfvGQIj17bU6jOr+8czkxdw+GAViAOOXK
	exkKmdTqodT0nEPOYvyg0TNHvfG6cKYfP4dRBdB7hVEUuluSAfPK+u+Wjse0m3BFS7UBOmze1Rf
	dhYxZ4jGrX0YiAIl4LzjB6pUavHHLjtCAMLN+krtfwQmrmWdZyrbRwiAFoosl881E17D57F9H0j
	JAbDG1uOyABy374N+YBJ6Ii4blV2lsj3apLkxIO0aHq2lTLUG+p10d4FnwSnSIhXcH5mkfapXbw
	==
X-Received: by 2002:a05:7022:5e09:b0:1a4:3169:cb with SMTP id a92af1059eb24-1ac5cfe5610mr9557267c88.17.1793517657572;
        Sun, 01 Nov 2026 00:20:57 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm29851495c88.6.2026.11.01.00.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 00:20:57 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v14 1/6] selftests: mptcp: connect: retry write() on EAGAIN
Date: Sun,  1 Nov 2026 07:20:46 +0000
Message-Id: <20261101072051.3853492-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261101072051.3853492-1-anilkaushikwireless@gmail.com>
References: <20261101072051.3853492-1-anilkaushikwireless@gmail.com>
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

