Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AAC883C
	for <mptcp@lists.linux.dev>; Tue,  4 Jul 2023 20:45:00 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so437725e9.0
        for <mptcp@lists.linux.dev>; Tue, 04 Jul 2023 13:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688503498; x=1691095498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=irQcTZRmsJv9yLw+oo0R2smAEctmL3X55DWeBMb3Xgg=;
        b=AbdcFx/rQ2BupkcS7tHqQ7Ov507+5/oUa82g3ajawYumtqR/ZB5JE/tvxh8BnQuetX
         +2ErlL6WYuMv/FCCpm5LuR86PEh4ZRliv1TzZxU1Bq5rW8rfcmrp1+3/fYSoLxR18GWR
         IgZ8mFwXKhJLqtoWDd40PXCvaUo4kB0IjBy+i88V+nR7p1goMR6w0vTs87KJwSM3go1y
         42Ex7dtxXGgktJXtBH000UPPe0IwvgvFP7PETTDoKR4m3xYeBhg7Yh4H/Hd6YhVYoAnW
         OBOdsGQSExWPviJbxA6Mfv0j8EDep9I9EDckuedjES1/UFrJxSreaI8ELtgA2ctlrTmy
         HhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688503498; x=1691095498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irQcTZRmsJv9yLw+oo0R2smAEctmL3X55DWeBMb3Xgg=;
        b=bO4VJB2Uz3uRSghslkc/Y05wSGHExVJ1rzo+C+nhFP/VfILOrvywGoi7ew4GCmPKRN
         tSMQrNzHnIYNSzZgbPOb1/GKA5FFkq2y+frWQpqPn3nKz1xeKCJsgnyrxcdiQRkLOdbw
         tPJ1CYtmZHoHhJdJnD3ByP35o6YAlBENDRF1lMpJcHIx44lVmD22OyhMDY11l3xz45v8
         fGXv7x13ZSmMIsuDB8aVS423NgoOq/j0QffK4ZshKQDE9KL0AIa/Dsa+3sJjXiCdF0NL
         V0+xlCKOQwp/aX811TfwOFS92B/DEz7oZ3Ew5DPJIS0h+p5A0spT9HerUKMNcz8LT7Le
         cG0A==
X-Gm-Message-State: ABy/qLYwV9DStRcthh3mkeNU+vaAUAZd8biCAXDss/Jx0uR+NylD7fMw
	2W+wlJ+PN9LuKW9ry976wrOXbw==
X-Google-Smtp-Source: APBJJlHVCDv2kYSOQsWKbxCTvcUMIPr4hZjuOTdzmgEd2cJycCTGIblQN7NvX5IjUohWlVIc7EfkDg==
X-Received: by 2002:a05:600c:4446:b0:3fa:ef97:1fa5 with SMTP id v6-20020a05600c444600b003faef971fa5mr313961wmn.6.1688503498304;
        Tue, 04 Jul 2023 13:44:58 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y4-20020a05600c364400b003fa74bff02asm115332wmq.26.2023.07.04.13.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 13:44:58 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 04 Jul 2023 22:44:38 +0200
Subject: [PATCH net 6/9] selftests: mptcp: userspace_pm: use correct server
 port
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-6-d7e67c274ca5@tessares.net>
References: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-0-d7e67c274ca5@tessares.net>
In-Reply-To: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-0-d7e67c274ca5@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Kishen Maloor <kishen.maloor@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=W8jKw1hMxiLOeZZvDuf1XZG5l8hWMmDQywIII/N7bcg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkpITDVUs10maSaUizFfzW/5uHbdpafk0qxzjwH
 ltHTHnsCzeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKSEwwAKCRD2t4JPQmmg
 czn/D/wPsNjzMUnZu6WAL2gtkZCLSrk2FqCTpvoiCaj+toarKac6awqKM0X2OQqAcS5XBgt3nLj
 qrrZxiHCPMZQFpHZX3tQVo/der59hrjtswqjbMrPabPWMZXNSA+RZZatIxjri3198Qk01HEfxsJ
 Iz6DAImHfy3IHQHmSrtVH88cpkFzfGEzLeoZaiDWeiX1Snpz8C+KbWuiHROmLb6YlpXqjHva867
 ubmVDe8dhJleDBoSm+A+iRR03+8EowX7Jxwi6m0Huz+jAwXnJ/DLFa8L04pmY5O3fWUVsk10N+3
 IVO3l1OGvH2NP8AYNUjW0r0wAfU2x3Qh3BDqL3kRa0+TDzSAH+97/9Ep2o/W5QJL9cIz9YoPFeg
 JK9lRycRKMlEYeEODlIHg5Iu5ExxU11jo9n+Eh1OSKwnZx71ciZ3nmJm/yzdkbI7J0D1OewS3+P
 If80l9isMxznoyNNC4CcRszZ3jXl1Vq6P4G+zDOWmPYiuNEXjxAfitUqYX0tgGZZ5H7SgLZ3GT4
 U1kLzOr4hILxJWr4Sx8cQDT4L9gMZc0PkXGbCsPS5NmYakmVTJiSMBhkXq4r3It8Kdae7biYxCt
 UqNtEHOk6jaqgTB1x8bWjx/kH1DzJygKg8//96n6eE2erpDQt6YU49VfqwS9WZgogEb6xYrdQj4
 lDemp4eD5NsFKMQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

"server4_port" variable is not set but "app4_port" is the server port in
v4 and the correct variable name to use.

The port is optional so there was no visible impact.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: ca188a25d43f ("selftests: mptcp: userspace PM support for MP_PRIO signals")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 98d9e4d2d3fc..841a67a7d524 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -848,7 +848,7 @@ test_prio()
 	local count
 
 	# Send MP_PRIO signal from client to server machine
-	ip netns exec "$ns2" ./pm_nl_ctl set 10.0.1.2 port "$client4_port" flags backup token "$client4_token" rip 10.0.1.1 rport "$server4_port"
+	ip netns exec "$ns2" ./pm_nl_ctl set 10.0.1.2 port "$client4_port" flags backup token "$client4_token" rip 10.0.1.1 rport "$app4_port"
 	sleep 0.5
 
 	# Check TX

-- 
2.40.1

