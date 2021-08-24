Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9669072
	for <mptcp@lists.linux.dev>; Tue, 24 Aug 2021 08:48:11 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id me10so14383200ejb.11
        for <mptcp@lists.linux.dev>; Tue, 24 Aug 2021 01:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QDkt5IPLUUl9Ron+tgBjIBYJ6XKbUU8/6iCw0wz7Shg=;
        b=sh0jc8NaU+kSIIwSMsSSX5eI8PkNO36khG3GQNXau8nYosGq53y41F8/O2LMpsLzi5
         cQIZPAJWoTz2KJd/qnA2p+CCZWbPPN+AcMIrTMnsV/NSSmXL92KtMLNqh0p6pcGtihRh
         9oaoYUQwwHA/NbFQMNI6YVqi+UEB8mg1VvHlRSjO1GX/t1lmq6gy3log7gppYsJDEgpk
         xOtPQJJjt7rPPztkmreblzeBhg/JbrYWCLR6R6RZQT/dWsNpQazmIelq0McVjhb/6KEn
         khxeMwHNyMATKWsLDg5O9wSsZnv4Sm2V8X04Z6WQQ4ImO4D2GMa6RWWTRKDsrBX/Uclz
         KnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QDkt5IPLUUl9Ron+tgBjIBYJ6XKbUU8/6iCw0wz7Shg=;
        b=fCKSdA23a63LaoHT6d+oVG9JgQtpk1wnjTHVl7glJ9JmIdQt6zLxQ4+ojeOR5uWWye
         rerUJTUH6mkEcFDbpkviWjbj1//zKBOICOrnE7fIEkIcR8eX7zIzmfv6Y5VCIIzTyjOh
         gYRdB2HplxdpE2+D9SaIZT/UcACGIOcJMHHIfJFnsnY4qr7yxOYcT1NrdvXKDLIEQ6S5
         YvZW9tZDqGtYdHxRA7SYTyiVEHzQwiLzQS9CLMEssAJcjmKGvFE7GnEqMxjzHNmlILS3
         8wsy315t4lOTEP4s919K9iAwjLqYG/5OY4VfoAOgOelFV9eTeG2g3NL/wpKPhWT9+c0E
         PkGQ==
X-Gm-Message-State: AOAM532WR3YlpOuQCDSrHxh1/baH2CGZ1ABUDV6nXHhEz07FCEtcA5Q+
	h/1ycNu8UjSWgRWcUry05jf/q0/7FWvvZkEFEY8=
X-Google-Smtp-Source: ABdhPJyDrVpcHRYzSvmAX+K0BWR3w9GdWle3+OWBzJ6xpxPeD6RQ2ie/RbQFDRwX/s38T4o1Y1RCng==
X-Received: by 2002:a17:906:4bd6:: with SMTP id x22mr40687323ejv.270.1629794889606;
        Tue, 24 Aug 2021 01:48:09 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id r16sm11023221edt.15.2021.08.24.01.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 01:48:09 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net] selftests: mptcp: clean tmp files in simult_flows
Date: Tue, 24 Aug 2021 10:47:51 +0200
Message-Id: <20210824084751.3490436-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'$cin' and '$sin' variables are local to a function: they are then not
available from the cleanup trap.

Instead, we need to use '$large' and '$small' that are not local and
defined just before setting the trap.

Without this patch, running this script in a loop might cause a:

  write: No space left on device

issue.

Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    I hit this problem when trying to reproduce issue #227.

 tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index fd63ebfe9a2b..910d8126af8f 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -22,8 +22,8 @@ usage() {
 
 cleanup()
 {
-	rm -f "$cin" "$cout"
-	rm -f "$sin" "$sout"
+	rm -f "$cout" "$sout"
+	rm -f "$large" "$small"
 	rm -f "$capout"
 
 	local netns
-- 
2.32.0

