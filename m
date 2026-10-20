Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792466243;
	b=P7xfYydPsk9ubyRGOFVp8vRPk0iPpjVLzusf7q79rKrE+sJ6VJrlfa/L+UiIMMdwvAQO
	 qi/WbreHkBzlN9dRkxbbFSJXwLIKwqMwvmdIGjHRYcqInVyHLl7IR3byiftZbIHL37kOj
	 pT7b4NG4zD7IGgmpIQrOstIBhL0uMNivPIOda4ya9+scnqIxi7aN2Qf0cBdQXYijKtk8Z
	 45gJ99GMzx9UPxiKnvlOzN8mfwbx8EpDqElxFFs/drpsKixFbnGzrYrcxXQdPKWXONYp3
	 iPCGQqs5/kjiDXHhmVSpG7fLMCG2wENgv8kO2Rw2zW5EtjwTNpfPki97tgqBqabVUSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792466243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=crdiqAdX0WongrBaAIeIY+l9rwOhSUcXzcgQ4HTO0HQ=;
	b=4fWZGW5ymHfMXHBRwoV8ndTCl6HqZHtJWnVK2VdWpnMfz5ZmUBna0RKD/t5Gem514bqu
	 6/02qluZI+AX21DcSuTxOCPXa8t/Pd1dGfr9MxTXC7kPQoiY/9YOKejtDECfDXVw85VW/
	 ixrEgBjSIYR5+hHdsqLmHDhs/PwCeawEG0JtU1uh2bUatuZvqpWUxiJCrGZ03+8trav1o
	 I7pQ5AUz8liV2VCgDwe/FaCemr/qlh72FgS+ISc2c9gLwXYd/Y4JrkUBUui6VJ5pJ+Da3
	 ErXufTi7es2iEscuc+hskLxL8uMbphvktBHZlx5PGwHpXXCR31aMMUx83GPBx+cBPQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nCgNNxPo;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6CE606A319
	for <mptcp@lists.linux.dev>; Tue, 20 Oct 2026 03:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF6CE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nCgNNxPo
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3535a54bed9so3869126eec.1
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 20:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792466242; x=1793071042; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=crdiqAdX0WongrBaAIeIY+l9rwOhSUcXzcgQ4HTO0HQ=;
        b=nCgNNxPoT2Sr5zLmTA+zWEQFXSFiUls30k8zLVdk9W1Gj3I1BbdmEo8qTH0daVCzqw
         +42g5IJvrQ1bwqCMn2qSh4k5LqQrp3AH+x+fSI4ivKM3ZS+PMBW9tfM9/oethx6C3qz8
         W034IQinOuk/gVo9Udd5NGjEQ3w0ln4L1cwDO6jHtd150nb2wWCUXeMqNH5VkOphyGYJ
         U6VzRxEadmxV1KQk9AHMPvn6nbP/5PS7clUjMVMFI0fe3QPLGQL/y0HRrxfB1B8lvHoD
         xti7zZxbZ6jQtaHbNLVR8aNJRr/sRjPWqjMwVOSVTtzpSyuRdtLjIrII0AvKRehFsoPg
         16yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792466242; x=1793071042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=crdiqAdX0WongrBaAIeIY+l9rwOhSUcXzcgQ4HTO0HQ=;
        b=eR6mjN0evPZaPn/0B0WcYSJp8REz8aMOM6QQqzoFbr0nPArm8GxgTqCvgUnRgd1fMg
         cjfEyf/bskDYddYjuKvdLxWRdtiLhdGX8EdvQTqhGBqvrVat+LxqKs5eaWlDuMjwkdT2
         TNOdx+ZfzFXRCUT3LieIMOPkGCHJuIB7r5kdgK4IiYg0ULTyYiC1GlEWMeRK8fJzCGxu
         hmpBhfV8lddsUgwcSHtlGHPy6ALRJRN2pjmOLfZWYKuGqIVxOrw9OdQgU4yKG4HHLktP
         WP0IFs+S22Bmx4WueG0h89vkur18P5pjeD6ZrGZDQ4bjYnBR7BF4X8HkPcMKSnkS0b++
         Rj0A==
X-Gm-Message-State: AFq9FYIwozR7DO/4wA14+MaesJlQT48jZNBPQ41F9bH5gCcn2fFVaTPs
	uoHBMliNuFG5nTy6JjlqeeQY82j8vCjkSwpDA1aXdo2+gh5g8rz6DV8hSoEgEw==
X-Gm-Gg: AYBFou2QkND0hZIofjXYQRMIQ7G0QnXRRrXJs6gxKRRgQLtuJp5R+Gzr2sST3kTB7bO
	JrO8+I2Mw1e4t00mezaVfqx1TDocs7IuNeufthffhMgvXR2K0Mbton4lDnO2qkU/iVGvXB3aZe3
	8HL6Ih/6NgTcrSXxxPRvqedng5NJ2Pxel8oCDdPqXPsgRuFPw3E9b5t/BadeG3q7VKRoYL/Byl/
	JlcXose81jrmVPg0scMpaE5B+M442oFrKWcyReCWiCVj8tTO0vYcEe9/BV1nJPfHvRepqDo/lo2
	MHbm+uHkxlLGuhcXhpfC0ynUDYtHYZqtAuDLJn4j0MI3sRMJEEJd+qQrnlssSh7FProlwiNyqNF
	soKKxk5jfFoI3LOL16WwFWNeK56R27kxCd9HWwWtILFQd939O4BKiHs2XUpuSaHnYkHYSMlkGDM
	iEx5rkubqHxRbfpyb9wacGEMIqjQFtD7WxFDPpuNuMWUKgvxDCBPBzuzy3n05i9BU6PIhE93VBi
	LfambJDt4jRdO3U8luUIzazdHDAyey4DLBvUl9Hq6ualVglok/A9JNLNG5+Pyl17v1w6AX4w8Mv
	80UBnjTjtn+CpLstcoEweNEuPeF7QtNd5A120y3l5QM=
X-Received: by 2002:a05:7301:77cb:b0:353:7b46:4819 with SMTP id 5a478bee46e88-361a1365d64mr12849346eec.8.1792466241592;
        Mon, 19 Oct 2026 20:17:21 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360826875b3sm38473608eec.21.2026.10.19.20.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 20:17:21 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v7 2/6] netlink: specs: mptcp: add the subflow-retries attribute
Date: Tue, 20 Oct 2026 03:17:07 +0000
Message-Id: <20261020031711.1896660-3-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261020031711.1896660-1-anilkaushikwireless@gmail.com>
References: <20261020031711.1896660-1-anilkaushikwireless@gmail.com>
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
retransmissions of a subflow re-created after an error, with the other
limits: add it to the set-limits and get-limits commands.

The uapi header and the generated files are updated with ynl-regen.

Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
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
index 39f3facc38e5..76b5407bd4c4 100644
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
+          SYN retries of a subflow re-created after an error, like the
+          TCP_SYNCNT socket option, so with tcp_syn_linear_timeouts on top.
+          15 by default, 0 to not re-create it. The maximum is
+          MAX_TCP_SYNCNT.
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

