Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE902F25
	for <mptcp@lists.linux.dev>; Mon,  7 Feb 2022 10:00:48 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id r7so9436822wmq.5
        for <mptcp@lists.linux.dev>; Mon, 07 Feb 2022 02:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MmD5L6TFKnk7SP309Q64eD0HNMQIwkdo7O5xDe1EpsY=;
        b=oUhcZID/4ivuCFmRXXNcyefM0v/HDab7+1+Epx9WKaG33tvTxC3nIRBPeS4nwfWC23
         +7esjUQ7KVIUKF7xWZ4fSnN3A5mgOGuqdkgW43PtPE4Aa3ISt67Cl3SsH/xvLyAQo4cQ
         Jzlqm0jQaj6VVsXACuunuoyCWtuZbrYKcAquiMoGwuQvPbU0R6V7I/KW+g65vRJRepv3
         DOdzmrNfxI/mhpX7C1AUAWEvzTE54XrNsDfpAZxMUFvyvAOm6TYEFz/WE+1oM+qMtHx0
         NAA1r8X9d/SVPPB1829xR9PJrsCMIXLLxNg2hz025J/r9AMj5TkQmyqmq4klkm+pKO4a
         zBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MmD5L6TFKnk7SP309Q64eD0HNMQIwkdo7O5xDe1EpsY=;
        b=jnTtNG1d1D2DsSFYAv8q2Ea4vvZQHXpT1KOju6yqJlQZmO30QHOT6a8S5LNeUoi5Qa
         kUwBydxXkuZCH2KOsKFfagpzN3qblCznbGu/jsJ/M3LXieulOiCZ1ZrgGT6JflbWE9cD
         GZ2mEng+jrKnCSaBgqyY8B7BFo+iYDx3VlfOWjuMrCuehZ32LSf0SqItHcv4y9WkCVjZ
         AeQc31iG72Zk+/50FLQ4KVRy8wg2NhYsgff5Ja1RzsLvUJ181wQ+NdB93dAw+WLpobyU
         KdHYHhZsGjkEyZ9dgFDy7QoU3HRoS+/La0QQ2o2kxTmzNpoVoh9/4GLQ8VyPOEkETqzS
         xd6g==
X-Gm-Message-State: AOAM533LsA31Ezwc5Teu9GqmMHNOb0irE3zkCAB33v0NDfAWVGOAcFzM
	zkVpci83m6t8AnOLm1opqkm1e6HJFUwM17fV
X-Google-Smtp-Source: ABdhPJz32RmXVX3/hcKR0p5lGIi1O+yTl4aM7Tn0vRQAJ6BWl701z+ZzwwW2WCYdTnEWlVSzNI6STw==
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr10224976wmq.53.1644228046605;
        Mon, 07 Feb 2022 02:00:46 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id w3sm9716512wra.67.2022.02.07.02.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 02:00:46 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next] selftests: mptcp: increase timeout to 1 hour
Date: Mon,  7 Feb 2022 11:00:22 +0100
Message-Id: <20220207100022.3936015-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the increase number of tests, on a slow public CI with kernel debug
settings, it has been observed it can easily and regularly take up to 45
minutes to execute all tests in this very slow environment. The slowest
test, mptcp_join.sh takes ~30 minutes in this case.

In such environments, the selftests timeout set in the 'settings' file
is disabled. But because other similar environments can be used to run
MPTCP selftests, it is certainly better to increase the timeout for
everybody else to 1h.

Most of the time, running all MPTCP selftests takes around 5 to 10
minutes on decent environments and the slowest test takes less than 10
minutes, the current timeout.

The timeout could be disabled but it is always good to have an extra
safeguard, just in case.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    On my CI at Tessares, another machine is now used with a different host
    kernel. mptcp_join.sh selftest is now regularly taking more than 10
    minutes when testing with a debug kernel.

 tools/testing/selftests/net/mptcp/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/settings b/tools/testing/selftests/net/mptcp/settings
index a62d2fa1275c..ed8418e8217a 100644
--- a/tools/testing/selftests/net/mptcp/settings
+++ b/tools/testing/selftests/net/mptcp/settings
@@ -1 +1 @@
-timeout=600
+timeout=3600
-- 
2.34.1

