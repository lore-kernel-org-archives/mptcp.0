Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE2468
	for <mptcp@lists.linux.dev>; Tue, 30 Nov 2021 16:20:52 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id a9so45654912wrr.8
        for <mptcp@lists.linux.dev>; Tue, 30 Nov 2021 08:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XyNE8TDU+ILWiPnvNzAzgaXompnrNsybkYA/rXwiZs8=;
        b=YhIn3zh4U8JXHON2GXKeB6cesdUwWriXYKKmQveTGRpieG94sZDPybkBUPlNM/kTgX
         k2bPJNALkVdprCHkhWOfqz1wp2/m3wwf5cb/M1wBPVDq482gXDC62yrh30GLygNrLjeY
         gRF3qJnxCcluav5/a5Y29YIi7Ph5wv85osVzjufzLMPT9s8IdcV4B6dzSd9akGIdfzx/
         af/JckU3DLugM6q57MZsjG5ctIc7QafQDFhuCfdRYuPxn1W/9e6YUSKb8BD8YhJMq4lK
         WH7mu9IP+/klG13orFlmp8b8VtJjVWcjl3ILhFkY7lo+E8jmKqaTFGFicljVr/wbYFv7
         kyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XyNE8TDU+ILWiPnvNzAzgaXompnrNsybkYA/rXwiZs8=;
        b=XSMrMXOn5xOdEpCXu1kfk9qYHUzc9b72qlb5Rv+Hg/Q9ju6sMYnjEk8V1Vlqp4/y/z
         RvwbIju0+7iD002Gn4Gi3s9P2HgBC5O7I5czWXjwK7NxOdBavZSLYYxuQR4+9+1xj7hK
         BK+m9Jd7U/PDTpnI3UwJuc/w/pO7CbrEnhJraPavezki5dV0k5xezjPqJDzLmBFXIeOL
         nScaYYPj88gro39a0NJp0jkMsNDAf3qAVW0dQj+2TYkEP+66x4dxBljaeDLdtNbVLGQW
         ItSsglWiH3l1BnHnTV8QqKzEr49OPsCuLwPHt1UL8HYiJWRDtCjzcn7Ad62H9ZeFHA+e
         SwpA==
X-Gm-Message-State: AOAM533q9XtBmZ+e4RY/9h7a2WJvttDexNo7NmKzPZ4nhD38BUAGx0kb
	jS2GFAspxhLk8z9CGIRG0l6VI8OmAeunXdTP
X-Google-Smtp-Source: ABdhPJyNWaEejYu4bfL3HayQvJZq5lQb6MdpEmBJuZREsIDyQjr9rfonjqTtecR721MNsBD5Lvi0mA==
X-Received: by 2002:adf:f907:: with SMTP id b7mr41671970wrr.5.1638289250716;
        Tue, 30 Nov 2021 08:20:50 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id t4sm2692306wmi.48.2021.11.30.08.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:20:50 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net] mptcp: add missing documented NL params
Date: Tue, 30 Nov 2021 17:20:26 +0100
Message-Id: <20211130162026.1455269-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'loc_id' and 'rem_id' are set in all events linked to subflows but those
were missing in the events description in the comments.

Fixes: b911c97c7dc7 ("mptcp: add netlink event support")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 include/uapi/linux/mptcp.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index c8cc46f80a16..f106a3941cdf 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -136,19 +136,21 @@ struct mptcp_info {
  * MPTCP_EVENT_REMOVED: token, rem_id
  * An address has been lost by the peer.
  *
- * MPTCP_EVENT_SUB_ESTABLISHED: token, family, saddr4 | saddr6,
- *                              daddr4 | daddr6, sport, dport, backup,
- *                              if_idx [, error]
+ * MPTCP_EVENT_SUB_ESTABLISHED: token, family, loc_id, rem_id,
+ *                              saddr4 | saddr6, daddr4 | daddr6, sport,
+ *                              dport, backup, if_idx [, error]
  * A new subflow has been established. 'error' should not be set.
  *
- * MPTCP_EVENT_SUB_CLOSED: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *                         sport, dport, backup, if_idx [, error]
+ * MPTCP_EVENT_SUB_CLOSED: token, family, loc_id, rem_id, saddr4 | saddr6,
+ *                         daddr4 | daddr6, sport, dport, backup, if_idx
+ *                         [, error]
  * A subflow has been closed. An error (copy of sk_err) could be set if an
  * error has been detected for this subflow.
  *
- * MPTCP_EVENT_SUB_PRIORITY: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *                           sport, dport, backup, if_idx [, error]
- *       The priority of a subflow has changed. 'error' should not be set.
+ * MPTCP_EVENT_SUB_PRIORITY: token, family, loc_id, rem_id, saddr4 | saddr6,
+ *                           daddr4 | daddr6, sport, dport, backup, if_idx
+ *                           [, error]
+ * The priority of a subflow has changed. 'error' should not be set.
  */
 enum mptcp_event_type {
 	MPTCP_EVENT_UNSPEC = 0,
-- 
2.32.0

