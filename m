Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336857;
	b=KQ0o+muWgqRiBlvBbIW5BoFYnPBJoHhJamjVYVfHnwLZkzDxeJJjUqX1d/gS6xsOIZHV
	 ayNAhMJe4Wy+KcUXe9Qp7r++UbOtWeCE1jLtJdeMx3Ugo2XoC2cTBApwtAMvO8ubtV1B4
	 KBM72cy3gIYyJzqppSSWba2incQ8T1QEPAZy4TqpYKGwHspYGutWb7kVtayUoQA2/cbPX
	 5QPPx1llt49LDBNte/Gz/XvhLJ0SwC13tU0xiZjWlplwUGVPOAr+HMfkaoyJr1J4K3yAl
	 Fo6HnxLEDQ9uoQYnG7UMFEAQwTQyPzpYOUoKcdyR9R47RVN24FGajFxKgGHklwD/jNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RhdWlyO5Sam//srEVeWFrjzifW9W6rttgI3RE0aHgEU=;
	b=eTAdZJTKEz2nx578eiB06x7ayyniertjy30O/9u49XET8Eg3aoPyN4KoYVCyLdgL1xiT
	 ATREA5KCYLVFMeKrivHSM7+lpEpTMVEcjIeptQAqr+INwJSMIEQDCmseLEfqzctXxpwTO
	 JOhrMbgK5eHvGHD0toH1DUKid1UhHeIn+a4YWLNN/qSY73U1L87g0nSVuC4le2ZBn2gWs
	 mpnA5zvU6d0/d/yGTuLecq83n4MIO3lghQ+qJm/cNYsQ0kO1Y0iegN9KDAZX2N1OlL61R
	 L7ZuYqKqDo3aTD8H349uezOVtQnD7L+T7YM6BJxoj/rtGLZo6GhOUdu35Qnil8e1Ang==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GXXLj0Uk;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEA1606A31C
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 05:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CEA1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GXXLj0Uk
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15ea896ddc8so506483c88.0
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 22:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793336856; x=1793941656; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RhdWlyO5Sam//srEVeWFrjzifW9W6rttgI3RE0aHgEU=;
        b=GXXLj0Ukg9bzL5Iwp0/+B22kCD3YHv9U3bn9ypE70YmBlXnREm1Al0JntQjYNh11MA
         paHNhlfNy2E2TgSeJbrKA/8TmFTSs77QzVnelbE6iy0QidR/bulK0u2opj9/2AtRpl/+
         F6d4lh46bAiy1lf6a2UZL+nYTGQV81xLKIAyA5GENm2vsyNk7UXh51hqNeWe3EvZpgHQ
         16QkXsY+i4M950B8StMKvoBdq+lCeOb8IVM2fFH6OBUM3Ndey5tNhEWAR9lDznfYGzI/
         Ds0lRUTqJXBEp78vQilThJGhu3ie/LHjjIh/m9ACA6FmXxQcU2m4uHI4B6xffAI1TV9U
         MM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793336856; x=1793941656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RhdWlyO5Sam//srEVeWFrjzifW9W6rttgI3RE0aHgEU=;
        b=g1uQ2UqpEpEVx8TH5TM/sxB38x3pAfVivKeNt3H+0q/NI6zLHatApUX77zxMML2rlL
         RsXmckWKOS84gXwTeu9V1hJCjYUNK/Glxh4UZG5MT4/WRx5AUlhAZYqqnjfJkSZ/YeU4
         4EqSENUVGtddcKAUhrtPzhNgGkbBV1IuMd0UadGtNtcPDT7h8ypfAfNNQlzucUlvOFrz
         JR19TgnFLyMdWTmeDYmkcw+5KeAfX9zvcHjcf6X900XuJSa+wQNJbliznxfTTigGUGLH
         w9SdobR1C6YaeKjoZT//n/UR4o7IW2qa5HUCWeVDkh4ZpfOpu7MLKmNoSMfdvS07RgsC
         16lw==
X-Gm-Message-State: AFq9FYLhCjhcPR+fwlw7PCalMvWxU43EzOArJ2z5MhHvCvPkWTZbYHSa
	kBflL700XyewRkK30ua1gNX9IvY6tNwlEX2Um6YkccchpL61lCznyhiXq3Rc6Q==
X-Gm-Gg: AYBFou3N8e1rIAPS7wYqvKVHlCwJbovSJgsuI9D66Y/uPZc4npD9Qsr1awwrBYPgSoG
	zIuSw+LFBCJt950+nRNhmXGhyYJAiyeQKbNaVcR0VPQcfzclyiN8gUDRXnBSeg+BJDS8XCYCwtm
	0SxIfHPn8zRdGNEt95SUTa3zkqOn49vsCj3KAFtIwBR/NV9VpvbWNo6fCvh6VXCKAoludc1NtoU
	BwfhFzvniC/4XdWCUy25+gjfJZ8kVzFGuI9mTpIMCi5nGmvI12UsozBittk0kSuaQmbIsBTzwqd
	DTfj3NImMTBSBFFMrAtx4JlLBtud0sWQG603kg8ONg/CvfgOpDQDuBv1DXIIHCIG0PbXFPli1GL
	jtAFkN7MN+wipz/XMgpJsKH16EhkkK3FLYnUgD28nqMDuiV/kpg6MMlIIauczuQtUhq6lJj5zoL
	H/eSmRCknTLlmd+tKyy+OEYAOgGdat8ey5ZkVvM72pyz3RrHrazSR0vekNEe5tAMWD8w4Yp7W7L
	GfqdOBOa1x3hC+Yc4P6rDLU5Pw6iodS1MyryNaT1EELqrQUPTIpdoXucLr6En9hiWlbFFlz2st0
	JohZpcegaDW7pUG/FX+maHi+1cgtqnRsenNOSpLZ4bkN+kH/3QXLDRD2X1Yjp2BorF1vYTLuQH9
	ca90ibKkznRGaWf9K1yHlg+t3gXjEIKXUowQOXJJ18SVuBxhsVQRDRzb3+q6Rerx6nk+takTOow
	==
X-Received: by 2002:a05:701a:c907:b0:1a7:7160:ffc8 with SMTP id a92af1059eb24-1ac5a2a156amr1569757c88.10.1793336856098;
        Thu, 29 Oct 2026 22:07:36 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b38ac58sm3512702c88.23.2026.10.29.22.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 22:07:35 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v13 2/6] netlink: specs: mptcp: add the subflow-retries attribute
Date: Fri, 30 Oct 2026 05:07:23 +0000
Message-Id: <20261030050727.3534304-3-anilkaushikwireless@gmail.com>
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

It will be used by the in-kernel PM to set the number of SYN
retransmissions of a subflow re-created after a timeout, with the other
limits: add it to the set-limits and get-limits commands.

The uapi header and the generated files are updated with ynl-regen.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v9:
     - after a timeout, not any error, and about 4 hours with the default
       RTO settings
    v8:
     - the default is the maximum, MAX_TCP_SYNCNT (127) (Matthieu)
    v7:
     - the doc gives the default value (netdev Sashiko)
    v6 (netdev Sashiko):
     - the policy checks the maximum value, 127 (MAX_TCP_SYNCNT)
     - the doc says the value works like TCP_SYNCNT
    v5:
     - new, split from the retry patch (Matthieu)

 Documentation/netlink/specs/mptcp_pm.yaml | 13 +++++++++++++
 include/uapi/linux/mptcp_pm.h             |  1 +
 net/mptcp/mptcp_pm_gen.c                  | 10 ++++++----
 net/mptcp/mptcp_pm_gen.h                  |  4 ++--
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 39f3facc38e5..690d3c5dfdd2 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -196,6 +196,16 @@ attribute-sets:
         name: addr-remote
         type: nest
         nested-attributes: address
+      -
+        name: subflow-retries
+        type: u32
+        checks:
+          max: 127
+        doc: |
+          SYN retries of a subflow re-created after a timeout, like the
+          TCP_SYNCNT socket option, so with tcp_syn_linear_timeouts on top.
+          The default is the maximum, MAX_TCP_SYNCNT (127), about 4 hours
+          with the default RTO settings. 0 to not re-create it.
   -
     name: event-attr
     enum-name: mptcp-event-attr
@@ -327,6 +337,7 @@ operations:
           attributes:
             - rcv-add-addrs
             - subflows
+            - subflow-retries
     -
       name: get-limits
       doc: Get protocol limits
@@ -337,10 +348,12 @@ operations:
           attributes:
             - rcv-add-addrs
             - subflows
+            - subflow-retries
         reply:
           attributes:
             - rcv-add-addrs
             - subflows
+            - subflow-retries
     -
       name: set-flags
       doc: Change endpoint flags
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index fe9863d75350..43e9643deda9 100644
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -102,6 +102,7 @@ enum {
 	MPTCP_PM_ATTR_TOKEN,
 	MPTCP_PM_ATTR_LOC_ID,
 	MPTCP_PM_ATTR_ADDR_REMOTE,
+	MPTCP_PM_ATTR_SUBFLOW_RETRIES,
 
 	__MPTCP_ATTR_AFTER_LAST
 };
diff --git a/net/mptcp/mptcp_pm_gen.c b/net/mptcp/mptcp_pm_gen.c
index c180930a8e0e..e2d4af1bc1d5 100644
--- a/net/mptcp/mptcp_pm_gen.c
+++ b/net/mptcp/mptcp_pm_gen.c
@@ -44,15 +44,17 @@ const struct nla_policy mptcp_pm_flush_addrs_nl_policy[MPTCP_PM_ENDPOINT_ADDR +
 };
 
 /* MPTCP_PM_CMD_SET_LIMITS - do */
-const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
+const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOW_RETRIES + 1] = {
 	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
 	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_SUBFLOW_RETRIES] = NLA_POLICY_MAX(NLA_U32, 127),
 };
 
 /* MPTCP_PM_CMD_GET_LIMITS - do */
-const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
+const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOW_RETRIES + 1] = {
 	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
 	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_SUBFLOW_RETRIES] = NLA_POLICY_MAX(NLA_U32, 127),
 };
 
 /* MPTCP_PM_CMD_SET_FLAGS - do */
@@ -127,7 +129,7 @@ const struct genl_ops mptcp_pm_nl_ops[11] = {
 		.validate	= GENL_DONT_VALIDATE_STRICT,
 		.doit		= mptcp_pm_nl_set_limits_doit,
 		.policy		= mptcp_pm_set_limits_nl_policy,
-		.maxattr	= MPTCP_PM_ATTR_SUBFLOWS,
+		.maxattr	= MPTCP_PM_ATTR_SUBFLOW_RETRIES,
 		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
@@ -135,7 +137,7 @@ const struct genl_ops mptcp_pm_nl_ops[11] = {
 		.validate	= GENL_DONT_VALIDATE_STRICT,
 		.doit		= mptcp_pm_nl_get_limits_doit,
 		.policy		= mptcp_pm_get_limits_nl_policy,
-		.maxattr	= MPTCP_PM_ATTR_SUBFLOWS,
+		.maxattr	= MPTCP_PM_ATTR_SUBFLOW_RETRIES,
 	},
 	{
 		.cmd		= MPTCP_PM_CMD_SET_FLAGS,
diff --git a/net/mptcp/mptcp_pm_gen.h b/net/mptcp/mptcp_pm_gen.h
index b9280bcb43f5..5b4dee8a0a34 100644
--- a/net/mptcp/mptcp_pm_gen.h
+++ b/net/mptcp/mptcp_pm_gen.h
@@ -23,9 +23,9 @@ extern const struct nla_policy mptcp_pm_get_addr_nl_policy[MPTCP_PM_ATTR_TOKEN +
 
 extern const struct nla_policy mptcp_pm_flush_addrs_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1];
 
-extern const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1];
+extern const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOW_RETRIES + 1];
 
-extern const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1];
+extern const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOW_RETRIES + 1];
 
 extern const struct nla_policy mptcp_pm_set_flags_nl_policy[MPTCP_PM_ATTR_ADDR_REMOTE + 1];
 
-- 
2.25.1

