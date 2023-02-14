Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA029C0B7
	for <mptcp@lists.linux.dev>; Tue, 14 Feb 2023 16:05:33 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id o36so11322514wms.1
        for <mptcp@lists.linux.dev>; Tue, 14 Feb 2023 08:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=koohUOzc3rjrd3gVo0FWEGT8TyvX1unyQ4Ov4ky2KxY=;
        b=ezar0RbmXvGadURMmsgoHqS5UwCpOY4/xRvW9tk4MUUE6qnooytNWC1Q4jjOa3Pmwi
         eJDcWj2/IQJXO1bJOLjkoW5wFOVsuMe4ekd2ZyUr/wsai2Lb8Y/xQfcALH2qP6BySKKV
         NmMnJOcC0Qvt56vU3ZwQW8nmNHN88lFb5My0CHi2jFRn80KY8H0o/PE4S8lt9YIFXwLg
         nBZtkiBa0g+PB0r+nw7kH1HjZB3vcdDyMWwH//fGjDe7jnbYk+Kr/vxpCzTZUAxkELCE
         0K+OtGfvL/PuHEkYzTBcSYM54uZTGgXQM/pOwdpftVpC6gE/G8/TIG3S6d/xo3LP9aj9
         wOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koohUOzc3rjrd3gVo0FWEGT8TyvX1unyQ4Ov4ky2KxY=;
        b=iAUBDiUXzP4/qiqXTXxZFFY36QWAddScrg8QA5xLDM3dSBiyMMJXtCZGZcXr9DzN93
         FAGOcesoD5vv4Wu3EFo2rvYMkk/+Brq8Qvndo2QvdT5YcceCA2dbvi7rW8LHnFXObDwk
         QkDhjf+YOV+fat8OHs0vrOwT/67wEWYxoZYE0+qHCqwybP8Z/UbI4CvnYm+pV+o0fXHI
         LybqlgEGQWazmhyAgsg4TJxxAFX1L3DZMZpOwvQRffwK/3Vx081Z6j1zsAcBDcMRNOI+
         j5ajbAz+vt73MEOucOW/qpY2OpAioJh33ajfycvF/cfDXzljCjcXJaTTnFEOPML7QSEv
         h2xQ==
X-Gm-Message-State: AO0yUKVrbAlLAGP8hqfyP5gumE7PgybIyb6hpTLkcZJwzHtZ8kUBPVFg
	Yg4ilPpkbuAns9R5+AUB44LIV7i1/0JA6azm6rjkbw==
X-Google-Smtp-Source: AK7set9Av7L6grWHige91KlE2d/GnFM04OOwqDW8qWWoB91apgCCJeh4yyq/B8Ly9x+X+KF13pc2SA==
X-Received: by 2002:a05:600c:1893:b0:3dc:4cb5:41c with SMTP id x19-20020a05600c189300b003dc4cb5041cmr2343832wmp.0.1676390731757;
        Tue, 14 Feb 2023 08:05:31 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg30-20020a05600c3c9e00b003db012d49b7sm4435537wmb.2.2023.02.14.08.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:05:31 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 14 Feb 2023 17:05:10 +0100
Subject: [PATCH 6.1 4/4] selftests: mptcp: userspace: fix v4-v6 test in
 v6.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230214-upstream-stable-20230214-linux-6-1-12-rc1-mptcp-fixes-v1-4-02f36fa30f8c@tessares.net>
References: <20230214-upstream-stable-20230214-linux-6-1-12-rc1-mptcp-fixes-v1-0-02f36fa30f8c@tessares.net>
In-Reply-To: <20230214-upstream-stable-20230214-linux-6-1-12-rc1-mptcp-fixes-v1-0-02f36fa30f8c@tessares.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org, 
 mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2149;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=SmWA3FfTQrdAQe5yh2fWIfTfIMgI4aRmQCw9PfjZtg8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBj67FHtzAQM2XHOno/T9eG7WW2rME9eHlHJv9JW
 jorwRbL/NeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY+uxRwAKCRD2t4JPQmmg
 c6SfD/9t1cdsl3PoFAZAjnJGng3cDWJx1rnsIJyQE55YF0cdFCSYuxv3XGgyVVBGs78+FUqpS0n
 mVck4LqsDy4i5LFDKzjMCkzph0kewhA0V3CfcQO5iG2nvyaanXqDGoAhqNI+chU5uTLrF6Ax6k6
 hzKqBYAImEECjiwyrOSfhhOc/JxqmRZjn/kkQwI5eQah0IuCAfgAJczFgt5KNEkOrlQc5d9tUeQ
 G+vhz6meBV8/poBpby3+yuY0amgzGuvgWbkJhgTbMXYWgGcECFJVwehoSBo5NPOoeQGsNbM6pud
 VkqTb/wp5ss7ai+RPn2QwC/O5y0TW2/7ceBAR1C5MBpiS0S3K2DzBqbs7CP8CsgyqItRDI7yjkC
 VMEIuoFKssTflZN6xQZUeSWVNSvbzbRh3dHckGIxBnccDK7BwNtL6WukRSnknIv3CjAYFmdZ524
 ZXFDWfQFxz+egzx7tMAyZy23iXV7XumrMzG7puTSngpPGT3BuYSxdBJ0gwkvBbrbbdhpvoCTfu3
 Q7kJsFblUcC7QzscFCu1KEprt10PjH30N8/Zu6902I7eYyEF84Y7p0A1Otj75pZrRAUsYEBHybE
 UfBv/TZm+uVu/i1SpNjAmbTiawsnc2rUPuIdZWcy0wzUtvNbAsisl40lxmIk+s0IhGiCU5DWoPY
 FwNN7N8T972HqSw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The commit 4656d72c1efa ("selftests: mptcp: userspace: validate v4-v6 subflows mix")
has been backported to v6.1.8 without any conflicts. But it looks like
it was depending on a previous one:

  commit 1cc94ac1af4b ("selftests: mptcp: make evts global in userspace_pm")

Without it, the test fails with:

  ./userspace_pm.sh: line 788: : No such file or directory
  # ADD_ADDR4 id:14 10.0.2.1 (ns1) => ns2, reuse port        [FAIL]
  sed: can't read : No such file or directory

This dependence refactors the way the monitoring files are being
created: only once for all the different sub-tests instead of per
sub-test.

It is probably better to avoid backporting the refactoring. That is why
the new sub-test has been adapted to work using the previous way that is
still in place here in v6.1: the monitoring is started at the beginning
of each sub-test and the created file is removed at the end.

Fixes: f59549814a64 ("selftests: mptcp: userspace: validate v4-v6 subflows mix")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 0040e3bc7b16..ad6547c79b83 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -778,6 +778,14 @@ test_subflows()
 
 test_subflows_v4_v6_mix()
 {
+	local client_evts
+	client_evts=$(mktemp)
+	# Capture events on the network namespace running the client
+	:>"$client_evts"
+	ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1 &
+	evts_pid=$!
+	sleep 0.5
+
 	# Attempt to add a listener at 10.0.2.1:<subflow-port>
 	ip netns exec "$ns1" ./pm_nl_ctl listen 10.0.2.1\
 	   $app6_port > /dev/null 2>&1 &
@@ -820,6 +828,9 @@ test_subflows_v4_v6_mix()
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
 	   "$server6_token" > /dev/null 2>&1
 	sleep 0.5
+
+	kill_wait $evts_pid
+	rm -f "$client_evts"
 }
 
 test_prio()

-- 
2.38.1

