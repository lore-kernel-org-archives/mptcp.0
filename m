Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13324206E
	for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732174319; cv=none; b=NR7j4LXrxQUQHC3Hfb/vDzSoFbo89kWFAB6PoZlJnOeHtyTXr/G89JGQOwbc6hEoDypdZ6vtElhSti2eFQmkdogi9VapLAVE6jZk0t7Ii4jDjpN3blBGLTikI1wB320jXMZFr8UAr9Eq5h6WvpmoX4mc2ckaxpiiphHWVzRvcOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732174319; c=relaxed/simple;
	bh=ylWnF6qjTwN3hJZDOedIehQ9YYRaQ7nMeK1jUHKslPg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=jm4jCoM5kxTjOZXSYIM/tK9A9JedoEuW0bTPg7pGh1rFPXD5ccCmMbTDTJaEeaSHAwUJ8Sg0jK2O1aP/2wnXmFLXOBEL+8Ibno3EtfB5cwBKB25zTvPgY2lS5LNtpkUONFOaP/RGoGNj8uk7yCOlfttzFOgDqjfR1NFV6TJFlv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJRN82eB; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJRN82eB"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso453973a12.3
        for <mptcp@lists.linux.dev>; Wed, 20 Nov 2024 23:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732174317; x=1732779117; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCiJBf2+T+ejv2tge+ahlKit+EEHRtqQmz4AcBhxhWg=;
        b=SJRN82eB26YuWWLv3KmU9QzgFVAoyVrzH5Chewv96kX+Xk6hR0RQbtsn/SOW8SUfAN
         SNxbUGjOb95EA30l+DOHmEXbmoJDdmOiQiDeI0sj7nGZQhr1ZrmiwusUPjE4FojfyMC6
         j0wGklInmmgLVfNf7lEutGz9jlhaBieVZ+sgRRPxuH+xx/XPTBc43EfcSJt+o9HWO8O+
         ggx3L2ZoWH1eC+gITzwN4BIJAQzr9klUjNOFAD+s8oXYOcq6ZxyBxEbJZWxQc3359CI4
         Jz8Tv4q7Hv7e0ZaIB9kSvIN5JqvoVpRsnHSvD4AB7u5A6uORLAlB2hdjap9h254yQgxZ
         610w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732174317; x=1732779117;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QCiJBf2+T+ejv2tge+ahlKit+EEHRtqQmz4AcBhxhWg=;
        b=E2AC8uwbN0rav2wZS/SUpH9mTTHZ9GjNQQ4FgK2vct4dAMk324qe8YA62NnKuc9Ust
         +g6rpEHvpEx0nEdweoFruNMNyomdP2V2W3lqc6NV2HDaMH3ZZi7VqtItqclEgbYxeMc8
         RBtZ98FTIkNrik2SqScD3OtkPQW5XTqueMi91oziCCm8aLOwYBUthR/gid0/8XZPi/Kb
         8fie4W62Vt+lR69wbGD3D9WQrl397b70zXyt4AxgIqcdQJyndpO26ousDUh0ldoJS9WD
         UWSaBxwBivdUGJQ30HKyLWvZWfXni/SDNdqqGCQ44bwJWbv1jTRQ1/s/sCaSuNnvAFxT
         lV1g==
X-Gm-Message-State: AOJu0YzSY6UwAbk4nMf81cOcIhkVEZQ96NzYGCXzUE0Sg6k4ZZIuano+
	QA8V029Tyt2tJo7x8w/u0wHS0Pa7v8HlVg/5otKY8LEJF5tfezsCocFC
X-Google-Smtp-Source: AGHT+IH2ROQH+3S6zx9u/9WpBgT/HJVA3nKVzLq6zjVTkzyRViK/fNr9Lp2Ty2WiC/dukdt8jD6Gow==
X-Received: by 2002:a05:6a21:99aa:b0:1d9:d04:586d with SMTP id adf61e73a8af0-1ddb0625117mr8051684637.38.1732174316988;
        Wed, 20 Nov 2024 23:31:56 -0800 (PST)
Received: from [127.0.0.1] ([52.225.77.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724bef8da6asm3018205b3a.123.2024.11.20.23.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 23:31:56 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1732172851.git.tanggeliang@kylinos.cn>
References: <cover.1732172851.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_0/3=5D_Squash_?=
 =?UTF-8?Q?to_=22Add_mptcp=5Fsubflow_bpf=5Fiter_sup?= =?UTF-8?Q?port=22?=
Message-ID: <5c15a431-46d3-2ad7-672a-d7a75618fdad@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Nov 2024 07:31:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/11948563035

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/b8=
5b1ada972f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D911431

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
