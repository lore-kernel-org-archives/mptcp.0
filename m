Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CA929415
	for <mptcp@lists.linux.dev>; Tue,  3 Oct 2023 16:54:28 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-65af726775eso153246d6.0
        for <mptcp@lists.linux.dev>; Tue, 03 Oct 2023 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696352067; x=1696956867; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KxKa4zW94v4IVqpiqAnA7KPWX9Nmw19gOiYHFMxFeY=;
        b=JNg9rHab2soi98AaZwagdZkoTABPeDjm0p5kI+urPiZEPBdHMQkkByEiK0LlyQCZbB
         VQeHKDsZi0N7xI1xaditAEPbFqliZvrrjzTvm2yDDwE0c+YylgW62CP+vCUbpAuZ4WNp
         4CcySLY9BZce6Egk+dbCpPjQ5U9QJrK+m1fhO1Vr5Sw2gyTNT32yDFdyTv6YEABiceVY
         7ZcGdaCsFtyhrM8WC1vyKA28vJYRQ6Zpog47BwdlaZmXrruuoTrJUSvrH5VSWchhkW1P
         awFuVerF1IfBn+OjfyxZGN5oskqGVXVgOPxMpXkn2mWYBpuUkvxrD4FEBUEEE5KXXkcU
         hITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696352067; x=1696956867;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6KxKa4zW94v4IVqpiqAnA7KPWX9Nmw19gOiYHFMxFeY=;
        b=YWGq0EGJ/ONiQkWhzpS5IWbDXckCH+f+LGLZf/YBPLGyBYPpPi4e/d9p54JqnhNzq/
         xs98BwrrnJZfgAd6I/zCyboX4gFfalJU2oinVop2oIE4Ob0jfJF7c6lXD8Wvt5MBBzyK
         UNgfO8VEnWJ7VwVxiTK5QRGh9GynvyhFJ4SrBpAWS6uPzJCxZG6YmRYR1T3wH2q3LkyQ
         bgFQpNwx8wBnBz5s5JH80LbJ03mjYZv377BK0etZ6TZ6BCv98IoVzvEonqG5FgR5flqD
         kRrwcowDeKUxJzw+lzIsH3iV9ygXKrf8HNd9qEqwxU+bfhu/3x4UuZVnJTWMiR6DCVGY
         MQtQ==
X-Gm-Message-State: AOJu0YyBPjmigQvmEr+cXnvWhL11K96UXz3tI6y1qDQoFP/32duoEerS
	dUhEHNz0RtG1Y4yoPEGUAw==
X-Google-Smtp-Source: AGHT+IGfyh8i79YOIactO7AHNwqj7dYnNpT2GlMOGkjSI6kP+XarEPLSjYg4jrP5/03TCZgNSTOByg==
X-Received: by 2002:a0c:b359:0:b0:658:7bad:4480 with SMTP id a25-20020a0cb359000000b006587bad4480mr3541285qvf.5.1696352067305;
        Tue, 03 Oct 2023 09:54:27 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.68.33])
        by smtp.gmail.com with ESMTPSA id s6-20020a0cdc06000000b006575372c845sm612201qvk.119.2023.10.03.09.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:54:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20231003-mptcp-matt-email-v1-1-5d86d82f8c08@kernel.org>
References: <20231003-mptcp-matt-email-v1-1-5d86d82f8c08@kernel.org>
Subject: Re: MAINTAINERS: update Matthieu's email address: Tests Results
Message-ID: <cbe37d48-a568-3ddc-3727-ca759e80497c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Oct 2023 16:54:26 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5746212993761280
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5746212993761280/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5183263040339968
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5183263040339968/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6309162947182592
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6309162947182592/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4901788063629312
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4901788063629312/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b9eae88f16c0


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
