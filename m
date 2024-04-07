Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E014A82
	for <mptcp@lists.linux.dev>; Sun,  7 Apr 2024 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712489238; cv=none; b=oiJtDmB4Z+gcW6JQGAUX+PYaDmN2KyHZ6+xRWSfofb6kbvPVFcr51hJINiUhubJ5CE6mdig0p3Oa0/p0XOaIb96xQ8PdoY7cdXpwqmBGLstT3X6+lXqXXty15LSBEpOw7g+WzukzPDWxKtgrYB2oghmY9v0zw7WoV7wCLZP0DzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712489238; c=relaxed/simple;
	bh=0lJB9OUvBkZSABTIJ/w3FgA4aR3+qV5nUIfLJSg0Lto=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=FajnKQeOZudM8J8tq9IK1nnLHOtNEAx6UhVKZ9T8J4OLRHEFbF+hP6Wv1M/N39XfONEIRI4SF//LVzkLp6vG6/SDMxicbJfLCnEufsxucN+Tpgg87aLnNFUvgbezHg+CE9H2twezghJCx2parivraL6nxfKnYZZEyEHvvHj+Z50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADyFV+9h; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADyFV+9h"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4348d65cab4so1588791cf.0
        for <mptcp@lists.linux.dev>; Sun, 07 Apr 2024 04:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712489236; x=1713094036; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fv+Hz0OeIM1O6HNg82KVc0f71j6M0OsVaeNL7MtzI9Y=;
        b=ADyFV+9hZx1NBiDs9qfXnnPRH6mLSl9IiXhn/RHv4AEaVMxkc60pPSAeR8RRtRWMje
         rgsqS5QwASdt/2yNw71aULtMvjineB9A0UNWw2ppIUoZP5a9UN4y7eYhf9WzrWPGDkpD
         Y6/khN8Rqets4wrhjo6LmjKQhIqUlxcTH29kYSLnjNYeUf5RZ61TcRPTIPbNiVKyXeDk
         mJJ17JXCnP0/vOYE4vt5y1bpbIp6cna3y6YIrI9XHL0rKYpwpfyTOwRncuA3QtzfABkG
         nL/ZinEwtAWDvGy104su7uVAForpYfN8t4cyRTsZ5VM1wjE7dvNr3/ZD3J3sm6tewjZq
         4Z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712489236; x=1713094036;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fv+Hz0OeIM1O6HNg82KVc0f71j6M0OsVaeNL7MtzI9Y=;
        b=ANk6KtzNqnUWNWIJr/jp5zXetJj2HhTXXd+vZHpz/3Km5fuMaSaZi7TUfOhi2ab+fo
         eZ7KRG6B3ZKlXsA9vT6XJaMDWbYXDVRWeqsvZ/BoHJ0XuGv0azUZm1EQzp2DxGd7ADlr
         r2976TUpHo64Ct4jdfFse8mZysTgPFI2Qv3Uc+Bx07Xj9O5sKFlzaQTEvGAcoMzqAXuc
         Skq69qKOutNoyjxfzM98NklkasjPina/rPkjIPcLorvktTPbLnshC/F3Ro3Lmwq2jN8S
         6G7k2uqPKjiSwUfUVtpr7rZiB/0IjEFovb0EUa3y987H5JdzkP440drOVvFXw0L2hP2Q
         x7tA==
X-Gm-Message-State: AOJu0Yy40PkDKYk9wBdQqcXs6AlX45tGgx9xP935luoIi+diZ/uvdmnC
	jYV735t2SSCAG3Ykr5akV+XIePQ36zGql8A7hBl4oL8HYHLdWiq/fPy/1D8=
X-Google-Smtp-Source: AGHT+IEOfNV85E2PchA6+fbtSFOKYZQcef2YBM+i34PnMHecYtBzVMwLpB9+jT6hwgiP2S0N6qPfIw==
X-Received: by 2002:a05:622a:1986:b0:434:6fee:5983 with SMTP id u6-20020a05622a198600b004346fee5983mr6068227qtc.7.1712489235235;
        Sun, 07 Apr 2024 04:27:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.75.95.192])
        by smtp.gmail.com with ESMTPSA id cg11-20020a05622a408b00b004313af9de34sm2570838qtb.94.2024.04.07.04.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 04:27:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7930751788d3bc8155898d4a22bdd6efca8cfde0.1712486293.git.tanggeliang@kylinos.cn>
References:
 <7930751788d3bc8155898d4a22bdd6efca8cfde0.1712486293.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v2=5D_Squash_t?=
 =?UTF-8?Q?o_=22mptcp=3A_add_last_time_fields_in_mp?=
 =?UTF-8?Q?tcp=5Finfo=22?=
Message-ID: <bb99237b-5603-9892-2b6b-66b686b03fb9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Apr 2024 11:27:14 +0000
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
uns/8588196493

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ebdea5824333
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D842144


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
