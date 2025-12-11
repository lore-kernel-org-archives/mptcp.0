Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4489079F2
	for <mptcp@lists.linux.dev>; Thu, 11 Dec 2025 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765480653; cv=none; b=A33zf9+TOswUX8enKgaI/NMdmBgsR/AfVK9ls4qSo/5RUCzpJdY3l/ShmlOGnIC8dzvg3xVeUQOBEIGPzeIVmb4YB3fxVIMNjyMuZrzrvZqMYA0A/A1qnt40NtRJibahWshvi9UwtuS1JNmLfHBJCwQbui6hBlL5UtM3gBfNQlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765480653; c=relaxed/simple;
	bh=4jlQiISe9R7HC+u2F/jYaC4jpPU85Ia5n33H6G+vyIo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Y39p6rJ8fdL8FHvyOLQGbNuCpJv13jHQb7D2uJpDVbrjcHfQfkHCbnfcD3OYjtEZIkl4piufae5GiNlzUXQGEBfatzhIu771a0Eun2qhdN7BKX62FgWrzORMJ7qqz2WHZurcEkRLUABVZsZwMHlHsJueRPK0sIbv05nZPlfC7Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mC028SjL; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC028SjL"
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-659848c994bso255922eaf.3
        for <mptcp@lists.linux.dev>; Thu, 11 Dec 2025 11:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765480651; x=1766085451; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fa2SHpT4smKfWEhnSw7/ej2wClLLq1kWHRMnI1H2s6g=;
        b=mC028SjLUkWHk5ySVrNOCQKGdGl+CCZZoSzLMrE7Y6/sYd3xQLraCDSIT/K7TX+D+5
         VhdtoTNrupaIXV3u7HuZmo8YrpUvD5O+36yAj6UjcExHJkfAsZdGRfRXhiAy4La5Y94S
         YF+ROpNZVc0BrmKt4D+D7BHrH7fMobit2pkgldOZwKj2UYrxiK/dCOM5+Cq/3tO/vgt0
         D9Q4L0UaYnBFlqyL84Z1mQmXuT6SLgk957+xakE+wQxIHRP9c0aqZHnVDLjH0QE8GHXs
         EIV5eT2tUe9UvcFa06CW++zBNCnmH9PsHSAxM7PXQvx7HwlaMuvtTv7qcjne2by+zI/d
         rCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765480651; x=1766085451;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fa2SHpT4smKfWEhnSw7/ej2wClLLq1kWHRMnI1H2s6g=;
        b=BOxGKEB7EOzld2qT6SurzNyNWlrueSlZy6ECcrsBR4sZHXzFpcpWO3lALRD9qPDfMw
         tJfiV7c5UyNRVJt3BeVMJ61BTJ6rbwyIKXv8EzR87VklY+fvrJGg/I936xrcQyXIDjEI
         V/XZgCQqo/0McSFv9m49wI1Ak3zQ5Vq79w+AzbWZ+izOQVHm2+R1ioZLt0vw7NrVTX3e
         h0Rs45rmAQXAki6FVLprwwTvEyAsfXejLGdhA7o58k8jzLfKtno8lBr0k45pSuLHVcEn
         6eSqUhP9X1qhFuqg+tB2foDtvE5K9PGD5nAbj35lbeALUN+JiejuNDU1K/SHrcy5+Hb/
         qPGw==
X-Gm-Message-State: AOJu0YyDz0MHEky2uMG3o6BGlUt5IV+mtIszVvQ8HzAaC6x2rrkuQdBJ
	RLi6ScDefm1vDcagaPi289Cz5AUCj4JRmO+XtcWWJd1R6P/NSQsPbt+0OX+8S2s=
X-Gm-Gg: AY/fxX4kV/Tz/m9cQLucQ8fVzI9lP1qVI7FQddZFMwwit45BKi0qgPydWiR0pQ6AbK5
	k/WUTabgvz7rHMopbyJ/HBStfTSU9GOC8ziRfyT8Fygz4YRKY2fDKSYiA9b3ybp2E4Z7nMd9HM3
	gw7RFgi5k+0cdXG1K4SP3ZrAATQ0JWEBMC1hzc5ZJvPg5DC2YLQQmC9qFz2ld0ALatSgAVIzHT4
	G6fpKPwacuELQt/hVtWEIF21fTy3NwVJzb1NcC/c+nld0lMG8CdOPluh8Vb1YDgipBL7+Or6mjd
	ICt0AY3KCH0+unqp8PBAU2nxT8v9FsfTk/Yx/Z1zzObxdnl8HlBp87ux+pi6LRGfB5jRMgMo8/W
	uE+TLakQCnycnZmRS9FGrMGGEKyqI7MQjOFxSq0FOozI/mFsAHqKRoZ8cg5445ZXdYihgSpzsru
	LjMlJudXe6yyE3gLVB5fTaw0UxTNkyF02KKg81
X-Google-Smtp-Source: AGHT+IFRbgtaIFGn+532TSvnBnoSPP4eKEGLoLu6Jp6ZV4Ql0iD2Sh4zbODklwuUJdcaAXHKHIZqfg==
X-Received: by 2002:a05:6820:1996:b0:659:9a49:901b with SMTP id 006d021491bc7-65b2ad9257dmr4033064eaf.72.1765480651263;
        Thu, 11 Dec 2025 11:17:31 -0800 (PST)
Received: from [127.0.0.1] ([172.212.169.147])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b360ef040sm1573290eaf.13.2025.12.11.11.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 11:17:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251211-sft-no-skip-new-cnt-v1-1-6dd6d70f8242@kernel.org>
References: <20251211-sft-no-skip-new-cnt-v1-1-6dd6d70f8242@kernel.org>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: join: no SKIP mark for
 group checks
Message-ID: <8184fbc8-5e8f-594e-1f54-323a43167347@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Dec 2025 19:17:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/20143199844

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/54a9be79c85b
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1032407


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
