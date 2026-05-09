Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B153148D2
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778312869; cv=none; b=cB/Y/VpkcoRFouk8AYk8jp5iY5zsiliOoyuHH6juUbmEsxqcf8HMm0648IzZaoWAcH7kKzub9VSF4HK4g18VaXFbxyooB70IIje9Xis7qJKGNGzUOl3sKkp5o5jPlBn1aTw8JbN++hHMB3/PjQ1i6zycerJV+G9/ijN1JB3A+rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778312869; c=relaxed/simple;
	bh=UzDU7gSP4OD1eiOFbpxACawCPmJaHCb0zBDuprK5DjE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=S0f3AIlMhn6IQpGB5wOzs0YWlPByHlWFuvsmtg6r8Ei7CL3ERk5gv996li1gQuNNPDyM6uMJPWdP5K3DDU7oqNk/txOAjyUHgImbXTynoSEWMSY2lSz0S4jj2PMhSf6Lqafon6aV7uL+ir60/Ab0EMGHfNFgI3hZHM1ROLUXW08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvlC8Xvw; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvlC8Xvw"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12db2e415a7so1955741c88.1
        for <mptcp@lists.linux.dev>; Sat, 09 May 2026 00:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778312867; x=1778917667; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=508xUpUCzKJkzBcwuq7HsZL3QUixH50dncGT89zU8uw=;
        b=WvlC8XvwZY0/gTlIIhojhliLP3diF1FZmHtEEw0Mo23WwpoonHNG97OrAtrY/+xMg0
         ZBfqqKlfoR3+itMwk/HfKXiTTr7esc8RsUj7AwMvZjKCRG9keAR3w2GGvgSvRWkPGk6D
         5y5U8Ea9cXtHi2AaZpkjcHQPoB+8kJOh8WAaZPqHAv+uKYP/4oL+xzS3TRIv7avAg5+2
         E/+5Kqxr5ybXXX+Z4iyheKm9LG/TjFMKedK/qUbhil5yZhCobXMHJ/gJ2KFdkH400Tdn
         Xt7avPo2Vzpdwagp7W5po6qw84odF3bhQVKjT45qCq8Kq6lRJklcHM4mClUHiMpjbKpw
         WfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778312867; x=1778917667;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=508xUpUCzKJkzBcwuq7HsZL3QUixH50dncGT89zU8uw=;
        b=Syx11cYuiHwFY2e/oQQo5bPBxNhlXbPiX4Bp8EEKkrOv1HvNuqNpQtNnH140coDvnA
         IDdpchkNfR5U9v9znFcCq2Mq74sk/M1LmyoMVHl2YF5txU/9Cz5Ip6F96BN2WSiSBBMt
         NGqcjRwg2Ku5lVBHB8m9KLTSVEOMPXUe97ULnFOu4GDDSUZhgAcpuj7rVDOYRj+hJ6cd
         CJqC/CLZpZHmxDGm+zfgJlbLIa0WpEAXyioJfIh/P+JvLnO0XJ/dllQ0inFkKTYj57hw
         p3I1Nu/TEJPFBns16CDSP5caxrPpdfy4ddSTzyaPbJuq4DJXkLpRPJeIub5tbundqFK5
         Si5A==
X-Gm-Message-State: AOJu0Yx+EZAnb5n99n6Q+BE0yH4lSPPl+RWc+aEn9LuMK99mgEALynDb
	Wve1z2IIFkfmSUy3ZH4LvpiaYPMOG5Xqd9t0zm68skaHHDTZWdywN3FfGsG3
X-Gm-Gg: Acq92OH0K+mmg89WMm9yP511/Eh1HH42LZPIBQdhSpvVuSgPgumDNboftAhL2LrqXkn
	w0CBBX9SLG8zQMecRZBG3KSg6Wog3E0rjCv1jbEJVYswhQt/LstDpVlaHSaFtGdPCEkOnhCHY0y
	Uf4wIXGLvgyTC5wnoZtscuVslnIH6rFJVkYN59p5QZZ7voUx44cPUbKT1KN9NOiIXo6oKGPzWzI
	7jRzhD8f4jwtvjLkkO6h0Cu647L7g4OjZAaH2Tkrkt6cNp7GSjybe1gzvghwvcDjT9higoaOgTC
	NWnIC0Boa0OnGXYytHM3fP2quA8miq0kKaVsfq5satZqF4q+B2nZ/QOqUyhWqyBdXk9MNL2osIi
	atR8P3f3ce6XnQRLEfLEH+Fwf3P5Rml7d/ghumTlHIbIr0CwmYh9+EJE71wp9G1/ffCwApV4Nht
	fOVDsHrkUTgQRYnW+fVRa6Ht82pujH5i9Ee421Tw==
X-Received: by 2002:a05:7022:123:b0:12d:ca32:5a7 with SMTP id a92af1059eb24-131969d27aemr7196395c88.10.1778312866758;
        Sat, 09 May 2026 00:47:46 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.161.192])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132781103e7sm6768545c88.1.2026.05.09.00.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 00:47:46 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260509-sockopt_lock-v4-0-33f3a1c4d7a0@kylinos.cn>
References: <20260509-sockopt_lock-v4-0-33f3a1c4d7a0@kylinos.cn>
Subject: Re: [PATCH mptcp-net v4 0/2] mptcp: convert to sockopt_lock_sock
Message-ID: <44469e91-5340-3984-469e-b974eda9a704@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 07:47:45 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/255947=
27876

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/81272fb3577a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1091935


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
