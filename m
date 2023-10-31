Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3130A7491
	for <mptcp@lists.linux.dev>; Tue, 31 Oct 2023 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVlq9B3d"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-778940531dbso400596985a.0
        for <mptcp@lists.linux.dev>; Tue, 31 Oct 2023 10:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698773190; x=1699377990; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVmYwPEu70kzRQ4KicTiwYioghTXQAoeGFGaZDfXhxE=;
        b=mVlq9B3dHD/ozl0XHRBQfTCFs4UlT1NQ68y6PYx6qTbYA1IA259mnPHip9p0ldTfx1
         k1nLFfk1YPLdbaIyE1sVIPHV0Q1vHCNnHkLhBlbIKiIj9Gs9b7OdMklJRtn8ncJ+EyNq
         gg6EHRoxrDr7MR5kLuLMY8Zhybq8rAujVnRo3agyOQjurw1i2Re0xtowPz54CfDrU6hi
         s7GyaOU1lt20AM4FbzNf7WiRnev2hHFPW6lYpKAt+PqJbKNIk6GuiZjrgKr8E+jm7uZz
         +RnOEHPSxVTNTgWV28dp+IBj+/4m3kbl0VNWj3TwSgzruxAd7xzWpXab1ICUJBYtE7Ke
         e9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698773190; x=1699377990;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DVmYwPEu70kzRQ4KicTiwYioghTXQAoeGFGaZDfXhxE=;
        b=jvHt6m1b4KSDVIOpDpvMc2vE+7GY+mLwtZv7wPKKL77wJ34EmL5Uummx+gBGFPKPj2
         TYCdqfkboxX/qtqe2T3d+RSUrWj95rztPHAGC14QacjjR7+HJnFSefQL5BucnNgsck04
         bK5rF6yYHK1FrqFBZwm4Gzk4s/w6QmeyxpLETpj4CH7+zr5kO2WW4mJSshtQFXfek7jv
         eLmt3kgbzy3hyRL/a6eOT0si3+zzztHWm+64zwJXzcvoORDA1Ymvb7AQKaGD2W3oEC9n
         QLVOFlWJTmkunnoLL0LiwBePyOjjWyxp4nrBStYB4E9RJ1r7IhfikXjxd9EkztT+iZ/K
         4hTg==
X-Gm-Message-State: AOJu0YyCVO0TdGfIiQCx/CLwBkBOqRwlKUiEGOBTI9w4ZWXgCk0MMitw
	n2weU6GC2/1SS9271yUnyuFp7ztWBw==
X-Google-Smtp-Source: AGHT+IG/oKwMFcGJnvN52DHJAmnEPRg2gFqMpbjz3dg7aCqq4PvrtTtGLGmqWDBZVCHAtLIrt4h+Ew==
X-Received: by 2002:a05:620a:3d91:b0:765:3ca0:3708 with SMTP id ts17-20020a05620a3d9100b007653ca03708mr10871580qkn.75.1698773190071;
        Tue, 31 Oct 2023 10:26:30 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.129.244])
        by smtp.gmail.com with ESMTPSA id qr7-20020a05620a390700b007788bb0ab8esm682527qkn.19.2023.10.31.10.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:26:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a2581b975c0c5bec417b2dd5e0b014acd7770e14.1698764762.git.dcaratti@redhat.com>
References:
 <a2581b975c0c5bec417b2dd5e0b014acd7770e14.1698764762.git.dcaratti@redhat.com>
Subject: Re: net/mptcp: don't overwrite sock_ops in mptcp_is_tcpsk(): Tests
 Results
Message-ID: <7a28b247-a637-90ed-5b29-97b29d41bd3b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 Oct 2023 17:26:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5260796763045888
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5260796763045888/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4979321786335232
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4979321786335232/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6386696669888512
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6386696669888512/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6105221693177856
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6105221693177856/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d6687043f997


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
