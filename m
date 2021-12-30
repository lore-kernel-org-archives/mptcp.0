Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8752C80
	for <mptcp@lists.linux.dev>; Thu, 30 Dec 2021 19:17:53 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id w16so101506453edc.11
        for <mptcp@lists.linux.dev>; Thu, 30 Dec 2021 11:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ISRM4adwNoqkzh7B445fjcCrFszOmyg8baD6T4jy2dA=;
        b=1aKO9SiF5D3KwrxH6wUQCO1yd6iXx41+RmVixn/2b9aUW7tSC6EcSmwH266DnWp0ka
         qWzA9CatQFKzbNIoi7i9S52koOmoJO1853R8qYc9f/MqJZkoo4VZfZpWjazGe5sXNsq4
         +yv6WPnfHn1Gj9idMQBy5UmWZRrRq4ymcoHgbAdfvO6DwqE8hOdjP1dg1Hbx+IaJ97NH
         9P7Jag2kk9z0cDq4Jzs16x1kLzH9wV770ltuZplDxygD+sLhF0GTI/ec/oMLPxKWztHR
         6pErJXZ7QR9bB5UiXvrLL3v3rfvHUeN3dov6COt5VtO+BKG42ausgmvr4DJQyIGzWOHc
         qHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ISRM4adwNoqkzh7B445fjcCrFszOmyg8baD6T4jy2dA=;
        b=FvzlYBAnU/hLkkvAc4iQV15Ur1OTuHR7SwelHSgKP1KRsAggykdVyJw75Tuy5EdsXR
         xOSCYcqLnzJTw1oHuR3dw7fMQtdTBZQLMcnZpzaS4VA0bnkUS7qUqEsTYjN4Sno6/P4S
         zOjGyZZmgBKS/K7gv8ckRtbBkcwpNyGyIsm8j67zjSlhmI1wDm4Dd/rjBV8Av35XyHtK
         4MxY9akHM49vfYBpXyVczAanelVXuJIJJlTvek25HlxMLurgI+iNxl+DzVODlbdABv+Y
         9jQqWiCRUoj7OEERmsBysN3zoWfAQ2oDCgtCjXfRZWi8/wLp6kIaZ7GGjbVCOOdSfOYi
         IYuQ==
X-Gm-Message-State: AOAM533V81Qu1dYqqsJa2iREN3MO9fSQZw/NaSWTo062winJaWCv8VeE
	R0ELYNlpj0++0TGm2ogLoMRv7Faoy29zjatU
X-Google-Smtp-Source: ABdhPJz13+Fg0CcPZopFz4EPxAQQrMzHHU5Tl7LlJ9cKxGtYmoEvqgLMASO5frvmuT3KTjvhwXKWtg==
X-Received: by 2002:a17:906:390c:: with SMTP id f12mr26171042eje.95.1640891871468;
        Thu, 30 Dec 2021 11:17:51 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id m6sm9918244edc.36.2021.12.30.11.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 11:17:51 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v7 3/4] mptcp: clarify when options can be used
Date: Thu, 30 Dec 2021 20:16:50 +0100
Message-Id: <20211230191651.1831507-4-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211230191651.1831507-1-matthieu.baerts@tessares.net>
References: <20211230191651.1831507-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC8684 doesn't seem to clearly specify which MPTCP options can be used
together.

Some options are mutually exclusive -- e.g. MP_CAPABLE and MP_JOIN --,
some can be used together -- e.g. DSS + MP_PRIO --, some can but we
prefer not to -- e.g. DSS + ADD_ADDR -- and some have to be used
together at some points -- e.g. MP_FAIL and DSS.

We need to clarify this as a base before allowing other modifications.

For example, does it make sense to send a RM_ADDR with an MPC or MPJ?
This remains open for possible future discussions.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3427b31c0da7..d06855e66007 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1263,8 +1263,27 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
 void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
-	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and FAIL are mutually exclusive,
-	 * see mptcp_established_options*()
+	/* Which options can be used together?
+	 *
+	 * X: mutually exclusive
+	 * O: often used together
+	 * C: can be used together in some cases
+	 * P: could be used together but we prefer not to (optimisations)
+	 *
+	 *  Opt: | MPC  | MPJ  | DSS  | ADD  |  RM  | PRIO | FAIL |  FC  |
+	 * ------|------|------|------|------|------|------|------|------|
+	 *  MPC  |------|------|------|------|------|------|------|------|
+	 *  MPJ  |  X   |------|------|------|------|------|------|------|
+	 *  DSS  |  X   |  X   |------|------|------|------|------|------|
+	 *  ADD  |  X   |  X   |  P   |------|------|------|------|------|
+	 *  RM   |  C   |  C   |  C   |  C   |------|------|------|------|
+	 *  PRIO |  X   |  C   |  C   |  C   |  C   |------|------|------|
+	 *  FAIL |  X   |  X   |  C   |  X   |  X   |  X   |------|------|
+	 *  FC   |  X   |  X   |  X   |  X   |  X   |  X   |  X   |------|
+	 *  RST  |  X   |  X   |  X   |  X   |  X   |  X   |  O   |  O   |
+	 * ------|------|------|------|------|------|------|------|------|
+	 *
+	 * The same applies in mptcp_established_options() function.
 	 */
 	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
 		struct mptcp_ext *mpext = &opts->ext_copy;
-- 
2.33.1

