Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED6B69DE4
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707377582; cv=none; b=eWtr1c9TWYcTp0IB+JruIk1OYblprnsyxryF2Vwj1LWmm9KDjlbL3cZ+H60qnDLdeNVk6lpONuAjgKyydhdy7OqzZjCt/WVfsHS06tuK+H0IXi7o1JCMMgp1xHgyymIHgbzKwS6u+tkd+q79VFavSotHlBEEaIvIF4fzP3vhddM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707377582; c=relaxed/simple;
	bh=Knt9cnPlXWgnH1XGoIHD3A66D862g3rDsL2G5tcvrW4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=HB1lbpOFzUNlNl5rvR/q6XdigxlvmNnb5rh7caJHHwnDUK/bGtFeQ7ORJ6BCVIL5r5yhaaDl1vIPKFHojdC2ncHBnzdMOyuExkpPm2mKvS5xen2UXz3a48fgQ3/ZrAXrlxzS/JbdA64LfzJm97upfqFEf7XclrDzNnab/Pclfjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsOcaBCP; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsOcaBCP"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-783dc658b59so89406385a.2
        for <mptcp@lists.linux.dev>; Wed, 07 Feb 2024 23:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707377579; x=1707982379; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/CH5zTabh5gSZtc3l2UXbBXTh25dniYT6NF+NJy2us=;
        b=BsOcaBCPePHZAvfC2dFa3Rr0XFz52dgtHURn3ISpkq/RzRFG5sbi5lWXo0ZfcgOJEm
         No6vu6vKTWskl71EIF23+HTAi8AD/SFXiu8tqNUORudvLWMTrnpcnjGCGssIkNeWkF7i
         ZIhviDMQovNVjINWPT1UaSXvXTTogLr3+nwgNZcpRfsreRzE3F9KNpsqMQzpLKrDRPyv
         YjdwRqZw6tRmTyxYqYUdsSifoRkWf1bwzZxn798day17Xdi4SihL7i9DWN/SgWyLxnUq
         3oUaE5RUEMYrgMPvzPtsrnBWHd5OZVBHPWLRGetj4rcFUezCcrR+xZkQQC8qQTueJBeS
         4cdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707377579; x=1707982379;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/CH5zTabh5gSZtc3l2UXbBXTh25dniYT6NF+NJy2us=;
        b=q5IxjPf7HFp5DR3zBFKaKioQ1u7l1SflbOWNzJWKptB9ut0s/vTQuswfv/DcBOViOg
         1NL5ze/HubS7m7n9K2ScsQOPY4LyYRvrMbBpfgrR0xOWNnEqNhv1YAugdq6L/zh+rCJ+
         HyJKNid4Pic2NCKaSU977vfKCbtFdFwodvqyYEul6Nmnnhw5xpa6vJExPUWUgN6ztyi+
         m+8r/HWpvNoFqlW10WaMqHxi5u40Dv6lcyXGD3oKHcxTLoSVGVNcRMmIGZnDdHxDbrgg
         +37kNiTKwlkelibTyvkH+Z1UG5S363m3KDxCy5But3kJEP7KEeQBI1wCxPFKN71M4Mps
         GPOg==
X-Gm-Message-State: AOJu0Yz4pOZ/mJepw2ebXM863fn97ah2v4VOWxHO44eA15CVO1l1rRCd
	arEZpI/r41WLrDnT36w1SEImxsJKCcx23B19VhFVlzIdlCzKtzID9G/UL/4=
X-Google-Smtp-Source: AGHT+IEv0J4mqAPwPk+7WPsEJNwfnAt9tAaizjgN6dKnXE3yssZU89lNOP4OyoP5e7FTjx985mhJ0w==
X-Received: by 2002:a05:620a:1477:b0:785:9516:90f8 with SMTP id j23-20020a05620a147700b00785951690f8mr6317900qkl.35.1707377579441;
        Wed, 07 Feb 2024 23:32:59 -0800 (PST)
Received: from [127.0.0.1] ([40.76.119.128])
        by smtp.gmail.com with ESMTPSA id h22-20020ae9ec16000000b007854d5238e9sm1194315qkg.121.2024.02.07.23.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 23:32:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <69082b9835463fe36f9e354bddf2d0a97df39c2b.1707373307.git.tanggeliang@kylinos.cn>
References:
 <69082b9835463fe36f9e354bddf2d0a97df39c2b.1707373307.git.tanggeliang@kylinos.cn>
Subject: Re: bpf, btf: Check btf for register_bpf_struct_ops: Tests Results
Message-ID: <04c27777-45a9-6da7-2582-2a638821fd63@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Feb 2024 07:32:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4767446159065088
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4767446159065088/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5893346065907712
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5893346065907712/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0a74337f9112


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
