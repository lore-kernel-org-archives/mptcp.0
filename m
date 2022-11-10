Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FA11A619
	for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 17:59:30 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id n12so6900505eja.11
        for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 09:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wScGSn18UY93sejCAJODduUbPLYxpyPQE6Hravy+Cqk=;
        b=Va/rPA22T/FFVCdcK12phhM5MdXhSlSQn2KiwDzlmmJhLffjiH56N6pJYIiTV03z1W
         Xsgx6feRKXxSjGmg/KfofrpZqtLOk8h8UgQfLXYzNgOUMFBWyWdlATRzGJZ+svLwDwMf
         bU5q148h7eruNGQhtM3Lg04NtRO+Wjn+703MsZI6TG5yx0+xJukChVOktbsMTUe4oglu
         j6u9oQ4uRjZM11oWlKolFJlmfic/ctgK5byB+Nr037yxQRjIPgtvbE76arV6gKNl1Bx+
         kI+uvC/3ZeehX3nWVkMqXO6JxHBXv6mqK63ohSfhGecU4UtjwmdY3Y+D/b1i8vEbKrO9
         C8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wScGSn18UY93sejCAJODduUbPLYxpyPQE6Hravy+Cqk=;
        b=Zw23UhhrGKmFHUO7J4UY03ppxAbeL4EhzvHchTBaVPDZKCnoXtT+Dc6AZIqRGU4ydK
         tymmsf+OuRwNhiVsEVrWbiuzaQ44kBMgm6NXqnpn/mHPlyhB5kANV5zM1aP25uwBt2Tk
         slTDGEDEBv6aRxcR2IwISRFQbbaGA9/9CED9y7VMgIvMomGub0BxwA+nBDZBae5Echwp
         x3nBzqJD3Ha8lTE/DJphu62zdBba4rcoXCCRhC5c4JGjaY8C/UMklfjNWm4T8Qe8AhHQ
         rcpYG7WVt4rf6Lw/bg18lCifotcpG+buIvMbtOAwMTKM7B71rRW0meSDdXIGAJLug/pV
         Kg5w==
X-Gm-Message-State: ACrzQf1ccncgbqwThIbNuJeEepPW8P9lxcxxPoP6zVsaYEKcbSAYxNmZ
	psK+kmEBdp7zcau8r5Oyf+/Dhubp6uS1c8TyGp0=
X-Google-Smtp-Source: AMsMyM6Nx00drsXj5R7tQvHET0Pjbq+2dgB4vr+cV7Y6UnAwTy56ciE/s72HadAKjKnfGRMBaRdWgg==
X-Received: by 2002:a17:906:3502:b0:78d:3862:4488 with SMTP id r2-20020a170906350200b0078d38624488mr3198288eja.683.1668103168944;
        Thu, 10 Nov 2022 09:59:28 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id c8-20020a056402120800b0045726e8a22bsm100765edw.46.2022.11.10.09.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:59:28 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/2] selftests: mptcp: clearly declare global ns vars
Date: Thu, 10 Nov 2022 18:58:56 +0100
Message-Id: <20221110175857.3953994-2-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221110175857.3953994-1-matthieu.baerts@tessares.net>
References: <20221110175857.3953994-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=+mwGtAUnoaes9Ul8bPfs3aARTrtWZde8GbZFxCHxuWs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjbTuuWV2aKTU3sbEI8WTq0rfBwb2F8tBx2H6oOpye
 S8+yHWCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY207rgAKCRD2t4JPQmmgc9dvD/
 4gBaCh7z47XucyffqI7IPQE+lZwa/v9gx7erbPe7vK0rDs+pbDgIJu5k5nLyXnWj3XZ8hWVbVITEdf
 uWIdSC4xJqOl6Aoa80nHr+zn6qhzg6EGrd8JhrwrpNVVn7r2eWeCa4CqliEVvsXdUCYVgvypzApYOQ
 E04cJV/YgvRAXGKRURh3uF+GZpl1VBVR94yRSHPFaYsGigYMW454NIm/dwN69xp9CoB9xadawrC7Fj
 xNlgaD5XCf3PPHUb6w+ZTwT323wp7yjQFTVIKDAPjNCbg0VCmddQFyFBybsqf89OAlhPf2JZp7axD3
 Jw4h41gTyr3GTde9ekJPnv7yA7T5+tdj7YxhY44V8DwsZ+rIyP4umybdXVlCrfwjXcX0IA3MNrEajh
 lTrREMfAqMHYg9wxk5Vz++RUsQKeqpuYu6rrK6S2d9Hx7/tFGX1Y2crFVMvraNLjNMjxcPX/0BM0iF
 Ao4ALtw401mo4hCrwMsL7g/Wr8q4ldcJg6Oj8iCKu6VMo+Th77I3TyOo+BblxrJIBrAIq5VFgqAtHJ
 LPJlS2DKMasTjUnrIiZgRFzyszhwU1spqd7nYOdXlv09CPmdxZWYzHoyj9506yG15TVryGIOvbn+D7
 WD4ksI9MJOmoiQtptk7EJsGDlDdFeS8PiX1hO2JM15M9O8IRve7ozL3Yc/4A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

It is clearer to declare these global variables at the beginning of the
file as it is done in other MPTCP selftests rather than in functions in
the middle of the script.

So for uniformity reason, we can do the same here in mptcp_sockopt.sh.

Suggested-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index dbee386450f3..f74b237bcb32 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -11,6 +11,12 @@ timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 mptcp_connect=""
 
+sec=$(date +%s)
+rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
+ns1="ns1-$rndh"
+ns2="ns2-$rndh"
+ns_sbox="ns_sbox-$rndh"
+
 add_mark_rules()
 {
 	local ns=$1
@@ -30,14 +36,6 @@ add_mark_rules()
 
 init()
 {
-	local sec rndh
-	sec=$(date +%s)
-	rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-
-	ns1="ns1-$rndh"
-	ns2="ns2-$rndh"
-	ns_sbox="ns_sbox-$rndh"
-
 	for netns in "$ns1" "$ns2" "$ns_sbox";do
 		ip netns add $netns || exit $ksft_skip
 		ip -net $netns link set lo up
-- 
2.37.2

