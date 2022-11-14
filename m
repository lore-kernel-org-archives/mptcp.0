Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA7F748D
	for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 16:46:40 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id m22so29723885eji.10
        for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 08:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zkmm5yo+LEUNzh4RgPaxcXQpJfatkpD1ywiiDs8uNk=;
        b=DXFRZnChPdZlHqz6eZjuLV9X3d0C9bzYaWg8SPXDq4ma2J8JdZWuG7fZ3kKGw/PCjb
         6GsuCIdEfBaplgrUDmIhuW8/AbVf1WhdwVT9fc9KhBEUH+fbXyUXsequQ3GUxXC1iZKY
         FIuMbWOOA1PYrCsCYZmT2P7bkpyvTnxD0eXwHRMGzVZxK2eMDpbd9toNJFMabiMSVSdQ
         d5jA5Z2daDR8Z2OEC79+brMR/9BpnOX8NlAWI47l1Iok2gYL5IijM/xf42So6lFB2I+t
         7ATEfVES2zKOnbhemdRQv9yoFYAPWr/pm4l5/Gd5Rb5bid6biAc3RtUUYhDsE/+8aWiG
         Tdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zkmm5yo+LEUNzh4RgPaxcXQpJfatkpD1ywiiDs8uNk=;
        b=ftr4d/CJCeonl1AFFfhHdLb2Tx7zRnK4xVQRLen1OK0GKsy5GthciPeY71GAiv/iQs
         CTSe35Jp+mxD10mHlFJyuwfLBupUq0BJ0lcd5ofcLPOB8LBZbmW95g0m2UrqGKVZi2Fx
         FUem7nK0NwIAJz3dd/JT4qbrmXXy846lvUqRbos/VZcNfpTlxpgI4maJVp7rRloRtPOo
         zHV3PqSsUb3GpYQx3aeV69ycuAhakYqDSCK8T8+sd3UiOnRum9ocVjkQOcjSzcY+gFcn
         aX0KrRYIGUsDNlo3y9O2X/1uDLmEh8EjD5Vi9iwiiIdVU7o+0AJczQ/Llypnir8l9Wwp
         uhGg==
X-Gm-Message-State: ANoB5pna3JISvq7Rc5lx8Kr94GLuMu/lwiwSKka2a5E/4EdrKFER86KQ
	pbWCBOAs3dPmvaVnmEqiAEIOkfOQSxc1Qw==
X-Google-Smtp-Source: AA0mqf4+rtmsVPV4eOo6t+PshURfYg0/2zu6NKKgrq1/h08oLGrJ8XqZqi7AbJCApquJrvhrQSR1Aw==
X-Received: by 2002:a17:906:54cf:b0:78a:d075:98d8 with SMTP id c15-20020a17090654cf00b0078ad07598d8mr10917645ejp.324.1668444398682;
        Mon, 14 Nov 2022 08:46:38 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id qq18-20020a17090720d200b00773f3ccd989sm4377877ejb.68.2022.11.14.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:46:38 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 3/5] Squash-to (part 2): "mptcp: add subflow_v(4,6)_send_synack()"
Date: Mon, 14 Nov 2022 17:45:59 +0100
Message-Id: <20221114164601.861295-4-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221114164601.861295-1-matthieu.baerts@tessares.net>
References: <20221114164601.861295-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=euLpY50T179Wa622ZzutZ0itzbhv/F18nUK4JxDC6wY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjcnAxbg2NP+GB51QpHkwnHHrPHw3Sozbb8y+J+lCS
 0czBnIaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY3JwMQAKCRD2t4JPQmmgc08cEA
 DJxdm/lc/wL5HgHXfIOwUjvqGgcJW0icM2iU3SDJpJdgEFJB3FEOokNvSOS92EzYpAcNk2GaE6MBp3
 426QQUX2G8tgV+oAY+cDTZSDthA0ncx86MdhX7jsZwjXmtJ+kzB0JJUra8Zh9FzHLFADSAY8RlYw1S
 KoTIMhdQZU+EcBi3T5qp5TIuM0ebBd/F7yGkivSFlB11qZrGyovemIROQCZS/9ujOu+M4ABai7e7IY
 8qYawdU2BM4tKbPQVslVsGAOzj44ouRJsQnYhNNtrepdiVqoq+AiL8V38VwxwUvWG5cHTh7LBJu7wY
 L9M0UB75ktKT7pRTKGsy1ZbxBsdmPhRJd4H+nKC8r7CnMkL0/7x3gsKvKdYDz6xwkyxdMeQIxa+5wj
 2EVszYflw1oGLHgwh7mDFd6ng/G/DhOZk84Jr42unv7v9yZRRqgTNGpzTPhYiS0hbMg5Ayzpcy2vDO
 DWQZsHnf2bTV5l1Lvixxb9NY5FZkGpImnjUtFoZ9z60PitFulqxtgOVZpC0YyAadEh65p9A1EbyOeA
 x37dFmdE1d8GdlNMqtZtBTwHx91KAq0K7VQq/sXcDHzJjcxS2Pd6G9HqgxZOruPEPLFE6GJ6s6HPaV
 W8EudwrxnhUFC+cR6dVS6ZbdAPBldZZntW+Y2gvRBi9lQROZXW9FqQACO42Q==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

mptcp: move mptcp_set_owner_r() signature with others from protocol.c

Because this function is not specific to fastopen functions.

I added it at the end of the list there because there is no real order.
Maybe we should order them differently to reduce conflicts in case of
backports? Anyway, that would not be don't in this patch.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ad204ef88bc3..20c0cf9fe453 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -633,6 +633,7 @@ void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
+void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);
@@ -850,7 +851,6 @@ bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
 void mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
 				   const struct mptcp_options_received *mp_opt);
-void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
 
-- 
2.37.2

