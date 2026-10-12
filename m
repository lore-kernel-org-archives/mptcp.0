Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFF84AD7DB
	for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825470; cv=none; b=S3aW0/7irHtBkcKBRE6CANL0mbmW7wQOEaAkwc6AnkotmE4UPOy0AJOd9bLNTfsqmhwqU1877cyt6AKYyg+DTEo3xyK/amcKFW1IdIFaXz/tIrfWEzWNVl1ySd0QtnXMKh4fv5zwq9uEOlxjNRsYpFk3mgWe8wrRvHDEKTZqsJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825470; c=relaxed/simple;
	bh=vQ1OeP4YYRn2fomUsV+/9t0XaY7WM1vGAx1p99dQvUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y/ppDy0pjIMl8x9UCHCa0K4WlukrEan8BJ8uv7nPDbkhiKlAdRZw4kvfF73dDyX5pUQi2LD0ZFVfpHpDmGQi8Ti3a8MlCd2tu/le4797F6BNEHikoVBgjWXlnNggbCXInxxkf6cdt5Mm9H3s8YdtEz5chDEKhLRjcOBZMA46cZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1st3i34; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1st3i34"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35943f55c06so1657521eec.0
        for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 10:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791825468; x=1792430268; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZGkJzBxphTZhjVH7Xcg9dcKaNTiGlXRcMUe2ndfmqtI=;
        b=S1st3i34oaiZticrLFEc1/63rHnR7M39d3dFglhhSjIuX8uMmczZ0hMYs0Q0+uXQwv
         aFaLbLil1R7rzkIQYGlQb3Cp0EhH+EaT2oDBbwfePlIoVb+B0oKTf8+snhqSHi5BAtUV
         gD7B82LHQP491emJFdDf5YM91iRGUN6w0vYn36TNfKR0r4Zn9+gzsLlptEU9Lb0wQGES
         bzGUrAFdrCR1H2W3NoZrcip7hljtLbGBW2EvmhBcJ26iWG8JtamTWCyxEcd43tWQa5aK
         f7dpa1+oPsO4PoZUPSFBMdIcl/xfgdlnknrm9Aan5gkhrOSk3NxgkWwc90p2+IC1aBuL
         4vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791825468; x=1792430268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZGkJzBxphTZhjVH7Xcg9dcKaNTiGlXRcMUe2ndfmqtI=;
        b=Z6utFFNW5PpLg6iTOwYbh6tyVSI9mW7hyWCAiZGv2HRonjAagapg4Det3vFVdAwLA9
         1dq+7KU2wvHjn4fb5H6o8rOjRak4xt6MC+NX5yfnZCx+fMaao8QM6eDesMnTxM9STdRV
         Opq/ZEhbZ2uipMj/oMtpGW55XxhsEQA2zhvrLMJfodZi2ybLKn/jzMr9/9XTuMyLR+oL
         XLj5tx363E0kFhrD0TxBn9gftS/dmdYnn/ACar40Q+NsKYV9VlL0McOD/wSkEO4f8iFv
         SdMwLzqj6n+KGqs86j0SeotKhXovyUnUTvIcJHv0e+0HHsVEoP0MsH4lvPAzMvzr4EAN
         3fBw==
X-Gm-Message-State: AFq9FYItExhYzLgI6DFtXwUfxT9B3MsDrHFsENCiHkuAWcYbT43nlnHQ
	KfTL4AsXnkmrI3SJcDCRajkCw+UbGC3D5EtRXRF2zZVeh3T4HCo+tviqah2j6A==
X-Gm-Gg: AYBFou3sBzdvbg9Hd3w/IqgPtZrgTfJuCVnP25zRKYjr7ABGltHswOIeI7h6JwvB06Z
	cqg1MUpCPt6D1xqufbiivRbaSvt4jeO/cw+HeD9Yf6Sgbqr1tRjuZVnXM1c643y/PVCOqcT2XyS
	bNsIPmlybpgMLyKNeO76ScGHiKLwO5MhAKz7zLAz3j4d4r9wMR02RXybIVwbuUN3sf4mH2LcF44
	+y3CfIGIyNYtstITD0KQp9IV4pV6iej9L9MSCM842S0NjOYCbsYKliaiGHc2cek59fkFgsSAIYi
	BIhaSGvBKWvJTPt530ZPKvo3ehNITUEg+5Mce3lqlUTjMg+wQzKvkQs1H9AcmABx/UtL03mcQCF
	YSe8nozMmFm7wCtGlP/nkMmjjsUuzxtgMT0FZ2R8xJCIMMFf97lcYiY/ROOQRs0DhF81Kcj7OBR
	d4JgDaLC2OyCeruJnw59HEjR0cowDYoifQKr3JTyo5WGGhTBbgicBuEozMGraG8a7zyupF0qZT6
	mgUZa248AGPj3gKXEUbPSORVvOOY8vQ9TVKBwIpua3lOFMehuO4IRLEG6UwwMWlvX95I+D3tSIK
	rM+Lvr4OxFojk4yTicMe21CQD33YBN+mZwWWWzA6Oog=
X-Received: by 2002:a05:7301:578a:b0:35a:dbe8:ccb5 with SMTP id 5a478bee46e88-35adbf822a8mr5006828eec.13.1791825467562;
        Mon, 12 Oct 2026 10:17:47 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb6a279sm34978099eec.30.2026.10.12.10.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:17:46 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [RFC PATCH mptcp-next 1/3] selftests: mptcp: connect: retry write() on EAGAIN
Date: Mon, 12 Oct 2026 17:17:38 +0000
Message-Id: <20261012171740.464517-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261012171740.464517-1-anilkaushikwireless@gmail.com>
References: <20261012171740.464517-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mptcp_connect treats any write() error as fatal. But write() can fail
with EAGAIN even after poll() said the socket was writable: the MPTCP
send buffer shrinks when a subflow is closed.

The tool then exits and the transfer fails on both sides. Instead, go
back to poll() and wait for more space.

Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 178d98d91fea..5bcebc721864 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -711,6 +711,14 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 
 				bw = do_rnd_write(peerfd, winfo->buf + winfo->off, winfo->len);
 				if (bw < 0) {
+					/* POLLOUT does not guarantee the next write
+					 * will not block: the MPTCP send buffer can
+					 * shrink in between, e.g. when a subflow is
+					 * closed. Wait for more space.
+					 */
+					if (errno == EAGAIN)
+						continue;
+
 					/* expected reset, continue to read */
 					if (cfg_rcv_trunc &&
 					    (errno == ECONNRESET ||
-- 
2.25.1

