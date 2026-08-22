Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0013A380F
	for <mptcp@lists.linux.dev>; Sat, 22 Aug 2026 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787406119; cv=none; b=j1Ts++UXwnwLNuYHMqAafNQSb3GxCqvSaLgbBW45CyIyYgg3z9I8KqrzV+5d5LeS8uVtG6FCQKJG+nxd2h9cpPIzAhK+jZShUKepZMxErVZmgsxSIQCIz2AMP/OYT7uq0e0xVRAC/LZI6mFVMAPSKyWxKKcm6fX3x0UMpSg+bRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787406119; c=relaxed/simple;
	bh=ShtTkIU3ezbFJIydaBLYCMvhC/wGsulze2uz5bQe5G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqDGkBcvOV4xbBLMGAdU9fQ/H4OYs+AUyAr5vrXzmzHlJh6M3cM3CnGETa4CKEGlmqOPRQHCA5iklS+YDBwu5uV259R72NbUwG40arytROg8JR2kTc5KBXKjXq7kPfyKIRsTYEV/uFHZsUx6GidjKkOBNPIK3P2tIF+1ucutFFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=m7ARVDz0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="m7ARVDz0"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15e592da74so276642066b.1
        for <mptcp@lists.linux.dev>; Sat, 22 Aug 2026 06:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787406114; x=1788010914; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Aj3ZYubTvLgnR11pZYHVat4EVUJdKX6AnHgTVge4+Wc=;
        b=m7ARVDz0+tsAgVTJG5RARAOMnpQnZzJ1TOPyGGj10sNI7L0waOq//ywaRJV4NQRxif
         8tnHfjm+tphsuEqmxX0rrvT5AeZTcbFEuZ/fyqyHL7q2gZdJ+8Wv9m5JAO7yhdZtOGuS
         I2Y/+cSIW1S+zvXmvh+M8a8ExdKlcqgxY54Nn4au83qia4qDGfHfwte/fImIy0QQI6Yz
         BFTtyWEH3b19yLryO+W/F62RCL1KFgDhKs90rRdVFZ/qI0BBfQRWZadjDpzbZ0LXVcpK
         daleagdCmdZFumcLMJOyi6Ff20WlWyYPAFkrl6yALoLlY6tKS9yFIW5A+vgW4wCfun8Q
         Vf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787406114; x=1788010914;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aj3ZYubTvLgnR11pZYHVat4EVUJdKX6AnHgTVge4+Wc=;
        b=hJ7EVz+hmqyNqXEQ1TdBGv1B02KA6euaiM0sByfOX/JvlCqYASQQ4Fozk68sRxbQfr
         hJIqaPAyt+tCHN0CxwOZNuX/1LKiDyRSl+ylpcJ4VtkzLHpckNBC3lrEGgY6UuQ/vhka
         aLac4NBBo/y1/aZWpt4+FGK0H/WixdJV98By+/SrdrZXoPmJaSx/Xddo6RME56RP9UN6
         UNKHhL8YpDGS8ij5TpDZyXVjuBn7TsiM35BWXRIHJrsCUhUgy6kgF9RS0zO8/xFLjrwT
         nVqPsxEcAN0+4iany5ppMkvQnyY/Ny14qf4J1Jit2AFN1icDsyP3ulfigDKcuDCGxlzG
         5t6g==
X-Forwarded-Encrypted: i=1; AHgh+RqpkakXKdj9O7w3eOzAoHAPjhu4zao23G/VnnkcPUWLDa9/7nCdvUdBmjSpx2LGtmLzYDZR7A==@lists.linux.dev
X-Gm-Message-State: AFuF++nqKcxMSjeQRw9Nw0YdOotuLxIya5eLLAZmLY/xYg5zfkYlDPkm
	E0QWVjXLcGfKBSkwFtw1mgv32ecsEOEkZCK0GhUEgqqSztZYtuXGoNeS9hKVodTx8QI=
X-Gm-Gg: AR+sD12RyiZc4Rm5ZxIcaic8M4i+nxUbW3wcfN19GvyNfsmYXZ4pAG93rFe5jKfn2hO
	j+WbJmeXr4Yoc9hrRzno3i1+BLtC0Txoiz3ZLDlLo9PSVVMKP2lqMKz8oYZEhWfk7DHM8Iy8u1M
	1R1zPpl8dMfCcfFuiagIb2MK4spJtgge88K2JcpUV0cFBolTXTI/zG6aogdD/Fa+Jojfj3XRvyn
	FEDJcMfyY822O3WBFl4epRUma/h56C9UsU3EXGnk4eGG87brYa2ofMLz4AZk72UksaVIcwke25c
	ea3NWVwZ9gqoomCQS8+e9/+ayZwsEmFpN1LrpFGiVCP8mjh8IK6opPG6mh+jlaO734No0ID+LgX
	Mlci7h1+MjEA+q8y/ifTaC/X+dI5wyA3eoN5H7vYd+v8fCG8OareH3p39r9tGmPL+ynDYgLTdDQ
	YnKl8xO1DThOO1gA7ChwtG+Fdqzx7/KuWAZZzI3sXA7kxiWcDWQVVx1asRwupM4bixrg==
X-Received: by 2002:a17:907:8908:b0:c21:35d0:f435 with SMTP id a640c23a62f3a-c24924db408mr547750766b.10.1787406113365;
        Sat, 22 Aug 2026 06:41:53 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-c249606a8fasm387614266b.8.2026.08.22.06.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 06:41:52 -0700 (PDT)
Date: Sat, 22 Aug 2026 15:41:50 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	kernel-dev@igalia.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	fsverity@lists.linux.dev, keyrings@vger.kernel.org, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wpan@vger.kernel.org, lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, bridge@lists.linux.dev, mptcp@lists.linux.dev, 
	rds-devel@oss.oracle.com, virtualization@lists.linux.dev
Subject: Re: [PATCH RFC v3 03/13] sysctl, mod_devicetable: add macro
 MODULE_SYSCTL_TABLE
Message-ID: <aomlfGJM61qZKxx2@monoceros>
References: <20260819-sysctl-module-aliases-v3-0-aab90569365d@igalia.com>
 <20260819-sysctl-module-aliases-v3-3-aab90569365d@igalia.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="akn7oxv4v2qk2wdq"
Content-Disposition: inline
In-Reply-To: <20260819-sysctl-module-aliases-v3-3-aab90569365d@igalia.com>


--akn7oxv4v2qk2wdq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC v3 03/13] sysctl, mod_devicetable: add macro
 MODULE_SYSCTL_TABLE
MIME-Version: 1.0

Hello,

On Wed, Aug 19, 2026 at 03:16:16PM -0300, Mauricio Faria de Oliveira wrote:
> The MODULE_SYSCTL_TABLE macro emits a struct module_sysctl_table variable
> with pointers to a sysctl table's path and entries, and table/entry sizes.

That new struct doesn't seem to contain any pointer?

> That symbol will be handled by file2alias.c (modpost) with the changes in
> mod_devicetable.h and devicetable-offsets.c.
>=20
> The option macros MODULE_SYSCTL_TABLE_{DISABLE,UNIQUE_ID} can be used on
> a per-file basis to disable the macro and change the symbol name pattern.
>=20
> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
> ---
>  include/linux/mod_devicetable.h   |  7 +++++++
>  include/linux/sysctl.h            | 42 +++++++++++++++++++++++++++++++++=
++++++
>  scripts/mod/devicetable-offsets.c |  6 ++++++
>  3 files changed, 55 insertions(+)

Please put the new struct in a separate header. Apart from not being
about a device table, I'm currently work on removing
<linux/mod_devicetable.h>. See commit
ad428f5811bd7fb3d91fa002174de533f9da94d7 for more details.

Best regards
Uwe

--akn7oxv4v2qk2wdq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqJpxsACgkQj4D7WH0S
/k5bfgf9HJoNnVEr9RCdAghOTP5QqFmH5ae7Kbmnodv6c6Pi9JGIjjGbeT5eKw3e
JkSKqdEnlVMrLoKrhneRsxwTDGPrZvrLZrPLdZwJmPWZn5Fg+kkOO9yFAGPeMsPX
S6UP1NY9kaCiBtlcsGT9EvMWz0jWVAWX1xb7Y2WcVZJsCWdcPhvWc3/lIbw3E4o7
PqLtSFblkQmtGl2OL4WkP6xhEPH6qQO9BAmhLVKKZwFW5/l4sHmXRrpgSJlroR3b
iH3liIeS6wxFp/fMYuFRryGHNMXn6gC447OnOCTmGNEj7+7Y3COwSGivgubcRIzI
RkmxkMf2Iuntnwp4oQzCbipE5EiKGA==
=SPY4
-----END PGP SIGNATURE-----

--akn7oxv4v2qk2wdq--
