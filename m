Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22BC2580CF
	for <mptcp@lists.linux.dev>; Sat, 16 May 2026 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778924587; cv=none; b=MXxeA8wj7K6qrJ0HOU806XLVuhO6920M9j16PKvUD1zzOx+gfgwlvDK4UW9/DCJS1dUbsQIM35LcVaL5pcPmnFyXg7HtfR2M7n3kbeeJHipX54mjDgod1xkH9VfMp8a5da9k3bRlVgm6qURg5QYdKPmDEmUqJ4WpeHgKEBpGZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778924587; c=relaxed/simple;
	bh=Ih7wVKuxxIA/OTFJpbywcb0ZhDTUGJJ2KUbrJYgfx1o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=AejhxeRUbIR/SyPJmSTCBdMXAGfaQME9xxQ9SKWtduPzaWK4Ce/Zgyxp6pYaR83x//yTKIO2JVTbPkKFpEi1GiC1fk8bAc/cxdXj8NOjcTzLPNPVmBIjDxw3CfEcJt2fiZw+L7pUqf2+E0ue3tfoRIp+0jZaPK/j3XWFHxZSw7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5dNZVhF; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5dNZVhF"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50e5eb0fabaso12938881cf.0
        for <mptcp@lists.linux.dev>; Sat, 16 May 2026 02:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778924586; x=1779529386; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N41AvPQtO/UkRYk9cU+LmwVBLWbeckqNifHGhmbdo0o=;
        b=C5dNZVhF+P7Hhqzziq9yX4deHyqs4sjJZDYIYltuXle7f86ALS5dkoZf6gmdDCMISM
         cPKAn649iIKRYne3AFsvPDtO3ZHfezWrO4IuMGfr/Mvn1fj75NgNu1THzz4cZ9YknqNf
         LUUQXTBpo+Gd+EwKu0+4LWeTqapD2ps0ahUypcqEf4tq0RmKHuaHuvaMYu7YB8Ru6VWK
         JVl2OTpoV/Hek74Ix3w5YelB3F8XUx3o8rCy+jKmFc1OhJBGuaTvUC8WuXFfNDJKt9mT
         QBJ2jOsolIeQs9dWGq/cgQ0Lo31k83fmJCU4dGpM3Tt4M1i6s7DF9TjSH0VQXC5/71tq
         MnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778924586; x=1779529386;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N41AvPQtO/UkRYk9cU+LmwVBLWbeckqNifHGhmbdo0o=;
        b=AZnbq8qTb/+TA8245gqWyLcItVg7DLYDtrUyufRiDxk8mJ0fGIAK5bN6m5/CpJ1wcr
         iv6YaWjIVhiIWrp7Bn9ihEjlwQH/wcSdYnOW7njH6Z+Ki5K5cDnQhYWueevT8ktwuFcq
         DaxtMZGj64cUOF3lw3hz88tJ4NecwIepjvrWopr8QQPQXnAT/lWo6CH1/KtxpFWYYUnx
         vReT27XMG7/BDOrxlRHlC8RMOTIbWfysXzMBZfcn9gZA/JNTxqYO+NretQNLRI/RiTsD
         1d0CF3c0G+B05DA59uVxN5TO0K7/qskIuUbKkQ9rlbPb7CnYom4+hVOXTMeSEd9bYAWK
         liGA==
X-Gm-Message-State: AOJu0Yw4ixViHvJvsXFVbOWt6qCCsdkSvufo8r6ajmT535cZH6fkDxl8
	G3xO3Tx12FbPpCoMRnVuxPOR0NCRkNIEUzs0/7Ncnxg/pq2nKgC1sM4U3WN8
X-Gm-Gg: Acq92OGrzBFKglXTD3qbsi2hhFsnYO2RzdKUhmugPLpf6DPLjr21FTTaQx+IzYcIzk1
	9OegZeS5QRy19lWVoSuYCwNy7x4XEUgMKWTWMyK6Bzgar9cl8Bl/8zlzlssLcWf5wRfu9opjdCw
	Bm8zmWWPUAu2DitnmHMaqSzv8TF4ir5FoH7rtIMlFTAGPTQCRPLEb1Uxh1wdnAAQj3dD6jfUG3R
	gBlfNmIeZxV16fMd2W01bKlFxNQ8nDgXwNlAJ/Aybue4V+YWT3oSZ6fJicbsLfso/wwLphB72vh
	7HUNF4kHYPgjSjl63It6sGRH1wH1aairPxqWnwmjyofkW+wAxkl3eo5z+YcbYbIbO3nQX4mFFUd
	vkUIR7c0dh7fe5ZmVhjU96ZHrdjKivhGMBVrZ24NivlCaToenzYIc19eT2Y/5CJGWtrkblzR2fa
	3uhdOudnDCqWOsnkTtBEEDRTScNQWtisq7fwXWJQ==
X-Received: by 2002:ac8:7dcd:0:b0:50e:5ca9:d263 with SMTP id d75a77b69052e-5165a023130mr110580591cf.16.1778924585554;
        Sat, 16 May 2026 02:43:05 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.140.163])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456c0a42sm72049521cf.10.2026.05.16.02.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 02:43:04 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1778919284.git.tanggeliang@kylinos.cn>
References: <cover.1778919284.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v10 0/9] NVME over MPTCP
Message-ID: <32bd1e82-8b51-5d14-84fe-5956e26ef570@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 09:43:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/259575=
76496

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/14f61f9f88cd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1095780


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
