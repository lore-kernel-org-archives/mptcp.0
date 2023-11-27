Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7913AC21
	for <mptcp@lists.linux.dev>; Mon, 27 Nov 2023 18:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7MxyTNk"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so3796951b3a.3
        for <mptcp@lists.linux.dev>; Mon, 27 Nov 2023 10:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701109449; x=1701714249; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOrOWqVt8oom1ap5o9NVJpL1jElHyzRl+1HUjO4roOE=;
        b=i7MxyTNkbH1p8H6qgs2A4LZuO13JIXCEnXBtnN+umhiSmHbsOZzTLI7mUnBxQmZjd2
         XRwvTU1O4l99SLiA63glAL217AY8t5Gq+8g7qxspsNvXMLbSW6LxXyZxQ4I06WVE20zo
         issA60WoNf8MSIUUvFWOc2973wcEsYbxHpOINx3BvzPTlUQpqfjjpeWTlMJ2wxh6FdrK
         F+gDiHUcxWFqW0loLzTbXIfQ4sYuQTM/f1P8+P0SIVya7t2VMj4Qh6jdxbPVerZcr9EF
         r2oUr/2DpK7mM6Uq2Z58bMhmDRLihmZeTDnwwKqrD7draCmch8OjHFv3e2ujbEv42PNT
         +4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701109449; x=1701714249;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IOrOWqVt8oom1ap5o9NVJpL1jElHyzRl+1HUjO4roOE=;
        b=Ga59BWteVXVJfrwmzkyv0U/qS5vhci9Fb3CeRIzrwrRU+5t8TfO/FQ2hnO5BsZ0TZ9
         gg4T8znmy8wqr5qtKwzCEFIT8ZnljWVUynH36I02U/xrZszPIbzBqV0Xxius7rzBD8Ci
         0REJ5QbB2GviDRXUP/nTc3MybxLmvblAzTi0lp3uOVzT/QlZMOR4zwOSVgYdQIFKmvv1
         cc5w+9Crn2c6G6RQ4EIH+7htFY+R9kEiHw1Kp+QCel5DmeBY4gnEpRaHFcjxlNGjR2BR
         4qI8R88DDDREczoZr9nbaoqdwUMFayXEyvMVntPSxe+cEa0yqARppmti7Both9ahZ6VP
         S4Iw==
X-Gm-Message-State: AOJu0YyliK5Re56fJ3d3t2yBnFh8w48ejugig6zgX5g96qmuWTs8jPSo
	3sN9D4yUVHFw2C5Uw7vA6Q==
X-Google-Smtp-Source: AGHT+IFBPE7igIn0ro19NZVuJwARijfVhzLt1EgpUfMShQleBkiDlzyd5O8aOqtz0dYoaFk78ND51Q==
X-Received: by 2002:a17:902:b718:b0:1cc:7d96:3fe7 with SMTP id d24-20020a170902b71800b001cc7d963fe7mr9927108pls.28.1701109449592;
        Mon, 27 Nov 2023 10:24:09 -0800 (PST)
Received: from [127.0.0.1] ([52.234.27.9])
        by smtp.gmail.com with ESMTPSA id jd1-20020a170903260100b001cfa91a0570sm6243327plb.155.2023.11.27.10.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 10:24:09 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7237df51ca90d9692f133823a3a6071ee87ba02d.1700667812.git.pabeni@redhat.com>
References:
 <7237df51ca90d9692f133823a3a6071ee87ba02d.1700667812.git.pabeni@redhat.com>
Subject: Re: mptcp: fix inconsistent state on fastopen race: Tests Results
Message-ID: <e545183a-bfaa-4baf-e750-7f6470daea41@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Nov 2023 18:24:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/4820403684638720
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4820403684638720/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5946303591481344
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5946303591481344/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6509253544902656
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6509253544902656/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5383353638060032
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5383353638060032/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/90bc6e5d8a90


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
