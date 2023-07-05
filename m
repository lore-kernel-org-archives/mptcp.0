Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2571012B6A
	for <mptcp@lists.linux.dev>; Wed,  5 Jul 2023 17:11:10 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-314172bac25so7550666f8f.3
        for <mptcp@lists.linux.dev>; Wed, 05 Jul 2023 10:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688577069; x=1691169069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ME/zVhsyXlpNyLTqpkFDzXWGrzr6cF5V8MIt/wOzFuc=;
        b=7kWuLwOB5PSygAqf5J9T0Zv/lCoREc9YVCl6Z2ULuxyOJrlb7zNhZ1Yr2czxgGwkl+
         JGCs7JJhzhjMv5ws5eKGOPsWm6WR4hjSxs2kJbToY1hZLoWFtfPBLuyM7nWn+JBv9AiT
         wbwzi/hSV3busEFSyfEEc7MSAw5mYMpJXUxKYkTIRL07Iz5FDAs2pL60C4XyNhPzjlgy
         InWqNvGKNhYfxzB0pFN67egPh+ikk1lh0FF6oNOigitfG3FqtbHQr0phgRuWJFcFClph
         GdwoJwdNaP8shRFhJmWh/15X8wyxWpocJ+TuGLFOT5S7O6lNN/gZ4/Zb8ijliqqbS/BS
         SRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688577069; x=1691169069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ME/zVhsyXlpNyLTqpkFDzXWGrzr6cF5V8MIt/wOzFuc=;
        b=SNnXW9wDngn0jDIUvkiTf/R211W2ecnqJ0Hkh/vzgNdCxsHpVQpqEjgjrtHnbNp1Ol
         6E5vlpKDpZC072BlunfTAW7OKAUhnmcFT8dMJScCzaLAblaKTG4tSLZuh49qMSWF8khe
         R0TEAE6DNe3oiAFZ1zsxUmtzeSEmRBXEzPJisPIwQpPgf0byc+qJwKNM7OLeGzN/340t
         U/jTo4Fs4zhw3lBOUxRwVDveQVVHcCvroADhyxc1KfcL3cYDCKcEecyv7bmrjZFEQOEG
         kaVk+aBbfnvZlr2rCm2IU4NA/ovMwHHMXBWxisPoIfaNI1w3jaLVsFWv/zT9eGYZl5LK
         X93Q==
X-Gm-Message-State: ABy/qLbSEJjdGNQ591pe2UPmRBrpk59YjhxfnMKcM1SoEd1T6T0b8J5U
	xere2pfrul6xZQJqQ904VQ8OstEE8Ld4quHIaFUe73sr
X-Google-Smtp-Source: APBJJlFUUHIMLYP83y25BstW240id/MZrcr/o9zNEye+SD1XNqQKcRE7w7Wl0vBrsOIj3zlBWZCQzw==
X-Received: by 2002:a5d:525c:0:b0:314:99e:af3a with SMTP id k28-20020a5d525c000000b00314099eaf3amr13101027wrc.48.1688577068959;
        Wed, 05 Jul 2023 10:11:08 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00314172ba213sm16993444wrn.108.2023.07.05.10.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 10:11:08 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 05 Jul 2023 19:10:38 +0200
Subject: [PATCH mptcp-next 1/2] selftests: mptcp: pm_nl_ctl: always look
 for errors
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230705-mptcp-issue-368-pm_nl_ctl_ack-v1-1-40bcff40cb6b@tessares.net>
References: <20230705-mptcp-issue-368-pm_nl_ctl_ack-v1-0-40bcff40cb6b@tessares.net>
In-Reply-To: <20230705-mptcp-issue-368-pm_nl_ctl_ack-v1-0-40bcff40cb6b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3555;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=LUyTTm6sFi44lf33ke8i+21lGQrdiIMfU1hMmvTRums=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkpaQr4PdAhbP3WLlygv3IH1Tu5kQOWXvSMqE4K
 br1riR1mp2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKWkKwAKCRD2t4JPQmmg
 c6CPEACVwt1LUgGPferE1ITLU9Y+ENXNeITdH0FAVoB8umsm59bAbYFYLY/GuaF01en7mucY5lh
 BWEUqMdSQJM1OANFcU2Kx0RlCdc5osldU3GTM/QDBEWCPRLxBPkTohGS8FZwZN0fLdhp972sO38
 b5aUcezHjhemovo3o8cZperdiwIPpPI4DOs5mOVFTVatr57prbHtBYOryQrqW77IuTvL0LwYZx4
 O9q1cUVLEHCWL98AfVUUWn9hscyvo540b8wt5/B3i0ndzfE7SPxQyUCR5zanZ/t61ZYOtPrYHCR
 u3u+OnJrp+IkVmxP3iEFGRQTEhmdiCquDCosS+b0+cT61vK7PGTsvi07BSHNCFbGHjmXdOrC1wF
 C43SO758RHW7Ictyd/r7mbTUfNmJpIqYIuBKgns2Spe2/D3MEKe7IhgB5LUsGJyN4/Ljpk+YIk6
 CQvmx4YyKAPwy8yXVe0CTKZHU0f0g+lwR/9DFl5PcS+qV/odV7E2anx27MltbnyFBLAPNiqtCgu
 MZUFCP3iKxwwDlPbotQiBuexfnCqkY+FqvRqsZRwZcmmMtHV4DT3DOF8lUL3HbrG9NUWHp2J+qz
 3WqMtYs/ia9qAWvQCZWCKM/2rTVzANzEm4vkSFqPrKY5J/4a4Do8eIV8W2fHvxrcOu2k9LTtHqW
 TqgM9eUUhlX7uNg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If a Netlink command for the MPTCP path-managers is not valid, it is
important to check if there are errors. If yes, they need to be reported
instead of being ignored and exiting without errors.

Now if no replies are expected, an ACK from the kernelspace is asked by
the userspace in order to always expect a reply. We can use the same
buffer that is currently always >1024 bytes. Then we can check if there
is an error (err->error), print it if any and report the error.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 33 ++++++++++++++++++---------
 1 file changed, 22 insertions(+), 11 deletions(-)

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

