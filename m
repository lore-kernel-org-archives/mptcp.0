Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1DA4A3B
	for <mptcp@lists.linux.dev>; Tue, 18 Oct 2022 13:16:12 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id y191so14060238pfb.2
        for <mptcp@lists.linux.dev>; Tue, 18 Oct 2022 06:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTcNQnfxKGuGdKR1Ql/6PDvQDDlmtC64fNjr1MWkIks=;
        b=oxtpZGh0/F2nMfT9JBl/HpVyrIlbLeieP/0Lels3u4So+Fq/K0bDU0VVZZ6uWzPYaX
         1DuarNiCOPMitTUe0fC7n1kU2w8JVQuztA24m0vciJcS/79rNGW5E2+N0GwuLjV1umds
         WYQjW/TzbgLx1+jdfTkke38OeIn3vUvMfpjhQCxd3dGj2K1PY3CGWQqy6A9p5cPnIYpM
         UXAQbwFgiGufRF+pbjimefADHQTQai1Fd29GNQFwTd2kgKZ2fEid277Ne8H/1FCVGpbS
         OOXVGmMQja+HSnVJdPe4bTne6NjllKkPpIijocsgBEWxONUsv7nULh2HmHbJHkWZDApd
         jUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vTcNQnfxKGuGdKR1Ql/6PDvQDDlmtC64fNjr1MWkIks=;
        b=PJJ3ADHt7eDUfVH4kyGPEty3/IC1G58cOGzU4vvNi8KWcNe/LIA340vZ+toO62++a+
         quJhaixUkbrRY7cI8YzK9U+Tw9eYmDg1/aWNqG44ADhMRmcckIH9Yba2MJad/RG0XoO8
         HO50NbYbZOb0GHBn55umDKqwTpNMggDvYSkpbWk9P+s6Utwf8smHH+Qvnc6Y2Xp0a1ob
         m7AvmkEderqNL9xo315i3mOzU8jfxvAtZf5sxaplKHnd7JVqIMuAGjTPpjrwITS6osRt
         tEaJ4pu+6scnDnciHuBlHVGENsgrZuXv2uYVySrcJFoR1vx2BfkEEPRlxdNWK5uontHw
         qiWw==
X-Gm-Message-State: ACrzQf1Jk5fdtQx2qNssvgPmzmtuYAaAQdWlBW6s1e79ynvHRg+TPRc2
	zyqIr4S+KnIqx7IJ1gHVXw==
X-Google-Smtp-Source: AMsMyM6ruY0Zx7Si4hdeyQb2X6ToQ+JgaWXMgQ91jyJtYBhpZ3H9Ubb5IiaJff44kBGdKAQvLO9DZQ==
X-Received: by 2002:a63:85c6:0:b0:46b:41a1:6322 with SMTP id u189-20020a6385c6000000b0046b41a16322mr2650107pgd.403.1666098971763;
        Tue, 18 Oct 2022 06:16:11 -0700 (PDT)
Received: from [127.0.0.1] ([20.245.246.48])
        by smtp.gmail.com with ESMTPSA id o9-20020a170903210900b00179c9219195sm8664386ple.16.2022.10.18.06.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 06:16:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221018110312.22510-5-geliang.tang@suse.com>
References: <20221018110312.22510-5-geliang.tang@suse.com>
Subject: Re: mptcp: refactor push_pending logic: Tests Results
Message-ID: <ec1ecf5b-d518-94e7-b999-75d4839e1a0e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Oct 2022 13:16:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5202885733515264
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5202885733515264/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6328785640357888
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6328785640357888/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ddd3c597286e


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
