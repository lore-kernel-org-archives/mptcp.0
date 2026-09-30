Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6AF3D1A81
	for <mptcp@lists.linux.dev>; Wed, 30 Sep 2026 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767977; cv=none; b=rZFNUU3H4dAHJKCi/bEYXxuDtvdf2DLvSjLhx6raZp7I7xzoU5etbsGMppmyujog/Mv3O22mnwjI6gZKyYVSvcCHcgKDThxeoby+gOEu0y90DCNaAevKG4RB6S0jBhAk32Jsu1/30rbQn3ZgKmXl4Z9o3e4DZ4HC4Hc8US6NjIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767977; c=relaxed/simple;
	bh=44PLXx1OY83L2gMRyVpZEHcmxjShEQQT5Gon3dy9wME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=IJGvYdGxzTwh7VJyETZbFxK/Uw1SbxY8ttX3rvEb3Bi4VjKy4EtrKxgTUWGfFu3yJfeDFytt2Tt+MR8jONlafij0UUzd6tifeuY+mKYJ4pvynEFKA9xe71VyvhsU2lnYsxu8eL+/hRm5WKKD8AbJX33el7X3CA8obvY5GYPbBmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjrbIqui; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjrbIqui"
Received: by mail-yx2-f41.google.com with SMTP id 956f58d0204a3-6737f134de1so3464659d50.2
        for <mptcp@lists.linux.dev>; Wed, 30 Sep 2026 04:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790767974; x=1791372774; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G7JSwzbc3leKQc4xuDLNMZOZ99fF/Wo6tAv62ThAq04=;
        b=EjrbIqui93XRPX+YT9ZM7/4XFeWkWeWgFA4+5NeFG7t32G+6KSaNc+zNiSemoMV/Sr
         PwulWaHJCD8/T0wGXf4Yl60/3F4S6F94pkiUCMdLZ2/Fx/XSbpY7OSKFL8pNDbc5ekes
         PvdjsOHYFylcc3B1tlnfKUCoXjPE5vfsZWXB4WbyvU6211TakkpTcRoz2o4hkv4d7yXS
         29Ch+OMrT0MMuiAXYlh/rsmK+EPh4GvYoGqM3smPpfGZVNa3QVfFmVh5JieBzjbVuyA6
         bDDzl6KtmMMyY5+k0YcFZUQ0QKMKYTiTya8XU/E5pdxs+CiEl9aa2Ai/Nun53iz3hSct
         f99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790767974; x=1791372774;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G7JSwzbc3leKQc4xuDLNMZOZ99fF/Wo6tAv62ThAq04=;
        b=Uz46qZkGszq0pOWuRj2M/w/x2IHzktgFcWiHRaiVPUx9qZgsCOeMdlmNFYlVzk8wcX
         BEAX+Yo23p7ia7VOTwNG+ZUEZndXqf875FPOJO7XsTOdVQTWPuesn26VbnnvVHsG+ify
         9te4H8NDkGPrbc3cfIVQSu5XYcDtnCZEbpths2BvkittACiiUhCaaWd2+zmlb1gRemfr
         /4siLCpVk8MDxJou2PaXBkTpfeTrHyLDncgziUez0JDVze/PJdvO/ISk2cIodIh2m1XV
         Z14JIVQqcVRi5RY6X4Pqxe+z87BQ3Ll6M9DMfwcbhAXY6BjIVQ6/KiaUYjzM9AfP5KM9
         mzMA==
X-Gm-Message-State: AFq9FYJidbGqj2d4UqpXTfzmQudc/xHH8TLXNRmflnYF3z9lJGHWkzMs
	rGXYCmkLfgR2oR8l0ET5BW/+u1ToLB4+bW2+rtuWcYUjDERfVbNXeEw=
X-Gm-Gg: AYBFou1e8ykh8NihKJvjLHMQsLRUHE8W3aMgdMGPf80dT13OsqDONdwbFi4HXsEN4Ew
	49OXRq7T8+VtgFsGN4uMLtl1sS7KVHchS0D8x0N+Ol8i+F0OH2/gjJIrn5DZ70U7O8DjNc61h1C
	j25F9J0WLql6Iw2zLyS583UPxwbOu3pWjl5jGnBF/4MFEoBWm9DJSyWiXX1vQcrf2tQPEm+sc4y
	9345qxqRgz5L4r9k2roFo1QMUkFI05EeTzuWeYghH3SNSOVv/7uqafXZQvRGAE/F+oX7ReA8g95
	FNZlF1xm2ImERksnuvzc6cBZ0hMVcIadNGJj6TpSQScEaQu1NXTAfpYwjd203yeOXsQOvGohhpr
	/j3nNC/80pPDn+b37JsjwQicttthx+Baq1+n3MNOK5R/hBDgnysAS2FYE21P2xR2B3nl5KFUZWZ
	svA+RPpbrB6czz2beTNe9ayLyKpMIShfCjt99lzWEMFP+Ifr551wfcXU5G5SWORgyXorujqZSHp
	lbx38JUDnQYjLIlMIAJBADpcg==
X-Received: by 2002:a05:690e:d41:b0:66f:c1be:317a with SMTP id 956f58d0204a3-676834fc4e8mr261718d50.81.1790767974525;
        Wed, 30 Sep 2026 04:32:54 -0700 (PDT)
Received: from [127.0.0.1] ([172.203.254.211])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917a03f476esm7838196d6.38.2026.09.30.04.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:32:53 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260930102804.2796208-1-kalpan.jani@mpiricsoftware.com>
References: <20260930102804.2796208-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net-next v7] mptcp: normalize seq numbers reported in
 mptcp_info
Message-ID: <b53e5c65-aee4-cc46-9a84-f2d72177fa04@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 11:32:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/36704096200

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/c964f91e84=
32
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1176773


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
