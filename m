Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019233;
	b=reSMP5SKLkVCSDSGP0DHiSnEU06uKPmq5P1irjGbjVxQ6ZBXOW0EzTlpDrBTlspGffIv
	 aGhwjTko/1r4jMvsz5/ZdMbw99baXAYZMgoS27QGxKVWGDZ39zGh70kEJ0BWO8l5ejuci
	 ZPKDVNi8+tH7UxFGBf44rLR176vhTJ3xxLiMTdkNx2KOi4q2PtAHKyf7/ZY8obNVBflIo
	 s81lx4CxGQ3bLnawjYp58b5B8P4UTP7XjxHxgf29Ls4q0Q9lvHRVtCJSKa2gwBJC7JntJ
	 yLEq2AOpJOfupuHGKv7Y+K3XKruwzMoxisbzg04rMlB9Wf83vviaDxHx+WMR0omqvlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XwlldahLZl6u6KBDX9l7n8vOmnvTZvhZdUFA/a8ErDA=;
	b=dv6T4DxZVEKuvSGxVVqD5/f0AdJOnJGPNJ3l4LUjEneOtk05uTGg6+ff7JOMov7WFmrV
	 UwFpD7PREyvlb3SyyfRQ8SmeBXLm1AF+4sxLwmfGRjUZIcKv9sMVAq51Phd6p3UwWmNgr
	 ena+0zqpjBoa7ennzRzBWP72xOoXG84cXDR9vWxj4F1yhYXOv+RmL0KFyqZRQMbCUe+b4
	 rOx8K1w3NHHo4m/7vt55NRIj4Z3IpScnT5GlsCnX377/z3Mf98Z7ahNXC6x8hGARGzD2+
	 35AOQbnWlJXlHza8C5KkBNrJH3knMJaxRd7nha1UcAkX2Z4DT1niJROrRPTWRfjBXAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="iGJvNAa/";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADC4606A31E
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 12:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DADC4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iGJvNAa/
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-369f3e9e431so599114eec.1
        for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 05:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793019232; x=1793624032; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XwlldahLZl6u6KBDX9l7n8vOmnvTZvhZdUFA/a8ErDA=;
        b=iGJvNAa/WowBH9X56D5SqbF8AQJKvgMBV6o1NO24Xf2qg8hdmLhTT41lTK/FGjwjch
         pBJEb6La3cSdhcYHCjJFVMpXJ4j7uRDk1jjnrQXN6cdFnEEZmcV80GiQxNIExxO3aMuL
         FmlR5ZM/hs53HOFxnsNKJCMm2aWaIOJrzBmuK8eDKPG47fbNcy9a3P5QxkdPZdbQMx36
         CZdDg05TnaNUIs60RronK1VIO5cjKFJT2dR3xqF4DRIN7oc2r3FGmSNmoaxyy+F/BXfg
         z5OftO1AxJNNQA3+pxeVMmLTP/iSQFUNUZkAulKiw/SYY/xow9Um4Xiu+CMdTHgjg16M
         kfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793019232; x=1793624032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XwlldahLZl6u6KBDX9l7n8vOmnvTZvhZdUFA/a8ErDA=;
        b=GDfC7PH1jv9x8ynVQtykUmKi6qjot82HpEQNY5W41oyZMqdis8mMF4lNhtQMZTM793
         cpm3aQKduKPcM78HQjU0ovyFMjSWltOxCjo67OzVZrOOge/pcxyYUEu7Sn/sFsXPUDeI
         KluhbgUIf6zQfMOhZr0XJcMmZFoeVYWzPez8uBoUlbH/rwoFnlkLoYcW0Fdh3wGwkRXz
         BQ5ZhIbaWs1V8i0tLumdoOjHjYZzd6Sv+nwK9mD32C3lg4XY43njwRfawApFuz9kgJUh
         STgmGRo0c6moyHVXnAiXSY/cjcL07TzFKBks7oOPZ184+Yz/yXrMnFnokCBw8qPvQUJC
         HeeA==
X-Gm-Message-State: AFq9FYJGEFhds3/+2ZyKjNVK4JsUimLtB+dTQwzffglNLCclqWVoPLl5
	msiPCIqiG4d8JQK1g/0ZWKOvaGocQmA22l26BVSrT6FCVK010xz3NjqjDSud1g==
X-Gm-Gg: AYBFou3yAeNelss47d6U64xOJiNwlvjHCQvDvl5idXVsnDysjzavh9yc2GUHAUgrp7e
	6b40SKNuMTtMuDPgUzeUhorKKvy6gzJIjtkKD4bmfKWpa23BnD1PyyTosCPKdyUsgcJI0bNPioc
	GSGrE1GMgTMzl8NaEbu7YiR5RrvSULqlOnLWj81Ij+9tna+w2Omwck/6l9wxqDnF5Lhog8Tz0Aj
	34SwUxQWQLVAi7JuY3e8L4fSTKGk1/Q+LvVzC7UzUCdo9SNYrYfDa4Ysp0KLHtQBN7nwnaLkDxV
	ZDYxqGxeYtBuKZHOqqx7BLGXjVqe3C/qoyLsFw9D4Sz0bAo93lYQzT8QmZV6SDqZTABp8c6/ptv
	QG0U+w9iLB3e39f2pmRRHUMIKGxOKfrIQRe/18hfYdv4UsztCtLEw55Kx1InqYyMX4QaO9Xlcf2
	6pE2L+F9AEgk3Q1Le4fapQ6IpFcKzK78+RfgJ9GllLygPlv/pynY8Gfgku9doaSGTRaEZDU8lnd
	h2JnYefOn9MQmxhv+RwwMku+zyKNjdDmbqg1Z0MGZvopwF4bVdV/SI/IfdDPhE30RXh7zSbFdmA
	qwZByN93YD2Wrw5C9r1d2a9vtCDaVzOCvcLaTU+Zjmzn1X+yU2QPNyMYybueSyvNP7Ruet4C5tK
	lC9KBCx4vtI94yq3OWG/SwrUW
X-Received: by 2002:a05:7301:2f0b:b0:351:606f:2832 with SMTP id 5a478bee46e88-369e875a232mr9901090eec.3.1793019231698;
        Mon, 26 Oct 2026 05:53:51 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369f4164886sm18377923eec.7.2026.10.26.05.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:53:51 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v11 1/6] selftests: mptcp: connect: retry write() on EAGAIN
Date: Mon, 26 Oct 2026 12:53:40 +0000
Message-Id: <20261026125345.3019372-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261026125345.3019372-1-anilkaushikwireless@gmail.com>
References: <20261026125345.3019372-1-anilkaushikwireless@gmail.com>
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

