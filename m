Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE381C3F
	for <mptcp@lists.linux.dev>; Sun, 10 Sep 2023 23:10:28 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2bd0bc8b429so66650771fa.2
        for <mptcp@lists.linux.dev>; Sun, 10 Sep 2023 16:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694387426; x=1694992226; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70Wla2Jr3IBJ9uGTryWFTukL34Oe/jHfMXRm6usu/EM=;
        b=aUKLoihPKsmwYC5VyNhCd2RbpYncor9Z6VXCOqsRrSxLeNw78SQAQlVZkQNQNAwM+n
         hLF9iOZgG2l9ueedJTWUI4+iHjlzenQYbSo04k2eBXxInY4s3IeBl4UeDcJS4WsY/RIi
         jaPBF6Cj5ABvNm+41lGoicM4vwMrm2KsplIc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694387426; x=1694992226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70Wla2Jr3IBJ9uGTryWFTukL34Oe/jHfMXRm6usu/EM=;
        b=s7X/p3EkQ8VQyOD2OBA/ACFKkqZsFVT1DDa+xPP0KCafIdYwenqZtqmIYd+i5Py1rT
         FJfA5aY82aMEA72rx1bUcBnQHuOegVtxSIR8xr5oZCuaXfgjyvawu40cvK+0evbwdnka
         K4wX0qVAkffnZywxMaoERtvZGctDpB3tDr2pyKWcKL3F/msErk4kqCHusAgvMLdv/LXs
         R2IsSxX/nF/LuBg2MU0MtCaaBiDGcdiHpPCBkz650msdApNtsqf1ieS82+bRYK8RG51s
         rSBDcoO/fbHbPcCNyEbjGGFZx+gZOUyrRdwv1fw1SO/NN5KQqQ27nDTyLv5gA2P2ReY3
         Hoyw==
X-Gm-Message-State: AOJu0YxKHzXrq7eAHX+gL/uf+eKIFBPBq38bMIBGNPXSSHbMXuALqQl2
	a7aDg22Z6IgyU17yf0c2be2lvfYrr04f8+0JeaciDw==
X-Google-Smtp-Source: AGHT+IFcRi9xf1a6sFEVOCtJ72EqRmPYlmptPZ9zVodgRg0sL1Mvl1Aq2N5Aw475MUcbdGt9JzSTMNqD99R/KLPKqYs=
X-Received: by 2002:a2e:9c06:0:b0:2bb:bf81:70f8 with SMTP id
 s6-20020a2e9c06000000b002bbbf8170f8mr5807451lji.48.1694387425698; Sun, 10 Sep
 2023 16:10:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com>
 <ZPZKsJUPVeHCsLQB@arm.com> <EDE8FE3D-043D-4A14-ACF6-71FF786C0D32@apple.com> <ZPi1LvrcGcSKBLqR@arm.com>
In-Reply-To: <ZPi1LvrcGcSKBLqR@arm.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Sun, 10 Sep 2023 19:10:14 -0400
Message-ID: <CAEXW_YTxLRAKCpFdKOdegj0gZdBb0OH+BnJf9FGTGfPtwiPkiw@mail.gmail.com>
Subject: Re: kmemleak handling of kfree_rcu
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Paasch <cpaasch@apple.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Wed, Sep 6, 2023 at 1:21=E2=80=AFPM Catalin Marinas <catalin.marinas@arm=
.com> wrote:
>
> On Tue, Sep 05, 2023 at 02:22:13PM -0700, Christoph Paasch wrote:
[..]
> > If you have an updated patch, let me know. I can test it.
>
> I sent it in reply to Joel.

Just checking if you got a chance to try Catalin's patch?

thanks,

 - Joel
