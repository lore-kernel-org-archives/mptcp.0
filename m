Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FE131F990
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399839; cv=none; b=tJFtULwMfadpKDQIA/zgqBnaPbbvPDUtpeBdkQydwzs78EkPdh+oV/ueB8Mos+Tn/rIr82GpJ1v2/tZ6keKGcXgHafkTvxQJLCERtidSWvIUuQ6D2qtav7+duzUA+d3jTPs01lsAfKlKRFIqbkJogFQ5KrpgEdC/CeDHkMtXtj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399839; c=relaxed/simple;
	bh=PTdFO3kbRnw8OSDQUWL+NffHKn1+lSnkMvd2B23yOeY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=j0Y9sc/RtLeOi5QochskiNHoPHfjnJoY5ae0DX2jgOSKHb+YYM3FI4PRfv9saiA57lh+HkFjzCjCPTi6fbbSsiKEu48rC8UQTrey4ME86j2P/VYS8AkgRy+ZZiC2froe52Y8O1IC16kmXrjl+HagvC1K01s/CVhBgdthNqzdxJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGegJXQy; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGegJXQy"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84861fc51f5so1322868b3a.1
        for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 01:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785399837; x=1786004637; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kaiBJfB6+iyqHw6qAkeZR8QAU0WHi5k+ghHWB1rEF6Y=;
        b=eGegJXQyGczUZ9bgWnLGaHIyXk54xCxkbqPXWbkH888sJme70D2reB+oigdPELKbeV
         neDcUPfSitwM0FtIDd8wI/eHaO505/jZGEGS5GhauqzHWYakKDQnFXDjXeP5sh2h14QG
         qbXoZ2B2U0K3bYQUNzSEjzrQ14T4EvcRkgJGkJ30uQyNJjhvxJVwL7Fi3zJ/fZGDTUyD
         sBZ5HWvgmnaFRb65WZ+KkmouW757nQkZxWN9v+pyqgB9veqJ9vmrg4M8qg/wUxyh2za8
         RmCL6iyCE1NDsanyz1rY6l1oIiCsEmjV3Jw8IQ6awBaMLoCMSsp8YDjMuzv/rJOhxTpK
         IwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785399837; x=1786004637;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kaiBJfB6+iyqHw6qAkeZR8QAU0WHi5k+ghHWB1rEF6Y=;
        b=D5NXdvTAc0DnpInl3pyUClVZzAlG5vJg6E8yJn5O20ZdWZYrff9oC8rF2ZAUqoO1QC
         DYEA0YCiR9Cp4W7ewvKaBCf0Re5f2LyaB8TPV4Kt0jsNHzd+cDGpZ+jzLD7KfwSxj+de
         xsReV6JgoMeNPRDS52AuGNI/2du/dDfWo+2jhCFtPZMknm5z38vBhIHTDBLOzfGqMs6a
         5oGMmorMOzlVir77X8YdFMC0gbRKl5xCvDKLR7ra9+eMpRBf9Si6EmThcQSVIbk6oMr7
         HzE0lvdTZNt5ct2RhWwhVb9gRTGZ1ef31dEN8IgVnbRGUas5DS9Du8QV37Qemj5Hic5a
         iA+g==
X-Gm-Message-State: AOJu0YxVMDHKzwiZApFcQLVKZfKfQvUuKAN969YQI0ysEL/DE2fkmhZc
	cABV+eGjCIRuYSOc4XFOGogmjwZS9YHaWwBvud0Xl2ZlCO2utjX1bBc=
X-Gm-Gg: AR+sD123FF31LUnHREjnU9kn3oWRGgxNHV2/t541AOVQUrDZfBN5KhvHiY6D5awGtLy
	sV0BjG3+uDjLxceq/a0D6yUZUf/JWlAJyQtFbW21msyVkSGJgbbB96t7k3RgqGNdDMEaDXYVdw+
	wsqW9dOmwyT3zivoKulvUFTqqSAB0UJZMjKki7GrA2DoZ0yU8yrkTA1X9gqOmjIzn8NLHT2xkRB
	2nVbeQAsOtOcEzPFAqMPoOn67BlaLAszw3TPWxeP2ii5F95IZkBcTf+XnTDRTy9wCtx4Q71fP+R
	KM+exH31TtB9dtP7cYcmdya5nSoMEn7Imv1rueWGRLtUJOWmuB18rZwxPtqJxKyZv5dZ4veRD2R
	I9XSuDvB/ftlCF8YQeL+6jC2W83zZ0+DYwoZGa42+JSF4aUYkuECcsD4w+ZC0uD6gduC8e1gh+W
	fG98biW9sAS3XTSyaiHkuD868gjSEuT0DPJzDI1Nc6DhWASd20w9hIYHCrRdjJ9E7ctcgb1A==
X-Received: by 2002:a05:6a00:8d93:b0:842:6a3b:60d8 with SMTP id d2e1a72fcca58-84ebc21479cmr1734439b3a.30.1785399837260;
        Thu, 30 Jul 2026 01:23:57 -0700 (PDT)
Received: from [127.0.0.1] ([4.154.7.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea02fa4d4sm2603300b3a.38.2026.07.30.01.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 01:23:56 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260730071244.69473-1-devnexen@gmail.com>
References: <20260730071244.69473-1-devnexen@gmail.com>
Subject: Re: [PATCH mptcp-next v12 0/4] mptcp: MSG_ERRQUEUE support on the
 parent socket
Message-ID: <f2bbf85f-329b-2521-13f7-8d5c44566dfd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 08:23:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi David,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/305234=
44243

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9fff460b62d5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1137167


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
