Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8AA6CDBC
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218611; cv=none; b=dSzdN4KVfEJSAOHjYhGyNQp+R/uMzHfPxf41IbWZdRnt7fogZD7Um3Wv7OA1VTLpGTaZFSfFYnvf9DwTsBRGDEk7aqa9LZ8hUL6HCa1RHV8WCst4G11jZ03jIR1T8LRDzA0buE6Y1Sd0ir5GD4GiAGDmBRgz5QiGWHP6brUgmZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218611; c=relaxed/simple;
	bh=on38X3gxRlR/1bjHtDEk7+NWERmR/5b4/+P3Ac8y+/w=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=JoS3j+S/dhLH+X9QlHkJw79KCldhw+NlSiKS/m2f8xEXtVKNvfdS/EbFyn25e7DiKTQ27ihJt/AoJT9tZuM6VH1vNWikABLPVNrs1Nq9ct6XKeEYUGjtpAFqSoIID2EXeEYLcX53qQAE8jJ9SmAzGxSr+Q8Y7KMXhWmd8ASfkmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtnZf1yZ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtnZf1yZ"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-69936145586so634206d6.0
        for <mptcp@lists.linux.dev>; Thu, 04 Apr 2024 01:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712218609; x=1712823409; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z16q3MctzPlnyIU8Z4b5jlAomm8ZYVtx1Plpwp/Rb7o=;
        b=DtnZf1yZb8x/vp+LXDGxjVvtFdkxAgEz8D7/6y0vWR2PJONOFvmUEUO6eLyZwlNoko
         85lQsevllIp+LvQnAKnrGOLLNzz3CqSpiGBnDyRqEEj/QR9l2xUzV0DutCRwgQlmX2FT
         KBFdli7H9UKc6POyDKtHyXqZc8jPgNLCPrhvl/jb2qmuvxcOKNnSBWajCiZh0kH2YJBz
         Pbs8ajHhz464AtZ8nZIunp15rSGPfgY1PrFNKk0XAFiK5Uzjg/UAS8Nrg2ZAXhiT/b6f
         GdKmox4fedCDGNACA5DtSRMuSKHktIVox/0b3kgLiE5oYsxXHnx2iTiVX55ZXwkUcUKV
         fhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712218609; x=1712823409;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z16q3MctzPlnyIU8Z4b5jlAomm8ZYVtx1Plpwp/Rb7o=;
        b=gs35hcPxiswXu3vOzv0NeRvhI5Q8JAPcl+ZbxtjfGTwTNmFcRsN2JaNhdWI1R3KJPS
         dzmfFGlq+1lIpFKMj89xxc6nnYOM9hBk2qKI+6hZVcUy/OEbq0ZVEdab8ws9l7b5Bc95
         UciB5AFKI6BzH6TjBqND/isJRFk06fzD0q2FEoib9NyKYEKdsSKEcH98EXgBvlGuaVMA
         MrEr4s4QfMv33Sgm92IUA6AYOorX6ABUrgKBV/wbTu6EuIFqYaQBQDKcrewDLE1ZAynw
         0GKKKinHPkXtqIPiIEODfUhWUVpeKoeBpbD6xt570LxLAwj3lSc6HlJwOx3DblcchLf+
         hhoA==
X-Gm-Message-State: AOJu0Yw+hGFMveYaK6xgIFUNfcQH09hcAiuakZ9TJ1orr7NPPJubjUrc
	0apg5LeivNW9jHpGNCy5Mp0vaZAiXJiXnel5ZSHR5FtC2DeQK9c=
X-Google-Smtp-Source: AGHT+IEXE88FUkFebCmSrw66hLTpUcCEjtaWX/QhA65j1sAA6VW9vKhOassPCGy4keZOzT/oJnr2sQ==
X-Received: by 2002:a05:6214:1cc7:b0:699:514:3046 with SMTP id g7-20020a0562141cc700b0069905143046mr2181615qvd.15.1712218608679;
        Thu, 04 Apr 2024 01:16:48 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.206])
        by smtp.gmail.com with ESMTPSA id eh22-20020a05622a579600b00430ac082732sm7472804qtb.70.2024.04.04.01.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 01:16:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jason Xing <kernelxing@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240404072047.11490-1-kerneljasonxing@gmail.com>
References: <20240404072047.11490-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next 0/6] Implement reset reason mechanism to
 detect
Message-ID: <481dbbe6-94ee-f8f1-7331-4c797af63b02@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Apr 2024 08:16:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8550992244

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6b1f99284a95
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D841302


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
