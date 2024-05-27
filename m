Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC67A15ECEC
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716815879; cv=none; b=JT0mP8f2CwCsdXU/lafhvLvtX3Db1SEWJ4w22Gtrdb4A3XRWZAYSi+EW/CG0Q9M8p+fQn94ke0pcM9p+2oeixtz9hpoCPYHV2Clz4t3THP3J9OvokZTLixADX9lKm6shs27kbvbnuZ5qrN08lPTU+UNk4n7CKHvl5YQqX5bBCVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716815879; c=relaxed/simple;
	bh=P8QxBfP31dStHpRF3OPsaueoDvTAbUSMPA9wUEbJE6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h51TVpMCiRhq31wrUl9LTeFMgRzKCIP8sf+6DcgBYBoLEtJ+FieFZtot4tLQ5fmyley2iZ+74c6CLP5381f6VAqjA6Kg8orFDPScjUvNJmmCjvfQNdzYBxWqQntQpJgYoxFuCBM3o88xqWH+yliK6u/ni1NVtWCztxhDs/KPzhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lq9O+K4e; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lq9O+K4e"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52449b7aa2bso8607180e87.3
        for <mptcp@lists.linux.dev>; Mon, 27 May 2024 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716815876; x=1717420676; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCd3DnD4wgoSE8+JwEWGmcJXrhJ/2oYHrCgzw8ggWYQ=;
        b=lq9O+K4eNmT/j6ONAVMBnDrNfQufy26k86nhXXutkkM/IhnAnxJlSrM3zzR6OuCyci
         euYlrJkh0N5kEsTg3O7YYUr8ehRSnRKHblIs2gCI/adCQRKh0qhhi+Um4B2uqgSatpy9
         gkmWsh3McbSg+PZha9TQPAydgjfXH+MCBFGRFoOBW3ZOH+7ZyMkZJXbWQ7it+9k0XplB
         yZDAsWx4aOFrY0GfJhAv2VsYNRhbtxsnfRice8gRQF9ZtKSVmYD4zsCturSJbfVJNqtZ
         L9bWWuupewBLk7xQF927RQ9k7tcZXlJGO1BXVPhMOv2Aedy+YDvNKUwvTIcocn3eUHfA
         caqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716815876; x=1717420676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCd3DnD4wgoSE8+JwEWGmcJXrhJ/2oYHrCgzw8ggWYQ=;
        b=KeSUq4+6sdTcFenX+ZuIzGvOoSQN2T+iSs6RsaAEqMC4a7zlG2R8QXHHJOvwJOd9yO
         9ibVMBA82FSLCrH3wpIU94tky3paxbw2Oil5fC72Ra2BKO/aieIntmh6MzR7bPVDEtqe
         aYa0ZCcXyNWfpRtn4JihC5eHOmPh1i9uO8DkTxdhjrc1YDzB7wdlehvZk/1KDpIgd8CP
         /vSH9g34LwVBsXi38z5mtWsKzppDBuoC4kKxHb58i3kjV/8vkaoAazYxV3ZAa3CuDYTO
         IuYYmbktcQlwam+qHz2P1mPBzQ+xkpJY0wsmkA1MvZvrNsZM5VAa1JN6mPK5i1NA5FcH
         tqqw==
X-Gm-Message-State: AOJu0YxJQZsWPSPn/iRQFlcxpvHpCpAyfCHStFxO2St0nNucNlr3d1WX
	tasaOP8kY4tuC4eJ0RB/orGa2daqn5nZqmIzbaIt2iE7aPphi8FL
X-Google-Smtp-Source: AGHT+IGZA4b23rCYHAFrWC8nDT5dVx27dB/+S+94nqpXV4+XmxvPu1FmGvhUYZarVnVEEVh/mPwy8w==
X-Received: by 2002:a05:6512:1143:b0:524:3177:8e46 with SMTP id 2adb3069b0e04-52964bb2c92mr5453841e87.28.1716815876041;
        Mon, 27 May 2024 06:17:56 -0700 (PDT)
Received: from [127.0.1.1] ([2001:41d0:700:80a3::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785240d1f9sm5799272a12.51.2024.05.27.06.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 06:17:55 -0700 (PDT)
From: Gregory Detal <gregory.detal@gmail.com>
Date: Mon, 27 May 2024 13:17:54 +0000
Subject: [PATCH mptcp-next RFC 3/4] mptcp: bpf: allow to write to
 mptcp_sched_chunk
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-sched_per_packet-v1-3-09a41d405f7c@gmail.com>
References: <20240527-sched_per_packet-v1-0-09a41d405f7c@gmail.com>
In-Reply-To: <20240527-sched_per_packet-v1-0-09a41d405f7c@gmail.com>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Gregory Detal <gregory.detal@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716815873; l=2078;
 i=gregory.detal@gmail.com; s=20240430; h=from:subject:message-id;
 bh=P8QxBfP31dStHpRF3OPsaueoDvTAbUSMPA9wUEbJE6s=;
 b=A2FtL5lzDdPwllAkhUAkNsAZSm/JKQtGy4MLvdKyZGF+huUh8HedPMioXBZNZX+qse12ITZf0
 GDgXCa3zKTPAN677xJhGuOz6aZvLag9KJZ1h7hNVqYsNzIS1FMzo8ko
X-Developer-Key: i=gregory.detal@gmail.com; a=ed25519;
 pk=TziJDop3YEG3Ywr6io7U9Iy2jaAY3l0hTh8KdwDKXQM=

This patch allows to write to either limit or flags, allowing a bpf
program to change the packet scheduling behavior.

The fields will be used in next commit.

Signed-off-by: Gregory Detal <gregory.detal@gmail.com>
---
 net/mptcp/bpf.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 57c47bb430b1..2fb706342064 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -18,8 +18,9 @@
 
 #ifdef CONFIG_BPF_JIT
 static struct bpf_struct_ops bpf_mptcp_sched_ops;
-static const struct btf_type *mptcp_sock_type, *mptcp_subflow_type __read_mostly;
-static u32 mptcp_sock_id, mptcp_subflow_id;
+static const struct btf_type *mptcp_sock_type, *mptcp_subflow_type __read_mostly,
+	*mptcp_sched_chunk_type;
+static u32 mptcp_sock_id, mptcp_subflow_id, mptcp_sched_chunk_id;
 
 static const struct bpf_func_proto *
 bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
@@ -71,6 +72,19 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 				off);
 			return -EACCES;
 		}
+	} else if (t == mptcp_sched_chunk_type) {
+		switch (off) {
+		case offsetof(struct mptcp_sched_chunk, limit):
+			end = offsetofend(struct mptcp_sched_chunk, limit);
+			break;
+		case offsetof(struct mptcp_sched_chunk, flags):
+			end = offsetofend(struct mptcp_sched_chunk, flags);
+			break;
+		default:
+			bpf_log(log, "no write support to mptcp_sched_chunk at off %d\n",
+				off);
+			return -EACCES;
+		}
 	} else {
 		bpf_log(log, "only access to mptcp sock or subflow is supported\n");
 		return -EACCES;
@@ -152,6 +166,13 @@ static int bpf_mptcp_sched_init(struct btf *btf)
 	mptcp_subflow_id = type_id;
 	mptcp_subflow_type = btf_type_by_id(btf, mptcp_subflow_id);
 
+	type_id = btf_find_by_name_kind(btf, "mptcp_sched_chunk",
+					BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	mptcp_sched_chunk_id = type_id;
+	mptcp_sched_chunk_type = btf_type_by_id(btf, mptcp_sched_chunk_id);
+
 	return 0;
 }
 

-- 
2.43.0

