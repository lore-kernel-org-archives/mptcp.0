Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792681899;
	b=scssgPfTBQdjQ7x9H7ypQXoVo8fweIh5d51SE0rg7jfBhMB2aMlRbu/VB14kOBOcr8P/
	 AIeU4vLxpUuWQ8JGi5lab4y0Adho9iLPfJt+9Ote1JiFF8Q6agT0gYF8ZiWHoDxLLoU1Y
	 apgxgARA9bqBexTsnnxAGsDHbulU6EBKnjpBN4LMobA8R7JWcmKwSxf9+hGhNmNvFifPh
	 5Arw6DdG0WkYE3f8Ru4P8dGgvJs6340k7zIQOiBH18RALTm6mUFGC6CbnXXIkc/1hl1xU
	 kfYh1XlHHpR19S+AFN5zGMV/8i/2DcGZKJK+k+eQv0oMaJyb1HAwJWJ8eWF7/2rqktA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792681899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KvEq34+Yf4dDq/T/EyGx6kouG+iVHJ1jZQO8J1NJeBI=;
	b=g4vGbnG21mcseoYOguL0GRbn7FLA38jCBZ82/Y1/kisNpPJzi6FTZZbUSYQuljzHcZt3
	 TeIXXMhkDMeyNYzUJojpYjWivm7Oi40emwD6xvyI3XlQu9jxkgR9PLLfhBr0KCJS8sYHK
	 Y9S7FwQUAz7QuUc0jQRXUbXEotT5apnX4SgUfL48br6tj+HgEYtTPKX33rRU4AJtNt6j/
	 Saz9eSCxLaJKJYy83w7Nop7FgOAxSEFLHgYG8TkpR44yWH6aGCV4AzA2pVZCzpuQ8oGMO
	 8DIqARXwXesHT4U9T/iNxJ5HsVuqZ0XovROb17pI9GZ0eNenWWUJkiKh0xRhZbGLKtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tEKnzkYq;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32D160A3819
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 15:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F32D160A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tEKnzkYq
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35f036b17easo116631eec.1
        for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 08:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792681898; x=1793286698; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KvEq34+Yf4dDq/T/EyGx6kouG+iVHJ1jZQO8J1NJeBI=;
        b=tEKnzkYqDNz0ZUhGS9wQgYNyBWjpmCyZAGbx4o39liGMvqykFE3vHnHQdiIZlC2FQD
         gRXDCLAOOQrbciAevBWNeOcn2OWdgZxnBwoqb5LwIkuBRbw/58X9VXU9I5dTNZaVxqCM
         x0ix/g7dtdv3Z8NW+JvoBwEiDOF2iqbGYPdEr4hkSZ92J8LeUbNsxOWxLROByIwtYYVB
         noimzondLIIJnJOmcG0T3Nol1sQGYVUhA0r+UiISsNGGdI8D1C+xlp0s2n749bU1vdFQ
         Q/GCLR5iCT9wpsRsN+81ZdDKMVxIfoTynnd2+sN5bjMN5QigLURLm/6fnbaAMlawBBi9
         jfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792681898; x=1793286698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KvEq34+Yf4dDq/T/EyGx6kouG+iVHJ1jZQO8J1NJeBI=;
        b=ibi804D0NyAzBljlVzvbfYCZ3EJLfTulnAyZXhWyLtS2PZaNRLLHbuJcOfBtNAGeho
         EJxFDBsOY9OzH5RE4AnmKX/F5q73O/csR0GKy9Ge/Xgc1FG/DFWSvVUXxBFqANZcxtv9
         eVdN5fiGPEA6PFbkmOi3RK9ZiyEZx7LxVVGKEzQ4/0nZls+KqLdb2/2SNZ1XPNd/X448
         JiZPuRTPQICZPAzHYPPS6JmE/W7pJfVIgbJe1QpGqKezTdrwXjXGMTP/Pk1tC2A3759f
         rPAKYgnSlfaf0mOMH6L6bYVVAP3ZEtWMZGy+HqvPPSPA1SgRb4XSAihjgU8XIa+/QtuS
         yIkQ==
X-Gm-Message-State: AFq9FYJv41ChdfBglA309imaytmuS9b1qMcdk4yK2ErwoUXepgvBzd+c
	gSrt3CQkAz0W3SOoJIDAURVEBWao5YJqIAl2kljtaagcXiKfoVlaEiffg6pJSw==
X-Gm-Gg: AYBFou16WUHbdd/+XSO8qmQV+qV4xuDEvugotkJUQizO9GfiFNiNoI8WuTV7bYgMcvZ
	D80cvSt2F/66aBEAWcAPveCr9ivB2dkPRUvqk0vLOGuqOwcivb0aqenHRwGugybkQA0ApfQt/CG
	F5R0RsLxaEAnV6e907Wn+80wUXDOpwT9xWpOATN9QpCfEIIu8Q1KZfblCjK13AKLCofYjrMhuB2
	aw97WI1JAv7lPOB3pTimrcelGGb+cCRpc4B/Pa4ZASj/wQxGwCHXZbBgWn9+SqxatpQ3/fOP+jJ
	1xWRuYXIYFB3qlmVczaGFPy04Z/GIyN4OSoSi/bn/kMZbPwVfCQ7L/bzs6NQhwcCzBJ8dpeR6tq
	WrbKkB9Jye51TohghBOqI8lrUw/oqFBmHGP0vZnUGSIUNZPGSunRXDIbP/IrIGlT9C2CKAXwQLC
	dg6X8+qMZ9lDNmqU1hBrItmW+b958d2whJ9CEi69/f+x+Jww68peDW3+XhQK6s9d+V4CLX4/YXt
	9eVMN3dcYAkvVdHlzg5+eNCDIeKvf6RVHEB8dqGuv7ru305IbUqZYsc9FeFsjoMr1yzJSSdLG6M
	rs9sC+9mCZPp5fTHpozjkxsBaZrdbAVe6p2wzBWhdMoeoXZIfS7e9XFvqDx4PjUTwZgsp9KkU9P
	ObUo7lODvEJEqmpNLFANQ20jy
X-Received: by 2002:a05:693c:66d2:10b0:366:f9c2:9b16 with SMTP id 5a478bee46e88-3674fd08d54mr7628074eec.31.1792681897791;
        Thu, 22 Oct 2026 08:11:37 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741e71eaesm36327560eec.26.2026.10.22.08.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:11:37 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v8 1/6] selftests: mptcp: connect: retry write() on EAGAIN
Date: Thu, 22 Oct 2026 15:11:25 +0000
Message-Id: <20261022151130.2285198-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261022151130.2285198-1-anilkaushikwireless@gmail.com>
References: <20261022151130.2285198-1-anilkaushikwireless@gmail.com>
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
Assisted-by: LLM
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

