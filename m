Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D732D1C9F9
	for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 18:39:56 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5636426c1b3so907337eaf.1
        for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 11:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690483195; x=1691087995;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFlDGVrXzlkbQdKPWIQdviZIg4mY1MdvD110UjPZTlA=;
        b=XBtU53ZVEWdkBsWo5IBz1dnAJn1iYq2OkYhroIyZjfs8IA1FE8SMwYtMf0K42yJtyS
         Z6qq30+7UzvvbP5C4xsoE0Fic9KaxgKoV5mGfeIKVSDo3J1MLC23knj4zVI+AOlGcpXy
         UD8ptrwKD4J2KmoJUxkt+/JuW63oj2B2zbjDzkAT3oiEagOWzLmM+ZT8srsr+0PK9REz
         ZP/+G/ao7Lw1Y/Dwib+BpQ46qxiozjwzP2oHluowi7xsdt0hFqqTJKZVrN1S7zD6XWlE
         2IAJZcZM1W4TcJbFBQiAOsho6SUVvJXeOyd8CuLk0ColwB5FKnj4oUo+vRzoa0mqnhHf
         YD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690483195; x=1691087995;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wFlDGVrXzlkbQdKPWIQdviZIg4mY1MdvD110UjPZTlA=;
        b=DhhfMOj7miUNy5WKbZmTobWsIhed78wVF6ju2cMVBGFA4f3x7ueNP0yIR9iajl6DzG
         s19s0agHRiMFvXR6URRPxT4sUtI1pB/t/7nuJaxYvOEp//Fr0ErrfjDxNl63shGAWY4W
         2R4/dmZkRJrBQOul6+UZapLjYpuo2h+nObE6lFERbTa8UKsnJFyNqHDbUdyPYLOX54Sp
         gNLBw/aO32C6gLsYQ7uWwSIc/hbDoBOsxnC0PuaDcqc1CkIICu3XFwl5a7KEWjmOUwtX
         WbPkoGIuZyBFCDimRSsba1jB6EOn9+EfkGikMKD1Hwcqo75wHjpDBqYaL7/IZ5rZowZC
         Y9Mg==
X-Gm-Message-State: ABy/qLYYIFmyO2HcrkGR6rmRk9I6lmH7APASUfG3iutzHQIOZGzypfDP
	lfkRPjGhmMoJPQvDdYRgJg==
X-Google-Smtp-Source: APBJJlEpRbyRccrZyUaG8LZVRJdHDxC+KA/mIGyQ63P8i9Qz95l8+D6ekGEqTQU2ubC1H0d4SAl6jQ==
X-Received: by 2002:a05:6358:922:b0:134:ccde:596b with SMTP id r34-20020a056358092200b00134ccde596bmr354442rwi.12.1690483195122;
        Thu, 27 Jul 2023 11:39:55 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.70.241])
        by smtp.gmail.com with ESMTPSA id o18-20020ac85552000000b00403bf34266csm602916qtr.30.2023.07.27.11.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 11:39:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <5c70132fb9512ecc42fea01c3118dc9a292791ab.1690454072.git.aclaudi@redhat.com>
References:
 <5c70132fb9512ecc42fea01c3118dc9a292791ab.1690454072.git.aclaudi@redhat.com>
Subject: Re: selftests: mptcp: join: fix 'implicit EP' test: Tests Results
Message-ID: <3bc72cd8-c7d8-34f6-c0b7-f374e8241997@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Jul 2023 18:39:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Andrea,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6040037498814464
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6040037498814464/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5477087545393152
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5477087545393152/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4773400103616512
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4773400103616512/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5708187203010560
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5708187203010560/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/af37d841a4c2


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
Bot operated by Matthieu Baerts (Tessares)
