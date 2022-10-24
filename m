Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DD9648
	for <mptcp@lists.linux.dev>; Mon, 24 Oct 2022 18:33:29 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id s17so6586915qkj.12
        for <mptcp@lists.linux.dev>; Mon, 24 Oct 2022 11:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUQ02SLVIT8qZzDKRysbEhr0pHAk/sw1aR7f1CKp1Ho=;
        b=oUAF0ExOhQa66Ik+gNFmC5gpAdmLV0OSUOJtdHbCP180g/mZ4OBqVmd3VbtEmTywkm
         VHc/LBS2u8Vo//megte0PDhl3wVWWpnBDLCgreTF9wqZjTdGphb4tir63RAYjR7kSqSs
         mNT7eX2TPchlK37YX6x+Gg7IpAQy2XhBh9Q/iN9yefAeOqdTPDgnrk+6t9QxarOp2yGv
         NdLbXgCQCXqX9clhddoP+ZhJL5pS9TBOYq+YIKNkWbtv28qUzU/wpmU38lns/qajthA6
         2HaE4v7IEz36TLpQ4KaW04XItkBNCHyYRUglA/6hBT2llvUo2jhONt80j5SAHSZGCsnr
         S9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QUQ02SLVIT8qZzDKRysbEhr0pHAk/sw1aR7f1CKp1Ho=;
        b=N74mw7qboxH2XGlj9ZxauPgEp1tKJkm3yDqkBCnIDPrzsyj8YLe397xqN8bj4hcoRB
         aMJ/71fETVd95EPmfbbPWF7UaM1dsxs9vSJ9vTGL3Yx2PVXRkLToR0kUIHTQEHC9lYu9
         2cxSiPRYkgKPyVk6z3HM/Lr3Goolg/yMk7gI3aKunwPkQmJt0gfDtJZSIcU+eoH5t3lW
         pP5Lw/9zEeh4y2vZvXfyfJrcOjZZr55xOgQi9Tm5Xk27sQ6padQK3sMRda+yzUXFBfP0
         jWzvVBO8K/MQp4BDKFeApl947LeE3FK+7aMkOy7lsqsR0HDa1e7UWH5GAPa4fBk2R4gp
         BMUQ==
X-Gm-Message-State: ACrzQf3Jb5RVs95+AcQv9ODoE5d5qCXquP8TCUmjGeFzoNcnDMhXillw
	boRzMaWciDLwkctj0oXKHE4qWkLln6SWnfA=
X-Google-Smtp-Source: AMsMyM6vkUAqz7hpFDxA34hARp/a3NoGlPbnglj+Ohfbk/F72LUGROYLWbh6Q3reANO8HOFpe/8CDg==
X-Received: by 2002:ac8:5794:0:b0:39c:b855:41b0 with SMTP id v20-20020ac85794000000b0039cb85541b0mr28239086qta.585.1666636397335;
        Mon, 24 Oct 2022 11:33:17 -0700 (PDT)
Received: from [127.0.0.1] ([104.208.142.229])
        by smtp.gmail.com with ESMTPSA id m16-20020a05620a291000b006cf9084f7d0sm488151qkp.4.2022.10.24.11.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:33:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <680973297b6995126f49732c0828ccfce8865c72.1666628806.git.pabeni@redhat.com>
References:
 <680973297b6995126f49732c0828ccfce8865c72.1666628806.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: gives slow test-case more time: Tests
 Results
Message-ID: <fa932db2-c670-6274-bcd1-6ec4a079c814@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Oct 2022 18:33:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5922635212128256
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5922635212128256/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5359685258706944
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5359685258706944/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b3fe6bfab13a


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
Bot operated by Matthieu Baerts =
(Tessares)
