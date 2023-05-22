Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC5714A92
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:21 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f42d937d2eso39690815e9.2
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773499; x=1687365499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3j4MqBDDsrtBle8foZJZynJx0yqJs49Kv7hBsjvH90=;
        b=1uLRFhOPcjeC6pbT9kW7KLZg30poZfrwg+snEHzqarqQo0PYwO6uC0xIYXaDacLAGA
         gN7Y5b5OV40YOCrKqyoQebwERAUpyDPGICbmM8hwbqkdvZQB9nWyCEuTEtTd9Gn83Wwi
         Qpn/4ybPw0Jv2Mr6RHXZwNGrIYgX0JVFP2sndjqHvVpUv+7TrdWDwukTOufbHZtYf4Ko
         9gx0rbfh91Qg1dV7LIiOHFGRTWOui6Adfb180w+MMFO7CjsFGoBHHf9vp6po4Zp9dGav
         O6rPtVZ15uo0Ps4IJK3IecPdoNruzc16FCZ/lgoLXU1onhXYKdcLQZ4z4cbbGvjCpKOa
         AywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773499; x=1687365499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3j4MqBDDsrtBle8foZJZynJx0yqJs49Kv7hBsjvH90=;
        b=W7j03jYp7JfZ4MNukLPASeIxoJOaK1MVlN8vHqtjSvNi9o/0MeKBoykWD9TCpTuT77
         oa/vBb6j8sQNN9He9hSUg2DhjMGIn+zeAdrq0elb83XQQdayk5+R0Ogn9LthrVfNo4I4
         VFwLOiJvOT3E9a5fPGUZPayV8nM5RHaYS4VaDRXJBFMNjjl41Cl2hCExKsNsC7F4lWeD
         9K9asJdt9mehoHCuFAZByG0YXZTQ7KrSsYcuj0mezvUTF5ALb+D/pa2N3TKYqOwbDH/p
         ujtHG85APSUcxuH97C/ozp6g1xGU8Z9LPRHy6SM6CXDYA8v3PjCXHd80Hk6TJpq4AVs9
         MuNw==
X-Gm-Message-State: AC+VfDyFlVtV9yk3e7SXoETC9bnyMznGZTpMMmay11yZ2mRX6h/B9F88
	HD2LsjPkkcAw2q/EWrk2KMzPUgGrmyuYvDW/nJI8qg==
X-Google-Smtp-Source: ACHHUZ79ArctoQTaCE9b9oGiNhBfc/nHZ+0S5KTOxT93Wo6VRP6voC4FcT2nklYlDL0c7n4KnJV6Lg==
X-Received: by 2002:a1c:741a:0:b0:3f4:2158:289b with SMTP id p26-20020a1c741a000000b003f42158289bmr7581061wmc.18.1684773499660;
        Mon, 22 May 2023 09:38:19 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:19 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:44 +0200
Subject: [PATCH mptcp-net v2 12/37] selftests: mptcp: connect: skip TFO
 tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-12-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=VcRSuTQnC5b+nFLj990Qlgwukx5iK7e7/cNHgBM6tZ0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pwj+QqC7vfjF3xHDSzTFYbJHfzqyGEmyFWK
 biiQh9W2lCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacAAKCRD2t4JPQmmg
 cxKkEACsI85nh0UoqKFSEczkZ4LMzz5yQOxdi873Hzd+Xybtrm2GsxifMI16YnEkzQO6I2VRYU1
 L+h8DkFZEH5LNXyB3NjP2l+EcPjV0EEeZPGLTeefsUBl3RiGjaAGixaSnztRZcbTTeoyxLoA/RQ
 0K6ZJP7eA6ZlxS1kPJ5vy5eDJRRoMf20kvn5iFs0DZgR/p01h3y0DsdylWYoaY817Zrukr3a8Tb
 UESlaRNK76nKhSKsFadvR7u+fzEuwjV/HYclrV+aKI/nhDezqijJp28ef/HReRlsd/QKwl+lDmS
 IX5G68jlLoFa6zzppX1fgGhf8f3KJFGCA6e+L4e9OzIJWF4TkW2I20/dQl86DFLQSpyJYPcQ6Pa
 uJh6iUM/jWXWSImHTBCJq8eoX2fugL8U79FrCORiCMglVRolzdUzqXS3scwNvvb8Xu5zDrgH69W
 cvLgotjAJkkLR0WoxeoXOME9E0x4KM25fVVRMsIdEM3UctF0bL24vRa88J79w484xvSbwlz319a
 x8dnK6dqgmJZjhHApi8qHfplBiRfdk1nJKunabRtu0bkygioOse8l1onSPdDbi8YsYY+4jAmqfU
 z+jNbFg8uHqu56nHuqdq3Jk5J6FRctstsvwN+ckfaua0p4b325npYG3CNXCNVduUb8byAp/rcIN
 N1jF3/bcCI4p/yg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of TCP_FASTOPEN socket option with MPTCP
connections introduced by commit 4ffb0a02346c ("mptcp: add TCP_FASTOPEN
sock option").

It is possible to look for "mptcp_fastopen_" in kallsyms to know if the
feature is supported or not.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: ca7ae8916043 ("selftests: mptcp: mptfo Initiator/Listener")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 1b2327d569a5..9cebe0252b78 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -777,6 +777,11 @@ run_tests_peekmode()
 
 run_tests_mptfo()
 {
+	if ! mptcp_lib_kallsyms_has "mptcp_fastopen_"; then
+		echo "INFO: TFO not supported by the kernel: SKIP"
+		return
+	fi
+
 	echo "INFO: with MPTFO start"
 	ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=2
 	ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=1

-- 
2.39.2

