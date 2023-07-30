Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93FA17C7
	for <mptcp@lists.linux.dev>; Sun, 30 Jul 2023 08:05:35 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-31792ac0fefso871121f8f.2
        for <mptcp@lists.linux.dev>; Sun, 30 Jul 2023 01:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690704334; x=1691309134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dzYnsVvpxbgyrd/hUa2HAaITPH/B+5u9jr/h+TX8qQ=;
        b=U+Wx0/zt83OdlYR7ItjD8uQOEX4px6Tl7Kg5dfRmI3ByHt0+F9KA7yKMzaIAf6J2tx
         l4Lr1RVSbbSo5+fSgUoJjiS8ZlubOIflWkuAn5vzbuNGtOwSxoCsbgiQhUhLqPr4rZFy
         h8hebEp4FljT97Fva1xQOBkRqSjBkC04vj5feUdNJEk0PKisoUqubCKarqHOci3IdPwc
         JObDxJAeNayGh2zLt0WbDzP3by2rJTqdo6En1qzLksYT8vEjcZ4HNFIRg5IPt1RgwDjk
         zIWgf3IO9DY6+FJI0RxdN53IGdN51vi+N6kMKrgzkAkx6ghwR97lVtW3ca3yjm/cvSsm
         +FCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690704334; x=1691309134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dzYnsVvpxbgyrd/hUa2HAaITPH/B+5u9jr/h+TX8qQ=;
        b=Oz8dRxat9MELGDSmIKnZj/SSxfqsxL9MnVL+wfa+QefBBfouu/He0CSyKn+ydNHcML
         rqV2UOeN2/MynpQ4jPRkxRCJrwIU3ruT7uRws4tJKnrurZ3enmeQlPc6vd1f7Oo7YvB1
         6uURk8rP9jLLahYSPf9b5wqs/Ofl1FjaMGov5h9yJVdIKmdEEvnzZJTXII2bekVfRvRr
         sT5WZtNxv7VRcMoSx1CXRZpfKxNMk+skiqPND96RMPUokFe8NAMpNKSDNCnC0ij+9d1Y
         QIqSYTvkbPeda/d5RUP2ntgLVZGLhpmxiEBHm9a7hTqSJJ0Qrln2FwO9iOyNm+OdYC/f
         jrcQ==
X-Gm-Message-State: ABy/qLYmNExkxSrPpwt+GQINeeX0dQK3RD7dhL+g1uLtn1si41VXxiYf
	g4MX5I8WeGKZDc6B+YlH1qF+71R7Vk+NvjwkzxXisGlI
X-Google-Smtp-Source: APBJJlGSdrHGlWWFGJ6QzVF7wYsEsJ3O5JzLW7sh5s2T3AONTMTgYanP70qKvqgy9P4CJCEcG4Vzow==
X-Received: by 2002:adf:e4d0:0:b0:317:64f4:5536 with SMTP id v16-20020adfe4d0000000b0031764f45536mr5678173wrm.44.1690704333580;
        Sun, 30 Jul 2023 01:05:33 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b0031766e99429sm9338684wrq.115.2023.07.30.01.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 01:05:33 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Sun, 30 Jul 2023 10:05:17 +0200
Subject: [PATCH net-next 3/4] selftests: mptcp: pm_nl_ctl: always look for
 errors
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230730-upstream-net-next-20230728-mptcp-selftests-misc-v1-3-7e9cc530a9cd@tessares.net>
References: <20230730-upstream-net-next-20230728-mptcp-selftests-misc-v1-0-7e9cc530a9cd@tessares.net>
In-Reply-To: <20230730-upstream-net-next-20230728-mptcp-selftests-misc-v1-0-7e9cc530a9cd@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5804;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=zt5ouxkb3s6zxzf7rDQx31R6QrrKJoR33HG4bTNCNOY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkxhnJRf1S/opybvBh9hwDX4s2576g78dNizyfx
 AnaaAJgN1GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMYZyQAKCRD2t4JPQmmg
 c5JqD/9Y4sHtT8a9AUwvtB6spBWjAyojPchT3SPEC3W/ROPd5+X38lKc/vo98dzsO+ArsDAVUhQ
 NgN+wLLS/zauoPt83gVj+lHEuTO4KJRuCpw6RDK7I/pu7FrlhS1QCexsfgC79dyQlGfUd39KorJ
 q1nyF2zxNfozxjgYmgANMAW7a2tbiDsWx155elIfiXF+jD02lJAKX+vQ0uqoBx6998tbGQga/+v
 gIofDnmuV6JFtSsYHunz3gC0bMh1YneDWXVqwF80+D2wEdU05FgY8zvmMY6DPmLjsu8EYIraJnx
 ny61bBH1MZQ8+0quTcDgChCLulb0hEfoZzUMIGU0TJxEI0G5GkTJQqz4iCvH6pQd25/11lfkS7Z
 usiuFVnefEXabU1gzyV1cqvD5eV1dwhUrwrMuCwxGtMfye0fECUeAEiMwsA5MF1K2nezKB6pli9
 rB7o8wmxr8Rq7PIi5126bp+9L3nr2kbtdOui1sSJNBvW/Rfy+Stt1+RvLQYpDUjiQhIARwWqO/M
 M8rF90Qt4bhTEaCK3V0Q6d3MHFHb3WxT4o6XXkuFIkX2J+Pvi1FkIffg5IHsEybtPI2Lo1gV4zi
 MUOu3fr0A8GU/U1d6bBboVsqzWzF66q2DWcL8iNN1f7S/QR7B/g5Yrw1+qawqPjGloy9peg2JaU
 IqlOgDGYm2/1XrA==
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
mptcp_join.sh and pm_netlink.sh selftests:

- when trying to add a bad endpoint, e.g. duplicated
- when trying to set the two limits above the hard limit

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  2 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh |  6 ++---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   | 33 ++++++++++++++++---------
 3 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 136d20641fce..63658b0416fb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3452,7 +3452,7 @@ endpoint_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 
-		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 33 2>/dev/null
 		pm_nl_check_endpoint "ID change is prevented" \
 			$ns2 10.0.2.2 id 1 flags implicit
 
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

