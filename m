Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5733D7D70
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011455; cv=none; b=auIbmQlMnBK9SO64t/K0wvSuAA2jPuMbGuaWBVLVlu7k/wnvS1KDP7+K8hPE514cr+Z4XSNlc18WyeMh2m4zFULTNx9r1bt+rpwcuMvojrz0BzkOfSv0PxY5a9Og2lOnIEQfurWi5UMNvk0jJAdmaNA+5K/tNMKFz5ZkkFlu8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011455; c=relaxed/simple;
	bh=KOzoXhz11Fe9ysxl6tRU8sIjKHg3Jqkh2Cr6iQN3VCc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=f8233Pwh4uPqW0uvZ32MFPvCp/xbMJDchtdZ/3Cd4hLQIAQBrGlDrdtqVFCBIPk3HLHK9PaO+gHJdjLeUuoJXY2Y0P8KuCkjr5/+yWCG3MrydVumSci6SpApXdo7ScrjOWoU2PV6ZR5AtZVI0FdLOLpDopUqspBtJ/ISAol6QBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQ1dKx2k; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQ1dKx2k"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81e8fa1b8d6so29071887b3.1
        for <mptcp@lists.linux.dev>; Thu, 06 Aug 2026 03:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786011452; x=1786616252; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zHWIuvGT+xLCIDC0K9jhKVJAabddAA0kyJ0NrCFI4mQ=;
        b=QQ1dKx2k+TktTRF49T9RDUlM+VQbCRTXJzqT6W9D0UjfCpovlGaW00xRnb5Yw6sTNX
         L5G3E1DBSe1J8JXODHiDS/HStZZp+rbAdtzpMYdnGWnbfLEZKm07fP6BHsoVNLvMQT8q
         YyjRLSNOCSViY/DHyyBhrP8MaiF6uIm4blDQbpxeNBaiio9lwsDEU86csqN6cq34tO+c
         I4zspAwG+eQLfG0kZe5TS75zE4bae12c8No2Psp7zHMNvZiIksSAG+JRyvFFU5hms5mL
         xgOISmb3H31NU73AJzccjRO8ZALJiFRkg3Bqqsf+GvvgIUr3P67pBDCdZ1jxs+MZcU8o
         GWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011452; x=1786616252;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zHWIuvGT+xLCIDC0K9jhKVJAabddAA0kyJ0NrCFI4mQ=;
        b=BPGu/Kxffkd7AqzFx3AxaujksgkDHIc6kKR8reTnDVMrGoh8wMJk7Bcqf/iiGz+Kyo
         1F37RjnM1gUydyarL4YwQGcg97Uf3FP7D5sG0r1SZC56QUKGo4gs00TRgwSSMkdGVxpP
         ZPfJkdxv8CnFzBd6xQEbAcxpXB7LBRZYEou16R076vquHVsCugDFl0sAhsE5qaTyRt4h
         Kmm1gu2TUUxRLaqWLswh40hL6ZyDQOXYbFQG0Y7pz7LvoQ3vTkZ/Z1w9U+tk2a4OP6iC
         F7i3QFEnBAyEuN4vKOPTACD9miGhXKt/KZZkGG5Je84BBp8aqwi7YJJldBqNevbnyeno
         AfHw==
X-Gm-Message-State: AOJu0Yy2IneY6Efn4yK+nv7FfcB1UHFTlMBqd66jj2Pz6o05XFMX8Ymz
	3BZqi3HinNN2Jk6ma4xsg5+chkJ8+Qe/+d2qi5cUfD4ZTHjfwmzNvM5Ll51B
X-Gm-Gg: AR+sD1247pqzWTievHP6sAYIXHYnKr2L8yd88kQNx4APcaWkz1ptf2a/6KDhG7CTbUw
	u0kVEYQfb4dqU66a7pM95BOJZ9NYlZUK4ei22po8L/FlEsoROwnZarJITrNVfH6WV1on6D205YY
	JLplUs963V+Ii1w5+eINEiBCZ+VM3rDegn/4pn0aPY42oFPz0ONDkOv22Z4XG4Cm/mGaOXdXSQM
	yl1eisZjMN3zBf59UbrtvNYJi1czZHgV2HsY2BlrPgZHRSNlhpj3rI6idCLC4ZUSAiIfakqFA5q
	IyJYs3yuvkJZZwrdOiYCWAIqEXjCzLAR72PKL3N/huv+52nc35cFLF7RhmpssrL83kN9swoeAe7
	cQvkNjlXfzq/zX6qm4En3bSlC1NAvQX5r5YHcuV8k0O/oJ/AvKeEqtMXeYOEsGhQ2siiEPbk6YR
	xMjBnPtF1bW3yYQ0Bhcw4SST6xa9OxQP/mDMxFHtk7TmQeTu7oheZictXDTjK2rnraISH2F4YBM
	GI7
X-Received: by 2002:a05:690c:7243:b0:81e:8d95:3d32 with SMTP id 00721157ae682-820222bbe91mr81770407b3.9.1786011450908;
        Thu, 06 Aug 2026 03:17:30 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.155.230])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-820134a8e08sm36512557b3.41.2026.08.06.03.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:17:30 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1786007209.git.tanggeliang@kylinos.cn>
References: <cover.1786007209.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/2] Drop mptcp_pm_subflow_chk_stale in bpf
Message-ID: <2748d752-3a54-e58b-3745-081777065d21@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 10:17:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/310893=
66128

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b071ec3b5fea
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1141341


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
