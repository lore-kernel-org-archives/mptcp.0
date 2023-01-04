Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED084AD59
	for <mptcp@lists.linux.dev>; Wed,  4 Jan 2023 17:16:00 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id s5so49480826edc.12
        for <mptcp@lists.linux.dev>; Wed, 04 Jan 2023 09:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXCSBF6liyCYU8H57JsfKDAkklMDGoDA3nQJzOmYetk=;
        b=V7MORkvtldbrV6cT2PmJbfWqEL2h02hdiQFoZRTgbPddbRQ/QmAmQJyje80D/iFYZE
         Tvyz9h7LZmsQ4iH7FuIfIsCM5gU19/Jw/ftHov/O3LMlcD6K3pGyIkIKqwQRybb6Lcq+
         iFZAmk5qC9DPJysFQ9sqxcUCw5Fw2IljtosFH3pyJzLeLatZ/nJJYnjck8Er0EPoQb/O
         dJ8OVpskmp1/QXkXiujpqkONSVzDAExGMxYxf7uHie22b8tzTVMV83JDT0FKGiZjpwth
         ZGxXo/xNW4RPUTOesXLAIeSezQq8O+aIJk54Q61q0JOJH+WOkzcyKeE1P2iWG6mFnM9z
         mtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXCSBF6liyCYU8H57JsfKDAkklMDGoDA3nQJzOmYetk=;
        b=Y4LuQZmTwyxiPXAqjkMuFAaovecW3sBK1+L+ZBEa5YrLguiptQeLc4L+Qs1CmswCBp
         GoIQ3s/sVG9g6RBDoo9fWshecXIxegLCFPNm4c9C8vE4rjGAcJA6zsTJT1KCT3ghZgKF
         LfqEe8boVmc3K3ev0k1291nai1ZqiJv5atVawsfiFEnWTVNg85I0okxFXpl4Jn+IUS24
         pIqK+ljtWqR54YxM99rA0xRTQ2uf3GuaoHyBk6q/DEqXC6FThQp5TquJsbVk7guwtWjr
         IMqp4ALZIipS+UrD6XI5Mkz22Lv2Al3EUMflHwEupoUTS24SWU0MzbBekoHgZWpv68Tw
         KI2g==
X-Gm-Message-State: AFqh2kpgDqjAxtxCJBSHB19zdnpCkv7V8ePH01hWcwI+R07PvPNRgK9A
	CPs2tK9po9Y97vaX8IfPh2be7ahOywd9vmkUqDE=
X-Google-Smtp-Source: AMrXdXu/bYcbQd0MBxaksmUw8p2k9GCvXeXV64hMJcIymi36yg8vgEtz7qNM2K0AquimBJ2VTsjosg==
X-Received: by 2002:aa7:d689:0:b0:46c:3f90:f5d9 with SMTP id d9-20020aa7d689000000b0046c3f90f5d9mr41496266edr.5.1672852560317;
        Wed, 04 Jan 2023 09:16:00 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m11-20020a50cc0b000000b00487fc51c532sm9258074edi.33.2023.01.04.09.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 09:15:59 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v5 09/12] selftests: mptcp: userspace: print titles
Date: Wed,  4 Jan 2023 18:15:23 +0100
Message-Id: <20230104171526.1416746-10-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
References: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2989; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=H+9EHc7FP/MHeHEjjNd26f57XIP8B+ErItLbmQVHXng=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjtbQIRLHwMAfsnmaWyMo8L7biigvp7cf2bLozce9Z
 z6d0+xKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY7W0CAAKCRD2t4JPQmmgc09ZD/
 42vSe/qU++c5mqYpBtMx6RlvZyrwB/GD0HNykfOf9G47Ks/ZouZBz6zi4bYbBvH243wjThml7oFt0l
 7JFVb8JWs0F0XHoi4rQXgV6FJ7YELq2NJTrh7Btq+F1aYUVyIpPbx4dDKZYiH6LbhRhBi3aIWKIUMx
 1rBEOWqUMqL04hL8bAlAWKa/zXS5ytVuBCvAG3+4g33WOxoVCBBTvSmHF3mh/2Z8Pgtvtd60UPJm1T
 zm0rbV7O8/RQ230S8XYZ229pR+e1Ydj0HDD9tSjcc0BcCb2oG8PVRaN+ZQl6dofPyxLs4XBAIPjHyu
 eQ1mKZMJbtw+FwEt8b0QkHU53zVCvBoVoxh3dl7p8O9/ONRqqvU+VxSEm2QWvHYuHqYJB4L6n9Od6z
 J4GivRhFBsR5m3jfgWkw3hSw7gmqAHx0HXRdNB1I3GIyf25/lgfCBoyRVO0kuXILo4d94uVO43ZBDL
 cSGrw7ZrhveofwkGDoaS4QKMV68Fho3q9QhTj3X9bj0hJSTh7jL5z8113y6Eva8pjGFFhQzGNxhzBj
 WFV/IUb/a85PRUVQcy236a4YpG5W/oXKjHsP1Z2w+Aqi/PkfGYpnzCAUQM+o04AhpdgoP9D4mW7ErI
 8jcff29v5nN2AN3LXel+w6NSaRGg4nEDOokOtBVrTqMDkN60r5972ezFrhBA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

This script is running a few tests after having setup the environment.

Printing titles helps understand what is being tested.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    v3->v4:
      - Add a title for the Cleanup (+ 'Done' at the end)

 .../selftests/net/mptcp/userspace_pm.sh       | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index ab2d581f28a1..f9a03e6e968f 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -43,6 +43,11 @@ rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
 
+print_title()
+{
+	stdbuf -o0 -e0 printf "\t%s:\n" "${1}"
+}
+
 kill_wait()
 {
 	kill $1 > /dev/null 2>&1
@@ -51,7 +56,7 @@ kill_wait()
 
 cleanup()
 {
-	echo "cleanup"
+	print_title "Cleanup"
 
 	rm -rf $file $client_evts $server_evts
 
@@ -78,6 +83,8 @@ cleanup()
 	for netns in "$ns1" "$ns2" ;do
 		ip netns del "$netns"
 	done
+
+	stdbuf -o0 -e0 printf "Done\n"
 }
 
 trap cleanup EXIT
@@ -108,6 +115,7 @@ ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
 ip -net "$ns2" addr add dead:beef:2::2/64 dev ns2eth1 nodad
 ip -net "$ns2" link set ns2eth1 up
 
+print_title "Init"
 stdbuf -o0 -e0 printf "Created network namespaces ns1, ns2         \t\t\t[OK]\n"
 
 make_file()
@@ -255,6 +263,8 @@ verify_announce_event()
 
 test_announce()
 {
+	print_title "Announce tests"
+
 	# Capture events on the network namespace running the server
 	:>"$server_evts"
 
@@ -359,6 +369,8 @@ verify_remove_event()
 
 test_remove()
 {
+	print_title "Remove tests"
+
 	# Capture events on the network namespace running the server
 	:>"$server_evts"
 
@@ -521,6 +533,8 @@ verify_subflow_events()
 
 test_subflows()
 {
+	print_title "Subflows v4 or v6 only tests"
+
 	# Capture events on the network namespace running the server
 	:>"$server_evts"
 
@@ -754,6 +768,8 @@ test_subflows()
 
 test_subflows_v4_v6_mix()
 {
+	print_title "Subflows v4 and v6 mix tests"
+
 	# Attempt to add a listener at 10.0.2.1:<subflow-port>
 	ip netns exec "$ns1" ./pm_nl_ctl listen 10.0.2.1\
 	   $app6_port > /dev/null 2>&1 &
@@ -800,6 +816,8 @@ test_subflows_v4_v6_mix()
 
 test_prio()
 {
+	print_title "Prio tests"
+
 	local count
 
 	# Send MP_PRIO signal from client to server machine
@@ -876,6 +894,8 @@ verify_listener_events()
 
 test_listener()
 {
+	print_title "Listener tests"
+
 	# Capture events on the network namespace running the client
 	:>$client_evts
 
@@ -902,8 +922,10 @@ test_listener()
 	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
 }
 
+print_title "Make connections"
 make_connection
 make_connection "v6"
+
 test_announce
 test_remove
 test_subflows
-- 
2.37.2

