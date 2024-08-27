Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777711C4EEE
	for <mptcp@lists.linux.dev>; Tue, 27 Aug 2024 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769183; cv=none; b=Sc+7tjyuJb5Esr01fdQAgGoQVeJq6Bb+wcAq10rAV5mGuFfF7grRploNIys0hdFb2Exnv0goGBzfb8VA6tXJAa3plUbZFm4GXtxwTPQP30Yr7JitooUggFff5qMsLd+WJ3/TKOUUf4gfu3TKFxGTiji99VDqgwBKQ3vL3EcAUtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769183; c=relaxed/simple;
	bh=MsKvpbTRE517YYtfMKHAmNE5hcdky509gcinmGfxJhg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=KSJqmtaMwUZWFhSn3B54+FA8p82gkRJWRGbXlxQ7CyZzmdZ5aguU02aM6IpRWF7wl+skPgHB2r+HRIVFN36fjqrU7o6Ba03wG18kymRVT0TWK/MbAlu0BwHC8aJNzHOz54fSEu9undyVG9ISBihzY4JuRY7+kE2+8nELbV2KNOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHB3apAk; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHB3apAk"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1d81dc0beso340480885a.2
        for <mptcp@lists.linux.dev>; Tue, 27 Aug 2024 07:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724769181; x=1725373981; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2F043aXfkrw6OnhqDAgN4I4WROXAE5AQRvg04xy92x8=;
        b=IHB3apAkH+Vp4RrML9KKEjhqkvaDKr+jpT/oZ93tIMqJQWwUl05F0z7yC36Xr7QTE/
         EHS43VtPVq1A2bmKL6++FTdiEHF8QkEG61BhBNIeLcNlBtLPCqb5hnGhfXo8Jb6FMpBZ
         7qzFDEXoNq/L0Pqvls9pV26lkKOU9/+55JMrYxPctPq0tvElAhZ+1fEWKo9mWzbNLebW
         q3vk1Q4+NxvjRjh8QnhyXn9LVGnYFOO4H+dgjeAjDg5UcWZ4WaKzcHd+5QF4LRxK2J3a
         xgiy6En+x3H/WJAvz6ddL5SbX/EokSByFnQtmZ0+krT7Lg7kj4k5nI9XnZ3Xn82NqVWh
         KkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724769181; x=1725373981;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2F043aXfkrw6OnhqDAgN4I4WROXAE5AQRvg04xy92x8=;
        b=ZCV2Q4jS7ABneah9bNutjmRzDSH0cbAooi75xIBXPhoLVU6pT6XBAvV9yWSD82A46k
         6bNAfGhG59kH6/04mNg0nssR47CV7ldkZrVpm3rs79xS/Xkx+YR0Z+ET1wonacoVTsmh
         MpNlqHJqeDEsHtwSH0d19a5dwHOO0Nm+2iWVkVx+BaKhDTuhp0r5wfR8tyQiPTiUx2xr
         E8vlLGvsgmSesUJWxpd7070oxAztdAk9gG4SQVnqPWfJ15xYAAqUJ5E/xmYmE0f9/qEB
         zTbfNFH9V7zWBcacXSOL3PNdWQpHx71+EK149sQgTo5i5+Ka0i974huGRewCGSNwO6Sz
         4ODQ==
X-Gm-Message-State: AOJu0Yx+F/bt6Goi5YOOeg+rnSid+SBnfnCulABFWXdDkGEwlreEBSCv
	92IwepKQGO95p7QhTiLTON9FygylRCPgtinG4mSDtfjPXHX1IVE=
X-Google-Smtp-Source: AGHT+IECdIVZuIblv0nshb7peAbop3SPMAKF6IKUkxtU30arYOIb4LXZ1vpRqPiyo++1fnFT71SL6Q==
X-Received: by 2002:a05:620a:4082:b0:7a3:78f5:5fee with SMTP id af79cd13be357-7a6896e387emr1664872585a.5.1724769181194;
        Tue, 27 Aug 2024 07:33:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.223.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d494d5sm56697856d6.32.2024.08.27.07.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:33:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240827-selftests-mptcp-longer-tests-v1-0-ec11c05fe980@kernel.org>
References:
 <20240827-selftests-mptcp-longer-tests-v1-0-ec11c05fe980@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_0/2=5D_mptcp?=
 =?UTF-8?Q?=3A_Squash-to_patches_for_=22mptcp=3A_mo?=
 =?UTF-8?Q?re_fixes_for_the_in-kernel_PM=22?=
Message-ID: <d6712fe7-6f4e-20ac-a7de-0bfe3f8c904e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Aug 2024 14:33:00 +0000
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
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10579504774

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e5e931378c30
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D883825


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
