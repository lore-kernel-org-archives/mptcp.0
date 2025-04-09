Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D7925A334
	for <mptcp@lists.linux.dev>; Wed,  9 Apr 2025 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744184027; cv=none; b=EAiE/nRMqRtcH780Ruzl8+EehuIsjg++aKLyjLNTUOfL4TBLjjd8PleHumdeoFXauqV4t8EKm6mBVng63Vm6JSvPwjAEZFhu9S9WO66aRCqw49KniyMwxoAHdekCNEEjOAI3Eh1Ly24SlXRZr0/Sy434tC18aAT+9fOWuIQk1fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744184027; c=relaxed/simple;
	bh=CzzHednERh0KvTlbtd3xmNYm6rDlfRQ+crsH7/cHLOA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=tG5ybvA6G6xhGx2OGiq/umrDgmF/qjDfeym5ZBKoP/m4b0ZCdfZ78T1YIPgGiZ7p9RdRG43Bh78N/OEqEWudg7wpD9LZgznxjQog7cqSfXdKsA+5l/Aj8Rnzdt49jVJ10YxAXnfoao0YhqUuh4jq40/GoyBmzs5HDYpl4sN/b1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUJBU3c6; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUJBU3c6"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7398d65476eso353175b3a.1
        for <mptcp@lists.linux.dev>; Wed, 09 Apr 2025 00:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744184025; x=1744788825; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6K1/SDgnXJq+yVuDwUYpTDRAtJEZEnELXOCQ0dAi3ys=;
        b=kUJBU3c6qrv0Fa1wGouqoJFkOoaMR5kE+7sv+T4MCuX5emi2pL7OghumlUs7oPIi/d
         fl+u1Qkx845mHQ8mgVUVIoSSeMFe9/LRvQhbcvdI3XM/U90qv9p649jmLSwZeSylGs5t
         3m/tGHhFXArOXzjFT15lzhGpVzAoOnRYj3XSvNyiynkEp1VkMqChH4nHM6vNHtoyhqGz
         pikEFVNG11GSlFqWC3da3DwZZK7/ZbrFBHEfKACDwDtDq6YBDc7YPnCKmCin6wqisW7K
         KOGabCiAL6+LVfKXGjiVN4FXvi6KUqvdloWKE9k9UMBOsDRfL3FhBfoOzfES5JjlgnGx
         1oZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744184025; x=1744788825;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6K1/SDgnXJq+yVuDwUYpTDRAtJEZEnELXOCQ0dAi3ys=;
        b=mQc2biZRfbhZuXbPp55shWa+HJb9/JuR0MKvEU7+dLbg/eI3eCEMhGvGy9rKaGXpnK
         ITLX2GE5uj96Y7cOB+6F+LzfiMcuzqKQZoBJpxUKyaatb+WM7O1LfVQx+nTzoE1dDgb4
         94gOeaVdG8LEUeVma2hVBr+eL4nFxWLtwOrUnNJFzSIa5+fMco1JBoyzrtryLAcIC6TG
         Q+gyAiXh6o5w9O2KmAPHOzCFDjtK3f8PF4b+bfu4AqvsnbML+BBenVHPiMKKNBRarF+9
         7D4xUqAEwmiGN6wo/9WWdXfjjwyWuz0uiJzDq27Dt+7voZccD+cK/qeMsqip+zMO2plc
         zAOA==
X-Gm-Message-State: AOJu0YzoaFbZpmEmHya5fhAtjZAq0YHrlCoAxmKl+VAz1yK2MdKaReQe
	kcDAFqLGoNZW+DLJOMKWZbvySsPGcE9p/Z3H/UXM+iHszfS9yRE=
X-Gm-Gg: ASbGncuIr/cITv2qZ/mD3iO5oPSx7HULwHOKsrhLHcJRxvO+WhP9eu0WX4oZtjWNGhU
	rGjmsBR83NgNSDs91eRChdGCgzCp1CO5L8cu+oMwb5fok6mcrSsHLvO264KUtRM7GGeOA6bK2zT
	jmSvS06zW/EHXG4rYxRcmM4XOzyptBuvMTTIrttDWGSrfKKTeRPESos04/9p4Tw8R8+rR5hAp4h
	lXWwsMvccNiAMtDJXRkQ5bpX1SGv50ddxeYwGIVitLhovYNAkwFAzGh4KpmLm8m3aic1SwXc7e2
	Tq9N/MwG5nvdnlYg4w7J2ZrYEFGB1rOgGFB8Wdxf6u62XDY92JQJPw==
X-Google-Smtp-Source: AGHT+IH4Z0fHsWVxtcMChNzwNnMLTLXdmkD53atGOzU3QrMCpFAW6HKNTW4Qfqzs0m5XECPwg0miFA==
X-Received: by 2002:a05:6a00:4651:b0:736:5969:2b6f with SMTP id d2e1a72fcca58-73bae42599bmr2442253b3a.6.1744184025196;
        Wed, 09 Apr 2025 00:33:45 -0700 (PDT)
Received: from [127.0.0.1] ([52.155.61.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d464f3sm618329b3a.46.2025.04.09.00.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 00:33:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <77efff47e3cace7d2dd9a1394d3ece4e234a5e74.1744178165.git.tanggeliang@kylinos.cn>
References:
 <77efff47e3cace7d2dd9a1394d3ece4e234a5e74.1744178165.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: use IPPROTO_MPTCP for
 getaddrinfo
Message-ID: <2a43fb87-e1c5-c68f-6915-b56a26092dcf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Apr 2025 07:33:44 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi zhenwei,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/14350513463

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1809498f6dbe
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D951400


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
