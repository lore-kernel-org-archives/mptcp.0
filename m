Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FAD221DB5
	for <mptcp@lists.linux.dev>; Sat,  6 Sep 2025 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757175569; cv=none; b=n0Go9C7lC0BbwZ2SJb1VUol/xPzQHHxKUj5h/ra0mjhD90v8wIb++Rt4bXQnMQBygAsy3CgE6Jsl0WsUC29dK7EAGT9SNwejDiEbInZsMXyZlyToKP4KEVauqD6ii9VugH1VIVX4p8XfJ8utCRhWXbb5ttZYezyapmCCeCjYgkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757175569; c=relaxed/simple;
	bh=GJLGTIPmXw36vvIEINlXdvy/w3WBz1dUhxsNH1l4gpI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=L1LOFtjWsRL4nCqiA5InmTSM/ReIFgZzyWD4NIGbDwXzdxOnv7Xg7AsKA01imbGnkWUx+QVHBYuVoeQgZWS1f1BgGsOFLoqx9EMEVsop2wB5yRX1obglA93GKkqMUeOIyNI5rlhRPMAmXhPhTRuV5tzgfr4Xw+DwsgqFRldhbrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6Rdc1jd; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6Rdc1jd"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7725147ec88so1293702b3a.0
        for <mptcp@lists.linux.dev>; Sat, 06 Sep 2025 09:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757175567; x=1757780367; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpxwdW9Eq65dgNQSqH0zCtVNg/EmOntoXaGWmsXTDgA=;
        b=D6Rdc1jdfrXC54QppRkScz+5uyGtMmB8y3xEAdu5+YbaGZbzyEeYR3inJvR73HT6WJ
         6l3X46hb6jr+Dq+ZGL36xiFOc1dreyBcxLfAm7UgGkJyrMD1VuVcEdKx5vqhG7w3lx4T
         k1isFhnmFeX2z8gaPQzJ8UiBGBZxr2Y3Lv8x1qdKNPpGxeBo/zLYMi1+01AJ+oh1gCTO
         X8ob0CEoBxCea3lWtYxbL4Xa47r7AP2NtoeK0jEScgxEVZpk8UTfI1JJmPseRA9SRObG
         HctO+JcMOZJbH0YUlsWlhF7ViHGd/QEBfKMZGoZeTds9MmlWKb2D2KO4qcSMEendpjJB
         I6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757175567; x=1757780367;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IpxwdW9Eq65dgNQSqH0zCtVNg/EmOntoXaGWmsXTDgA=;
        b=uW3cPNDGyAqZd7GKtCWF1OB7kz4aiqtCSSaWDxoYdsQccojlp0xc5Cre+/hMmfTylB
         Svk3SlVzyecrurvGHYjkrexHp8EIWSaZtumD9LOEQ6R7j1Ns4Vo8SfZXqkl8BZXdNCHE
         CBpBq7hMA0sMe8D/0k17wYvQaEx0BZJkJjSynEXPdsJaCmWFyISbziIEvDQhOi7rsLbV
         ev4gAaVOmJN6lKLa+fX/Uh2VN0fUwJuhogY0cDid8EJXLZC0WJFm/ToDIvNxypMM2SOu
         ooQDbhtmNyxF5KzLPHm1t8hbn3X4+K85SDlikA6Vd/1YIORjstHEXeTEYoms3YGRaJKg
         2HaA==
X-Gm-Message-State: AOJu0YyXdxxlZFB2mN6LS7vnQJ+nfTHGBtUBT8mVgFqptZCRJBPP1eM6
	VKLxA8tYBnyBkF+XV5HL/wc59vI25VRIXSg/ydCIVT5e6bhg2q8JQ94k/HZQMGA=
X-Gm-Gg: ASbGncv5iDlriWG7EljnTzmrhYOfMe7l0/PMigHzCfO28KQGcEt8JJrxIWe1AHVWVyJ
	HUtmPe8j97+xaPl6gy8XIwLgMMsciRQ5PSbInL4eiCFu/oj/dJ0tqeCCwwWYb7mulD39fLigJsO
	6bDiW30SAB8HBwiPWxAMhFggJSpRGvnu8xGBAe2zAD2s53K3XPptbNqzv1DR3NVfbTfzhxu6edz
	EhJqWbEx37aBaFT3V272mL5FSWqlJ9eoUS+ngVy+i9iE5T7RHf/rPswPWImxWl/BPz8JWz6BCKS
	ldaq4g4FFisC8GaioteqVCa0AVrRO+dfxXq0/gtyLcWGwLdBkWgCyxv7hwNJxyvqtvtfs9OXJV8
	jmyXu6pIDi1t1XnTT8tDVdiXCTuQMT20tJQidqLpJ814Ls23DQzbbosDZWg==
X-Google-Smtp-Source: AGHT+IE0Ap7bowL3cVS8Ajuj6bCC1GQCer58VMJRITqB/r6utStVFc3TZ6Pq3BOzxAa5+8tYhl4EhQ==
X-Received: by 2002:a05:6a21:6d99:b0:246:5be:ca90 with SMTP id adf61e73a8af0-253777539b7mr3185418637.10.1757175567196;
        Sat, 06 Sep 2025 09:19:27 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b65a2sm25123290b3a.34.2025.09.06.09.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 09:19:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250906-check_data_fin_ret-v1-1-2c8100bc20eb@kernel.org>
References: <20250906-check_data_fin_ret-v1-1-2c8100bc20eb@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: remove unused returned value
Message-ID: <a5a6ef45-1d63-fd8a-b81d-e89d20ac0971@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Sep 2025 16:19:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): selftest_mptcp_connect_checksum =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/175157=
31496

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ffb29b394e92
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D999625


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
