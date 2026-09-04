Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AD9377575
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518713; cv=none; b=PWu6/8zX71UPUnlaJiRkcv3nvQafEvQ7jeSeWpPBO5/LQ/FQsdJMQQayCkyq8ou/LfSBJt6lfej5uWTFzNm21PrYfvTZySPh4yMhSr9ADyfnOIBYFdTdEJHV4MiTAECX3mWO95yfpLM5T3MnuAwmrpyoSmtYabeFotuMolnZsAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518713; c=relaxed/simple;
	bh=e7tk6h/FfUV0IXvcqucv43tN+TPB3a1ABf9pv3ct4Nc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=UPDUiwKyKuzVZINy7BteC6CKA7pP3JiCLixdfOb33WZvbAgJZ9/ITvuCr423QuBmD+ZRWClCxkP75ore5IlGNubLyBd1ItrZRlz5QLNUWEprSzY8s2BxrPl8Rm2GfwrXIjcl80ql1obEM30l5stQLbioyCgRofBQhSU4AgOrS4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUmVTKQW; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUmVTKQW"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8568e3ecfc3so605766b3a.3
        for <mptcp@lists.linux.dev>; Fri, 04 Sep 2026 03:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788518711; x=1789123511; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eSksx++UbQsnVlL9ThLD3sBaQfwkDUk+p9rJaE6qMy0=;
        b=rUmVTKQWsqlGu0DaSYZ0OSIul4sTF0AbGhDqqxHA+jaV/Bh0L30YrJp4+kwi3aNwJq
         lKq9FZR7aaVtzMsHQ7x1ELROOq93pGLfJz3q2dInhEOxYJo7vZOomkA6lPCuLfw4Qha6
         6QbxIF3b5dPqgm5/2gGUoRbLMJ+0gihTZ+ADX1xI0ZYLAj8ubLLQYtKEfk6557VKfV4r
         ESNPxiCeAjoH2ZE3ZRbH69n7TE5zyzjfi/CD+MujlhhjZheIeoGUbuMvBpBJFXyEVDwa
         Sw4o0jcufk0aY1K6dfsqsKbC//i4MdWD4b7et6ZPd2pHbSARZapcogk9yd1w9uRaHrwd
         NoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518711; x=1789123511;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eSksx++UbQsnVlL9ThLD3sBaQfwkDUk+p9rJaE6qMy0=;
        b=VvhEtJM9tFIZAbCK1okZzUoeZ+d8K02saCwRx0mF5tTtKwV40JpQCMT/FfppyL3UhH
         4PABPy9VSJ9EA9sEkwMwLaK2LP6hot4dg/0VOzqS6TGIewq1DyzGxNrAOFw1kn8patfa
         qviKyJEkzTAQhMkDgP8EZmsMK4hASlhteweDrSzBu26yjXOPsLnXgW1gB1tKp8Zrr4vD
         JAYWOPAgnKih3jYRJx4geMN2gVc4nQ1o/RKcUc6qUX0LIyAj3wHED4I6BElKPGSf0WXY
         4vULZ4sZ7blqqMnBJDKn4lEZRbgozr4WKMrxctTSy4kpEqvn7aijWjcBf4fEH1+Rb6pg
         xnJQ==
X-Gm-Message-State: AFuF++nmSzoOmdK7ZdYESPRDcaqWIwZMw3BO2O9FW6QK1alTNwpa585i
	PwNpFaASKQ/XN9W0MzOeZ0Z+vkJdb0DOEVyzDWnzLK1ikwCuwlMPpo4EsRZmU/Q=
X-Gm-Gg: AYBFou2EbOsEwIbLx86MEEArqvYwwx/2YgIkyJl8P+6JTA9YU1MqeiKW0VglWqcBj5L
	84F9VophObB9FB2xTJxcZNtj24j6cWTAWP9/Wkp4wpObEoz6YpBQIVXBgNnUMEdxzuFxehmwYRy
	4QTxS0non1McSL2DiyaO4y/GJZnzKN0MGXs4F1rxFN7CPRilXxigqZEWKoj9CoeWjjlpufkqy/p
	PTpX00iB6a45IWU95/PKt1GivwCCr3q946cFcI3TaGWmvZ4hDv519e7ri3eTmsnpyJ/HVHtneRV
	QUgKHTorKboJUGAopQ2uICTNxVBao4LpvlpVJLPw8CXm6oSnfDJMn0h2XN+TG3rdiwA82lKqJZZ
	3NvdBaawU+uO9p/LKfnrjjaimD+0jMpF/fN8177q4LuXtbrQS7Fl/xLTgaxBvE1kdked93c5kbs
	xMx5r+gP5G7HcRHxPaRpBvbCrhU1o9Cpb3TWe9Es+dKA6W+EdtFKOm1S7YZTIp91aslUuaWcauh
	6GfS2SxjBnY
X-Received: by 2002:a05:6a00:414e:b0:857:7384:b5f7 with SMTP id d2e1a72fcca58-861692846b6mr8044840b3a.19.1788518711331;
        Fri, 04 Sep 2026 03:45:11 -0700 (PDT)
Received: from [127.0.0.1] ([20.125.46.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615203e041sm1033483b3a.17.2026.09.04.03.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:45:10 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260904093531.20023-1-gang.yan@linux.dev>
References: <20260904093531.20023-1-gang.yan@linux.dev>
Subject: Re: [PATCH mptcp-next v6 0/6] mptcp: avoid data-races around the
 sysctls
Message-ID: <deb30a91-c779-d827-7da1-f92dab45601c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 10:45:10 +0000
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
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/33860787080

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/db37114e85ea
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1157772


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
