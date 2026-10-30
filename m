Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336855;
	b=WseR9l8uw3YnWQSz+Gcq/F0MACnCKqDshNi8Zlg7/bj6Cnbk5oT5QlTwhQ/eXndxGus7
	 APZYuMCFloV+D5xkjgOMBP9xUMRr2SrZW3isW2Vya8MgMPBDOW6ItcUpyk0OMwNvM7rPt
	 gjNRkdx9tMALqyc/L8ECHkmq+o7ZBYVOxQhaNKHt6AS5JTz4UoIl6zClG8PC/rB8wwS/+
	 WIUTuUQjWZJ3BRk97p0WuHbdnHvnSb+0RTcys0YYDH+YtjOr9rcnQ1wGm9uqbF5lladPR
	 hxcIOBZxvVUhTA62oHyDwCxXzaBLnAgzS07uqtyyqW6aluQEF/WsiRvjisGi0Gp4Uzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lvLN24gtIiDD108HbQ1hU9mpKtt6mQ07/LEzVwndxzA=;
	b=pSgW3vtqag9Fyf6LRvfoDRtA44KMzLfLnZK+Xv2KeFJ/koc4sYtRDzPHCykJKXsfM7MC
	 WHfYNFSubzgncqcKIfOLp/pJqlooqEaspczibtkyu6xqKdviUgRjy+ZFsaeOPz/KHYnnM
	 W8gRRtaW/tSALuCRhR/HiKoRXKvMkzjtfR9RQybWPZT0l0gnZ3M/gaA10kGXpJja2vBQ3
	 wnd6dvo/MAt8qP8dJKSMxwZQkC+NqNK58IdGmnrX5PoBZXMKPBxXr9stQen98P6w2IIU7
	 YHfLTCMq06HxAPgtGRLmpnYIwGRdUh47cKAcqdFJxj08SyNLTsmArQzKZ8LaxeHDkEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ADK+2ZWj;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC4C606A31E
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 05:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CC4C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ADK+2ZWj
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-19305bcb72cso207427c88.1
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 22:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793336854; x=1793941654; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lvLN24gtIiDD108HbQ1hU9mpKtt6mQ07/LEzVwndxzA=;
        b=ADK+2ZWjZckbVoFGJVq9s+ISfHLPEs/RYoKRXL6y3h4daJK2pD5Ixdv/xiSETdemOv
         29pR/jlLE20nKZxQdSWWdwJzCa0mwTI5CSk2ekQ58D+IuTIdMWgVcwuFRnKTECX/OnPs
         1rgwpHGe/tvA0kYc1kgPLte8p0KK7H0FZ8J31JUR+TIZeMGnMxo7B2/esyygjzEMlL+J
         TDX4BPA1xsusPSCRIFytV9FRsvyw8QlEG4FldMe0ldWQWk5lOXTICDcNEPgydTfQYEsX
         lCwPTLFbQyOatZGhcxhyeKkr+tEPxOSC65p4IkjHbKYdOroH+jS9VNdPInMR+AzgPm5K
         6+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793336854; x=1793941654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lvLN24gtIiDD108HbQ1hU9mpKtt6mQ07/LEzVwndxzA=;
        b=BPCiUIOl9DBbQLjQc3/Q4bO4gW2oi63wsfH1DzpJcIYzeFi33TzMxZFkWAF1SYr+o4
         lkA3HszOwFpoDQgUbv956qZ9YRal8C0IX2/bODfsLWL7ZfBnwzdhAkr4xjVPu0Z9dV12
         JNWxqrZQsJN7cx4POk6zHSHpJuhh0H7OELeEKnIW3wswbEJXWItUVESt7mq5Ihcngjwh
         y1/nD/w1DUMPAYK0vEqA4KQLeUWuprVrJwNeovPN4ogodG17WQ8xuBEbwtfn+RWp9Riy
         dXtNsPpj5mzTRs5yrj94O+60UrsZ79izmFFn7hWkYuPsQlRUuGdlGmNLz+nIY9oMZk3+
         tsLQ==
X-Gm-Message-State: AFq9FYKIT31xbXvhGn3umB40qHq0hBMyZGfBahdYSmm8ndGj8r9cC2we
	/ja9IqJHwM7Tbjhqs0K/E82/Uw8SqI/GPk++CFHm1UDh4tfuDCqpWucQBExDjQ==
X-Gm-Gg: AYBFou20GhwcZEO1tejA7i1Jnx03TvOyAxNnTuCGfrF8qxtQhaVeVarz4sxNLfG/Azu
	oGZnKfKxihPkjDm2P0XVeZR5x0BGoNL4PcxSMhe/hmvUO+jJCXfUfWvr1EEwxUrs3LEVW1jqV2A
	gZJSWS1oVZvgYtsOAdMtRgKuJxSSrHgzMTT9IfRjB062k1ZWyORrztmKdNzQsTkfZU8TCFHIUh1
	kac+zxaOLecNMLp/c7YtA3x/UhZvsUJeHE4JDgO7pvS45Ur6zA30+MkvDDsgahS3MRu3GHUcPjo
	lcq/7TciyAYee7cv9uWGX+GPAJS8iu1hmCuonXrcIMXl/xG+f+gfd8BHXG0JmKqua/dzp96hrqD
	zG1XUlbOm21xAqLmaZPK4hYW2+Wy0nmLyzYyf/si7bXQpoyt0JbDc0xjPkrvHJZW/glVBWFCw4r
	jX3+giG5k2xd3zXtaqguI18jKEF86gIPcLNxvXUPw9OnGhJDISocD9iYeoRH9kvJxqYlWU3B35p
	OJoj2n+u5t3E62rqw8yVMy5lDbv+JhqQQD+Foaj/B+/jVoI4yMqEeI42Y61mhYJ6aa0IDW57kZI
	j4tXCe7tr7Pi73ivPVEIXb1coNTWClKqf2VyhsEA5HOFKzGUqZsqTqVH4rrbwk9OfAo3h9ESNrI
	sErSnRoxti9ec7bXF7IjNidV7oU9gD2KBV9oV3V1htm4n+TYZjSF6sINytxrJ7XjQjRDulpaA3P
	EqvAQ2SOLsIgoHHDGmy4QO
X-Received: by 2002:a05:701b:2087:10b0:143:7001:7645 with SMTP id a92af1059eb24-1ac5d889adcmr1746759c88.47.1793336853864;
        Thu, 29 Oct 2026 22:07:33 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b38ac58sm3512702c88.23.2026.10.29.22.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 22:07:33 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v13 1/6] selftests: mptcp: connect: retry write() on EAGAIN
Date: Fri, 30 Oct 2026 05:07:22 +0000
Message-Id: <20261030050727.3534304-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261030050727.3534304-1-anilkaushikwireless@gmail.com>
References: <20261030050727.3534304-1-anilkaushikwireless@gmail.com>
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

