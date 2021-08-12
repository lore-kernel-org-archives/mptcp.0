Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C8D70
	for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 16:28:26 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id g21so10593362edb.4
        for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nDk76aDL8dAMl6yzVty266AgmHloZ/DzIl1xuI4hctc=;
        b=IiPyQorvTtKULxH+rDXlUAjANf0ndDtK/1Nv8PH9x6dM1mDnPXgcqCa7KgH7oGhW6u
         GamJBshO5/ERgaNkkKI3gChJwZfXYJ7/sU/D72HycSB7lOjZLa9yWodmf1AToQb0xbhc
         P0AZ2GnfQwaFDTQK1/GqeGyxWFA1p3vjPrtmZ3x6yF4HlaLcW3ECRQOP1J5nJxbgy3na
         uwJa1mc8sYZ2qeB830BSO3jEMJMnUQbs4Lhbgb3wY95cR+OPLq9UpJcKNDuxSh5CqQ8m
         QF3h9lNgEAL4BfP6fXk77T4dwftfEX/c1HV0I+kDPOiPzJ2xClYeygbXJZEx2ZcKfybW
         9dSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nDk76aDL8dAMl6yzVty266AgmHloZ/DzIl1xuI4hctc=;
        b=e8XPaarSSHW3nkM2TpSSWQVooCYpWHJIwMrE6Q4ewBvDcdcruIN55Tjs+fXlwxrDyj
         Ng/UhKvSBW5zYDSKas3qbbHgZGUoDzV6djyA+Axt6a99z83fmafqA4/94wnFGw62MvL7
         buPYcKVo0d4MD4nkZ2u8LwbM6/Pe3BERRUFfAuE/VTyFSY312kyCaPQWWATM9truLxsE
         s7IcUVhDM6Id+mUyUDrEFfaYEU8oWhxc1FryH/7xp/a8OjcjS81y/aMAu8exFUAN5Ju9
         JD4W5QYgLNnX9p6R1NbgxZbb5MXJxsm+/Zav+6OeIob6Ugnjrz2+Fy4Tf6yHMlM/bfXR
         G++w==
X-Gm-Message-State: AOAM532oA1Sn5f0LydFnpMibj2VURg2TLdPv2w6CUBjmUpZ9eGXkaSoZ
	oIzetqarZ7PkbAh8Un6pBkOFQ7lCbR1sqQHG
X-Google-Smtp-Source: ABdhPJyzwj8qYFnjwEYSQC08580wGSScMGP7Y3jlNnR0n/i7rrBg0dZYcONdtumTYhGeOUe7Rg+wjg==
X-Received: by 2002:a50:eb95:: with SMTP id y21mr6365558edr.5.1628785705069;
        Thu, 12 Aug 2021 09:28:25 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id b17sm1279284edd.27.2021.08.12.09.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 09:28:24 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next] mptcp: full fully established support after ADD_ADDR
Date: Thu, 12 Aug 2021 18:27:57 +0200
Message-Id: <20210812162757.282366-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If directly after an MP_CAPABLE 3WHS, the client receives a valid
ADD_ADDR from the server, it is enough to prove exchanged MPTCP options
are valid. Indeed, the ADD_ADDR contains an HMAC generated using both
the client and server keys.

It was then OK to enable the fully_established flag on the MPTCP socket.

But that is not enough. On one hand, the path-manager has be notified
the state has changed. On the other hand, the fully_established flag on
the subflow socket should be turned on as well, not to re-send the
MP_CAPABLE 3rd ACK content with the next ACK.

Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    Once applied, we can close issue 221. But this patch alone is not enough
    to fix issue 221, hence no "Closes" tag.
    
    Because the PM was not notified, I think it is best to send it to -net.
    Before, I think we were overriding MPC ACK options when sending the echo
    ADD_ADDR so the issue was not visible.
    
    Here it is visible (and this is covered by out tests) since the
    introduction of commit 32c3e4d50806 ("Squash-to: "mptcp: move
    drop_other_suboptions check under pm lock"")
    
    With this patch, the packetdrill tests are all OK!
    (And the other selftests as well even if I still have other issues with
     mptcp_join.sh but it doesn't seem related.)

 net/mptcp/options.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d94ff50c29b3..175563c95c0b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -945,20 +945,15 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		return subflow->mp_capable;
 	}
 
-	if (mp_opt->dss && mp_opt->use_ack) {
+	if ((mp_opt->dss && mp_opt->use_ack) || mp_opt->add_addr) {
 		/* subflows are fully established as soon as we get any
-		 * additional ack.
+		 * additional ack, including ADD_ADDR.
 		 */
 		subflow->fully_established = 1;
 		WRITE_ONCE(msk->fully_established, true);
 		goto fully_established;
 	}
 
-	if (mp_opt->add_addr) {
-		WRITE_ONCE(msk->fully_established, true);
-		return true;
-	}
-
 	/* If the first established packet does not contain MP_CAPABLE + data
 	 * then fallback to TCP. Fallback scenarios requires a reset for
 	 * MP_JOIN subflows.
-- 
2.32.0

