Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF11F9EC
	for <mptcp@lists.linux.dev>; Mon, 22 Apr 2024 03:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713758058; cv=none; b=cFY09aKZRns52T86XFWdi7VISU6stThJ8OCIAhHrEsEVGPdkNhInWnr4eWFj1Y9CSTY4i3GP4FovOXrf8x9sJ5bIfU7eGNMtpL8AUXnuRZxGqJsxwSYQvWASA82O8r+I4eqrBcEzqX3GKPuM+4Ptxt7oK9xDtbZqDuc1cbCKJqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713758058; c=relaxed/simple;
	bh=joNQOJ8z583dSIGPfGfJTCBFh819eblF/6T382Cq6ow=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=h2xLn589Y+vHA3OqgAgDV5MFp3Nch74QQ6Rn8k+DH1PqIMEaMljdDMSq/CeW8lyZAkPXihM+qs47c0BdRhhlVMv0ZIrivLSgs5Gl7kwwc2gaF4rsp2isELWdiGbCBFPqWrQOF5B/bo0nJhgUMQ/aIJmTAPrpHUyBHUUfRFx51k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhSeqMqO; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhSeqMqO"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so2252052a12.1
        for <mptcp@lists.linux.dev>; Sun, 21 Apr 2024 20:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713758056; x=1714362856; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gq8H7bQC0mBHUVBIIgHip1X90KaH7PGGllBhseh9c2k=;
        b=RhSeqMqOfm+3jgULO4PCgsPuofZ77Y2JlOy5DporCPx06NN8PYIooT5WFiVGp/fYAA
         ALOxQ4ysxe1XwLtCYGWTsRAY3j6N78d+tcC2bQ21wLXi7rCFmx3wKbjO10r92uyeaXLs
         5YztoQ5rl5AfIksmarKTMifZzo2fq3Zt8rc3EJBeM6AUgCBOgUT31nBd7ClqkW5oS6Xq
         j6oJuQIL7tZnjjlvKXEm+v/q/GkIELE1CogngjzBtXb3vStLtcOknDOdOKQYAc7d1Yvj
         ItA88Ocx7mC16dr33/JVHRxXUOToyPglNK5gp7F1DdWBAILBGcf3eMicIfIe31rW/e8J
         rrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713758056; x=1714362856;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gq8H7bQC0mBHUVBIIgHip1X90KaH7PGGllBhseh9c2k=;
        b=dAB5oQtFwItRLZVhtmm08AdhkHBYCeIVbdVxwx9zAo2SrWzzwzoRraftTqx4Wk332o
         TMRpxk9NKDnbxtganb3eyfT5bJ7RTo6jd0cff4B5cKH2Eqy0ALMrFu0AghB76ulrQz31
         hWVc7JDgFjLhyryrEWW7/F45Uf6fQ1GPe8LzZTIY+ZzaLkSmW31Oxnye9TfJWyAvEmRf
         QNGvz8NeVXd0zqDj6+06cvGsbeh4HZDKfzpXE9LopHCoXjtNMLI2Skx4e9uWDKYttR9j
         24wM+Ht94GCZZlNbhfyJr8WSU52zlI5a+8vOe88BYp7AyPU5YQxHN3GelMMlaOWWtcTr
         yj9g==
X-Gm-Message-State: AOJu0YwpvhUaPVfNb2CL5f0lkIIgeaEnLQ4J8GXrlh4YsVWFUZbB5PyX
	hNfTjqUy3zqRwtTyzzJpx+faSeEHSk4Au4Nqm8wt09ARkHMOmf0=
X-Google-Smtp-Source: AGHT+IFkmaDYWewK1N71cdAAoEjKNTHlyainvOgZeRBkhiqE2dBLLuyL2CwV8Bc24PPgibBtqUPDgQ==
X-Received: by 2002:a17:90b:3c4:b0:2a5:8ff:9d1 with SMTP id go4-20020a17090b03c400b002a508ff09d1mr7660584pjb.14.1713758056255;
        Sun, 21 Apr 2024 20:54:16 -0700 (PDT)
Received: from [127.0.0.1] ([138.91.70.180])
        by smtp.gmail.com with ESMTPSA id h4-20020a17090a580400b002a51dcecc49sm6563075pji.38.2024.04.21.20.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 20:54:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jason Xing <kernelxing@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240422030109.12891-1-kerneljasonxing@gmail.com>
References: <20240422030109.12891-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v7 0/7] Implement reset reason mechanism to
 detect
Message-ID: <b0aed644-1ae1-b9a3-9e22-df050cf02bef@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Apr 2024 03:54:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8777989860

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e8bb33fa75b4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D846464


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
