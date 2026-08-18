Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2AB2BDC28
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787048507; cv=none; b=iKGd6JFZGiEhuWZit9S1BtX6DORCZ94qsOb5INsf9P4bLS5mHNxadBjlFguiZF0wCU3tqk9jUpWhqn79NdQvkwp6o774ONftmC/NOAkJqcCGGhDYnpCnwPwqoBA6+FZML0p7a+MuKUvOWAupa6s+Rb81OmTVCR0zFWDHez1Y7BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787048507; c=relaxed/simple;
	bh=/Xf2kI13fzIwYytqhusc1sTNa6ce1cY4DrldUZUybPU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ssOEUMAc57npsIvl0pXVm0gMRba+7lwJ13McHdEHU/cK8PZyE3O0z/61kygctSucH9zqrBHBU46hxD9FKmqM1yAVbY73dHndj0tNv6gCl35zSpOtnpJ8JA1iUHa1p+QVw//QaxGbJmL8XHxns6Rnf/KBazfOesxbOtU/3HWXiUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUXv7+6j; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUXv7+6j"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-934944f2d22so244729685a.0
        for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 03:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787048505; x=1787653305; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JHN2/ACk7uZjxZo/ZRa9EEq/fNGV+J5PhdHFgT21iZU=;
        b=bUXv7+6jefW83eYnlfJLPMDIhbAnr3g/BkvGHHOZNIku2DbTi2QqyvR/VRxQLVJK3m
         EKNkMkXJG3sc5YvO1YBVoGp45dW8V12ufSvvaepAeDtau+xLVrnzw57Ct9DXNbYiHc/Y
         e/jTNwhxGdlqofi8b+d8bXxLnw1Xii0Zam3vO9zwTAsjZEnBNej5vE3wn5qASJG3oaHH
         HVR0wCRievJTdm/kPim53RRwDw2gFXYFsaKVFw817ZMLy+EICBkX7ow7ZWLWV8xQvV1r
         hmRhEkVY3c4uhfLcxwbmAvNDGgikW5Hh/8mWHRFpHOEan9HJ2rh3ViGN8ENrRP88P7i2
         0eEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787048505; x=1787653305;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JHN2/ACk7uZjxZo/ZRa9EEq/fNGV+J5PhdHFgT21iZU=;
        b=eMOHeJlqu/mFIiUyVOJFuJ38y3G2mzeCQtN5UJ7emjp2UrPWSNTaTsU6gR23xdgv6V
         2O55e8UCmdRGLG9XbSv+k+v/DIziEzYR2Imq5xe2ATqTdbh2BChElyLW45+5Kr+qoP8z
         oKMgfTFK7lz4iQkNDiAqLwCaVwxvQam2n8nmhwXn5Q+eVh8eXuiiM6Hq7/BTDZ7y+FU2
         JeQ77AE4b53XVfT5ee2zi1X8IcYF7pBbHp0tgClc1/E4PYqpsB4W/dd/HJfWW1hy3B2j
         pZ947bLFdfU2WU382SpaFAtRzlaDHW9c9rVCSX9Fb3oJeGXnKDfLu1H6ucLFATNx1Y9o
         xNzg==
X-Gm-Message-State: AOJu0YyGF54UES7nvUjixOGh2aJzkIWkW2cFm6ssyOe9Uz9xicRgB7w5
	9jHZ8nuuUuzT5XbQ4z4cY781M6c5rDq9x6il2re4Nax0IzEFG0fSjLOvm+5e
X-Gm-Gg: AR+sD12xExc8igATpwOgjFYVmN8h1n5opVP8kkKeDGhfi7l8jT46MdBCbZvPd3YJ5pP
	pUR8KkD8w5u/AMjES6jp7Zu1wttBrLc+XsFsd3ZWY0RMtC3QqQOn80uCvTxZcats+1LsU1KgO4m
	WdYVlwayd9v3jv1KluYfHXU6sQGM9Cl933cnuWTm5FGHBXsrGa6Xs1sZOi1WD5yQw32pAltRpoQ
	NWcnkgyl6oF6xnmwrFSeK1NUfkJuJ+ikmHoBk5NsBUGWYLugSIkfdptEbT8NjOofdKpeXNIgBoV
	Mq3kYTJYclSJmYoyZobLLuOa+NUK+V1+0zEa34W28X+nfcQAkKbiMmT691xdrqUgPchY1xUmq9Q
	/JBI5vp5NcSAGHplXXSo0YqOOwMe+gTPRKm9Hy+PY86auxDWc3UOT+4cAENkTSm1tjMDvWQfoRq
	A+vKtfEJuKApLgPLgwOtQnqfT4cfD/qisEWGfJ6XebVNoEwxPoFUAxswIPlMWoRaQ3RhYUd8mjd
	8QxIar8Oj+Cqg==
X-Received: by 2002:a05:620a:1713:b0:930:b068:8c03 with SMTP id af79cd13be357-93704bbfa1amr605488185a.34.1787048504589;
        Tue, 18 Aug 2026 03:21:44 -0700 (PDT)
Received: from [127.0.0.1] ([52.152.180.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937010efb6esm306728785a.21.2026.08.18.03.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:21:44 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260818091417.2200986-1-chenguang.zhao@linux.dev>
References: <20260818091417.2200986-1-chenguang.zhao@linux.dev>
Subject: Re: [PATCH mptcp-next RFC v4 0/2] mptcp: fallback to TCP on
 MP_FAIL with a single subflow
Message-ID: <c8fd9e42-aa87-c6a0-eff8-ad6f284818c6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 10:21:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Chenguang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/321223=
51648

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/02ed8cd94c7c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1147672


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
