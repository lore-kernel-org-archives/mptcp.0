Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15146AD55
	for <mptcp@lists.linux.dev>; Wed,  4 Jan 2023 17:16:03 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id b88so42209811edf.6
        for <mptcp@lists.linux.dev>; Wed, 04 Jan 2023 09:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/jHKBQFqn7bUxdd3zFAuj3Z6MLFTXhPHtnSVA/ZQLI=;
        b=vYG0695Zx0eNdfDrvEm431Hb3w2Q2yYkEDRU1jpQeUD932fJfK/KHQpkd9Nd0fMOqt
         8eOGYQrUfrGYSq0QXaL1bMhZbxm5BTMKA0bxXotI/+dd8RwwHPl6qn0EJTywt3+vnOOm
         8pXIRzPvimDwyYJy66R1xSVjO6K4vM/9pV1GJidXzYp2AwFwA3VaKjHq/R7K1kzZeCXh
         zLhorMs+MbFGA2tjSWJs0xarZBhiyLCosyiNTzmPlLGSmYDsz/HsZ0E3clIiTv7FmFmR
         h6i6NMC+Ga0hrXrg6dHIfKxwAHOzpG8XlzsUinz0wk+4UYz8b02oT34iyAW2IPV3CNRy
         no9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/jHKBQFqn7bUxdd3zFAuj3Z6MLFTXhPHtnSVA/ZQLI=;
        b=Y574XV7AY1cbBiXxQ8JXeWXgHHDCL1ufJPgKtAtIWtTKi89fCZ8A+i7cBpZ0xHIwmC
         SsdbIF4u8U05GbUeXliSch0vLeDPWcTkFGbISbII7eAY/z+b+LOd0MTyDa7C68aHjuEg
         cD+CEiasObr4Pu2mCTJjJu6/OA3/S3SWnKdkvQufEa46T1unQLDf/St6vItoM9hbcLSo
         BlYmZY4HnjRltfVuEG6JytYeMxhdeTiYKbf8A79imUUKhEw93KMR2rkD9SvsMiCKuPX2
         JG1VAMbo5wyGx82FugTkePJlQaHrnTPfM/XjkjUu+xkluPFw9y9fM9wE5PUSsXQirFLA
         LlnA==
X-Gm-Message-State: AFqh2kroXBZpbYZi2Uzmn2hbuYCj91QIi+tuw1BXLuVwXFp4qrjI7Ycf
	Mmx14qBnKpcErzWP+PS/nz0fvYF1nUvmZjgZwbU=
X-Google-Smtp-Source: AMrXdXug+dZVebw5PUN4HYjCYaqP22Tko+klv1+IVjlLiBgdvF3aQVR7y6okLoZR8uWCduu7RyxJ6A==
X-Received: by 2002:aa7:cb4b:0:b0:491:3a5c:6e2 with SMTP id w11-20020aa7cb4b000000b004913a5c06e2mr547122edt.5.1672852562433;
        Wed, 04 Jan 2023 09:16:02 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m11-20020a50cc0b000000b00487fc51c532sm9258074edi.33.2023.01.04.09.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 09:16:02 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v5 12/12] selftests: mptcp: userspace: avoid read errors
Date: Wed,  4 Jan 2023 18:15:26 +0100
Message-Id: <20230104171526.1416746-13-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
References: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2046; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=R010oh46FcW31/7ZHEGi4EYd6Lvb3u6lx2QxCCnXZ1I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjtbQIcxyi6f2f9eDjRxyGAWuZ1HNAmTZYz3tkM20t
 xLGCznWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY7W0CAAKCRD2t4JPQmmgc4gUD/
 9+Ft+d1kXzaqGMv//92XNaQlnzuqfjaiZFfvmKykv9bsqvjQ1ftqh0ldw8YOjPF2F9JwSwocoEDS8R
 bRmpUNxwlECKGTWasZdQR2dYsrgCJom3Fg8/H1+oXA/AkS3Im8rLjWNsJdIPR0jOta3MwnyCegzPgR
 EsvY48vPPm377ZdaYKopiGjSR5u5Xxmdbl7heL/ID/NVvX8kjxaO08+LrUqLlD5BwrRCrTe7inSfE9
 nReuFJJwOQdqmsIvWx6Dppp0Z62TcUZs/y6t8G4PDrZLgSwP2ahp47zoJMkBnNCtaiCcl96WIjVlSU
 7rMx/8SLy7bx5yb7QLnhgzv1qGrkdgp55lp+8xASHd/Xnpws9Y2UDmWIfLN5v7K0XfMnvayekc7J1g
 3Xc6eGNbyQUHJbP30ePGY9K+6YHbCPtMUYGxGf0hdNZ5nfYQ965dtu2Xk3E0a648hQvBc39ULyODfz
 zM8y0oINP0I5jit43MGTMQWBtBNoaQ6QX6TCFEYy6ts0r+7VY+14xfzofLktdH+EjWFsUY41cXkgQR
 wd5zbq7LNBykDXd+vu3z9eViT7XA9cnA4a1chq+wInEmThlE0IV9f2sjEC//+1ji7QdflLSauTcs6i
 bGYLfNEm/BgR6Qoqg0y6ctLSB7Wfww7DUs1Ngp+0Q9ZuyWVjoUvkQRtImYYw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

During the cleanup phase, the server pids were killed with a SIGTERM
directly, not using a SIGUSR1 first to quit safely. As a result, this
test was often ending with two error messages:

  read: Connection reset by peer

While at it, use a for-loop to terminal all the PIDs the same way.

Also the different files are now removed after having killed the PIDs
using them. It makes more sense to do that in this order.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../selftests/net/mptcp/userspace_pm.sh       | 32 +++++++------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 0bd35768c1aa..8b4f130800b9 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -50,6 +50,9 @@ print_title()
 
 kill_wait()
 {
+	[ $1 -eq 0 ] && return 0
+
+	kill -SIGUSR1 $1 > /dev/null 2>&1
 	kill $1 > /dev/null 2>&1
 	wait $1 2>/dev/null
 }
@@ -58,32 +61,21 @@ cleanup()
 {
 	print_title "Cleanup"
 
-	rm -rf $file $client_evts $server_evts
-
 	# Terminate the MPTCP connection and related processes
-	if [ $client4_pid -ne 0 ]; then
-		kill -SIGUSR1 $client4_pid > /dev/null 2>&1
-	fi
-	if [ $server4_pid -ne 0 ]; then
-		kill_wait $server4_pid
-	fi
-	if [ $client6_pid -ne 0 ]; then
-		kill -SIGUSR1 $client6_pid > /dev/null 2>&1
-	fi
-	if [ $server6_pid -ne 0 ]; then
-		kill_wait $server6_pid
-	fi
-	if [ $server_evts_pid -ne 0 ]; then
-		kill_wait $server_evts_pid
-	fi
-	if [ $client_evts_pid -ne 0 ]; then
-		kill_wait $client_evts_pid
-	fi
+	local pid
+	for pid in $client4_pid $server4_pid $client6_pid $server6_pid\
+		   $server_evts_pid $client_evts_pid
+	do
+		kill_wait $pid
+	done
+
 	local netns
 	for netns in "$ns1" "$ns2" ;do
 		ip netns del "$netns"
 	done
 
+	rm -rf $file $client_evts $server_evts
+
 	stdbuf -o0 -e0 printf "Done\n"
 }
 
-- 
2.37.2

