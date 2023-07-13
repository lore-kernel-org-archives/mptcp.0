Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACEA1DDEE
	for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 19:08:25 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3fbf1b82de7so7117515e9.1
        for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 12:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689275304; x=1691867304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XkEf6EFdzJhabJQyGb8T2pwvDzCCIpcqtYKG8mt/1Ew=;
        b=eGdcplTcOITMMLiBj3rTHS5uBYG9jckPX9qOhiZBEGASW4JZeB9DOtqlOskYDtqepD
         EK2Wxf/aOOwQEfScwCy6u6tVgjTVQsfg7RAuCjtTbWew0E4pOHTiWs/9BVkRqp10LV79
         qXBnXinnl1E6f2Cwaps9hZAF9F4SgH+g6BxgwZR7pPttCYe0jYCNPqyAi8jSwzVQHkY+
         XgYkPZjjHzVS6JZpJEGtdP75Rj3xvRfAp6AGlCCFYFW5grgBVYn/YvJMRZZkD0vLksdu
         FUaVyFgLg4i6nhKgvid+pfiDwHjcMUyMXF3XMxb12br9c0LLOUJWNcIqV9gvWhi34L3G
         Cjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689275304; x=1691867304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkEf6EFdzJhabJQyGb8T2pwvDzCCIpcqtYKG8mt/1Ew=;
        b=U+QZmWLvUa7Mf6DAfm+s0nR/W8UpN2FqjEIOLJfsC550n/L5y8wJ1l1vPHsjEoSd4W
         2tJV+sMP6CYIcc0Kf+myt3L8jNWmx8PE+J/tLIamDnLWlG0xezebfilvC0MAqPTAxkw6
         irnU/bxGCZIgwVS90uL0TryxcvsG8V+9/W1ZkEgs6OwLTinS8royJ8rzVjkRoYmgmJ1u
         z3VvVdaW2Z7lLK8H+R1T2KB0XksPszYuO3+QsUeXojyNPiQaoQrfEr6SPWTdDrLLBEGa
         gT9VsZZ4l3xHQzxHx/0eEOYBwQds34FW/NKYFLn0ZYkOcaifAgq8wu508V2rdf1JfTMo
         iBsQ==
X-Gm-Message-State: ABy/qLZMA/bb8UY+LW/rG09LoqelqEZ/+lBHQM3V+VW7Fi8cBpx1SE98
	8h6lXTtT/bzBojt5PTq3gHRB8gF0lWlda9LYEo+/yNnc
X-Google-Smtp-Source: APBJJlFglKjt67gO3IwngDXdkE6xdrpay0VACsF/GX4eOj9ZlD/E9A6QM5ZkQRHI2B91v0/P/UzF+g==
X-Received: by 2002:a1c:770a:0:b0:3fa:aeac:e978 with SMTP id t10-20020a1c770a000000b003faaeace978mr491978wmi.0.1689275303918;
        Thu, 13 Jul 2023 12:08:23 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c740b000000b003fbe36a4ce6sm18988530wmc.10.2023.07.13.12.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 12:08:23 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Thu, 13 Jul 2023 21:08:14 +0200
Subject: [PATCH mptcp-next v2 1/2] selftests: mptcp: pm_nl_ctl: always look
 for errors
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-mptcp-issue-368-pm_nl_ctl_ack-v2-1-eb9582b8e24b@tessares.net>
References: <20230713-mptcp-issue-368-pm_nl_ctl_ack-v2-0-eb9582b8e24b@tessares.net>
In-Reply-To: <20230713-mptcp-issue-368-pm_nl_ctl_ack-v2-0-eb9582b8e24b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5126;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=JGzSN426bg7ZxUIzyVHzWVEVDmDpTgF0TEvJZSyjtpE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBksEumUsC0vcaCffRw3a+FVyVJskoZ/Odz2P7iD
 ZRr/dlpkbiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLBLpgAKCRD2t4JPQmmg
 c9zYEADh9hQ8vlByY6OKKWA9Z2uk4CyPrxCWjYap3/4pXCn0tbzI2F1k4QTqUV6zsXR7q+kqPI5
 HNr8ZGI9Fsy7FOEqdVGSXSWwycgZt4FMn5hTSJHENqXUGT0qXRTCDQVFXqR9eI4fkLAVvKpUbrO
 KFZpjFbM6v4D2jT1rVtCPmdxD78ksH+ZRbviPAjmhHhZVJe6HQEP7WZ3d+Nf2oEwRz2lD01ZCJO
 xR0B3s7CP3lvSUrYhDv3L5zgQAz+8SczLYyOph0Gc9V31e0Dgzr2Eou/wai52EyMU0WYbyHt64K
 XSh/x0Ya4ZI04vVEE5xAkgySEe1cL184nADTsS2NTqGtOoSonSG7vff+7bmTFTEzUUqJ1m6VapH
 mLDamHFgqauZYtUzGeBJx0r1949/dnAr5AXqLe8navT/sUlFuqusUB0PVQvZvADe8hO2vvM3MRu
 Q6IV38sfHkvUcRTZgJhTOwoxie010vhmv+YLwqSZjRAXjFtLxaG1JxWfMu+mHG+M+087g7OWmjn
 RBeTp1nktMdZ2oyDHQuab5I7gWaA0pP2vB+k7SXVqKGGvjuspwHTWnJfwAk2DIU7+AWYx6dHOG1
 18kbWxiPKyb0wISc8hHnYa36jrOmrZ1Nl5w2+1GNiJ4ZIW1OcLptk4LgyRRTOLmPawSGKaxXffw
 wVgNKDVVKvI4ERg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If a Netlink command for the MPTCP path-managers is not valid, it is
important to check if there are errors. If yes, they need to be reported
instead of being ignored and exiting without errors.

Now if no replies are expected, an ACK from the kernelspace is asked by
the userspace in order to always expect a reply. We can use the same
buffer that is currently always >1024 bytes. Then we can check if there
is an error (err->error), print it if any and report the error.

After this modification, it is required to mute expected errors in
pm_netlink.sh selftest:

- when trying to add a duplicated entry
- when trying to set the two limits above the hard limit

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
v2:
  - mute expected errors in pm_netlink.sh (Mat)
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh |  6 ++---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   | 33 ++++++++++++++++---------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index f32038fe1ee5..8f4ff123a7eb 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -99,7 +99,7 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 "id 1 flags  10.0.1.1
 id 3 flags signal,backup 10.0.1.3" "dump addrs after del"
 
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 2>/dev/null
 check "ip netns exec $ns1 ./pm_nl_ctl get 4" "" "duplicate addr"
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4 flags signal
@@ -127,10 +127,10 @@ id 8 flags signal 10.0.1.8" "id limit"
 ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
 
-ip netns exec $ns1 ./pm_nl_ctl limits 9 1
+ip netns exec $ns1 ./pm_nl_ctl limits 9 1 2>/dev/null
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "rcv addrs above hard limit"
 
-ip netns exec $ns1 ./pm_nl_ctl limits 1 9
+ip netns exec $ns1 ./pm_nl_ctl limits 1 9 2>/dev/null
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 1887bd61bd9a..49369c4a5f26 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -66,20 +66,25 @@ static int init_genl_req(char *data, int family, int cmd, int version)
 	return off;
 }
 
-static void nl_error(struct nlmsghdr *nh)
+static int nl_error(struct nlmsghdr *nh)
 {
 	struct nlmsgerr *err = (struct nlmsgerr *)NLMSG_DATA(nh);
 	int len = nh->nlmsg_len - sizeof(*nh);
 	uint32_t off;
 
-	if (len < sizeof(struct nlmsgerr))
+	if (len < sizeof(struct nlmsgerr)) {
 		error(1, 0, "netlink error message truncated %d min %ld", len,
 		      sizeof(struct nlmsgerr));
+		return -1;
+	}
 
-	if (!err->error) {
+	if (err->error) {
 		/* check messages from kernel */
 		struct rtattr *attrs = (struct rtattr *)NLMSG_DATA(nh);
 
+		fprintf(stderr, "netlink error %d (%s)\n",
+			err->error, strerror(-err->error));
+
 		while (RTA_OK(attrs, len)) {
 			if (attrs->rta_type == NLMSGERR_ATTR_MSG)
 				fprintf(stderr, "netlink ext ack msg: %s\n",
@@ -91,9 +96,10 @@ static void nl_error(struct nlmsghdr *nh)
 			}
 			attrs = RTA_NEXT(attrs, len);
 		}
-	} else {
-		fprintf(stderr, "netlink error %d", err->error);
+		return -1;
 	}
+
+	return 0;
 }
 
 static int capture_events(int fd, int event_group)
@@ -198,7 +204,7 @@ static int capture_events(int fd, int event_group)
 	return 0;
 }
 
-/* do a netlink command and, if max > 0, fetch the reply  */
+/* do a netlink command and, if max > 0, fetch the reply ; nh's size >1024B */
 static int do_nl_req(int fd, struct nlmsghdr *nh, int len, int max)
 {
 	struct sockaddr_nl nladdr = { .nl_family = AF_NETLINK };
@@ -207,12 +213,16 @@ static int do_nl_req(int fd, struct nlmsghdr *nh, int len, int max)
 	int rem, ret;
 	int err = 0;
 
+	/* If no expected answer, ask for an ACK to look for errors if any */
+	if (max == 0) {
+		nh->nlmsg_flags |= NLM_F_ACK;
+		max = 1024;
+	}
+
 	nh->nlmsg_len = len;
 	ret = sendto(fd, data, len, 0, (void *)&nladdr, sizeof(nladdr));
 	if (ret != len)
 		error(1, errno, "send netlink: %uB != %uB\n", ret, len);
-	if (max == 0)
-		return 0;
 
 	addr_len = sizeof(nladdr);
 	rem = ret = recvfrom(fd, data, max, 0, (void *)&nladdr, &addr_len);
@@ -221,10 +231,11 @@ static int do_nl_req(int fd, struct nlmsghdr *nh, int len, int max)
 
 	/* Beware: the NLMSG_NEXT macro updates the 'rem' argument */
 	for (; NLMSG_OK(nh, rem); nh = NLMSG_NEXT(nh, rem)) {
-		if (nh->nlmsg_type == NLMSG_ERROR) {
-			nl_error(nh);
+		if (nh->nlmsg_type == NLMSG_DONE)
+			break;
+
+		if (nh->nlmsg_type == NLMSG_ERROR && nl_error(nh))
 			err = 1;
-		}
 	}
 	if (err)
 		error(1, 0, "bailing out due to netlink error[s]");

-- 
2.40.1

