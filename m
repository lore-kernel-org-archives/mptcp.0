Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12FFC2C8
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129821; cv=none; b=sS8Nx9qZ2EE4/7C++JufYd4uhE5M6GfGHShoIqafDxzpGEpFra3msw4eb9wTiz6vR5v8xLofHKUIks0I2WUB5WzqPEWQjJblORXSrD4B0zuCXEuMt4rpq0lp133HOKJ0x9H8a5ZaU2OcMClmA8g35hHds7TGT7bvvLGNqtmJZPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129821; c=relaxed/simple;
	bh=Ja0b8RMvRigxqlwDvhWiK/CGM2uIh1ychM5RGzO7mP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UmjlDDtfLUAR5pOZ2IVvLTK/lE5VL7SGyxqFN/AciequRE3Bz9IWi7okarKPpjc4ItvcOLE1eM2/ww8z35GVuio7x6G56Db+MN2imgZn7iJMaT1QZ0INp+bQi4YQ2/cjv5x8OJbzH0MetTtMxl9wuf26MjzFK3WctTytJeOVhjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNxH5P99; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNxH5P99"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35f1f76ea84so2977319eec.1
        for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 22:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792129819; x=1792734619; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BMBWbtQif7wba5PSMMMho8H/LBwdZGpG/6LtkI5qyoM=;
        b=nNxH5P99javEyei32VOCVh5sTd/Fw60lCRmMWbYLXV6pThvz35OiPSTtpWX09BIrSE
         K992ca4NBYQ8i2B1b4mLtF5WV8NO2cTGiBTCgwjhiyqPxcR7lIFFSSJELIAGwXawW8zy
         2WyHJ9qwPvgkiTRe5neKRQPwgyiCXM22fP3z9zKEFSiEz2zUbgSeCD399+EInSBP5v0w
         diXbv9cYwGXQM642Y7c3ZX2ZammnX0tMcbM73gg8PuPmc9haanooVdb+qY9Tfocj8/cr
         qVCPS4UE5GIQKYmCXl/W3YEuo9J3erGPKu+uIyaQEE66sVJ2Kcw9XSyIW2ZHjxBHcifn
         HYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792129819; x=1792734619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BMBWbtQif7wba5PSMMMho8H/LBwdZGpG/6LtkI5qyoM=;
        b=AVMf4/HWthNKThrm9hqqQEi0fDUU6FKD1Vg56eihIsgXa19Be+sSMPScX1H4Zqbtwy
         Y64kax7JQ+cFl5wiDLO2X1WIevKsKjwLFnMXcCXGM9UfJzhR/RdvVE4fXlPedgupuom6
         9j0KxWu2W9u6zLJw0+syhVsOJcVgDgIVHV7urp/9zL1FxwNBlehoiBWtb2jfCw4wdAum
         GJJNbBpfk/o7Lrqbn8VXkuvX0W378j9FeHJiN0DOcGfpF+tGQGPcW4GA4MPWsQwSJCC/
         OVmGrYu1wsudeT0v8/W5QaxNeWk8zAs1b1QjJ+3V2vQq32WjFQ+wNwfg0excyAP/Ra8e
         40ng==
X-Gm-Message-State: AFq9FYJlw3R7ba1SJcolrPg6NPleCoEPFkVvdN10/F+hksHRpJMYvU4U
	qgs+PgVOnwKA/jfggIEg46Zo8EpXFpuXcc76Vw2Whi4kqF9yOCL6/m8ZrOuWbA==
X-Gm-Gg: AYBFou3z+YnVVCSh729oENpvfoAnm+w4KkHLZ80Q7CwUXgdeRzkY76kP7eVcXPeGwcZ
	HOaPa+T6H7v+sKne7x5CbCa9G8BAAeCe/9IjnidyBD+adR5F3ElXdQzX28OPvUxRKd8NZ8P3wA9
	l6AD4uaA5fE3qU8AaQ5CiPdj7e8OPVvxQ/LWeJIuKcZdmjSbW5PA/10NwVFP4m51oitb+RGqEOd
	wh2XteR2lF70MmAT4tmk8d+HBJX57c0XgaLTSukt9VuhwpnNEgEvouLCOb1q/lKDkuSUxA1VMYZ
	NVr2ocTeSCqNQa36G0oOCyYtmmi0kzc8r/Zt6yuZQWoDEYfPXabilwBTtZSA25T/3G0R6eJI435
	RDqIREZsIBDYUe0qo1VDpOko7GPbDQc+AcHVctau/OQjptrbvmbvd8gSicdbxLYZNfIvzKsjFMf
	nDcdnJ30nylebqE/ZQ1xMDMfdVXmD4D0gRYVZHSgFqJ8jPswWlFr/sk+2DTiQH7MTjxujdcgiCu
	9jLKFUC5rPwdsdnWhhIxRP1PbwNBpanv6swn8z9UojA1HecyYvh30dZfUS9we6kO6TB5MWQhpZE
	RMej/j+48VZF+XaX9BZCnrql6O/N/B6l3jCwGjicnpU=
X-Received: by 2002:a05:7300:4628:b0:34d:2c1a:9892 with SMTP id 5a478bee46e88-3537e2773e4mr27778708eec.40.1792129818425;
        Thu, 15 Oct 2026 22:50:18 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6791sm3928803eec.6.2026.10.15.22.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 22:50:17 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v4 2/3] mptcp: pm: kernel: retry subflows closed after an error
Date: Fri, 16 Oct 2026 05:50:09 +0000
Message-Id: <20261016055010.980819-3-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261016055010.980819-1-anilkaushikwireless@gmail.com>
References: <20261016055010.980819-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the in-kernel PM, a subflow closed after an error, e.g. a timeout
when a path silently drops packets, is never re-created, even once the
path works again. For example, with a main link and a backup link,
connections move to the backup after an outage but never come back.

When TCP closes a subflow created by this side after an error, the PM
now creates a new one with the same addresses. Its SYN retransmissions
space out the attempts. Their number is set by a new limit,
subflow-retries: 15 by default, about 20 minutes, and 0 disables it. If
this new subflow cannot connect, it is not retried again. Once it is
established, it is handled like any other subflow. Re-creating the
initial subflow uses one of the additional subflows allowed by the
limits.

Subflows refused by the peer, reset by the peer with an MP_RST without
the transient flag (RFC 8684 section 3.6), aborted locally, or whose
endpoint has been removed are not retried.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440
Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v4 (Matthieu):
     - netlink limit, on by default, instead of the sysctl
     - one new subflow per failure, its SYN retries set from the limit: no
       socket reuse, no attempts counter, no 60s check
     - no MIB counter
     - not retried if the endpoint was removed, instead of the pm.c change
     - called through pm.c
     - new bit in the subflow context, no new hole
     - commit message: MP_RST, not any RST (Sashiko)
    v3 (Sashiko):
     - no retry after MP_RST without the T flag, local abort or EBADMSG
     - no retry on a removed endpoint or address
     - use only request_bkup for the backup flag
    v2:
     - use the subflow sockets, no list or timer
     - code moved to pm_kernel.c

 Documentation/netlink/specs/mptcp_pm.yaml |   9 ++
 include/uapi/linux/mptcp_pm.h             |   1 +
 net/mptcp/mptcp_pm_gen.c                  |  10 +-
 net/mptcp/mptcp_pm_gen.h                  |   4 +-
 net/mptcp/pm.c                            |  20 +++
 net/mptcp/pm_kernel.c                     | 149 +++++++++++++++++++++-
 net/mptcp/protocol.c                      |   5 +
 net/mptcp/protocol.h                      |  18 +++
 8 files changed, 203 insertions(+), 13 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 39f3facc38e5..1b481908980c 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -196,6 +196,12 @@ attribute-sets:
         name: addr-remote
         type: nest
         nested-attributes: address
+      -
+        name: subflow-retries
+        type: u32
+        doc: |
+          SYN retransmissions of a subflow re-created after an error, 0 to
+          not re-create it.
   -
     name: event-attr
     enum-name: mptcp-event-attr
@@ -327,6 +333,7 @@ operations:
           attributes:
             - rcv-add-addrs
             - subflows
+            - subflow-retries
     -
       name: get-limits
       doc: Get protocol limits
@@ -337,10 +344,12 @@ operations:
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
index c180930a8e0e..127a1fadaac4 100644
--- a/net/mptcp/mptcp_pm_gen.c
+++ b/net/mptcp/mptcp_pm_gen.c
@@ -44,15 +44,17 @@ const struct nla_policy mptcp_pm_flush_addrs_nl_policy[MPTCP_PM_ENDPOINT_ADDR +
 };
 
 /* MPTCP_PM_CMD_SET_LIMITS - do */
-const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
+const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOW_RETRIES + 1] = {
 	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
 	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_SUBFLOW_RETRIES] = { .type = NLA_U32, },
 };
 
 /* MPTCP_PM_CMD_GET_LIMITS - do */
-const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
+const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOW_RETRIES + 1] = {
 	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
 	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_SUBFLOW_RETRIES] = { .type = NLA_U32, },
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
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d7c5b50b34cc..1bea4012d7f1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -694,6 +694,26 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 	spin_unlock_bh(&pm->lock);
 }
 
+/* Called with the msk socket lock held, before closing a subflow: true if
+ * it has to be re-created once closed, see mptcp_pm_subflow_retry().
+ */
+bool mptcp_pm_subflow_retry_check(struct mptcp_sock *msk,
+				  const struct mptcp_subflow_context *subflow,
+				  struct mptcp_pm_retry *retry)
+{
+	if (!mptcp_pm_is_kernel(msk))
+		return false;
+
+	return mptcp_pm_kernel_retry_check(msk, subflow, retry);
+}
+
+void mptcp_pm_subflow_retry(struct mptcp_sock *msk,
+			    const struct mptcp_pm_retry *retry)
+{
+	if (mptcp_pm_is_kernel(msk))
+		mptcp_pm_kernel_retry(msk, retry);
+}
+
 void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr)
 {
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d3014bf57bf3..6c081a9c664c 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -25,6 +25,7 @@ struct pm_nl_pernet {
 	u8			endp_fullmesh_max;
 	u8			limit_add_addr_accepted;
 	u8			limit_extra_subflows;
+	u8			limit_subflow_retries;
 	u8			next_id;
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 };
@@ -1399,7 +1400,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 	return msg->len;
 }
 
-static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
+static int parse_limit(struct genl_info *info, int id, unsigned int *limit,
+		       unsigned int max)
 {
 	struct nlattr *attr = info->attrs[id];
 
@@ -1407,10 +1409,9 @@ static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 		return 0;
 
 	*limit = nla_get_u32(attr);
-	if (*limit > MPTCP_PM_SUBFLOWS_MAX) {
+	if (*limit > max) {
 		NL_SET_ERR_MSG_ATTR_FMT(info->extack, attr,
-					"limit greater than maximum (%u)",
-					MPTCP_PM_SUBFLOWS_MAX);
+					"limit greater than maximum (%u)", max);
 		return -EINVAL;
 	}
 	return 0;
@@ -1419,22 +1420,31 @@ static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	unsigned int rcv_addrs, subflows;
+	unsigned int rcv_addrs, subflows, retries;
 	int ret;
 
 	spin_lock_bh(&pernet->lock);
 	rcv_addrs = pernet->limit_add_addr_accepted;
-	ret = parse_limit(info, MPTCP_PM_ATTR_RCV_ADD_ADDRS, &rcv_addrs);
+	ret = parse_limit(info, MPTCP_PM_ATTR_RCV_ADD_ADDRS, &rcv_addrs,
+			  MPTCP_PM_SUBFLOWS_MAX);
 	if (ret)
 		goto unlock;
 
 	subflows = pernet->limit_extra_subflows;
-	ret = parse_limit(info, MPTCP_PM_ATTR_SUBFLOWS, &subflows);
+	ret = parse_limit(info, MPTCP_PM_ATTR_SUBFLOWS, &subflows,
+			  MPTCP_PM_SUBFLOWS_MAX);
+	if (ret)
+		goto unlock;
+
+	retries = pernet->limit_subflow_retries;
+	ret = parse_limit(info, MPTCP_PM_ATTR_SUBFLOW_RETRIES, &retries,
+			  MAX_TCP_SYNCNT);
 	if (ret)
 		goto unlock;
 
 	WRITE_ONCE(pernet->limit_add_addr_accepted, rcv_addrs);
 	WRITE_ONCE(pernet->limit_extra_subflows, subflows);
+	WRITE_ONCE(pernet->limit_subflow_retries, retries);
 
 unlock:
 	spin_unlock_bh(&pernet->lock);
@@ -1464,6 +1474,10 @@ int mptcp_pm_nl_get_limits_doit(struct sk_buff *skb, struct genl_info *info)
 			READ_ONCE(pernet->limit_extra_subflows)))
 		goto fail;
 
+	if (nla_put_u32(msg, MPTCP_PM_ATTR_SUBFLOW_RETRIES,
+			READ_ONCE(pernet->limit_subflow_retries)))
+		goto fail;
+
 	genlmsg_end(msg, reply);
 	return genlmsg_reply(msg, info);
 
@@ -1591,6 +1605,125 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 	return true;
 }
 
+static bool mptcp_pm_retry_path_error(int err)
+{
+	switch (err) {
+	case ETIMEDOUT:
+	case EHOSTUNREACH:
+	case ENETUNREACH:
+	case EHOSTDOWN:
+	case ENETDOWN:
+		return true;
+	}
+
+	return false;
+}
+
+/* Called with the msk socket lock held, before the subflow is closed */
+bool mptcp_pm_kernel_retry_check(struct mptcp_sock *msk,
+				 const struct mptcp_subflow_context *subflow,
+				 struct mptcp_pm_retry *retry)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	bool established = READ_ONCE(subflow->fully_established);
+	struct sock *sk = (struct sock *)msk;
+	int err = READ_ONCE(ssk->sk_err);
+	bool endp_found;
+	u8 id;
+
+	retry->syn_retries = READ_ONCE(pernet->limit_subflow_retries);
+	if (!retry->syn_retries || !err || sk->sk_state != TCP_ESTABLISHED ||
+	    __mptcp_check_fallback(msk))
+		return false;
+
+	/* mptcp_close_ssk() will not handle it again, e.g. the initial
+	 * subflow, kept in the list once closed
+	 */
+	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
+		return false;
+
+	/* A single attempt: its SYN retransmissions space out the tries */
+	if (subflow->retry && !established)
+		return false;
+
+	/* The peer asked not to use this path again (MP_RST without the T
+	 * flag), the subflow has been aborted locally, or it hit an MPTCP
+	 * protocol error.
+	 */
+	if ((subflow->reset_seen && !subflow->reset_transient) ||
+	    err == ECONNABORTED || err == EBADMSG)
+		return false;
+
+	/* A subflow that never got established is retried only after network
+	 * errors: if the peer rejected it, trying again will not help.
+	 */
+	if (!established && !mptcp_pm_retry_path_error(err))
+		return false;
+
+	/* Only re-create subflows initiated by this side: MP_JOIN ones, or the
+	 * initial one on the client side.
+	 */
+	if (!subflow->request_join &&
+	    (subflow->mp_join || READ_ONCE(msk->pm.server_side)))
+		return false;
+
+	/* not if its endpoint has been removed */
+	id = subflow_get_local_id(subflow);
+	if (id) {
+		rcu_read_lock();
+		endp_found = !!__lookup_addr_by_id(pernet, id);
+		rcu_read_unlock();
+		if (!endp_found)
+			return false;
+	}
+
+	mptcp_remote_address((struct sock_common *)ssk, &retry->remote);
+	retry->remote.id = READ_ONCE(subflow->remote_id);
+	if (!retry->remote.id && READ_ONCE(msk->pm.remote_deny_join_id0))
+		return false;
+
+	mptcp_local_address((struct sock_common *)ssk, &retry->local.addr);
+	retry->local.addr.port = 0;
+	retry->local.addr.id = id;
+	retry->local.flags = subflow->request_bkup ?
+			     MPTCP_PM_ADDR_FLAG_BACKUP : 0;
+	retry->local.ifindex = ssk->sk_bound_dev_if;
+
+	return true;
+}
+
+/* Called with the msk socket lock held, after the subflow has been closed */
+void mptcp_pm_kernel_retry(struct mptcp_sock *msk,
+			   const struct mptcp_pm_retry *retry)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	struct sock *ssk;
+	bool allowed;
+
+	spin_lock_bh(&msk->pm.lock);
+	allowed = msk->pm.extra_subflows <
+		  mptcp_pm_get_limit_extra_subflows(msk);
+	if (allowed)
+		msk->pm.extra_subflows++;
+	spin_unlock_bh(&msk->pm.lock);
+
+	if (!allowed ||
+	    __mptcp_subflow_connect(sk, &retry->local, &retry->remote))
+		return;
+
+	/* the new subflow is the last one */
+	subflow = list_last_entry(&msk->conn_list, struct mptcp_subflow_context,
+				  node);
+	ssk = mptcp_subflow_tcp_sock(subflow);
+
+	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	WRITE_ONCE(inet_csk(ssk)->icsk_syn_retries, retry->syn_retries);
+	subflow->retry = 1;
+	release_sock(ssk);
+}
+
 /* Called under PM lock */
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
 {
@@ -1618,6 +1751,8 @@ static int __net_init pm_nl_init_net(struct net *net)
 
 	/* Cit. 2 subflows ought to be enough for anybody. */
 	pernet->limit_extra_subflows = 2;
+	/* about 20 minutes with the default RTO values */
+	pernet->limit_subflow_retries = 15;
 	pernet->next_id = 1;
 	spin_lock_init(&pernet->lock);
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 60cbd91be632..307a818d4783 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2816,6 +2816,8 @@ static void __mptcp_close_subflow(struct sock *sk)
 	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		int ssk_state = inet_sk_state_load(ssk);
+		struct mptcp_pm_retry retry;
+		bool do_retry;
 
 		if (ssk_state != TCP_CLOSE &&
 		    (ssk_state != TCP_CLOSE_WAIT ||
@@ -2827,7 +2829,10 @@ static void __mptcp_close_subflow(struct sock *sk)
 		if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
 			continue;
 
+		do_retry = mptcp_pm_subflow_retry_check(msk, subflow, &retry);
 		mptcp_close_ssk(sk, ssk, subflow);
+		if (do_retry)
+			mptcp_pm_subflow_retry(msk, &retry);
 	}
 
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ed2f363bb915..ab916c75e406 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -621,6 +621,7 @@ struct mptcp_subflow_context {
 	u8	reset_seen:1;
 	u8	reset_transient:1;
 	u8	reset_reason:4;
+	u8	retry:1;	    /* re-created after an error */
 	u8	stale_count;	    /* Protected by the msk socket lock */
 	u8	stale;		    /* Protected by the msk socket lock,
 				     * if set the subflow is unable to snd/rcv
@@ -1137,6 +1138,18 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk);
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
 void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow);
+
+struct mptcp_pm_retry {
+	struct mptcp_pm_local	local;
+	struct mptcp_addr_info	remote;
+	u8			syn_retries;
+};
+
+bool mptcp_pm_subflow_retry_check(struct mptcp_sock *msk,
+				  const struct mptcp_subflow_context *subflow,
+				  struct mptcp_pm_retry *retry);
+void mptcp_pm_subflow_retry(struct mptcp_sock *msk,
+			    const struct mptcp_pm_retry *retry);
 void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
@@ -1258,6 +1271,11 @@ void __init mptcp_pm_userspace_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
+bool mptcp_pm_kernel_retry_check(struct mptcp_sock *msk,
+				 const struct mptcp_subflow_context *subflow,
+				 struct mptcp_pm_retry *retry);
+void mptcp_pm_kernel_retry(struct mptcp_sock *msk,
+			   const struct mptcp_pm_retry *retry);
 u8 mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_laminar_max(const struct mptcp_sock *msk);
-- 
2.25.1

