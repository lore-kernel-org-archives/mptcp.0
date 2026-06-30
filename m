Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBCD319852
	for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832049; cv=pass; b=LppMBMd+O+/FI2jrARn/sdWVnxhlywQ6oj2EjsQFOgURtmUJdys0RA1kd74t9T+Vq06TIC0Uj+gPcShJPKBjtdolAt/QEuZN8f3EqZ//u1TQ0px1Q3OYI5YMD2Vn5WDpHq37VgYaQ6MwqMR3l2Rir++rlssaQbK2/Twbig5yKWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832049; c=relaxed/simple;
	bh=3jRzh6OB28z5vZ4rEqdipq//8uA8gjUTGN7R31oDzvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gI/KNXRuNuHGDPHw1CCZv+9FBORmCkFgooP8YHEV4CQugEQOduhtyxCo0rQK63b2r1IMPS+tAcQ+3dMhEoyJnPxTe1SB+DTugUd3E5MZJxcP0ov83HuLv/bnvHh9LNtTqCqZ5IwJa/LoMWgY0WVUQyx7vKxvEls7CwzmwgwPDbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=sJj/Nn3c reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="sJj/Nn3c"
ARC-Seal: i=1; a=rsa-sha256; t=1782832017; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TEVHQlCXgmJ50t5C86O0zH5Ir5oXK6O37DtvHN9TJuPfbc1uKw1Im44sMNExn7Av+dalMsfCfivW12cmNRf0lGgm9LG6rJmJcoKRZKki4KfHG7Vlip171sz8ARxQhNK4+k4lKL2HAKpkG8az4S9bivpZr1ArimjptONund89awg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782832017; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=h416sGqVgtFIf8IrsvPeVuYKWINAHvt7aZmWVji5QxQ=; 
	b=ZMxlboQKmPwYBjTiNtVZXzbhke3DtE3U6QYscLQiwYsRpgC+QroDJCQfk0b3Y2Qa3+M4mVI/SR4N1O8++rpiSXwzriHgjXOtDfj/m7jrR4A+P3Fmd8Tgn60eMuRuDday/QPlsaxIJCsbixcjAM++2e+S8ePWNWi+84lAmXbVo7w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782832017;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=h416sGqVgtFIf8IrsvPeVuYKWINAHvt7aZmWVji5QxQ=;
	b=sJj/Nn3c+eet9Zomqd0K6kZQl67amXtNy6XTKcUFBFmTboCqCAe2RPdCUC9yk8eS
	Z0VNmirgN/w0sUJ1/O5VIxbRL7K06C6Rr595mJQXuc4knMHno4ETS1zdydZNYjqadGE
	iIGQRDqLkytPhp0IqxopEgWDg50vu0znYihMFfjA=
Received: by mx.zohomail.com with SMTPS id 1782832014579955.5500305277944;
	Tue, 30 Jun 2026 08:06:54 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	akshit@mpiricsoftware.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH net v5 2/2] selftests: mptcp: add id 0 stale ADD_ADDR regression test
Date: Tue, 30 Jun 2026 20:36:32 +0530
Message-ID: <20260630150632.899750-3-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630150632.899750-1-kalpan.jani@mpiricsoftware.com>
References: <20260630150632.899750-1-kalpan.jani@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add regression test for issue #620 to the mptcp_join.sh suite: removing
the id 0 endpoint while a pending ADD_ADDR echo is outstanding used to
leave a stale anno_list entry. A subsequent PM reselection would
re-announce
that address and trigger WARN_ON_ONCE() in mptcp_pm_alloc_anno_list().

The test verifies no WARNING appears when removing id 0 from a fully-
established MPTCP connection with a signal endpoint.

Co-developed-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Tested-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 550a6b6117a9..d45c3b670fdd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2775,6 +2775,16 @@ remove_tests()
 		chk_rm_nr 1 1 invert
 		chk_rst_nr 0 0 invert
 	fi
+	# id 0 stale anno list entry (issue #620)
+	if reset "id 0 stale anno"; then
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_set_limits $ns2 1 1
+		addr_nr_ns1=-1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
+		chk_add_nr 1 1
+		chk_rm_nr 1 1 invert
+	fi
 }
 
 add_tests()
-- 
2.43.0

