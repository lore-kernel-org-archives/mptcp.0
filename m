Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3703200A9
	for <mptcp@lists.linux.dev>; Sat,  7 Sep 2024 04:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725683913; cv=none; b=IR5dPTCwcGkER1mSwa6bC7xmQXHCwkzUzDLiWUOZHUPcDNyQ6mVjjxJARsYhp+kLmy9waDzEcD9n4EyBKY+5tV+70Pw4QQX4/lbKD/k+ktLPZqFjLMC2aJFcIzK04IpKQ1qzYY9wOwTXzwjICxnQxqKPb6e8slzr/37HGCasXrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725683913; c=relaxed/simple;
	bh=mGvUs2/qpdyR2mNpuMMPTIbmDwl+DfZt9p7+mxpRbNw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=LI9nxPIFgbigtqEHsgpezfMpYVq5PlpkRkAjLtS+w0p+cObRqLm9o+xzPmYVmMrXLE+MTHdn7PTHFNBn+T/5Soth9xCGSQ0Isr3ivhLZIFwFiGxxsCSjwmOML3Jv6JQW5sJuhVqUqfx4GUb0emjrTHSzbnTPxiA+ZFEw67xaJh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+XIRCHv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+XIRCHv"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-714187df604so2326724b3a.1
        for <mptcp@lists.linux.dev>; Fri, 06 Sep 2024 21:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725683910; x=1726288710; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXvDbCqb1MHEoYG7UBPr3+c5tMgUXC7o23Jr03rLP8w=;
        b=V+XIRCHvLjYXCuROF9ySFEWYYVqKdPpjSwMdGXzinvJ78Qi6Qiy+3WFx92G1J6qs8f
         vp5fYysdszIML7h1HsE3AyLNySEmHbDhgk0ZuXXk628XTvJzyjztuYWSppyuiUFjCFoz
         F7R+uqM2DanR2FF02l9FRIQtVHx2l0BAHCT4CHtF0s6EnV6jTJwdMJQ92oA90b79HEnE
         jEQ7+h9HIF4jUVv8mBYW07FxHZAQkIaJvotasRvrm8webZph7I9QVE/pnNfF+RDIUfGU
         K7p2Ct1gzSdWLC9FEClnvj2f90umhZsesZJ6pAvxRdIi8i8C776PKezlP6ZZPxrjGBdG
         euvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725683910; x=1726288710;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RXvDbCqb1MHEoYG7UBPr3+c5tMgUXC7o23Jr03rLP8w=;
        b=rfwAeB6mCgot3vaFNdMtIRGoqi4hzwX0jHSYJF72Jz7zBQ6vZpAJ/67lhOS5+dIlFb
         1YVF2m3tHnu7owt0kKzGNehyxVyuuNf7QyqO25u2oDvO3+9YfyLYotIz4R7iIhWZwTa9
         xPxZZSKl+10PGvqCjKxYH9FplkXfHdIvkpGMPaN6foELNvz0OksL075+VVu8TnnWGnrP
         oFx+XqXlXRBTwyp8UNtLfvHLkhLsgZfD8RT7pTNGk7o13M469hBcdOtl/j0iIJ30UsdQ
         WLsxHbhWFJSxMjVmisp4VGTRODn9d6WnHJ+0P5l6N4o0H7bo5kOCr9MvnR7mekPoEzdx
         a/kQ==
X-Gm-Message-State: AOJu0YxpmIfhxX6WPhM+KpThUH6KIEUitzGH2hnkg7Si0rYArJwj4WWD
	cPpHoLd2afYsumnamfV5Q6oJcPNndWoi0S4tQmR9bOpbfnxczoTDDNOW
X-Google-Smtp-Source: AGHT+IF3Wkh54NpoCnJu7TGbCogtvGsSAFyBpWX0VMRd/ahh9L8SIQ6MMWzWf+IVSq7jtZtRYnuvrw==
X-Received: by 2002:a05:6a20:2d0e:b0:1cf:1228:c175 with SMTP id adf61e73a8af0-1cf1bfa1533mr7202410637.8.1725683909617;
        Fri, 06 Sep 2024 21:38:29 -0700 (PDT)
Received: from [127.0.0.1] ([52.238.27.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e5983c15sm272992b3a.184.2024.09.06.21.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 21:38:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d5598209aecfc8fe58f9a93dc802817b041785a9.1725680751.git.tanggeliang@kylinos.cn>
References:
 <d5598209aecfc8fe58f9a93dc802817b041785a9.1725680751.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests/bpf=3A_Add_mptcp_subflow_su?= =?UTF-8?Q?btest=22?=
Message-ID: <c78340ee-6268-b9d8-50f0-02b5922f0515@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Sep 2024 04:38:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10748445039

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0145299d2c69
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D887967


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
