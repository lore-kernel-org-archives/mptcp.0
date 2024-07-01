Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7969C8C7
	for <mptcp@lists.linux.dev>; Mon,  1 Jul 2024 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860907; cv=none; b=Wwq/BGm3+PxPcLrsHDoYy4tjkYepVNEu6JAX7r7mWIYRTJ62CsRp7DHa+AmUU9UCR3W6qMSVdjE/Ofzh3CzcOygaX3PRCNqoJkPwClOzXePsENRqRn37zssSOKgA5JjqYbauOSEQ8pHw2kCmPGeK2kuJ4ScsZYIUFz82OPtz3vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860907; c=relaxed/simple;
	bh=ymR3czF8jWWUwYYuintPNeyAhCcdShLuOBV0lYK5WU4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=FLvE/Miqr9aUfpBrMYNc6BBwYEDZGlR6VolvtS2iJasIQt5RtPGQx4WDMj9MJPl/ozykup/Erm3I7NFQxmafiVvelbRXwFAWTLnYiqGf619HpnUdsZ6XGIAzcxecqOuXtYFNbgXqyf3ep6Tmkm2x+ausx96PGu6KoHyCVvDGkhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsrqQtuA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsrqQtuA"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fa9ecfb321so19825815ad.0
        for <mptcp@lists.linux.dev>; Mon, 01 Jul 2024 12:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719860905; x=1720465705; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiUASAcvSSMMAkamAotHaL7YSipSiVsC8BtjXqEZmBo=;
        b=PsrqQtuA1ncIAZs0Evz09OcC51uMfI52xWtuW3r6F1v4R2TMWKqUlewkVXvZHFjfkY
         3l7pFsFYf/xLhDtbpYuVPuwiYX9OkInLflrGjEWxYQsGaaJAEjoRl8QsDyCo02yTSZfP
         yQOqqAnoQwZlcXX6mrS5wxucd1/MVP8peH0TRpspL/+1uVL0AL7PZnrQeEj1llliX3sn
         0kN/9qDgmDVvN3dpZJRHEtSv2DM78KJQOL2oHKzyltX9NkVLt4QO1UaTJJvmyJOVvlk2
         bES2IFeDPVK3+l8JfK2DLVJwo5P7t7Ad5kckpiVYTHRwIoEHf8OmFS5F1bDjKy7/VFbk
         DMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719860905; x=1720465705;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZiUASAcvSSMMAkamAotHaL7YSipSiVsC8BtjXqEZmBo=;
        b=tUZ38LtLutiWkb3JiiwDeqXebo0DkuISvTaBR5VP2Y9WLBd6odoC8MLTGoPtNCI+j8
         QvymAnGrGW169z/tPJNE9fD7RgKXTLfHqf097Ob/0XpWmnoEGV6u8ZAFt0uwAULixADO
         wbhbb0HymvDhLbwaC67ktjR6iDoxoGBdv0S3l4tVF0iIetdZvpxiZdd+iKU4oLHWPSzb
         wDizBprKHLHNjS14SbAepdvzqNiinkuDQX5EFW24YfmeErS8nfVe/rTsL6v1FLXC/QZi
         36Oo9qiriw/AB30gykiBHAHAs1gguQx/38JZdTCcOemd7zn8NgaCtFp1nql/q1+x8dOM
         NBWg==
X-Gm-Message-State: AOJu0YyYCCh0OgL1niKze8Etq19cTPKB5VBqamWgxosSv3AtvqTSZi8P
	XI+LfuHtM7WaYiyedSYI417iFl8bujLk/epQrXrFDT1yRFIncobUSH9o
X-Google-Smtp-Source: AGHT+IEQiHGsmwq2E5hgvTYcRYdJZ5XAeri99C8h72KXRU6YoFr0/rnRBBQqFKQfUwvjKWKQy4PGCg==
X-Received: by 2002:a17:902:c94b:b0:1f9:cf2f:507c with SMTP id d9443c01a7336-1fadbcb4858mr42219025ad.41.1719860903654;
        Mon, 01 Jul 2024 12:08:23 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.33.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d1c78sm70101255ad.23.2024.07.01.12.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 12:08:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240701181646.252683-2-matttbe@kernel.org>
References: <20240701181646.252683-2-matttbe@kernel.org>
Subject: Re: [PATCH] selftests: mptcp: add close function in main_loop_s
 function
Message-ID: <0586d247-9be5-d748-353e-160d35f7e99e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jul 2024 19:08:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Liu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9749324571

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/27aea1e315d8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D867250


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
