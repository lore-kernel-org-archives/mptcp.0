Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793166111;
	b=XSa44DBlzR3Q8iqpcHIXzT1CfvTdt2jTfbySRvEuinQqJG6sTHJ8D5Z087yQz6cmg7zE
	 fmtz9pvTmSfCUSzjw0MCPKfPsGeErffisNmdtMr3XHSK1dgWYxUeGswse6mpikMuoTFYa
	 dG73KGtNYbsbEXyMdrseLc1BWALCHjjEn1vdPDncJYk+m6aETVSe/5+flldL+V3zMvHe5
	 D7KQo2vexpbkb/SyPUMNYJFitJ3LXGaeBgnmxInyJcn5ninZIpX1UJrVHW7Yd6h5zUtAs
	 IJYmbJCUP8nnSXCXs4Fb615SAjqmb+b4HhXYo8cB7dXQ9YrXxg0VAquSdEpIi+cl3jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793166111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XwlldahLZl6u6KBDX9l7n8vOmnvTZvhZdUFA/a8ErDA=;
	b=wZ5yN6zBQn1os5Hj4uqMIGz47Iw7wSYJ1oB4F1LfHlIPG27LOZIXjCeeVa/QZzeoTSbB
	 V0OERd/2Rz9p7z/MA/NOgpY3YZEntUblMxkSoK9f3ubGy67u2RE30Akei9bbz0yfIq7G7
	 1ODJVS9Dp5++j2K0ygu5xBaEVY+iyOMPZZ2BP0UpEW4pMUv89YpVAbWmkwpxhH2N/kNLR
	 jk7i/TGmaCyriEWBF+TMJRgDa4IrXlAmNE8mvtOwmDsDwTMNEXkK0EicdeQMxMHt9tXEv
	 gmKHtsNwR29WDkuJNoX98oyqQk7l32TOgf6kj582Vi/syfnnWn7WzkFLOhssrxD1DKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JN8zjv2K;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE166606A31A
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 05:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE166606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JN8zjv2K
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a121bb8c2so786827eec.0
        for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 22:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793166110; x=1793770910; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XwlldahLZl6u6KBDX9l7n8vOmnvTZvhZdUFA/a8ErDA=;
        b=JN8zjv2KLs/7DVad0K/a5RReIyD2LSA67YZUrffvM+kc0LsxPSXaoR3gM5lghHLNd7
         Ob4dDQaD38NR+dR3deDTDmqHYbOAqETykQUMSH1K4vhv6C+IClghHdfiogSX8xWj3qSr
         j+HMHxlr0iqEcwpCtHNqzNHgpolZbc5E3QRLRhxl/l3+JAAmpNg2GYSG3fD2zP9vz1SJ
         HnTVoKrJ/LihV8YP4EgdP6jhriTHX0EqgohWNrCvyaX4qrxyoTIYjzWhhh27J2U0eKuZ
         UVvQNJvbfS+ECfR4QiXUhJ/h2nrHsI2/7Ku5/ookhn44D87sLNXqDAv4nIgvdt3+7rMz
         8Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793166110; x=1793770910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XwlldahLZl6u6KBDX9l7n8vOmnvTZvhZdUFA/a8ErDA=;
        b=XXWyYJWYhHMI4Izh9QJjS11PsGErSawSvIkjWNA+yiULyupTZhl7mpbZ0rRjU2Aca8
         N80fEmwC+HLDok4Ilm1x9/LXy7XQ8M79jG+nU7yOmOOcLPJq5Rsf4jVBNXmwhQ5lqMOE
         mPlf+17hf677h+PqQGnWc8pDccpaNSKRxfjOxZmwGfon3nSH4Jyzc2F0z6cLaxMUD6uP
         Fi96baJ+QAaGg0CHQgyufUI1UtzKfGE0FsHcwY2eWdsfXBOCxUBGNvNcaw/gGvS0xnex
         rZ37O6qSSWdrmWNdkEfmU3n2Kyn4qy1X9xP61r9/xmWqDye5AY9uqRTTBoQCtblrATik
         bRHA==
X-Gm-Message-State: AFq9FYLWOVcDJwfFIwjQ0oKYESIyyKGcMEGfpkqZD5u6xilSB9qnP9/5
	5en6czVTGymNA+L55/cKIv3Yta0OYEEn56uriJNYeR/nnknT3KeuqXQRA50Rtg==
X-Gm-Gg: AYBFou0lLlfuvBmlv8vN3h8rEMEe4YQBORd5p/nBtMgvdHJmBVpa9Pbo7lJlEaXOpi8
	Qt86wv/PBkiNLtsNp5AhZCg9z9zbiBvrlJqC4TGSArCOQr0pYC3Oan76zl+co9KQJXhnBHoYZ3E
	8L1k0cS4v98pV2Zp8IqBKM1kj9eryZnY8x8FlMDBFz97Y5GK0gcGOIkO/MT7ALqITuxjwzNBI2h
	RJLXJSXkmriTIm5ZZMpXryCMN2GLLHIbGL5bTzZPTCFG5TI1ND9tJCrb0u4zTQWr+G2TW3ewYit
	vwjwnRv+lrzNQgPjWhIiv3doiX+w3EUgjsN6XyS43p8NCmif3qmvGsc966GiiLBiz+kh7pfjVyk
	YiF+t2e4tqXfWWGqs5cHSc4GrWhAv7ahhNpTHzzyjuYZZpsQ2r1ALXWlnRHgWinU6V8vRc0A+r8
	xo+aIOeYI0BAmx+qXLcZzO/M5TKChCN+gvrZ4ElgccyDg21DSRCsbRSIxUSgLdz2rc5WSxrSKzp
	DDlS+WXivRP9jYn7XOm7EhTpcSWmAKRojc0+9XRTj9HHF9Kh9QaptR4A9mOs2unnsfSmwxI7NTJ
	+FdELyLUktL71mZlPbbLGn1EFFI0+akeoh1yatfIvIn2ktM2X8u/sTdWGn95psgtvfDz2eyjQk6
	2M/V8vHZxoxkSbK2MfNA3R01VL5cvMoPIuApCpKOZkHMi1L0YKyB+OICTZG3kXPEP+a7AG+Us/X
	njuCrPQjsBJU8L/9Cigeg=
X-Received: by 2002:a05:693c:6384:20b0:339:851c:4c1 with SMTP id 5a478bee46e88-36a0f887a20mr6037334eec.18.1793166109762;
        Tue, 27 Oct 2026 22:41:49 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a237be80csm5860973eec.2.2026.10.27.22.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 22:41:49 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v12 1/6] selftests: mptcp: connect: retry write() on EAGAIN
Date: Wed, 28 Oct 2026 05:41:38 +0000
Message-Id: <20261028054143.3222998-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261028054143.3222998-1-anilkaushikwireless@gmail.com>
References: <20261028054143.3222998-1-anilkaushikwireless@gmail.com>
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
fail after as many retries, 1ms apart: poll() does not check every
cause of EAGAIN.

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
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

