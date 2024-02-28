Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A4D535AB
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115701; cv=none; b=bF1DX+8mqaXR5rAsIwz5JWg4KR+poApc5HfhYgoQV92fBnEUd0rY/NQKO85zPibe7SA+EpYGnzpxWbr7lbxu4K8MtrsjCJkYPluLNrik0zluBuvwnw1D3kTieTcAj4DdC+DnI0s5DqL8ldZRNuG8j4siZ7RYjGtDXR/Jvuuo1yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115701; c=relaxed/simple;
	bh=W12t/1qE1RRMpZPrjQ8tWSWIgvK72W8thurVIr2eWLk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=olyylCkBdnCldKVA+Asz59wGubsFSCcM+/nvg3H8A8Bt0IAUWuCxm3bdGNVeFyp7Mwm2Ujqrdi/Iett+2XnlxaNhLsgLKE6HXWDV9hyVCOfSaeJ/JKXPXK9gyj1q1QM2RTWoNsu/n5QtHX09fN2Yvi1JIvogNgne4OsWenoyURE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icKIjJWF; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icKIjJWF"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68fb3a3f1c5so19188706d6.3
        for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 02:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709115699; x=1709720499; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XavMbJBKLs7qkeQLonDS2mo3GEbZmJzx+U8J6huimtg=;
        b=icKIjJWFrcm4F4RVLml7Hp4PWF1kp4zpIxJwpYiBMCapjKDCV+SYWGYmZC1cau8p5r
         aeRCFDF+FfsetIEb5lDUdCzuwLObXo8GBFTFaNiYgqMeWWAX/BuXlpVZVEKb9TFfUemg
         A/P9zcyWutAvmbh5ubVo2OIVgTOFVgTpw8VtaETIlUPJbM+vRokECsq4tU4YFV8zKHFs
         KoBuUJS5INsP9UswVETLtFkJ/bOmSImIPC+LlBqfsdbkrn6hqpGuFKyqIZ5eeQikYJDQ
         aHr9G4ZEO3F2Q1seaUuNMOGGFBDbhwaiNrrngj9UQ9dzpLZUxgCv99JBLbJvfr4ffi/O
         fG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709115699; x=1709720499;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XavMbJBKLs7qkeQLonDS2mo3GEbZmJzx+U8J6huimtg=;
        b=M/rcLfEgTwExCKI5/gPdFjmAQERkdahCD0liUQUMLSPGVUZjFHdxLcuNskFtU7kpt9
         Gv6C5Z0TgJhRaytQrTVsmyfy3VVjL68VGElmTuDW3FLw092r7O0JviJV6Hb3Gl0c2aLc
         ZToVkmbXt5PX+meEXMKP14Zp8a+8YRdft18MaA2e6+4b9ChDAsNPaSTcXONRTD0Ud4u1
         2BOKVPgEJKMpQI3uZ4LZOTMwTraJxSFxM7ZZ8KOAXrPIAcQg6yYf8hTFjpEnzuFZoo+r
         qFjWOi6wvJhttZ+kNu9eH3bGpkad3+xERz2+4gwzUKOY3v665iRPu2Fei4Gbf3e9qOCZ
         ZLpQ==
X-Gm-Message-State: AOJu0YzHcoCTysgjaB8kz+W15ZwBmFdo58b8990jvcfJfEEr1vB7bbQt
	ZYGwTW0XGhvT2suyXSLlY4h5PjNIXMLZWcQLnhDa9TBHmQcYduw=
X-Google-Smtp-Source: AGHT+IHRpJvQg05pJEiykfm8REP/dkzyZvep3LwJYHn9NBVSqoaym/0Srsg/oluLpePpRojbDLKpkA==
X-Received: by 2002:ad4:5dc2:0:b0:690:2c3:941f with SMTP id m2-20020ad45dc2000000b0069002c3941fmr5050207qvh.13.1709115698888;
        Wed, 28 Feb 2024 02:21:38 -0800 (PST)
Received: from [127.0.0.1] ([20.55.118.245])
        by smtp.gmail.com with ESMTPSA id lb25-20020a056214319900b0068ff2b62f9esm4599460qvb.141.2024.02.28.02.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 02:21:38 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240228095858.4117568-2-matttbe@kernel.org>
References: <20240228095858.4117568-2-matttbe@kernel.org>
Subject: Re: mptcp: continue marking the first subflow as UNCONNECTED:
 Build Failure
Message-ID: <013cef70-d5a9-986c-651e-ebde5ebd0692@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Feb 2024 10:21:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20240228095858.4117568-2-matttbe@kernel.org/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/8078767443

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/405bf7b2a541

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
