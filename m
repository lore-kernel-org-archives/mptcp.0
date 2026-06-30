Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B82B477E43
	for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782836906; cv=none; b=Gni2afAkmbMSxgibNXlKr5OTUuKd8QBaOt6iOiMI4M7uEwAFH2WVETCf3h+JnN/WYamYNNYwiWfl0AgfcpQoq/tYYEiovYl3C+ow930si491VU4AdM+X0xAI0n6yGaa9wKEe3Zc3F9UcxYiN78iDOwUvAJ+1kHzTx2kI0atrWlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782836906; c=relaxed/simple;
	bh=7j975v674j6jUBq+ADCnzZJLKBhynuhJnuSZZynRza4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ukWwF8OM2FKV++yI0Ym+Xox66jMlhqpXilln/KtoT2z5vsGHMDMdmnfHnBX5NSaLOkHlftERrKdwBdNtfr8qpNu7MkPJgY1/M0hyD+PPydOQs8zuftebL6Bz2zILRNi1R2u5es8tJf8WJcPcVsbAIaG4voo19EVYw8rwA/bb+9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJDovTbP; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJDovTbP"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-13981833e13so5677001c88.1
        for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782836903; x=1783441703; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXGlicWct+mMQHNq4fc3uTm1G5CzSQkJAY/zpSIltqA=;
        b=VJDovTbPC0xqQSf23BQKEz/zcSOlvUJRaavYD3rycmZgLK4g+q3XrX072hjcIMFQTu
         8SOq3GqSkMiLWY+7/FsFqzZHDF/hIhHQQE2s1ypCe6cfyT4Lz/E0BRm9lxndrEccj0ZP
         MaZWNz0Px1q1+Q6cNLucARdNRhtV74vtwOMss3F+jtX37W3D7Ds/jDuKbFUiTtEGT2I+
         vduCYGthpxozRi4M0AdPBrQWsJrOWQuoNnFLJLMBB7wlooGqnn2/x1g+eUAyvXpgcNW3
         31DUdx5huRRUbLREm43afBwm/qZiPCpahAxZUr7lRV9kk5ZHicY0o4OIV0zXzXOBPO0Z
         lkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782836903; x=1783441703;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXGlicWct+mMQHNq4fc3uTm1G5CzSQkJAY/zpSIltqA=;
        b=NYqqKk5Y94emYwbCW7KGC4OfIT3iyI7OZN5lFrv0Yjd2WEoSaZg3uz02y97PGKPwrb
         SB3NMu4jTvDovdqBEL1sUFyq+CdYlx1R3yL3QkYR86yc1UweO9upBqaSSINVIr+oOasf
         0UHaQv7aJvc5Dpk8Kk4jHksT4CkhPBvpVhKRjhL8f3kar0R1Thrzj1eapViA6FpaCXTL
         kUV5FEKBhMojUQtMeSEtPxxVH+YS2EO6rBxqPqGntjE1Lyn+7msZT5pTJmDhFEPdy2HS
         cm3yeD+eIgLCnLZqaxMvzcJXoFEh+p8h4wBgrye6VdovzJh+MEojQwu1OtDeLEhgbswu
         2lkg==
X-Gm-Message-State: AOJu0YzGmFxlJb0cbzbCS7xRc2wpbyhYVd2Zl45cGOOptZBnvIZMeXk+
	Rt3GJdcXiKMC91d2YAStBlpQ1tO1E3vQM7aA775cv9j+buIkmCprkhk=
X-Gm-Gg: AfdE7clRaxRWDcY3GfuiLNsrjeOA8g5hK3Y+/Sv0aPqDtDo01qHAiMVGeXN7leHoWTx
	v1LReCLbvme3ChGq+VcvdbQ6G4ypx2NZYBqJwf6pkD+k0hSQ6der9Gu/5A9nQnGUXZGziTQ1l68
	tnCl556v0l5EEo4SiJdJTBna/UVjOcgfcdtqqISu244/fmdCExjXv/ndwqvs14DgsM3lMs7Thdn
	KYJeaAeR4FUKjAd+hlWjVBbOzhRSYzhQkDCv7dtOdFshgBImx60GR8R+zsYvz/7j5T2XSlB7Dj/
	d6bSOCG3j2qWkP6w10idbsE1MDWZAf2Dv6Uug9WajYtxLlPFBvzr7mDI1smIiRPfFViUeH3GbTG
	pWqkARvjJJ2gDfPUCmDVNm4BzR0Dgwllx7bHqFBckbAPQojXUG+z5js9isXk+ZLUSvaxj0PYgKt
	YEXoy57zQnuZSi5t+x0xFsj/1mf3VINOWMFci0
X-Received: by 2002:a05:7022:4190:b0:130:7246:10aa with SMTP id a92af1059eb24-13b2a173044mr2395309c88.12.1782836903233;
        Tue, 30 Jun 2026 09:28:23 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.75.195])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2ab0fc3fsm10239342c88.2.2026.06.30.09.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:28:22 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260630150632.899750-1-kalpan.jani@mpiricsoftware.com>
References: <20260630150632.899750-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net v5 0/2] mptcp: pm: fix stale ADD_ADDR anno_list
 entry on id 0 removal
Message-ID: <81982c84-a5f2-ed8e-8fd9-dabaf03d5ad6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 16:28:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/284570=
83924

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/81b37efcf998
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1119114


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
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
