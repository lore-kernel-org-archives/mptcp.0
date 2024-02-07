Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E7E76904
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311420; cv=none; b=gEzs+JaGouesTtUIkiN6y+yiX1DPX4No0nYrSyTG61gqUYCAcVA2WL0Wst69uMu71PrILpzEp52UZs8A3sPsVonEN8K7RuSrIcKqzeTIfII3svj/+Rma7Xj5NGFHJ95q0b0ETsqnjcgm5gsKDZxm+pmzZD34uSfvryyH80XSevQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311420; c=relaxed/simple;
	bh=emHTcBJylgoS5wI7AKlw8yVTDTmJIVLjwoSRN/LJJqY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=LkgukcjbmnH66CJ2S/ZsN/C2pWyhr1/75uuOmdGcnsxLf5KOAlEVbILJ+FVHVaAzdPdZhjybOW1dWhFJJvQS5uHo+FGoATmk5A/oVcc4KZx6AgcvOCURJhk4LyuPa8BYKhkBgvWGgZNGmtB32/JsafzeMFN4sCjGDNU19U0eLVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GA68zkKD; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA68zkKD"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-783da26489aso33956185a.3
        for <mptcp@lists.linux.dev>; Wed, 07 Feb 2024 05:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707311417; x=1707916217; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MgQQWOxnppSFJ969crc6DW+aPBH38uHZhWDW5Jn85M=;
        b=GA68zkKD+ARYBdlo92yKcWZHrEoQjbWJcPGpylnikqI3QptcpfFWuJkp53cQe5llxC
         ZdefsfPIB1NBmU7LxTm90pajjx9hFeUVjjtkVFTeQG76f0SzezD2LEF+IMlOt8jXyedL
         97tu1P4+cdfQRGifUakhB8ztea6FakR/Ls8vFGAUNPYcQir9hfKYST1krUrua+r1kA/C
         Q0hazkkd8v47Fau0z8DgFrKygNvRJnaAjRPxmG4crxJ9t4I6njJBNL+w8as6YdoCEanl
         zg/EVGCL6MP6NVr97+At8GsdQF+yxcVWOxBkM+IkNjIBYPJDlXugyunh19NXIx5Ckaee
         fTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707311417; x=1707916217;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4MgQQWOxnppSFJ969crc6DW+aPBH38uHZhWDW5Jn85M=;
        b=Ej/8cGXdYHTmXyDyhzL8p45awgTjtC72W4OUwVvMuAd+8F0gKSqahzEhzSArxFj2WV
         QycmuCdkLwlln1CiHkNynLtyE1zNtAUp06343ftnmzQ0YYFRmV2Z6S0FgjCge9zwl/vr
         2555ML11i4tsigBxtDWNnN7YgWj5O39Z8EUPbJW2hoRvwoo+iqNPxMf0x6zS7Jx2+9L5
         SLfdNftqWpW4NGrF7tASSy/o2Zyze/tpPSAgQYR9pqouRPEwaxTrSYB2g21E2kwP/+Gx
         eEg9fQ+d8CQqWn+I/8dJNFXHTT65ZNcWczFi1ntBK6drNkzFRQCRvQz9b/NW/8m2584x
         e+5Q==
X-Gm-Message-State: AOJu0YwUpmPyHmMvEDMWlY76KV5spWW5sUqLxAX4TVhj3v2QfdOY/SPV
	INZZ452krQlZ0Jl6XsoWyyK5TMEcY2tJH7vAMwkbHLukMlG5AfE=
X-Google-Smtp-Source: AGHT+IE8Sijjv5/JAvazgaRJF1+PDCdvmP72ilmXv2dmt8JI5jiU/9c55qVpzfE665GNQiMXX07+8w==
X-Received: by 2002:ad4:5d49:0:b0:68c:79dd:cd92 with SMTP id jk9-20020ad45d49000000b0068c79ddcd92mr7067930qvb.9.1707311417687;
        Wed, 07 Feb 2024 05:10:17 -0800 (PST)
Received: from [127.0.0.1] ([20.109.39.245])
        by smtp.gmail.com with ESMTPSA id m12-20020a05621402ac00b0068cbd690c47sm556855qvv.116.2024.02.07.05.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 05:10:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240207-mptcp-check-protocol-v3-3-77c69c596f55@kernel.org>
References: <20240207-mptcp-check-protocol-v3-3-77c69c596f55@kernel.org>
Subject: Re: mptcp: check the protocol in mptcp_sk() with DEBUG_NET: Tests
 Results
Message-ID: <315565e1-ea1d-fa2b-753a-4721690f66ff@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Feb 2024 13:10:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5671751590346752
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5671751590346752/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5108801636925440
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5108801636925440/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7511efd6fe57


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
