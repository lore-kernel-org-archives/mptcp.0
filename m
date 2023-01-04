Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D49AD52
	for <mptcp@lists.linux.dev>; Wed,  4 Jan 2023 17:15:59 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id b88so42209408edf.6
        for <mptcp@lists.linux.dev>; Wed, 04 Jan 2023 09:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fd6j44evsdxLh0WpMpw+J+gHn9aMiDodElArLsrBkw=;
        b=3caR/m/7fiKLGYuSVFZbQBhz2g1lC1PEsQMNg2ilFMjO3ks6DFRqTvkVkw9LqAWxUK
         AINh9Fibl+yW3lORUTnv5OIZRNVpZeZM9/oMJJgVGP0KZURV7fYcNc0idwApa1eE9hHS
         KiKSWRO15Lcdfqk1JqX2j4DFKv8eqIa+Ofm+7VeIMqf3sv/eVjtLY/d1TRz7VfXT92f1
         ELO/EyKWU0CX2mqBSYrfk7h+t3DjjJKyTenq/x29MSRsBzEsnaYV+q0kR5N77TSHidFM
         ZiMvo8B8eN5F3s1gWz9WLVi9zR0UYFqIdeDLiKCRBBVx3us/bg3A0DGsFmslbbkvt+4K
         t4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fd6j44evsdxLh0WpMpw+J+gHn9aMiDodElArLsrBkw=;
        b=gMf9fm2F190V/ahMYScwWfgd/MCkvy7bKYwU823q6biE+HJTpWkaEhKR5wqnxJdl0E
         v8rgWNuFXVdnsmOVvaDMlSslT3Sp/X0tuCzUCW/KgXRDnHT9I1WlKOKrA+/p0nR5LVp1
         9VnLrHxMPtUvsh397WNjM5oa2cFjNLIjxy8AoDBKIjKGH7V6B8Wf5Xu3fmmAbfzTJqQt
         L5seBvXhPVS38cXt9TQawydfa8G2qxcb7O7/K91B6MrVxVrVwTJJQC7g7iQAIcPlOMr7
         sX0HluNt3rAFKbEOuivesI7xitT7s7A9Jyv7aZJYf5wjDBgMwnGdKDkN+NxxG0maYR4G
         p+tQ==
X-Gm-Message-State: AFqh2kpiPOxvpBVQj7lDDSgLDX7/LFo8oBt5oYzABpSOludjdmsnMGxq
	Yk8J72XoJF4bcDOiZkI2BpguJ9N3TqU1djF0sTw=
X-Google-Smtp-Source: AMrXdXv+a31s1zwcgk9bYHCMCAHEftVDmZI8hepIuEYBMjlkptA3Z9SQHX5UKQEX7mQcervPpZ9xzA==
X-Received: by 2002:aa7:d448:0:b0:467:b851:6066 with SMTP id q8-20020aa7d448000000b00467b8516066mr52654932edr.6.1672852557491;
        Wed, 04 Jan 2023 09:15:57 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m11-20020a50cc0b000000b00487fc51c532sm9258074edi.33.2023.01.04.09.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 09:15:57 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v5 05/12] mptcp: propagate sk_ipv6only to subflows
Date: Wed,  4 Jan 2023 18:15:19 +0100
Message-Id: <20230104171526.1416746-6-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
References: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=867; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=3kFlGna5rOeu2JRWjKHDAzgElplXk4ztNIOnJGHXgXY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjtbQHR0xH4p4pVLmey+SRnwbbsIZ0WGxSsK61eWLt
 hTDcQo6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY7W0BwAKCRD2t4JPQmmgc6YhEA
 CZb2NGtrDpEVBY++jBWP3n+ahvrIyxUSozazzWrgjw8LiwMwQiNPUC8gVLEBcz3iZ3j6cwKpcm4i2O
 wJvQR4BhUDNmNuqwbMnm6LnRukSlKsLRE6f3x9bT5coUXCYbocMhNxi/DnZizxV/VPk0oBXvop1l5S
 DsFtUrMJAvPm4cYFYVE10Bf/XOwVzQPKOsbWgOb/lI8xzOsZ30AgLosqT3DZmwJfzr5L+bUGKiI/Xl
 VApWdynERKfWIBbNJec0Hz/SiRPHsvx3aJGwHnMnFFsx6yr1eEqGGbZBdLoGriV8hxRVodsudmq6lv
 MYvyXhtlG/2dGuODNem7ohgpISBbP0kJ5IvFi4aPCHwz/+qw+WtCb3O585LaqclEvR7pX3GhPQ01Ib
 pNLARhRvaK9Sc/+iC4TT4gfww5HbmzAkE996Wu4mnLSQ80rY0b1lhcdpRHFBRgOfZUoWJrHRgNTbAi
 3YgYbRx8nITikYFpfZZsQF5yd+xt4swhTW7Y4lR0N0OX8Naw2bYpcOaaqU/6IkBpUpGcNOYcxo9x10
 XViFJv1z1X3Fy6VWeE2aqrEKCBl98PtHUXaa4SVXwgxOsXE7G9xIyG6EuFFQFO+eoLVijEts6zPkNv
 YA2Gsz+D+igAaPRv69EGMvxQuMzu956FZ7EQoZV3anxXVXQqzPBMmI+p6G1Q==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Usually, attributes are propagated to subflows as well.

Here, if subflows are created by other ways than the MPTCP path-manager,
it is important to make sure they are in v6 if it is asked by the
userspace.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/sockopt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 582ed93bcc8a..9986681aaf40 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1255,6 +1255,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	ssk->sk_priority = sk->sk_priority;
 	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
 	ssk->sk_incoming_cpu = sk->sk_incoming_cpu;
+	ssk->sk_ipv6only = sk->sk_ipv6only;
 	__ip_sock_set_tos(ssk, inet_sk(sk)->tos);
 
 	if (sk->sk_userlocks & tx_rx_locks) {
-- 
2.37.2

